Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CDECD129A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNr-0005v1-Vm; Wed, 10 Apr 2024 03:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNq-0005hW-Hr; Wed, 10 Apr 2024 03:28:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNn-0004uq-Oa; Wed, 10 Apr 2024 03:28:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A02C35D6A9;
 Wed, 10 Apr 2024 10:25:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 44083B02E9;
 Wed, 10 Apr 2024 10:23:08 +0300 (MSK)
Received: (nullmailer pid 4191820 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 57/87] block-backend: fix edge case in
 bdrv_next_cleanup() where BDS associated to BB changes
Date: Wed, 10 Apr 2024 10:22:30 +0300
Message-Id: <20240410072303.4191455-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

Same rationale as for commit "block-backend: fix edge case in
bdrv_next() where BDS associated to BB changes". The block graph might
change between the bdrv_next() call and the bdrv_next_cleanup() call,
so it could be that the associated BDS is not the same that was
referenced previously anymore. Instead, rely on bdrv_next() to set
it->bs to the BDS it referenced and unreference that one in any case.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20240322095009.346989-4-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit bac09b093ebbb79e6a7444c7b979c32ca5540132)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/block-backend.c b/block/block-backend.c
index 4a419f75fb..86315d62c6 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -677,13 +677,10 @@ void bdrv_next_cleanup(BdrvNextIterator *it)
     /* Must be called from the main loop */
     assert(qemu_get_current_aio_context() == qemu_get_aio_context());
 
-    if (it->phase == BDRV_NEXT_BACKEND_ROOTS) {
-        if (it->blk) {
-            bdrv_unref(blk_bs(it->blk));
-            blk_unref(it->blk);
-        }
-    } else {
-        bdrv_unref(it->bs);
+    bdrv_unref(it->bs);
+
+    if (it->phase == BDRV_NEXT_BACKEND_ROOTS && it->blk) {
+        blk_unref(it->blk);
     }
 
     bdrv_next_reset(it);
-- 
2.39.2


