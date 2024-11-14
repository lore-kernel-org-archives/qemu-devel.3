Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05969D6A248
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 22:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBhuv-0003Ss-8i; Thu, 14 Nov 2024 17:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhuj-0003Qb-5O
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:02:09 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhug-0007gY-S4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:02:08 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b15d7b7a32so70987885a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 14:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1731621726; x=1732226526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhcJa+cHhe6ao2Bt0/MyVwDuA8e0xe0uuQoaXDZtjb0=;
 b=Kjmqv/YtT8K9OEfrLZh8TWQ0uw5D1YQ38Ofn+ZkI514bBdAryHK+MopkA2sauz1eRD
 /LVCzwoSS8srsiFMfq7uBpVeT62MOPYD5xIlPuMaLNmhkLh772m8uxFyPBP23p90cudJ
 9BpxwDbVSegPzOWYLEJl4vR85SsG+5j66l4pdOMs2+p5sf4f2MLrULhIE7YpUNfPV4dA
 WRG9NCiNwai6nw+X21vg9gpCo/NEksj0OfzXQh+YLRuWgujjyAF1D8RMfxw1r8O6e9lT
 YlqHIwfro2eZzNVPDxLoa5oQANgvXY3a+Z6U1Ipa6uiR5iYEB+2+fdc+q1/dqjQHx+/7
 3xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731621726; x=1732226526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhcJa+cHhe6ao2Bt0/MyVwDuA8e0xe0uuQoaXDZtjb0=;
 b=JbJK2Ecb18IcfEJFQGgEd8izY2ogt9vQq7P2VG3yBkevas61+63j2Aj5EjRwkyQH7D
 mQqr0Pilmnibgz7agBgO7wBSJWjraQqJIHYJoenh8fzV0fWfKZoX0t9VskKGw+2IJqpd
 RA7/QwX71MSYxffjh5WAJ817h6REOZXXljKOE467zriDdvxR8J7C7UokS7D5FPcUfi6/
 KKRsULNmiWeOGpCSYalbUnEp1Yvn1E4YbrHdGIMMTpZacYgTYXNsrGw3liUvFb9wzBID
 /bazJPioO3PedXbIc8zNaTmQqSswFpyzNNv4nPHAE9gvv/1mfvaealx+5Ouw1UaQISYj
 96uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXySaiB+vBsRmi2WEP+CdLI+jPvVLVlEC8utfkGCVJbXZ/xn3wmk2hnQJ7cdaSGdWsx/Hai+35H8P5@nongnu.org
X-Gm-Message-State: AOJu0YwsFD4W+yrTY7SfcbzH8YFnRcVjur5cG/Om/2SLp7Cq/qILb0RG
 ypf9XqVY5sJkIApE9NL7yDVhPAux616a9k5f88ij+gRKWBpNoshuXqsJyD1mnT8=
X-Google-Smtp-Source: AGHT+IG8Osu4O0Qf6cch2QqQccsUCbzX9k72LIQ/bVUgnUwqxDN+O9q2qFg8Wue4Uqc/gWfd3ZRsRw==
X-Received: by 2002:a05:620a:2402:b0:7a9:b250:d57b with SMTP id
 af79cd13be357-7b362298c94mr66572685a.5.1731621725643; 
 Thu, 14 Nov 2024 14:02:05 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net ([130.44.212.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca308bdsm93742485a.83.2024.11.14.14.02.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 14:02:05 -0800 (PST)
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
Subject: [PATCH v7 10/12] util/dsa: Add unit test coverage for Intel DSA task
 submission and completion.
Date: Thu, 14 Nov 2024 14:01:30 -0800
Message-Id: <20241114220132.27399-11-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241114220132.27399-1-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qk1-x735.google.com
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

* Test DSA start and stop path.
* Test DSA configure and cleanup path.
* Test DSA task submission and completion path.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 tests/unit/meson.build |   6 +
 tests/unit/test-dsa.c  | 503 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 509 insertions(+)
 create mode 100644 tests/unit/test-dsa.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d5248ae51d..394219e903 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -50,6 +50,12 @@ tests = {
   'test-fifo': [],
 }
 
+if config_host_data.get('CONFIG_DSA_OPT')
+  tests += {
+    'test-dsa': [],
+  }
+endif
+
 if have_system or have_tools
   tests += {
     'test-qmp-event': [testqapi],
diff --git a/tests/unit/test-dsa.c b/tests/unit/test-dsa.c
new file mode 100644
index 0000000000..181a547528
--- /dev/null
+++ b/tests/unit/test-dsa.c
@@ -0,0 +1,503 @@
+/*
+ * Test DSA functions.
+ *
+ * Copyright (C) Bytedance Ltd.
+ *
+ * Authors:
+ *  Hao Xiang <hao.xiang@bytedance.com>
+ *  Bryan Zhang <bryan.zhang@bytedance.com>
+ *  Yichen Wang <yichen.wang@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+
+#include "qemu/cutils.h"
+#include "qemu/memalign.h"
+#include "qemu/dsa.h"
+
+/*
+ * TODO Communicate that DSA must be configured to support this batch size.
+ * TODO Alternatively, poke the DSA device to figure out batch size.
+ */
+#define batch_size 128
+#define page_size 4096
+
+#define oversized_batch_size (batch_size + 1)
+#define num_devices 2
+#define max_buffer_size (64 * 1024)
+
+/* TODO Make these not-hardcoded. */
+static const strList path1[] = {
+    {.value = (char *)"/dev/dsa/wq4.0", .next = NULL}
+};
+static const strList path2[] = {
+    {.value = (char *)"/dev/dsa/wq4.0", .next = (strList*)&path2[1]},
+    {.value = (char *)"/dev/dsa/wq4.1", .next = NULL}
+};
+
+static Error **errp;
+
+static QemuDsaBatchTask *task;
+
+/* A helper for running a single task and checking for correctness. */
+static void do_single_task(void)
+{
+    task = buffer_zero_batch_task_init(batch_size);
+    char buf[page_size];
+    char *ptr = buf;
+
+    buffer_is_zero_dsa_batch_sync(task,
+                                  (const void **)&ptr,
+                                  1,
+                                  page_size);
+    g_assert(task->results[0] == buffer_is_zero(buf, page_size));
+
+    buffer_zero_batch_task_destroy(task);
+}
+
+static void test_single_zero(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    task = buffer_zero_batch_task_init(batch_size);
+
+    char buf[page_size];
+    char *ptr = buf;
+
+    memset(buf, 0x0, page_size);
+    buffer_is_zero_dsa_batch_sync(task,
+                                  (const void **)&ptr,
+                                  1, page_size);
+    g_assert(task->results[0]);
+
+    buffer_zero_batch_task_destroy(task);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_single_zero_async(void)
+{
+    test_single_zero();
+}
+
+static void test_single_nonzero(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    task = buffer_zero_batch_task_init(batch_size);
+
+    char buf[page_size];
+    char *ptr = buf;
+
+    memset(buf, 0x1, page_size);
+    buffer_is_zero_dsa_batch_sync(task,
+                                  (const void **)&ptr,
+                                  1, page_size);
+    g_assert(!task->results[0]);
+
+    buffer_zero_batch_task_destroy(task);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_single_nonzero_async(void)
+{
+    test_single_nonzero();
+}
+
+/* count == 0 should return quickly without calling into DSA. */
+static void test_zero_count_async(void)
+{
+    char buf[page_size];
+    buffer_is_zero_dsa_batch_sync(task,
+                                  (const void **)&buf,
+                                  0,
+                                  page_size);
+}
+
+static void test_null_task_async(void)
+{
+    if (g_test_subprocess()) {
+        g_assert(!qemu_dsa_init(path1, errp));
+
+        char buf[page_size * batch_size];
+        char *addrs[batch_size];
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf + (page_size * i);
+        }
+
+        buffer_is_zero_dsa_batch_sync(NULL, (const void **)addrs,
+                                      batch_size,
+                                      page_size);
+    } else {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_failed();
+    }
+}
+
+static void test_oversized_batch(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    task = buffer_zero_batch_task_init(batch_size);
+
+    char buf[page_size * oversized_batch_size];
+    char *addrs[batch_size];
+    for (int i = 0; i < oversized_batch_size; i++) {
+        addrs[i] = buf + (page_size * i);
+    }
+
+    int ret = buffer_is_zero_dsa_batch_sync(task,
+                                            (const void **)addrs,
+                                            oversized_batch_size,
+                                            page_size);
+    g_assert(ret != 0);
+
+    buffer_zero_batch_task_destroy(task);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_oversized_batch_async(void)
+{
+    test_oversized_batch();
+}
+
+static void test_zero_len_async(void)
+{
+    if (g_test_subprocess()) {
+        g_assert(!qemu_dsa_init(path1, errp));
+
+        task = buffer_zero_batch_task_init(batch_size);
+
+        char buf[page_size];
+
+        buffer_is_zero_dsa_batch_sync(task,
+                                      (const void **)&buf,
+                                      1,
+                                      0);
+
+        buffer_zero_batch_task_destroy(task);
+    } else {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_failed();
+    }
+}
+
+static void test_null_buf_async(void)
+{
+    if (g_test_subprocess()) {
+        g_assert(!qemu_dsa_init(path1, errp));
+
+        task = buffer_zero_batch_task_init(batch_size);
+
+        buffer_is_zero_dsa_batch_sync(task, NULL, 1, page_size);
+
+        buffer_zero_batch_task_destroy(task);
+    } else {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_failed();
+    }
+}
+
+static void test_batch(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    task = buffer_zero_batch_task_init(batch_size);
+
+    char buf[page_size * batch_size];
+    char *addrs[batch_size];
+    for (int i = 0; i < batch_size; i++) {
+        addrs[i] = buf + (page_size * i);
+    }
+
+    /*
+     * Using whatever is on the stack is somewhat random.
+     * Manually set some pages to zero and some to nonzero.
+     */
+    memset(buf + 0, 0, page_size * 10);
+    memset(buf + (10 * page_size), 0xff, page_size * 10);
+
+    buffer_is_zero_dsa_batch_sync(task,
+                                  (const void **)addrs,
+                                  batch_size,
+                                  page_size);
+
+    bool is_zero;
+    for (int i = 0; i < batch_size; i++) {
+        is_zero = buffer_is_zero((const void *)&buf[page_size * i], page_size);
+        g_assert(task->results[i] == is_zero);
+    }
+
+    buffer_zero_batch_task_destroy(task);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_batch_async(void)
+{
+    test_batch();
+}
+
+static void test_page_fault(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    char *buf[2];
+    int prot = PROT_READ | PROT_WRITE;
+    int flags = MAP_SHARED | MAP_ANON;
+    buf[0] = (char *)mmap(NULL, page_size * batch_size, prot, flags, -1, 0);
+    assert(buf[0] != MAP_FAILED);
+    buf[1] = (char *)malloc(page_size * batch_size);
+    assert(buf[1] != NULL);
+
+    for (int j = 0; j < 2; j++) {
+        task = buffer_zero_batch_task_init(batch_size);
+
+        char *addrs[batch_size];
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf[j] + (page_size * i);
+        }
+
+        buffer_is_zero_dsa_batch_sync(task,
+                                      (const void **)addrs,
+                                      batch_size,
+                                      page_size);
+
+        bool is_zero;
+        for (int i = 0; i < batch_size; i++) {
+            is_zero = buffer_is_zero((const void *)&buf[j][page_size * i],
+                                      page_size);
+            g_assert(task->results[i] == is_zero);
+        }
+        buffer_zero_batch_task_destroy(task);
+    }
+
+    assert(!munmap(buf[0], page_size * batch_size));
+    free(buf[1]);
+    qemu_dsa_cleanup();
+}
+
+static void test_various_buffer_sizes(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    char *buf = malloc(max_buffer_size * batch_size);
+    char *addrs[batch_size];
+
+    for (int len = 16; len <= max_buffer_size; len *= 2) {
+        task = buffer_zero_batch_task_init(batch_size);
+
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf + (len * i);
+        }
+
+        buffer_is_zero_dsa_batch_sync(task,
+                                      (const void **)addrs,
+                                      batch_size,
+                                      len);
+
+        bool is_zero;
+        for (int j = 0; j < batch_size; j++) {
+            is_zero = buffer_is_zero((const void *)&buf[len * j], len);
+            g_assert(task->results[j] == is_zero);
+        }
+
+        buffer_zero_batch_task_destroy(task);
+    }
+
+    free(buf);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_various_buffer_sizes_async(void)
+{
+    test_various_buffer_sizes();
+}
+
+static void test_double_start_stop(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    /* Double start */
+    qemu_dsa_start();
+    qemu_dsa_start();
+    g_assert(qemu_dsa_is_running());
+    do_single_task();
+
+    /* Double stop */
+    qemu_dsa_stop();
+    g_assert(!qemu_dsa_is_running());
+    qemu_dsa_stop();
+    g_assert(!qemu_dsa_is_running());
+
+    /* Restart */
+    qemu_dsa_start();
+    g_assert(qemu_dsa_is_running());
+    do_single_task();
+    qemu_dsa_cleanup();
+}
+
+static void test_is_running(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+
+    g_assert(!qemu_dsa_is_running());
+    qemu_dsa_start();
+    g_assert(qemu_dsa_is_running());
+    qemu_dsa_stop();
+    g_assert(!qemu_dsa_is_running());
+    qemu_dsa_cleanup();
+}
+
+static void test_multiple_engines(void)
+{
+    g_assert(!qemu_dsa_init(path2, errp));
+    qemu_dsa_start();
+
+    QemuDsaBatchTask *tasks[num_devices];
+    char bufs[num_devices][page_size * batch_size];
+    char *addrs[num_devices][batch_size];
+
+    /*
+     *  This is a somewhat implementation-specific way
+     *  of testing that the tasks have unique engines
+     *  assigned to them.
+     */
+    tasks[0] = buffer_zero_batch_task_init(batch_size);
+    tasks[1] = buffer_zero_batch_task_init(batch_size);
+    g_assert(tasks[0]->device != tasks[1]->device);
+
+    for (int i = 0; i < num_devices; i++) {
+        for (int j = 0; j < batch_size; j++) {
+            addrs[i][j] = bufs[i] + (page_size * j);
+        }
+
+        buffer_is_zero_dsa_batch_sync(tasks[i],
+                                      (const void **)addrs[i],
+                                      batch_size, page_size);
+
+        bool is_zero;
+        for (int j = 0; j < batch_size; j++) {
+            is_zero = buffer_is_zero((const void *)&bufs[i][page_size * j],
+                                     page_size);
+            g_assert(tasks[i]->results[j] == is_zero);
+        }
+    }
+
+    buffer_zero_batch_task_destroy(tasks[0]);
+    buffer_zero_batch_task_destroy(tasks[1]);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_configure_dsa_twice(void)
+{
+    g_assert(!qemu_dsa_init(path2, errp));
+    g_assert(!qemu_dsa_init(path2, errp));
+    qemu_dsa_start();
+    do_single_task();
+    qemu_dsa_cleanup();
+}
+
+static void test_configure_dsa_bad_path(void)
+{
+    const strList *bad_path = &(strList) {
+        .value = (char *)"/not/a/real/path", .next = NULL
+    };
+    g_assert(qemu_dsa_init(bad_path, errp));
+}
+
+static void test_cleanup_before_configure(void)
+{
+    qemu_dsa_cleanup();
+    g_assert(!qemu_dsa_init(path2, errp));
+}
+
+static void test_configure_dsa_num_devices(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    do_single_task();
+    qemu_dsa_stop();
+    qemu_dsa_cleanup();
+}
+
+static void test_cleanup_twice(void)
+{
+    g_assert(!qemu_dsa_init(path2, errp));
+    qemu_dsa_cleanup();
+    qemu_dsa_cleanup();
+
+    g_assert(!qemu_dsa_init(path2, errp));
+    qemu_dsa_start();
+    do_single_task();
+    qemu_dsa_cleanup();
+}
+
+static int check_test_setup(void)
+{
+    const strList *path[2] = {path1, path2};
+    for (int i = 0; i < sizeof(path) / sizeof(strList *); i++) {
+        if (qemu_dsa_init(path[i], errp)) {
+            return -1;
+        }
+        qemu_dsa_cleanup();
+    }
+    return 0;
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (check_test_setup() != 0) {
+        /*
+         * This test requires extra setup. The current
+         * setup is not correct. Just skip this test
+         * for now.
+         */
+        exit(0);
+    }
+
+    if (num_devices > 1) {
+        g_test_add_func("/dsa/multiple_engines", test_multiple_engines);
+    }
+
+    g_test_add_func("/dsa/async/batch", test_batch_async);
+    g_test_add_func("/dsa/async/various_buffer_sizes",
+                    test_various_buffer_sizes_async);
+    g_test_add_func("/dsa/async/null_buf", test_null_buf_async);
+    g_test_add_func("/dsa/async/zero_len", test_zero_len_async);
+    g_test_add_func("/dsa/async/oversized_batch", test_oversized_batch_async);
+    g_test_add_func("/dsa/async/zero_count", test_zero_count_async);
+    g_test_add_func("/dsa/async/single_zero", test_single_zero_async);
+    g_test_add_func("/dsa/async/single_nonzero", test_single_nonzero_async);
+    g_test_add_func("/dsa/async/null_task", test_null_task_async);
+    g_test_add_func("/dsa/async/page_fault", test_page_fault);
+
+    g_test_add_func("/dsa/double_start_stop", test_double_start_stop);
+    g_test_add_func("/dsa/is_running", test_is_running);
+
+    g_test_add_func("/dsa/configure_dsa_twice", test_configure_dsa_twice);
+    g_test_add_func("/dsa/configure_dsa_bad_path", test_configure_dsa_bad_path);
+    g_test_add_func("/dsa/cleanup_before_configure",
+                    test_cleanup_before_configure);
+    g_test_add_func("/dsa/configure_dsa_num_devices",
+                    test_configure_dsa_num_devices);
+    g_test_add_func("/dsa/cleanup_twice", test_cleanup_twice);
+
+    return g_test_run();
+}
-- 
Yichen Wang


