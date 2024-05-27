Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F85FC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUWH-0004Co-NV; Mon, 27 May 2024 03:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUW2-0003wm-Vv; Mon, 27 May 2024 03:11:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUW0-0003T0-Az; Mon, 27 May 2024 03:11:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R7AS5A008397; Mon, 27 May 2024 07:11:18 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DW8B?=
 =?UTF-8?Q?jaysw443IWw7kJD6fjTEldh3vld9SoWsblYEZLHo=3D;_b=3Da4jcB6MosVrVsm?=
 =?UTF-8?Q?tb2J4taZ89uk+wVHHDkBiAaQgTKKFM0Ws2n0vAeYS97izbI2GUGJfs_bHUbdr3F?=
 =?UTF-8?Q?ll8DOVdVMSVHoA5plXqWZvv9VKO+mW18h0a2u+BYPkSWxIf3398xvvlGsJl0_Ff?=
 =?UTF-8?Q?71oQVIxU9YOj3NK56pXVCbCsiQIPrFLcMfG6e3V9vZCWLhEGQVZf/5ke3Bh0LBb?=
 =?UTF-8?Q?jG0_EDvlEp/pINuZcYetXfjrz51tPmCd7ZC8tL0ywX8XuwmrC8hMOC9mQF40Wc+?=
 =?UTF-8?Q?vFOrHMCHS_ubTEMZlx5u65aq01wkF0JK5ZTLBr2EGx27N7IYgZCyWpHzsTFOEFH?=
 =?UTF-8?Q?9l2+EnGBFz/xqIf_FA=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycnbur0y8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:11:18 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44R7BHTm010060;
 Mon, 27 May 2024 07:11:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycnbur0xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:11:17 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R5Adum004520; Mon, 27 May 2024 07:11:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ybuanqheh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:11:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44R7BApB29622702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2024 07:11:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBEA020043;
 Mon, 27 May 2024 07:11:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A66582004B;
 Mon, 27 May 2024 07:11:08 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.179.2.64]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 May 2024 07:11:08 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v3 09/11] ppc/pnv: Add a PSI bridge model for Power11
Date: Mon, 27 May 2024 12:40:40 +0530
Message-ID: <20240527071042.489540-10-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527071042.489540-1-adityag@linux.ibm.com>
References: <20240527071042.489540-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G1d9-QBttkMC-FA2yHuxTjJZoKHvNo4U
X-Proofpoint-ORIG-GUID: ylEALst5iZSNOveCkyGRLwy3jMNZctDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=988 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405270057
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
2.45.1


