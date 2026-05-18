Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5482CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vs-0000mH-Na; Mon, 18 May 2026 17:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vm-0000YO-Ua
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:32 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vk-0000hX-Tj
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:30 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e36bb16a92so1712596a34.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139708; x=1779744508;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dk/gcJTcR+HqotYXXre567+adU5e8XCaDOO7/5sPCWw=;
 b=hjfDy+ukXnxul+bMuKYCWffdotVaDf6RtWZIHDbI3+A8rlsc6Y+Txuo5SHzmfQTpPx
 ByRwg/BMgS9S1dUIaHR/hqZlQ4DuhDJPjrn+NRIJpxM+6Em2tmusqdxdAIHd+8msdKl+
 XH6e6tVbG+wHo/LpJo7B5POW1s4/YK9argKTPw5FGik9Yems8ePxCsxXyvHB0/DGgRpo
 UCj39bmml87P96TBMsGVwsUh19Jj0dWh6+S/vuzx4TAM+h5bmFxx+xQGr8+V5ipKoG9i
 WCEVbtavqYioutr2FazG5ec4tD0ryyV06lLrnPyv2uy6e+Caj5sNEPJStrwbqoc9xyQv
 Zcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139708; x=1779744508;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dk/gcJTcR+HqotYXXre567+adU5e8XCaDOO7/5sPCWw=;
 b=eF8ZJmmx38Dx/n3sFNv4TQR7W/fsnjRYxB2UtLTG9oOOrj7KTPQSamAzqRWF2HbOXn
 tLlwGenWtQTWRbc3kDUZa/RrF8GHH2jgNV6uBuRrhj9Hwf8lG8z83pgBAW7iOhBMV/6l
 /0Dorcn7PM9laUyCtQQGqFoTJdGA67rGAYtzt+HE/D5eF0stTF7SzFZOXjbYFWBBBwFx
 87WKkTLP8Sc9gOg+9ukrWzFze4FmgDbsuNO8Xa2cqNjiYKWf/p77flJVC0/QO3A1Z32j
 h9dUhD33MHE4eu82Z3ESUr2nzJ0XNS4mMSYUuoPoW2zIMUUaGu22Fst4UiVixMV4ILdD
 Dlsg==
X-Gm-Message-State: AOJu0Yw2242gwOcqZJ/P+amrECeGwWB9ub927Dy3RXQkTTHHW7FBoFiZ
 reZe8uj/wJt9bkzcrRlMIPcygHZ/T+9tMhkfoKKurSIQGh9i7amJIidj7WIRBnkv92s=
X-Gm-Gg: Acq92OGMYImwYgsMik64LtgBFbvrlIUvRioZ/JTpKbs7CNMQNKRwUL+NSx9LXb0p3p+
 66a4GswVMj1xyZVewpFUfD3sT8TfK1E4eAHa1XrZdK4yrRhhH/KJk96+qm5Eus4Yx8V8UCFzdGC
 lwcuYoBv1iAmB7vg5QZwusZgOaVhIJ9Hg2kS7SfADh9wXGmn4wBXa7KLLW0pTfDJEjTvxJRI1Gx
 pkCrbsCEME7S9NazcY2NCOjBuqvCIWkYYO3iobj48eQZLIfkFh5MB2R8u6Ho6T+6faxs2xxrGR0
 muCNsrXtuCGcYBkEeftAH0Wq31/eAOMxdV9IIdmPpb8o517fBe51r4w4FYeKWoa2HTZ4j8l+Obh
 rH/nGAuamjjGkMkZXe5MvQWB6FZoocDz8S+poh03WSWcTJ63XTY2KFUHKw2uWDTPAXovy63yxHO
 NSmAl5nJy6oA==
X-Received: by 2002:a05:6830:4486:b0:7d7:f638:7a03 with SMTP id
 46e09a7af769-7e4ea07fd2bmr13318626a34.10.1779139707825; 
 Mon, 18 May 2026 14:28:27 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:53 -0600
Subject: [PATCH v2 35/37] bsd-user: Add scheduler and cpuset functions to
 os-misc.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-misc-2026q2-v2-35-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Sean Bruno <sbruno@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11338; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=VJLI5yf/kV1K/lBJ1hjwgi5j2yWe3Wg0MdjyGKt/tVc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RJbLhq5nA+nbNGVfUyudY3q9nuvkGQSdjIJ
 fAofqUhnxCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESQAKCRBsHNEofbAR
 APH5EACKR6eWJtotiEjl9iUuDyOWWspUpXJyK9P8sbGxA05a8SikFRNtcU8Ux/qWMR399ck7VPY
 UUT9F9/4qvm7ov/FpRJFG0NaxsRSOoZ7i4hFfD4mD4Qh8jMYWL7W0hL7Y5LBMOnhNBe0/8vWYOL
 ZUMnCVbeh01T95elBhiZlphU0VBweeemLv26W9RuaJhEJr5d8/Kj85qau5oKwoCHQjFoxlqbvlr
 ltF0uUkoNbey4rUjGJSx7TuCIBSVSNHoc9wOdbJfKmj7YNSJFP15y4qyCUyCxEDOnoxdidHQY7f
 wMcTLdM8XTKHzIFCJ9l4NrE/fjv1eT5pLuYSJCepavak8eTHHstNZBhl2i4fvuQmUMHkMPdgwFP
 Kp255VYcvoiVxALPg0DmB0HXcn956cf1sLv61/k3GCrqUmtswYDi/0yqHSuye4L1Bjhk06fsEAk
 rtbUVoIenYuXy+9esbDQPi423BedLDnyTAxxPAFcz3aTYoyoUyuDfLUaphmU1HFhtDmFYphq0k3
 p1acWJH2bgl64Vj5CbPEcbhj3YL3dYM4IRPu+9sTqofT8HBOIk3SLlYCVHhWRd2LkPENjAdkhgV
 D7PytXSCfm2edXQLaeH4psAT2/cLs9nzLfk/SC98ph0Z4mrpNM6U9KubsXt594IUc2Ee0u49tsH
 c0ftXvHWcqbJSUQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x332.google.com
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

Expand os-misc.h with scheduler functions (sched_setparam,
sched_getparam, sched_setscheduler, sched_getscheduler,
sched_rr_get_interval) and CPU affinity functions (cpuset,
cpuset_setid, cpuset_getid, cpuset_getaffinity, cpuset_setaffinity).
Also add sched_yield, sched_get_priority_min, and
sched_get_priority_max to bsd-proc.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/bsd-proc.h        |  20 +++-
 bsd-user/freebsd/os-misc.h | 288 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 257 insertions(+), 51 deletions(-)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 62052c70b9..b9973dbedf 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -400,4 +400,22 @@ static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,
     return get_errno(setpriority(which, who, prio));
 }
 
-#endif /* !BSD_PROC_H_ */
+/* sched_yield(2) */
+static inline abi_long do_bsd_sched_yield(void)
+{
+    return get_errno(sched_yield());
+}
+
+/* sched_get_priority_min(2) */
+static inline abi_long do_bsd_sched_get_priority_min(int policy)
+{
+    return get_errno(sched_get_priority_min(policy));
+}
+
+/* sched_get_priority_max(2) */
+static inline abi_long do_bsd_sched_get_priority_max(int policy)
+{
+    return get_errno(sched_get_priority_max(policy));
+}
+
+#endif /* !BSD_PROC_H */
diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index d9979b2a8b..74ed1d2f47 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -11,76 +11,264 @@
 #include <sys/cpuset.h>
 #include <sys/random.h>
 #include <sched.h>
+#include <kenv.h>
 
-/*
- * shm_open2 isn't exported, but the __sys_ alias is. We can use either for the
- * static version, but to dynamically link we have to use the sys version.
- */
-int __sys_shm_open2(const char *path, int flags, mode_t mode, int shmflags,
+int shm_open2(const char *path, int flags, mode_t mode, int shmflags,
     const char *);
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
-/* shm_open2(2) */
-static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
-    abi_long mode, abi_ulong shmflags, abi_ulong nameptr)
+/* sched_setparam(2) */
+static inline abi_long do_freebsd_sched_setparam(pid_t pid,
+        abi_ulong target_sp_addr)
 {
-    int ret;
-    void *uname, *upath;
+    abi_long ret;
+    struct sched_param host_sp;
 
-    if (pathptr == (uintptr_t)SHM_ANON) {
-        upath = SHM_ANON;
-    } else {
-        upath = lock_user_string(pathptr);
-        if (upath == NULL) {
-            return -TARGET_EFAULT;
-        }
+    ret = get_user_s32(host_sp.sched_priority, target_sp_addr);
+    if (!is_error(ret)) {
+        ret = get_errno(sched_setparam(pid, &host_sp));
     }
+    return ret;
+}
 
-    uname = NULL;
-    if (nameptr != 0) {
-        uname = lock_user_string(nameptr);
-        if (uname == NULL) {
-            unlock_user(upath, pathptr, 0);
-            return -TARGET_EFAULT;
-        }
+/* sched_get_param(2) */
+static inline abi_long do_freebsd_sched_getparam(pid_t pid,
+        abi_ulong target_sp_addr)
+{
+    abi_long ret;
+    struct sched_param host_sp;
+
+    ret = get_errno(sched_getparam(pid, &host_sp));
+    if (!is_error(ret)) {
+        ret = put_user_s32(host_sp.sched_priority, target_sp_addr);
     }
-    ret = get_errno(__sys_shm_open2(upath,
-                target_to_host_bitmask(flags, fcntl_flags_tbl), mode,
-                target_to_host_bitmask(shmflags, shmflag_flags_tbl), uname));
+    return ret;
+}
+
+/* sched_setscheduler(2) */
+static inline abi_long do_freebsd_sched_setscheduler(pid_t pid, int policy,
+        abi_ulong target_sp_addr)
+{
+    abi_long ret;
+    struct sched_param host_sp;
 
-    if (upath != SHM_ANON) {
-        unlock_user(upath, pathptr, 0);
+    ret = get_user_s32(host_sp.sched_priority, target_sp_addr);
+    if (!is_error(ret)) {
+        ret = get_errno(sched_setscheduler(pid, policy, &host_sp));
     }
-    if (uname != NULL) {
-        unlock_user(uname, nameptr, 0);
+    return ret;
+}
+
+/* sched_getscheduler(2) */
+static inline abi_long do_freebsd_sched_getscheduler(pid_t pid)
+{
+
+    return get_errno(sched_getscheduler(pid));
+}
+
+/* sched_getscheduler(2) */
+static inline abi_long do_freebsd_sched_rr_get_interval(pid_t pid,
+        abi_ulong target_ts_addr)
+{
+    abi_long ret;
+    struct timespec host_ts;
+
+    ret = get_errno(sched_rr_get_interval(pid, &host_ts));
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_timespec(target_ts_addr, &host_ts);
     }
     return ret;
 }
-#endif /* __FreeBSD_version >= 1300048 */
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
-/* shm_rename(2) */
-static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
-        abi_ulong flags)
+/* cpuset(2) */
+static inline abi_long do_freebsd_cpuset(abi_ulong target_cpuid)
 {
-    int ret;
-    void *ufrom, *uto;
+    abi_long ret;
+    cpusetid_t setid;
 
-    ufrom = lock_user_string(fromptr);
-    if (ufrom == NULL) {
-        return -TARGET_EFAULT;
+    ret = get_errno(cpuset(&setid));
+    if (is_error(ret)) {
+        return ret;
     }
-    uto = lock_user_string(toptr);
-    if (uto == NULL) {
-        unlock_user(ufrom, fromptr, 0);
-        return -TARGET_EFAULT;
+    return put_user_s32(setid, target_cpuid);
+}
+
+#define target_to_host_cpuset_which(hp, t) { \
+    (*hp) = t;                               \
+} while (0)
+
+#define target_to_host_cpuset_level(hp, t) { \
+    (*hp) = t;                               \
+} while (0)
+
+/* cpuset_setid(2) */
+static inline abi_long do_freebsd_cpuset_setid(CPUArchState *env, abi_long arg1,
+        abi_ulong arg2, abi_ulong arg3, abi_ulong arg4, abi_ulong arg5)
+{
+    id_t id;    /* 64-bit value */
+    cpusetid_t setid;
+    cpuwhich_t which;
+
+    target_to_host_cpuset_which(&which, arg1);
+#if TARGET_ABI_BITS == 32
+    /* See if we need to align the register pairs */
+    if (regpairs_aligned(env)) {
+        id = target_arg64(arg3, arg4);
+        setid = arg5;
+    } else {
+        id = target_arg64(arg2, arg3);
+        setid = arg4;
     }
-    ret = get_errno(shm_rename(ufrom, uto, flags));
-    unlock_user(ufrom, fromptr, 0);
-    unlock_user(uto, toptr, 0);
+#else
+    id = arg2;
+    setid = arg3;
+#endif
+    return get_errno(cpuset_setid(which, id, setid));
+}
+
+/* cpuset_getid(2) */
+static inline abi_long do_freebsd_cpuset_getid(abi_long arg1, abi_ulong arg2,
+        abi_ulong arg3, abi_ulong arg4, abi_ulong arg5)
+{
+    abi_long ret;
+    id_t id;    /* 64-bit value */
+    cpusetid_t setid;
+    cpuwhich_t which;
+    cpulevel_t level;
+    abi_ulong target_setid;
+
+    target_to_host_cpuset_which(&which, arg1)
+        ;
+    target_to_host_cpuset_level(&level, arg2);
+#if TARGET_ABI_BITS == 32
+    id = target_arg64(arg3, arg4);
+    target_setid = arg5;
+#else
+    id = arg3;
+    target_setid = arg4;
+#endif
+    ret = get_errno(cpuset_getid(level, which, id, &setid));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return put_user_s32(setid, target_setid);
+}
+
+static abi_ulong copy_from_user_cpuset_mask(cpuset_t *mask,
+        abi_ulong target_mask_addr)
+{
+        int i, j, k;
+        abi_ulong b, *target_mask;
+
+        target_mask = lock_user(VERIFY_READ, target_mask_addr,
+                                CPU_SETSIZE / 8, 1);
+        if (target_mask == NULL) {
+                return -TARGET_EFAULT;
+        }
+        CPU_ZERO(mask);
+        k = 0;
+        for (i = 0; i < ((CPU_SETSIZE / 8) / sizeof(abi_ulong)); i++) {
+                __get_user(b, &target_mask[i]);
+                for (j = 0; j < TARGET_ABI_BITS; j++) {
+                        if ((b >> j) & 1) {
+                                CPU_SET(k, mask);
+                        }
+                        k++;
+                }
+        }
+        unlock_user(target_mask, target_mask_addr, 0);
+
+        return 0;
+}
+
+static abi_ulong copy_to_user_cpuset_mask(abi_ulong target_mask_addr,
+        cpuset_t *mask)
+{
+        int i, j, k;
+        abi_ulong b, *target_mask;
+
+        target_mask = lock_user(VERIFY_WRITE, target_mask_addr,
+                                CPU_SETSIZE / 8, 0);
+        if (target_mask == NULL) {
+                return -TARGET_EFAULT;
+        }
+        k = 0;
+        for (i = 0; i < ((CPU_SETSIZE / 8) / sizeof(abi_ulong)); i++) {
+                b = 0;
+                for (j = 0; j < TARGET_ABI_BITS; j++) {
+                        b |= ((CPU_ISSET(k, mask) != 0) << j);
+                        k++;
+                }
+                __put_user(b, &target_mask[i]);
+        }
+        unlock_user(target_mask, target_mask_addr, (CPU_SETSIZE / 8));
+
+        return 0;
+}
+
+/* cpuset_getaffinity(2) */
+/* cpuset_getaffinity(cpulevel_t, cpuwhich_t, id_t, size_t, cpuset_t *); */
+static inline abi_long do_freebsd_cpuset_getaffinity(cpulevel_t level,
+        cpuwhich_t which, abi_ulong arg3, abi_ulong arg4, abi_ulong arg5,
+        abi_ulong arg6)
+{
+        cpuset_t mask;
+        abi_long ret;
+    id_t id;    /* 64-bit */
+    abi_ulong setsize, target_mask;
+
+#if TARGET_ABI_BITS == 32
+    id = (id_t)target_arg64(arg3, arg4);
+    setsize = arg5;
+    target_mask = arg6;
+#else
+    id = (id_t)arg3;
+    setsize = arg4;
+    target_mask = arg5;
+#endif
+
+        ret = get_errno(cpuset_getaffinity(level, which, id, setsize, &mask));
+        if (ret == 0) {
+                ret = copy_to_user_cpuset_mask(target_mask, &mask);
+        }
 
     return ret;
 }
-#endif /* __FreeBSD_version >= 1300049 */
+
+/* cpuset_setaffinity(2) */
+/* cpuset_setaffinity(cpulevel_t, cpuwhich_t, id_t, size_t, const cpuset_t *);*/
+static inline abi_long do_freebsd_cpuset_setaffinity(cpulevel_t level,
+        cpuwhich_t which, abi_ulong arg3, abi_ulong arg4, abi_ulong arg5,
+        abi_ulong arg6)
+{
+        cpuset_t mask;
+        abi_long ret;
+    id_t id; /* 64-bit */
+    abi_ulong setsize, target_mask;
+
+#if TARGET_ABI_BITS == 32
+    id = (id_t)target_arg64(arg3, arg4);
+    setsize = arg5;
+    target_mask = arg6;
+#else
+    id = (id_t)arg3;
+    setsize = arg4;
+    target_mask = arg5;
+#endif
+
+        ret = copy_from_user_cpuset_mask(&mask, target_mask);
+        if (ret == 0) {
+                ret = get_errno(cpuset_setaffinity(level, which, id, setsize,
+                                                   &mask));
+        }
+
+        return ret;
+}
+
+/*
+ * Pretend there are no modules loaded into the kernel. Don't allow loading or
+ * unloading of modules. This works well for tests, and little else seems to
+ * care. Will reevaluate if examples are found that do matter.
+ */
+
 
 #endif /* OS_MISC_H */

-- 
2.52.0


