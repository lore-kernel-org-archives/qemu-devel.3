Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3D4E7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIes8-000425-1V; Tue, 03 Dec 2024 21:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIes6-00041J-3Y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:12:10 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIes4-0005Qm-7n
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:12:09 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-466a079bc5eso50406711cf.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 18:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1733278327; x=1733883127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOkdQXfhMlMNsUsnnl15U7tgloUxCN5E+1OgsVHEgkw=;
 b=Scj4yxEjLMxYn4LqV1vZdbeqX3W6GHhBF0UrsME580p0YFHTcW8htikspMJc4Fa7nY
 qH+gT+aeoRLgfxs2OORRgRNEKSpxLkr+q48OEAZ3K5gl/QCfMeeJ2Gn2JnTjlagOx1Q/
 2xhKNwWtC2o/+LCdkfZ97NELpqDELc1/FPaZh02wefCR/nC6O7lbRLdkxDe9FidKr4dq
 cP+1hd0cXlusQod0HQvoa/1OC/Dz0E8QaQRwdqKktoe2SOJ33TCDXhuOZtiVu+baKpLM
 U64VPAG9qNgw9Tzm50ZCIJypjhbXt+2QzWrHp7go3oqqBFbdOY+3KfTyBTRW6i7osal+
 Ccfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733278327; x=1733883127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WOkdQXfhMlMNsUsnnl15U7tgloUxCN5E+1OgsVHEgkw=;
 b=NMEjrF/hREQUYk7pV/I+XDWVDSiZ72WndTNA4RN5+Gim9AgxKTJ3+iHkq2yucJwALM
 p8vo6eMyrTiLCEXjSVuZDXYluri0jLFnFLY+mi9cqFn1xkU1iT7+Xu4M4g1PcikYSIck
 UHs0kLHJKIQ4rWMNZPJBimwPNYF7SHqqOa5Pkvw3VBRCU/pCzW2A/X+qmrdOUYWjG2qa
 L1m+wD4SU2ps2kYnhewKAPQS/qUMwCrPa+gegudnPcfZW1nWdW4rNQyf+Z/XjEkXL4fg
 5npbXxEnpEFwPnurGf8RMM+v2FJDSXn8tw+dQlNty06zGDB2YZnOgCG3pmrDlEgb95Zv
 prNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYgbb8m5h4H4Wuds5vHdovIzrGpHE14IljZGxHThYw1Ir1tz2Nj02UrGK0Y+2/hXhwj+yrqZRSNr28@nongnu.org
X-Gm-Message-State: AOJu0YyMLcEeXqusdjaDTrmOrzmnFFlYnZnBt6h6RLarJAa/WXTGwkqL
 qUxOSy6f4Uu1Oh5RSvdzoe0RWfnVz4v9rAMVcX2dSw2YYiE7OGxgyh6LLqMVpiQ=
X-Gm-Gg: ASbGncvJdmds8G38ZNhtgVjbLtdumaaEvgGAaOLHcGNSFzOWS15p8LWHbnche3tJn1H
 rvcbtslv6x3SI1vywnaRxqXi0qocRbcaXLwvzhmOWq/F0sUOZI8wT5SIPdG6Uw5GgLJ1bzFhY3h
 EuR+7KiswJqHvgBfR11BeahVeohBDx++YmuFK/GbDnNXxTQ3W07aFkPIjwGBzZuECVbokzqNoEr
 eoZpwrbALUH6JXnkpWlcpbs3Q2PDZ7T19TKtpko4La/a1z6wGB11Arym+b3BFmQuZEXDFBRK/Py
 QPuhEvNr5leyl2qJfA==
X-Google-Smtp-Source: AGHT+IGHdK/+ieEW0Es2NWEaRArvYd3IyysXMFAMVlRMV50uMrJOZlqJoC+AbQbwfQg6MbftdqOpNw==
X-Received: by 2002:a05:6214:d6f:b0:6d4:36ff:435b with SMTP id
 6a1803df08f44-6d8b738a673mr88456976d6.20.1733278327207; 
 Tue, 03 Dec 2024 18:12:07 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:323:644e:288b:2b6d:d94c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d87ec537ebsm63488986d6.30.2024.12.03.18.12.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 18:12:06 -0800 (PST)
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
Subject: [PATCH v8 05/12] util/dsa: Implement DSA task asynchronous completion
 thread model.
Date: Tue,  3 Dec 2024 18:11:34 -0800
Message-Id: <20241204021142.24184-6-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241204021142.24184-1-yichen.wang@bytedance.com>
References: <20241204021142.24184-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qt1-x833.google.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/dsa.h |   1 +
 util/dsa.c         | 272 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 272 insertions(+), 1 deletion(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index a32b75c387..ca78b06069 100644
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
index 8e78215903..5c4821e23e 100644
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
@@ -387,6 +398,263 @@ submit_batch_wi_async(QemuDsaBatchTask *batch_task)
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
@@ -394,7 +662,7 @@ submit_batch_wi_async(QemuDsaBatchTask *batch_task)
  */
 bool qemu_dsa_is_running(void)
 {
-    return false;
+    return completion_thread.running;
 }
 
 static void
@@ -435,6 +703,7 @@ void qemu_dsa_start(void)
         return;
     }
     dsa_device_group_start(&dsa_group);
+    dsa_completion_thread_init(&completion_thread, &dsa_group);
 }
 
 /**
@@ -449,6 +718,7 @@ void qemu_dsa_stop(void)
         return;
     }
 
+    dsa_completion_thread_stop(&completion_thread);
     dsa_empty_task_queue(group);
 }
 
-- 
Yichen Wang


