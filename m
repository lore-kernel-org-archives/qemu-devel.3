Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4F7C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1j1-0004np-Tw; Thu, 11 Jul 2024 17:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1iz-0004gO-N3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:13 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1ix-0005al-4U
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:13 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7036e383089so757309a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720734790; x=1721339590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrzhnVMIN0zieDhkTpHmtBi2Mh7MPJkNAnz/C4OZgI0=;
 b=NjCckZzCoKo2mBdAZAhMl2l/sL8VZLwzWe+ylUMn77XJ6B3QMuVFjJFem6yFSBC5WA
 VqVwzBpA9MzwXFl6pPmh8uY5A3C1QkedSx3+l8fueDiGhmFuZTUNiPX1ARdK4BWcCVKD
 oT6isFUIrdhLqBE4D709Jv5Mz3eizjb3QF1Em0z/n+VFGTUUm3q26sNMQZn0+WsL/f0I
 BP6Ts5/UO26nBpMN5vxp+dOUoFTnAeiegt0UeGRv91C3Zg8o6klzPdCp7YLHjeWSBGMO
 G1z4zBDjl3uErNkgRH5otvNDApIq50bzM+GndSYtEJzkVNUfLi+7sVJ09TfamkvCwZVW
 zNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720734790; x=1721339590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JrzhnVMIN0zieDhkTpHmtBi2Mh7MPJkNAnz/C4OZgI0=;
 b=w/KdF4c4tAczXTx4sLHI9uHFc3B990mLlxjXHzW5ndiWnoiFQ/k7rCQufXqyzFVw3o
 Rp+/+OGitEVCUIMPfLq8OsGxeP0gX/eRnw7qhpR72YQBNr4hTwgb40EOdUIOOW7Yt5Wo
 gmVJ6Hh00LmoWq7d/B62hh7Lqc6xgNUfGAIZGOOS2LIowKQ0QpUKsSN8TM2dGKJTTjiL
 hlyNgZ5hfYxZ7elg6OrVoHrmqb0+dy6l9qIPTplWSb1a9VE0Uwag/G5VaEB2617UQic2
 Sxe0wvBaOBZw6Zi6/Z8f+eadnVCyb4NyRv8ZPQly5jbTcRJifWEI8AAoZ3PF644M7Nqj
 N0RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1f1vMIJ3hRxNxPKBNZlENlnWsY3fdrjxfsdDn3USAsv+Pkv6PecNIXjaKXdUkPfYjBXZN3vQtsKdNd2nV9CWtyW2M6qA=
X-Gm-Message-State: AOJu0Yyr2YwHfGgfhMRn8RjZQ5rGqMSqvD7M5W/Eb1JI7iVDkGUORkEo
 X5URuFeWmYu7VQRWpBnoYFIO7+fQTGKo6YQ4XAdyNpTo7v7HSveKwNzWEAzh3bI=
X-Google-Smtp-Source: AGHT+IHsSMKlrqRzTEMdePQ4spC/Rq8EILcx2P/tUbDZZguToZbmRh75MKkWJ3das3SV7q5S6Ny7xw==
X-Received: by 2002:a05:6830:39d7:b0:703:6989:5b04 with SMTP id
 46e09a7af769-70375b48a32mr10113294a34.31.1720734789880; 
 Thu, 11 Jul 2024 14:53:09 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7044ac2876dsm713125a34.2.2024.07.11.14.53.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 14:53:09 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v5 09/13] migration/multifd: Prepare to introduce DSA
 acceleration on the multifd path.
Date: Thu, 11 Jul 2024 14:52:44 -0700
Message-Id: <20240711215244.19237-10-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711215244.19237-1-yichen.wang@bytedance.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=yichen.wang@bytedance.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hao Xiang <hao.xiang@linux.dev>

1. Refactor multifd_send_thread function.
2. Introduce the batch task structure in MultiFDSendParams.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 include/qemu/dsa.h  |  41 ++++---
 migration/multifd.c |   4 +
 migration/multifd.h |   3 +
 util/dsa.c          | 270 +++++++++++++++++++++++---------------------
 4 files changed, 172 insertions(+), 146 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index 20bb88d48c..fd0305a7c7 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -16,6 +16,7 @@
 #define QEMU_DSA_H
 
 #include "qemu/error-report.h"
+#include "exec/cpu-common.h"
 #include "qemu/thread.h"
 #include "qemu/queue.h"
 
@@ -70,10 +71,11 @@ typedef struct QemuDsaBatchTask {
     QemuDsaTaskStatus status;
     int batch_size;
     bool *results;
+    /* Address of each pages in pages */
+    ram_addr_t *addr;
     QSIMPLEQ_ENTRY(QemuDsaBatchTask) entry;
 } QemuDsaBatchTask;
 
-
 /**
  * @brief Initializes DSA devices.
  *
@@ -106,15 +108,13 @@ void qemu_dsa_cleanup(void);
 bool qemu_dsa_is_running(void);
 
 /**
- * @brief Initializes a buffer zero batch task.
+ * @brief Initializes a buffer zero DSA batch task.
  *
- * @param task A pointer to the batch task to initialize.
- * @param results A pointer to an array of zero page checking results.
- * @param batch_size The number of DSA tasks in the batch.
+ * @param batch_size The number of zero page checking tasks in the batch.
+ * @return A pointer to the zero page checking tasks initialized.
  */
-void
-buffer_zero_batch_task_init(QemuDsaBatchTask *task,
-                            bool *results, int batch_size);
+QemuDsaBatchTask *
+buffer_zero_batch_task_init(int batch_size);
 
 /**
  * @brief Performs the proper cleanup on a DSA batch task.
@@ -139,6 +139,8 @@ buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batch_task,
 
 #else
 
+typedef struct QemuDsaBatchTask {} QemuDsaBatchTask;
+
 static inline bool qemu_dsa_is_running(void)
 {
     return false;
@@ -146,19 +148,28 @@ static inline bool qemu_dsa_is_running(void)
 
 static inline int qemu_dsa_init(const char *dsa_parameter, Error **errp)
 {
-    if (dsa_parameter != NULL && strlen(dsa_parameter) != 0) {
-        error_setg(errp, "DSA is not supported.");
-        return -1;
-    }
-
-    return 0;
+    error_setg(errp, "DSA accelerator is not enabled.");
+    return -1;
 }
 
 static inline void qemu_dsa_start(void) {}
 
 static inline void qemu_dsa_stop(void) {}
 
-static inline void qemu_dsa_cleanup(void) {}
+static inline QemuDsaBatchTask *buffer_zero_batch_task_init(int batch_size)
+{
+    return NULL;
+}
+
+static inline void buffer_zero_batch_task_destroy(QemuDsaBatchTask *task) {}
+
+static inline int
+buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batch_task,
+                              const void **buf, size_t count, size_t len)
+{
+    error_setg(errp, "DSA accelerator is not enabled.");
+    return -1;
+}
 
 #endif
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 0b4cbaddfe..6f8edd4b6a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/rcu.h"
+#include "qemu/dsa.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
 #include "exec/ramblock.h"
@@ -792,6 +793,8 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     p->name = NULL;
     multifd_pages_clear(p->pages);
     p->pages = NULL;
+    buffer_zero_batch_task_destroy(p->dsa_batch_task);
+    p->dsa_batch_task = NULL;
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
@@ -1182,6 +1185,7 @@ bool multifd_send_setup(void)
         qemu_sem_init(&p->sem_sync, 0);
         p->id = i;
         p->pages = multifd_pages_init(page_count);
+        p->dsa_batch_task = buffer_zero_batch_task_init(page_count);
 
         if (use_packets) {
             p->packet_len = sizeof(MultiFDPacket_t)
diff --git a/migration/multifd.h b/migration/multifd.h
index 0ecd6f47d7..027f57bf4e 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -14,6 +14,7 @@
 #define QEMU_MIGRATION_MULTIFD_H
 
 #include "ram.h"
+#include "qemu/dsa.h"
 
 typedef struct MultiFDRecvData MultiFDRecvData;
 
@@ -137,6 +138,8 @@ typedef struct {
      * pending_job != 0 -> multifd_channel can use it.
      */
     MultiFDPages_t *pages;
+    /* Zero page checking batch task */
+    QemuDsaBatchTask *dsa_batch_task;
 
     /* thread local variables. No locking required */
 
diff --git a/util/dsa.c b/util/dsa.c
index 74b9aa1331..5aba1ae23a 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -696,93 +696,81 @@ static void dsa_completion_thread_stop(void *opaque)
 }
 
 /**
- * @brief Initializes a buffer zero comparison DSA task.
+ * @brief Check if DSA is running.
  *
- * @param descriptor A pointer to the DSA task descriptor.
- * @param completion A pointer to the DSA task completion record.
+ * @return True if DSA is running, otherwise false.
  */
+bool qemu_dsa_is_running(void)
+{
+    return completion_thread.running;
+}
+
 static void
-buffer_zero_task_init_int(struct dsa_hw_desc *descriptor,
-                          struct dsa_completion_record *completion)
+dsa_globals_init(void)
 {
-    descriptor->opcode = DSA_OPCODE_COMPVAL;
-    descriptor->flags = IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
-    descriptor->comp_pattern = (uint64_t)0;
-    descriptor->completion_addr = (uint64_t)completion;
+    max_retry_count = DSA_WQ_DEPTH;
 }
 
 /**
- * @brief Initializes a buffer zero batch task.
+ * @brief Initializes DSA devices.
+ *
+ * @param dsa_parameter A list of DSA device path from migration parameter.
  *
- * @param task A pointer to the batch task to initialize.
- * @param results A pointer to an array of zero page checking results.
- * @param batch_size The number of DSA tasks in the batch.
+ * @return int Zero if successful, otherwise non zero.
  */
-void
-buffer_zero_batch_task_init(QemuDsaBatchTask *task,
-                            bool *results, int batch_size)
+int qemu_dsa_init(const char *dsa_parameter, Error **errp)
 {
-    int descriptors_size = sizeof(*task->descriptors) * batch_size;
-    memset(task, 0, sizeof(*task));
-
-    task->descriptors =
-        (struct dsa_hw_desc *)qemu_memalign(64, descriptors_size);
-    memset(task->descriptors, 0, descriptors_size);
-    task->completions = (struct dsa_completion_record *)qemu_memalign(
-        32, sizeof(*task->completions) * batch_size);
-    task->results = results;
-    task->batch_size = batch_size;
+    dsa_globals_init();
 
-    task->batch_completion.status = DSA_COMP_NONE;
-    task->batch_descriptor.completion_addr = (uint64_t)&task->batch_completion;
-    /* TODO: Ensure that we never send a batch with count <= 1 */
-    task->batch_descriptor.desc_count = 0;
-    task->batch_descriptor.opcode = DSA_OPCODE_BATCH;
-    task->batch_descriptor.flags = IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
-    task->batch_descriptor.desc_list_addr = (uintptr_t)task->descriptors;
-    task->status = QEMU_DSA_TASK_READY;
-    task->group = &dsa_group;
-    task->device = dsa_device_group_get_next_device(&dsa_group);
+    return dsa_device_group_init(&dsa_group, dsa_parameter, errp);
+}
 
-    for (int i = 0; i < task->batch_size; i++) {
-        buffer_zero_task_init_int(&task->descriptors[i],
-                                  &task->completions[i]);
+/**
+ * @brief Start logic to enable using DSA.
+ *
+ */
+void qemu_dsa_start(void)
+{
+    if (dsa_group.num_dsa_devices == 0) {
+        return;
     }
-
-    qemu_sem_init(&task->sem_task_complete, 0);
-    task->completion_callback = buffer_zero_dsa_completion;
+    if (dsa_group.running) {
+        return;
+    }
+    dsa_device_group_start(&dsa_group);
+    dsa_completion_thread_init(&completion_thread, &dsa_group);
 }
 
 /**
- * @brief Performs the proper cleanup on a DSA batch task.
+ * @brief Stop the device group and the completion thread.
  *
- * @param task A pointer to the batch task to cleanup.
  */
-void
-buffer_zero_batch_task_destroy(QemuDsaBatchTask *task)
+void qemu_dsa_stop(void)
 {
-    qemu_vfree(task->descriptors);
-    qemu_vfree(task->completions);
-    task->results = NULL;
+    QemuDsaDeviceGroup *group = &dsa_group;
 
-    qemu_sem_destroy(&task->sem_task_complete);
+    if (!group->running) {
+        return;
+    }
+
+    dsa_completion_thread_stop(&completion_thread);
+    dsa_empty_task_queue(group);
 }
 
 /**
- * @brief Resets a buffer zero comparison DSA batch task.
+ * @brief Clean up system resources created for DSA offloading.
  *
- * @param task A pointer to the batch task.
- * @param count The number of DSA tasks this batch task will contain.
  */
-static void
-buffer_zero_batch_task_reset(QemuDsaBatchTask *task, size_t count)
+void qemu_dsa_cleanup(void)
 {
-    task->batch_completion.status = DSA_COMP_NONE;
-    task->batch_descriptor.desc_count = count;
-    task->task_type = QEMU_DSA_BATCH_TASK;
-    task->status = QEMU_DSA_TASK_READY;
+    qemu_dsa_stop();
+    dsa_device_group_cleanup(&dsa_group);
 }
 
+
+/* Buffer zero comparison DSA task implementations */
+/* =============================================== */
+
 /**
  * @brief Sets a buffer zero comparison DSA task.
  *
@@ -817,6 +805,21 @@ buffer_zero_task_reset(QemuDsaBatchTask *task)
     task->status = QEMU_DSA_TASK_READY;
 }
 
+/**
+ * @brief Resets a buffer zero comparison DSA batch task.
+ *
+ * @param task A pointer to the batch task.
+ * @param count The number of DSA tasks this batch task will contain.
+ */
+static void
+buffer_zero_batch_task_reset(QemuDsaBatchTask *task, size_t count)
+{
+    task->batch_completion.status = DSA_COMP_NONE;
+    task->batch_descriptor.desc_count = count;
+    task->task_type = QEMU_DSA_BATCH_TASK;
+    task->status = QEMU_DSA_TASK_READY;
+}
+
 /**
  * @brief Sets a buffer zero comparison DSA task.
  *
@@ -923,6 +926,7 @@ buffer_zero_dsa_wait(QemuDsaBatchTask *batch_task)
  *
  * @param batch_task A pointer to the batch task.
  */
+
 static void
 buffer_zero_cpu_fallback(QemuDsaBatchTask *batch_task)
 {
@@ -966,78 +970,6 @@ buffer_zero_cpu_fallback(QemuDsaBatchTask *batch_task)
     }
 }
 
-/**
- * @brief Check if DSA is running.
- *
- * @return True if DSA is running, otherwise false.
- */
-bool qemu_dsa_is_running(void)
-{
-    return completion_thread.running;
-}
-
-static void
-dsa_globals_init(void)
-{
-    max_retry_count = DSA_WQ_DEPTH;
-}
-
-/**
- * @brief Initializes DSA devices.
- *
- * @param dsa_parameter A list of DSA device path from migration parameter.
- *
- * @return int Zero if successful, otherwise non zero.
- */
-int qemu_dsa_init(const char *dsa_parameter, Error **errp)
-{
-    dsa_globals_init();
-
-    return dsa_device_group_init(&dsa_group, dsa_parameter, errp);
-}
-
-/**
- * @brief Start logic to enable using DSA.
- *
- */
-void qemu_dsa_start(void)
-{
-    if (dsa_group.num_dsa_devices == 0) {
-        return;
-    }
-    if (dsa_group.running) {
-        return;
-    }
-    dsa_device_group_start(&dsa_group);
-    dsa_completion_thread_init(&completion_thread, &dsa_group);
-}
-
-/**
- * @brief Stop the device group and the completion thread.
- *
- */
-void qemu_dsa_stop(void)
-{
-    QemuDsaDeviceGroup *group = &dsa_group;
-
-    if (!group->running) {
-        return;
-    }
-
-    dsa_completion_thread_stop(&completion_thread);
-    dsa_empty_task_queue(group);
-}
-
-/**
- * @brief Clean up system resources created for DSA offloading.
- *
- */
-void qemu_dsa_cleanup(void)
-{
-    qemu_dsa_stop();
-    dsa_device_group_cleanup(&dsa_group);
-}
-
 /**
  * @brief Performs buffer zero comparison on a DSA batch task synchronously.
  *
@@ -1073,3 +1005,79 @@ buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batch_task,
     return 0;
 }
 
+/**
+ * @brief Initializes a buffer zero comparison DSA task.
+ *
+ * @param descriptor A pointer to the DSA task descriptor.
+ * @param completion A pointer to the DSA task completion record.
+ */
+static void
+buffer_zero_task_init_int(struct dsa_hw_desc *descriptor,
+                          struct dsa_completion_record *completion)
+{
+    descriptor->opcode = DSA_OPCODE_COMPVAL;
+    descriptor->flags = IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
+    descriptor->comp_pattern = (uint64_t)0;
+    descriptor->completion_addr = (uint64_t)completion;
+}
+
+/**
+ * @brief Initializes a buffer zero DSA batch task.
+ *
+ * @param batch_size The number of zero page checking tasks in the batch.
+ * @return A pointer to the zero page checking tasks initialized.
+ */
+QemuDsaBatchTask *
+buffer_zero_batch_task_init(int batch_size)
+{
+    QemuDsaBatchTask *task = qemu_memalign(64, sizeof(QemuDsaBatchTask));
+    int descriptors_size = sizeof(*task->descriptors) * batch_size;
+
+    memset(task, 0, sizeof(*task));
+    task->addr = g_new0(ram_addr_t, batch_size);
+    task->results = g_new0(bool, batch_size);
+    task->batch_size = batch_size;
+    task->descriptors =
+        (struct dsa_hw_desc *)qemu_memalign(64, descriptors_size);
+    memset(task->descriptors, 0, descriptors_size);
+    task->completions = (struct dsa_completion_record *)qemu_memalign(
+        32, sizeof(*task->completions) * batch_size);
+
+    task->batch_completion.status = DSA_COMP_NONE;
+    task->batch_descriptor.completion_addr = (uint64_t)&task->batch_completion;
+    /* TODO: Ensure that we never send a batch with count <= 1 */
+    task->batch_descriptor.desc_count = 0;
+    task->batch_descriptor.opcode = DSA_OPCODE_BATCH;
+    task->batch_descriptor.flags = IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
+    task->batch_descriptor.desc_list_addr = (uintptr_t)task->descriptors;
+    task->status = QEMU_DSA_TASK_READY;
+    task->group = &dsa_group;
+    task->device = dsa_device_group_get_next_device(&dsa_group);
+
+    for (int i = 0; i < task->batch_size; i++) {
+        buffer_zero_task_init_int(&task->descriptors[i],
+                                  &task->completions[i]);
+    }
+
+    qemu_sem_init(&task->sem_task_complete, 0);
+    task->completion_callback = buffer_zero_dsa_completion;
+
+    return task;
+}
+
+/**
+ * @brief Performs the proper cleanup on a DSA batch task.
+ *
+ * @param task A pointer to the batch task to cleanup.
+ */
+void
+buffer_zero_batch_task_destroy(QemuDsaBatchTask *task)
+{
+    g_free(task->addr);
+    g_free(task->results);
+    qemu_vfree(task->descriptors);
+    qemu_vfree(task->completions);
+    task->results = NULL;
+    qemu_sem_destroy(&task->sem_task_complete);
+    qemu_vfree(task);
+}
-- 
Yichen Wang


