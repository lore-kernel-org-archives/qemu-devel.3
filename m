Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F364FC9EF4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 11:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vypqn-0004JI-RC; Sat, 07 Mar 2026 06:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypql-0004I5-N3
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:29:39 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypqj-0006At-UM
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:29:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so4157695e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 03:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772882975; x=1773487775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSJR1I2hsyWOM4prfuj0fevco22SuYO4GKehUiibbzk=;
 b=zw3qbd7ksCeDQ4+7+uBrYonljYzBtuzJlxwz/3YV6yhYW9Rq1z9xy1oCZZfoAEFW7c
 bhagYHgG7UDeHislVQ7FertOKymrlTG+R5xMXGVuKXy+A+Go4/cwNawmhDapgD7B+L9C
 rftoL3G/L32RHw9eI0rurH4pS+WidWRR9NMLkxMT9fz3SdmkWAhJMg1bd1rtHuBTOePc
 O0AW0EgT7IBMOBukNwya7DVpcqUnGHjCXt1GZ7CkSnNFDWVzXEbu+rpjtVInELDTY147
 cYQL52q8YdkgJXWyOXDLUORdlR8q8In8jfbnsy8wP2MqODm13qUL8i28gatXL7WcwLbr
 TWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772882975; x=1773487775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OSJR1I2hsyWOM4prfuj0fevco22SuYO4GKehUiibbzk=;
 b=c/5Gfi/n45+WGS+U7aI4l40P1AYyd3qZm90QWf9mFseIv//Q4f3QlMluI6YbvDtF8w
 hBaTGyaJVkhN2wZaKiNR2Ja3p/Z7NKWOFlMrliIeMgIg7Lw+wY0zHlsYAdmyWt9VK7RI
 Q0K3hoFdLRo08EemKFC4yGmSLnS7/cw0QiEgpiFIFT4azIj6PnbxIv/rzUkYlkNKwjyF
 HEh2zl47SutrqyXa6n5u90u7wWr9DfIyr6fUFs0rwfvyBMOScNyNdOwzDR14YGBhusTx
 /AUSxxQpdZw+KNi7YvEYccOrpvE+Lyl1R68lNuF1PO/XjT4F4E78p/qIJQFy81MNfeRo
 a/PQ==
X-Gm-Message-State: AOJu0YwXYRgNE8KMmMytCT7ybPLWX/6MER054BNAHOlhwiQYtp2g+uzQ
 0FrdbxJdsny912IbR4KZ6C9e5uNbxA6nU0ePudssebQfBwrHuTtiZn7obcYMa7ci7rzKLKcmPfV
 6C/zO
X-Gm-Gg: ATEYQzym/5MHUZQYyaTYu6aPP3IiGbCj0yhqlhQAAcAE0XGOquD8kvFbR+1VQEDuK37
 NC4HLzYGGRzlqnO/eSS7MWJgPSwUdN/iAFkA6dbS0U8La8HWmUAUAWLVB//CkO5ZQjoUlwbuyP2
 TmJvtQyPvoltu+kr4zoSBePUXYkjWVYavzm7SuQYiNvy09nov0WUtYZzzGtmBx3s1kQ3XjV9Gcl
 aCHd4SPKo42Ce1AnP9Xq7G4t1p5CycWe/p/Lv4Hx1XWsHy+MjwH+DcJzqQnrBBrHRKusHVLyNfQ
 CI1KYjEQd/tzz0vBwHhoRpz96SFo1fKT0uyrPzSRc9qbqw1L2ZtZRdgLoL6eVOTfB1IXymuZCaN
 y1ywQdZwgGQQnfyYm4PgGGvL6VEiCcsgfGyUSPfVPyF5rutmGTzX+w9kBYu+HDhcyr1kd6rmF/M
 AKVQGN6pmmwNZRaPZqNVke3RueeoKJkNosTSw7FHn7BgTEsYXHTYfCZtEf2cVcXPd/RGJ2RLcqj
 7wp2YXeKl7J8cPtWlh9qtTO/J3DoTs=
X-Received: by 2002:a05:600c:1d26:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-4852691abc4mr94931485e9.2.1772882975500; 
 Sat, 07 Mar 2026 03:29:35 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853252cae1sm13462255e9.3.2026.03.07.03.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 03:29:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 2/3] hw/sparc/sun4m: Use qdev GPIOs rather than
 qemu_allocate_irqs()
Date: Sat,  7 Mar 2026 11:29:30 +0000
Message-ID: <20260307112931.3322532-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307112931.3322532-1-peter.maydell@linaro.org>
References: <20260307112931.3322532-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In the sun4m machine creation code, we currently use qemu_allocate_irqs()
to set up the IRQ lines that act as the inbound IRQ lines to the CPUs.
This results in a memory leak:

Direct leak of 128 byte(s) in 1 object(s) allocated from:
    #0 0x5a23c1281ec3 in malloc (/home/pm215/qemu/build/sparc-san/qemu-system-sparc+0xdf1ec3) (BuildId: e6aa10be01feb5524656dd083997bc82b85e3e93)
    #1 0x79e8f78f0ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x5a23c1a94e54 in qemu_extend_irqs /home/pm215/qemu/build/sparc-san/../../hw/core/irq.c:77:51
    #3 0x5a23c1a39e03 in cpu_devinit /home/pm215/qemu/build/sparc-san/../../hw/sparc/sun4m.c:802:17
    #4 0x5a23c1a39e03 in sun4m_hw_init /home/pm215/qemu/build/sparc-san/../../hw/sparc/sun4m.c:838:9

The leak is unimportant as it is a "once at startup" leak, but
fixing it helps in getting a clean leak-sanitizer test run.

Switch the sun4m code to handle CPU interrupt lines in the same way
as the leon3 machine does: the machine init code uses
qdev_init_gpio_in to create GPIO lines on the CPU objects.  This is a
little bit odd as ideally the CPU would do that itself, but for these
32-bit SPARC machines the machine and the CPU are very closely
coupled already (the functions handling the IRQ lines modify data
fields inside the CPU).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sparc/sun4m.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 29bc26ebcb..b9f8236be5 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -341,7 +341,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
 static DeviceState *slavio_intctl_init(hwaddr addr,
                                        hwaddr addrg,
                                        unsigned int smp_cpus,
-                                       qemu_irq **parent_irq)
+                                       DeviceState **cpus)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -354,7 +354,8 @@ static DeviceState *slavio_intctl_init(hwaddr addr,
 
     for (i = 0; i < smp_cpus; i++) {
         for (j = 0; j < MAX_PILS; j++) {
-            sysbus_connect_irq(s, i * MAX_PILS + j, parent_irq[i][j]);
+            sysbus_connect_irq(s, i * MAX_PILS + j,
+                               qdev_get_gpio_in_named(cpus[i], "pil", j));
         }
     }
     sysbus_mmio_map(s, 0, addrg);
@@ -785,22 +786,25 @@ static const TypeInfo ram_info = {
     .class_init    = ram_class_init,
 };
 
-static void cpu_devinit(const char *cpu_type, unsigned int id,
-                        uint64_t prom_addr, qemu_irq **cpu_irqs)
+static DeviceState *cpu_devinit(const char *cpu_type, unsigned int id,
+                                uint64_t prom_addr)
 {
     SPARCCPU *cpu;
     CPUSPARCState *env;
+    DeviceState *cpudev;
 
     cpu = SPARC_CPU(object_new(cpu_type));
     env = &cpu->env;
+    cpudev = DEVICE(cpu);
 
     qemu_register_reset(sun4m_cpu_reset, cpu);
     object_property_set_bool(OBJECT(cpu), "start-powered-off", id != 0,
                              &error_abort);
-    qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
+    qdev_init_gpio_in_named(cpudev, cpu_set_irq, "pil", MAX_PILS);
+    qdev_realize_and_unref(cpudev, NULL, &error_fatal);
     cpu_sparc_set_id(env, id);
-    *cpu_irqs = qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
     env->prom_addr = prom_addr;
+    return cpudev;
 }
 
 static void dummy_fdc_tc(void *opaque, int irq, int level)
@@ -813,13 +817,14 @@ static void sun4m_hw_init(MachineState *machine)
     DeviceState *slavio_intctl;
     unsigned int i;
     Nvram *nvram;
-    qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
+    qemu_irq slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
     qemu_irq fdc_tc;
     unsigned long kernel_size;
     uint32_t initrd_size;
     DriveInfo *fd[MAX_FD];
     FWCfgState *fw_cfg;
     DeviceState *dev, *ms_kb_orgate, *serial_orgate;
+    DeviceState *cpus[MAX_CPUS];
     SysBusDevice *s;
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
@@ -835,7 +840,7 @@ static void sun4m_hw_init(MachineState *machine)
 
     /* init CPUs */
     for(i = 0; i < smp_cpus; i++) {
-        cpu_devinit(machine->cpu_type, i, hwdef->slavio_base, &cpu_irqs[i]);
+        cpus[i] = cpu_devinit(machine->cpu_type, i, hwdef->slavio_base);
     }
 
     /* Create and map RAM frontend */
@@ -855,7 +860,7 @@ static void sun4m_hw_init(MachineState *machine)
     slavio_intctl = slavio_intctl_init(hwdef->intctl_base,
                                        hwdef->intctl_base + 0x10000ULL,
                                        smp_cpus,
-                                       cpu_irqs);
+                                       cpus);
 
     for (i = 0; i < 32; i++) {
         slavio_irq[i] = qdev_get_gpio_in(slavio_intctl, i);
-- 
2.43.0


