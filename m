Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B062AC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfHg-0001LE-Vp; Tue, 14 Jul 2026 11:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjfHe-0001KQ-MF
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:42:58 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjfHc-000839-Ru
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:42:58 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1b:16:0:640:bc52:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 8B2C980B08;
 Tue, 14 Jul 2026 18:42:55 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id lgRdV71YDKo0-8OYkTVPk; Tue, 14 Jul 2026 18:42:55 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784043775;
 bh=YsRS8Z2tp1PC14mEkhgyKVR5oLh/1sNAa7JkijtPoIY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=R69TI9PjnuUppsnW9z+7crINd6bSSzi3RPnVO/JT+1cN4rc0zaBHa0BU7zzsu6v/F
 K6n8ThgUBwhCtv65SDXweWkekp519Pqbgzi8jtC7JbZdH10okKcKfu7yPBhHgC7H0C
 Qpo1RC8lIgn3cGICQm7PNRhjOW87w4+bqP6jYruM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v19 07/15] net/tap: QOMify tap backend
Date: Tue, 14 Jul 2026 18:42:35 +0300
Message-ID: <20260714154246.1242856-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We prepare for being able to migrate TAP backend. We'll need a
user change-able property for it, which can be set from machine
type. So, let's QOMify it first.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/net/net.h |  7 +++++++
 include/net/tap.h |  2 ++
 net/net.c         | 14 +++++++-------
 net/tap.c         | 48 +++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 45bc86fc86b..bdf16bb3e64 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -160,6 +160,13 @@ char *qemu_mac_strdup_printf(const uint8_t *macaddr);
 NetClientState *qemu_find_netdev(const char *id);
 int qemu_find_net_clients_except(const char *id, NetClientState **ncs,
                                  NetClientDriver type, int max);
+void qemu_net_client_setup(NetClientState *nc,
+                           NetClientInfo *info,
+                           NetClientState *peer,
+                           const char *model,
+                           const char *name,
+                           NetClientDestructor *destructor,
+                           bool is_datapath);
 NetClientState *qemu_new_net_client(NetClientInfo *info,
                                     NetClientState *peer,
                                     const char *model,
diff --git a/include/net/tap.h b/include/net/tap.h
index 6f34f13eae4..268570571f4 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -28,6 +28,8 @@
 
 #include "standard-headers/linux/virtio_net.h"
 
+#define TYPE_TAP_NETDEV "tap-netdev"
+
 int tap_enable(NetClientState *nc);
 int tap_disable(NetClientState *nc);
 
diff --git a/net/net.c b/net/net.c
index 2892f1730d1..a06558b75bf 100644
--- a/net/net.c
+++ b/net/net.c
@@ -261,13 +261,13 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
                                        int iovcnt,
                                        void *opaque);
 
-static void qemu_net_client_setup(NetClientState *nc,
-                                  NetClientInfo *info,
-                                  NetClientState *peer,
-                                  const char *model,
-                                  const char *name,
-                                  NetClientDestructor *destructor,
-                                  bool is_datapath)
+void qemu_net_client_setup(NetClientState *nc,
+                           NetClientInfo *info,
+                           NetClientState *peer,
+                           const char *model,
+                           const char *name,
+                           NetClientDestructor *destructor,
+                           bool is_datapath)
 {
     nc->info = info;
     nc->model = g_strdup(model);
diff --git a/net/tap.c b/net/tap.c
index 0679580fcaf..8ba48180b01 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -43,6 +43,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "hw/virtio/vhost.h"
+#include "qom/object.h"
 
 #include "net/tap.h"
 #include "net/util.h"
@@ -68,7 +69,11 @@ static const int kernel_feature_bits[] = {
     VHOST_INVALID_FEATURE_BIT
 };
 
-typedef struct TAPState {
+OBJECT_DECLARE_SIMPLE_TYPE(TAPState, TAP_NETDEV)
+
+struct TAPState {
+    Object parent_obj;
+
     NetClientState nc;
     int fd;
     int vhostfd;
@@ -86,7 +91,7 @@ typedef struct TAPState {
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
     Notifier exit;
-} TAPState;
+};
 
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp);
@@ -414,6 +419,19 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
     return s->vhost_net;
 }
 
+
+static const TypeInfo tap_netdev_info = {
+    .name = TYPE_TAP_NETDEV,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(TAPState),
+};
+
+static void tap_net_client_destructor(NetClientState *nc)
+{
+    TAPState *s = container_of(nc, TAPState, nc);
+    object_unref(OBJECT(s));
+}
+
 /* fd support */
 
 static NetClientInfo net_tap_info = {
@@ -436,6 +454,18 @@ static NetClientInfo net_tap_info = {
     .get_vhost_net = tap_get_vhost_net,
 };
 
+static TAPState *new_tap(NetClientState *peer,
+                         const char *model,
+                         const char *name)
+{
+    TAPState *s = TAP_NETDEV(object_new(TYPE_TAP_NETDEV));
+
+    qemu_net_client_setup(&s->nc, &net_tap_info, peer, model, name,
+                          tap_net_client_destructor, true);
+
+    return s;
+}
+
 static TAPState *net_tap_fd_init(NetClientState *peer,
                                  const char *model,
                                  const char *name,
@@ -443,12 +473,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
                                  int vnet_hdr)
 {
     NetOffloads ol = {};
-    NetClientState *nc;
-    TAPState *s;
-
-    nc = qemu_new_net_client(&net_tap_info, peer, model, name);
-
-    s = container_of(nc, TAPState, nc);
+    TAPState *s = new_tap(peer, model, name);
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
@@ -1049,3 +1074,10 @@ int tap_disable(NetClientState *nc)
         return ret;
     }
 }
+
+static void tap_register_types(void)
+{
+    type_register_static(&tap_netdev_info);
+}
+
+type_init(tap_register_types)
-- 
2.43.0


