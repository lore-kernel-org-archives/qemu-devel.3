Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BB7FED2DD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0aFx-0004YF-Tu; Thu, 12 Mar 2026 03:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aFu-0004XP-3w
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aFs-0008Ga-5Y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773299686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fm6Ge9uLm0frQzsn6yDgIGw/bNW8EgJgnqMeUpMdIlY=;
 b=F7uh4x+lP1BdlN9XHNrFDvW8ijBd7lS2x3HSax9+Z4JTLctBeJjxxM2XsTTFXDfhJSmEFt
 4NdkdlFS2D71q6Y8RPJ/yl7PXxOqIe9bFkU7M//dg244F/Gl7rHxGP5PxTZCFOHb+yL/O9
 4LIKgdxRiJd6YdzrGffiUC7o5BkOa10=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-l_Ym-zu9P16dxHGiKIcC8A-1; Thu,
 12 Mar 2026 03:14:43 -0400
X-MC-Unique: l_Ym-zu9P16dxHGiKIcC8A-1
X-Mimecast-MFC-AGG-ID: l_Ym-zu9P16dxHGiKIcC8A_1773299682
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E37DD195608A; Thu, 12 Mar 2026 07:14:41 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.170])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E4A71800361; Thu, 12 Mar 2026 07:14:38 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v2 3/9] net/filter-redirector: add AF_PACKET socket setup and
 input handler
Date: Thu, 12 Mar 2026 15:09:31 +0800
Message-ID: <20260312071415.1836655-4-lulu@redhat.com>
In-Reply-To: <20260312071415.1836655-1-lulu@redhat.com>
References: <20260312071415.1836655-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add the AF_PACKET plumbing that lets filter-redirector bypass vhost and
talk to the TAP device directly.

Resolve the TAP ifname from the backend fd, create a nonblocking raw
socket, bind it to the interface, and store it as either the capture or
inject endpoint depending on the redirector role.

Also add the capture-side fd handler, which drains PACKET_OUTGOING
frames and forwards them into the filter chain.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 179 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 170 insertions(+), 9 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 376b7da025..915f2f8b35 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -27,6 +27,13 @@
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
@@ -41,6 +48,10 @@ struct MirrorState {
     NetFilterState parent_obj;
     char *indev;
     char *outdev;
+    NetClientState *out_net;
+    int in_netfd;
+    uint8_t *in_netbuf;
+    int out_netfd;
     CharFrontend chr_in;
     CharFrontend chr_out;
     SocketReadState rs;
@@ -189,6 +200,17 @@ static int redirector_chr_can_read(void *opaque)
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
@@ -225,6 +247,40 @@ static void redirector_chr_event(void *opaque, QEMUChrEvent event)
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
+        error_report("filter redirector read netdev failed(%s)",
+                     strerror(errno));
+    }
+}
+
 static ssize_t filter_mirror_receive_iov(NetFilterState *nf,
                                          NetClientState *sender,
                                          unsigned flags,
@@ -285,7 +341,19 @@ static void filter_redirector_cleanup(NetFilterState *nf)
 
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
@@ -352,6 +420,14 @@ static void filter_redirector_vm_state_change(void *opaque, bool running,
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
 
     if (!running && nc && s->enable_when_stopped && nc->info->read_poll) {
         nc->info->read_poll(nc, true);
@@ -379,21 +455,83 @@ static void filter_redirector_maybe_enable_read_poll(NetFilterState *nf)
     }
 }
 
+static bool filter_redirector_netdev_setup(NetFilterState *nf, Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+    struct sockaddr_ll sll = { 0 };
+    char ifname[IFNAMSIZ] = { 0 };
+    int ifindex;
+    int fd;
+    NetClientState *nc = nf->netdev;
+    int tapfd;
+    bool capture = filter_redirector_use_capture_netdev(nf);
+    bool inject = filter_redirector_use_inject_netdev(nf);
+
+    if (!capture && !inject) {
+        return true;
+    }
+
+    if (!nc || nc->info->type != NET_CLIENT_DRIVER_TAP) {
+        return true;
+    }
+
+    tapfd = tap_get_fd(nc);
+    if (tapfd < 0 || tap_fd_get_ifname(tapfd, ifname) != 0) {
+        error_setg(errp, "failed to resolve TAP ifname for netdev '%s'",
+                   nf->netdev_id);
+        return false;
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
+    if (capture) {
+        s->in_netfd = fd;
+        g_free(s->in_netbuf);
+        s->in_netbuf = g_malloc(REDIRECTOR_MAX_LEN);
+    } else if (inject) {
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
 
     if (!s->indev && !s->outdev) {
-        error_setg(errp, "filter redirector needs 'indev' or "
-                   "'outdev' at least one property set");
+        error_setg(errp, "filter redirector needs at least one of "
+                   "'indev' or 'outdev'");
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
@@ -429,9 +567,21 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
         }
     }
 
+    if (!filter_redirector_netdev_setup(nf, errp)) {
+        return;
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
@@ -440,6 +590,7 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 static void filter_redirector_status_changed(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
+    bool active = filter_redirector_input_active(nf, nf->on);
 
     if (s->indev) {
         if (nf->on) {
@@ -452,6 +603,13 @@ static void filter_redirector_status_changed(NetFilterState *nf, Error **errp)
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
@@ -642,6 +800,8 @@ static void filter_redirector_init(Object *obj)
     MirrorState *s = FILTER_REDIRECTOR(obj);
 
     s->vnet_hdr = false;
+    s->in_netfd = -1;
+    s->out_netfd = -1;
 }
 
 static void filter_mirror_fini(Object *obj)
@@ -657,6 +817,7 @@ static void filter_redirector_fini(Object *obj)
 
     g_free(s->indev);
     g_free(s->outdev);
+    g_free(s->in_netbuf);
 }
 
 static const TypeInfo filter_redirector_info = {
-- 
2.52.0


