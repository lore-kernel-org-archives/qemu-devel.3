Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EE8EB106E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyne-00075O-J2; Tue, 10 Mar 2026 11:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynS-0006rO-Ft
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:15:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynP-0000G9-Jo
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:58 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A87eqd1651541
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=doIly4w7g2zui144z
 EsvAuCenF/BQeruCMLjDHsTj4k=; b=Dw5rTfEENT9yU/8e3FHmoNTnCpqR8vc0I
 FvjCCRhNOqhSogMvInZ5GbGtxYNvYei8y+0JQVWlqXbU0cpwWR2rKDKwtFw/Pzer
 JQ7PIDrFkK86iBqhFjLiAUBBWnBisPeYzxJ2A4Y7seqmsj48yEuBIyn011F33aGH
 rzARbuM0T/N0tLch8L3zIYgrRbWmnG4tITlbQEZ/cQnjLsYoX5LORdbBaT0bocg0
 CBLNK0ACRQpQoZJKegM+WNdxHmQUGqRDjIzVfaQ8EzjRzaNz798ZvKdCy9cL7qGE
 BubCFxYGC78PMDfr3zfP3Ifas5Wxnx1ONAI7EVOpv1CUPgFl3Zxbg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunb5b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AEwoI0029714
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6up8ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AFEnhR12124638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 15:14:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 725812004D;
 Tue, 10 Mar 2026 15:14:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA6E42004B;
 Tue, 10 Mar 2026 15:14:47 +0000 (GMT)
Received: from Mac.com (unknown [9.39.23.49])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 15:14:47 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PULL 05/10] pnv/mpipl: Preserve CPU registers after crash
Date: Tue, 10 Mar 2026 20:44:25 +0530
Message-ID: <20260310151432.92531-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310151432.92531-1-harshpb@linux.ibm.com>
References: <20260310151432.92531-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: riAZ19tgrKJnQ54BtQe-lqKZDbDCQsl6
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b0356e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=nsAygp86oCIyxKH0w3IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMSBTYWx0ZWRfX2wqCey14mqVC
 kjrFiB66d9gNg6doXNgaZR6WbiUHi4on+H3mbN/tKJFR3f3+7sCLa+0mQKyrU9dw+Q+hucMcJWZ
 Px+h/PSQdZaY3d2RzGmhNTZxupTScioBAEns9YHb9IQioCz4ExQXfQhurg0ahmIWoeft0DGTRlu
 qLvXF4KRqb1wslaa8aVQE7HrPLZ+ejaBqzZWmfKKnsygHqM8W29PRqitpd6FuF2SH6+NXmdwjyp
 KFMBehgluOEo7BNOi8ec+a3HkcUwraMC9pk78YP3nX9nhJqS/n4WBO4YkiztVC7RTJgp4e76n9u
 26OlHfFThHyxrIdFvy0m27a5SGqSWjonHZCbAeBjL+gqEki1Af4hhMykFtEXIA7uXDzETKiGw2w
 fwKLl3FS0TR0vfbpVXJ4Do/moR0a2gTJEjHtitL489FgiA+M3rrEVnAyOW5hB1XWJkok7SMPjlN
 BaaZlQuHY4YhmvOuTqw==
X-Proofpoint-ORIG-GUID: riAZ19tgrKJnQ54BtQe-lqKZDbDCQsl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Aditya Gupta <adityag@linux.ibm.com>

Kernel expects the platform to provide CPU registers after pausing
execution of the CPUs.

Currently only exporting the registers, used by Linux, for generating
the /proc/vmcore

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260310124619.3909045-6-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/pnv_mpipl.h |  60 +++++++++++++++
 hw/ppc/pnv_mpipl.c         | 154 +++++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
index e0518ef2e1..a602d6bef4 100644
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
diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
index cef1fe2c40..308948b829 100644
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
-- 
2.52.0


