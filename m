Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB0EC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCaD-0000Ga-CO; Wed, 12 Aug 2026 13:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZs-0000B6-D6; Wed, 12 Aug 2026 13:17:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZo-0000oq-Mg; Wed, 12 Aug 2026 13:17:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1b7b4040894; Wed, 12 Aug 2026 17:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=F0jQIfuLBD4YvbYbt
 B17Ur+g1eyPfBHg0haWS315WfY=; b=Ps62zwBWQBdvVOgLyZTrJjjhjdwvbLf2w
 esUnWUK1jKGGvXejALZjsHahaDrqPF6kM6IYVtZuSuiBukeGvXVneoALVWuHiJgG
 NeZ2FhwQG5q4QL0qDhVJ1Mam/dxF+DXa1d5gh4PCh9IpVuQtBUAqt5k01futwpaY
 k1TLZHlOoB2AEd2ERlXthRTjz32DkdGF/YYPNzUwMLB0NNa17v+WeaqairbWYwIQ
 rZ4D86xWESzk3LYhNqVJnot2CFD3cWKubc9jOh5PbQHjpd343EjU9GR1FEIYSgg6
 0kHk10Nzh1X3k37QmA6XIwQS+/5OijCmnJCG0RvekfLnV9+Ytarqg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9kpj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBK8m025502;
 Wed, 12 Aug 2026 17:17:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6x81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHBje13435478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:11 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9083758051;
 Wed, 12 Aug 2026 17:17:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC79D5805A;
 Wed, 12 Aug 2026 17:17:10 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:10 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 02/15] tests/tcg/s390x: Test PRNO TRNG interruptibility
Date: Wed, 12 Aug 2026 13:16:54 -0400
Message-ID: <20260812171707.1605637-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P0JGy26jVukC8S9aIBWob9GglsNKKX53
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7caa9a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=rdsRWXD1_pUD-tburKAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX0pDt8p2psV/6
 r5/cSTXSI+U7iYCptYdGWqdpdMW/sFaIQJME3FNGphemN/JBtjHGBwRTGpINELQLbr3JhrMSy1h
 Q4qLeeDRZKxtIznkpDyYewHW1yzxP44Hx3bw0L3uu50t29Fzx0Ff/DUxuX/tceeI9TQxMspFj48
 h+Crr0gWkaBR8MLNd4w9GfM6ae+LYzj5ZeV2tN7fC7gD0+mSF20KPzq56xQPxgxTrCZfyd/XBLN
 UqhpaWJJu1s+4WhpucSDD9OHLcB1fyC+e14GnZOSNDpwfe+1TK0gZjSikCxpJCRZQRkgUkleKbI
 8cYMnHI7hRhcXqCMv/FxXJzxZWIP/V2YsRw0Pi1w8InVbnswC8bZY2Du/sFFAC/XGwuXLnt4Dl8
 u7/xHYZdVzfcjBLd1o6yRfvQotQboGymPzYWIIGJs09kHQmYll5lcSWYV54+uMmG8FTc+6ySHYe
 tDPx+Wdl/ja9E4WHcwQ==
X-Proofpoint-ORIG-GUID: P0JGy26jVukC8S9aIBWob9GglsNKKX53
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX3k60GcZPVxjO
 eiNNGsVrcHtWl1vgeplmk7oSYTbTeR79T1v3ISh/hsiUPCfO+81PjbhI//9of7a4Dfxe72aSm3F
 cvf/ZeM2nGVjQ4Dv1E4apPo8O7kkM+Q=
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

Add a small test that issues a large PRNO TRNG request while a timer is
running, and checks that the timer interrupts it several times.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260714191948.342204-3-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/prno-trng.c     | 67 +++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 tests/tcg/s390x/prno-trng.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 0ca030ded0..48cba4cdfa 100644
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
index 0000000000..43eea5db1d
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


