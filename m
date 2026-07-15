Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302A9C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzB1-0006is-DI; Wed, 15 Jul 2026 08:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wjzAz-0006hZ-Ro; Wed, 15 Jul 2026 08:57:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wjzAx-0001E0-Pr; Wed, 15 Jul 2026 08:57:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FBfYuU2370439; Wed, 15 Jul 2026 12:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nwf9k0uw12KJ0w3Xa
 ahKm9z5jpVZpApy9e7/PRZtVh8=; b=GSUvikUcpNsRsVWwCh5UsnhtTfREtWWlm
 0NvV5+h6203PzvklLuVwoIT8WgKwLvxG8NZf3xnerPBwOtE68874ZGytVD1iFys3
 RNzg8nddXG7sDPI+OcUKQf8RHcz4kBirSo0CWZ/Bf4RrRYnCOePNZ34x5RoixACh
 tGJFtsPDyeMx4nuE5kuE9bFvcmT47Llo6ixlZE97D1UZQGtuTV0YUAdAyl7gb9R/
 MgCtRd6p6NcfCxxaMKDaFYKjw61ysCkLZTGpWzbxaE5qIOxLvWgG7axaGghmdWLm
 7aEP6koCFGHlljIJF8QSLhwYvWpJkXH8XdFEepPzUvoVZ+gcR8WIA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33c5e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 12:57:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FCndB8006226;
 Wed, 15 Jul 2026 12:57:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k02bp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 12:57:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FCvGjp50331944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 12:57:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 213FC2004F;
 Wed, 15 Jul 2026 12:57:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A0FB2004D;
 Wed, 15 Jul 2026 12:57:13 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.30.15]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2026 12:57:12 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, tommusta@gmail.com
Cc: richard.henderson@linaro.org, milesg@linux.ibm.com, shivangu@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 7/7] target/ppc: Add ICBT support for ISA version 2.07
Date: Wed, 15 Jul 2026 18:26:34 +0530
Message-ID: <20260715125634.2107320-8-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715125634.2107320-1-rathc@linux.ibm.com>
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyNiBTYWx0ZWRfXx6SeFLuaTrz9
 x5TXG4wLlnnOMMIMnqKg0gbBNMQSprXhMfoxK2zHNwOGcHfJyj2zmK/8UFABpBcGAkzZyN6Hqmz
 3dOeKYk5EbyF390aGeTureDnuATFpvs=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5783b1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VhmWRyikh7PcAoWILYgA:9
X-Proofpoint-GUID: lkz5MOZLCRyZrtLcJrNc9yWb-UCZP8R6
X-Proofpoint-ORIG-GUID: g5cSdYNwwt7DgF3aO5ZwMFIIjoxPUl9n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyNiBTYWx0ZWRfX2yK2UZ4NZ5tX
 j6GeXpVPAglqXdIV9Tk8ocsvGKZfSGh5DaZrNjN50Ea7H/k0VZniKo/0xTYdehi24Posib2Fjvq
 w/2ZkZZ7HMpQ7KpSJTcnC90AHVkXDkcMgUZOHWjSXrGVlOqv4Pw6m/ga3AMPuBXlvRejvBcDlB4
 fNmaArrUcq9Ib6WlKXPKcd8KRfm8VX+VSYvLPWvxPrgbsODkK3AmBisu8foElTT0y/b9K/84u6o
 9h9Lncf9DbESz5PsyoPUZdjI7Z0zYeTvhyCkBl10ilIL2f+bExBARQmzaLC9YiTDnyPR2iPlfFY
 nfC1omITYN53Dx1Wgs7iJmwp3DwPU1GpwwnxCr9jv2w+ttkqNRbkMROtqUI2WJGMiYedUEUswtd
 zh6WNfkM5EN6AuXnVKyG5Ezj0BW/rHgjzyPx1yCvg+2TZumo3RppVNmeQmFbPBihfIm2wjTkFxk
 7sD1Ok++GnHCgZF/rVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

The summary of changes in Power ISA version 2.07B mentions :
"ICBT instruction has been moved from the Embedded category
to the Base category".
Updating ICBT flag for the same.

While we are at it, correct the invalid mask as per the ISA as well.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8dab54ccee..3cd849c706 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4559,8 +4559,8 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
 GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
 GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
 GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
-GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
-               PPC_BOOKE, PPC2_BOOKE206),
+GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x02000001,
+               PPC_BOOKE, (PPC2_BOOKE206 | PPC2_ISA207)),
 GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
              PPC_440_SPEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
-- 
2.53.0


