Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8307BC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpmD-0001Cq-Vn; Fri, 28 Aug 2026 02:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpmC-00019A-Iv
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:09:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpmA-00013t-St
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:09:20 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S23C0S679899; Fri, 28 Aug 2026 06:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=EhTCFUrHYxeM1RJ5V
 GSGAochDNAymPva3G1d0fvhWTg=; b=NEMZ0pJtXbZAQNMxP3cKI2Q/9eRCzNZyj
 8f6VhbotWy5ZCJS2mzJfw3wUm5UKAZPTSxXOGIlxz2/7SEHp1yCXKQxb70iWHNP9
 9wCNvrxcUsoOgFs3I8f6bRI8tXW6UsbY0zNlF2TEPJLM/gr8p71eMwgQxdcuLxIS
 0Y1rtTShWsMPQF1FYjJ1psBDrEgK+lv33wzvM9+x+60sZUzzI1jRGPy9DcFiFTvB
 OUXSoMkrrxhMQWOOsah0u8g0z0kK2VT9d7lGev7pf8YfrDCuJ5nH39A5P/KO+0p5
 IBgXuIwmiUi3YE9MqwZyp8gMkbFyuTbuKy4Ns4hP5giKBKpl0HiPg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxt0s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 06:09:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uSN9003721;
 Fri, 28 Aug 2026 06:09:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhmk57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 06:09:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S69Cib51052946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:09:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA51320043;
 Fri, 28 Aug 2026 06:09:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9409C20040;
 Fri, 28 Aug 2026 06:09:10 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:09:10 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Tasmiya Nalatwad <tasmiya@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 40/41] target/ppc: Add ICBT support for ISA version 2.07
Date: Fri, 28 Aug 2026 11:37:15 +0530
Message-ID: <20260828060716.91672-41-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX3FJf2FttprL2
 iJIRSvJl1ouGhVnA+kiX13x5Cxw8TtFHpE7yk9i6r6zK99eXdbND0HjFLk8hvW9kgrVvzeygKux
 SOQHWa0bweoIk4P1M2IB3j4/xCaij7M=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a91260d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=VhmWRyikh7PcAoWILYgA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: siNb5EzoS9lOhnzU6QAia2rrdkqhSuvJ
X-Proofpoint-GUID: siNb5EzoS9lOhnzU6QAia2rrdkqhSuvJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX+Qk6qrcGuUSt
 W4D2zzlt2lJSYhWDuDHc0LRI+TvUVCNpJLXZO8iCVVhkxPd4ob/e/b9Oiue15lxsK3waDmYw74F
 cJsMB2xdZlb0/jYiL+ibGkw8VBsqGGm/73hFysXfr/Lq7N7T+VZUYtwNbQ/jlSGiVsqcXOs6Od4
 lZ3T6d5L7ZpwU8qM9p4oRQQZJzBCiTnkA+25GgsKWWR94WYpSlM+tEAovKtmMpyTw5i+NvDWatI
 Ko2xy6oid31Val+HFP7/48Ga+/upzU2p+hnQXSO3rnpzUvG/ELAIgqVOnRZmAZkI5pYudrCziVu
 xo8dN4Jfcv03xJTcqWGC3vxSTT66jYBrRe9+vJqegQldP25Ei4NNr0l8kMS7vumYBoAkfRJ4tta
 9f4H8J44wf9D5AEJFioIPK3JeysD7VENs9filkmwiqv5dEa/7HQeWBMKqBRX4Nva+krercj/KM7
 /yvoT0BvLDZvrNN/fIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

The summary of changes in Power ISA version 2.07B mentions :
"ICBT instruction has been moved from the Embedded category
to the Base category".
Updating ICBT flag for the same.

While we are at it, correct the invalid mask as per the ISA as well.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-37-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 023935c10e..467b8f3d4e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4498,8 +4498,8 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
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
2.52.0


