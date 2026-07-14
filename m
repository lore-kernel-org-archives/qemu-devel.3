Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A8BC4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiQI-0002Pt-FZ; Tue, 14 Jul 2026 15:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjiQG-0002PC-T0; Tue, 14 Jul 2026 15:04:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjiQF-0007x4-Ag; Tue, 14 Jul 2026 15:04:04 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EGC1RM1721275; Tue, 14 Jul 2026 19:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zhcOOWCFTC0P4/C5B
 priC+rsGxWAwKUPqFXE2y8rkxY=; b=m/Cnc1Dh8QgkJVJMqKKKSq1g+mXGxD/nB
 i7DZbvKmu81Vde69U0wTRfhGMTWAPLny4sH7wzEVZtFkyccd+OyzSdYhWCmDlxx+
 /qGMNaKFSzKyd3r6+UgV3VL86nL2ZDZ0pO2iTFwT4Tf7qpMIBRubMCUxHeuC0Xxl
 5+fRpCGALtsr3IyLmTXnL+TcmR+n+jNKUctECdPc1XhssR3j3yica1xJtLi8whhE
 Dm2UJoSxMpbKF4pCr75OBJfhQRT2w8WwDO7zW9lVz9QyZKMQgohALxH0NpwTwojy
 RwkijRIe5HjZPPUNhCqzHEkAJlHNlAixFyGW8tUv9iZkJmRjS1GLA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwqag5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 19:04:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EInfdN031605;
 Tue, 14 Jul 2026 19:03:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy40n9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 19:03:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EJ3tqH27459990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 19:03:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8890620049;
 Tue, 14 Jul 2026 19:03:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A4B420040;
 Tue, 14 Jul 2026 19:03:55 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.27.233]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 19:03:55 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] tests/tcg/s390x: Test DR overflow (INT64_MIN / -1)
Date: Tue, 14 Jul 2026 21:02:41 +0200
Message-ID: <20260714190351.337923-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714190351.337923-1-iii@linux.ibm.com>
References: <20260714190351.337923-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 28wxwteWKRHF8AkeCMlKM4gLsaRZ0wbr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE5MyBTYWx0ZWRfX9giYTfaPaA+o
 oG7fECM1JdakGd0BdTINC3wX2oMZUKwQtQexNj1j1Qcd4Oogyy8bJjbUitRf7qyGyuvgSMBlVfl
 TMPJIyl8ad+Cy1IxMci0PtimO0/qZVNY5AnaCXMyfj3BKwY7FtzpZIOr4IvW+Xgwf0FCDctAdHL
 XgGhVQmmE6MXlkEU7yqFSHf7HlCVJVPjWG/6dZcvDr0CcbEzMD+NeZ/GzrMDERNisA4LjLvCEqq
 tKjlUK3pMF+OtEVXnfxfenv5fn3ujHHf96K/+dA6k/ra9h8FpItt1lFiLyiOepYaRVAmxFKb3ua
 rQLWyOCQgHFOcxAR7vpWeHK9g/iguzixbXtubR+SDrTVZRLoDYe1e3/sJkuN8sZJFp2sNT31bAy
 Czu8df4/gMUK/M5AtNiEQhweVgkfQets21j1i0VRs2SFJXLK+u1Nr/4RZKTF5SlAGQ3s3iZwuVq
 691VkTiZbgb5gkmvIHw==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a568820 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ZZ0oepHopxe46yikozEA:9
X-Proofpoint-ORIG-GUID: 28wxwteWKRHF8AkeCMlKM4gLsaRZ0wbr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE5MyBTYWx0ZWRfX6x8YU0dCucLU
 4RJuInuTHk/t7XPZE+43ajgiG3+tQeoEaWlxk843xkDEbaF8KF4/Yu1pfroUbDxgvgYYnGBrR9/
 99mx5TCUb+101dxexDRkUCtymSMz5lg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140193
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

Check that DR with a non-representable quotient raises SIGFPE rather than
crashing the emulator.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/div.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tests/tcg/s390x/div.c b/tests/tcg/s390x/div.c
index 6ad9900e082..124c9ecc339 100644
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


