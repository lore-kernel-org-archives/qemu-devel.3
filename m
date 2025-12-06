Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5443DD3ABF5
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 05:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRlJT-00049y-Fv; Sat, 06 Dec 2025 00:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJR-00048D-UU; Sat, 06 Dec 2025 00:58:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJQ-0005XJ-4X; Sat, 06 Dec 2025 00:58:33 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B62l2pf023008;
 Sat, 6 Dec 2025 05:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ROy75RqasHOPQn/yH
 ra7gT4mwXrRJKa5wKQA5F3mCLQ=; b=CAsYvkP1Do3D7WdEhGIhRpLMzIUBWZvkX
 RQTcMqHtAd0oNpzcmM7mfx5MvGLazEsvH0Zxb3wqJWiDRgG3CiEbJiIIKuBt3X4o
 fgNJQkMy9T2f6r7U5qu3ZzJrpstQqPZOqSPUHd+D+98l8kRHyrJg25rtMQeNbfAm
 nETj7L/aNCVI4uyPCugiZHTzWz+XD86Bp7hEhrVuxtlGPmKOZCTXVUq+mThZFkuU
 xv1fAAOISu3yHs8GrOalN3DRs8e7XobCZEF4AlY/RRvBiYdQtYVZNNJLQmBRwSic
 PpcqYNtfXMYB51p+7Cqnj7UTC3vyQT5bChi6H+JnIccjlAY2Rzq9g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jgg53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B62uRfw029343;
 Sat, 6 Dec 2025 05:58:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv20qbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B65wLRG51184114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Dec 2025 05:58:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BF9520043;
 Sat,  6 Dec 2025 05:58:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89A4C20040;
 Sat,  6 Dec 2025 05:58:19 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.93]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Dec 2025 05:58:19 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 2/9] hw/ppc: Implement S0 SBE interrupt as cpu_pause then
 host reset
Date: Sat,  6 Dec 2025 11:26:41 +0530
Message-ID: <20251206055648.1908734-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206055648.1908734-1-adityag@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=6933c602 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=atcXKtye3xvqEmVJAE4A:9
X-Proofpoint-ORIG-GUID: uDVTGdwLNzsEH_zgtH0g23nIvYVmpYmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX3S/LmDZpcTjs
 RFr+I2nu0HC9ngcO7WN81adXFyCn+T54wbOF+/GFs21bme78Nm8zLNoZKm/+jh+hbh5JD/1EVh6
 U8Rw4YG6bAGfo5SSypOVsasd0zzjQ9GtU90sXcmrdJFf4y5/vofY2GHOMTCM3CclLvfkr6vKg3b
 gJ5L83c3RT7x4McAZ70FQLnco+c2V3lgRWxElIMkMfX06ByB1X2Ug/1w/1p60oH/kysxR8i+gOH
 Gu5Teilu2Gnu0/7F/j1X7PonrAjVlpDBIGT7sv4WSLamPeM8sXIaezua/TCk96z6hPQ6Wvjj49a
 gKkbG4uRHy1fPHLWGCEAr9Z/GIKgFY6CQnM5Ovex67mvJVhVy9qA27rwxDEytoS0XovGpcjgKNx
 IcC9PplS941ojALb5UCj4/3c5rGr/w==
X-Proofpoint-GUID: uDVTGdwLNzsEH_zgtH0g23nIvYVmpYmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_09,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

During MPIPL (aka fadump), OPAL triggers the S0 SBE interrupt to trigger
MPIPL.

Currently S0 interrupt is unimplemented in QEMU.

Implement S0 interrupt as 'pause_vcpus' + 'guest_reset' in QEMU, as the
SBE's implementation of S0 seems to be basically "stop all clocks" and
then "host reset".

pause_vcpus is done in a later patch when register preserving support is
added

See 'stopClocksS0' in SBE source code for more information.

Also log both S0 and S1 interrupts.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/meson.build         |  1 +
 hw/ppc/pnv_mpipl.c         | 26 ++++++++++++++++++++++++++
 hw/ppc/pnv_sbe.c           | 29 +++++++++++++++++++++++++++++
 include/hw/ppc/pnv.h       |  6 ++++++
 include/hw/ppc/pnv_mpipl.h | 19 +++++++++++++++++++
 5 files changed, 81 insertions(+)
 create mode 100644 hw/ppc/pnv_mpipl.c
 create mode 100644 include/hw/ppc/pnv_mpipl.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index f7dac87a2a48..c61fba4ec8f2 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -56,6 +56,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_pnor.c',
   'pnv_nest_pervasive.c',
   'pnv_n1_chiplet.c',
+  'pnv_mpipl.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
new file mode 100644
index 000000000000..d8c9b7a428b7
--- /dev/null
+++ b/hw/ppc/pnv_mpipl.c
@@ -0,0 +1,26 @@
+/*
+ * Emulation of MPIPL (Memory Preserving Initial Program Load), aka fadump
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/runstate.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_mpipl.h"
+
+void do_mpipl_preserve(PnvMachineState *pnv)
+{
+    /* Mark next boot as Memory-preserving boot */
+    pnv->mpipl_state.is_next_boot_mpipl = true;
+
+    /*
+     * Do a guest reset.
+     * Next reset will see 'is_next_boot_mpipl' as true, and trigger MPIPL
+     *
+     * Requirement:
+     * GUEST_RESET is expected to NOT clear the memory, as is the case when
+     * this is merged
+     */
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+}
diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index b9b28c5deaef..d004b7d5c225 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -21,11 +21,14 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_sbe.h"
+#include "hw/ppc/pnv_mpipl.h"
 #include "trace.h"
 
 /*
@@ -113,11 +116,37 @@ static uint64_t pnv_sbe_power9_xscom_ctrl_read(void *opaque, hwaddr addr,
 static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
                                        uint64_t val, unsigned size)
 {
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    PnvSBE *sbe = opaque;
     uint32_t offset = addr >> 3;
 
     trace_pnv_sbe_xscom_ctrl_write(addr, val);
 
     switch (offset) {
+    case SBE_CONTROL_REG_RW:
+        switch (val) {
+        case SBE_CONTROL_REG_S0:
+            qemu_log_mask(LOG_UNIMP, "SBE: S0 Interrupt triggered\n");
+
+            pnv_sbe_set_host_doorbell(sbe, sbe->host_doorbell | SBE_HOST_RESPONSE_MASK);
+
+            /* Preserve memory regions and CPU state, if MPIPL is registered */
+            do_mpipl_preserve(pnv);
+
+            /*
+             * Control may not come back here as 'do_mpipl_preserve' triggers
+             * a guest reboot
+             */
+            break;
+        case SBE_CONTROL_REG_S1:
+            qemu_log_mask(LOG_UNIMP, "SBE: S1 Interrupt triggered\n");
+            break;
+        default:
+            qemu_log_mask(LOG_UNIMP,
+                "SBE: CONTROL_REG_RW: Unknown value: Ox%."
+                  HWADDR_PRIx "\n", val);
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "SBE Unimplemented register: Ox%"
                       HWADDR_PRIx "\n", addr >> 3);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index cbdddfc73cd4..02baa0012460 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -25,6 +25,7 @@
 #include "hw/sysbus.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/ppc/pnv_pnor.h"
+#include "hw/ppc/pnv_mpipl.h"
 
 #define TYPE_PNV_CHIP "pnv-chip"
 
@@ -111,6 +112,8 @@ struct PnvMachineState {
 
     bool         big_core;
     bool         lpar_per_core;
+
+    MpiplPreservedState mpipl_state;
 };
 
 PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
@@ -290,4 +293,7 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
 
 #define PNV11_OCC_SENSOR_BASE(chip) PNV10_OCC_SENSOR_BASE(chip)
 
+/* MPIPL helpers */
+void do_mpipl_preserve(PnvMachineState *pnv);
+
 #endif /* PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
new file mode 100644
index 000000000000..c544984dc76d
--- /dev/null
+++ b/include/hw/ppc/pnv_mpipl.h
@@ -0,0 +1,19 @@
+/*
+ * Emulation of MPIPL (Memory Preserving Initial Program Load), aka fadump
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PNV_MPIPL_H
+#define PNV_MPIPL_H
+
+#include "qemu/osdep.h"
+
+typedef struct MpiplPreservedState MpiplPreservedState;
+
+/* Preserved state to be saved in PnvMachineState */
+struct MpiplPreservedState {
+    bool       is_next_boot_mpipl;
+};
+
+#endif
-- 
2.52.0


