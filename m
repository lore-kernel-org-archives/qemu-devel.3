Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BFEC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 19:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsoA3-0002rG-BO; Thu, 13 Mar 2025 15:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsoA0-0002oV-4a; Thu, 13 Mar 2025 15:24:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tso9y-0000tB-47; Thu, 13 Mar 2025 15:24:03 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGo6Ja030511;
 Thu, 13 Mar 2025 19:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ImNWkpaXEqwbMy5GC
 rrvtrhO9XfnFlcOfSdaOM9TASc=; b=kKs4xzV4py7ag27RZdsf2spyleIQWtuz+
 tJmdRrnJfhmsfDk+mtyK/jrYRuVG1ymD+helLOp4yiDkiz5xN69zPeNnOK222E5D
 M5StLL2lw5bY8eZV8bvlWJl0y/NavPG8vmWvtjOqaci9CH+9yRcYu0uavvGdtB81
 NVw4n9ZlyO4zgZJi1rl6penNFiWLW+2DR6qECgZMhSSlWWQp5fI1DYIDRDMd25l7
 dyxzhDO4DpW5R6uj6XBrJ40OzYhA4I+eTaiGhINPsZbWRsu/9d8sG66a0vEYYoFJ
 s/5C7DdfkQRJvKK52cmKM5YigvY/pVIp2jgqwOqLb3F0sNZl+MGHA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bqr94hmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:24:00 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52DJLlQ0018299;
 Thu, 13 Mar 2025 19:23:59 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bqr94hmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:23:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52DJGFX4003131;
 Thu, 13 Mar 2025 19:23:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atstufty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:23:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52DJNt0O55443762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 19:23:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4609020040;
 Thu, 13 Mar 2025 19:23:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9B1E20043;
 Thu, 13 Mar 2025 19:23:52 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.223.53]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 19:23:52 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v2 2/8] hw/ppc: Implement fadump register command
Date: Fri, 14 Mar 2025 00:53:35 +0530
Message-ID: <20250313192341.132171-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313192341.132171-1-adityag@linux.ibm.com>
References: <20250313192341.132171-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L043ooWYTV3w8cMu08fdEk_xOxRu5Zb7
X-Proofpoint-ORIG-GUID: xPr2PFyp4ne4exwT_ZTURs1ieU8hjQOC
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

Implement the register command of "ibm,configure-kernel-dump" RTAS call.
The register just verifies the structure of the fadump memory structure
passed by kernel, and set fadump_registered in spapr state to true.

We also store the passed fadump memory structure, which will later be
used for preserving memory for fadump boot in case of a crash.

The fadump memory structure isn't modified (other than .dump_status_flag
after the fadump is triggered, that is in a later patch).
So if the structure needs to updated, the kernel should first
de-register and re-register the structure again.

Relevant section for the register command in PAPR is:
    Section 7.3.30: "ibm,configure-kernel-dump RTAS call" (PAPR v2.13)

Note: The fadump registration is done, but triggering fadump on an
os-term rtas call is done in later patches. Hence QEMU will just shutdown
on a kernel crash due to no special handling for fadump in ibm,os-term

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/spapr_fadump.c         | 111 ++++++++++++++++++++++++++++++++--
 hw/ppc/spapr_rtas.c           |   2 +-
 include/hw/ppc/spapr_fadump.h |   2 +-
 3 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index 20b7b804c485..9c7fb9e12b16 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -5,18 +5,119 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/ppc/spapr.h"
 
 /*
  * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
  *
+ * Note: Any changes made by the kernel to the fadump memory struct won't
+ * reflect in QEMU after the 'ibm,configure-kernel-dump' RTAS call has returned,
+ * as we store the passed fadump memory structure passed during fadump
+ * registration.
+ * Kernel has to invalidate & re-register fadump, if it intends to make any
+ * changes to the fadump memory structure
+ *
  * Returns:
- *  * RTAS_OUT_HW_ERROR: Not implemented/Misc issue such as memory access
- *                       failures
+ *  * RTAS_OUT_SUCCESS: On successful registration
+ *  * RTAS_OUT_PARAM_ERROR: If parameters are not correct, eg. too many
+ *                          sections, invalid memory addresses that we are
+ *                          unable to read, etc
+ *  * RTAS_OUT_DUMP_ALREADY_REGISTERED: Dump already registered
+ *  * RTAS_OUT_HW_ERROR: Misc issue such as memory access failures
  */
-uint32_t do_fadump_register(void)
+uint32_t do_fadump_register(SpaprMachineState *spapr, target_ulong args)
 {
-    /* WIP: FADUMP_CMD_REGISTER implemented in future patch */
+    FadumpSectionHeader header;
+    FadumpSection regions[FADUMP_MAX_SECTIONS] = {0};
+    target_ulong fdm_addr = rtas_ld(args, 1);
+    target_ulong fdm_size = rtas_ld(args, 2);
+    AddressSpace *default_as = &address_space_memory;
+    MemTxResult io_result;
+    MemTxAttrs attrs;
+    uint64_t next_section_addr;
+    uint16_t dump_num_sections;
+
+    /* Mark the memory transaction as privileged memory access */
+    attrs.user = 0;
+    attrs.memory = 1;
+
+    if (spapr->fadump_registered) {
+        /* FADump already registered */
+        return RTAS_OUT_DUMP_ALREADY_REGISTERED;
+    }
+
+    if (spapr->fadump_dump_active == 1) {
+        return RTAS_OUT_DUMP_ACTIVE;
+    }
+
+    if (fdm_size < sizeof(FadumpSectionHeader)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Header size is invalid: %lu\n", fdm_size);
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    /* Ensure fdm_addr points to a valid RMR-memory/RMA-memory buffer */
+    if ((fdm_addr <= 0) || ((fdm_addr + fdm_size) > spapr->rma_size)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Invalid fdm address: %ld\n", fdm_addr);
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    /* Try to read the passed fadump header */
+    io_result = address_space_read(default_as, fdm_addr, attrs,
+            &header, sizeof(header));
+    if (io_result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Unable to read fdm address: %ld\n", fdm_addr);
+
+        return RTAS_OUT_HW_ERROR;
+    }
+
+    /* Verify that we understand the fadump header version */
+    if (header.dump_format_version != cpu_to_be32(FADUMP_VERSION)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Unknown fadump header version: 0x%x\n",
+            header.dump_format_version);
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    /* Reset dump status flags */
+    header.dump_status_flag = 0;
+
+    dump_num_sections = be16_to_cpu(header.dump_num_sections);
+
+    if (dump_num_sections > FADUMP_MAX_SECTIONS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Too many sections: %d sections\n", dump_num_sections);
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    next_section_addr =
+        fdm_addr +
+        be32_to_cpu(header.offset_first_dump_section);
+
+    for (int i = 0; i < dump_num_sections; ++i) {
+        /* Read the fadump section from memory */
+        io_result = address_space_read(default_as, next_section_addr, attrs,
+                &regions[i], sizeof(regions[i]));
+        if (io_result != MEMTX_OK) {
+            qemu_log_mask(LOG_UNIMP,
+                "FADump: Unable to read fadump %dth section\n", i);
+            return RTAS_OUT_PARAM_ERROR;
+        }
+
+        next_section_addr += sizeof(regions[i]);
+    }
+
+    spapr->fadump_registered = true;
+    spapr->fadump_dump_active = false;
+
+    /* Store the registered fadump memory struct */
+    spapr->registered_fdm.header = header;
+    for (int i = 0; i < dump_num_sections; ++i) {
+        spapr->registered_fdm.rgn[i] = regions[i];
+    }
 
-    return RTAS_OUT_HW_ERROR;
+    return RTAS_OUT_SUCCESS;
 }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index b8bfa9c33fb5..0454938a01e9 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -366,7 +366,7 @@ static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
 
     switch (cmd) {
     case FADUMP_CMD_REGISTER:
-        ret_val = do_fadump_register();
+        ret_val = do_fadump_register(spapr, args);
         if (ret_val != RTAS_OUT_SUCCESS) {
             rtas_st(rets, 0, ret_val);
             return;
diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
index 45109fd9e137..6abbcb44f353 100644
--- a/include/hw/ppc/spapr_fadump.h
+++ b/include/hw/ppc/spapr_fadump.h
@@ -65,5 +65,5 @@ struct FadumpMemStruct {
     FadumpSection       rgn[FADUMP_MAX_SECTIONS];
 };
 
-uint32_t do_fadump_register(void);
+uint32_t do_fadump_register(struct SpaprMachineState *, target_ulong);
 #endif /* PPC_SPAPR_FADUMP_H */
-- 
2.48.1


