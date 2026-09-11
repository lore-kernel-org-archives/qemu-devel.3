Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF5BC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52QO-0004eB-HM; Fri, 11 Sep 2026 10:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52N2-0002Ls-Dm
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Mw-0007ri-J3
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8SFGy/hq0dW7bSxSgJO/zU5isKmK2Ilivs89TXlOVY=;
 b=ij7AzpuBkpZu5tMHiI2riRBYUCONbLSg0A9C+XsveWPUlEyBsJPZiTZ9DrJaVcbMRNV1bG
 7jnBPUPQqF8GpJjTLf+919pvC8AKxaKB9kgyZ//vPqyc2jiemn9BieC4mjpFGkJnxZ0pmx
 nPCSUg4R1raKU7lIthBY8QaO12HftS0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-QJAJc0lBOSyL8twcGOmj4g-1; Fri,
 11 Sep 2026 10:36:41 -0400
X-MC-Unique: QJAJc0lBOSyL8twcGOmj4g-1
X-Mimecast-MFC-AGG-ID: QJAJc0lBOSyL8twcGOmj4g_1789137399
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6CC21954202; Fri, 11 Sep 2026 14:36:39 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D6BFA3000229; Fri, 11 Sep 2026 14:36:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 04/28] hw: mark all virtio CCW devices as secure
Date: Fri, 11 Sep 2026 15:36:03 +0100
Message-ID: <20260911143627.2743803-5-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

These are all intended for use in a virtualization scenario and must
provide a security boundary.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/s390x/vhost-scsi-ccw.c     | 1 +
 hw/s390x/vhost-user-fs-ccw.c  | 1 +
 hw/s390x/vhost-vsock-ccw.c    | 1 +
 hw/s390x/virtio-ccw-9p.c      | 1 +
 hw/s390x/virtio-ccw-balloon.c | 1 +
 hw/s390x/virtio-ccw-blk.c     | 1 +
 hw/s390x/virtio-ccw-crypto.c  | 1 +
 hw/s390x/virtio-ccw-gpu.c     | 1 +
 hw/s390x/virtio-ccw-input.c   | 5 +++++
 hw/s390x/virtio-ccw-md.c      | 1 +
 hw/s390x/virtio-ccw-mem.c     | 1 +
 hw/s390x/virtio-ccw-net.c     | 1 +
 hw/s390x/virtio-ccw-rng.c     | 1 +
 hw/s390x/virtio-ccw-scsi.c    | 1 +
 hw/s390x/virtio-ccw-serial.c  | 1 +
 hw/s390x/virtio-ccw.c         | 1 +
 16 files changed, 20 insertions(+)

diff --git a/hw/s390x/vhost-scsi-ccw.c b/hw/s390x/vhost-scsi-ccw.c
index 1e68459eb0..2bd51a8033 100644
--- a/hw/s390x/vhost-scsi-ccw.c
+++ b/hw/s390x/vhost-scsi-ccw.c
@@ -62,6 +62,7 @@ static const TypeInfo vhost_ccw_scsi = {
     .instance_size = sizeof(VHostSCSICcw),
     .instance_init = vhost_ccw_scsi_instance_init,
     .class_init    = vhost_ccw_scsi_class_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_scsi_register(void)
diff --git a/hw/s390x/vhost-user-fs-ccw.c b/hw/s390x/vhost-user-fs-ccw.c
index 35a77e4cb7..6d341dc5e9 100644
--- a/hw/s390x/vhost-user-fs-ccw.c
+++ b/hw/s390x/vhost-user-fs-ccw.c
@@ -64,6 +64,7 @@ static const TypeInfo vhost_user_fs_ccw = {
     .instance_size = sizeof(VHostUserFSCcw),
     .instance_init = vhost_user_fs_ccw_instance_init,
     .class_init    = vhost_user_fs_ccw_class_init,
+    .secure        = true,
 };
 
 static void vhost_user_fs_ccw_register(void)
diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
index efdfdeec84..92b6d177e8 100644
--- a/hw/s390x/vhost-vsock-ccw.c
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -71,6 +71,7 @@ static const TypeInfo vhost_vsock_ccw_info = {
     .instance_size = sizeof(VHostVSockCCWState),
     .instance_init = vhost_vsock_ccw_instance_init,
     .class_init    = vhost_vsock_ccw_class_init,
+    .secure        = true,
 };
 
 static void vhost_vsock_ccw_register(void)
diff --git a/hw/s390x/virtio-ccw-9p.c b/hw/s390x/virtio-ccw-9p.c
index d8612f7cd1..08d3ee577b 100644
--- a/hw/s390x/virtio-ccw-9p.c
+++ b/hw/s390x/virtio-ccw-9p.c
@@ -64,6 +64,7 @@ static const TypeInfo virtio_ccw_9p_info = {
     .instance_size = sizeof(V9fsCCWState),
     .instance_init = virtio_ccw_9p_instance_init,
     .class_init    = virtio_ccw_9p_class_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_9p_register(void)
diff --git a/hw/s390x/virtio-ccw-balloon.c b/hw/s390x/virtio-ccw-balloon.c
index 4f67310b69..f7f5640cf1 100644
--- a/hw/s390x/virtio-ccw-balloon.c
+++ b/hw/s390x/virtio-ccw-balloon.c
@@ -69,6 +69,7 @@ static const TypeInfo virtio_ccw_balloon = {
     .instance_size = sizeof(VirtIOBalloonCcw),
     .instance_init = virtio_ccw_balloon_instance_init,
     .class_init    = virtio_ccw_balloon_class_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_balloon_register(void)
diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
index 939dcaeed3..dd4ac892b2 100644
--- a/hw/s390x/virtio-ccw-blk.c
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -67,6 +67,7 @@ static const TypeInfo virtio_ccw_blk = {
     .instance_size = sizeof(VirtIOBlkCcw),
     .instance_init = virtio_ccw_blk_instance_init,
     .class_init    = virtio_ccw_blk_class_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_blk_register(void)
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index 2c4ee2ca39..9f274562ac 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -67,6 +67,7 @@ static const TypeInfo virtio_ccw_crypto = {
     .instance_size = sizeof(VirtIOCryptoCcw),
     .instance_init = virtio_ccw_crypto_instance_init,
     .class_init    = virtio_ccw_crypto_class_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_crypto_register(void)
diff --git a/hw/s390x/virtio-ccw-gpu.c b/hw/s390x/virtio-ccw-gpu.c
index 4120c6bcb9..79c302860f 100644
--- a/hw/s390x/virtio-ccw-gpu.c
+++ b/hw/s390x/virtio-ccw-gpu.c
@@ -66,6 +66,7 @@ static const TypeInfo virtio_ccw_gpu = {
     .instance_size = sizeof(VirtIOGPUCcw),
     .instance_init = virtio_ccw_gpu_instance_init,
     .class_init    = virtio_ccw_gpu_class_init,
+    .secure        = true,
 };
 module_obj(TYPE_VIRTIO_GPU_CCW);
 module_kconfig(VIRTIO_CCW);
diff --git a/hw/s390x/virtio-ccw-input.c b/hw/s390x/virtio-ccw-input.c
index a9ec60428c..1ada4caa15 100644
--- a/hw/s390x/virtio-ccw-input.c
+++ b/hw/s390x/virtio-ccw-input.c
@@ -96,6 +96,7 @@ static const TypeInfo virtio_ccw_input = {
     .instance_size = sizeof(VirtIOInputCcw),
     .class_init    = virtio_ccw_input_class_init,
     .abstract = true,
+    .secure = true,
 };
 
 static const TypeInfo virtio_ccw_input_hid = {
@@ -103,6 +104,7 @@ static const TypeInfo virtio_ccw_input_hid = {
     .parent        = TYPE_VIRTIO_INPUT_CCW,
     .instance_size = sizeof(VirtIOInputHIDCcw),
     .abstract = true,
+    .secure = true,
 };
 
 static const TypeInfo virtio_ccw_keyboard = {
@@ -110,6 +112,7 @@ static const TypeInfo virtio_ccw_keyboard = {
     .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
     .instance_size = sizeof(VirtIOInputHIDCcw),
     .instance_init = virtio_ccw_keyboard_instance_init,
+    .secure        = true,
 };
 
 static const TypeInfo virtio_ccw_mouse = {
@@ -117,6 +120,7 @@ static const TypeInfo virtio_ccw_mouse = {
     .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
     .instance_size = sizeof(VirtIOInputHIDCcw),
     .instance_init = virtio_ccw_mouse_instance_init,
+    .secure        = true,
 };
 
 static const TypeInfo virtio_ccw_tablet = {
@@ -124,6 +128,7 @@ static const TypeInfo virtio_ccw_tablet = {
     .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
     .instance_size = sizeof(VirtIOInputHIDCcw),
     .instance_init = virtio_ccw_tablet_instance_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_input_register(void)
diff --git a/hw/s390x/virtio-ccw-md.c b/hw/s390x/virtio-ccw-md.c
index 0370f58450..9a0264efda 100644
--- a/hw/s390x/virtio-ccw-md.c
+++ b/hw/s390x/virtio-ccw-md.c
@@ -140,6 +140,7 @@ static const TypeInfo virtio_ccw_md_info = {
     .instance_size = sizeof(VirtIOMDCcw),
     .class_size = sizeof(VirtIOMDCcwClass),
     .abstract = true,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_MEMORY_DEVICE },
         { }
diff --git a/hw/s390x/virtio-ccw-mem.c b/hw/s390x/virtio-ccw-mem.c
index dea30aacfb..7014f0f92e 100644
--- a/hw/s390x/virtio-ccw-mem.c
+++ b/hw/s390x/virtio-ccw-mem.c
@@ -216,6 +216,7 @@ static const TypeInfo virtio_ccw_mem = {
     .instance_size = sizeof(VirtIOMEMCcw),
     .instance_init = virtio_ccw_mem_instance_init,
     .class_init = virtio_ccw_mem_class_init,
+    .secure = true,
 };
 
 static void virtio_ccw_mem_register_types(void)
diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
index 30e7055ab2..d39311a9f0 100644
--- a/hw/s390x/virtio-ccw-net.c
+++ b/hw/s390x/virtio-ccw-net.c
@@ -70,6 +70,7 @@ static const TypeInfo virtio_ccw_net = {
     .instance_size = sizeof(VirtIONetCcw),
     .instance_init = virtio_ccw_net_instance_init,
     .class_init    = virtio_ccw_net_class_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_net_register(void)
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index 0647621e33..8b62fd9905 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -66,6 +66,7 @@ static const TypeInfo virtio_ccw_rng = {
     .instance_size = sizeof(VirtIORNGCcw),
     .instance_init = virtio_ccw_rng_instance_init,
     .class_init    = virtio_ccw_rng_class_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_rng_register(void)
diff --git a/hw/s390x/virtio-ccw-scsi.c b/hw/s390x/virtio-ccw-scsi.c
index c181a2b769..baac329d75 100644
--- a/hw/s390x/virtio-ccw-scsi.c
+++ b/hw/s390x/virtio-ccw-scsi.c
@@ -76,6 +76,7 @@ static const TypeInfo virtio_ccw_scsi = {
     .instance_size = sizeof(VirtIOSCSICcw),
     .instance_init = virtio_ccw_scsi_instance_init,
     .class_init    = virtio_ccw_scsi_class_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_scsi_register(void)
diff --git a/hw/s390x/virtio-ccw-serial.c b/hw/s390x/virtio-ccw-serial.c
index 7ff07a0841..9a1686a4dc 100644
--- a/hw/s390x/virtio-ccw-serial.c
+++ b/hw/s390x/virtio-ccw-serial.c
@@ -76,6 +76,7 @@ static const TypeInfo virtio_ccw_serial = {
     .instance_size = sizeof(VirtioSerialCcw),
     .instance_init = virtio_ccw_serial_instance_init,
     .class_init    = virtio_ccw_serial_class_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_serial_register(void)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index d82874ed27..bf01e5a7fa 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1264,6 +1264,7 @@ static const TypeInfo virtio_ccw_device_info = {
     .class_init = virtio_ccw_device_class_init,
     .class_size = sizeof(VirtIOCCWDeviceClass),
     .abstract = true,
+    .secure = true,
 };
 
 /* virtio-ccw-bus */
-- 
2.55.0


