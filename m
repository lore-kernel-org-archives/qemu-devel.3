Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC037C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJ8L-0006ge-3b; Fri, 12 Jul 2024 12:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ8I-0006N1-Pf
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:28:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ8F-00023Z-TI
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:28:30 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-36796bbf687so1184398f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720801706; x=1721406506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glf0Dg5n4+P+FxR4zbHuZCiafWvUhX2krPIpxd4tsFI=;
 b=gx8HRFj4AKvCh3bX8Lywn0cV1Ve5HR4D/fyH9ekckM60ZaUYZBqDfHSpfLJSwWucqA
 llegillcgVh9kpBT/XStGUD8GZ+cO1f12LaUF9nKwYU3gUccWxTfYurOdQHioOoX85e8
 Cwgw6C/aWE9c8T90z0FdAr/B4uDDqJyhYXJlyvuoQyL6aAfXLOfW7bINLfWpJrcOS347
 ZSljksdTAqqAeEfs6S4DUKM06S7lYoFwXmzHgmj9wxcINPRIS3pEwQpEP8AvhYBvfeqM
 4LvPbSB0OAVMp0zgFJcllaSK7FBtImZFN1hR848hp6nO9fD50H5XceTuyNQu3Q67i3io
 HItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720801706; x=1721406506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glf0Dg5n4+P+FxR4zbHuZCiafWvUhX2krPIpxd4tsFI=;
 b=vaSfs2cUQZ1A4jvDfs49UyredMgfYGXc7sbaYpKMPScybW2NxIA+4w4Kj1VstTI2tt
 QjVJO9FqAct9GkfDk7ydZpkrI7cFTpdkmI8+C+tRl2onzYMhKO5vS5ftq7HMuId8Xfsi
 c+1f7aqvJgdORB/sTtR3AFF3zfGTckMaHEE8vxp8293ZLMmzLQQRakLJXy8Q275PMHns
 M2X7QPh68uQakZ4EVhhTuFMtt/5wPeQ+qVrS5EdnzZWDnFQgftyOyMFiq8/CR5mku+Qj
 B5X/SfhPlFqHfhZ70OywnLsd3KaU4SoP0mq/feNjZfIQXXcqKmwuJZjWzfH7C3mr3fPx
 eqOQ==
X-Gm-Message-State: AOJu0YwkDE7fd5V1kgpSy7L5CROt0yJFjpK0+r5aY1PS3S7Qc8GXnNBf
 maFm0ThcasLGzUT2DZb8XQoemTY9+Y1wUZ/JjNtxUCQwSCf5jg1xxeu41Ajabi2yef4fPUELviA
 N
X-Google-Smtp-Source: AGHT+IEVleA7iO0HwT2JQMWJ49/9qtmd7qM+Vf8YYGGQBgQzvkgSjScFXLX/8o+QceClUCG0OTjmJw==
X-Received: by 2002:a05:6000:ac9:b0:367:8a6f:8c0e with SMTP id
 ffacd0b85a97d-367cea67f4dmr8065002f8f.21.1720801706106; 
 Fri, 12 Jul 2024 09:28:26 -0700 (PDT)
Received: from localhost.localdomain
 (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr. [176.184.54.152])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde89113sm10473168f8f.56.2024.07.12.09.28.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jul 2024 09:28:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v49 11/11] hw/sd/sdcard: Support boot area in emmc image
Date: Fri, 12 Jul 2024 18:27:19 +0200
Message-ID: <20240712162719.88165-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240712162719.88165-1-philmd@linaro.org>
References: <20240712162719.88165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Joel Stanley <joel@jms.id.au>

This assumes a specially constructed image:

  dd if=/dev/zero of=mmc-bootarea.img count=2 bs=1M
  dd if=u-boot-spl.bin of=mmc-bootarea.img conv=notrunc
  dd if=u-boot.bin of=mmc-bootarea.img conv=notrunc count=64 bs=1K
  cat mmc-bootarea.img obmc-phosphor-image.wic > mmc.img
  truncate --size 16GB mmc.img

For now this still requires a mtd image to load the SPL:

  qemu-system-arm -M tacoma-bmc -nographic \
   -global driver=sd-card,property=emmc,value=true \
   -drive file=mmc.img,if=sd,index=2,format=raw

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1f16c16fd1..07cb97d88c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -137,6 +137,7 @@ struct SDState {
     uint8_t spec_version;
     uint64_t boot_part_size;
     BlockBackend *blk;
+    uint8_t boot_config;
 
     const SDProto *proto;
 
@@ -513,6 +514,9 @@ static void emmc_set_ext_csd(SDState *sd, uint64_t size)
     sd->ext_csd[EXT_CSD_CARD_TYPE] = 0b11;
     sd->ext_csd[EXT_CSD_STRUCTURE] = 2;
     sd->ext_csd[EXT_CSD_REV] = 3;
+
+    /* Mode segment (RW) */
+    sd->ext_csd[EXT_CSD_PART_CONFIG] = sd->boot_config;
 }
 
 static void emmc_set_csd(SDState *sd, uint64_t size)
@@ -763,6 +767,40 @@ static uint32_t sd_blk_len(SDState *sd)
     return sd->blk_len;
 }
 
+/*
+ * This requires a disk image that has two boot partitions inserted at the
+ * beginning of it. The size of the boot partitions is the "boot-size"
+ * property.
+ */
+static uint32_t sd_bootpart_offset(SDState *sd)
+{
+    bool partitions_enabled;
+    unsigned partition_access;
+
+    if (!sd->boot_part_size || !sd_is_emmc(sd)) {
+        return 0;
+    }
+
+    partitions_enabled = sd->ext_csd[EXT_CSD_PART_CONFIG]
+                                   & EXT_CSD_PART_CONFIG_EN_MASK;
+    if (!partitions_enabled) {
+        return 0;
+    }
+
+    partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
+                                 & EXT_CSD_PART_CONFIG_ACC_MASK;
+    switch (partition_access) {
+    case EXT_CSD_PART_CONFIG_ACC_DEFAULT:
+        return sd->boot_part_size * 2;
+    case EXT_CSD_PART_CONFIG_ACC_BOOT0:
+        return 0;
+    case EXT_CSD_PART_CONFIG_ACC_BOOT0 + 1:
+        return sd->boot_part_size * 1;
+    default:
+         g_assert_not_reached();
+    }
+}
+
 static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -795,6 +833,7 @@ static void sd_reset(DeviceState *dev)
         sect = 0;
     }
     size = sect << HWBLOCK_SHIFT;
+    size -= sd_bootpart_offset(sd);
 
     sect = sd_addr_to_wpnum(size) + 1;
 
@@ -1003,6 +1042,7 @@ void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
+    addr += sd_bootpart_offset(sd);
     if (!sd->blk || blk_pread(sd->blk, addr, len, sd->data, 0) < 0) {
         fprintf(stderr, "sd_blk_read: read error on host side\n");
     }
@@ -1011,6 +1051,7 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_write_block(addr, len);
+    addr += sd_bootpart_offset(sd);
     if (!sd->blk || blk_pwrite(sd->blk, addr, len, sd->data, 0) < 0) {
         fprintf(stderr, "sd_blk_write: write error on host side\n");
     }
@@ -2763,6 +2804,7 @@ static Property sd_properties[] = {
 
 static Property emmc_properties[] = {
     DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
+    DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.41.0


