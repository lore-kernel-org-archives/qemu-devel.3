Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C98BCD6E74
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 04:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVMM2-0000mM-W0; Fri, 05 Jun 2026 00:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wVLaw-0003lC-QR
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 23:51:43 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wVLav-0002MN-2w
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 23:51:42 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6608c1a4215so1895526d50.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780631500; x=1781236300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xEhAhztERlLY25A4bHIiwaX34mD7mW74JJDyzCOigOA=;
 b=TKk7XXS+1fyKVaokKfRcL/EekQYZsgyp95KDzH/x/ihRmagl5EXRe1tZQeD6t+lYzE
 mXOrkx4zQTdLZDsQeJin2Sx4a3GAMWPrTde9hR/zTseRIkWWhx51iAgKRjTlkcYGg081
 3ZXCuK++R95x6J6igZFjvjYUjVZlBRal7hOdpX2a9elDtAreEkiAnUWh9MeYoC9e7yiG
 4SPMIpV39poR9UZc1hsrxhg+Pzsc4VqBbwLqjCvgPBlPTgGFAlAAcrhdc+hD68bCCMde
 FVsC56CJ3g9Kb0DWLlsP4r59h51LUo74omc7aV23HEjdZd+2wyt93eRJPKKQSAVjcUVb
 jElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780631500; x=1781236300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEhAhztERlLY25A4bHIiwaX34mD7mW74JJDyzCOigOA=;
 b=q87qIgdLoH01lv0KDerfM6F7y+XilK1SPS+3pIhzbfhxuItCoNEBzwAgXnXn6PVwJC
 UItrn90UT/5cM+dXOdNAiJzGziU25J4cy0JbXQ/c/qMerXjXYj2160/k7c7uktmN89wr
 mvnwoVSWpKbtB1rRh99S4cePFMqZAg3JwLb6TOPjhB5wm6M7d5afoI5ubJZ+6oQFCwDm
 JT+qUAQzu7qUipA6zadqxK5BP4FdMOkDAxupQ5//LplxwfGgYEEJr8ec3F9HmOVdOJNw
 ET4FqKn2SkkAI0jFuE6Fbq/FyQO9G+6TUFIjLiydN+atU5v206PMtGRHY10CZxIqjKK1
 HdNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ96vVQuogQ7hLcGNZSxHKdmNK/WudPzA3pocZJB/gF9Ps5hiJ/3GQW2ok2fmhbj5LRP6IrxQfrMiKsl@nongnu.org
X-Gm-Message-State: AOJu0YzWs2a/VwWhwfa3N30uWBMWHPpebqYC421MRqFzzjihF+s8K9Je
 uBVKjIA6j5a/xBTDw3EyGGqNCX/St3MQmr902yqJ+1SkqKIv+npe3Aed
X-Gm-Gg: Acq92OHq86xdXwnHE9PJteC49MuSxNhVZpVu2SGK8CS/foA8i3ePoYwUj8jEYYOL2OA
 Uv4clF5IIKqIoWckbH1wEWotwWydMVQwewxThJeOk+JcKflat7MY2MugGAW7Yovq2U1X8kgzLGS
 Sz1CbqpHra6bI2iDqwXkZvSj8KWrgxknnbb8EPtnayLcw4TR6kDTvI3Rnk2+o9lyoguDM/wqOeJ
 49Ht7ySlYPVC0NPu4u4sCQDCgwSU2DL624ErArroT+bhCo+UBSAuCxJOHuuH7Ch4/vp7GuJpfh9
 xCdUjGJEeXsP8GwvEELBu4xupMw8l/au5IhXsg8NhzsaFU1xIs5YCiBNKKb9Q0rtpb+mAt5xsex
 kQ2UMhLNrUCvI5n3ExRPJAWwkPfdmZGs7O1WfoZ/T6a/Zajj1T7GzNv6hDR3sVigfKAsSNUyvrs
 QPOUdRc+6K13gRZGTrC97BVNM93WI9AN2Y37jIYy3v2BmlczVCIF0Wj3qCIJCshoODnpiYLYnBo
 bq9E+4cJowt1bfkg+4R
X-Received: by 2002:a05:690e:4007:b0:660:43ec:efbf with SMTP id
 956f58d0204a3-6610a665445mr663444d50.11.1780631499819; 
 Thu, 04 Jun 2026 20:51:39 -0700 (PDT)
Received: from skippy.tail1682c8.ts.net
 (99-61-67-1.lightspeed.austtx.sbcglobal.net. [99.61.67.1])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d5f39fedsm5080851d50.1.2026.06.04.20.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 20:51:38 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/sd/sdhci: let i.MX (u)SDHC issue commands without SDCLK_EN
Date: Thu,  4 Jun 2026 22:51:34 -0500
Message-Id: <20260605035134.2877604-1-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 05 Jun 2026 00:40:21 -0400
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

The i.MX (u)SDHC gates the SD card clock in hardware and has no
software-visible "SD Clock Enable" bit, so the Linux sdhci-esdhc-imx
driver programs only the divider and the internal-clock enable and never
sets SDHC_CLOCK_SDCLK_EN. The generic command-dispatch gate,
sdhci_can_issue_command() -> SDHC_CLOCK_IS_ON(), requires that bit, so
under Linux every command issued to such a controller is silently
dropped: no command-complete or command-timeout interrupt is raised, and
the guest mmc layer falls back to a 10s host-side timeout per command,
indefinitely. (The existing VENDORSPEC->clkcon mirror only covered the
U-Boot fsl_esdhc_imx clock path, which does toggle the VENDORSPEC enable
bits; the upstream Linux driver does not.)

On the i.MX 95 machine this wedges shutdown: with no backing storage the
empty eMMC slot (non-removable, always probed) and SD slot both spin on
these 10s timeouts, so device_shutdown() never returns and the guest
never reaches PSCI SYSTEM_OFF -- a guest poweroff fails to terminate
QEMU, and the controllers spew sdhci-esdhc-imx debug-status dumps the
whole time.

Add SDHCI_QUIRK_SDCLK_AUTO_GATE: when set, the controller is considered
ready to issue commands once the internal clock is enabled and stable,
without also requiring SDHC_CLOCK_SDCLK_EN. Set it on the three i.MX
variants (imx-usdhc, fsl-esdhc-be, fsl-esdhc-le). With the clock gate
relaxed, an absent card is reported promptly as a command timeout, card
init fails in milliseconds instead of 10s, device_shutdown() completes,
and guest poweroff terminates the VM cleanly.

The change is strictly more permissive than the previous gate (every
state that satisfied SDHC_CLOCK_IS_ON still dispatches), so controllers
without the quirk are unaffected; the sdhci qtests (xlnx-zcu102 and
sdhci-pci, neither of which sets the quirk) still pass.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>

---
 hw/sd/sdhci.c         | 25 +++++++++++++++++++++----
 include/hw/sd/sdhci.h | 11 +++++++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 4ad96a8760..d52335424b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1013,9 +1013,26 @@ static void sdhci_data_transfer(void *opaque)
     }
 }
 
+static bool sdhci_clock_is_on(SDHCIState *s)
+{
+    /*
+     * The i.MX (u)SDHC has no software SD-clock-enable bit (the card clock
+     * is auto-gated by hardware), so its driver never sets
+     * SDHC_CLOCK_SDCLK_EN. For such a controller, treat the clock as
+     * running once the internal clock is enabled and stable; otherwise
+     * every command would be silently dropped (no completion/timeout IRQ),
+     * stalling the guest on 10s host-side timeouts.
+     */
+    if (s->quirks & SDHCI_QUIRK_SDCLK_AUTO_GATE) {
+        return (s->clkcon & (SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE)) ==
+               (SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE);
+    }
+    return SDHC_CLOCK_IS_ON(s->clkcon);
+}
+
 static bool sdhci_can_issue_command(SDHCIState *s)
 {
-    if (!SDHC_CLOCK_IS_ON(s->clkcon) ||
+    if (!sdhci_clock_is_on(s) ||
         (((s->prnsts & SDHC_DATA_INHIBIT) || s->stopped_state) &&
         ((s->cmdreg & SDHC_CMD_DATA_PRESENT) ||
         ((s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY &&
@@ -1905,7 +1922,7 @@ static void fsl_esdhc_be_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &esdhc_mmio_be_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_SDCLK_AUTO_GATE;
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
 }
 
@@ -1930,7 +1947,7 @@ static void fsl_esdhc_le_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &esdhc_mmio_le_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_SDCLK_AUTO_GATE;
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
 }
 
@@ -1951,7 +1968,7 @@ static void imx_usdhc_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &usdhc_mmio_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_SDCLK_AUTO_GATE;
     qdev_prop_set_uint8(dev, "sd-spec-version", 3);
 }
 
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index a9da6203fc..d96f9c1dfa 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -115,6 +115,17 @@ typedef struct SDHCIState SDHCIState;
  */
 #define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
 
+/*
+ * The i.MX (u)SDHC gates the SD card clock automatically and has no
+ * software-visible "SD Clock Enable" bit: its driver programs only the
+ * divider and the internal-clock enable, never SDHC_CLOCK_SDCLK_EN. With
+ * this quirk the controller is considered ready to issue commands once the
+ * internal clock is enabled and stable, instead of also requiring
+ * SDHC_CLOCK_SDCLK_EN (which such a driver never sets). QEMU-internal bit,
+ * not mirrored from Linux.
+ */
+#define SDHCI_QUIRK_SDCLK_AUTO_GATE    BIT(16)
+
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
                          TYPE_PCI_SDHCI)
-- 
2.34.1


