Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494B6C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 20:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1A5-0002kZ-I4; Sat, 08 Mar 2025 15:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tr1A3-0002j1-ET; Sat, 08 Mar 2025 15:52:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tr1A1-0007Rc-Te; Sat, 08 Mar 2025 15:52:43 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528KqdE7012863;
 Sat, 8 Mar 2025 20:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JBwpaP
 CjtsPsP8265Kuim9S9U4XGLb0EBxIzoew96yE=; b=gJIjKvCK9HhmUDEt4NTTer
 yWaURrQzZS2xUp2/f4huqUf6li7yxk4Euc2ImBWSu4UNX7I2fQ5l4xwDZvs+nE8E
 v9TCZ9lhzlrYxfWQzNI+Qp7i71yixB0rPhcNt7cIQc4sKqxZYxGkErh3zBwZBaLA
 p8vD+jaggwAVYX20ZX8zO/UBDaaXC29ujAUJWoCIcV1uc32zIARb5XtmqRuWbOGi
 kxxh48EOqMgRXaIVHtcoVySGl+ORC4QWbKcrCWe7AhDwWewMsxBcI6cPUbe/Hv1v
 KXETn7RL09Tu+wo2rrjpJ7HayMW2m5GzhXo1KRzQH/4MwbCpRqMt8dPu2Z/DqWJg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458wa4g017-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 528KqYvc012717;
 Sat, 8 Mar 2025 20:52:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458wa4g015-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 528H0Uce013784;
 Sat, 8 Mar 2025 20:52:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2mdu0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 528KqYb226673698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 8 Mar 2025 20:52:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9DFD2004B;
 Sat,  8 Mar 2025 20:52:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9258420040;
 Sat,  8 Mar 2025 20:52:31 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.32]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  8 Mar 2025 20:52:31 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v5 5/8] ppc/pnv: Add SBE model for Power11
Date: Sun,  9 Mar 2025 02:21:38 +0530
Message-ID: <20250308205141.3219333-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308205141.3219333-1-adityag@linux.ibm.com>
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3KVHKkbYMfraG1vGBUTMLV6J9rmtGcya
X-Proofpoint-ORIG-GUID: pjyoKLdx8e6F-fsOBs_5DcDayMzTi6wq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=963 classifier=spam adjust=0 reason=mlx scancount=1
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

Power11 core is same as Power10, reuse PNV10_SBE initialisation, by
declaring PNV11_SBE as child class of PNV10_SBE

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
2.48.1


