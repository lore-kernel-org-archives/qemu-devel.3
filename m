Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8780BC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnRAA-00051o-E9; Fri, 24 Jul 2026 21:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnRA8-00050Z-CI
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 21:26:48 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnRA6-0006GL-ND
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 21:26:48 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-73791ee3612so459241137.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784942806; x=1785547606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sv4Do54efz6CSaj7wJa92SFTaZ0J6tHEWKHA9fHHKzQ=;
 b=DWnarfuaoebzeDcj/v1UPHmpoKg77FxRx2c/6tv9ieTubF3cF8yy88gir9o6KYX3Tg
 IEciQGJ+cdqcDtG9dUg0U2tuwTs4cpXV/sa+EHPlLJNftTSKfUC30iHFMlX7JhwtwkTT
 NREvb4dHcSexx1NbJaecCvnBnC5JKh5YHMaf4fVUqc5X8Md6vC5ezdcX7SH7EgxJzwSZ
 45dbVybIyAuu6RYP8qtLVuNNabOhOpzjkF1EMgXi7oQpks/J6dfvOeKyCcF+ziyMYAaj
 rM8kfa6gCRu4Zy2BbSi/oY9tfOrCZ88aYS3Ad8gWVAFM4DX0A1JS+zJ8ero1sH9A4zeW
 X+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784942806; x=1785547606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sv4Do54efz6CSaj7wJa92SFTaZ0J6tHEWKHA9fHHKzQ=;
 b=pw0jzC3r4QDODX5oAj3Ftashyux6FGYdAGmJY2PjnMGHQfuP1VMLPBkgpcbNohv/E0
 dA4UI3TbI4D7CCNWXSnpTZR5PFbYomNwuNqfAm5Iz1o1RQl4FQznsqrxekUBalLS1FIY
 JykYdhQBmluZyQ0C6iOavTIvHEZJYT46pXAUU5CLCbnMHIBobbzYsDfEQhMPmSVqrgx8
 RhTad7pFr00qRkDG/DrQ4Qqv5YL/FVsF9GgmKLbxIo6tLyHH4ZBS4emBVcAUweCX9rlU
 AmsXpEzzXQg6qRMEXcF28gFKGoLKdXV3mk4DZaaAPCguL75rJ3fnQJeGk1njxa0nvYeh
 7hew==
X-Gm-Message-State: AOJu0YwxhM6S0nVnTHWRCKY1RtLfpgJ5yn/Bt3HvhSNff6Im8BcHuW+Z
 ATCNq0rtAQBsW7uQ+J8AgZBHadvNL6uRR29/+1gAznjjXrffPLqZQcmpG12lLRpk
X-Gm-Gg: AR+sD12xhKEDZjo7sfn5uMF3t+RDHVbUAbALrPXRZs481iMR6WKYk2uU4Ur3cHGlnET
 ec7TpaYlMONZJutw6BJWjzeifq0US8/irjVHqeJ6tBiw1BqMp5uozon6iSZF29DVh0VelUJ1tas
 TQgKaBEq/ZYRzIHh8j0gSDbkY/vl5r2KnqebMYqXy963qjl4KTHad331JF5LHp9FWLMXsv6FSDp
 PAXW8ZMPUq3jijTeGYWvNc1hKZGV61a9tDf6Yt6Id9qks5aVo0DYLMeAijHsA2u/UmGgnuwN/jU
 qti8WcbXnDL78DXoESr4ths0QHsc6EGIQhlWA2OJD8HhJ56punhLGzbgD42f7bvWz2k8F1M7XSj
 AcSNCubB+jI/GNlJwj/7tT9mLcl8kpX0832nnlhai4QGp4GUA59fP5xR01mjRcQIUZXrn27VBs7
 LCvURTpDiymnnSwPiJlZv57nmGCNPs9aS6
X-Received: by 2002:a05:6102:94f:b0:726:cd42:d039 with SMTP id
 ada2fe7eead31-750409bda93mr694912137.24.1784942805732; 
 Fri, 24 Jul 2026 18:26:45 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774c388d7sm1092856241.1.2026.07.24.18.26.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 18:26:44 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 4/5] hw/arm/bcm2838: enable BCM2838 thermal sensor
Date: Fri, 24 Jul 2026 21:26:34 -0400
Message-ID: <20260725012635.4925-5-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725012635.4925-1-marcelomanzo@gmail.com>
References: <20260725012635.4925-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vs1-xe36.google.com
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

Wire the BCM2838 thermal sensor (added in the previous patch) into
the SoC: instantiate it in the peripherals block and map its
register region at the real BCM2711 physical address.

This is also the last device masked out of the raspi4b DTB, so drop
the "brcm,bcm2711-thermal" node-removal entry -- and with it the
whole nodes_to_remove[] mechanism in raspi4_modify_dtb(), which is
now empty (GENET, PCIe, RNG200, and this thermal sensor were the
only four devices it ever masked, and all four are now implemented).

Adapted from patch 17/41 of Sergey Kambalin's Raspberry Pi 4B series
(patchwork series 829638) against current QEMU master.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/arm/bcm2838_peripherals.c         | 11 +++++++++++
 hw/arm/raspi4b.c                     | 18 ------------------
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 7c202b00..c268fffd 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -43,6 +43,9 @@ static void bcm2838_peripherals_init(Object *obj)
     /* Random Number Generator */
     object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
 
+    /* Thermal */
+    object_initialize_child(obj, "thermal", &s->thermal, TYPE_BCM2838_THERMAL);
+
     /* PCIe Host Bridge */
     object_initialize_child(obj, "pcie-host", &s->pcie_host,
                             TYPE_BCM2838_PCIE_HOST);
@@ -87,6 +90,7 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     MemoryRegion *mmio_mr;
     MemoryRegion *rng200_mr;
     qemu_irq rng_200_irq;
+    MemoryRegion *thermal_mr;
     int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
@@ -111,6 +115,13 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                                          BCM2835_IC_GPU_IRQ, INTERRUPT_RNG);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0, rng_200_irq);
 
+    /* THERMAL */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), errp)) {
+        return;
+    }
+    thermal_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0);
+    memory_region_add_subregion(&s->peri_low_mr, 0x15D2000, thermal_mr);
+
     /* Extended Mass Media Controller 2 */
     object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
                              &error_abort);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 1c063a1c..b92840e1 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -62,24 +62,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 {
     uint64_t ram_size;
 
-    /* Temporarily disable following devices until they are implemented */
-    const char *nodes_to_remove[] = {
-        "brcm,bcm2711-thermal",
-    };
-
-    for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
-        const char *dev_str = nodes_to_remove[i];
-        int offset;
-
-        offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
-        while (offset >= 0) {
-            if (fdt_nop_node(fdt, offset) == 0) {
-                warn_report("bcm2711 dtb: %s has been disabled!", dev_str);
-            }
-            offset = fdt_node_offset_by_compatible(fdt, offset, dev_str);
-        }
-    }
-
     ram_size = board_ram_size(info->board_id);
 
     if (info->ram_size > UPPER_RAM_BASE) {
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 52eabf67..49ca780b 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -11,6 +11,7 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/misc/bcm2838_rng200.h"
+#include "hw/misc/bcm2838_thermal.h"
 #include "hw/arm/bcm2838_pcie.h"
 #include "hw/net/bcm2838_genet.h"
 #include "hw/sd/sdhci.h"
@@ -70,6 +71,7 @@ struct BCM2838PeripheralState {
     MemoryRegion mphi_mr_alias;
 
     BCM2838Rng200State rng200;
+    Bcm2838ThermalState thermal;
     SDHCIState emmc2;
     BCM2838PcieHostState pcie_host;
     BCM2838GenetState genet;
-- 
2.47.1


