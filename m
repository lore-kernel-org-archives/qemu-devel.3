Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FB9C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvbB-0000iP-DF; Fri, 02 Feb 2024 10:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb5-0000NX-HA
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb1-0004WR-KD
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:55 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e800461baso19228755e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888210; x=1707493010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=amHR5O3giydBqIG5HDDnvSZQyLiZ0je93DEkkg1t/tA=;
 b=w8ju74AHvXW50ncEU+Cdawd3Yvn7JL/sTcsaoYjb+jIOAnxXNFuWejBR37BFhYDR4c
 0gWo0LXPYp2nnJ5eYSz6anIqlH+0SW5O9LAe5uD++2M/L4WSjccQkPdQB87teKcEKFJI
 OKhjrGFj4tA4vRNK725+nuDfKn/xrwGdmXEqGrEaVQQJimRVhDrZudBxBB5yA7PM3m18
 Th2BF4uBSr6shL8b98p9UIKVbhH8Dub2HYDlT9xJxF5Rg0BcR+Q8d1rEWztIA0X9JV6u
 tmx4ro9+0MMaZlcqEUIRO2MJuKJw1ZgfY2MrnyccNgt4174LWkLEPzHTnH+x+owQgoCV
 2eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888210; x=1707493010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amHR5O3giydBqIG5HDDnvSZQyLiZ0je93DEkkg1t/tA=;
 b=l13rMCfZApHvCkILBwJ+nHJdfdEo71gSyPiTjz3/OMpcjV6vaZi/o1RDHASgKh+sRx
 dgcNtwEDmkUHgXPaPr9HIkGx0aC9lIpiXPOo6gPBRfi3m5YSfWc88QfZeOpNVMglGj+K
 dfAlIxxzes6ptVeDdgeBxo+Y6w2IW3AhWnWDe9vZ4lUAUMc84pEU+x87c881t6NJ7p0t
 7JBFVscQgeJQmpQvoZPIBaUR0BEXoISbZzIz7POuEz+8k1iD/qVp4CEBmQYYwfjmU82J
 qItXRUu1DYQmmmnKetFt82En3S5l5VUNdSx3h6XF5RQcPSLvXjtDT51Nc0ckGRhAl0O+
 zJug==
X-Gm-Message-State: AOJu0Yz/4F1a8EMiFEzs6OMAG4unk8GTdGxTNrnq5T1ySs1Ag+5MlZFP
 KxP+Hu3JuS3EFz19T2GRvFYiDWBN7PiKnXXDyzWYI5rENlXl1Ah0eYOMODnL1EHvynLV0LAqYhU
 d
X-Google-Smtp-Source: AGHT+IH7ytEEMSxthew7rK8gwnndRuqrW3Ez/AXnyQzL2TzsMcUq06kHyT0HOQUwcN65gnTcbTc2tA==
X-Received: by 2002:a05:600c:3594:b0:40f:b691:d374 with SMTP id
 p20-20020a05600c359400b0040fb691d374mr5828583wmq.17.1706888210244; 
 Fri, 02 Feb 2024 07:36:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/36] hw/arm/xen_arm.c: convert DPRINTF to trace events and
 error/warn reports
Date: Fri,  2 Feb 2024 15:36:26 +0000
Message-Id: <20240202153637.3710444-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Tracing DPRINTFs to stderr might not be desired. A developer that relies
on trace events should be able to opt-in to each trace event and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into trace events. Errors or warnings are converted to error_report and
warn_report calls.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: fe5e3bd54231abe933f95a24e0e88208cd8cfd8f.1706544115.git.manos.pitsidianakis@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xen_arm.c    | 23 +++++++++++------------
 hw/arm/trace-events |  5 +++++
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index a5631529d09..32776d94dfe 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -34,6 +34,7 @@
 #include "hw/xen/xen-hvm-common.h"
 #include "sysemu/tpm.h"
 #include "hw/xen/arch_hvm.h"
+#include "trace.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 OBJECT_DECLARE_SIMPLE_TYPE(XenArmState, XEN_ARM)
@@ -91,8 +92,9 @@ static void xen_create_virtio_mmio_devices(XenArmState *xam)
 
         sysbus_create_simple("virtio-mmio", base, irq);
 
-        DPRINTF("Created virtio-mmio device %d: irq %d base 0x%lx\n",
-                i, GUEST_VIRTIO_MMIO_SPI_FIRST + i, base);
+        trace_xen_create_virtio_mmio_devices(i,
+                                             GUEST_VIRTIO_MMIO_SPI_FIRST + i,
+                                             base);
     }
 }
 
@@ -101,6 +103,7 @@ static void xen_init_ram(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     ram_addr_t block_len, ram_size[GUEST_RAM_BANKS];
 
+    trace_xen_init_ram(machine->ram_size);
     if (machine->ram_size <= GUEST_RAM0_SIZE) {
         ram_size[0] = machine->ram_size;
         ram_size[1] = 0;
@@ -117,15 +120,10 @@ static void xen_init_ram(MachineState *machine)
     memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &ram_memory,
                              GUEST_RAM0_BASE, ram_size[0]);
     memory_region_add_subregion(sysmem, GUEST_RAM0_BASE, &ram_lo);
-    DPRINTF("Initialized region xen.ram.lo: base 0x%llx size 0x%lx\n",
-            GUEST_RAM0_BASE, ram_size[0]);
-
     if (ram_size[1] > 0) {
         memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &ram_memory,
                                  GUEST_RAM1_BASE, ram_size[1]);
         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
-        DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n",
-                GUEST_RAM1_BASE, ram_size[1]);
     }
 }
 
@@ -158,7 +156,7 @@ static void xen_enable_tpm(XenArmState *xam)
 
     TPMBackend *be = qemu_find_tpm_be("tpm0");
     if (be == NULL) {
-        DPRINTF("Couldn't fine the backend for tpm0\n");
+        error_report("Couldn't find tmp0 backend");
         return;
     }
     dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
@@ -168,7 +166,7 @@ static void xen_enable_tpm(XenArmState *xam)
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, xam->cfg.tpm_base_addr);
 
-    DPRINTF("Connected tpmdev at address 0x%lx\n", xam->cfg.tpm_base_addr);
+    trace_xen_enable_tpm(xam->cfg.tpm_base_addr);
 }
 #endif
 
@@ -179,8 +177,9 @@ static void xen_arm_init(MachineState *machine)
     xam->state =  g_new0(XenIOState, 1);
 
     if (machine->ram_size == 0) {
-        DPRINTF("ram_size not specified. QEMU machine started without IOREQ"
-                "(no emulated devices including Virtio)\n");
+        warn_report("%s non-zero ram size not specified. QEMU machine started"
+                    " without IOREQ (no emulated devices including virtio)",
+                    MACHINE_CLASS(object_get_class(OBJECT(machine)))->desc);
         return;
     }
 
@@ -194,7 +193,7 @@ static void xen_arm_init(MachineState *machine)
     if (xam->cfg.tpm_base_addr) {
         xen_enable_tpm(xam);
     } else {
-        DPRINTF("tpm-base-addr is not provided. TPM will not be enabled\n");
+        warn_report("tpm-base-addr is not provided. TPM will not be enabled");
     }
 #endif
 }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 0ff41e6c780..fd0d92762e4 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -65,3 +65,8 @@ z2_lcd_enable_disable_result(const char *result) "LCD %s"
 z2_aer915_send_too_long(int8_t msg) "message too long (%i bytes)"
 z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
 z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
+
+# xen_arm.c
+xen_create_virtio_mmio_devices(int i, int irq, uint64_t base) "Created virtio-mmio device %d: irq %d base 0x%"PRIx64
+xen_init_ram(uint64_t machine_ram_size) "Initialized xen ram with size 0x%"PRIx64
+xen_enable_tpm(uint64_t addr) "Connected tpmdev at address 0x%"PRIx64
-- 
2.34.1


