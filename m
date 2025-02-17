Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B31DC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvQ6-0000xz-Cl; Mon, 17 Feb 2025 02:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvQ3-0000wR-BH; Mon, 17 Feb 2025 02:19:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvQ1-0002p6-9z; Mon, 17 Feb 2025 02:19:55 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GMiUBd022928;
 Mon, 17 Feb 2025 07:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gISwMQNNGzZLUhzNn
 af+nj06ef9jK+nXr2lbvZ2tKmc=; b=sbb/SnMFnFPr/G+XfZ4SrMet1iJ6yHQ8P
 Ib+vto7Ju+j8wQiYwyyCS2qIQXBbuY/R2EWAEjA1Bnk9Styp8i78o12Ai5u547Ip
 71FkGQBI68ZuJGw/ChMmpVrYue/RmdYUVViP5XN42f8Lrfu69P/cGoTr+fCrb+nB
 57IN+i0H4wjgRPu4+dBOZtKkMXnwj/Vn3CjXwNFxPTsjHhED4BhNKyRawpVtRadb
 cA3hi40SP6gexHqfl1SyNUTHW7IhQ5C+ph2CfGH/K8lmXRwZu019twyUdqh5wxL8
 QfqNINyMNhekxjMqftDNOGCg3N9eqRDcxM35dOAPqbC/im6c5T5GQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ubqnuyex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:51 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51H7D09A016672;
 Mon, 17 Feb 2025 07:19:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ubqnuyev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H3MBXD001599;
 Mon, 17 Feb 2025 07:19:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u5myn350-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51H7Jkw534210196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 07:19:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D03132004D;
 Mon, 17 Feb 2025 07:19:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6138120040;
 Mon, 17 Feb 2025 07:19:45 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.160])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 07:19:45 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH 2/7] hw/ppc: Implement S0 SBE interrupt as cpu_pause then host
 reset
Date: Mon, 17 Feb 2025 12:49:29 +0530
Message-ID: <20250217071934.86131-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217071934.86131-1-adityag@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U45Gh5xxbGdH7hd6O7ESbWFtYCZmcM9K
X-Proofpoint-ORIG-GUID: wyRwL7lxm6UzpvVce63ymStO0c7dAxNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502170060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

SBE's implementation of S0 seems to be basically "stop all clocks" and
then "host reset"

Nearest equivalent to the stop clocks seems to be 'pause_all_vcpus' in
QEMU,

Then reset the host, which is 'SHUTDOWN_CAUSE_GUEST_RESET' in QEMU.

Implement the S0 interrupt as pause_vcpus + guest_reset

See 'stopClocksS0' in SBE source code for more information.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_sbe.c | 50 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 62c94a04a2df..a6bf13650f2d 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -21,6 +21,8 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
@@ -80,6 +82,15 @@
 #define SBE_CONTROL_REG_S0              PPC_BIT(14)
 #define SBE_CONTROL_REG_S1              PPC_BIT(15)
 
+static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
+{
+    val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
+    sbe->host_doorbell = val;
+
+    trace_pnv_sbe_reg_set_host_doorbell(val);
+    qemu_set_irq(sbe->psi_irq, !!val);
+}
+
 struct sbe_msg {
     uint64_t reg[4];
 };
@@ -104,6 +115,7 @@ static uint64_t pnv_sbe_power9_xscom_ctrl_read(void *opaque, hwaddr addr,
 static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
                                        uint64_t val, unsigned size)
 {
+    PnvSBE *sbe = opaque;
     uint32_t offset = addr >> 3;
 
     trace_pnv_sbe_xscom_ctrl_write(addr, val);
@@ -113,6 +125,35 @@ static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
         switch (val) {
         case SBE_CONTROL_REG_S0:
             qemu_log_mask(LOG_UNIMP, "SBE: S0 Interrupt triggered\n");
+
+            pnv_sbe_set_host_doorbell(sbe, sbe->host_doorbell | SBE_HOST_RESPONSE_MASK);
+
+            /*
+             * Looks like, SBE stops clocks for all cores in S0.
+             * See 'stopClocksS0' in SBE source code.
+             * Nearest equivalent in QEMU seems to be 'pause_all_vcpus'
+             */
+            pause_all_vcpus();
+
+            /*
+             * TODO: Pass `mpipl` node in device tree to signify next
+             * boot is an MPIPL boot
+             */
+
+            /* Then do a guest reset */
+            /*
+             * Requirement:
+             * This guest reset should not clear the memory (which is
+             * the case when this is merged)
+             */
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+
+            /*
+             * XXX: Does SBE really do system reset or only stop
+             * clocks ? OPAL seems to think that control will not come
+             * to it after it has triggered S0 interrupt.
+             */
+
             break;
         case SBE_CONTROL_REG_S1:
             qemu_log_mask(LOG_UNIMP, "SBE: S1 Interrupt triggered\n");
@@ -138,15 +179,6 @@ static const MemoryRegionOps pnv_sbe_power9_xscom_ctrl_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
-{
-    val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
-    sbe->host_doorbell = val;
-
-    trace_pnv_sbe_reg_set_host_doorbell(val);
-    qemu_set_irq(sbe->psi_irq, !!val);
-}
-
 /* SBE Target Type */
 #define SBE_TARGET_TYPE_PROC            0x00
 #define SBE_TARGET_TYPE_EX              0x01
-- 
2.48.1


