Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1593DD5B85D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCDa-0002SZ-OD; Mon, 15 Dec 2025 12:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDQ-0002D2-JG; Mon, 15 Dec 2025 12:18:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDM-0002gp-K8; Mon, 15 Dec 2025 12:18:32 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFCFEm5030921;
 Mon, 15 Dec 2025 17:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cva5ZBoYoUhj+fm1v
 LQwcvS1IsAUupqHklY5+6VEThg=; b=Si2/H2rrWE1YLOadjq4X698a8hirSB6vF
 PST+dLF1YEhEgowrHF0fieduChL1f0fhaD6MbmMY5SBtD0X491SLqegtLjWrlMWH
 y/zoSrVRpmzmch6lLV5GNz9X3BVGuGazYjwK13hs/CZW/40J6DTIWfB+zMCBQjzl
 rkk6hZfOrnVvxJNyBCfFoll1OAc41+IU6dyapqmgUNJjEdwWAAU6GjSyE4VtXQwx
 IXO5knbg0hdC3EePTcBlyNEvMJFuBOa/KbpoOYKieP//X2Q23u7hGq56Uwzs8IiK
 73eQF/ZQOZeuSPrM1WHPcz6Fji7KOiApxRYdBeClNfBRL1mgnNtqw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjktn21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFHINnP006935;
 Mon, 15 Dec 2025 17:18:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjktn1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFExYE2012800;
 Mon, 15 Dec 2025 17:18:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juxytvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BFHILd116908830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 17:18:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C50D58060;
 Mon, 15 Dec 2025 17:18:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9C6A5803F;
 Mon, 15 Dec 2025 17:18:20 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Dec 2025 17:18:20 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v2 1/7] hw/ppc: Add VMSTATE information for LPC model
Date: Mon, 15 Dec 2025 11:18:07 -0600
Message-ID: <20251215171813.1670241-2-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215171813.1670241-1-calebs@linux.ibm.com>
References: <20251215171813.1670241-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n46iAahUqLRPZ0wcFz8zZVciBDve5Lcy
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=694042df cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=GMd5MdSob7TKo89JhDQA:9
X-Proofpoint-GUID: ZiuSycC1SZUN6l27NagRsNSLx0SC5QdI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX12St5Oo4k3N8
 tmpLttKJRmwiqdHGywpYqQjDlfsK2R8h4gq2IgKD1Nsr+YIVnXE4dqtsJbFG53v/2SYkLAvJU7K
 X5eNM+znsSCAkPPgE4AbyxjdNJeQVVgtvIFvJlvwmcyOAnu6689/Wyq7tJCSO3saUsJT40MChc6
 hurRpuT4uh95YCdXvq93BcpB9PGdTGMV2IKOZZ1FjJcj7wtsnGAZ6ZpINEKPB8YvWEz7m4m8gxu
 P9etIzsK4YvCQsb4D0+XAIrv4g6jOiwh6+2hu4/1Oa3T5FLb27n5ZpYMjhWSYyTtfiTB3+dv1JO
 4RI7P0ItfPgynd5uzphRGo2kgOW1i5bk8vWDxeULWuTE50Lg9uh7ultE5bEYaRIrXIoo84gsiCe
 gF21bTBZdXQui223JOhi8JmKUnAmcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Snapshot support added for Power8, Power9, and Power10.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_lpc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index f6beba0917..e52a062181 100644
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
2.47.3


