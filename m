Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331DEC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjgIl-00008H-Nm; Tue, 14 Jul 2026 12:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wjgIk-00007W-4L; Tue, 14 Jul 2026 12:48:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wjgIh-0000nV-Oe; Tue, 14 Jul 2026 12:48:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EGCB1P1786204; Tue, 14 Jul 2026 16:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=F26CThR3e0R5NPk9i
 fWQ3TSTDhBH1V6eLgp4tbrje6c=; b=gEtuLWeAPUyvOVz/916nwrGxOLRdfUMta
 /ga7vuir062BiHb850tBLJDrWj49yr1Jfy0qIM9mH0w4eh6W5symSLdPU7p8CBgt
 NIecYp9g6/DrCH0TVdusSaMOdkZ8g9RWnQcE48M8QtsGmY5MxBQO3f2PjjmMCsGn
 n4XbIZq7H6tmusKlzKVr3Dom7VfpUMNsNmu/S3oonFp+qZWNOdIlAidz7L6uJlk8
 oUVJYYfjp8qoDV4cUgr9CoyfgdN8dsg0Z3w+ApL9ocFGGWhW0c7yAXssEjM22FA1
 h14d83mrDztpBcjrvkIOl3VNoNF9klhJcavsYJAF5jL/dGKf8COmg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbpsxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 16:48:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EGdRDd017120;
 Tue, 14 Jul 2026 16:48:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy3ert-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 16:48:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EGlxSw29688128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 16:47:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B38020043;
 Tue, 14 Jul 2026 16:47:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67B3D20040;
 Tue, 14 Jul 2026 16:47:56 +0000 (GMT)
Received: from shivang.com (unknown [9.124.218.131])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 16:47:56 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: hbathini@linux.ibm.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com, 
 harshpb@linux.ibm.com, rathc@linux.ibm.com, npiggin@gmail.com,
 mahesh@linux.ibm.com, Shivang Upadhyay <shivangu@linux.ibm.com>,
 Shivang Upadhyay <shivanug@linux.ibm.com>
Subject: [PATCH 1/3] hw/ppc: move RAS-specific RTAS handlers to
 spapr_rtas_ras.c
Date: Tue, 14 Jul 2026 22:17:42 +0530
Message-ID: <20260714164745.573141-2-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714164745.573141-1-shivangu@linux.ibm.com>
References: <20260714164745.573141-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a566846 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=kfHov91USKOIAA82GnUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3MyBTYWx0ZWRfXzPfeXXAYLK1w
 cgACaKsfJqDfdi/V+sMEoK5JRR/Hd9CkKgt1Qz3weWFuOwXS/y+NB98Xy2KT5txIJlZUYpkkVsw
 zMQt1MG7/7Hnp9NCfs4zhuExB7OXEZjdQxsFUTVl5TIG6PDw101iLlNVnKZ4wMA0IN+5iVildeO
 /KWHRnrQ7E162UwdlBX/rr3XoWoOZnmfk9hcZTIdYki4ap5yRPCPUOEmAKHPiZ9hIKLCBZRkr73
 gwQGAuze/rRn0O1xqs0JbpX5o5zcqBdtUo09JDFwxOWsiLLSMjhAzDj7WIk/TYJXGtn0ugyKXq3
 NZZfYtO8RmChvtqv7HmUaQSapeLOEoSVzkhIHcpIuPYdh64nL4c2LptkGOtKLUJEn3xkEAS6IJw
 dOKN2kODGGzK8geCRZ3exoHTz0yfGqqhYSdbGAwUUVm3StJZ8qXSoG+upv8Gx/dO4SbCYTvCBYk
 yWwFmyihq/KRtMjDEwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3MyBTYWx0ZWRfX5R2jAYpaqlUO
 gYWhIek+vsFVryxdgfTMM6tyh18asqMBatp8CNqj2/jh1A965SkrVA+KHBGmAsPJAg6Ot5KXUzl
 nTz3PIu08gnylpD1L/SlsOhCJL+eOaw=
X-Proofpoint-GUID: DlnW5f3zAxRRW9Z70OsENdUzU7QB1aLP
X-Proofpoint-ORIG-GUID: 1xUBV7oP7gK_ur-SDJBfP7c9GjuShWGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140173
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Following RTAS calls are moved to spapr_rtas_ras.c file
- ibm,os-term
- ibm,nmi-register
- ibm,nmi-interlock
- ibm,configure-kernel-dump

The rtas calls are initialized with a new rtas_register_types
constructor.

No functional changes.

Signed-off-by: Shivang Upadhyay <shivanug@linux.ibm.com>
---
 hw/ppc/meson.build      |   1 +
 hw/ppc/spapr_rtas.c     | 189 --------------------------------
 hw/ppc/spapr_rtas_ras.c | 232 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 233 insertions(+), 189 deletions(-)
 create mode 100644 hw/ppc/spapr_rtas_ras.c

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 37aa535db2..83edb3d852 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -14,6 +14,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
   'spapr_events.c',
   'spapr_hcall.c',
   'spapr_nested.c',
+  'spapr_rtas_ras.c',
   'spapr_iommu.c',
   'spapr_rtas.c',
   'spapr_pci.c',
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 328fc27c40..f8538735a4 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -361,96 +361,6 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
     rtas_st(rets, 0, ret);
 }
 
-/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
-static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
-                                   SpaprMachineState *spapr,
-                                   uint32_t token, uint32_t nargs,
-                                   target_ulong args,
-                                   uint32_t nret, target_ulong rets)
-{
-    target_ulong cmd = rtas_ld(args, 0);
-    uint32_t ret_val;
-
-    /* Number of outputs has to be 1 */
-    if (nret != 1) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-            "FADump: ibm,configure-kernel-dump called with nret != 1.\n");
-        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
-        return;
-    }
-
-    /* Number of inputs has to be 3 */
-    if (nargs != 3) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-            "FADump: ibm,configure-kernel-dump called with nargs != 3.\n");
-        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
-        return;
-    }
-
-    switch (cmd) {
-    case FADUMP_CMD_REGISTER:
-        ret_val = do_fadump_register(spapr, args);
-        if (ret_val != RTAS_OUT_SUCCESS) {
-            rtas_st(rets, 0, ret_val);
-            return;
-        }
-        break;
-    case FADUMP_CMD_UNREGISTER:
-        if (spapr->fadump_dump_active) {
-            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
-            return;
-        }
-
-        spapr->fadump_registered = false;
-        spapr->fadump_dump_active = false;
-        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
-        break;
-    case FADUMP_CMD_INVALIDATE:
-        if (!spapr->fadump_dump_active) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                "FADump: Nothing to invalidate, no dump active\n");
-
-            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
-        }
-
-        spapr->fadump_registered = false;
-        spapr->fadump_dump_active = false;
-        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                "FADump: Unknown command: " TARGET_FMT_lu "\n", cmd);
-
-        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
-        return;
-    }
-
-    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
-}
-
-static void rtas_ibm_os_term(PowerPCCPU *cpu,
-                            SpaprMachineState *spapr,
-                            uint32_t token, uint32_t nargs,
-                            target_ulong args,
-                            uint32_t nret, target_ulong rets)
-{
-    target_ulong msgaddr = rtas_ld(args, 0);
-    char msg[512];
-
-    if (spapr->fadump_registered) {
-        /* If fadump boot works, control won't come back here */
-        return trigger_fadump_boot(spapr, rets);
-    }
-
-    physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
-    msg[sizeof(msg) - 1] = 0;
-
-    error_report("OS terminated: %s", msg);
-    qemu_system_guest_panicked(NULL);
-
-    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
-}
-
 static void rtas_set_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                  uint32_t token, uint32_t nargs,
                                  target_ulong args, uint32_t nret,
@@ -501,95 +411,6 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
     rtas_st(rets, 1, 100);
 }
 
-static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
-                                  SpaprMachineState *spapr,
-                                  uint32_t token, uint32_t nargs,
-                                  target_ulong args,
-                                  uint32_t nret, target_ulong rets)
-{
-    hwaddr rtas_addr;
-    target_ulong sreset_addr, mce_addr;
-
-    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
-        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
-        return;
-    }
-
-    rtas_addr = spapr_get_rtas_addr();
-    if (!rtas_addr) {
-        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
-        return;
-    }
-
-    sreset_addr = rtas_ld(args, 0);
-    mce_addr = rtas_ld(args, 1);
-
-    /* PAPR requires these are in the first 32M of memory and within RMA */
-    if (sreset_addr >= 32 * MiB || sreset_addr >= spapr->rma_size ||
-           mce_addr >= 32 * MiB ||    mce_addr >= spapr->rma_size) {
-        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
-        return;
-    }
-
-    if (kvm_enabled()) {
-        if (kvmppc_set_fwnmi(cpu) < 0) {
-            rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
-            return;
-        }
-    }
-
-    spapr->fwnmi_system_reset_addr = sreset_addr;
-    spapr->fwnmi_machine_check_addr = mce_addr;
-
-    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
-}
-
-static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
-                                   SpaprMachineState *spapr,
-                                   uint32_t token, uint32_t nargs,
-                                   target_ulong args,
-                                   uint32_t nret, target_ulong rets)
-{
-    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
-        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
-        return;
-    }
-
-    if (spapr->fwnmi_machine_check_addr == -1) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-"FWNMI: ibm,nmi-interlock RTAS called with FWNMI not registered.\n");
-
-        /* NMI register not called */
-        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
-        return;
-    }
-
-    if (spapr->fwnmi_machine_check_interlock != cpu->vcpu_id) {
-        /*
-         * The vCPU that hit the NMI should invoke "ibm,nmi-interlock"
-         * This should be PARAM_ERROR, but Linux calls "ibm,nmi-interlock"
-         * for system reset interrupts, despite them not being interlocked.
-         * PowerVM silently ignores this and returns success here. Returning
-         * failure causes Linux to print the error "FWNMI: nmi-interlock
-         * failed: -3", although no other apparent ill effects, this is a
-         * regression for the user when enabling FWNMI. So for now, match
-         * PowerVM. When most Linux clients are fixed, this could be
-         * changed.
-         */
-        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
-        return;
-    }
-
-    /*
-     * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
-     * hence unset fwnmi_machine_check_interlock.
-     */
-    spapr->fwnmi_machine_check_interlock = -1;
-    qemu_cond_signal(&spapr->fwnmi_machine_check_interlock_cond);
-    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
-    migrate_del_blocker(&spapr->fwnmi_migration_blocker);
-}
-
 static struct rtas_call {
     const char *name;
     spapr_rtas_fn fn;
@@ -737,20 +558,10 @@ static void core_rtas_register_types(void)
     spapr_rtas_register(RTAS_IBM_SET_SYSTEM_PARAMETER,
                         "ibm,set-system-parameter",
                         rtas_ibm_set_system_parameter);
-    spapr_rtas_register(RTAS_IBM_OS_TERM, "ibm,os-term",
-                        rtas_ibm_os_term);
     spapr_rtas_register(RTAS_SET_POWER_LEVEL, "set-power-level",
                         rtas_set_power_level);
     spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
                         rtas_get_power_level);
-    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
-                        rtas_ibm_nmi_register);
-    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
-                        rtas_ibm_nmi_interlock);
-
-    /* Register fadump rtas call */
-    spapr_rtas_register(RTAS_CONFIGURE_KERNEL_DUMP, "ibm,configure-kernel-dump",
-                        rtas_configure_kernel_dump);
 
     qtest_set_command_cb(spapr_qtest_callback);
 }
diff --git a/hw/ppc/spapr_rtas_ras.c b/hw/ppc/spapr_rtas_ras.c
new file mode 100644
index 0000000000..2f7ee3bb24
--- /dev/null
+++ b/hw/ppc/spapr_rtas_ras.c
@@ -0,0 +1,232 @@
+/*
+ * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware System Emulator
+ *
+ * RAS (Reliability, Availability and Serviceability) RTAS call handlers:
+ *   - ibm,configure-kernel-dump  (FADump)
+ *   - ibm,os-term                (FADump-aware OS termination)
+ *
+ * Copyright (c) 2010-2011 David Gibson, IBM Corporation.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "system/physmem.h"
+#include "system/runstate.h"
+#include "kvm_ppc.h"
+#include "migration/blocker.h"
+
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_fadump.h"
+
+/* PAPR Section 7.4.9 ibm,configure-kernel-dump RTAS call */
+static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
+                                       SpaprMachineState *spapr,
+                                       uint32_t token, uint32_t nargs,
+                                       target_ulong args,
+                                       uint32_t nret, target_ulong rets)
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
+static void rtas_ibm_os_term(PowerPCCPU *cpu,
+                             SpaprMachineState *spapr,
+                             uint32_t token, uint32_t nargs,
+                             target_ulong args,
+                             uint32_t nret, target_ulong rets)
+{
+    target_ulong msgaddr = rtas_ld(args, 0);
+    char msg[512];
+
+    if (spapr->fadump_registered) {
+        /* If fadump boot works, control won't come back here */
+        return trigger_fadump_boot(spapr, rets);
+    }
+
+    physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
+    msg[sizeof(msg) - 1] = 0;
+
+    error_report("OS terminated: %s", msg);
+    qemu_system_guest_panicked(NULL);
+
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
+static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
+                                  SpaprMachineState *spapr,
+                                  uint32_t token, uint32_t nargs,
+                                  target_ulong args,
+                                  uint32_t nret, target_ulong rets)
+{
+    hwaddr rtas_addr;
+    target_ulong sreset_addr, mce_addr;
+
+    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+        return;
+    }
+
+    rtas_addr = spapr_get_rtas_addr();
+    if (!rtas_addr) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+        return;
+    }
+
+    sreset_addr = rtas_ld(args, 0);
+    mce_addr = rtas_ld(args, 1);
+
+    /* PAPR requires these are in the first 32M of memory and within RMA */
+    if (sreset_addr >= 32 * MiB || sreset_addr >= spapr->rma_size ||
+           mce_addr >= 32 * MiB ||    mce_addr >= spapr->rma_size) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    if (kvm_enabled()) {
+        if (kvmppc_set_fwnmi(cpu) < 0) {
+            rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+            return;
+        }
+    }
+
+    spapr->fwnmi_system_reset_addr = sreset_addr;
+    spapr->fwnmi_machine_check_addr = mce_addr;
+
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
+static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   uint32_t token, uint32_t nargs,
+                                   target_ulong args,
+                                   uint32_t nret, target_ulong rets)
+{
+    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+        return;
+    }
+
+    if (spapr->fwnmi_machine_check_addr == -1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+"FWNMI: ibm,nmi-interlock RTAS called with FWNMI not registered.\n");
+
+        /* NMI register not called */
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    if (spapr->fwnmi_machine_check_interlock != cpu->vcpu_id) {
+        /*
+         * The vCPU that hit the NMI should invoke "ibm,nmi-interlock"
+         * This should be PARAM_ERROR, but Linux calls "ibm,nmi-interlock"
+         * for system reset interrupts, despite them not being interlocked.
+         * PowerVM silently ignores this and returns success here. Returning
+         * failure causes Linux to print the error "FWNMI: nmi-interlock
+         * failed: -3", although no other apparent ill effects, this is a
+         * regression for the user when enabling FWNMI. So for now, match
+         * PowerVM. When most Linux clients are fixed, this could be
+         * changed.
+         */
+        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+        return;
+    }
+
+    /*
+     * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
+     * hence unset fwnmi_machine_check_interlock.
+     */
+    spapr->fwnmi_machine_check_interlock = -1;
+    qemu_cond_signal(&spapr->fwnmi_machine_check_interlock_cond);
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+    migrate_del_blocker(&spapr->fwnmi_migration_blocker);
+}
+
+static void ras_rtas_register_types(void)
+{
+    spapr_rtas_register(RTAS_IBM_OS_TERM, "ibm,os-term",
+                        rtas_ibm_os_term);
+    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
+                        rtas_ibm_nmi_register);
+    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
+                        rtas_ibm_nmi_interlock);
+    spapr_rtas_register(RTAS_CONFIGURE_KERNEL_DUMP, "ibm,configure-kernel-dump",
+                        rtas_configure_kernel_dump);
+}
+
+type_init(ras_rtas_register_types)
-- 
2.54.0


