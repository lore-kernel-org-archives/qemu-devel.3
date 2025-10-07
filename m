Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2695FCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68QM-0005nH-5U; Tue, 07 Oct 2025 10:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QE-0005jy-FW
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q1-0002Bp-44
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so59801225e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846310; x=1760451110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Jd0jT3nIxt2CYcjtDILkFxdvizj09Viqz+9IpRV+fI=;
 b=Uh5qpF6rJbWVpmbFCb4zBOgenXegqXHXZUnBluGz1dkzpqCgAe9i/fE/ezPXXR2iYu
 L9zYIzfPsoKAm1I9VUqt5cQVxZoo9LpCL5Gl1eWRomKdBuSJdFc2+KJYViZNnvSy7prP
 /3/60jWxI/8eCu6C4QwEMmhAV4XjcNxSr+orAUVbH7sfJNJStcWOohYrnP++j0Y+GwOe
 sPTslC0e3L1mclLlW61ue91oicBfMyCQWVNNOwOHG/3qn4WdhPvr7cypkxMLKG9bpq7L
 YsPM2K6mmsJo0F78f0l/M0vowrGwUG/ZXyWLPSU/HKyMRXKDuwCO4BRWIn3nA0MZeW9R
 9uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846310; x=1760451110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Jd0jT3nIxt2CYcjtDILkFxdvizj09Viqz+9IpRV+fI=;
 b=YAa1eIDOUwzZ8NYx3IHG67dcEPP3qWlV2MZ2u1TzKFMzfO8QpIU1MmWFi88h+3tJWr
 DbborRdPZRia34FRTH29/8SblSNGksPmcMMKabscexV6j+B4tsYIu23ZfAXvz2sSOkEV
 X7fAE/HtgpyzLObu4+WqpA20gI+t6q0VJ1ByXjMjhe6a46bdhIt6t1b4ZxYhqHAtTQL7
 HDVe5I/ql0ZuHX6V/o1vshiFv+/jvtejoNl6DOXa/kJiNifvgRh1HvxMCcuxHgjgnZUh
 alskvR1u4FD2TF7MunFDOxu7EU1cvqWe3bFs4cODNSvW30Rmxb/j+apHgzw5h1O8iM4P
 GWCQ==
X-Gm-Message-State: AOJu0YzPBaSdsyR2Wnz9AI58xkbGyersT+euDgGAfVHDDlCRcmdGut80
 ACQy/78bQ564h4VqRHf516Kj2tNRlJc9asC7N/3fHGVmvvQuFJWu9IKwRm+MHqMZ/aOaTZ3qxlR
 usuAn
X-Gm-Gg: ASbGncvLF2l/t97bIbPnlOYcAkcEQZoHl4Gwjmf3K20ACu2x//n5s2WNgdRoG0co2si
 21t+gh4cG5km5VbsNlqA5BmQ1hHvRH4+VWPDNlwm8HVXpQRq2hTAAFIyudrm7u2ME0GGRI37c63
 dGTRmIxuK/iIcQ9+vwqhQ2+ASrfFxOFGXJIhpOn4rRIJv6xMeGNVmpfO080fKDbVPDWVzp8BoV9
 bK+NcyYFe4dJNdkQyVDv8iUhIkl+pPCS9pU+Tnvi/qDGA9pKQRbgDKaltR6+Sys/iD0ohLc6MoK
 Hxsz13eE39+kESOoHBRlC86VIV+sD4QnBFgyDz2x4+2jlx2tMkmUfCtJK8fBe24kqkfV8tVbFOf
 ZwHlWCGdPol+ahJWrnEuZVwSnq65Z8emgBQYTTvyqfupWE7NV1frzbrz1R8jJ7SZIl/8=
X-Google-Smtp-Source: AGHT+IGB65rO96F6tCRS3n6MDiCRL5/AuaAIHuWmD1JovJ6FiHR210RwKifZr2/hwmNZ4dZmSU7x9g==
X-Received: by 2002:a05:600c:450e:b0:46e:35eb:43a with SMTP id
 5b1f17b1804b1-46e7110c336mr122128425e9.15.1759846309771; 
 Tue, 07 Oct 2025 07:11:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/62] hw/arm/xlnx-versal: instantiate the GIC ITS in the APU
Date: Tue,  7 Oct 2025 15:10:43 +0100
Message-ID: <20251007141123.3239867-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Luc Michel <luc.michel@amd.com>

Add the instance of the GIC ITS in the APU.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-23-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index ccb78fadd7f..e03411bc212 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -44,6 +44,7 @@
 #include "hw/or-irq.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/intc/arm_gicv3_its_common.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -72,7 +73,9 @@ typedef struct VersalGicMap {
     int version;
     uint64_t dist;
     uint64_t redist;
+    uint64_t its;
     size_t num_irq;
+    bool has_its;
 } VersalGicMap;
 
 enum StartPoweredOffMode {
@@ -215,6 +218,8 @@ static const VersalMap VERSAL_MAP = {
             .dist = 0xf9000000,
             .redist = 0xf9080000,
             .num_irq = 192,
+            .has_its = true,
+            .its = 0xf9020000,
         },
     },
 
@@ -451,6 +456,48 @@ static MemoryRegion *create_cpu_mr(Versal *s, DeviceState *cluster,
     return mr;
 }
 
+static void versal_create_gic_its(Versal *s,
+                                  const VersalCpuClusterMap *map,
+                                  DeviceState *gic,
+                                  MemoryRegion *mr,
+                                  char *gic_node)
+{
+    DeviceState *dev;
+    SysBusDevice *sbd;
+    g_autofree char *node_pat = NULL, *node = NULL;
+    const char compatible[] = "arm,gic-v3-its";
+
+    if (!map->gic.has_its) {
+        return;
+    }
+
+    dev = qdev_new(TYPE_ARM_GICV3_ITS);
+    sbd = SYS_BUS_DEVICE(dev);
+
+    object_property_add_child(OBJECT(gic), "its", OBJECT(dev));
+    object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(gic),
+                             &error_abort);
+
+    sysbus_realize_and_unref(sbd, &error_abort);
+
+    memory_region_add_subregion(mr, map->gic.its,
+                                sysbus_mmio_get_region(sbd, 0));
+
+    if (!map->dtb_expose) {
+        return;
+    }
+
+    qemu_fdt_setprop(s->cfg.fdt, gic_node, "ranges", NULL, 0);
+    qemu_fdt_setprop_cell(s->cfg.fdt, gic_node, "#address-cells", 2);
+    qemu_fdt_setprop_cell(s->cfg.fdt, gic_node, "#size-cells", 2);
+
+    node_pat = g_strdup_printf("%s/its", gic_node);
+    node = versal_fdt_add_simple_subnode(s, node_pat, map->gic.its, 0x20000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop(s->cfg.fdt, node, "msi-controller", NULL, 0);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "#msi-cells", 1);
+}
+
 static DeviceState *versal_create_gic(Versal *s,
                                       const VersalCpuClusterMap *map,
                                       MemoryRegion *mr,
@@ -476,6 +523,7 @@ static DeviceState *versal_create_gic(Versal *s,
     qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
 
     qdev_prop_set_bit(dev, "has-security-extensions", true);
+    qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
     object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
 
     sysbus_realize_and_unref(sbd, &error_fatal);
@@ -501,6 +549,8 @@ static DeviceState *versal_create_gic(Versal *s,
         qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
 
+    versal_create_gic_its(s, map, dev, mr, node);
+
     return dev;
 }
 
-- 
2.43.0


