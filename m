Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E619EF36E8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 07:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUun-0006NE-IU; Mon, 09 Mar 2026 03:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUum-0006Lm-6p; Mon, 09 Mar 2026 03:20:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUuj-0006DR-BV; Mon, 09 Mar 2026 03:20:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628NkIAv1997845; Mon, 9 Mar 2026 07:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=r4kwiVQEybDHN93dA
 RGxFnIMvaVRPC9O66XAVBFtd54=; b=iGKc4hTVc0wlFDkgNjVJXHwAHvz8T95H6
 tnG/238gUJKmO5Geqz90xQKN384FTY6sPaLrlRwnEaJVLfDsncxRcmo2Jz4/+ZK2
 4x/5HZ+pwkOMe0sbIcY4GLOtMzV1qzktSa6DHHxLInI7JqUAlsKU+E2nyhwz/8gO
 /b6i0eMCsB84oqHF66m+ivjRZJFqjvCC8mskWihePl6gaXoJdGMhgunCVim2IEV+
 ugdbUVl8brjAB0lFaPTNYeUcBbHUSX88JeWXU6D4Feqm4LZDxbzWtBdwpW2GLPke
 /oT/LOI/PKoC9p+vl+qKoggcbxFM/kd7opQkee534cVH75SbwTYqw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm5h2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629307JH021164;
 Mon, 9 Mar 2026 07:20:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsm4tx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6297KLS152363732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 07:20:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4472D2004F;
 Mon,  9 Mar 2026 07:20:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 061402004B;
 Mon,  9 Mar 2026 07:20:19 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 07:20:18 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v4 05/10] pnv/mpipl: Preserve CPU registers after crash
Date: Mon,  9 Mar 2026 12:49:54 +0530
Message-ID: <20260309072001.3136261-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309072001.3136261-1-adityag@linux.ibm.com>
References: <20260309072001.3136261-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: lOiVkVilRM4syzM1R8QSdWRjM4YM_vfO
X-Proofpoint-ORIG-GUID: TbNCtQoWNm1XTipSmQ-etRqXJr_97XlQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2MyBTYWx0ZWRfXz52gyROod9sl
 dpGN5Ksra5pS+tYCJvnkDW/7dTwEc6kKE2ObR+W3AYxRsYD3p6YOfb5ZvXGEuDGNvgM/Mimdivv
 HBlOwovAiYITWNZl3b4UdtvWB8atD+gDB4Ux/bshTT/oDa558gbLzwCIUhrja9KbstJkl9/u5yD
 KQT+M4komdohJ/h2LWt7tw3UV/HwXbSOtBs/RvRrznd9UZ3jY38cGLhOC5TsFis6Mqro9w7H8+K
 Vci0LTB5KnVBySxl2Z3IXMJjI3QOxJmhfXsl0g0iFa01sPSxHXgXLkvJ9C8b7BMDu3zn2ZWGVsT
 taXGvm5Uedd2/FYXQeLXmah4VSEcih+uf+vP/zLdRdC5P9LRUkj7KziHu64mYxEaNDZU/wQ+7SX
 8Y7NLSDn3x3wJc3s3YX7jYSTAPOwtjawYjXo1AdjlZnvPuHonYQnCDugP+24szUoJYp4HGKw+8W
 lto4GfYJ3GGfQ+aRfWg==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69ae74bb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=wbqgZbxrT7QHuDENgcwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090063
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_mpipl.c         | 154 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_mpipl.h |  60 +++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
index d9fe4a5decac..37f498051254 100644
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
@@ -168,9 +173,158 @@ static bool pnv_mpipl_preserve_mem(PnvMachineState *pnv)
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
index e0518ef2e12e..a602d6bef48d 100644
--- a/include/hw/ppc/pnv_mpipl.h
+++ b/include/hw/ppc/pnv_mpipl.h
@@ -15,6 +15,10 @@
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
 
 #define __packed             __attribute__((packed))
 
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
+} __packed;
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
+} __packed;
+
+struct MpiplRegEntry {
+    uint32_t reg_type;
+    uint32_t reg_num;
+    uint64_t reg_val;
+} __packed;
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


