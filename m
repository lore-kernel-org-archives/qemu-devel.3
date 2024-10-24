Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E77D0E3F8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 20:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t440s-0003JY-KU; Thu, 24 Oct 2024 16:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t440m-0003Iu-Cn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:00:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t440k-0002CW-9T
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:00:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ODJFKT011407;
 Thu, 24 Oct 2024 20:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aRVfQ8+ZSlgeARQdK
 kNjIs92kauHeSDJJzu9jan6Tw8=; b=eKG6DLYfUCtF6AS0tEDV8BVMeh8s6mjDC
 ePs9v3hqBi77GPsxwowZOzoXQW85UpbHLgLO7w06P0lBAmSs9f8SnyWEdMxqRTYL
 A2fgOu0ed99CxiHvzO5ZTUTGt8Y93+Vm+dtwzcjUbymw97gDzl2BUJ9/hYobgim4
 R5X4lN9TyoK3ZiMlC8E9mVDfsut6MhfqI0aE9+tIsgKfOACU8pujzRJYsW8ubYqU
 F8OQTPzjN5LyEeVp2LLH448EyMJYW3iWQO/sVxwGAmrfVLNsMaDkqnMyB/iMFhWC
 d0162EXryNhODUTr2LzuTpPC6dqQToufxa4lyYsMcELXkoPhOm8Pg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw44t73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Oct 2024 20:00:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHpfrX006862;
 Thu, 24 Oct 2024 20:00:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emjd26a8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Oct 2024 20:00:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49OK0Z2626214918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2024 20:00:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E32F20043;
 Thu, 24 Oct 2024 20:00:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF2B620040;
 Thu, 24 Oct 2024 20:00:34 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.25.135])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Oct 2024 20:00:34 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/8] user: Introduce user/signal.h
Date: Thu, 24 Oct 2024 21:59:10 +0200
Message-ID: <20241024200031.80327-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024200031.80327-1-iii@linux.ibm.com>
References: <20241024200031.80327-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i0tS8DKl4qgeU-3kswFNEiwn48xGqaZF
X-Proofpoint-GUID: i0tS8DKl4qgeU-3kswFNEiwn48xGqaZF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=932 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240159
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

gdbstub needs target_to_host_signal(), so move its declaration to a
public header.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/signal-common.h   |  1 -
 bsd-user/signal.c          |  1 +
 include/user/signal.h      | 23 +++++++++++++++++++++++
 linux-user/signal-common.h |  1 -
 linux-user/signal.c        |  1 +
 linux-user/syscall.c       |  1 +
 6 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 include/user/signal.h

diff --git a/bsd-user/signal-common.h b/bsd-user/signal-common.h
index 77d7c7a78b7..4e634e04a30 100644
--- a/bsd-user/signal-common.h
+++ b/bsd-user/signal-common.h
@@ -42,7 +42,6 @@ void process_pending_signals(CPUArchState *env);
 void queue_signal(CPUArchState *env, int sig, int si_type,
                   target_siginfo_t *info);
 void signal_init(void);
-int target_to_host_signal(int sig);
 void target_to_host_sigset(sigset_t *d, const target_sigset_t *s);
 
 /*
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index da49b9bffc1..a2b11a97131 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "qemu.h"
 #include "exec/page-protection.h"
+#include "user/signal.h"
 #include "user/tswap-target.h"
 #include "gdbstub/user.h"
 #include "signal-common.h"
diff --git a/include/user/signal.h b/include/user/signal.h
new file mode 100644
index 00000000000..19b6b9e5ddc
--- /dev/null
+++ b/include/user/signal.h
@@ -0,0 +1,23 @@
+/*
+ * Signal-related declarations.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef USER_SIGNAL_H
+#define USER_SIGNAL_H
+
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
+
+/**
+ * target_to_host_signal:
+ * @sig: target signal.
+ *
+ * On success, return the host signal between 0 (inclusive) and NSIG
+ * (exclusive) corresponding to the target signal @sig. Return any other value
+ * on failure.
+ */
+int target_to_host_signal(int sig);
+
+#endif
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index f4cbe6185e1..f82185ec0f5 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -61,7 +61,6 @@ void queue_signal(CPUArchState *env, int sig, int si_type,
                   target_siginfo_t *info);
 void host_to_target_siginfo(target_siginfo_t *tinfo, const siginfo_t *info);
 void target_to_host_siginfo(siginfo_t *info, const target_siginfo_t *tinfo);
-int target_to_host_signal(int sig);
 int host_to_target_signal(int sig);
 long do_sigreturn(CPUArchState *env);
 long do_rt_sigreturn(CPUArchState *env);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 63ac2df53b7..84bb8a34808 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -33,6 +33,7 @@
 #include "signal-common.h"
 #include "host-signal.h"
 #include "user/safe-syscall.h"
+#include "user/signal.h"
 #include "tcg/tcg.h"
 
 /* target_siginfo_t must fit in gdbstub's siginfo save area. */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d1b0f7c5bbc..0a3c4d5a946 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -136,6 +136,7 @@
 #include "loader.h"
 #include "user-mmap.h"
 #include "user/safe-syscall.h"
+#include "user/signal.h"
 #include "qemu/guest-random.h"
 #include "qemu/selfmap.h"
 #include "user/syscall-trace.h"
-- 
2.47.0


