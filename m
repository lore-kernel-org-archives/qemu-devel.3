Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976F6C28B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKt6-0005rT-5v; Sat, 15 Mar 2025 02:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKs1-00040p-8L; Sat, 15 Mar 2025 02:19:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKry-0003Lp-Vx; Sat, 15 Mar 2025 02:19:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AB19AFF9DE;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 827B91CAC47;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 56A83558D3; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Dorinda Bassey <dbassey@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 18/51] vhost-user-snd: correct the calculation of
 config_size
Date: Sat, 15 Mar 2025 09:17:24 +0300
Message-Id: <20250315061801.622606-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>

Use virtio_get_config_size() rather than sizeof(struct
virtio_snd_config) for the config_size in the vhost-user-snd frontend.
The frontend shall rely on device features for the size of the device
configuration space. The presence of `controls` in the config space
depends on VIRTIO_SND_F_CTLS according to the specification (v1.3):
`
5.14.4 Device Configuration Layout
...

controls
(driver-read-only) indicates a total number of all available control
elements if VIRTIO_SND_F_CTLS has been negotiated.
`
This fixes an issue introduced by commit ab0c7fb2 ("linux-headers:
update to current kvm/next") in which the optional field `controls` is
added to the virtio_snd_config structure. This breaks vhost-user-device
backends that do not implement the `controls` field.

Fixes: ab0c7fb22b ("linux-headers: update to current kvm/next")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2805
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Message-Id: <20250217131255.829892-1-mvaralar@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Dorinda Bassey <dbassey@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit e87b6efb11be9f5ff213461f5ecdbae47d9402b9)
(Mjt: context fix for 9.2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 9a217543f8..348de6a486 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -16,6 +16,18 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_snd.h"
 
+static const VirtIOFeature feature_sizes[] = {
+    {.flags = 1ULL << VIRTIO_SND_F_CTLS,
+    .end = endof(struct virtio_snd_config, controls)},
+    {}
+};
+
+static const VirtIOConfigSizeParams cfg_size_params = {
+    .min_size = endof(struct virtio_snd_config, chmaps),
+    .max_size = sizeof(struct virtio_snd_config),
+    .feature_sizes = feature_sizes
+};
+
 static const VMStateDescription vu_snd_vmstate = {
     .name = "vhost-user-snd",
     .unmigratable = 1,
@@ -23,6 +35,8 @@ static const VMStateDescription vu_snd_vmstate = {
 
 static Property vsnd_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_BIT64("controls", VHostUserBase,
+                      parent_obj.host_features, VIRTIO_SND_F_CTLS, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -30,10 +44,12 @@ static void vu_snd_base_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
     VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
+    VirtIODevice *vdev = &vub->parent_obj;
 
     vub->virtio_id = VIRTIO_ID_SOUND;
     vub->num_vqs = 4;
-    vub->config_size = sizeof(struct virtio_snd_config);
+    vub->config_size = virtio_get_config_size(&cfg_size_params,
+                                              vdev->host_features);
     vub->vq_size = 64;
 
     vubs->parent_realize(dev, errp);
-- 
2.39.5


