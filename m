Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33ACC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 20:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1A7-0002oE-JZ; Sat, 08 Mar 2025 15:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tr1A4-0002js-LM; Sat, 08 Mar 2025 15:52:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tr1A3-0007Rt-6s; Sat, 08 Mar 2025 15:52:44 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528Kq9OL011892;
 Sat, 8 Mar 2025 20:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ensJfO
 r+JfK0peq57YGG3v2YzXFHdBtv2/otWU9hKpU=; b=iosogx7DXGaEG3xyGZ/+5a
 QxdkVNjOs4t/pjmATWI7+GpsvO/51l1O2KsX7uRDi6ajBXihLM2xRPnX3zdyIQCe
 iqNkMoLLXK3ZX4Yut9jXCbYOrBf8ETh9gy9f4X78NRQUa9aHwsai+mIMh28plNVV
 kmGVqcdHnHK9qqTTkFDr78qKI4/IOIGPiTtFn1r/tYuZsb5Cf/3WS6SWUJ3VHz0u
 jvcEve8Q8Z19Y+Ec/thVaQ0+lyFjoayx/aJpz3nsYZiqmD+hVkqcvsAjM0mq4A4s
 NxN/pgVPPhsc4KVfn7Qtc2R/ePGDtZyUkmGkI2eEnQpS6MgRuLO9TRvCYros8htg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458wa4g014-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 528KqYva012717;
 Sat, 8 Mar 2025 20:52:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458wa4g011-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 528J8MRu008958;
 Sat, 8 Mar 2025 20:52:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cy061cw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:52:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 528KqUf949414566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 8 Mar 2025 20:52:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73B5A2004B;
 Sat,  8 Mar 2025 20:52:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D3B520043;
 Sat,  8 Mar 2025 20:52:28 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.32]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  8 Mar 2025 20:52:27 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v5 4/8] ppc/pnv: Add a PSI bridge model for Power11
Date: Sun,  9 Mar 2025 02:21:37 +0530
Message-ID: <20250308205141.3219333-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308205141.3219333-1-adityag@linux.ibm.com>
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W2z53H5Qt5VmH8HJ_LddGrckmR1wwfsp
X-Proofpoint-ORIG-GUID: _5RwzPODXzzwRIXN49wHaCEWZg0rxrPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=912 classifier=spam adjust=0 reason=mlx scancount=1
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

Power11 core is same as Power10, reuse PNV10_PSI initialisation, by
declaring 'PNV11_PSI' as child class of 'PNV10_PSI'

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_psi.c         | 24 ++++++++++++++++++++++++
 include/hw/ppc/pnv_psi.h |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 1fe11dde501b..d2bc2bdd2c8b 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -937,6 +937,29 @@ static const TypeInfo pnv_psi_power10_info = {
     .name          = TYPE_PNV10_PSI,
     .parent        = TYPE_PNV9_PSI,
     .class_init    = pnv_psi_power10_class_init,
+    .class_base_init = pnv_psi_power10_class_init,
+};
+
+static void pnv_psi_power11_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvPsiClass *ppc = PNV_PSI_CLASS(klass);
+    static const char compat[] = "ibm,power11-psihb-x\0ibm,psihb-x";
+
+    dc->desc    = "PowerNV PSI Controller POWER11";
+
+    /*
+     * ppc->xscom_pbca and ppc->xscom_size will be set up by
+     * pnv_psi_power10_class_init
+     */
+    ppc->compat     = compat;
+    ppc->compat_size = sizeof(compat);
+}
+
+static const TypeInfo pnv_psi_power11_info = {
+    .name          = TYPE_PNV11_PSI,
+    .parent        = TYPE_PNV10_PSI,
+    .class_init    = pnv_psi_power11_class_init,
 };
 
 static void pnv_psi_class_init(ObjectClass *klass, void *data)
@@ -971,6 +994,7 @@ static void pnv_psi_register_types(void)
     type_register_static(&pnv_psi_power8_info);
     type_register_static(&pnv_psi_power9_info);
     type_register_static(&pnv_psi_power10_info);
+    type_register_static(&pnv_psi_power11_info);
 }
 
 type_init(pnv_psi_register_types);
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index cf7f95a6b1f5..1182ed47d280 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -69,7 +69,7 @@ struct Pnv9Psi {
 };
 
 #define TYPE_PNV10_PSI TYPE_PNV_PSI "-POWER10"
-
+#define TYPE_PNV11_PSI TYPE_PNV_PSI "-POWER11"
 
 struct PnvPsiClass {
     SysBusDeviceClass parent_class;
-- 
2.48.1


