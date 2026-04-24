Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A513BFB44D6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGC4M-0004jl-O7; Fri, 24 Apr 2026 04:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC4L-0004jI-8c; Fri, 24 Apr 2026 04:39:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC4J-0005P4-5C; Fri, 24 Apr 2026 04:39:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NIbqLS3658063; Fri, 24 Apr 2026 08:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Bq+v8/nQIJ0Vet1k9
 3IvPZlJZuOoNDtPlLHwurn5b/I=; b=O6JOYQzHXJTHU/aQMJ+IVONIeVJujVjPx
 +v4gUYOYqrLGSU9gjCDwSjoJO8rX/4R1DUtnPYtY79EQScgXJjLjFlvugJKQ7E+9
 gEysdU7INN3t2W5LD2UPoOHJOXMSehEZDk4PQTJl6f7hFV5kVLLZ1P9ODwDxum+Z
 XaqrfyApu38POseoXksjcxj7dlU4AADTlM9hX/h3RK2/yX69IcgO6mG6y4uICfID
 oSa1RkbmILL9M+KluD0HONRP04BUbHPOYexO7sWyt5/6B2xs7JuDD7MjXhfoGdvP
 PgJV59I38yT/LdTaMKqlIXKOv82OsxexysQ5+92ZCJO9zb++KJG+A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7v3ng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O85K9O008868;
 Fri, 24 Apr 2026 08:39:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyt2bg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63O8dH5Z52167114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 08:39:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0860D2004E;
 Fri, 24 Apr 2026 08:39:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDB9520040;
 Fri, 24 Apr 2026 08:39:12 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.230]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 08:39:12 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v6 05/10] pnv/mpipl: Preserve CPU registers after crash
Date: Fri, 24 Apr 2026 14:08:32 +0530
Message-ID: <20260424083837.214947-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424083837.214947-1-adityag@linux.ibm.com>
References: <20260424083837.214947-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: -7BWJtYoZe-IXKLcI2Ut0AAKsAaBtG20
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69eb2c39 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=758Tq7CB64zFO0BBSKcA:9
X-Proofpoint-GUID: 3c3B8N9_aGbxBJ5T5e7mcurr8dsTRJnf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA3NiBTYWx0ZWRfX/ItXUk5JNff1
 AznnjJlgZcavAsJZNKi+2R8fNta5HJwZy1O835j9GdjxrBpTXuQCjbT6k0xj9TG8TMv7mQr3HTl
 yNcXvvZJ3yycyA1JrkQClMAXBkJZ6LdmuQQhINm8zpTjfPf1N1IXgjErdpYxXhNqI0bGwF0qhXM
 8/d12J8ORb8dMcNjB83xQJDFFfQ+Afh43zVLYCtGtrp35HGVLAzRFyQAIV/YNx+cWIJimyvSEIY
 5zAXdyEGRp6F7kFb5NZhQCNZVK1uDCOiwIOa7Ap3TYOqM1WGsaFYkCTaquVmpQEgHeaUAb/LN52
 3aG1j5cQqRAIPiTIyvAxy0DPMeYKKDEfod0JtYmRdvT5jCxQUDHQVsTDr5GVf91eudYboe1zXPI
 JthL+Ju2IQY9oVetGXKCyBaF4uhiEDcbAoAxBoNPdyP4+cGS+oGv9RtjHjW9qrZWygTRnxMlFZ+
 HC97F5BKegDXDoshGFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Kernel expects the platform to provide CPU registers after pausing
execution of the CPUs.

Currently only exporting the registers, used by Linux, for generating
the /proc/vmcore

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_mpipl.c         | 154 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_mpipl.h |  60 +++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
index cef1fe2c4056..308948b829cd 100644
--- a/hw/ppc/pnv_mpipl.c
+++ b/hw/ppc/pnv_mpipl.c
@@ -8,6 +8,9 @@
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "system/address-spaces.h"
+#include "system/cpus.h"
+#include "system/hw_accel.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_mpipl.h"
@@ -17,6 +20,8 @@
     (pnv->mpipl_state.skiboot_base + MDST_TABLE_OFF)
 #define MDDT_TABLE_RELOCATED                            \
     (pnv->mpipl_state.skiboot_base + MDDT_TABLE_OFF)
+#define PROC_DUMP_RELOCATED                             \
+    (pnv->mpipl_state.skiboot_base + PROC_DUMP_AREA_OFF)
 
 /*
  * Preserve the memory regions as pointed by MDST table
@@ -169,9 +174,158 @@ static bool pnv_mpipl_preserve_mem(PnvMachineState *pnv)
     return true;
 }
 
+static void do_store_cpu_regs(CPUState *cpu, MpiplPreservedCPUState *state)
+{
+    CPUPPCState *env = cpu_env(cpu);
+    MpiplRegDataHdr *regs_hdr = &state->hdr;
+    MpiplRegEntry *reg_entries = state->reg_entries;
+    MpiplRegEntry *curr_reg_entry;
+    uint32_t num_saved_regs = 0;
+
+    cpu_synchronize_state(cpu);
+
+    regs_hdr->pir = cpu_to_be32(env->spr[SPR_PIR]);
+
+    /* QEMU CPUs are not in Power Saving Mode */
+    regs_hdr->core_state = 0xff;
+
+    regs_hdr->off_regentries = 0;
+    regs_hdr->num_regentries = cpu_to_be32(NUM_REGS_PER_CPU);
+
+    regs_hdr->alloc_size = cpu_to_be32(sizeof(MpiplRegEntry));
+    regs_hdr->act_size   = cpu_to_be32(sizeof(MpiplRegEntry));
+
+#define REG_TYPE_GPR  0x1
+#define REG_TYPE_SPR  0x2
+#define REG_TYPE_TIMA 0x3
+
+/*
+ * ID numbers used by f/w while populating certain registers
+ *
+ * Copied these defines from the linux kernel
+ */
+#define REG_ID_NIP          0x7D0
+#define REG_ID_MSR          0x7D1
+#define REG_ID_CCR          0x7D2
+
+    curr_reg_entry = reg_entries;
+
+#define REG_ENTRY(type, num, val)                          \
+    do {                                               \
+        curr_reg_entry->reg_type = cpu_to_be32(type);  \
+        curr_reg_entry->reg_num  = cpu_to_be32(num);   \
+        curr_reg_entry->reg_val  = cpu_to_be64(val);   \
+        ++curr_reg_entry;                              \
+        ++num_saved_regs;                            \
+    } while (0)
+
+    /* Save the GPRs */
+    for (int gpr_id = 0; gpr_id < 32; ++gpr_id) {
+        REG_ENTRY(REG_TYPE_GPR, gpr_id, env->gpr[gpr_id]);
+    }
+
+    REG_ENTRY(REG_TYPE_SPR, SPR_ACOP, env->spr[SPR_ACOP]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_AMR, env->spr[SPR_AMR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_BESCR, env->spr[SPR_BESCR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_CFAR, env->spr[SPR_CFAR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_CIABR, env->spr[SPR_CIABR]);
+
+    REG_ENTRY(REG_TYPE_SPR, SPR_CTR, env->spr[SPR_CTR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_CTRL, env->spr[SPR_CTRL]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DABR, env->spr[SPR_DABR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DABRX, env->spr[SPR_DABRX]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DAR, env->spr[SPR_DAR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DAWR0, env->spr[SPR_DAWR0]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DAWR1, env->spr[SPR_DAWR1]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DAWRX0, env->spr[SPR_DAWRX0]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DAWRX1, env->spr[SPR_DAWRX1]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DPDES, env->spr[SPR_DPDES]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DSCR, env->spr[SPR_DSCR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DSISR, env->spr[SPR_DSISR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_EBBHR, env->spr[SPR_EBBHR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_EBBRR, env->spr[SPR_EBBRR]);
+
+    REG_ENTRY(REG_TYPE_SPR, SPR_FSCR, env->spr[SPR_FSCR]);
+
+    REG_ENTRY(REG_TYPE_SPR, SPR_CTR, env->ctr);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DAR, env->spr[SPR_DAR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_DSISR, env->spr[SPR_DSISR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_LR, env->lr);
+    REG_ENTRY(REG_TYPE_SPR, REG_ID_MSR, env->msr);
+    REG_ENTRY(REG_TYPE_SPR, REG_ID_NIP, env->nip);
+    REG_ENTRY(REG_TYPE_SPR, SPR_XER, env->xer);
+    REG_ENTRY(REG_TYPE_SPR, SPR_SRR0, env->spr[SPR_SRR0]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_SRR1, env->spr[SPR_SRR1]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_HSRR0, env->spr[SPR_HSRR0]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_HSRR1, env->spr[SPR_HSRR1]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_CFAR, env->spr[SPR_CFAR]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_HMER, env->spr[SPR_HMER]);
+    REG_ENTRY(REG_TYPE_SPR, SPR_HMEER, env->spr[SPR_HMEER]);
+
+    /*
+     * Ensure the number of registers saved match the number of
+     * registers per cpu
+     *
+     * This will help catch an error if in future a new register entry
+     * is added/removed while not modifying NUM_PER_CPU_REGS
+     */
+    assert(num_saved_regs == NUM_REGS_PER_CPU);
+}
+
+static bool pnv_mpipl_preserve_cpu_state(PnvMachineState *pnv)
+{
+    MachineState *machine = MACHINE(pnv);
+    uint32_t num_cpus = machine->smp.cpus;
+    MpiplPreservedCPUState *state;
+    CPUState *cpu;
+    AddressSpace *default_as = &address_space_memory;
+    MemTxResult io_result;
+    MemTxAttrs attrs;
+
+    /* Mark the memory transactions as privileged memory access */
+    attrs.user = 0;
+    attrs.memory = 1;
+
+    if (pnv->mpipl_state.cpu_states) {
+        /*
+         * CPU States might have been allocated from some past crash, free the
+         * memory to preven memory leak
+         */
+        g_free(pnv->mpipl_state.cpu_states);
+        pnv->mpipl_state.num_cpu_states = 0;
+    }
+
+    pnv->mpipl_state.cpu_states = g_malloc_n(num_cpus,
+            sizeof(MpiplPreservedCPUState));
+    pnv->mpipl_state.num_cpu_states = num_cpus;
+
+    state = pnv->mpipl_state.cpu_states;
+
+    /* Preserve the Processor Dump Area */
+    io_result = address_space_read(default_as, PROC_DUMP_RELOCATED, attrs,
+            &pnv->mpipl_state.proc_area, sizeof(MpiplProcDumpArea));
+    if (io_result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "MPIPL: Failed to read Proc Dump Area at: 0x" TARGET_FMT_lx "\n",
+            PROC_DUMP_RELOCATED);
+
+        return false;
+    }
+
+    CPU_FOREACH(cpu) {
+        do_store_cpu_regs(cpu, state);
+        ++state;
+    }
+
+    return true;
+}
+
 void do_mpipl_preserve(PnvMachineState *pnv)
 {
+    pause_all_vcpus();
+
     pnv_mpipl_preserve_mem(pnv);
+    pnv_mpipl_preserve_cpu_state(pnv);
 
     /* Mark next boot as Memory-preserving boot */
     pnv->mpipl_state.is_next_boot_mpipl = true;
diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
index b3d980dfefb1..aa2936caa75c 100644
--- a/include/hw/ppc/pnv_mpipl.h
+++ b/include/hw/ppc/pnv_mpipl.h
@@ -17,6 +17,10 @@
 typedef struct MdstTableEntry MdstTableEntry;
 typedef struct MdrtTableEntry MdrtTableEntry;
 typedef struct MpiplPreservedState MpiplPreservedState;
+typedef struct MpiplRegDataHdr MpiplRegDataHdr;
+typedef struct MpiplRegEntry MpiplRegEntry;
+typedef struct MpiplProcDumpArea MpiplProcDumpArea;
+typedef struct MpiplPreservedCPUState MpiplPreservedCPUState;
 
 /*
  * Following offsets are copied from skiboot source code.
@@ -49,6 +53,8 @@ typedef struct MpiplPreservedState MpiplPreservedState;
 /* HRMOR_BIT copied from skiboot */
 #define HRMOR_BIT (1ull << 63)
 
+#define NUM_REGS_PER_CPU 66 /*(32 GPRs, 34 SPRs)*/
+
 /*
  * Memory Dump Source Table (MDST)
  *
@@ -95,6 +101,55 @@ static_assert(MDST_MAX_ENTRIES == MDDT_MAX_ENTRIES,
 static_assert(MDRT_MAX_ENTRIES >= MDST_MAX_ENTRIES,
         "MDRT should support atleast having number of entries as in MDST");
 
+/*
+ * Processor Dump Area
+ *
+ * This contains the information needed for having processor
+ * state captured during a platform dump.
+ *
+ * As mentioned in HDAT, following the P9 specific format
+ */
+struct MpiplProcDumpArea {
+    uint32_t  thread_size;    /* Size of each thread register entry */
+#define PROC_DUMP_AREA_VERSION_P9    0x1    /* P9 format */
+    uint8_t version;
+    uint8_t reserved[11];
+    uint64_t  alloc_addr;    /* Destination memory to place register data */
+    uint32_t  reserved2;
+    uint32_t  alloc_size;    /* Allocated size */
+    uint64_t  dest_addr;     /* Destination address */
+    uint32_t  reserved3;
+    uint32_t  act_size;      /* Actual data size */
+} QEMU_PACKED;
+
+/*
+ * "Architected Register Data" in the HDAT spec
+ *
+ * Acts as a header to the register entries for a particular thread
+ */
+struct MpiplRegDataHdr {
+    uint32_t pir;         /* PIR of thread */
+    uint8_t  core_state;  /* Stop state of the overall core */
+    uint8_t  reserved[3];
+    uint32_t off_regentries;  /* Offset to Register Entries Array */
+    uint32_t num_regentries;  /* Number of Register Entries in Array */
+    uint32_t alloc_size;  /* Allocated size for each Register Entry */
+    uint32_t act_size;    /* Actual size for each Register Entry */
+} QEMU_PACKED;
+
+struct MpiplRegEntry {
+    uint32_t reg_type;
+    uint32_t reg_num;
+    uint64_t reg_val;
+} QEMU_PACKED;
+
+struct MpiplPreservedCPUState {
+    MpiplRegDataHdr hdr;
+
+    /* Length of 'reg_entries' is hdr.num_regentries */
+    MpiplRegEntry  reg_entries[NUM_REGS_PER_CPU];
+};
+
 /* Preserved state to be saved in PnvMachineState */
 struct MpiplPreservedState {
     /* skiboot_base will be valid only after OPAL sends relocated base to SBE */
@@ -103,6 +158,11 @@ struct MpiplPreservedState {
 
     MdrtTableEntry *mdrt_table;
     uint32_t num_mdrt_entries;
+
+    MpiplProcDumpArea proc_area;
+
+    MpiplPreservedCPUState *cpu_states;
+    uint32_t num_cpu_states;
 };
 
 #endif
-- 
2.53.0


