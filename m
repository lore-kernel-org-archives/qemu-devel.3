Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F86C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sET3o-0003i7-9U; Tue, 04 Jun 2024 08:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3l-0003gL-F5
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3g-0006wr-3v
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:36 -0400
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VtqF55KFlzPpNw;
 Tue,  4 Jun 2024 20:11:05 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
 by mail.maildlp.com (Postfix) with ESMTPS id 20034180060;
 Tue,  4 Jun 2024 20:14:22 +0800 (CST)
Received: from DESKTOP-8LI8G6S.china.huawei.com (10.173.124.235) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Jun 2024 20:14:21 +0800
To: <qemu-devel@nongnu.org>
CC: <peterx@redhat.com>, <yu.zhang@ionos.com>, <mgalaxy@akamai.com>,
 <elmar.gerdes@ionos.com>, <zhengchuan@huawei.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <lizhijian@fujitsu.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <xiexiangyou@huawei.com>, <linux-rdma@vger.kernel.org>,
 <lixiao91@huawei.com>, <arei.gonglei@huawei.com>, <jinpu.wang@ionos.com>,
 Jialin Wang <wangjialin23@huawei.com>
Subject: [PATCH 4/6] tests/unit: add test-io-channel-rdma.c
Date: Tue, 4 Jun 2024 20:14:10 +0800
Message-ID: <1717503252-51884-5-git-send-email-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.8.2.windows.1
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.124.235]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=arei.gonglei@huawei.com; helo=szxga03-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Gonglei <arei.gonglei@huawei.com>
From:  Gonglei via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jialin Wang <wangjialin23@huawei.com>

Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 tests/unit/meson.build            |   1 +
 tests/unit/test-io-channel-rdma.c | 276 ++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+)
 create mode 100644 tests/unit/test-io-channel-rdma.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 26c109c968..c44020a3b5 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -85,6 +85,7 @@ if have_block
     'test-authz-listfile': [authz],
     'test-io-task': [testblock],
     'test-io-channel-socket': ['socket-helpers.c', 'io-channel-helpers.c', io],
+    'test-io-channel-rdma': ['io-channel-helpers.c', io],
     'test-io-channel-file': ['io-channel-helpers.c', io],
     'test-io-channel-command': ['io-channel-helpers.c', io],
     'test-io-channel-buffer': ['io-channel-helpers.c', io],
diff --git a/tests/unit/test-io-channel-rdma.c b/tests/unit/test-io-channel-rdma.c
new file mode 100644
index 0000000000..e96b55c8c7
--- /dev/null
+++ b/tests/unit/test-io-channel-rdma.c
@@ -0,0 +1,276 @@
+/*
+ * QEMU I/O channel RDMA test
+ *
+ * Copyright (c) 2024 HUAWEI TECHNOLOGIES CO., LTD.
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
+
+#include "qemu/osdep.h"
+#include "io/channel-rdma.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "io-channel-helpers.h"
+#include "qapi-types-sockets.h"
+#include <rdma/rsocket.h>
+
+static SocketAddress *l_addr;
+static SocketAddress *c_addr;
+
+static void test_io_channel_set_rdma_bufs(QIOChannel *src, QIOChannel *dst)
+{
+    int buflen = 64 * 1024;
+
+    /*
+     * Make the socket buffers small so that we see
+     * the effects of partial reads/writes
+     */
+    rsetsockopt(((QIOChannelRDMA *)src)->fd, SOL_SOCKET, SO_SNDBUF,
+                (char *)&buflen, sizeof(buflen));
+
+    rsetsockopt(((QIOChannelRDMA *)dst)->fd, SOL_SOCKET, SO_SNDBUF,
+                (char *)&buflen, sizeof(buflen));
+}
+
+static void test_io_channel_setup_sync(InetSocketAddress *listen_addr,
+                                       InetSocketAddress *connect_addr,
+                                       QIOChannel **srv, QIOChannel **src,
+                                       QIOChannel **dst)
+{
+    QIOChannelRDMA *lioc;
+
+    lioc = qio_channel_rdma_new();
+    qio_channel_rdma_listen_sync(lioc, listen_addr, 1, &error_abort);
+
+    *src = QIO_CHANNEL(qio_channel_rdma_new());
+    qio_channel_rdma_connect_sync(QIO_CHANNEL_RDMA(*src), connect_addr,
+                                  &error_abort);
+    qio_channel_set_delay(*src, false);
+
+    qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
+    *dst = QIO_CHANNEL(qio_channel_rdma_accept(lioc, &error_abort));
+    g_assert(*dst);
+
+    test_io_channel_set_rdma_bufs(*src, *dst);
+
+    *srv = QIO_CHANNEL(lioc);
+}
+
+struct TestIOChannelData {
+    bool err;
+    GMainLoop *loop;
+};
+
+static void test_io_channel_complete(QIOTask *task, gpointer opaque)
+{
+    struct TestIOChannelData *data = opaque;
+    data->err = qio_task_propagate_error(task, NULL);
+    g_main_loop_quit(data->loop);
+}
+
+static void test_io_channel_setup_async(InetSocketAddress *listen_addr,
+                                        InetSocketAddress *connect_addr,
+                                        QIOChannel **srv, QIOChannel **src,
+                                        QIOChannel **dst)
+{
+    QIOChannelRDMA *lioc;
+    struct TestIOChannelData data;
+
+    data.loop = g_main_loop_new(g_main_context_default(), TRUE);
+
+    lioc = qio_channel_rdma_new();
+    qio_channel_rdma_listen_async(lioc, listen_addr, 1,
+                                  test_io_channel_complete, &data, NULL, NULL);
+
+    g_main_loop_run(data.loop);
+    g_main_context_iteration(g_main_context_default(), FALSE);
+
+    g_assert(!data.err);
+
+    *src = QIO_CHANNEL(qio_channel_rdma_new());
+
+    qio_channel_rdma_connect_async(QIO_CHANNEL_RDMA(*src), connect_addr,
+                                   test_io_channel_complete, &data, NULL, NULL);
+
+    g_main_loop_run(data.loop);
+    g_main_context_iteration(g_main_context_default(), FALSE);
+
+    g_assert(!data.err);
+
+    if (qemu_in_coroutine()) {
+        qio_channel_yield(QIO_CHANNEL(lioc), G_IO_IN);
+    } else {
+        qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
+    }
+    *dst = QIO_CHANNEL(qio_channel_rdma_accept(lioc, &error_abort));
+    g_assert(*dst);
+
+    qio_channel_set_delay(*src, false);
+    test_io_channel_set_rdma_bufs(*src, *dst);
+
+    *srv = QIO_CHANNEL(lioc);
+
+    g_main_loop_unref(data.loop);
+}
+
+static void test_io_channel(bool async, InetSocketAddress *listen_addr,
+                            InetSocketAddress *connect_addr)
+{
+    QIOChannel *src, *dst, *srv;
+    QIOChannelTest *test;
+
+    if (async) {
+        /* async + blocking */
+
+        test_io_channel_setup_async(listen_addr, connect_addr, &srv, &src,
+                                    &dst);
+
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
+
+        test = qio_channel_test_new();
+        qio_channel_test_run_threads(test, true, src, dst);
+        qio_channel_test_validate(test);
+
+        /* unref without close, to ensure finalize() cleans up */
+
+        object_unref(OBJECT(src));
+        object_unref(OBJECT(dst));
+        object_unref(OBJECT(srv));
+
+        /* async + non-blocking */
+
+        test_io_channel_setup_async(listen_addr, connect_addr, &srv, &src,
+                                    &dst);
+
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
+
+        test = qio_channel_test_new();
+        qio_channel_test_run_threads(test, false, src, dst);
+        qio_channel_test_validate(test);
+
+        /* close before unref, to ensure finalize copes with already closed */
+
+        qio_channel_close(src, &error_abort);
+        qio_channel_close(dst, &error_abort);
+        object_unref(OBJECT(src));
+        object_unref(OBJECT(dst));
+
+        qio_channel_close(srv, &error_abort);
+        object_unref(OBJECT(srv));
+    } else {
+        /* sync + blocking */
+
+        test_io_channel_setup_sync(listen_addr, connect_addr, &srv, &src, &dst);
+
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
+
+        test = qio_channel_test_new();
+        qio_channel_test_run_threads(test, true, src, dst);
+        qio_channel_test_validate(test);
+
+        /* unref without close, to ensure finalize() cleans up */
+
+        object_unref(OBJECT(src));
+        object_unref(OBJECT(dst));
+        object_unref(OBJECT(srv));
+
+        /* sync + non-blocking */
+
+        test_io_channel_setup_sync(listen_addr, connect_addr, &srv, &src, &dst);
+
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
+
+        test = qio_channel_test_new();
+        qio_channel_test_run_threads(test, false, src, dst);
+        qio_channel_test_validate(test);
+
+        /* close before unref, to ensure finalize copes with already closed */
+
+        qio_channel_close(src, &error_abort);
+        qio_channel_close(dst, &error_abort);
+        object_unref(OBJECT(src));
+        object_unref(OBJECT(dst));
+
+        qio_channel_close(srv, &error_abort);
+        object_unref(OBJECT(srv));
+    }
+}
+
+static void test_io_channel_rdma(bool async)
+{
+    InetSocketAddress *listen_addr;
+    InetSocketAddress *connect_addr;
+
+    listen_addr = &l_addr->u.inet;
+    connect_addr = &l_addr->u.inet;
+
+    test_io_channel(async, listen_addr, connect_addr);
+}
+
+static void test_io_channel_rdma_sync(void)
+{
+    test_io_channel_rdma(false);
+}
+
+static void test_io_channel_rdma_async(void)
+{
+    test_io_channel_rdma(true);
+}
+
+static void test_io_channel_rdma_co(void *opaque)
+{
+    test_io_channel_rdma(true);
+}
+
+static void test_io_channel_rdma_coroutine(void)
+{
+    Coroutine *coroutine;
+
+    coroutine = qemu_coroutine_create(test_io_channel_rdma_co, NULL);
+    qemu_coroutine_enter(coroutine);
+}
+
+int main(int argc, char **argv)
+{
+    module_call_init(MODULE_INIT_QOM);
+    qemu_init_main_loop(&error_abort);
+
+    if (argc != 3) {
+        fprintf(stderr, "Usage: %s listen_addr connect_addr\n", argv[0]);
+        exit(-1);
+    }
+
+    l_addr = socket_parse(argv[1], NULL);
+    c_addr = socket_parse(argv[2], NULL);
+    if (l_addr == NULL || c_addr == NULL ||
+        l_addr->type != SOCKET_ADDRESS_TYPE_INET ||
+        c_addr->type != SOCKET_ADDRESS_TYPE_INET) {
+        fprintf(stderr, "Only socket address types 'inet' is supported\n");
+        exit(-1);
+    }
+
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/io/channel/rdma/sync", test_io_channel_rdma_sync);
+    g_test_add_func("/io/channel/rdma/async", test_io_channel_rdma_async);
+    g_test_add_func("/io/channel/rdma/coroutine",
+                    test_io_channel_rdma_coroutine);
+
+    return g_test_run();
+}
-- 
2.43.0


