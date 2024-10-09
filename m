Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA1DCEDDA6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygPM-000340-1Z; Wed, 09 Oct 2024 19:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPK-00033H-5H
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:47:54 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPI-0006e6-CG
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:47:53 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-460414d5250so1071111cf.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728517670; x=1729122470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smtARH6HYgdJtrl2FWYeE5W3midpBOU+64GAZEvxYdY=;
 b=Mw69cmn6ybdHl7v6R4X8fqy8IViaB6bouOopSLJl0hFcn0LMHxwrOQDkSZcEJuxGmr
 Y1EMBCKkQGtNU9BrGwihb08/+mBYubbnkOe4aUFZGIE+03KjszqOPmDqeoj7cYFQnhQI
 jKhr9s4N6Vu2Wp98aRxDbRDEk/BeCRvn8UjWf87pHIhBE2Ei/LKkUUiaEjLfldFLFaeC
 HDBWOTJKYjBDW/wM3edu9oJeaHhDV8DF12j8jrZWboU08P5EGr8aIiyqhccKDHJ0g+Dl
 hWfPMtkcdfIG/Uu7hHfKxhZSZm9Oy3bgbIEd41/97xUPAPPquCHZ1ijfLXQB7wbp/ta8
 uYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728517670; x=1729122470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=smtARH6HYgdJtrl2FWYeE5W3midpBOU+64GAZEvxYdY=;
 b=myQ9dBld9uIfoSqnmBKMs54W3o3aEpKEEvm6qOqACCG+6Kvv6zTGWKDmCcLTjDzkHV
 XganzjcgpkcdNCB+3bkXDm8tPNcjAD4XbyWaYlx9oB5cYHHiELU0LDTghwDj/HY1Kmpi
 d/A4XCDXb/7hBpuefhol8jl/0Op+Zfnk3ZyN8DdoYjySan1AOwA3w/L8m4smO4kfZYOm
 0SwcpaXNmVzMrpL37mZAYHHYcD7z/qAR8UlLAx4k6cexAeSRxx6P/Cv4S8CTzskWGg5I
 yM/ak11k+ILumouAoKIftzdZOHABH/iqkcvUjc2aRcqxYyz4RMFLec3863YH7q3aHLxq
 7v/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDkFfkzV7FvAt8vsY1EXo339iZpM8rHcZFkJHWXj7iO0ZY3rcI8KwPEW6T3uNqYyuaAd4Hr8Oqpa7W@nongnu.org
X-Gm-Message-State: AOJu0YxQgT+GVfxo8G864d1JLplPsVL0D01CUFVuVjcf7ExMfX6CRPIP
 WwQNCu6R5/YhNYVcJsMMbi9/dU7M57Cb3OlTIEYwVcQkB8hD88bEg4mW8DlO7aU=
X-Google-Smtp-Source: AGHT+IHkfDL8BsEP2++RGoxorCQCEq++h1PQWkbsHGkQnPI+avOSYCFxCEsB3+HgNU9BvN0VHUx8Kg==
X-Received: by 2002:a05:6214:5d8b:b0:6cb:8267:e285 with SMTP id
 6a1803df08f44-6cbc91f4d0dmr44132516d6.0.1728517670382; 
 Wed, 09 Oct 2024 16:47:50 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([2605:a7c0:0:301::44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85d856fsm264386d6.72.2024.10.09.16.47.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Oct 2024 16:47:50 -0700 (PDT)
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
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v6 07/12] util/dsa: Implement DSA task asynchronous submission
 and wait for completion.
Date: Wed,  9 Oct 2024 16:46:05 -0700
Message-Id: <20241009234610.27039-8-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009234610.27039-1-yichen.wang@bytedance.com>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qt1-x830.google.com
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

* Add a DSA task completion callback.
* DSA completion thread will call the tasks's completion callback
on every task/batch task completion.
* DSA submission path to wait for completion.
* Implement CPU fallback if DSA is not able to complete the task.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 include/qemu/dsa.h |  14 +++++
 util/dsa.c         | 125 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index 89841a6ffa..a3b502ee41 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -123,6 +123,20 @@ buffer_zero_batch_task_init(int batch_size);
  */
 void buffer_zero_batch_task_destroy(QemuDsaBatchTask *task);
 
+/**
+ * @brief Performs buffer zero comparison on a DSA batch task synchronously.
+ *
+ * @param batch_task A pointer to the batch task.
+ * @param buf An array of memory buffers.
+ * @param count The number of buffers in the array.
+ * @param len The buffer length.
+ *
+ * @return Zero if successful, otherwise non-zero.
+ */
+int
+buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batch_task,
+                              const void **buf, size_t count, size_t len);
+
 #else
 
 typedef struct QemuDsaBatchTask {} QemuDsaBatchTask;
diff --git a/util/dsa.c b/util/dsa.c
index d9c066ff00..cbaa47c360 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -435,6 +435,42 @@ poll_completion(struct dsa_completion_record *completion,
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
 /**
  * @brief Complete a single DSA task in the batch task.
  *
@@ -563,7 +599,7 @@ dsa_completion_loop(void *opaque)
         (QemuDsaCompletionThread *)opaque;
     QemuDsaBatchTask *batch_task;
     QemuDsaDeviceGroup *group = thread_context->group;
-    int ret;
+    int ret = 0;
 
     rcu_register_thread();
 
@@ -831,7 +867,6 @@ buffer_zero_batch_task_set(QemuDsaBatchTask *batch_task,
  *
  * @return int Zero if successful, otherwise an appropriate error code.
  */
-__attribute__((unused))
 static int
 buffer_zero_dsa_async(QemuDsaBatchTask *task,
                       const void *buf, size_t len)
@@ -850,7 +885,6 @@ buffer_zero_dsa_async(QemuDsaBatchTask *task,
  * @param count The number of buffers.
  * @param len The buffer length.
  */
-__attribute__((unused))
 static int
 buffer_zero_dsa_batch_async(QemuDsaBatchTask *batch_task,
                             const void **buf, size_t count, size_t len)
@@ -881,13 +915,61 @@ buffer_zero_dsa_completion(void *context)
  *
  * @param batch_task A pointer to the buffer zero comparison batch task.
  */
-__attribute__((unused))
 static void
 buffer_zero_dsa_wait(QemuDsaBatchTask *batch_task)
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
+buffer_zero_cpu_fallback(QemuDsaBatchTask *batch_task)
+{
+    if (batch_task->task_type == QEMU_DSA_TASK) {
+        if (batch_task->completions[0].status == DSA_COMP_SUCCESS) {
+            return;
+        }
+        task_cpu_fallback_int(&batch_task->completions[0],
+                              &batch_task->descriptors[0],
+                              &batch_task->results[0]);
+    } else if (batch_task->task_type == QEMU_DSA_BATCH_TASK) {
+        struct dsa_completion_record *batch_completion =
+            &batch_task->batch_completion;
+        struct dsa_completion_record *completion;
+        uint8_t status;
+        bool *results = batch_task->results;
+        uint32_t count = batch_task->batch_descriptor.desc_count;
+
+        /* DSA is able to complete the entire batch task. */
+        if (batch_completion->status == DSA_COMP_SUCCESS) {
+            assert(count == batch_completion->bytes_completed);
+            return;
+        }
+
+        /*
+         * DSA encounters some error and is not able to complete
+         * the entire batch task. Use CPU fallback.
+         */
+        for (int i = 0; i < count; i++) {
+
+            completion = &batch_task->completions[i];
+            status = completion->status;
+
+            assert(status == DSA_COMP_SUCCESS ||
+                status == DSA_COMP_PAGE_FAULT_NOBOF);
+
+            task_cpu_fallback_int(completion,
+                                  &batch_task->descriptors[i],
+                                  &results[i]);
+        }
+    }
+}
+
 /**
  * @brief Initializes a buffer zero comparison DSA task.
  *
@@ -964,3 +1046,38 @@ buffer_zero_batch_task_destroy(QemuDsaBatchTask *task)
     qemu_sem_destroy(&task->sem_task_complete);
     qemu_vfree(task);
 }
+
+/**
+ * @brief Performs buffer zero comparison on a DSA batch task synchronously.
+ *
+ * @param batch_task A pointer to the batch task.
+ * @param buf An array of memory buffers.
+ * @param count The number of buffers in the array.
+ * @param len The buffer length.
+ *
+ * @return Zero if successful, otherwise non-zero.
+ */
+int
+buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batch_task,
+                              const void **buf, size_t count, size_t len)
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
-- 
Yichen Wang


