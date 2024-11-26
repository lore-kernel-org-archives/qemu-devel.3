Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E472D3B986
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFuCz-0004Sd-FN; Tue, 26 Nov 2024 06:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tFuCv-0004RM-E0
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:58:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tFuCt-00033o-LA
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732622294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pfc7JF7qG3aZf0kHhQuU4xgdY9xXgpXt7NXpqF3Jagg=;
 b=JSFyOf7wfvHp6mdB2/lu8A+QFq49feeYN05nBujg2i5uGBaLFlKPS0/GvHnQrGeQ8UbOG4
 q1c3Kdy3TKlfS/rbmEKJGl0CqYxmbCylMwTwZYVbjQUIcK79vglEbhJTiXwJi83HXpGysO
 zWY8jQqRrxqX/LZeGPLZYjYjf4h6+tQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-xT9gkc-_MhiJ3Ev1wnmRmw-1; Tue,
 26 Nov 2024 06:58:12 -0500
X-MC-Unique: xT9gkc-_MhiJ3Ev1wnmRmw-1
X-Mimecast-MFC-AGG-ID: xT9gkc-_MhiJ3Ev1wnmRmw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07A9A1955BD2; Tue, 26 Nov 2024 11:58:11 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0FCF19560A3; Tue, 26 Nov 2024 11:58:07 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
Date: Tue, 26 Nov 2024 17:27:47 +0530
Message-ID: <20241126115748.118683-4-ppandit@redhat.com>
In-Reply-To: <20241126115748.118683-1-ppandit@redhat.com>
References: <20241126115748.118683-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
it frees 'migration_ops' object from usage, so it
is expunged.

When both Multifd and Postcopy modes are enabled,
to avoid errors, the Multifd threads are active until
migration reaches the Postcopy mode. This is done by
checking the state returned by migration_in_postcopy().

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/multifd-nocomp.c |  3 +-
 migration/ram.c            | 74 ++++++++++++--------------------------
 2 files changed, 24 insertions(+), 53 deletions(-)

v1: Further refactor ram_save_target_page() function to conflate
    save_zero_page() calls.

    Add migration_in_postcopy() call to check migration state
    instead of combining it with migrate_multifd().

v0: https://lore.kernel.org/qemu-devel/20241029150908.1136894-1-ppandit@redhat.com/T/#u

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 55191152f9..e92821e8f6 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -14,6 +14,7 @@
 #include "exec/ramblock.h"
 #include "exec/target_page.h"
 #include "file.h"
+#include "migration.h"
 #include "multifd.h"
 #include "options.h"
 #include "qapi/error.h"
@@ -345,7 +346,7 @@ retry:
 
 int multifd_ram_flush_and_sync(void)
 {
-    if (!migrate_multifd()) {
+    if (!migrate_multifd() || migration_in_postcopy()) {
         return 0;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 05ff9eb328..9d1ec6209c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -467,13 +467,6 @@ void ram_transferred_add(uint64_t bytes)
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
@@ -1323,9 +1316,9 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (migrate_multifd() &&
-                (!migrate_multifd_flush_after_each_section() ||
-                 migrate_mapped_ram())) {
+            if (migrate_multifd() && !migration_in_postcopy()
+                && (!migrate_multifd_flush_after_each_section()
+                    || migrate_mapped_ram())) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_ram_flush_and_sync();
                 if (ret < 0) {
@@ -1986,55 +1979,39 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
 }
 
 /**
- * ram_save_target_page_legacy: save one target page
+ * ram_save_target_page: save one target page to the precopy thread
+ * OR to multifd workers.
  *
- * Returns the number of pages written
+ * Multifd mode: returns 1 if the page was queued, -1 otherwise.
+ * Non-multifd mode: returns the number of pages written.
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
+    if (migrate_multifd() && !migration_in_postcopy()) {
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
@@ -2121,7 +2098,7 @@ static int ram_save_host_page_urgent(PageSearchStatus *pss)
 
         if (page_dirty) {
             /* Be strict to return code; it must be 1, or what else? */
-            if (migration_ops->ram_save_target_page(rs, pss) != 1) {
+            if (ram_save_target_page(rs, pss) != 1) {
                 error_report_once("%s: ram_save_target_page failed", __func__);
                 ret = -1;
                 goto out;
@@ -2190,7 +2167,7 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
             if (preempt_active) {
                 qemu_mutex_unlock(&rs->bitmap_mutex);
             }
-            tmppages = migration_ops->ram_save_target_page(rs, pss);
+            tmppages = ram_save_target_page(rs, pss);
             if (tmppages >= 0) {
                 pages += tmppages;
                 /*
@@ -2388,8 +2365,6 @@ static void ram_save_cleanup(void *opaque)
     xbzrle_cleanup();
     multifd_ram_save_cleanup();
     ram_state_cleanup(rsp);
-    g_free(migration_ops);
-    migration_ops = NULL;
 }
 
 static void ram_state_reset(RAMState *rs)
@@ -3055,13 +3030,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
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
 
     bql_unlock();
-- 
2.47.0


