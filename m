Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443D8D7494F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 23:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5vXg-0004Do-4G; Tue, 29 Oct 2024 19:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t5vXc-0004D7-6K
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 19:22:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t5vXa-00045t-E2
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 19:22:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TLKBfW031401;
 Tue, 29 Oct 2024 23:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9BbXIVBdJZZMWwDof
 7aKer9V95VsJYCKUjtzhRofcng=; b=EpfkGEYGN3DNbYStlv8HlHRleOpAVPSII
 Ai4jWIqPRBOPj5gy5J1AApD94NUFyPyp9QjGl4+VYZP04170POPKLX7HggrdCz6P
 Vk45MJwQxt5VoLUHrHW2sOmO+auPde2+LHb3oGlFuWbZmRQzFdCcC+61tzL5uqjh
 3xEbT+qe/aQIs+NGd+/6I4rnbztoEOeZGsNx624n8ZliV68YXH5ka+1kdRrzgS2J
 j3muiLKFNjj91oS1JyADNgJAYGhPRIkBDynXw9bDpKJ1OVwnsrIndvV0fuXu9Kkj
 pHyKe5/X65Bvu4xQ/6dZ3CsyNxTun3TK2fAkPyGJEQY98RuoiIv6g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nsusff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 23:22:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49TNMHXQ030433;
 Tue, 29 Oct 2024 23:22:18 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nsusfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 23:22:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49TJXprH024535;
 Tue, 29 Oct 2024 23:22:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyjd51g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 23:22:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49TNMF0x35521144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Oct 2024 23:22:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34A8F20040;
 Tue, 29 Oct 2024 23:22:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C77DC2004B;
 Tue, 29 Oct 2024 23:22:14 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.12.2])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Oct 2024 23:22:14 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Brian Cain <bcain@quicinc.com>,
 "ltaylorsimpson @ gmail . com" <ltaylorsimpson@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 2/2] tests/tcg: Add SIGRTMIN/SIGRTMAX test
Date: Wed, 30 Oct 2024 00:17:48 +0100
Message-ID: <20241029232211.206766-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029232211.206766-1-iii@linux.ibm.com>
References: <20241029232211.206766-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 41-FSsKq4XLsZ3YEd4b-WjwZpGH21lpB
X-Proofpoint-GUID: aSnoV_l9HxwjdReTVJoBpIKLAUpau_ML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=897 clxscore=1015 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290175
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Test the lowest and the highest real-time signals. This requires
configuring the real-time signal mapping, and therefore some knowledge
about the host. To this end, pass the emulator path in the QEMU
environment variable to all tests (this should not disturb the existing
ones), and assume that all hosts have signals 36-39 available.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/Makefile.target                     |  4 +-
 tests/tcg/multiarch/linux/linux-sigrtminmax.c | 74 +++++++++++++++++++
 2 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-sigrtminmax.c

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 9722145b976..95ff76ea44d 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -179,10 +179,10 @@ run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true
 
 ifeq ($(filter %-softmmu, $(TARGET)),)
 run-%: %
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<)
+	$(call run-test, $<, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) $<)
 
 run-plugin-%:
-	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
+	$(call run-test, $@, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) \
 		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<))
diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
new file mode 100644
index 00000000000..a7059aacd9c
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
@@ -0,0 +1,74 @@
+/*
+ * Test the lowest and the highest real-time signals.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+/* For hexagon and microblaze. */
+#ifndef __SIGRTMIN
+#define __SIGRTMIN 32
+#endif
+
+extern char **environ;
+
+static bool seen_sigrtmin, seen_sigrtmax;
+
+static void handle_signal(int sig)
+{
+    if (sig == SIGRTMIN) {
+        seen_sigrtmin = true;
+    } else if (sig == SIGRTMAX) {
+        seen_sigrtmax = true;
+    } else {
+        _exit(1);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    char *qemu = getenv("QEMU");
+    struct sigaction act;
+
+    assert(qemu);
+
+    if (!getenv("QEMU_RTSIG_MAP")) {
+        char **new_argv = malloc((argc + 2) + sizeof(char *));
+        int tsig1, hsig1, count1, tsig2, hsig2, count2;
+        char rt_sigmap[64];
+
+        /* Re-exec with a mapping that includes SIGRTMIN and SIGRTMAX. */
+        new_argv[0] = qemu;
+        memcpy(&new_argv[1], argv, (argc + 1) * sizeof(char *));
+        tsig1 = __SIGRTMIN;
+        /* The host must have a few signals starting from this one. */
+        hsig1 = 36;
+        count1 = SIGRTMIN - __SIGRTMIN + 1;
+        tsig2 = SIGRTMAX;
+        hsig2 = hsig1 + count1;
+        count2 = 1;
+        snprintf(rt_sigmap, sizeof(rt_sigmap), "%d %d %d,%d %d %d",
+                 tsig1, hsig1, count1, tsig2, hsig2, count2);
+        setenv("QEMU_RTSIG_MAP", rt_sigmap, 0);
+        assert(execve(new_argv[0], new_argv, environ) == 0);
+        return EXIT_FAILURE;
+    }
+
+    memset(&act, 0, sizeof(act));
+    act.sa_handler = handle_signal;
+    assert(sigaction(SIGRTMIN, &act, NULL) == 0);
+    assert(sigaction(SIGRTMAX, &act, NULL) == 0);
+
+    assert(kill(getpid(), SIGRTMIN) == 0);
+    assert(seen_sigrtmin);
+    assert(kill(getpid(), SIGRTMAX) == 0);
+    assert(seen_sigrtmax);
+
+    return EXIT_SUCCESS;
+}
-- 
2.47.0


