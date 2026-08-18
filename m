Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4290AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgR-0001oi-EY; Tue, 18 Aug 2026 19:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgP-0001oD-S3
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:29 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgM-0005C0-Qz
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:29 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4b28db06775so314718b6e.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097446; x=1787702246;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YfOh8OoaQYgpTQSmCrfdR2/AwfLWimXK2o/Oo7feBGg=;
 b=pk0YpdWUB4n5J826uPuThdxOaT/ccm1OSYSeQbRUJw1At98EOlSeaCQxemNL/LO2xG
 RWGfoFQOkvdVSRgZHm3hS1ZJ/xE+fkNq3fRzcvJy8lTpjSQT7OlFktqj15wYOOtHhjdj
 GcxRo/VsZ6KlrcjjNxDVKPnTlYb5ERiqr+cten4or4j5Ps1y5dnVyDZYrIbF1Osee5sI
 jDSBirROhHzPDB6tUzJt5A/7H5PL6hVCp6RzfHQXjA8knIAaewHjBqwW9RslH/STa488
 gyU2m/ZggX3UyKXhUYyFMmBa+GJH9/udUrKWHwMJ53bmhk1ChPW9GwH1Ay0teXye5Y87
 lu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097446; x=1787702246;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YfOh8OoaQYgpTQSmCrfdR2/AwfLWimXK2o/Oo7feBGg=;
 b=kUSohu+Th8PUG9BdW1C9yp5aAKJQRITdbF9nZ5gwKxlOE+P/TO7MvPTefnjJQzQxa4
 YZxOANXAdoB3dwiHyscwY1II3bicYpyIsIr7OrqaEa+tguWs1UXDr/3Yh5nQQGj3x8TI
 E2oEm6YdBnMc9Kazl3EFjsVf/gpJ2OAo+6o8KE2HajT+bVF9owGhjDGXpga3JMEytb/H
 b6I9vAUOxrLpNiMLLwIJgJiSdN5pitcPXxv3CN9cv1BrNaYetcFjgEs/zvWgWKEVZELz
 lTzNEcjdHKnvRzKeEF5jUGDAqugL6GHJbyrVGo5mcm+VVcy6bnPhQnWpKHAbf3J0dKE9
 pW0A==
X-Gm-Message-State: AOJu0Yw6IsHuTLPReiLcsSrC8g87T23zNbV6edBGveLv9rR18ufKlSaI
 FgmfdEOqRYG9ExTj4FQeghQHXrlew9s0Gg/yHk2Wty3cHmo4TVIJfukZc2cHl5u5nPs=
X-Gm-Gg: AR+sD10ZLnUbvxstafY9eC4lWlujOCPmI3peN+3xckTH1x4RkErXfXM+W7cLzpAyxXW
 J3xvYrkMg/HsRtI+NKlvhU3i54glwZXmpka3Nq6w1+x+zROzSFfLNw6hIRCGIegpuNzMsELXz+C
 oodcOUHQzJ9uxKxeS7Z7qf9949Krwyjpd/BgGEIfSM9MYxeT6/SQWaNATnEGVWGoa5fKtUzgn9l
 DaiGRCl6ToxrrF6NxHvQrisByNQ6LifCY6RlGd8Pl+2VYFV4g4BJ3u6hF4UkFe7SCE7k+jEwF9n
 azHR56WNluvGF0RbdF9c1Ou/6FIdxped1xK1srd+Zuy3U+AX7t64WiD4+20uEMbwB94z7MMc3nC
 1ofTyiu7URrbyopuS9AkFuQNz15I/zZ7sqNy3s7EA4OS5XoVLSLHV3rdIpKUNc2RoKJtnzePkdG
 gC6wfnZFv9Bs6dFrGxm47MMn9HA1DjfpY1iPian/4bSlKO+no=
X-Received: by 2002:a05:6808:238d:b0:4b2:8e24:799 with SMTP id
 5614622812f47-4b2bcb4e333mr298202b6e.17.1787097445438; 
 Tue, 18 Aug 2026 16:57:25 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:23 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:55:54 -0600
Subject: [PATCH v4 01/40] bsd-user: Rename cpu_env to env throughout bsd-user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-1-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=23722; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=E6Pqw9RKHOUbzH508FXwoeSGSiLNeRFD9I4NltDh4L4=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEf84pusYvFP5bqwilbs05K9j1qYmSKO0KC4
 vABus7q2/iJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxHxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDZIw//TcnRfAP/8gQfVp9SKWPycVc/BrUUQsw
 mUDtz5M+TCjMWhssfVNWJp2khuisLqg8XP6NLd6QVPEAifetEPSpb212VoHNQJMJCfnpqdS2+L3
 8s30sxUK3chSiD1ah2yvHiKpFLzgifGKesXiTW3W30mHFz4Kxb260lmxPi0FzIuKAn/FvOkCfye
 p0T0jnrROH3zm1hPLwk6BzJHuAxsvCIGNIso3YjQ8BNO1apQGqY7IWk2DlQalpupLReXtyZ8yj2
 ffj1RY8k7mtRmfDLah9Ahp9RMcO5Cg9ueDcgfY+n/AOAfZOo6xwlpyDAwkLq4GIu9t9Hdvb0zDt
 RCi74i55Rx5EGCeClsh0s73lgLWow0/uvTzfVjVQnu98QSPTpr0kG0lA2Fum9wRZCFu0pCIuxNX
 813rSr/WHw+kI26ak0OVejjtyYjDLoZRsNxvO1WPYfvQICmG0ITnWiCsHRqKmXlVj9ttvAn2wxE
 xoBbaAfVyWBc7Rx5YwQDDlFsflbniMJQ9MXmOq20LBXsJNIcCCfkUy/114KEm6+vFx8DMsIihc9
 srjCPoagbBOEwfh8n63in/P61Am9UE91DfS4UJGykdwCraqWu0q09ZDj5r3F+lFNqXO/Js4/DXY
 /je9n4Bn3H56kkdGUHokUZ7tPYACCBt7NSBKLWKm0xzrga7lRQJM=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::232;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace 'void *cpu_env' parameters with 'CPUArchState *env' across all
bsd-user source files. This improves type safety and aligns with the
convention used in the rest of the codebase.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/target.h     |  2 +-
 bsd-user/arm/target.h         |  2 +-
 bsd-user/bsd-file.h           | 28 +++++++++++++--------------
 bsd-user/bsd-mem.h            |  4 ++--
 bsd-user/bsd-proc.h           |  8 ++++----
 bsd-user/freebsd/os-proc.c    |  4 ++--
 bsd-user/freebsd/os-proc.h    | 26 ++++++++++++-------------
 bsd-user/freebsd/os-sys.c     |  4 ++--
 bsd-user/freebsd/os-syscall.c | 44 +++++++++++++++++++++----------------------
 bsd-user/i386/target.h        |  2 +-
 bsd-user/qemu.h               |  6 +++---
 bsd-user/riscv/target.h       |  2 +-
 bsd-user/x86_64/target.h      |  2 +-
 13 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/bsd-user/aarch64/target.h b/bsd-user/aarch64/target.h
index 702aeb7fc5..37b9817fe1 100644
--- a/bsd-user/aarch64/target.h
+++ b/bsd-user/aarch64/target.h
@@ -12,7 +12,7 @@
 /*
  * aaarch64 ABI does not 'lump' the registers for 64-bit args.
  */
-static inline bool regpairs_aligned(void *cpu_env)
+static inline bool regpairs_aligned(CPUArchState *env)
 {
     return false;
 }
diff --git a/bsd-user/arm/target.h b/bsd-user/arm/target.h
index 7c423ec575..cf131f29fb 100644
--- a/bsd-user/arm/target.h
+++ b/bsd-user/arm/target.h
@@ -12,7 +12,7 @@
 /*
  * arm EABI 'lumps' the registers for 64-bit args.
  */
-static inline bool regpairs_aligned(void *cpu_env)
+static inline bool regpairs_aligned(CPUArchState *env)
 {
     return true;
 }
diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index dca1518cb1..dec59bd80b 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -72,7 +72,7 @@ static abi_long do_bsd_read(abi_long arg1, abi_long arg2, abi_long arg3)
 }
 
 /* pread(2) */
-static abi_long do_bsd_pread(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_pread(CPUArchState *env, abi_long arg1,
     abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
     abi_long ret;
@@ -82,7 +82,7 @@ static abi_long do_bsd_pread(void *cpu_env, abi_long arg1,
     if (p == NULL) {
         return -TARGET_EFAULT;
     }
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         arg4 = arg5;
         arg5 = arg6;
     }
@@ -109,14 +109,14 @@ static abi_long do_bsd_readv(abi_long arg1, abi_long arg2, abi_long arg3)
 }
 
 /* preadv(2) */
-static abi_long do_bsd_preadv(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_preadv(CPUArchState *env, abi_long arg1,
     abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
     abi_long ret;
     struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 1);
 
     if (vec != NULL) {
-        if (regpairs_aligned(cpu_env) != 0) {
+        if (regpairs_aligned(env) != 0) {
             arg4 = arg5;
             arg5 = arg6;
         }
@@ -151,7 +151,7 @@ static abi_long do_bsd_write(abi_long arg1, abi_long arg2, abi_long arg3)
 }
 
 /* pwrite(2) */
-static abi_long do_bsd_pwrite(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_pwrite(CPUArchState *env, abi_long arg1,
     abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
     abi_long ret;
@@ -161,7 +161,7 @@ static abi_long do_bsd_pwrite(void *cpu_env, abi_long arg1,
     if (p == NULL) {
         return -TARGET_EFAULT;
     }
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         arg4 = arg5;
         arg5 = arg6;
     }
@@ -188,14 +188,14 @@ static abi_long do_bsd_writev(abi_long arg1, abi_long arg2, abi_long arg3)
 }
 
 /* pwritev(2) */
-static abi_long do_bsd_pwritev(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_pwritev(CPUArchState *env, abi_long arg1,
     abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
     abi_long ret;
     struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
 
     if (vec != NULL) {
-        if (regpairs_aligned(cpu_env) != 0) {
+        if (regpairs_aligned(env) != 0) {
             arg4 = arg5;
             arg5 = arg6;
         }
@@ -484,14 +484,14 @@ static abi_long do_bsd_dup2(abi_long arg1, abi_long arg2)
 }
 
 /* truncate(2) */
-static abi_long do_bsd_truncate(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_truncate(CPUArchState *env, abi_long arg1,
         abi_long arg2, abi_long arg3, abi_long arg4)
 {
     abi_long ret;
     void *p;
 
     LOCK_PATH(p, arg1);
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         arg2 = arg3;
         arg3 = arg4;
     }
@@ -502,10 +502,10 @@ static abi_long do_bsd_truncate(void *cpu_env, abi_long arg1,
 }
 
 /* ftruncate(2) */
-static abi_long do_bsd_ftruncate(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_ftruncate(CPUArchState *env, abi_long arg1,
         abi_long arg2, abi_long arg3, abi_long arg4)
 {
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         arg2 = arg3;
         arg3 = arg4;
     }
@@ -735,7 +735,7 @@ static abi_long do_bsd_freebsd11_mknodat(abi_long arg1, abi_long arg2,
 }
 
 /* post-ino64 mknodat(2) */
-static abi_long do_bsd_mknodat(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_mknodat(CPUArchState *env, abi_long arg1,
         abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5,
         abi_long arg6)
 {
@@ -744,7 +744,7 @@ static abi_long do_bsd_mknodat(void *cpu_env, abi_long arg1,
 
     LOCK_PATH(p, arg2);
        /* 32-bit arch's use two 32 registers for 64 bit return value */
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         ret = get_errno(mknodat(arg1, p, arg3, target_arg64(arg5, arg6)));
     } else {
         ret = get_errno(mknodat(arg1, p, arg3, target_arg64(arg4, arg5)));
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 9d7b60d3c3..3086143d40 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -51,11 +51,11 @@ extern abi_ulong target_brk;
 extern abi_ulong initial_target_brk;
 
 /* mmap(2) */
-static inline abi_long do_bsd_mmap(void *cpu_env, abi_long arg1, abi_long arg2,
+static inline abi_long do_bsd_mmap(CPUArchState *env, abi_long arg1, abi_long arg2,
     abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6, abi_long arg7,
     abi_long arg8)
 {
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         arg6 = arg7;
         arg7 = arg8;
     }
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index b1d4446ff1..7efc5b4c92 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef BSD_PROC_H_
-#define BSD_PROC_H_
+#ifndef BSD_PROC_H
+#define BSD_PROC_H
 
 #include <sys/resource.h>
 
@@ -19,7 +19,7 @@ extern int _getlogin(char*, int);
 int bsd_get_ncpu(void);
 
 /* exit(2) */
-static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
+static inline abi_long do_bsd_exit(CPUArchState *env, abi_long arg1)
 {
     gdb_exit(arg1);
     qemu_plugin_user_exit();
@@ -400,4 +400,4 @@ static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,
     return get_errno(setpriority(which, who, prio));
 }
 
-#endif /* !BSD_PROC_H_ */
+#endif /* !BSD_PROC_H */
diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index 0309036178..0a0cea5bb2 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -238,7 +238,7 @@ h2t_procctl_reaper_pidinfo(struct procctl_reaper_pidinfo *host_pi,
 }
 
 abi_long
-do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2, abi_ulong arg3,
+do_freebsd_procctl(CPUArchState *env, int idtype, abi_ulong arg2, abi_ulong arg3,
        abi_ulong arg4, abi_ulong arg5, abi_ulong arg6)
 {
     abi_long error = 0, target_rp_pids;
@@ -257,7 +257,7 @@ do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2, abi_ulong arg3,
 
 #if TARGET_ABI_BITS == 32
     /* See if we need to align the register pairs. */
-    if (regpairs_aligned(cpu_env)) {
+    if (regpairs_aligned(env)) {
         id = (id_t)target_arg64(arg3, arg4);
         target_cmd = (int)arg5;
         target_arg = arg6;
diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 1cf3c43de3..7a035f5481 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -68,7 +68,7 @@ static inline abi_long do_freebsd_wait4(abi_long arg1, abi_ulong target_status,
 }
 
 /* wait6(2) */
-static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,
+static inline abi_long do_freebsd_wait6(CPUArchState *env, abi_long idtype,
     abi_long id1, abi_long id2,
     abi_ulong target_status, abi_long options, abi_ulong target_wrusage,
     abi_ulong target_infop, abi_ulong pad1)
@@ -79,7 +79,7 @@ static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,
     siginfo_t info;
     void *p;
 
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         /* printf("shifting args\n"); */
         /* 64-bit id is aligned, so shift all the arguments over by one */
         id1 = id2;
@@ -173,7 +173,7 @@ static inline abi_long do_freebsd___setugid(abi_long arg1)
 }
 
 /* fork(2) */
-static inline abi_long do_freebsd_fork(void *cpu_env)
+static inline abi_long do_freebsd_fork(CPUArchState *env)
 {
     abi_long ret;
     abi_ulong child_flag;
@@ -183,7 +183,7 @@ static inline abi_long do_freebsd_fork(void *cpu_env)
     if (ret == 0) {
         /* child */
         child_flag = 1;
-        target_cpu_clone_regs(cpu_env, 0);
+        target_cpu_clone_regs(env, 0);
     } else {
         /* parent */
         child_flag = 0;
@@ -193,7 +193,7 @@ static inline abi_long do_freebsd_fork(void *cpu_env)
      * The fork system call sets a child flag in the second return
      * value: 0 for parent process, 1 for child process.
      */
-    set_second_rval(cpu_env, child_flag);
+    set_second_rval(env, child_flag);
 
     fork_end(ret);
 
@@ -201,13 +201,13 @@ static inline abi_long do_freebsd_fork(void *cpu_env)
 }
 
 /* vfork(2) */
-static inline abi_long do_freebsd_vfork(void *cpu_env)
+static inline abi_long do_freebsd_vfork(CPUArchState *env)
 {
-    return do_freebsd_fork(cpu_env);
+    return do_freebsd_fork(env);
 }
 
 /* rfork(2) */
-static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
+static inline abi_long do_freebsd_rfork(CPUArchState *env, abi_long flags)
 {
     abi_long ret;
     abi_ulong child_flag;
@@ -228,7 +228,7 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
     if (ret == 0) {
         /* child */
         child_flag = 1;
-        target_cpu_clone_regs(cpu_env, 0);
+        target_cpu_clone_regs(env, 0);
     } else {
         /* parent */
         child_flag = 0;
@@ -238,7 +238,7 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
      * The fork system call sets a child flag in the second return
      * value: 0 for parent process, 1 for child process.
      */
-    set_second_rval(cpu_env, child_flag);
+    set_second_rval(env, child_flag);
     fork_end(ret);
 
     return ret;
@@ -246,7 +246,7 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
 }
 
 /* pdfork(2) */
-static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
+static inline abi_long do_freebsd_pdfork(CPUArchState *env, abi_ulong target_fdp,
         abi_long flags)
 {
     abi_long ret;
@@ -258,7 +258,7 @@ static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
     if (ret == 0) {
         /* child */
         child_flag = 1;
-        target_cpu_clone_regs(cpu_env, 0);
+        target_cpu_clone_regs(env, 0);
     } else {
         /* parent */
         child_flag = 0;
@@ -271,7 +271,7 @@ static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
      * The fork system call sets a child flag in the second return
      * value: 0 for parent process, 1 for child process.
      */
-    set_second_rval(cpu_env, child_flag);
+    set_second_rval(env, child_flag);
     fork_end(ret);
 
     return ret;
diff --git a/bsd-user/freebsd/os-sys.c b/bsd-user/freebsd/os-sys.c
index df31706558..d6f7c92420 100644
--- a/bsd-user/freebsd/os-sys.c
+++ b/bsd-user/freebsd/os-sys.c
@@ -593,7 +593,7 @@ out:
 }
 
 /* sysarch() is architecture dependent. */
-abi_long do_freebsd_sysarch(void *cpu_env, abi_long arg1, abi_long arg2)
+abi_long do_freebsd_sysarch(CPUArchState *env, abi_long arg1, abi_long arg2)
 {
-    return do_freebsd_arch_sysarch(cpu_env, arg1, arg2);
+    return do_freebsd_arch_sysarch(env, arg1, arg2);
 }
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 90ef1bd916..d402c64726 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -215,7 +215,7 @@ void unlock_iovec(struct iovec *vec, abi_ulong target_addr,
 /*
  * All errnos that freebsd_syscall() returns must be -TARGET_<errcode>.
  */
-static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
+static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
                                 abi_long arg2, abi_long arg3, abi_long arg4,
                                 abi_long arg5, abi_long arg6, abi_long arg7,
                                 abi_long arg8)
@@ -227,19 +227,19 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
          * process system calls
          */
     case TARGET_FREEBSD_NR_fork: /* fork(2) */
-        ret = do_freebsd_fork(cpu_env);
+        ret = do_freebsd_fork(env);
         break;
 
     case TARGET_FREEBSD_NR_vfork: /* vfork(2) */
-        ret = do_freebsd_vfork(cpu_env);
+        ret = do_freebsd_vfork(env);
         break;
 
     case TARGET_FREEBSD_NR_rfork: /* rfork(2) */
-        ret = do_freebsd_rfork(cpu_env, arg1);
+        ret = do_freebsd_rfork(env, arg1);
         break;
 
     case TARGET_FREEBSD_NR_pdfork: /* pdfork(2) */
-        ret = do_freebsd_pdfork(cpu_env, arg1, arg2);
+        ret = do_freebsd_pdfork(env, arg1, arg2);
         break;
 
     case TARGET_FREEBSD_NR_execve: /* execve(2) */
@@ -255,12 +255,12 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_wait6: /* wait6(2) */
-        ret = do_freebsd_wait6(cpu_env, arg1, arg2, arg3,
+        ret = do_freebsd_wait6(env, arg1, arg2, arg3,
                                arg4, arg5, arg6, arg7, arg8);
         break;
 
     case TARGET_FREEBSD_NR_exit: /* exit(2) */
-        ret = do_bsd_exit(cpu_env, arg1);
+        ret = do_bsd_exit(env, arg1);
         break;
 
     case TARGET_FREEBSD_NR_getgroups: /* getgroups(2) */
@@ -424,7 +424,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_procctl: /* procctl(2) */
-        ret = do_freebsd_procctl(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_freebsd_procctl(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
         /*
@@ -435,7 +435,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_pread: /* pread(2) */
-        ret = do_bsd_pread(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_bsd_pread(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_readv: /* readv(2) */
@@ -443,7 +443,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_preadv: /* preadv(2) */
-        ret = do_bsd_preadv(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_bsd_preadv(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_write: /* write(2) */
@@ -451,7 +451,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_pwrite: /* pwrite(2) */
-        ret = do_bsd_pwrite(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_bsd_pwrite(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_writev: /* writev(2) */
@@ -459,7 +459,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_pwritev: /* pwritev(2) */
-        ret = do_bsd_pwritev(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_bsd_pwritev(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_open: /* open(2) */
@@ -559,11 +559,11 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_truncate: /* truncate(2) */
-        ret = do_bsd_truncate(cpu_env, arg1, arg2, arg3, arg4);
+        ret = do_bsd_truncate(env, arg1, arg2, arg3, arg4);
         break;
 
     case TARGET_FREEBSD_NR_ftruncate: /* ftruncate(2) */
-        ret = do_bsd_ftruncate(cpu_env, arg1, arg2, arg3, arg4);
+        ret = do_bsd_ftruncate(env, arg1, arg2, arg3, arg4);
         break;
 
     case TARGET_FREEBSD_NR_acct: /* acct(2) */
@@ -595,7 +595,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_readlink: /* readlink(2) */
-        ret = do_bsd_readlink(cpu_env, arg1, arg2, arg3);
+        ret = do_bsd_readlink(env, arg1, arg2, arg3);
         break;
 
     case TARGET_FREEBSD_NR_readlinkat: /* readlinkat(2) */
@@ -627,7 +627,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_mknodat: /* mknodat(2) */
-        ret = do_bsd_mknodat(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_bsd_mknodat(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_chown: /* chown(2) */
@@ -807,7 +807,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
          * Memory management system calls.
          */
     case TARGET_FREEBSD_NR_mmap: /* mmap(2) */
-        ret = do_bsd_mmap(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
+        ret = do_bsd_mmap(env, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
                           arg8);
         break;
 
@@ -953,15 +953,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
          * sys{ctl, arch, call}
          */
     case TARGET_FREEBSD_NR___sysctl: /* sysctl(3) */
-        ret = do_freebsd_sysctl(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_freebsd_sysctl(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR___sysctlbyname: /* sysctlbyname(2) */
-        ret = do_freebsd_sysctlbyname(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_freebsd_sysctlbyname(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_sysarch: /* sysarch(2) */
-        ret = do_freebsd_sysarch(cpu_env, arg1, arg2);
+        ret = do_freebsd_sysarch(env, arg1, arg2);
         break;
 
     default:
@@ -979,7 +979,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
  * as a wrapper around freebsd_syscall() so that actually happens. Since
  * that is a singleton, modern compilers will inline it anyway...
  */
-abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
+abi_long do_freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
                             abi_long arg2, abi_long arg3, abi_long arg4,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8)
@@ -990,7 +990,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
-    ret = freebsd_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6,
+    ret = freebsd_syscall(env, num, arg1, arg2, arg3, arg4, arg5, arg6,
                           arg7, arg8);
     if (do_strace) {
         print_freebsd_syscall_ret(num, ret);
diff --git a/bsd-user/i386/target.h b/bsd-user/i386/target.h
index ddd3b8ec08..9cd158fc11 100644
--- a/bsd-user/i386/target.h
+++ b/bsd-user/i386/target.h
@@ -12,7 +12,7 @@
 /*
  * i386 doesn't 'lump' the registers for 64-bit args.
  */
-static inline bool regpairs_aligned(void *cpu_env)
+static inline bool regpairs_aligned(CPUArchState *env)
 {
     return false;
 }
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index b0b2c249fb..60d1adf560 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -176,7 +176,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 void target_set_brk(abi_ulong new_brk);
 abi_long do_brk(abi_ulong new_brk);
 void syscall_init(void);
-abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
+abi_long do_freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
                             abi_long arg2, abi_long arg3, abi_long arg4,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8);
@@ -238,7 +238,7 @@ int host_to_target_errno(int err);
 /* os-proc.c */
 abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
         abi_ulong guest_envp, int do_fexec);
-abi_long do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2,
+abi_long do_freebsd_procctl(CPUArchState *env, int idtype, abi_ulong arg2,
         abi_ulong arg3, abi_ulong arg4, abi_ulong arg5, abi_ulong arg6);
 
 /* os-sys.c */
@@ -247,7 +247,7 @@ abi_long do_freebsd_sysctl(CPUArchState *env, abi_ulong namep, int32_t namelen,
 abi_long do_freebsd_sysctlbyname(CPUArchState *env, abi_ulong namep,
         int32_t namelen, abi_ulong oldp, abi_ulong oldlenp, abi_ulong newp,
         abi_ulong newlen);
-abi_long do_freebsd_sysarch(void *cpu_env, abi_long arg1, abi_long arg2);
+abi_long do_freebsd_sysarch(CPUArchState *env, abi_long arg1, abi_long arg2);
 
 /* user access */
 
diff --git a/bsd-user/riscv/target.h b/bsd-user/riscv/target.h
index 036ddd185e..dc3e0be795 100644
--- a/bsd-user/riscv/target.h
+++ b/bsd-user/riscv/target.h
@@ -12,7 +12,7 @@
 /*
  * riscv64 ABI does not 'lump' the registers for 64-bit args.
  */
-static inline bool regpairs_aligned(void *cpu_env)
+static inline bool regpairs_aligned(CPUArchState *env)
 {
     return false;
 }
diff --git a/bsd-user/x86_64/target.h b/bsd-user/x86_64/target.h
index 0cf0e2a14a..fccfc593bd 100644
--- a/bsd-user/x86_64/target.h
+++ b/bsd-user/x86_64/target.h
@@ -12,7 +12,7 @@
 /*
  * x86 doesn't 'lump' the registers for 64-bit args, all args are 64 bits.
  */
-static inline bool regpairs_aligned(void *cpu_env)
+static inline bool regpairs_aligned(CPUArchState *env)
 {
     return false;
 }

-- 
2.55.0


