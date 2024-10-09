Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F7BCEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygPK-00033P-Br; Wed, 09 Oct 2024 19:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPD-00030U-Si
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:47:50 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPB-0006dC-Vs
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:47:47 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbbe3f6931so3725956d6.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728517665; x=1729122465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WUmwCNj9B4h3+NTsNbKxCDcNXgP/1g/8yeQPXdEzHo=;
 b=K99W7a9SrTQLeDUDRTiv8pa1UIVWizTkywdVu0H62FyHqm0GAIqf4W8l7jOg7R0wzk
 aLjmh96ABjBgkeooqRsJwOiMorDAOulGfYenAUdw50md8sYhx36yll9XmcickvtZKT/6
 oga1MVyphY4sCEJZnBmBnSDFdvcpArPpHpufaOhfTgfuMt0tCxD0uvdeKqN/2Ndq7azw
 yli281EzYEVAqRcIjWAqpEDHUBlBlfmVGFK7mpMJ/RroERNI28FMBbh60yi1pK9DoSO6
 wkXkr1pUAs+GhBs1KyZdkRPag0YAgMLHztVe6TkCvHihssCibKppcjHv7Jdbe2Uftq0I
 nVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728517665; x=1729122465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WUmwCNj9B4h3+NTsNbKxCDcNXgP/1g/8yeQPXdEzHo=;
 b=uM2hb7Ew8PLTY1oal+Q9O9GTdrW4Hqnmj76ctlXxzB0Cgz0hVg37l6Nb/Siv9xWeN8
 jWT4uGdZSBN0meykEsUWGJxaMYSRnAymluXK4uZBAJIEIaq1hozMjkqAlhEPSXva/7/W
 ne/DRQQdVGeddmsE/o/Nv3tlev/nHWVnyMtxU4ViE5leeOC27ldpFobALDaQ7zAbKBhz
 5fWXyZdJW6OGapB4XHHPue/RtC1+XnJB0qvcGfB7Lkc41OWWmj8vWAajDXDWd5yhvNdJ
 1QaN8vtl542SSFtTmg0gV/PQKLN692vEkNev9MNi3/rXemrVMU00z1XDmxbkuDC6SRwA
 1kvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBCdKM8/9lcFmkYamOkN9iO5En3PtI061c7+aLketUG7EkjHuBmN94nc09cNccp2QrCtTDFq7BlMcm@nongnu.org
X-Gm-Message-State: AOJu0Yz2Z76t8wbbnHi9GHbo2Z5tkbNdjDrBs0yT3jCdxjQHsUsH1FHP
 7wTFB0Hmh9ZSBws6ghyuI151c5SVe2Ge09CMDxUsS6NWOX94d9mq/NaOX71B4tU=
X-Google-Smtp-Source: AGHT+IFRTNg1/qFrWIsgSZAt7IflR0jKWfWRs05c62hDyD+L3zz0JcGbNWHf/FX1qkV788qx/+RHxw==
X-Received: by 2002:a05:6214:5788:b0:6cb:d1a7:aa1e with SMTP id
 6a1803df08f44-6cbd1a7af4cmr37410286d6.21.1728517664725; 
 Wed, 09 Oct 2024 16:47:44 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([2605:a7c0:0:301::44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85d856fsm264386d6.72.2024.10.09.16.47.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Oct 2024 16:47:44 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v6 05/12] util/dsa: Implement DSA task asynchronous completion
 thread model.
Date: Wed,  9 Oct 2024 16:46:03 -0700
Message-Id: <20241009234610.27039-6-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009234610.27039-1-yichen.wang@bytedance.com>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf35.google.com
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

* Create a dedicated thread for DSA task completion.
* DSA completion thread runs a loop and poll for completed tasks.
* Start and stop DSA completion thread during DSA device start stop.

User space application can directly submit task to Intel DSA
accelerator by writing to DSA's device memory (mapped in user space).
Once a task is submitted, the device starts processing it and write
the completion status back to the task. A user space application can
poll the task's completion status to check for completion. This change
uses a dedicated thread to perform DSA task completion checking.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 include/qemu/dsa.h |   1 +
 util/dsa.c         | 274 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 274 insertions(+), 1 deletion(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index f39533f4ac..7b30303791 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -69,6 +69,7 @@ typedef struct QemuDsaBatchTask {
     QemuDsaTaskType task_type;
     QemuDsaTaskStatus status;
     int batch_size;
+    bool *results;
     QSIMPLEQ_ENTRY(QemuDsaBatchTask) entry;
 } QemuDsaBatchTask;
 
diff --git a/util/dsa.c b/util/dsa.c
index 79e305cb6e..56828bec21 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -33,9 +33,20 @@
 #define DSA_WQ_PORTAL_SIZE 4096
 #define DSA_WQ_DEPTH 128
 #define MAX_DSA_DEVICES 16
+#define DSA_COMPLETION_THREAD "qemu_dsa_completion"
+
+typedef struct {
+    bool stopping;
+    bool running;
+    QemuThread thread;
+    int thread_id;
+    QemuSemaphore sem_init_done;
+    QemuDsaDeviceGroup *group;
+} QemuDsaCompletionThread;
 
 uint32_t max_retry_count;
 static QemuDsaDeviceGroup dsa_group;
+static QemuDsaCompletionThread completion_thread;
 
 
 /**
@@ -405,6 +416,265 @@ submit_batch_wi_async(QemuDsaBatchTask *batch_task)
     return dsa_task_enqueue(device_group, batch_task);
 }
 
+/**
+ * @brief Poll for the DSA work item completion.
+ *
+ * @param completion A pointer to the DSA work item completion record.
+ * @param opcode The DSA opcode.
+ *
+ * @return Zero if successful, non-zero otherwise.
+ */
+static int
+poll_completion(struct dsa_completion_record *completion,
+                enum dsa_opcode opcode)
+{
+    uint8_t status;
+    uint64_t retry = 0;
+
+    while (true) {
+        /* The DSA operation completes successfully or fails. */
+        status = completion->status;
+        if (status == DSA_COMP_SUCCESS ||
+            status == DSA_COMP_PAGE_FAULT_NOBOF ||
+            status == DSA_COMP_BATCH_PAGE_FAULT ||
+            status == DSA_COMP_BATCH_FAIL) {
+            break;
+        } else if (status != DSA_COMP_NONE) {
+            error_report("DSA opcode %d failed with status = %d.",
+                    opcode, status);
+            return 1;
+        }
+        retry++;
+        if (retry > max_retry_count) {
+            error_report("DSA wait for completion retry %lu times.", retry);
+            return 1;
+        }
+        _mm_pause();
+    }
+
+    return 0;
+}
+
+/**
+ * @brief Complete a single DSA task in the batch task.
+ *
+ * @param task A pointer to the batch task structure.
+ *
+ * @return Zero if successful, otherwise non-zero.
+ */
+static int
+poll_task_completion(QemuDsaBatchTask *task)
+{
+    assert(task->task_type == QEMU_DSA_TASK);
+
+    struct dsa_completion_record *completion = &task->completions[0];
+    uint8_t status;
+    int ret;
+
+    ret = poll_completion(completion, task->descriptors[0].opcode);
+    if (ret != 0) {
+        goto exit;
+    }
+
+    status = completion->status;
+    if (status == DSA_COMP_SUCCESS) {
+        task->results[0] = (completion->result == 0);
+        goto exit;
+    }
+
+    assert(status == DSA_COMP_PAGE_FAULT_NOBOF);
+
+exit:
+    return ret;
+}
+
+/**
+ * @brief Poll a batch task status until it completes. If DSA task doesn't
+ *        complete properly, use CPU to complete the task.
+ *
+ * @param batch_task A pointer to the DSA batch task.
+ *
+ * @return Zero if successful, otherwise non-zero.
+ */
+static int
+poll_batch_task_completion(QemuDsaBatchTask *batch_task)
+{
+    struct dsa_completion_record *batch_completion =
+        &batch_task->batch_completion;
+    struct dsa_completion_record *completion;
+    uint8_t batch_status;
+    uint8_t status;
+    bool *results = batch_task->results;
+    uint32_t count = batch_task->batch_descriptor.desc_count;
+    int ret;
+
+    ret = poll_completion(batch_completion,
+                          batch_task->batch_descriptor.opcode);
+    if (ret != 0) {
+        goto exit;
+    }
+
+    batch_status = batch_completion->status;
+
+    if (batch_status == DSA_COMP_SUCCESS) {
+        if (batch_completion->bytes_completed == count) {
+            /*
+             * Let's skip checking for each descriptors' completion status
+             * if the batch descriptor says all succedded.
+             */
+            for (int i = 0; i < count; i++) {
+                assert(batch_task->completions[i].status == DSA_COMP_SUCCESS);
+                results[i] = (batch_task->completions[i].result == 0);
+            }
+            goto exit;
+        }
+    } else {
+        assert(batch_status == DSA_COMP_BATCH_FAIL ||
+            batch_status == DSA_COMP_BATCH_PAGE_FAULT);
+    }
+
+    for (int i = 0; i < count; i++) {
+
+        completion = &batch_task->completions[i];
+        status = completion->status;
+
+        if (status == DSA_COMP_SUCCESS) {
+            results[i] = (completion->result == 0);
+            continue;
+        }
+
+        assert(status == DSA_COMP_PAGE_FAULT_NOBOF);
+
+        if (status != DSA_COMP_PAGE_FAULT_NOBOF) {
+            error_report("Unexpected DSA completion status = %u.", status);
+            ret = 1;
+            goto exit;
+        }
+    }
+
+exit:
+    return ret;
+}
+
+/**
+ * @brief Handles an asynchronous DSA batch task completion.
+ *
+ * @param task A pointer to the batch buffer zero task structure.
+ */
+static void
+dsa_batch_task_complete(QemuDsaBatchTask *batch_task)
+{
+    batch_task->status = QEMU_DSA_TASK_COMPLETION;
+    batch_task->completion_callback(batch_task);
+}
+
+/**
+ * @brief The function entry point called by a dedicated DSA
+ *        work item completion thread.
+ *
+ * @param opaque A pointer to the thread context.
+ *
+ * @return void* Not used.
+ */
+static void *
+dsa_completion_loop(void *opaque)
+{
+    QemuDsaCompletionThread *thread_context =
+        (QemuDsaCompletionThread *)opaque;
+    QemuDsaBatchTask *batch_task;
+    QemuDsaDeviceGroup *group = thread_context->group;
+    int ret;
+
+    rcu_register_thread();
+
+    thread_context->thread_id = qemu_get_thread_id();
+    qemu_sem_post(&thread_context->sem_init_done);
+
+    while (thread_context->running) {
+        batch_task = dsa_task_dequeue(group);
+        assert(batch_task != NULL || !group->running);
+        if (!group->running) {
+            assert(!thread_context->running);
+            break;
+        }
+        if (batch_task->task_type == QEMU_DSA_TASK) {
+            ret = poll_task_completion(batch_task);
+        } else {
+            assert(batch_task->task_type == QEMU_DSA_BATCH_TASK);
+            ret = poll_batch_task_completion(batch_task);
+        }
+
+        if (ret != 0) {
+            goto exit;
+        }
+
+        dsa_batch_task_complete(batch_task);
+    }
+
+exit:
+    if (ret != 0) {
+        error_report("DSA completion thread exited due to internal error.");
+    }
+    rcu_unregister_thread();
+    return NULL;
+}
+
+/**
+ * @brief Initializes a DSA completion thread.
+ *
+ * @param completion_thread A pointer to the completion thread context.
+ * @param group A pointer to the DSA device group.
+ */
+static void
+dsa_completion_thread_init(
+    QemuDsaCompletionThread *completion_thread,
+    QemuDsaDeviceGroup *group)
+{
+    completion_thread->stopping = false;
+    completion_thread->running = true;
+    completion_thread->thread_id = -1;
+    qemu_sem_init(&completion_thread->sem_init_done, 0);
+    completion_thread->group = group;
+
+    qemu_thread_create(&completion_thread->thread,
+                       DSA_COMPLETION_THREAD,
+                       dsa_completion_loop,
+                       completion_thread,
+                       QEMU_THREAD_JOINABLE);
+
+    /* Wait for initialization to complete */
+    qemu_sem_wait(&completion_thread->sem_init_done);
+}
+
+/**
+ * @brief Stops the completion thread (and implicitly, the device group).
+ *
+ * @param opaque A pointer to the completion thread.
+ */
+static void dsa_completion_thread_stop(void *opaque)
+{
+    QemuDsaCompletionThread *thread_context =
+        (QemuDsaCompletionThread *)opaque;
+
+    QemuDsaDeviceGroup *group = thread_context->group;
+
+    qemu_mutex_lock(&group->task_queue_lock);
+
+    thread_context->stopping = true;
+    thread_context->running = false;
+
+    /* Prevent the compiler from setting group->running first. */
+    barrier();
+    dsa_device_group_stop(group);
+
+    qemu_cond_signal(&group->task_queue_cond);
+    qemu_mutex_unlock(&group->task_queue_lock);
+
+    qemu_thread_join(&thread_context->thread);
+
+    qemu_sem_destroy(&thread_context->sem_init_done);
+}
+
 /**
  * @brief Check if DSA is running.
  *
@@ -412,7 +682,7 @@ submit_batch_wi_async(QemuDsaBatchTask *batch_task)
  */
 bool qemu_dsa_is_running(void)
 {
-    return false;
+    return completion_thread.running;
 }
 
 static void
@@ -453,6 +723,7 @@ void qemu_dsa_start(void)
         return;
     }
     dsa_device_group_start(&dsa_group);
+    dsa_completion_thread_init(&completion_thread, &dsa_group);
 }
 
 /**
@@ -467,6 +738,7 @@ void qemu_dsa_stop(void)
         return;
     }
 
+    dsa_completion_thread_stop(&completion_thread);
     dsa_empty_task_queue(group);
 }
 
-- 
Yichen Wang


