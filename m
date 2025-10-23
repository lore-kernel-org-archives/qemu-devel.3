Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214FFCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuJT-00040k-EQ; Thu, 23 Oct 2025 08:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGT-0001Py-IQ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:18:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGL-0006Ta-PO
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:56 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N5wO7o004814
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SHOv8a
 CPVVBUZ4TJUuYP+d/H3Z0VMw1ie/M0KiCcZSg=; b=eFRf0Df+tCFCZg8TKSCl3x
 Oz65/cCEnTZrV+rvYi9RxttmekbBHt+M4C6+RAVYtIExzYLS73/5FXKY8vN1yEe5
 wYLIvTXZFnfoDFbij0SkyQrBVBhfx6ZOvn2XHt51YTIACmKdfE1qFRaOwId5d1xh
 pP+vt0yZtwzhxvFtqgUcqhjKNo4qvKmZFCEfA9mA5zqloLSmJ7hYNXDsRmu/0BQx
 vfVS2IGxLrqaekaHnyi6arfNNUXq9LluXwCbqlYyL5DbwKbjIuCLRymKTCag3TsS
 Oh2Lx3jD3qj5BEgIf21ygJY50aDZmU8dEa5WEVh5aq3Ouh9iIHjnc0HtDRTMQOTQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32721ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9C5MV014685
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdtug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHXeZ33816832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49D2A20043;
 Thu, 23 Oct 2025 12:17:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DD1A20040;
 Thu, 23 Oct 2025 12:17:32 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:32 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 25/32] hw/ppc: Implement fadump register command
Date: Thu, 23 Oct 2025 17:46:44 +0530
Message-ID: <20251023121653.3686015-26-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa1ce1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=l8_VZ6W0Klpo2I8UYZoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0+dkrDW/LDQg
 pdSkoR2JuSS/skpPqrfKb81PGfOs5VUiEDmZhrwF1DFaWknzLQURXMvL5Df1/x23mJPXbDs0vK0
 KgpSL8S7zHy1EwkUUgdva4CaHNVoNMkAMCI5sbaKtSHsCfGqZ3HQBlxFosrTHHVlHH4byLBnvVF
 ZhOaSOxOOXKiL9qLTeQf49t1uiEh3881dq85AVjC1TaKEXRrEtUH0BfNOX5C/yIYGI6Dj5/HEeg
 B7+6dK+QJdKagTNTZqOiXwRPbX5JEV4Zj9GpXIIDx1umA+EYet3SpbMjBR4hHotgObl0gYJSPVi
 SVYf9ueMw2FlHGYINpBPM6/RZMSNbJeK+6Zf4uqpTroTDIfo/+1x61bTrKX/LDFwxaS//nqnANY
 gFPjm5FUbsTIcEoVmdNI23xwxf5mXA==
X-Proofpoint-GUID: rVMkilLtwszUdG0Wm5M5y7ZWDqPbqP3q
X-Proofpoint-ORIG-GUID: rVMkilLtwszUdG0Wm5M5y7ZWDqPbqP3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Add skeleton to handle "ibm,configure-kernel-dump" rtas call in QEMU,
including register, unregister and invalidate commands.

The register just verifies the structure of the fadump memory structure
passed by kernel, and set fadump_registered in spapr state to true.

Verify basic details mandated by the PAPR, such as number of
inputs/output, and add handling for the three fadump commands:
regiser/unregister/invalidate.

The checks are based on the table in following requirement in PAPR v2.13:
    "R1–7.3.30–1. For the Configure Platform Assisted Kernel Dump option ..."

Relevant section for the register command in PAPR is:
    Section 7.3.30: "ibm,configure-kernel-dump RTAS call" (PAPR v2.13)

Note: Any modifications made by the kernel to the fadump memory
structure after the 'ibm,configure-kernel-dump' RTAS call returns will
not be reflected in QEMU, as QEMU retains the fadump memory structure
that was provided during fadump registration.

The kernel must unregister and re-register fadump to apply any changes
to the fadump memory structure.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251021134823.1861675-2-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h        |  11 ++-
 include/hw/ppc/spapr_fadump.h |  69 +++++++++++++++++++
 hw/ppc/spapr_fadump.c         | 123 ++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c           |  71 ++++++++++++++++++++
 hw/ppc/meson.build            |   1 +
 5 files changed, 274 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/ppc/spapr_fadump.h
 create mode 100644 hw/ppc/spapr_fadump.c

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index b9d884745f..28cf2723d8 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -13,6 +13,7 @@
 #include "hw/ppc/xics.h"        /* For ICSState */
 #include "hw/ppc/spapr_tpm_proxy.h"
 #include "hw/ppc/spapr_nested.h" /* For SpaprMachineStateNested */
+#include "hw/ppc/spapr_fadump.h" /* For FadumpMemStruct */
 
 struct SpaprVioBus;
 struct SpaprPhbState;
@@ -267,6 +268,11 @@ struct SpaprMachineState {
     Error *fwnmi_migration_blocker;
 
     SpaprWatchdog wds[WDT_MAX_WATCHDOGS];
+
+    /* Fadump State */
+    bool fadump_registered;
+    bool fadump_dump_active;
+    FadumpMemStruct registered_fdm;
 };
 
 #define H_SUCCESS         0
@@ -692,6 +698,8 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 #define RTAS_OUT_PARAM_ERROR                    -3
 #define RTAS_OUT_NOT_SUPPORTED                  -3
 #define RTAS_OUT_NO_SUCH_INDICATOR              -3
+#define RTAS_OUT_DUMP_ALREADY_REGISTERED        -9
+#define RTAS_OUT_DUMP_ACTIVE                    -10
 #define RTAS_OUT_NOT_AUTHORIZED                 -9002
 #define RTAS_OUT_SYSPARM_PARAM_ERROR            -9999
 
@@ -754,8 +762,9 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
 #define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
 #define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
+#define RTAS_CONFIGURE_KERNEL_DUMP              (RTAS_TOKEN_BASE + 0x2D)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2E)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
new file mode 100644
index 0000000000..f64f339204
--- /dev/null
+++ b/include/hw/ppc/spapr_fadump.h
@@ -0,0 +1,69 @@
+/*
+ * Firmware Assisted Dump in PSeries
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef PPC_SPAPR_FADUMP_H
+#define PPC_SPAPR_FADUMP_H
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+/* Fadump commands */
+#define FADUMP_CMD_REGISTER            1
+#define FADUMP_CMD_UNREGISTER          2
+#define FADUMP_CMD_INVALIDATE          3
+
+#define FADUMP_VERSION                 1
+
+/*
+ * The Firmware Assisted Dump Memory structure supports a maximum of 10 sections
+ * in the dump memory structure. Presently, three sections are used for
+ * CPU state data, HPTE & Parameters area, while the remaining seven sections
+ * can be used for boot memory regions.
+ */
+#define FADUMP_MAX_SECTIONS            10
+
+typedef struct FadumpSection FadumpSection;
+typedef struct FadumpSectionHeader FadumpSectionHeader;
+typedef struct FadumpMemStruct FadumpMemStruct;
+
+struct SpaprMachineState;
+
+/* Kernel Dump section info */
+/* All fields are in big-endian */
+struct FadumpSection {
+    uint32_t    request_flag;
+    uint16_t    source_data_type;
+    uint16_t    error_flags;
+    uint64_t    source_address;
+    uint64_t    source_len;
+    uint64_t    bytes_dumped;
+    uint64_t    destination_address;
+};
+
+/* ibm,configure-kernel-dump header. */
+struct FadumpSectionHeader {
+    uint32_t    dump_format_version;
+    uint16_t    dump_num_sections;
+    uint16_t    dump_status_flag;
+    uint32_t    offset_first_dump_section;
+
+    /* Fields for disk dump option. */
+    uint32_t    dd_block_size;
+    uint64_t    dd_block_offset;
+    uint64_t    dd_num_blocks;
+    uint32_t    dd_offset_disk_path;
+
+    /* Maximum time allowed to prevent an automatic dump-reboot. */
+    uint32_t    max_time_auto;
+};
+
+/* Note: All the data in these structures is in big-endian */
+struct FadumpMemStruct {
+    FadumpSectionHeader header;
+    FadumpSection       rgn[FADUMP_MAX_SECTIONS];
+};
+
+uint32_t do_fadump_register(struct SpaprMachineState *, target_ulong);
+#endif /* PPC_SPAPR_FADUMP_H */
diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
new file mode 100644
index 0000000000..2c9f024c2d
--- /dev/null
+++ b/hw/ppc/spapr_fadump.c
@@ -0,0 +1,123 @@
+/*
+ * Firmware Assisted Dump in PSeries
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/ppc/spapr.h"
+
+/*
+ * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
+ *
+ * Note: Any changes made by the kernel to the fadump memory struct won't
+ * reflect in QEMU after the 'ibm,configure-kernel-dump' RTAS call has returned,
+ * as we store the passed fadump memory structure passed during fadump
+ * registration.
+ * Kernel has to invalidate & re-register fadump, if it intends to make any
+ * changes to the fadump memory structure
+ *
+ * Returns:
+ *  * RTAS_OUT_SUCCESS: On successful registration
+ *  * RTAS_OUT_PARAM_ERROR: If parameters are not correct, eg. too many
+ *                          sections, invalid memory addresses that we are
+ *                          unable to read, etc
+ *  * RTAS_OUT_DUMP_ALREADY_REGISTERED: Dump already registered
+ *  * RTAS_OUT_HW_ERROR: Misc issue such as memory access failures
+ */
+uint32_t do_fadump_register(SpaprMachineState *spapr, target_ulong args)
+{
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
+    if (spapr->fadump_dump_active) {
+        return RTAS_OUT_DUMP_ACTIVE;
+    }
+
+    if (fdm_size < sizeof(FadumpSectionHeader)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Header size is invalid: " TARGET_FMT_lu "\n", fdm_size);
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    /* Ensure fdm_addr points to a valid RMR-memory/RMA-memory buffer */
+    if ((fdm_addr <= 0) || ((fdm_addr + fdm_size) > spapr->rma_size)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Invalid fdm address: " TARGET_FMT_lu "\n", fdm_addr);
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    /* Try to read the passed fadump header */
+    io_result = address_space_read(default_as, fdm_addr, attrs,
+            &header, sizeof(header));
+    if (io_result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Unable to read fdm: " TARGET_FMT_lu "\n", fdm_addr);
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
+
+    return RTAS_OUT_SUCCESS;
+}
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 143bc8c379..6042fc72e5 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -344,6 +344,73 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
     rtas_st(rets, 0, ret);
 }
 
+/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
+static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   uint32_t token, uint32_t nargs,
+                                   target_ulong args,
+                                   uint32_t nret, target_ulong rets)
+{
+    target_ulong cmd = rtas_ld(args, 0);
+    uint32_t ret_val;
+
+    /* Number of outputs has to be 1 */
+    if (nret != 1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: ibm,configure-kernel-dump called with nret != 1.\n");
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    /* Number of inputs has to be 3 */
+    if (nargs != 3) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: ibm,configure-kernel-dump called with nargs != 3.\n");
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    switch (cmd) {
+    case FADUMP_CMD_REGISTER:
+        ret_val = do_fadump_register(spapr, args);
+        if (ret_val != RTAS_OUT_SUCCESS) {
+            rtas_st(rets, 0, ret_val);
+            return;
+        }
+        break;
+    case FADUMP_CMD_UNREGISTER:
+        if (spapr->fadump_dump_active) {
+            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
+            return;
+        }
+
+        spapr->fadump_registered = false;
+        spapr->fadump_dump_active = false;
+        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
+        break;
+    case FADUMP_CMD_INVALIDATE:
+        if (!spapr->fadump_dump_active) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "FADump: Nothing to invalidate, no dump active\n");
+
+            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        }
+
+        spapr->fadump_registered = false;
+        spapr->fadump_dump_active = false;
+        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "FADump: Unknown command: " TARGET_FMT_lu "\n", cmd);
+
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
 static void rtas_ibm_os_term(PowerPCCPU *cpu,
                             SpaprMachineState *spapr,
                             uint32_t token, uint32_t nargs,
@@ -659,6 +726,10 @@ static void core_rtas_register_types(void)
     spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
                         rtas_ibm_nmi_interlock);
 
+    /* Register fadump rtas call */
+    spapr_rtas_register(RTAS_CONFIGURE_KERNEL_DUMP, "ibm,configure-kernel-dump",
+                        rtas_configure_kernel_dump);
+
     qtest_set_command_cb(spapr_qtest_callback);
 }
 
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 170b90ae7d..6b7c1f4f49 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -26,6 +26,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
   'spapr_nvdimm.c',
   'spapr_rtas_ddw.c',
   'spapr_numa.c',
+  'spapr_fadump.c',
   'pef.c',
 ))
 ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
-- 
2.43.5


