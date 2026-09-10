Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8061DC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nlQ-00066j-JB; Thu, 10 Sep 2026 19:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lNl-0003Yh-QO
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lNV-0001Dh-80
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ym7KMRqUcvU4ABujQuwWyzRgxAgmuy8bm1077mgBw+A=;
 b=e41rFEO0t3us9d5PtfthU567tyAWteQ20aGNAocdm0MjtCQwmZX/H8qztTkbXmRQDp9ZOc
 v7ZplMnjfvQnr4X6SPQe58ztNM6nrbzT1eiIkIX6Yfce82+puhzT0NxA+dugRLOP99EXF2
 BEbSOGurFOUhdXfmKGnjS19dfFBpwFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Z10Ojd1dMamFWMXCzzBk4Q-1; Thu, 10 Sep 2026 16:12:27 -0400
X-MC-Unique: Z10Ojd1dMamFWMXCzzBk4Q-1
X-Mimecast-MFC-AGG-ID: Z10Ojd1dMamFWMXCzzBk4Q_1789071147
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994cf6cdb9so1564895e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071146; x=1789675946; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ym7KMRqUcvU4ABujQuwWyzRgxAgmuy8bm1077mgBw+A=;
 b=QoOg8u6REyAqXLTIZ2xNOa3MSRLF+sU2pX87aGGG4tW+S7Zd8b6CKOC+HNILt9Pgdg
 8rr6RRkQUNJFaiD5NU08QFyznExjCcN3+uNknKCF93dqpmYzPPtUgQtkcOBegpvkhedf
 zQcG0+vSFd5wCIKHfz6IuW14NdgOePu9stWX5lAqECbXqdbKU+F2NZQm626fjphI7KcY
 1KpKWoGUaNeW0qO//1p9TT+gvav+2sluDF5icxToxkCzuZFxryj5GZX6SyJr3ujtfNQd
 2H9OMDy0BKdaN7Z7ckWAHPstajmKV3xPcXfCpqeTCnjqQcjV4zfI3g/xWFuKMryFqJ38
 VfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071146; x=1789675946;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ym7KMRqUcvU4ABujQuwWyzRgxAgmuy8bm1077mgBw+A=;
 b=VUJwQnllp6ZEqLYDW0ftibxyMNGNpOhTj0IwB2OBHay3q+Y2yFpKEJehYMPzjWEffw
 sW2JDPEgzs4KYfNT84xkOvLCAMY9UaxonYs4Bbu/lJJFoKWpweaKgv7csXrvydqb7o5/
 rXNHrZeS7JkxQjNIpPqcxzHtJa/dRcEHm1TsTtV1RaxPBWT5LcHAsp1f74GPHfaGd5LC
 6w/wXHSi0HB4+FMKkOe+BnfPTV2i+ZqRsoU8sA6N7cwkj3jMXT34TF8XURFRsSutnwC6
 +bmENjIYwDsRh+/MxzkI9BvVBeXqLm3GYFvSTxqvFBPCrAKsNYJKX6qSuY6AAsqCT8Wr
 /L0A==
X-Gm-Message-State: AFuF++npcbqubV61g9OVd84sNX9iINU7QiJuubfxzxKvPTxRvUXiOq3a
 ITt+ZqNU1XlcjjBXZZiHzf/uacMEfadM2HMGLtLfUy/SvhQV9Nf4RkFlCjDB72z8zDpc0bKUk/3
 +k+FYdyWJkkjXxKT1y3ToEwXINGOWlV+dIIrQQ863ZrKa/p18Rj+kTpzOkpbPZ93V35xIeDb3Ne
 1ojXuaROvmX6s4pS+QyGr1jvRm9L3B8Hy0cQ==
X-Gm-Gg: AYBFou2X5zdSjcocu1m+g3JaukdfRgCETg4Yp4PvtWjZQPOtrN7BKnwldc+FNS6BFQT
 xCmezQXRALGgVLIM1g9iQlAX+kFEVg2oQ3zl9oZnhikHLSUdNmjSCA8sKvp5m0JgGPx6f8anxYt
 EoGxp402DlFW2Ic2sernoVD3QTPBLYSOOVjBUF3i1VNhEdAv9D+hdnJci1Qk1p2UwXpOoFmDyOz
 sUpA3JdsF371rKYePEz4Gknl+bkRadB55wBQNa15DUfFdqLAYATd245EmBJVooAg8YVoU6CRuj9
 nqEkYmaXs3HtsDTnLs0FfW6cndljno7TIVwzE3ihrFxQAWGDGyR2/P/iDjKOBUqux2NJmpWN2Ro
 YyaRTQoZ3YXyLzW8pn2aJMSw=
X-Received: by 2002:a05:600d:8444:10b0:49c:d818:8764 with SMTP id
 5b1f17b1804b1-49e61988253mr5830015e9.11.1789071146444; 
 Thu, 10 Sep 2026 13:12:26 -0700 (PDT)
X-Received: by 2002:a05:600d:8444:10b0:49c:d818:8764 with SMTP id
 5b1f17b1804b1-49e61988253mr5829735e9.11.1789071145975; 
 Thu, 10 Sep 2026 13:12:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60adaee4sm25603115e9.14.2026.09.10.13.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:25 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL 25/90] net/tap: QOMify tap backend
Message-ID: <3559b6073c917e55bbd8fffe8df42ead10c19cf9.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We prepare for being able to migrate TAP backend. We'll need a
user change-able property for it, which can be set from machine
type. So, let's QOMify it first.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-8-vsementsov@yandex-team.ru>
---
 include/net/net.h |  7 +++++++
 include/net/tap.h |  2 ++
 net/net.c         | 14 +++++++-------
 net/tap.c         | 48 +++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 626b997948..ea07760b56 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -161,6 +161,13 @@ char *qemu_mac_strdup_printf(const uint8_t *macaddr);
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
index 6f34f13eae..268570571f 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -28,6 +28,8 @@
 
 #include "standard-headers/linux/virtio_net.h"
 
+#define TYPE_TAP_NETDEV "tap-netdev"
+
 int tap_enable(NetClientState *nc);
 int tap_disable(NetClientState *nc);
 
diff --git a/net/net.c b/net/net.c
index 1161183e18..d7fa637ce5 100644
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
index bfed74717e..7392344200 100644
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
@@ -413,6 +418,19 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
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
@@ -435,6 +453,18 @@ static NetClientInfo net_tap_info = {
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
@@ -442,12 +472,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
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
@@ -1048,3 +1073,10 @@ int tap_disable(NetClientState *nc)
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
MST


