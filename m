Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B43C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3S-0000fn-LU; Mon, 19 May 2025 00:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrpI-0000KU-JT
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:10:09 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrpG-0004c4-3T
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:10:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso30461865ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627804; x=1748232604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2IPT0y4bR7Ad0h8qFIp+L+38iB43yKtbwvpNpqIgic=;
 b=ir9Z3u6ueWWxxvnJ4j1LimgDz9GXZiuCRG88zVAHwmAZ3dlhSzWfqPHyHs9AvYwx46
 GzhLzCMXgHHg14CBrwzBCH8lRUyA/c3LtDOGuchk6Jv5YmTBFw+w7cb3YIvGHUvUasxb
 w38yRds076cROJifVWmt+T77IjuggmOK18M0PMVvuGtAgff2z2eB1ciDY+8Y511zVfbX
 0JQc7JMIZu3pnkNNlE1M4GxJiKCe5VvbSKu8FBeiBvJDC1ANylDnY78DtdX5F2zj5b83
 gHm05Lz+4nTp4/isz4f/5InqCZm5xY7BS5JrRZnEsBs933kXr5rfZ4snp8Rm0SfeqUvK
 Im2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627804; x=1748232604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r2IPT0y4bR7Ad0h8qFIp+L+38iB43yKtbwvpNpqIgic=;
 b=L869h7108AEqGtffkd6fxqdcEi/+WwBMOMZcSpB6sbCG8taRCewg4U+e43HlTaTU4t
 8cBgnHsD9UhX+OC754CfMl7q0txFJhn3hAlxJAqMf0cQ2kfg3l5dAX15041BwwDC+FAv
 HI5ynqFYdom0La+oYwP3CsJjZz/cHG4LMiSnNvcQWgfQ/8HvrmNQ/XLQIC6kzIBvmJwS
 v+s4t+vlSIh+qZVL1TsijW4yDEo0zqE2UKb9GEoj2W0Ni8dZO7hTYcwB0VEs2OXF+xoq
 W1D1CvbdbTJ7JbhvrhnQ/e8lexHpuUzpSjz6avzVwuH8KaCtQQCQaBIssW7DnUM0/img
 /jsA==
X-Gm-Message-State: AOJu0Yw6CyGgB4kyJND3tRgaON5yTOZxwgQ6w+hVOYzSgvBtzMOqbeQQ
 gL5Dh2F97a92d+3REbuRaK93CT64nV/WksajtAwW4Guqq5I4NuYroqKMSOAhUw==
X-Gm-Gg: ASbGnctBJs5FTbiSm41TLpwsEx9jRsEXVd148RtEtpbEGpxkq360bYCNw9jMPpiUNyj
 cPMHxVqbsb0i78cTW9NIg10oOn1iD+YEFeeLsC9/cocYcMCi8fFNsyH3CVTlfHTFG4MzI3xIlIR
 iyn+PK/6xPbbvVaLMx/3cxJQhlbqB2HEGtSsj06dVtJwQE/tsdRsffaxpYwxNZMDAJYYbF2Vn5z
 8jEkxr2JSwUs6edgvfuaWz89Mg8Myjpr0bOcQQMfPsUzkYg7hVDKscNQJGAtGQMLLsHyR1yvm9X
 O1VwKPTmDseGtWQKebrzv/8WOj80WJ+CGvzpAS7PmSuvrPWrdSwAgc2f4qhWB4YIKFS9cW6mY+g
 DJKLWdhGk6QGRpi+gV9iZcVFiMgOIbILLPtZdM3zjyguJBiRKt2CYGtwe
X-Google-Smtp-Source: AGHT+IHivU+KOPgdtlJaJiG65/7WyySzhZYPjPBxvLEihINg2gmOSNhbW+0RqQZZqQ6zbaGmfEycmA==
X-Received: by 2002:a17:902:e5d1:b0:223:54aa:6d15 with SMTP id
 d9443c01a7336-231d44e4599mr174413905ad.12.1747627804190; 
 Sun, 18 May 2025 21:10:04 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:10:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 56/56] hw/riscv/virt.c: remove 'long' casts in fmt strings
Date: Mon, 19 May 2025 14:05:53 +1000
Message-ID: <20250519040555.3797167-57-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We can avoid the 'long' casts by using PRIx64 and HWADDR_PRIx on the fmt
strings for uint64_t and hwaddr types.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429125811.224803-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index edb6973100..0dcced1b49 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -304,12 +304,13 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
 static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
 {
     g_autofree char *mem_name = NULL;
-    uint64_t addr, size;
+    hwaddr addr;
+    uint64_t size;
     MachineState *ms = MACHINE(s);
 
     addr = s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
     size = riscv_socket_mem_size(ms, socket);
-    mem_name = g_strdup_printf("/memory@%lx", (long)addr);
+    mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
     qemu_fdt_add_subnode(ms->fdt, mem_name);
     qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
         addr >> 32, addr, size >> 32, size);
@@ -880,8 +881,8 @@ static void create_fdt_pcie(RISCVVirtState *s,
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
-    name = g_strdup_printf("/soc/pci@%lx",
-        (long) s->memmap[VIRT_PCIE_ECAM].base);
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
+                           s->memmap[VIRT_PCIE_ECAM].base);
     qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
         FDT_PCI_ADDR_CELLS);
     qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
@@ -925,8 +926,8 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
     MachineState *ms = MACHINE(s);
 
     test_phandle = (*phandle)++;
-    name = g_strdup_printf("/soc/test@%lx",
-        (long)s->memmap[VIRT_TEST].base);
+    name = g_strdup_printf("/soc/test@%"HWADDR_PRIx,
+                           s->memmap[VIRT_TEST].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     {
         static const char * const compat[3] = {
@@ -964,8 +965,8 @@ static void create_fdt_uart(RISCVVirtState *s,
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
-    name = g_strdup_printf("/soc/serial@%lx",
-                           (long)s->memmap[VIRT_UART0].base);
+    name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
+                           s->memmap[VIRT_UART0].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
     qemu_fdt_setprop_cells(ms->fdt, name, "reg",
@@ -989,7 +990,8 @@ static void create_fdt_rtc(RISCVVirtState *s,
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
-    name = g_strdup_printf("/soc/rtc@%lx", (long)s->memmap[VIRT_RTC].base);
+    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
+                           s->memmap[VIRT_RTC].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible",
         "google,goldfish-rtc");
@@ -1042,8 +1044,8 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
     g_autofree char *iommu_node = NULL;
     g_autofree char *pci_node = NULL;
 
-    pci_node = g_strdup_printf("/soc/pci@%lx",
-                               (long) s->memmap[VIRT_PCIE_ECAM].base);
+    pci_node = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
+                               s->memmap[VIRT_PCIE_ECAM].base);
     iommu_node = g_strdup_printf("%s/virtio_iommu@%x,%x", pci_node,
                                  PCI_SLOT(bdf), PCI_FUNC(bdf));
     iommu_phandle = qemu_fdt_alloc_phandle(fdt);
@@ -1111,8 +1113,8 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     g_autofree char *iommu_node = NULL;
     g_autofree char *pci_node = NULL;
 
-    pci_node = g_strdup_printf("/soc/pci@%lx",
-                               (long) s->memmap[VIRT_PCIE_ECAM].base);
+    pci_node = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
+                               s->memmap[VIRT_PCIE_ECAM].base);
     iommu_node = g_strdup_printf("%s/iommu@%x", pci_node, bdf);
     iommu_phandle = qemu_fdt_alloc_phandle(fdt);
     qemu_fdt_add_subnode(fdt, iommu_node);
@@ -1181,8 +1183,8 @@ static void create_fdt(RISCVVirtState *s)
      * The "/soc/pci@..." node is needed for PCIE hotplugs
      * that might happen before finalize_fdt().
      */
-    name = g_strdup_printf("/soc/pci@%lx",
-                           (long) s->memmap[VIRT_PCIE_ECAM].base);
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
+                           s->memmap[VIRT_PCIE_ECAM].base);
     qemu_fdt_add_subnode(ms->fdt, name);
 
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
-- 
2.49.0


