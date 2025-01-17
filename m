Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9171C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 00:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYa1r-00028C-QO; Thu, 16 Jan 2025 19:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYa1p-00027p-5f
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 19:16:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYa1n-0008KA-CF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 19:16:00 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GE73hD025432;
 Fri, 17 Jan 2025 00:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WBuOr1ZSrRUBNaILv
 a5B47YmUMZfjdf9mHbEGsDD8W8=; b=HmVBisqCxexRHzvBV7DLiD3FrX3Tl8Z/U
 Z0zM3uAYCDUSPPqkueRNEPZXGie/twAoe/SFGre0jAvansl5nesa65/ZeEeakUpT
 GUiKJUwJQqxMgJTis217KytASr3SpV+Hm8iuQ67xy7q6w0UJzr2lQ3PTi3k08uUK
 RnFyTFgLnQujmWxMqXXEKMGUnGvpYH45QlTubUSc15GMY8Y6RKV4qP3bPlNlTvfB
 XhaDXD4ZftioXS5BRopuax9Xmyrw2HnUgX8bRXyGFAm9ALwfa75dhKE4K136NVQJ
 fCco1xvJ3OXnjf5zXU/TMVd0K/hju1MdAJyFULHIb8fyNYvPc2PVg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4473k5akw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 00:15:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GKHqLt004526;
 Fri, 17 Jan 2025 00:15:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4442yt0jk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 00:15:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50H0FlXS30605904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 00:15:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB6DE20043;
 Fri, 17 Jan 2025 00:15:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A1F320040;
 Fri, 17 Jan 2025 00:15:47 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.62.46])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jan 2025 00:15:47 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v6 4/8] user: Introduce host_interrupt_signal
Date: Fri, 17 Jan 2025 01:11:29 +0100
Message-ID: <20250117001542.8290-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117001542.8290-1-iii@linux.ibm.com>
References: <20250117001542.8290-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DwecRVtSR48ay6qOInSAezk7f7bYq3Dw
X-Proofpoint-ORIG-GUID: DwecRVtSR48ay6qOInSAezk7f7bYq3Dw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160178
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.797, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Attaching to the gdbstub of a running process requires stopping its
threads. For threads that run on a CPU, cpu_exit() is enough, but the
only way to grab attention of a thread that is stuck in a long-running
syscall is to interrupt it with a signal.

Reserve a host realtime signal for this, just like it's already done
for TARGET_SIGABRT on Linux. This may reduce the number of available
guest realtime signals by one, but this is acceptable, since there are
quite a lot of them, and it's unlikely that there are apps that need
them all.

Set signal_pending for the safe_sycall machinery to prevent invoking
the syscall. This is a lie, since we don't queue a guest signal, but
process_pending_signals() can handle the absence of pending signals.
The syscall returns with QEMU_ERESTARTSYS errno, which arranges for
the automatic restart. This is important, because it helps avoiding
disturbing poorly written guests.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/signal.c     | 12 ++++++++++++
 include/user/signal.h |  2 ++
 linux-user/signal.c   | 25 ++++++++++++++++++++-----
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index 8c51f6ce653..ff2ccbbf605 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -51,6 +51,8 @@ static inline int sas_ss_flags(TaskState *ts, unsigned long sp)
         on_sig_stack(ts, sp) ? SS_ONSTACK : 0;
 }
 
+int host_interrupt_signal = SIGRTMAX;
+
 /*
  * The BSD ABIs use the same signal numbers across all the CPU architectures, so
  * (unlike Linux) these functions are just the identity mapping. This might not
@@ -491,6 +493,12 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
     uintptr_t pc = 0;
     bool sync_sig = false;
 
+    if (host_sig == host_interrupt_signal) {
+        ts->signal_pending = 1;
+        cpu_exit(thread_cpu);
+        return;
+    }
+
     /*
      * Non-spoofed SIGSEGV and SIGBUS are synchronous, and need special
      * handling wrt signal blocking and unwinding.
@@ -854,6 +862,9 @@ void signal_init(void)
 
     for (i = 1; i <= TARGET_NSIG; i++) {
         host_sig = target_to_host_signal(i);
+        if (host_sig == host_interrupt_signal) {
+            continue;
+        }
         sigaction(host_sig, NULL, &oact);
         if (oact.sa_sigaction == (void *)SIG_IGN) {
             sigact_table[i - 1]._sa_handler = TARGET_SIG_IGN;
@@ -872,6 +883,7 @@ void signal_init(void)
             sigaction(host_sig, &act, NULL);
         }
     }
+    sigaction(host_interrupt_signal, &act, NULL);
 }
 
 static void handle_pending_signal(CPUArchState *env, int sig,
diff --git a/include/user/signal.h b/include/user/signal.h
index 19b6b9e5ddc..7fa33b05d91 100644
--- a/include/user/signal.h
+++ b/include/user/signal.h
@@ -20,4 +20,6 @@
  */
 int target_to_host_signal(int sig);
 
+extern int host_interrupt_signal;
+
 #endif
diff --git a/linux-user/signal.c b/linux-user/signal.c
index bffbef235cd..81a98c6d02f 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -517,6 +517,8 @@ static int core_dump_signal(int sig)
     }
 }
 
+int host_interrupt_signal;
+
 static void signal_table_init(const char *rtsig_map)
 {
     int hsig, tsig, count;
@@ -580,10 +582,10 @@ static void signal_table_init(const char *rtsig_map)
          * Attempts for configure "missing" signals via sigaction will be
          * silently ignored.
          *
-         * Reserve one signal for internal usage (see below).
+         * Reserve two signals for internal usage (see below).
          */
 
-        hsig = SIGRTMIN + 1;
+        hsig = SIGRTMIN + 2;
         for (tsig = TARGET_SIGRTMIN;
              hsig <= SIGRTMAX && tsig <= TARGET_NSIG;
              hsig++, tsig++) {
@@ -604,12 +606,17 @@ static void signal_table_init(const char *rtsig_map)
     host_to_target_signal_table[SIGABRT] = 0;
     for (hsig = SIGRTMIN; hsig <= SIGRTMAX; hsig++) {
         if (!host_to_target_signal_table[hsig]) {
-            host_to_target_signal_table[hsig] = TARGET_SIGABRT;
-            break;
+            if (host_interrupt_signal) {
+                host_to_target_signal_table[hsig] = TARGET_SIGABRT;
+                break;
+            } else {
+                host_interrupt_signal = hsig;
+            }
         }
     }
     if (hsig > SIGRTMAX) {
-        fprintf(stderr, "No rt signals left for SIGABRT mapping\n");
+        fprintf(stderr,
+                "No rt signals left for interrupt and SIGABRT mapping\n");
         exit(EXIT_FAILURE);
     }
 
@@ -689,6 +696,8 @@ void signal_init(const char *rtsig_map)
         }
         sigact_table[tsig - 1]._sa_handler = thand;
     }
+
+    sigaction(host_interrupt_signal, &act, NULL);
 }
 
 /* Force a synchronously taken signal. The kernel force_sig() function
@@ -1036,6 +1045,12 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
     bool sync_sig = false;
     void *sigmask;
 
+    if (host_sig == host_interrupt_signal) {
+        ts->signal_pending = 1;
+        cpu_exit(thread_cpu);
+        return;
+    }
+
     /*
      * Non-spoofed SIGSEGV and SIGBUS are synchronous, and need special
      * handling wrt signal blocking and unwinding.  Non-spoofed SIGILL,
-- 
2.47.1


