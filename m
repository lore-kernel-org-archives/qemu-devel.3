Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CCACA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENGx-0004Ka-2R; Wed, 07 Oct 2026 04:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJb5-0006rq-VP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:49:53 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJav-0003QI-2Z
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:49:41 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3a9a2cfe1d4so2824271fa.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791348540; x=1791953340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=21yxfb4i7kxC3qcFd4IJSGMl/u7d4pLAk60w6us8vRM=;
 b=EprH6Pq7UqRgDIx+ts5V827FxpwJKJ9bFX9zYKpmSzAlJYOa/bGmYeCYMbclY95eaZ
 Q1PS9Hre/fHzJuDjwcLgKjtTIwkv/bt4IqgRDtuQD6uZ090W+HSMcE2mYqTnLSTDMVDm
 NkRmtIMgBt5RCLwAhwfqa+IRo89AiQMOqdsywGZHwg4EPF5SOwRXWTwRLcc1fyAfadPZ
 htyNJHKwp4cQWN+IMzKUBNBBmQbJt/XsTNGMtvSx0KS45+g4M54W2mtGNbSXGh9/TJzj
 nMjMvqaHXaREHitRCrRfXcPj5yy0yCpsf5TWramNRu7K7hHgUJAUxGUMhB2dxPsEiQTi
 G7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791348540; x=1791953340;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=21yxfb4i7kxC3qcFd4IJSGMl/u7d4pLAk60w6us8vRM=;
 b=Ac62Vw+veywjCfX+Bj1GyzLGWIPDLWm3HvXBb5i7cKpfzp8ozrM/YiMAZOlDYgFMRq
 qQWuwp+WQtrzHWmZim7SY0Wpr/tHTorM/z3e9WfOHvV6exsJAs6fs9IlH6dVzIX2MfzP
 4F1L2+O1yoNQrMqqQMpNHmvErRxLEjJLuunabwQzONbHnBDSzDioYxfRN0TwuMeZE9iY
 E4O9V7+oAV5bRKL8Q2ToyyeBvhdegOxGCSTbuyNbIr73Peaef3oYoE4m+uz/uQFlERYF
 COonto3OLZMXj8kSUW+UUHZS4MaYjRGpSomkD7XIkgB8gS/Votdo0KpMKfBWDmTuWvit
 R79w==
X-Gm-Message-State: AFq9FYJhRW2DyqQdUc9EpRe1bctpnoDj6vRuTVk6b2pvqRmNfOEC1/91
 G8l6iRwbAe3ssqoVwQPtdIGG/lHuz7of4XL5LoD87b9dy/6jWhzafcrRJY+gdA==
X-Gm-Gg: AYBFou1/8AszOk1vstjbPu/hZf9HsiaahxClUTvhOTExPTbBTT20TM8TF3IGknrm6sI
 7DNUWifdopOISfMhk7UdjTuFHw/VPj6dcmMDepgd/By/lPBb0MjKKI5gVv01v4uQHHCFVfdfC5Q
 hc2i6eDXA1WbJi03l+enppOnTKrllrWXfo+jqGs13/TyNf9DlSlhj1ClRQwGrTUKQRi3+EkXiYd
 M1k3im7yp9VzILvCFn6Kr9Hy6OgX+bhd+d1IWhH6JMoYziUxxUuRP77voZqIwy4rLccsNQ8/aVM
 hKJjwrFybgG7Gvwt7qljcm3UB19Zo0PkCj2UljGKht3dVie4qa7mI8l/iNUrbGl7WopVhTIqTvJ
 HylkMaZLumME1VNmWy+V4dKAEnh9U/WxjBQ221f9krm90L0iT1zPhU65KPINUHXd+XdvmjEXFLK
 7T7X2lK+eke9uC3dKf4jW5tudw8gsnNQqfD5N17LOaFRar6DHJwhj00uyJ2KePOtU5BivtNT3YA
 dPFwCV8wx4QrLIPMhNtREmb5QNximjhzdM8UA==
X-Received: by 2002:a05:6000:26c9:b0:487:218b:bbb0 with SMTP id
 ffacd0b85a97d-48c6d1d1c18mr1762387f8f.42.1791279909492; 
 Tue, 06 Oct 2026 02:45:09 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6faa93fbsm433426f8f.16.2026.10.06.02.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:45:09 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Christian Speich <c.speich@avm.de>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 5/8] hw/sd/sd: Add erase-blocks-as-zero option.
Date: Tue,  6 Oct 2026 11:44:44 +0200
Message-ID: <20261006094447.43491-6-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006094447.43491-1-shentey@gmail.com>
References: <20261006094447.43491-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Christian Speich <c.speich@avm.de>

Currently, erased blocks are filled with 0xFF. However SCR Bit 55
(DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
them is wrong.

This patch does two things.

First it fixes the reporting of DATA_STAT_AFTER_ERASE in SCR to
correctly reflect the content of erased blocks. We also increase the
Product Revision (REV in CID) to indicate to the guest that
DATA_STAT_AFTER_ERASE is now reliable.

Secondly, we introduce a erase-blocks-as-zero option, which allows the
user to choose if erased blocks should contain 0xFF or 0x00. The default
is still 0xFF to remain compatible with current users.

Signed-off-by: Christian Speich <c.speich@avm.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Move global compat property
  `{ "sdmmc-common", "erase-blocks-as-zero", "false" }`
to 11.1 section.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/core/machine.c |  1 +
 hw/sd/sd.c        | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index d9ac4b419a..7b0be16444 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@
 #include "hw/arm/smmuv3.h"
 
 GlobalProperty hw_compat_11_1[] = {
+    { "sdmmc-common", "erase-blocks-as-zero", "false" },
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
 };
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6e2bb8ff2d..c40097924c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -162,6 +162,7 @@ struct SDState {
     /* Static properties */
 
     uint8_t spec_version;
+    bool erase_blocks_as_zero;
     uint64_t boot_part_size;
     uint64_t rpmb_part_size;
     BlockBackend *blk;
@@ -440,6 +441,9 @@ static void sd_set_scr(SDState *sd)
     sd->scr[0] |= 2;            /* Spec Version 2.00 or Version 3.0X */
     sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
                  | 0b0101;      /* 1-bit or 4-bit width bus modes */
+    if (!sd->erase_blocks_as_zero) {
+        sd->scr[1] |= (1 << 7); /* DATA_STAT_AFTER_ERASE: Erase produces 0xFF */
+    }
     sd->scr[2] = 0x00;          /* Extended Security is not supported. */
     if (sd->spec_version >= SD_PHY_SPECv3_01_VERS) {
         sd->scr[2] |= 1 << 7;   /* Spec Version 3.0X */
@@ -457,7 +461,7 @@ static void sd_set_scr(SDState *sd)
 #define MID     0xaa
 #define OID     "XY"
 #define PNM     "QEMU!"
-#define PRV     0x01
+#define PRV     0x02
 #define MDT_YR  2006
 #define MDT_MON 2
 
@@ -1354,7 +1358,12 @@ static void sd_erase(SDState *sd)
     sd->erase_end = INVALID_ADDRESS;
     sd->csd[14] |= 0x40;
 
-    memset(sd->data, 0xff, erase_len);
+    if (sd->erase_blocks_as_zero) {
+        memset(sd->data, 0x0, erase_len);
+    } else {
+        memset(sd->data, 0xFF, erase_len);
+    }
+
     for (erase_addr = erase_start; erase_addr <= erase_end;
          erase_addr += erase_len) {
         if (sdsc) {
@@ -3281,6 +3290,8 @@ static void emmc_realize(DeviceState *dev, Error **errp)
 
 static const Property sdmmc_common_properties[] = {
     DEFINE_PROP_DRIVE("drive", SDState, blk),
+    DEFINE_PROP_BOOL("erase-blocks-as-zero", SDState, erase_blocks_as_zero,
+                     true),
 };
 
 static const Property sd_properties[] = {
-- 
2.56.0


