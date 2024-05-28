Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977B3C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqv3-0007OW-FN; Tue, 28 May 2024 03:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBqun-0007AK-Bx; Tue, 28 May 2024 03:06:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBqub-0004l0-VJ; Tue, 28 May 2024 03:06:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S6AkMk000526; Tue, 28 May 2024 07:05:44 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DQ9Z?=
 =?UTF-8?Q?dG0LLGazrxsNfC5nM56OqVLfyGj+FQT9ZhTdSjrE=3D;_b=3DXjon03/t5+6tMi?=
 =?UTF-8?Q?EMN1HRIg2mqfoYjiqoP5b33G1AlZ/+9A3rX+KL7CN+tdrlUydUzavW_ug5cPpf8?=
 =?UTF-8?Q?Qy0cjS0ddraHvreZGu3EbQJ4XaOEb0bJU4pVU2T2ddD0KoM6vPMdERS7JHKi_vP?=
 =?UTF-8?Q?5ogcamrvdxXcI3ZpGh2ZkX4KloDn/j/lswdo/MIoKPW3sgv7u4r26afPIoVBraU?=
 =?UTF-8?Q?cXq_8JD338w4S2J/O7jFc4c8F/eqr8p8gAIs85ggXGTpifGjWsk2zo5DQmql+EL?=
 =?UTF-8?Q?Vx2edZwY4_Vdw68vJ01cEgxZ9LyYSXeQHnWc9TLivenJiyBtKWnh5cFRDzGbCHr?=
 =?UTF-8?Q?w6GVHZMS1/wsyDx_Yw=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd90488ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:44 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S75hQI023735;
 Tue, 28 May 2024 07:05:43 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd90488nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:43 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S47uuL010920; Tue, 28 May 2024 07:05:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybw12n0be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44S75bCp46989600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 07:05:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59C1420043;
 Tue, 28 May 2024 07:05:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71C5620040;
 Tue, 28 May 2024 07:05:35 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 07:05:35 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v4 08/11] ppc/pnv: Add OCC for Power11
Date: Tue, 28 May 2024 12:35:12 +0530
Message-ID: <20240528070515.117160-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528070515.117160-1-adityag@linux.ibm.com>
References: <20240528070515.117160-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7GI8WRQkAWk9Flb0jqe9JCDsPQd_EYGc
X-Proofpoint-ORIG-GUID: gVycCCEMB2PZIjbzSRb2bUATZrvwd35r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=912 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.45.1


