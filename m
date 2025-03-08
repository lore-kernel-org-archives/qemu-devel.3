Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33025C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 20:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1A4-0002jK-8P; Sat, 08 Mar 2025 15:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tr1A2-0002iW-7d; Sat, 08 Mar 2025 15:52:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tr1A0-0007RR-My; Sat, 08 Mar 2025 15:52:41 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528KcWGY007425;
 Sat, 8 Mar 2025 20:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FnUx5D
 xvyVdz78/c9VKqX3UpRE72FGx2YcbqIrBra0g=; b=gC2JGkEcH1OLc4iU3aEK6Q
 KK6DIqjSFN473IGz0+iqJMRnyiTGfF7K0J/jtSr5++CYVw0a0Bi7PWK1q/M8jG3H
 X1oDASke7V/52Z4nrG+RQ2dEllGfg65dbdDmespF7xIftnsfK404RY2DfV+46YTy
 5Iby129LZF6rpeqPMljfMQTmesOCKhpmjdMI7oAe9b74RgsIX0MYHB6FBvoOgUgL
 HUxydXsyBayBog/jhzdpPaHzvSngOSeNXGWn6F2zQVfeR0tyVaHYdRKbfqVa1Mld
 IT9yd73NaGx/jGuDbnaMqVi+K+n0Q8RbuNgotMmSmCaBOHM8K19xAjLRyDkeKNvg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458w3yg17b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 528KqVji030222;
 Sat, 8 Mar 2025 20:52:31 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458w3yg179-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 528IxkB2032243;
 Sat, 8 Mar 2025 20:52:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjtp4dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 528KqR2820119812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 8 Mar 2025 20:52:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1869320043;
 Sat,  8 Mar 2025 20:52:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA9D920040;
 Sat,  8 Mar 2025 20:52:24 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.32]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  8 Mar 2025 20:52:24 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v5 3/8] ppc/pnv: Add OCC for Power11
Date: Sun,  9 Mar 2025 02:21:36 +0530
Message-ID: <20250308205141.3219333-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308205141.3219333-1-adityag@linux.ibm.com>
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n3-RiZuEWdEm5tusilw3ib4PZDkl8InI
X-Proofpoint-GUID: jGZ6RK3Ac9-Lh1Cg-28ovWNB2yzRxFCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=906
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503080159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
index 48123ceae176..4f510419045e 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -262,6 +262,19 @@ static const TypeInfo pnv_occ_power10_type_info = {
     .class_init    = pnv_occ_power10_class_init,
 };
 
+static void pnv_occ_power11_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV OCC Controller (POWER11)";
+}
+
+static const TypeInfo pnv_occ_power11_type_info = {
+    .name          = TYPE_PNV11_OCC,
+    .parent        = TYPE_PNV10_OCC,
+    .class_init    = pnv_occ_power11_class_init,
+};
+
 static void pnv_occ_realize(DeviceState *dev, Error **errp)
 {
     PnvOCC *occ = PNV_OCC(dev);
@@ -305,6 +318,7 @@ static void pnv_occ_register_types(void)
     type_register_static(&pnv_occ_power8_type_info);
     type_register_static(&pnv_occ_power9_type_info);
     type_register_static(&pnv_occ_power10_type_info);
+    type_register_static(&pnv_occ_power11_type_info);
 }
 
 type_init(pnv_occ_register_types);
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index df321244e3b1..7b5e28f13b4f 100644
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
2.48.1


