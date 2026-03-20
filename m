Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62CB10987AF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3csb-0003IL-36; Fri, 20 Mar 2026 12:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1w3csG-0003He-JA
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1w3cs9-0006P5-3h
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774024730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ojVgpHPdozufTm2eUCtk3vbv6e1CEZRkZVvHlIrz0JI=;
 b=e9Psw3N3qKS01L+hoON/ug8flSEZODEn+supIXS4jRY9gIFD6dmTqQ/X37Srk14KQqeHhw
 fsNecdfo4C/P/iY1vLcuk5hRMcXejiNL2B9T5ubmVnv/2+HD12lhBBhO2nHVkAB7R/FYCN
 uvbpRaa3afLHaoEh2S4AjRUBYvA8hAI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-04JXGDxbO2enli6-BCpruA-1; Fri,
 20 Mar 2026 12:38:48 -0400
X-MC-Unique: 04JXGDxbO2enli6-BCpruA-1
X-Mimecast-MFC-AGG-ID: 04JXGDxbO2enli6-BCpruA_1774024728
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FF98195609D
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 16:38:48 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.224.233])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16A1B1800763; Fri, 20 Mar 2026 16:38:45 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] virtio-net: allow vhost-user backends to provide config space
Date: Fri, 20 Mar 2026 17:38:44 +0100
Message-ID: <20260320163844.754762-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Remove the vDPA-only guard on vhost_net_get_config/set_config calls so
any vhost backend that negotiates VHOST_USER_PROTOCOL_F_CONFIG can
provide device configuration.

To manage backends that don't support vhost_net_get_config/set_config,
modify the stubs and vhost_net_get_config/vhost_net_set_config
with NULL vhost_net parameter to return -ENOSYS.

Until now VHOST_USER_PROTOCOL_F_CONFIG was requisited with the
supports_config flag in VhostUserState or ignored, but now stop
stripping VHOST_USER_PROTOCOL_F_CONFIG when the device code doesn't
explicitly require it, so vhost-user backends that advertise F_CONFIG
can negotiate it.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net-stub.c |  4 ++--
 hw/net/vhost_net.c      |  8 ++++++++
 hw/net/virtio-net.c     | 36 ++++++++++--------------------------
 hw/virtio/vhost-user.c  | 31 +++++++++++--------------------
 4 files changed, 31 insertions(+), 48 deletions(-)

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 0740d5a2ebe6..6edc0a222f3b 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -53,12 +53,12 @@ void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
                          uint32_t config_len)
 {
-    return 0;
+    return -ENOSYS;
 }
 int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
                          uint32_t offset, uint32_t size, uint32_t flags)
 {
-    return 0;
+    return -ENOSYS;
 }
 
 void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index a8ee18a91266..13f926b5cfb6 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -42,11 +42,19 @@ void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
                          uint32_t config_len)
 {
+    if (net == NULL) {
+        return -EINVAL;
+    }
+
     return vhost_dev_get_config(&net->dev, config, config_len, NULL);
 }
 int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
                          uint32_t offset, uint32_t size, uint32_t flags)
 {
+    if (net == NULL) {
+        return -EINVAL;
+    }
+
     return vhost_dev_set_config(&net->dev, data, offset, size, flags);
 }
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2a5d642a6476..7ad2dac450d9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -180,17 +180,9 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
                  n->rss_data.supported_hash_types);
     memcpy(config, &netcfg, n->config_size);
 
-    /*
-     * Is this VDPA? No peer means not VDPA: there's no way to
-     * disconnect/reconnect a VDPA peer.
-     */
-    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
-        ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
-                                   n->config_size);
-        if (ret == -1) {
-            return;
-        }
-
+    ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
+                               n->config_size);
+    if (ret >= 0) {
         /*
          * Some NIC/kernel combinations present 0 as the mac address.  As that
          * is not a legal address, try to proceed with the address from the
@@ -223,15 +215,9 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
         qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
     }
 
-    /*
-     * Is this VDPA? No peer means not VDPA: there's no way to
-     * disconnect/reconnect a VDPA peer.
-     */
-    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
-        vhost_net_set_config(get_vhost_net(nc->peer),
-                             (uint8_t *)&netcfg, 0, n->config_size,
-                             VHOST_SET_CONFIG_TYPE_FRONTEND);
-      }
+    vhost_net_set_config(get_vhost_net(nc->peer),
+                         (uint8_t *)&netcfg, 0, n->config_size,
+                         VHOST_SET_CONFIG_TYPE_FRONTEND);
 }
 
 static bool virtio_net_started(VirtIONet *n, uint8_t status)
@@ -3868,6 +3854,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIONet *n = VIRTIO_NET(dev);
+    struct virtio_net_config netcfg = {};
     NetClientState *nc;
     int i;
 
@@ -4023,12 +4010,9 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
 
-   if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
-        struct virtio_net_config netcfg = {};
-        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
-        vhost_net_set_config(get_vhost_net(nc->peer),
-            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
-    }
+    memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
+    vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg, 0,
+                         ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a8907cca74ec..2c310403851f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2196,28 +2196,19 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
             return -EPROTO;
         }
 
-        /*
-         * We will use all the protocol features we support - although
-         * we suppress F_CONFIG if we know QEMUs internal code can not support
-         * it.
-         */
         protocol_features &= VHOST_USER_PROTOCOL_FEATURE_MASK;
 
-        if (supports_f_config) {
-            if (!virtio_has_feature(protocol_features,
-                                    VHOST_USER_PROTOCOL_F_CONFIG)) {
-                error_setg(errp, "vhost-user device expecting "
-                           "VHOST_USER_PROTOCOL_F_CONFIG but the vhost-user backend does "
-                           "not support it.");
-                return -EPROTO;
-            }
-        } else {
-            if (virtio_has_feature(protocol_features,
-                                   VHOST_USER_PROTOCOL_F_CONFIG)) {
-                warn_report("vhost-user backend supports "
-                            "VHOST_USER_PROTOCOL_F_CONFIG but QEMU does not.");
-                protocol_features &= ~(1ULL << VHOST_USER_PROTOCOL_F_CONFIG);
-            }
+        /*
+         * Fail if vhost-user device expects F_CONFIG but backend doesn't
+         * provide it. Otherwise negotiate as usual.
+         */
+        if (supports_f_config &&
+            !virtio_has_feature(protocol_features,
+                                VHOST_USER_PROTOCOL_F_CONFIG)) {
+            error_setg(errp, "vhost-user device expecting "
+                       "VHOST_USER_PROTOCOL_F_CONFIG but the vhost-user backend does "
+                       "not support it.");
+            return -EPROTO;
         }
 
         if (!u->user->supports_inflight_migration ||
-- 
2.53.0


