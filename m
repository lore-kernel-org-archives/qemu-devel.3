Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F04CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HQI-0005lV-4r; Thu, 02 Oct 2025 07:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQ9-0005iU-NG
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:25 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HPk-0005pt-QR
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:24 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71d5fb5e34cso11853287b3.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404233; x=1760009033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTwXjBbTx6LPcxPbBTJANRdu/S1CtbLLrtAo/8QDU8w=;
 b=kDC/hkkEXCYNYzm3l2lJZLAnq0tsmEc/t9cnyTgU6FfPsy7CRFgjkvMo8krGxeVdMp
 4Zw4xrtGRjtDFs5RF1TiE3sJr5IYMcR7URsBwRKWwrYJ9S0Qa4SA8oEUsvS49jmwIotk
 9ZX8EtwhPmhJK9m3TuOLmY3viG2jTZnWvAiniCJE7vbf4LbL3pgXwU1rKmtwWzATRG3u
 qIcgihRbEwgRiLbd1OS5Fa8+dlhPi6r0bdaK+YjB2N15akQqRMiGnli3qwT8/9kr7B3o
 hv1i3mOwp8mRu+6Sp0x1zah80szjuoSs/3656xqOBYHaLDRgSPV2f5HFVlwMp29AbY3d
 kHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404233; x=1760009033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTwXjBbTx6LPcxPbBTJANRdu/S1CtbLLrtAo/8QDU8w=;
 b=T2EQEf5fBvtGEQvB8Eaey1ZPHj9ARNNy+nAWXKfmxOUc9lQe+GNgB7t6kv1zDCqfon
 aqHJDmb4XmRdBPnDLDH/uIoi+WmDzetKE2vukKxvu6HOUkVmt+Uq+p4O9rjApOGd3IVB
 k/tGvg9kY75piZk4duztqCmRRT5hcbF/N1E0WRcQ49TqjE+Su50G4MbvluYud55/qD7b
 1X44gwBiTEFognHC/yEST1Eais1aav9j9Ly9POjxvzKWv+5Xdb0/hsaqt3Z3FOhkrvEx
 uLNYyJj0/lbSIcwzc2tOkmNOheRBqDV7mflVZa56itMi3XBnKtieoH7LCXvX6qyRRPGU
 SOJA==
X-Gm-Message-State: AOJu0YyxH5CLES11VxpmBVBYF6ERIqDGAL4r1ujq7nT70k8rkbXgsNQw
 RHQOHDzeG3EebN+B3Pg0ypgiLtQ00bLzAP2O/7It8ARFfSTqzbbWyHwOD+Sh16nzbLTQ7hzaFH9
 h2WudyoA=
X-Gm-Gg: ASbGncsxfvBbzUNZfdZ3AVstW8yg9ezsv+LiT1Pg+Pel2XE/CbzGHWbtCK8VAx7p7CS
 81moMTLJbSy6tzm3fcJW/xPhwdokUvN/ox81d0ZipYVvvKvQuHxL0fO9yhzLyfZuzRgaimMgMwq
 P2DWcsaqA0x5MIrY9I+28HbgTtDkbRsm7WFJ7CFLt8dv3ZI2m+YwES2Mdf+Yb7nUSkOUtfiJSxD
 ko/qGyRnkXi9KBSAIwJKySNqthDhCacFQSIS6OyB0lkwogbSHul8qIxDogK8FeqpJhgZ4+30cuN
 W2BeiuGQcYgnLNujBlAXJqcapSxQYHMRKVrz2Tb6IHE/j04OtiGOfExZct5FaojwmilMdpXxCz+
 UbBIDY2XfFSBg6HFIEokqjPmES1rFlzZVX7RWqcRNsdFJGfaxbcydmkp0wYcz2DhCnEgn/KQuhz
 E=
X-Google-Smtp-Source: AGHT+IEbJ3QiQC+N3DqXxNaBk7lvdKeFwhDyLdCqMVrNi8uBsQ8a7dAtFcN056ARUH87iS/Ibsy8CQ==
X-Received: by 2002:a05:690c:6c93:b0:71d:4c76:ebff with SMTP id
 00721157ae682-77f81afc88fmr37441617b3.16.1759404232773; 
 Thu, 02 Oct 2025 04:23:52 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:23:52 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 04/17] hw/riscv/virt.c: add trace encoders and trace ram sinks
Date: Thu,  2 Oct 2025 08:23:22 -0300
Message-ID: <20251002112335.2374517-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1129.google.com
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
index 47e573f85a..6f5eaf5f8c 100644
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
index 2c2266415e..d0ab445637 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -552,6 +552,15 @@ struct ArchCPU {
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
index 1150bd1469..1068d4d8da 100644
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
2.51.0


