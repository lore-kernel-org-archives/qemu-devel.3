Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66E1E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB31-00048q-SA; Fri, 13 Dec 2024 14:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2L-0003QI-46
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:17 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2C-0006cu-Tk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:16 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71e2aa8d5e3so1086777a34.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116944; x=1734721744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvKuTabJuM44RrR9LqcDtNRzVnC+ouLNjCo5mA0gZDg=;
 b=e8DKzh8l3mS/vYxerQuHxY/Yuazy7Uki6YxgY2Na/aLCqjWyUCHfUj16YI9lMZ1EU6
 YCsUY2KrF+Q0JRVi04zRyMFT8ttLpGgIh1ke7pQoGuE5zkrhrjGyHQw4IGlTEO7jk193
 1umq4Z/Mm+ei9K0kde+hp8buCBwXob27LDGxqDbkdyxWROpQLcsw5K2lJbfZHkMWxxA0
 Wsh895lYEX8Fx8pNio99oqUwv+avDcwxYeHkMVVeLvtw+fwYoSHJn3Jr30yhpVT5lNOS
 Pkn/dnyjsYl3LOfUZ0AZAKvRpmVrvf7GeRq4J2b10GnUvD/SVZQurag0XsKgj+Dad1h7
 vfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116944; x=1734721744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvKuTabJuM44RrR9LqcDtNRzVnC+ouLNjCo5mA0gZDg=;
 b=N2QLspHkbKZir13Vv/uIiJDyMq9VBD/jJZ74ZvQMMQc2cGhTP/dEa14JpbDlKzjmV4
 TkcqQxCdt1XdmHa6eoXDKT6+6/gY3cHbRz+7WqbS0TmQiZXbxrEDjRygjc/fG+VgLqcH
 pHvjfUkmllGG1WjUkzMR8bsTwLDMNgsF29szyL2xhTjm4XWPiAK9SV/gBUs05+wKHFyJ
 SdyXttNX2sU3pU7QejaQuIT5BlUqq2unU0Orgrk1FQXOn1M2pBwMlduaJ0CODA67Brq6
 6LiBdnMo9rf8uI7Ojnlb5FtcnjCIKYn/+hqFPEjtuGfvlVppQMLHmTYC9q6FlffuGEkR
 Ub3g==
X-Gm-Message-State: AOJu0Yz+5QrsJL7IHouAIB3eppiot9YLwJ67oC9+3wnuXmFCeb3jKxNU
 tghQIpzyH5H0utaudViHLm1ZskzO6u3+y8DouXQIyJR3sfcOp8FSx1/m6tNOFo81VMP3Qo4ovGC
 44/PH33bg
X-Gm-Gg: ASbGncsoSFjtHmU7fTIg3dNsfhlUk6f/DOfs6pR9WPIyofFIVt5SvGJr7f+fuDmMi4Q
 5FYpoDeb1QJsUHmWl9sjRitChrZnD3j5bHzDPJ7YLg6miwOUSeeUq6bZ6putQC2k4uorH54r9EC
 khGfjaZjt7YtTP7MC07BrQuZiFS2/dolxnaefnMwp3PEiKfVt+0mF9NlRR4JXo43/+E1SqPrJh/
 +tSTbOLefzPnFFNQ0S/a6EqBfRtKCruIdVK5N0wADv2gALZ+TZdnZ3G5KavHnre
X-Google-Smtp-Source: AGHT+IH4rJcdXbtBNLnupXAb1IE3M6qGGNYml9H8C6S7DGbxJKBCaGKoGLFrcPQYq1LiK/0DBH3rEw==
X-Received: by 2002:a05:6830:6e18:b0:71d:f239:c0a8 with SMTP id
 46e09a7af769-71e3b827be9mr2189273a34.6.1734116944096; 
 Fri, 13 Dec 2024 11:09:04 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:09:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-block@nongnu.org (open list:Floppy),
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH 19/71] hw/block: Constify all Property
Date: Fri, 13 Dec 2024 13:06:53 -0600
Message-ID: <20241213190750.2513964-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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
 hw/block/fdc-isa.c        | 2 +-
 hw/block/fdc-sysbus.c     | 4 ++--
 hw/block/fdc.c            | 2 +-
 hw/block/m25p80.c         | 2 +-
 hw/block/nand.c           | 2 +-
 hw/block/pflash_cfi01.c   | 2 +-
 hw/block/pflash_cfi02.c   | 2 +-
 hw/block/swim.c           | 2 +-
 hw/block/vhost-user-blk.c | 2 +-
 hw/block/virtio-blk.c     | 2 +-
 hw/block/xen-block.c      | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 5ed3c18c28..2b9f667fe4 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -283,7 +283,7 @@ static const VMStateDescription vmstate_isa_fdc = {
     }
 };
 
-static Property isa_fdc_properties[] = {
+static const Property isa_fdc_properties[] = {
     DEFINE_PROP_UINT32("iobase", FDCtrlISABus, iobase, 0x3f0),
     DEFINE_PROP_UINT32("irq", FDCtrlISABus, irq, 6),
     DEFINE_PROP_UINT32("dma", FDCtrlISABus, dma, 2),
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index e1ddbf3d1a..f17e04b138 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -196,7 +196,7 @@ static const TypeInfo sysbus_fdc_common_typeinfo = {
     .class_size    = sizeof(FDCtrlSysBusClass),
 };
 
-static Property sysbus_fdc_properties[] = {
+static const Property sysbus_fdc_properties[] = {
     DEFINE_PROP_SIGNED("fdtypeA", FDCtrlSysBus, state.qdev_for_drives[0].type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
@@ -223,7 +223,7 @@ static const TypeInfo sysbus_fdc_typeinfo = {
     .class_init    = sysbus_fdc_class_init,
 };
 
-static Property sun4m_fdc_properties[] = {
+static const Property sun4m_fdc_properties[] = {
     DEFINE_PROP_SIGNED("fdtype", FDCtrlSysBus, state.qdev_for_drives[0].type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 6dd94e98bc..57d6844806 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -454,7 +454,7 @@ struct FloppyDrive {
     FloppyDriveType type;
 };
 
-static Property floppy_drive_properties[] = {
+static const Property floppy_drive_properties[] = {
     DEFINE_PROP_UINT32("unit", FloppyDrive, unit, -1),
     DEFINE_BLOCK_PROPERTIES(FloppyDrive, conf),
     DEFINE_PROP_SIGNED("drive-type", FloppyDrive, type,
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 748594524e..ca97365926 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1720,7 +1720,7 @@ static int m25p80_pre_save(void *opaque)
     return 0;
 }
 
-static Property m25p80_properties[] = {
+static const Property m25p80_properties[] = {
     /* This is default value for Micron flash */
     DEFINE_PROP_BOOL("write-enable", Flash, write_enable, false),
     DEFINE_PROP_UINT32("nonvolatile-cfg", Flash, nonvolatile_cfg, 0x8FFF),
diff --git a/hw/block/nand.c b/hw/block/nand.c
index ac0a5d2b42..b6e6bfac23 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -445,7 +445,7 @@ static void nand_realize(DeviceState *dev, Error **errp)
     s->ioaddr = s->io;
 }
 
-static Property nand_properties[] = {
+static const Property nand_properties[] = {
     DEFINE_PROP_UINT8("manufacturer_id", NANDFlashState, manf_id, 0),
     DEFINE_PROP_UINT8("chip_id", NANDFlashState, chip_id, 0),
     DEFINE_PROP_DRIVE("drive", NANDFlashState, blk),
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 21a81b44f0..20f4fc67a0 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -895,7 +895,7 @@ static void pflash_cfi01_system_reset(DeviceState *dev)
     pfl->blk_offset = -1;
 }
 
-static Property pflash_cfi01_properties[] = {
+static const Property pflash_cfi01_properties[] = {
     DEFINE_PROP_DRIVE("drive", PFlashCFI01, blk),
     /* num-blocks is the number of blocks actually visible to the guest,
      * ie the total size of the device divided by the sector length.
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 8393f261b8..c82002d665 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -937,7 +937,7 @@ static void pflash_cfi02_reset(DeviceState *dev)
     pflash_reset_state_machine(pfl);
 }
 
-static Property pflash_cfi02_properties[] = {
+static const Property pflash_cfi02_properties[] = {
     DEFINE_PROP_DRIVE("drive", PFlashCFI02, blk),
     DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, uniform_nb_blocs, 0),
     DEFINE_PROP_UINT32("sector-length", PFlashCFI02, uniform_sector_len, 0),
diff --git a/hw/block/swim.c b/hw/block/swim.c
index 64992eb72e..c336d83bdc 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -166,7 +166,7 @@ static const BlockDevOps swim_block_ops = {
     .change_media_cb = swim_change_cb,
 };
 
-static Property swim_drive_properties[] = {
+static const Property swim_drive_properties[] = {
     DEFINE_PROP_INT32("unit", SWIMDrive, unit, -1),
     DEFINE_BLOCK_PROPERTIES(SWIMDrive, conf),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 7996e49821..f3ac007108 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -570,7 +570,7 @@ static const VMStateDescription vmstate_vhost_user_blk = {
     },
 };
 
-static Property vhost_user_blk_properties[] = {
+static const Property vhost_user_blk_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
                        VHOST_USER_BLK_AUTO_NUM_QUEUES),
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9166d7974d..9ca60fbc07 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1985,7 +1985,7 @@ static const VMStateDescription vmstate_virtio_blk = {
     },
 };
 
-static Property virtio_blk_properties[] = {
+static const Property virtio_blk_properties[] = {
     DEFINE_BLOCK_PROPERTIES(VirtIOBlock, conf.conf),
     DEFINE_BLOCK_ERROR_PROPERTIES(VirtIOBlock, conf.conf),
     DEFINE_BLOCK_CHS_PROPERTIES(VirtIOBlock, conf.conf),
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 72cfd6893a..0c0817f498 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -666,7 +666,7 @@ static const PropertyInfo xen_block_prop_vdev = {
     .set = xen_block_set_vdev,
 };
 
-static Property xen_block_props[] = {
+static const Property xen_block_props[] = {
     DEFINE_PROP("vdev", XenBlockDevice, props.vdev,
                 xen_block_prop_vdev, XenBlockVdev),
     DEFINE_BLOCK_PROPERTIES(XenBlockDevice, props.conf),
-- 
2.43.0


