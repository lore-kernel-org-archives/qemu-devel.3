Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1E6C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiQI-0002QF-Pc; Tue, 14 Jul 2026 15:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjiQH-0002PL-AY; Tue, 14 Jul 2026 15:04:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjiQF-0007x5-RF; Tue, 14 Jul 2026 15:04:05 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EGCAKq1786186; Tue, 14 Jul 2026 19:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MvHvSO9S9IcYJkzmp
 N7yHB9Y9M1L2bNieOVHwKTfdps=; b=cIuyrB/faWb154qzp8JZB9rPPLzFtfs2C
 qZL4fSHil8ZL7K0wHsB9/5av+MYbfeykI/aofvCCQGIlDseK+ph5YsgWNmSqm8Td
 OegxhDBEfN7f6xkuhT5UQ9CARZNBFS93cI4VUbMnFXoQMktjFwJxwEtYsY/I7v+O
 trj/0zVfBoWuTvvpp1ReDuPGd4w9AiRuOlzNHxyNNWtUUKq83Q5FlbhopjXEALJE
 iJUtosd/dfGDimnlg89me2KLtxwf1NPWjcR8O8G8ayCn9brVgX0JGkksAjOV73OY
 humH0vxTz/qE/BVzCSXn+cnS3OomXpLabqE7R8VYQqmRDUf+CMyjA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbqcny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 19:03:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EIngqS007944;
 Tue, 14 Jul 2026 19:03:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhc7a0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 19:03:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EJ3tHG9372152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 19:03:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17DC120049;
 Tue, 14 Jul 2026 19:03:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AF4920040;
 Tue, 14 Jul 2026 19:03:54 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.27.233]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 19:03:54 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/2] target/s390x: Fix DR/D INT64_MIN / -1 host crash
Date: Tue, 14 Jul 2026 21:02:40 +0200
Message-ID: <20260714190351.337923-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714190351.337923-1-iii@linux.ibm.com>
References: <20260714190351.337923-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a56881f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=aSik7ZIpPfau7K45Dq0A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE5MyBTYWx0ZWRfXz873b9l/uqyu
 jJd8oLVcqDLIVTPI2AMkYTwYOxB1jkvLYTiGE7dM7RTq7WCWYx/6F+sofIM76mjd/eCrtZKt/1V
 3BmJzSADHaMQbHaDidv7EVidhKbpjKUvyJDsaO03g46496iP6OWcjwC/adL73L00ti1w07ZzhlF
 pgdZc5sWbARTWTdgxI1fLkA4RJJA3bC1IUTwCCuttRe0vePomL3vPPHJe2t9mulAt6EwfBnCWBA
 QStRtmSS0A3FLSf8d7zkRwNvMByAapRV3iJiz7PI3LDPeb/Z9+0c0z9I0ML/rpO4TKiBTYaS1QH
 NYfSBACt1X48X15Ipsk80gCnMeo7LP+bcLjztjxSmuOPCs0VI9Qh+1a367aLouy/FhoLge9H9As
 wNbY83a1+aBO1G3B0Wuk9n+Vzo1ND9rRTPSrjloWChNNR9nRrY31SvKITcshRoZdIXOYJ+dIPZL
 Y1DqFE7eeWHu5GWVfhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE5MyBTYWx0ZWRfX6LtYdh7dQLLO
 2OUGUnJllgiV9Rv/WpUYt2eCnG15Ik7O/OnwXleRzSp0BoCHIrFa0G45G6ddh32siEqtl603D2/
 /ft9bSVUU3cdUy4UMTyRdzTv6vO2r9A=
X-Proofpoint-GUID: AxPSijxeWBPZepytWOAyJshYH_P62V8v
X-Proofpoint-ORIG-GUID: AxPSijxeWBPZepytWOAyJshYH_P62V8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140193
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
---
 target/s390x/tcg/int_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
index fbda396f5b4..5aedd1405bf 100644
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


