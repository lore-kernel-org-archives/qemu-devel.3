Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A309C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 19:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsoAP-0002xE-5m; Thu, 13 Mar 2025 15:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsoA9-0002tx-QI; Thu, 13 Mar 2025 15:24:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsoA7-0000u7-1X; Thu, 13 Mar 2025 15:24:13 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGo4YS030285;
 Thu, 13 Mar 2025 19:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=p45XZPt6cyjO7tLyV
 DUdmlJeuN9UMUcDZJ8ahf4Xc8c=; b=kAmXIcFHQc5CHZGr3chrTdd3luQD/RfPA
 rgV79VE7BkGK/AetXb3ZQrTg2teTcCmZFchcOEUqnLOKZhmvk/xcALWLWLTEz+CY
 4Te4zdZgA1qbm2CgNpARJp6wLSWEYSndyf5PyFWb9T76vEWY4EKz3jmsYD3CAqo7
 /Udr9X06mCu9YIJJVMZ9kJI0eBpG9nquYWdi4EYSUVTkINoMnyjFDxz+e/xDqSpk
 lTNdC2wsuuFBWr0miZUVfxn73CZm+kaxQhrgNbLefTGfwQL5aU/M6FKsB603KYCR
 L7X9qNWQGpjV+txMjqzj/vMvE07vA8AoDuPZrWqBixf+4L8XdxTCA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bqr94hn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:24:08 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52DIsOHp024720;
 Thu, 13 Mar 2025 19:24:07 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bqr94hn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:24:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52DG55HV026064;
 Thu, 13 Mar 2025 19:24:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspkg28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:24:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52DJO3YF22872564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 19:24:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F90F20043;
 Thu, 13 Mar 2025 19:24:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03F4720040;
 Thu, 13 Mar 2025 19:24:01 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.223.53]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 19:24:00 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v2 5/8] hw/ppc: Implement saving CPU state in Fadump
Date: Fri, 14 Mar 2025 00:53:38 +0530
Message-ID: <20250313192341.132171-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313192341.132171-1-adityag@linux.ibm.com>
References: <20250313192341.132171-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kAr6PgUSOBCm29akchGeE76BEVdCw3FH
X-Proofpoint-ORIG-GUID: ehMVT3DeZCtnroHMWnQyzQd1bJQAdHY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Kernel expects CPU states/register states in the format mentioned in
"Register Save Area" in PAPR.

The platform (in our case, QEMU) saves each CPU register in the form of
an array of "register entries", the start and end of this array is
signified by "CPUSTRT" and "CPUEND" register entries respectively.

The CPUSTRT and CPUEND register entry also has 4-byte logical CPU ID,
thus storing the CPU ID corresponding to the array of register entries.

Each register, and CPUSTRT, CPUEND has a predefined identifier.
Implement calculating identifier for a given register in
'fadump_str_to_u64', which has been taken from the linux kernel

Similarly GPRs also have predefined identifiers, and a corresponding
64-bit resiter value (split into two 32-bit cells). Implement
calculation of GPR identifiers with 'fadump_gpr_id_to_u64'

PAPR has restrictions on particular order of few registers, and is
free to be in any order for other registers.
Some registers mentioned in PAPR have not been exported as they are not
implemented in QEMU / don't make sense in QEMU.

Implement saving of CPU state according to the PAPR document

Note: As of this patch, the "kernel-dump" device tree entry is still not
added for the second boot, so after crash, the second kernel will boot
assuming fadump dump is "NOT" active, and try to register for fadump,
but since we already have fadump registered in QEMU internal state, the
register rtas call will fail with: "DUMP ACTIVE"

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/spapr_fadump.c         | 333 +++++++++++++++++++++++++++++++++-
 include/hw/ppc/spapr_fadump.h |  28 +++
 2 files changed, 360 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index db874fe13487..e84f7338d82c 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -8,6 +8,71 @@
 #include "qemu/log.h"
 #include "hw/ppc/spapr.h"
 #include "system/cpus.h"
+#include "system/hw_accel.h"
+
+/*
+ * Copy the ascii values for first 8 characters from a string into u64
+ * variable at their respective indexes.
+ * e.g.
+ *  The string "FADMPINF" will be converted into 0x4641444d50494e46
+ */
+static uint64_t fadump_str_to_u64(const char *str)
+{
+    uint64_t val = 0;
+    int i;
+
+    for (i = 0; i < sizeof(val); i++) {
+        val = (*str) ? (val << 8) | *str++ : val << 8;
+    }
+    return val;
+}
+
+/**
+ * Get the identifier id for register entries of GPRs
+ *
+ * It gives the same id as 'fadump_str_to_u64' when the complete string id
+ * of the GPR is given, ie.
+ *
+ *   fadump_str_to_u64("GPR05") == fadump_gpr_id_to_u64(5);
+ *   fadump_str_to_u64("GPR12") == fadump_gpr_id_to_u64(12);
+ *
+ * And so on. Hence this can be implemented by creating a dynamic
+ * string for each GPR, such as "GPR00", "GPR01", ... "GPR31"
+ * Instead of allocating a string, an observation from the math of
+ * 'fadump_str_to_u64' or from PAPR tells us that there's a pattern
+ * in the identifier IDs, such that the first 4 bytes are affected only by
+ * whether it is GPR0*, GPR1*, GPR2*, GPR3*.
+ * Upper half of 5th byte is always 0x3. Lower half (nibble) of 5th byte
+ * is the tens digit of the GPR id, ie. GPR ID / 10.
+ * Upper half of 6th byte is always 0x3. Lower half (nibble) of 5th byte
+ * is the ones digit of the GPR id, ie. GPR ID % 10
+ *
+ * For example, for GPR 29, the 5th and 6th byte will be 0x32 and 0x39
+ */
+static uint64_t fadump_gpr_id_to_u64(uint32_t gpr_id)
+{
+    uint64_t val = 0;
+
+    /* Valid range of GPR id is only GPR0 to GPR31 */
+    assert(gpr_id < 32);
+
+    /* Below calculations set the 0th to 5th byte */
+    if (gpr_id <= 9) {
+        val = fadump_str_to_u64("GPR0");
+    } else if (gpr_id <= 19) {
+        val = fadump_str_to_u64("GPR1");
+    } else if (gpr_id <= 29) {
+        val = fadump_str_to_u64("GPR2");
+    } else {
+        val = fadump_str_to_u64("GPR3");
+    }
+
+    /* Set the 6th byte */
+    val |= 0x30000000;
+    val |= ((gpr_id % 10) << 24);
+
+    return val;
+}
 
 /*
  * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
@@ -218,14 +283,222 @@ static bool do_preserve_region(FadumpSection *region)
     return true;
 }
 
+/*
+ * Populate the passed CPUs register entries, in the buffer starting at
+ * the argument 'curr_reg_entry'
+ *
+ * The register entries is an array of pair of register id and register
+ * value, as described in Table 591/592 in section "H.1 Register Save Area"
+ * in PAPR v2.13
+ *
+ * Returns pointer just past this CPU's register entries, which can be used
+ * as the start address for next CPU's register entries
+ */
+static FadumpRegEntry *populate_cpu_reg_entries(CPUState *cpu,
+        FadumpRegEntry *curr_reg_entry)
+{
+    CPUPPCState *env;
+    PowerPCCPU *ppc_cpu;
+    uint32_t num_regs_per_cpu = 0;
+
+    ppc_cpu = POWERPC_CPU(cpu);
+    env = cpu_env(cpu);
+    num_regs_per_cpu = 0;
+
+    curr_reg_entry->reg_id =
+        cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
+    curr_reg_entry->reg_value = ppc_cpu->vcpu_id;
+    ++curr_reg_entry;
+
+#define REG_ENTRY(id, val)                             \
+    do {                                               \
+        curr_reg_entry->reg_id =                       \
+            cpu_to_be64(fadump_str_to_u64(#id));       \
+        curr_reg_entry->reg_value = cpu_to_be64(val);  \
+        ++curr_reg_entry;                              \
+        ++num_regs_per_cpu;                            \
+    } while (0)
+
+    REG_ENTRY(ACOP, env->spr[SPR_ACOP]);
+    REG_ENTRY(AMR, env->spr[SPR_AMR]);
+    REG_ENTRY(BESCR, env->spr[SPR_BESCR]);
+    REG_ENTRY(CFAR, env->spr[SPR_CFAR]);
+    REG_ENTRY(CIABR, env->spr[SPR_CIABR]);
+
+    /* Save the condition register */
+    REG_ENTRY(CR, ppc_get_cr(env));
+
+    REG_ENTRY(CTR, env->spr[SPR_CTR]);
+    REG_ENTRY(CTRL, env->spr[SPR_CTRL]);
+    REG_ENTRY(DABR, env->spr[SPR_DABR]);
+    REG_ENTRY(DABRX, env->spr[SPR_DABRX]);
+    REG_ENTRY(DAR, env->spr[SPR_DAR]);
+    REG_ENTRY(DAWR0, env->spr[SPR_DAWR0]);
+    REG_ENTRY(DAWR1, env->spr[SPR_DAWR1]);
+    REG_ENTRY(DAWRX0, env->spr[SPR_DAWRX0]);
+    REG_ENTRY(DAWRX1, env->spr[SPR_DAWRX1]);
+    REG_ENTRY(DPDES, env->spr[SPR_DPDES]);
+    REG_ENTRY(DSCR, env->spr[SPR_DSCR]);
+    REG_ENTRY(DSISR, env->spr[SPR_DSISR]);
+    REG_ENTRY(EBBHR, env->spr[SPR_EBBHR]);
+    REG_ENTRY(EBBRR, env->spr[SPR_EBBRR]);
+
+    REG_ENTRY(FPSCR, env->fpscr);
+    REG_ENTRY(FSCR, env->spr[SPR_FSCR]);
+
+    /* Save the GPRs */
+    for (int gpr_id = 0; gpr_id < 32; ++gpr_id) {
+        curr_reg_entry->reg_id =
+            cpu_to_be64(fadump_gpr_id_to_u64(gpr_id));
+        curr_reg_entry->reg_value =
+            cpu_to_be64(env->gpr[gpr_id]);
+        ++curr_reg_entry;
+        ++num_regs_per_cpu;
+    }
+
+    REG_ENTRY(IAMR, env->spr[SPR_IAMR]);
+    REG_ENTRY(IC, env->spr[SPR_IC]);
+    REG_ENTRY(LR, env->spr[SPR_LR]);
+
+    REG_ENTRY(MSR, env->msr);
+    REG_ENTRY(NIA, env->nip);   /* NIA */
+    REG_ENTRY(PIR, env->spr[SPR_PIR]);
+    REG_ENTRY(PSPB, env->spr[SPR_PSPB]);
+    REG_ENTRY(PVR, env->spr[SPR_PVR]);
+    REG_ENTRY(RPR, env->spr[SPR_RPR]);
+    REG_ENTRY(SPURR, env->spr[SPR_SPURR]);
+    REG_ENTRY(SRR0, env->spr[SPR_SRR0]);
+    REG_ENTRY(SRR1, env->spr[SPR_SRR1]);
+    REG_ENTRY(TAR, env->spr[SPR_TAR]);
+    REG_ENTRY(TEXASR, env->spr[SPR_TEXASR]);
+    REG_ENTRY(TFHAR, env->spr[SPR_TFHAR]);
+    REG_ENTRY(TFIAR, env->spr[SPR_TFIAR]);
+    REG_ENTRY(TIR, env->spr[SPR_TIR]);
+    REG_ENTRY(UAMOR, env->spr[SPR_UAMOR]);
+    REG_ENTRY(VRSAVE, env->spr[SPR_VRSAVE]);
+    REG_ENTRY(VSCR, env->vscr);
+    REG_ENTRY(VTB, env->spr[SPR_VTB]);
+    REG_ENTRY(WORT, env->spr[SPR_WORT]);
+    REG_ENTRY(XER, env->spr[SPR_XER]);
+
+    /*
+     * Ignoring transaction checkpoint and few other registers
+     * mentioned in PAPR as not supported in QEMU
+     */
+#undef REG_ENTRY
+
+    /* End the registers for this CPU with "CPUEND" reg entry */
+    curr_reg_entry->reg_id =
+        cpu_to_be64(fadump_str_to_u64("CPUEND"));
+
+    /*
+     * Ensure the number of registers match (+2 for STRT & END)
+     *
+     * This will help catch an error if in future a new register entry
+     * is added/removed while not modifying FADUMP_NUM_PER_CPU_REGS
+     */
+    assert(FADUMP_NUM_PER_CPU_REGS == num_regs_per_cpu + 2 /*CPUSTRT+CPUEND*/);
+
+    ++curr_reg_entry;
+
+    return curr_reg_entry;
+}
+
+/*
+ * Populate the "Register Save Area"/CPU State as mentioned in section "H.1
+ * Register Save Area" in PAPR v2.13
+ *
+ * It allocates the buffer for this region, then populates the register
+ * entries
+ *
+ * Returns the pointer to the buffer (which should be deallocated by the
+ * callers), and sets the size of this buffer in the argument
+ * 'cpu_state_len'
+ */
+static void *populate_cpu_state_data(uint64_t *cpu_state_len)
+{
+    FadumpRegSaveAreaHeader reg_save_hdr;
+    FadumpRegEntry *reg_entries;
+    FadumpRegEntry *curr_reg_entry;
+    CPUState *cpu;
+
+    uint32_t fadump_reg_entries_size;
+    uint32_t num_cpus = 0;
+
+    void *cpu_state_buffer = 0;
+    uint64_t offset = 0;
+
+    CPU_FOREACH(cpu) {
+        ++num_cpus;
+    }
+
+    reg_save_hdr.version = cpu_to_be32(0);
+    reg_save_hdr.magic_number =
+        cpu_to_be64(fadump_str_to_u64("REGSAVE"));
+
+    /* Reg save area header is immediately followed by num cpus */
+    reg_save_hdr.num_cpu_offset =
+        cpu_to_be32(sizeof(FadumpRegSaveAreaHeader));
+
+    fadump_reg_entries_size = num_cpus *
+                              FADUMP_NUM_PER_CPU_REGS *
+                              sizeof(FadumpRegEntry);
+
+    reg_entries = malloc(fadump_reg_entries_size);
+
+    /* Pointer to current CPU's registers */
+    curr_reg_entry = reg_entries;
+
+    /* Populate register entries for all CPUs */
+    CPU_FOREACH(cpu) {
+        cpu_synchronize_state(cpu);
+        curr_reg_entry = populate_cpu_reg_entries(cpu, curr_reg_entry);
+    }
+
+    *cpu_state_len = 0;
+    *cpu_state_len += sizeof(reg_save_hdr);     /* reg save header */
+    *cpu_state_len += 0xc;                      /* padding as in PAPR */
+    *cpu_state_len += sizeof(__be32);           /* num_cpus */
+    *cpu_state_len += fadump_reg_entries_size;  /* reg entries */
+
+    cpu_state_buffer = g_malloc(*cpu_state_len);
+
+    memcpy(cpu_state_buffer + offset,
+            &reg_save_hdr, sizeof(reg_save_hdr));
+    offset += sizeof(reg_save_hdr);
+
+    /* Write num_cpus */
+    num_cpus = cpu_to_be32(num_cpus);
+    memcpy(cpu_state_buffer + offset, &num_cpus, sizeof(__be32));
+    offset += sizeof(__be32);
+
+    /* Write the register entries */
+    memcpy(cpu_state_buffer + offset,
+            reg_entries, fadump_reg_entries_size);
+    offset += fadump_reg_entries_size;
+
+    return cpu_state_buffer;
+}
+
 /* Preserve the memory locations registered for fadump */
 static bool fadump_preserve_mem(SpaprMachineState *spapr)
 {
     FadumpMemStruct *fdm = &spapr->registered_fdm;
+    FadumpSection *cpu_state_region;
+    AddressSpace *default_as = &address_space_memory;
+    MemTxResult io_result;
+    MemTxAttrs attrs;
     uint16_t dump_num_sections, data_type;
+    uint64_t dest_addr;
+    uint64_t cpu_state_addr, cpu_state_len = 0;
+    void *cpu_state_buffer;
 
     assert(spapr->fadump_registered);
 
+    /* Mark the memory transaction as privileged memory access */
+    attrs.user = 0;
+    attrs.memory = 1;
+
     /*
      * Handle all sections
      *
@@ -238,6 +511,7 @@ static bool fadump_preserve_mem(SpaprMachineState *spapr)
     dump_num_sections = be16_to_cpu(fdm->header.dump_num_sections);
     for (int i = 0; i < dump_num_sections; ++i) {
         data_type = be16_to_cpu(fdm->rgn[i].source_data_type);
+        dest_addr = be64_to_cpu(fdm->rgn[i].destination_address);
 
         /* Reset error_flags & bytes_dumped for now */
         fdm->rgn[i].error_flags = 0;
@@ -252,7 +526,15 @@ static bool fadump_preserve_mem(SpaprMachineState *spapr)
 
         switch (data_type) {
         case FADUMP_CPU_STATE_DATA:
-            /* TODO: Add CPU state data */
+            cpu_state_region = &fdm->rgn[i];
+            cpu_state_addr    = dest_addr;
+            cpu_state_buffer  = populate_cpu_state_data(&cpu_state_len);
+
+            /*
+             * We will write the cpu state data later, as otherwise it
+             * might get overwritten by other fadump regions
+             */
+
             break;
         case FADUMP_HPTE_REGION:
             /* TODO: Add hpte state data */
@@ -278,6 +560,55 @@ static bool fadump_preserve_mem(SpaprMachineState *spapr)
         }
     }
 
+    /*
+     * Write the Register Save Area
+     *
+     * CPU State/Register Save Area should be written after dumping the
+     * memory to prevent overwriting while saving other memory regions
+     *
+     * eg. If boot memory region is 1G, then both the first 1GB memory, and
+     * the Register Save Area needs to be saved at 1GB.
+     * And as the CPU_STATE_DATA region comes first than the
+     * REAL_MODE_REGION region to be copied, the CPU_STATE_DATA will get
+     * overwritten if saved before the 0GB - 1GB region is copied after
+     * saving CPU state data
+     */
+    io_result = address_space_write(default_as, cpu_state_addr, attrs,
+            cpu_state_buffer, cpu_state_len);
+    g_free(cpu_state_buffer);
+    if ((io_result & MEMTX_DECODE_ERROR) ||
+        (io_result & MEMTX_ACCESS_ERROR)) {
+        /*
+         * Invalid destination address is not an hardware error, instead
+         * wrong parameter from the kernel.
+         * Return true to let caller know to continue reading other
+         * sections
+         */
+        cpu_state_region->error_flags = FADUMP_ERROR_INVALID_DEST_ADDR;
+        cpu_state_region->bytes_dumped = 0;
+        return true;
+    } else if (io_result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Failed to write CPU state region\n");
+        cpu_state_region->bytes_dumped = 0;
+
+        return false;
+    }
+
+    /*
+     * Set bytes_dumped in cpu state region, so kernel knows platform have
+     * exported it
+     */
+    cpu_state_region->bytes_dumped = cpu_to_be64(cpu_state_len);
+
+    if (cpu_state_region->source_len != cpu_state_region->bytes_dumped) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "CPU State region's length passed by kernel (0x%lx) !="
+                " CPU State region's length exported by QEMU (0x%lx)\n",
+                be64_to_cpu(cpu_state_region->source_len),
+                be64_to_cpu(cpu_state_region->bytes_dumped));
+    }
+
     return true;
 }
 
diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
index d56ca1d6d651..13bdd39a9ec1 100644
--- a/include/hw/ppc/spapr_fadump.h
+++ b/include/hw/ppc/spapr_fadump.h
@@ -48,9 +48,14 @@
 #define FADUMP_MAX_SECTIONS            10
 #define RTAS_FADUMP_MAX_BOOT_MEM_REGS  7
 
+/* Number of registers stored per cpu */
+#define FADUMP_NUM_PER_CPU_REGS (32 /*GPR*/ + 45 /*others*/ + 2 /*STRT & END*/)
+
 typedef struct FadumpSection FadumpSection;
 typedef struct FadumpSectionHeader FadumpSectionHeader;
 typedef struct FadumpMemStruct FadumpMemStruct;
+typedef struct FadumpRegSaveAreaHeader FadumpRegSaveAreaHeader;
+typedef struct FadumpRegEntry FadumpRegEntry;
 
 struct SpaprMachineState;
 
@@ -88,6 +93,29 @@ struct FadumpMemStruct {
     FadumpSection       rgn[FADUMP_MAX_SECTIONS];
 };
 
+/*
+ * The firmware-assisted dump format.
+ *
+ * The register save area is an area in the partition's memory used to preserve
+ * the register contents (CPU state data) for the active CPUs during a firmware
+ * assisted dump. The dump format contains register save area header followed
+ * by register entries. Each list of registers for a CPU starts with "CPUSTRT"
+ * and ends with "CPUEND".
+ */
+
+/* Register save area header. */
+struct FadumpRegSaveAreaHeader {
+    __be64    magic_number;
+    __be32    version;
+    __be32    num_cpu_offset;
+};
+
+/* Register entry. */
+struct FadumpRegEntry {
+    __be64    reg_id;
+    __be64    reg_value;
+};
+
 uint32_t do_fadump_register(struct SpaprMachineState *, target_ulong);
 void     trigger_fadump_boot(struct SpaprMachineState *, target_ulong);
 #endif /* PPC_SPAPR_FADUMP_H */
-- 
2.48.1


