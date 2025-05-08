Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626CBC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1iC-0006tl-Bp; Thu, 08 May 2025 09:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uD0Sj-0006xI-68
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:34:53 -0400
Received: from www62.your-server.de ([213.133.104.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uD0Sf-0003ko-N6
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=pdD4e+0YvwbK4M2mw+D7atifPTn7nNDSvWZ/aczH990=; b=lN5o8QdpHfkL+nGOGfwFCgXVMv
 AMF3ENwo+dDmAeSEPXEV/rTi+P7HGUyIiuYXAsyBwGZJA4KSRTbU5RDZN44kNMiDNxhb3Rk34Bfwj
 sUynF0Yf6w2yhP3+yEMolsUVlwoRE0X1d0qcAkfED9wrM0ow7Lo/UlA//NxRqYfTdOkHUpGHHcOS9
 oRO/gE+AACSOhoc1agTF5ljyjUvCBlJX44mzrBOPw8xscdw0q3X09fSn2DiXQ+5aYmzn2SEtxdwDG
 QUuoKz4Viwpym4+lR33EOEmNDjFTAZzkng3qLZ8w9S2qoNDl87DLaV9WMQ79/vHowtKfhmRyl/Nxn
 FoUYT2gA==;
Received: from 85-195-247-12.fiber7.init7.net ([85.195.247.12] helo=localhost)
 by www62.your-server.de with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <daniel@iogearbox.net>) id 1uD0ST-000HjY-06;
 Thu, 08 May 2025 14:34:37 +0200
To: qemu-devel@nongnu.org
Cc: daniel@iogearbox.net, Ilya Maximets <i.maximets@ovn.org>,
 Jason Wang <jasowang@redhat.com>, Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH] net/af-xdp: Support pinned map path for AF_XDP sockets
Date: Thu,  8 May 2025 14:34:36 +0200
Message-ID: <20250508123436.461030-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27631/Thu May  8 10:35:15 2025)
Received-SPF: pass client-ip=213.133.104.62; envelope-from=daniel@iogearbox.net;
 helo=www62.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 May 2025 09:54:54 -0400
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

Extend inhibit=on setting with the option to specify a pinned XSK map
path along with a starting index (default 0) to push the created XSK
sockets into. Example usage:

  # ./build/qemu-system-x86_64 [...] \
    -netdev af-xdp,ifname=eth0,id=net0,mode=native,queues=2,inhibit=on,map-path=/sys/fs/bpf/foo,map-start-index=2
    -device virtio-net-pci,netdev=net0 [...]

This is useful for the case where an existing XDP program with XSK map
is present on the AF_XDP supported phys device and the XSK map not yet
populated. Qemu will then push the XSK sockets into the specified map.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Anton Protopopov <aspsk@isovalent.com>
---
 net/af-xdp.c  | 63 +++++++++++++++++++++++++++++++++++++++++++++------
 qapi/net.json | 24 +++++++++++++-------
 2 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 01c5fb914e..ddc52f1307 100644
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
+	    xsk_fd = xsk_socket__fd(s->xsk);
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
@@ -465,8 +501,8 @@ int net_init_af_xdp(const Netdev *netdev,
         return -1;
     }
 
-    if ((opts->has_inhibit && opts->inhibit) != !!opts->sock_fds) {
-        error_setg(errp, "'inhibit=on' requires 'sock-fds' and vice versa");
+    if ((opts->has_inhibit && opts->inhibit) != !!(opts->sock_fds || opts->map_path)) {
+        error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path' and vice versa");
         return -1;
     }
 
@@ -491,6 +527,12 @@ int net_init_af_xdp(const Netdev *netdev,
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
@@ -504,10 +546,17 @@ int net_init_af_xdp(const Netdev *netdev,
     if (nc0) {
         s = DO_UPCAST(AFXDPState, nc, nc0);
         if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
-            error_setg_errno(errp, errno,
-                             "no XDP program loaded on '%s', ifindex: %d",
-                             s->ifname, s->ifindex);
-            goto err;
+            if (!s->map_path) {
+                error_setg_errno(errp, errno,
+                                 "no XDP program loaded on '%s', ifindex: %d",
+                                 s->ifname, s->ifindex);
+                goto err;
+	    } else {
+                warn_report("no XDP program loaded on '%s', ifindex: %d, "
+			    "only %"PRIi64" XSK socket%s loaded into map %s at this point",
+			    s->ifname, s->ifindex, queues, queues > 1 ? "s" : "",
+			    s->map_path);
+            }
         }
     }
 
diff --git a/qapi/net.json b/qapi/net.json
index 310cc4fd19..c750b805e8 100644
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
+#     for bound AF_XDP sockets into. Requires @inhibit.
+#
+# @map-start-index: Use @map-path to insert xsk sockets starting from
+#     this index number (default: 0). Requires @map-path.
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
-- 
2.43.0


