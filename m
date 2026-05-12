Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0196CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuKJ-0000Tc-1o; Tue, 12 May 2026 17:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJa-0007te-H4; Tue, 12 May 2026 17:06:54 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJY-0001jQ-8v; Tue, 12 May 2026 17:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619300; bh=G+0gqThKbNLLZS71dv1lJG+vMxDq2tBpgVUYj3t34VA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JymCCgzLosr+TnUgsowHUbnbPEBIOmH0F9V7iyaPhtcKs4sR8s+eJigz28eAuViq9
 lp3wDRc/cobn3BsVH/0QISK6m6UCKcsthhskuqAo6xsliDH3NcNMCOPJR/1h9j6n4M
 8d1w4/Uoy69PvA+4mq0GkU8U6x6gPaV8ajlye1yHxjxAalbSO933RxITLi3fNGQRB8
 PUOvqBl6hoEnzHsZwJrjxl2oGIng7XRakvB8XrXrHi5AL2XtY01gca5r0Gdt/655bY
 bbdULXUBdH6yxe9n4zPI/2hfKDw3yRYAQWsh+d7/6bjlKvqs3+MlTbQbGU550oJyqO
 +5CVxvG6q99xw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 610DE1AA346;
 Tue, 12 May 2026 23:55:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6E42C3ABCB7;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Hanna Czenczek <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 010/117] block/mirror: fix assertion failure upon
 duplicate complete for job using 'replaces'
Date: Tue, 12 May 2026 23:53:12 +0300
Message-ID: <20260512205503.361097-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

If s->replace_blocker was already set by an earlier invocation of
mirror_complete(), then there will be an assertion failure when
error_setg() is called for it a second time. The bdrv_op_block_all()
and bdrv_ref() operations should only be done a single time too.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20260311145717.668492-2-f.ebner@proxmox.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
(cherry picked from commit 9ac85f4cc7995217db8f736733b990d6addcb036)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/mirror.c b/block/mirror.c
index fa1d975eb9..2fcded9e93 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1276,23 +1276,25 @@ static void mirror_complete(Job *job, Error **errp)
         return;
     }
 
-    /* block all operations on to_replace bs */
-    if (s->replaces) {
-        s->to_replace = bdrv_find_node(s->replaces);
-        if (!s->to_replace) {
-            error_setg(errp, "Node name '%s' not found", s->replaces);
-            return;
+    if (!s->should_complete) {
+        /* block all operations on to_replace bs */
+        if (s->replaces) {
+            s->to_replace = bdrv_find_node(s->replaces);
+            if (!s->to_replace) {
+                error_setg(errp, "Node name '%s' not found", s->replaces);
+                return;
+            }
+
+            /* TODO Translate this into child freeze system. */
+            error_setg(&s->replace_blocker,
+                       "block device is in use by block-job-complete");
+            bdrv_op_block_all(s->to_replace, s->replace_blocker);
+            bdrv_ref(s->to_replace);
         }
 
-        /* TODO Translate this into child freeze system. */
-        error_setg(&s->replace_blocker,
-                   "block device is in use by block-job-complete");
-        bdrv_op_block_all(s->to_replace, s->replace_blocker);
-        bdrv_ref(s->to_replace);
+        s->should_complete = true;
     }
 
-    s->should_complete = true;
-
     /* If the job is paused, it will be re-entered when it is resumed */
     WITH_JOB_LOCK_GUARD() {
         if (!job->paused) {
-- 
2.47.3


