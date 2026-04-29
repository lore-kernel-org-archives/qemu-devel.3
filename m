Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25149FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHym8-0002bH-45; Wed, 29 Apr 2026 02:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wHym2-0002as-Q8; Wed, 29 Apr 2026 02:51:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wHym0-0008Nq-Ve; Wed, 29 Apr 2026 02:51:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T606XY1892388; Wed, 29 Apr 2026 06:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ackvfLE23OIA3/Emi6Nwt4GfZWO3HPJBwLWkv/WbH
 m8=; b=tUbsbUr34HQN0kkNbWz7DCJUstqxGngXPtMT3yiLd/rSpdJcIF6KvCd2A
 IyYU/DNA38fpMmCFeeCO2W0y/6G73DFoS6C/P28N6K1hSKIfncUl6GvD8h1x/408
 Hk43ExpFLrRGByl17JXGOPUBwQPhuSJH86atrDSDn46w6HaG21SRYQccyCfTHqJ4
 bLXMZzY5vA8NaHYs8HSQPbvQlDF2mNSBtkJT5SmJvzDtdFShge0z3ZtfdSnIIr35
 3cHmLMEWfBNKbeTQB0kc2IvncCOX/NQnugyVdDThpHu9Get4iX+nT7i2xz0BRLG+
 F9tzPQqnxHS84birShGhnSNJwgQ9A==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1dyu68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 06:51:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63T6cnst018790;
 Wed, 29 Apr 2026 06:51:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avwa2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 06:51:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63T6pi7949545656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 06:51:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83EED20043;
 Wed, 29 Apr 2026 06:51:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A99DD20040;
 Wed, 29 Apr 2026 06:51:42 +0000 (GMT)
Received: from shivang.com (unknown [9.123.12.247])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 06:51:42 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: [PATCH] ppc/spapr: make fadump collect regs for maxcpus
Date: Wed, 29 Apr 2026 12:21:27 +0530
Message-ID: <20260429065127.366813-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dJdOv-P-JoEwq5jzLy4p0RLSqsO0pNSy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NiBTYWx0ZWRfX8hlaRZaHH2HK
 52jJyErWtNCire8YHR0Sy1bz24TPaBW4GtIDLrzxii320W7riwdgr+8U1Cj99h5IiE+l3cNEaaH
 pHlv48ZGEJK8MpFmwrro2DhqZBRRVO+OX7IJw6EI8kJZ7M0cDryxtjWKD6GuKYJ8OVGXoPiSuaw
 VOhY4JfZv0Rhzt0wIpSzn0kSZTdqnrDbuqbTqk3RXGZcSIY/BeTlMDO11LtasaODyNpKh1hne4q
 DSHAZtw/WfrT6P9MFMjtLlaWbEVGaosFE3/f142PObRWiu/Hgn/2gxLAqWm0yX3MjIWOCQ8J2A6
 8ioW4aqWV5NI82RSFpVXiyMnNl0D7XZtAmX4Y75O/8oLSxUcNW3uGV9BDOC1n1ocnkywY+jhVsH
 oV5XTOzrtX3PaiZWYtunCshhQmVn3jSfl1DlSDOn3cC38E6baGHOvPe3ScKS76NRrTzN03sSv0S
 DJR/GJgu4yKibC4UMow==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f1aa86 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=RuK-KQVcXEPILYYYT2UA:9
X-Proofpoint-GUID: dJdOv-P-JoEwq5jzLy4p0RLSqsO0pNSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290066
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

When a ppc machine is started with maxcpus greater than the number of
present CPUs (e.g., -smp cpus=2,maxcpus=8), firmware allocates the CPU
state data buffer based on maxcpus and advertises this size to the
kernel during fadump registration.

However, fadump currently fails to generate a vmcore during the
rebooted kernel because:

1. The CPU state buffer length does not match what firmware advertised
   (QEMU only populates entries for present CPUs, not maxcpus)
2. The kernel cannot find CPU data for all maxcpus slots

This patch adds placeholder entries for the unrealized cpus.
The placeholder entries contain only the CPUSTRT and CPUEND markers
with the CPU ID, which is sufficient for the kernel to recognize the
CPU slot exists even though the CPU was never realized.

This ensures the CPU state buffer size and structure matches what
firmware advertised to the kernel, allowing fadump to successfully
generate vmcore.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 hw/ppc/spapr_fadump.c | 57 +++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index 13cab0cfe1..b1a21ff115 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -309,6 +309,30 @@ static bool do_preserve_region(FadumpSection *region)
     return true;
 }
 
+/*
+ * Populate placeholder register entries for an unrealized CPU
+ *
+ * For CPUs that are not realized (cpu_index < maxcpus), we need to
+ * create minimal register entries containing only CPUSTRT and CPUEND
+ * markers to maintain the expected buffer structure.
+ *
+ * Returns pointer just past the placeholder entries, which can be used
+ * as the start address for the next CPU's register entries
+ */
+static FadumpRegEntry *populate_cpu_reg_entries_placeholder(int cpu_id,
+                                                             FadumpRegEntry *curr_reg_entry)
+{
+    curr_reg_entry->reg_id = cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
+    curr_reg_entry->reg_value = cpu_to_be64(cpu_id & FADUMP_CPU_ID_MASK);
+    ++curr_reg_entry;
+
+    curr_reg_entry->reg_id = cpu_to_be64(fadump_str_to_u64("CPUEND"));
+    curr_reg_entry->reg_value = cpu_to_be64(cpu_id & FADUMP_CPU_ID_MASK);
+    ++curr_reg_entry;
+
+    return curr_reg_entry;
+}
+
 /*
  * Populate the passed CPUs register entries, in the buffer starting at
  * the argument 'curr_reg_entry'
@@ -450,7 +474,7 @@ static FadumpRegEntry *populate_cpu_reg_entries(CPUState *cpu,
  * callers), and sets the size of this buffer in the argument
  * 'cpu_state_len'
  */
-static void *get_cpu_state_data(uint64_t *cpu_state_len)
+static void *get_cpu_state_data(uint64_t *cpu_state_len, MachineState *ms)
 {
     FadumpRegSaveAreaHeader reg_save_hdr;
     g_autofree FadumpRegEntry *reg_entries = NULL;
@@ -459,15 +483,11 @@ static void *get_cpu_state_data(uint64_t *cpu_state_len)
 
     uint32_t num_reg_entries;
     uint32_t reg_entries_size;
-    uint32_t num_cpus = 0;
+    uint32_t num_cpus = ms->smp.max_cpus;
 
     void *cpu_state_buffer = NULL;
     uint64_t offset = 0;
 
-    CPU_FOREACH(cpu) {
-        ++num_cpus;
-    }
-
     reg_save_hdr.version = cpu_to_be32(0);
     reg_save_hdr.magic_number =
         cpu_to_be64(fadump_str_to_u64("REGSAVE"));
@@ -484,10 +504,20 @@ static void *get_cpu_state_data(uint64_t *cpu_state_len)
     /* Pointer to current CPU's registers */
     curr_reg_entry = reg_entries;
 
-    /* Populate register entries for all CPUs */
-    CPU_FOREACH(cpu) {
-        cpu_synchronize_state(cpu);
-        curr_reg_entry = populate_cpu_reg_entries(cpu, curr_reg_entry);
+    /*
+     * Populate register entries for all CPU slots (0 to maxcpus-1)
+     */
+    for (int i = 0; i < num_cpus; i++) {
+        cpu = qemu_get_cpu(i);
+        if (cpu) {
+            /* CPU is realized - populate full register entries */
+            cpu_synchronize_state(cpu);
+            curr_reg_entry = populate_cpu_reg_entries(cpu, curr_reg_entry);
+        } else {
+            /* CPU slot is empty - populate placeholder entries */
+            curr_reg_entry = populate_cpu_reg_entries_placeholder(i,
+                                                                   curr_reg_entry);
+        }
     }
 
     *cpu_state_len = 0;
@@ -526,7 +556,7 @@ static void *get_cpu_state_data(uint64_t *cpu_state_len)
  * such as invalid destination address or non-fatal error errors likely
  * caused due to invalid parameters, return true and set region->error_flags
  */
-static bool do_populate_cpu_state(FadumpSection *region)
+static bool do_populate_cpu_state(FadumpSection *region, MachineState *ms)
 {
     uint64_t dest_addr = be64_to_cpu(region->destination_address);
     uint64_t cpu_state_len = 0;
@@ -541,7 +571,7 @@ static bool do_populate_cpu_state(FadumpSection *region)
     attrs.user = 0;
     attrs.memory = 1;
 
-    cpu_state_buffer  = get_cpu_state_data(&cpu_state_len);
+    cpu_state_buffer  = get_cpu_state_data(&cpu_state_len, ms);
 
     io_result = address_space_write(default_as, dest_addr, attrs,
             cpu_state_buffer, cpu_state_len);
@@ -597,6 +627,7 @@ static bool do_populate_cpu_state(FadumpSection *region)
 static bool fadump_preserve_mem(SpaprMachineState *spapr)
 {
     FadumpMemStruct *fdm = &spapr->registered_fdm;
+    MachineState *ms = MACHINE(spapr);
     uint16_t dump_num_sections, data_type;
 
     assert(spapr->fadump_registered);
@@ -627,7 +658,7 @@ static bool fadump_preserve_mem(SpaprMachineState *spapr)
 
         switch (data_type) {
         case FADUMP_CPU_STATE_DATA:
-            if (!do_populate_cpu_state(&fdm->rgn[i])) {
+            if (!do_populate_cpu_state(&fdm->rgn[i], ms)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                     "FADump: Failed to store CPU State Data");
                 fdm->header.dump_status_flag |=
-- 
2.53.0


