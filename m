Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57942E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwS-0001Iz-5F; Sun, 15 Dec 2024 14:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwQ-0001I2-Qw
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:10 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwM-00015O-RQ
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:10 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-27d0e994ae3so1545381fac.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289565; x=1734894365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M692peXjo7SYsajihEWIkJ+6iFAYEs8PJrwKZYR0Ts8=;
 b=vai7D/jkAnp/j02Bid4RAgaXQBb2IJcppJgZ/C/PiNTXT0p4XMZ5FgP7Cq1eQ+GZQT
 X5KuTnZd+buB8bqy4extJwt6pjvqlDrTzDmFdouFDTXDw6tl7zqp5CSPGLFA/tEB29UU
 uqLvQI6KpTvVrVYwRbbBFzRIm8Kby2jfcwGq9C1YQxVc5a1AybcPj0ch1iTTFAyo2mrx
 bEN17BTvGK3Y81rm5Jm5UEyfjNFYKGqemWb8AXJw1mo/zvKBHwWsT6sOUGA7Xcnv5CD+
 a/jD1Xkmg3aqMYasHbZP6vEVhNLOInbOJ+BkOncZeXVaI4gmzL9h4thW5A6gY7DtDa8A
 B8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289565; x=1734894365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M692peXjo7SYsajihEWIkJ+6iFAYEs8PJrwKZYR0Ts8=;
 b=ql2CwhoVymB7a6mqPxUKtrc4Mkc5ySXzb0H/JXE0IFlIQMQxevrJDFIueRXQO/FAIy
 WMVjrvWQNLUF+xVVEYbFVfgnFNkBeaSeuWhEnkz/vKWF7zFynV6KuX6K99r5rFfGxZCI
 QL+PmRGJ1tlFLwh7QUQ7l41JU6jyCFSUXtVrh/0mKzm2rdzTAo1N+gqKv6CjUanvsHMd
 t9bAhC4MW41kd4Yt9ND/rOSejisKD1VBcF+9zbmcAmPDkz2kPjj3OqVzY650BmExw3lz
 qXZUVc43zwztXdMjSai0lJR10oU/1YfX4gMXzM8NJb2nBr6/+gTxBTJQWsHXipwr9hM7
 Yo9w==
X-Gm-Message-State: AOJu0YwVBD7AlqYAr1zGziqYoD5mGxBFFCvX5flMImrMJqCZt1hbiobQ
 MUwrMRpvpO1vzYKDLB3Hvhz4cWuWDDCejsPfXvXl5Ls7c3hdAPtg25GpveyRxmnwZjxLkjyqf9w
 ILKhpq8hE
X-Gm-Gg: ASbGnctPfr27IPn3aZxvhXsQtSW0XSZjyTQLc1nEs/rPcXZNhwnDnGFnM+cd4QBsmXm
 5lOB1ASKgoH3Bn+LLCBUeZxmr1AqQZCynkgCTaAYfFdYOUioJICrTEXJX+b5iZ8EVNr1liQYA7/
 9sX+0Dapva7Fupxe+NrEAG5lw24m+wyUEvdIGp6BHcKO5amTjCsU+Iu8xfL1AIqkkHW/AKIwgff
 mOtdWuwKd1jyy7D4rRvFDpiZrIcNEXGve9Op7SWw28A/I8QkPSV1cIP5p53RLYQKLDhr+rtPBrS
 GjiGH2nHXeRdVtM/Uvd5wtWsaTSqJmUa6x2kZZWSXd8=
X-Google-Smtp-Source: AGHT+IFhUH+CziBZM/oWC449yo0Q65MF96AVg4l1Z91PN4U+p8ZEw9RG9YsMpBt4+/9eig9uFE/GDQ==
X-Received: by 2002:a05:6871:7288:b0:29e:3345:74ff with SMTP id
 586e51a60fabf-2a3ac7c1e2bmr5776507fac.23.1734289564772; 
 Sun, 15 Dec 2024 11:06:04 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/67] hw/block: Constify all Property
Date: Sun, 15 Dec 2024 13:04:44 -0600
Message-ID: <20241215190533.3222854-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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


