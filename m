Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A698C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52QP-0004gF-Ui; Fri, 11 Sep 2026 10:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52N3-0002M2-UL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52My-0007s1-Dj
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ITXs1RC82PxSIg8yFFapmKCFNMrOr2p5NsMTwGt6/Sk=;
 b=Hv0mDAeG9XcJ/g7/u5HT88JjyYW9aMBGqWEnQr4EEoGA/MecWqKC9gQm4QzLyIVSrGOjwb
 BOT1TVA1WCyJDJtrnWdwSNE6/FB/LdXh5tNQ1GA+UQeDKW5+0kz+yauWJx/SH3goUQN0/Y
 ZGDpI4HEo4zvp7XIIYmdk73zRBM2E6c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-_kA9vgHhO4OI92Jt3oP7vg-1; Fri,
 11 Sep 2026 10:36:43 -0400
X-MC-Unique: _kA9vgHhO4OI92Jt3oP7vg-1
X-Mimecast-MFC-AGG-ID: _kA9vgHhO4OI92Jt3oP7vg_1789137401
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4EE5180074A; Fri, 11 Sep 2026 14:36:41 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 052D53000229; Fri, 11 Sep 2026 14:36:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 05/28] hw: mark all vhost devices a secure
Date: Fri, 11 Sep 2026 15:36:04 +0100
Message-ID: <20260911143627.2743803-6-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

These are all intended for use in a virtualization scenario and must
provide a security boundary.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/block/vhost-user-blk.c          | 1 +
 hw/display/vhost-user-gpu.c        | 1 +
 hw/scsi/vhost-scsi-common.c        | 1 +
 hw/scsi/vhost-scsi.c               | 1 +
 hw/scsi/vhost-user-scsi.c          | 1 +
 hw/virtio/vhost-user-base.c        | 3 ++-
 hw/virtio/vhost-user-fs.c          | 1 +
 hw/virtio/vhost-user-gpio.c        | 1 +
 hw/virtio/vhost-user-i2c.c         | 1 +
 hw/virtio/vhost-user-input.c       | 1 +
 hw/virtio/vhost-user-rng.c         | 1 +
 hw/virtio/vhost-user-rtc.c         | 1 +
 hw/virtio/vhost-user-scmi.c        | 1 +
 hw/virtio/vhost-user-snd.c         | 1 +
 hw/virtio/vhost-user-spi.c         | 1 +
 hw/virtio/vhost-user-test-device.c | 1 +
 hw/virtio/vhost-user-vsock.c       | 1 +
 hw/virtio/vhost-vsock-common.c     | 1 +
 hw/virtio/vhost-vsock.c            | 1 +
 19 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 2e5b3ae1b1..105d77e543 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -673,6 +673,7 @@ static const TypeInfo vhost_user_blk_info = {
     .instance_size = sizeof(VHostUserBlk),
     .instance_init = vhost_user_blk_instance_init,
     .class_init = vhost_user_blk_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index cd684d6363..4204cac483 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -727,6 +727,7 @@ static const TypeInfo vhost_user_gpu_info = {
     .instance_init = vhost_user_gpu_instance_init,
     .instance_finalize = vhost_user_gpu_instance_finalize,
     .class_init = vhost_user_gpu_class_init,
+    .secure = true,
 };
 module_obj(TYPE_VHOST_USER_GPU);
 module_kconfig(VHOST_USER_GPU);
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index e19800a0bc..7b0007a30e 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -164,6 +164,7 @@ static const TypeInfo vhost_scsi_common_info = {
     .parent = TYPE_VIRTIO_SCSI_COMMON,
     .instance_size = sizeof(VHostSCSICommon),
     .abstract = true,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 657403cad0..e1f209fabb 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -400,6 +400,7 @@ static const TypeInfo vhost_scsi_info = {
     .instance_size = sizeof(VHostSCSI),
     .class_init = vhost_scsi_class_init,
     .instance_init = vhost_scsi_instance_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { }
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 5070178dc2..8906997051 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -425,6 +425,7 @@ static const TypeInfo vhost_user_scsi_info = {
     .instance_size = sizeof(VHostUserSCSI),
     .class_init = vhost_user_scsi_class_init,
     .instance_init = vhost_user_scsi_instance_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { }
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 478ec68f09..682c06f26b 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -426,7 +426,8 @@ static const TypeInfo vub_types[] = {
         .instance_size = sizeof(VHostUserBase),
         .class_init = vub_class_init,
         .class_size = sizeof(VHostUserBaseClass),
-        .abstract = true
+        .abstract = true,
+        .secure = true,
     }
 };
 
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 209993918a..9901f84bfb 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -448,6 +448,7 @@ static const TypeInfo vuf_info = {
     .instance_size = sizeof(VHostUserFS),
     .instance_init = vuf_instance_init,
     .class_init = vuf_class_init,
+    .secure = true,
 };
 
 static void vuf_register_types(void)
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index d473f87077..cec21106e0 100644
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
index 152b1f6740..17b0b44413 100644
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
index 106c8f211a..dc1286559c 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -55,6 +55,7 @@ static const TypeInfo vu_rng_info = {
     .parent = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserRNG),
     .class_init = vu_rng_class_init,
+    .secure = true,
 };
 
 static void vu_rng_register_types(void)
diff --git a/hw/virtio/vhost-user-rtc.c b/hw/virtio/vhost-user-rtc.c
index 88b0c70b90..2cb949590e 100644
--- a/hw/virtio/vhost-user-rtc.c
+++ b/hw/virtio/vhost-user-rtc.c
@@ -54,6 +54,7 @@ static const TypeInfo vu_rtc_info = {
     .parent = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserRTC),
     .class_init = vu_rtc_class_init,
+    .secure = true,
 };
 
 static void vu_rtc_register_types(void)
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 02dc088ea9..c5f7f0afb0 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -310,6 +310,7 @@ static const TypeInfo vu_scmi_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VHostUserSCMI),
     .class_init = vu_scmi_class_init,
+    .secure = true,
 };
 
 static void vu_scmi_register_types(void)
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 7129b77d9c..3695534aa2 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -72,6 +72,7 @@ static const TypeInfo vu_snd_info = {
     .parent = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserSound),
     .class_init = vu_snd_class_init,
+    .secure = true,
 };
 
 static void vu_snd_register_types(void)
diff --git a/hw/virtio/vhost-user-spi.c b/hw/virtio/vhost-user-spi.c
index 707f96c250..58d5fd7b46 100644
--- a/hw/virtio/vhost-user-spi.c
+++ b/hw/virtio/vhost-user-spi.c
@@ -55,6 +55,7 @@ static const TypeInfo vu_spi_info = {
     .parent = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserSPI),
     .class_init = vu_spi_class_init,
+    .secure = true,
 };
 
 static void vu_spi_register_types(void)
diff --git a/hw/virtio/vhost-user-test-device.c b/hw/virtio/vhost-user-test-device.c
index a2f963fdf6..73da8af48a 100644
--- a/hw/virtio/vhost-user-test-device.c
+++ b/hw/virtio/vhost-user-test-device.c
@@ -50,6 +50,7 @@ static const TypeInfo vud_info = {
     .name = TYPE_VHOST_USER_TEST_DEVICE,
     .parent = TYPE_VHOST_USER_BASE,
     .class_init = vud_class_init,
+    .secure = true,
 };
 
 static void vu_register_types(void)
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index c2cd376e73..e10ceb95cb 100644
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
index b79f4c9ce6..01f7dea6f5 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -309,6 +309,7 @@ static const TypeInfo vhost_vsock_common_info = {
     .instance_size = sizeof(VHostVSockCommon),
     .class_init = vhost_vsock_common_class_init,
     .abstract = true,
+    .secure = true,
 };
 
 static void vhost_vsock_common_register_types(void)
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb165..66a17ee15f 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -225,6 +225,7 @@ static const TypeInfo vhost_vsock_info = {
     .parent = TYPE_VHOST_VSOCK_COMMON,
     .instance_size = sizeof(VHostVSock),
     .class_init = vhost_vsock_class_init,
+    .secure = true,
 };
 
 static void vhost_vsock_register_types(void)
-- 
2.55.0


