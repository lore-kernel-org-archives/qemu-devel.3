Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA14C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF7l-00050j-4h; Tue, 04 Feb 2025 04:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7g-0004rt-N8; Tue, 04 Feb 2025 04:21:36 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7e-00054Z-Nv; Tue, 04 Feb 2025 04:21:36 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so4719747f8f.0; 
 Tue, 04 Feb 2025 01:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660892; x=1739265692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cEk32kMD1kZvvQqKH9FRTKkA4gEz+BQ4LOOjQfR3gI=;
 b=B1hpDW1T08jc98aDgR4vEgJmNK8mmNQig9bWf62Dq8Bw+LB7aHl+3sNw0QU54eaC1B
 +f7TmxM9r47382aE/W4UW3J0siyEyF/vmnbQl/IgltOBouszTrIkDwO4in6EmPGuzBx8
 L7JKqilZCv6d87hHRVJ4i+L/zoE9JqlHPnDX26RgPWK1P/yg67PRKw9iqayW1JoxG6Hm
 T8ndMRngqLtYykJ/xiDebbyx7V+VI6kc2+iPTvlRGD3ihhAQByMQmThjsOodzQ/lqiA7
 er0/fbuWXjszxhp8s7aWwzNXL88TmQ988I0wHkK7t90GPD0wU35nfF4FAPrzQ93k1A+5
 Zn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660892; x=1739265692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cEk32kMD1kZvvQqKH9FRTKkA4gEz+BQ4LOOjQfR3gI=;
 b=CmfcAThC3z8D6NdwQBgSgB4nDT8ikKQhwzUykphnRhRkzou03P7Xw8yr9tPK2FVhuI
 5hvwcUjTYhpfBSPYTnWzPt+OfLP6viKMZUYyyJzI0cxnzNr19cr11Scnq3wmthift139
 f1/sHWjV8ZY5hP+QsEL+O4TIBjnoxYjDXX7yKUcREKjsQ3SAYQQZxh4gXMrhlXIMBmxj
 NIXE9Tj+/b7KUYQGQzOArYvk1u8MiKO0rEUPJzk7M18+WSDkA8YlyMtVzmGQSyL0Ur0u
 mnrYPaHXYqsPzNPyMHwvtD7JUcisqXNt9Jd7UgXTLyoGOHJ323GQ1LHCllfOZLa5ToxA
 2BhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4VnRr3E8tJsX0H+84KcsLQpXHjriQOwYNGjbx6LIl8PLiW5mLbRi0LubyISX4kGkhREJ+FSZEuw==@nongnu.org
X-Gm-Message-State: AOJu0YzAZiTmBR/+E9zFCuv88/kmB3qxiY71If6YjIaIzmuD2NR91N5V
 yHl44lYxb3+5/GYezh0hFIMEAbX/9lUP0MCqHeoOuJ0VqX1TfeVXgIkx8Q==
X-Gm-Gg: ASbGncszc8BGVH9HMt+WBzd0QRrZv0aIPKJmVnq/VzZNJF+qAT2dgJBbLPvocaLSvik
 if7pO3GVWpdc6PVke/2g5ATFSWOahB2gX2kZcirymkhTKmKlHtVoMRTCqrNYC3zc/xU1ZeBL/7P
 QterbAqYR9sCjkdMVwN4Ws1GHnbx4AjqBvSlFOPtyysQetnn9Sh9vdDc/g/XqdDTxaBxRjvj0WT
 c3ZOeANiglrqM7PlopGX/3d6O5IkGiAY8yVNSiRhac+nnTEhTLS850cLtnTCe5akZQC5tVVbiQM
 xkoUfpoRJ3okyGMWqHNc1mgbyMs94G8hrM5f18YGZBO0LkR2KhHGapH7HYOj/BkUFE7diIdj1cT
 +lsBGMw8MCw==
X-Google-Smtp-Source: AGHT+IHPHCKOSu0VUjbhXKplBGKk5Fh3hTS4nBxGQAvKaWgAke3LhX7clZg4yeU+L9Cu++jgP7HHow==
X-Received: by 2002:a5d:59a3:0:b0:38c:5d42:152a with SMTP id
 ffacd0b85a97d-38c5d42185bmr17654732f8f.35.1738660891793; 
 Tue, 04 Feb 2025 01:21:31 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:31 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 10/18] hw/arm/fsl-imx8mp: Add I2C controllers
Date: Tue,  4 Feb 2025 10:21:04 +0100
Message-ID: <20250204092112.26957-11-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    | 11 +++++++++++
 hw/arm/fsl-imx8mp.c            | 29 +++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index a89aad6f92..e63c5b7118 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -16,6 +16,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
  * 5 GPIO Controllers
+ * 6 I2C Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 18ea52d083..2590056627 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/i2c/imx_i2c.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
@@ -31,6 +32,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_GPIOS        = 5,
+    FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
     FSL_IMX8MP_NUM_USDHCS       = 3,
@@ -45,6 +47,7 @@ struct FslImx8mpState {
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
+    IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
     DesignwarePCIEHost pcie;
@@ -205,6 +208,11 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_UART5_IRQ    = 30,
     FSL_IMX8MP_UART6_IRQ    = 16,
 
+    FSL_IMX8MP_I2C1_IRQ     = 35,
+    FSL_IMX8MP_I2C2_IRQ     = 36,
+    FSL_IMX8MP_I2C3_IRQ     = 37,
+    FSL_IMX8MP_I2C4_IRQ     = 38,
+
     FSL_IMX8MP_GPIO1_LOW_IRQ  = 64,
     FSL_IMX8MP_GPIO1_HIGH_IRQ = 65,
     FSL_IMX8MP_GPIO2_LOW_IRQ  = 66,
@@ -216,6 +224,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_GPIO5_LOW_IRQ  = 72,
     FSL_IMX8MP_GPIO5_HIGH_IRQ = 73,
 
+    FSL_IMX8MP_I2C5_IRQ     = 76,
+    FSL_IMX8MP_I2C6_IRQ     = 77,
+
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 13910dc44a..1971c76aaa 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -211,6 +211,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
+        snprintf(name, NAME_SIZE, "i2c%d", i + 1);
+        object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
+    }
+
     for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
         snprintf(name, NAME_SIZE, "gpio%d", i + 1);
         object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
@@ -364,6 +369,29 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* I2Cs */
+    for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } i2c_table[FSL_IMX8MP_NUM_I2CS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C1].addr, FSL_IMX8MP_I2C1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C2].addr, FSL_IMX8MP_I2C2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C3].addr, FSL_IMX8MP_I2C3_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C4].addr, FSL_IMX8MP_I2C4_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C5].addr, FSL_IMX8MP_I2C5_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C6].addr, FSL_IMX8MP_I2C6_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
+                           qdev_get_gpio_in(gicdev, i2c_table[i].irq));
+    }
+
     /* GPIOs */
     for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
         static const struct {
@@ -474,6 +502,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
+        case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f1e140a29d..4a8695f22a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -579,11 +579,13 @@ config FSL_IMX7
 
 config FSL_IMX8MP
     bool
+    imply I2C_DEVICES
     imply PCI_DEVICES
     select ARM_GIC
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
+    select IMX_I2C
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
-- 
2.48.1


