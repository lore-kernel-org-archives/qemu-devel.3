Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C496BC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sET3n-0003hf-7K; Tue, 04 Jun 2024 08:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3k-0003fz-Lr
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:36 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3g-0006wW-3c
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:36 -0400
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VtqF41gQQzPpHv;
 Tue,  4 Jun 2024 20:11:04 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
 by mail.maildlp.com (Postfix) with ESMTPS id 97E5D14022E;
 Tue,  4 Jun 2024 20:14:20 +0800 (CST)
Received: from DESKTOP-8LI8G6S.china.huawei.com (10.173.124.235) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Jun 2024 20:14:19 +0800
To: <qemu-devel@nongnu.org>
CC: <peterx@redhat.com>, <yu.zhang@ionos.com>, <mgalaxy@akamai.com>,
 <elmar.gerdes@ionos.com>, <zhengchuan@huawei.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <lizhijian@fujitsu.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <xiexiangyou@huawei.com>, <linux-rdma@vger.kernel.org>,
 <lixiao91@huawei.com>, <arei.gonglei@huawei.com>, <jinpu.wang@ionos.com>,
 Jialin Wang <wangjialin23@huawei.com>
Subject: [PATCH 2/6] io: add QIOChannelRDMA class
Date: Tue, 4 Jun 2024 20:14:08 +0800
Message-ID: <1717503252-51884-3-git-send-email-arei.gonglei@huawei.com>
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

Implement a QIOChannelRDMA subclass that is based on the rsocket
API (similar to socket API).

Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 include/io/channel-rdma.h | 152 +++++++++++++
 io/channel-rdma.c         | 437 ++++++++++++++++++++++++++++++++++++++
 io/meson.build            |   1 +
 io/trace-events           |  14 ++
 4 files changed, 604 insertions(+)
 create mode 100644 include/io/channel-rdma.h
 create mode 100644 io/channel-rdma.c

diff --git a/include/io/channel-rdma.h b/include/io/channel-rdma.h
new file mode 100644
index 0000000000..8cab2459e5
--- /dev/null
+++ b/include/io/channel-rdma.h
@@ -0,0 +1,152 @@
+/*
+ * QEMU I/O channels RDMA driver
+ *
+ * Copyright (c) 2024 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *  Jialin Wang <wangjialin23@huawei.com>
+ *  Gonglei <arei.gonglei@huawei.com>
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
+#ifndef QIO_CHANNEL_RDMA_H
+#define QIO_CHANNEL_RDMA_H
+
+#include "io/channel.h"
+#include "io/task.h"
+#include "qemu/sockets.h"
+#include "qom/object.h"
+
+#define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
+OBJECT_DECLARE_SIMPLE_TYPE(QIOChannelRDMA, QIO_CHANNEL_RDMA)
+
+/**
+ * QIOChannelRDMA:
+ *
+ * The QIOChannelRDMA object provides a channel implementation
+ * that discards all writes and returns EOF for all reads.
+ */
+struct QIOChannelRDMA {
+    QIOChannel parent;
+    /* the rsocket fd */
+    int fd;
+
+    struct sockaddr_storage localAddr;
+    socklen_t localAddrLen;
+    struct sockaddr_storage remoteAddr;
+    socklen_t remoteAddrLen;
+};
+
+/**
+ * qio_channel_rdma_new:
+ *
+ * Create a channel for performing I/O on a rdma
+ * connection, that is initially closed. After
+ * creating the rdma, it must be setup as a client
+ * connection or server.
+ *
+ * Returns: the rdma channel object
+ */
+QIOChannelRDMA *qio_channel_rdma_new(void);
+
+/**
+ * qio_channel_rdma_connect_sync:
+ * @ioc: the rdma channel object
+ * @addr: the address to connect to
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Attempt to connect to the address @addr. This method
+ * will run in the foreground so the caller will not regain
+ * execution control until the connection is established or
+ * an error occurs.
+ */
+int qio_channel_rdma_connect_sync(QIOChannelRDMA *ioc, InetSocketAddress *addr,
+                                  Error **errp);
+
+/**
+ * qio_channel_rdma_connect_async:
+ * @ioc: the rdma channel object
+ * @addr: the address to connect to
+ * @callback: the function to invoke on completion
+ * @opaque: user data to pass to @callback
+ * @destroy: the function to free @opaque
+ * @context: the context to run the async task. If %NULL, the default
+ *           context will be used.
+ *
+ * Attempt to connect to the address @addr. This method
+ * will run in the background so the caller will regain
+ * execution control immediately. The function @callback
+ * will be invoked on completion or failure. The @addr
+ * parameter will be copied, so may be freed as soon
+ * as this function returns without waiting for completion.
+ */
+void qio_channel_rdma_connect_async(QIOChannelRDMA *ioc,
+                                    InetSocketAddress *addr,
+                                    QIOTaskFunc callback, gpointer opaque,
+                                    GDestroyNotify destroy,
+                                    GMainContext *context);
+
+/**
+ * qio_channel_rdma_listen_sync:
+ * @ioc: the rdma channel object
+ * @addr: the address to listen to
+ * @num: the expected amount of connections
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Attempt to listen to the address @addr. This method
+ * will run in the foreground so the caller will not regain
+ * execution control until the connection is established or
+ * an error occurs.
+ */
+int qio_channel_rdma_listen_sync(QIOChannelRDMA *ioc, InetSocketAddress *addr,
+                                 int num, Error **errp);
+
+/**
+ * qio_channel_rdma_listen_async:
+ * @ioc: the rdma channel object
+ * @addr: the address to listen to
+ * @num: the expected amount of connections
+ * @callback: the function to invoke on completion
+ * @opaque: user data to pass to @callback
+ * @destroy: the function to free @opaque
+ * @context: the context to run the async task. If %NULL, the default
+ *           context will be used.
+ *
+ * Attempt to listen to the address @addr. This method
+ * will run in the background so the caller will regain
+ * execution control immediately. The function @callback
+ * will be invoked on completion or failure. The @addr
+ * parameter will be copied, so may be freed as soon
+ * as this function returns without waiting for completion.
+ */
+void qio_channel_rdma_listen_async(QIOChannelRDMA *ioc, InetSocketAddress *addr,
+                                   int num, QIOTaskFunc callback,
+                                   gpointer opaque, GDestroyNotify destroy,
+                                   GMainContext *context);
+
+/**
+ * qio_channel_rdma_accept:
+ * @ioc: the rdma channel object
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * If the rdma represents a server, then this accepts
+ * a new client connection. The returned channel will
+ * represent the connected client rdma.
+ *
+ * Returns: the new client channel, or NULL on error
+ */
+QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *ioc, Error **errp);
+
+#endif /* QIO_CHANNEL_RDMA_H */
diff --git a/io/channel-rdma.c b/io/channel-rdma.c
new file mode 100644
index 0000000000..92c362df52
--- /dev/null
+++ b/io/channel-rdma.c
@@ -0,0 +1,437 @@
+/*
+ * QEMU I/O channels RDMA driver
+ *
+ * Copyright (c) 2024 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *  Jialin Wang <wangjialin23@huawei.com>
+ *  Gonglei <arei.gonglei@huawei.com>
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
+#include "io/channel.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/error.h"
+#include "qapi/qapi-visit-sockets.h"
+#include "trace.h"
+#include <errno.h>
+#include <netdb.h>
+#include <rdma/rsocket.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/eventfd.h>
+#include <sys/poll.h>
+#include <unistd.h>
+
+QIOChannelRDMA *qio_channel_rdma_new(void)
+{
+    QIOChannelRDMA *rioc;
+    QIOChannel *ioc;
+
+    rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
+    ioc = QIO_CHANNEL(rioc);
+    qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
+
+    trace_qio_channel_rdma_new(ioc);
+
+    return rioc;
+}
+
+static int qio_channel_rdma_set_fd(QIOChannelRDMA *rioc, int fd, Error **errp)
+{
+    if (rioc->fd != -1) {
+        error_setg(errp, "Socket is already open");
+        return -1;
+    }
+
+    rioc->fd = fd;
+    rioc->remoteAddrLen = sizeof(rioc->remoteAddr);
+    rioc->localAddrLen = sizeof(rioc->localAddr);
+
+    if (rgetpeername(fd, (struct sockaddr *)&rioc->remoteAddr,
+                     &rioc->remoteAddrLen) < 0) {
+        if (errno == ENOTCONN) {
+            memset(&rioc->remoteAddr, 0, sizeof(rioc->remoteAddr));
+            rioc->remoteAddrLen = sizeof(rioc->remoteAddr);
+        } else {
+            error_setg_errno(errp, errno,
+                             "Unable to query remote rsocket address");
+            goto error;
+        }
+    }
+
+    if (rgetsockname(fd, (struct sockaddr *)&rioc->localAddr,
+                     &rioc->localAddrLen) < 0) {
+        error_setg_errno(errp, errno, "Unable to query local rsocket address");
+        goto error;
+    }
+
+    return 0;
+
+error:
+    rioc->fd = -1; /* Let the caller close FD on failure */
+    return -1;
+}
+
+int qio_channel_rdma_connect_sync(QIOChannelRDMA *rioc, InetSocketAddress *addr,
+                                  Error **errp)
+{
+    int ret, fd = -1;
+    struct rdma_addrinfo *ai;
+
+    trace_qio_channel_rdma_connect_sync(rioc, addr);
+    ret = rdma_getaddrinfo(addr->host, addr->port, NULL, &ai);
+    if (ret) {
+        error_setg(errp, "Failed to rdma_getaddrinfo: %s", gai_strerror(ret));
+        goto out;
+    }
+
+    fd = rsocket(ai->ai_family, SOCK_STREAM, 0);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "Failed to create rsocket");
+        goto out;
+    }
+    qemu_set_cloexec(fd);
+
+retry:
+    ret = rconnect(fd, ai->ai_dst_addr, ai->ai_dst_len);
+    if (ret) {
+        if (errno == EINTR) {
+            goto retry;
+        }
+        error_setg_errno(errp, errno, "Failed to rconnect");
+        goto out;
+    }
+
+    trace_qio_channel_rdma_connect_complete(rioc, fd);
+    ret = qio_channel_rdma_set_fd(rioc, fd, errp);
+    if (ret) {
+        goto out;
+    }
+
+out:
+    if (ret) {
+        trace_qio_channel_rdma_connect_fail(rioc);
+        if (fd >= 0) {
+            rclose(fd);
+        }
+    }
+    if (ai) {
+        rdma_freeaddrinfo(ai);
+    }
+
+    return ret;
+}
+
+static void qio_channel_rdma_connect_worker(QIOTask *task, gpointer opaque)
+{
+    QIOChannelRDMA *ioc = QIO_CHANNEL_RDMA(qio_task_get_source(task));
+    InetSocketAddress *addr = opaque;
+    Error *err = NULL;
+
+    qio_channel_rdma_connect_sync(ioc, addr, &err);
+
+    qio_task_set_error(task, err);
+}
+
+void qio_channel_rdma_connect_async(QIOChannelRDMA *ioc,
+                                    InetSocketAddress *addr,
+                                    QIOTaskFunc callback, gpointer opaque,
+                                    GDestroyNotify destroy,
+                                    GMainContext *context)
+{
+    QIOTask *task = qio_task_new(OBJECT(ioc), callback, opaque, destroy);
+    InetSocketAddress *addrCopy;
+
+    addrCopy = QAPI_CLONE(InetSocketAddress, addr);
+
+    /* rdma_getaddrinfo() blocks in DNS lookups, so we must use a thread */
+    trace_qio_channel_rdma_connect_async(ioc, addr);
+    qio_task_run_in_thread(task, qio_channel_rdma_connect_worker, addrCopy,
+                           (GDestroyNotify)qapi_free_InetSocketAddress,
+                           context);
+}
+
+int qio_channel_rdma_listen_sync(QIOChannelRDMA *rioc, InetSocketAddress *addr,
+                                 int num, Error **errp)
+{
+    int ret, fd = -1;
+    struct rdma_addrinfo *ai;
+    struct rdma_addrinfo ai_hints = { 0 };
+
+    trace_qio_channel_rdma_listen_sync(rioc, addr, num);
+    ai_hints.ai_port_space = RDMA_PS_TCP;
+    ai_hints.ai_flags |= RAI_PASSIVE;
+    ret = rdma_getaddrinfo(addr->host, addr->port, &ai_hints, &ai);
+    if (ret) {
+        error_setg(errp, "Failed to rdma_getaddrinfo: %s", gai_strerror(ret));
+        goto out;
+    }
+
+    fd = rsocket(ai->ai_family, SOCK_STREAM, 0);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "Failed to create rsocket");
+        goto out;
+    }
+    qemu_set_cloexec(fd);
+
+    ret = rbind(fd, ai->ai_src_addr, ai->ai_src_len);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to rbind");
+        goto out;
+    }
+
+    ret = rlisten(fd, num);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to rlisten");
+        goto out;
+    }
+
+    ret = qio_channel_rdma_set_fd(rioc, fd, errp);
+    if (ret) {
+        goto out;
+    }
+
+    qio_channel_set_feature(QIO_CHANNEL(rioc), QIO_CHANNEL_FEATURE_LISTEN);
+    trace_qio_channel_rdma_listen_complete(rioc, fd);
+
+out:
+    if (ret) {
+        trace_qio_channel_rdma_listen_fail(rioc);
+        if (fd >= 0) {
+            rclose(fd);
+        }
+    }
+    if (ai) {
+        rdma_freeaddrinfo(ai);
+    }
+
+    return ret;
+}
+
+struct QIOChannelListenWorkerData {
+    InetSocketAddress *addr;
+    int num; /* amount of expected connections */
+};
+
+static void qio_channel_listen_worker_free(gpointer opaque)
+{
+    struct QIOChannelListenWorkerData *data = opaque;
+
+    qapi_free_InetSocketAddress(data->addr);
+    g_free(data);
+}
+
+static void qio_channel_rdma_listen_worker(QIOTask *task, gpointer opaque)
+{
+    QIOChannelRDMA *ioc = QIO_CHANNEL_RDMA(qio_task_get_source(task));
+    struct QIOChannelListenWorkerData *data = opaque;
+    Error *err = NULL;
+
+    qio_channel_rdma_listen_sync(ioc, data->addr, data->num, &err);
+
+    qio_task_set_error(task, err);
+}
+
+void qio_channel_rdma_listen_async(QIOChannelRDMA *ioc, InetSocketAddress *addr,
+                                   int num, QIOTaskFunc callback,
+                                   gpointer opaque, GDestroyNotify destroy,
+                                   GMainContext *context)
+{
+    QIOTask *task = qio_task_new(OBJECT(ioc), callback, opaque, destroy);
+    struct QIOChannelListenWorkerData *data;
+
+    data = g_new0(struct QIOChannelListenWorkerData, 1);
+    data->addr = QAPI_CLONE(InetSocketAddress, addr);
+    data->num = num;
+
+    /* rdma_getaddrinfo() blocks in DNS lookups, so we must use a thread */
+    trace_qio_channel_rdma_listen_async(ioc, addr, num);
+    qio_task_run_in_thread(task, qio_channel_rdma_listen_worker, data,
+                           qio_channel_listen_worker_free, context);
+}
+
+QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *rioc, Error **errp)
+{
+    QIOChannelRDMA *cioc;
+
+    cioc = qio_channel_rdma_new();
+    cioc->remoteAddrLen = sizeof(rioc->remoteAddr);
+    cioc->localAddrLen = sizeof(rioc->localAddr);
+
+    trace_qio_channel_rdma_accept(rioc);
+retry:
+    cioc->fd = raccept(rioc->fd, (struct sockaddr *)&cioc->remoteAddr,
+                       &cioc->remoteAddrLen);
+    if (cioc->fd < 0) {
+        if (errno == EINTR) {
+            goto retry;
+        }
+        error_setg_errno(errp, errno, "Unable to accept connection");
+        goto error;
+    }
+    qemu_set_cloexec(cioc->fd);
+
+    if (rgetsockname(cioc->fd, (struct sockaddr *)&cioc->localAddr,
+                     &cioc->localAddrLen) < 0) {
+        error_setg_errno(errp, errno, "Unable to query local rsocket address");
+        goto error;
+    }
+
+    trace_qio_channel_rdma_accept_complete(rioc, cioc, cioc->fd);
+    return cioc;
+
+error:
+    trace_qio_channel_rdma_accept_fail(rioc);
+    object_unref(OBJECT(cioc));
+    return NULL;
+}
+
+static void qio_channel_rdma_init(Object *obj)
+{
+    QIOChannelRDMA *ioc = QIO_CHANNEL_RDMA(obj);
+    ioc->fd = -1;
+}
+
+static void qio_channel_rdma_finalize(Object *obj)
+{
+    QIOChannelRDMA *ioc = QIO_CHANNEL_RDMA(obj);
+
+    if (ioc->fd != -1) {
+        rclose(ioc->fd);
+        ioc->fd = -1;
+    }
+}
+
+static ssize_t qio_channel_rdma_readv(QIOChannel *ioc, const struct iovec *iov,
+                                      size_t niov, int **fds G_GNUC_UNUSED,
+                                      size_t *nfds G_GNUC_UNUSED,
+                                      int flags G_GNUC_UNUSED, Error **errp)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+    ssize_t ret;
+
+retry:
+    ret = rreadv(rioc->fd, iov, niov);
+    if (ret < 0) {
+        if (errno == EINTR) {
+            goto retry;
+        }
+        error_setg_errno(errp, errno, "Unable to write to rsocket");
+        return -1;
+    }
+
+    return ret;
+}
+
+static ssize_t qio_channel_rdma_writev(QIOChannel *ioc, const struct iovec *iov,
+                                       size_t niov, int *fds G_GNUC_UNUSED,
+                                       size_t nfds G_GNUC_UNUSED,
+                                       int flags G_GNUC_UNUSED, Error **errp)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+    ssize_t ret;
+
+retry:
+    ret = rwritev(rioc->fd, iov, niov);
+    if (ret <= 0) {
+        if (errno == EINTR) {
+            goto retry;
+        }
+        error_setg_errno(errp, errno, "Unable to write to rsocket");
+        return -1;
+    }
+
+    return ret;
+}
+
+static void qio_channel_rdma_set_delay(QIOChannel *ioc, bool enabled)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+    int v = enabled ? 0 : 1;
+
+    rsetsockopt(rioc->fd, IPPROTO_TCP, TCP_NODELAY, &v, sizeof(v));
+}
+
+static int qio_channel_rdma_close(QIOChannel *ioc, Error **errp)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+
+    if (rioc->fd != -1) {
+        rclose(rioc->fd);
+        rioc->fd = -1;
+    }
+
+    return 0;
+}
+
+static int qio_channel_rdma_shutdown(QIOChannel *ioc, QIOChannelShutdown how,
+                                     Error **errp)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+    int sockhow;
+
+    switch (how) {
+    case QIO_CHANNEL_SHUTDOWN_READ:
+        sockhow = SHUT_RD;
+        break;
+    case QIO_CHANNEL_SHUTDOWN_WRITE:
+        sockhow = SHUT_WR;
+        break;
+    case QIO_CHANNEL_SHUTDOWN_BOTH:
+    default:
+        sockhow = SHUT_RDWR;
+        break;
+    }
+
+    if (rshutdown(rioc->fd, sockhow) < 0) {
+        error_setg_errno(errp, errno, "Unable to shutdown rsocket");
+        return -1;
+    }
+
+    return 0;
+}
+
+static void qio_channel_rdma_class_init(ObjectClass *klass,
+                                        void *class_data G_GNUC_UNUSED)
+{
+    QIOChannelClass *ioc_klass = QIO_CHANNEL_CLASS(klass);
+
+    ioc_klass->io_writev = qio_channel_rdma_writev;
+    ioc_klass->io_readv = qio_channel_rdma_readv;
+    ioc_klass->io_close = qio_channel_rdma_close;
+    ioc_klass->io_shutdown = qio_channel_rdma_shutdown;
+    ioc_klass->io_set_delay = qio_channel_rdma_set_delay;
+}
+
+static const TypeInfo qio_channel_rdma_info = {
+    .parent = TYPE_QIO_CHANNEL,
+    .name = TYPE_QIO_CHANNEL_RDMA,
+    .instance_size = sizeof(QIOChannelRDMA),
+    .instance_init = qio_channel_rdma_init,
+    .instance_finalize = qio_channel_rdma_finalize,
+    .class_init = qio_channel_rdma_class_init,
+};
+
+static void qio_channel_rdma_register_types(void)
+{
+    type_register_static(&qio_channel_rdma_info);
+}
+
+type_init(qio_channel_rdma_register_types);
diff --git a/io/meson.build b/io/meson.build
index 283b9b2bdb..e0dbd5183f 100644
--- a/io/meson.build
+++ b/io/meson.build
@@ -14,3 +14,4 @@ io_ss.add(files(
   'net-listener.c',
   'task.c',
 ), gnutls)
+io_ss.add(when: rdma, if_true: files('channel-rdma.c'))
diff --git a/io/trace-events b/io/trace-events
index d4c0f84a9a..33026a2224 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -67,3 +67,17 @@ qio_channel_command_new_pid(void *ioc, int writefd, int readfd, int pid) "Comman
 qio_channel_command_new_spawn(void *ioc, const char *binary, int flags) "Command new spawn ioc=%p binary=%s flags=%d"
 qio_channel_command_abort(void *ioc, int pid) "Command abort ioc=%p pid=%d"
 qio_channel_command_wait(void *ioc, int pid, int ret, int status) "Command abort ioc=%p pid=%d ret=%d status=%d"
+
+# channel-rdma.c
+qio_channel_rdma_new(void *ioc) "RDMA rsocket new ioc=%p"
+qio_channel_rdma_connect_sync(void *ioc, void *addr) "RDMA rsocket connect sync ioc=%p addr=%p"
+qio_channel_rdma_connect_async(void *ioc, void *addr) "RDMA rsocket connect async ioc=%p addr=%p"
+qio_channel_rdma_connect_fail(void *ioc) "RDMA rsocket connect fail ioc=%p"
+qio_channel_rdma_connect_complete(void *ioc, int fd) "RDMA rsocket connect complete ioc=%p fd=%d"
+qio_channel_rdma_listen_sync(void *ioc, void *addr, int num) "RDMA rsocket listen sync ioc=%p addr=%p num=%d"
+qio_channel_rdma_listen_fail(void *ioc) "RDMA rsocket listen fail ioc=%p"
+qio_channel_rdma_listen_async(void *ioc, void *addr, int num) "RDMA rsocket listen async ioc=%p addr=%p num=%d"
+qio_channel_rdma_listen_complete(void *ioc, int fd) "RDMA rsocket listen complete ioc=%p fd=%d"
+qio_channel_rdma_accept(void *ioc) "Socket accept start ioc=%p"
+qio_channel_rdma_accept_fail(void *ioc) "RDMA rsocket accept fail ioc=%p"
+qio_channel_rdma_accept_complete(void *ioc, void *cioc, int fd) "RDMA rsocket accept complete ioc=%p cioc=%p fd=%d"
-- 
2.43.0


