Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E95EF48DB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 07:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqnKZ-0002bY-99; Fri, 13 Feb 2026 02:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnKY-0002bO-4o
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnKV-0005cG-L0
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770966666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAZphhdyLWX/lOPr43JYhLTuyzZzE7b582uHiu2GZm8=;
 b=bu3aU2VIVokHY4a8AaNgSFiCa6xMV18+CqEpDirVaQCZ3mltXSE2O7L4Quo8YyIZA6WBpm
 zO4r8lxr9qIFJ6p12QbnmkH4FQGO1OakGisZQ7Nwl7XxCRmWdRd2EOxgdUyFKgT1RRY6Ov
 hLJm+eNkrSbdbu9wiDMVn3tfVJA/Ick=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-gw1XUclDP4uce-TG4dpkpQ-1; Fri,
 13 Feb 2026 02:11:03 -0500
X-MC-Unique: gw1XUclDP4uce-TG4dpkpQ-1
X-Mimecast-MFC-AGG-ID: gw1XUclDP4uce-TG4dpkpQ_1770966662
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAF4818003F6; Fri, 13 Feb 2026 07:11:01 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEE9530001B9; Fri, 13 Feb 2026 07:10:58 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [RFC 3/5] net/filter-redirector: Add AF_PACKET sockets initialization
Date: Fri, 13 Feb 2026 15:08:03 +0800
Message-ID: <20260213071042.3733239-4-lulu@redhat.com>
In-Reply-To: <20260213071042.3733239-1-lulu@redhat.com>
References: <20260213071042.3733239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement the initialization logic for AF_PACKET based netdev
endpoints in filter-redirector:

1. filter_redirector_netdev_setup(): Creates and binds AF_PACKET
   sockets to the specified TAP interface. For in_netdev, the socket
   is used to receive packets; for out_netdev, it is used to send.

2. filter_redirector_netdev_read(): Async handler for reading packets
   from the in_netdev AF_PACKET socket. Packets are forwarded through
   the redirector chain.

3. Updated cleanup to properly close AF_PACKET sockets and free
   associated buffers.

4. Modified allow_send_when_stopped logic to consider both chardev
   and netdev output endpoints, and to only enable when the
   redirector is active (status=on).

5. VM state change handler now manages the AF_PACKET read handler
   activation based on VM running state and enable_when_stopped.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 241 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 224 insertions(+), 17 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 37035f3892..f8001612ec 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -26,6 +26,13 @@
 #include "qemu/sockets.h"
 #include "block/aio-wait.h"
 #include "system/runstate.h"
+#include "net/tap.h"
+#include "net/tap_int.h"
+
+#include <sys/socket.h>
+#include <net/if.h>
+#include <linux/if_packet.h>
+#include <netinet/if_ether.h>
 
 typedef struct MirrorState MirrorState;
 DECLARE_INSTANCE_CHECKER(MirrorState, FILTER_MIRROR,
@@ -42,6 +49,10 @@ struct MirrorState {
     char *outdev;
     char *in_netdev;
     char *out_netdev;
+    NetClientState *out_net;
+    int in_netfd;
+    uint8_t *in_netbuf;
+    int out_netfd;
     CharFrontend chr_in;
     CharFrontend chr_out;
     SocketReadState rs;
@@ -172,6 +183,17 @@ static int redirector_chr_can_read(void *opaque)
     return REDIRECTOR_MAX_LEN;
 }
 
+static bool filter_redirector_input_active(NetFilterState *nf, bool enable)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+
+    if (!enable) {
+        return false;
+    }
+
+    return runstate_is_running() || s->enable_when_stopped;
+}
+
 static void redirector_chr_read(void *opaque, const uint8_t *buf, int size)
 {
     NetFilterState *nf = opaque;
@@ -208,6 +230,40 @@ static void redirector_chr_event(void *opaque, QEMUChrEvent event)
     }
 }
 
+static void filter_redirector_netdev_read(void *opaque)
+{
+    NetFilterState *nf = opaque;
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+    struct sockaddr_ll sll;
+    socklen_t sll_len;
+    ssize_t len;
+
+    if (!s->in_netbuf || s->in_netfd < 0) {
+        return;
+    }
+
+    for (;;) {
+        sll_len = sizeof(sll);
+        len = recvfrom(s->in_netfd, s->in_netbuf, REDIRECTOR_MAX_LEN, 0,
+                       (struct sockaddr *)&sll, &sll_len);
+        if (len <= 0) {
+            break;
+        }
+
+        if (sll.sll_pkttype != PACKET_OUTGOING) {
+            continue;
+        }
+
+        redirector_to_filter(nf, s->in_netbuf, len);
+    }
+
+    if (len < 0 && errno != EAGAIN && errno != EWOULDBLOCK &&
+        errno != EINTR) {
+        error_report("filter redirector read in_netdev failed(%s)",
+                     strerror(errno));
+    }
+}
+
 static ssize_t filter_mirror_receive_iov(NetFilterState *nf,
                                          NetClientState *sender,
                                          unsigned flags,
@@ -268,7 +324,19 @@ static void filter_redirector_cleanup(NetFilterState *nf)
 
     qemu_chr_fe_deinit(&s->chr_in, false);
     qemu_chr_fe_deinit(&s->chr_out, false);
-    qemu_del_vm_change_state_handler(s->vmsentry);
+    if (s->vmsentry) {
+        qemu_del_vm_change_state_handler(s->vmsentry);
+        s->vmsentry = NULL;
+    }
+    if (s->in_netfd >= 0) {
+        qemu_set_fd_handler(s->in_netfd, NULL, NULL, NULL);
+        close(s->in_netfd);
+        s->in_netfd = -1;
+    }
+    if (s->out_netfd >= 0) {
+        close(s->out_netfd);
+        s->out_netfd = -1;
+    }
 
     if (nf->netdev) {
         nf->netdev->allow_send_when_stopped = 0;
@@ -320,13 +388,13 @@ filter_redirector_refresh_allow_send_when_stopped(NetFilterState *nf)
 
     /*
      * Allow sending when stopped if enable_when_stopped is set and we have
-     * an outdev. This must be independent of nf->on (status) so that packets
-     * can still flow through the filter chain to other filters even when this
-     * redirector is disabled. Otherwise, tap_send() will disable read_poll
-     * when qemu_can_send_packet() returns false, preventing further packet
-     * processing.
+     * a redirector output endpoint and the redirector is enabled.
+     * Keeping this active while redirector status=off can unexpectedly
+     * drain packets in migration stop windows and perturb vhost ring state.
      */
-    nc->allow_send_when_stopped = (s->enable_when_stopped && s->outdev);
+    nc->allow_send_when_stopped = (nf->on &&
+                                   s->enable_when_stopped &&
+                                   (s->outdev || s->out_netdev));
 }
 
 static void filter_redirector_vm_state_change(void *opaque, bool running,
@@ -335,8 +403,16 @@ static void filter_redirector_vm_state_change(void *opaque, bool running,
     NetFilterState *nf = opaque;
     MirrorState *s = FILTER_REDIRECTOR(nf);
     NetClientState *nc = nf->netdev;
+    bool active = filter_redirector_input_active(nf, nf->on);
+
+    if (s->in_netfd >= 0) {
+        qemu_set_fd_handler(s->in_netfd,
+                            active ? filter_redirector_netdev_read : NULL,
+                            NULL,
+                            active ? nf : NULL);
+    }
 
-    if (!running && s->enable_when_stopped && nc->info->read_poll) {
+    if (!running && nc && s->enable_when_stopped && nc->info->read_poll) {
         nc->info->read_poll(nc, true);
     }
 }
@@ -362,21 +438,127 @@ static void filter_redirector_maybe_enable_read_poll(NetFilterState *nf)
     }
 }
 
+static bool filter_redirector_netdev_setup(MirrorState *s, Error **errp)
+{
+    struct sockaddr_ll sll = { 0 };
+    char ifname[IFNAMSIZ] = { 0 };
+    int ifindex;
+    int fd;
+    NetClientState *nc;
+
+    if (s->in_netdev) {
+        int tapfd;
+        nc = qemu_find_netdev(s->in_netdev);
+        if (!nc) {
+            error_setg(errp, "in_netdev '%s' not found", s->in_netdev);
+            return false;
+        }
+
+        if (nc->info->type != NET_CLIENT_DRIVER_TAP) {
+            error_setg(errp, "in_netdev '%s' must be a TAP netdev",
+                       s->in_netdev);
+            return false;
+        }
+
+        tapfd = tap_get_fd(nc);
+        if (tapfd < 0 || tap_fd_get_ifname(tapfd, ifname) != 0) {
+            error_setg(errp, "failed to resolve TAP ifname for in_netdev '%s'",
+                       s->in_netdev);
+            return false;
+        }
+    } else if (s->out_netdev) {
+        nc = qemu_find_netdev(s->out_netdev);
+        if (!nc) {
+            error_setg(errp, "out_netdev '%s' not found", s->out_netdev);
+            return false;
+        }
+        /*
+         * out_netdev always uses AF_PACKET. For TAP netdev we resolve the
+         * interface name from tap fd; for non-TAP netdev we interpret
+         * out_netdev string as host interface name.
+         */
+        if (nc->info->type == NET_CLIENT_DRIVER_TAP) {
+            int tapfd = tap_get_fd(nc);
+
+            if (tapfd < 0 || tap_fd_get_ifname(tapfd, ifname) != 0) {
+                error_setg(errp,
+                           "failed to resolve TAP ifname for out_netdev '%s'",
+                           s->out_netdev);
+                return false;
+            }
+        } else {
+            snprintf(ifname, sizeof(ifname), "%s", s->out_netdev);
+        }
+    }
+
+    ifindex = if_nametoindex(ifname);
+    if (!ifindex) {
+        error_setg_errno(errp, errno,
+                         "failed to resolve ifindex for '%s'", ifname);
+        return false;
+    }
+
+    fd = qemu_socket(AF_PACKET, SOCK_RAW | SOCK_NONBLOCK, htons(ETH_P_ALL));
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "failed to create AF_PACKET socket");
+        return false;
+    }
+
+    sll.sll_family = AF_PACKET;
+    sll.sll_ifindex = ifindex;
+    sll.sll_protocol = htons(ETH_P_ALL);
+    if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0) {
+        error_setg_errno(errp, errno,
+                         "failed to bind AF_PACKET socket for ifname '%s'",
+                         ifname);
+        close(fd);
+        return false;
+    }
+
+    if (s->in_netdev) {
+        s->in_netfd = fd;
+        g_free(s->in_netbuf);
+        s->in_netbuf = g_malloc(REDIRECTOR_MAX_LEN);
+    } else {
+        s->out_netfd = fd;
+        s->out_net = nc;
+    }
+    return true;
+}
+
 static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
     Chardev *chr;
 
-    if (!s->indev && !s->outdev) {
-        error_setg(errp, "filter redirector needs 'indev' or "
-                   "'outdev' at least one property set");
+    if (!s->indev && !s->outdev && !s->in_netdev && !s->out_netdev) {
+        error_setg(errp, "filter redirector needs at least one of "
+                   "'indev', 'outdev', 'in_netdev', or 'out_netdev'");
+        return;
+    }
+
+    if (s->indev && s->in_netdev) {
+        error_setg(errp, "'indev' and 'in_netdev' cannot both be set "
+                   "for filter redirector");
+        return;
+    }
+
+    if (s->outdev && s->out_netdev) {
+        error_setg(errp, "'outdev' and 'out_netdev' cannot both be set "
+                   "for filter redirector");
+        return;
+    }
+
+    if (s->in_netdev && s->out_netdev) {
+        error_setg(errp, "'in_netdev' and 'out_netdev' cannot both be set "
+                   "for filter redirector");
+        return;
+    }
+
+    if (s->indev && s->outdev && !strcmp(s->indev, s->outdev)) {
+        error_setg(errp, "'indev' and 'outdev' could not be same "
+                   "for filter redirector");
         return;
-    } else if (s->indev && s->outdev) {
-        if (!strcmp(s->indev, s->outdev)) {
-            error_setg(errp, "'indev' and 'outdev' could not be same "
-                       "for filter redirector");
-            return;
-        }
     }
 
     net_socket_rs_init(&s->rs, redirector_rs_finalize, s->vnet_hdr);
@@ -412,9 +594,23 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
         }
     }
 
+    if (s->out_netdev || s->in_netdev) {
+        if (!filter_redirector_netdev_setup(s, errp)) {
+            return;
+        }
+    }
+
     s->vmsentry = qemu_add_vm_change_state_handler(
         filter_redirector_vm_state_change, nf);
 
+    if (s->in_netfd >= 0) {
+        bool active = filter_redirector_input_active(nf, nf->on);
+
+        qemu_set_fd_handler(s->in_netfd,
+                            active ? filter_redirector_netdev_read : NULL,
+                            NULL,
+                            active ? nf : NULL);
+    }
     filter_redirector_maybe_enable_read_poll(nf);
 
     filter_redirector_refresh_allow_send_when_stopped(nf);
@@ -423,6 +619,7 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 static void filter_redirector_status_changed(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
+    bool active = filter_redirector_input_active(nf, nf->on);
 
     if (s->indev) {
         if (nf->on) {
@@ -435,6 +632,13 @@ static void filter_redirector_status_changed(NetFilterState *nf, Error **errp)
         }
     }
 
+    if (s->in_netfd >= 0) {
+        qemu_set_fd_handler(s->in_netfd,
+                            active ? filter_redirector_netdev_read : NULL,
+                            NULL,
+                            active ? nf : NULL);
+    }
+
     if (nf->on) {
         filter_redirector_maybe_enable_read_poll(nf);
     }
@@ -665,6 +869,8 @@ static void filter_redirector_init(Object *obj)
     MirrorState *s = FILTER_REDIRECTOR(obj);
 
     s->vnet_hdr = false;
+    s->in_netfd = -1;
+    s->out_netfd = -1;
 }
 
 static void filter_mirror_fini(Object *obj)
@@ -682,6 +888,7 @@ static void filter_redirector_fini(Object *obj)
     g_free(s->outdev);
     g_free(s->in_netdev);
     g_free(s->out_netdev);
+    g_free(s->in_netbuf);
 }
 
 static const TypeInfo filter_redirector_info = {
-- 
2.52.0


