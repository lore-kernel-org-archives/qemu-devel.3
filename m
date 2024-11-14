Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367B6D6A248
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 22:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBhuZ-0003OK-Ut; Thu, 14 Nov 2024 17:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhuU-0003N2-1T
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:01:57 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhuR-0007ec-6B
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:01:52 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b15416303aso66569885a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 14:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1731621710; x=1732226510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5ccyaMJduIz/3YSCSIg1cp3jQKkuXtEIUcvrNn75vU=;
 b=CPdyuoQi+n23tr1Hmca76z+juRQXmYQlg6OIIYOk5HCsNaAVW00mWACtk8W0XJ4zyI
 DOiXkQU/C6vhoG8PHGAKOxRCeyt49DgQHoqoPyDlgrC1/NSP6XdWVNgTTbjajp/xOEbX
 gQZeiGGevnrWiywohjOoG5lLjV+szuXqF+7twSM6w5mvDOLuRjiLP4ssjVlfOmKSMeFk
 +cSKBb3mE/ZvkVJEwZVdCp3gJSum1h4O67cshfFGKoysOiTF3PSNdwloYLhTgpxcDwT8
 b935r5uzzyToHk3DBCnSk/rOL1nwHQ5LF1YWF/F2plliT56e3uf0NyBHeojGLWdHp46n
 69vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731621710; x=1732226510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5ccyaMJduIz/3YSCSIg1cp3jQKkuXtEIUcvrNn75vU=;
 b=E3Q24WcvI3uc/FoyKgE0Csof2v30d/Y9wY0r9Jn7NUstqaY/ncGVhg274SuYKTIQlX
 tiqwAYcXVFNxj1ZeDxbAeeifdHkRuMZdz3qiguvx6xFz4ocdzAGHEiLzEGEzfYis1nNC
 tppKw+5x7lmZUUuk3NOmGk1PDMWaupbgJVS33rxHlvNRWrxeJ5Y1g4Re41DsoEvLN4YD
 UZ4suaDN5ULSxvlFnFC14Q0fN+6u/xAJMB2QvrJKj5OMaddN1L0QmFIcMzUbzAhXvllm
 3JiKeZ2IshSSgRVEO5h71AYLO2BgBEVtWQibZjMT1UObqSNzA9OtaO61U2cWdvuR/uAw
 RXDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe7PsjrTN6ytFTRwsAYc45h337XA5lV4TVKPfamhly2dAgaVfRA2ImJM7L2kq7/EA9JjhgVb+KdXge@nongnu.org
X-Gm-Message-State: AOJu0YyGzX83GKVHryMgU7ctcfWQ7GKuxV8B5JTwpF8X9VUL1twGvUwu
 XlbNZqOUbHI49Sowz0HFYGXPNgh80FB6izfxLb1e3h0njwT+bTpA3CTg2Lt8rps=
X-Google-Smtp-Source: AGHT+IHXTWS7/H/Q5aLUpRoBH3tpBsnQkzVRRp3WVjnx+2EhICqd87raHL35N3vSeAxEg94lkKZsZg==
X-Received: by 2002:a05:6214:5b11:b0:6d3:9292:6ce with SMTP id
 6a1803df08f44-6d3fb83ded2mr3582066d6.27.1731621710074; 
 Thu, 14 Nov 2024 14:01:50 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net ([130.44.212.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca308bdsm93742485a.83.2024.11.14.14.01.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 14:01:49 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v7 04/12] util/dsa: Implement DSA task enqueue and dequeue.
Date: Thu, 14 Nov 2024 14:01:24 -0800
Message-Id: <20241114220132.27399-5-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241114220132.27399-1-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qk1-x72f.google.com
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

* Use a safe thread queue for DSA task enqueue/dequeue.
* Implement DSA task submission.
* Implement DSA batch task submission.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 include/qemu/dsa.h |  29 +++++++
 util/dsa.c         | 202 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 230 insertions(+), 1 deletion(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index 71686af28f..04ee8924ab 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -27,6 +27,17 @@
 #include <linux/idxd.h>
 #include "x86intrin.h"
 
+typedef enum QemuDsaTaskType {
+    QEMU_DSA_TASK = 0,
+    QEMU_DSA_BATCH_TASK
+} QemuDsaTaskType;
+
+typedef enum QemuDsaTaskStatus {
+    QEMU_DSA_TASK_READY = 0,
+    QEMU_DSA_TASK_PROCESSING,
+    QEMU_DSA_TASK_COMPLETION
+} QemuDsaTaskStatus;
+
 typedef struct {
     void *work_queue;
 } QemuDsaDevice;
@@ -44,6 +55,24 @@ typedef struct {
     QemuDsaTaskQueue task_queue;
 } QemuDsaDeviceGroup;
 
+typedef void (*qemu_dsa_completion_fn)(void *);
+
+typedef struct QemuDsaBatchTask {
+    struct dsa_hw_desc batch_descriptor;
+    struct dsa_hw_desc *descriptors;
+    struct dsa_completion_record batch_completion __attribute__((aligned(32)));
+    struct dsa_completion_record *completions;
+    QemuDsaDeviceGroup *group;
+    QemuDsaDevice *device;
+    qemu_dsa_completion_fn completion_callback;
+    QemuSemaphore sem_task_complete;
+    QemuDsaTaskType task_type;
+    QemuDsaTaskStatus status;
+    int batch_size;
+    QSIMPLEQ_ENTRY(QemuDsaBatchTask) entry;
+} QemuDsaBatchTask;
+
+
 /**
  * @brief Initializes DSA devices.
  *
diff --git a/util/dsa.c b/util/dsa.c
index 79dab5d62c..b55fa599f0 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -31,6 +31,7 @@
 #include "x86intrin.h"
 
 #define DSA_WQ_PORTAL_SIZE 4096
+#define DSA_WQ_DEPTH 128
 #define MAX_DSA_DEVICES 16
 
 uint32_t max_retry_count;
@@ -210,6 +211,198 @@ dsa_device_group_get_next_device(QemuDsaDeviceGroup *group)
     return &group->dsa_devices[current];
 }
 
+/**
+ * @brief Empties out the DSA task queue.
+ *
+ * @param group A pointer to the DSA device group.
+ */
+static void
+dsa_empty_task_queue(QemuDsaDeviceGroup *group)
+{
+    qemu_mutex_lock(&group->task_queue_lock);
+    QemuDsaTaskQueue *task_queue = &group->task_queue;
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
+ * @param task A pointer to the DSA task to enqueue.
+ *
+ * @return int Zero if successful, otherwise a proper error code.
+ */
+static int
+dsa_task_enqueue(QemuDsaDeviceGroup *group,
+                 QemuDsaBatchTask *task)
+{
+    bool notify = false;
+
+    qemu_mutex_lock(&group->task_queue_lock);
+
+    if (!group->running) {
+        error_report("DSA: Tried to queue task to stopped device queue.");
+        qemu_mutex_unlock(&group->task_queue_lock);
+        return -1;
+    }
+
+    /* The queue is empty. This enqueue operation is a 0->1 transition. */
+    if (QSIMPLEQ_EMPTY(&group->task_queue)) {
+        notify = true;
+    }
+
+    QSIMPLEQ_INSERT_TAIL(&group->task_queue, task, entry);
+
+    /* We need to notify the waiter for 0->1 transitions. */
+    if (notify) {
+        qemu_cond_signal(&group->task_queue_cond);
+    }
+
+    qemu_mutex_unlock(&group->task_queue_lock);
+
+    return 0;
+}
+
+/**
+ * @brief Takes a DSA task out of the task queue.
+ *
+ * @param group A pointer to the DSA device group.
+ * @return QemuDsaBatchTask* The DSA task being dequeued.
+ */
+__attribute__((unused))
+static QemuDsaBatchTask *
+dsa_task_dequeue(QemuDsaDeviceGroup *group)
+{
+    QemuDsaBatchTask *task = NULL;
+
+    qemu_mutex_lock(&group->task_queue_lock);
+
+    while (true) {
+        if (!group->running) {
+            goto exit;
+        }
+        task = QSIMPLEQ_FIRST(&group->task_queue);
+        if (task != NULL) {
+            break;
+        }
+        qemu_cond_wait(&group->task_queue_cond, &group->task_queue_lock);
+    }
+
+    QSIMPLEQ_REMOVE_HEAD(&group->task_queue, entry);
+
+exit:
+    qemu_mutex_unlock(&group->task_queue_lock);
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
+    uint32_t retry = 0;
+
+    _mm_sfence();
+
+    while (true) {
+        if (_enqcmd(wq, descriptor) == 0) {
+            break;
+        }
+        retry++;
+        if (retry > max_retry_count) {
+            error_report("Submit work retry %u times.", retry);
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
+ * @param wq A pointer to the DSA work queue's device memory.
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
+ * @param task A pointer to the task.
+ *
+ * @return int Zero if successful, non-zero otherwise.
+ */
+__attribute__((unused))
+static int
+submit_wi_async(QemuDsaBatchTask *task)
+{
+    QemuDsaDeviceGroup *device_group = task->group;
+    QemuDsaDevice *device_instance = task->device;
+    int ret;
+
+    assert(task->task_type == QEMU_DSA_TASK);
+
+    task->status = QEMU_DSA_TASK_PROCESSING;
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
+ * @param batch_task A pointer to the batch task.
+ *
+ * @return int Zero if successful, non-zero otherwise.
+ */
+__attribute__((unused))
+static int
+submit_batch_wi_async(QemuDsaBatchTask *batch_task)
+{
+    QemuDsaDeviceGroup *device_group = batch_task->group;
+    QemuDsaDevice *device_instance = batch_task->device;
+    int ret;
+
+    assert(batch_task->task_type == QEMU_DSA_BATCH_TASK);
+    assert(batch_task->batch_descriptor.desc_count <= batch_task->batch_size);
+    assert(batch_task->status == QEMU_DSA_TASK_READY);
+
+    batch_task->status = QEMU_DSA_TASK_PROCESSING;
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
@@ -223,7 +416,12 @@ bool qemu_dsa_is_running(void)
 static void
 dsa_globals_init(void)
 {
-    max_retry_count = UINT32_MAX;
+    /*
+     * This value follows a reference example by Intel. The POLL_RETRY_MAX is
+     * defined to 10000, so here we used the max WQ depth * 100 for the the max
+     * polling retry count.
+     */
+    max_retry_count = DSA_WQ_DEPTH * 100;
 }
 
 /**
@@ -266,6 +464,8 @@ void qemu_dsa_stop(void)
     if (!group->running) {
         return;
     }
+
+    dsa_empty_task_queue(group);
 }
 
 /**
-- 
Yichen Wang


