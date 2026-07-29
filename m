Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E79C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0ML-0003kj-If; Wed, 29 Jul 2026 05:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0MH-0003hn-95
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:13:49 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0MF-0004vX-BU
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:13:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 0FE68C0A60;
 Wed, 29 Jul 2026 12:13:46 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id bDa8GXKW9mI0-RzW3xrkW; Wed, 29 Jul 2026 12:13:45 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785316425;
 bh=rqXLRKVB9rUlP5qhRTvWTc1Jy5XuBInjTD1aruBDXbM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=GkMZCDe4HLiBlCqOVM2Erz1zTpAgYGW/sAXfacwJzL7aAo615IoLf6/EUVbnxGX2H
 gNXmMy8omxqodNk2QAxqUSAS75y5Llu1v+y2HTw8avKAXPimLqeAxm6q5tym79rWJZ
 mo47LoLXg4giCsYq7rvDG1SL4EeRdf+YGRi+YfIQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v20 06/15] net/tap: use container_of instead of DO_UPCAST
Date: Wed, 29 Jul 2026 12:12:44 +0300
Message-ID: <20260729091334.1863155-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

We are going to QOMify tap backend, which includes deriving TAPState
from Object. So "NetClientState nc" will not be a first member.
Let's parepare for this change, and use container_of(), which will
work regardless position of "nc" field.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f2b571dd116..bfed74717e4 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -175,7 +175,7 @@ static ssize_t tap_write_packet(TAPState *s, const struct iovec *iov, int iovcnt
 static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
                                int iovcnt)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     const struct iovec *iovp = iov;
     g_autofree struct iovec *iov_copy = NULL;
     struct virtio_net_hdr hdr = { };
@@ -211,7 +211,7 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)
 
 static void tap_send_completed(NetClientState *nc, ssize_t len)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     tap_read_poll(s, true);
 }
 
@@ -271,7 +271,7 @@ static void tap_send(void *opaque)
 
 static bool tap_has_ufo(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -280,7 +280,7 @@ static bool tap_has_ufo(NetClientState *nc)
 
 static bool tap_has_uso(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -289,7 +289,7 @@ static bool tap_has_uso(NetClientState *nc)
 
 static bool tap_has_tunnel(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     return s->has_tunnel;
@@ -297,7 +297,7 @@ static bool tap_has_tunnel(NetClientState *nc)
 
 static bool tap_has_vnet_hdr(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -311,7 +311,7 @@ static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
 
 static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -322,21 +322,21 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 
 static int tap_set_vnet_le(NetClientState *nc, bool is_le)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     return tap_fd_set_vnet_le(s->fd, is_le);
 }
 
 static int tap_set_vnet_be(NetClientState *nc, bool is_be)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     return tap_fd_set_vnet_be(s->fd, is_be);
 }
 
 static void tap_set_offload(NetClientState *nc, const NetOffloads *ol)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     if (s->fd < 0) {
         return;
     }
@@ -357,7 +357,7 @@ static void tap_exit_notify(Notifier *notifier, void *data)
 
 static void tap_cleanup(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     if (s->vhost_net) {
         vhost_net_cleanup(s->vhost_net);
@@ -381,14 +381,14 @@ static void tap_cleanup(NetClientState *nc)
 
 static void tap_poll(NetClientState *nc, bool enable)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     tap_read_poll(s, enable);
     tap_write_poll(s, enable);
 }
 
 static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
     return tap_fd_set_steering_ebpf(s->fd, prog_fd) == 0;
@@ -396,7 +396,7 @@ static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
 
 int tap_get_fd(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     return s->fd;
 }
@@ -408,7 +408,7 @@ int tap_get_fd(NetClientState *nc)
  */
 static VHostNetState *tap_get_vhost_net(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     return s->vhost_net;
 }
@@ -447,7 +447,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
 
     nc = qemu_new_net_client(&net_tap_info, peer, model, name);
 
-    s = DO_UPCAST(TAPState, nc, nc);
+    s = container_of(nc, TAPState, nc);
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
@@ -1016,7 +1016,7 @@ fail:
 
 int tap_enable(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     int ret;
 
     if (s->enabled) {
@@ -1033,7 +1033,7 @@ int tap_enable(NetClientState *nc)
 
 int tap_disable(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     int ret;
 
     if (s->enabled == 0) {
-- 
2.43.0


