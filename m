Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C851AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 11:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0JPC-0007k5-64; Fri, 26 Apr 2024 07:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0JP9-0007iz-MO; Fri, 26 Apr 2024 07:06:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0JP3-0001MB-4f; Fri, 26 Apr 2024 07:06:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QB5uYC025578; Fri, 26 Apr 2024 11:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=o5mmwpWln24izk7/WLw17cwc+L1Heaq1AU4H2mASA+0=;
 b=EcWp7yucEus2WfolLFOtW0PMUEBtAIve1u1TF20+iOhvJ6oNi4mSpNY1yzPFlbFdIhhe
 GpMpkbhuRRwjNTvXtFwSJjKDwFPtsbV94GzIXTn0nINb2N6WOf/4SyO1AeetFlWUU0ZL
 SxiMWkit0UDuN3nY32DKrsWaHE/JQZR84kFBx6WmwpUkQ6zLO2TzI+GAo9BZh/JWtZkz
 N3TBaFg7BDCQwkO/84c0G3oVk1boYLo/HUaulZS7pNspKMmoGolZyZU853DzZwX30O7W
 9eGw1DLlksnI2U9bk0PWvPN6r6W7vE7rdceSQOfVaPnkn6ymZjO9n8imLmulGEthAKO+ TA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrb2mr036-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:05:56 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QB5tMG025571;
 Fri, 26 Apr 2024 11:05:55 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrb2mr034-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:05:55 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43Q7veXT028341; Fri, 26 Apr 2024 11:00:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr2xujs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QB0ncp51970412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 11:00:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E6C62004B;
 Fri, 26 Apr 2024 11:00:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED0FE2004E;
 Fri, 26 Apr 2024 11:00:46 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.171.14.245]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2024 11:00:46 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v2 08/10] ppc/pnv: Add SBE model for Power11
Date: Fri, 26 Apr 2024 16:30:21 +0530
Message-ID: <20240426110023.733309-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426110023.733309-1-adityag@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RRscp_M98uAV_lXVf8vyQ6FVRuksx5aT
X-Proofpoint-GUID: luuJ5MMYDiXu5czrVKGuqDycWSbrkyFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260073
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Power11 core is same as Power10, reuse PNV10_SBER initialisation, by
declaring PNV11_PSI as child class of PNV10_PSI

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_sbe.c         | 15 +++++++++++++++
 include/hw/ppc/pnv_sbe.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 74cee4eea7ad..a655cc7f8c9e 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -366,6 +366,20 @@ static const TypeInfo pnv_sbe_power10_type_info = {
     .name          = TYPE_PNV10_SBE,
     .parent        = TYPE_PNV9_SBE,
     .class_init    = pnv_sbe_power10_class_init,
+    .class_base_init = pnv_sbe_power10_class_init,
+};
+
+static void pnv_sbe_power11_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV SBE Controller (POWER11)";
+}
+
+static const TypeInfo pnv_sbe_power11_type_info = {
+    .name          = TYPE_PNV11_SBE,
+    .parent        = TYPE_PNV10_SBE,
+    .class_init    = pnv_sbe_power11_class_init,
 };
 
 static void pnv_sbe_realize(DeviceState *dev, Error **errp)
@@ -409,6 +423,7 @@ static void pnv_sbe_register_types(void)
     type_register_static(&pnv_sbe_type_info);
     type_register_static(&pnv_sbe_power9_type_info);
     type_register_static(&pnv_sbe_power10_type_info);
+    type_register_static(&pnv_sbe_power11_type_info);
 }
 
 type_init(pnv_sbe_register_types);
diff --git a/include/hw/ppc/pnv_sbe.h b/include/hw/ppc/pnv_sbe.h
index b6b378ad14c7..09073a1256d6 100644
--- a/include/hw/ppc/pnv_sbe.h
+++ b/include/hw/ppc/pnv_sbe.h
@@ -29,6 +29,8 @@ OBJECT_DECLARE_TYPE(PnvSBE, PnvSBEClass, PNV_SBE)
 DECLARE_INSTANCE_CHECKER(PnvSBE, PNV9_SBE, TYPE_PNV9_SBE)
 #define TYPE_PNV10_SBE TYPE_PNV_SBE "-POWER10"
 DECLARE_INSTANCE_CHECKER(PnvSBE, PNV10_SBE, TYPE_PNV10_SBE)
+#define TYPE_PNV11_SBE TYPE_PNV_SBE "-POWER11"
+DECLARE_INSTANCE_CHECKER(PnvSBE, PNV11_SBE, TYPE_PNV11_SBE)
 
 struct PnvSBE {
     DeviceState xd;
-- 
2.44.0


