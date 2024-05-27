Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C88AC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUWC-00046C-Rc; Mon, 27 May 2024 03:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUVu-0003oy-2k; Mon, 27 May 2024 03:11:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUVs-0003SE-DH; Mon, 27 May 2024 03:11:21 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R77jHt009063; Mon, 27 May 2024 07:11:11 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3D/3Y?=
 =?UTF-8?Q?Cl/4f/GNbshg2zK4MPZ8AFxvVUu8lM3Tjk5um5jY=3D;_b=3DZFw0LxkDZWrgFI?=
 =?UTF-8?Q?uKSQ47Gc2FiYdSHi2Qw+VLXgrijKQ7sHNeHRJN5vFE5U9YG/9CIJZ2_TuoAQxpO?=
 =?UTF-8?Q?ztijI0VtS/ZTotk2LA9VNBAcwdI1XifTxIEFmkR5AdyXjqI8B8O7wTcgXg4n_jl?=
 =?UTF-8?Q?OJdkhWcA63nrE7emE2xODKEM5AJcS9G5Tq2JpN944YZAZtXJYFPwvNOqlMilbb/?=
 =?UTF-8?Q?XGU_dItLtmKTPVeVAcA8SCzQZkfTI4nAG1yKRZhGJFu03soggjeELBDk8RKo9KS?=
 =?UTF-8?Q?Uwn7Nlvez_xJNJsHb73IgEyKjbGstk0+Y/XzlVIHLhDNfmSt2J7pdSRpDCbaYFS?=
 =?UTF-8?Q?OLRSqJeLDXBJ6e0_0Q=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycngng0ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:11:10 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44R7BAWm014097;
 Mon, 27 May 2024 07:11:10 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycngng0b8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:11:10 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R4DPku011096; Mon, 27 May 2024 07:11:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ybtpyyqd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:11:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44R7B3X550397510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2024 07:11:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2663C20040;
 Mon, 27 May 2024 07:11:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2B3B20043;
 Mon, 27 May 2024 07:11:00 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.179.2.64]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 May 2024 07:11:00 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v3 06/11] ppc/pnv: Add HOMER for POWER11
Date: Mon, 27 May 2024 12:40:37 +0530
Message-ID: <20240527071042.489540-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527071042.489540-1-adityag@linux.ibm.com>
References: <20240527071042.489540-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KIYyoPF2KMFfAkyTW2ku1LvVmyTQSM2w
X-Proofpoint-GUID: fpJgdhIeZoUf3Cb370l50TDrdMoNMUrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxlogscore=813 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405270057
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Power11 core is same as Power10, declare PNV11_HOMER as a child
class of PNV10_HOMER, so it goes through same class init

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_homer.c         | 8 ++++++++
 include/hw/ppc/pnv_homer.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index f9a203d11d0d..1b0123a6f2ea 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -394,6 +394,13 @@ static const TypeInfo pnv_homer_power10_type_info = {
     .parent        = TYPE_PNV_HOMER,
     .instance_size = sizeof(PnvHomer),
     .class_init    = pnv_homer_power10_class_init,
+    .class_base_init = pnv_homer_power10_class_init,
+};
+
+static const TypeInfo pnv_homer_power11_type_info = {
+    .name          = TYPE_PNV11_HOMER,
+    .parent        = TYPE_PNV10_HOMER,
+    .instance_size = sizeof(PnvHomer),
 };
 
 static void pnv_homer_realize(DeviceState *dev, Error **errp)
@@ -442,6 +449,7 @@ static void pnv_homer_register_types(void)
     type_register_static(&pnv_homer_power8_type_info);
     type_register_static(&pnv_homer_power9_type_info);
     type_register_static(&pnv_homer_power10_type_info);
+    type_register_static(&pnv_homer_power11_type_info);
 }
 
 type_init(pnv_homer_register_types);
diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
index b1c5d498dc55..8f1cc8135937 100644
--- a/include/hw/ppc/pnv_homer.h
+++ b/include/hw/ppc/pnv_homer.h
@@ -35,6 +35,9 @@ DECLARE_INSTANCE_CHECKER(PnvHomer, PNV9_HOMER,
 #define TYPE_PNV10_HOMER TYPE_PNV_HOMER "-POWER10"
 DECLARE_INSTANCE_CHECKER(PnvHomer, PNV10_HOMER,
                          TYPE_PNV10_HOMER)
+#define TYPE_PNV11_HOMER TYPE_PNV_HOMER "-POWER11"
+DECLARE_INSTANCE_CHECKER(PnvHomer, PNV11_HOMER,
+                         TYPE_PNV11_HOMER)
 
 struct PnvHomer {
     DeviceState parent;
-- 
2.45.1


