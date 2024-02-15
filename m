Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17257C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag4E-00064k-J3; Thu, 15 Feb 2024 13:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag45-0004wi-SX
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:29 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3v-0002kv-Bl
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:29 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-411fc50e4e9so9096655e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020137; x=1708624937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/qyviN7UEniUAjJrEM78E18kGldAh1UYReZhCV2+9Q=;
 b=boHR/BQv/TTYxJ1oojx2zlSSu1DXQ4CEXywoatXmEhbzR5brITQz6OmD+fBl5kL8G0
 L00qmTP3oPzuWvnbLHSPIRQFG2tvSh/j3vo+SiWngOfi1prFqQKyaAlq2zknmHh48Iyf
 XjL0IiOx1P7VgVhH2+mHCxTSInX2yjJfXETnUxNOUVZa7fPrcHezdbGTpHp8WDe2zqOk
 Cn9BxriecpEij36z6PkB5lGqMYp1JgcfiD7TpBSjnaSsBTnq/ruui/SgUulfSlujVEOl
 h9u4MT3bXz9yJYJL3rRGr8647OIj8m+L8gQJ2AUrTWPX5uvdjQKfMJ8a+a20P4F32SCZ
 bNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020137; x=1708624937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/qyviN7UEniUAjJrEM78E18kGldAh1UYReZhCV2+9Q=;
 b=lQsJqKnvURlgdGaWsee3TYD2R91UOMf3GH/B/HXB2bOEygVx18tSR1kHJLyr4F4TZF
 QqKIxKohS+83aL8VDjCt29cXQoRQwONZqn5N7d9zV3XLvGzfz00nkvx4YHlzRkRnusEo
 nzSiH0yt1ZFrLmC3Q5PVFevCF7hT3l6h31grbgTfIX3va9tCUKdUA/NcZgUki+91kkV5
 S4nLQXLa3nDy1NazinnhXMLFaIRSV3I0gm4x0iANv16yjhugRI1pFgUDf1kqQlQTaRNt
 gffv+z3fDXpyiRnr+u8ixvAQEoJnq8GfVLuB86+ecB4e/1u/eu+ulYlf44C6g0OnDC7P
 bbAA==
X-Gm-Message-State: AOJu0YwusMun8V7UzIsXqXF90p8lh9Eo/ayJ6a9FXGeh/qH5KG/9xTN0
 ieKb3TvfbFZXxgAfexw6lkOzgnGzmnKQ50uYsFruwmFTruzdojrrhFFl1z2MS9SMJ7J6Mi1rg0a
 EhjM=
X-Google-Smtp-Source: AGHT+IHf1SDTrEC/lV6DJ0A8DyzvFCY7ox1cYTt6FC4D1fCTdONaJdenX3PqkeKbzDdGK9QCTh1QDw==
X-Received: by 2002:adf:f50e:0:b0:33b:304d:36b7 with SMTP id
 q14-20020adff50e000000b0033b304d36b7mr2015794wro.56.1708020136423; 
 Thu, 15 Feb 2024 10:02:16 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 bt13-20020a056000080d00b0033d1739aedbsm18872wrb.95.2024.02.15.10.02.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:02:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 39/56] hw/sparc/leon3: implement multiprocessor
Date: Thu, 15 Feb 2024 18:57:33 +0100
Message-ID: <20240215175752.82828-40-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Clément Chigot <chigot@adacore.com>

This allows to register more than one CPU on the leon3_generic machine.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Message-ID: <20240131085047.18458-8-chigot@adacore.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 93 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 25 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 46fc1e783a..1637900162 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -54,6 +54,8 @@
 #define LEON3_PROM_OFFSET    (0x00000000)
 #define LEON3_RAM_OFFSET     (0x40000000)
 
+#define MAX_CPUS  4
+
 #define LEON3_UART_OFFSET  (0x80000100)
 #define LEON3_UART_IRQ     (3)
 
@@ -67,8 +69,11 @@
 #define LEON3_AHB_PNP_OFFSET (0xFFFFF000)
 
 typedef struct ResetData {
-    SPARCCPU *cpu;
-    uint32_t  entry;            /* save kernel entry in case of reset */
+    struct CPUResetData {
+        int id;
+        SPARCCPU *cpu;
+    } info[MAX_CPUS];
+    uint32_t entry;             /* save kernel entry in case of reset */
 } ResetData;
 
 static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
@@ -123,17 +128,19 @@ static void write_bootloader(void *ptr, hwaddr kernel_addr)
     stl_p(p++, 0x01000000); /* nop */
 }
 
-static void main_cpu_reset(void *opaque)
+static void leon3_cpu_reset(void *opaque)
 {
-    ResetData *s   = (ResetData *)opaque;
-    CPUState *cpu = CPU(s->cpu);
-    CPUSPARCState  *env = &s->cpu->env;
+    struct CPUResetData *info = (struct CPUResetData *) opaque;
+    int id = info->id;
+    ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
+    CPUState *cpu = CPU(s->info[id].cpu);
+    CPUSPARCState *env = cpu_env(cpu);
 
     cpu_reset(cpu);
 
-    cpu->halted = 0;
-    env->pc     = s->entry;
-    env->npc    = s->entry + 4;
+    cpu->halted = cpu->cpu_index != 0;
+    env->pc = s->entry;
+    env->npc = s->entry + 4;
 }
 
 static void leon3_cache_control_int(CPUSPARCState *env)
@@ -167,8 +174,8 @@ static void leon3_cache_control_int(CPUSPARCState *env)
 
 static void leon3_irq_ack(CPUSPARCState *env, int intno)
 {
-    /* No SMP support yet, only CPU #0 available so far.  */
-    grlib_irqmp_ack(env->irq_manager, 0, intno);
+    CPUState *cpu = CPU(env_cpu(env));
+    grlib_irqmp_ack(env->irq_manager, cpu->cpu_index, intno);
 }
 
 /*
@@ -210,6 +217,19 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
     }
 }
 
+static void leon3_start_cpu_async_work(CPUState *cpu, run_on_cpu_data data)
+{
+    cpu->halted = 0;
+}
+
+static void leon3_start_cpu(void *opaque, int n, int level)
+{
+    CPUState *cs = CPU(opaque);
+
+    assert(level == 1);
+    async_run_on_cpu(cs, leon3_start_cpu_async_work, RUN_ON_CPU_NULL);
+}
+
 static void leon3_irq_manager(CPUSPARCState *env, int intno)
 {
     leon3_irq_ack(env, intno);
@@ -235,16 +255,20 @@ static void leon3_generic_hw_init(MachineState *machine)
     AHBPnp *ahb_pnp;
     APBPnp *apb_pnp;
 
-    /* Init CPU */
-    cpu = SPARC_CPU(cpu_create(machine->cpu_type));
-    env = &cpu->env;
+    reset_info = g_malloc0(sizeof(ResetData));
 
-    cpu_sparc_set_id(env, 0);
+    for (i = 0; i < machine->smp.cpus; i++) {
+        /* Init CPU */
+        cpu = SPARC_CPU(cpu_create(machine->cpu_type));
+        env = &cpu->env;
 
-    /* Reset data */
-    reset_info        = g_new0(ResetData, 1);
-    reset_info->cpu   = cpu;
-    qemu_register_reset(main_cpu_reset, reset_info);
+        cpu_sparc_set_id(env, i);
+
+        /* Reset data */
+        reset_info->info[i].id = i;
+        reset_info->info[i].cpu = cpu;
+        qemu_register_reset(leon3_cpu_reset, &reset_info->info[i]);
+    }
 
     ahb_pnp = GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ahb_pnp), &error_fatal);
@@ -262,14 +286,28 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate IRQ manager */
     irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
+    object_property_set_int(OBJECT(irqmpdev), "ncpus", machine->smp.cpus,
+                            &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
-    qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
-                                        env, "pil", 1);
-    qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
-                                qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
+
+    for (i = 0; i < machine->smp.cpus; i++) {
+        cpu = reset_info->info[i].cpu;
+        env = &cpu->env;
+        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_start_cpu,
+                                            cpu, "start_cpu", 1);
+        qdev_connect_gpio_out_named(irqmpdev, "grlib-start-cpu", i,
+                                    qdev_get_gpio_in_named(DEVICE(cpu),
+                                                           "start_cpu", 0));
+        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
+                                            env, "pil", 1);
+        qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
+                                    qdev_get_gpio_in_named(DEVICE(cpu),
+                                                           "pil", 0));
+        env->irq_manager = irqmpdev;
+        env->qemu_irq_ack = leon3_irq_manager;
+    }
+
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
-    env->irq_manager = irqmpdev;
-    env->qemu_irq_ack = leon3_irq_manager;
     grlib_apb_pnp_add_entry(apb_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
                             GRLIB_VENDOR_GAISLER, GRLIB_IRQMP_DEV,
                             2, 0, GRLIB_APBIO_AREA);
@@ -342,6 +380,10 @@ static void leon3_generic_hw_init(MachineState *machine)
              */
             write_bootloader(memory_region_get_ram_ptr(prom), entry);
             reset_info->entry = LEON3_PROM_OFFSET;
+            for (i = 0; i < machine->smp.cpus; i++) {
+                reset_info->info[i].cpu->env.pc = LEON3_PROM_OFFSET;
+                reset_info->info[i].cpu->env.npc = LEON3_PROM_OFFSET + 4;
+            }
         }
     }
 
@@ -380,6 +422,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->init = leon3_generic_hw_init;
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
     mc->default_ram_id = "leon3.ram";
+    mc->max_cpus = MAX_CPUS;
 }
 
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
-- 
2.41.0


