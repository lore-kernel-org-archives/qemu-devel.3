Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A014EC9EC63
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFGL-0003Sh-61; Mon, 12 Jan 2026 05:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGJ-0003RJ-Bx
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGH-00028s-G7
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:03 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60C1rDgn001282
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=plLwRG/MfEvmray4D
 OOAMS5DoEibhKDHm37RIdxjSsU=; b=ZMMdcXmtTsPxGODQ07KQQGG2vzXT2FnfM
 l9ZGM7rRA1NLIFf9oNqNwrWysCPt9Z4vvgrqRirKPf12U7lgNvbtQKITO4i8E0Dc
 cuJ3tYoBvdqt+kybo/EJxYeIXxPPeTloy30CkJR4H/D4fXW7vxehTFGEY816oGI1
 soC3/IeNqgNEUxlIotpzO+7VVmBBmRCPZ0EM6GtwzNs4tMln7LU433HSQyU7D6s9
 IRL0xv7eb9UpAyPepHbkW+P6c+AG7HnEqlsV6Dznqk2xMoX/cisSuBoMM/lmG7pB
 fEzXVHXWvzJ24qL6Ev76Qjj3GkQMhu4SKhsbnBAMzTQ45V37arMaQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeepphyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C9H1s4002536
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13sdj4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CAYtm921889382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 10:34:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D1F020043;
 Mon, 12 Jan 2026 10:34:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C81920040;
 Mon, 12 Jan 2026 10:34:54 +0000 (GMT)
Received: from Mac.com (unknown [9.43.47.93])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 10:34:53 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Caleb Schlossin <calebs@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PULL 02/10] hw/ppc: Add VMSTATE information for LPC model
Date: Mon, 12 Jan 2026 16:04:25 +0530
Message-ID: <20260112103433.8451-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103433.8451-1-harshpb@linux.ibm.com>
References: <20260112103433.8451-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=6964ce53 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=42l16weh4kzh4Z9CBFoA:9
X-Proofpoint-GUID: BmERnuRRuP9bNcQHlMJGNjmfeL8L7I66
X-Proofpoint-ORIG-GUID: BmERnuRRuP9bNcQHlMJGNjmfeL8L7I66
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4MSBTYWx0ZWRfX02eMP5k6wn62
 hxt01HwdXWw2ICDFqEtTZRZK4DddjmzQSRrN9eUBRbYI121R7BaY+bK/0pDODX7l0bo8bog3xHY
 D11OEDkJqSLjPCSdmbizj0AUTir7pnondFslTzjSD5ReNof8lmL0QzNdP2O598ntnyXvom5tN7I
 WGbG5Uy1OGjxhq0blgJWBQsCb6oB/9NxeY56bCVhZ1fRWAN0kf83kMuU1BP2mTPr+ad1x36FL9y
 3ml7GMOyuBUYOsm/CPwD9I8Li1By47GskI2dG20nSwJ7K74uG/b6PunHEHrqRcR5Vn4+cC2iAYS
 ozZfF0EJFYGJAaxNPzTury/BMytnyInYaSuQVW8+8Bjy0sqLlXtldD7w4qgcXJbewIwccgd4LZu
 phY+Id9GXuWgK0PDf/LhpXx9YqIIqklMtPSQvL5HgtHsB0zZv/mTD+a2MkKKwc3QYN7OOGWzgdL
 1fxohx1rqk3rAQ84nbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120081
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Caleb Schlossin <calebs@linux.ibm.com>

The PNV LPC model needs snapshot/migration support.  Added a VMSTATE
descriptor to save model data and an associated post_load() method.
Snapshot support added for Power8, Power9, and Power10.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260105160138.3242709-2-calebs@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv_lpc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 3b65c12316..d1357dd359 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -30,6 +30,7 @@
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/fdt.h"
+#include "migration/vmstate.h"
 
 #include <libfdt.h>
 
@@ -696,6 +697,43 @@ static const MemoryRegionOps opb_master_ops = {
     },
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
 static void pnv_lpc_power8_realize(DeviceState *dev, Error **errp)
 {
     PnvLpcController *lpc = PNV_LPC(dev);
@@ -721,6 +759,7 @@ static void pnv_lpc_power8_class_init(ObjectClass *klass, const void *data)
     PnvLpcClass *plc = PNV_LPC_CLASS(klass);
 
     dc->desc = "PowerNV LPC Controller POWER8";
+    dc->vmsd = &vmstate_pnv_lpc;
 
     xdc->dt_xscom = pnv_lpc_dt_xscom;
 
@@ -766,6 +805,7 @@ static void pnv_lpc_power9_class_init(ObjectClass *klass, const void *data)
     PnvLpcClass *plc = PNV_LPC_CLASS(klass);
 
     dc->desc = "PowerNV LPC Controller POWER9";
+    dc->vmsd = &vmstate_pnv_lpc;
 
     device_class_set_parent_realize(dc, pnv_lpc_power9_realize,
                                     &plc->parent_realize);
@@ -782,6 +822,7 @@ static void pnv_lpc_power10_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "PowerNV LPC Controller POWER10";
+    dc->vmsd = &vmstate_pnv_lpc;
 }
 
 static const TypeInfo pnv_lpc_power10_info = {
-- 
2.52.0


