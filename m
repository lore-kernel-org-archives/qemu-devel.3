Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C5DC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGxq-0000e3-VO; Tue, 21 Jan 2025 11:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxn-0000WJ-GT
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:51 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxl-000623-ET
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:51 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso3125629f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737476327; x=1738081127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymQLxILP6KEtEAWt2AfXSUgSXSVS/hfsSOWZfTMTJgk=;
 b=IwcOs87YnVU7NeJkbTQNMr99fzgK64J+E4tG3oSn001PTnptdT1l7knTSSfVLry3oN
 pKMFfsnRp365QrZ33wqUPIhzAYCRYTqyH1TtZMH9wXdUFoLQcZpdOUNvXLhFLTWH+RCI
 xutBj+0eOB9NtDnOSME9pq2ixL+yCCKqc7cQJS5STbB1jALIax3SpPvGTgfAan+yizkR
 bt+PExAiQtuA7PuOVtox6U0RwSpSB/rI5B386NGypZBsppGJMrHjaGEzN7CKLvufZ/BE
 GK9Zx1SKdHD4ELYEuiDeGIJ4UpWXQM5/RBbqaJELW3wG9Sv902xgS+V0OvzyWlE944Wu
 ccPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737476327; x=1738081127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymQLxILP6KEtEAWt2AfXSUgSXSVS/hfsSOWZfTMTJgk=;
 b=fuTKr5D5PX1G6JCCagW20/hEMXyxxk7A/ZXs6X6P+5Zx7yI/1e1zV0f+9VzQXQSQO6
 Q/03SnnJs37S/OuC9I5Y81Qv5Y/K7GfK/VeQvbwcQX/XFNYUJPD9OMKDPiDICEbTWXod
 UTMmoOZx9pE9vb7u7ff0hFVrT6dvzSjb19wmiA4ZeUsxrP41Cv5YurYC9pCl9YZP0keR
 D/fX3vvsMlAk9iA64QUXkHRrXEpSO/WMtLkAs9hjGh12GkdEaZWY2kuPRQznkHZZnIw/
 gwsVMw62mLKruTgOqIobszbqd/B1YR+ku95K+111nl4pyeV5Oi9PtKiI6slxUPdXttJE
 QU/g==
X-Gm-Message-State: AOJu0Yx3pKMWD/lcfAPCqFlZEc62Ujyh9/IkD+hPzMccRKZ5kqJY+aJQ
 FUDp8PdKE2a9U9suHsdkDEAdcKUa0t48pursWkgPCucFJ214LbJwqZ6rb6eND/PtG4u//KnZ5+t
 dhSo=
X-Gm-Gg: ASbGncsB+08Z0AiwhiLd5E90g6sqP2MaQD5Zz0oda2icDXtBrlsI1GSFJ7I4d5x8iug
 yeOp/kBSxkYqwlvzKMCiuFk2NxL+JmABlqTatu8aznEC16x6XxJl1UyfH4lWkh2f0YYFmiNr2ZF
 qsqj9W23KtqURPqWSbgZA9+v3uMMJcqD53qA0r9WlgZLM9FS56XO865nLehVyL07sPO3A5SU5Ea
 6crOGsVW0QcX+uZ4lBOyd21TYkaQIa8ppj+OaEK2LfAaHxveEAHe8LxFolZkneM1MG+60wEV2Vw
 TQBsjZCJZLCg7xtj7Y8/3QlNi7pEjuGcu1ml7vDVEkhm
X-Google-Smtp-Source: AGHT+IEoRsjblS7awvdbiWLy0wu2UxsFNRcTVd8ZOpWBkQKaYkdOSg68eiPPYtzdETE8IbTdb6jOIA==
X-Received: by 2002:a05:6000:1564:b0:38b:d7d2:12f2 with SMTP id
 ffacd0b85a97d-38bf59f4422mr17330799f8f.54.1737476327518; 
 Tue, 21 Jan 2025 08:18:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf321505asm13655776f8f.7.2025.01.21.08.18.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 08:18:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 6/6] target/mips: Allocate CPU IRQs within CPUMIPSState
Date: Tue, 21 Jan 2025 17:18:17 +0100
Message-ID: <20250121161817.33654-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121161817.33654-1-philmd@linaro.org>
References: <20250121161817.33654-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

There are always 8 IRQs created with a MIPS CPU.
Allocate their state once in CPUMIPSState, initialize
them in place in cpu_mips_irq_init_cpu(). Update hw/ uses.

Move cpu_mips_irq_init_cpu() declaration from "cpu.h"
to "internal.h", as it shouldn't be accessible from hw/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h               |  4 ++--
 target/mips/internal.h          |  2 ++
 hw/intc/mips_gic.c              |  4 ++--
 hw/mips/fuloong2e.c             |  4 ++--
 hw/mips/jazz.c                  |  6 +++---
 hw/mips/loongson3_virt.c        |  4 ++--
 hw/mips/malta.c                 |  4 ++--
 hw/mips/mipssim.c               |  4 ++--
 target/mips/system/cp0_timer.c  |  4 ++--
 target/mips/system/interrupts.c | 11 +++--------
 10 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index e5767ea9cf3..25a19b61913 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -8,6 +8,7 @@
 #endif
 #include "fpu/softfloat-types.h"
 #include "hw/clock.h"
+#include "hw/irq.h"
 #include "mips-defs.h"
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
@@ -1177,7 +1178,7 @@ typedef struct CPUArchState {
     CPUMIPSMVPContext *mvp;
 #if !defined(CONFIG_USER_ONLY)
     CPUMIPSTLBContext *tlb;
-    qemu_irq irq[8];
+    IRQState irq[8];
     MemoryRegion *itc_tag; /* ITC Configuration Tags */
 
     /* Loongson IOCSR memory */
@@ -1360,7 +1361,6 @@ uint64_t cpu_mips_phys_to_kseg1(void *opaque, uint64_t addr);
 
 /* HW declaration specific to the MIPS target */
 void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
-void cpu_mips_irq_init_cpu(MIPSCPU *cpu);
 
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 69452aae5bc..63a56254bee 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -160,6 +160,8 @@ void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc);
 void cpu_mips_store_status(CPUMIPSState *env, target_ulong val);
 void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
 
+void cpu_mips_irq_init_cpu(MIPSCPU *cpu);
+
 extern const VMStateDescription vmstate_mips_cpu;
 
 static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 5e3cbeabece..e5b16538305 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -50,7 +50,7 @@ static void mips_gic_set_vp_irq(MIPSGICState *gic, int vp, int pin)
                                    pin + GIC_CPU_PIN_OFFSET,
                                    ored_level);
     } else {
-        qemu_set_irq(gic->vps[vp].env->irq[pin + GIC_CPU_PIN_OFFSET],
+        qemu_set_irq(&gic->vps[vp].env->irq[pin + GIC_CPU_PIN_OFFSET],
                      ored_level);
     }
 }
@@ -203,7 +203,7 @@ static void gic_timer_expire_cb(void *opaque, uint32_t vp_index)
         if (gic->vps[vp_index].compare_map & GIC_MAP_TO_PIN_MSK) {
             /* it is safe to set the irq high regardless of other GIC IRQs */
             uint32_t pin = (gic->vps[vp_index].compare_map & GIC_MAP_MSK);
-            qemu_irq_raise(gic->vps[vp_index].env->irq
+            qemu_irq_raise(&gic->vps[vp_index].env->irq
                            [pin + GIC_CPU_PIN_OFFSET]);
         }
     }
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 9a638f596bd..ccebc56adec 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -278,7 +278,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     }
 
     /* North bridge, Bonito --> IP2 */
-    pci_bus = bonito_init(env->irq[2]);
+    pci_bus = bonito_init(&env->irq[2]);
 
     /* South bridge -> IP5 */
     pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
@@ -296,7 +296,7 @@ static void mips_fuloong2e_init(MachineState *machine)
                               object_resolve_path_component(OBJECT(pci_dev),
                                                             "rtc"),
                               "date");
-    qdev_connect_gpio_out_named(DEVICE(pci_dev), "intr", 0, env->irq[5]);
+    qdev_connect_gpio_out_named(DEVICE(pci_dev), "intr", 0, &env->irq[5]);
 
     dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
     pci_ide_create_devs(PCI_DEVICE(dev));
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index ce4a702aa53..85728ab45ad 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -262,8 +262,8 @@ static void mips_jazz_init(MachineState *machine,
     /* Chipset */
     rc4030 = rc4030_init(&dmas, &rc4030_dma_mr);
     sysbus = SYS_BUS_DEVICE(rc4030);
-    sysbus_connect_irq(sysbus, 0, env->irq[6]);
-    sysbus_connect_irq(sysbus, 1, env->irq[3]);
+    sysbus_connect_irq(sysbus, 0, &env->irq[6]);
+    sysbus_connect_irq(sysbus, 1, &env->irq[3]);
     memory_region_add_subregion(address_space, 0x80000000,
                                 sysbus_mmio_get_region(sysbus, 0));
     memory_region_add_subregion(address_space, 0xf0000000,
@@ -284,7 +284,7 @@ static void mips_jazz_init(MachineState *machine,
     isa_bus = isa_bus_new(NULL, isa_mem, isa_io, &error_abort);
 
     /* ISA devices */
-    i8259 = i8259_init(isa_bus, env->irq[4]);
+    i8259 = i8259_init(isa_bus, &env->irq[4]);
     isa_bus_register_input_irqs(isa_bus, i8259);
     i8257_dma_init(OBJECT(rc4030), isa_bus, 0);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 91070824bbe..f1403826fc5 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -573,7 +573,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         if (!kvm_enabled()) {
             hwaddr base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
             base += core * 0x100;
-            qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);
+            qdev_connect_gpio_out(ipi, i, &cpu->env.irq[6]);
             sysbus_mmio_map(SYS_BUS_DEVICE(ipi), i + 2, base);
         }
 
@@ -594,7 +594,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         for (ip = 0; ip < 4 ; ip++) {
             int pin = core * LOONGSON3_CORE_PER_NODE + ip;
             sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
-                               pin, cpu->env.irq[ip + 2]);
+                               pin, &cpu->env.irq[ip + 2]);
         }
     }
     env = &MIPS_CPU(first_cpu)->env;
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index ac3b16229c8..425d836f476 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1042,8 +1042,8 @@ static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
 
     cpu = MIPS_CPU(first_cpu);
     env = &cpu->env;
-    *i8259_irq = env->irq[2];
-    *cbus_irq = env->irq[4];
+    *i8259_irq = &env->irq[2];
+    *cbus_irq = &env->irq[4];
 }
 
 static void create_cps(MachineState *ms, MaltaState *s,
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index d4b3b043053..4277b40d723 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -223,13 +223,13 @@ mips_mipssim_init(MachineState *machine)
         qdev_prop_set_uint8(dev, "regshift", 0);
         qdev_prop_set_uint8(dev, "endianness", DEVICE_LITTLE_ENDIAN);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, &env->irq[4]);
         memory_region_add_subregion(get_system_io(), 0x3f8,
                       sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
     }
 
     /* MIPSnet uses the MIPS CPU INT0, which is interrupt 2. */
-    mipsnet_init(0x4200, env->irq[2]);
+    mipsnet_init(0x4200, &env->irq[2]);
 }
 
 static void mips_mipssim_machine_init(MachineClass *mc)
diff --git a/target/mips/system/cp0_timer.c b/target/mips/system/cp0_timer.c
index 07641cab521..5600af66bc4 100644
--- a/target/mips/system/cp0_timer.c
+++ b/target/mips/system/cp0_timer.c
@@ -57,7 +57,7 @@ static void cpu_mips_timer_expire(CPUMIPSState *env)
     if (env->insn_flags & ISA_MIPS_R2) {
         env->CP0_Cause |= 1 << CP0Ca_TI;
     }
-    qemu_irq_raise(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
+    qemu_irq_raise(&env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
 }
 
 uint32_t cpu_mips_get_count(CPUMIPSState *env)
@@ -105,7 +105,7 @@ void cpu_mips_store_compare(CPUMIPSState *env, uint32_t value)
     if (env->insn_flags & ISA_MIPS_R2) {
         env->CP0_Cause &= ~(1 << CP0Ca_TI);
     }
-    qemu_irq_lower(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
+    qemu_irq_lower(&env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
 }
 
 void cpu_mips_start_count(CPUMIPSState *env)
diff --git a/target/mips/system/interrupts.c b/target/mips/system/interrupts.c
index 26fdb934f50..f85bb66de3c 100644
--- a/target/mips/system/interrupts.c
+++ b/target/mips/system/interrupts.c
@@ -25,6 +25,7 @@
 #include "hw/irq.h"
 #include "system/kvm.h"
 #include "kvm_mips.h"
+#include "internal.h"
 
 static void cpu_mips_irq_request(void *opaque, int irq, int level)
 {
@@ -58,14 +59,8 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
 void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
-    qemu_irq *qi;
-    int i;
 
-    qi = qemu_allocate_irqs(cpu_mips_irq_request, cpu, 8);
-    for (i = 0; i < 8; i++) {
-        env->irq[i] = qi[i];
-    }
-    g_free(qi);
+    qemu_init_irqs(env->irq, ARRAY_SIZE(env->irq), cpu_mips_irq_request, cpu);
 }
 
 void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level)
@@ -74,5 +69,5 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level)
         return;
     }
 
-    qemu_set_irq(env->irq[irq], level);
+    qemu_set_irq(&env->irq[irq], level);
 }
-- 
2.47.1


