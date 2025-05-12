Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B5BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 16:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEW5L-0006Vz-C2; Mon, 12 May 2025 12:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uEVfo-0000ru-Ct
 for qemu-devel@nongnu.org; Mon, 12 May 2025 12:06:41 -0400
Received: from www62.your-server.de ([213.133.104.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uEVfg-0002AE-2w
 for qemu-devel@nongnu.org; Mon, 12 May 2025 12:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=pzKaO3GGe65ufa7mLKo0q2JCa/WfOLMa3pMh/Ku87UY=; b=QcNM/OTu8wp7YvkBZnDtUbB4o9
 U2kSFhWb2eg+h1GZ7I5/Xaw8oN3i20YIxwja0taw/GaWNFA8eyJmV3QQfIOT1NX0gNZhCfDsYIVt6
 J85D5AkENx2RllrHwcmaAp1/OVaVmXc2Prb9ElYviWVLxdftvvPIG6VagsuwVb30OY4i6QEk6Etgd
 mWzP+7kTe7llQ+ntGz/Wi2hgMkG53SdEkjNJe2btFy4OMfBEL7Zvxmp9GsEWXJP96p6Mcc55SlnpF
 b1yLUFcqGnONMv0Ms7wn6S+iIEiOrK3LQxRKqct73A4KVLZGnRHPUiUyASFD0FF3acb2a0G7TWLCT
 k5VXvQbQ==;
Received: from 85-195-247-12.fiber7.init7.net ([85.195.247.12] helo=localhost)
 by www62.your-server.de with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <daniel@iogearbox.net>) id 1uEVfZ-000G3d-10;
 Mon, 12 May 2025 18:06:21 +0200
To: qemu-devel@nongnu.org
Cc: daniel@iogearbox.net, Ilya Maximets <i.maximets@ovn.org>,
 Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v2] net/af-xdp: Support pinned map path for AF_XDP sockets
Date: Mon, 12 May 2025 18:06:20 +0200
Message-ID: <20250512160621.550062-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27635/Mon May 12 10:33:06 2025)
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
X-Mailman-Approved-At: Mon, 12 May 2025 12:32:56 -0400
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

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Anton Protopopov <aspsk@isovalent.com>
---
 net/af-xdp.c    | 65 +++++++++++++++++++++++++++++++++++++++++++------
 qapi/net.json   | 24 ++++++++++++------
 qemu-options.hx |  3 +++
 3 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 01c5fb914e..494b894706 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -51,6 +51,8 @@ typedef struct AFXDPState {
 
     uint32_t             n_queues;
     uint32_t             xdp_flags;
+    char                 *map_path;
+    uint32_t             map_start_index;
     bool                 inhibit;
 } AFXDPState;
 
@@ -261,6 +263,7 @@ static void af_xdp_send(void *opaque)
 static void af_xdp_cleanup(NetClientState *nc)
 {
     AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
+    int pin_fd, idx;
 
     qemu_purge_queued_packets(nc);
 
@@ -282,6 +285,22 @@ static void af_xdp_cleanup(NetClientState *nc)
                 "af-xdp: unable to remove XDP program from '%s', ifindex: %d\n",
                 s->ifname, s->ifindex);
     }
+    if (s->map_path) {
+        pin_fd = bpf_obj_get(s->map_path);
+        if (pin_fd < 0) {
+            fprintf(stderr,
+                "af-xdp: unable to remove %s's XSK sockets from '%s', ifindex: %d\n",
+                s->ifname, s->map_path, s->ifindex);
+        } else {
+            idx = nc->queue_index;
+            if (s->map_start_index > 0) {
+                idx += s->map_start_index;
+            }
+            bpf_map_delete_elem(pin_fd, &idx);
+            close(pin_fd);
+        }
+    }
+    g_free(s->map_path);
 }
 
 static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
@@ -343,7 +362,7 @@ static int af_xdp_socket_create(AFXDPState *s,
         .bind_flags = XDP_USE_NEED_WAKEUP,
         .xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST,
     };
-    int queue_id, error = 0;
+    int queue_id, pin_fd, xsk_fd, idx, error = 0;
 
     s->inhibit = opts->has_inhibit && opts->inhibit;
     if (s->inhibit) {
@@ -384,6 +403,23 @@ static int af_xdp_socket_create(AFXDPState *s,
         }
     }
 
+    if (!error && s->map_path) {
+        pin_fd = bpf_obj_get(s->map_path);
+        if (pin_fd < 0) {
+            error = errno;
+        } else {
+            xsk_fd = xsk_socket__fd(s->xsk);
+            idx = s->nc.queue_index;
+            if (s->map_start_index) {
+                idx += s->map_start_index;
+            }
+            if (bpf_map_update_elem(pin_fd, &idx, &xsk_fd, 0)) {
+                error = errno;
+            }
+            close(pin_fd);
+        }
+    }
+
     if (error) {
         error_setg_errno(errp, error,
                          "failed to create AF_XDP socket for %s queue_id: %d",
@@ -465,8 +501,12 @@ int net_init_af_xdp(const Netdev *netdev,
         return -1;
     }
 
-    if ((opts->has_inhibit && opts->inhibit) != !!opts->sock_fds) {
-        error_setg(errp, "'inhibit=on' requires 'sock-fds' and vice versa");
+    if ((opts->has_inhibit && opts->inhibit) != !!(opts->sock_fds || opts->map_path)) {
+        if (opts->has_inhibit && opts->inhibit) {
+            error_setg(errp, "'inhibit=on' requires setting 'sock-fds' or 'map-path'");
+        } else {
+            error_setg(errp, "'sock-fds' or 'map-path' requires setting 'inhibit=on'");
+        }
         return -1;
     }
 
@@ -491,6 +531,12 @@ int net_init_af_xdp(const Netdev *netdev,
         pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
         s->ifindex = ifindex;
         s->n_queues = queues;
+        if (opts->map_path) {
+            s->map_path = g_strdup(opts->map_path);
+            if (opts->has_map_start_index && opts->map_start_index > 0) {
+                s->map_start_index = opts->map_start_index;
+            }
+        }
 
         if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp)
             || af_xdp_socket_create(s, opts, errp)) {
@@ -504,10 +550,15 @@ int net_init_af_xdp(const Netdev *netdev,
     if (nc0) {
         s = DO_UPCAST(AFXDPState, nc, nc0);
         if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
-            error_setg_errno(errp, errno,
-                             "no XDP program loaded on '%s', ifindex: %d",
-                             s->ifname, s->ifindex);
-            goto err;
+            if (!s->inhibit) {
+                error_setg_errno(errp, errno,
+                                 "no XDP program loaded on '%s', ifindex: %d",
+                                 s->ifname, s->ifindex);
+                goto err;
+            } else {
+                warn_report("no XDP program loaded yet on '%s', ifindex: %d",
+                            s->ifname, s->ifindex);
+            }
         }
     }
 
diff --git a/qapi/net.json b/qapi/net.json
index 310cc4fd19..66a1fcf6ae 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -454,7 +454,7 @@
 #     (default: 0).
 #
 # @inhibit: Don't load a default XDP program, use one already loaded
-#     to the interface (default: false).  Requires @sock-fds.
+#     to the interface (default: false).  Requires @sock-fds or @map-path.
 #
 # @sock-fds: A colon (:) separated list of file descriptors for
 #     already open but not bound AF_XDP sockets in the queue order.
@@ -462,17 +462,25 @@
 #     into XDP socket map for corresponding queues.  Requires
 #     @inhibit.
 #
+# @map-path: The path to a pinned xsk map to push file descriptors
+#     for bound AF_XDP sockets into. Requires @inhibit. (Since 10.1)
+#
+# @map-start-index: Use @map-path to insert xsk sockets starting from
+#     this index number (default: 0). Requires @map-path. (Since 10.1)
+#
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
index dc694a99a3..50fc592f5d 100644
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
-- 
2.43.0


