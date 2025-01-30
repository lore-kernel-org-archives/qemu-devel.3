Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B9DC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZFa-0002yi-Lv; Thu, 30 Jan 2025 13:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZFW-0002iR-VJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:26:47 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZFU-0001LD-Tc
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:26:46 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so1625630f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261603; x=1738866403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riA4zmJH/fUcpHKgfppzYaaXrF+oAl0RGRsil+s6hSg=;
 b=R0WXohcBKGEHuRnfVw1FuPbzgBfcMlkkKvP/qOe54Lj99Xl7JoygCzU9kuKMMC3LPL
 p01E2/S7alwfEfkQyfq2huxSRFUoe8sP5UZRlaO4TnzF/8zptEu7vgLIhXVyLtEOYqlf
 J3zgcuFs6tlXr9oSpCvDiPFMV0BNNepVWg71hux4vlXDR08SR4vw0X/TwrziJxyNy2Pn
 xSc32Ig94j7aLUgnKY/y9VJDp4PCwa5A6/FfQwRVyjIODKKry/mKMwRWL+/RJLSpvysn
 MCG1cgvOTg+SQOU4Evg0sI8hQoj6/NBVAZ5FLf3+8ks9jdmswvK1kscP9Em5U1HZIDTV
 95cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261603; x=1738866403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riA4zmJH/fUcpHKgfppzYaaXrF+oAl0RGRsil+s6hSg=;
 b=CyrY2x7abO8bELtJfNbmQSSkKnUObiNWF4aYb1KBvVk0Be0J6Ju5pbalShmJC5ZGbk
 OHp2A9EWy/5CcQfkxzXmAUsyGojANk/Qw54dEBpv4990jNqs8lb3LuqCPiDI+z50xlqn
 zo0nc08XfVzTarBp2MdxhtBwHprBCw+j5xxa47j+2JJClrJt4wqEydtRvRY9qHpaIn5p
 xOALDq4xsQHOmPEEQBI65vWhBCSAsKBs/5NLK0svZWcldSa/8fuqELzLVpE35N4uhPtp
 +UDX+WkueXIBgmKXfbIVPVR+fmBo1JWyGEBIeFydWC+cg61neYklnDO/EhmleSjzbRlc
 k2dQ==
X-Gm-Message-State: AOJu0YxHD2zu9a0WoAg1mW8Cxd78EEJzSltNLJrCC98bkyca/iscmQI5
 +xvU+0nn2CjFIZ9/aVJFgAfQteptOiUykQqnpiDUvpQiqJmZL8qhlkQifOFhfQ6nEsgTTjTL5h7
 joF4=
X-Gm-Gg: ASbGncupv7LoA/X0BQW4cmLQ5HTh4IMITqlwyZFRhhnq21FW7OvTEAXnOoxh68WWbIp
 ijJ4fsBkYsaapqK1bkASJZ/jEgTrWVsTtveX7QvO9BwYJ7QNdigTQjy5o7Ze8ejV1lyLHEvy6b/
 6DKnpQm4AbkyKDPpuVgfSZ7mZbzBZ95pqQaQj44R3RA07GzzBZ0bYtpRvIHqaLUjzq6ssBc1xJR
 1UiYXoZC5YvBnEfX5I/Te2b+/EkUGnCcpvysbcA2hEecPnqGRCBNrvAmbE6Rwq+FNbSfHNuTdru
 /vtInBTOVsGwp8quWAOPJbmDA8oKCXfLoQ40Rd9WsKAH1cag8WfQMXyrk9TZKPtdsA==
X-Google-Smtp-Source: AGHT+IH34UEDzx62k22/qBAWxPwbcHRlx6C+AiBc0kQFEvARbxxUmWQ2neRDb/DsDoxFvg2HA2Eowg==
X-Received: by 2002:a05:6000:1a8f:b0:386:3afc:14a7 with SMTP id
 ffacd0b85a97d-38c60f1654emr420718f8f.7.1738261602664; 
 Thu, 30 Jan 2025 10:26:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc26d05sm66624965e9.12.2025.01.30.10.26.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 10:26:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/8] hw/arm/vexpress: Explicit number of GIC external IRQs
Date: Thu, 30 Jan 2025 19:24:39 +0100
Message-ID: <20250130182441.40480-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130182441.40480-1-philmd@linaro.org>
References: <20250130182441.40480-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

When not specified, Cortex-A9MP configures its GIC with 64 external
IRQs, (see commit a32134aad89 "arm:make the number of GIC interrupts
configurable"), and Cortex-15MP to 128 (see commit  528622421eb
"hw/cpu/a15mpcore: Correct default value for num-irq").
The Versatile Express board however expects a fixed set of 64
interrupts (see the fixed IRQ length when this board was added in
commit 2055283bcc8 ("hw/vexpress: Add model of ARM Versatile Express
board"). Add the GIC_EXT_IRQS definition (with a comment) to make
that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/vexpress.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 42c67034061..8e801aa79cb 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -51,6 +51,14 @@
 #define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
 #define VEXPRESS_FLASH_SECT_SIZE (256 * 1024)
 
+/*
+ * The Cortex-A9MP/A15MP may have anything from 0 to 224 external interrupt
+ * IRQ lines (with another 32 internal). We default to 64+32, which
+ * is the number provided by the Cortex-A9MP test chip in the
+ * Realview PBX-A9 and Versatile Express A9 development boards.
+ */
+#define GIC_EXT_IRQS 64
+
 /* Number of virtio transports to create (0..8; limited by
  * number of available IRQ lines).
  */
@@ -241,6 +249,7 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      */
     dev = qdev_new(privdev);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
+    qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, periphbase);
@@ -251,7 +260,7 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      * external interrupts starting from 32 (because there
      * are internal interrupts 0..31).
      */
-    for (n = 0; n < 64; n++) {
+    for (n = 0; n < GIC_EXT_IRQS; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
@@ -543,7 +552,7 @@ static void vexpress_common_init(MachineState *machine)
     VexpressMachineClass *vmc = VEXPRESS_MACHINE_GET_CLASS(machine);
     VEDBoardInfo *daughterboard = vmc->daughterboard;
     DeviceState *dev, *sysctl, *pl041;
-    qemu_irq pic[64];
+    qemu_irq pic[GIC_EXT_IRQS];
     uint32_t sys_id;
     DriveInfo *dinfo;
     PFlashCFI01 *pflash0;
-- 
2.47.1


