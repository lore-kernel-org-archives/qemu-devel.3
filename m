Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F1BFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLOG-0008Mm-BN; Mon, 27 Apr 2026 08:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNL-0007lF-8C
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNI-0005RA-KM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso74975685e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294063; x=1777898863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ghI8DYvTSL+/rSM2e8e78x9QvBfh+Z450FrfGt1c51A=;
 b=WRVZjrrSXHuMQuAuA8vi58MReJUCZbOA5MUnnD/9CBbd6Pi+QTKsbVZaGaxqiOWLi0
 HdSMKAXHjt1DYElZAFmpQdVv/RHQMBfqBZy8+rKuJ47XFGrDsoPdmkuCRoDQBiDzW3+0
 p4c+/eCJtpTPqIe5DiuH3jOkLtpTNBVoZRnKnvG2f1ooYTItW/kRpoGdum8i0JcGPcYA
 4F/Mr1RtfeKgQ2TQhfxGAENP4hvFre0sdopFsS1wMeDzwHvpQKrWUwFku/QJhkDpB3KZ
 6D5ct5bC4WOND4sSWpB21WzjhPxkf9GHm/IqurkrhX+n1EuroPlBik3aQov76dIIsI6w
 3eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294063; x=1777898863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ghI8DYvTSL+/rSM2e8e78x9QvBfh+Z450FrfGt1c51A=;
 b=Lc/eSftTBT9KTRNGIkE7tEdgsPqRAcxrQ4bgdkQpmCVavdB3GhDqbyMKJ/qbQRZoed
 G1DetAGRduDzI9dsGHT0U2rqN9HxpStJHHDzkYnrJJY6fScdfjKexiuxHZpWItV9yFPM
 Wcw4qkq1nqhOQsbaU/LuP1jvnplPoA266pq0HzWvy25bEHJStAgHUuIZFAxKR5Y+cTNp
 BGQ2ZfyT9fKXX44/ONAwA0r/e/XB/rXfVI85lH3sC1wVOAReq1Dz7ZBHBJWpS5jvQ3Oj
 nP/C72KsiFi4uF5fQ6L+99IwpGLJuW5Fm4A9CybU6m2VCpfowojL0EBBSY4LJa9T5uU7
 gleQ==
X-Gm-Message-State: AOJu0YzlpIrjetTaQOOMqisCA1+h87M1uA6j15H+FEVRaoLrXgSZ03/1
 PZfvJEycwYs3wWeckaIvc3Z6fgQoI1/y0VUG//NyvNXDQzWAXrdSq3vRjy3cBN4rd+UER/wbFt6
 KOxi8
X-Gm-Gg: AeBDies+FWuH8jRN8MVJ/ILki03Ft56V675N0cgI/HvL4BU3SdyhYK31Gi9NKqP0jig
 82jYQNMXEV/Rzmctzpwo5J3JKQspn47eKpcgI32FT+QhWotRATWSfbIGxiGLeY6jMKtsTBnE8ZO
 8/wsIffDOhk0ONxcyAw7f/sRMP3LAbsg8xO8GtcJDkt/ir8MC1MnPb3pokHYcpwctu3OSMMhxmq
 VWuhA5t3QVwWaEHe0vpM2JE1PP/Me896aLzs3ys5jUdkb/SyPS5lfjw17wDCpGIFWROmekIPUrS
 n7FJQjVjSQ8d9QSzdf4n1yYR1ioziZB2Z/G3N+fFSVoUIybw3sgpztfjG957+6HvpUkMLBdACj/
 4ZXK5+geG7LFd9p3MSXTi4c1MLypgTm4hoP+Sa3eqN+z+VrByKuo0F4l4Y+6ZgVrQ7P7fJ1YfuU
 0ZwThRBn0GOmbPvYExQuY9qZFFmHN/bq3fVVC5kw3XecmtlcEASbfuU/lWAYWsJF3RklkoQ6xfa
 T/0sgx0ipJ7Wu32wRqperq0uuJnQ4YhgnwWoJ6HOZtDhGb4JHew
X-Received: by 2002:a05:600c:4e4c:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-48a58ae9f69mr414383445e9.19.1777294062868; 
 Mon, 27 Apr 2026 05:47:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/63] hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
Date: Mon, 27 Apr 2026 13:46:38 +0100
Message-ID: <20260427124738.966578-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Add the Analog IP to i.MX8MM SoC. iMX8MM and i.MX8MP uses
the same Analog IP so the analog ip source will be shared.

The ARM PLL divider control register (arm-pll-fdiv-ctl0) has
a different reset value on i.MX8MM (0x000fa030) compared to
i.MX8MP (0x000fa031). So iMX8MM will be overriding this property
with its own reset-value.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx8mm.c         | 12 ++++++++++++
 include/hw/arm/fsl-imx8mm.h |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 86f4d9bc4d..b3db2d6848 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -620,6 +620,7 @@ config FSL_IMX8MP_EVK
 config FSL_IMX8MM
     bool
     select ARM_GIC
+    select FSL_IMX8MP_ANALOG
     select IMX
 
 config FSL_IMX8MM_EVK
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 23a82613d7..8218448074 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -169,6 +169,8 @@ static void fsl_imx8mm_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
+    object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALOG);
+
     for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -303,6 +305,15 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* Analog */
+    object_property_set_uint(OBJECT(&s->analog), "arm-pll-fdiv-ctl0-reset",
+                            0x000fa030, &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->analog), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->analog), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_ANA_PLL].addr);
+
     /* UARTs */
     for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
         static const struct {
@@ -338,6 +349,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
         switch (i) {
+        case FSL_IMX8MM_ANA_PLL:
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_RAM:
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 2811e809b9..0a020c32a1 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -13,6 +13,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx8mp_analog.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -33,6 +34,7 @@ struct FslImx8mmState {
 
     ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
     GICv3State         gic;
+    IMX8MPAnalogState  analog;
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     MemoryRegion ocram;
 };
-- 
2.43.0


