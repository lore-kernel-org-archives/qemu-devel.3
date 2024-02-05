Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515D8C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 11:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWx48-0001lk-8W; Mon, 05 Feb 2024 06:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx46-0001kd-9B
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx44-0006kp-GM
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:05 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415AtLoF030208; Mon, 5 Feb 2024 11:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uT7A/sqalgVYQqMzo1c6DQ3YIZWlQuYQ+v4AEThmUeo=;
 b=peoF6FKXhRJeppVw6bYa3pro+yxShvf2hH8i1C6CP6gWsp/15JOdwZJBS44lI7/arMDH
 f5aGxxVerLVSZxmUXY7gawZMNiZal1hkmcHH46kdatB4/KhvmJ810NYJ6AyF1I9dFMB8
 fFUIQT8yj9O+fClb4hNY+DDbl94sWW/nWQZ+Zn/6bxKWUSI8vxLoCbQKVwtoBR4GnnYe
 3y2Elhm3hGlZwuzJEYIsbXLYOcc4IOnj2izolFGpUFMzEeD8PZqlYM+X1u1VniiTofxG
 ymzMdyLq8O2wr2joBLBqW07u0f9wldnmFo++fmXyslYt84E7IqRerrpq8WAttt+rpztT ww== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2ur8vk53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:23:01 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415ApcpB014837; Mon, 5 Feb 2024 11:23:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tng28m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:23:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415BMxUo20120156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 11:22:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24AD02004D;
 Mon,  5 Feb 2024 11:22:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF1FB2004B;
 Mon,  5 Feb 2024 11:22:58 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.32.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 11:22:58 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 04/11] {linux,bsd}-user: Pass pid to fork_end()
Date: Mon,  5 Feb 2024 12:22:18 +0100
Message-ID: <20240205112251.121569-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205112251.121569-1-iii@linux.ibm.com>
References: <20240205112251.121569-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hex0ZWQ51K4ZFgMB1mr1dxu4E6vWk-Ox
X-Proofpoint-ORIG-GUID: hex0ZWQ51K4ZFgMB1mr1dxu4E6vWk-Ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=639 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index bfe6888ea89..bc233a85cef 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -109,8 +109,10 @@ void fork_start(void)
     gdbserver_fork_start();
 }
 
-void fork_end(int child)
+void fork_end(abi_long pid)
 {
+    int child = pid == 0;
+
     if (child) {
         CPUState *cpu, *next_cpu;
         /*
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index dc842fffa7d..2414a87559b 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -180,7 +180,7 @@ void cpu_loop(CPUArchState *env);
 char *target_strerror(int err);
 int get_osversion(void);
 void fork_start(void);
-void fork_end(int child);
+void fork_end(abi_long pid);
 
 #include "qemu/log.h"
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 8c7bea1c631..f1a0267816b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -147,8 +147,10 @@ void fork_start(void)
     gdbserver_fork_start();
 }
 
-void fork_end(int child)
+void fork_end(abi_long pid)
 {
+    int child = pid == 0;
+
     qemu_plugin_user_postfork(child);
     mmap_fork_end(child);
     if (child) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index aeb95644873..9e628a0f975 100644
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
index c63ef45fc78..9014014d920 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -71,7 +71,7 @@ const char *target_strerror(int err);
 int get_osversion(void);
 void init_qemu_uname_release(void);
 void fork_start(void);
-void fork_end(int child);
+void fork_end(abi_long pid);
 
 /**
  * probe_guest_base:
-- 
2.43.0


