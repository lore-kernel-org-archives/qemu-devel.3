Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45701C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1ip-00043i-8F; Thu, 11 Jul 2024 17:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1in-0003xT-EC
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:01 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1ik-0005ZB-HJ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:01 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7036815bde7so764076a34.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720734777; x=1721339577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezdtSRzbDM4mbxnqXDkQjV62eVN37sRjYFDSf1h9wlc=;
 b=ITayidxDmvs9yIeGheqt/dc5kfrpRvL0mrTrI46/vlA2lmAt7krTWW2gICzgQBxGum
 9D8Ifd6qjKZ1LRhfxqV/K/m9mreV/u7gtLKggg5woVly2m+QymT36xg2a6QrFtHsx8wM
 eYB4WoSHMBJMa9pv6sU+QJiFX9FKZ7PyssTNobfrK+ZIygIzM5ELd4Vb48uXVPkZeSBq
 DsQQbMCpQ5ZuFSZJiAebts8mwilC6u41GQt4v7LRkCgzd1rQJ2ks3QCdxKcDbCN0wjQq
 xtlhLE+RklzW8Rial685oE+9DPYrBX5twSQqliyxqMJXjdJL7Bj4zPC4ihY+IvN5wVLU
 ORgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720734777; x=1721339577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezdtSRzbDM4mbxnqXDkQjV62eVN37sRjYFDSf1h9wlc=;
 b=OjeTxkxIkgA2PSWGGK03Kmc4tFAdLMiA7ofhj6zUerJYAZjGEYZDWU0sf/vIIv0SaB
 km7Xoed9oR6f4qMrHWG1nEmcc8tIJSB5acS+3M+YWCnyD8TXpUev55rXbq7Qj67SzCXp
 bcJzMKkteZt+y6/cCB7xTR9WiLX/LOZmXjYAcn7FExecwpZHKDZ6jS9GFHt5gmJluNug
 PCI9CenAz/JT8I/V/UaPSGWC1EssOGHiIa9jxK/Kk4lbDPVUxaSzGCLfiW2ZxpragLJs
 zJ9Nl1eYsLA02mbtkXT7O+4yMQcsWWuMJ30EFf6rbY28Y1AbdDxfoYw+GfJaE+v0sVma
 vw6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg0m1MLqCPTr4wIMDaDik+JJtzYWNZ7MTbyZsrMOrfDUdrWehjiecNvUzP2t6JYEdQE116qqAsyLNIoMM9tPKNbKKpYt4=
X-Gm-Message-State: AOJu0YyEW0wRj3QTmSjLb8klwlsLW/pr7H97inAFkEK3IqgsSbJlSiJB
 0ce5GwRViJAjOYUSfk3zdIHpcGaD1dMjm9tcPj6kRrhdzgUs+jxsmdPP8Rcsip8=
X-Google-Smtp-Source: AGHT+IGXbu5g32bH53t05aCGfesH7madKXiU/qxxZfX8BjX6ygJ5Ghow2wt31583z9NLFoxKjB8+Gg==
X-Received: by 2002:a05:6830:cb:b0:703:77bd:9522 with SMTP id
 46e09a7af769-70377bd9d30mr10668090a34.17.1720734777343; 
 Thu, 11 Jul 2024 14:52:57 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7044ac2876dsm713125a34.2.2024.07.11.14.52.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 14:52:57 -0700 (PDT)
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
Subject: [PATCH v5 04/13] util/dsa: Implement DSA task enqueue and dequeue.
Date: Thu, 11 Jul 2024 14:52:39 -0700
Message-Id: <20240711215244.19237-5-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711215244.19237-1-yichen.wang@bytedance.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=yichen.wang@bytedance.com; helo=mail-ot1-x331.google.com
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
 include/qemu/dsa.h |  46 ++++++++++
 util/dsa.c         | 222 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 246 insertions(+), 22 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index 29b60654e9..9cc836b64c 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -27,6 +27,52 @@
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
+typedef struct {
+    void *work_queue;
+} QemuDsaDevice;
+
+typedef QSIMPLEQ_HEAD(QemuDsaTaskQueue, QemuDsaBatchTask) QemuDsaTaskQueue;
+
+typedef struct {
+    QemuDsaDevice *dsa_devices;
+    int num_dsa_devices;
+    /* The index of the next DSA device to be used. */
+    uint32_t device_allocator_index;
+    bool running;
+    QemuMutex task_queue_lock;
+    QemuCond task_queue_cond;
+    QemuDsaTaskQueue task_queue;
+} QemuDsaDeviceGroup;
+
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
index cdb0b9dda2..43280b31cd 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -30,27 +30,11 @@
 #include <linux/idxd.h>
 #include "x86intrin.h"
 
-#define DSA_WQ_SIZE 4096
+#define DSA_WQ_PORTAL_SIZE 4096
+#define DSA_WQ_DEPTH 128
 #define MAX_DSA_DEVICES 16
 
-typedef QSIMPLEQ_HEAD(dsa_task_queue, dsa_batch_task) dsa_task_queue;
-
-typedef struct {
-    void *work_queue;
-} QemuDsaDevice;
-
-typedef struct {
-    QemuDsaDevice *dsa_devices;
-    int num_dsa_devices;
-    /* The index of the next DSA device to be used. */
-    uint32_t device_allocator_index;
-    bool running;
-    QemuMutex task_queue_lock;
-    QemuCond task_queue_cond;
-    dsa_task_queue task_queue;
-} QemuDsaDeviceGroup;
-
-uint64_t max_retry_count;
+uint32_t max_retry_count;
 static QemuDsaDeviceGroup dsa_group;
 
 
@@ -73,7 +57,7 @@ map_dsa_device(const char *dsa_wq_path)
                 dsa_wq_path, errno);
         return MAP_FAILED;
     }
-    dsa_device = mmap(NULL, DSA_WQ_SIZE, PROT_WRITE,
+    dsa_device = mmap(NULL, DSA_WQ_PORTAL_SIZE, PROT_WRITE,
                       MAP_SHARED | MAP_POPULATE, fd, 0);
     close(fd);
     if (dsa_device == MAP_FAILED) {
@@ -105,7 +89,7 @@ static void
 dsa_device_cleanup(QemuDsaDevice *instance)
 {
     if (instance->work_queue != MAP_FAILED) {
-        munmap(instance->work_queue, DSA_WQ_SIZE);
+        munmap(instance->work_queue, DSA_WQ_PORTAL_SIZE);
     }
 }
 
@@ -233,6 +217,198 @@ dsa_device_group_get_next_device(QemuDsaDeviceGroup *group)
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
@@ -246,7 +422,7 @@ bool qemu_dsa_is_running(void)
 static void
 dsa_globals_init(void)
 {
-    max_retry_count = UINT64_MAX;
+    max_retry_count = DSA_WQ_DEPTH;
 }
 
 /**
@@ -289,6 +465,8 @@ void qemu_dsa_stop(void)
     if (!group->running) {
         return;
     }
+
+    dsa_empty_task_queue(group);
 }
 
 /**
-- 
Yichen Wang


