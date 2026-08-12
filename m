Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EF9C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCaD-0000FN-3S; Wed, 12 Aug 2026 13:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZs-0000B4-CZ; Wed, 12 Aug 2026 13:17:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZq-0000pR-EQ; Wed, 12 Aug 2026 13:17:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1vW74041295; Wed, 12 Aug 2026 17:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=A9zQl+mw+jxPxG/WH
 O+c2q/QxLiv3vrvoqJeDG3hiS0=; b=RWtQT9vDYfnp4wJ4ZRgnbQgJRBgd8S+Y3
 EDld6eHN5xBG2EbAk8jO5tGts8N5dlJnPwUdfvCuGAMBtUu1nIZhUi8qb+Xc78aG
 IhtyrJSjipygwBxFjjvM+zFxOs1o2QASqBOSXpE5XkecaFzDKh5XmIQ9UQiyv41l
 xb6DaDetF/XaXavbF/YcJT+UYB9j3aEQdlvY6QSs2uBqr5yRXPF9iOpo6nRi8pYX
 ly3S+v9bjr8818CFCa6gvJNwZF0ur+iH8BEpIODvfGl0LUWn37ocScQcxZoQUzr5
 cUL29W4llp+EVXZ9VP+lUIzwfqhDUcNdWkG283bkhfizPURsKCaXQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9kpjd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBGd9026640;
 Wed, 12 Aug 2026 17:17:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gf0dd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHCjv19399244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9182058051;
 Wed, 12 Aug 2026 17:17:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0E115805A;
 Wed, 12 Aug 2026 17:17:11 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:11 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 03/15] target/s390x: Fix DR/D INT64_MIN / -1 host crash
Date: Wed, 12 Aug 2026 13:16:55 -0400
Message-ID: <20260812171707.1605637-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5u7cfoqUBc5cgzJEiGrOMwjrvN56W65_
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7caa9b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=KKAkSRfTAAAA:8 a=aSik7ZIpPfau7K45Dq0A:9 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX4X7WedSKPbWh
 /tEJ6njsd2jeBsr5IhG2mMaerkH0A2S2YVeqEvdrhQC5SX/0NDEH8LRuz72rJUn/cMT2N0xeSf+
 hyQokDld3+vM/csIrEAkmvY4AdcgQoEfq20KbquLmOewK+xNs1PLvp6meoC9hVEtbCXuj1df8ka
 lM20jj40yYKgyn/gpBleAb1fjV0Xxmj+ng2tAc4O61IBFObZGfkaMayjL8TDYU2ylPk49bgZpHN
 KT/t3U4Dh9bsugI7v7ojRjBPAnbankUx2ZgoxZffzHJ3UBeah5EZIpNUPp2iUgSOlsWp65OcT5Z
 OteQ7YbLau2vGAF1SkJPnBf532Wrl9XomM83xwLViRK7EGlV6FJMCfRuKrYeX8TffLrtt+oF4X9
 rvx0Q7F+7VjQH7fPRHCgEK6yE9gp4O0POyQESmSj9PlnIMgR3GwIazQqfMuaz+NGo4DyZK3dpSm
 lvvQyxgZoa4+1jAxbjA==
X-Proofpoint-ORIG-GUID: 5u7cfoqUBc5cgzJEiGrOMwjrvN56W65_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX3kLPOZ/i0+o5
 pO4wkwN1zInUvzsDxp058MZP5zUI1tTdmUasAyuschsGs+rc2hXLpN8QX3i9F9qu5xib92Y1L7N
 KPH56nf+F9fGj/trzOQWHyVs64AkVRM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

helper_divs32() divides the 64-bit dividend by the 32-bit divisor as a 64-bit
host operation, guarding only against a zero divisor. INT64_MIN / -1 therefore
overflows the host division before the representability check runs; on hosts
that trap this, QEMU is killed with SIGFPE instead of raising the
fixed-point-divide exception the guest expects:

    qemu-s390x: QEMU internal SIGFPE {code=INTDIV, addr=...}

helper_divs64() already guards the same case; add the missing check to
helper_divs32().

Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Fixes: b4e2bd3563af ("target-s390: Send signals for divide")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260714190351.337923-2-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/tcg/int_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
index fbda396f5b..5aedd1405b 100644
--- a/target/s390x/tcg/int_helper.c
+++ b/target/s390x/tcg/int_helper.c
@@ -39,7 +39,8 @@ uint64_t HELPER(divs32)(CPUS390XState *env, int64_t a, int64_t b64)
     int32_t b = b64;
     int64_t q, r;
 
-    if (b == 0) {
+    /* Catch divide by zero, and non-representable quotient (MIN / -1).  */
+    if (b == 0 || (b == -1 && a == (1ll << 63))) {
         tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
 
-- 
2.55.0


