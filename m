Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212BDC61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rYp-0003Mv-8b; Sun, 30 Aug 2026 22:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rYn-0003MZ-89
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:15:45 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rYl-0007X2-2f
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:15:44 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so2378284a91.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 19:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788142542; x=1788747342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VGOjahCWQljJX/t45ndWJ2MkBFF7RcCJ+AbG0IBVH5s=;
 b=A5QHHR1zTfBzE7N2aP+sTSQu+d0RRuyyi9Ta1oVMIwr4XCYjhREC98maWvockXmmu/
 ewzh2Vv5vXlmT9vc2LC6GMcgthUVXtEddjlb7/m2GWsm0spzWx1EMuK4dc+jb+xZtEuU
 467h7qp8mqb3fFCs/qCCz7H/2NuoRdriA3d8yPExUl6a22QeJLZmZJGmdJWcPkWlmnzi
 3ysyjRvjwRZyrpzTJAafB4m9z0E+wJHyjWcM3CcfSrxwK9nbIfrXOg+OlXU5nRZ39H/R
 7ucxyHkjDRGqEPU+/wwWn/ZmQh/P6HuG78gB3wlfDgbTLOicAOV+Js6JYXSy7cDLjCJJ
 Q6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788142542; x=1788747342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VGOjahCWQljJX/t45ndWJ2MkBFF7RcCJ+AbG0IBVH5s=;
 b=PCqmyeEJe+CycANIIvdUZsFJ8ZtqS8jEeg2W8k6HW2KryQbY7xpGHCgByHDf88knXZ
 f+qNb/HMCAx9dixs5FjJ75aYf9msnAqk18SmAEQoCWPZIzWyjNLkRQHlkjciLNRMBzzP
 EXi+Zz/aRkKYuoxqxplTIvUJGyJA8BfRQAtsK6PySde+dnijgx15zDYI52fsqH9i8tR3
 24p2inheyidROk3BXsIoi+jI3xlZ0p5AtDV5edFZtrafTfAhSmOPceHv+ucSD3BWrX/m
 JTRKoOqulcuyiZt33rSIsvBrhAJGQZuGaFpXStTzbD2ZP2RlNyQzstlcfp7l9J3kDu9g
 w+/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBypLsMhEBtPIfSJv7vhrlbdZFjg5WF0TL5BR/SiRzZ5YjkXjAf5Au8Ua3ZHe6DmFSJmvmfbIh6UHwdf@nongnu.org
X-Gm-Message-State: AFuF++kovjza4+H9l8KDPR4w8AOddWprMOvcPlwVNz0gournf8nW10tu
 bi/ZMIK5yqXzSWwbOfZ6Q6nXC9sQTj+RA6gCFeKImEr+47/OInujYFUa
X-Gm-Gg: AYBFou1TSgVNMyVdKyvPU2Yclo7lN70zn/mZSdp+XQTn+UrIravIBWqMzckyvU1K8wY
 AkD7wtLVd6h1I98DG8VOyrIyn8y+f11YGrqf6aoA0NlCRAtJCvHqI8Vm6ikNPGMHGbmKMPh4EYI
 G2TZ5zK0RYfCiivwEqCtGx5g3+aw5GdV6Ckx14ZmSxKyA/Bl46jn7gnu2J28asgjzKFAD8m02u9
 yjr8QYZ/NT7UOTopwImJMhy6+6W1miUVevLfSJPxOwIa8fEoeVcgBj0JuQrtP6qWJN9YEUxDiFe
 HG3rFEejAkcOt50HT5qXQvelfPN96qLOxMqB5zjyvMUbqveHT6GhrnvbB8pfY9D6Gu/8th5oed/
 pATysjsHpehcLOZNrkwDo9/qZxec6LInitZ/cDoo/1DfTpewGKj/3G/yqxDDZv5Y3EnbEO89wqZ
 96i5kvs05cvS721zYha0/H+4ElIbp0QXXn8sM+bpypZi+jMhzDJEk7d9vs/LOoR70ZzqRVdnkl8
 UUUmmi7oOpvlyGbA6zc8MQDzVzGgSI/Z6HT+HzF28X6WtvhBYlnvEPhQrzswBZQLzxVKlwSR2kD
 TPnwnS1iKAPTn0IEYXNv
X-Received: by 2002:a17:90a:d407:b0:38e:bbf1:de3f with SMTP id
 98e67ed59e1d1-398f859e1c8mr402824a91.12.1788142541589; 
 Sun, 30 Aug 2026 19:15:41 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186807bsm20071240a91.12.2026.08.30.19.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:15:41 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 02/16] hw/intc/riscv_aclint: Take a MemoryRegion for the
 created devices
Date: Mon, 31 Aug 2026 11:44:43 +0930
Message-ID: <20260831021500.82565-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831021500.82565-1-joel@jms.id.au>
References: <20260831021500.82565-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The riscv_aclint_mtimer_create() and riscv_aclint_swi_create() helpers
map the device they create into system_memory, which prevents their use
by SoCs that map devices into a memory container of their own.

Add a MemoryRegion parameter and map the device into it instead of
calling sysbus_mmio_map(). All callers pass system_memory, so there is
no change in behaviour.

Signed-off-by: Joel Stanley <joel@jms.id.au>
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
index 0e0b98acb08a..a8c5d4eb5895 100644
--- a/include/hw/intc/riscv_aclint.h
+++ b/include/hw/intc/riscv_aclint.h
@@ -46,7 +46,8 @@ typedef struct RISCVAclintMTimerState {
     qemu_irq *timer_irqs;
 } RISCVAclintMTimerState;
 
-DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
+DeviceState *riscv_aclint_mtimer_create(MemoryRegion *mr,
+    hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts,
     uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
     bool provide_rdtime);
@@ -68,8 +69,8 @@ typedef struct RISCVAclintSwiState {
     qemu_irq *soft_irqs;
 } RISCVAclintSwiState;
 
-DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
-    uint32_t num_harts, bool sswi);
+DeviceState *riscv_aclint_swi_create(MemoryRegion *mr,
+    hwaddr addr, uint32_t hartid_base, uint32_t num_harts, bool sswi);
 
 enum {
     RISCV_ACLINT_DEFAULT_MTIMECMP      = 0x0,
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 361a8d1bcb45..972c6c99b044 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -371,7 +371,8 @@ static const TypeInfo riscv_aclint_mtimer_info = {
 /*
  * Create ACLINT MTIMER device.
  */
-DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
+DeviceState *riscv_aclint_mtimer_create(MemoryRegion *mr,
+    hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts,
     uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
     bool provide_rdtime)
@@ -392,7 +393,8 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
     qdev_prop_set_uint32(dev, "aperture-size", size);
     qdev_prop_set_uint32(dev, "timebase-freq", timebase_freq);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    memory_region_add_subregion(mr, addr,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     for (i = 0; i < num_harts; i++) {
         CPUState *cpu = cpu_by_arch_id(hartid_base + i);
@@ -556,7 +558,8 @@ static const TypeInfo riscv_aclint_swi_info = {
 /*
  * Create ACLINT [M|S]SWI device.
  */
-DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
+DeviceState *riscv_aclint_swi_create(MemoryRegion *mr,
+    hwaddr addr, uint32_t hartid_base,
     uint32_t num_harts, bool sswi)
 {
     int i;
@@ -569,7 +572,8 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
     qdev_prop_set_uint32(dev, "num-harts", num_harts);
     qdev_prop_set_uint32(dev, "sswi", sswi ? true : false);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    memory_region_add_subregion(mr, addr,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     for (i = 0; i < num_harts; i++) {
         CPUState *cpu = cpu_by_arch_id(hartid_base + i);
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
index 86172be5b3ca..5cfb54aa27d2 100644
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
index 558f30b97e9d..1ef4260c5391 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -196,9 +196,11 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
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
index 4017129c8304..a6026776d4de 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -250,9 +250,10 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
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
index 835b1f879b7f..86ff8f8fcaab 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -127,10 +127,11 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
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
index 71925583bd97..0ea444f43bc5 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -225,9 +225,9 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
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
index 57a57c96e16b..58b4744318f8 100644
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
index 630b65f56977..a227e0eca147 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -163,10 +163,10 @@ static void spike_board_init(MachineState *machine)
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
index d69851df0a01..3f183db5c302 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -509,7 +509,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
                                   TT_IRQCHIP_NUM_MSIS,
                                   TT_IRQCHIP_NUM_PRIO_BITS);
 
-    riscv_aclint_mtimer_create(s->memmap[TT_ATL_ACLINT].base,
+    riscv_aclint_mtimer_create(system_memory,
+            s->memmap[TT_ATL_ACLINT].base,
             TT_ACLINT_MTIME_SIZE,
             0, hart_count,
             TT_ACLINT_MTIMECMP,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 22a607ed10bf..6e4b39315aaa 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1370,7 +1370,8 @@ static void virt_machine_init(MachineState *machine)
         if (virt_aclint_allowed() && s->have_aclint) {
             if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
                 /* Per-socket ACLINT MTIMER */
-                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
+                riscv_aclint_mtimer_create(system_memory,
+                        s->memmap[VIRT_CLINT].base +
                             i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         base_hartid, hart_count,
@@ -1379,10 +1380,12 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1390,16 +1393,18 @@ static void virt_machine_init(MachineState *machine)
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
index 384624d69ad5..94f9d02a00b9 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -116,9 +116,11 @@ static void xiangshan_kmh_soc_realize(DeviceState *dev, Error **errp)
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
2.47.3


