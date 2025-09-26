Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E638CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v293T-0006p1-Ve; Fri, 26 Sep 2025 10:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293N-0006nd-J0
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293A-0004qi-C3
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ea+0MhEY9iX2+yYiaaMVa1DUQB95GkrV93+grZ+Cioc=;
 b=dw5x/81C76NeWjM7FrEulybCu+iKYySNRDQOj2/Pkto9nOo+yp2XCQekZksqKYbDeLAHou
 SWeNl6n717AJ/iK3r0kqR4omJvNBGK6FuKZt9NJ1BsZjoHFf6RvoZzQ+QjwJ5ssi9Hx2Wx
 3MtgR8KBsZ6bWT8TjYSuyFGk6NPwBYo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-MEJXisDkOzC7Cj_FeY2XMA-1; Fri,
 26 Sep 2025 10:03:46 -0400
X-MC-Unique: MEJXisDkOzC7Cj_FeY2XMA-1
X-Mimecast-MFC-AGG-ID: MEJXisDkOzC7Cj_FeY2XMA_1758895425
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8DB01800597; Fri, 26 Sep 2025 14:03:44 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96F9A1956095; Fri, 26 Sep 2025 14:03:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 19/32] hw: mark all virtio CCW devices as secure
Date: Fri, 26 Sep 2025 15:01:30 +0100
Message-ID: <20250926140144.1998694-20-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 8341b23a95..2a16f8d06e 100644
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
index cc1b8227fc..74c2ac288b 100644
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
index 552e9e86a4..60a286f6d5 100644
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
index 72bf6ec80c..72430b9897 100644
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
index 399b40f366..40425a5995 100644
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
index 7d8c4a75ce..a61da0f6d6 100644
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
index 75e714603b..0903cc0c97 100644
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
index edb6a47d37..9f6170bcd4 100644
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
index 2250d8cf98..f5e1a209d1 100644
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
index daa485d189..719386cfa7 100644
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
index a7d4afbeb9..b2ebc76000 100644
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
index 3263287d45..6216cc76dc 100644
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
index 06b4c6c4a5..a9e99b5af1 100644
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
index 0dac590c08..5ae7bb2f30 100644
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
index d2f85b39f3..5977357aa9 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1249,6 +1249,7 @@ static const TypeInfo virtio_ccw_device_info = {
     .class_init = virtio_ccw_device_class_init,
     .class_size = sizeof(VirtIOCCWDeviceClass),
     .abstract = true,
+    .secure = true,
 };
 
 /* virtio-ccw-bus */
-- 
2.50.1


