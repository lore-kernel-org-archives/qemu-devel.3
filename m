Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B48EC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sET3r-0003k6-NG; Tue, 04 Jun 2024 08:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3o-0003iN-RU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:40 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3j-0006wf-91
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:40 -0400
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VtqDL10fyz1S9Lw;
 Tue,  4 Jun 2024 20:10:26 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
 by mail.maildlp.com (Postfix) with ESMTPS id 5BC93180060;
 Tue,  4 Jun 2024 20:14:21 +0800 (CST)
Received: from DESKTOP-8LI8G6S.china.huawei.com (10.173.124.235) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Jun 2024 20:14:20 +0800
To: <qemu-devel@nongnu.org>
CC: <peterx@redhat.com>, <yu.zhang@ionos.com>, <mgalaxy@akamai.com>,
 <elmar.gerdes@ionos.com>, <zhengchuan@huawei.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <lizhijian@fujitsu.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <xiexiangyou@huawei.com>, <linux-rdma@vger.kernel.org>,
 <lixiao91@huawei.com>, <arei.gonglei@huawei.com>, <jinpu.wang@ionos.com>,
 Jialin Wang <wangjialin23@huawei.com>
Subject: [PATCH 3/6] io/channel-rdma: support working in coroutine
Date: Tue, 4 Jun 2024 20:14:09 +0800
Message-ID: <1717503252-51884-4-git-send-email-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.8.2.windows.1
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.124.235]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=arei.gonglei@huawei.com; helo=szxga08-in.huawei.com
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

It is not feasible to obtain RDMA completion queue notifications
through poll/ppoll on the rsocket fd. Therefore, we create a thread
named rpoller for each rsocket fd and two eventfds: pollin_eventfd
and pollout_eventfd.

When using io_create_watch or io_set_aio_fd_handler waits for POLLIN
or POLLOUT events, it will actually poll/ppoll on the pollin_eventfd
and pollout_eventfd instead of the rsocket fd.

The rpoller rpoll() on the rsocket fd to receive POLLIN and POLLOUT
events.
When a POLLIN event occurs, the rpoller write the pollin_eventfd,
and then poll/ppoll will return the POLLIN event.
When a POLLOUT event occurs, the rpoller read the pollout_eventfd,
and then poll/ppoll will return the POLLOUT event.

For a non-blocking rsocket fd, if rread/rwrite returns EAGAIN, it will
read/write the pollin/pollout_eventfd, preventing poll/ppoll from
returning POLLIN/POLLOUT events.

Known limitations:

  For a blocking rsocket fd, if we use io_create_watch to wait for
  POLLIN or POLLOUT events, since the rsocket fd is blocking, we
  cannot determine when it is not ready to read/write as we can with
  non-blocking fds. Therefore, when an event occurs, it will occurs
  always, potentially leave the qemu hanging. So we need be cautious
  to avoid hanging when using io_create_watch .

Luckily, channel-rdma works well in coroutines :)

Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 include/io/channel-rdma.h |  15 +-
 io/channel-rdma.c         | 363 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 376 insertions(+), 2 deletions(-)

diff --git a/include/io/channel-rdma.h b/include/io/channel-rdma.h
index 8cab2459e5..cb56127d76 100644
--- a/include/io/channel-rdma.h
+++ b/include/io/channel-rdma.h
@@ -47,6 +47,18 @@ struct QIOChannelRDMA {
     socklen_t localAddrLen;
     struct sockaddr_storage remoteAddr;
     socklen_t remoteAddrLen;
+
+    /* private */
+
+    /* qemu g_poll/ppoll() POLLIN event on it */
+    int pollin_eventfd;
+    /* qemu g_poll/ppoll() POLLOUT event on it */
+    int pollout_eventfd;
+
+    /* the index in the rpoller's fds array */
+    int index;
+    /* rpoller will rpoll() rpoll_events on the rsocket fd */
+    short int rpoll_events;
 };
 
 /**
@@ -147,6 +159,7 @@ void qio_channel_rdma_listen_async(QIOChannelRDMA *ioc, InetSocketAddress *addr,
  *
  * Returns: the new client channel, or NULL on error
  */
-QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *ioc, Error **errp);
+QIOChannelRDMA *coroutine_mixed_fn qio_channel_rdma_accept(QIOChannelRDMA *ioc,
+                                                           Error **errp);
 
 #endif /* QIO_CHANNEL_RDMA_H */
diff --git a/io/channel-rdma.c b/io/channel-rdma.c
index 92c362df52..9792add5cf 100644
--- a/io/channel-rdma.c
+++ b/io/channel-rdma.c
@@ -23,10 +23,15 @@
 
 #include "qemu/osdep.h"
 #include "io/channel-rdma.h"
+#include "io/channel-util.h"
+#include "io/channel-watch.h"
 #include "io/channel.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-sockets.h"
+#include "qemu/atomic.h"
+#include "qemu/error-report.h"
+#include "qemu/thread.h"
 #include "trace.h"
 #include <errno.h>
 #include <netdb.h>
@@ -39,11 +44,274 @@
 #include <sys/poll.h>
 #include <unistd.h>
 
+typedef enum {
+    CLEAR_POLLIN,
+    CLEAR_POLLOUT,
+    SET_POLLIN,
+    SET_POLLOUT,
+} UpdateEvent;
+
+typedef enum {
+    RP_CMD_ADD_IOC,
+    RP_CMD_DEL_IOC,
+    RP_CMD_UPDATE,
+} RpollerCMD;
+
+typedef struct {
+    RpollerCMD cmd;
+    QIOChannelRDMA *rioc;
+} RpollerMsg;
+
+/*
+ * rpoll() on the rsocket fd with rpoll_events, when POLLIN/POLLOUT event
+ * occurs, it will write/read the pollin_eventfd/pollout_eventfd to allow
+ * qemu g_poll/ppoll() get the POLLIN/POLLOUT event
+ */
+static struct Rpoller {
+    QemuThread thread;
+    bool is_running;
+    int sock[2];
+    int count; /* the number of rsocket fds being rpoll() */
+    int size; /* the size of fds/riocs */
+    struct pollfd *fds;
+    QIOChannelRDMA **riocs;
+} rpoller;
+
+static void qio_channel_rdma_notify_rpoller(QIOChannelRDMA *rioc,
+                                            RpollerCMD cmd)
+{
+    RpollerMsg msg;
+    int ret;
+
+    msg.cmd = cmd;
+    msg.rioc = rioc;
+
+    ret = RETRY_ON_EINTR(write(rpoller.sock[0], &msg, sizeof msg));
+    if (ret != sizeof msg) {
+        error_report("%s: failed to send msg, errno: %d", __func__, errno);
+    }
+}
+
+static void qio_channel_rdma_update_poll_event(QIOChannelRDMA *rioc,
+                                               UpdateEvent action,
+                                               bool notify_rpoller)
+{
+    /* An eventfd with the value of ULLONG_MAX - 1 is readable but unwritable */
+    unsigned long long buf = ULLONG_MAX - 1;
+
+    switch (action) {
+    /* only rpoller do SET_* action, to allow qemu ppoll() get the event */
+    case SET_POLLIN:
+        RETRY_ON_EINTR(write(rioc->pollin_eventfd, &buf, sizeof buf));
+        rioc->rpoll_events &= ~POLLIN;
+        break;
+    case SET_POLLOUT:
+        RETRY_ON_EINTR(read(rioc->pollout_eventfd, &buf, sizeof buf));
+        rioc->rpoll_events &= ~POLLOUT;
+        break;
+
+    /* the rsocket fd is not ready to rread/rwrite */
+    case CLEAR_POLLIN:
+        RETRY_ON_EINTR(read(rioc->pollin_eventfd, &buf, sizeof buf));
+        rioc->rpoll_events |= POLLIN;
+        break;
+    case CLEAR_POLLOUT:
+        RETRY_ON_EINTR(write(rioc->pollout_eventfd, &buf, sizeof buf));
+        rioc->rpoll_events |= POLLOUT;
+        break;
+    default:
+        break;
+    }
+
+    /* notify rpoller to rpoll() POLLIN/POLLOUT events */
+    if (notify_rpoller) {
+        qio_channel_rdma_notify_rpoller(rioc, RP_CMD_UPDATE);
+    }
+}
+
+static void qio_channel_rdma_rpoller_add_rioc(QIOChannelRDMA *rioc)
+{
+    if (rioc->index != -1) {
+        error_report("%s: rioc already exsits", __func__);
+        return;
+    }
+
+    rioc->index = ++rpoller.count;
+
+    if (rpoller.count + 1 > rpoller.size) {
+        rpoller.size *= 2;
+        rpoller.fds = g_renew(struct pollfd, rpoller.fds, rpoller.size);
+        rpoller.riocs = g_renew(QIOChannelRDMA *, rpoller.riocs, rpoller.size);
+    }
+
+    rpoller.fds[rioc->index].fd = rioc->fd;
+    rpoller.fds[rioc->index].events = rioc->rpoll_events;
+    rpoller.riocs[rioc->index] = rioc;
+}
+
+static void qio_channel_rdma_rpoller_del_rioc(QIOChannelRDMA *rioc)
+{
+    if (rioc->index == -1) {
+        error_report("%s: rioc not exsits", __func__);
+        return;
+    }
+
+    rpoller.fds[rioc->index] = rpoller.fds[rpoller.count];
+    rpoller.riocs[rioc->index] = rpoller.riocs[rpoller.count];
+    rpoller.riocs[rioc->index]->index = rioc->index;
+    rpoller.count--;
+
+    close(rioc->pollin_eventfd);
+    close(rioc->pollout_eventfd);
+    rioc->index = -1;
+    rioc->rpoll_events = 0;
+}
+
+static void qio_channel_rdma_rpoller_update_ioc(QIOChannelRDMA *rioc)
+{
+    if (rioc->index == -1) {
+        error_report("%s: rioc not exsits", __func__);
+        return;
+    }
+
+    rpoller.fds[rioc->index].fd = rioc->fd;
+    rpoller.fds[rioc->index].events = rioc->rpoll_events;
+}
+
+static void qio_channel_rdma_rpoller_process_msg(void)
+{
+    RpollerMsg msg;
+    int ret;
+
+    ret = RETRY_ON_EINTR(read(rpoller.sock[1], &msg, sizeof msg));
+    if (ret != sizeof msg) {
+        error_report("%s: rpoller failed to recv msg: %s", __func__,
+                     strerror(errno));
+        return;
+    }
+
+    switch (msg.cmd) {
+    case RP_CMD_ADD_IOC:
+        qio_channel_rdma_rpoller_add_rioc(msg.rioc);
+        break;
+    case RP_CMD_DEL_IOC:
+        qio_channel_rdma_rpoller_del_rioc(msg.rioc);
+        break;
+    case RP_CMD_UPDATE:
+        qio_channel_rdma_rpoller_update_ioc(msg.rioc);
+        break;
+    default:
+        break;
+    }
+}
+
+static void qio_channel_rdma_rpoller_cleanup(void)
+{
+    close(rpoller.sock[0]);
+    close(rpoller.sock[1]);
+    rpoller.sock[0] = -1;
+    rpoller.sock[1] = -1;
+    g_free(rpoller.fds);
+    g_free(rpoller.riocs);
+    rpoller.fds = NULL;
+    rpoller.riocs = NULL;
+    rpoller.count = 0;
+    rpoller.size = 0;
+    rpoller.is_running = false;
+}
+
+static void *qio_channel_rdma_rpoller_thread(void *opaque)
+{
+    int i, ret, error_events = POLLERR | POLLHUP | POLLNVAL;
+
+    do {
+        ret = rpoll(rpoller.fds, rpoller.count + 1, -1);
+        if (ret < 0 && errno != -EINTR) {
+            error_report("%s: rpoll() error: %s", __func__, strerror(errno));
+            break;
+        }
+
+        for (i = 1; i <= rpoller.count; i++) {
+            if (rpoller.fds[i].revents & (POLLIN | error_events)) {
+                qio_channel_rdma_update_poll_event(rpoller.riocs[i], SET_POLLIN,
+                                                   false);
+                rpoller.fds[i].events &= ~POLLIN;
+            }
+            if (rpoller.fds[i].revents & (POLLOUT | error_events)) {
+                qio_channel_rdma_update_poll_event(rpoller.riocs[i],
+                                                   SET_POLLOUT, false);
+                rpoller.fds[i].events &= ~POLLOUT;
+            }
+            /* ignore this fd */
+            if (rpoller.fds[i].revents & (error_events)) {
+                rpoller.fds[i].fd = -1;
+            }
+        }
+
+        if (rpoller.fds[0].revents) {
+            qio_channel_rdma_rpoller_process_msg();
+        }
+    } while (rpoller.count >= 1);
+
+    qio_channel_rdma_rpoller_cleanup();
+
+    return NULL;
+}
+
+static void qio_channel_rdma_rpoller_start(void)
+{
+    if (qatomic_xchg(&rpoller.is_running, true)) {
+        return;
+    }
+
+    if (qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, rpoller.sock)) {
+        rpoller.is_running = false;
+        error_report("%s: failed to create socketpair %s", __func__,
+                     strerror(errno));
+        return;
+    }
+
+    rpoller.count = 0;
+    rpoller.size = 4;
+    rpoller.fds = g_malloc0_n(rpoller.size, sizeof(struct pollfd));
+    rpoller.riocs = g_malloc0_n(rpoller.size, sizeof(QIOChannelRDMA *));
+    rpoller.fds[0].fd = rpoller.sock[1];
+    rpoller.fds[0].events = POLLIN;
+
+    qemu_thread_create(&rpoller.thread, "qio-channel-rdma-rpoller",
+                       qio_channel_rdma_rpoller_thread, NULL,
+                       QEMU_THREAD_JOINABLE);
+}
+
+static void qio_channel_rdma_add_rioc_to_rpoller(QIOChannelRDMA *rioc)
+{
+    int flags = EFD_CLOEXEC | EFD_NONBLOCK;
+
+    /*
+     * A single eventfd is either readable or writable. A single eventfd cannot
+     * represent a state where it is neither readable nor writable. so use two
+     * eventfds here.
+     */
+    rioc->pollin_eventfd = eventfd(0, flags);
+    rioc->pollout_eventfd = eventfd(0, flags);
+    /* pollout_eventfd with the value 0, means writable, make it unwritable */
+    qio_channel_rdma_update_poll_event(rioc, CLEAR_POLLOUT, false);
+
+    /* tell the rpoller to rpoll() events on rioc->socketfd */
+    rioc->rpoll_events = POLLIN | POLLOUT;
+    qio_channel_rdma_notify_rpoller(rioc, RP_CMD_ADD_IOC);
+}
+
 QIOChannelRDMA *qio_channel_rdma_new(void)
 {
     QIOChannelRDMA *rioc;
     QIOChannel *ioc;
 
+    qio_channel_rdma_rpoller_start();
+    if (!rpoller.is_running) {
+        return NULL;
+    }
+
     rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
     ioc = QIO_CHANNEL(rioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -125,6 +393,8 @@ retry:
         goto out;
     }
 
+    qio_channel_rdma_add_rioc_to_rpoller(rioc);
+
 out:
     if (ret) {
         trace_qio_channel_rdma_connect_fail(rioc);
@@ -211,6 +481,8 @@ int qio_channel_rdma_listen_sync(QIOChannelRDMA *rioc, InetSocketAddress *addr,
     qio_channel_set_feature(QIO_CHANNEL(rioc), QIO_CHANNEL_FEATURE_LISTEN);
     trace_qio_channel_rdma_listen_complete(rioc, fd);
 
+    qio_channel_rdma_add_rioc_to_rpoller(rioc);
+
 out:
     if (ret) {
         trace_qio_channel_rdma_listen_fail(rioc);
@@ -267,8 +539,10 @@ void qio_channel_rdma_listen_async(QIOChannelRDMA *ioc, InetSocketAddress *addr,
                            qio_channel_listen_worker_free, context);
 }
 
-QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *rioc, Error **errp)
+QIOChannelRDMA *coroutine_mixed_fn qio_channel_rdma_accept(QIOChannelRDMA *rioc,
+                                                           Error **errp)
 {
+    QIOChannel *ioc = QIO_CHANNEL(rioc);
     QIOChannelRDMA *cioc;
 
     cioc = qio_channel_rdma_new();
@@ -283,6 +557,17 @@ retry:
         if (errno == EINTR) {
             goto retry;
         }
+        if (errno == EAGAIN) {
+            if (!(rioc->rpoll_events & POLLIN)) {
+                qio_channel_rdma_update_poll_event(rioc, CLEAR_POLLIN, true);
+            }
+            if (qemu_in_coroutine()) {
+                qio_channel_yield(ioc, G_IO_IN);
+            } else {
+                qio_channel_wait(ioc, G_IO_IN);
+            }
+            goto retry;
+        }
         error_setg_errno(errp, errno, "Unable to accept connection");
         goto error;
     }
@@ -294,6 +579,8 @@ retry:
         goto error;
     }
 
+    qio_channel_rdma_add_rioc_to_rpoller(cioc);
+
     trace_qio_channel_rdma_accept_complete(rioc, cioc, cioc->fd);
     return cioc;
 
@@ -307,6 +594,10 @@ static void qio_channel_rdma_init(Object *obj)
 {
     QIOChannelRDMA *ioc = QIO_CHANNEL_RDMA(obj);
     ioc->fd = -1;
+    ioc->pollin_eventfd = -1;
+    ioc->pollout_eventfd = -1;
+    ioc->index = -1;
+    ioc->rpoll_events = 0;
 }
 
 static void qio_channel_rdma_finalize(Object *obj)
@@ -314,6 +605,7 @@ static void qio_channel_rdma_finalize(Object *obj)
     QIOChannelRDMA *ioc = QIO_CHANNEL_RDMA(obj);
 
     if (ioc->fd != -1) {
+        qio_channel_rdma_notify_rpoller(ioc, RP_CMD_DEL_IOC);
         rclose(ioc->fd);
         ioc->fd = -1;
     }
@@ -330,6 +622,12 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc, const struct iovec *iov,
 retry:
     ret = rreadv(rioc->fd, iov, niov);
     if (ret < 0) {
+        if (errno == EAGAIN) {
+            if (!(rioc->rpoll_events & POLLIN)) {
+                qio_channel_rdma_update_poll_event(rioc, CLEAR_POLLIN, true);
+            }
+            return QIO_CHANNEL_ERR_BLOCK;
+        }
         if (errno == EINTR) {
             goto retry;
         }
@@ -351,6 +649,12 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc, const struct iovec *iov,
 retry:
     ret = rwritev(rioc->fd, iov, niov);
     if (ret <= 0) {
+        if (errno == EAGAIN) {
+            if (!(rioc->rpoll_events & POLLOUT)) {
+                qio_channel_rdma_update_poll_event(rioc, CLEAR_POLLOUT, true);
+            }
+            return QIO_CHANNEL_ERR_BLOCK;
+        }
         if (errno == EINTR) {
             goto retry;
         }
@@ -361,6 +665,28 @@ retry:
     return ret;
 }
 
+static int qio_channel_rdma_set_blocking(QIOChannel *ioc, bool enabled,
+                                         Error **errp G_GNUC_UNUSED)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+    int flags, ret;
+
+    flags = rfcntl(rioc->fd, F_GETFL);
+    if (enabled) {
+        flags &= ~O_NONBLOCK;
+    } else {
+        flags |= O_NONBLOCK;
+    }
+
+    ret = rfcntl(rioc->fd, F_SETFL, flags);
+    if (ret) {
+        error_setg_errno(errp, errno,
+                         "Unable to rfcntl rsocket fd with flags %d", flags);
+    }
+
+    return ret;
+}
+
 static void qio_channel_rdma_set_delay(QIOChannel *ioc, bool enabled)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
@@ -374,6 +700,7 @@ static int qio_channel_rdma_close(QIOChannel *ioc, Error **errp)
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
 
     if (rioc->fd != -1) {
+        qio_channel_rdma_notify_rpoller(rioc, RP_CMD_DEL_IOC);
         rclose(rioc->fd);
         rioc->fd = -1;
     }
@@ -408,6 +735,37 @@ static int qio_channel_rdma_shutdown(QIOChannel *ioc, QIOChannelShutdown how,
     return 0;
 }
 
+static void
+qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc, AioContext *read_ctx,
+                                    IOHandler *io_read, AioContext *write_ctx,
+                                    IOHandler *io_write, void *opaque)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+
+    qio_channel_util_set_aio_fd_handler(rioc->pollin_eventfd, read_ctx, io_read,
+                                        rioc->pollout_eventfd, write_ctx,
+                                        io_write, opaque);
+}
+
+static GSource *qio_channel_rdma_create_watch(QIOChannel *ioc,
+                                              GIOCondition condition)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+
+    switch (condition) {
+    case G_IO_IN:
+        return qio_channel_create_fd_watch(ioc, rioc->pollin_eventfd,
+                                           condition);
+    case G_IO_OUT:
+        return qio_channel_create_fd_watch(ioc, rioc->pollout_eventfd,
+                                           condition);
+    default:
+        error_report("%s: do not support watch 0x%x event", __func__,
+                     condition);
+        return NULL;
+    }
+}
+
 static void qio_channel_rdma_class_init(ObjectClass *klass,
                                         void *class_data G_GNUC_UNUSED)
 {
@@ -415,9 +773,12 @@ static void qio_channel_rdma_class_init(ObjectClass *klass,
 
     ioc_klass->io_writev = qio_channel_rdma_writev;
     ioc_klass->io_readv = qio_channel_rdma_readv;
+    ioc_klass->io_set_blocking = qio_channel_rdma_set_blocking;
     ioc_klass->io_close = qio_channel_rdma_close;
     ioc_klass->io_shutdown = qio_channel_rdma_shutdown;
     ioc_klass->io_set_delay = qio_channel_rdma_set_delay;
+    ioc_klass->io_create_watch = qio_channel_rdma_create_watch;
+    ioc_klass->io_set_aio_fd_handler = qio_channel_rdma_set_aio_fd_handler;
 }
 
 static const TypeInfo qio_channel_rdma_info = {
-- 
2.43.0


