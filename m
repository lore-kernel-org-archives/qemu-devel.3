Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297E6CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v293R-0006no-4Q; Fri, 26 Sep 2025 10:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293L-0006n4-JZ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293E-0004rV-Fg
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0EG0UHxXlT7ifLJrFLKM9KqjYitx4zh2UVX0jlUVOoU=;
 b=G+Qc0flPW7ntgKpQz9GSFrFWUuvlOz/8mPH+vWzlKgI2CJeblu4WyRkNSC4HjOB4okmP/b
 ZdQuhVNV9kEzPBxxcePIJvdpMfBJqtBCXNnaq+PZhYSyt4v5SUL182ewCYhq0qXOSGu3wZ
 KOVJYeZv664j3QTaT2uwwM2m1AJ1xeM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-q_O02v1WPRuAbEuEFU9wcA-1; Fri,
 26 Sep 2025 10:03:51 -0400
X-MC-Unique: q_O02v1WPRuAbEuEFU9wcA-1
X-Mimecast-MFC-AGG-ID: q_O02v1WPRuAbEuEFU9wcA_1758895430
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5ED49180057B; Fri, 26 Sep 2025 14:03:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BF8F1956095; Fri, 26 Sep 2025 14:03:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 20/32] hw: mark all vhost devices a secure
Date: Fri, 26 Sep 2025 15:01:31 +0100
Message-ID: <20250926140144.1998694-21-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These are all intended for use in a virtualization scenario and must
provide a security boundary.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/block/vhost-user-blk.c      | 1 +
 hw/display/vhost-user-gpu.c    | 1 +
 hw/scsi/vhost-scsi.c           | 1 +
 hw/scsi/vhost-user-scsi.c      | 1 +
 hw/virtio/vhost-user-base.c    | 3 ++-
 hw/virtio/vhost-user-device.c  | 1 +
 hw/virtio/vhost-user-fs.c      | 1 +
 hw/virtio/vhost-user-gpio.c    | 1 +
 hw/virtio/vhost-user-i2c.c     | 1 +
 hw/virtio/vhost-user-input.c   | 1 +
 hw/virtio/vhost-user-rng.c     | 1 +
 hw/virtio/vhost-user-scmi.c    | 1 +
 hw/virtio/vhost-user-snd.c     | 1 +
 hw/virtio/vhost-user-vsock.c   | 1 +
 hw/virtio/vhost-vsock-common.c | 1 +
 hw/virtio/vhost-vsock.c        | 1 +
 16 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c0cc5f6942..dbe672c5c4 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -618,6 +618,7 @@ static const TypeInfo vhost_user_blk_info = {
     .instance_size = sizeof(VHostUserBlk),
     .instance_init = vhost_user_blk_instance_init,
     .class_init = vhost_user_blk_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 9fc6bbcd2c..3fc6267c4f 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -694,6 +694,7 @@ static const TypeInfo vhost_user_gpu_info = {
     .instance_init = vhost_user_gpu_instance_init,
     .instance_finalize = vhost_user_gpu_instance_finalize,
     .class_init = vhost_user_gpu_class_init,
+    .secure = true,
 };
 module_obj(TYPE_VHOST_USER_GPU);
 module_kconfig(VHOST_USER_GPU);
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index cdf405b0f8..7b8aec50e6 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -401,6 +401,7 @@ static const TypeInfo vhost_scsi_info = {
     .instance_size = sizeof(VHostSCSI),
     .class_init = vhost_scsi_class_init,
     .instance_init = vhost_scsi_instance_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { }
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 25f2d894e7..0ce5436090 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -426,6 +426,7 @@ static const TypeInfo vhost_user_scsi_info = {
     .instance_size = sizeof(VHostUserSCSI),
     .class_init = vhost_user_scsi_class_init,
     .instance_init = vhost_user_scsi_instance_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { }
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index ff67a020b4..626657ced3 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -372,7 +372,8 @@ static const TypeInfo vub_types[] = {
         .instance_size = sizeof(VHostUserBase),
         .class_init = vub_class_init,
         .class_size = sizeof(VHostUserBaseClass),
-        .abstract = true
+        .abstract = true,
+        .secure = true,
     }
 };
 
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index 3939bdf755..d2e80c9f09 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -53,6 +53,7 @@ static const TypeInfo vud_info = {
     .name = TYPE_VHOST_USER_DEVICE,
     .parent = TYPE_VHOST_USER_BASE,
     .class_init = vud_class_init,
+    .secure = true,
 };
 
 static void vu_register_types(void)
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index e77c69eb12..6861e4ff33 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -447,6 +447,7 @@ static const TypeInfo vuf_info = {
     .instance_size = sizeof(VHostUserFS),
     .instance_init = vuf_instance_init,
     .class_init = vuf_class_init,
+    .secure = true,
 };
 
 static void vuf_register_types(void)
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index a7fd49b10a..47b9d685a2 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -53,6 +53,7 @@ static const TypeInfo vu_gpio_info = {
     .parent = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserGPIO),
     .class_init = vu_gpio_class_init,
+    .secure = true,
 };
 
 static void vu_gpio_register_types(void)
diff --git a/hw/virtio/vhost-user-i2c.c b/hw/virtio/vhost-user-i2c.c
index ae007fe97d..6e7558bc85 100644
--- a/hw/virtio/vhost-user-i2c.c
+++ b/hw/virtio/vhost-user-i2c.c
@@ -53,6 +53,7 @@ static const TypeInfo vu_i2c_info = {
     .parent = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserI2C),
     .class_init = vu_i2c_class_init,
+    .secure = true,
 };
 
 static void vu_i2c_register_types(void)
diff --git a/hw/virtio/vhost-user-input.c b/hw/virtio/vhost-user-input.c
index 5cfc5bbb56..a850e3770e 100644
--- a/hw/virtio/vhost-user-input.c
+++ b/hw/virtio/vhost-user-input.c
@@ -47,6 +47,7 @@ static const TypeInfo vhost_input_info = {
     .parent        = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserInput),
     .class_init    = vhost_input_class_init,
+    .secure        = true,
 };
 
 static void vhost_input_register_types(void)
diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index 61dadcda05..5ebae80635 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -55,6 +55,7 @@ static const TypeInfo vu_rng_info = {
     .parent = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserRNG),
     .class_init = vu_rng_class_init,
+    .secure = true,
 };
 
 static void vu_rng_register_types(void)
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index f9264c4374..565618d7aa 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -305,6 +305,7 @@ static const TypeInfo vu_scmi_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VHostUserSCMI),
     .class_init = vu_scmi_class_init,
+    .secure = true,
 };
 
 static void vu_scmi_register_types(void)
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 732411c655..d79e7d037c 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -72,6 +72,7 @@ static const TypeInfo vu_snd_info = {
     .parent = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserSound),
     .class_init = vu_snd_class_init,
+    .secure = true,
 };
 
 static void vu_snd_register_types(void)
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index 993c287348..a430d07a55 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -175,6 +175,7 @@ static const TypeInfo vuv_info = {
     .parent = TYPE_VHOST_VSOCK_COMMON,
     .instance_size = sizeof(VHostUserVSock),
     .class_init = vuv_class_init,
+    .secure = true,
 };
 
 static void vuv_register_types(void)
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index c6c44d8989..d06d2342d9 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -308,6 +308,7 @@ static const TypeInfo vhost_vsock_common_info = {
     .instance_size = sizeof(VHostVSockCommon),
     .class_init = vhost_vsock_common_class_init,
     .abstract = true,
+    .secure = true,
 };
 
 static void vhost_vsock_common_register_types(void)
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 107d88babe..0fefe94b52 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -226,6 +226,7 @@ static const TypeInfo vhost_vsock_info = {
     .parent = TYPE_VHOST_VSOCK_COMMON,
     .instance_size = sizeof(VHostVSock),
     .class_init = vhost_vsock_class_init,
+    .secure = true,
 };
 
 static void vhost_vsock_register_types(void)
-- 
2.50.1


