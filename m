Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7D7CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxd-0002Ud-Kq; Fri, 15 May 2026 17:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxa-0002IA-C9
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:42 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxY-00033i-2e
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:42 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso292226a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880039; x=1779484839;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dk/gcJTcR+HqotYXXre567+adU5e8XCaDOO7/5sPCWw=;
 b=m9e4Nqx/nKMdoTZzmnU3HqmbROiKLoB3kYm/wpuSg51FamuUjd1ruzOMjtVtcv8GmS
 7Mp8jdwkMde6QTggCqbhz4LT0DlGfcM8OSPMtRUDmWIFkcjCtx3DnwurpXGsYf9esMVe
 RSP8ma/a8/6UDVrnhyIqaUav+S4E3rqjeG0LHK2NctOWGhrAWOD7C+0Y3EsKG2lvKHoU
 ZmWym3el7rnW4kbawRZmfFyV/foP52O9vYPMfQqXBoH5RvXYi2iB8EJaBzA0jGUSNexZ
 9zspB1uTx7PUGgCI2H7rD2ZqIw9lyeeR1vl+R+P76UTY3jWXfsxnCIKc1KDEx2qsQX71
 cHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880039; x=1779484839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dk/gcJTcR+HqotYXXre567+adU5e8XCaDOO7/5sPCWw=;
 b=MBZq1EkzdHud5JDw+sBGoi/qnu8o8AX+Cod0rgHJY35GCCpVf57Ocg3PLVmhs2kUoo
 wQypsuTnM16WK7jUXXFmANTteLulVWRtW+uyuTvuS8/onZh9JSYvdLDRDSDk7VpDd+ul
 7HzssP+Fas33pk1Za2yRHyoR1vm6MLqaI1Oiu4PPnYryg80eL0gSIhmQbL5TqEn4DohX
 Fu54rWfNz0G8PStAmvtrDMmfW3453P4NTMnD63XBV2E/Dy8+z52F1lpbZmZoYTcf4K4w
 vryaz9WDoUXJk5qahTvHoMs9q+43BtvoCN+Hrpn8TvsN8e4c7lugcORlKrXHbcEqnqcO
 zHBQ==
X-Gm-Message-State: AOJu0Yy+qHSTSRr0IbTlwVpWwG1kLhx/WB7m0eWq8+YkgVUggbExB6sX
 Zkvj1z34DfvLzTpu/uj4ln/Hx8CM/z2pWN87cjgPWuB1QvHiW5a5cMtgRHoyxJM/bzM=
X-Gm-Gg: Acq92OEe9/pYm5tGS5zkF7KqB4EmWk0hn5Gex3zourCnYX/RB4JyYmHdr3o6RSh7g1a
 opzOzTouam0Wft22Yx3wgNgyhizxBzXnLyUR/O/eHk17bsyLIr3CmhZzrKQrVKGjkEXs6EL67xp
 BnKfgHQigO/1cNiStgikj0JXdS4gqZmT06VTsLSbATK+pM86eMZ38NVZ5zjNxPpRaJutP2aeymP
 7PZfG7n8tfNmDzh3SZOBQbi+ilmrDaycxJH0NHBO+pMrgrELiURO8dtwnaTvhGS0H2GHn22gNjm
 A12rPVa0ZEZ35HDaW+apcYqbCcjykMXMRNFDTXBlsmSp3e+LD4pfdVcGRp0h/aYb/GDUbXJ/53z
 9tCLQC5x1uUHBw0IYNXwW5ZfLRLnwzIzXPORpwqjVRnsZ4+S2WR7EVs6peO3lM/P3U5nBVCJFq1
 Cg+IZ4LlmcCQ==
X-Received: by 2002:a05:6830:349e:b0:7d9:f50f:9691 with SMTP id
 46e09a7af769-7e4de6b026fmr4117542a34.0.1778880038783; 
 Fri, 15 May 2026 14:20:38 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:38 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:34 -0600
Subject: [PATCH 35/66] bsd-user: Add scheduler and cpuset functions to
 os-misc.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-misc-2026q2-v1-35-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Sean Bruno <sbruno@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11338; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=VJLI5yf/kV1K/lBJ1hjwgi5j2yWe3Wg0MdjyGKt/tVc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43lPMEjCGk6g5LBMPoxa+NX4dwXa02odDZ7N
 7ICLAELUOuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5QAKCRBsHNEofbAR
 AMezEADbqh4gADSJLo6riPGnGzFlsvfv9NFq1n50YtUiH4g1Nk5qERPO5KuNoMH4abpb8yOB5ny
 D5pkzQ4TtUt9xrXljzqma7LIhL7hb1AhKjB+wzPGHGZ4N3asvYsxxBRJO4VwLZAlfkRv8JzocdK
 NB/fQm26WW9dwjVwvx2ntIXiC+yr3v3Lw2vhqHrqHCEI/Tipf6lBrOAuxl//uStVVgivGcljCHK
 oaBGUr6jt36ZifB+EjIhyM6nJqZiAKeRYvq8IdAxLt3HB1Za+AOx31hS6YLe/upVjMzrlyEeOYo
 19R/ht0lLnXD7+yjrQTmIr+eGiz03jvHdNa9kmPxIbjXw6TK7QEJDINHskO2BEXP+35YPeQXlL0
 HVj8lio04Zdg6AbuaFVjBr7DS0wtQCO1E+b3/Ws93BuU0qe16CxOlazl0nSEjKlXtbNMCIT+4ob
 mXR6GUYJK0yS16wzx+2kUr/DisHBGJZKx/z4kCYB5V6BR+Aw3WsnAJrJUko1g1IPtBgk7VHaBLk
 Gm1R2le2ABUlOR02qP8JWyFYaXbxy0WN45mD3sbeCGWPWi6fkkuIlq9cCjrAYVyH+hSmoXYY7CG
 qfd0pGJzMHblv3vOxcc+g8opG5mlOrqE3pMcZ4xegDamGbxOavFv1GTuiy8+L4vrmweicZMq8Rr
 IJ4gEDmGFgLOoDA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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


