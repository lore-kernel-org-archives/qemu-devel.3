Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF3EE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu0r-0005eR-Iu; Sun, 15 Dec 2024 14:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzx-0002fC-UT
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:50 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzv-0001WR-L1
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:49 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71e36b27b53so1648874a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289786; x=1734894586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fpW3iItI5HTlmDdHlgpSevm4IQsWBBU1taxzUX01uoE=;
 b=Ox3KuHaeWIZswX28alohQ99FuOqPlBwChZB4+XNadBlX3Qj7pUIgbNE+/FOzhFe+CI
 VvC0gKMIdoxQaIvLQjfBQFWBQgWZP4b5u2QpAQ9hnLcxL+7+QGnBrkGZhMKgieiOW4Mo
 KbU+pSVQUFlZDY7OyqVw4BDqDXxaGaGd4sqV8oiOlFiseM6+p4CduaJ+p9D+8m/PCax2
 iqouQ7m+6JmRFp38aI77Bn6jE3trmqImxonCCrfESodax24RltQ/8/3rkZMixAfldadk
 rY6gC/gJf28VIpD4w0Ly7Ytxdpqz/T31/4XpLD0WTADWWlOLvafyT6qYAz/oQMmOv1pY
 OtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289786; x=1734894586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fpW3iItI5HTlmDdHlgpSevm4IQsWBBU1taxzUX01uoE=;
 b=DRU4uu9OzhDD8Heq5TnfVe/mLidVVAutfFDy6VORb3LnfosHJxmTv7wP9AxFFzyRM1
 nCN+XNjKvJFEWGYY1YX1c0CKYs5bzMjHm7JcVuGJSzn5HhwXvWzh0CVvfbBIayBbc+N9
 QSKuIdaz/rZ8aS2m59YqVzAt50kptrANWZebl1FAOLM1RRBCpTHH7Erb1yJAnxMWMyv3
 iiMYKzoOrxLYcqP9PHxkJLaDQim5CUur0vkLSZ8EXmIP0P0mTUho08uFFvFV+ROkw7lN
 ZzTiAISSuBdQB39Mx2d5o5YTgZUitJ94BCgX2d+OfmhvNJZGlPs9JMIwfYvvRAT2wcY7
 St0A==
X-Gm-Message-State: AOJu0YzdiMy/i+RzvLH5jNy+MLr6eNLYtOOayI+VFJDhYfXe5+EwY7Vc
 HnTG3oZ4Ku8E42N+Jb/S0tVHM7f9xkerJ1n1bdHkX2Q78FPZW9ZNNP+oLvtlf+ooMtGkEz/WmgM
 yEo5wakcf
X-Gm-Gg: ASbGnctTLFS4Un3p0P1x2p2xfcHQ8T08VScZ/7m5HoEIlAPg+qg8McruG6ffaB8S42C
 eX1C6izq5BXV5lDj/UKGUI1wAsD0Fl4SdK+8OeBZ6OPlPsWYWZY2HRgFK5NIFyHXv5hSgnKUE/7
 0duUAOjQjKYJOVNCb//SEqPAbSq2p3GTavXFUIu4sXQf0NrYJrMeCH/RBKKB8cZu59wEK8tGfty
 gnrdityCUOpNNuyJbOkCFiZJROMQ3sP9vHwKXBwUnaZXC4r63jIjUhGKWPGlfxi3WDnPZEM5FCC
 XMw0rh/YYGI69pbilDBkdrmYWoCIVlKeHpqwVZy2gIk=
X-Google-Smtp-Source: AGHT+IF8004rBmPHmzGVdz8JKdp4FzTV67AUsz+2AqsfcVSUPZPyzdMn5p56zeJcIvjjsJqNtO9h0A==
X-Received: by 2002:a05:6830:4885:b0:71d:4264:cce2 with SMTP id
 46e09a7af769-71e3b857851mr5787035a34.9.1734289786308; 
 Sun, 15 Dec 2024 11:09:46 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 52/67] hw/s390x: Constify all Property
Date: Sun, 15 Dec 2024 13:05:18 -0600
Message-ID: <20241215190533.3222854-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/s390x/ccw-device.c         | 2 +-
 hw/s390x/css-bridge.c         | 2 +-
 hw/s390x/ipl.c                | 2 +-
 hw/s390x/s390-pci-bus.c       | 2 +-
 hw/s390x/s390-skeys.c         | 2 +-
 hw/s390x/s390-stattrib.c      | 2 +-
 hw/s390x/vhost-scsi-ccw.c     | 2 +-
 hw/s390x/vhost-user-fs-ccw.c  | 2 +-
 hw/s390x/vhost-vsock-ccw.c    | 2 +-
 hw/s390x/virtio-ccw-9p.c      | 2 +-
 hw/s390x/virtio-ccw-balloon.c | 2 +-
 hw/s390x/virtio-ccw-blk.c     | 2 +-
 hw/s390x/virtio-ccw-crypto.c  | 2 +-
 hw/s390x/virtio-ccw-gpu.c     | 2 +-
 hw/s390x/virtio-ccw-input.c   | 2 +-
 hw/s390x/virtio-ccw-net.c     | 2 +-
 hw/s390x/virtio-ccw-rng.c     | 2 +-
 hw/s390x/virtio-ccw-scsi.c    | 2 +-
 hw/s390x/virtio-ccw-serial.c  | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 30f2fb486f..0d10c3ed55 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -81,7 +81,7 @@ const PropertyInfo ccw_loadparm = {
     .set = ccw_device_set_loadparm,
 };
 
-static Property ccw_device_properties[] = {
+static const Property ccw_device_properties[] = {
     DEFINE_PROP_CSS_DEV_ID("devno", CcwDevice, devno),
     DEFINE_PROP_CSS_DEV_ID_RO("dev_id", CcwDevice, dev_id),
     DEFINE_PROP_CSS_DEV_ID_RO("subch_id", CcwDevice, subch_id),
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 8657ff7bf4..860a04a7da 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -120,7 +120,7 @@ VirtualCssBus *virtual_css_bus_init(void)
 
 /***************** Virtual-css Bus Bridge Device ********************/
 
-static Property virtual_css_bridge_properties[] = {
+static const Property virtual_css_bridge_properties[] = {
     DEFINE_PROP_BOOL("css_dev_path", VirtualCssBridge, css_dev_path,
                      true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 30734661ad..88a97f0085 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -291,7 +291,7 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
     qemu_register_reset(resettable_cold_reset_fn, dev);
 }
 
-static Property s390_ipl_properties[] = {
+static const Property s390_ipl_properties[] = {
     DEFINE_PROP_STRING("kernel", S390IPLState, kernel),
     DEFINE_PROP_STRING("initrd", S390IPLState, initrd),
     DEFINE_PROP_STRING("cmdline", S390IPLState, cmdline),
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 40b2567aa7..22e6be67af 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1481,7 +1481,7 @@ static const PropertyInfo s390_pci_fid_propinfo = {
 #define DEFINE_PROP_S390_PCI_FID(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, s390_pci_fid_propinfo, uint32_t)
 
-static Property s390_pci_device_properties[] = {
+static const Property s390_pci_device_properties[] = {
     DEFINE_PROP_UINT16("uid", S390PCIBusDevice, uid, UID_UNDEFINED),
     DEFINE_PROP_S390_PCI_FID("fid", S390PCIBusDevice, fid),
     DEFINE_PROP_STRING("target", S390PCIBusDevice, target),
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index bf22d6863e..6d0a47ed73 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -475,7 +475,7 @@ static void s390_skeys_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property s390_skeys_props[] = {
+static const Property s390_skeys_props[] = {
     DEFINE_PROP_BOOL("migration-enabled", S390SKeysState, migration_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c4259b5327..6c69c01e1f 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -360,7 +360,7 @@ static void s390_stattrib_realize(DeviceState *dev, Error **errp)
                          &savevm_s390_stattrib_handlers, dev);
 }
 
-static Property s390_stattrib_props[] = {
+static const Property s390_stattrib_props[] = {
     DEFINE_PROP_BOOL("migration-enabled", S390StAttribState, migration_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/s390x/vhost-scsi-ccw.c b/hw/s390x/vhost-scsi-ccw.c
index 40dc14bbc7..0be0f8a82c 100644
--- a/hw/s390x/vhost-scsi-ccw.c
+++ b/hw/s390x/vhost-scsi-ccw.c
@@ -41,7 +41,7 @@ static void vhost_ccw_scsi_instance_init(Object *obj)
                                 TYPE_VHOST_SCSI);
 }
 
-static Property vhost_ccw_scsi_properties[] = {
+static const Property vhost_ccw_scsi_properties[] = {
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/s390x/vhost-user-fs-ccw.c b/hw/s390x/vhost-user-fs-ccw.c
index 6c6f269293..934378aaec 100644
--- a/hw/s390x/vhost-user-fs-ccw.c
+++ b/hw/s390x/vhost-user-fs-ccw.c
@@ -23,7 +23,7 @@ typedef struct VHostUserFSCcw {
         OBJECT_CHECK(VHostUserFSCcw, (obj), TYPE_VHOST_USER_FS_CCW)
 
 
-static Property vhost_user_fs_ccw_properties[] = {
+static const Property vhost_user_fs_ccw_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
index 07845a9a00..3ba4008b4b 100644
--- a/hw/s390x/vhost-vsock-ccw.c
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -22,7 +22,7 @@ struct VHostVSockCCWState {
     VHostVSock vdev;
 };
 
-static Property vhost_vsock_ccw_properties[] = {
+static const Property vhost_vsock_ccw_properties[] = {
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/s390x/virtio-ccw-9p.c b/hw/s390x/virtio-ccw-9p.c
index 6f931f5994..c10b084d40 100644
--- a/hw/s390x/virtio-ccw-9p.c
+++ b/hw/s390x/virtio-ccw-9p.c
@@ -41,7 +41,7 @@ static void virtio_ccw_9p_instance_init(Object *obj)
                                 TYPE_VIRTIO_9P);
 }
 
-static Property virtio_ccw_9p_properties[] = {
+static const Property virtio_ccw_9p_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
             VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
diff --git a/hw/s390x/virtio-ccw-balloon.c b/hw/s390x/virtio-ccw-balloon.c
index 44287b9bbe..bbbed494b3 100644
--- a/hw/s390x/virtio-ccw-balloon.c
+++ b/hw/s390x/virtio-ccw-balloon.c
@@ -46,7 +46,7 @@ static void virtio_ccw_balloon_instance_init(Object *obj)
                               "guest-stats-polling-interval");
 }
 
-static Property virtio_ccw_balloon_properties[] = {
+static const Property virtio_ccw_balloon_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
index 2364432c6e..3182851234 100644
--- a/hw/s390x/virtio-ccw-blk.c
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -43,7 +43,7 @@ static void virtio_ccw_blk_instance_init(Object *obj)
                               "bootindex");
 }
 
-static Property virtio_ccw_blk_properties[] = {
+static const Property virtio_ccw_blk_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index 0fa2f89443..b4cd7605c9 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -44,7 +44,7 @@ static void virtio_ccw_crypto_instance_init(Object *obj)
                                 TYPE_VIRTIO_CRYPTO);
 }
 
-static Property virtio_ccw_crypto_properties[] = {
+static const Property virtio_ccw_crypto_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
diff --git a/hw/s390x/virtio-ccw-gpu.c b/hw/s390x/virtio-ccw-gpu.c
index 0642c5281d..c44dc2d355 100644
--- a/hw/s390x/virtio-ccw-gpu.c
+++ b/hw/s390x/virtio-ccw-gpu.c
@@ -42,7 +42,7 @@ static void virtio_ccw_gpu_instance_init(Object *obj)
                                 TYPE_VIRTIO_GPU);
 }
 
-static Property virtio_ccw_gpu_properties[] = {
+static const Property virtio_ccw_gpu_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
diff --git a/hw/s390x/virtio-ccw-input.c b/hw/s390x/virtio-ccw-input.c
index 61a07ba38d..040a9e04a9 100644
--- a/hw/s390x/virtio-ccw-input.c
+++ b/hw/s390x/virtio-ccw-input.c
@@ -43,7 +43,7 @@ static void virtio_ccw_input_realize(VirtioCcwDevice *ccw_dev, Error **errp)
     qdev_realize(vdev, BUS(&ccw_dev->bus), errp);
 }
 
-static Property virtio_ccw_input_properties[] = {
+static const Property virtio_ccw_input_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
index a4a3f65c7e..c41d347034 100644
--- a/hw/s390x/virtio-ccw-net.c
+++ b/hw/s390x/virtio-ccw-net.c
@@ -46,7 +46,7 @@ static void virtio_ccw_net_instance_init(Object *obj)
                               "bootindex");
 }
 
-static Property virtio_ccw_net_properties[] = {
+static const Property virtio_ccw_net_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index a3fffb5138..c9a15c4eb6 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -43,7 +43,7 @@ static void virtio_ccw_rng_instance_init(Object *obj)
                                 TYPE_VIRTIO_RNG);
 }
 
-static Property virtio_ccw_rng_properties[] = {
+static const Property virtio_ccw_rng_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
diff --git a/hw/s390x/virtio-ccw-scsi.c b/hw/s390x/virtio-ccw-scsi.c
index d003f89f43..bec9a73518 100644
--- a/hw/s390x/virtio-ccw-scsi.c
+++ b/hw/s390x/virtio-ccw-scsi.c
@@ -53,7 +53,7 @@ static void virtio_ccw_scsi_instance_init(Object *obj)
                                 TYPE_VIRTIO_SCSI);
 }
 
-static Property virtio_ccw_scsi_properties[] = {
+static const Property virtio_ccw_scsi_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
diff --git a/hw/s390x/virtio-ccw-serial.c b/hw/s390x/virtio-ccw-serial.c
index 8f8d2302f8..037d4f9db1 100644
--- a/hw/s390x/virtio-ccw-serial.c
+++ b/hw/s390x/virtio-ccw-serial.c
@@ -53,7 +53,7 @@ static void virtio_ccw_serial_instance_init(Object *obj)
                                 TYPE_VIRTIO_SERIAL);
 }
 
-static Property virtio_ccw_serial_properties[] = {
+static const Property virtio_ccw_serial_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
-- 
2.43.0


