Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCC9CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdho-00040v-8R; Fri, 21 Nov 2025 21:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdhh-0003xu-3j; Fri, 21 Nov 2025 21:50:25 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdhA-0005u7-3a; Fri, 21 Nov 2025 21:50:21 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 088CE16C6F2;
 Fri, 21 Nov 2025 16:51:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 629EC32198F;
 Fri, 21 Nov 2025 16:52:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 26/76] block: fix luks 'amend' when run in coroutine
Date: Fri, 21 Nov 2025 16:51:04 +0300
Message-ID: <20251121135201.1114964-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

Launch QEMU with

  $ qemu-img create \
      --object secret,id=sec0,data=123456 \
      -f luks -o key-secret=sec0 demo.luks 1g

  $ qemu-system-x86_64 \
      --object secret,id=sec0,data=123456 \
      -blockdev  driver=luks,key-secret=sec0,file.filename=demo.luks,file.driver=file,node-name=luks

Then in QMP shell attempt

  x-blockdev-amend job-id=fish node-name=luks options={'state':'active','new-secret':'sec0','driver':'luks'}

It will result in an assertion

  #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
  #1  0x00007fad18b73f63 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:89
  #2  0x00007fad18b19f3e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
  #3  0x00007fad18b016d0 in __GI_abort () at abort.c:77
  #4  0x00007fad18b01639 in __assert_fail_base
      (fmt=<optimized out>, assertion=<optimized out>, file=<optimized out>, line=<optimized out>, function=<optimized out>) at assert.c:118
  #5  0x00007fad18b120af in __assert_fail (assertion=<optimized out>, file=<optimized out>, line=<optimized out>, function=<optimized out>)
      at assert.c:127
  #6  0x000055ff74fdbd46 in bdrv_graph_rdlock_main_loop () at ../block/graph-lock.c:260
  #7  0x000055ff7548521b in graph_lockable_auto_lock_mainloop (x=<optimized out>)
      at /usr/src/debug/qemu-9.2.4-1.fc42.x86_64/include/block/graph-lock.h:266
  #8  block_crypto_read_func (block=<optimized out>, offset=4096, buf=0x55ffb6d66ef0 "", buflen=256000, opaque=0x55ffb5edcc30, errp=0x55ffb6f00700)
      at ../block/crypto.c:71
  #9  0x000055ff75439f8b in qcrypto_block_luks_load_key
      (block=block@entry=0x55ffb5edbe90, slot_idx=slot_idx@entry=0, password=password@entry=0x55ffb67dc260 "123456", masterkey=masterkey@entry=0x55ffb5fb0c40 "", readfunc=readfunc@entry=0x55ff754851e0 <block_crypto_read_func>, opaque=opaque@entry=0x55ffb5edcc30, errp=0x55ffb6f00700)
      at ../crypto/block-luks.c:927
  #10 0x000055ff7543b90f in qcrypto_block_luks_find_key
      (block=<optimized out>, password=<optimized out>, masterkey=<optimized out>, readfunc=<optimized out>, opaque=<optimized out>, errp=<optimized out>) at ../crypto/block-luks.c:1045
  #11 qcrypto_block_luks_amend_add_keyslot
      (block=0x55ffb5edbe90, readfunc=0x55ff754851e0 <block_crypto_read_func>, writefunc=0x55ff75485100 <block_crypto_write_func>, opaque=0x55ffb5edcc3, opts_luks=0x7fad1715aef8, force=<optimized out>, errp=0x55ffb6f00700) at ../crypto/block-luks.c:1673
  #12 qcrypto_block_luks_amend_options
      (block=0x55ffb5edbe90, readfunc=0x55ff754851e0 <block_crypto_read_func>, writefunc=0x55ff75485100 <block_crypto_write_func>, opaque=0x55ffb5edcc30, options=0x7fad1715aef0, force=<optimized out>, errp=0x55ffb6f00700) at ../crypto/block-luks.c:1865
  #13 0x000055ff75485b95 in block_crypto_amend_options_generic_luks
      (bs=<optimized out>, amend_options=<optimized out>, force=<optimized out>, errp=<optimized out>) at ../block/crypto.c:949
  #14 0x000055ff75485c28 in block_crypto_co_amend_luks (bs=<optimized out>, opts=<optimized out>, force=<optimized out>, errp=<optimized out>)
      at ../block/crypto.c:1008
  #15 0x000055ff754778e5 in blockdev_amend_run (job=0x55ffb6f00640, errp=0x55ffb6f00700) at ../block/amend.c:52
  #16 0x000055ff75468b90 in job_co_entry (opaque=0x55ffb6f00640) at ../job.c:1106
  #17 0x000055ff755a0fc2 in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:175

This changes the read/write callbacks to not assert that they
are run in mainloop context if already in a coroutine.

This is also reproduced by qemu-iotests cases 295 and 296.

Fixes: 1f051dcbdf2e4b6f518db731c84e304b2b9d15ce
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250919112213.1530079-1-berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit c86488abaf017ed3f5a636c3247cd640a93d3b08)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/crypto.c b/block/crypto.c
index 17b4749a1e..7c37b23e36 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -67,11 +67,18 @@ static int block_crypto_read_func(QCryptoBlock *block,
     BlockCrypto *crypto = bs->opaque;
     ssize_t ret;
 
-    GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    if (qemu_in_coroutine()) {
+        GRAPH_RDLOCK_GUARD();
 
-    ret = bdrv_pread(crypto->header ? crypto->header : bs->file,
-                     offset, buflen, buf, 0);
+        ret = bdrv_co_pread(crypto->header ? crypto->header : bs->file,
+                            offset, buflen, buf, 0);
+    } else {
+        GLOBAL_STATE_CODE();
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+        ret = bdrv_pread(crypto->header ? crypto->header : bs->file,
+                         offset, buflen, buf, 0);
+    }
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read encryption header");
         return ret;
@@ -90,11 +97,18 @@ static int block_crypto_write_func(QCryptoBlock *block,
     BlockCrypto *crypto = bs->opaque;
     ssize_t ret;
 
-    GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    if (qemu_in_coroutine()) {
+        GRAPH_RDLOCK_GUARD();
 
-    ret = bdrv_pwrite(crypto->header ? crypto->header : bs->file,
-                      offset, buflen, buf, 0);
+        ret = bdrv_co_pwrite(crypto->header ? crypto->header : bs->file,
+                             offset, buflen, buf, 0);
+    } else {
+        GLOBAL_STATE_CODE();
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+        ret = bdrv_pwrite(crypto->header ? crypto->header : bs->file,
+                          offset, buflen, buf, 0);
+    }
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not write encryption header");
         return ret;
-- 
2.47.3


