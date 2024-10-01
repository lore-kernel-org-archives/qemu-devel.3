Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C00ACEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveSU-0001Al-Pg; Tue, 01 Oct 2024 11:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sveSS-000120-KR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:06:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sveSM-0001G3-KU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:06:36 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491EJZxO020002;
 Tue, 1 Oct 2024 15:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-transfer-encoding
 :mime-version; s=pp1; bh=CDZp9CuEf4wuPoEKk64KTAQTzKZUPI5Qtq2zRdo
 QAqc=; b=b52YgwPku/XwwYzwFHc29bqVUfvp9/e3cb+l04lh8qOlZSaCPoZQ+nt
 wN0W97DSISunaJeZTDUMBOQPjC/CRA9ckprp0cRwFMsIVbpQn8ZtjOZvZIKvUT7n
 /tf8SFRtrHNXTKiX2ZMy4LOL+kHCnSIOorhgJmMhVfUA4QrWe8DWr4vX1KMPnkvb
 IuOnq0FUffJMB9bPxrh8Olwhs6RPS5QRpXd1FRBkcHx0PO0ENM4uBhZ1Dh1hU3LT
 /kM5XcEAuxZ1MCZ4hmii3/eFMUqnvu5dhfvtIICEySreB/IMaEmGdUW/O4DuVYpc
 ivYmunLhvmUkL3vFVv33PU2ehnXR0cg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420jra88p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:06:24 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491F6OBP025406;
 Tue, 1 Oct 2024 15:06:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420jra88p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:06:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491EmCbZ007989;
 Tue, 1 Oct 2024 15:06:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxw86j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:06:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 491F6LQM57278946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 15:06:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9BAE2004B;
 Tue,  1 Oct 2024 15:06:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7748C20040;
 Tue,  1 Oct 2024 15:06:21 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.29.119])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2024 15:06:21 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4] tests/tcg/x86_64: Add cross-modifying code test
Date: Tue,  1 Oct 2024 17:03:48 +0200
Message-ID: <20241001150617.9977-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q4nyWSi_LyRbhWVICPM5JqOUz85LeDxB
X-Proofpoint-ORIG-GUID: ZVx-MogHAU_Jkab79SNZ7QHp5tY8tCdj
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_11,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010096
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

commit f025692c992c ("accel/tcg: Clear PAGE_WRITE before translation")
fixed cross-modifying code handling, but did not add a test. The
changed code was further improved recently [1], and I was not sure
whether these modifications were safe (spoiler: they were fine).

Add a test to make sure there are no regressions.

[1] https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg00034.html

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v3: https://lore.kernel.org/qemu-devel/20230316214711.318339-1-iii@linux.ibm.com/
v3 -> v4: Rebase.
          I've been looking into the .NET failures under QEMU again and
          what this test looks for was a suspect. It turned out to be
          https://gitlab.com/qemu-project/qemu/-/issues/2600
          but it would be good to have this test upstream to ensure
          there are no regressions.

v2: https://patchew.org/QEMU/20220905154944.1284289-1-iii@linux.ibm.com/
v2 -> v3: Resend with a trivial rebase.

v1: https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg00455.html
v1 -> v2: Fix tweaking the flags (Alex).
          Keep the custom build rule for now.

 tests/tcg/x86_64/Makefile.target        |  4 ++
 tests/tcg/x86_64/cross-modifying-code.c | 80 +++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 tests/tcg/x86_64/cross-modifying-code.c

diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index 783ab5b21ad..d6dff559c7d 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -17,6 +17,7 @@ X86_64_TESTS += cmpxchg
 X86_64_TESTS += adox
 X86_64_TESTS += test-1648
 X86_64_TESTS += test-2175
+X86_64_TESTS += cross-modifying-code
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
@@ -27,6 +28,9 @@ adox: CFLAGS=-O2
 run-test-i386-ssse3: QEMU_OPTS += -cpu max
 run-plugin-test-i386-ssse3-%: QEMU_OPTS += -cpu max
 
+cross-modifying-code: CFLAGS+=-pthread
+cross-modifying-code: LDFLAGS+=-pthread
+
 test-x86_64: LDFLAGS+=-lm -lc
 test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/x86_64/cross-modifying-code.c b/tests/tcg/x86_64/cross-modifying-code.c
new file mode 100644
index 00000000000..2704df6061c
--- /dev/null
+++ b/tests/tcg/x86_64/cross-modifying-code.c
@@ -0,0 +1,80 @@
+/*
+ * Test patching code, running in one thread, from another thread.
+ *
+ * Intel SDM calls this "cross-modifying code" and recommends a special
+ * sequence, which requires both threads to cooperate.
+ *
+ * Linux kernel uses a different sequence that does not require cooperation and
+ * involves patching the first byte with int3.
+ *
+ * Finally, there is user-mode software out there that simply uses atomics, and
+ * that seems to be good enough in practice. Test that QEMU has no problems
+ * with this as well.
+ */
+
+#include <assert.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stdlib.h>
+
+void add1_or_nop(long *x);
+asm(".pushsection .rwx,\"awx\",@progbits\n"
+    ".globl add1_or_nop\n"
+    /* addq $0x1,(%rdi) */
+    "add1_or_nop: .byte 0x48, 0x83, 0x07, 0x01\n"
+    "ret\n"
+    ".popsection\n");
+
+#define THREAD_WAIT 0
+#define THREAD_PATCH 1
+#define THREAD_STOP 2
+
+static void *thread_func(void *arg)
+{
+    int val = 0x0026748d; /* nop */
+
+    while (true) {
+        switch (__atomic_load_n((int *)arg, __ATOMIC_SEQ_CST)) {
+        case THREAD_WAIT:
+            break;
+        case THREAD_PATCH:
+            val = __atomic_exchange_n((int *)&add1_or_nop, val,
+                                      __ATOMIC_SEQ_CST);
+            break;
+        case THREAD_STOP:
+            return NULL;
+        default:
+            assert(false);
+            __builtin_unreachable();
+        }
+    }
+}
+
+#define INITIAL 42
+#define COUNT 1000000
+
+int main(void)
+{
+    int command = THREAD_WAIT;
+    pthread_t thread;
+    long x = 0;
+    int err;
+    int i;
+
+    err = pthread_create(&thread, NULL, &thread_func, &command);
+    assert(err == 0);
+
+    __atomic_store_n(&command, THREAD_PATCH, __ATOMIC_SEQ_CST);
+    for (i = 0; i < COUNT; i++) {
+        add1_or_nop(&x);
+    }
+    __atomic_store_n(&command, THREAD_STOP, __ATOMIC_SEQ_CST);
+
+    err = pthread_join(thread, NULL);
+    assert(err == 0);
+
+    assert(x >= INITIAL);
+    assert(x <= INITIAL + COUNT);
+
+    return EXIT_SUCCESS;
+}
-- 
2.46.2


