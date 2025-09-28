Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06ADCAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x34-0002ZN-6w; Sun, 28 Sep 2025 15:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x2y-0002Xx-Lc
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x2s-000408-Nd
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S1fpml014288;
 Sun, 28 Sep 2025 19:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3pnNs+
 NQwCzmeZ5Xk9ZhVSzVtVMhqSHZeXfAzJlmo1w=; b=jZ/+B5M7z6p7yOeirhBwpu
 0EZssJUsMj/UMgAbP5lP6jKnyV39o34bTWWD3Of+HO27Z/YvL2yfpNj73vs3/RKK
 6/8uAdGuQvxfSSKdV1RRWd/+aBF/KlmFiviAKFeImVSKb36q8CFMO6YLyMC3EEf5
 NanTZpLDlWlUF71PIXa1xnmqoEYY9395YBH2MXc/bgIsjq93LrZTEnlw2YnS+z6e
 f8XY2FK+zd5w2suY8gtWI3yIU10QOaTI8eyFntZuGJ+Bfbr7IPNvzTIX20dnoju2
 q2P2G9MpXhWNmOxsw/wjx2lXGxetPstpL9DNdIeZMMcMJ3TXhhrjwKer4x7ndnfQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e6xp96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:26:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SI48oP026756;
 Sun, 28 Sep 2025 19:26:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8mjub1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:26:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJQfGB13697446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:26:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B73C20049;
 Sun, 28 Sep 2025 19:26:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2718820040;
 Sun, 28 Sep 2025 19:26:40 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:26:39 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 03/27] ppc/pnv: Add PnvChipClass handler to get reference to
 interrupt controller
Date: Mon, 29 Sep 2025 00:56:05 +0530
Message-ID: <20250928192629.139822-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wlJo9Pdql10VzXa4EHnGRRR-F_OcYwv-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfX2cyFlwkdXANj
 jVoUC/XyHXq/Ii8GHgrpYrZuEnaIfryizBSFK5K2Vuxmp3bZjVV+/kutCOGhjQxh8P09aAAS+hr
 jqROWmG8RTYHt8Nz6NgM32QasasxJvT8q8khEii4GhPzyw5QpSGm4QinvbHKKWuefiuFI8zG0Ue
 /ZPY5yDX/7vFQpdDdY0rwvuPPRLl1+CY35ZK2DmFyO/VVxwJA2U11gETOq5QZwv54iHpe2jF/j+
 dwPRlY4R/hEwJ54htHweo4mAHDAuVylGui8TfC6xpoJeYks40YzVyyR9JcMUahh80cCote6u9Rn
 E60vc6In8rl9hPd3LqmaebVzN39xgbigp7hCWq8Vh7gSN/bCMO0mSwhg5cV7Jv5cuD7IG44Dt2Z
 0Fvkqvr85qvnUyvDzqJG+yMd8u/6RQ==
X-Proofpoint-GUID: wlJo9Pdql10VzXa4EHnGRRR-F_OcYwv-
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68d98bf6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=iorEynmUMFpPDaT-22UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Aditya Gupta <adityag@linux.ibm.com>

Existing code in XIVE2 assumes the chip to be a Power10 Chip.
Instead add a handler to get reference to the interrupt controller (XIVE)
for a given Power Chip.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250925173049.891406-4-adityag@linux.ibm.com
Message-ID: <20250925173049.891406-4-adityag@linux.ibm.com>
---
 include/hw/ppc/pnv_chip.h |  1 +
 hw/intc/pnv_xive2.c       |  4 ++--
 hw/ppc/pnv.c              | 12 ++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 6bd930f8b4..a5b8c49680 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -170,6 +170,7 @@ struct PnvChipClass {
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, GString *buf);
+    void* (*intc_get)(PnvChip *chip);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, GString *buf);
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index e019cad5c1..0663baab54 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -110,8 +110,8 @@ static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
     int i;
 
     for (i = 0; i < pnv->num_chips; i++) {
-        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
-        PnvXive2 *xive = &chip10->xive;
+        PnvChipClass *k = PNV_CHIP_GET_CLASS(pnv->chips[i]);
+        PnvXive2 *xive = PNV_XIVE2(k->intc_get(pnv->chips[i]));
 
         /*
          * Is this the XIVE matching the forwarded VSD address is for this
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 423954ba7e..a4fdf59207 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1486,6 +1486,16 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
     xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
 }
 
+static void *pnv_chip_power10_intc_get(PnvChip *chip)
+{
+    return &PNV10_CHIP(chip)->xive;
+}
+
+static void *pnv_chip_power11_intc_get(PnvChip *chip)
+{
+    return &PNV11_CHIP(chip)->xive;
+}
+
 /*
  * Allowed core identifiers on a POWER8 Processor Chip :
  *
@@ -2680,6 +2690,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, const void *data)
     k->intc_reset = pnv_chip_power10_intc_reset;
     k->intc_destroy = pnv_chip_power10_intc_destroy;
     k->intc_print_info = pnv_chip_power10_intc_print_info;
+    k->intc_get = pnv_chip_power10_intc_get;
     k->isa_create = pnv_chip_power10_isa_create;
     k->dt_populate = pnv_chip_power10_dt_populate;
     k->pic_print_info = pnv_chip_power10_pic_print_info;
@@ -2709,6 +2720,7 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, const void *data)
     k->chip_cfam_id = 0x220da04980000000ull; /* P11 DD2.0 (with NX) */
     k->cores_mask = POWER11_CORE_MASK;
     k->get_pir_tir = pnv_get_pir_tir_p10;
+    k->intc_get = pnv_chip_power11_intc_get;
     k->isa_create = pnv_chip_power11_isa_create;
     k->dt_populate = pnv_chip_power11_dt_populate;
     k->pic_print_info = pnv_chip_power11_pic_print_info;
-- 
2.43.5


