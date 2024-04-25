Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33507C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzol5-0000Xe-4R; Wed, 24 Apr 2024 22:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzol0-0000WX-LW
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:42 -0400
Received: from out-181.mta1.migadu.com ([95.215.58.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzoky-0005AI-GN
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:42 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1714011759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGc89WKM0cHq+3UC0v4DbA0/xNOJoDXKucErcy0uuiY=;
 b=N6xoF3F73kIv8H/hfvV+egYoZEo1tfaV8qqLMD+9H6mCii5OPPwfx8xxJO6Eyw9LXvZhAp
 ZYuGHT3ldLI1KPWPTJFG8DjpBTDfGSXTJvz9xzCfBjwbvSbNthSgOcWgUCB64W5fYLnCvI
 EL+aDTysNY2Qy71hSNoHAMJc7ZX6D0Y=
From: Hao Xiang <hao.xiang@linux.dev>
To: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>,
	Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v4 07/14] util/dsa: Implement DSA task asynchronous submission
 and wait for completion.
Date: Thu, 25 Apr 2024 02:21:10 +0000
Message-Id: <20240425022117.4035031-8-hao.xiang@linux.dev>
In-Reply-To: <20240425022117.4035031-1-hao.xiang@linux.dev>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.181; envelope-from=hao.xiang@linux.dev;
 helo=out-181.mta1.migadu.com
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

* Add a DSA task completion callback.
* DSA completion thread will call the tasks's completion callback
on every task/batch task completion.
* DSA submission path to wait for completion.
* Implement CPU fallback if DSA is not able to complete the task.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
---
 include/qemu/dsa.h |  14 +++++
 util/dsa.c         | 147 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index 645e6fc367..e002652879 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -91,6 +91,20 @@ buffer_zero_batch_task_init(struct dsa_batch_task *task,
  */
 void buffer_zero_batch_task_destroy(struct dsa_batch_task *task);
 
+/**
+ * @brief Performs buffer zero comparison on a DSA batch task asynchronously.
+ *
+ * @param batch_task A pointer to the batch task.
+ * @param buf An array of memory buffers.
+ * @param count The number of buffers in the array.
+ * @param len The buffer length.
+ *
+ * @return Zero if successful, otherwise non-zero.
+ */
+int
+buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
+                               const void **buf, size_t count, size_t len);
+
 #else
 
 static inline bool dsa_is_running(void)
diff --git a/util/dsa.c b/util/dsa.c
index 9db4cfcf1d..5a2bf33651 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -473,6 +473,57 @@ poll_completion(struct dsa_completion_record *completion,
     return 0;
 }
 
+/**
+ * @brief Helper function to use CPU to complete a single
+ *        zero page checking task.
+ *
+ * @param completion A pointer to a DSA task completion record.
+ * @param descriptor A pointer to a DSA task descriptor.
+ * @param result A pointer to the result of a zero page checking.
+ */
+static void
+task_cpu_fallback_int(struct dsa_completion_record *completion,
+                      struct dsa_hw_desc *descriptor, bool *result)
+{
+    const uint8_t *buf;
+    size_t len;
+
+    if (completion->status == DSA_COMP_SUCCESS) {
+        return;
+    }
+
+    /*
+     * DSA was able to partially complete the operation. Check the
+     * result. If we already know this is not a zero page, we can
+     * return now.
+     */
+    if (completion->bytes_completed != 0 && completion->result != 0) {
+        *result = false;
+        return;
+    }
+
+    /* Let's fallback to use CPU to complete it. */
+    buf = (const uint8_t *)descriptor->src_addr;
+    len = descriptor->xfer_size;
+    *result = buffer_is_zero(buf + completion->bytes_completed,
+                             len - completion->bytes_completed);
+}
+
+/**
+ * @brief Use CPU to complete a single zero page checking task.
+ *
+ * @param task A pointer to the task.
+ */
+static void
+task_cpu_fallback(struct dsa_batch_task *task)
+{
+    assert(task->task_type == DSA_TASK);
+
+    task_cpu_fallback_int(&task->completions[0],
+                          &task->descriptors[0],
+                          &task->results[0]);
+}
+
 /**
  * @brief Complete a single DSA task in the batch task.
  *
@@ -574,6 +625,47 @@ exit:
     return ret;
 }
 
+/**
+ * @brief Use CPU to complete the zero page checking batch task.
+ *
+ * @param batch_task A pointer to the batch task.
+ */
+static void
+batch_task_cpu_fallback(struct dsa_batch_task *batch_task)
+{
+    assert(batch_task->task_type == DSA_BATCH_TASK);
+
+    struct dsa_completion_record *batch_completion =
+        &batch_task->batch_completion;
+    struct dsa_completion_record *completion;
+    uint8_t status;
+    bool *results = batch_task->results;
+    uint32_t count = batch_task->batch_descriptor.desc_count;
+
+    /* DSA is able to complete the entire batch task. */
+    if (batch_completion->status == DSA_COMP_SUCCESS) {
+        assert(count == batch_completion->bytes_completed);
+        return;
+    }
+
+    /*
+     * DSA encounters some error and is not able to complete
+     * the entire batch task. Use CPU fallback.
+     */
+    for (int i = 0; i < count; i++) {
+
+        completion = &batch_task->completions[i];
+        status = completion->status;
+
+        assert(status == DSA_COMP_SUCCESS ||
+            status == DSA_COMP_PAGE_FAULT_NOBOF);
+
+        task_cpu_fallback_int(completion,
+                              &batch_task->descriptors[i],
+                              &results[i]);
+    }
+}
+
 /**
  * @brief Handles an asynchronous DSA batch task completion.
  *
@@ -861,7 +953,6 @@ buffer_zero_batch_task_set(struct dsa_batch_task *batch_task,
  *
  * @return int Zero if successful, otherwise an appropriate error code.
  */
-__attribute__((unused))
 static int
 buffer_zero_dsa_async(struct dsa_batch_task *task,
                       const void *buf, size_t len)
@@ -880,7 +971,6 @@ buffer_zero_dsa_async(struct dsa_batch_task *task,
  * @param count The number of buffers.
  * @param len The buffer length.
  */
-__attribute__((unused))
 static int
 buffer_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
                             const void **buf, size_t count, size_t len)
@@ -911,13 +1001,29 @@ buffer_zero_dsa_completion(void *context)
  *
  * @param batch_task A pointer to the buffer zero comparison batch task.
  */
-__attribute__((unused))
 static void
 buffer_zero_dsa_wait(struct dsa_batch_task *batch_task)
 {
     qemu_sem_wait(&batch_task->sem_task_complete);
 }
 
+/**
+ * @brief Use CPU to complete the zero page checking task if DSA
+ *        is not able to complete it.
+ *
+ * @param batch_task A pointer to the batch task.
+ */
+static void
+buffer_zero_cpu_fallback(struct dsa_batch_task *batch_task)
+{
+    if (batch_task->task_type == DSA_TASK) {
+        task_cpu_fallback(batch_task);
+    } else {
+        assert(batch_task->task_type == DSA_BATCH_TASK);
+        batch_task_cpu_fallback(batch_task);
+    }
+}
+
 /**
  * @brief Check if DSA is running.
  *
@@ -990,5 +1096,40 @@ void dsa_cleanup(void)
     dsa_device_group_cleanup(&dsa_group);
 }
 
+/**
+ * @brief Performs buffer zero comparison on a DSA batch task asynchronously.
+ *
+ * @param batch_task A pointer to the batch task.
+ * @param buf An array of memory buffers.
+ * @param count The number of buffers in the array.
+ * @param len The buffer length.
+ *
+ * @return Zero if successful, otherwise non-zero.
+ */
+int
+buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
+                               const void **buf, size_t count, size_t len)
+{
+    if (count <= 0 || count > batch_task->batch_size) {
+        return -1;
+    }
+
+    assert(batch_task != NULL);
+    assert(len != 0);
+    assert(buf != NULL);
+
+    if (count == 1) {
+        /* DSA doesn't take batch operation with only 1 task. */
+        buffer_zero_dsa_async(batch_task, buf[0], len);
+    } else {
+        buffer_zero_dsa_batch_async(batch_task, buf, count, len);
+    }
+
+    buffer_zero_dsa_wait(batch_task);
+    buffer_zero_cpu_fallback(batch_task);
+
+    return 0;
+}
+
 #endif
 
-- 
2.30.2


