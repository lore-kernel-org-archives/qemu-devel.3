Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C7AC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7t9-0004hn-IT; Wed, 12 Aug 2026 08:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t2-0004KT-3a
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t0-0008Vk-32
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso6937215e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537004; x=1787141804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zprv574hMUc1osPTRItRwojX5aCpqSuO6N7TCEXrs0g=;
 b=gucxTZoWBLu8fb1ie/4XuPGq0ZjlyfKuZEak13G+vj6EdW4BW7shsJ8gwpingsNuCd
 bBI5LmpXzmek0mxraDToVW86XcVtgpHaIqYpP4T9zNT2/pOGEfi+DwZj2K2Nbp5gDnEb
 55qdsH0fddZoqLsMfHQ1Rh8x+yR4aehVUJq2Sm3OcKB/plizgRrfKT2T+HCzjjRJxuta
 xhCmAxqrKy7ul9feoU9cnsaEQbD3dpq43vxR/DF1JdXnq1AygibvAbkwOoJ7UqFTN/fR
 ahL48kysvJfJ+S2E0PsK9J5pBthnQwlmqOrDG8463omLwMdvw0qkC55ieLo/4k7OjpWW
 oKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537004; x=1787141804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zprv574hMUc1osPTRItRwojX5aCpqSuO6N7TCEXrs0g=;
 b=jTDDSjuzKIHl2HVG5bZKxlCfwwDwp6nCTg/UGPTqkXkKI06IEx8mrw3AxQEiL7gbaT
 9fEpIOPumcYHeOmYHfXyF6wD93eC0/oEkCBdOSL2hSDT3UxlsmcnZ68/2hORBkBNcng7
 2K9CbZwL8R8AxRuFUYmOfQlTNpHV5KicsPTbh9PKqrJd/wCubmoLBr862kukApPoEyuJ
 w4TGkwiGgrdqhExqeh7rvrX+RSX732BC02CpsYBlD9bxN+7jRfQYfAYoFMTrEGN72oBY
 4C0v1RaYL0jUvvO/aMbZHVpohc/W2rh6Hy/djmXlBDiAsoooql1kaSP4k7RdpJMyeHYf
 d6gA==
X-Gm-Message-State: AOJu0Yx+0ICIoE0Qq76wHtIs7PEpPONRVTe9bP0bThxSpO/1A6A8m3JP
 q6RkGwManF+zT0Zg0poo5h6UTuiqFl+gsKmyVcbAUfmFoRNPxtuj9cx/kvWEYvYCeozvSmDFmf8
 +T3XJ
X-Gm-Gg: AR+sD12MO6c1kUDdROjS9bLKkV+oyWA8IGlyJ6ZyVe0kd5r/vTmBwV+BkmnbjU+EHPy
 cwHIMF/oqg2+K+D/JUEGOnPuLR2Aktz+JlWchEAEr+TR0gcmj1KPZinqr/lmwZtN3Dpq8XtkGhb
 kOdSooSmqGtXlxciXqS+iPWf4wRT6CRdD+KMcB2iIbPDCjvx1boO1Qv5HUA4gYpqAWca/AeQcii
 S+HP1O22E1l/ne3w4RrXUS4wI3dooCwpyKsQzdwoisX9slzZxKnfGjV86w/uVNa8ns8/GzagLGx
 jS4jwSS7YImi5YuS+sEA/lXPEbHsefCbEvxTj//hT0YTIDpITX0PLAjOp+Nlnq4xhQN0AYDgXus
 n8rG4FJt+2xjcQCIMK9oJrn9rrCk8dIl7M5/Lv4L7vCVI+PYjow5dl0IiOh4kl9oGcnVIv662gP
 4h6m7d0iSX1qQ+Ur/W85BHbfuVG3W54Q+9LzSGPG3tFVdUpHMQUPW/E7+2zIwwawOvPFxDKD7Do
 N4rBJa0/I4yxhtTxTzA1l4ZrAwiUw6juMyPjnwFMAML4Fnc9JsOjw1MZe/1uBD80crBSA==
X-Received: by 2002:a7b:cbc5:0:b0:499:7a86:4145 with SMTP id
 5b1f17b1804b1-4997c1461f3mr40483935e9.13.1786537003608; 
 Wed, 12 Aug 2026 05:16:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/26] hw/misc: Add AX3000 clock control
Date: Wed, 12 Aug 2026 13:16:08 +0100
Message-ID: <20260812121622.649730-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
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

From: Kuan-Jui Chiu <kchiu@axiado.com>

This patch adds a new model for Axiado AX3000 clock control which supports
to read ID and status

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Message-id: 20260713073033.3883619-3-kchiu@axiado.com
[PMM: use HWADDR_PRIx]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Kconfig              |  3 ++
 hw/misc/axiado_clk.c         | 79 ++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build          |  3 ++
 include/hw/misc/axiado_clk.h | 26 ++++++++++++
 4 files changed, 111 insertions(+)
 create mode 100644 hw/misc/axiado_clk.c
 create mode 100644 include/hw/misc/axiado_clk.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..b8860dd3e7 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -257,4 +257,7 @@ config XLNX_VERSAL_TRNG
 config XLNX_ZYNQ_DDRC
     bool
 
+config AXIADO_CLK
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/axiado_clk.c b/hw/misc/axiado_clk.c
new file mode 100644
index 0000000000..090beb38b5
--- /dev/null
+++ b/hw/misc/axiado_clk.c
@@ -0,0 +1,79 @@
+/*
+ * Axiado Clock Control
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/axiado_clk.h"
+#include "qemu/log.h"
+
+#define CLKRST_CPU_PLL_POSTDIV_OFFSET   0x0C
+#define CLKRST_CPU_PLL_STS_OFFSET       0x14
+
+static uint64_t pll_read(void *opaque, hwaddr offset, unsigned size)
+{
+    switch (offset) {
+    case CLKRST_CPU_PLL_POSTDIV_OFFSET:
+        return 0x20891b;
+    case CLKRST_CPU_PLL_STS_OFFSET:
+        return 0x01;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "Register 0x%" HWADDR_PRIx " not implemented\n", offset);
+        break;
+    }
+    return 0x00;
+}
+
+static void pll_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "Register 0x%" HWADDR_PRIx " not implemented\n", offset);
+}
+
+static const MemoryRegionOps pll_ops = {
+    .read = pll_read,
+    .write = pll_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
+static void ax3000_clk_init(Object *obj)
+{
+    Ax3000ClkState *s = AX3000_CLK(obj);
+
+    memory_region_init_io(&s->pll_ctrl, obj, &pll_ops, s,
+                          TYPE_AX3000_CLK, AX3000_CLK_PLL_CTRL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->pll_ctrl);
+}
+
+static void ax3000_clk_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Axiado AX3000 Clock Control";
+}
+
+static const TypeInfo ax3000_clk_info = {
+    .parent             = TYPE_SYS_BUS_DEVICE,
+    .name               = TYPE_AX3000_CLK,
+    .instance_size      = sizeof(Ax3000ClkState),
+    .instance_init      = ax3000_clk_init,
+    .class_init         = ax3000_clk_class_init,
+};
+
+static void axiado_clk_register_type(void)
+{
+    type_register_static(&ax3000_clk_info);
+}
+type_init(axiado_clk_register_type);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..e86d9ad6b3 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -1,4 +1,5 @@
 system_ss.add(when: 'CONFIG_APPLESMC', if_true: files('applesmc.c'))
+
 system_ss.add(when: 'CONFIG_EDU', if_true: files('edu.c'))
 system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
@@ -168,3 +169,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
+
+system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
diff --git a/include/hw/misc/axiado_clk.h b/include/hw/misc/axiado_clk.h
new file mode 100644
index 0000000000..6e12a509d7
--- /dev/null
+++ b/include/hw/misc/axiado_clk.h
@@ -0,0 +1,26 @@
+/*
+ * Axiado AX3000 Clock Control
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef AXIADO_AX3000_CLK_H
+#define AXIADO_AX3000_CLK_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_AX3000_CLK "ax3000-clk"
+OBJECT_DECLARE_SIMPLE_TYPE(Ax3000ClkState, AX3000_CLK)
+
+#define AX3000_CLK_PLL_CTRL_SIZE    0x1000
+
+typedef struct Ax3000ClkState {
+    SysBusDevice        parent;
+
+    MemoryRegion        pll_ctrl;
+} Ax3000ClkState;
+
+#endif /* AXIADO_AX3000_CLK_H */
-- 
2.43.0


