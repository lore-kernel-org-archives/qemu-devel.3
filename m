Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF214C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 11:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmJL-0004Pg-0R; Wed, 04 Jun 2025 07:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uMmJI-0004PI-4j
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:29:32 -0400
Received: from www62.your-server.de ([213.133.104.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uMmJE-0005eT-68
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=3Afq4dwx3oSMs+2R1yg8PwwnT4dHFCk3T1VIwh9s1DY=; b=Xww2PSu3qm9M7hkB1CYXtTCB0i
 pJgNDvVZaJo2YNTN8+ePWDsTuPVTwvWozne+mg7M4OTZ/8Qps/c8j3JtF+VPHCE15Rw+Rapm92bKF
 yXKn/HkRXETWYqysbdBtImJ/geebUL2NzJYLnCKR0fKH4TfK20tcNZlr1Xx3phy9Q+rk7aWaNT9vk
 CIhkdAeBxq7AIEmGJhDnxLMabgzoA8Qm2tivWwhwwdiKX/MkqAVDemn/Iz91tqigxzAO6YmlM+dSE
 cbuYCb2WJqGuHyVWxZVyvmeL2wR8GC4xWYdclvxaKmyBVAzyVjdQ++WtxwDu+rHi0qEUX2xrI9JQT
 1bBczBxw==;
Received: from localhost ([127.0.0.1])
 by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <daniel@iogearbox.net>)
 id 1uMmJ2-0001Fc-1e; Wed, 04 Jun 2025 13:29:17 +0200
To: qemu-devel@nongnu.org
Cc: daniel@iogearbox.net, Ilya Maximets <i.maximets@ovn.org>,
 Jason Wang <jasowang@redhat.com>, Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v3 1/2] net/af-xdp: Support pinned map path for AF_XDP sockets
Date: Wed,  4 Jun 2025 13:29:15 +0200
Message-ID: <20250604112916.1195368-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27658/Wed Jun  4 10:36:16 2025)
Received-SPF: pass client-ip=213.133.104.62; envelope-from=daniel@iogearbox.net;
 helo=www62.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Daniel Borkmann <daniel@iogearbox.net>
From:  Daniel Borkmann via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Extend 'inhibit=on' setting with the option to specify a pinned XSK map
path along with a starting index (default 0) to push the created XSK
sockets into. Example usage:

  # ./build/qemu-system-x86_64 [...] \
   -netdev af-xdp,ifname=enp2s0f0np0,id=net0,mode=native,queues=2,start-queue=14,inhibit=on,map-path=/sys/fs/bpf/xsks_map,map-start-index=14 \
   -device virtio-net-pci,netdev=net0 [...]

This is useful for the case where an existing XDP program with XSK map
is present on the AF_XDP supported phys device and the XSK map is not
yet populated. For example, the former could have been pre-loaded onto
the netdevice by a control plane, which later launches qemu to populate
it with XSK sockets.

Normally, the main idea behind 'inhibit=on' is that the qemu instance
doesn't need to have a lot of privileges to use the pre-loaded program
and the pre-created sockets, but this mentioned use-case here is different
where qemu still needs privileges to create the sockets.

The 'map-start-index' parameter is optional and defaults to 0. It allows
flexible placement of the XSK sockets, and is up to the user to specify
when the XDP program with XSK map was already preloaded. In the simplest
case the queue-to-map-slot mapping is just 1:1 based on ctx->rx_queue_index
but the user might as well have a different scheme (or smaller map size,
e.g. ctx->rx_queue_index % max_size) to push the inbound traffic to one
of the XSK sockets.

Note that the bpf_xdp_query_id() is now only tested for 'inhibit=off'
since only in the latter case the libxdp takes care of installing the
XDP program which was installed based on the s->xdp_flags pointing to
either driver or skb mode. For 'inhibit=on' we don't make any assumptions
and neither go down the path of probing all possible options in which
way the user installed the XDP program.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Anton Protopopov <aspsk@isovalent.com>
---
 net/af-xdp.c    | 80 +++++++++++++++++++++++++++++++++++++++++++++----
 qapi/net.json   | 29 +++++++++++-------
 qemu-options.hx | 23 ++++++++++++--
 3 files changed, 114 insertions(+), 18 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 01c5fb914e..b83d9bc47f 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -52,6 +52,10 @@ typedef struct AFXDPState {
     uint32_t             n_queues;
     uint32_t             xdp_flags;
     bool                 inhibit;
+
+    char                 *map_path;
+    int                  map_fd;
+    uint32_t             map_start_index;
 } AFXDPState;
 
 #define AF_XDP_BATCH_SIZE 64
@@ -261,6 +265,7 @@ static void af_xdp_send(void *opaque)
 static void af_xdp_cleanup(NetClientState *nc)
 {
     AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
+    int idx;
 
     qemu_purge_queued_packets(nc);
 
@@ -282,6 +287,18 @@ static void af_xdp_cleanup(NetClientState *nc)
                 "af-xdp: unable to remove XDP program from '%s', ifindex: %d\n",
                 s->ifname, s->ifindex);
     }
+
+    if (s->map_fd >= 0) {
+        idx = nc->queue_index + s->map_start_index;
+        if (bpf_map_delete_elem(s->map_fd, &idx)) {
+            fprintf(stderr, "af-xdp: unable to remove AF_XDP socket from map %s\n",
+                    s->map_path);
+        }
+        close(s->map_fd);
+        s->map_fd = -1;
+    }
+    g_free(s->map_path);
+    s->map_path = NULL;
 }
 
 static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
@@ -345,7 +362,6 @@ static int af_xdp_socket_create(AFXDPState *s,
     };
     int queue_id, error = 0;
 
-    s->inhibit = opts->has_inhibit && opts->inhibit;
     if (s->inhibit) {
         cfg.libxdp_flags |= XSK_LIBXDP_FLAGS__INHIBIT_PROG_LOAD;
     }
@@ -396,6 +412,34 @@ static int af_xdp_socket_create(AFXDPState *s,
     return 0;
 }
 
+static int af_xdp_update_xsk_map(AFXDPState *s, Error **errp)
+{
+    int xsk_fd, idx, error = 0;
+
+    if (!s->map_path)
+        return 0;
+
+    s->map_fd = bpf_obj_get(s->map_path);
+    if (s->map_fd < 0) {
+        error = errno;
+    } else {
+        xsk_fd = xsk_socket__fd(s->xsk);
+        idx = s->nc.queue_index + s->map_start_index;
+        if (bpf_map_update_elem(s->map_fd, &idx, &xsk_fd, 0)) {
+            error = errno;
+        }
+    }
+
+    if (error) {
+        error_setg_errno(errp, error,
+                         "failed to insert AF_XDP socket into map %s",
+                         s->map_path);
+        return -1;
+    }
+
+    return 0;
+}
+
 /* NetClientInfo methods. */
 static NetClientInfo net_af_xdp_info = {
     .type = NET_CLIENT_DRIVER_AF_XDP,
@@ -450,6 +494,7 @@ int net_init_af_xdp(const Netdev *netdev,
     int64_t i, queues;
     Error *err = NULL;
     AFXDPState *s;
+    bool inhibit;
 
     ifindex = if_nametoindex(opts->ifname);
     if (!ifindex) {
@@ -465,8 +510,21 @@ int net_init_af_xdp(const Netdev *netdev,
         return -1;
     }
 
-    if ((opts->has_inhibit && opts->inhibit) != !!opts->sock_fds) {
-        error_setg(errp, "'inhibit=on' requires 'sock-fds' and vice versa");
+    inhibit = opts->has_inhibit && opts->inhibit;
+    if (inhibit && !opts->sock_fds && !opts->map_path) {
+        error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path'");
+        return -1;
+    }
+    if (!inhibit && (opts->sock_fds || opts->map_path)) {
+        error_setg(errp, "'sock-fds' and 'map-path' require 'inhibit=on'");
+        return -1;
+    }
+    if (opts->sock_fds && opts->map_path) {
+        error_setg(errp, "'sock-fds' and 'map-path' are mutually exclusive");
+        return -1;
+    }
+    if (!opts->map_path && opts->has_map_start_index) {
+        error_setg(errp, "'map-start-index' requires 'map-path'");
         return -1;
     }
 
@@ -492,8 +550,18 @@ int net_init_af_xdp(const Netdev *netdev,
         s->ifindex = ifindex;
         s->n_queues = queues;
 
-        if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp)
-            || af_xdp_socket_create(s, opts, errp)) {
+        s->inhibit = inhibit;
+
+        s->map_path = g_strdup(opts->map_path);
+        s->map_fd = -1;
+        s->map_start_index = 0;
+        if (opts->has_map_start_index && opts->map_start_index > 0) {
+            s->map_start_index = opts->map_start_index;
+        }
+
+        if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp) ||
+            af_xdp_socket_create(s, opts, errp) ||
+            af_xdp_update_xsk_map(s, errp)) {
             /* Make sure the XDP program will be removed. */
             s->n_queues = i;
             error_propagate(errp, err);
@@ -501,7 +569,7 @@ int net_init_af_xdp(const Netdev *netdev,
         }
     }
 
-    if (nc0) {
+    if (nc0 && !inhibit) {
         s = DO_UPCAST(AFXDPState, nc, nc0);
         if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
             error_setg_errno(errp, errno,
diff --git a/qapi/net.json b/qapi/net.json
index 310cc4fd19..4ebc9580d8 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -454,25 +454,34 @@
 #     (default: 0).
 #
 # @inhibit: Don't load a default XDP program, use one already loaded
-#     to the interface (default: false).  Requires @sock-fds.
+#     to the interface (default: false).  Requires @sock-fds or @map-path.
 #
 # @sock-fds: A colon (:) separated list of file descriptors for
 #     already open but not bound AF_XDP sockets in the queue order.
 #     One fd per queue.  These descriptors should already be added
-#     into XDP socket map for corresponding queues.  Requires
-#     @inhibit.
+#     into XDP socket map for corresponding queues.  @sock-fds and
+#     @map-path are mutually exclusive.  Requires @inhibit.
+#
+# @map-path: The path to a pinned xsk map to push file descriptors
+#     for bound AF_XDP sockets into.  @map-path and @sock-fds are
+#     mutually exclusive.  Requires @inhibit.  (Since 10.1)
+#
+# @map-start-index: Use @map-path to insert xsk sockets starting from
+#     this index number (default: 0).  Requires @map-path.  (Since 10.1)
 #
 # Since: 8.2
 ##
 { 'struct': 'NetdevAFXDPOptions',
   'data': {
-    'ifname':       'str',
-    '*mode':        'AFXDPMode',
-    '*force-copy':  'bool',
-    '*queues':      'int',
-    '*start-queue': 'int',
-    '*inhibit':     'bool',
-    '*sock-fds':    'str' },
+    'ifname':           'str',
+    '*mode':            'AFXDPMode',
+    '*force-copy':      'bool',
+    '*queues':          'int',
+    '*start-queue':     'int',
+    '*inhibit':         'bool',
+    '*sock-fds':        'str',
+    '*map-path':        'str',
+    '*map-start-index': 'int' },
   'if': 'CONFIG_AF_XDP' }
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index 7eb8e02b4b..a2eb34f483 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2909,6 +2909,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #ifdef CONFIG_AF_XDP
     "-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off]\n"
     "         [,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z]\n"
+    "         [,map-path=/path/to/socket/map][,map-start-index=i]\n"
     "                attach to the existing network interface 'name' with AF_XDP socket\n"
     "                use 'mode=MODE' to specify an XDP program attach mode\n"
     "                use 'force-copy=on|off' to force XDP copy mode even if device supports zero-copy (default: off)\n"
@@ -2916,6 +2917,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                with inhibit=on,\n"
     "                  use 'sock-fds' to provide file descriptors for already open AF_XDP sockets\n"
     "                  added to a socket map in XDP program.  One socket per queue.\n"
+    "                  use 'map-path' to provide the socket map location to populate AF_XDP sockets with\n"
+    "                  beginning from the 'map-start-index' specified index (default: 0) (Since 10.1)\n"
     "                use 'queues=n' to specify how many queues of a multiqueue interface should be used\n"
     "                use 'start-queue=m' to specify the first queue that should be used\n"
 #endif
@@ -3610,7 +3613,7 @@ SRST
         # launch QEMU instance
         |qemu_system| linux.img -nic vde,sock=/tmp/myswitch
 
-``-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off][,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z]``
+``-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off][,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z][,map-path=/path/to/socket/map][,map-start-index=i]``
     Configure AF_XDP backend to connect to a network interface 'name'
     using AF_XDP socket.  A specific program attach mode for a default
     XDP program can be forced with 'mode', defaults to best-effort,
@@ -3650,7 +3653,8 @@ SRST
             -netdev af-xdp,id=n1,ifname=eth0,queues=1,start-queue=1
 
     XDP program can also be loaded externally.  In this case 'inhibit' option
-    should be set to 'on' and 'sock-fds' provided with file descriptors for
+    should be set to 'on'.  Either 'sock-fds' or 'map-path' can be used with
+    'inhibit' enabled.  'sock-fds' can be provided with file descriptors for
     already open but not bound XDP sockets already added to a socket map for
     corresponding queues.  One socket per queue.
 
@@ -3659,6 +3663,21 @@ SRST
         |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \\
             -netdev af-xdp,id=n1,ifname=eth0,queues=3,inhibit=on,sock-fds=15:16:17
 
+    For the 'inhibit' option set to 'on' used together with 'map-path' it is
+    expected that the XDP program with the socket map is already loaded on
+    the networking device and the map pinned into BPF file system.  The path
+    to the pinned map is then passed to QEMU which then creates the file
+    descriptors and inserts them into the existing socket map.
+
+    .. parsed-literal::
+
+        |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \\
+            -netdev af-xdp,id=n1,ifname=eth0,queues=2,inhibit=on,map-path=/sys/fs/bpf/xsks_map
+
+    Additionally, 'map-start-index' can be used to specify the start offset
+    for insertion into the socket map.  The combination of 'map-path' and
+    'sock-fds' together is not supported.
+
 ``-netdev vhost-user,chardev=id[,vhostforce=on|off][,queues=n]``
     Establish a vhost-user netdev, backed by a chardev id. The chardev
     should be a unix domain socket backed one. The vhost-user uses a
-- 
2.43.0


