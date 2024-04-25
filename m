Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EF1C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzokx-0000Uj-Tt; Wed, 24 Apr 2024 22:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzoku-0000TQ-Bn
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:36 -0400
Received: from out-189.mta1.migadu.com ([95.215.58.189])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzoks-00051I-FL
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:36 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1714011752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlIyorlshT2KtpOtlnobLBBslJn63zcO14fOuSzWnq4=;
 b=FKoet1pLYSogT2dOq268S0y+aWTFC8gcp0VQQ3avSg+iMg6pMELQy2e48ufTT6JGCNP4PE
 e/LThCb3nVt4Ks3WcFr/171ztBIuqnDqxL0/v6Pq0esgxcUWpoGa/qF1Im8+AfJ/oWL75E
 Z/Ml+2CNDxInfZu5DIgB37+Xrc/HHjE=
From: Hao Xiang <hao.xiang@linux.dev>
To: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>
Subject: [PATCH v4 04/14] util/dsa: Implement DSA task enqueue and dequeue.
Date: Thu, 25 Apr 2024 02:21:07 +0000
Message-Id: <20240425022117.4035031-5-hao.xiang@linux.dev>
In-Reply-To: <20240425022117.4035031-1-hao.xiang@linux.dev>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.189; envelope-from=hao.xiang@linux.dev;
 helo=out-189.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

* Use a safe thread queue for DSA task enqueue/dequeue.
* Implement DSA task submission.
* Implement DSA batch task submission.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
 include/qemu/dsa.h |  28 +++++++
 util/dsa.c         | 201 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 229 insertions(+)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index f15c05ee85..37cae8d9d2 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -13,6 +13,34 @@
 #include <linux/idxd.h>
 #include "x86intrin.h"
 
+typedef enum DsaTaskType {
+    DSA_TASK = 0,
+    DSA_BATCH_TASK
+} DsaTaskType;
+
+typedef enum DsaTaskStatus {
+    DSA_TASK_READY = 0,
+    DSA_TASK_PROCESSING,
+    DSA_TASK_COMPLETION
+} DsaTaskStatus;
+
+typedef void (*dsa_completion_fn)(void *);
+
+typedef struct dsa_batch_task {
+    struct dsa_hw_desc batch_descriptor;
+    struct dsa_hw_desc *descriptors;
+    struct dsa_completion_record batch_completion __attribute__((aligned(32)));
+    struct dsa_completion_record *completions;
+    struct dsa_device_group *group;
+    struct dsa_device *device;
+    dsa_completion_fn completion_callback;
+    QemuSemaphore sem_task_complete;
+    DsaTaskType task_type;
+    DsaTaskStatus status;
+    int batch_size;
+    QSIMPLEQ_ENTRY(dsa_batch_task) entry;
+} dsa_batch_task;
+
 /**
  * @brief Initializes DSA devices.
  *
diff --git a/util/dsa.c b/util/dsa.c
index 05bbf8e31a..75739a1af6 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -244,6 +244,205 @@ dsa_device_group_get_next_device(struct dsa_device_group *group)
     return &group->dsa_devices[current];
 }
 
+/**
+ * @brief Empties out the DSA task queue.
+ *
+ * @param group A pointer to the DSA device group.
+ */
+static void
+dsa_empty_task_queue(struct dsa_device_group *group)
+{
+    qemu_mutex_lock(&group->task_queue_lock);
+    dsa_task_queue *task_queue = &group->task_queue;
+    while (!QSIMPLEQ_EMPTY(task_queue)) {
+        QSIMPLEQ_REMOVE_HEAD(task_queue, entry);
+    }
+    qemu_mutex_unlock(&group->task_queue_lock);
+}
+
+/**
+ * @brief Adds a task to the DSA task queue.
+ *
+ * @param group A pointer to the DSA device group.
+ * @param context A pointer to the DSA task to enqueue.
+ *
+ * @return int Zero if successful, otherwise a proper error code.
+ */
+static int
+dsa_task_enqueue(struct dsa_device_group *group,
+                 struct dsa_batch_task *task)
+{
+    dsa_task_queue *task_queue = &group->task_queue;
+    QemuMutex *task_queue_lock = &group->task_queue_lock;
+    QemuCond *task_queue_cond = &group->task_queue_cond;
+
+    bool notify = false;
+
+    qemu_mutex_lock(task_queue_lock);
+
+    if (!group->running) {
+        error_report("DSA: Tried to queue task to stopped device queue.");
+        qemu_mutex_unlock(task_queue_lock);
+        return -1;
+    }
+
+    /* The queue is empty. This enqueue operation is a 0->1 transition. */
+    if (QSIMPLEQ_EMPTY(task_queue)) {
+        notify = true;
+    }
+
+    QSIMPLEQ_INSERT_TAIL(task_queue, task, entry);
+
+    /* We need to notify the waiter for 0->1 transitions. */
+    if (notify) {
+        qemu_cond_signal(task_queue_cond);
+    }
+
+    qemu_mutex_unlock(task_queue_lock);
+
+    return 0;
+}
+
+/**
+ * @brief Takes a DSA task out of the task queue.
+ *
+ * @param group A pointer to the DSA device group.
+ * @return dsa_batch_task* The DSA task being dequeued.
+ */
+__attribute__((unused))
+static struct dsa_batch_task *
+dsa_task_dequeue(struct dsa_device_group *group)
+{
+    struct dsa_batch_task *task = NULL;
+    dsa_task_queue *task_queue = &group->task_queue;
+    QemuMutex *task_queue_lock = &group->task_queue_lock;
+    QemuCond *task_queue_cond = &group->task_queue_cond;
+
+    qemu_mutex_lock(task_queue_lock);
+
+    while (true) {
+        if (!group->running) {
+            goto exit;
+        }
+        task = QSIMPLEQ_FIRST(task_queue);
+        if (task != NULL) {
+            break;
+        }
+        qemu_cond_wait(task_queue_cond, task_queue_lock);
+    }
+
+    QSIMPLEQ_REMOVE_HEAD(task_queue, entry);
+
+exit:
+    qemu_mutex_unlock(task_queue_lock);
+    return task;
+}
+
+/**
+ * @brief Submits a DSA work item to the device work queue.
+ *
+ * @param wq A pointer to the DSA work queue's device memory.
+ * @param descriptor A pointer to the DSA work item descriptor.
+ *
+ * @return Zero if successful, non-zero otherwise.
+ */
+static int
+submit_wi_int(void *wq, struct dsa_hw_desc *descriptor)
+{
+    uint64_t retry = 0;
+
+    _mm_sfence();
+
+    while (true) {
+        if (_enqcmd(wq, descriptor) == 0) {
+            break;
+        }
+        retry++;
+        if (retry > max_retry_count) {
+            error_report("Submit work retry %lu times.", retry);
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+/**
+ * @brief Synchronously submits a DSA work item to the
+ *        device work queue.
+ *
+ * @param wq A pointer to the DSA worjk queue's device memory.
+ * @param descriptor A pointer to the DSA work item descriptor.
+ *
+ * @return int Zero if successful, non-zero otherwise.
+ */
+__attribute__((unused))
+static int
+submit_wi(void *wq, struct dsa_hw_desc *descriptor)
+{
+    return submit_wi_int(wq, descriptor);
+}
+
+/**
+ * @brief Asynchronously submits a DSA work item to the
+ *        device work queue.
+ *
+ * @param task A pointer to the buffer zero task.
+ *
+ * @return int Zero if successful, non-zero otherwise.
+ */
+__attribute__((unused))
+static int
+submit_wi_async(struct dsa_batch_task *task)
+{
+    struct dsa_device_group *device_group = task->group;
+    struct dsa_device *device_instance = task->device;
+    int ret;
+
+    assert(task->task_type == DSA_TASK);
+
+    task->status = DSA_TASK_PROCESSING;
+
+    ret = submit_wi_int(device_instance->work_queue,
+                        &task->descriptors[0]);
+    if (ret != 0) {
+        return ret;
+    }
+
+    return dsa_task_enqueue(device_group, task);
+}
+
+/**
+ * @brief Asynchronously submits a DSA batch work item to the
+ *        device work queue.
+ *
+ * @param dsa_batch_task A pointer to the batch buffer zero task.
+ *
+ * @return int Zero if successful, non-zero otherwise.
+ */
+__attribute__((unused))
+static int
+submit_batch_wi_async(struct dsa_batch_task *batch_task)
+{
+    struct dsa_device_group *device_group = batch_task->group;
+    struct dsa_device *device_instance = batch_task->device;
+    int ret;
+
+    assert(batch_task->task_type == DSA_BATCH_TASK);
+    assert(batch_task->batch_descriptor.desc_count <= batch_task->batch_size);
+    assert(batch_task->status == DSA_TASK_READY);
+
+    batch_task->status = DSA_TASK_PROCESSING;
+
+    ret = submit_wi_int(device_instance->work_queue,
+                        &batch_task->batch_descriptor);
+    if (ret != 0) {
+        return ret;
+    }
+
+    return dsa_task_enqueue(device_group, batch_task);
+}
+
 /**
  * @brief Check if DSA is running.
  *
@@ -300,6 +499,8 @@ void dsa_stop(void)
     if (!group->running) {
         return;
     }
+
+    dsa_empty_task_queue(group);
 }
 
 /**
-- 
2.30.2


