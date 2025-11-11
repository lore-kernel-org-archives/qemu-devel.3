Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8439ACCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrO-0006yN-7i; Tue, 11 Nov 2025 06:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqh-000507-Br
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:47 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqd-0004Pr-TG
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:47 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2956d816c10so43959075ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861654; x=1763466454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cw/EijlREtcvo2COVu/cVEEzmj7shDfjPN3cQQN1US0=;
 b=H71RX2JzaT4QxBYckPDlh3yB1Zab37K2W/ayVFJun+e6m3aQmQKxBqtsSo0jKtzHmh
 ySgQ+bOrYEmmdBHfEkcPU9q/1l9HjG1YTkT5iikYivHAYhvAUMdRRhzuq3+pxD1+JlOX
 WHlfAzATY8V2cdR67AON4GNXOqZ0Ixf7TzKTebU7w2gL6VbRuTF0xkXau353TcZ4GC9R
 RlSTZ0cXjLhhM2D+Bq+r0dx31BR8g1ycQwwom8myhU0UaI42CLEhDAB2jVRrX1eifp/g
 TVq6w9YkH45D04jDoVrA7sM5MiIFbxhB9BWL1qENxiANahS0DILHEr+EI3LQEoORMG+f
 H02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861654; x=1763466454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cw/EijlREtcvo2COVu/cVEEzmj7shDfjPN3cQQN1US0=;
 b=FPUBoyYEY9+ParJ5m3OUC3fclRIgmdcwfWGfvczvPsm5zcQplmKmQU5N+MkLJ+sFZ/
 rqj3KHQ0XLlmTPJsqZFy3UKQZ6baF3dbXBunwr+vf/n7D9QqHANlQoGMPcAUK0N6OSdg
 zN29+HXqsFH93ZKcWOdX47B+ZxAIALsFCYLTI0xdEe5AqZFL77ugJSpbiRK2QeI3VlZT
 wBf6a6BGVUcjQlYzPeiuBiXmF1FeHCwiPM5tIiThT9wNUG//EFDcBNEXpQsrLF1Fk3MY
 Cqa0dsDtH4UPKomGuiLeTnXPb3NEzu56da4vMpfQWwBA2RR3aXDyvZNn/l6DpfvtMTYo
 qd/w==
X-Gm-Message-State: AOJu0YyDI6pKLJfgRBOXG0FwwqIScOPtVls9zinRKYYmj0YxY82/x3FF
 naC+24u7U5JDUiZNIWPLz6/P4AyL+HB3w+++yjDTn5H87JtFaADJjdpLNS6HyB42z2n08cEFxAZ
 +c71YrwI=
X-Gm-Gg: ASbGncslyWDWvJd/ha9B+ZkUACEkBTJRQnH3kolDrSx7mZsj+RYCSKqll9o9g2efATB
 +ZHMFHpAvUFOkZhkJWodhtT97fVqg3kwKxTQ/1JwxuyJSh7jB7+eVHGi3gCKKwarRdwbGDbP9O+
 vwu+5GSZAVhBr0SPNgOD+tJgfwq4xtknQ0uL45Z5AhnkI2Be3kgtfUSeqIwNZa62Ba0IlzOFn2V
 G2KjsZull4VphefCvv1qDj/lFauWsbvZwgQ6YNDfCQsjRZnYo8UwyxT0AgGcoe1C/KMkClkE+6o
 TqVY7N74AMZWmO0xzRkN1/6Hot64zUYqvyljt10AcLI84THCJJlKaF1ggWHce3h48ylLTTXD4mX
 6DQvFXitNlKHMTXYxhi3ngxxzEjSMGze/e5ZqdZnRQrCg+sncMXhun3CldkK7KuZacgzO2WSW7/
 LxpceuIEdKky3S4H4u2ozKWzlJcmfCf82x8nzydE0E4VQ93m/+
X-Google-Smtp-Source: AGHT+IFwNMoUz5KvnNPM6+6ii7vvM3Udw2/SPywoiErpFwScpbVJKcdBYcZ6Yn01E2/OLO5zwj9pSA==
X-Received: by 2002:a17:903:4b43:b0:298:90f:5b01 with SMTP id
 d9443c01a7336-298090f5c89mr104999795ad.52.1762861653630; 
 Tue, 11 Nov 2025 03:47:33 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:47:33 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 04/17] hw/riscv/virt.c: add trace encoders and trace ram
 sinks
Date: Tue, 11 Nov 2025 08:46:43 -0300
Message-ID: <20251111114656.2285048-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the minimal topology required for e-trace support in the virt
machine, e.g. each CPU will have a single trace encoder, and each trace
encoder will communicate to a single associated trace ram sink.

At this moment we're not going to support more complex topologies with
trace funnels and so on.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c            | 77 ++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h    |  2 +
 target/riscv/cpu.h         |  9 +++++
 target/riscv/tcg/tcg-cpu.c |  5 +++
 4 files changed, 93 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 17909206c7..b1a4d63efd 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -58,6 +58,8 @@
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
+#include "hw/riscv/trace-encoder.h"
+#include "hw/riscv/trace-ram-sink.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
@@ -79,6 +81,17 @@ static bool virt_aclint_allowed(void)
     return tcg_enabled() || qtest_enabled();
 }
 
+#define TR_DEV_REGMAP_SIZE 0x1000
+/* For VIRT_CPUS_MAX = 512: TRACE_DEV_REG_MAX = 0x200000 */
+#define TRACE_DEV_REG_MAX (TR_DEV_REGMAP_SIZE * VIRT_CPUS_MAX)
+
+/*
+ * 64k for the RAM Sink that includes the 4k (0x1000)
+ * for regs, for each possible CPU. For 512 max CPUs,
+ * total size = 0x2000000.
+ */
+#define TRACE_RAM_SINK_SIZE (1UL << 16)
+
 static const MemMapEntry virt_memmap[] = {
     [VIRT_DEBUG] =        {        0x0,         0x100 },
     [VIRT_MROM] =         {     0x1000,        0xf000 },
@@ -88,7 +101,9 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_ACLINT_SSWI] =  {  0x2F00000,        0x4000 },
     [VIRT_PCIE_PIO] =     {  0x3000000,       0x10000 },
     [VIRT_IOMMU_SYS] =    {  0x3010000,        0x1000 },
+    [VIRT_TR_ENCODERS] =  {  0x3020000, TRACE_DEV_REG_MAX },
     [VIRT_PLATFORM_BUS] = {  0x4000000,     0x2000000 },
+    [VIRT_TR_RAM_SINKS] = {  0x6000000, TRACE_RAM_SINK_SIZE * VIRT_CPUS_MAX },
     [VIRT_PLIC] =         {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MAX * 2) },
     [VIRT_APLIC_M] =      {  0xc000000, APLIC_SIZE(VIRT_CPUS_MAX) },
     [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
@@ -1525,6 +1540,64 @@ static void virt_machine_done(Notifier *notifier, void *data)
     }
 }
 
+/*
+ * Must be called after 'soc' realize since it
+ * uses CPU objs.
+ */
+static void virt_init_socket_trace_hw(RISCVVirtState *s, int socket_num)
+{
+    for (int cpu = 0; cpu < s->soc[socket_num].num_harts; cpu++) {
+        RISCVCPU *cpu_ptr = &s->soc[socket_num].harts[cpu];
+        DeviceState *trencoder, *ram_sink;
+        uint64_t trencoder_addr, ram_sink_addr, smem_addr;
+        uint32_t smem_size = TRACE_RAM_SINK_SIZE - TR_DEV_REGMAP_SIZE;
+
+        ram_sink = qdev_new(TYPE_TRACE_RAM_SINK);
+
+        ram_sink_addr = virt_memmap[VIRT_TR_RAM_SINKS].base +
+                        TRACE_RAM_SINK_SIZE * cpu;
+        /* smem is located right after ram sink base */
+        smem_addr = ram_sink_addr + TR_DEV_REGMAP_SIZE;
+
+        object_property_set_uint(OBJECT(ram_sink), "baseaddr",
+                                 ram_sink_addr, &error_fatal);
+        object_property_set_uint(OBJECT(ram_sink), "smemaddr",
+                                 smem_addr, &error_fatal);
+        object_property_set_uint(OBJECT(ram_sink), "smemsize",
+                                 smem_size, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ram_sink), &error_fatal);
+
+        /*
+         * We can't do object_property_set_link() because we're
+         * coming after cpu.realize() (the riscv_hart obj creates
+         * the CPU objs in its realize() since it has no init).
+         * We need changes in how riscv_hart works to use
+         * set_link() and to not manually realize the trace
+         * encoder.
+         *
+         * For now do everything manually.
+         */
+        trencoder = qdev_new(TYPE_TRACE_ENCODER);
+        cpu_ptr->trencoder = OBJECT(trencoder);
+
+        trencoder_addr = virt_memmap[VIRT_TR_ENCODERS].base +
+                         TR_DEV_REGMAP_SIZE * cpu;
+
+        object_property_set_link(OBJECT(trencoder), "cpu",
+                                 OBJECT(cpu_ptr), &error_fatal);
+        object_property_set_int(OBJECT(trencoder), "cpu-id", cpu, &error_fatal);
+        object_property_set_uint(OBJECT(trencoder), "baseaddr",
+                                 trencoder_addr, &error_fatal);
+        object_property_set_uint(OBJECT(trencoder), "dest-baseaddr",
+                                 ram_sink_addr, &error_fatal);
+        object_property_set_uint(OBJECT(trencoder), "ramsink-ramstart",
+                                 smem_addr, &error_fatal);
+        object_property_set_uint(OBJECT(trencoder), "ramsink-ramlimit",
+                                 smem_addr + smem_size, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(trencoder), &error_fatal);
+    }
+}
+
 static void virt_machine_init(MachineState *machine)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
@@ -1580,6 +1653,10 @@ static void virt_machine_init(MachineState *machine)
                                 hart_count, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
 
+        if (tcg_enabled()) {
+            virt_init_socket_trace_hw(s, i);
+        }
+
         if (virt_aclint_allowed() && s->have_aclint) {
             if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
                 /* Per-socket ACLINT MTIMER */
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7b4c2c8b7d..e2aa6fbbcd 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -88,6 +88,8 @@ enum {
     VIRT_PLATFORM_BUS,
     VIRT_PCIE_ECAM,
     VIRT_IOMMU_SYS,
+    VIRT_TR_ENCODERS,
+    VIRT_TR_RAM_SINKS,
 };
 
 enum {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f10037..12251e4d94 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -553,6 +553,15 @@ struct ArchCPU {
     /* Mapping of events to counters */
     GHashTable *pmu_event_ctr_map;
     const GPtrArray *decoders;
+
+#ifndef CONFIG_USER_ONLY
+    /*
+     * Associated Trace Encoder. It will not be NULL if
+     * we're running with TCG and initialized manually by
+     * the board.
+     */
+    Object *trencoder;
+#endif
 };
 
 typedef struct RISCVCSR RISCVCSR;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index d3968251fa..a381ee2840 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -37,6 +37,7 @@
 #include "hw/boards.h"
 #include "system/tcg.h"
 #include "exec/icount.h"
+#include "hw/riscv/trace-encoder.h"
 #endif
 
 /* Hash that stores user set extensions */
@@ -1297,6 +1298,10 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
     if (riscv_has_ext(env, RVH)) {
         env->mideleg = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP | MIP_SGEIP;
     }
+
+    if (cpu->trencoder) {
+        qdev_realize(DEVICE(cpu->trencoder), NULL, &error_fatal);
+    }
 #endif
 
     return true;
-- 
2.51.1


