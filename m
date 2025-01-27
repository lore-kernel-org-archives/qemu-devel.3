Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12110C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgXr-0003r2-Ha; Tue, 28 Jan 2025 03:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgX4-0000iw-07; Tue, 28 Jan 2025 03:01:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgX2-0001lO-Ck; Tue, 28 Jan 2025 03:01:13 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8CF9BE1B4B;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 08D111A62FE;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id E367F5208D; Tue, 28 Jan 2025 10:57:33 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 04/58] linux-user: Fix strace output for s390x mmap()
Date: Mon, 27 Jan 2025 23:24:50 +0300
Message-Id: <20250127202547.3723716-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

print_mmap() assumes that mmap() receives arguments via memory if
mmap2() is present. s390x (as opposed to s390) does not fit this
pattern: it does not have mmap2(), but mmap() still receives arguments
via memory.

Fix by sharing the detection logic between syscall.c and strace.c.

Cc: qemu-stable@nongnu.org
Fixes: d971040c2d16 ("linux-user: Fix strace output for old_mmap")
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20241120212717.246186-1-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit d95fd9838b540e69da9b07538ec8ad6ab9eab260)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: compensate for chris architecture removal by v9.1.0-282-gbff4b02ca1f4
 "linux-user: Remove support for CRIS target")

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b4d1098170..4dabe0bd42 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3823,7 +3823,7 @@ print_mmap(CPUArchState *cpu_env, const struct syscallname *name,
 {
     return print_mmap_both(cpu_env, name, arg0, arg1, arg2, arg3,
                            arg4, arg5,
-#if defined(TARGET_NR_mmap2)
+#ifdef TARGET_ARCH_WANT_SYS_OLD_MMAP
                             true
 #else
                             false
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c393ca6716..900872a741 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10496,10 +10496,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return ret;
 #ifdef TARGET_NR_mmap
     case TARGET_NR_mmap:
-#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
-    (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
-    defined(TARGET_M68K) || defined(TARGET_CRIS) || defined(TARGET_MICROBLAZE) \
-    || defined(TARGET_S390X)
+#ifdef TARGET_ARCH_WANT_SYS_OLD_MMAP
         {
             abi_ulong *v;
             abi_ulong v1, v2, v3, v4, v5, v6;
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a00b617cae..7ca5972296 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2754,4 +2754,11 @@ struct target_sched_param {
     abi_int sched_priority;
 };
 
+#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
+    (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
+    defined(TARGET_M68K) || defined(TARGET_CRIS) || defined(TARGET_MICROBLAZE) \
+    || defined(TARGET_S390X)
+#define TARGET_ARCH_WANT_SYS_OLD_MMAP
+#endif
+
 #endif
-- 
2.39.5


