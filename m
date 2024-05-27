Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54617C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUsY-0008Sn-3y; Mon, 27 May 2024 03:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUsC-0008KX-SK; Mon, 27 May 2024 03:34:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUs9-00084R-W3; Mon, 27 May 2024 03:34:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R6lE63009336; Mon, 27 May 2024 07:34:19 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3D0jg?=
 =?UTF-8?Q?tKrYf5jfhF77+OmWmxZ1folxqtx9UGc4ste1RsPI=3D;_b=3DNan+TVlHxrRfZv?=
 =?UTF-8?Q?E6yb7zXOi3qWIHNFaYvOzaw7A7A9UA4nFz5S3nWnmHnCKcabKHVi6g_eUyP79Dx?=
 =?UTF-8?Q?7qknvSLx2+O16FsAP8Wz9qVVF4bW6f3E3qHHrsllYZC8d0JEQPilp0CXY3jz_x3?=
 =?UTF-8?Q?p0g1bDiGlCyU36Lf5KVDJrY0x/pFP3VulXiP4yiS4fZnJnfH3CQPmL5aIndDdTU?=
 =?UTF-8?Q?OZB_xE+iSsUQ9MyzZUQCesnjXpzt2ESl/OjCLQrbRg/MGVeDMbjFx/qJjUni99Z?=
 =?UTF-8?Q?MFG21psIg_fBvoC6LsHpvJ9f+W09kPcPoeYLuwEGP72XmXPXtuOYYb4+Z+Eu0Q8?=
 =?UTF-8?Q?NO2cZ3ARsm/XQKO_xg=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycn77r47q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:34:18 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44R7YIG1021247;
 Mon, 27 May 2024 07:34:18 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycn77r47j-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:34:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R6UTmS027093; Mon, 27 May 2024 07:11:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybvhkf6uq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:11:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44R7BDex34996772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2024 07:11:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60C1F20040;
 Mon, 27 May 2024 07:11:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B88A2004B;
 Mon, 27 May 2024 07:11:11 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.179.2.64]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 May 2024 07:11:10 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v3 10/11] ppc/pnv: Add SBE model for Power11
Date: Mon, 27 May 2024 12:40:41 +0530
Message-ID: <20240527071042.489540-11-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527071042.489540-1-adityag@linux.ibm.com>
References: <20240527071042.489540-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K3-l0Grs_iiQ6RWMpRBmPJM-tRm9PUEw
X-Proofpoint-GUID: l1V03l-X32VD3pzfHwBY_1VO-vVHWjwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=986
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405270060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
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
2.45.1


