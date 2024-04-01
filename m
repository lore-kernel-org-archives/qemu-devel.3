Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A036CD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 12:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrGsb-0000LA-1D; Mon, 01 Apr 2024 08:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rrGs5-0008Kd-D1; Mon, 01 Apr 2024 08:34:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rrGs1-0000gO-Eb; Mon, 01 Apr 2024 08:34:41 -0400
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V7Vms1D2Jz1GFPy;
 Mon,  1 Apr 2024 20:33:49 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (unknown [7.185.36.84])
 by mail.maildlp.com (Postfix) with ESMTPS id 8F58C1A016C;
 Mon,  1 Apr 2024 20:34:25 +0800 (CST)
Received: from huawei.com (10.91.158.201) by dggpeml500011.china.huawei.com
 (7.185.36.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 20:34:24 +0800
To: <zhuyangyang14@huawei.com>
CC: <eblake@redhat.com>, <stefanha@redhat.com>, <qemu-block@nongnu.org>,
 <qemu-devel@nongnu.org>, <vsementsov@yandex-team.ru>, <kwolf@redhat.com>,
 <luolongmin@huawei.com>, <suxiaodong1@huawei.com>, <chenxiaoyu48@huawei.com>, 
 <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>
Subject: [PATCH v2 1/1] nbd/server: do not poll within a coroutine context
Date: Mon, 1 Apr 2024 20:41:20 +0800
Message-ID: <20240401124120.4020988-1-zhuyangyang14@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240401123342.3947762-1-zhuyangyang14@huawei.com>
References: <20240401123342.3947762-1-zhuyangyang14@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.91.158.201]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500011.china.huawei.com (7.185.36.84)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhuyangyang14@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Zhu Yangyang <zhuyangyang14@huawei.com>
From:  Zhu Yangyang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Coroutines are not supposed to block. Instead, they should yield.

Fixes: f95910f ("nbd: implement TLS support in the protocol negotiation")
Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
---
 nbd/client.c       |  7 ++++---
 nbd/common.c       | 19 ++++++++++++++++---
 nbd/nbd-internal.h |  6 +++---
 nbd/server.c       | 10 +++++-----
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 29ffc609a4..1ab91ed205 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -619,18 +619,19 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
         return NULL;
     }
     qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-client-tls");
-    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
     trace_nbd_receive_starttls_tls_handshake();
     qio_channel_tls_handshake(tioc,
-                              nbd_tls_handshake,
+                              nbd_client_tls_handshake,
                               &data,
                               NULL,
                               NULL);
 
     if (!data.complete) {
+        data.loop = g_main_loop_new(g_main_context_default(), FALSE);
         g_main_loop_run(data.loop);
+        g_main_loop_unref(data.loop);
     }
-    g_main_loop_unref(data.loop);
+
     if (data.error) {
         error_propagate(errp, data.error);
         object_unref(OBJECT(tioc));
diff --git a/nbd/common.c b/nbd/common.c
index 3247c1d618..01ca30a5c4 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -47,14 +47,27 @@ int nbd_drop(QIOChannel *ioc, size_t size, Error **errp)
 }
 
 
-void nbd_tls_handshake(QIOTask *task,
-                       void *opaque)
+void nbd_client_tls_handshake(QIOTask *task, void *opaque)
 {
     struct NBDTLSHandshakeData *data = opaque;
 
     qio_task_propagate_error(task, &data->error);
     data->complete = true;
-    g_main_loop_quit(data->loop);
+    if (data->loop) {
+        g_main_loop_quit(data->loop);
+    }
+}
+
+
+void nbd_server_tls_handshake(QIOTask *task, void *opaque)
+{
+    struct NBDTLSHandshakeData *data = opaque;
+
+    qio_task_propagate_error(task, &data->error);
+    data->complete = true;
+    if (!qemu_coroutine_entered(data->co)) {
+        aio_co_wake(data->co);
+    }
 }
 
 
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index dfa02f77ee..99cca9382c 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -74,13 +74,13 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
 
 struct NBDTLSHandshakeData {
     GMainLoop *loop;
+    Coroutine *co;
     bool complete;
     Error *error;
 };
 
-
-void nbd_tls_handshake(QIOTask *task,
-                       void *opaque);
+void nbd_server_tls_handshake(QIOTask *task, void *opaque);
+void nbd_client_tls_handshake(QIOTask *task, void *opaque);
 
 int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
 
diff --git a/nbd/server.c b/nbd/server.c
index c3484cc1eb..b218512ced 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -777,17 +777,17 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
 
     qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-server-tls");
     trace_nbd_negotiate_handle_starttls_handshake();
-    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
+    data.co = qemu_coroutine_self();
     qio_channel_tls_handshake(tioc,
-                              nbd_tls_handshake,
+                              nbd_server_tls_handshake,
                               &data,
                               NULL,
                               NULL);
 
-    if (!data.complete) {
-        g_main_loop_run(data.loop);
+    while (!data.complete) {
+        qemu_coroutine_yield();
     }
-    g_main_loop_unref(data.loop);
+
     if (data.error) {
         object_unref(OBJECT(tioc));
         error_propagate(errp, data.error);
-- 
2.33.0


