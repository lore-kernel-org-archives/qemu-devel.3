Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A67CFB44D6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGC4s-0004tO-54; Fri, 24 Apr 2026 04:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC4U-0004mW-Cd; Fri, 24 Apr 2026 04:39:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC4S-0005YT-8P; Fri, 24 Apr 2026 04:39:34 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NJd8Rv3229404; Fri, 24 Apr 2026 08:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9UbVaBHSsaJJHRuc6
 bRvTz0yLapktboekfF2dSz6h4Y=; b=THrad1fPLY2kLbwm/hIs50jMITfyDkfgd
 hH8p4xBUO4ryLOGbnEjOCI7X+z9rFaIrTF2Dwlqs9DF6L+kXNMXlrQ05rs29RVAh
 JB5QkhF7pYjCjli7vQnKR01c7MZqaOcHU7SrmGpZbiuKTfZtijENVQxlE6OlZEBW
 7e9L5qEH9E1D92VHBdFJvaFefB9iZXCCTLPSdDHbPSKTDklcsBgPbNDa55leuY4t
 LhCi/s8QbzaWu4Ihl4tr953eDn1QifbNaT399ZorzspG0Tw75nuB25r4A3MhgmU6
 DXqSHooiaPCdXujXzo5rC1pFcS+So9K3frJqcH+7FHF7cRXSZXwYQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2cwnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O8ZaJC015624;
 Fri, 24 Apr 2026 08:39:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkya3gc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63O8dPxP51577212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 08:39:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 727A32004D;
 Fri, 24 Apr 2026 08:39:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B2D320049;
 Fri, 24 Apr 2026 08:39:22 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.230]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 08:39:21 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v6 07/10] pnv/mpipl: Write the preserved CPU and MDRT state
Date: Fri, 24 Apr 2026 14:08:34 +0530
Message-ID: <20260424083837.214947-8-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424083837.214947-1-adityag@linux.ibm.com>
References: <20260424083837.214947-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vG0wH6Ndyat_IEkItvL5BOd02HCufNr_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA3NiBTYWx0ZWRfX06yS2T12BqLR
 AdWE+ZMw/j9ULhad8y18GgV/RDLRYVQdk7IBwi5GDl1cL6utOfo91V5DHK53qADz8fZBmFxT6/G
 JvbhfXFQ/3pUaM3Ok6n67md2z/OGqnnFbjlePbWRNzKM8b4LDI46131wQ/i3G0TsU8QLM1XKk01
 ajr8gDLtERgGgSApAkmIVt7/lmoRmF2j47q674QP+u1uTwuXXZDN6rf8NZeVYYcAlj8BuH5WdhZ
 1GhSakkJDn7KXfhK8/Tt3RyIRji8hrh31ypF4LeYpKVjw4shxlD8EEpBt36DNqU20R3lu4qoP6E
 ouLs+gpM65KFfXNs9AN7P/ToYAf2JWxzNMPWr7kN0PHYFl7BzeXUEToMBMHsl4dmWl9YnvhOYrT
 u+bnXEoRtQTrGNrX6XxTBiBZOOehNbiYjp8Y/h/ab0MxeExQb0l5XhjGT9H395Ci4UHDGITZprm
 o9i6ajsG8uFtt4Ixeug==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69eb2c42 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=FAZnT6m9RyNNhMT2MuIA:9
X-Proofpoint-ORIG-GUID: ER0xSbCrk1xDWAT1qvjvkhaH-e9wvSws
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Logic for preserving the CPU registers and memory regions has been done
in previous patches.

Write those data at the relevant memory address, such as PROC_DUMP_AREA
for CPU registers, and MDRT for preserved memory regions.

Also export "mpipl-boot" device tree node, for kernel to know that it's
a 'dump active' boot

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c         |  39 +++++++++++-
 hw/ppc/pnv_mpipl.c   | 140 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv.h |   1 +
 3 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 09b69c355a45..48f49bef8251 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -750,10 +750,47 @@ static void pnv_reset(MachineState *machine, ResetType type)
 {
     PnvMachineState *pnv = PNV_MACHINE(machine);
     void *fdt;
+    int node_offset;
+    bool mpipl_write_succeeded = false;
 
     qemu_devices_reset(type);
 
-    if (!pnv->mpipl_state.is_next_boot_mpipl) {
+    /*
+     * Only on success of writing MPIPL data will the next boot be provided
+     * "mpipl-boot" property in device tree
+     * Otherwise boot like a normal non-MPIPL boot
+     */
+    if (pnv->mpipl_state.is_next_boot_mpipl) {
+        /* Write the preserved MDRT and CPU State Data */
+        mpipl_write_succeeded = do_mpipl_write(pnv);
+    }
+
+    /*
+     * If it's a MPIPL boot, add the "mpipl-boot" property, and reset the
+     * boolean for MPIPL boot for next boot
+     */
+    if (mpipl_write_succeeded) {
+        void *fdt_copy = g_malloc0(FDT_MAX_SIZE);
+
+        /* Create a writable copy of the fdt */
+        _FDT((fdt_open_into(fdt, fdt_copy, FDT_MAX_SIZE)));
+
+        node_offset = fdt_path_offset(fdt_copy, "/ibm,opal/dump");
+        _FDT((fdt_appendprop_u64(fdt_copy, node_offset, "mpipl-boot", 1)));
+
+        /* Update the fdt, and free the original fdt */
+        if (fdt != machine->fdt) {
+            /*
+             * Only free the fdt if it's not machine->fdt, to prevent
+             * double free, since we already free machine->fdt later
+             */
+            g_free(fdt);
+        }
+        fdt = fdt_copy;
+
+        /* This boot is an MPIPL, reset the boolean for next boot */
+        pnv->mpipl_state.is_next_boot_mpipl = false;
+    } else {
         /*
          * Set the "Thread Register State Entry Size", so that firmware can
          * allocate enough memory to capture CPU state in the event of a
diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
index 308948b829cd..f5b228f5ba3c 100644
--- a/hw/ppc/pnv_mpipl.c
+++ b/hw/ppc/pnv_mpipl.c
@@ -20,6 +20,8 @@
     (pnv->mpipl_state.skiboot_base + MDST_TABLE_OFF)
 #define MDDT_TABLE_RELOCATED                            \
     (pnv->mpipl_state.skiboot_base + MDDT_TABLE_OFF)
+#define MDRT_TABLE_RELOCATED                            \
+    (pnv->mpipl_state.skiboot_base + MDRT_TABLE_OFF)
 #define PROC_DUMP_RELOCATED                             \
     (pnv->mpipl_state.skiboot_base + PROC_DUMP_AREA_OFF)
 
@@ -320,6 +322,139 @@ static bool pnv_mpipl_preserve_cpu_state(PnvMachineState *pnv)
     return true;
 }
 
+/*
+ * Write the preserved CPU state data in Processor Dump Area (PROC_DUMP_AREA)
+ *
+ * Returns true if everything went fine, else false for any error
+ */
+static bool pnv_mpipl_write_cpu_state(PnvMachineState *pnv)
+{
+    MpiplProcDumpArea *proc_area = &pnv->mpipl_state.proc_area;
+    MpiplPreservedCPUState *cpu_state = pnv->mpipl_state.cpu_states;
+    const uint32_t num_cpu_states = pnv->mpipl_state.num_cpu_states;
+    hwaddr next_regentries_hdr;
+    AddressSpace *default_as = &address_space_memory;
+    MemTxResult io_result;
+    MemTxAttrs attrs;
+
+    /* Mark the memory transactions as privileged memory access */
+    attrs.user = 0;
+    attrs.memory = 1;
+
+    if (be32_to_cpu(proc_area->alloc_size) <
+       (num_cpu_states * sizeof(MpiplPreservedCPUState))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "MPIPL: Size of buffer allocate by skiboot (%u bytes) is not"
+            "enough to save all CPUs registers needed (%zu bytes)",
+            be32_to_cpu(proc_area->alloc_size),
+            num_cpu_states * sizeof(MpiplPreservedCPUState));
+
+        return false;
+    }
+
+    proc_area->version = PROC_DUMP_AREA_VERSION_P9;
+
+    /*
+     * This is the stride kernel/firmware should use to jump from a
+     * register entries header to next CPU's header
+     */
+    proc_area->thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState));
+
+    /* Write the header and register entries for each CPU */
+    next_regentries_hdr = be64_to_cpu(proc_area->alloc_addr) & (~HRMOR_BIT);
+    for (int i = 0; i < num_cpu_states; ++i) {
+        io_result = address_space_write(default_as, next_regentries_hdr, attrs,
+            &cpu_state->hdr, sizeof(MpiplRegDataHdr));
+        if (io_result != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "MPIPL: Failed to write RegEntries Header\n");
+            return false;
+        }
+
+        io_result = address_space_write(default_as,
+            next_regentries_hdr + sizeof(MpiplRegDataHdr), attrs,
+            &cpu_state->reg_entries,
+            NUM_REGS_PER_CPU * (sizeof(MpiplRegEntry)));
+        if (io_result != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "MPIPL: Failed to write Register Entries\n");
+            return false;
+        }
+
+        /*
+         * According to HDAT section:
+         *  "15.3.1.5 Architected Register Data content":
+         *
+         * The next register entries header will be at current header +
+         * "Thread Register State Entry size"
+         *
+         * Note: proc_area.thread_size == sizeof(MpiplPreservedCPUState)
+         */
+        next_regentries_hdr += sizeof(MpiplPreservedCPUState);
+        ++cpu_state;
+    }
+
+    /* Point the destination address to the preserved memory region */
+    proc_area->dest_addr = proc_area->alloc_addr;
+    proc_area->act_size  = cpu_to_be32(num_cpu_states *
+            sizeof(MpiplPreservedCPUState));
+
+    io_result = address_space_write(default_as, PROC_DUMP_AREA_OFF, attrs,
+        proc_area, sizeof(MpiplProcDumpArea));
+    if (io_result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "MPIPL: Failed to write Register Entries\n");
+        return false;
+    }
+
+    return true;
+}
+
+/*
+ * Write the preserved MDRT table, representing preserved memory regions
+ *
+ * Returns true if everything went fine, else false for any error
+ */
+static bool pnv_mpipl_write_mdrt(PnvMachineState *pnv)
+{
+    MpiplPreservedState *state = &pnv->mpipl_state;
+    AddressSpace *default_as = &address_space_memory;
+    MemTxResult io_result;
+    MemTxAttrs attrs;
+
+    /* Mark the memory transactions as privileged memory access */
+    attrs.user = 0;
+    attrs.memory = 1;
+
+    /*
+     * Generally writes from platform during MPIPL don't go to a relocated
+     * skiboot address
+     *
+     * Though for MDRT we are doing so, as this is the address skiboot
+     * considers by default for MDRT
+     *
+     * MDRT/MDST/MDDT base addresses are actually meant to be shared by
+     * platform in SPIRA structures.
+     *
+     * Not implementing SPIRA as it increases complexity for no gains.
+     * Using the default address skiboot expects for MDRT, which is the
+     * relocated MDRT, hence writing to it
+     *
+     * Other tables like MDST/MDDT should not be written to relocated
+     * addresses, as skiboot will overwrite anything from SKIBOOT_BASE till
+     * SKIBOOT_BASE+SKIBOOT_SIZE (which is 0x30000000-0x31c00000 by default)
+     */
+    io_result = address_space_write(default_as, MDRT_TABLE_RELOCATED, attrs,
+            state->mdrt_table,
+            state->num_mdrt_entries * sizeof(MdrtTableEntry));
+    if (io_result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR, "MPIPL: Failed to write MDRT table\n");
+        return false;
+    }
+
+    return true;
+}
+
 void do_mpipl_preserve(PnvMachineState *pnv)
 {
     pause_all_vcpus();
@@ -340,3 +475,8 @@ void do_mpipl_preserve(PnvMachineState *pnv)
      */
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
 }
+
+bool do_mpipl_write(PnvMachineState *pnv)
+{
+    return pnv_mpipl_write_mdrt(pnv) && pnv_mpipl_write_cpu_state(pnv);
+}
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 79de6b856923..88f44950fc69 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -296,5 +296,6 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
 
 /* MPIPL helpers */
 void do_mpipl_preserve(PnvMachineState *pnv);
+bool do_mpipl_write(PnvMachineState *pnv);
 
 #endif /* PPC_PNV_H */
-- 
2.53.0


