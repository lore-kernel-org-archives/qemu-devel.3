Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED27FB3CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78dS-0005SK-VJ; Mon, 30 Mar 2026 05:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dQ-0005Q3-SF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dO-0000NX-Vl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774861810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRWno4DoMHQAFKmIk4fJA+2FKgaKaWQkcckpkoQAejg=;
 b=HbqI5c4/18vBvE2PtiJOHlKmEDiXsSVYGBwA7/D0RozOEuli0P3lWJ2ORTY6xMgY/I1LDc
 ejFJL5l9+nu9UNjE7/6i2wOblkT2cJ5FRzSNeAXprpvH1qEunN/VMEDhg7sKbzCMriENcs
 6OgNLmrVhqlX43u8SFrWQ6fK09T6Ta0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-0eCi7j8tP_iSZyg5YERkfA-1; Mon,
 30 Mar 2026 05:10:06 -0400
X-MC-Unique: 0eCi7j8tP_iSZyg5YERkfA-1
X-Mimecast-MFC-AGG-ID: 0eCi7j8tP_iSZyg5YERkfA_1774861806
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C93C618005B3; Mon, 30 Mar 2026 09:10:05 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.39])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F34C30001A1; Mon, 30 Mar 2026 09:10:02 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v3 3/7] net/filter-redirector: add AF_PACKET netdev setup helpers
Date: Mon, 30 Mar 2026 16:58:11 +0800
Message-ID: <20260330090944.1008027-4-lulu@redhat.com>
In-Reply-To: <20260330090944.1008027-1-lulu@redhat.com>
References: <20260330090944.1008027-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Prepare filter-redirector for direct TAP access through AF_PACKET sockets.

Add the setup-side plumbing needed by later capture/inject changes:
- extend MirrorState with dedicated AF_PACKET fds and a capture buffer
- resolve the TAP ifname from the backend fd
- create and bind a nonblocking AF_PACKET socket on that interface
- store the socket as the capture or inject endpoint based on the
  redirector role
- clean up the AF_PACKET resources from cleanup/finalize paths

This commit only prepares the sockets and object state.  The actual
capture and inject datapaths are added by follow-up commits.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index ab711e8835..d9f6a11d6b 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -22,10 +22,18 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "chardev/char-fe.h"
+#include "net/vhost_net.h"
 #include "qemu/iov.h"
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
@@ -40,6 +48,9 @@ struct MirrorState {
     NetFilterState parent_obj;
     char *indev;
     char *outdev;
+    int in_netfd;
+    uint8_t *in_netbuf;
+    int out_netfd;
     CharFrontend chr_in;
     CharFrontend chr_out;
     SocketReadState rs;
@@ -267,6 +278,15 @@ static void filter_redirector_cleanup(NetFilterState *nf)
     qemu_chr_fe_deinit(&s->chr_in, false);
     qemu_chr_fe_deinit(&s->chr_out, false);
     qemu_del_vm_change_state_handler(s->vmsentry);
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
@@ -360,6 +380,70 @@ static void filter_redirector_maybe_enable_read_poll(NetFilterState *nf)
     }
 }
 
+static bool filter_redirector_netdev_setup(NetFilterState *nf, Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+    struct sockaddr_ll sll = { 0 };
+    char ifname[IFNAMSIZ] = { 0 };
+    bool capture_role;
+    bool inject_role;
+    int ifindex;
+    int fd;
+    NetClientState *nc = nf->netdev;
+    int tapfd;
+
+    if (!nc || nc->info->type != NET_CLIENT_DRIVER_TAP) {
+        return true;
+    }
+
+    capture_role = s->outdev && !s->indev && get_vhost_net(nc);
+    inject_role = s->indev && !s->outdev && get_vhost_net(nc);
+    if (!capture_role && !inject_role) {
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
+    if (capture_role) {
+        s->in_netfd = fd;
+        g_free(s->in_netbuf);
+        s->in_netbuf = g_malloc(REDIRECTOR_MAX_LEN);
+    } else {
+        s->out_netfd = fd;
+    }
+
+    return true;
+}
+
 static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
@@ -410,6 +494,10 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
         }
     }
 
+    if (!filter_redirector_netdev_setup(nf, errp)) {
+        return;
+    }
+
     s->vmsentry = qemu_add_vm_change_state_handler(
         filter_redirector_vm_state_change, nf);
 
@@ -623,6 +711,8 @@ static void filter_redirector_init(Object *obj)
     MirrorState *s = FILTER_REDIRECTOR(obj);
 
     s->vnet_hdr = false;
+    s->in_netfd = -1;
+    s->out_netfd = -1;
 }
 
 static void filter_mirror_fini(Object *obj)
@@ -638,6 +728,7 @@ static void filter_redirector_fini(Object *obj)
 
     g_free(s->indev);
     g_free(s->outdev);
+    g_free(s->in_netbuf);
 }
 
 static const TypeInfo filter_redirector_info = {
-- 
2.52.0


