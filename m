Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D8BE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 01:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQFka-0001Sx-9Z; Tue, 24 Dec 2024 19:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkX-0001SK-A1
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 19:59:45 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkV-0000Oy-CG
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 19:59:45 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6dd0d09215aso45905196d6.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 16:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1735088382; x=1735693182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsvRVxOZcXRyv7zkrV/CJN5+n221ZewV1Tvd0+NPBPA=;
 b=jah/XfOgt3CYAVn678G929qvKMz37NDmRsx2345z4U0jLFRjFidEFkNW8KOZNOjEZq
 5PqGVIhvN4UnvF7EeUZYAtL4U6qsVGyglH44t8N247JOHQWsE5fpDf5tmsBBr7qrggmU
 r0c5VTK8jzHghqL6W62GbI9MnISndWQY4bmZWU5QOP/cpVr4R1U9iUqoo2Ykc8sISrU5
 gasuM5rSsGyukwiBKREBrhlSBDEDiC6ZY4GZfrwcUYtcSZECs+iflzw9xn8vACo5JfA+
 QwPm3OxaGVzmU0kbM8XcfjDUgJy2BPoqfdFW7kAKQ/bc/8P0MLBUk1Txg8WdRZ7Eg3Ip
 7qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735088382; x=1735693182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsvRVxOZcXRyv7zkrV/CJN5+n221ZewV1Tvd0+NPBPA=;
 b=RwRT5tHDSCROPONsbOKa7An7AzU8LOTyCT2SpRXZQg8e+WOxZC9r9snZgVZQnMGLxK
 R60CFaNjwAToy1Wi93tx4H2ij1gr6FTkTwgsqnvzIUwVxvD8NCsDP2bVPmSqxY+A7Lox
 60W2vbKqxf9KAiFchKJiXK6Glww7x5nhtGPUBdkObsrsF4d6fdjo4vT7udbTABslNR6W
 LG2ddguk/E71OKhgr/ob79IDi2MuOvOJ+tWquzBYKeHezY9iqABm1FbqHVIX/Wsd0rNz
 7qWqTFcJH62JBzfS3xVZUuQFKr868aqscbwRBHP1x89/1R5hiNU0MM1rNiGC4rMwU39J
 opyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoNCd8pj+8yPQgSxHaMiw4VhgS6yEsECQHP8VGt5WmW7hb8TPupuBOwOmTVpFIazWw08z10yZPUCRg@nongnu.org
X-Gm-Message-State: AOJu0Yxs8jfKvygoTbOYvKU00zoaeaG0lhF8jdj1XqC7dkBKOyGpjQu/
 yjVLaJLkjpZvLE/aj9SwXquBvinofi/pJ9hgc8+3oqjVLojAxSjr7OoaNkeuM2s=
X-Gm-Gg: ASbGncsWHT4VQzmpzEMJtAG/RjiLpxaLyTg/6GfiTDLQRVqNQUkSR8Ezm2/DXQaOjAR
 Hfh83TS5iWVcsNZPkhNN4h33WelfLX0G3tO6WfRjAZ4rX52cL0QZu8rsDOg7elNqO7XX3KPS6cG
 qvjbqJ8MHoqDSuZttwfeHi8AJG2xduEJ03B6B78kXd+MeJYT+33GnXq/GzHj7m4rx0ObCy+YC7w
 QWkWdPttR6NbCOBopx/c7m8RRM480H11M6tBeBHLsktRQ07gSJr2Rr/SSlfDgzrLKNgJNSCIR4t
 okUHwlo2qfK714/4VjrkzCr8YQ==
X-Google-Smtp-Source: AGHT+IFO3Y7VSnlNp4Om7eQIZ/RcjYY0s++fXbv2bqwkgtwJUb96PmH/8ImrqnyWhoUvsXCkKfxrtg==
X-Received: by 2002:a05:6214:1d21:b0:6d1:9e72:596a with SMTP id
 6a1803df08f44-6dd2339dcc5mr255684056d6.37.1735088382389; 
 Tue, 24 Dec 2024 16:59:42 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:1799:4ca4:2dd7:ba38:ecbd])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d244fsm57318206d6.98.2024.12.24.16.59.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Dec 2024 16:59:41 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v9 06/12] util/dsa: Implement zero page checking in DSA task.
Date: Tue, 24 Dec 2024 16:59:13 -0800
Message-Id: <20241225005919.26853-7-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241225005919.26853-1-yichen.wang@bytedance.com>
References: <20241225005919.26853-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf33.google.com
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

Create DSA task with operation code DSA_OPCODE_COMPVAL.
Here we create two types of DSA tasks, a single DSA task and
a batch DSA task. Batch DSA task reduces task submission overhead
and hence should be the default option. However, due to the way DSA
hardware works, a DSA batch task must contain at least two individual
tasks. There are times we need to submit a single task and hence a
single DSA task submission is also required.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/dsa.h |  36 ++++++-
 util/dsa.c         | 240 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 270 insertions(+), 6 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index ca78b06069..a9aa394e5b 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -16,6 +16,7 @@
 #define QEMU_DSA_H
 
 #include "qapi/error.h"
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
@@ -105,8 +107,26 @@ void qemu_dsa_cleanup(void);
  */
 bool qemu_dsa_is_running(void);
 
+/**
+ * @brief Initializes a buffer zero DSA batch task.
+ *
+ * @param batch_size The number of zero page checking tasks in the batch.
+ * @return A pointer to the zero page checking tasks initialized.
+ */
+QemuDsaBatchTask *
+buffer_zero_batch_task_init(int batch_size);
+
+/**
+ * @brief Performs the proper cleanup on a DSA batch task.
+ *
+ * @param task A pointer to the batch task to cleanup.
+ */
+void buffer_zero_batch_task_destroy(QemuDsaBatchTask *task);
+
 #else
 
+typedef struct QemuDsaBatchTask {} QemuDsaBatchTask;
+
 static inline bool qemu_dsa_is_running(void)
 {
     return false;
@@ -124,6 +144,20 @@ static inline void qemu_dsa_stop(void) {}
 
 static inline void qemu_dsa_cleanup(void) {}
 
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
+    return -1;
+}
+
 #endif
 
 #endif
diff --git a/util/dsa.c b/util/dsa.c
index 5c4821e23e..7831cb5925 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -48,6 +48,7 @@ uint32_t max_retry_count;
 static QemuDsaDeviceGroup dsa_group;
 static QemuDsaCompletionThread completion_thread;
 
+static void buffer_zero_dsa_completion(void *context);
 
 /**
  * @brief This function opens a DSA device's work queue and
@@ -174,7 +175,6 @@ dsa_device_group_start(QemuDsaDeviceGroup *group)
  *
  * @param group A pointer to the DSA device group.
  */
-__attribute__((unused))
 static void
 dsa_device_group_stop(QemuDsaDeviceGroup *group)
 {
@@ -210,7 +210,6 @@ dsa_device_group_cleanup(QemuDsaDeviceGroup *group)
  * @return struct QemuDsaDevice* A pointer to the next available DSA device
  *         in the group.
  */
-__attribute__((unused))
 static QemuDsaDevice *
 dsa_device_group_get_next_device(QemuDsaDeviceGroup *group)
 {
@@ -283,7 +282,6 @@ dsa_task_enqueue(QemuDsaDeviceGroup *group,
  * @param group A pointer to the DSA device group.
  * @return QemuDsaBatchTask* The DSA task being dequeued.
  */
-__attribute__((unused))
 static QemuDsaBatchTask *
 dsa_task_dequeue(QemuDsaDeviceGroup *group)
 {
@@ -346,7 +344,6 @@ submit_wi_int(void *wq, struct dsa_hw_desc *descriptor)
  *
  * @return int Zero if successful, non-zero otherwise.
  */
-__attribute__((unused))
 static int
 submit_wi_async(QemuDsaBatchTask *task)
 {
@@ -375,7 +372,6 @@ submit_wi_async(QemuDsaBatchTask *task)
  *
  * @return int Zero if successful, non-zero otherwise.
  */
-__attribute__((unused))
 static int
 submit_batch_wi_async(QemuDsaBatchTask *batch_task)
 {
@@ -732,3 +728,237 @@ void qemu_dsa_cleanup(void)
     dsa_device_group_cleanup(&dsa_group);
 }
 
+
+/* Buffer zero comparison DSA task implementations */
+/* =============================================== */
+
+/**
+ * @brief Sets a buffer zero comparison DSA task.
+ *
+ * @param descriptor A pointer to the DSA task descriptor.
+ * @param buf A pointer to the memory buffer.
+ * @param len The length of the buffer.
+ */
+static void
+buffer_zero_task_set_int(struct dsa_hw_desc *descriptor,
+                         const void *buf,
+                         size_t len)
+{
+    struct dsa_completion_record *completion =
+        (struct dsa_completion_record *)descriptor->completion_addr;
+
+    descriptor->xfer_size = len;
+    descriptor->src_addr = (uintptr_t)buf;
+    completion->status = 0;
+    completion->result = 0;
+}
+
+/**
+ * @brief Resets a buffer zero comparison DSA batch task.
+ *
+ * @param task A pointer to the DSA batch task.
+ */
+static void
+buffer_zero_task_reset(QemuDsaBatchTask *task)
+{
+    task->completions[0].status = DSA_COMP_NONE;
+    task->task_type = QEMU_DSA_TASK;
+    task->status = QEMU_DSA_TASK_READY;
+}
+
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
+/**
+ * @brief Sets a buffer zero comparison DSA task.
+ *
+ * @param task A pointer to the DSA task.
+ * @param buf A pointer to the memory buffer.
+ * @param len The buffer length.
+ */
+static void
+buffer_zero_task_set(QemuDsaBatchTask *task,
+                     const void *buf,
+                     size_t len)
+{
+    buffer_zero_task_reset(task);
+    buffer_zero_task_set_int(&task->descriptors[0], buf, len);
+}
+
+/**
+ * @brief Sets a buffer zero comparison batch task.
+ *
+ * @param batch_task A pointer to the batch task.
+ * @param buf An array of memory buffers.
+ * @param count The number of buffers in the array.
+ * @param len The length of the buffers.
+ */
+static void
+buffer_zero_batch_task_set(QemuDsaBatchTask *batch_task,
+                           const void **buf, size_t count, size_t len)
+{
+    assert(count > 0);
+    assert(count <= batch_task->batch_size);
+
+    buffer_zero_batch_task_reset(batch_task, count);
+    for (int i = 0; i < count; i++) {
+        buffer_zero_task_set_int(&batch_task->descriptors[i], buf[i], len);
+    }
+}
+
+/**
+ * @brief Asychronously perform a buffer zero DSA operation.
+ *
+ * @param task A pointer to the batch task structure.
+ * @param buf A pointer to the memory buffer.
+ * @param len The length of the memory buffer.
+ *
+ * @return int Zero if successful, otherwise an appropriate error code.
+ */
+__attribute__((unused))
+static int
+buffer_zero_dsa_async(QemuDsaBatchTask *task,
+                      const void *buf, size_t len)
+{
+    buffer_zero_task_set(task, buf, len);
+
+    return submit_wi_async(task);
+}
+
+/**
+ * @brief Sends a memory comparison batch task to a DSA device and wait
+ *        for completion.
+ *
+ * @param batch_task The batch task to be submitted to DSA device.
+ * @param buf An array of memory buffers to check for zero.
+ * @param count The number of buffers.
+ * @param len The buffer length.
+ */
+__attribute__((unused))
+static int
+buffer_zero_dsa_batch_async(QemuDsaBatchTask *batch_task,
+                            const void **buf, size_t count, size_t len)
+{
+    assert(count <= batch_task->batch_size);
+    buffer_zero_batch_task_set(batch_task, buf, count, len);
+
+    return submit_batch_wi_async(batch_task);
+}
+
+/**
+ * @brief The completion callback function for buffer zero
+ *        comparison DSA task completion.
+ *
+ * @param context A pointer to the callback context.
+ */
+static void
+buffer_zero_dsa_completion(void *context)
+{
+    assert(context != NULL);
+
+    QemuDsaBatchTask *task = (QemuDsaBatchTask *)context;
+    qemu_sem_post(&task->sem_task_complete);
+}
+
+/**
+ * @brief Wait for the asynchronous DSA task to complete.
+ *
+ * @param batch_task A pointer to the buffer zero comparison batch task.
+ */
+__attribute__((unused))
+static void
+buffer_zero_dsa_wait(QemuDsaBatchTask *batch_task)
+{
+    qemu_sem_wait(&batch_task->sem_task_complete);
+}
+
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
+    if (task) {
+        g_free(task->addr);
+        g_free(task->results);
+        qemu_vfree(task->descriptors);
+        qemu_vfree(task->completions);
+        task->results = NULL;
+        qemu_sem_destroy(&task->sem_task_complete);
+        qemu_vfree(task);
+    }
+}
-- 
Yichen Wang


