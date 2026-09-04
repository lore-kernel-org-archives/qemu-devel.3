Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC9AC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MN0-0001CB-QI; Fri, 04 Sep 2026 01:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMv-0000wi-Ky
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:43 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMt-0001TF-81
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:41 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc1cbb64a1fso772843a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499298; x=1789104098; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kJutTL3mqNB8tqMY6YiMBA/ZWRU8a8bRB5ONvaYFcrU=;
 b=MzXP+JL+E/2BkbEX5T/ulT555glcpCuRgrBPcM8kvp64CAffySOGXxHVs/L1nHBYbW
 F8noAuKi20dM9shulOagl7+0KboV6Q2FRjnXYjW9zWcJMIWdDOJyWsjNMwP7b6TM33DC
 lwEQkdPB/E5ZPm4T6X6POhNFuwRhFpWkNs8AIIUsgIpPvvdA1vNNn+ITWiGkxUxdrGco
 Gzrh22zP3KXioN93D31LoSGWnri8JvwQmFBaNn/Py+U+ejkmjkG8Fprun2fFzyoXNLJs
 ATTLBSvxZYXsdP8tGXG2q/1rwDqVvhTWmIXyXzTFxx8T+tF2Je5Goyhveg+sziplQOaq
 UHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499298; x=1789104098;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kJutTL3mqNB8tqMY6YiMBA/ZWRU8a8bRB5ONvaYFcrU=;
 b=c0lr3Tb1SLSqIY55qt7ybVE4z8MDP0RFLkF9j9S3mFoUHuj+lVPXMSrxVBG2A3O41H
 Nu0XvZkQS6aFjTqpd83JsfoGZ7eVqsvmVxNFlpmgHm2JRu58XBwsxFmDRlqoHuQVS4eJ
 66q9WlI8wxSc0qlorVG3971pcNj3DyUOR0+T83O5DFZxTmILRGiw8mLDxdJ2GqfQ0vJj
 tLsfIMieDv0O06umx3RQ7l3Y6qMiOuj4sP69F41BRe7HPBw0CMWfh/vRpUxh9KKRVtTa
 6xgzYB3RYbAbVKM4d+C8De73HjhBAwPMRNvx73/XYdm8QBqidr4nJSHpig7JgNqfCNAs
 ZIoA==
X-Gm-Message-State: AFuF++nnehZZgu3mqo9+z0b40Qkrwnb0u67tWuzsNdYAoVdyIozRnh5t
 5Txqmuu9cdBGzPliGNZ38Rm6/92rgVs+fx4OnPLk5/eNJoiWJD2Vyt+0O3YngQ==
X-Gm-Gg: AYBFou0DTFmiAat70NLholX+lQ1DF4yI8z+KWJJXAAIsNLoxl+IASZFPu35pQ3QHIxn
 vnNzN6S9sNfFPolCBq3CC63uFtwHoNxxjhzMoEdDtcU0nx3CZshX2uim9sn1yZAx61jdZV5FpJ7
 /ZF9ankGPmRHfU8inR2/9MTt0lsf46uAalSAVJoamGpgIFJUcdovJ9AfIbN2cUkJ4DVQUH7Mh0Q
 os7vyEZ8UJbaS+8i59oRB8eATY+NfT7UEFY1THK3QwXLcypaxexCTqrYYsvQ8b7g7kEU5+wsc3m
 +9ViOGLbK4fC6+v5hP6Y9wJMSFCBd1NwEcS5RvjPR5Z11dRyma0OysSSJAQdB8Rlov+hHBslGYx
 YXJV8cVZdOOeVbq1Tz6i/3/JIU/MvL6RQysjN5zSk2wQfUpJ2vp9rLGoNWAMQFAqRmUB1LS3/yK
 aVe823iDgkEjgUifMeqWmhw7gNb/hg25LRNOQzRn94y45Xhk2/KOU9PvoW/CvchDbcCReKTRK9C
 453fA==
X-Received: by 2002:a05:6a21:6f12:b0:3bf:49c8:f7b with SMTP id
 adf61e73a8af0-3da39fdfe0cmr5939444637.13.1788499297944; 
 Thu, 03 Sep 2026 22:21:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/47] hw/intc/riscv_aclint: Take a MemoryRegion for the
 created devices
Date: Fri,  4 Sep 2026 15:19:29 +1000
Message-ID: <20260904051943.799041-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

From: Joel Stanley <joel@jms.id.au>

The riscv_aclint_mtimer_create() and riscv_aclint_swi_create() helpers
map the device they create into system_memory, which prevents their use
by SoCs that map devices into a memory container of their own.

Add a MemoryRegion parameter and map the device into it instead of
calling sysbus_mmio_map(). All callers pass system_memory, so there is
no change in behaviour.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260903055131.257903-3-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/intc/riscv_aclint.h |  7 ++++---
 hw/intc/riscv_aclint.c         | 12 ++++++++----
 hw/riscv/cps.c                 |  6 ++++--
 hw/riscv/k230.c                |  6 ++++--
 hw/riscv/microchip_pfsoc.c     |  5 +++--
 hw/riscv/shakti_c.c            |  7 ++++---
 hw/riscv/sifive_e.c            |  4 ++--
 hw/riscv/sifive_u.c            |  7 ++++---
 hw/riscv/spike.c               |  4 ++--
 hw/riscv/tt_atlantis.c         |  3 ++-
 hw/riscv/virt.c                | 17 +++++++++++------
 hw/riscv/xiangshan_kmh.c       |  6 ++++--
 12 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
index 0e0b98acb0..71d1b551a1 100644
--- a/include/hw/intc/riscv_aclint.h
+++ b/include/hw/intc/riscv_aclint.h
@@ -46,7 +46,8 @@ typedef struct RISCVAclintMTimerState {
     qemu_irq *timer_irqs;
 } RISCVAclintMTimerState;
 
-DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
+DeviceState *riscv_aclint_mtimer_create(MemoryRegion *container,
+    hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts,
     uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
     bool provide_rdtime);
@@ -68,8 +69,8 @@ typedef struct RISCVAclintSwiState {
     qemu_irq *soft_irqs;
 } RISCVAclintSwiState;
 
-DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
-    uint32_t num_harts, bool sswi);
+DeviceState *riscv_aclint_swi_create(MemoryRegion *container,
+    hwaddr addr, uint32_t hartid_base, uint32_t num_harts, bool sswi);
 
 enum {
     RISCV_ACLINT_DEFAULT_MTIMECMP      = 0x0,
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 361a8d1bcb..2d133d0dcf 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -371,7 +371,8 @@ static const TypeInfo riscv_aclint_mtimer_info = {
 /*
  * Create ACLINT MTIMER device.
  */
-DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
+DeviceState *riscv_aclint_mtimer_create(MemoryRegion *container,
+    hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts,
     uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
     bool provide_rdtime)
@@ -392,7 +393,8 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
     qdev_prop_set_uint32(dev, "aperture-size", size);
     qdev_prop_set_uint32(dev, "timebase-freq", timebase_freq);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    memory_region_add_subregion(container, addr,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     for (i = 0; i < num_harts; i++) {
         CPUState *cpu = cpu_by_arch_id(hartid_base + i);
@@ -556,7 +558,8 @@ static const TypeInfo riscv_aclint_swi_info = {
 /*
  * Create ACLINT [M|S]SWI device.
  */
-DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
+DeviceState *riscv_aclint_swi_create(MemoryRegion *container,
+    hwaddr addr, uint32_t hartid_base,
     uint32_t num_harts, bool sswi)
 {
     int i;
@@ -569,7 +572,8 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
     qdev_prop_set_uint32(dev, "num-harts", num_harts);
     qdev_prop_set_uint32(dev, "sswi", sswi ? true : false);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    memory_region_add_subregion(container, addr,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     for (i = 0; i < num_harts; i++) {
         CPUState *cpu = cpu_by_arch_id(hartid_base + i);
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
index 86172be5b3..5cfb54aa27 100644
--- a/hw/riscv/cps.c
+++ b/hw/riscv/cps.c
@@ -151,9 +151,11 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
                            false, false, s->aplic);
         /* PLIC changes msi_nonbroken to ture. We revert the change. */
         msi_nonbroken = false;
-        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
+        riscv_aclint_swi_create(get_system_memory(),
+                                cm_base + AIA_CLINT_OFFSET,
                                 hartid_base, MAX_HARTS, false);
-        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
+        riscv_aclint_mtimer_create(get_system_memory(),
+                                   cm_base + AIA_CLINT_OFFSET +
                                    RISCV_ACLINT_SWI_SIZE,
                                    RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                                    hartid_base,
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 34905bb170..309619dabf 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -195,9 +195,11 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     s->c908_plic = k230_create_plic(C908_CPU_HARTID, c908_cpus);
 
     /* CLINT */
-    riscv_aclint_swi_create(memmap[K230_DEV_CLINT].base,
+    riscv_aclint_swi_create(sys_mem,
+                            memmap[K230_DEV_CLINT].base,
                             C908_CPU_HARTID, c908_cpus, false);
-    riscv_aclint_mtimer_create(memmap[K230_DEV_CLINT].base + 0x4000,
+    riscv_aclint_mtimer_create(sys_mem,
+                               memmap[K230_DEV_CLINT].base + 0x4000,
                                RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                                C908_CPU_HARTID, c908_cpus,
                                RISCV_ACLINT_DEFAULT_MTIMECMP,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 60bb96da01..d34d8182b1 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -249,9 +249,10 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT4].size);
 
     /* CLINT */
-    riscv_aclint_swi_create(memmap[MICROCHIP_PFSOC_CLINT].base,
+    riscv_aclint_swi_create(system_memory,
+        memmap[MICROCHIP_PFSOC_CLINT].base,
         0, ms->smp.cpus, false);
-    riscv_aclint_mtimer_create(
+    riscv_aclint_mtimer_create(system_memory,
         memmap[MICROCHIP_PFSOC_CLINT].base + RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index a205a21332..4f99d78327 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -125,10 +125,11 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
         SHAKTI_C_PLIC_CONTEXT_STRIDE,
         shakti_c_memmap[SHAKTI_C_PLIC].size);
 
-    riscv_aclint_swi_create(shakti_c_memmap[SHAKTI_C_CLINT].base,
+    riscv_aclint_swi_create(system_memory,
+        shakti_c_memmap[SHAKTI_C_CLINT].base,
         0, 1, false);
-    riscv_aclint_mtimer_create(shakti_c_memmap[SHAKTI_C_CLINT].base +
-            RISCV_ACLINT_SWI_SIZE,
+    riscv_aclint_mtimer_create(system_memory,
+        shakti_c_memmap[SHAKTI_C_CLINT].base + RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, 1,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 1acfea4966..fa77f28152 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -223,9 +223,9 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_E_PLIC_CONTEXT_BASE,
         SIFIVE_E_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_E_DEV_PLIC].size);
-    riscv_aclint_swi_create(memmap[SIFIVE_E_DEV_CLINT].base,
+    riscv_aclint_swi_create(sys_mem, memmap[SIFIVE_E_DEV_CLINT].base,
         0, ms->smp.cpus, false);
-    riscv_aclint_mtimer_create(memmap[SIFIVE_E_DEV_CLINT].base +
+    riscv_aclint_mtimer_create(sys_mem, memmap[SIFIVE_E_DEV_CLINT].base +
             RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a40f82e7a5..0f0370b8c5 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -788,10 +788,11 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
     sifive_uart_create(system_memory, memmap[SIFIVE_U_DEV_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
-    riscv_aclint_swi_create(memmap[SIFIVE_U_DEV_CLINT].base, 0,
+    riscv_aclint_swi_create(system_memory,
+        memmap[SIFIVE_U_DEV_CLINT].base, 0,
         ms->smp.cpus, false);
-    riscv_aclint_mtimer_create(memmap[SIFIVE_U_DEV_CLINT].base +
-            RISCV_ACLINT_SWI_SIZE,
+    riscv_aclint_mtimer_create(system_memory,
+        memmap[SIFIVE_U_DEV_CLINT].base + RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
         CLINT_TIMEBASE_FREQ, false);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 5fd4109d29..63cf77e1de 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -166,10 +166,10 @@ static void spike_board_init(MachineState *machine)
         sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
 
         /* Core Local Interruptor (timer and IPI) for each socket */
-        riscv_aclint_swi_create(
+        riscv_aclint_swi_create(system_memory,
             memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size,
             base_hartid, hart_count, false);
-        riscv_aclint_mtimer_create(
+        riscv_aclint_mtimer_create(system_memory,
             memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size +
                 RISCV_ACLINT_SWI_SIZE,
             RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index e40aacbb6c..8b07218152 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -510,7 +510,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
                                   TT_IRQCHIP_NUM_MSIS,
                                   TT_IRQCHIP_NUM_PRIO_BITS);
 
-    riscv_aclint_mtimer_create(s->memmap[TT_ATL_ACLINT].base,
+    riscv_aclint_mtimer_create(system_memory,
+            s->memmap[TT_ATL_ACLINT].base,
             TT_ACLINT_MTIME_SIZE,
             0, hart_count,
             TT_ACLINT_MTIMECMP,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index def46c1ec6..186d266b29 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -767,7 +767,8 @@ static void virt_machine_init(MachineState *machine)
         if (virt_aclint_allowed() && s->have_aclint) {
             if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
                 /* Per-socket ACLINT MTIMER */
-                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
+                riscv_aclint_mtimer_create(system_memory,
+                        s->memmap[VIRT_CLINT].base +
                             i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         base_hartid, hart_count,
@@ -776,10 +777,12 @@ static void virt_machine_init(MachineState *machine)
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
             } else {
                 /* Per-socket ACLINT MSWI, MTIMER, and SSWI */
-                riscv_aclint_swi_create(s->memmap[VIRT_CLINT].base +
+                riscv_aclint_swi_create(system_memory,
+                        s->memmap[VIRT_CLINT].base +
                             i * s->memmap[VIRT_CLINT].size,
                         base_hartid, hart_count, false);
-                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
+                riscv_aclint_mtimer_create(system_memory,
+                        s->memmap[VIRT_CLINT].base +
                             i * s->memmap[VIRT_CLINT].size +
                             RISCV_ACLINT_SWI_SIZE,
                         RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
@@ -787,16 +790,18 @@ static void virt_machine_init(MachineState *machine)
                         RISCV_ACLINT_DEFAULT_MTIMECMP,
                         RISCV_ACLINT_DEFAULT_MTIME,
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
-                riscv_aclint_swi_create(s->memmap[VIRT_ACLINT_SSWI].base +
+                riscv_aclint_swi_create(system_memory,
+                        s->memmap[VIRT_ACLINT_SSWI].base +
                             i * s->memmap[VIRT_ACLINT_SSWI].size,
                         base_hartid, hart_count, true);
             }
         } else if (tcg_enabled()) {
             /* Per-socket SiFive CLINT */
-            riscv_aclint_swi_create(
+            riscv_aclint_swi_create(system_memory,
                     s->memmap[VIRT_CLINT].base + i * s->memmap[VIRT_CLINT].size,
                     base_hartid, hart_count, false);
-            riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
+            riscv_aclint_mtimer_create(system_memory,
+                    s->memmap[VIRT_CLINT].base +
                     i * s->memmap[VIRT_CLINT].size + RISCV_ACLINT_SWI_SIZE,
                     RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
                     RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 247a0b5d1f..7ebe422dfc 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -115,9 +115,11 @@ static void xiangshan_kmh_soc_realize(DeviceState *dev, Error **errp)
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     /* CLINT */
-    riscv_aclint_swi_create(memmap[XIANGSHAN_KMH_CLINT].base,
+    riscv_aclint_swi_create(system_memory,
+                            memmap[XIANGSHAN_KMH_CLINT].base,
                             0, num_harts, false);
-    riscv_aclint_mtimer_create(memmap[XIANGSHAN_KMH_CLINT].base +
+    riscv_aclint_mtimer_create(system_memory,
+                               memmap[XIANGSHAN_KMH_CLINT].base +
                                RISCV_ACLINT_SWI_SIZE,
                                RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                                0, num_harts, RISCV_ACLINT_DEFAULT_MTIMECMP,
-- 
2.55.0


