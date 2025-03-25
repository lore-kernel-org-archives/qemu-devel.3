Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CA5C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 11:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx2O4-0005Mu-EG; Tue, 25 Mar 2025 07:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx2O2-0005ML-SZ; Tue, 25 Mar 2025 07:24:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx2O0-000488-Uq; Tue, 25 Mar 2025 07:24:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P8o7iG023843;
 Tue, 25 Mar 2025 11:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/Apc6u
 B05ql3VJI0qxFa1sF8AzcQhlN7HEin81hzd3M=; b=QXIDJpfscWbrX+ti0wn4Nb
 x1ukM8utx49Gx0sezpqttTN6li5ivHn0ZuMCuTMGVCl9kAUYOiY2Bde5t03k35o5
 aBTbUFKZtHqnw0t2SaY4BoUvZW9t2ox8lrj1xLdfVdVoDmHKJW/YFTFUz9ARk/bW
 +Zzwt7Fcaaq9jCCFUBk9gnnnJNTzBJB29mP8DzVQbLME6nMz2dfltdygsfUwBqcS
 nRYYdvo2o/pNUrLrqESJr9/XSYmc5nn9BZ0CiqTZzk+xHNoZZHX9K1b+JGykrCrZ
 lnBuO9uPNjatXSQxUI33rjR3FAd9Agvzh1tstoPzF8aH0wuICBqDtrp1xDKbcHBw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyu7nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:23:55 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PBFTxj024923;
 Tue, 25 Mar 2025 11:23:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyu7nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:23:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52P97I77020639;
 Tue, 25 Mar 2025 11:23:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hnu3nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:23:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PBNo7K44827084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 11:23:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDC9A20043;
 Tue, 25 Mar 2025 11:23:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B80D920040;
 Tue, 25 Mar 2025 11:23:48 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.216.239])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 11:23:48 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v6 02/10] ppc/pnv: Add a LPC controller for Power11
Date: Tue, 25 Mar 2025 16:53:11 +0530
Message-ID: <20250325112319.927190-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325112319.927190-1-adityag@linux.ibm.com>
References: <20250325112319.927190-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zBKwTNId0gEWzxY74YYhEP3dMVDaV3Ga
X-Proofpoint-GUID: 52tOW2mesbrwCYQZsiRmfR1pmLj8Hyad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=955 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250076
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

Power11 core is same as Power10 core, declare PNV11_LPC as a child
class of PNV10_LPC, so it goes through same class init

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_lpc.c         | 14 ++++++++++++++
 include/hw/ppc/pnv_lpc.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d812dc826810..8178794705ab 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -790,6 +790,19 @@ static const TypeInfo pnv_lpc_power10_info = {
     .class_init    = pnv_lpc_power10_class_init,
 };
 
+static void pnv_lpc_power11_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV LPC Controller Power11";
+}
+
+static const TypeInfo pnv_lpc_power11_info = {
+    .name          = TYPE_PNV11_LPC,
+    .parent        = TYPE_PNV10_LPC,
+    .class_init    = pnv_lpc_power11_class_init,
+};
+
 static void pnv_lpc_realize(DeviceState *dev, Error **errp)
 {
     PnvLpcController *lpc = PNV_LPC(dev);
@@ -868,6 +881,7 @@ static void pnv_lpc_register_types(void)
     type_register_static(&pnv_lpc_power8_info);
     type_register_static(&pnv_lpc_power9_info);
     type_register_static(&pnv_lpc_power10_info);
+    type_register_static(&pnv_lpc_power11_info);
 }
 
 type_init(pnv_lpc_register_types)
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 174add4c53be..c3f621fe8ce1 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -42,6 +42,10 @@ DECLARE_INSTANCE_CHECKER(PnvLpcController, PNV9_LPC,
 DECLARE_INSTANCE_CHECKER(PnvLpcController, PNV10_LPC,
                          TYPE_PNV10_LPC)
 
+#define TYPE_PNV11_LPC TYPE_PNV_LPC "-POWER11"
+DECLARE_INSTANCE_CHECKER(PnvLpcController, PNV11_LPC,
+                         TYPE_PNV11_LPC)
+
 struct PnvLpcController {
     DeviceState parent;
 
-- 
2.49.0


