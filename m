Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD440C35FF1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 19:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsoA0-0002oQ-5S; Thu, 13 Mar 2025 15:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tso9y-0002n5-J8; Thu, 13 Mar 2025 15:24:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tso9w-0000sw-Fu; Thu, 13 Mar 2025 15:24:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGo44T030318;
 Thu, 13 Mar 2025 19:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KdSC/2
 SwrQzJeucHQAe5URjKPn9snhPM4o+bwfM/pec=; b=pmuhwmrkndYKba4wVd9xzc
 s2irSMVmsPZisKib0sTZfUetkb90pyzKbAxAjOi63+X4OYVBti4ZYR2oOVRRZguJ
 vyhtaB7Pmjj2GngMOFXxnb9XMS+6uWAuCHNXPoQ6IdYK0CkH2HacR0pEXG8OReNb
 Jw+Ia3nUD3vzFQdHy8fzexQN+BDB4QDY7Zhx9gTbaC1uDTINjKSTP/3xHN1dGtca
 5kT5IkP8Y///evex/XEThyVPrB0k6AApQjozjSPUdnd1W/800KF7pwZVWDUVb1u8
 RbrwxW4i4X79Sx6WNWDUV/ZzdEwHRXfLKlfDMDJF2IbhpqVLCiWmSkm4sPKVZUkg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bqr94hmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:23:57 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52DJMtme019938;
 Thu, 13 Mar 2025 19:23:57 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bqr94hme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:23:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52DJ1GKM003181;
 Thu, 13 Mar 2025 19:23:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atstufts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:23:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52DJNqQH59310580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 19:23:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BBA720043;
 Thu, 13 Mar 2025 19:23:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F29B20040;
 Thu, 13 Mar 2025 19:23:50 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.223.53]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 19:23:49 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v2 1/8] hw/ppc: Implement skeleton code for fadump in PSeries
Date: Fri, 14 Mar 2025 00:53:34 +0530
Message-ID: <20250313192341.132171-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313192341.132171-1-adityag@linux.ibm.com>
References: <20250313192341.132171-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PqVmuWxwBjehb-N-sc1iHMFMIB2kbk2a
X-Proofpoint-ORIG-GUID: _TO3BCXRd_V_bmW8YmCqX5d-DOHqwA0z
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

Add skeleton for handle "ibm,configure-kernel-dump" rtas call in QEMU.

Verify basic details mandated by the PAPR, such as number of
inputs/output, and add handling for the three fadump commands:
regiser/unregister/invalidate.

Currently fadump register will always return HARDWARE ERROR, since it's
not implemented yet. So if the kernel's attempt to register fadump will
itself fail as the support is not there yet in QEMU.

The checks are based on the table in following requirement in PAPR v2.13:
    "R1–7.3.30–1. For the Configure Platform Assisted Kernel Dump option ..."

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/meson.build            |  1 +
 hw/ppc/spapr_fadump.c         | 22 +++++++++++
 hw/ppc/spapr_rtas.c           | 66 +++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h        | 11 +++++-
 include/hw/ppc/spapr_fadump.h | 69 +++++++++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/spapr_fadump.c
 create mode 100644 include/hw/ppc/spapr_fadump.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 9893f8adebb0..863972741b15 100644
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
diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
new file mode 100644
index 000000000000..20b7b804c485
--- /dev/null
+++ b/hw/ppc/spapr_fadump.c
@@ -0,0 +1,22 @@
+/*
+ * Firmware Assisted Dump in PSeries
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/ppc/spapr.h"
+
+/*
+ * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
+ *
+ * Returns:
+ *  * RTAS_OUT_HW_ERROR: Not implemented/Misc issue such as memory access
+ *                       failures
+ */
+uint32_t do_fadump_register(void)
+{
+    /* WIP: FADUMP_CMD_REGISTER implemented in future patch */
+
+    return RTAS_OUT_HW_ERROR;
+}
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 503d441b48e4..b8bfa9c33fb5 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -341,6 +341,68 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
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
+                "FADump: ibm,configure-kernel-dump RTAS called with nret != 1.\n");
+        return;
+    }
+
+    /* Number of inputs has to be 3 */
+    if (nargs != 3) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    switch (cmd) {
+    case FADUMP_CMD_REGISTER:
+        ret_val = do_fadump_register();
+        if (ret_val != RTAS_OUT_SUCCESS) {
+            rtas_st(rets, 0, ret_val);
+            return;
+        }
+        break;
+    case FADUMP_CMD_UNREGISTER:
+        if (spapr->fadump_dump_active == 1) {
+            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
+            return;
+        }
+
+        spapr->fadump_registered = false;
+        spapr->fadump_dump_active = false;
+        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
+        break;
+    case FADUMP_CMD_INVALIDATE:
+        if (spapr->fadump_dump_active) {
+            spapr->fadump_registered = false;
+            spapr->fadump_dump_active = false;
+            memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "FADump: Nothing to invalidate, no dump active\n");
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "FADump: Unknown command: %lu\n", cmd);
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
@@ -656,6 +718,10 @@ static void core_rtas_register_types(void)
     spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
                         rtas_ibm_nmi_interlock);
 
+    /* Register fadump rtas call */
+    spapr_rtas_register(RTAS_CONFIGURE_KERNEL_DUMP, "ibm,configure-kernel-dump",
+                        rtas_configure_kernel_dump);
+
     qtest_set_command_cb(spapr_qtest_callback);
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 39bd5bd5ed31..4c1636497e30 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -13,6 +13,7 @@
 #include "hw/ppc/xics.h"        /* For ICSState */
 #include "hw/ppc/spapr_tpm_proxy.h"
 #include "hw/ppc/spapr_nested.h" /* For SpaprMachineStateNested */
+#include "hw/ppc/spapr_fadump.h" /* For FadumpMemStruct */
 
 struct SpaprVioBus;
 struct SpaprPhbState;
@@ -283,6 +284,11 @@ struct SpaprMachineState {
     Error *fwnmi_migration_blocker;
 
     SpaprWatchdog wds[WDT_MAX_WATCHDOGS];
+
+    /* Fadump State */
+    bool fadump_registered;
+    bool fadump_dump_active;
+    FadumpMemStruct registered_fdm;
 };
 
 #define H_SUCCESS         0
@@ -708,6 +714,8 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 #define RTAS_OUT_PARAM_ERROR                    -3
 #define RTAS_OUT_NOT_SUPPORTED                  -3
 #define RTAS_OUT_NO_SUCH_INDICATOR              -3
+#define RTAS_OUT_DUMP_ALREADY_REGISTERED        -9
+#define RTAS_OUT_DUMP_ACTIVE                    -10
 #define RTAS_OUT_NOT_AUTHORIZED                 -9002
 #define RTAS_OUT_SYSPARM_PARAM_ERROR            -9999
 
@@ -770,8 +778,9 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
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
index 000000000000..45109fd9e137
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
+#define RTAS_FADUMP_MAX_BOOT_MEM_REGS  7
+
+typedef struct FadumpSection FadumpSection;
+typedef struct FadumpSectionHeader FadumpSectionHeader;
+typedef struct FadumpMemStruct FadumpMemStruct;
+
+struct SpaprMachineState;
+
+/* Kernel Dump section info */
+struct FadumpSection {
+    __be32    request_flag;
+    __be16    source_data_type;
+    __be16    error_flags;
+    __be64    source_address;
+    __be64    source_len;
+    __be64    bytes_dumped;
+    __be64    destination_address;
+};
+
+/* ibm,configure-kernel-dump header. */
+struct FadumpSectionHeader {
+    __be32    dump_format_version;
+    __be16    dump_num_sections;
+    __be16    dump_status_flag;
+    __be32    offset_first_dump_section;
+
+    /* Fields for disk dump option. */
+    __be32    dd_block_size;
+    __be64    dd_block_offset;
+    __be64    dd_num_blocks;
+    __be32    dd_offset_disk_path;
+
+    /* Maximum time allowed to prevent an automatic dump-reboot. */
+    __be32    max_time_auto;
+};
+
+/* Note: All the data in these structures is in big-endian */
+struct FadumpMemStruct {
+    FadumpSectionHeader header;
+    FadumpSection       rgn[FADUMP_MAX_SECTIONS];
+};
+
+uint32_t do_fadump_register(void);
+#endif /* PPC_SPAPR_FADUMP_H */
-- 
2.48.1


