Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA81CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqjL-0005bi-5E; Wed, 17 Sep 2025 07:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyqi1-00035V-CW
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyqhw-0003km-DL
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758109938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDt16D/xIlibpM+anFgsGni23NbiYIHZWAx38JCMgPE=;
 b=TwfRAFYc4Kj30aDWJ3/x5K3p8l+LZ8D2MofX1lhrczsxRbrj+LPszaxo1Vfd6RBlXTCZnA
 4zl45qmYQq1gjYbvBh5i2lBBcgYP6dvVBck96fMpscOOATt+SiqyU+Gkr2BTjWuqPE7i8/
 vjT7Vd7vBHejk2gBvr9+qbKKOymzAA0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-dRZJUoC6Phia63GhCtIx3A-1; Wed,
 17 Sep 2025 07:52:14 -0400
X-MC-Unique: dRZJUoC6Phia63GhCtIx3A-1
X-Mimecast-MFC-AGG-ID: dRZJUoC6Phia63GhCtIx3A_1758109934
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCB7A19560A1; Wed, 17 Sep 2025 11:52:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5783B195608E; Wed, 17 Sep 2025 11:52:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6432B21E66D4; Wed, 17 Sep 2025 13:52:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com
Subject: [PATCH v2 12/12] error: Kill @error_warn
Date: Wed, 17 Sep 2025 13:52:07 +0200
Message-ID: <20250917115207.1730186-13-armbru@redhat.com>
In-Reply-To: <20250917115207.1730186-1-armbru@redhat.com>
References: <20250917115207.1730186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We added @error_warn some two years ago in commit 3ffef1a55ca (error:
add global &error_warn destination).  It has multiple issues:

* error.h's big comment was not updated for it.

* Function contracts were not updated for it.

* ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
  error_prepend() and such.  These crash on @error_warn, as pointed
  out by Akihiko Odaki.

All fixable.  However, after more than two years, we had just of 15
uses, of which the last few patches removed seven as unclean or
otherwise undesirable, adding back five elsewhere.  I didn't look
closely enough at the remaining seven to decide whether they are
desirable or not.

I don't think this feature earns its keep.  Drop it.

Thanks-to: Akihiko  Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/error.h           |  6 ------
 include/system/os-win32.h      |  5 ++++-
 hw/display/virtio-gpu.c        |  8 ++++++--
 hw/net/virtio-net.c            |  8 +++++++-
 io/channel-socket.c            |  4 ++--
 io/channel-watch.c             |  6 +++---
 tests/unit/test-error-report.c | 17 -----------------
 ui/gtk.c                       |  6 +++++-
 util/aio-win32.c               |  2 +-
 util/error.c                   |  5 +----
 util/oslib-win32.c             | 21 ++++++++++++++++++++-
 11 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 41e3816380..b16c6303f8 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -533,12 +533,6 @@ static inline void error_propagator_cleanup(ErrorPropagator *prop)
 
 G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
 
-/*
- * Special error destination to warn on error.
- * See error_setg() and error_propagate() for details.
- */
-extern Error *error_warn;
-
 /*
  * Special error destination to abort on error.
  * See error_setg() and error_propagate() for details.
diff --git a/include/system/os-win32.h b/include/system/os-win32.h
index 3aa6cee4c2..22d72babdf 100644
--- a/include/system/os-win32.h
+++ b/include/system/os-win32.h
@@ -168,11 +168,14 @@ static inline void qemu_funlockfile(FILE *f)
 #endif
 }
 
-/* Helper for WSAEventSelect, to report errors */
+/* Helpers for WSAEventSelect() */
 bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
                         long lNetworkEvents, Error **errp);
+void qemu_socket_select_nofail(int sockfd, WSAEVENT hEventObject,
+                               long lNetworkEvents);
 
 bool qemu_socket_unselect(int sockfd, Error **errp);
+void qemu_socket_unselect_nofail(int sockfd);
 
 /* We wrap all the sockets functions so that we can set errno based on
  * WSAGetLastError(), and use file-descriptors instead of SOCKET.
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0a1a625b0e..de35902213 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -242,6 +242,7 @@ static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command *cmd)
 {
+    Error *err = NULL;
     pixman_format_code_t pformat;
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_resource_create_2d c2d;
@@ -293,7 +294,8 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                 c2d.width,
                 c2d.height,
                 c2d.height ? res->hostmem / c2d.height : 0,
-                &error_warn)) {
+                &err)) {
+            warn_report_err(err);
             goto end;
         }
     }
@@ -1282,6 +1284,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
                            const VMStateField *field)
 {
     VirtIOGPU *g = opaque;
+    Error *err = NULL;
     struct virtio_gpu_simple_resource *res;
     uint32_t resource_id, pformat;
     int i;
@@ -1317,7 +1320,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
                                              res->width,
                                              res->height,
                                              res->height ? res->hostmem / res->height : 0,
-                                             &error_warn)) {
+                                             &err)) {
+            warn_report_err(err);
             g_free(res);
             return -EINVAL;
         }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6b5b5dace3..7848e26278 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1289,6 +1289,8 @@ exit:
 
 static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
 {
+    Error *err = NULL;
+
     if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
         return true;
     }
@@ -1306,7 +1308,11 @@ static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
         return virtio_net_load_ebpf_fds(n, errp);
     }
 
-    ebpf_rss_load(&n->ebpf_rss, &error_warn);
+    ebpf_rss_load(&n->ebpf_rss, &err);
+    /* Beware, ebpf_rss_load() can return false with @err unset */
+    if (err) {
+        warn_report_err(err);
+    }
     return true;
 }
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 56ef353cd3..c21592d141 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -454,7 +454,7 @@ static void qio_channel_socket_finalize(Object *obj)
             }
         }
 #ifdef WIN32
-        qemu_socket_unselect(ioc->fd, &error_warn);
+        qemu_socket_unselect_nofail(ioc->fd);
 #endif
         close(ioc->fd);
         ioc->fd = -1;
@@ -890,7 +890,7 @@ qio_channel_socket_close(QIOChannel *ioc,
 
     if (sioc->fd != -1) {
 #ifdef WIN32
-        qemu_socket_unselect(sioc->fd, &error_warn);
+        qemu_socket_unselect_nofail(sioc->fd);
 #endif
         if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_LISTEN)) {
             socket_listen_cleanup(sioc->fd, errp);
diff --git a/io/channel-watch.c b/io/channel-watch.c
index ec76bd1ec6..018648b36b 100644
--- a/io/channel-watch.c
+++ b/io/channel-watch.c
@@ -281,9 +281,9 @@ GSource *qio_channel_create_socket_watch(QIOChannel *ioc,
     GSource *source;
     QIOChannelSocketSource *ssource;
 
-    qemu_socket_select(sockfd, ioc->event,
-                       FD_READ | FD_ACCEPT | FD_CLOSE |
-                       FD_CONNECT | FD_WRITE | FD_OOB, &error_warn);
+    qemu_socket_select_nofail(sockfd, ioc->event,
+                              FD_READ | FD_ACCEPT | FD_CLOSE |
+                              FD_CONNECT | FD_WRITE | FD_OOB);
 
     source = g_source_new(&qio_channel_socket_source_funcs,
                           sizeof(QIOChannelSocketSource));
diff --git a/tests/unit/test-error-report.c b/tests/unit/test-error-report.c
index 54319c86c9..0cbde3c4cf 100644
--- a/tests/unit/test-error-report.c
+++ b/tests/unit/test-error-report.c
@@ -104,22 +104,6 @@ test_error_report_timestamp(void)
 ");
 }
 
-static void
-test_error_warn(void)
-{
-    if (g_test_subprocess()) {
-        error_setg(&error_warn, "Testing &error_warn");
-        return;
-    }
-
-    g_test_trap_subprocess(NULL, 0, 0);
-    g_test_trap_assert_passed();
-    g_test_trap_assert_stderr("\
-test-error-report: warning: Testing &error_warn*\
-");
-}
-
-
 int
 main(int argc, char *argv[])
 {
@@ -133,7 +117,6 @@ main(int argc, char *argv[])
     g_test_add_func("/error-report/glog", test_error_report_glog);
     g_test_add_func("/error-report/once", test_error_report_once);
     g_test_add_func("/error-report/timestamp", test_error_report_timestamp);
-    g_test_add_func("/error-report/warn", test_error_warn);
 
     return g_test_run();
 }
diff --git a/ui/gtk.c b/ui/gtk.c
index e91d093a49..9a08cadc88 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1181,6 +1181,7 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
                                void *opaque)
 {
     VirtualConsole *vc = opaque;
+    Error *err = NULL;
     uint64_t num_slot = GPOINTER_TO_UINT(touch->sequence);
     int type = -1;
 
@@ -1203,7 +1204,10 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
     console_handle_touch_event(vc->gfx.dcl.con, touch_slots,
                                num_slot, surface_width(vc->gfx.ds),
                                surface_height(vc->gfx.ds), touch->x,
-                               touch->y, type, &error_warn);
+                               touch->y, type, &err);
+    if (err) {
+        warn_report_err(err);
+    }
     return TRUE;
 }
 
diff --git a/util/aio-win32.c b/util/aio-win32.c
index b125924433..c6fbce64c2 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -121,7 +121,7 @@ void aio_set_fd_handler(AioContext *ctx,
 
         QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
         event = event_notifier_get_handle(&ctx->notifier);
-        qemu_socket_select(fd, event, bitmask, &error_warn);
+        qemu_socket_select_nofail(fd, event, bitmask);
     }
     if (old_node) {
         aio_remove_fd_handler(ctx, old_node);
diff --git a/util/error.c b/util/error.c
index daea2142f3..0ae08225c0 100644
--- a/util/error.c
+++ b/util/error.c
@@ -19,7 +19,6 @@
 
 Error *error_abort;
 Error *error_fatal;
-Error *error_warn;
 
 static void error_handle(Error **errp, Error *err)
 {
@@ -41,9 +40,7 @@ static void error_handle(Error **errp, Error *err)
         error_report_err(err);
         exit(1);
     }
-    if (errp == &error_warn) {
-        warn_report_err(err);
-    } else if (errp && !*errp) {
+    if (errp && !*errp) {
         *errp = err;
     } else {
         error_free(err);
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index df118b164e..e6109cc2cc 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -181,7 +181,7 @@ void qemu_socket_set_block(int fd)
 {
     unsigned long opt = 0;
 
-    qemu_socket_unselect(fd, &error_warn);
+    qemu_socket_unselect_nofail(fd);
     ioctlsocket(fd, FIONBIO, &opt);
 }
 
@@ -315,6 +315,25 @@ bool qemu_socket_unselect(int sockfd, Error **errp)
     return qemu_socket_select(sockfd, NULL, 0, errp);
 }
 
+void qemu_socket_select_nofail(int sockfd, WSAEVENT hEventObject,
+                               long lNetworkEvents)
+{
+    Error *err = NULL;
+
+    if (!qemu_socket_select(sockfd, hEventObject, lNetworkEvents, &err)) {
+        warn_report_err(err);
+    }
+}
+
+void qemu_socket_unselect_nofail(int sockfd)
+{
+    Error *err = NULL;
+
+    if (!qemu_socket_unselect(sockfd, &err)) {
+        warn_report_err(err);
+    }
+}
+
 int qemu_socketpair(int domain, int type, int protocol, int sv[2])
 {
     struct sockaddr_un addr = {
-- 
2.49.0


