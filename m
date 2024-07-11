Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D3AC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1iv-0004Sk-Tn; Thu, 11 Jul 2024 17:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1iu-0004MX-8q
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:08 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1is-0005aB-Cq
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:08 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7036ab4a2acso695418a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720734785; x=1721339585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9m458/uhhAXId9laqR5q13dVQY2eOCevIh5lPaBzFwg=;
 b=ZJujagfH6RLfJsb/WC/5sO42CQKOE6uATjzbdgwn9kzbyWxoUM0gS7Lyt5PE5zMV/t
 ik4A8Oq3pN7EyxOJSSvj37x2WmI4d9nP4N/xP4hWFzCiwzV4TrM7VXkQi13ajSmp5rXk
 92phYR0Fx3e3YKsf4GXblevlYeHIEHPv0qhwQMKPIXik45y+m4iTwkwp/JxOzoZ8tTL6
 OzrMSe3bU9I3hZhBWXxy9e2l9RPR8Fx3Td0T2x+eesv7MqfsdriX+CG2a2Ua3CzoEZfu
 9gkHL/sr2Bb7Tr1IjbIr58EhoeNuVG+9DSm/6SELIA+gGAIzd5f4I8N+SoNXEiMLrO5f
 blKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720734785; x=1721339585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9m458/uhhAXId9laqR5q13dVQY2eOCevIh5lPaBzFwg=;
 b=pFQHpPq3bRK9G8QPJsvJKx4yaEzm8GkK40ffmzpe5h3WV/o2uyr5/sIzvCGjc25VoN
 gYSPWmkFJ0Hohfq8qGoKvEC+awDHB7qCb4Lyp2PGanQIqk7ogcXYkk/DSZFCbTxznIH6
 YfSeLqPpCyQFpjdFU00L7sIobmveCjo3Az+rZD69Eau/Udt13lfaBQSnZ0WHfYEAngoN
 BJ51wH58Ufia89hT0KxjGsCe1NPl34QhfqLi3H9NsVEHG3RbHiAlivJjl3wvC9SMOWr+
 DmVuLEDFOEX1F2kJHlgXNwB4asBFlg8bKC5cU+PTkLA2iuYPu/XS6eMiYpJ4Y7aqSGsv
 gB8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGMpEWsd4z/EiUSrx0fgMvzVw/KFhTNAXKAgxrzCNTtb/mYPsrD35cOrRsOJ2o+g195yx5g3YLlyhPLWIyGN2whwSQNmM=
X-Gm-Message-State: AOJu0YzfcBOfCR9hjG+iOXoijg2V+3F7OHn2QFPPKicyTwxtQJF3Y+u6
 AAL/hmYUzu2iddFEtcCAyHsi6o/Xm1dI1iOx/3sAqVZAu0z94KIZOukDdsOyDWgUP62wtDS7VZW
 M
X-Google-Smtp-Source: AGHT+IGfge220JKGhpa1aVvmXZTMP7C5bj467mbmfAjwUFGjU6QSaq8JXgcvTSLMtk2UF4LQgoDKsw==
X-Received: by 2002:a05:6830:1389:b0:703:68ff:c078 with SMTP id
 46e09a7af769-70375b4d1b8mr10711216a34.30.1720734785219; 
 Thu, 11 Jul 2024 14:53:05 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7044ac2876dsm713125a34.2.2024.07.11.14.53.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 14:53:04 -0700 (PDT)
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
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v5 07/13] util/dsa: Implement DSA task asynchronous submission
 and wait for completion.
Date: Thu, 11 Jul 2024 14:52:42 -0700
Message-Id: <20240711215244.19237-8-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711215244.19237-1-yichen.wang@bytedance.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=yichen.wang@bytedance.com; helo=mail-ot1-x32f.google.com
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
index 1b4baf1c80..20bb88d48c 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -123,6 +123,20 @@ buffer_zero_batch_task_init(QemuDsaBatchTask *task,
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
 
 static inline bool qemu_dsa_is_running(void)
diff --git a/util/dsa.c b/util/dsa.c
index f0d8cce210..74b9aa1331 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -439,6 +439,42 @@ poll_completion(struct dsa_completion_record *completion,
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
@@ -567,7 +603,7 @@ dsa_completion_loop(void *opaque)
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
  * @brief Check if DSA is running.
  *
@@ -956,3 +1038,38 @@ void qemu_dsa_cleanup(void)
     dsa_device_group_cleanup(&dsa_group);
 }
 
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
+
-- 
Yichen Wang


