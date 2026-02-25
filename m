Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF05FD3758
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvEID-0007Ih-6F; Wed, 25 Feb 2026 07:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEIB-0007Hq-8m; Wed, 25 Feb 2026 07:47:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEI9-0002GE-99; Wed, 25 Feb 2026 07:47:02 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61OJRG0a2032984; Wed, 25 Feb 2026 12:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=yCYp0dibDwAHYJwDS
 YO0E26O5qhckXkHqlRcHcJTTWc=; b=pNdHZHqjX5E198RpjzSkPmOj32omd6YWk
 AUbVzEPQ4GhW5/ipDiesHVs4jYEyTZmqLDPE9KrDKohfYxGolciGnJcwfPBtZbqk
 aeygxO3sZmQrMIvGgobRp2dOu2bO/pT/WZqy9Cs/rJC+FQ+X8XZAykSQFgaN3V8V
 OimxhJgacxmwCn2iYV0A36Ap0BuoeypJ1vZ3ENHdBslsifODKfBRSzaOifAdbQVg
 1NYaNM/Wt2Q5rdxNiNE6Xhl+vOvj3NDzqYTP1cW3cBXU+G+vGJKsuuW3oFu5ip2N
 BE0m5nFujBIp/BTmYJbL0pMff6K1l2sVRmoIuwMhZ8fmR1yl1kOHA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gfppu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 12:46:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61P8FNuO030259;
 Wed, 25 Feb 2026 12:46:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhkd82e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 12:46:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61PCksYd53281122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 12:46:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A505420043;
 Wed, 25 Feb 2026 12:46:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4F8E20040;
 Wed, 25 Feb 2026 12:46:51 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.222.235])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Feb 2026 12:46:51 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v3 05/10] pnv/mpipl: Preserve CPU registers after crash
Date: Wed, 25 Feb 2026 18:16:27 +0530
Message-ID: <20260225124633.1841222-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225124633.1841222-1-adityag@linux.ibm.com>
References: <20260225124633.1841222-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699eef43 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=brt73dwc2WLUf8B55FwA:9
X-Proofpoint-GUID: k6Ct_lpS3FZJIt8EBFioqoQsZGL44di8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMyBTYWx0ZWRfX+olntFnMqoaq
 N6QQIUM5rI1AWtcwU4qqcx0aWhoxZbT6yoHtV+36obIs/0ZVYkv3uVyrLSJkn9zW/syXSfNhr7X
 nJawHIopyz9kd83yUtulgnCkwPHTWagbthHsaXNnQA0BxL8AQfdK5uUVzyDduvtvxw6Szd7oL85
 b2+uE+DKXJEgFAQmyXiSKH2dMCaax85qlLZIUqFrV30Ay1PCk2i50vdMbmAG8/SkrnLazCxddH6
 vp0WUv4I9wEh9K1vQuhIUX4l38l8MCarQeCRL7DpdmpZdnG+ycj5MOphWB46uuAPyG5vv3cXl2j
 bAnKY3a6sj9J7Hvoto/oq3A+cunwfPctSxNCTRrbqY6h4mZ8Nkd/JBGegsHQ7zejDMI4zlh8y3J
 feo76naVi0qWoQ9nd0Q1K4bP8zJ6Rcm+kXXZi2KynR3lOo5VWPYugvr/O9Qf+CEzcjt276+rv2M
 z56gslTMmfR+wxxQtVg==
X-Proofpoint-ORIG-GUID: lOTMaZ2a_tiS4tNu9iskU34_ZyjbadSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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


