Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBB6C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 20:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr19n-0002eB-11; Sat, 08 Mar 2025 15:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tr19k-0002bx-Gn; Sat, 08 Mar 2025 15:52:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tr19i-00072P-Ub; Sat, 08 Mar 2025 15:52:24 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528E3VaC017812;
 Sat, 8 Mar 2025 20:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WG4kHL
 t+f37sehKlwR5ktEKPljdq65/TBAT/BK7px5s=; b=RzHJKSx4rSOWjKmFHWRGSk
 mpGoqHuwQIw0bTTnweIixA8xJCouvvwOHo1t62Tu99TErPQ2ymYJucqMxoIEnM5m
 7N0/6slO/z0lcirku19U0ctZimu0HXsuYyG1/5IXL4ZCmbUDiM5LfZzsddLL7GXy
 kyNS2p4ljlUEDy4qvX+Z95Dcb6UBiv1v3kGcR2eMZzfg+yB5K47b69hpoztxznTk
 CV6pOBc6leJxJEAfFL6t8pIO0FyxzrZYJmtwu5sW+0dhTOn9V6dmpF74+Pc9uDEM
 ceDBOg2vx3g6pkFZUW+smGyEa9V05tJgsx7xHy/5Eu3erJTbZj0QtfZEOm76F2ZA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458qans5p4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 528KqCnK023418;
 Sat, 8 Mar 2025 20:52:12 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458qans5p2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 528JKHS5031827;
 Sat, 8 Mar 2025 20:52:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjtp4dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 528Kq7PZ52887948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 8 Mar 2025 20:52:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B523920043;
 Sat,  8 Mar 2025 20:52:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DF1C20040;
 Sat,  8 Mar 2025 20:52:05 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.32]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  8 Mar 2025 20:52:05 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v5 1/8] ppc/pnv: Add HOMER for POWER11
Date: Sun,  9 Mar 2025 02:21:34 +0530
Message-ID: <20250308205141.3219333-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308205141.3219333-1-adityag@linux.ibm.com>
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0Hm66y-Dh7AC9n80kG-hh61vKPkVj17P
X-Proofpoint-ORIG-GUID: ZERo8yiREECdIYPgk9Aio8ql6L08MmCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=784 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503080159
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
index a1d83c8149d3..f314e823f11a 100644
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
@@ -441,6 +448,7 @@ static void pnv_homer_register_types(void)
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
2.48.1


