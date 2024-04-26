Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DA4C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 11:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0JKd-0000CL-U5; Fri, 26 Apr 2024 07:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0JKC-0008RT-BT; Fri, 26 Apr 2024 07:01:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0JKA-0008T1-E5; Fri, 26 Apr 2024 07:01:04 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QA3lNK025378; Fri, 26 Apr 2024 11:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=GpMcdPuq1PA3bLMuZz/wFJul2G+7uP9ofxPj2h93V4Y=;
 b=nvGXuEBthX+tf/5RqUYzCZ9RmchSIcIALgLKqbUrZIH3LnQ3Fj/5mJFYP1fG3AbdLgnK
 QtRYfUcL0cu16KQ2IAm2tBtiCA0Vl/YxIC/qs3pa+RrA7JxE++O1lRMeGNIOoYEb0Sab
 M9N0SyRMPrcOJP2UDA2hCLSQJihMTSxRbIu5EAupE2d7NnW5zz7ln2PF/uV5/gyaU4y7
 zbVYXSKrnCsADdvriZK6bA3Os3zYC1ckBAB4B27VRw30FsheQ6l8CBcDIlEj+OPWaDvH
 dUtDrkWSENo02KB36tzOUQJM+Yzuzh33hQrSZ8coaLWolotxcJ+VZvQa2e/xixZgoGYF yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xra63g3my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:53 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QB0AiG012411;
 Fri, 26 Apr 2024 11:00:52 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xra63g3mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:52 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43Q7jvRK028356; Fri, 26 Apr 2024 11:00:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr2xuj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QB0kln52953490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 11:00:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89E3E2004B;
 Fri, 26 Apr 2024 11:00:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 641502006A;
 Fri, 26 Apr 2024 11:00:44 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.171.14.245]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2024 11:00:44 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v2 07/10] ppc/pnv: Add a PSI bridge model for Power11
Date: Fri, 26 Apr 2024 16:30:20 +0530
Message-ID: <20240426110023.733309-8-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426110023.733309-1-adityag@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4edsYcy9aD9L2H6Bxuzhm39yN5x9f3V_
X-Proofpoint-ORIG-GUID: 6OZoCIE5GRzHoNkTnWs4HmBUJWrPj30D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260072
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

Power11 core is same as Power10, reuse PNV10_PSI initialisation, by
declaring 'PNV11_PSI' as child class of 'PNV10_PSI'

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_psi.c         | 24 ++++++++++++++++++++++++
 include/hw/ppc/pnv_psi.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 26460d210deb..1f708b183a87 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -939,6 +939,29 @@ static const TypeInfo pnv_psi_power10_info = {
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
@@ -973,6 +996,7 @@ static void pnv_psi_register_types(void)
     type_register_static(&pnv_psi_power8_info);
     type_register_static(&pnv_psi_power9_info);
     type_register_static(&pnv_psi_power10_info);
+    type_register_static(&pnv_psi_power11_info);
 }
 
 type_init(pnv_psi_register_types);
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index 2a6f715350b6..9e1d31779204 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -70,6 +70,8 @@ struct Pnv9Psi {
 
 #define TYPE_PNV10_PSI TYPE_PNV_PSI "-POWER10"
 
+#define TYPE_PNV11_PSI TYPE_PNV_PSI "-POWER11"
+
 
 struct PnvPsiClass {
     SysBusDeviceClass parent_class;
-- 
2.44.0


