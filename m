Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCC4E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu07-0003jm-1h; Sun, 15 Dec 2024 14:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzy-0002iz-9W
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:50 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzw-0001Wb-Ag
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:50 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71e1b1767b3so1815971a34.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289787; x=1734894587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TE3i9BvNsJ8uvWEOc4m6BExB44JWE6o+XCFwzjFJuZo=;
 b=cSZRLJNQ9+BjpzYS+9NN6YRm7/9OpqZWz+KQIebX+1PFeEPCEqsJ3ZP1XJbMsLMIxm
 G1zNbIr0C9UJl0bfkgqSZLu1OjkXnZrePK4MQi+5yHn83rCDZ7OnwJaQDzI1/SutW4EL
 nCIO9Mv6s5lnZRIxeYPp/OFqnGpwZ0tPwVqdVsiccbZT1///FlRBneCARSoB4UdElCyj
 ftsJk/GSUboB2nGQK0L5EjKVlOyChZnxumWfw1M1qiL002pkNQVRijJDvIdI5oSlEKWW
 RCqX7FygSkP6FcpTQlRPqewtl1LkHQn7Zh9m1/dvDQ3tGW/HKXGaQUPWJszhZDtDKiyO
 RcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289787; x=1734894587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TE3i9BvNsJ8uvWEOc4m6BExB44JWE6o+XCFwzjFJuZo=;
 b=NaCMf4TX9zvn21/zcejgfAm+xDGwAdLuipL9IBWUDM05CC2fo//763/DlFCMIPLndc
 moJsChkAjbCuDN5ECXSXJFGdTo+qRoRWlMi73QyqwxA6fhmTup620ern91uQDGr8rty0
 e64k2nFty07TeEgU3Ttrxz8Gmi4ip3jsuT7/tiShOgklKZkn4p2KVhiTCXtxjZGFo2wU
 mA8gk4qS20HAhz3aJmrbfgOdENB2qQxDEMjuQgU4ndPl04HPxxyOwIvomC3OTys7M1V3
 5lVCqk8gsm0JKw3kdBmZNRdrAiy6WfyX7LWAwJQpXA5M8aQ6ZMh7jqYnarXtqZZmq9JJ
 647g==
X-Gm-Message-State: AOJu0Yw/yIrDarm+skLfpmgH9TC8BepBYfiUVdHU5QBwG+e+wWN7gdhO
 3mpdKrNI+IChXf2m2BQCVW41pGq0PxivXfimQV4g3r7cvbvC2/AczpJLmqCTiLxmgEFzkQsW78y
 mDYflPRGs
X-Gm-Gg: ASbGncsX88tTi2JgeegzV0yvh6VDEFFaO8soi0Yz2ddcguM8CMwKJGWRA5wCapEroBT
 0YQ4WrYewlIephmbqc5YjrKcLzJLSzeGzLu9KaExV+IZD1qWy6vUNK9STLlw5or7RdrrCjP3MkD
 Hxoe+UvJPHj7JMVTUlcRNfBRKqyuhJoVWEmfmbRkpdjPNP/afktQyTw66ySPU7T5IZTB+ckChRS
 yuOv9x5J0MvPOj6r+hF21g4nP9DQfMvk0ZnFL6sbXSfs627Dlfd+8LDfCmlqJWv00yACsv8PHOS
 FYYOWXXfkekxfmqNZ/cOCBgzr71eTCPNTmBPmaswv0E=
X-Google-Smtp-Source: AGHT+IFPRHGalaslBANDpH8skhZuMZni3/uBHzvr9+Yc5jxV0/xkkTS4iulQ7Y7UnEnYqc7Jor18aw==
X-Received: by 2002:a05:6830:3114:b0:71e:2310:7c7 with SMTP id
 46e09a7af769-71e3ba73f41mr5789489a34.29.1734289787136; 
 Sun, 15 Dec 2024 11:09:47 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 53/67] hw/scsi: Constify all Property
Date: Sun, 15 Dec 2024 13:05:19 -0600
Message-ID: <20241215190533.3222854-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
 hw/scsi/megasas.c         | 6 +++---
 hw/scsi/mptsas.c          | 2 +-
 hw/scsi/scsi-bus.c        | 2 +-
 hw/scsi/scsi-disk.c       | 6 +++---
 hw/scsi/scsi-generic.c    | 2 +-
 hw/scsi/spapr_vscsi.c     | 2 +-
 hw/scsi/vhost-scsi.c      | 2 +-
 hw/scsi/vhost-user-scsi.c | 2 +-
 hw/scsi/virtio-scsi.c     | 2 +-
 hw/scsi/vmw_pvscsi.c      | 2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index df58aeb995..8323cd18e3 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2448,7 +2448,7 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
     scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev), &megasas_scsi_info);
 }
 
-static Property megasas_properties_gen1[] = {
+static const Property megasas_properties_gen1[] = {
     DEFINE_PROP_UINT32("max_sge", MegasasState, fw_sge,
                        MEGASAS_DEFAULT_SGE),
     DEFINE_PROP_UINT32("max_cmds", MegasasState, fw_cmds,
@@ -2462,7 +2462,7 @@ static Property megasas_properties_gen1[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static Property megasas_properties_gen2[] = {
+static const Property megasas_properties_gen2[] = {
     DEFINE_PROP_UINT32("max_sge", MegasasState, fw_sge,
                        MEGASAS_DEFAULT_SGE),
     DEFINE_PROP_UINT32("max_cmds", MegasasState, fw_cmds,
@@ -2487,7 +2487,7 @@ typedef struct MegasasInfo {
     int mmio_bar;
     int osts;
     const VMStateDescription *vmsd;
-    Property *props;
+    const Property *props;
     InterfaceInfo *interfaces;
 } MegasasInfo;
 
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index c6bc3479e9..a06113d908 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1410,7 +1410,7 @@ static const VMStateDescription vmstate_mptsas = {
     }
 };
 
-static Property mptsas_properties[] = {
+static const Property mptsas_properties[] = {
     DEFINE_PROP_UINT64("sas_address", MPTSASState, sas_addr, 0),
     /* TODO: test MSI support under Windows */
     DEFINE_PROP_ON_OFF_AUTO("msi", MPTSASState, msi, ON_OFF_AUTO_AUTO),
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 53eff5dd3d..2f1678d51e 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1943,7 +1943,7 @@ const VMStateDescription vmstate_scsi_device = {
     }
 };
 
-static Property scsi_props[] = {
+static const Property scsi_props[] = {
     DEFINE_PROP_UINT32("channel", SCSIDevice, channel, 0),
     DEFINE_PROP_UINT32("scsi-id", SCSIDevice, id, -1),
     DEFINE_PROP_UINT32("lun", SCSIDevice, lun, -1),
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 7f13b0588f..a47b80907f 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3207,7 +3207,7 @@ static const TypeInfo scsi_disk_base_info = {
     DEFINE_PROP_BOOL("migrate-emulated-scsi-request", SCSIDiskState, migrate_emulated_scsi_request, true)
 
 
-static Property scsi_hd_properties[] = {
+static const Property scsi_hd_properties[] = {
     DEFINE_SCSI_DISK_PROPERTIES(),
     DEFINE_PROP_BIT("removable", SCSIDiskState, features,
                     SCSI_DISK_F_REMOVABLE, false),
@@ -3267,7 +3267,7 @@ static const TypeInfo scsi_hd_info = {
     .class_init    = scsi_hd_class_initfn,
 };
 
-static Property scsi_cd_properties[] = {
+static const Property scsi_cd_properties[] = {
     DEFINE_SCSI_DISK_PROPERTIES(),
     DEFINE_PROP_UINT64("wwn", SCSIDiskState, qdev.wwn, 0),
     DEFINE_PROP_UINT64("port_wwn", SCSIDiskState, qdev.port_wwn, 0),
@@ -3310,7 +3310,7 @@ static const TypeInfo scsi_cd_info = {
 };
 
 #ifdef __linux__
-static Property scsi_block_properties[] = {
+static const Property scsi_block_properties[] = {
     DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),
     DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
     DEFINE_PROP_BOOL("share-rw", SCSIDiskState, qdev.conf.share_rw, false),
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 76f04a5ee8..d7ae7549d0 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -772,7 +772,7 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
     return scsi_req_alloc(&scsi_generic_req_ops, d, tag, lun, hba_private);
 }
 
-static Property scsi_generic_properties[] = {
+static const Property scsi_generic_properties[] = {
     DEFINE_PROP_DRIVE("drive", SCSIDevice, conf.blk),
     DEFINE_PROP_BOOL("share-rw", SCSIDevice, conf.share_rw, false),
     DEFINE_PROP_UINT32("io_timeout", SCSIDevice, io_timeout,
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index c75a6c8807..7c55e4d40f 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1250,7 +1250,7 @@ static int spapr_vscsi_devnode(SpaprVioDevice *dev, void *fdt, int node_off)
     return 0;
 }
 
-static Property spapr_vscsi_properties[] = {
+static const Property spapr_vscsi_properties[] = {
     DEFINE_SPAPR_PROPERTIES(VSCSIState, vdev),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 22d16dc26b..effb8dab1f 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -343,7 +343,7 @@ static struct vhost_dev *vhost_scsi_get_vhost(VirtIODevice *vdev)
     return &vsc->dev;
 }
 
-static Property vhost_scsi_properties[] = {
+static const Property vhost_scsi_properties[] = {
     DEFINE_PROP_STRING("vhostfd", VirtIOSCSICommon, conf.vhostfd),
     DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 55e4be5b34..d5265c57bc 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -341,7 +341,7 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
     virtio_scsi_common_unrealize(dev);
 }
 
-static Property vhost_user_scsi_properties[] = {
+static const Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 6637cfeaf5..c0a4f1a620 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1285,7 +1285,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev)
     qemu_mutex_destroy(&s->tmf_bh_lock);
 }
 
-static Property virtio_scsi_properties[] = {
+static const Property virtio_scsi_properties[] = {
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues,
                        VIRTIO_SCSI_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 57761b5594..46cec531cc 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1296,7 +1296,7 @@ static const VMStateDescription vmstate_pvscsi = {
     }
 };
 
-static Property pvscsi_properties[] = {
+static const Property pvscsi_properties[] = {
     DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
     DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, compat_flags,
                     PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
-- 
2.43.0


