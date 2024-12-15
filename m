Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1312AE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu1Y-0006IT-At; Sun, 15 Dec 2024 14:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu0C-0004Vo-3B
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:10:04 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu08-0001YY-Py
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:10:03 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eb98b3b63dso850603b6e.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289798; x=1734894598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6CqmURNxHAAtewHFIbzq4SYWA9eT6bkucvqiTjmDsk=;
 b=PzP6b5PQrD9Ev27zDN2T3M9O3uC5xPPmpKGi+d2CnZqrfT1kRsokmpHhiljSMK2+N8
 YVKlcCM+5AtlyUhZh+qNHPxtDCnZCZpzENv1D98tzE3kT00bj0Y58AhU787nYS1WjYcY
 at6LYdctw8FeHNQqEn6hSXQmjsw4DYPMEWysMiNJwVvFrXQIIXrVeUFh3kDyA/LC8grB
 icn06XIue5RRPY6ZfRaj9J02tTjPS568pTVhUJDaCpKHfJn4NSHxPVlOwIoGDJ3Y2nY8
 ufkPaajB2QKJshcSmEROcilAHKDdS1qhrOsauA9juW5LxDllVpaFrkGZuD6Fc1MnglYQ
 2w8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289798; x=1734894598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6CqmURNxHAAtewHFIbzq4SYWA9eT6bkucvqiTjmDsk=;
 b=lVleG0YlxbvS42kchFxxl0xEoBB+yGt6Gwp/G3WzIRSQmEwzETApuWnk+bOulAG/CV
 4ECZv2ErzpAlw7itEtHMacPnxXe13LML7qoR608wyQQY1ChMt8joS5BfiKHhzu7LN72Z
 dO+PPCYmkc9k6JzUgKJc/hZFGD79MRm2akaWtu616RzBbDCFNe9dQJZ6Udabi/L4w80U
 mfHz60/+MP9Z1MQsVXmggkbKF4RgFfu4MBkeDIMS7ALXlOL5R3OTpvu8c5In7G/TYf0e
 7JF3xNfd1FTA2IqRShudgF0VUP7TBo+dj7mPG0mmN+i8Rgjiggt0WmD0ON5LXzxVMAX+
 Rc9w==
X-Gm-Message-State: AOJu0Yy3ZjMY2uf7uYtMQ+Qixv8vPILD6lhqnLROpalvs9ArPwKt57ri
 DDDOSi8W+TDTCW+0idAN+lulgA/0zr+F7clFhArjWJyHfmj/HfJs2P+tZz70nGVqY/vfNSkzlF4
 HYZtx331W
X-Gm-Gg: ASbGncvgA+jsp6L9N7WJzotk3sffVshR+E6AuR5u3w7TQDFxmNQ1y7r+VGoFT7yNIwf
 VglWkRHIai7D+lOD4newNL87aqLoFutnJr+xNQeKP65mkh/x12bCOpzI3LOYB+V8XFneKjehUK5
 KK7uCc+M7U1Ts4IEgMGyjkBhaZLZAP5j0Nt+jTKQy7muX/w4KeWG705y9sKbLszT53M3SBBThWO
 kRcY0TEIb86deLTWj5NUigPLMqJVvA8ZjJrSHUQg52SatWfFyCzhW7o3SAUphSg6k5zd0kifAMW
 aO4n7BRwuz+prdBCdbdy00w5UAUP1FZEzE93bIFX+FE=
X-Google-Smtp-Source: AGHT+IHujuTMWQ/bMWD2TSQzlJY4bMJ4cGDlNa1Wsqgf6jBnqONS52tzB0ti5PhzLJ2BYSeYmNVPQw==
X-Received: by 2002:a05:6830:6c12:b0:71e:5a:f4e6 with SMTP id
 46e09a7af769-71e3ba24b35mr5054271a34.20.1734289798256; 
 Sun, 15 Dec 2024 11:09:58 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 63/67] hw/virtio: Constify all Property
Date: Sun, 15 Dec 2024 13:05:29 -0600
Message-ID: <20241215190533.3222854-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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
 hw/virtio/vdpa-dev.c             | 2 +-
 hw/virtio/vhost-scsi-pci.c       | 2 +-
 hw/virtio/vhost-user-blk-pci.c   | 2 +-
 hw/virtio/vhost-user-device.c    | 2 +-
 hw/virtio/vhost-user-fs-pci.c    | 2 +-
 hw/virtio/vhost-user-fs.c        | 2 +-
 hw/virtio/vhost-user-gpio.c      | 2 +-
 hw/virtio/vhost-user-i2c.c       | 2 +-
 hw/virtio/vhost-user-input.c     | 2 +-
 hw/virtio/vhost-user-rng-pci.c   | 2 +-
 hw/virtio/vhost-user-rng.c       | 2 +-
 hw/virtio/vhost-user-scmi.c      | 2 +-
 hw/virtio/vhost-user-scsi-pci.c  | 2 +-
 hw/virtio/vhost-user-snd.c       | 2 +-
 hw/virtio/vhost-user-vsock-pci.c | 2 +-
 hw/virtio/vhost-user-vsock.c     | 2 +-
 hw/virtio/vhost-vsock-common.c   | 2 +-
 hw/virtio/vhost-vsock-pci.c      | 2 +-
 hw/virtio/vhost-vsock.c          | 2 +-
 hw/virtio/virtio-9p-pci.c        | 2 +-
 hw/virtio/virtio-balloon.c       | 2 +-
 hw/virtio/virtio-blk-pci.c       | 2 +-
 hw/virtio/virtio-crypto-pci.c    | 2 +-
 hw/virtio/virtio-crypto.c        | 2 +-
 hw/virtio/virtio-input-pci.c     | 2 +-
 hw/virtio/virtio-iommu-pci.c     | 2 +-
 hw/virtio/virtio-iommu.c         | 2 +-
 hw/virtio/virtio-mem.c           | 2 +-
 hw/virtio/virtio-mmio.c          | 2 +-
 hw/virtio/virtio-net-pci.c       | 2 +-
 hw/virtio/virtio-nsm.c           | 2 +-
 hw/virtio/virtio-pci.c           | 4 ++--
 hw/virtio/virtio-pmem.c          | 2 +-
 hw/virtio/virtio-rng-pci.c       | 2 +-
 hw/virtio/virtio-rng.c           | 2 +-
 hw/virtio/virtio-scsi-pci.c      | 2 +-
 hw/virtio/virtio-serial-pci.c    | 2 +-
 hw/virtio/virtio.c               | 2 +-
 38 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 64b96b226c..61849b3b0e 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -337,7 +337,7 @@ static void vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
     }
 }
 
-static Property vhost_vdpa_device_properties[] = {
+static const Property vhost_vdpa_device_properties[] = {
     DEFINE_PROP_STRING("vhostdev", VhostVdpaDevice, vhostdev),
     DEFINE_PROP_UINT16("queue-size", VhostVdpaDevice, queue_size, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index 08980bc23b..7536b37f18 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -38,7 +38,7 @@ struct VHostSCSIPCI {
     VHostSCSI vdev;
 };
 
-static Property vhost_scsi_pci_properties[] = {
+static const Property vhost_scsi_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
index eef8641a98..99f1472023 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -43,7 +43,7 @@ struct VHostUserBlkPCI {
     VHostUserBlk vdev;
 };
 
-static Property vhost_user_blk_pci_properties[] = {
+static const Property vhost_user_blk_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index 67aa934710..3222b67bd9 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -29,7 +29,7 @@ static const VMStateDescription vud_vmstate = {
     .unmigratable = 1,
 };
 
-static Property vud_properties[] = {
+static const Property vud_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
     DEFINE_PROP_UINT32("vq_size", VHostUserBase, vq_size, 64),
diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
index 6829b8b743..9ba6c40655 100644
--- a/hw/virtio/vhost-user-fs-pci.c
+++ b/hw/virtio/vhost-user-fs-pci.c
@@ -29,7 +29,7 @@ typedef struct VHostUserFSPCI VHostUserFSPCI;
 DECLARE_INSTANCE_CHECKER(VHostUserFSPCI, VHOST_USER_FS_PCI,
                          TYPE_VHOST_USER_FS_PCI)
 
-static Property vhost_user_fs_pci_properties[] = {
+static const Property vhost_user_fs_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 32ee7f496d..c0462329a5 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -403,7 +403,7 @@ static const VMStateDescription vuf_backend_vmstate = {
     },
 };
 
-static Property vuf_properties[] = {
+static const Property vuf_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserFS, conf.chardev),
     DEFINE_PROP_STRING("tag", VHostUserFS, conf.tag),
     DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index 9f37c25415..c997c66d80 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -14,7 +14,7 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_gpio.h"
 
-static Property vgpio_properties[] = {
+static const Property vgpio_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/virtio/vhost-user-i2c.c b/hw/virtio/vhost-user-i2c.c
index a464f5e039..b0a5cbf3ea 100644
--- a/hw/virtio/vhost-user-i2c.c
+++ b/hw/virtio/vhost-user-i2c.c
@@ -14,7 +14,7 @@
 #include "qemu/error-report.h"
 #include "standard-headers/linux/virtio_ids.h"
 
-static Property vi2c_properties[] = {
+static const Property vi2c_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/virtio/vhost-user-input.c b/hw/virtio/vhost-user-input.c
index bedec0468c..c57cc461bb 100644
--- a/hw/virtio/vhost-user-input.c
+++ b/hw/virtio/vhost-user-input.c
@@ -7,7 +7,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio-input.h"
 
-static Property vinput_properties[] = {
+static const Property vinput_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/virtio/vhost-user-rng-pci.c b/hw/virtio/vhost-user-rng-pci.c
index f64935453b..0016ee74ce 100644
--- a/hw/virtio/vhost-user-rng-pci.c
+++ b/hw/virtio/vhost-user-rng-pci.c
@@ -23,7 +23,7 @@ typedef struct VHostUserRNGPCI VHostUserRNGPCI;
 DECLARE_INSTANCE_CHECKER(VHostUserRNGPCI, VHOST_USER_RNG_PCI,
                          TYPE_VHOST_USER_RNG_PCI)
 
-static Property vhost_user_rng_pci_properties[] = {
+static const Property vhost_user_rng_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index 01879c863d..c9985b5fad 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -20,7 +20,7 @@ static const VMStateDescription vu_rng_vmstate = {
     .unmigratable = 1,
 };
 
-static Property vrng_properties[] = {
+static const Property vrng_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 300847e672..a15e6916ef 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -277,7 +277,7 @@ static const VMStateDescription vu_scmi_vmstate = {
     .unmigratable = 1,
 };
 
-static Property vu_scmi_properties[] = {
+static const Property vu_scmi_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserSCMI, chardev),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index 75882e3cf9..b2f6451f48 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -44,7 +44,7 @@ struct VHostUserSCSIPCI {
     VHostUserSCSI vdev;
 };
 
-static Property vhost_user_scsi_pci_properties[] = {
+static const Property vhost_user_scsi_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 9a217543f8..8810a9f699 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -21,7 +21,7 @@ static const VMStateDescription vu_snd_vmstate = {
     .unmigratable = 1,
 };
 
-static Property vsnd_properties[] = {
+static const Property vsnd_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
index e5a86e8013..529d967059 100644
--- a/hw/virtio/vhost-user-vsock-pci.c
+++ b/hw/virtio/vhost-user-vsock-pci.c
@@ -31,7 +31,7 @@ struct VHostUserVSockPCI {
 
 /* vhost-user-vsock-pci */
 
-static Property vhost_user_vsock_pci_properties[] = {
+static const Property vhost_user_vsock_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index da3b0e0229..97885bfeab 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -148,7 +148,7 @@ static void vuv_device_unrealize(DeviceState *dev)
 
 }
 
-static Property vuv_properties[] = {
+static const Property vuv_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserVSock, conf.chardev),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index fd88df2560..cb2253c39f 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -285,7 +285,7 @@ static struct vhost_dev *vhost_vsock_common_get_vhost(VirtIODevice *vdev)
     return &vvc->vhost_dev;
 }
 
-static Property vhost_vsock_common_properties[] = {
+static const Property vhost_vsock_common_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("seqpacket", VHostVSockCommon, seqpacket,
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
index 9f34414d38..1d9abd02bd 100644
--- a/hw/virtio/vhost-vsock-pci.c
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -35,7 +35,7 @@ struct VHostVSockPCI {
 
 /* vhost-vsock-pci */
 
-static Property vhost_vsock_pci_properties[] = {
+static const Property vhost_vsock_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3d4a5a97f4..ce80e84494 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -205,7 +205,7 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     vhost_vsock_common_unrealize(vdev);
 }
 
-static Property vhost_vsock_properties[] = {
+static const Property vhost_vsock_properties[] = {
     DEFINE_PROP_UINT64("guest-cid", VHostVSock, conf.guest_cid, 0),
     DEFINE_PROP_STRING("vhostfd", VHostVSock, conf.vhostfd),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/virtio/virtio-9p-pci.c b/hw/virtio/virtio-9p-pci.c
index 94c14f0b98..b33faf2fbb 100644
--- a/hw/virtio/virtio-9p-pci.c
+++ b/hw/virtio/virtio-9p-pci.c
@@ -43,7 +43,7 @@ static void virtio_9p_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static Property virtio_9p_pci_properties[] = {
+static const Property virtio_9p_pci_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index afd2ad6dd6..ab2ee30475 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -1015,7 +1015,7 @@ static const VMStateDescription vmstate_virtio_balloon = {
     },
 };
 
-static Property virtio_balloon_properties[] = {
+static const Property virtio_balloon_properties[] = {
     DEFINE_PROP_BIT("deflate-on-oom", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index 9743bee965..abdcc11b2e 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -38,7 +38,7 @@ struct VirtIOBlkPCI {
     VirtIOBlock vdev;
 };
 
-static Property virtio_blk_pci_properties[] = {
+static const Property virtio_blk_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 0783dc2f7e..23c85fe586 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -37,7 +37,7 @@ struct VirtIOCryptoPCI {
     VirtIOCrypto vdev;
 };
 
-static Property virtio_crypto_pci_properties[] = {
+static const Property virtio_crypto_pci_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index c3ffd8328d..9ae0b02598 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1128,7 +1128,7 @@ static const VMStateDescription vmstate_virtio_crypto = {
     },
 };
 
-static Property virtio_crypto_properties[] = {
+static const Property virtio_crypto_properties[] = {
     DEFINE_PROP_LINK("cryptodev", VirtIOCrypto, conf.cryptodev,
                      TYPE_CRYPTODEV_BACKEND, CryptoDevBackend *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index a53edf46c4..55c0b0555b 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -37,7 +37,7 @@ struct VirtIOInputHIDPCI {
     VirtIOInputHID vdev;
 };
 
-static Property virtio_input_pci_properties[] = {
+static const Property virtio_input_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index cbdfe4c591..92adf63684 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -34,7 +34,7 @@ struct VirtIOIOMMUPCI {
     VirtIOIOMMU vdev;
 };
 
-static Property virtio_iommu_pci_properties[] = {
+static const Property virtio_iommu_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
                       vdev.nr_prop_resv_regions, vdev.prop_resv_regions,
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 59ef4fb217..576ad8383f 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1655,7 +1655,7 @@ static const VMStateDescription vmstate_virtio_iommu = {
     },
 };
 
-static Property virtio_iommu_properties[] = {
+static const Property virtio_iommu_properties[] = {
     DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 80ada89551..3f6f46fad7 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1680,7 +1680,7 @@ static void virtio_mem_instance_finalize(Object *obj)
     vmem->mr = NULL;
 }
 
-static Property virtio_mem_properties[] = {
+static const Property virtio_mem_properties[] = {
     DEFINE_PROP_UINT64(VIRTIO_MEM_ADDR_PROP, VirtIOMEM, addr, 0),
     DEFINE_PROP_UINT32(VIRTIO_MEM_NODE_PROP, VirtIOMEM, node, 0),
     DEFINE_PROP_BOOL(VIRTIO_MEM_PREALLOC_PROP, VirtIOMEM, prealloc, false),
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index e3366fe54c..49d9fe8f30 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -751,7 +751,7 @@ static void virtio_mmio_pre_plugged(DeviceState *d, Error **errp)
 
 /* virtio-mmio device */
 
-static Property virtio_mmio_properties[] = {
+static const Property virtio_mmio_properties[] = {
     DEFINE_PROP_BOOL("format_transport_address", VirtIOMMIOProxy,
                      format_transport_address, true),
     DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index e03543a70a..e86094ae22 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -38,7 +38,7 @@ struct VirtIONetPCI {
     VirtIONet vdev;
 };
 
-static Property virtio_net_properties[] = {
+static const Property virtio_net_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
index 6830fcfe17..685c548361 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -1705,7 +1705,7 @@ static const VMStateDescription vmstate_virtio_nsm = {
     },
 };
 
-static Property virtio_nsm_properties[] = {
+static const Property virtio_nsm_properties[] = {
     DEFINE_PROP_STRING("module-id", VirtIONSM, module_id),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5c6c2019ce..de41cb5ef2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2349,7 +2349,7 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
     }
 }
 
-static Property virtio_pci_properties[] = {
+static const Property virtio_pci_properties[] = {
     DEFINE_PROP_BIT("virtio-pci-bus-master-bug-migration", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
     DEFINE_PROP_BIT("migrate-extra", VirtIOPCIProxy, flags,
@@ -2431,7 +2431,7 @@ static const TypeInfo virtio_pci_info = {
     .abstract      = true,
 };
 
-static Property virtio_pci_generic_properties[] = {
+static const Property virtio_pci_generic_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("disable-legacy", VirtIOPCIProxy, disable_legacy,
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("disable-modern", VirtIOPCIProxy, disable_modern, false),
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index c3512c2dae..f6f3b5ddaf 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -155,7 +155,7 @@ static MemoryRegion *virtio_pmem_get_memory_region(VirtIOPMEM *pmem,
     return &pmem->memdev->mr;
 }
 
-static Property virtio_pmem_properties[] = {
+static const Property virtio_pmem_properties[] = {
     DEFINE_PROP_UINT64(VIRTIO_PMEM_ADDR_PROP, VirtIOPMEM, start, 0),
     DEFINE_PROP_LINK(VIRTIO_PMEM_MEMDEV_PROP, VirtIOPMEM, memdev,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
index 6e76f8b57b..398f432237 100644
--- a/hw/virtio/virtio-rng-pci.c
+++ b/hw/virtio/virtio-rng-pci.c
@@ -32,7 +32,7 @@ struct VirtIORngPCI {
     VirtIORNG vdev;
 };
 
-static Property virtio_rng_properties[] = {
+static const Property virtio_rng_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 7cf31da071..13a1a0b236 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -249,7 +249,7 @@ static const VMStateDescription vmstate_virtio_rng = {
     },
 };
 
-static Property virtio_rng_properties[] = {
+static const Property virtio_rng_properties[] = {
     /* Set a default rate limit of 2^47 bytes per minute or roughly 2TB/s.  If
      * you have an entropy source capable of generating more entropy than this
      * and you can pass it through via virtio-rng, then hats off to you.  Until
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index e8e3442f38..733b5756db 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -35,7 +35,7 @@ struct VirtIOSCSIPCI {
     VirtIOSCSI vdev;
 };
 
-static Property virtio_scsi_pci_properties[] = {
+static const Property virtio_scsi_pci_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
diff --git a/hw/virtio/virtio-serial-pci.c b/hw/virtio/virtio-serial-pci.c
index cea31adcc4..bda643ec54 100644
--- a/hw/virtio/virtio-serial-pci.c
+++ b/hw/virtio/virtio-serial-pci.c
@@ -69,7 +69,7 @@ static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-static Property virtio_serial_pci_properties[] = {
+static const Property virtio_serial_pci_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f12c4aa81e..7fcdb55ba4 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4012,7 +4012,7 @@ static void virtio_device_instance_finalize(Object *obj)
     g_free(vdev->vector_queues);
 }
 
-static Property virtio_properties[] = {
+static const Property virtio_properties[] = {
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
     DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
     DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
-- 
2.43.0


