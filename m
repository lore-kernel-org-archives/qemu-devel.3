Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0585CAC5B3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ppA-0001yI-Ad; Thu, 25 Sep 2025 13:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1pow-0001tC-8F; Thu, 25 Sep 2025 13:31:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1pop-0006EB-RP; Thu, 25 Sep 2025 13:31:52 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PDk1UA011952;
 Thu, 25 Sep 2025 17:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=I6o1AGbqexnzRG5m+
 mx6kaCfFMCpeksUi7CfCchNwO8=; b=oZaY0NwSrALCW7D20eECc+P/y565/Q3PT
 1PgKpGDXOe5bq6Iw2nSkO2kLBsaExN9tSWXQJ8G4jA8f3aTEjn01EDjONzrC+G7p
 QxHDz2yRJ67b7V1awnB82AGJxMUcqhxmsRcgJB7bDD48MJtX+hbqfnafr7UTy0EA
 lJ2DZxYcFExDKL7jTKseFIiQuSbXnw6MxplGVR7UH+ienLBNrBgavpG/28bFUSWr
 VLVCefCsngkz3J1I77EqtfJLq5nPs5XanaJSCG1fVuNQwWspRLcWKuI8tIuaGsGP
 ToPW5lPn/HxLjx+sQpMI1lxLLcEDrB27JNt2kS2zfKM1sZ7DfMkSw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksc7ehf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PHQ9Tp002818;
 Thu, 25 Sep 2025 17:31:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksc7eh8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PH5JcH013380;
 Thu, 25 Sep 2025 17:31:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49cj34ea0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHVaAh50594194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:31:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEF1F2004E;
 Thu, 25 Sep 2025 17:31:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA2E12004B;
 Thu, 25 Sep 2025 17:31:33 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.220.124])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:31:33 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Mike Kowal <kowal@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: [PATCH v10 3/8] ppc/pnv: Add PnvChipClass handler to get reference to
 interrupt controller
Date: Thu, 25 Sep 2025 23:00:44 +0530
Message-ID: <20250925173049.891406-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925173049.891406-1-adityag@linux.ibm.com>
References: <20250925173049.891406-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OqHG2FAgqh961WOSt4dNe42lFgJH76kH
X-Proofpoint-GUID: QL_KMC-ayJxqk8DRe62aec0TY648mkCu
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d57c7e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=iorEynmUMFpPDaT-22UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX0j0UAkbcr6cQ
 oP96Mey2egYSAwgqadqXeOKrZpJnBTMvIjOyhRZHV65x12TMRC7qhqwdPRCE7UAtzQYcwvsdWvX
 kC7nU+ib7pLIJcMs494T5Ky8n+mFaGqZxBMw3dEaf91rwWsZAx12u/6hcqsbOflWh2LAEeixA2O
 mW1Qr0jLR8OyVj40vC4tvdm+PqLj8jq2drnSFIyyHOrSXddVtkHZyGhc24sBz0fyyiOycSu0IhM
 7DqgkVJ/pGewjrW8VfIRKvWxq7cpct3WuimYGc27w2V5Jto0V7lOJ92eWxU40uYW6MlMUT5n9J7
 vv3dvq/RGr1b9YTfHYd6ZoMuegk7BhicNMUvySk8d+n78qUzbIWbtJzW0Hd7db5t7dITIdqEPRL
 ISiY/LDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

Existing code in XIVE2 assumes the chip to be a Power10 Chip.
Instead add a handler to get reference to the interrupt controller (XIVE)
for a given Power Chip.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/intc/pnv_xive2.c       |  4 ++--
 hw/ppc/pnv.c              | 12 ++++++++++++
 include/hw/ppc/pnv_chip.h |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index e019cad5c14c..0663baab544c 100644
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
index 423954ba7e0c..a4fdf59207fa 100644
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
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 6bd930f8b439..a5b8c49680d3 100644
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
-- 
2.50.1


