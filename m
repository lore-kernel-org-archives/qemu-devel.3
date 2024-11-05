Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2019AD2C122
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LHK-0007oT-TZ; Tue, 05 Nov 2024 10:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1t8LHI-0007nr-9x
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:15:32 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1t8LHG-0002N8-Dl
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:15:32 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id CE00DA4306F;
 Tue,  5 Nov 2024 15:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA2CC4CECF;
 Tue,  5 Nov 2024 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730819728;
 bh=1zhW+Lr6humUyTRTRcizuZ1ATV6UDIXNwt8wvDXht/g=;
 h=Date:From:To:Subject:From;
 b=t6yjA1J9nDkddXwbHGWISdoeHgmoTr/kIAQUF8/FV27xJyHr294tt/fQbsblvSWlR
 qxkfzL04qNaghVLW20mrCNfyNM4e2pJqAJkR7df2E0HJR4TdM00U6IQ415BMkB4mbh
 L50XVrFHShfLg0oak/3DqzUN0ZTNpIovCtSixPYqrUQnps29Y0KQY0wYLCjMt1+erC
 pbhd1XDU4/5EDVK6mDQR+hBQVcp5HTp5msJui7WzwxlhQVp29sBOEuWwayPeU5p6pG
 XDFZhBYbjo2TONwZa3UYOptxhgB+CBKOaBLD3uGfM82FzL3wYrACRPgkJA4KCxGc2n
 WU0nBj+OC6ELA==
Date: Tue, 5 Nov 2024 16:15:24 +0100
From: Helge Deller <deller@kernel.org>
To: Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Riku Voipio <riku.voipio@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Fix setreuid and setregid to use direct syscalls
Message-ID: <Zyo2jMKqq8hG8Pkz@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The commit fd6f7798ac30 ("linux-user: Use direct syscalls for setuid(),
etc") added direct syscall wrappers for setuid(), setgid(), etc since the
system calls have different semantics than the libc functions.

Add and use the corresponding wrappers for setreuid and setregid which
were missed in that commit.

This fixes the build of the debian package of the uid_wrapper library
(https://cwrap.org/uid_wrapper.html) when running linux-user.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 59b2080b98..0279f23576 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7233,12 +7233,24 @@ static inline int tswapid(int id)
 #else
 #define __NR_sys_setgroups __NR_setgroups
 #endif
+#ifdef __NR_sys_setreuid32
+#define __NR_sys_setreuid __NR_setreuid32
+#else
+#define __NR_sys_setreuid __NR_setreuid
+#endif
+#ifdef __NR_sys_setregid32
+#define __NR_sys_setregid __NR_setregid32
+#else
+#define __NR_sys_setregid __NR_setregid
+#endif
 
 _syscall1(int, sys_setuid, uid_t, uid)
 _syscall1(int, sys_setgid, gid_t, gid)
 _syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
 _syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
 _syscall2(int, sys_setgroups, int, size, gid_t *, grouplist)
+_syscall2(int, sys_setreuid, uid_t, ruid, uid_t, euid);
+_syscall2(int, sys_setregid, gid_t, rgid, gid_t, egid);
 
 void syscall_init(void)
 {
@@ -11932,9 +11944,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return get_errno(high2lowgid(getegid()));
 #endif
     case TARGET_NR_setreuid:
-        return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
+        return get_errno(sys_setreuid(low2highuid(arg1), low2highuid(arg2)));
     case TARGET_NR_setregid:
-        return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
+        return get_errno(sys_setregid(low2highgid(arg1), low2highgid(arg2)));
     case TARGET_NR_getgroups:
         { /* the same code as for TARGET_NR_getgroups32 */
             int gidsetsize = arg1;
@@ -12264,11 +12276,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_setreuid32
     case TARGET_NR_setreuid32:
-        return get_errno(setreuid(arg1, arg2));
+        return get_errno(sys_setreuid(arg1, arg2));
 #endif
 #ifdef TARGET_NR_setregid32
     case TARGET_NR_setregid32:
-        return get_errno(setregid(arg1, arg2));
+        return get_errno(sys_setregid(arg1, arg2));
 #endif
 #ifdef TARGET_NR_getgroups32
     case TARGET_NR_getgroups32:

