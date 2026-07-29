Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89EFC54FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0MK-0003kA-4e; Wed, 29 Jul 2026 05:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0MI-0003j6-Uj
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:13:50 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0MH-0004wH-9Q
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:13:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 0B352C0A64;
 Wed, 29 Jul 2026 12:13:48 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id bDa8GXKW9mI0-qYxwR9tp; Wed, 29 Jul 2026 12:13:47 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785316427;
 bh=oI96v0+TPIsbCm1buVmXupjL3MsG1DCG6blbQzz3fVA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=wH50gQHOZ+RjlIfkUoU2xm+HyyAefTzCccdjvb1uLK5daWeuxIDFsjNgC4rru9pkY
 08PLaxWifTEFH8vDorW91eK/GBljPVeyLUHYhwUIeu2DVPU0ORXdtxxEwE71BDEdSe
 Yy1rLPB+m5FqPhKKiQy5xjrl7KtZlkZZJipLJiT8=
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
Subject: [PATCH v20 08/15] net/tap: add TYPE_VMSTATE_IF interface
Date: Wed, 29 Jul 2026 12:12:46 +0300
Message-ID: <20260729091334.1863155-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We'll need it to implement TAP backend live migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 73923442009..dd0d134875b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -43,7 +43,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "hw/virtio/vhost.h"
-#include "qom/object.h"
 
 #include "net/tap.h"
 #include "net/util.h"
@@ -91,6 +90,8 @@ struct TAPState {
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
     Notifier exit;
+
+    int queue_index;
 };
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -419,10 +420,29 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
 }
 
 
+static char *tap_vmstate_if_get_id(VMStateIf *obj)
+{
+    TAPState *s = TAP_NETDEV(obj);
+    char *res = g_strdup_printf("%s/%d", s->nc.name, s->queue_index);
+    return res;
+}
+
+static void tap_class_init(ObjectClass *klass, const void *data)
+{
+    VMStateIfClass *vc = VMSTATE_IF_CLASS(klass);
+
+    vc->get_id = tap_vmstate_if_get_id;
+}
+
 static const TypeInfo tap_netdev_info = {
     .name = TYPE_TAP_NETDEV,
     .parent = TYPE_OBJECT,
     .instance_size = sizeof(TAPState),
+    .class_init = tap_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { TYPE_VMSTATE_IF },
+        { }
+    },
 };
 
 static void tap_net_client_destructor(NetClientState *nc)
@@ -455,13 +475,16 @@ static NetClientInfo net_tap_info = {
 
 static TAPState *new_tap(NetClientState *peer,
                          const char *model,
-                         const char *name)
+                         const char *name,
+                         int queue_index)
 {
     TAPState *s = TAP_NETDEV(object_new(TYPE_TAP_NETDEV));
 
     qemu_net_client_setup(&s->nc, &net_tap_info, peer, model, name,
                           tap_net_client_destructor, true);
 
+    s->queue_index = queue_index;
+
     return s;
 }
 
@@ -469,10 +492,11 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
                                  const char *model,
                                  const char *name,
                                  int fd,
-                                 int vnet_hdr)
+                                 int vnet_hdr,
+                                 int queue_index)
 {
     NetOffloads ol = {};
-    TAPState *s = new_tap(peer, model, name);
+    TAPState *s = new_tap(peer, model, name, queue_index);
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
@@ -709,7 +733,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         close(fd);
         return -1;
     }
-    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
+    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr, 0);
 
     qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
 
@@ -785,10 +809,11 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *name,
                              const char *ifname, const char *script,
                              const char *downscript, int vhostfd,
-                             int vnet_hdr, int fd, Error **errp)
+                             int vnet_hdr, int fd, int queue_index,
+                             Error **errp)
 {
     TAPState *s = net_tap_fd_init(peer, tap->helper ? "bridge" : "tap",
-                                  name, fd, vnet_hdr);
+                                  name, fd, vnet_hdr, queue_index);
     bool sndbuf_required = tap->has_sndbuf;
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
@@ -989,7 +1014,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             if (!net_init_tap_one(tap, peer, name, ifname,
                                   NULL, NULL,
                                   vhost_fds ? vhost_fds[i] : -1,
-                                  vnet_hdr, fds[i], errp)) {
+                                  vnet_hdr, fds[i], i, errp)) {
                 goto fail;
             }
         }
@@ -1024,7 +1049,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                                   i >= 1 ? NULL : script,
                                   i >= 1 ? NULL : downscript,
                                   vhost_fds ? vhost_fds[i] : -1,
-                                  vnet_hdr, fd, errp)) {
+                                  vnet_hdr, fd, i, errp)) {
                 goto fail;
             }
         }
-- 
2.43.0


