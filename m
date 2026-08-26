Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88832C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5x9-00087Q-1v; Wed, 26 Aug 2026 01:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5x0-0007xY-E2; Wed, 26 Aug 2026 01:13:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5wy-0005cK-Qy; Wed, 26 Aug 2026 01:13:26 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3VvFO2831123; Wed, 26 Aug 2026 05:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4T+hYys6zCY9FSSui
 5ycLq1g3qnB9puV3GuRsma9f2o=; b=otE8fD+yxPgoSv0x6vx+XQxUCXJ+XjiQN
 AT4bPesA/Z/RFvBopTLhcyyPolntI4bK7bBXeF6N9Jti6AePAdh8y9U4pImZRPxJ
 1WZFWeAjO5cvgTSmnFK/FNOfe7IUV1m99KQCXmyI8cubgZ5T7M0y0gLi1wwmks40
 X1CuaTN3qofZFez18wGoLT8ndEOjBP424tRnqi3WEsuN5hgaV6/JQdktQ7UJHSnM
 c5XC6+weVT3i1y0lSa2+POTDBG7xb7E15JM2QWOLUcHwhW/Jw7YssuaZphOiV6Hx
 SYXzuMQhGbjTyPZQ3VSvX9Fo2LNCF2ZDH7aXI57/5tok7ERYRGRKg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4vp2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:13:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BFe3011917;
 Wed, 26 Aug 2026 05:13:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragg2gx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:13:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5DHAd33817046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:13:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 915B52004E;
 Wed, 26 Aug 2026 05:13:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED64B20040;
 Wed, 26 Aug 2026 05:13:11 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:13:11 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>,
 Tasmiya Nalatwad <tasmiya@linux.ibm.com>
Subject: [PATCH v2 36/37] target/ppc: Add ICBT support for ISA version 2.07
Date: Wed, 26 Aug 2026 10:39:02 +0530
Message-ID: <20260826050923.74756-37-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: EkZxfH7eqSLyPgC5a3DAIEr4JJkBdPHi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfXwQ7ZgGC7yfNR
 G3P+9RnQToyo4CrjPqhZuHQpxF0NY7xp2JxQYc3jh8rqjJa9d0Iy5QeY9tQzMoQYj5TJSX1McdY
 zx6Hr+iw+yTHvWHw7m51GxSoHDFrZVI=
X-Proofpoint-GUID: fNGqFng8GgyRpkbgTsJZ07usNUb7iM3o
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8e75f2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=VhmWRyikh7PcAoWILYgA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfXyUQoKR9dvUK0
 AA0sJhmQ3MWyCdLCa9Rpib7mpfRuf9Lyo23jL+wLi4zY7KRm2PYl9gjtECyg3q7OqxYVugLG1r5
 K0Tyuwl0+i+4ZUKyGSa4GxpqVJMUZjSpBuYmqnHQq4e61KePZCveVFUzs3xTv5FChHosMz2OWO8
 ggyj8eNJdIq/3NMsxSjzhCMsPtHtTZfKZUMJxoas0XD9xonHBiP95E7UHMLrJ/asteJXfHnB++J
 wMFwFAUDe0F13t4Wamsgm+QS89upFpLmxT1sG54ek1H63tkrlKNx6D7KzFXeYdZSN80Xvc+72IO
 4TF4XN31BITKgvXGRNY/FXfQBgfCnHzNgJGOEnmMuH1Xk+jaVUonChSiHTTgu7cqgP9rpDv+P0B
 Bm4IccHbNeJ0B3drMXSswdVPU29AV7kA2k6vTv06wp03YSr58B89jzRwglQN0tc6Okzmx0rzBOv
 Q4HCklXxpbBuzdz64Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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

The summary of changes in Power ISA version 2.07B mentions :
"ICBT instruction has been moved from the Embedded category
to the Base category".
Updating ICBT flag for the same.

While we are at it, correct the invalid mask as per the ISA as well.

Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index bc23a71a2f..4208763e8a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4509,8 +4509,8 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
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
2.55.0


