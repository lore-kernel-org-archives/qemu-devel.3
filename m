Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0C3C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzol7-0000YY-51; Wed, 24 Apr 2024 22:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzol4-0000Xa-TH
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:46 -0400
Received: from out-189.mta1.migadu.com ([2001:41d0:203:375::bd])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzol2-0005KM-US
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:46 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1714011763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1cSokO6PX4qtftK34R3zY5rMpYUEQVNbC4cHnwkamg=;
 b=W4/UE0wbteecEfMP7+aaBYgNyLpuxSSyTMe4HdOWjqRxhuI4eJFfDYxx8U3rmrmcaEcTp2
 bLa3A4iysTG5RFdN78q9sya2lPiCfjvgHbHVdj2q1mnDcwWPXbmJuXiTMCXWQMRVGFE4fi
 dZA/7WBGpjeT/kPUgegXEw357wKuIRc=
From: Hao Xiang <hao.xiang@linux.dev>
To: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>
Subject: [PATCH v4 09/14] migration/multifd: Prepare to introduce DSA
 acceleration on the multifd path.
Date: Thu, 25 Apr 2024 02:21:12 +0000
Message-Id: <20240425022117.4035031-10-hao.xiang@linux.dev>
In-Reply-To: <20240425022117.4035031-1-hao.xiang@linux.dev>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::bd;
 envelope-from=hao.xiang@linux.dev; helo=out-189.mta1.migadu.com
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

1. Refactor multifd_send_thread function.
2. Introduce the batch task structure in MultiFDSendParams.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
 include/qemu/dsa.h  | 51 +++++++++++++++++++++++++++++++++++++++++++--
 migration/multifd.c |  5 +++++
 migration/multifd.h |  2 ++
 util/dsa.c          | 51 ++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 99 insertions(+), 10 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index e002652879..0c36e93016 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -2,6 +2,7 @@
 #define QEMU_DSA_H
 
 #include "qemu/error-report.h"
+#include "exec/cpu-common.h"
 #include "qemu/thread.h"
 #include "qemu/queue.h"
 
@@ -42,6 +43,21 @@ typedef struct dsa_batch_task {
     QSIMPLEQ_ENTRY(dsa_batch_task) entry;
 } dsa_batch_task;
 
+#endif
+
+struct batch_task {
+#ifdef CONFIG_DSA_OPT
+    /* Address of each pages in pages */
+    ram_addr_t *addr;
+    /* Zero page checking results */
+    bool *results;
+    /* Batch task DSA specific implementation */
+    struct dsa_batch_task *dsa_batch;
+#endif
+};
+
+#ifdef CONFIG_DSA_OPT
+
 /**
  * @brief Initializes DSA devices.
  *
@@ -74,7 +90,7 @@ void dsa_cleanup(void);
 bool dsa_is_running(void);
 
 /**
- * @brief Initializes a buffer zero batch task.
+ * @brief Initializes a buffer zero DSA batch task.
  *
  * @param task A pointer to the batch task to initialize.
  * @param results A pointer to an array of zero page checking results.
@@ -102,9 +118,26 @@ void buffer_zero_batch_task_destroy(struct dsa_batch_task *task);
  * @return Zero if successful, otherwise non-zero.
  */
 int
-buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
+buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
                                const void **buf, size_t count, size_t len);
 
+/**
+ * @brief Initializes a general buffer zero batch task.
+ *
+ * @param batch_size The number of zero page checking tasks in the batch.
+ * @return A pointer to the general batch task initialized.
+ */
+struct batch_task *
+batch_task_init(int batch_size);
+
+/**
+ * @brief Destroys a general buffer zero batch task.
+ *
+ * @param task A pointer to the general batch task to destroy.
+ */
+void
+batch_task_destroy(struct batch_task *task);
+
 #else
 
 static inline bool dsa_is_running(void)
@@ -128,6 +161,20 @@ static inline void dsa_stop(void) {}
 
 static inline void dsa_cleanup(void) {}
 
+static inline int
+buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
+                               const void **buf, size_t count, size_t len)
+{
+    exit(1);
+}
+
+static inline struct batch_task *batch_task_init(int batch_size)
+{
+    return NULL;
+}
+
+static inline void batch_task_destroy(struct batch_task *task) {}
+
 #endif
 
 #endif
diff --git a/migration/multifd.c b/migration/multifd.c
index f317bff077..cfd3a92f6c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -13,6 +13,8 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/rcu.h"
+#include "qemu/dsa.h"
+#include "qemu/memalign.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
 #include "exec/ramblock.h"
@@ -780,6 +782,8 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     p->name = NULL;
     multifd_pages_clear(p->pages);
     p->pages = NULL;
+    batch_task_destroy(p->batch_task);
+    p->batch_task = NULL;
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
@@ -1172,6 +1176,7 @@ bool multifd_send_setup(void)
         qemu_sem_init(&p->sem_sync, 0);
         p->id = i;
         p->pages = multifd_pages_init(page_count);
+        p->batch_task = batch_task_init(page_count);
 
         if (use_packets) {
             p->packet_len = sizeof(MultiFDPacket_t)
diff --git a/migration/multifd.h b/migration/multifd.h
index c9d9b09239..16e27db5e9 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -135,6 +135,8 @@ typedef struct {
      * pending_job != 0 -> multifd_channel can use it.
      */
     MultiFDPages_t *pages;
+    /* Zero page checking batch task */
+    struct batch_task *batch_task;
 
     /* thread local variables. No locking required */
 
diff --git a/util/dsa.c b/util/dsa.c
index 5a2bf33651..4f695e58af 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -802,7 +802,7 @@ buffer_zero_task_init_int(struct dsa_hw_desc *descriptor,
 }
 
 /**
- * @brief Initializes a buffer zero batch task.
+ * @brief Initializes a buffer zero DSA batch task.
  *
  * @param task A pointer to the batch task to initialize.
  * @param results A pointer to an array of zero page checking results.
@@ -1107,29 +1107,64 @@ void dsa_cleanup(void)
  * @return Zero if successful, otherwise non-zero.
  */
 int
-buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
+buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
                                const void **buf, size_t count, size_t len)
 {
-    if (count <= 0 || count > batch_task->batch_size) {
+    struct dsa_batch_task *dsa_batch = batch_task->dsa_batch;
+
+    if (count <= 0 || count > dsa_batch->batch_size) {
         return -1;
     }
 
-    assert(batch_task != NULL);
+    assert(dsa_batch != NULL);
     assert(len != 0);
     assert(buf != NULL);
 
     if (count == 1) {
         /* DSA doesn't take batch operation with only 1 task. */
-        buffer_zero_dsa_async(batch_task, buf[0], len);
+        buffer_zero_dsa_async(dsa_batch, buf[0], len);
     } else {
-        buffer_zero_dsa_batch_async(batch_task, buf, count, len);
+        buffer_zero_dsa_batch_async(dsa_batch, buf, count, len);
     }
 
-    buffer_zero_dsa_wait(batch_task);
-    buffer_zero_cpu_fallback(batch_task);
+    buffer_zero_dsa_wait(dsa_batch);
+    buffer_zero_cpu_fallback(dsa_batch);
 
     return 0;
 }
 
+/**
+ * @brief Initializes a general buffer zero batch task.
+ *
+ * @param batch_size The number of zero page checking tasks in the batch.
+ * @return A pointer to the general batch task initialized.
+ */
+struct batch_task *
+batch_task_init(int batch_size)
+{
+    struct batch_task *task = g_malloc0(sizeof(struct batch_task));
+    task->addr = g_new0(ram_addr_t, batch_size);
+    task->results = g_new0(bool, batch_size);
+    task->dsa_batch = qemu_memalign(64, sizeof(struct dsa_batch_task));
+    buffer_zero_batch_task_init(task->dsa_batch, task->results, batch_size);
+
+    return task;
+}
+
+/**
+ * @brief Destroys a general buffer zero batch task.
+ *
+ * @param task A pointer to the general batch task to destroy.
+ */
+void
+batch_task_destroy(struct batch_task *task)
+{
+    g_free(task->addr);
+    g_free(task->results);
+    buffer_zero_batch_task_destroy(task->dsa_batch);
+    qemu_vfree(task->dsa_batch);
+    g_free(task);
+}
+
 #endif
 
-- 
2.30.2


