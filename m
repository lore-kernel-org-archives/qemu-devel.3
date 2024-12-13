Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A2EE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBNI-0006sr-Pd; Fri, 13 Dec 2024 14:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBN4-0006hl-6K
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:45 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBMw-0004G1-IU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:39 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ffa49f623cso23679831fa.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734118232; x=1734723032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NulB13XWjt/WlDjxXREVViEirAoAtzzDMPxFRCnz5s=;
 b=tDDcfHHzUq5ntD8rXjy6uWqpZVSQUHhKg0P2sPBBBrOgIdep/9JPk5QP/cpkLBlCSI
 //lQjgOOJVOn63ZJOoTBh8nAjC3hLO7P5m6blBJb9f1zf1Jj2FnzsS7D1xui6l6pcW6s
 vqXfYeseJbbBlvpXfZc+uwRqNAEvusIMVNwLcI/Dd2ZpDY/kLVKF4LxYDzA5qYmB8jTU
 ldHBg26pQAAzvoSP2Cipc/LfBgfDy6M0f3oqi20babYhW8ObYCDmymHVfQt8t8HsPk3u
 v52Qn2UjXe7nYP31fDcBevjmfAybGwzzk/ty7kfUwcF5J0lcDjOMumb6L9CWIrk5SoDg
 hSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118232; x=1734723032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NulB13XWjt/WlDjxXREVViEirAoAtzzDMPxFRCnz5s=;
 b=D2sUpSeoqcHuLoNFg5IemnXpJO9o2JgZR0kidYAbr30SxoZr1xENTIp0vkEaZWQmH1
 ub+B+WM+KCXKZOD/WlRsAucti1Z6XnrgENZvxn/Z00hYLqmtL/ou6mBIeanDaZCqbrvG
 NN1TMOZPZfiLjSvDDXsK8ot+wCWPPllc97yruiAIAhv7J8eKbuOHJpTXcDbnDqQ+WqA4
 uDfnRCGHjAHwKd+nrth1r4qr2G3XWIcw0QVQ3tEHRy/+ZJYGnHUt1FDuE77EnM/Ua+PP
 nBZVUPa2JUU67/YT4w4P5+rTMxJoBZKTfhSg3Qy+Di902iqkHMQg03iE6Y29VQc4IXcY
 XSXg==
X-Gm-Message-State: AOJu0YxIkr+WeZ0Obie/hqBNohsJSVETwsvej2P2dNLJNZwCUvRDxqZ4
 93vrZ4CzZWupcHR2TqChWRnDRkXZRkXQrP5BEhJ4RYohPwUGlAC3a3PfKfJ92rsR4E/H+H0JUwN
 XjESoTw1E
X-Gm-Gg: ASbGnct2lsDYzYRbkCPrGi/bKDl5+V8rhY+jEY9q7iXAoGqfYcByGTmeaEhy0zZLW7U
 JkWLkENn7SzHGPUICLTxscVnTHGLz3PzEbkl+7ZECch1FZVT+liJMatfI9QytV5IQ6+tNqWokPq
 Kpq1EIEhqxElvHYGa/mcYrtTVIvO1LkPGQE99EhRDZeGesnMK+1UjldtEdq1cOZ66CszPE868Ta
 gMhG1NbCHfdv61RFpZwsZdPcpHCWp1pkHLimnDgpCBMIDeG6uBiGWEYr+EkMQ==
X-Google-Smtp-Source: AGHT+IGDB7QyFSQEXLvPA+kQz8xMBE8pu7+0bruT87ZLMJ3m/DdoiwuDeXZclipgmtWmH25SpKGl4g==
X-Received: by 2002:a05:6512:a8c:b0:53e:391c:e96c with SMTP id
 2adb3069b0e04-5408ad80ba1mr1205721e87.8.1734118232425; 
 Fri, 13 Dec 2024 11:30:32 -0800 (PST)
Received: from stoup.. ([91.209.212.67]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c01051sm6972e87.156.2024.12.13.11.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:30:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 mzamazal@redhat.com (reviewer:vhost-user-scmi),
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Alexander Graf <graf@amazon.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 virtio-fs@lists.linux.dev (open list:virtiofs)
Subject: [PATCH 66/71] hw/virtio: Constify all Property
Date: Fri, 13 Dec 2024 13:30:00 -0600
Message-ID: <20241213193004.2515684-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213193004.2515684-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213193004.2515684-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/virtio/vdpa-dev-pci.c         | 2 +-
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
 hw/virtio/vhost-user-snd-pci.c   | 2 +-
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
 40 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/hw/virtio/vdpa-dev-pci.c b/hw/virtio/vdpa-dev-pci.c
index 5446e6b393..d0ee240e9d 100644
--- a/hw/virtio/vdpa-dev-pci.c
+++ b/hw/virtio/vdpa-dev-pci.c
@@ -48,7 +48,7 @@ static void vhost_vdpa_device_pci_instance_init(Object *obj)
                               "bootindex");
 }
 
-static Property vhost_vdpa_device_pci_properties[] = {
+static const Property vhost_vdpa_device_pci_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
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
diff --git a/hw/virtio/vhost-user-snd-pci.c b/hw/virtio/vhost-user-snd-pci.c
index d61cfdae63..5cf3557b7e 100644
--- a/hw/virtio/vhost-user-snd-pci.c
+++ b/hw/virtio/vhost-user-snd-pci.c
@@ -23,7 +23,7 @@ typedef struct VHostUserSoundPCI VHostUserSoundPCI;
 DECLARE_INSTANCE_CHECKER(VHostUserSoundPCI, VHOST_USER_SND_PCI,
                          TYPE_VHOST_USER_SND_PCI)
 
-static Property vhost_user_snd_pci_properties[] = {
+static const Property vhost_user_snd_pci_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
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
index a3db8eef3e..7b85a3f4f7 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -1698,7 +1698,7 @@ static const VMStateDescription vmstate_virtio_nsm = {
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


