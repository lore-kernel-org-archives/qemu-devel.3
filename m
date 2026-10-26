Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B31606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=YhUMQEtn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLAP-0004yI-9O; Mon, 26 Oct 2026 09:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAM-0004x3-Pw; Mon, 26 Oct 2026 09:55:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAK-00004r-VB; Mon, 26 Oct 2026 09:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=Nb5Q2BOMGoI/euVE2zFjvuPziTiykZiGfD07p22lCOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YhUMQEtncB9VluRZx7ClGWxItSXiYic2fhDXQiVqSwUy66wOHpv0jB3kcv6GocH0K
 tJipduoJXZFQNqHtdIW1Y58SEtV2PxFHJuthkYrsWyG6tXXK2rNiIAJVnso3CgyA/8
 pwZWNXS4tPETrHrRm268SAKczZI0bUUIDVtl4xt2m1i/MV6BsGPBX89ixozGU/WBx2
 wGtdk6Ka+YnRSXTmAI/ga9nJ3yKtmvYVSk/AlZkTgZ9OSFvF97YQnVUMlC2TSlxd+W
 YAVYJwcMAuFJTRJAn7aVmRjKLpYlAcscxpLxfUzLTtxEfp9Nh07lmFtHO2ciSMv2dA
 ZfYFi9Buwdqbw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 971871E127B;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 950BB44B8C7;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8572093485; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 69/91] qemu-img: convert: flush target image after
 copying
Date: Mon, 26 Oct 2026 16:54:12 +0300
Message-ID: <20261026135441.1019505-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fiona Ebner <f.ebner@proxmox.com>

With 'qemu-img convert', when using a cache mode with 'cache.no-flush
= off', the expectation is that the data is flushed to the disk, which
happens since commit 80ccf93b88 ("qemu-img: let 'qemu-img convert'
flush data"). This expectation also encompasses that failure to do so
is properly reported, so ensure that 'qemu-img convert' exits with a
non-zero status code when the target image cannot be flushed.

In particular, the reproducer below [0], based on a report by
Ing. Alfonso Kuen Arroyo [1], would result in
> rc=0
> Content mismatch at offset XYZ!
before this change, and in
> rc=1
> Content mismatch at offset XYZ!
after this change.

Note that this change does not affect the (default) 'unsafe' cache
mode, because bdrv_co_flush() still skips flush to disk for that cache
mode.

[0]:
> #!/bin/bash -x
> dd if=/dev/urandom of=src.raw bs=1M count=500
> truncate -s 500M dst.img
> LOOP=$(losetup --find --show dst.img)
> SIZE=$(blockdev --getsz $LOOP)
> dd if=/dev/zero of=$LOOP bs=1M count=500 conv=fsync status=none
> sync
> echo 3 > /proc/sys/vm/drop_caches
> dmsetup create flk --table "0 $SIZE flakey $LOOP 0 5 5"
> qemu-img convert -t writeback -p -r 100M -f raw -O raw src.raw /dev/mapper/flk
> echo rc=$?
> sleep 5
> dmsetup remove flk
> qemu-img compare src.raw $LOOP
> losetup -d $LOOP
> rm src.raw dst.img

[1]: https://lore.proxmox.com/pve-devel/178961792132.43804.17173233935297903311@idkmanager.com/

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260930132140.2342574-5-f.ebner@proxmox.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 901ac73874c2129a17b6e54482aee800a0f9b2d2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-img.c b/qemu-img.c
index a7ae3bd121a..e4961a90777 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2248,7 +2248,7 @@ static int img_convert(int argc, char **argv)
     Error *local_err = NULL;
     bool writethrough, src_writethrough, image_opts = false,
          skip_create = false, progress = false, tgt_image_opts = false;
-    int64_t ret = -EINVAL;
+    int64_t ret = -EINVAL, ret2;
     bool force_share = false;
     bool explict_min_sparse = false;
     bool bitmaps = false;
@@ -2790,6 +2790,12 @@ static int img_convert(int argc, char **argv)
         ret = convert_copy_bitmaps(blk_bs(s.src[0]), out_bs, skip_broken);
     }
 
+    ret2 = blk_flush(s.target);
+    if (ret2 < 0) {
+        error_report("Failed to flush target image: %s", strerror(-ret2));
+        ret = ret != 0 ? ret : ret2;
+    }
+
 out:
     if (!ret) {
         qemu_progress_print(100, 0);
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 84283f24343..38794f96ac2 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -267,9 +267,10 @@ qemu-img convert exited with status 0
 
 === failing flush after convert with 'writeback' cache mode ===
 
+qemu-img: Failed to flush target image: Input/output error
 qemu-img: Failed flush for 'json:{ /* filtered */ }' during close: Input/output error
 qemu-img: Failed to flush the L2 table cache: Input/output error
 qemu-img: Failed to flush the refcount block cache: Input/output error
 qemu-img: Failed flush for 'json:{ /* filtered */ }' during close: Input/output error
-qemu-img convert exited with status 0
+qemu-img convert exited with status 1
 *** done
-- 
2.47.3


