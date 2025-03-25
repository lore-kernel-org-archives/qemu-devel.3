Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1D1C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 11:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx2OE-0005Ra-To; Tue, 25 Mar 2025 07:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx2OC-0005PB-ND; Tue, 25 Mar 2025 07:24:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx2OA-0004BK-IC; Tue, 25 Mar 2025 07:24:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P3kCKh025662;
 Tue, 25 Mar 2025 11:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=URNpJ9
 uRw0qeexnsJaN2Hic52xxragkNHQj2N5NIc64=; b=esz9JmJIfX0879ivKtF2WS
 3nmT48mG+NgrgREuM5CeAwhuGpqCPXY8SOvj6x5NtPAnjnBJCVwn44XHllvzpWBb
 231nkwGhTrJInM7KGuCZqxl/4EPX0+/v0nK3ktUwnE/EXXhDCd9S4N/NHBorhXL8
 I+yoy9+UUX1D//OdW2lwam5T1xfHxweMBcHSTHskMVfslw/FdPCy4cC3Yv19uqSA
 63iZU7zGsvF3ET20zYAhcE9Cbablkffk4JWP1wPFWcZC3X89LZxZRj0/Kh/60hWV
 JAFjKjD88FSbf3I/HMw1pKMiNCdrFsr50u/PNyt7y9P2CJiXfM/Sjl0OUwEwQ1jQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kmva1xw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:24:00 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PB7kmJ020217;
 Tue, 25 Mar 2025 11:24:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kmva1xvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:24:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52P7qwYi030299;
 Tue, 25 Mar 2025 11:23:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htba0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:23:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PBNuRd60162436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 11:23:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECACE2004B;
 Tue, 25 Mar 2025 11:23:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D037B20040;
 Tue, 25 Mar 2025 11:23:53 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.216.239])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 11:23:53 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v6 04/10] ppc/pnv: Add a PSI bridge model for Power11
Date: Tue, 25 Mar 2025 16:53:13 +0530
Message-ID: <20250325112319.927190-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325112319.927190-1-adityag@linux.ibm.com>
References: <20250325112319.927190-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DrET2kHcdIaEyisxnk3gyjNxIr0OQ2Gq
X-Proofpoint-GUID: xcO3qzEAdA2IABDpsrI7zexQhrPDcJZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxlogscore=925 bulkscore=0 suspectscore=0
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
index 1fe11dde501b..c568edb80e53 100644
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
+    dc->desc    = "PowerNV PSI Controller (Power11)";
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
2.49.0


