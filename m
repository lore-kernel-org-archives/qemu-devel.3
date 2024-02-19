Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E86C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Sh-0007kP-6c; Mon, 19 Feb 2024 09:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SY-0007d4-EQ
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SU-0000bv-Ml
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:29 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JDUhEO018254; Mon, 19 Feb 2024 14:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=5sH+jweDU29k5FKPAV+TufXz3YDiKawh1y2LJSnbhZk=;
 b=e6BKzdMhcCbz/88CQkHtFjcQz76m38ZqvquqeQPrm6pzhhLGW8tiLLlOZBXOXeBVd2Sz
 BQGPwSMXrI2FQPl3oEsC0kSfkTqBz1KtxC0vyso5mU8aZG8j7oS2PpyHd/s+66ELfruC
 1r5+Yk0XNA81RH+8JS9IW9vBnxPPb8GaNs0e9wLd9gYG0PL9yMmF1KUTLw+5FA9Fg0oG
 oBKU51AZT/L0z+kS/tBKoxgrSkECn9NBoIrL1yCkRL1hVDlMfjIz3MHZ33k+0GSz+4ZU
 w+d17d9z33f33RNwrw6nIyTy/IYvf31ub7T0C2j3cxYbx63M+oRb/bugBsAIkMoJlyVj 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb2p8kj2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:05 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JDVJTi019257;
 Mon, 19 Feb 2024 14:17:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb2p8kj1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:04 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JBI9f4009577; Mon, 19 Feb 2024 14:17:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p1n4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41JEGw9a26739424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Feb 2024 14:17:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 649BE2004E;
 Mon, 19 Feb 2024 14:16:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A82092004D;
 Mon, 19 Feb 2024 14:16:57 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Feb 2024 14:16:57 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 05/12] {linux,bsd}-user: Pass pid to fork_end()
Date: Mon, 19 Feb 2024 15:15:53 +0100
Message-ID: <20240219141628.246823-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219141628.246823-1-iii@linux.ibm.com>
References: <20240219141628.246823-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RUK2VwubId6UAImgR_HnYGyMXvy6o_OT
X-Proofpoint-GUID: 4ygWsoOGInuRxnJHYuv9wMqpDNwocBzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=939 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The upcoming follow-fork-mode child support requires knowing the child
pid. Pass it down.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/freebsd/os-proc.h  | 6 +++---
 bsd-user/main.c             | 4 +++-
 bsd-user/qemu.h             | 2 +-
 linux-user/main.c           | 4 +++-
 linux-user/syscall.c        | 6 +++---
 linux-user/user-internals.h | 2 +-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index d6418780344..3003c8cb637 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -208,7 +208,7 @@ static inline abi_long do_freebsd_fork(void *cpu_env)
      */
     set_second_rval(cpu_env, child_flag);
 
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 }
@@ -252,7 +252,7 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
      * value: 0 for parent process, 1 for child process.
      */
     set_second_rval(cpu_env, child_flag);
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 
@@ -285,7 +285,7 @@ static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
      * value: 0 for parent process, 1 for child process.
      */
     set_second_rval(cpu_env, child_flag);
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 }
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 35a27a07c8d..94e1edf8247 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -109,8 +109,10 @@ void fork_start(void)
     gdbserver_fork_start();
 }
 
-void fork_end(int child)
+void fork_end(pid_t pid)
 {
+    bool child = pid == 0;
+
     if (child) {
         CPUState *cpu, *next_cpu;
         /*
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index a2417b25156..c1ee90a296d 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -185,7 +185,7 @@ void cpu_loop(CPUArchState *env);
 char *target_strerror(int err);
 int get_osversion(void);
 void fork_start(void);
-void fork_end(int child);
+void fork_end(pid_t pid);
 
 #include "qemu/log.h"
 
diff --git a/linux-user/main.c b/linux-user/main.c
index dce6233ee49..a490d798898 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -147,8 +147,10 @@ void fork_start(void)
     gdbserver_fork_start();
 }
 
-void fork_end(int child)
+void fork_end(pid_t pid)
 {
+    bool child = pid == 0;
+
     qemu_plugin_user_postfork(child);
     mmap_fork_end(child);
     if (child) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3e105488ee2..a0b61bcb2a2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6669,7 +6669,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         if (ret == 0) {
             /* Child Process.  */
             cpu_clone_regs_child(env, newsp, flags);
-            fork_end(1);
+            fork_end(ret);
             /* There is a race condition here.  The parent process could
                theoretically read the TID in the child process before the child
                tid is set.  This would require using either ptrace
@@ -6700,8 +6700,8 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                 }
 #endif
                 put_user_u32(pid_fd, parent_tidptr);
-                }
-            fork_end(0);
+            }
+            fork_end(ret);
         }
         g_assert(!cpu_in_exclusive_context(cpu));
     }
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index c63ef45fc78..ce11d9e21c1 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -71,7 +71,7 @@ const char *target_strerror(int err);
 int get_osversion(void);
 void init_qemu_uname_release(void);
 void fork_start(void);
-void fork_end(int child);
+void fork_end(pid_t pid);
 
 /**
  * probe_guest_base:
-- 
2.43.2


