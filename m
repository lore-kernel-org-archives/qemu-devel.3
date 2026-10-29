Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VGqF+Lx9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPx6-0008RI-Bu; Thu, 29 Oct 2026 09:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwM-0007oT-To
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwE-00067f-0m
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ytvqd2n+blzrWyy7zvQFqV06YwIDv3bBMmdY4VTkQu4=;
 b=VGqF+Lx9yvwm0SVzd6txfMAvShJMLvy6zUIk6hyqZh7t+bnf3W5mRx03yTvv0N+MGWo3uE
 8XEj55oKA5ND32JY94oWzDWZYj6C8NiVG30e+7KGnvDDeLWxmKqLRpBMsQJMmRZz2SLj4Z
 k1fxkbssb03Mocq6Wp1wU/rVPqwfYhA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-RgqlW2jyO0-aiNzAOGYWlA-1; Thu,
 29 Oct 2026 09:12:53 -0400
X-MC-Unique: RgqlW2jyO0-aiNzAOGYWlA-1
X-Mimecast-MFC-AGG-ID: RgqlW2jyO0-aiNzAOGYWlA_1793279572
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CBA41955EA2; Thu, 29 Oct 2026 13:12:52 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41CD63000738; Thu, 29 Oct 2026 13:12:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 02/28] hw: mark all virtio CCW devices as secure
Date: Thu, 29 Oct 2026 13:12:15 +0000
Message-ID: <20261029131241.2275706-3-berrange@redhat.com>
In-Reply-To: <20261029131241.2275706-1-berrange@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These are all intended for use in a virtualization scenario and must
provide a security boundary.

Acked-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
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
 hw/s390x/virtio-ccw-input.c   | 3 +++
 hw/s390x/virtio-ccw-mem.c     | 1 +
 hw/s390x/virtio-ccw-net.c     | 1 +
 hw/s390x/virtio-ccw-rng.c     | 1 +
 hw/s390x/virtio-ccw-scsi.c    | 1 +
 hw/s390x/virtio-ccw-serial.c  | 1 +
 14 files changed, 16 insertions(+)

diff --git a/hw/s390x/vhost-scsi-ccw.c b/hw/s390x/vhost-scsi-ccw.c
index 1e68459eb0e..2bd51a80332 100644
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
index 35a77e4cb71..6d341dc5e93 100644
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
index efdfdeec84c..92b6d177e80 100644
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
index d8612f7cd13..08d3ee577b4 100644
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
index 4f67310b693..f7f5640cf12 100644
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
index 939dcaeed38..dd4ac892b20 100644
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
index 2c4ee2ca394..9f274562ac1 100644
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
index 4120c6bcb9f..79c302860f7 100644
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
index a9ec60428ca..532f230617d 100644
--- a/hw/s390x/virtio-ccw-input.c
+++ b/hw/s390x/virtio-ccw-input.c
@@ -110,6 +110,7 @@ static const TypeInfo virtio_ccw_keyboard = {
     .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
     .instance_size = sizeof(VirtIOInputHIDCcw),
     .instance_init = virtio_ccw_keyboard_instance_init,
+    .secure        = true,
 };
 
 static const TypeInfo virtio_ccw_mouse = {
@@ -117,6 +118,7 @@ static const TypeInfo virtio_ccw_mouse = {
     .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
     .instance_size = sizeof(VirtIOInputHIDCcw),
     .instance_init = virtio_ccw_mouse_instance_init,
+    .secure        = true,
 };
 
 static const TypeInfo virtio_ccw_tablet = {
@@ -124,6 +126,7 @@ static const TypeInfo virtio_ccw_tablet = {
     .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
     .instance_size = sizeof(VirtIOInputHIDCcw),
     .instance_init = virtio_ccw_tablet_instance_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_input_register(void)
diff --git a/hw/s390x/virtio-ccw-mem.c b/hw/s390x/virtio-ccw-mem.c
index dea30aacfb3..7014f0f92e6 100644
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
index 30e7055ab2b..d39311a9f01 100644
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
index 0647621e33d..8b62fd99056 100644
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
index c181a2b7692..baac329d75c 100644
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
index 7ff07a08412..9a1686a4dc3 100644
--- a/hw/s390x/virtio-ccw-serial.c
+++ b/hw/s390x/virtio-ccw-serial.c
@@ -76,6 +76,7 @@ static const TypeInfo virtio_ccw_serial = {
     .instance_size = sizeof(VirtioSerialCcw),
     .instance_init = virtio_ccw_serial_instance_init,
     .class_init    = virtio_ccw_serial_class_init,
+    .secure        = true,
 };
 
 static void virtio_ccw_serial_register(void)
-- 
2.56.0


