Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B96E7716C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIesE-00044V-3b; Tue, 03 Dec 2024 21:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIesB-000432-Sb
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:12:15 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIesA-0005RV-15
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:12:15 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6d89811946eso27480876d6.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 18:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1733278333; x=1733883133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmWLJIQJ8N12JbkkyHiQfgxCXrtZm1tXnIWK6/dvu9s=;
 b=lQQPDHhnUCgHncdQhg8apmo7tBYPOVxPxI1/LRzMDnagxoYeG7PPPbuhJfq+jCUSvA
 3AVA5MWOAlj41GHEniIE6pjy6kkX4o1iCJnQ+aDj77gZlfl1+fXZtrIici1CvMm3owsH
 9dXQVo00KHR7QSNMs/jy/+yaIow/tY3zU2Kxxity1M7TiIe4vRzpxEG69UJdV/B/kyR4
 vXSTkauOjpuWkL0JZ7/SNOyBICNFhUOdCWBmInRwvFb+00w4FsvWItf3Vi6dGe6HlKpI
 HqYuc0O/KwI5/7je3V7lQmtS9gQYvTXL8hcmXRTUgDhCq+iTaetPltoN/KMuI2ywxhcI
 y8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733278333; x=1733883133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmWLJIQJ8N12JbkkyHiQfgxCXrtZm1tXnIWK6/dvu9s=;
 b=Kevd8nOP83yVSgD8L3IYbCDU7mzpLn9t9OM1EIUO6MNHXivjeQeQvEEKCCRKaq/pM/
 z8KplDuphLEpRoUKV5p3SCtFyxsdJWvDdersVyO6zD3hxex1gN1dkPdZ+4TmhCcBkT+w
 4uDXYzal29YByqqzbVtlEQVnMj+oQpQS9btDrqUVA8mwnAbFQ2tCzgAjMjam13UwtpqK
 r+4J7i8bvvlQEOFJN43HB+RezthS4qJPPeq6QB5KvHXu9Am+4y2+7GHSFOye3Y0aPagT
 ofSV+CCVp+Z68Uig5R6FinsaBQTMKSCCFsAYUvbCcEqqg5DzH5IaokwpHDTGAjOpFUxn
 Ysjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9RoIZA5nBOjfFzHmpYwwK/adOOhVgp3UJAbqCOCR/OLNkH4TYkt3PEgp2gMwOdV4jjv9/9UWONTDD@nongnu.org
X-Gm-Message-State: AOJu0YwqRv4N0OuL2jiKVHgTLKlhm1GuUBwE72uiPwYWV7OaBqHNxwJl
 wDx/6QeqRDIWcEwilju+suWIMqtwgZsffPxh8exrYw8y05YEE++3grk/UW+cV2Y=
X-Gm-Gg: ASbGncv++dZ7ol4uPZU5Oz/GivXigeBUj2shwMFQlkRZWUd2gyR1wqDO5SqCf9PcXve
 xGjjpA03gTDq1ufizNxxFQ4Eivd+hRZAnYFtQLmYIIEiHG3RXCYRYiRDq/YUW6tTHvFLQqRUVo7
 Aii/mDk3v5OdAve9w/UY3fhqeZNpWA6nnluL6QVALa+nQmuTse4/5SEoAz48i/xU3bl6XIkmtog
 +9wbpgpAkoiUKjhfsgn1XxkGPdRU1NkNJULQCUfHtoanJ4XnnJ0s9UNPsp35i/HEJg6x6eP23Vw
 rnbUNZLDIfjNS34ZtA==
X-Google-Smtp-Source: AGHT+IH4HNXO428Jp9onbiLf0da8k0EgfQ8EREF6TkS7WE68vEyOY4euq/SBf9OcpEyOcGMaj4EuRQ==
X-Received: by 2002:a05:6214:1312:b0:6d8:af66:6344 with SMTP id
 6a1803df08f44-6d8c443d31fmr45981306d6.2.1733278332962; 
 Tue, 03 Dec 2024 18:12:12 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:323:644e:288b:2b6d:d94c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d87ec537ebsm63488986d6.30.2024.12.03.18.12.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 18:12:12 -0800 (PST)
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
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v8 07/12] util/dsa: Implement DSA task asynchronous submission
 and wait for completion.
Date: Tue,  3 Dec 2024 18:11:36 -0800
Message-Id: <20241204021142.24184-8-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241204021142.24184-1-yichen.wang@bytedance.com>
References: <20241204021142.24184-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2e.google.com
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
index a9aa394e5b..4972332bdf 100644
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
index a897ccac90..e6b7db2cf6 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -433,6 +433,42 @@ poll_completion(struct dsa_completion_record *completion,
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
@@ -559,7 +595,7 @@ dsa_completion_loop(void *opaque)
         (QemuDsaCompletionThread *)opaque;
     QemuDsaBatchTask *batch_task;
     QemuDsaDeviceGroup *group = thread_context->group;
-    int ret;
+    int ret = 0;
 
     rcu_register_thread();
 
@@ -827,7 +863,6 @@ buffer_zero_batch_task_set(QemuDsaBatchTask *batch_task,
  *
  * @return int Zero if successful, otherwise an appropriate error code.
  */
-__attribute__((unused))
 static int
 buffer_zero_dsa_async(QemuDsaBatchTask *task,
                       const void *buf, size_t len)
@@ -846,7 +881,6 @@ buffer_zero_dsa_async(QemuDsaBatchTask *task,
  * @param count The number of buffers.
  * @param len The buffer length.
  */
-__attribute__((unused))
 static int
 buffer_zero_dsa_batch_async(QemuDsaBatchTask *batch_task,
                             const void **buf, size_t count, size_t len)
@@ -877,13 +911,61 @@ buffer_zero_dsa_completion(void *context)
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
@@ -960,3 +1042,38 @@ buffer_zero_batch_task_destroy(QemuDsaBatchTask *task)
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
+    assert(batch_task != NULL);
+    assert(len != 0);
+    assert(buf != NULL);
+
+    if (count <= 0 || count > batch_task->batch_size) {
+        return -1;
+    }
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


