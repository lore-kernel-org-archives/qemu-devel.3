Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1392CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsgE-00030J-7A; Wed, 04 Sep 2024 12:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfs-0001Mw-Km
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:16:07 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfp-0002JB-3o
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:16:04 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-533463f6b16so1384163e87.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725466558; x=1726071358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhHuSPxpBNKwAgr3pqcWE8F4qfu6xeqGgbqjKgqrTwo=;
 b=HjpM4fdI9THucjEYxNqoIQBPyLbe/dT5nlfGax4BGBscR4lxzULfn/JtbHNB3m3IzL
 YfrXfz3VyzF7DlJcIYUPPbEaebDqzdMjsph3NO2XIW4iPc1uXpGwECXI+9toGpk0Xh33
 vGZVqW9gibfxWrTkyjXB9Jkfm0FUq0lYfZPsU6mBDUOtlBFcMdLu06mjIZcvaJnW/1Rb
 PsoniwHJ1ddiuv2QRPVLbp95NskV0SlCbWywvOeyJ283DoskAjgcL8JpH6wGdL0iXNhc
 lc+IXLwfFIV1jlK1IPnJL6TjbyjQdYS258SxjO0LjyrzsO7+jLURBfOsMkZ/Q8wQVY3W
 oCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466558; x=1726071358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhHuSPxpBNKwAgr3pqcWE8F4qfu6xeqGgbqjKgqrTwo=;
 b=w5VvcPVWa/+wcHaoj6x3ZPbiiAyc10FDG37XWixSdr9WOrrtv4v1ZMv/NFPNtwtNaJ
 fR236GW1IQtlxSDldzcv397+slZQy156zxqAVfL5WHHDW/5NL60vDqeIz00Kr6DMHOkH
 mtsPVwmJIa6F9tiqMaLtbUCyWzGa+gMmOHGOXspCzuozAmExHIyyTnR0kBTPurW3xXh5
 7klqk4O/VzXbzZsmgcbc446xIqX/ErqpxtPamzmWLXrJbeRT3mhteZ53XXNU/00vMb5Q
 vl6m5HSAjQNiB7NAsrFGEPQpeW/HzQozIHeoeMcCEuZ0Rs8JJKHuyKu7Au7+phu3qE56
 oENg==
X-Gm-Message-State: AOJu0Ywep76egKxR8soqMHO92bhPf4QIZdzcYsqcuytKSpAIJek5dxc4
 pd07IWkbMxsnQIa1Mluhox+n7JqP9YE59wvy/f0ly4/5Ib2taMbvL4/rnAaW
X-Google-Smtp-Source: AGHT+IF1GFmSMfUcd/mUHwagfqt5mpNvfaEt+oYlqwsbk12notXPjCro2OfzhCpiGNq2eIcwaUFOhQ==
X-Received: by 2002:a05:6512:1192:b0:52f:eb:aaca with SMTP id
 2adb3069b0e04-53565f22906mr2195749e87.32.1725466557827; 
 Wed, 04 Sep 2024 09:15:57 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53540841326sm2387308e87.197.2024.09.04.09.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:15:56 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL v1 10/12] hw/xen: pvh-common: Add support for creating PCIe/GPEX
Date: Wed,  4 Sep 2024 18:15:34 +0200
Message-ID: <20240904161537.664189-11-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904161537.664189-1-edgar.iglesias@gmail.com>
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x129.google.com
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
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-pvh-common.c         | 76 +++++++++++++++++++++++++++++++++
 include/hw/xen/xen-pvh-common.h | 29 +++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 295f920442..28d7168446 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -122,6 +122,64 @@ static void xen_enable_tpm(XenPVHMachineState *s)
 }
 #endif
 
+/*
+ * We use the GPEX PCIe controller with its internal INTX PCI interrupt
+ * swizzling. This swizzling is emulated in QEMU and routes all INTX
+ * interrupts from endpoints down to only 4 INTX interrupts.
+ * See include/hw/pci/pci.h : pci_swizzle()
+ */
+static inline void xenpvh_gpex_init(XenPVHMachineState *s,
+                                    XenPVHMachineClass *xpc,
+                                    MemoryRegion *sysmem)
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
+    memory_region_add_subregion(sysmem, s->cfg.pci_ecam.base, ecam_reg);
+
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+
+    if (s->cfg.pci_mmio.size) {
+        memory_region_init_alias(&s->pci.mmio_alias, OBJECT(dev), "pcie-mmio",
+                                 mmio_reg,
+                                 s->cfg.pci_mmio.base, s->cfg.pci_mmio.size);
+        memory_region_add_subregion(sysmem, s->cfg.pci_mmio.base,
+                                    &s->pci.mmio_alias);
+    }
+
+    if (s->cfg.pci_mmio_high.size) {
+        memory_region_init_alias(&s->pci.mmio_high_alias, OBJECT(dev),
+                "pcie-mmio-high",
+                mmio_reg, s->cfg.pci_mmio_high.base, s->cfg.pci_mmio_high.size);
+        memory_region_add_subregion(sysmem, s->cfg.pci_mmio_high.base,
+                &s->pci.mmio_high_alias);
+    }
+
+    /*
+     * PVH implementations with PCI enabled must provide set_pci_intx_irq()
+     * and optionally an implementation of set_pci_link_route().
+     */
+    assert(xpc->set_pci_intx_irq);
+
+    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+        qemu_irq irq = qemu_allocate_irq(xpc->set_pci_intx_irq, s, i);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
+        gpex_set_irq_num(GPEX_HOST(dev), i, s->cfg.pci_intx_irq_base + i);
+        if (xpc->set_pci_link_route) {
+            xpc->set_pci_link_route(i, s->cfg.pci_intx_irq_base + i);
+        }
+    }
+}
+
 static void xen_pvh_init(MachineState *ms)
 {
     XenPVHMachineState *s = XEN_PVH_MACHINE(ms);
@@ -152,6 +210,15 @@ static void xen_pvh_init(MachineState *ms)
     }
 #endif
 
+    /* Non-zero pci-ecam-size enables PCI.  */
+    if (s->cfg.pci_ecam.size) {
+        if (s->cfg.pci_ecam.size != 256 * MiB) {
+            error_report("pci-ecam-size only supports values 0 or 0x10000000");
+            exit(EXIT_FAILURE);
+        }
+        xenpvh_gpex_init(s, xpc, sysmem);
+    }
+
     /* Call the implementation specific init.  */
     if (xpc->init) {
         xpc->init(ms);
@@ -200,6 +267,9 @@ XEN_PVH_PROP_MEMMAP(ram_high)
 /* TPM only has a base-addr option.  */
 XEN_PVH_PROP_MEMMAP_BASE(tpm)
 XEN_PVH_PROP_MEMMAP(virtio_mmio)
+XEN_PVH_PROP_MEMMAP(pci_ecam)
+XEN_PVH_PROP_MEMMAP(pci_mmio)
+XEN_PVH_PROP_MEMMAP(pci_mmio_high)
 
 void xen_pvh_class_setup_common_props(XenPVHMachineClass *xpc)
 {
@@ -242,6 +312,12 @@ do {                                                                      \
         OC_MEMMAP_PROP(oc, "virtio-mmio", virtio_mmio);
     }
 
+    if (xpc->has_pci) {
+        OC_MEMMAP_PROP(oc, "pci-ecam", pci_ecam);
+        OC_MEMMAP_PROP(oc, "pci-mmio", pci_mmio);
+        OC_MEMMAP_PROP(oc, "pci-mmio-high", pci_mmio_high);
+    }
+
 #ifdef CONFIG_TPM
     if (xpc->has_tpm) {
         object_class_property_add(oc, "tpm-base-addr", "uint64_t",
diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
index 77fd98b9fe..bc09eea936 100644
--- a/include/hw/xen/xen-pvh-common.h
+++ b/include/hw/xen/xen-pvh-common.h
@@ -25,10 +25,29 @@ struct XenPVHMachineClass {
     /* PVH implementation specific init.  */
     void (*init)(MachineState *state);
 
+    /*
+     * set_pci_intx_irq - Deliver INTX irqs to the guest.
+     *
+     * @opaque: pointer to XenPVHMachineState.
+     * @irq: IRQ after swizzling, between 0-3.
+     * @level: IRQ level.
+     */
+    void (*set_pci_intx_irq)(void *opaque, int irq, int level);
+
+    /*
+     * set_pci_link_route: - optional implementation call to setup
+     * routing between INTX IRQ (0 - 3) and GSI's.
+     *
+     * @line: line the INTx line (0 => A .. 3 => B)
+     * @irq: GSI
+     */
+    int (*set_pci_link_route)(uint8_t line, uint8_t irq);
+
     /*
      * Each implementation can optionally enable features that it
      * supports and are known to work.
      */
+    bool has_pci;
     bool has_tpm;
     bool has_virtio_mmio;
 };
@@ -44,6 +63,12 @@ struct XenPVHMachineState {
         MemoryRegion high;
     } ram;
 
+    struct {
+        GPEXHost gpex;
+        MemoryRegion mmio_alias;
+        MemoryRegion mmio_high_alias;
+    } pci;
+
     struct {
         MemMapEntry ram_low, ram_high;
         MemMapEntry tpm;
@@ -52,6 +77,10 @@ struct XenPVHMachineState {
         MemMapEntry virtio_mmio;
         uint32_t virtio_mmio_num;
         uint32_t virtio_mmio_irq_base;
+
+        /* PCI */
+        MemMapEntry pci_ecam, pci_mmio, pci_mmio_high;
+        uint32_t pci_intx_irq_base;
     } cfg;
 };
 
-- 
2.43.0


