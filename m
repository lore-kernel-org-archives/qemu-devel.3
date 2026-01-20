Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADA1D2ECE9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viD55-0001mQ-Ti; Tue, 20 Jan 2026 09:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1viD4u-0001cL-AX; Tue, 20 Jan 2026 09:51:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1viD4q-0000ER-Ev; Tue, 20 Jan 2026 09:51:30 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KEkgKL021340;
 Tue, 20 Jan 2026 14:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=FQPJK3WQkPTrAwIUjNUS/Pz1rw3xj3GU6Tc0wD0UL
 ZA=; b=LQy4/m2cqi9onnxDRrsvujF94QNHnYhI/BFTCTjhkTmouywlpdDRN2xck
 tg3oJRmwh9KpsHncMuuOi07L6J+OPzBNeXo72bBszUMmCCjAjBSgtqFOF88nXz+6
 qxOaLvUECruMhiJkIkInTYWj4AxwjukbtAQfmf5YaLM3Y9SoMFwlbG8CT+9U/zZY
 2i6Pn87Pf18Fxh4cwrROaACfp6YE2NlMnr42BRuW14qtH0sNFkF0w+1bAP6owygy
 gTRIjnMLJ0Yyah1Ktgs3562zegCxrOEgWTZ0UX+rndEfq3aEbt/0syLAaJZ+WIFO
 lGmz4Qm1iDPfpofxLQ79i6WtIHMbA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt6121qps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:51:24 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60KElQQn023130;
 Tue, 20 Jan 2026 14:51:24 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt6121qpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:51:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KEjBxk006415;
 Tue, 20 Jan 2026 14:51:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf1d5s7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:51:23 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60KEp3WB26345928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jan 2026 14:51:03 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77A5F58045;
 Tue, 20 Jan 2026 14:51:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8F9958050;
 Tue, 20 Jan 2026 14:51:20 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Jan 2026 14:51:20 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v2] hw/ssi/pnv_spi: Fix fifo8 memory leak on unrealize
Date: Tue, 20 Jan 2026 08:51:17 -0600
Message-ID: <20260120145117.602960-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zduFe80b179cWf6Pe9aPXDodjUzuHdqU
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=696f966c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=Q8LBFeAF4jmk_nWGM1UA:9
X-Proofpoint-ORIG-GUID: 5gbfgP-J98cU0Ias761oFQY-eCAH23uT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDEyMyBTYWx0ZWRfX3XHh5F5AqlJ/
 kwpkwKdMSmEPqNBX7nqOyKrHnwDwHcCT1Yf+ZiVFg/SwgAos70QzBjBHpUl3ir5Q25eUDZr5+UM
 nFcu+y2tR2I7cMdkvmYkTYMpYSdQbCBVCGnkx+rHKEmSA8J7xf19+Jtfwsp4l22lN54JlMwqcff
 2z8h/wFlUm44LeCRYSdSovQEG1J1W03S72CQfRA35gWgfH+Xhfb8gE9YRE6Jg5h2RZYJUUujJ1w
 MPHoYbb0u/NPc3n4l6dApbTmLbZhIonurmKcSlDv+uA/IkYXAkxKGgl1DnqNxRU89cIB2WDTv0g
 /nrlgWl2oTtLSMCxT4avDEJUvxkW/hIs9aGJjC2gghpW8WGKEKbVn5MRsSkPbDtvITlY6n7lQao
 r6mjwhUEEy54v+LHL98+yUKs19UgsDE87LEJS42RiAe+FmyXaY7OuGPLLilAgXPjh55TTGEJdlc
 i+BABHJHVo0AW8ga3kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601200123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

unrealize should free the fifo8 memory that was allocated by realize.

Fixes: 17befecda85 ("hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure")

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Chalapathi V<chalapathi.v@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
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
2.47.3


