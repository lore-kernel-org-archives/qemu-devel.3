Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF667C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 13:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdUl2-0004uc-Uj; Mon, 12 Aug 2024 09:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUkx-0004bw-W0
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:06:40 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUks-00047X-2g
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:06:38 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ef2d96164aso46453331fa.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723467990; x=1724072790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsU79nmQ1AQVXUbNSxYwoeBBAkcfnxSMEvBp2lKDwWA=;
 b=C87fvWOXYf04yLU59xfYVHEZw8f14FGvbveQn4em1wZBV59rNuloyXvpIlLi282w/3
 jqVnZ8hTuAgzxte64Yc5hNBGXuPtdJSQN2UvJ2Sk9nB1BJDxEI6ZlZ9xqNTtwnpgtBV3
 W4XY8dM1i0rfZuQ5gHDVVvbHJODrQ6vYSQgyHvru+LQ8r+yQAVF07c9dYUKeCDqBwSel
 UYbNjAz+tCZm+UmNZIgef5tFuhMzueFUV3pegND7O/BsEWQWRmxamfbvCZhyyIwzlWAM
 ojdb9YdMahk2upauCL6Ncl0g4HvsHWMN2FRIFfMNkqb4XfoZlEnjUd3s0p30qBuWybJ4
 il4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723467990; x=1724072790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fsU79nmQ1AQVXUbNSxYwoeBBAkcfnxSMEvBp2lKDwWA=;
 b=WmuQufmz66Pc3jJuiwvIq+Wb1vvSmU8hC6+OnrhPcv0eAUznK9n11SJdGAtoOSrHrj
 b4jqEJgixuAfutJoB6MeqJlZsQIi7/JsP7GLRuzyd/jac1wHLoMvMH63RFu6l8pw1AzW
 k2cCmQoUCVMKySG6cW1UpYNmqH8dLsx1E6x0Zan55JhyK2TBilNvumggWT6PkNiwkg7i
 k/epS13gqJhhF0JP4lRY7g0InWGhXb3SZDMHxKQFqJcEeDnTYtClMk/HFhQ4TlqRYx6z
 buQN4cJTSQD752titje212SyBoPI8eqNbouao6Eg4g0VwuzSvbiq0JtORX0qlpQKgei0
 TKmA==
X-Gm-Message-State: AOJu0YxdKxxBYjT5w/La3oCp8glrBSrgYUBvxtKR/iqi7vX3N1ed8ErF
 17KRJu2cO/r+cybvbwYAC2lHxdsR79XZADMbgOuOHOvLHEiH2lsxn8vJfBLS
X-Google-Smtp-Source: AGHT+IExi6OAtMSH2lj/PgBrg+LlxDZERUpkwQQHEWkaEtSD3XJV0ILUPZ6rtXYIo0sScSOwNbS7/Q==
X-Received: by 2002:a05:6512:6d1:b0:52e:941d:7039 with SMTP id
 2adb3069b0e04-532136a4e69mr29594e87.59.1723467989238; 
 Mon, 12 Aug 2024 06:06:29 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53200f42667sm739978e87.294.2024.08.12.06.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 06:06:28 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v1 08/10] hw/xen: pvh-common: Add support for creating
 PCIe/GPEX
Date: Mon, 12 Aug 2024 15:06:03 +0200
Message-ID: <20240812130606.90410-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812130606.90410-1-edgar.iglesias@gmail.com>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add support for optionally creating a PCIe/GPEX controller.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-pvh-common.c         | 66 +++++++++++++++++++++++++++++++++
 include/hw/xen/xen-pvh-common.h | 10 ++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 69a2dbdb6d..b1432e4bd9 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -120,6 +120,59 @@ static void xen_enable_tpm(XenPVHCommonState *s)
 }
 #endif
 
+static void xen_set_pci_intx_irq(void *opaque, int irq, int level)
+{
+    if (xen_set_pci_intx_level(xen_domid, 0, 0, 0, irq, level)) {
+        error_report("xendevicemodel_set_pci_intx_level failed");
+    }
+}
+
+static inline void xenpvh_gpex_init(XenPVHCommonState *s,
+                                    MemoryRegion *sysmem,
+                                    hwaddr ecam_base, hwaddr ecam_size,
+                                    hwaddr mmio_base, hwaddr mmio_size,
+                                    hwaddr mmio_high_base,
+                                    hwaddr mmio_high_size,
+                                    int intx_irq_base)
+{
+    MemoryRegion *ecam_reg;
+    MemoryRegion *mmio_reg;
+    DeviceState *dev;
+    int i;
+
+    object_initialize_child(OBJECT(s), "gpex", &s->pci.gpex,
+                            TYPE_GPEX_HOST);
+    dev = DEVICE(&s->pci.gpex);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(sysmem, ecam_base, ecam_reg);
+
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+
+    if (mmio_size) {
+        memory_region_init_alias(&s->pci.mmio_alias, OBJECT(dev), "pcie-mmio",
+                                 mmio_reg, mmio_base, mmio_size);
+        memory_region_add_subregion(sysmem, mmio_base, &s->pci.mmio_alias);
+    }
+
+    if (mmio_high_size) {
+        memory_region_init_alias(&s->pci.mmio_high_alias, OBJECT(dev),
+                "pcie-mmio-high",
+                mmio_reg, mmio_high_base, mmio_high_size);
+        memory_region_add_subregion(sysmem, mmio_high_base,
+                &s->pci.mmio_high_alias);
+    }
+
+    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+        qemu_irq irq = qemu_allocate_irq(xen_set_pci_intx_irq, s, i);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
+        gpex_set_irq_num(GPEX_HOST(dev), i, intx_irq_base + i);
+        xen_set_pci_link_route(i, intx_irq_base + i);
+    }
+}
+
 static void xen_pvh_realize(DeviceState *dev, Error **errp)
 {
     XenPVHCommonState *s = XEN_PVH_COMMON(dev);
@@ -152,6 +205,14 @@ static void xen_pvh_realize(DeviceState *dev, Error **errp)
         warn_report("tpm-base-addr is not provided. TPM will not be enabled");
     }
 #endif
+
+    if (s->cfg.ecam.size) {
+        xenpvh_gpex_init(s, sysmem,
+                         s->cfg.ecam.base, s->cfg.ecam.size,
+                         s->cfg.mmio.base, s->cfg.mmio.size,
+                         s->cfg.mmio_high.base, s->cfg.mmio_high.size,
+                         s->cfg.pci_intx_irq_base);
+    }
 }
 
 #define DEFINE_PROP_MEMMAP(n, f) \
@@ -165,10 +226,15 @@ static Property xen_pvh_properties[] = {
     DEFINE_PROP_MEMMAP("ram-high", ram_high),
     DEFINE_PROP_MEMMAP("virtio-mmio", virtio_mmio),
     DEFINE_PROP_MEMMAP("tpm", tpm),
+    DEFINE_PROP_MEMMAP("pci-ecam", ecam),
+    DEFINE_PROP_MEMMAP("pci-mmio", mmio),
+    DEFINE_PROP_MEMMAP("pci-mmio-high", mmio_high),
     DEFINE_PROP_UINT32("virtio-mmio-num", XenPVHCommonState,
                        cfg.virtio_mmio_num, 0),
     DEFINE_PROP_UINT32("virtio-mmio-irq-base", XenPVHCommonState,
                        cfg.virtio_mmio_irq_base, 0),
+    DEFINE_PROP_UINT32("pci-intx-irq-base", XenPVHCommonState,
+                       cfg.pci_intx_irq_base, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
index e958b441fd..faacfca70e 100644
--- a/include/hw/xen/xen-pvh-common.h
+++ b/include/hw/xen/xen-pvh-common.h
@@ -29,17 +29,25 @@ typedef struct XenPVHCommonState {
         MemoryRegion high;
     } ram;
 
+    struct {
+        GPEXHost gpex;
+        MemoryRegion mmio_alias;
+        MemoryRegion mmio_high_alias;
+    } pci;
+
     struct {
         uint64_t ram_size;
         uint32_t max_cpus;
         uint32_t virtio_mmio_num;
         uint32_t virtio_mmio_irq_base;
+        uint32_t pci_intx_irq_base;
         struct {
             uint64_t base;
             uint64_t size;
         } ram_low, ram_high,
           virtio_mmio,
-          tpm;
+          tpm,
+          ecam, mmio, mmio_high;
     } cfg;
 } XenPVHCommonState;
 #endif
-- 
2.43.0


