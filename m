Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914F1C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 15:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRvB2-0003KL-KD; Wed, 18 Jun 2025 11:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAy-0003Jp-59
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAv-0008CL-8z
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750262288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gre2I6LOYm1z05m4D6vkpyet4MseB5D8a+Nz9AAXimU=;
 b=bI4GtIZNRm+wJlEzHLsc7FoFZaZP7FhxvOUFHHhPnVStMtOw/G6hIDH5sG2tc69/okA9av
 1blYUtTb710Gfx8VppGKxw9lI+HH2Cr6y7sxS1XDXsrRYhtjtCaSy+P6hO4c6NmgRBE9EA
 5vsnTCvM+7LTrxtr9sQ9qStrOVE7+tc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-lzwPwYzxMgSFy_cdJYCmSQ-1; Wed,
 18 Jun 2025 11:58:05 -0400
X-MC-Unique: lzwPwYzxMgSFy_cdJYCmSQ-1
X-Mimecast-MFC-AGG-ID: lzwPwYzxMgSFy_cdJYCmSQ_1750262284
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 017D41809C85; Wed, 18 Jun 2025 15:58:04 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 281BE18003FC; Wed, 18 Jun 2025 15:57:59 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 09/10] net: Add passt network backend
Date: Wed, 18 Jun 2025 17:57:17 +0200
Message-ID: <20250618155718.550968-10-lvivier@redhat.com>
In-Reply-To: <20250618155718.550968-1-lvivier@redhat.com>
References: <20250618155718.550968-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hmp-commands.hx   |   3 +
 meson.build       |   6 +
 meson_options.txt |   2 +
 net/clients.h     |   4 +
 net/hub.c         |   3 +
 net/meson.build   |   3 +
 net/net.c         |   4 +
 net/passt.c       | 434 ++++++++++++++++++++++++++++++++++++++++++++++
 qapi/net.json     | 124 +++++++++++++
 qemu-options.hx   |  18 ++
 10 files changed, 601 insertions(+)
 create mode 100644 net/passt.c

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
index 34729c2a3dd5..485a60a0cb0c 100644
--- a/meson.build
+++ b/meson.build
@@ -1288,6 +1288,10 @@ if not get_option('slirp').auto() or have_system
   endif
 endif
 
+enable_passt = get_option('passt') \
+  .require(host_os == 'linux', error_message: 'passt is supported only on Linux') \
+  .allowed()
+
 vde = not_found
 if not get_option('vde').auto() or have_system or have_tools
   vde = cc.find_library('vdeplug', has_headers: ['libvdeplug.h'],
@@ -2541,6 +2545,7 @@ if seccomp.found()
   config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
 endif
 config_host_data.set('CONFIG_PIXMAN', pixman.found())
+config_host_data.set('CONFIG_PASST', enable_passt)
 config_host_data.set('CONFIG_SLIRP', slirp.found())
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
 config_host_data.set('CONFIG_SOLARIS', host_os == 'sunos')
@@ -4965,6 +4970,7 @@ if host_os == 'darwin'
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
index ba051441053f..e6789378809c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1267,6 +1267,9 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
     const char *name,
     NetClientState *peer, Error **errp) = {
         [NET_CLIENT_DRIVER_NIC]       = net_init_nic,
+#ifdef CONFIG_PASST
+        [NET_CLIENT_DRIVER_PASST]     = net_init_passt,
+#endif
 #ifdef CONFIG_SLIRP
         [NET_CLIENT_DRIVER_USER]      = net_init_slirp,
 #endif
@@ -1372,6 +1375,7 @@ void show_netdevs(void)
         "dgram",
         "hubport",
         "tap",
+        "passt",
 #ifdef CONFIG_SLIRP
         "user",
 #endif
diff --git a/net/passt.c b/net/passt.c
new file mode 100644
index 000000000000..ce194b1e02f0
--- /dev/null
+++ b/net/passt.c
@@ -0,0 +1,434 @@
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
+static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
+
+{
+    error_setg(errp, "vhost-user parameter not yet implemented");
+
+    return -1;
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
+    /* provide a pid file to be able to kil passt on exit */
+    g_ptr_array_add(args, g_strdup("--pid"));
+    g_ptr_array_add(args, g_strdup(pidfile));
+
+    /* g_subprocess_launcher_take_fd() will set the socket on fd 3 */
+    g_ptr_array_add(args, g_strdup("--fd"));
+    g_ptr_array_add(args, g_strdup("3"));
+
+    /* by default, be quiet */
+    if (!passt->has_quiet || passt->quiet) {
+        g_ptr_array_add(args, g_strdup("--quiet"));
+    }
+
+    if (passt->has_debug && passt->debug) {
+        g_ptr_array_add(args, g_strdup("--debug"));
+    }
+
+    if (passt->has_trace && passt->trace) {
+        g_ptr_array_add(args, g_strdup("--trace"));
+    }
+
+    if (passt->has_vhost_user && passt->vhost_user) {
+        g_ptr_array_add(args, g_strdup("--vhost-user"));
+    }
+
+    if (passt->pcap_file) {
+        g_ptr_array_add(args, g_strdup("--pcap"));
+        g_ptr_array_add(args, g_strdup(passt->pcap_file));
+    }
+
+    if (passt->has_mtu) {
+        g_ptr_array_add(args, g_strdup("--mtu"));
+        g_ptr_array_add(args, g_strdup_printf("%"PRId64, passt->mtu));
+    }
+
+    if (passt->address) {
+        g_ptr_array_add(args, g_strdup("--address"));
+        g_ptr_array_add(args, g_strdup(passt->address));
+    }
+
+    if (passt->netmask) {
+        g_ptr_array_add(args, g_strdup("--netmask"));
+        g_ptr_array_add(args, g_strdup(passt->netmask));
+    }
+
+    if (passt->mac) {
+        g_ptr_array_add(args, g_strdup("--mac-addr"));
+        g_ptr_array_add(args, g_strdup(passt->mac));
+    }
+
+    if (passt->gateway) {
+        g_ptr_array_add(args, g_strdup("--gateway"));
+        g_ptr_array_add(args, g_strdup(passt->gateway));
+    }
+
+    if (passt->interface) {
+        g_ptr_array_add(args, g_strdup("--interface"));
+        g_ptr_array_add(args, g_strdup(passt->interface));
+    }
+
+    if (passt->outbound) {
+        g_ptr_array_add(args, g_strdup("--outbound"));
+        g_ptr_array_add(args, g_strdup(passt->outbound));
+    }
+
+    if (passt->outbound_if4) {
+        g_ptr_array_add(args, g_strdup("--outbound-if4"));
+        g_ptr_array_add(args, g_strdup(passt->outbound_if4));
+    }
+
+    if (passt->outbound_if6) {
+        g_ptr_array_add(args, g_strdup("--outbound-if6"));
+        g_ptr_array_add(args, g_strdup(passt->outbound_if6));
+    }
+
+    if (passt->dns) {
+        g_ptr_array_add(args, g_strdup("--dns"));
+        g_ptr_array_add(args, g_strdup(passt->dns));
+    }
+
+    if (passt->fqdn) {
+        g_ptr_array_add(args, g_strdup("--fqdn"));
+        g_ptr_array_add(args, g_strdup(passt->fqdn));
+    }
+
+    if (passt->has_dhcp_dns && !passt->dhcp_dns) {
+        g_ptr_array_add(args, g_strdup("--no-dhcp-dns"));
+    }
+
+    if (passt->has_dhcp_search && !passt->dhcp_search) {
+        g_ptr_array_add(args, g_strdup("--no-dhcp-search"));
+    }
+
+    if (passt->map_host_loopback) {
+        g_ptr_array_add(args, g_strdup("--map-host-loopback"));
+        g_ptr_array_add(args, g_strdup(passt->map_host_loopback));
+    }
+
+    if (passt->map_guest_addr) {
+        g_ptr_array_add(args, g_strdup("--map-guest-addr"));
+        g_ptr_array_add(args, g_strdup(passt->map_guest_addr));
+    }
+
+    if (passt->dns_forward) {
+        g_ptr_array_add(args, g_strdup("--dns-forward"));
+        g_ptr_array_add(args, g_strdup(passt->dns_forward));
+    }
+
+    if (passt->dns_host) {
+        g_ptr_array_add(args, g_strdup("--dns-host"));
+        g_ptr_array_add(args, g_strdup(passt->dns_host));
+    }
+
+    if (passt->has_tcp && !passt->tcp) {
+        g_ptr_array_add(args, g_strdup("--no-tcp"));
+    }
+
+    if (passt->has_udp && !passt->udp) {
+        g_ptr_array_add(args, g_strdup("--no-udp"));
+    }
+
+    if (passt->has_icmp && !passt->icmp) {
+        g_ptr_array_add(args, g_strdup("--no-icmp"));
+    }
+
+    if (passt->has_dhcp && !passt->dhcp) {
+        g_ptr_array_add(args, g_strdup("--no-dhcp"));
+    }
+
+    if (passt->has_ndp && !passt->ndp) {
+        g_ptr_array_add(args, g_strdup("--no-ndp"));
+    }
+
+    if (passt->has_dhcpv6 && !passt->dhcpv6) {
+        g_ptr_array_add(args, g_strdup("--no-dhcpv6"));
+    }
+
+    if (passt->has_ra && !passt->ra) {
+        g_ptr_array_add(args, g_strdup("--no-ra"));
+    }
+
+    if (passt->has_freebind && passt->freebind) {
+        g_ptr_array_add(args, g_strdup("--freebind"));
+    }
+
+    if (passt->has_ipv4 && !passt->ipv4) {
+        g_ptr_array_add(args, g_strdup("--ipv6-only"));
+    }
+
+    if (passt->has_ipv6 && !passt->ipv6) {
+        g_ptr_array_add(args, g_strdup("--ipv4-only"));
+    }
+
+    if (passt->has_search && passt->search) {
+        const StringList *list = passt->search;
+        GString *domains = g_string_new(list->value->str);
+
+        list = list->next;
+        while (list) {
+            g_string_append(domains, " ");
+            g_string_append(domains, list->value->str);
+            list = list->next;
+        }
+
+        g_ptr_array_add(args, g_strdup("--search"));
+        g_ptr_array_add(args, g_string_free(domains, FALSE));
+    }
+
+    if (passt->has_tcp_ports && passt->tcp_ports) {
+        const StringList *list = passt->tcp_ports;
+        GString *tcp_ports = g_string_new(list->value->str);
+
+        list = list->next;
+        while (list) {
+            g_string_append(tcp_ports, ",");
+            g_string_append(tcp_ports, list->value->str);
+            list = list->next;
+        }
+
+        g_ptr_array_add(args, g_strdup("--tcp-ports"));
+        g_ptr_array_add(args, g_string_free(tcp_ports, FALSE));
+    }
+
+    if (passt->has_udp_ports && passt->udp_ports) {
+        const StringList *list = passt->udp_ports;
+        GString *udp_ports = g_string_new(list->value->str);
+
+        list = list->next;
+        while (list) {
+            g_string_append(udp_ports, ",");
+            g_string_append(udp_ports, list->value->str);
+            list = list->next;
+        }
+
+        g_ptr_array_add(args, g_strdup("--udp-ports"));
+        g_ptr_array_add(args, g_string_free(udp_ports, FALSE));
+    }
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
+    if (netdev->u.passt.has_vhost_user && netdev->u.passt.vhost_user) {
+        if (net_passt_vhost_user_init(s, errp) == -1) {
+            qemu_del_net_client(nc);
+            return -1;
+        }
+
+        return 0;
+    }
+
+    if (net_passt_stream_start(s, errp) == -1) {
+        qemu_del_net_client(nc);
+        return -1;
+    }
+
+    return 0;
+}
diff --git a/qapi/net.json b/qapi/net.json
index 97ea1839813b..76d7654414f7 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -112,6 +112,125 @@
   'data': {
     'str': 'str' } }
 
+##
+# @NetDevPasstOptions:
+#
+# Unprivileged user-mode network connectivity using passt
+#
+# @path: path to passt binary
+#
+# @quiet: don't print informational messages
+#
+# @debug: be verbose
+#
+# @trace: extra verbose
+#
+# @vhost-user: enable vhost-user
+#
+# @pcap-file: log traffic to pcap file
+#
+# @mtu: assign MTU via DHCP/NDP
+#
+# @address: IPv4 or IPv6 address
+#
+# @netmask: IPv4 mask
+#
+# @mac: source MAC address
+#
+# @gateway: IPv4 or IPv6 address as gateway
+#
+# @interface: interface for addresses and routes
+#
+# @outbound: bind to address as outbound source
+#
+# @outbound-if4: bind to outbound interface for IPv4
+#
+# @outbound-if6: bind to outbound interface for IPv6
+#
+# @dns: IPv4 or IPv6 address as DNS
+#
+# @search: search domains
+#
+# @fqdn: FQDN to configure client with
+#
+# @dhcp-dns: enable/disable DNS list in DHCP/DHCPv6/NDP
+#
+# @dhcp-search: enable/disable list in DHCP/DHCPv6/NDP
+#
+# @map-host-loopback: addresse to refer to host
+#
+# @map-guest-addr: addr to translate to guest's address
+#
+# @dns-forward: forward DNS queries sent to
+#
+# @dns-host: host nameserver to direct queries to
+#
+# @tcp: enable/disable TCP
+#
+# @udp: enable/disable UDP
+#
+# @icmp: enable/disable ICMP
+#
+# @dhcp: enable/disable DHCP
+#
+# @ndp: enable/disable NDP
+#
+# @dhcpv6: enable/disable DHCPv6
+#
+# @ra: enable/disable route advertisements
+#
+# @freebind: bind to any address for forwarding
+#
+# @ipv4: enable/disable IPv4
+#
+# @ipv6: enable/disable IPv6
+#
+# @tcp-ports: TCP ports to forward
+#
+# @udp-ports: UDP ports to forward
+#
+# Since: 10.1
+##
+{ 'struct': 'NetDevPasstOptions',
+  'data': {
+    '*path':               'str',
+    '*quiet':              'bool',
+    '*debug':              'bool',
+    '*trace':              'bool',
+    '*vhost-user':         'bool',
+    '*pcap-file':          'str',
+    '*mtu':                'int',
+    '*address':            'str',
+    '*netmask':            'str',
+    '*mac':                'str',
+    '*gateway':            'str',
+    '*interface':          'str',
+    '*outbound':           'str',
+    '*outbound-if4':       'str',
+    '*outbound-if6':       'str',
+    '*dns':                'str',
+    '*search':             ['String'],
+    '*fqdn':               'str',
+    '*dhcp-dns':           'bool',
+    '*dhcp-search':        'bool',
+    '*map-host-loopback':  'str',
+    '*map-guest-addr':     'str',
+    '*dns-forward':        'str',
+    '*dns-host':           'str',
+    '*tcp':                'bool',
+    '*udp':                'bool',
+    '*icmp':               'bool',
+    '*dhcp':               'bool',
+    '*ndp':                'bool',
+    '*dhcpv6':             'bool',
+    '*ra':                 'bool',
+    '*freebind':           'bool',
+    '*ipv4':               'bool',
+    '*ipv6':               'bool',
+    '*tcp-ports':          ['String'],
+    '*udp-ports':          ['String'] },
+    'if': 'CONFIG_PASST' }
+
 ##
 # @NetdevUserOptions:
 #
@@ -729,12 +848,15 @@
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
@@ -756,6 +878,8 @@
   'discriminator': 'type',
   'data': {
     'nic':      'NetLegacyNicOptions',
+    'passt':    { 'type': 'NetDevPasstOptions',
+                  'if': 'CONFIG_PASST' },
     'user':     'NetdevUserOptions',
     'tap':      'NetdevTapOptions',
     'l2tpv3':   'NetdevL2TPv3Options',
diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a676..4787f9309c69 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2796,6 +2796,18 @@ DEFHEADING()
 DEFHEADING(Network options:)
 
 DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
+#ifdef CONFIG_PASST
+    "-netdev passt,id=str[,path=file][,quiet=on|off][,debug=on|off][,trace=on|off]\n"
+    "          [,vhost-user=on|off][,pcap-file=file][,mtu=mtu]\n"
+    "          [,address=addr][,netmask=mask][,mac=addr][,gateway=addr]\n"
+    "          [,interface=name][,outbound=address][,outbound-if4=name]\n"
+    "          [,outbound-if6=name][,dns=addr][,search=list][,fqdn=name]\n"
+    "          [,dhcp-dns=on|off][,dhcp-search=on|off][,map-host-loopback=addr]\n"
+    "          [,map-guest-addr=addr][,dns-forward=addr][,dns-host=addr]\n"
+    "          [,tcp=on|off][,udp=on|off][,icmp=on|off][,dhcp=on|off]\n"
+    "          [,ndp=on|off][,dhcpv6=on|off][,ra=on|off][,freebind=on|off]\n"
+    "          [,ipv4=on|off][,ipv6=on|off][,tcp-ports=spec][,udp-ports=spec]\n"
+#endif
 #ifdef CONFIG_SLIRP
     "-netdev user,id=str[,ipv4=on|off][,net=addr[/mask]][,host=addr]\n"
     "         [,ipv6=on|off][,ipv6-net=addr[/int]][,ipv6-host=addr]\n"
@@ -2952,6 +2964,9 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                configure a hub port on the hub with ID 'n'\n", QEMU_ARCH_ALL)
 DEF("nic", HAS_ARG, QEMU_OPTION_nic,
     "-nic [tap|bridge|"
+#ifdef CONFIG_PASST
+    "passt|"
+#endif
 #ifdef CONFIG_SLIRP
     "user|"
 #endif
@@ -2984,6 +2999,9 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
     "                configure or create an on-board (or machine default) NIC and\n"
     "                connect it to hub 0 (please use -nic unless you need a hub)\n"
     "-net ["
+#ifdef CONFIG_PASST
+    "passt|"
+#endif
 #ifdef CONFIG_SLIRP
     "user|"
 #endif
-- 
2.49.0


