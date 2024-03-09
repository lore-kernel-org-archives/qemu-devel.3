Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85F0C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 15:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riz58-0007Jm-Pa; Sat, 09 Mar 2024 10:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz57-0007JF-JK; Sat, 09 Mar 2024 10:57:53 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz55-0004Hh-QN; Sat, 09 Mar 2024 10:57:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 286935452B;
 Sat,  9 Mar 2024 18:58:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 637A0944C0;
 Sat,  9 Mar 2024 18:57:37 +0300 (MSK)
Received: (nullmailer pid 1694662 invoked by uid 1000);
 Sat, 09 Mar 2024 15:57:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 06/11] blockdev: Fix block_resize error reporting for op
 blockers
Date: Sat,  9 Mar 2024 18:57:24 +0300
Message-Id: <20240309155729.1694607-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240309155729.1694607-1-mjt@tls.msk.ru>
References: <20240309155729.1694607-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Markus Armbruster <armbru@redhat.com>

When block_resize() runs into an op blocker, it creates an error like
this:

        error_setg(errp, "Device '%s' is in use", device);

Trouble is @device can be null.  My system formats null as "(null)",
but other systems might crash.  Reproducer:

1. Create two block devices

    -> {"execute": "blockdev-add", "arguments": {"driver": "file", "node-name": "blk0", "filename": "64k.img"}}
    <- {"return": {}}
    -> {"execute": "blockdev-add", "arguments": {"driver": "file", "node-name": "blk1", "filename": "m.img"}}
    <- {"return": {}}

2. Put a blocker on one them

    -> {"execute": "blockdev-mirror", "arguments": {"job-id": "job0", "device": "blk0", "target": "blk1", "sync": "full"}}
    {"return": {}}
    -> {"execute": "job-pause", "arguments": {"id": "job0"}}
    {"return": {}}
    -> {"execute": "job-complete", "arguments": {"id": "job0"}}
    {"return": {}}

   Note: job events elided for brevity.

3. Attempt to resize

    -> {"execute": "block_resize", "arguments": {"node-name": "blk1", "size":32768}}
    <- {"error": {"class": "GenericError", "desc": "Device '(null)' is in use"}}

Broken when commit 3b1dbd11a60 made @device optional.  Fixed in commit
ed3d2ec98a3 (block: Add errp to b{lk,drv}_truncate()), except for this
one instance.

Fix it by using the error message provided by the op blocker instead,
so it fails like this:

    <- {"error": {"class": "GenericError", "desc": "Node 'blk1' is busy: block device is in use by block job: mirror"}}

Fixes: 3b1dbd11a60d (qmp: Allow block_resize to manipulate bs graph nodes.)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 blockdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index f8bb0932f8..d8fb3399f5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2252,8 +2252,7 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
     }
 
     bdrv_graph_co_rdlock();
-    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_RESIZE, NULL)) {
-        error_setg(errp, QERR_DEVICE_IN_USE, device);
+    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_RESIZE, errp)) {
         bdrv_graph_co_rdunlock();
         return;
     }
-- 
2.39.2


