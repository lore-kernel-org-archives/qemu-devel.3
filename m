Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C18FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9jh-0007v3-0F; Wed, 29 Apr 2026 14:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jc-0007nV-OX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:34:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jX-0007DA-Vc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:34:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TIEAbb1973593
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=u7PmL0DPcJ17q5P43
 x3UH4AeWo6hO13Jc83RjVZt+nw=; b=IUw37U7HrRoEiRGd2usAjA6B8/p7pcK4u
 pjWAU0TdoP6+Qgc1k350HfnDpCRhfebj1xOkQGU5lqjPH50ALKrsZ8KeBCDn0ogu
 XO/SNEP0ArapeE7lNW4eJeRxJ97Qag0kH8tiM8iJkP1BcOAy4HEpSra+61LvOxI+
 F+hYpHz0Tj4E+/DFwMn6lgafGYAsvrvsKrkCUEJSvos9BI4FipjE+75sCKS5qTm0
 /9B8TFexy2qNMhFKLmaIuZAJ+98ytsu3D9uoVvI1s+FulDGYYOrdU+ZUuNGZILX0
 cBYuqUbkXn/BGGwpP3t46onb52gkgM0LBRA4muCiGw/6po3BWJGaw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44v6bu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 18:34:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TINoNr014447;
 Wed, 29 Apr 2026 18:34:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqfqhw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 18:34:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TIXvnM9044252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 18:33:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCB122004E;
 Wed, 29 Apr 2026 18:33:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5462F20049;
 Wed, 29 Apr 2026 18:33:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.77])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 18:33:55 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Caleb Schlossin <calebs@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 11/13] hw/ssi/pnv_spi: Fix fifo8 memory leak on unrealize
Date: Thu, 30 Apr 2026 00:03:01 +0530
Message-ID: <20260429183310.12455-12-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260429183310.12455-1-harshpb@linux.ibm.com>
References: <20260429183310.12455-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8Q9JkKSUSbrqcTLN2mOpMN4fl0vDN_yX
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f24f1a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=Q8LBFeAF4jmk_nWGM1UA:9
X-Proofpoint-GUID: d5FiGD7l7op7p0b5R2XAmyJ5zz5ttHLN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4NCBTYWx0ZWRfX/MZCVJciYxTe
 0TSliaqY/lkfIsYEBgFRLf8CbNhA+pAmAdTSIkCMoJWz/HBBNatoflyXXr6WYgWo1i1BEeNn5eZ
 ezmPK2oP3Tl2RrT9NSMzw81I0wR5GnPUF5wq87mISb7kDuH1KPn2HSy7aOqt3H1NYrMffBZBkrZ
 stfUqopXaMWgk2KXA65eV37p3Og+TUjS7OB9NYC5cfpBp79tQKGianXTVpmvUk4Guqcq525MxCi
 bWuX+vDi5k2W24hu2RhlZc5RAJGK8QueJmHU/B64clqR4lTjNCxhtIhmKXzLmol2u47bLHU8bvd
 WEi8JA3SDLDfFG7t/MItPko9mLQQ8M4Y+jo8PpdwQMxq7WoFmGlcclWK5Y1C7kuu+OQtlM17CK7
 GlhSyBVMQJM78kUJffNKwXu/EkIYCVtQ/HOd9rDOGgynx8q+uQVdma8FPonCuVsMpK7NVfkrR7c
 gV7O0X5Njp+y7qKWHNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290184
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Caleb Schlossin <calebs@linux.ibm.com>

unrealize should free the fifo8 memory that was allocated by realize.

Fixes: 17befecda85 ("hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure")

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260120145117.602960-1-calebs@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ssi/pnv_spi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 76304d26fc..f3add8cab9 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1177,6 +1177,13 @@ static void pnv_spi_realize(DeviceState *dev, Error **errp)
                           s, "xscom-spi", PNV10_XSCOM_PIB_SPIC_SIZE);
 }
 
+static void pnv_spi_unrealize(DeviceState *dev)
+{
+    PnvSpi *s = PNV_SPI(dev);
+    fifo8_destroy(&s->tx_fifo);
+    fifo8_destroy(&s->rx_fifo);
+}
+
 static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
                              int offset)
 {
@@ -1234,6 +1241,7 @@ static void pnv_spi_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "PowerNV SPI";
     dc->realize = pnv_spi_realize;
+    dc->unrealize = pnv_spi_unrealize;
     device_class_set_legacy_reset(dc, do_reset);
     dc->vmsd = &pnv_spi_vmstate;
     device_class_set_props(dc, pnv_spi_properties);
-- 
2.52.0


