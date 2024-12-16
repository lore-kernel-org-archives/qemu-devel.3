Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC3CE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAJ0-0002ZZ-Gn; Mon, 16 Dec 2024 07:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tNAIv-0002O6-MB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:34:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tNAIr-0002Lu-FC
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:34:27 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG85Wco027022;
 Mon, 16 Dec 2024 12:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=sggGxTYzs8/8Ih5aZ
 G9UlHzBiFw8zdXKN35kfsUZBHs=; b=L65HzYI1wr6jQ8S9FZbh3v0xorZs+zkVq
 0SzYNr6Tvc9J/e8EMJkcwu8WPugNtPT5huFygh72c+CMnugcArStKINJqOnbHTS7
 IAFupSPzTtKpcoqs1BPIQJ6IGRpAUtKIRSTbasZ+a7k45MIK/buzkCfDzQI0Fk2M
 s3uvudV2Ih+jwCV6heROHRwunWKP2dZkCbOurMqFnA4wMs9pcMvlAorFU3ezxIZ2
 LhlrDaK1TQFsXgcZA0fem4EbDs7oc0RYfno4gx/+4ZnL7n8vdpATMsiPyfvZHYJd
 5qNIAPVEBBmDImhyC27zYmrZMINZzjJy+9CB9YnB52gyrMdTmeTzg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd295yj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 12:34:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGAH9LF011249;
 Mon, 16 Dec 2024 12:34:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjjwmxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 12:34:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BGCYHWG55902538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:34:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA1E920049;
 Mon, 16 Dec 2024 12:34:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A67420040;
 Mon, 16 Dec 2024 12:34:16 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.68.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Dec 2024 12:34:16 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 3/8] user: Introduce user/signal.h
Date: Mon, 16 Dec 2024 13:33:21 +0100
Message-ID: <20241216123412.77450-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216123412.77450-1-iii@linux.ibm.com>
References: <20241216123412.77450-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SpotVJIpYHSdB1wfmreXOUDnGCwmMODk
X-Proofpoint-GUID: SpotVJIpYHSdB1wfmreXOUDnGCwmMODk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.13, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
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
index 8584d9ecc2a..196d2406f86 100644
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
index 9b6d772882d..b1c468cf5c3 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -34,6 +34,7 @@
 #include "signal-common.h"
 #include "host-signal.h"
 #include "user/safe-syscall.h"
+#include "user/signal.h"
 #include "tcg/tcg.h"
 
 /* target_siginfo_t must fit in gdbstub's siginfo save area. */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1ce4c79784f..7cccaf4e48a 100644
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


