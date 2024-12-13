Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA00E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB9I-0001m2-FG; Fri, 13 Dec 2024 14:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7I-0007G8-Ux
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:25 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7G-0007b2-Hi
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:24 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3eba5848ee4so361576b6e.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117261; x=1734722061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KW4uvX6kcpOG+0vWrOl72mSjdGCdTxn0mYV6Vb8Zew=;
 b=x3IPk8Kk3h8vSS4PoJz3IS4Uqh/aFr7SzpQc6N7VYJIWh5+NQNWH2Xl+4+Z+mDw5YA
 hU0WMZpEzRX3rBfvvDw92dJx/7yfK8WAjLqJT7g0gWS65Dz2q0S3VmvID6vuDNRqxbFz
 KB84KokZXCEFCpWD114LEmHGbpNOZTdgIP9lHIIuPDG/BQJt+7Y14YHAjGQbqwRrTm10
 0Gy/SIlweehVhmuOAG3TYa8E+bSqNlQEcbK7IIcn+NsulBUrNCR2xXu1+fZmcPKLqmno
 XdJjUGdteZtdlKeeYgY9xz7IgFh9FNmDPiKV6QCHWcXFBC9MAzoRCNL5whEUCfD0aGu4
 CbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117261; x=1734722061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4KW4uvX6kcpOG+0vWrOl72mSjdGCdTxn0mYV6Vb8Zew=;
 b=TxK9HRJPzb4z2vwiXbZFTjjRmF8let91se7cX139TDgXQkDwW+Q5QUvep2UjUBZK3y
 MIxhjguD8NIvIuV3EujgwSyV8eb516N0q3rj098mfbEZwWxmFjiM6X3zX9RmZ6lwdtRM
 BKIygPO6JvA26A30p6aXi/qj34lzdLeP0lfpHNwtWqNtSSXSA6ww0CUFdHs0TC4im++6
 LXfMln0xsYeg96yUs/+GOPOwDQr5g/p5wC0gcinMuYtFYVHOsb7Z+UkbJa9HFRqdLOml
 Ok/YbYI7jVb1ZmxNbfFVjQICBYP/N+OhZVUq1cNTUJbTEbnjbLtLh15J9/pfeTruwoF7
 iXrA==
X-Gm-Message-State: AOJu0YzDNn6CEXNqiZq20BGdm7LRKWiCWxb4oEWL2wHHucBh2WwPUi+P
 2zlAtgQOc2qvLgKJqZbkOAsKNwYzHpa3SbP2kbg8zzT2eJDT+Ws2ul044fqjzKiWR3b8mCueBCx
 soNCjJUaK
X-Gm-Gg: ASbGncsWXMh+mibFE57KKlNi6gpsbPTuRW4cdXjYR+BXNz2gTrdq93ZQg5VzHRHShSa
 yiVCNHwbGRLwk/dtiivWwxX8QUXFGT/SIt/QlWZ6FR+73Ac3XWbt6feMQh62D7w/ZIHQiH4rdqV
 ntn/hbBm1m6aJVQ6aNUrMxXJaCeNpSMn4g76cB46F9k51dOvaNbFJiqBzjyQzzG9uA4gvjpnJFp
 HDGS9T4JcgIoLvFqqDE/Iq7YSuoUblkj4wxNr2hqQ7EIpEx/G0x91x5kSsDow3N
X-Google-Smtp-Source: AGHT+IGCIOfGpB/iF/deXHBGaEbXRJ5JTMEFdSRzqxoHGrhegchaBfH6TvuMWEC8/k/jFTHmx2rElQ==
X-Received: by 2002:a05:6808:2022:b0:3eb:8442:9fb2 with SMTP id
 5614622812f47-3eba693a9c3mr2211714b6e.29.1734117261204; 
 Fri, 13 Dec 2024 11:14:21 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 3270 device)
Subject: [PATCH 54/71] hw/s390x: Constify all Property
Date: Fri, 13 Dec 2024 13:07:28 -0600
Message-ID: <20241213190750.2513964-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/s390x/3270-ccw.c           | 2 +-
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
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 69e6783ade..f48a14ca2c 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -150,7 +150,7 @@ out_err:
     g_free(sch);
 }
 
-static Property emulated_ccw_3270_properties[] = {
+static const Property emulated_ccw_3270_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
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


