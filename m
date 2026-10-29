Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDEA606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XgEUo25U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPxA-00009a-Er; Thu, 29 Oct 2026 09:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwL-0007oO-SF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwE-00067Z-Sv
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bwmAHrROp/STFTEzxYXHgHCUy/mmWmTKEj5UseF7WTI=;
 b=XgEUo25UpQsWS/S+WEj4gHp2PFyhFN3FCjlDr7Bo9PDkD11Slfx7tR610WegqcAeZU4BF2
 Djyhj89+H2/ddBBNy7zZKKCSEoXy51UAjXQYL7+Qf7xD8BcYO0FEF9zlAtQmYw7DFRP/fs
 5VSwIqOPA54RGoDxcc69+aQ5zkYfN10=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-TJC7hRoZOj6NrumuJAAz0w-1; Thu,
 29 Oct 2026 09:12:56 -0400
X-MC-Unique: TJC7hRoZOj6NrumuJAAz0w-1
X-Mimecast-MFC-AGG-ID: TJC7hRoZOj6NrumuJAAz0w_1793279574
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9959195399A; Thu, 29 Oct 2026 13:12:54 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58D2E3000B7A; Thu, 29 Oct 2026 13:12:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 03/28] hw: mark all vhost devices a secure
Date: Thu, 29 Oct 2026 13:12:16 +0000
Message-ID: <20261029131241.2275706-4-berrange@redhat.com>
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

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/block/vhost-user-blk.c          | 1 +
 hw/display/vhost-user-gpu.c        | 1 +
 hw/scsi/vhost-scsi.c               | 1 +
 hw/scsi/vhost-user-scsi.c          | 1 +
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
 hw/virtio/vhost-vsock.c            | 1 +
 16 files changed, 16 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 1352a0cf578..d1d10427201 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -697,6 +697,7 @@ static const TypeInfo vhost_user_blk_info = {
     .instance_size = sizeof(VHostUserBlk),
     .instance_init = vhost_user_blk_instance_init,
     .class_init = vhost_user_blk_class_init,
+    .secure = true,
 };
 
 static void vhost_user_blk_set_inflight_migration(Object *obj, Visitor *v,
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index c09aca04113..32e7d9638f6 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -726,6 +726,7 @@ static const TypeInfo vhost_user_gpu_info = {
     .instance_init = vhost_user_gpu_instance_init,
     .instance_finalize = vhost_user_gpu_instance_finalize,
     .class_init = vhost_user_gpu_class_init,
+    .secure = true,
 };
 module_obj(TYPE_VHOST_USER_GPU);
 module_kconfig(VHOST_USER_GPU);
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 657403cad01..e1f209fabb3 100644
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
index 7687f2804f8..4374a54962b 100644
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
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 0d8842817a1..3a97038ee7b 100644
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
index d473f870778..cec21106e0b 100644
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
index 152b1f67401..17b0b444139 100644
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
index 5cfc5bbb564..a850e3770e0 100644
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
index 106c8f211aa..dc1286559cf 100644
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
index 88b0c70b903..2cb949590ec 100644
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
index 29d37716b3c..ad5c176c1e2 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -311,6 +311,7 @@ static const TypeInfo vu_scmi_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VHostUserSCMI),
     .class_init = vu_scmi_class_init,
+    .secure = true,
 };
 
 static void vu_scmi_register_types(void)
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 7129b77d9c0..3695534aa2c 100644
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
index 707f96c2505..58d5fd7b469 100644
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
index a2f963fdf60..73da8af48a8 100644
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
index c2cd376e732..e10ceb95cb2 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -175,6 +175,7 @@ static const TypeInfo vuv_info = {
     .parent = TYPE_VHOST_VSOCK_COMMON,
     .instance_size = sizeof(VHostUserVSock),
     .class_init = vuv_class_init,
+    .secure = true,
 };
 
 static void vuv_register_types(void)
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb1657..66a17ee15ff 100644
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
2.56.0


