Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB1CD609B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 15:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVXEi-00035e-Nb; Tue, 16 Dec 2025 10:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVXEg-00033z-Lp; Tue, 16 Dec 2025 10:45:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVXEf-0006D2-00; Tue, 16 Dec 2025 10:45:14 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG7hmPl022380;
 Tue, 16 Dec 2025 15:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=xW0c7JRqxECu5Zj5bc0pNcq21I7+Qjjh5Qau9MiNn
 2A=; b=PhdL01ur4DzV1hXaw+gfmEgDH9DfyUy4BfIoajilCZ6xjZXPu8Q89MsyJ
 gIl4wlTDNhfIMJbtwQRJaD5AqkVMpM1WPHWMaQ3PwYQ7PWvlY8uxHSq6+AcBpCTG
 si7T93Z5m5LUwv65EgrRa9BOBZoI8jhWl3LcmLO9WJvRe8wveLZEZTHOHMLXu6x7
 s0CZXk80YW43h7mp0GlwSntRzuLjY+4CAl2lbAuR5rc6X1HSVxJVpy3wBGS8IHp9
 hMRz81Y7wUKsHBdFYLOk2q4a8RDmCbCztfIh4eRf3FLZdQj8y48gqXqMKFKC0N5P
 7GO7INVXTjNmUSVZ9yy/fBm6ivseQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkybe9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:45:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGFPUnB006022;
 Tue, 16 Dec 2025 15:45:09 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkybe4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:45:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGElbdR014337;
 Tue, 16 Dec 2025 15:45:08 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpjvmg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:45:08 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGFj6X160555694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 15:45:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C57DE5805A;
 Tue, 16 Dec 2025 15:45:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 567FB58063;
 Tue, 16 Dec 2025 15:45:06 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 15:45:06 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH] hw/ssi/pnv_spi: Fix fifo8 memory leak on unrealize
Date: Tue, 16 Dec 2025 09:45:03 -0600
Message-ID: <20251216154503.2263755-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9r5D5l47sRDe7FUGIdQXbWNXYTk6MSOv
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=69417e85 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=6v4oqpcl_3JwHzr1eSQA:9
X-Proofpoint-GUID: n3haAZoYLEnbUhOEr-Dow4xgeE4VR5ZY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX1ViFxv6rJ3Ir
 haST6BMPSoiFezbk3e9OJwKbkT71f5hIpnOZlcNeHclyuNSQHEkCxJJhefcS3cfU6L1QU+Ch7P3
 /Q0Q1MMs5gqUCvnF8YN0wBn1bwzWEq/LTZGrC52P18Sf+fKO3Gt8AQl9w1/4NfMNpC4S/+DK+Vf
 cj9Mn+D+3VsBRCTwploSFN79wQZ7sKXt91vrpoZPFmqj/P3CC1zq695XU+AWg5HvkC2hgViiFIf
 SIupJ0WneUjSBEwVu0MB52M7wvC3lZpC0/Tb18iONbagdo7hhLlHPic2+5G852EUP91iaI81xX5
 4lRGA65bKbHs4eTPGXOluJPa2vb3zYsOQp1By1e2mwU1kgEbOJlaX3tqc8glBDr9K+KOjX7Njvo
 h8Yh24YCCLgsFBNZXTg1CCmPngbfXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

unrealize should free the fifo8 memory that was allocated by realize.

Fixes: 17befecda85 ("hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ssi/pnv_spi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index f40e8836b9..5db440be9a 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1176,6 +1176,13 @@ static void pnv_spi_realize(DeviceState *dev, Error **errp)
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
@@ -1208,6 +1215,7 @@ static void pnv_spi_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "PowerNV SPI";
     dc->realize = pnv_spi_realize;
+    dc->unrealize = pnv_spi_unrealize;
     device_class_set_legacy_reset(dc, do_reset);
     device_class_set_props(dc, pnv_spi_properties);
 }
-- 
2.47.3


