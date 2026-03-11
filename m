Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDA3112583A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0L0E-0001OG-83; Wed, 11 Mar 2026 10:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w0L0C-0001NE-Ot; Wed, 11 Mar 2026 10:57:36 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w0L0A-0002oN-Tv; Wed, 11 Mar 2026 10:57:36 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BC3D0874AF;
 Wed, 11 Mar 2026 15:57:25 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH 1/3] block/mirror: fix assertion failure upon duplicate
 complete for job using 'replaces'
Date: Wed, 11 Mar 2026 15:54:25 +0100
Message-ID: <20260311145717.668492-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311145717.668492-1-f.ebner@proxmox.com>
References: <20260311145717.668492-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1773241010274
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If s->replace_blocker was already set by an earlier invocation of
mirror_complete(), then there will be an assertion failure when
error_setg() is called for it a second time. The bdrv_op_block_all()
and bdrv_ref() operations should only be done a single time too.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/mirror.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

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



