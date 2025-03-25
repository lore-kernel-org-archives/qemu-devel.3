Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD47C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 11:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx2O6-0005O1-Gp; Tue, 25 Mar 2025 07:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx2O4-0005Mg-6p; Tue, 25 Mar 2025 07:24:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx2O2-00048e-DO; Tue, 25 Mar 2025 07:24:03 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P3jvgP025440;
 Tue, 25 Mar 2025 11:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mAds9U
 zv2OoT1bpW3YTnFgvA1Vx4+zfeGJvzk8XwL+M=; b=pW0iuWq5HaSn3bF9UvnaxZ
 i+A3T9f9KVaOjjkEkuA1TOkoYJ2w8BshZFEbW/5Xz6p5KhzVIaAJSw8gp/tPB/+Z
 yW8VHmePzQRU0t5Mw2f1DcVMeqMMiO8muqMO/yN8lNeNmPEF1Ut5apmAeNwkmDsA
 9TmofeOTchdVWRHK5x3tTugPLzdeaIE//M22sHKc/aDiuuDoF19quxlKyoCt3mwQ
 ihjir2BvExhdh1cXLggfjdpuMwOO7e5k/rNylt2FGzpCWZbIov1q79aCbMCpTzfo
 AI2Kop/F2IojaM0idnRNlA5SjyhGXW5fx3ih5g6/utnJ1yj4TYx4SEyDhc6g+BJg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kmva1xvu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:23:58 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PBG6MH008317;
 Tue, 25 Mar 2025 11:23:58 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kmva1xvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:23:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PAGFX4005969;
 Tue, 25 Mar 2025 11:23:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82asds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:23:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PBNrAP55509320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 11:23:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 702A12004B;
 Tue, 25 Mar 2025 11:23:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E8B420040;
 Tue, 25 Mar 2025 11:23:51 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.216.239])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 11:23:51 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v6 03/10] ppc/pnv: Add OCC for Power11
Date: Tue, 25 Mar 2025 16:53:12 +0530
Message-ID: <20250325112319.927190-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325112319.927190-1-adityag@linux.ibm.com>
References: <20250325112319.927190-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5nt9UAJHP1gXMa9nFMJBxPNKpfw-nBm7
X-Proofpoint-GUID: rcP9iuxDQb2pcGaia4jOu3D0ZVi-vN4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Power11 core is same as Power10, reuse PNV10_OCC initialisation,
by declaring `PNV11_OCC` as child class of `PNV10_OCC`

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_occ.c         | 14 ++++++++++++++
 include/hw/ppc/pnv_occ.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 177c5e514b74..89932bc26ec7 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -286,6 +286,19 @@ static const TypeInfo pnv_occ_power10_type_info = {
     .class_init    = pnv_occ_power10_class_init,
 };
 
+static void pnv_occ_power11_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV OCC Controller (Power11)";
+}
+
+static const TypeInfo pnv_occ_power11_type_info = {
+    .name          = TYPE_PNV11_OCC,
+    .parent        = TYPE_PNV10_OCC,
+    .class_init    = pnv_occ_power11_class_init,
+};
+
 static bool occ_init_homer_memory(PnvOCC *occ, Error **errp);
 static bool occ_model_tick(PnvOCC *occ);
 
@@ -360,6 +373,7 @@ static void pnv_occ_register_types(void)
     type_register_static(&pnv_occ_power8_type_info);
     type_register_static(&pnv_occ_power9_type_info);
     type_register_static(&pnv_occ_power10_type_info);
+    type_register_static(&pnv_occ_power11_type_info);
 }
 
 type_init(pnv_occ_register_types);
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index 3ec42de0ff16..a42d26118cd5 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -34,6 +34,8 @@ DECLARE_INSTANCE_CHECKER(PnvOCC, PNV9_OCC,
                          TYPE_PNV9_OCC)
 #define TYPE_PNV10_OCC TYPE_PNV_OCC "-POWER10"
 DECLARE_INSTANCE_CHECKER(PnvOCC, PNV10_OCC, TYPE_PNV10_OCC)
+#define TYPE_PNV11_OCC TYPE_PNV_OCC "-POWER11"
+DECLARE_INSTANCE_CHECKER(PnvOCC, PNV11_OCC, TYPE_PNV11_OCC)
 
 #define PNV_OCC_SENSOR_DATA_BLOCK_OFFSET 0x00580000
 #define PNV_OCC_SENSOR_DATA_BLOCK_SIZE   0x00025800
-- 
2.49.0


