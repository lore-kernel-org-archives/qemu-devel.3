Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A19C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 11:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0JKK-0008UE-0O; Fri, 26 Apr 2024 07:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0JK1-0008MS-6S; Fri, 26 Apr 2024 07:00:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0JJz-0008Ey-78; Fri, 26 Apr 2024 07:00:52 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QAwWbW007912; Fri, 26 Apr 2024 11:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Crgi3RWDYOzpHg7WnapLY1PEWmyimQxygA6zitqUPik=;
 b=IjmTqB/82AneJz/GJJ6pGIH4jxLEMaIjg9X93fhK4aLrjUg3NXcH3e2/kK61Pnl753Xe
 ToEuJgNpqY8CJhkWzjr8Mw7K2UnhM9o1tY5i0BgwxxtIdLnrL4ggn0bWOzUUi+0/Mybe
 tiGcZx4h0zbrV0l2v8qWvW9RunUxrnb+m7BBh3USS63VU8Q1bahtUo6FF4rLDZM2sYXt
 +9Qgo3ERXLQtGWXVx5nl4TEIwFaQJ4I1/k9aqQdcPNa7zVfz/4wslU1ZhgCMEhEDPNxT
 zDB13RdhdxX6i8gzo9pf8jBpLnqV3v2MGXaJ3LBHnnrvgtOne+XJ3cBhtlsn62vaClbk jw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xraybr07s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:40 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QB08dg011408;
 Fri, 26 Apr 2024 11:00:40 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xraybr07n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43Q7jvRC028356; Fri, 26 Apr 2024 11:00:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr2xug7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QB0XUR13435248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 11:00:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 574D92004D;
 Fri, 26 Apr 2024 11:00:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3150F2005A;
 Fri, 26 Apr 2024 11:00:31 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.171.14.245]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2024 11:00:30 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v2 02/10] ppc/pnv: Introduce 'PnvChipClass::chip_type'
Date: Fri, 26 Apr 2024 16:30:15 +0530
Message-ID: <20240426110023.733309-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426110023.733309-1-adityag@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vkaje69_ciYcbX2uWAElXad38W5hbMh3
X-Proofpoint-GUID: NrKUgZtxJqUz1txvNjraG66vQZoobkGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Introduce 'PnvChipClass::chip_type' to easily get which Power chip is
it.
This helps generalise similar codes such as *_dt_populate, and removes
duplication of code between Power11 and Power10 changes in following
patches.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c              |  5 +++++
 include/hw/ppc/pnv_chip.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec76..74e7908e5ffb 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1457,6 +1457,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
 
     k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
+    k->chip_type = PNV_TYPE_POWER8E;
     k->cores_mask = POWER8E_CORE_MASK;
     k->num_phbs = 3;
     k->chip_pir = pnv_chip_pir_p8;
@@ -1481,6 +1482,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
 
     k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
+    k->chip_type = PNV_TYPE_POWER8;
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 3;
     k->chip_pir = pnv_chip_pir_p8;
@@ -1505,6 +1507,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
 
     k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
+    k->chip_type = PNV_TYPE_POWER8NVL;
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 4;
     k->chip_pir = pnv_chip_pir_p8;
@@ -1779,6 +1782,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     static const int i2c_ports_per_engine[PNV9_CHIP_MAX_I2C] = {2, 13, 2, 2};
 
     k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
+    k->chip_type = PNV_TYPE_POWER9;
     k->cores_mask = POWER9_CORE_MASK;
     k->chip_pir = pnv_chip_pir_p9;
     k->intc_create = pnv_chip_power9_intc_create;
@@ -2091,6 +2095,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
 
     k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
+    k->chip_type = PNV_TYPE_POWER10;
     k->cores_mask = POWER10_CORE_MASK;
     k->chip_pir = pnv_chip_pir_p10;
     k->intc_create = pnv_chip_power10_intc_create;
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 8589f3291ed3..ebfe82b89537 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -17,12 +17,21 @@
 OBJECT_DECLARE_TYPE(PnvChip, PnvChipClass,
                     PNV_CHIP)
 
+typedef enum PnvChipType {
+    PNV_TYPE_POWER8E,     /* AKA Murano (default) */
+    PNV_TYPE_POWER8,      /* AKA Venice */
+    PNV_TYPE_POWER8NVL,   /* AKA Naples */
+    PNV_TYPE_POWER9,      /* AKA Nimbus */
+    PNV_TYPE_POWER10,
+} PnvChipType;
+
 struct PnvChip {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
     uint32_t     chip_id;
+
     uint64_t     ram_start;
     uint64_t     ram_size;
 
@@ -137,6 +146,7 @@ struct PnvChipClass {
     SysBusDeviceClass parent_class;
 
     /*< public >*/
+    PnvChipType  chip_type;
     uint64_t     chip_cfam_id;
     uint64_t     cores_mask;
     uint32_t     num_pecs;
-- 
2.44.0


