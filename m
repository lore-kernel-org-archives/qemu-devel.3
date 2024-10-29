Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471B7D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nqu-0006YY-FV; Tue, 29 Oct 2024 11:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t5nqs-0006Xk-E8
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t5nqq-0007LI-Pm
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730214580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmZ8F0qsUU0LCTzHXDV9zhG89gZuFvGDJ+PdF5DBmig=;
 b=Rqi4fhBBPdKvhwTtHkxDXZb2lUiRJC/5ekB7ombA5uyTWyVSlDAsMS2R2o17efsacM62Rv
 NrFBl7EBvyy24x+dkjLGCUiCrvuprnqCEFXDlqKFzhvUzVi0xQ3LnGNUkrw3kdLS0xNiJm
 RIKj6yNSUnZmuYiNY/Qf7iHVli27E+A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-L2KPxKaFOU-XQknto7eVlw-1; Tue,
 29 Oct 2024 11:09:38 -0400
X-MC-Unique: L2KPxKaFOU-XQknto7eVlw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D89219560A3; Tue, 29 Oct 2024 15:09:37 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.130])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9609C195607C; Tue, 29 Oct 2024 15:09:33 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH 4/5] migration: refactor ram_save_target_page functions
Date: Tue, 29 Oct 2024 20:39:07 +0530
Message-ID: <20241029150908.1136894-5-ppandit@redhat.com>
In-Reply-To: <20241029150908.1136894-1-ppandit@redhat.com>
References: <20241029150908.1136894-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Refactor ram_save_target_page legacy and multifd
functions into one. Other than simplifying it,
it avoids reinitialization of the 'migration_ops'
object, when migration moves from multifd to postcopy
phase.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/ram.c | 54 ++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 326ce7eb79..f9a6395d00 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1985,18 +1985,36 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
 }
 
 /**
- * ram_save_target_page_legacy: save one target page
+ * ram_save_target_page_common:
+ * send one target page to multifd workers OR save one target page.
  *
- * Returns the number of pages written
+ * Multifd mode: returns 1 if the page was queued, -1 otherwise.
+ *
+ * Non-multifd mode: returns the number of pages written
  *
  * @rs: current RAM state
  * @pss: data about the page we want to send
  */
-static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
+static int ram_save_target_page_common(RAMState *rs, PageSearchStatus *pss)
 {
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
+    if (migrate_multifd()) {
+        RAMBlock *block = pss->block;
+        /*
+         * While using multifd live migration, we still need to handle zero
+         * page checking on the migration main thread.
+         */
+        if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
+            if (save_zero_page(rs, pss, offset)) {
+                return 1;
+            }
+        }
+
+        return ram_save_multifd_page(block, offset);
+    }
+
     if (control_save_page(pss, offset, &res)) {
         return res;
     }
@@ -2008,32 +2026,6 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
     return ram_save_page(rs, pss);
 }
 
-/**
- * ram_save_target_page_multifd: send one target page to multifd workers
- *
- * Returns 1 if the page was queued, -1 otherwise.
- *
- * @rs: current RAM state
- * @pss: data about the page we want to send
- */
-static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
-{
-    RAMBlock *block = pss->block;
-    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
-
-    /*
-     * While using multifd live migration, we still need to handle zero
-     * page checking on the migration main thread.
-     */
-    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
-        if (save_zero_page(rs, pss, offset)) {
-            return 1;
-        }
-    }
-
-    return ram_save_multifd_page(block, offset);
-}
-
 /* Should be called before sending a host page */
 static void pss_host_page_prepare(PageSearchStatus *pss)
 {
@@ -3055,12 +3047,10 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
     }
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
+    migration_ops->ram_save_target_page = ram_save_target_page_common;
 
     if (migrate_multifd()) {
         multifd_ram_save_setup();
-        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
-    } else {
-        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
     }
 
     bql_unlock();
-- 
2.47.0


