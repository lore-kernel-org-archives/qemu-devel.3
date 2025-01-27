Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7F9C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 12:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNw3-0003cv-CO; Mon, 27 Jan 2025 07:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tcNvH-0003S3-KX
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 07:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tcNvD-0000WT-H3
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 07:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737979733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nziMzvKUqRfCyUAdl+k805XQHeV+TEZSKfZNCwb64kY=;
 b=bkOK2UcX0eHrI3ZIKAe9K6TdVFcvgsG2ML7YuN90C2peiCP97MCIjCbvpgO0ReWLXk4zwe
 rvDVrgeSqfj3QM6brtokYQaoglvBLJmKnRXmH7AvXFp9S9oUATc/CQu6rRBX0PAggU+1Mv
 LvWRdm66rOyar85R6nLNnXFBpAIqke8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-gTzKZdogMQWZKv0VhSfXPg-1; Mon,
 27 Jan 2025 07:08:49 -0500
X-MC-Unique: gTzKZdogMQWZKv0VhSfXPg-1
X-Mimecast-MFC-AGG-ID: gTzKZdogMQWZKv0VhSfXPg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBE041828AEC; Mon, 27 Jan 2025 12:08:47 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.17.143])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 159C7180034C; Mon, 27 Jan 2025 12:08:42 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v4 2/4] migration: refactor ram_save_target_page functions
Date: Mon, 27 Jan 2025 17:38:21 +0530
Message-ID: <20250127120823.144949-3-ppandit@redhat.com>
In-Reply-To: <20250127120823.144949-1-ppandit@redhat.com>
References: <20250127120823.144949-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Refactor ram_save_target_page legacy and multifd
functions into one. Other than simplifying it,
it frees 'migration_ops' object from usage, so it
is expunged.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/ram.c | 67 +++++++++++++------------------------------------
 1 file changed, 17 insertions(+), 50 deletions(-)

v3: No change
- https://lore.kernel.org/qemu-devel/20250121131032.1611245-1-ppandit@redhat.com/T/#t

diff --git a/migration/ram.c b/migration/ram.c
index ce28328141..f2326788de 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -446,13 +446,6 @@ void ram_transferred_add(uint64_t bytes)
     }
 }
 
-struct MigrationOps {
-    int (*ram_save_target_page)(RAMState *rs, PageSearchStatus *pss);
-};
-typedef struct MigrationOps MigrationOps;
-
-MigrationOps *migration_ops;
-
 static int ram_save_host_page_urgent(PageSearchStatus *pss);
 
 /* NOTE: page is the PFN not real ram_addr_t. */
@@ -1958,55 +1951,36 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
 }
 
 /**
- * ram_save_target_page_legacy: save one target page
- *
- * Returns the number of pages written
+ * ram_save_target_page: save one target page to the precopy thread
+ * OR to multifd workers.
  *
  * @rs: current RAM state
  * @pss: data about the page we want to send
  */
-static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
+static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
 {
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
+    if (!migrate_multifd()
+        || migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
+        if (save_zero_page(rs, pss, offset)) {
+            return 1;
+        }
+    }
+
+    if (migrate_multifd()) {
+        RAMBlock *block = pss->block;
+        return ram_save_multifd_page(block, offset);
+    }
+
     if (control_save_page(pss, offset, &res)) {
         return res;
     }
 
-    if (save_zero_page(rs, pss, offset)) {
-        return 1;
-    }
-
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
@@ -2093,7 +2067,7 @@ static int ram_save_host_page_urgent(PageSearchStatus *pss)
 
         if (page_dirty) {
             /* Be strict to return code; it must be 1, or what else? */
-            if (migration_ops->ram_save_target_page(rs, pss) != 1) {
+            if (ram_save_target_page(rs, pss) != 1) {
                 error_report_once("%s: ram_save_target_page failed", __func__);
                 ret = -1;
                 goto out;
@@ -2162,7 +2136,7 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
             if (preempt_active) {
                 qemu_mutex_unlock(&rs->bitmap_mutex);
             }
-            tmppages = migration_ops->ram_save_target_page(rs, pss);
+            tmppages = ram_save_target_page(rs, pss);
             if (tmppages >= 0) {
                 pages += tmppages;
                 /*
@@ -2360,8 +2334,6 @@ static void ram_save_cleanup(void *opaque)
     xbzrle_cleanup();
     multifd_ram_save_cleanup();
     ram_state_cleanup(rsp);
-    g_free(migration_ops);
-    migration_ops = NULL;
 }
 
 static void ram_state_reset(RAMState *rs)
@@ -3027,13 +2999,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
         return ret;
     }
 
-    migration_ops = g_malloc0(sizeof(MigrationOps));
-
     if (migrate_multifd()) {
         multifd_ram_save_setup();
-        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
-    } else {
-        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
     }
 
     /*
-- 
2.48.1


