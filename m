Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB11C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzolI-0000b1-Oo; Wed, 24 Apr 2024 22:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzolF-0000aV-DM
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:57 -0400
Received: from out-181.mta1.migadu.com ([95.215.58.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzolC-0005fm-Nu
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:57 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1714011773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0crJNuoW+nW3d0lLEukaZUR839qcrFK+o9JwkG0Mflg=;
 b=H84vlzX4x67rGXD6UaZWaGYvvHJqklyIf1Eov+2GgWitImODoNFhHfnqG7NWyBiuoJZYqr
 DGYBnIQ4P1fLuMJw3yxtWKkaIKCEwQGR/FQ+FOfjF7HsEyjnFTKeiYAt5Qh3Msdp0fpCas
 bgJK4OJCs9U4uWg1HQbCipgqvGxg6uk=
From: Hao Xiang <hao.xiang@linux.dev>
To: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>,
	Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v4 13/14] util/dsa: Add unit test coverage for Intel DSA task
 submission and completion.
Date: Thu, 25 Apr 2024 02:21:16 +0000
Message-Id: <20240425022117.4035031-14-hao.xiang@linux.dev>
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

* Test DSA start and stop path.
* Test DSA configure and cleanup path.
* Test DSA task submission and completion path.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
 tests/unit/meson.build |   6 +
 tests/unit/test-dsa.c  | 499 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 505 insertions(+)
 create mode 100644 tests/unit/test-dsa.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 26c109c968..1d4d48898b 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -49,6 +49,12 @@ tests = {
   'test-interval-tree': [],
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
index 0000000000..0f2092767d
--- /dev/null
+++ b/tests/unit/test-dsa.c
@@ -0,0 +1,499 @@
+/*
+ * Test DSA functions.
+ *
+ * Copyright (c) 2023 Hao Xiang <hao.xiang@bytedance.com>
+ * Copyright (c) 2023 Bryan Zhang <bryan.zhang@bytedance.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
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
+static const char *path1 = "/dev/dsa/wq4.0";
+static const char *path2 = "/dev/dsa/wq4.0 /dev/dsa/wq4.1";
+
+static struct batch_task *task;
+
+/* A helper for running a single task and checking for correctness. */
+static void do_single_task(void)
+{
+    task = batch_task_init(batch_size);
+    char buf[page_size];
+    char *ptr = buf;
+
+    buffer_is_zero_dsa_batch_async(task,
+                                   (const void **)&ptr,
+                                   1,
+                                   page_size);
+    g_assert(task->results[0] == buffer_is_zero(buf, page_size));
+
+    batch_task_destroy(task);
+}
+
+static void test_single_zero(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    task = batch_task_init(batch_size);
+
+    char buf[page_size];
+    char *ptr = buf;
+
+    memset(buf, 0x0, page_size);
+    buffer_is_zero_dsa_batch_async(task,
+                                   (const void **)&ptr,
+                                   1, page_size);
+    g_assert(task->results[0]);
+
+    batch_task_destroy(task);
+
+    dsa_cleanup();
+}
+
+static void test_single_zero_async(void)
+{
+    test_single_zero();
+}
+
+static void test_single_nonzero(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    task = batch_task_init(batch_size);
+
+    char buf[page_size];
+    char *ptr = buf;
+
+    memset(buf, 0x1, page_size);
+    buffer_is_zero_dsa_batch_async(task,
+                                   (const void **)&ptr,
+                                   1, page_size);
+    g_assert(!task->results[0]);
+
+    batch_task_destroy(task);
+
+    dsa_cleanup();
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
+    buffer_is_zero_dsa_batch_async(task,
+                             (const void **)&buf,
+                             0,
+                             page_size);
+}
+
+static void test_null_task_async(void)
+{
+    if (g_test_subprocess()) {
+        g_assert(!dsa_init(path1));
+
+        char buf[page_size * batch_size];
+        char *addrs[batch_size];
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf + (page_size * i);
+        }
+
+        buffer_is_zero_dsa_batch_async(NULL, (const void **)addrs,
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
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    task = batch_task_init(batch_size);
+
+    char buf[page_size * oversized_batch_size];
+    char *addrs[batch_size];
+    for (int i = 0; i < oversized_batch_size; i++) {
+        addrs[i] = buf + (page_size * i);
+    }
+
+    int ret = buffer_is_zero_dsa_batch_async(task,
+                                            (const void **)addrs,
+                                            oversized_batch_size,
+                                            page_size);
+    g_assert(ret != 0);
+
+    batch_task_destroy(task);
+
+    dsa_cleanup();
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
+        g_assert(!dsa_init(path1));
+
+        task = batch_task_init(batch_size);
+
+        char buf[page_size];
+
+        buffer_is_zero_dsa_batch_async(task,
+                                       (const void **)&buf,
+                                       1,
+                                       0);
+
+        batch_task_destroy(task);
+    } else {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_failed();
+    }
+}
+
+static void test_null_buf_async(void)
+{
+    if (g_test_subprocess()) {
+        g_assert(!dsa_init(path1));
+
+        task = batch_task_init(batch_size);
+
+        buffer_is_zero_dsa_batch_async(task, NULL, 1, page_size);
+
+        batch_task_destroy(task);
+    } else {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_failed();
+    }
+}
+
+static void test_batch(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    task = batch_task_init(batch_size);
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
+    buffer_is_zero_dsa_batch_async(task,
+                                   (const void **)addrs,
+                                   batch_size,
+                                   page_size);
+
+    bool is_zero;
+    for (int i = 0; i < batch_size; i++) {
+        is_zero = buffer_is_zero((const void *)&buf[page_size * i], page_size);
+        g_assert(task->results[i] == is_zero);
+    }
+
+    batch_task_destroy(task);
+
+    dsa_cleanup();
+}
+
+static void test_batch_async(void)
+{
+    test_batch();
+}
+
+static void test_page_fault(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
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
+        task = batch_task_init(batch_size);
+
+        char *addrs[batch_size];
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf[j] + (page_size * i);
+        }
+
+        buffer_is_zero_dsa_batch_async(task,
+                                       (const void **)addrs,
+                                       batch_size,
+                                       page_size);
+
+        bool is_zero;
+        for (int i = 0; i < batch_size; i++) {
+            is_zero = buffer_is_zero((const void *)&buf[j][page_size * i],
+                                      page_size);
+            g_assert(task->results[i] == is_zero);
+        }
+        batch_task_destroy(task);
+    }
+
+    assert(!munmap(buf[0], page_size * batch_size));
+    free(buf[1]);
+    dsa_cleanup();
+}
+
+static void test_various_buffer_sizes(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    char *buf = malloc(max_buffer_size * batch_size);
+    char *addrs[batch_size];
+
+    for (int len = 16; len <= max_buffer_size; len *= 2) {
+        task = batch_task_init(batch_size);
+
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf + (len * i);
+        }
+
+        buffer_is_zero_dsa_batch_async(task,
+                                       (const void **)addrs,
+                                       batch_size,
+                                       len);
+
+        bool is_zero;
+        for (int j = 0; j < batch_size; j++) {
+            is_zero = buffer_is_zero((const void *)&buf[len * j], len);
+            g_assert(task->results[j] == is_zero);
+        }
+
+        batch_task_destroy(task);
+    }
+
+    free(buf);
+
+    dsa_cleanup();
+}
+
+static void test_various_buffer_sizes_async(void)
+{
+    test_various_buffer_sizes();
+}
+
+static void test_double_start_stop(void)
+{
+    g_assert(!dsa_init(path1));
+    /* Double start */
+    dsa_start();
+    dsa_start();
+    g_assert(dsa_is_running());
+    do_single_task();
+
+    /* Double stop */
+    dsa_stop();
+    g_assert(!dsa_is_running());
+    dsa_stop();
+    g_assert(!dsa_is_running());
+
+    /* Restart */
+    dsa_start();
+    g_assert(dsa_is_running());
+    do_single_task();
+    dsa_cleanup();
+}
+
+static void test_is_running(void)
+{
+    g_assert(!dsa_init(path1));
+
+    g_assert(!dsa_is_running());
+    dsa_start();
+    g_assert(dsa_is_running());
+    dsa_stop();
+    g_assert(!dsa_is_running());
+    dsa_cleanup();
+}
+
+static void test_multiple_engines(void)
+{
+    g_assert(!dsa_init(path2));
+    dsa_start();
+
+    struct batch_task *tasks[num_devices];
+    char bufs[num_devices][page_size * batch_size];
+    char *addrs[num_devices][batch_size];
+
+    /*
+     *  This is a somewhat implementation-specific way
+     *  of testing that the tasks have unique engines
+     *  assigned to them.
+     */
+    tasks[0] = batch_task_init(batch_size);
+    tasks[1] = batch_task_init(batch_size);
+    g_assert(tasks[0]->dsa_batch->device != tasks[1]->dsa_batch->device);
+
+    for (int i = 0; i < num_devices; i++) {
+        for (int j = 0; j < batch_size; j++) {
+            addrs[i][j] = bufs[i] + (page_size * j);
+        }
+
+        buffer_is_zero_dsa_batch_async(tasks[i],
+                                       (const void **)addrs[i],
+                                       batch_size, page_size);
+
+        bool is_zero;
+        for (int j = 0; j < batch_size; j++) {
+            is_zero = buffer_is_zero((const void *)&bufs[i][page_size * j],
+                                     page_size);
+            g_assert(tasks[i]->results[j] == is_zero);
+        }
+    }
+
+    batch_task_destroy(tasks[0]);
+    batch_task_destroy(tasks[1]);
+
+    dsa_cleanup();
+}
+
+static void test_configure_dsa_twice(void)
+{
+    g_assert(!dsa_init(path2));
+    g_assert(!dsa_init(path2));
+    dsa_start();
+    do_single_task();
+    dsa_cleanup();
+}
+
+static void test_configure_dsa_bad_path(void)
+{
+    const char *bad_path = "/not/a/real/path";
+    g_assert(dsa_init(bad_path));
+}
+
+static void test_cleanup_before_configure(void)
+{
+    dsa_cleanup();
+    g_assert(!dsa_init(path2));
+}
+
+static void test_configure_dsa_num_devices(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    do_single_task();
+    dsa_stop();
+    dsa_cleanup();
+}
+
+static void test_cleanup_twice(void)
+{
+    g_assert(!dsa_init(path2));
+    dsa_cleanup();
+    dsa_cleanup();
+
+    g_assert(!dsa_init(path2));
+    dsa_start();
+    do_single_task();
+    dsa_cleanup();
+}
+
+static int check_test_setup(void)
+{
+    const char *path[2] = {path1, path2};
+    for (int i = 0; i < sizeof(path) / sizeof(char *); i++) {
+        if (dsa_init(path[i])) {
+            return -1;
+        }
+        dsa_cleanup();
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
2.30.2


