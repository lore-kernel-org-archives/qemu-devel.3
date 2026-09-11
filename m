Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DE4C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9I-0002PQ-Nz; Fri, 11 Sep 2026 05:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x94-00028y-8u
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x92-00086Z-DR
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RmU1ZVuK0eWJ8g7D4bDyVxoI5VfvIMF1jU9CZuz+FqI=;
 b=PfkwchiiJyyABKOh9UfbR3Ku2WVQWXA7najAu7TRKwj7tmK5GpqjFuKiFZt86bcWr5VOTf
 oDJlPvPsuDUY8OHplPLoeAl4TMTYRy7+IxePUQXTU78CnF7x832AqhBxZ8lCsxeUIISN+3
 ycyXw4gkGlC3stGcApW06VnT5DNvrlY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-BLWcj7G7N92UKvxP6JqDoQ-1; Fri, 11 Sep 2026 05:02:00 -0400
X-MC-Unique: BLWcj7G7N92UKvxP6JqDoQ-1
X-Mimecast-MFC-AGG-ID: BLWcj7G7N92UKvxP6JqDoQ_1789117319
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f4bff865cso359937f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117319; x=1789722119; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RmU1ZVuK0eWJ8g7D4bDyVxoI5VfvIMF1jU9CZuz+FqI=;
 b=IEh6FHfUBH3RDv216M4yqKWUM0d9Za2Z+w8h+UZqkJuK7WSrTkkOpT6XyCA2wsNKkq
 Q1CLrHssr6T7jR050f+wkQATEMuQhVRMcFKHIm7A1Dj0yRPPY6bqs3XWOZ9GyDaotkIl
 M0YIRJn9NCtXycS4N85pLFL/a0Eysz9WT82lFy5q6mgvyivvU1fmqoUUts582RE8HGq9
 1SmMFLu9B3HVHsK/VyrwZJrzYdqGrX3DnjUBzIZZxc/D6qB3W5Hr8YAYRyKCbeCwZekQ
 A/ImC0jX9x1ch4tj0OPf/6fHu4VPW1DgKfXg1ZzWgdpLAALYpvnDOWrpHB+uXG1A31uL
 tf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117319; x=1789722119;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RmU1ZVuK0eWJ8g7D4bDyVxoI5VfvIMF1jU9CZuz+FqI=;
 b=icozD3kO4ndHrYu5Av9uCsRNx8rAsHzVAKuj4VkQ9uQC3ylHiwm7gS5alNiYC6Ijyq
 Ve/XY1IjkKEdCMJfuoszjcJJWYNjbFis/EFgfpHSHX6lUrgiwkYYWjtGsPOleCyUQReO
 SCbRLOV2c5V04t4zZ+6oudX28atdndF0u9Wd659h3sC3+PbdLCY2tmteKntl1pHF0dzg
 GmUg6stUOAp4hcfa39GducdDPc1EUs+GFyiY4Vx0yVtVcPtoa6NVtCR7uAdDH55Aa8Nu
 EqkfmvZAZcwtsR7OQ5Drsn0MG2hNXcRcMA2fZa7D486kZwOxNnAvf1nLhj0GAz2rZtle
 56Vw==
X-Gm-Message-State: AFuF++n25GMr6/HGqkQV3GYyv9bDJ7VUI8f4geOCUI3cNVODd84R15fW
 OKA1N16PcO4//NuYeWE44zFyT+nuvGBXSA5glQwpT9OktaZ86tZjflGMuu8RK2sce0UN7dcU2DQ
 XyoOh31y31TCUWYiuN0Dlo1yR2KsqqvFDUZla9ebb3NVCOMU8ThlvKpITQfXVZLJh+pov2LSbNX
 SZF9sYPdyf9hwmgvp+Smkhx97D46f3hdlX2g==
X-Gm-Gg: AYBFou1TgMnnKZQL52ytOyWZJ1ShLiTTrH67eto2ODfKeudPeFFnpGs7RAd1d9UPmp6
 7cnIkXyDGJVW156PmQtEsJzeFoeoW1dC1CHQaVgY01/QaAiLguJ9y8u6SfDFvi4kyV8PnopqC3X
 co2meQ7bFaZmdnKnOMkBIHmMAIdslM3qR+d9bsLgoj+ppz1YnLNwbksfzqIDsES28b5Brsj2/7E
 F5dxrm3pgg7tA/pMwjXpkxICZySLpTR9TE++5mrM8APrq1HKsR+RUndFtbYWs5iJjbZsgMiL2SO
 kREPRVgfLw//v5ywgFels+ZN8ZAqAXU7WqgfjC4TsRnG77ojlj9QY9W07NshwYR6ZXpihWZN4Ft
 C/gvwILki28Sx2OX330kYg4c=
X-Received: by 2002:adf:e00b:0:10b0:484:3310:710c with SMTP id
 ffacd0b85a97d-486eb351000mr4929127f8f.24.1789117319034; 
 Fri, 11 Sep 2026 02:01:59 -0700 (PDT)
X-Received: by 2002:adf:e00b:0:10b0:484:3310:710c with SMTP id
 ffacd0b85a97d-486eb351000mr4929027f8f.24.1789117318374; 
 Fri, 11 Sep 2026 02:01:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486f301121asm310240f8f.0.2026.09.11.02.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:57 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL v2 16/75] net/tap: add TYPE_VMSTATE_IF interface
Message-ID: <9fe286589d7c5f9c944a4855d932c40b24a82adc.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
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


