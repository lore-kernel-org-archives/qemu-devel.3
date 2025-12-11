Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C845D4335A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTor6-0007nQ-3h; Thu, 11 Dec 2025 17:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTor4-0007n1-L7; Thu, 11 Dec 2025 17:09:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTor3-0000qW-1h; Thu, 11 Dec 2025 17:09:46 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBFOWFI011156;
 Thu, 11 Dec 2025 22:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tUGt6yJxb94Zne/6P
 s+J4IZ56FJqM4T7v2D0ElYfeA4=; b=jlKbSDvw6iMV2gYluYcvtYwbG0s1ujHx8
 DHqgDvMfTFH77zkl1kiYFL9Y2hWiQETLJmQKKlYSXFiDeCZRHhgj1yeBi1DxvbmG
 uJ1D/FglJ8DC81XEVhyAC2yYpAXc0t73lSZ8jzur0ZiMrtXZVQOhcIGMd/EBJeCN
 R/y7R6fqi7eNQKwGHVlHhpJCOX7HnQF4tnwyzU7BkJ4PNjYZpNzvZr96/W3d6l1I
 8/wuIN+A5XkV9eocVj/cdSkgMEyabVsS2CKc50BwPn6BAHXzhxpSM2b6jmZyD5+d
 N6510OPa1pe/jo4qZXTvAs39Ed97mnldzfZ+4F5y0J8Md1zE0VfnA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7caa48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BBM9gY4007902;
 Thu, 11 Dec 2025 22:09:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7caa45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBLhQ5u008391;
 Thu, 11 Dec 2025 22:09:41 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytn8vd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BBM9eXa4457276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Dec 2025 22:09:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E581358043;
 Thu, 11 Dec 2025 22:09:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23A7358053;
 Thu, 11 Dec 2025 22:09:39 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Dec 2025 22:09:39 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH 1/6] hw/ppc: Add VMSTATE information for LPC model
Date: Thu, 11 Dec 2025 16:09:21 -0600
Message-ID: <20251211220926.2865972-2-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211220926.2865972-1-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G7vw-wgS8l4OUNS6MtNE78rsm9K0sPQO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX3cm7SP0IvrP6
 4T6odsBcRQdgMj3MXXPMOVQW2+UToW4GHOmeDN6NF1jfjse1jA500Dn5OeMhOAIAl2S1k33Jxkg
 M198F1/vG28kB4BFbH+GRj41dxC7YjgqOStcooaLbiXkKRL1TarZJPHkqLE3NjKJ0I0VlOFK3QN
 gx9fZoR34hyt2qQYiBg7vLc6/B1e/Dfj8HTXLR6NR4FTp4/aTH7RKt6cmjW4sT3VehoIKbZ558M
 KZFIVXJiVhSjjqroJeU1IhMU0+5Ms2eAhv6dFiGZdhN2yfo1CadaBZ6B/skfHyJAAqrWimUXNEn
 mLh5+7KB3OCauqgtlvs5dU1fH3a7KT6N0jBgF5GcIrHd+clTyekoMc2vNSFIKYwYxZoyD1udZRp
 R9G/QYtdJJXWUNkR8o1Qmoy1gHTBOw==
X-Proofpoint-GUID: 9QpSUcU5Mr_n6WdALNer2PolxUm9dk2m
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=693b4127 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=euV60TMU5PurI9-ex4EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The PNV LPC model needs snapshot/migration support.  Added a VMSTATE
descriptor to save model data and an associated post_load() method.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_lpc.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index f6beba0917..7f11fd312a 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -30,6 +30,7 @@
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/fdt.h"
+#include "migration/vmstate.h"
 
 #include <libfdt.h>
 
@@ -777,11 +778,49 @@ static const TypeInfo pnv_lpc_power9_info = {
     .class_init    = pnv_lpc_power9_class_init,
 };
 
+static int vmstate_pnv_lpc_post_load(void *opaque, int version_id)
+{
+    PnvLpcController *lpc = PNV_LPC(opaque);
+
+    memory_region_set_alias_offset(&lpc->opb_isa_fw,
+                                   lpc->lpc_hc_fw_seg_idsel * LPC_FW_OPB_SIZE);
+    pnv_lpc_eval_serirq_routes(lpc);
+
+    pnv_lpc_eval_irqs(lpc);
+    return 0;
+}
+
+static const VMStateDescription vmstate_pnv_lpc = {
+    .name = TYPE_PNV_LPC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = vmstate_pnv_lpc_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(eccb_stat_reg,       PnvLpcController),
+        VMSTATE_UINT32(eccb_data_reg,       PnvLpcController),
+        VMSTATE_UINT32(opb_irq_route0,      PnvLpcController),
+        VMSTATE_UINT32(opb_irq_route1,      PnvLpcController),
+        VMSTATE_UINT32(opb_irq_stat,        PnvLpcController),
+        VMSTATE_UINT32(opb_irq_mask,        PnvLpcController),
+        VMSTATE_UINT32(opb_irq_pol,         PnvLpcController),
+        VMSTATE_UINT32(opb_irq_input,       PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_irq_inputs,   PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_fw_seg_idsel, PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_irqser_ctrl,  PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_irqmask,      PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_irqstat,      PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_error_addr,   PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_fw_rd_acc_size,     PnvLpcController),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void pnv_lpc_power10_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "PowerNV LPC Controller POWER10";
+    dc->vmsd = &vmstate_pnv_lpc;
 }
 
 static const TypeInfo pnv_lpc_power10_info = {
-- 
2.47.3


