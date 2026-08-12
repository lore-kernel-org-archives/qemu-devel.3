Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8612EC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCaD-0000GP-9L; Wed, 12 Aug 2026 13:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZs-0000B5-Dc; Wed, 12 Aug 2026 13:17:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZq-0000pY-H2; Wed, 12 Aug 2026 13:17:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1TTK4087974; Wed, 12 Aug 2026 17:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xsTwaJacnZns4tjWm
 K+EQ7NMxpfF1EqIVQuGw/npmsE=; b=gubgwXFeJqvFlDaIqUObGhIebnUwGhYs9
 uRnB00AnExUnizGwb/niGB1ZA5IOozi0tXAXSNDeoBOnOs9btppBtMx7VH4Ui8CP
 7NHrsa5XxvE1BTDSw1NPiCuPV7Bfsezsc6bmu+ISan/MjOtStIck5oPJYKzcLd7V
 8nFq0DQA0sM8CurMtOuJufo8omYV/eQn/BHdNUgaOJxj6kywj9+o/+7r4/cdMORH
 e4QegcmNiokALyBYfCZq9LF0JcVjDVG7+q1GlEtYcqr3Ndid0fRm/apFA11ZSsMT
 3bsgSFvIeJD3WNHMTFSaX1QnWvR/zXQ9B2AciA4/kDno7EYYJ2+nQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9us2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBQcG017599;
 Wed, 12 Aug 2026 17:17:14 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h72my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHDmu4719372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 569895805C;
 Wed, 12 Aug 2026 17:17:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B20715805A;
 Wed, 12 Aug 2026 17:17:12 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:12 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 04/15] tests/tcg/s390x: Test DR overflow (INT64_MIN / -1)
Date: Wed, 12 Aug 2026 13:16:56 -0400
Message-ID: <20260812171707.1605637-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX3YAXLOHZcVH0
 od4nszWg8FkrUx4tSSEqq+aDzF3oLypIQUyjLusArC6P43VRywUTx4ceXm6OY1F2PgpjWPuh/4t
 2ioWQ05oBI7sNd2EiKO0URd9yYNyfC10n+28cdmupyne9IrLUWQEgqBJdWeUi9MdUXBChjes1Px
 diH8OKCHjXrJixzT0TflPrtUz1L9u3lYlnI8Wg2v38mii547/P2KTPqDxYD/0wewpl7w4HGNHDy
 XKgXl/2m7WT2mred2Uuuh0d74TPfu9WjvovwO8+UVommCmgkJA3I9m8FG+Bx3vElGXLvYb+LcQB
 RrYdSLlTpHFg7tFDko++ygoXYldPylmckmQMFCypkeDb1VJA3fDMeaVYFyjBjv2y06WdAmyGEKI
 wChwkPspi7pkgFSZRZCw8GK14fnuV13pTjqkmkTT3Z7/krjW/lfqNKa8o4WGFOR1IeMWmbY6Not
 zDA/GhrQg7mUKke4yJA==
X-Proofpoint-ORIG-GUID: 7myvyHF9deMbSN8syftzTE17h4wH_383
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXz9g4kyYOyQgW
 egTGY87usZF7t998Uln324Z4JRYxF83/oVl9AIky2Xc5M3igiufYlckyN7E+sPH6rldI2spB9Xg
 +kViUkDtwXW2tAko7/ZGTC+VKHoKoDA=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7caa9b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=ZZ0oepHopxe46yikozEA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7myvyHF9deMbSN8syftzTE17h4wH_383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138
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

Check that DR with a non-representable quotient raises SIGFPE rather than
crashing the emulator.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260714190351.337923-3-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/tcg/s390x/div.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tests/tcg/s390x/div.c b/tests/tcg/s390x/div.c
index 6ad9900e08..124c9ecc33 100644
--- a/tests/tcg/s390x/div.c
+++ b/tests/tcg/s390x/div.c
@@ -1,6 +1,15 @@
 #include <assert.h>
+#include <signal.h>
 #include <stdint.h>
 
+/* Set asynchronously by the signal handler. */
+static volatile int signum;
+
+static void signal_handler(int n)
+{
+    signum = n;
+}
+
 static void test_dr(void)
 {
     register int32_t r0 asm("r0") = -1;
@@ -65,11 +74,39 @@ static void test_dlgr(void)
     assert(r == 1);
 }
 
+/*
+ * The most negative dividend divided by -1 yields a quotient that does not
+ * fit into 32 bits, so DR must raise a fixed-point-divide exception.
+ */
+static void test_dr_overflow(void)
+{
+    struct sigaction act = { .sa_handler = signal_handler };
+    register int32_t r0 asm("r0");
+    register int32_t r1 asm("r1");
+    int32_t b = -1;
+    int err;
+
+    err = sigaction(SIGFPE, &act, NULL);
+    assert(err == 0);
+    signum = -1;
+
+    r0 = 0x80000000;
+    r1 = 0;
+    asm volatile("dr %[r0],%[b]"
+                 : [r0] "+r" (r0), [r1] "+r" (r1)
+                 : [b] "r" (b)
+                 : "cc");
+    assert(signum == SIGFPE);
+
+    signal(SIGFPE, SIG_DFL);
+}
+
 int main(void)
 {
     test_dr();
     test_dlr();
     test_dsgr();
     test_dlgr();
+    test_dr_overflow();
     return 0;
 }
-- 
2.55.0


