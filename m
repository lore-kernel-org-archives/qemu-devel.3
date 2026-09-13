Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFD1C88E40
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5deg-0000Mr-RF; Sun, 13 Sep 2026 02:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x5def-0000Mb-Qh
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:25:33 -0400
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x5dec-0002mk-DN
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1789280721; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=MwbegZEI14F01jCXZp5cYkEbYaeq2J4T7CeUkrDUIh0=;
 b=LGf7K/6zX+gvZ+Vo5yULoKIcGmbCC6KqFSObQClNv1oapDIYrSr65ol4E4jPRtaTb6JrEu
 yo2xqRaFaxRH99JgA5AZnNbmKJD8tzKaxS4fqv4pV6a8jHHCMbUR9xdvXXemn5hMNh5doR
 59rDVzwNbm8JDv/o33Mi+kvnKfs/6hdEWdd087iGo6Rb6YdkYqmjtgjxnBInTv/8hJaHCY
 SdkuOVH0dbG+sAiCpohsAD8A0wmktkJGD14PixVbkukqvpUSjdFDgabuk/Rrjd4feD/ByK
 +J3yExYy9G9CQPnb+/N62D8PEMuEhRzHZxsDzXcLo2mXjOny6s0h66eb+oB9vA==
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>, <peterx@redhat.com>
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Date: Sun, 13 Sep 2026 14:24:52 +0800
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26aa641cf+63aa3f+nongnu.org+yanfei.xu@bytedance.com>
Subject: [PATCH v3 1/4] migration/ram: Add RAM round synchronization notifiers
Mime-Version: 1.0
In-Reply-To: <20260913062455.940447-1-yanfei.xu@bytedance.com>
References: <20260913062455.940447-1-yanfei.xu@bytedance.com>
Cc: <farosas@suse.de>, <lizhijian@fujitsu.com>, <isyanfei.xu@gmail.com>, 
 <jinpu.wang@cloud.ionos.com>, "Yanfei Xu" <yanfei.xu@bytedance.com>
Message-Id: <20260913062455.940447-2-yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=209.127.230.111;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-111.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

find_dirty_block() directly invokes multifd's per-round synchronization
when the RAM scan wraps.  Other transports need the same boundary to
order page versions.

Add a return-valued notifier for RAM round completion and register
multifd's existing synchronization through it.  This keeps the current
behavior while allowing other transports to synchronize at the same
boundary.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-nocomp.c | 24 ++++++++++++++++++++
 migration/ram.c            | 45 +++++++++++++++++++++++++++++++++-----
 migration/ram.h            | 12 ++++++++++
 3 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 9f7a792fa7..3067c19cc6 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -19,6 +19,7 @@
 #include "multifd-colo.h"
 #include "options.h"
 #include "migration.h"
+#include "ram.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
@@ -27,6 +28,28 @@
 
 static MultiFDSendData *multifd_ram_send;
 
+static int multifd_ram_round_notify(NotifierWithReturn *n G_GNUC_UNUSED,
+                                    void *data, Error **errp)
+{
+    RAMRoundNotifyData *round_data = data;
+    QEMUFile *f = round_data->file;
+    int ret;
+
+    if (!multifd_ram_sync_per_round()) {
+        return 0;
+    }
+
+    ret = multifd_ram_flush_and_sync(f);
+    if (ret < 0) {
+        error_setg(errp, "multifd RAM round synchronization failed");
+    }
+    return ret;
+}
+
+static NotifierWithReturn multifd_ram_round_notifier = {
+    .notify = multifd_ram_round_notify,
+};
+
 void multifd_ram_payload_alloc(MultiFDPages_t *pages)
 {
     pages->offset = g_new0(ram_addr_t, multifd_ram_page_count());
@@ -471,6 +494,7 @@ static const MultiFDMethods multifd_nocomp_ops = {
 static void multifd_nocomp_register(void)
 {
     multifd_register_ops(MULTIFD_COMPRESSION_NONE, &multifd_nocomp_ops);
+    ram_round_add_notifier(&multifd_ram_round_notifier);
 }
 
 migration_init(multifd_nocomp_register);
diff --git a/migration/ram.c b/migration/ram.c
index 8918b2f03b..2dd898b305 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -440,6 +440,8 @@ typedef struct RAMState RAMState;
 static RAMState *ram_state;
 
 static NotifierWithReturnList precopy_notifier_list;
+static NotifierWithReturnList ram_round_notifier_list =
+    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(ram_round_notifier_list);
 
 /* Whether postcopy has queued requests? */
 static bool postcopy_has_request(RAMState *rs)
@@ -470,6 +472,38 @@ int precopy_notify(PrecopyNotifyReason reason, Error **errp)
     return notifier_with_return_list_notify(&precopy_notifier_list, &pnd, errp);
 }
 
+void ram_round_add_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_list_add(&ram_round_notifier_list, n);
+}
+
+void ram_round_remove_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_remove(n);
+}
+
+static int ram_round_notify(QEMUFile *f)
+{
+    RAMRoundNotifyData data = {
+        .file = f,
+    };
+    Error *local_err = NULL;
+    int ret;
+
+    ret = notifier_with_return_list_notify(&ram_round_notifier_list, &data,
+                                           &local_err);
+    if (ret) {
+        if (local_err) {
+            error_report_err(local_err);
+        } else {
+            error_report("RAM round notifier failed: %d", ret);
+        }
+        return -1;
+    }
+
+    return 0;
+}
+
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
@@ -1380,12 +1414,11 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (multifd_ram_sync_per_round()) {
-                QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
-                int ret = multifd_ram_flush_and_sync(f);
-                if (ret < 0) {
-                    return ret;
-                }
+            QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
+            int ret = ram_round_notify(f);
+
+            if (ret < 0) {
+                return ret;
             }
 
             /* Hit the end of the list */
diff --git a/migration/ram.h b/migration/ram.h
index 41697a7599..84f10087e8 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -31,6 +31,7 @@
 
 #include "qapi/qapi-types-migration.h"
 #include "exec/cpu-common.h"
+#include "qemu/notify.h"
 #include "system/ram_addr.h"
 #include "io/channel.h"
 
@@ -95,6 +96,17 @@ void ram_handle_zero(void *host, uint64_t size);
 void ram_transferred_add(uint64_t bytes);
 void ram_release_page(const char *rbname, uint64_t offset);
 
+/*
+ * The RAM round notifier is invoked whenever the migration RAM core
+ * completes one full scan of guest memory.
+ */
+typedef struct RAMRoundNotifyData {
+    QEMUFile *file;
+} RAMRoundNotifyData;
+
+void ram_round_add_notifier(NotifierWithReturn *n);
+void ram_round_remove_notifier(NotifierWithReturn *n);
+
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
 bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
-- 
2.20.1

