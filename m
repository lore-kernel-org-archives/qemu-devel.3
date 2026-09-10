Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C58C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mKP-0001CH-ST; Thu, 10 Sep 2026 17:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lK2-0002QM-L1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJp-0000TF-OH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RmU1ZVuK0eWJ8g7D4bDyVxoI5VfvIMF1jU9CZuz+FqI=;
 b=Hjq1RdKZ0eA+LrdCMDEEf6/DIqabDWRaiXSvrWEjG+hwxjSkh6IX8dNkC7ApRQrVfjv95m
 mN4vPiiXfo40xQrMIjxo2kQi0pTxbOsR4QHtjfGX2ItZefY3nTZzFgNeBh81iB6GGTkChn
 4fm6iKUPcU54fMRw+/M/wxuj62Waiag=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-pNwfoZnEPnS0VcfjxdLsMA-1; Thu, 10 Sep 2026 16:12:30 -0400
X-MC-Unique: pNwfoZnEPnS0VcfjxdLsMA-1
X-Mimecast-MFC-AGG-ID: pNwfoZnEPnS0VcfjxdLsMA_1789071149
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so2190855e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071149; x=1789675949; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RmU1ZVuK0eWJ8g7D4bDyVxoI5VfvIMF1jU9CZuz+FqI=;
 b=S30Ft62Y8fsesBugWok85KY8OHvlNV2KPegyaV2S49Yxt70F9YejYLxBwqLHxgn0Zn
 abkrj0ISqzo1d+15dzSnFAmc9/lCia00t7uFmqj0490HArdIrYw02ik+xPu6XvqW2KH8
 fknAiN1Qmmrb9NEGeigl3X6ojweZekIOSBxWLBY5Bf5eMwoaWe/wo6PMyGCVAztCYJVU
 cFdRQRl0IALP4yE9kcfYsCBFd/g5tGjHn5d85ta48R9U/xJ//5yIpgum2IMTjcAcdzIh
 EWi7cDgMfIeC9A01juIuB//wral05tg2AocNgmHgrJ74vLgQcQjoPBvd1oaS8+J8YslB
 DTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071149; x=1789675949;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RmU1ZVuK0eWJ8g7D4bDyVxoI5VfvIMF1jU9CZuz+FqI=;
 b=JSBbTiIBElcTruTYBlfFJRadnePlYYYw+Z6XFWi3rLIRdgjMawBlVwbp+MPOQD1o1z
 rLi2Cc/a+x1TOAYEWnDQ069dRqRxGKInAr+9uZAfOy8mXPBW4YdFdhn5UUrHk6WOvYzB
 P7kohIj/HOu0yf4PJ1ijBxuJ7XNpqu6uNfQZMYiEkdUvjM/rCvJrjbbq/8vvNkh/j/qH
 wVeLdoU0VvN4IwW2smiGoXYAGYc5cgruEO6PIO6cPWpEGDpsSf5fBXtYc/vbrifSblcT
 9L5QSILEsLMqkYeXe3cazLo/Q9HyYcMCWtgycuKP55w31WC3hnFEzdBDEdsncRJZ9MFT
 WvmA==
X-Gm-Message-State: AFuF++lyxfHvAcIpsyi3ujmfX5X2wI0xC+J4hpc0RQ+TXLcR4/p9nbZQ
 GP8yqx4z3v1MXuNDs4Jqwpmrvd32U1ymI1azaT5cin+V0Tr82WcMtg+bQ4PnM4JComV1bHUcoYX
 MjtPO2ghRIyTSJP69wHBGnsXdfCSw5pyuaYgX9aRNI5j5o01VuPMWVRqMgZxRRQDm4Rbh89S2c1
 h9uiP2vo//wd8f0xAUgpxEws8NsA4zjKWWiQ==
X-Gm-Gg: AYBFou3NsQCFwhaDxh2DLOE1l9f9kQmaGcYXzgH3y7dpszkUiyIdrg3o8peDUv3rAqS
 PV8+Yyg/ct5kTRhjp3ByP+NlfaP1T+9LXDdKOzRbMhqx/IOXV9N704HWJkV7GhePFn+UpNYifnD
 8Q/BM62GsEkiel4VeUMIXRB+l6CCH6B/76TbeW+XYCWQkOv1MkRsjZeTZs36uyweNTD/lpxxAmg
 SRNyxME4vew6rdpsiYows66vliIrJrWAgpH8COk3FHJpzwTvJxy9lv4Mtg0zrSBd944kxNhqXVr
 QHVZXeqeDLJvbeoQVSy6qW18j7iCo/CS6qhbEY2jpFPBM2y5WJwhPNe1TiL8Rmi8fcqcQ08g7h6
 7EAyYvS2JSidcfG0f5UWsjG0=
X-Received: by 2002:a05:600c:b96:b0:49c:dada:30b7 with SMTP id
 5b1f17b1804b1-49e618898eamr7003625e9.2.1789071148924; 
 Thu, 10 Sep 2026 13:12:28 -0700 (PDT)
X-Received: by 2002:a05:600c:b96:b0:49c:dada:30b7 with SMTP id
 5b1f17b1804b1-49e618898eamr7003165e9.2.1789071148362; 
 Thu, 10 Sep 2026 13:12:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c494basm87343805e9.12.2026.09.10.13.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:27 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL 26/90] net/tap: add TYPE_VMSTATE_IF interface
Message-ID: <fc7964b03080b10fa32a9ed435d4ddb6399b14cc.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We'll need it to implement TAP backend live migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-9-vsementsov@yandex-team.ru>
---
 net/tap.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 7392344200..dd0d134875 100644
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
MST


