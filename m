Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F53D5C0D3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9QLz-0007Qb-KS; Fri, 08 Nov 2024 09:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t9QLv-00079R-QZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:52:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t9QLu-00064E-4k
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:52:47 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8EBCO6024977;
 Fri, 8 Nov 2024 14:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=PtopWrB95sEJJakqj
 ViYAB0+qRP5bfPxyQ/0IlUv5kw=; b=aHn9taudWKbo3XtosgfeIyPSnrWgAetKK
 jwTtWw5nQBD+aYBM6ybRiMoPDysPGYhzOd/IEKk84WjjScTNBQ9VVM6AWfTSukA5
 uTlBJSPyM5DAqHnGCb9o5pruc3l4SgXDI9wGaRWxXpMO6RMPRkAF56Q0pF12D2ix
 q1Wt+XZeU3rAPrR4xb5LnNYaswV8q7payzbKgbn1q8Vc2wpDuakjyCiygAcWuxOW
 rv/ILeNTEanr9i1hgo0a1YeiV19J80A/3Xv7upeXZd+NwuApRAZMKoThB+LutLIw
 VvF0M3qfqKHSvA1b9WOEu7PgIx8qFUaN0UI8X/ndFS8/XS2tetunQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42sm5qr6qp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Nov 2024 14:52:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8Db4IL024174;
 Fri, 8 Nov 2024 14:52:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxt0ax89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Nov 2024 14:52:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A8EqePM51511806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Nov 2024 14:52:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DE3520043;
 Fri,  8 Nov 2024 14:52:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25A2620040;
 Fri,  8 Nov 2024 14:52:40 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.28.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Nov 2024 14:52:40 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/1] tests/tcg: Test that sigreturn() does not corrupt the
 signal mask
Date: Fri,  8 Nov 2024 15:50:04 +0100
Message-ID: <20241108145237.37377-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108145237.37377-1-iii@linux.ibm.com>
References: <20241108145237.37377-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: htm-ASqO2WB_tHTEFhIvWOqUAa1vRHgU
X-Proofpoint-GUID: htm-ASqO2WB_tHTEFhIvWOqUAa1vRHgU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080122
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/Makefile.target     |  3 ++
 tests/tcg/multiarch/sigreturn-sigmask.c | 51 +++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 tests/tcg/multiarch/sigreturn-sigmask.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 78b83d5575a..18d3cf4ae00 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -42,6 +42,9 @@ munmap-pthread: LDFLAGS+=-pthread
 vma-pthread: CFLAGS+=-pthread
 vma-pthread: LDFLAGS+=-pthread
 
+sigreturn-sigmask: CFLAGS+=-pthread
+sigreturn-sigmask: LDFLAGS+=-pthread
+
 # The vma-pthread seems very sensitive on gitlab and we currently
 # don't know if its exposing a real bug or the test is flaky.
 ifneq ($(GITLAB_CI),)
diff --git a/tests/tcg/multiarch/sigreturn-sigmask.c b/tests/tcg/multiarch/sigreturn-sigmask.c
new file mode 100644
index 00000000000..e6cc904898d
--- /dev/null
+++ b/tests/tcg/multiarch/sigreturn-sigmask.c
@@ -0,0 +1,51 @@
+/*
+ * Test that sigreturn() does not corrupt the signal mask.
+ * Block SIGUSR2 and handle SIGUSR1.
+ * Then sigwait() SIGUSR2, which relies on it remaining blocked.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int seen_sig = -1;
+
+static void signal_func(int sig)
+{
+    seen_sig = sig;
+}
+
+static void *thread_func(void *arg)
+{
+    kill(getpid(), SIGUSR2);
+    return NULL;
+}
+
+int main(void)
+{
+    struct sigaction act = {
+        .sa_handler = signal_func,
+    };
+    pthread_t thread;
+    sigset_t set;
+    int sig;
+
+    assert(sigaction(SIGUSR1, &act, NULL) == 0);
+
+    assert(sigemptyset(&set) == 0);
+    assert(sigaddset(&set, SIGUSR2) == 0);
+    assert(sigprocmask(SIG_BLOCK, &set, NULL) == 0);
+
+    kill(getpid(), SIGUSR1);
+    assert(seen_sig == SIGUSR1);
+
+    assert(pthread_create(&thread, NULL, thread_func, NULL) == 0);
+    assert(sigwait(&set, &sig) == 0);
+    assert(sig == SIGUSR2);
+    assert(pthread_join(thread, NULL) == 0);
+
+    return EXIT_SUCCESS;
+}
-- 
2.47.0


