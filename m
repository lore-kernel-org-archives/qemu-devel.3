Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDC3CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLAY-0005Eo-Q8; Tue, 04 Nov 2025 12:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9e-0004RR-B9
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:49:20 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9b-0005md-Fj
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:49:13 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b4aed12cea3so1041347966b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762278549; x=1762883349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PVcoZgZLsYK/XnxRN+C/AtxnAFpsEr/gg/xT7dn67wo=;
 b=ZiWiVMWjPBylG4gQ6tU3ym6bQM/jaj33w9iYiJVvB7tTbTmbc6dELt/pWrryfky13/
 2ZOVPdzAe6vYwkVmpbaj+6kTn8IzeFrnYWDjgsYzWIz/pq9WSp76fBflhXp+LB6DWhMF
 /ROFX71m6RpIHkGlfa68E6mie4mNTKhzaO7te0e+rOMlcK2akwHZNM/FncPhZtycC3Li
 QCLQhitEFT3zzQahQifXEJ9PDngx3YmSt6LoUZdGa+Mnn8Cd+/5dDFO2bHSZ45OLjwR1
 jeAYjqW9bUIKC8ZTMzSwDXNvwQVh3/mZQ4fhrj/u5XGt7dNtcxtI8QWnaFEMyvpyGeGx
 blpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762278549; x=1762883349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVcoZgZLsYK/XnxRN+C/AtxnAFpsEr/gg/xT7dn67wo=;
 b=hM7DSFSE7B71UlPw9qBQ7c3xQcnrt8qqCWUetFw/erVg1cUe4uUNLhenSGeAE+zghN
 N0snYOAgAyV5xbCZ0QYif7VnPt/fTPNaiAXuADFVmhsEMu9ywD+TjfVFyo4mBA+F1y7x
 b3yAnaAUf3he+ZGle4bvoPqJAH4bbf7gqHc64GgD5NuRelMQhw3s2aWX6eFvgoSpQKoW
 tyJBMqcl84MFxL0uFFPTjOaL0gZCgVukYo3e7yJ4oRTJoWw+RVbTv0Uvk5C0uBFGiNVe
 Sz/bTjgQx2o1mb9xz6GzVC+y+S2sesfTVE44TSL6mXWTWPEPwUfdXWXDjGjtzWiqFj43
 LrUg==
X-Gm-Message-State: AOJu0Yy4l9YCyG/jQ/FNV2u6+2l1eCOZxzlQMflWKwQJxLSCx5bnV3rA
 qeEZOymhjH0gDaD2MCPOR01NO2V28LSg57EcG/onSPAzkMwWh6TpkYjCN9rbHYCiQo4NC6ssLiL
 hXt2dPkk2WA==
X-Gm-Gg: ASbGnctzCdgzd774FqkAFZjOA9kv4e2+WOZTz1oihzOUvYzOcj/hqy1remREeMdm3n0
 ClTHQQreVY/iLQqsVoprv4RRv2ze3/ko5K+w95ixD1OSrSdBYCAjqPvfaCMKhy+0WErxzz84JjO
 pogLZ4djY7LZIpVmFWBD50fOwnulSxuzkKsndJlogh7aPFFWc6efJvxvKLZNOKIN6tNRvYuwwTz
 NrdkcpZzLOykv5GH3uMfHmVwbHw97KKxI3UaMHxjqqco/gl3KZ3YZUBUzw9Aai2ao2FoAbAyi3a
 sEYu9+1oi2OzJmIEgPiDOGcLlzU72wTKpBAo769VroSw0oLcnIyQqLaikH7KpKkaXXs+mZdqGu5
 vMg8OOX/TJbr8DexsTycrPNOzWnLPHlKKR2eyjmvOINMzUOaaV3alNtkvT7f+wOXaJj1Hnh1tLs
 ozpYMBEGsMbjJ9jGoEuSGTuQ==
X-Google-Smtp-Source: AGHT+IGTtX+DMoX+GrRqC8Ft9Ho9BdvRJh340sE1u9E6ZlSJvrT7fOFV8ksM5buWg5CFwGolzWYTQw==
X-Received: by 2002:a17:907:d92:b0:b70:b324:6eed with SMTP id
 a640c23a62f3a-b7264e12516mr6053366b.0.1762278549257; 
 Tue, 04 Nov 2025 09:49:09 -0800 (PST)
Received: from localhost.localdomain ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d3a2fe7sm287924366b.4.2025.11.04.09.49.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Nov 2025 09:49:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] hw/i386/microvm: Use fdt field from MachineState
Date: Tue,  4 Nov 2025 18:48:22 +0100
Message-ID: <20251104174823.92412-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104174823.92412-1-philmd@linaro.org>
References: <20251104174823.92412-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

From: Luigi Leonardi <leonardi@redhat.com>

MachineState already provides an fdt field, remove it from
MicrovmMachineState and use that instead.

This is useful when using the `dumpdtb` option, as QEMU expects the
device tree to be stored in the MachineState struct, otherwise it
will return this error:

  qemu-system-x86_64: This machine doesn't have an FDT

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251030-fix_microvm-v1-1-f89544a04be3@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/microvm.h |  2 -
 hw/i386/microvm-dt.c      | 96 +++++++++++++++++++++------------------
 2 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index b9ac34a3ef1..e73d1e65de8 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -102,8 +102,6 @@ struct MicrovmMachineState {
     Notifier powerdown_req;
     struct GPEXConfig gpex;
 
-    /* device tree */
-    void *fdt;
     uint32_t ioapic_phandle[2];
 };
 
diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index cb27dfd732e..81eaddafc8b 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -48,6 +48,7 @@ static bool debug;
 static void dt_add_microvm_irq(MicrovmMachineState *mms,
                                const char *nodename, uint32_t irq)
 {
+    MachineState *ms = MACHINE(mms);
     int index = 0;
 
     if (irq >= IO_APIC_SECONDARY_IRQBASE) {
@@ -55,13 +56,14 @@ static void dt_add_microvm_irq(MicrovmMachineState *mms,
         index++;
     }
 
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "interrupt-parent",
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           mms->ioapic_phandle[index]);
-    qemu_fdt_setprop_cells(mms->fdt, nodename, "interrupts", irq, 0);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0);
 }
 
 static void dt_add_virtio(MicrovmMachineState *mms, VirtIOMMIOProxy *mmio)
 {
+    MachineState *ms = MACHINE(mms);
     SysBusDevice *dev = SYS_BUS_DEVICE(mmio);
     VirtioBusState *mmio_virtio_bus = &mmio->bus;
     BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
@@ -77,10 +79,10 @@ static void dt_add_virtio(MicrovmMachineState *mms, VirtIOMMIOProxy *mmio)
     uint32_t irq = mms->virtio_irq_base + index;
 
     nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop_string(mms->fdt, nodename, "compatible", "virtio,mmio");
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg", 2, base, 2, size);
-    qemu_fdt_setprop(mms->fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "virtio,mmio");
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
     dt_add_microvm_irq(mms, nodename, irq);
     g_free(nodename);
 }
@@ -88,40 +90,42 @@ static void dt_add_virtio(MicrovmMachineState *mms, VirtIOMMIOProxy *mmio)
 static void dt_add_xhci(MicrovmMachineState *mms)
 {
     const char compat[] = "generic-xhci";
+    MachineState *ms = MACHINE(mms);
     uint32_t irq = MICROVM_XHCI_IRQ;
     hwaddr base = MICROVM_XHCI_BASE;
     hwaddr size = XHCI_LEN_REGS;
     char *nodename;
 
     nodename = g_strdup_printf("/usb@%" PRIx64, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop(mms->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg", 2, base, 2, size);
-    qemu_fdt_setprop(mms->fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
     dt_add_microvm_irq(mms, nodename, irq);
     g_free(nodename);
 }
 
 static void dt_add_pcie(MicrovmMachineState *mms)
 {
+    MachineState *ms = MACHINE(mms);
     hwaddr base = PCIE_MMIO_BASE;
     int nr_pcie_buses;
     char *nodename;
 
     nodename = g_strdup_printf("/pcie@%" PRIx64, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop_string(mms->fdt, nodename,
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename,
                             "compatible", "pci-host-ecam-generic");
-    qemu_fdt_setprop_string(mms->fdt, nodename, "device_type", "pci");
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "#address-cells", 3);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "#size-cells", 2);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "linux,pci-domain", 0);
-    qemu_fdt_setprop(mms->fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "pci");
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 3);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#size-cells", 2);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "linux,pci-domain", 0);
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
 
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg",
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, PCIE_ECAM_BASE, 2, PCIE_ECAM_SIZE);
     if (mms->gpex.mmio64.size) {
-        qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "ranges",
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "ranges",
 
                                      1, FDT_PCI_RANGE_MMIO,
                                      2, mms->gpex.mmio32.base,
@@ -133,7 +137,7 @@ static void dt_add_pcie(MicrovmMachineState *mms)
                                      2, mms->gpex.mmio64.base,
                                      2, mms->gpex.mmio64.size);
     } else {
-        qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "ranges",
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "ranges",
 
                                      1, FDT_PCI_RANGE_MMIO,
                                      2, mms->gpex.mmio32.base,
@@ -142,7 +146,7 @@ static void dt_add_pcie(MicrovmMachineState *mms)
     }
 
     nr_pcie_buses = PCIE_ECAM_SIZE / PCIE_MMCFG_SIZE_MIN;
-    qemu_fdt_setprop_cells(mms->fdt, nodename, "bus-range", 0,
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "bus-range", 0,
                            nr_pcie_buses - 1);
 
     g_free(nodename);
@@ -150,6 +154,7 @@ static void dt_add_pcie(MicrovmMachineState *mms)
 
 static void dt_add_ioapic(MicrovmMachineState *mms, SysBusDevice *dev)
 {
+    MachineState *ms = MACHINE(mms);
     hwaddr base = dev->mmio[0].addr;
     char *nodename;
     uint32_t ph;
@@ -168,18 +173,18 @@ static void dt_add_ioapic(MicrovmMachineState *mms, SysBusDevice *dev)
     }
 
     nodename = g_strdup_printf("/ioapic%d@%" PRIx64, index + 1, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop_string(mms->fdt, nodename,
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename,
                             "compatible", "intel,ce4100-ioapic");
-    qemu_fdt_setprop(mms->fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "#interrupt-cells", 0x2);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "#address-cells", 0x2);
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg",
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 0x2);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 0x2);
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base, 2, 0x1000);
 
-    ph = qemu_fdt_alloc_phandle(mms->fdt);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "phandle", ph);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "linux,phandle", ph);
+    ph = qemu_fdt_alloc_phandle(ms->fdt);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", ph);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "linux,phandle", ph);
     mms->ioapic_phandle[index] = ph;
 
     g_free(nodename);
@@ -190,17 +195,18 @@ static void dt_add_isa_serial(MicrovmMachineState *mms, ISADevice *dev)
     const char compat[] = "ns16550";
     uint32_t irq = object_property_get_int(OBJECT(dev), "irq", &error_fatal);
     hwaddr base = object_property_get_int(OBJECT(dev), "iobase", &error_fatal);
+    MachineState *ms = MACHINE(mms);
     hwaddr size = 8;
     char *nodename;
 
     nodename = g_strdup_printf("/serial@%" PRIx64, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop(mms->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
     dt_add_microvm_irq(mms, nodename, irq);
 
     if (base == 0x3f8 /* com1 */) {
-        qemu_fdt_setprop_string(mms->fdt, "/chosen", "stdout-path", nodename);
+        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
     }
 
     g_free(nodename);
@@ -211,13 +217,14 @@ static void dt_add_isa_rtc(MicrovmMachineState *mms, ISADevice *dev)
     const char compat[] = "motorola,mc146818";
     uint32_t irq = object_property_get_uint(OBJECT(dev), "irq", &error_fatal);
     hwaddr base = object_property_get_uint(OBJECT(dev), "iobase", &error_fatal);
+    MachineState *ms = MACHINE(mms);
     hwaddr size = 8;
     char *nodename;
 
     nodename = g_strdup_printf("/rtc@%" PRIx64, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop(mms->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
     dt_add_microvm_irq(mms, nodename, irq);
     g_free(nodename);
 }
@@ -317,27 +324,28 @@ static void dt_setup_sys_bus(MicrovmMachineState *mms)
 void dt_setup_microvm(MicrovmMachineState *mms)
 {
     X86MachineState *x86ms = X86_MACHINE(mms);
+    MachineState *ms = MACHINE(mms);
     int size = 0;
 
-    mms->fdt = create_device_tree(&size);
+    ms->fdt = create_device_tree(&size);
 
     /* root node */
-    qemu_fdt_setprop_string(mms->fdt, "/", "compatible", "linux,microvm");
-    qemu_fdt_setprop_cell(mms->fdt, "/", "#address-cells", 0x2);
-    qemu_fdt_setprop_cell(mms->fdt, "/", "#size-cells", 0x2);
+    qemu_fdt_setprop_string(ms->fdt, "/", "compatible", "linux,microvm");
+    qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
 
-    qemu_fdt_add_subnode(mms->fdt, "/chosen");
+    qemu_fdt_add_subnode(ms->fdt, "/chosen");
     dt_setup_sys_bus(mms);
 
     /* add to fw_cfg */
     if (debug) {
         fprintf(stderr, "%s: add etc/fdt to fw_cfg\n", __func__);
     }
-    fw_cfg_add_file(x86ms->fw_cfg, "etc/fdt", mms->fdt, size);
+    fw_cfg_add_file(x86ms->fw_cfg, "etc/fdt", ms->fdt, size);
 
     if (debug) {
         fprintf(stderr, "%s: writing microvm.fdt\n", __func__);
-        if (!g_file_set_contents("microvm.fdt", mms->fdt, size, NULL)) {
+        if (!g_file_set_contents("microvm.fdt", ms->fdt, size, NULL)) {
             fprintf(stderr, "%s: writing microvm.fdt failed\n", __func__);
             return;
         }
-- 
2.51.0


