Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5499C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbUZ-0003FP-0r; Tue, 14 Jul 2026 07:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbUW-0003Dp-IN; Tue, 14 Jul 2026 07:40:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbUU-0003kL-Td; Tue, 14 Jul 2026 07:40:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6gD2n2860262; Tue, 14 Jul 2026 11:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Pz0IxQS4TCsskW5+b
 RjwlEEVwQ/C4mNq4ojIyQfm7Y0=; b=d2O18G1Pe5Ecw77aeN293M8GUvRGuW9jY
 BZTHUXVzehwBwdtZ8UfAReuAOZbqDIM5nZWBWK69l/sjmJE0nQ601nA8FKVLB6T5
 pnoctTXlRuZg8jimPsC7RXHWFMWN6DYyNqfKS4xCrMIrSU8Kl/+2jQLjdE3JppI1
 5dtJq4xhA2HyhuVf5TAGSeiGYUgvJndhMYQfksCPph0+KHeTP6k9La0EV8pJa2ZB
 VkLyv8mqNiS3cL0YyvjTJ2L0qeB6Prhn3U41y7r61D/PS4WLfDW/qMU7cHB+gR1n
 aklwgYYJPvXWS+Ocmuwj0I00cSFzBOCfhoqRHrQjD9ACJK3VqrMUw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv336dhq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 11:39:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EBYxIT025989;
 Tue, 14 Jul 2026 11:39:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jthr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 11:39:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EBdnvA51708290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 11:39:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CCC920049;
 Tue, 14 Jul 2026 11:39:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D99552004F;
 Tue, 14 Jul 2026 11:39:48 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.75.242]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 11:39:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Harald Freudenberger <freude@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] tests/tcg/s390x: Test PRNO TRNG interruptibility
Date: Tue, 14 Jul 2026 13:34:51 +0200
Message-ID: <20260714113946.275122-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714113946.275122-1-iii@linux.ibm.com>
References: <20260714113946.275122-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExNiBTYWx0ZWRfX94G6XyNwZgYL
 Zk0tfoI/XQ6kY8HwLvxneH37N/LNAcjuVaV7OUzhnLibCId/F+vzDOnTVe+H8Nw0iWJosj32oxB
 yorfujqBk3ClegefYXqt6rUYNe9yh4o=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a56200a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=p6xrlejl6-JkR3ofBtoA:9
X-Proofpoint-GUID: y7Y9-S95eAGOVfdauieh9cSruWADjx-N
X-Proofpoint-ORIG-GUID: y7Y9-S95eAGOVfdauieh9cSruWADjx-N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExNiBTYWx0ZWRfXx9ihT9iRGfHb
 RkNwxMoxJgpl/a51bSkZ6oXtWBmM6XAJAa7yLiyPUdH0dBYE1IpoUd0y+Oj+72HICVdnVnbgQeH
 wVcLnSDWKUdxH2ECiHqq51Jw/bQ8oHpKcxNzsvwRa8PzX4kwSDSjdvM4BtxqoBM3dJiKRGHWvsO
 oqPnwCwAza3UptsF6pJzd9Nl3hGF6d9OFKl93CLxavvsm8sHWA8EZRmfyhkudHtw1vzKHtgEfui
 M6wEOhf1QFHgzLpJ6+pbdADkwsiyfrUSFqd30g2FWQhwKrcG2PHvMhaxQ6XBxHHA8h5nTrxzf/G
 A99kNEBEBleiXpDsA+43BGwcMT0YcoQj1FNC0QxkMvw0aF81UsMCVLghOfIeTI2gXO77Xl8qDM/
 flzOkbnrl0bgUuED6/fxuMAf60xUHnwVdg2uEHqqGux3gZuIjsNjpTraGnZU4uAuxHIiNMT6aFn
 LMSd1xPsd/Cj0QBzmCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140116
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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

Add a small test that issues a large PRNO TRNG request while a timer is
running, and checks that the timer interrupts it several times.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/prno-trng.c     | 67 +++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 tests/tcg/s390x/prno-trng.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 0ca030ded01..48cba4cdfa4 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -75,6 +75,7 @@ Z13_TESTS+=vcksm
 Z13_TESTS+=vstl
 Z13_TESTS+=vrep
 Z13_TESTS+=precise-smc-user
+Z13_TESTS+=prno-trng
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
diff --git a/tests/tcg/s390x/prno-trng.c b/tests/tcg/s390x/prno-trng.c
new file mode 100644
index 00000000000..43eea5db1dc
--- /dev/null
+++ b/tests/tcg/s390x/prno-trng.c
@@ -0,0 +1,67 @@
+/*
+ * Test that PERFORM RANDOM NUMBER OPERATION TRNG is interruptible.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/time.h>
+#include <asm/ucontext.h>
+
+static unsigned char buf1[16 * 1024 * 1024];
+static unsigned char buf2[16 * 1024 * 1024];
+
+static volatile sig_atomic_t interrupted;
+
+static void sigprof_handler(int sig, siginfo_t *info, void *ucontext)
+{
+    struct ucontext *uc = ucontext;
+    unsigned long addr = uc->uc_mcontext.regs.psw.addr;
+
+    if (*(unsigned short *)(addr - 4) == 0xb93c) {
+        interrupted++;
+    }
+}
+
+static void prno_trng(void *b1, unsigned long l1, void *b2, unsigned long l2)
+{
+    register unsigned long r0 asm("r0") = 114;  /* TRNG */
+    register unsigned long r2 asm("r2") = (unsigned long)b1;
+    register unsigned long r3 asm("r3") = l1;
+    register unsigned long r4 asm("r4") = (unsigned long)b2;
+    register unsigned long r5 asm("r5") = l2;
+
+    asm volatile("0: ppno %[r2],%[r4]\n"  /* prno alias for old toolchains */
+                 "   jo 0b"
+                 : [r2] "+r" (r2), [r3] "+r" (r3)
+                 , [r4] "+r" (r4), [r5] "+r" (r5)
+                 : "r" (r0)
+                 : "cc", "memory");
+}
+
+int main(void)
+{
+    struct itimerval it = {
+        .it_interval = { .tv_usec = 10000 },  /* 0.01s */
+        .it_value = { .tv_usec = 10000 },
+    };
+    struct sigaction act = {
+        .sa_sigaction = sigprof_handler,
+        .sa_flags = SA_SIGINFO,
+    };
+    int err;
+
+    err = sigaction(SIGPROF, &act, NULL);
+    assert(err == 0);
+    err = setitimer(ITIMER_PROF, &it, NULL);
+    assert(err == 0);
+
+    prno_trng(buf1, sizeof(buf1), buf2, sizeof(buf2));
+    printf("interrupted %d times\n", interrupted);
+    assert(interrupted >= 3);
+
+    return EXIT_SUCCESS;
+}
-- 
2.55.0


