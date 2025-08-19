Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605BCCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 21:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoTty-0007Qu-IT; Tue, 19 Aug 2025 17:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uoTtx-0007QJ-AH; Tue, 19 Aug 2025 17:29:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uoTtv-0006pk-KN; Tue, 19 Aug 2025 17:29:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLIHBZ014523;
 Tue, 19 Aug 2025 21:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=F6msv1cPb6ggL+C6G
 0VWSwBOirJ0oTMBqDxuAz9Aybs=; b=r62kEYs/+m1wnIWRsQTV3E+2Y3S5IMOLf
 2mkvldsg3/Tg5l3CfWrZCLemB3RKIpKLSGZWW9Oeqxzhiq4wuv8ii2H8YwCEuhSy
 /DAU6IMk9Jdaq2JQMmGc1nXIC69vYFn6kB8LFo8VVdJ7BGjqjbol1//Pda5pw4W4
 GNze4AOHY1Rnw7AN+b5W5eIc2dqel8TSroohnmKa5fmskStB8LVG4PXrY5evHxMo
 ngYaUz5Cm/PP/zlXh/OFYxtj6bLtWBfXi3ckivGin1CUJIibCsbRzHiuKFOgASQc
 igeTAXhk8vGDmiSosMKPz1SB2w/oA5jB3uubGAmtQcGuHbBb9FCdg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n12ng17w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 21:29:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57JLTngt004222;
 Tue, 19 Aug 2025 21:29:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n12ng17v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 21:29:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57JJ70gP027184;
 Tue, 19 Aug 2025 21:29:48 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my4w0egv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 21:29:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57JLTlTo20316724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Aug 2025 21:29:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06BFB5804E;
 Tue, 19 Aug 2025 21:29:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37B785803F;
 Tue, 19 Aug 2025 21:29:46 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Aug 2025 21:29:46 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH 3/4] hw/ppc: Add a test machine for the IBM PPE42 CPU
Date: Tue, 19 Aug 2025 16:28:47 -0500
Message-ID: <20250819212856.219932-4-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819212856.219932-1-milesg@linux.ibm.com>
References: <20250819212856.219932-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5OCBTYWx0ZWRfXywAOLgHv4bBx
 BlKDOgBq2Bo9WztWMOwOmLaVgcad4SnJgRo5x4NzJdUb+CdGibRaFVUNbdo6juey9gQCr+N3XXi
 UFgzBo/E3vSQrUzf6yKfPnQlcL6TB+a+7XzuTnlPJbbDLM8zp62vUGeaZ86Y4glRklcOfump+/T
 g1+wNlLfFh88+PhHo03N6MbtuGAvBiQu5Xpr0pAav3qf1W9YoUMboGNxGB7qjbMmfaiLJ2KTWzQ
 Nz1X5d2+seWTa4oLivpx3nlw3VkAvTP0wzAAIMvk94xojZkw5eS+MG8nZC6+1LF3TQDmVjsHthy
 jl+MBfiuj5LlrgNqqDYMhNFuC73nXKoPdQPiDu0ZjHdcAVINZVM2KayOnVCKsnsSENGvaLBmBgF
 blQx/6Zgm6nvXzuyfCK+FEyrGvSVoA==
X-Authority-Analysis: v=2.4 cv=H7+CA+Yi c=1 sm=1 tr=0 ts=68a4eccd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=evqTDFjjXuFHBGdgQ8UA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: xUfq9Atc8Iq36n4Et50ptnz8t7fhs5SU
X-Proofpoint-GUID: SHib10qWZZ9PXuY7yVWkM-rp3teRgfpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190198
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adds a test machine for the IBM PPE42 processor, including a
DEC, FIT, WDT and 1MB of ram.

The purpose of this machine is only to provide a generic platform
for testing instructions of the recently  added PPE42 processor
model which is used extensively in the IBM Power9, Power10 and
future Power server processors.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/ppc/Kconfig         |  9 ++++++
 hw/ppc/meson.build     |  2 ++
 hw/ppc/ppc_booke.c     |  7 ++++-
 hw/ppc/ppe42_machine.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/ppc.h   |  1 +
 5 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/ppe42_machine.c

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index ced6bbc740..3fdea5919c 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -44,6 +44,15 @@ config POWERNV
     select SSI_M25P80
     select PNV_SPI
 
+config PPC405
+    bool
+    default y
+    depends on PPC
+    select M48T59
+    select PFLASH_CFI02
+    select PPC4XX
+    select SERIAL
+
 config PPC440
     bool
     default y
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 9893f8adeb..170b90ae7d 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -57,6 +57,8 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_n1_chiplet.c',
 ))
 # PowerPC 4xx boards
+ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
+  'ppe42_machine.c'))
 ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
   'ppc440_bamboo.c',
   'ppc440_uc.c'))
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 3872ae2822..13403a56b1 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -352,7 +352,12 @@ void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags)
     booke_timer = g_new0(booke_timer_t, 1);
 
     cpu->env.tb_env = tb_env;
-    tb_env->flags = flags | PPC_TIMER_BOOKE | PPC_DECR_ZERO_TRIGGERED;
+    if (flags & PPC_TIMER_PPE) {
+        /* PPE's use a modified version of the booke behavior */
+        tb_env->flags = flags | PPC_DECR_UNDERFLOW_TRIGGERED;
+    } else {
+        tb_env->flags = flags | PPC_TIMER_BOOKE | PPC_DECR_ZERO_TRIGGERED;
+    }
 
     tb_env->tb_freq    = freq;
     tb_env->decr_freq  = freq;
diff --git a/hw/ppc/ppe42_machine.c b/hw/ppc/ppe42_machine.c
new file mode 100644
index 0000000000..0bc295da28
--- /dev/null
+++ b/hw/ppc/ppe42_machine.c
@@ -0,0 +1,69 @@
+
+/*
+ * Test Machine for the IBM PPE42 processor
+ *
+ * Copyright (c) 2025, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "system/address-spaces.h"
+#include "hw/boards.h"
+#include "hw/ppc/ppc.h"
+#include "system/system.h"
+#include "system/reset.h"
+#include "system/kvm.h"
+
+static void main_cpu_reset(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    cpu_reset(CPU(cpu));
+}
+
+static void ppe42_machine_init(MachineState *machine)
+{
+    PowerPCCPU *cpu;
+    CPUPPCState *env;
+
+    if (kvm_enabled()) {
+        error_report("machine %s does not support the KVM accelerator",
+                     MACHINE_GET_CLASS(machine)->name);
+        exit(EXIT_FAILURE);
+    }
+
+    /* init CPU */
+    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+    env = &cpu->env;
+    if (PPC_INPUT(env) != PPC_FLAGS_INPUT_PPE42) {
+        error_report("Incompatible CPU, only PPE42 bus supported");
+        exit(1);
+    }
+
+    qemu_register_reset(main_cpu_reset, cpu);
+
+    /* This sets the decrementer timebase */
+    ppc_booke_timers_init(cpu, 37500000, PPC_TIMER_PPE);
+
+    /* RAM */
+    if (machine->ram_size > 2 * GiB) {
+        error_report("RAM size more than 2 GiB is not supported");
+        exit(1);
+    }
+    memory_region_add_subregion(get_system_memory(), 0xfff80000, machine->ram);
+}
+
+
+static void ppe42_machine_class_init(MachineClass *mc)
+{
+    mc->desc = "PPE42 Test Machine";
+    mc->init = ppe42_machine_init;
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("PPE42XM");
+    mc->default_ram_id = "ram";
+    mc->default_ram_size = 1 * MiB;
+}
+
+DEFINE_MACHINE("ppe42_machine", ppe42_machine_class_init)
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 8a14d623f8..cb51d704c6 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -52,6 +52,7 @@ struct ppc_tb_t {
 #define PPC_DECR_UNDERFLOW_LEVEL     (1 << 4) /* Decr interrupt active when
                                                * the most significant bit is 1.
                                                */
+#define PPC_TIMER_PPE                (1 << 5) /* Enable PPE support */
 
 uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset);
 void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq);
-- 
2.43.0


