Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7DEC83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 08:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYh1N-0000Jr-Dm; Mon, 07 Jul 2025 04:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh1F-0000Ic-NE
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh1B-0007UH-Ee
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751876164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnYydR4V0quatpugzQCe28351azNl+MR44OzIdbCWKg=;
 b=fE362Y0AHnWwFBSymU+quuUtDNqr7i+I8zLyG/JPjLH7U/GGDEAzm9KxLnci9kdwvjzlTq
 a+qgwSWNnQOggKAnXmjKhx1II5SnUdLy4CNZbQ66wiewhpv5s3QArUPMkxvQzqwG4/iCJ1
 SyIP2WkhOyoEAdJiezxaJJmS1lg1aUs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-3tXYiOvCM0O_MMp4guyHSw-1; Mon,
 07 Jul 2025 04:16:03 -0400
X-MC-Unique: 3tXYiOvCM0O_MMp4guyHSw-1
X-Mimecast-MFC-AGG-ID: 3tXYiOvCM0O_MMp4guyHSw_1751876162
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 208C71944AA5; Mon,  7 Jul 2025 08:16:02 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.147])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24AA71803AF2; Mon,  7 Jul 2025 08:15:57 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 10/11] net: Add passt network backend
Date: Mon,  7 Jul 2025 10:15:04 +0200
Message-ID: <20250707081505.127519-11-lvivier@redhat.com>
In-Reply-To: <20250707081505.127519-1-lvivier@redhat.com>
References: <20250707081505.127519-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This commit introduces support for passt as a new network backend.
passt is an unprivileged, user-mode networking solution that provides
connectivity for virtual machines by launching an external helper process.

The implementation reuses the generic stream data handling logic. It
launches the passt binary using GSubprocess, passing it a file
descriptor from a socketpair() for communication. QEMU connects to
the other end of the socket pair to establish the network data stream.

The PID of the passt daemon is tracked via a temporary file to
ensure it is terminated when QEMU exits.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 docs/system/devices/net.rst   |  40 +++++-
 hmp-commands.hx               |   3 +
 meson.build                   |   6 +
 meson_options.txt             |   2 +
 net/clients.h                 |   4 +
 net/hub.c                     |   3 +
 net/meson.build               |   3 +
 net/net.c                     |   4 +
 net/passt.c                   | 241 ++++++++++++++++++++++++++++++++++
 qapi/net.json                 |  25 ++++
 qemu-options.hx               |  44 ++++++-
 scripts/meson-buildoptions.sh |   3 +
 12 files changed, 374 insertions(+), 4 deletions(-)
 create mode 100644 net/passt.c

diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
index a3efbdcabd1a..255ac9b8d1ed 100644
--- a/docs/system/devices/net.rst
+++ b/docs/system/devices/net.rst
@@ -85,13 +85,49 @@ passt doesn't require any capability or privilege. passt has
 better performance than ``-net user``, full IPv6 support and better security
 as it's a daemon that is not executed in QEMU context.
 
-passt can be connected to QEMU either by using a socket
-(``-netdev stream``) or using the vhost-user interface (``-netdev vhost-user``).
+passt_ can be used in the same way as the user backend (using ``-net passt``,
+``-netdev passt`` or ``-nic passt``) or it can be launched manually and
+connected to QEMU either by using a socket (``-netdev stream``) or by using
+the vhost-user interface (``-netdev vhost-user``).
+
+Using ``-netdev stream`` or ``-netdev vhost-user`` will allow the user to
+enable functionalities not available through the passt backend interface
+(like migration).
+
 See `passt(1)`_ for more details on passt.
 
 .. _passt: https://passt.top/
 .. _passt(1): https://passt.top/builds/latest/web/passt.1.html
 
+To use the passt backend interface
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+There is no need to start the daemon as QEMU will do it for you.
+
+passt is started in the socket-based mode.
+
+.. parsed-literal::
+   |qemu_system| [...OPTIONS...] -nic passt
+
+   (qemu) info network
+   e1000e.0: index=0,type=nic,model=e1000e,macaddr=52:54:00:12:34:56
+    \ #net071: index=0,type=passt,stream,connected to pid 24846
+
+.. parsed-literal::
+   |qemu_system| [...OPTIONS...] -net nic -net passt,param=--tcp-ports=10001,param=udp-ports=10001
+
+   (qemu) info network
+   hub 0
+    \ hub0port1: #net136: index=0,type=passt,stream,connected to pid 25204
+    \ hub0port0: e1000e.0: index=0,type=nic,model=e1000e,macaddr=52:54:00:12:34:56
+
+.. parsed-literal::
+   |qemu_system| [...OPTIONS...] -netdev passt,id=netdev0 -device virtio-net,mac=9a:2b:2c:2d:2e:2f,id=virtio0,netdev=netdev0
+
+   (qemu) info network
+   virtio0: index=0,type=nic,model=virtio-net-pci,macaddr=9a:2b:2c:2d:2e:2f
+    \ netdev0: index=0,type=passt,stream,connected to pid 25428
+
 To use socket based passt interface:
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 06746f0afc37..d0e4f35a30af 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1287,6 +1287,9 @@ ERST
         .name       = "netdev_add",
         .args_type  = "netdev:O",
         .params     = "[user|tap|socket|stream|dgram|vde|bridge|hubport|netmap|vhost-user"
+#ifdef CONFIG_PASST
+                      "|passt"
+#endif
 #ifdef CONFIG_AF_XDP
                       "|af-xdp"
 #endif
diff --git a/meson.build b/meson.build
index dbc97bfdf7a0..3dd533e57184 100644
--- a/meson.build
+++ b/meson.build
@@ -1285,6 +1285,10 @@ if not get_option('slirp').auto() or have_system
   endif
 endif
 
+enable_passt = get_option('passt') \
+  .require(host_os == 'linux', error_message: 'passt is supported only on Linux') \
+  .allowed()
+
 vde = not_found
 if not get_option('vde').auto() or have_system or have_tools
   vde = cc.find_library('vdeplug', has_headers: ['libvdeplug.h'],
@@ -2538,6 +2542,7 @@ if seccomp.found()
   config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
 endif
 config_host_data.set('CONFIG_PIXMAN', pixman.found())
+config_host_data.set('CONFIG_PASST', enable_passt)
 config_host_data.set('CONFIG_SLIRP', slirp.found())
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
 config_host_data.set('CONFIG_SOLARIS', host_os == 'sunos')
@@ -4925,6 +4930,7 @@ if host_os == 'darwin'
   summary_info += {'vmnet.framework support': vmnet}
 endif
 summary_info += {'AF_XDP support':    libxdp}
+summary_info += {'passt support':     enable_passt}
 summary_info += {'slirp support':     slirp}
 summary_info += {'vde support':       vde}
 summary_info += {'netmap support':    have_netmap}
diff --git a/meson_options.txt b/meson_options.txt
index a442be29958f..3146eec19440 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -234,6 +234,8 @@ option('pixman', type : 'feature', value : 'auto',
        description: 'pixman support')
 option('slirp', type: 'feature', value: 'auto',
        description: 'libslirp user mode network backend support')
+option('passt', type: 'feature', value: 'auto',
+       description: 'passt network backend support')
 option('vde', type : 'feature', value : 'auto',
        description: 'vde network backend support')
 option('vmnet', type : 'feature', value : 'auto',
diff --git a/net/clients.h b/net/clients.h
index be53794582cf..e786ab420352 100644
--- a/net/clients.h
+++ b/net/clients.h
@@ -29,6 +29,10 @@
 int net_init_dump(const Netdev *netdev, const char *name,
                   NetClientState *peer, Error **errp);
 
+#ifdef CONFIG_PASST
+int net_init_passt(const Netdev *netdev, const char *name,
+                   NetClientState *peer, Error **errp);
+#endif
 #ifdef CONFIG_SLIRP
 int net_init_slirp(const Netdev *netdev, const char *name,
                    NetClientState *peer, Error **errp);
diff --git a/net/hub.c b/net/hub.c
index cba20ebd874f..e3b58b1c4f8e 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -285,6 +285,9 @@ void net_hub_check_clients(void)
             case NET_CLIENT_DRIVER_NIC:
                 has_nic = 1;
                 break;
+#ifdef CONFIG_PASST
+            case NET_CLIENT_DRIVER_PASST:
+#endif
             case NET_CLIENT_DRIVER_USER:
             case NET_CLIENT_DRIVER_TAP:
             case NET_CLIENT_DRIVER_SOCKET:
diff --git a/net/meson.build b/net/meson.build
index bb3c011e5a30..da6ea635e95d 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -34,6 +34,9 @@ system_ss.add(when: 'CONFIG_TCG', if_true: files('filter-replay.c'))
 if have_l2tpv3
   system_ss.add(files('l2tpv3.c'))
 endif
+if enable_passt
+  system_ss.add(files('passt.c'))
+endif
 system_ss.add(when: slirp, if_true: files('slirp.c'))
 system_ss.add(when: vde, if_true: files('vde.c'))
 if have_netmap
diff --git a/net/net.c b/net/net.c
index cfa2d8e95827..90f69fdf39b0 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1248,6 +1248,9 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
     const char *name,
     NetClientState *peer, Error **errp) = {
         [NET_CLIENT_DRIVER_NIC]       = net_init_nic,
+#ifdef CONFIG_PASST
+        [NET_CLIENT_DRIVER_PASST]     = net_init_passt,
+#endif
 #ifdef CONFIG_SLIRP
         [NET_CLIENT_DRIVER_USER]      = net_init_slirp,
 #endif
@@ -1353,6 +1356,7 @@ void show_netdevs(void)
         "dgram",
         "hubport",
         "tap",
+        "passt",
 #ifdef CONFIG_SLIRP
         "user",
 #endif
diff --git a/net/passt.c b/net/passt.c
new file mode 100644
index 000000000000..4936825d681c
--- /dev/null
+++ b/net/passt.c
@@ -0,0 +1,241 @@
+/*
+ * passt network backend
+ *
+ * Copyright Red Hat
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+#include <gio/gio.h>
+#include "net/net.h"
+#include "clients.h"
+#include "qapi/error.h"
+#include "io/net-listener.h"
+#include "stream_data.h"
+
+typedef struct NetPasstState {
+    NetStreamData data;
+    GPtrArray *args;
+    gchar *pidfile;
+    pid_t pid;
+} NetPasstState;
+
+static int net_passt_stream_start(NetPasstState *s, Error **errp);
+
+static void net_passt_cleanup(NetClientState *nc)
+{
+    NetPasstState *s = DO_UPCAST(NetPasstState, data.nc, nc);
+
+    kill(s->pid, SIGTERM);
+    g_remove(s->pidfile);
+    g_free(s->pidfile);
+    g_ptr_array_free(s->args, TRUE);
+}
+
+static ssize_t net_passt_receive(NetClientState *nc, const uint8_t *buf,
+                                  size_t size)
+{
+    NetStreamData *d = DO_UPCAST(NetStreamData, nc, nc);
+
+    return net_stream_data_receive(d, buf, size);
+}
+
+static gboolean net_passt_send(QIOChannel *ioc, GIOCondition condition,
+                                gpointer data)
+{
+    if (net_stream_data_send(ioc, condition, data) == G_SOURCE_REMOVE) {
+        NetPasstState *s = DO_UPCAST(NetPasstState, data, data);
+        Error *error;
+
+        /* we need to restart passt */
+        kill(s->pid, SIGTERM);
+        if (net_passt_stream_start(s, &error) == -1) {
+            error_report_err(error);
+        }
+
+        return G_SOURCE_REMOVE;
+    }
+
+    return G_SOURCE_CONTINUE;
+}
+
+static NetClientInfo net_passt_info = {
+    .type = NET_CLIENT_DRIVER_PASST,
+    .size = sizeof(NetPasstState),
+    .receive = net_passt_receive,
+    .cleanup = net_passt_cleanup,
+};
+
+static void net_passt_client_connected(QIOTask *task, gpointer opaque)
+{
+    NetPasstState *s = opaque;
+
+    if (net_stream_data_client_connected(task, &s->data) == 0) {
+        qemu_set_info_str(&s->data.nc, "stream,connected to pid %d", s->pid);
+    }
+}
+
+static int net_passt_start_daemon(NetPasstState *s, int sock, Error **errp)
+{
+    g_autoptr(GSubprocess) daemon = NULL;
+    g_autofree gchar *contents = NULL;
+    g_autoptr(GError) error = NULL;
+    GSubprocessLauncher *launcher;
+
+    qemu_set_info_str(&s->data.nc, "launching passt");
+
+    launcher = g_subprocess_launcher_new(G_SUBPROCESS_FLAGS_NONE);
+    g_subprocess_launcher_take_fd(launcher, sock, 3);
+
+    daemon =  g_subprocess_launcher_spawnv(launcher,
+                                           (const gchar *const *)s->args->pdata,
+                                           &error);
+    g_object_unref(launcher);
+
+    if (!daemon) {
+        error_setg(errp, "Error creating daemon: %s", error->message);
+        return -1;
+    }
+
+    if (!g_subprocess_wait(daemon, NULL, &error)) {
+        error_setg(errp, "Error waiting for daemon: %s", error->message);
+        return -1;
+    }
+
+    if (g_subprocess_get_if_exited(daemon) &&
+        g_subprocess_get_exit_status(daemon)) {
+        return -1;
+    }
+
+    if (!g_file_get_contents(s->pidfile, &contents, NULL, &error)) {
+        error_setg(errp, "Cannot read passt pid: %s", error->message);
+        return -1;
+    }
+
+    s->pid = (pid_t)g_ascii_strtoll(contents, NULL, 10);
+    if (s->pid <= 0) {
+        error_setg(errp, "File '%s' did not contain a valid PID.", s->pidfile);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int net_passt_stream_start(NetPasstState *s, Error **errp)
+{
+    QIOChannelSocket *sioc;
+    SocketAddress *addr;
+    int sv[2];
+
+    if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) == -1) {
+        error_setg_errno(errp, errno, "socketpair() failed");
+        return -1;
+    }
+
+    /* connect to passt */
+    qemu_set_info_str(&s->data.nc, "connecting to passt");
+
+    /* create socket channel */
+    sioc = qio_channel_socket_new();
+    s->data.ioc = QIO_CHANNEL(sioc);
+    s->data.nc.link_down = true;
+    s->data.send = net_passt_send;
+
+    addr = g_new0(SocketAddress, 1);
+    addr->type = SOCKET_ADDRESS_TYPE_FD;
+    addr->u.fd.str = g_strdup_printf("%d", sv[0]);
+
+    qio_channel_socket_connect_async(sioc, addr,
+                                     net_passt_client_connected, s,
+                                     NULL, NULL);
+
+    qapi_free_SocketAddress(addr);
+
+    /* start passt */
+    if (net_passt_start_daemon(s, sv[1], errp) == -1) {
+        close(sv[0]);
+        close(sv[1]);
+        return -1;
+    }
+    close(sv[1]);
+
+    return 0;
+}
+
+static GPtrArray *net_passt_decode_args(const NetDevPasstOptions *passt,
+                                        gchar *pidfile, Error **errp)
+{
+    GPtrArray *args = g_ptr_array_new_with_free_func(g_free);
+
+    if (passt->path) {
+        g_ptr_array_add(args, g_strdup(passt->path));
+    } else {
+        g_ptr_array_add(args, g_strdup("passt"));
+    }
+
+    /* by default, be quiet */
+    if (!passt->has_quiet || passt->quiet) {
+        g_ptr_array_add(args, g_strdup("--quiet"));
+    }
+
+    if (passt->has_param && passt->param) {
+        const StringList *list = passt->param;
+
+        while (list) {
+            g_ptr_array_add(args, g_strdup(list->value->str));
+            list = list->next;
+        }
+    }
+
+    /* provide a pid file to be able to kil passt on exit */
+    g_ptr_array_add(args, g_strdup("--pid"));
+    g_ptr_array_add(args, g_strdup(pidfile));
+
+    /* g_subprocess_launcher_take_fd() will set the socket on fd 3 */
+    g_ptr_array_add(args, g_strdup("--fd"));
+    g_ptr_array_add(args, g_strdup("3"));
+
+    g_ptr_array_add(args, NULL);
+
+    return args;
+}
+
+int net_init_passt(const Netdev *netdev, const char *name,
+                   NetClientState *peer, Error **errp)
+{
+    g_autoptr(GError) error = NULL;
+    NetClientState *nc;
+    NetPasstState *s;
+    GPtrArray *args;
+    gchar *pidfile;
+    int pidfd;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_PASST);
+
+    pidfd = g_file_open_tmp("passt-XXXXXX.pid", &pidfile, &error);
+    if (pidfd == -1) {
+        error_setg(errp, "Failed to create temporary file: %s", error->message);
+        return -1;
+    }
+    close(pidfd);
+
+    args = net_passt_decode_args(&netdev->u.passt, pidfile, errp);
+    if (args == NULL) {
+        g_free(pidfile);
+        return -1;
+    }
+
+    nc = qemu_new_net_client(&net_passt_info, peer, "passt", name);
+    s = DO_UPCAST(NetPasstState, data.nc, nc);
+
+    s->args = args;
+    s->pidfile = pidfile;
+
+    if (net_passt_stream_start(s, errp) == -1) {
+        qemu_del_net_client(nc);
+        return -1;
+    }
+
+    return 0;
+}
diff --git a/qapi/net.json b/qapi/net.json
index 97ea1839813b..8a8528ba1f47 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -112,6 +112,26 @@
   'data': {
     'str': 'str' } }
 
+##
+# @NetDevPasstOptions:
+#
+# Unprivileged user-mode network connectivity using passt
+#
+# @path: Filename of the passt program to run (by default 'passt', and use PATH)
+#
+# @quiet: don't print informational messages (default, passed as '--quiet')
+#
+# @param: parameter to pass to passt command
+#
+# Since: 10.1
+##
+{ 'struct': 'NetDevPasstOptions',
+  'data': {
+    '*path':               'str',
+    '*quiet':              'bool',
+    '*param':             ['String'] },
+    'if': 'CONFIG_PASST' }
+
 ##
 # @NetdevUserOptions:
 #
@@ -729,12 +749,15 @@
 #
 # @af-xdp: since 8.2
 #
+# @passt: since 10.1
+#
 # Since: 2.7
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'stream',
             'dgram', 'vde', 'bridge', 'hubport', 'netmap', 'vhost-user',
             'vhost-vdpa',
+            { 'name': 'passt', 'if': 'CONFIG_PASST' },
             { 'name': 'af-xdp', 'if': 'CONFIG_AF_XDP' },
             { 'name': 'vmnet-host', 'if': 'CONFIG_VMNET' },
             { 'name': 'vmnet-shared', 'if': 'CONFIG_VMNET' },
@@ -756,6 +779,8 @@
   'discriminator': 'type',
   'data': {
     'nic':      'NetLegacyNicOptions',
+    'passt':    { 'type': 'NetDevPasstOptions',
+                  'if': 'CONFIG_PASST' },
     'user':     'NetdevUserOptions',
     'tap':      'NetdevTapOptions',
     'l2tpv3':   'NetdevL2TPv3Options',
diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a676..9855657aa48b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2796,6 +2796,13 @@ DEFHEADING()
 DEFHEADING(Network options:)
 
 DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
+#ifdef CONFIG_PASST
+    "-netdev passt,id=str[,path=file][,quiet=on|off][,param=list]\n"
+    "                configure a passt network backend with ID 'str'\n"
+    "                if 'path' is not provided 'passt' will be started according to PATH\n"
+    "                by default, informational message of passt are not displayed (quiet=on)\n"
+    "                to display this message, use 'quiet=off'\n"
+#endif
 #ifdef CONFIG_SLIRP
     "-netdev user,id=str[,ipv4=on|off][,net=addr[/mask]][,host=addr]\n"
     "         [,ipv6=on|off][,ipv6-net=addr[/int]][,ipv6-host=addr]\n"
@@ -2952,6 +2959,9 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                configure a hub port on the hub with ID 'n'\n", QEMU_ARCH_ALL)
 DEF("nic", HAS_ARG, QEMU_OPTION_nic,
     "-nic [tap|bridge|"
+#ifdef CONFIG_PASST
+    "passt|"
+#endif
 #ifdef CONFIG_SLIRP
     "user|"
 #endif
@@ -2984,6 +2994,9 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
     "                configure or create an on-board (or machine default) NIC and\n"
     "                connect it to hub 0 (please use -nic unless you need a hub)\n"
     "-net ["
+#ifdef CONFIG_PASST
+    "passt|"
+#endif
 #ifdef CONFIG_SLIRP
     "user|"
 #endif
@@ -3005,7 +3018,7 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
     "                old way to initialize a host network interface\n"
     "                (use the -netdev option if possible instead)\n", QEMU_ARCH_ALL)
 SRST
-``-nic [tap|bridge|user|l2tpv3|vde|netmap|af-xdp|vhost-user|socket][,...][,mac=macaddr][,model=mn]``
+``-nic [tap|passt|bridge|user|l2tpv3|vde|netmap|af-xdp|vhost-user|socket][,...][,mac=macaddr][,model=mn]``
     This option is a shortcut for configuring both the on-board
     (default) guest NIC hardware and the host network backend in one go.
     The host backend options are the same as with the corresponding
@@ -3027,6 +3040,33 @@ SRST
     network backend) which is activated if no other networking options
     are provided.
 
+``-netdev passt,id=str[,option][,...]``
+    Configure a passt network backend which requires no administrator
+    privilege to run. Valid options are:
+
+    ``id=id``
+        Assign symbolic name for use in monitor commands.
+
+    ``path=file``
+        Filename of the passt program to run. If it is not provided,
+        passt command will be started with the help of the PATH environment
+        variable.
+
+    ``quiet=on|off``
+        By default, ``quiet=on`` to disable informational message from
+        passt. ``quiet=on`` is passed as ``--quiet`` to passt.
+
+    ``param=string``
+       ``string`` will be passed to passt has a command line parameter,
+       we can have multiple occurences of the ``param`` parameter to
+       pass multiple parameters to passt.
+
+       For instance, to pass ``--tcp-ports=10001 --tcp-ports=10002 --udp-ports=10001`` to passt:
+
+    .. parsed-literal::
+
+        |qemu_system| -nic passt,param=--tcp-ports=10001,param=--tcp-ports=10002,param=--udp-ports=10001
+
 ``-netdev user,id=id[,option][,option][,...]``
     Configure user mode host network backend which requires no
     administrator privilege to run. Valid options are:
@@ -3711,7 +3751,7 @@ SRST
     Use ``-net nic,model=help`` for a list of available devices for your
     target.
 
-``-net user|tap|bridge|socket|l2tpv3|vde[,...][,name=name]``
+``-net user|passt|tap|bridge|socket|l2tpv3|vde[,...][,name=name]``
     Configure a host network backend (with the options corresponding to
     the same ``-netdev`` option) and connect it to the emulated hub 0
     (the default hub). Use name to specify the name of the hub port.
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 73e0770f42b9..bb3e34d852a4 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -162,6 +162,7 @@ meson_options_help() {
   printf "%s\n" '  oss             OSS sound support'
   printf "%s\n" '  pa              PulseAudio sound support'
   printf "%s\n" '  parallels       parallels image format support'
+  printf "%s\n" '  passt           passt network backend support'
   printf "%s\n" '  pipewire        PipeWire sound support'
   printf "%s\n" '  pixman          pixman support'
   printf "%s\n" '  plugins         TCG plugins via shared library loading'
@@ -422,6 +423,8 @@ _meson_option_parse() {
     --disable-pa) printf "%s" -Dpa=disabled ;;
     --enable-parallels) printf "%s" -Dparallels=enabled ;;
     --disable-parallels) printf "%s" -Dparallels=disabled ;;
+    --enable-passt) printf "%s" -Dpasst=enabled ;;
+    --disable-passt) printf "%s" -Dpasst=disabled ;;
     --enable-pipewire) printf "%s" -Dpipewire=enabled ;;
     --disable-pipewire) printf "%s" -Dpipewire=disabled ;;
     --enable-pixman) printf "%s" -Dpixman=enabled ;;
-- 
2.49.0


