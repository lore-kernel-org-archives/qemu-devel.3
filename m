Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E72CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuKz-0006Jo-U0; Thu, 23 Oct 2025 08:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGW-0001Qb-3l
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:18:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGP-0006UT-Af
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N747uR019199
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=G5m1HjdetVDWVXHFj
 JnYfx+Onlw+MmmbV4Ew3Z6582w=; b=YhfEcBIPmj1bruZHaANRf3FpiS72evShJ
 AlmF/1SRsSZljK7IdZ79xMaz9WJ0jf74jou+YZS7jikYgNYK52GE/DmvRc1Cmthm
 4SIWU8uVYrW6w39xF+J+hVADhP0MoVi4GMZSPy2E9DyjasJ//t98aS+e8GNhbK4X
 EHBD8NWmJS+OX1zySQyIvaV7QoQKetEWe16+DZdPuGUyhCMQR01MMOPgj5erBDY2
 IleyakcIfqc/TFJFSSgdhu+Lkn7vCw6TylLt9WHKM1siNWaHiCDjoRNLq3TDS1Ks
 U290pksXevIQOSw7c5BdFgmXkBLpQ2YBvjpIShKU0VligX/Ig2ZvA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hrgjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NBAWLj002367
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejne53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHb5I8323486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CC4620043;
 Thu, 23 Oct 2025 12:17:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6135C20040;
 Thu, 23 Oct 2025 12:17:36 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:36 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 28/32] hw/ppc: Implement saving CPU state in Fadump
Date: Thu, 23 Oct 2025 17:46:47 +0530
Message-ID: <20251023121653.3686015-29-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX8jCzRsDQfcXR
 i+6WmhmjLymarziZPdKkz34g/mtbXzZSj1B5DQMyuUyPB5VJKIXKs9B3YvtuCoJyoS3N66b5cW5
 ukQitDoD2O4CliO44olvaQDYX3aaJ23TSPOFOS4yU8ezqE+GBjLo2rvdoKxuBGHsA2R1o8V46Uv
 lxu37JxPzEButfPskryTTSMtzDqMjH46iIDsaUYuURXPQRdo/4TfAXTcyVAxSzD0T1w0UHBFFnQ
 Kl48EjIsRu13VaKQTEIj9WOKHVD0+HbKV5aDQ4xJCi5HjHw+ypzy8tMZgVhhynrT0TTKYAEnUfF
 BWyDPEhKzc96YL1fzjgbXzvl9ZXJweC9bfF1otHO2Ka8rGmGXHnb/Z+0W1RhLcHUlJ3K4eDzROO
 oU9VV9s20FNAc9ppw1GxFpLdDmtlBQ==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fa1ce6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=zxgWIWaIXYGjLxZ_zYYA:9
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: pfhxxGsa-a-NlsxSfO3-suPYiFAn7wD4
X-Proofpoint-ORIG-GUID: pfhxxGsa-a-NlsxSfO3-suPYiFAn7wD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Aditya Gupta <adityag@linux.ibm.com>

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

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251021134823.1861675-5-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr_fadump.h |  31 +++
 hw/ppc/spapr_fadump.c         | 361 +++++++++++++++++++++++++++++++++-
 2 files changed, 390 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
index 71be2ad92c..fde2830e94 100644
--- a/include/hw/ppc/spapr_fadump.h
+++ b/include/hw/ppc/spapr_fadump.h
@@ -47,9 +47,17 @@
  */
 #define FADUMP_MAX_SECTIONS            10
 
+/* Number of register entries stored per cpu */
+#define FADUMP_PER_CPU_REG_ENTRIES (32 /*GPR*/ + 45 /*others*/ + 2 /*STRT & END*/)
+
+/* Mask of CPU ID in CPUSTRT and CPUEND entries */
+#define FADUMP_CPU_ID_MASK      ((1ULL << 32) - 1)
+
 typedef struct FadumpSection FadumpSection;
 typedef struct FadumpSectionHeader FadumpSectionHeader;
 typedef struct FadumpMemStruct FadumpMemStruct;
+typedef struct FadumpRegSaveAreaHeader FadumpRegSaveAreaHeader;
+typedef struct FadumpRegEntry FadumpRegEntry;
 
 struct SpaprMachineState;
 
@@ -88,6 +96,29 @@ struct FadumpMemStruct {
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
+    uint64_t    magic_number;
+    uint32_t    version;
+    uint32_t    num_cpu_offset;
+};
+
+/* Register entry. */
+struct FadumpRegEntry {
+    uint64_t    reg_id;
+    uint64_t    reg_value;
+};
+
 uint32_t do_fadump_register(struct SpaprMachineState *, target_ulong);
 void     trigger_fadump_boot(struct SpaprMachineState *, target_ulong);
 #endif /* PPC_SPAPR_FADUMP_H */
diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index 5068a9d83d..fdd4929148 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -9,8 +9,73 @@
 #include "hw/ppc/spapr.h"
 #include "qemu/units.h"
 #include "system/cpus.h"
+#include "system/hw_accel.h"
 #include <math.h>
 
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
+
 /*
  * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
  *
@@ -243,7 +308,291 @@ static bool do_preserve_region(FadumpSection *region)
     return true;
 }
 
-/* Preserve the memory locations registered for fadump */
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
+    /*
+     * CPUSTRT and CPUEND register entries follow this format:
+     *
+     * 8 Bytes Reg ID (BE) | 4 Bytes (0x0) | 4 Bytes Logical CPU ID (BE)
+     */
+    curr_reg_entry->reg_id =
+        cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
+    curr_reg_entry->reg_value = cpu_to_be64(
+            ppc_cpu->vcpu_id & FADUMP_CPU_ID_MASK);
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
+    curr_reg_entry->reg_value = cpu_to_be64(
+            ppc_cpu->vcpu_id & FADUMP_CPU_ID_MASK);
+
+    /*
+     * Ensure number of register entries saved matches the expected
+     * 'FADUMP_PER_CPU_REG_ENTRIES' count
+     *
+     * This will help catch an error if in future a new register entry
+     * is added/removed while not modifying FADUMP_PER_CPU_REG_ENTRIES
+     */
+    assert(FADUMP_PER_CPU_REG_ENTRIES == num_regs_per_cpu + 2 /*CPUSTRT+CPUEND*/);
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
+static void *get_cpu_state_data(uint64_t *cpu_state_len)
+{
+    FadumpRegSaveAreaHeader reg_save_hdr;
+    FadumpRegEntry *reg_entries;
+    FadumpRegEntry *curr_reg_entry;
+    CPUState *cpu;
+
+    uint32_t num_reg_entries;
+    uint32_t reg_entries_size;
+    uint32_t num_cpus = 0;
+
+    void *cpu_state_buffer = NULL;
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
+    num_reg_entries = num_cpus * FADUMP_PER_CPU_REG_ENTRIES;
+    reg_entries_size = num_reg_entries * sizeof(FadumpRegEntry);
+
+    reg_entries = g_new(FadumpRegEntry, num_reg_entries);
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
+    *cpu_state_len += reg_entries_size;         /* reg entries */
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
+    memcpy(cpu_state_buffer + offset, reg_entries, reg_entries_size);
+    offset += reg_entries_size;
+
+    return cpu_state_buffer;
+}
+
+/*
+ * Save the CPU State Data (aka "Register Save Area") in given region
+ *
+ * Region argument is expected to be of CPU_STATE_DATA type
+ *
+ * Returns false only in case of Hardware Error, such as failure to
+ * read/write a valid address.
+ *
+ * Otherwise, even in case of unsuccessful copy of CPU state data for reasons
+ * such as invalid destination address or non-fatal error errors likely
+ * caused due to invalid parameters, return true and set region->error_flags
+ */
+static bool do_populate_cpu_state(FadumpSection *region)
+{
+    uint64_t dest_addr = be64_to_cpu(region->destination_address);
+    uint64_t cpu_state_len = 0;
+    g_autofree void *cpu_state_buffer = NULL;
+    AddressSpace *default_as = &address_space_memory;
+    MemTxResult io_result;
+    MemTxAttrs attrs;
+
+    assert(region->source_data_type == cpu_to_be16(FADUMP_CPU_STATE_DATA));
+
+    /* Mark the memory transaction as privileged memory access */
+    attrs.user = 0;
+    attrs.memory = 1;
+
+    cpu_state_buffer  = get_cpu_state_data(&cpu_state_len);
+
+    io_result = address_space_write(default_as, dest_addr, attrs,
+            cpu_state_buffer, cpu_state_len);
+    if ((io_result & MEMTX_DECODE_ERROR) ||
+        (io_result & MEMTX_ACCESS_ERROR)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Failed to decode/access address in CPU State Region's"
+            " destination address: 0x%016" PRIx64 "\n", dest_addr);
+
+        /*
+         * Invalid source address is not an hardware error, instead
+         * wrong parameter from the kernel.
+         * Return true to let caller know to continue reading other
+         * sections
+         */
+        region->error_flags = FADUMP_ERROR_INVALID_SOURCE_ADDR;
+        region->bytes_dumped = 0;
+        return true;
+    } else if (io_result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Failed to write CPU state region.\n");
+
+        return false;
+    }
+
+    /*
+     * Set bytes_dumped in cpu state region, so kernel knows platform have
+     * exported it
+     */
+    region->bytes_dumped = cpu_to_be64(cpu_state_len);
+
+    if (region->source_len != region->bytes_dumped) {
+        /*
+         * Log the error, but don't fail the dump collection here, let
+         * kernel handle the mismatch
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "FADump: Mismatch in CPU State region's length exported:"
+                " Kernel expected: 0x%" PRIx64 " bytes,"
+                " QEMU exported: 0x%" PRIx64 " bytes\n",
+                be64_to_cpu(region->source_len),
+                be64_to_cpu(region->bytes_dumped));
+    }
+
+    return true;
+}
+
+/*
+ * Preserve the memory locations registered for fadump
+ *
+ * Returns false only in case of RTAS_OUT_HW_ERROR, otherwise true
+ */
 static bool fadump_preserve_mem(SpaprMachineState *spapr)
 {
     FadumpMemStruct *fdm = &spapr->registered_fdm;
@@ -277,7 +626,15 @@ static bool fadump_preserve_mem(SpaprMachineState *spapr)
 
         switch (data_type) {
         case FADUMP_CPU_STATE_DATA:
-            /* TODO: Add CPU state data */
+            if (!do_populate_cpu_state(&fdm->rgn[i])) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                    "FADump: Failed to store CPU State Data");
+                fdm->header.dump_status_flag |=
+                    cpu_to_be16(FADUMP_STATUS_DUMP_ERROR);
+
+                return false;
+            }
+
             break;
         case FADUMP_HPTE_REGION:
             /* TODO: Add hpte state data */
-- 
2.43.5


