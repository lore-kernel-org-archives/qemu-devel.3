Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEA5F589DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGC4A-0004er-AY; Fri, 24 Apr 2026 04:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC48-0004dm-FG; Fri, 24 Apr 2026 04:39:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC46-0005In-LJ; Fri, 24 Apr 2026 04:39:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NIZBhL3657914; Fri, 24 Apr 2026 08:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=h6e0Ld9GyXjt/9CgK
 FlSYjhYhBYMTPq6Wjq4dgR2vkU=; b=HpGEp3ZjBD7m+gER88jFgO1erQuq6JCUy
 5lGONbyzDa3CKn8yEWA8L9kz8GKdam+NpNXYhoyDWXnm3f6PatCpp0UgxLX2uYqa
 Vt+RnLh/0jfWvhcLpL9UfLa8q4gr0r8R56CtoFtYFgq7puo611bMtyLXbCveV+Za
 qwC0Lj1BdFKTMe3mpiJylYB7V8ltL0dqZ80p8I89bcwRkqzGVxp8gpWUdZIkJP4x
 J8XNSVTlZtpcvJqZxqZM7y/lbyxeXwwci0kFTPacOoAYeP4NYqYIaMFhq47lj1io
 aDSiPkZfrmA1jWJIJOPeeGfWjVruotXAHRq6612hNz4LbaXtYMSzw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7v3mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O8ZV2c002414;
 Fri, 24 Apr 2026 08:39:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkya2cc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63O8d3g141615652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 08:39:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A26822004E;
 Fri, 24 Apr 2026 08:39:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECD022004F;
 Fri, 24 Apr 2026 08:38:59 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.230]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 08:38:59 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v6 02/10] ppc/mpipl: Implement S0 SBE interrupt
Date: Fri, 24 Apr 2026 14:08:29 +0530
Message-ID: <20260424083837.214947-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424083837.214947-1-adityag@linux.ibm.com>
References: <20260424083837.214947-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: AOsbdYGPYn7gWzUY9JjN92aaT0GcRcTV
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69eb2c2c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=atcXKtye3xvqEmVJAE4A:9
X-Proofpoint-GUID: PySs8pHEaPGGVTztPrTdv00pOr9KTVGA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA3NiBTYWx0ZWRfXzbuV46nNFqnj
 z5NIR9Sta3OOSyv4G/E3HIyKRrS2H/ywh8TO6kqEng9LFgaXT164xAAF/vM/GUNIpUhajhFxHxj
 90ycGtLdzLODMIfTDyefs2SuCpokDlyis6gGaVo3eeZ4V2tPhnS6sRZG+qXrQwV3b2p1Qwo+ldZ
 JyZc7WRjBWr8WBW6PxtE2VRzIZCGGuw4wkD1Ves8I9eSpRuLsYUY6xxBuGIZOpZm3JCVvQmW+Qp
 AlFj+Z3ia3ApMiUVRkMU4YcniZXDTzCrVSO9PTg46dp9pufOZjyBnyUh7UiZ9NFEYGsz6BD7/2U
 zh2BOiuBV6BNNzSLBP6e3AYWqt5lMQKjXifCP6h00g2lvFxcTaAozTHbhSJUmqcDIv6KnSAIRfP
 ADTtB6sng6AxRIMbrFvMQxG4UMQmrNV0EFw9UGmR2urcEQ7KmKogxe5bWPJAgbbKbhbyFJE+7vc
 y5Y2LqAsdG+EO7PnkBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

During MPIPL (aka fadump), after a kernel crash, the kernel does
opal_cec_reboot2 opal call, signifying an abnormal termination.
When OPAL receives this opal call, it further triggers SBE S0 interrupt,
to trigger a MPIPL boot.

Currently S0 interrupt is unimplemented in QEMU.

Implement S0 interrupt as 'pause_vcpus' + 'guest_reset' in QEMU, as the
SBE's implementation of S0 seems to be basically "stop all clocks" and
then "host reset".

pause_vcpus is done in a later patch when register preserving support is
added

See 'stopClocksS0' in SBE source code for more information.

Also log both S0 and S1 interrupts.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/meson.build         |  1 +
 hw/ppc/pnv_mpipl.c         | 26 ++++++++++++++++++++++++++
 hw/ppc/pnv_sbe.c           | 29 +++++++++++++++++++++++++++++
 include/hw/ppc/pnv.h       |  5 +++++
 include/hw/ppc/pnv_mpipl.h | 19 +++++++++++++++++++
 5 files changed, 80 insertions(+)
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
index 247617338a0d..5a2b3342d199 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -26,6 +26,9 @@
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_sbe.h"
+#include "hw/ppc/pnv_mpipl.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
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
index 90028f974dab..79de6b856923 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -25,6 +25,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/ppc/pnv_pnor.h"
+#include "hw/ppc/pnv_mpipl.h"
 
 #define TYPE_PNV_CHIP "pnv-chip"
 
@@ -113,6 +114,7 @@ struct PnvMachineState {
     bool         lpar_per_core;
 
     Notifier     machine_init_done;
+    MpiplPreservedState mpipl_state;
 };
 
 PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
@@ -292,4 +294,7 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
 
 #define PNV11_OCC_SENSOR_BASE(chip) PNV10_OCC_SENSOR_BASE(chip)
 
+/* MPIPL helpers */
+void do_mpipl_preserve(PnvMachineState *pnv);
+
 #endif /* PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
new file mode 100644
index 000000000000..61ef7ef8fe60
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
+#include <stdbool.h>
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
2.53.0


