Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F2DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjxz-0005N2-FU; Mon, 11 Mar 2024 14:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rjjxy-0005Mc-9i
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:01:38 -0400
Received: from out-188.mta0.migadu.com ([2001:41d0:1004:224b::bc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rjjxw-0002uG-Ep
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:01:38 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1710180094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLb7ftKP10iFOR1PFB6C4W+WcjWJbkyogMMoy+Sli38=;
 b=JQ2oECGJZP+xGY8mcK4oVSEpx8v9ZnIe/qjjrRsujSZcttMfUtRfq9Zr0lot5rDdjexJCe
 elMDOWsgVU9Cr8wsJe9xSNtTyx+ifrdN7++esSwHzP/x4d5FbmPoSv2Xo8gJhHZqFzA7AN
 AdtQD/HeeqhMoF4D4Zd2iAW6Uho7cJI=
From: Hao Xiang <hao.xiang@linux.dev>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v6 5/7] migration/multifd: Implement
 ram_save_target_page_multifd to handle multifd version of
 MigrationOps::ram_save_target_page.
Date: Mon, 11 Mar 2024 18:00:13 +0000
Message-Id: <20240311180015.3359271-6-hao.xiang@linux.dev>
In-Reply-To: <20240311180015.3359271-1-hao.xiang@linux.dev>
References: <20240311180015.3359271-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::bc;
 envelope-from=hao.xiang@linux.dev; helo=out-188.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hao Xiang <hao.xiang@bytedance.com>

1. Add a dedicated handler for MigrationOps::ram_save_target_page in
multifd live migration.
2. Refactor ram_save_target_page_legacy so that the legacy and multifd
handlers don't have internal functions calling into each other.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20240226195654.934709-4-hao.xiang@bytedance.com>
---
 migration/ram.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d1f97cf862..1d52b5c37f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2079,7 +2079,6 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
  */
 static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
 {
-    RAMBlock *block = pss->block;
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
@@ -2095,17 +2094,33 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return 1;
     }
 
+    return ram_save_page(rs, pss);
+}
+
+/**
+ * ram_save_target_page_multifd: send one target page to multifd workers
+ *
+ * Returns 1 if the page was queued, -1 otherwise.
+ *
+ * @rs: current RAM state
+ * @pss: data about the page we want to send
+ */
+static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
+{
+    RAMBlock *block = pss->block;
+    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
+
     /*
-     * Do not use multifd in postcopy as one whole host page should be
-     * placed.  Meanwhile postcopy requires atomic update of pages, so even
-     * if host page size == guest page size the dest guest during run may
-     * still see partially copied pages which is data corruption.
+     * While using multifd live migration, we still need to handle zero
+     * page checking on the migration main thread.
      */
-    if (migrate_multifd() && !migration_in_postcopy()) {
-        return ram_save_multifd_page(block, offset);
+    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
+        if (save_zero_page(rs, pss, offset)) {
+            return 1;
+        }
     }
 
-    return ram_save_page(rs, pss);
+    return ram_save_multifd_page(block, offset);
 }
 
 /* Should be called before sending a host page */
@@ -3113,7 +3128,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
-    migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+
+    if (migrate_multifd()) {
+        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
+    } else {
+        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+    }
 
     bql_unlock();
     ret = multifd_send_sync_main();
-- 
2.30.2


