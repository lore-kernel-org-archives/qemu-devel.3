Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B31DD37498
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Q5O-0005c9-13; Thu, 17 Oct 2024 08:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t1Q5L-0005bH-Tw
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 08:58:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t1Q5K-0000Y1-D4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 08:58:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HBo1nV015735;
 Thu, 17 Oct 2024 12:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gS0xWRYrY5GGaEk9y
 6Pmlu4HXJzr4kMuWVjTQXxgu+U=; b=hwlecouyVrD2fL5H4rcaJ+quxX93L6O5i
 pYMMOD8tmMiQSz01LRRIUMpD5xxrLPMi83dssvUrSWjN+IPS1Ds+DQRe87TSaxn4
 n5suxm37MBrhaAZhAGfXSxItRvtPqLbt/Eml+xXP7MCe07wjQHn8Fx44j1Gh/Gi2
 CcOouGnYylXVuU/rvodhPj9NDWlsUxAmx86A97UzakpPM7LkGgfQ7NpqJzqS/qnT
 hPoDrbaey2bTxc04JodL2aZHx8vwtNK/Cu5A1ghjt7XAd+WM/fFfDZDPJWhW3Af/
 GPaDEiLYkuNK9ny3FWUTjjsnvT+7h/UjEuDqFt3xyOZNyIINgDBug==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42as8a2py6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 12:58:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49HAmKBs006338;
 Thu, 17 Oct 2024 12:58:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4286516mwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 12:58:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49HCwFkb45875688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 12:58:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0A5820043;
 Thu, 17 Oct 2024 12:58:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7045F20040;
 Thu, 17 Oct 2024 12:58:15 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.92.150])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2024 12:58:15 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] tests/tcg: Test that sigreturn() does not corrupt the
 signal mask
Date: Thu, 17 Oct 2024 14:54:44 +0200
Message-ID: <20241017125811.447961-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017125811.447961-1-iii@linux.ibm.com>
References: <20241017125811.447961-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B5GEhbjYwAf_sRZBSJoel3U0QfjqK8ri
X-Proofpoint-ORIG-GUID: B5GEhbjYwAf_sRZBSJoel3U0QfjqK8ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=915 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 tests/tcg/multiarch/sigreturn-sigmask.c | 51 +++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 tests/tcg/multiarch/sigreturn-sigmask.c

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


