Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3A9CD4F56
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vr-0000l0-Mq; Mon, 18 May 2026 17:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vn-0000YS-TP
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:32 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vl-0000jM-SF
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:31 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso2865720a34.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139709; x=1779744509;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jGHnVuP8jIyMC8JIdhhrduGtNIGJ/j5NOLUiUoZFHBY=;
 b=CbAc9sex+D9krn9X3dayteBWGqRig1CYPKvv6NZwaYZig6QTMil/gkeBsBv7Sn10BW
 15SKYz30s6egvsVRgqhfToaWL+jTFcMhek/fL5ZyAghQ37bDdEOL7B2RN01ODGrY7rOc
 v1l0yXwwwdJHSs/Y2jpnbVtI9uZXFqKZCDvQHFC9l7PwU+sc+gP9N8xCmtioZJ7vm/Fk
 qffT1t4EmHMl+ZUZ5f9RD1+e8xoi0RHLW1s2Ld74IfC4z4VBpsQNbWIA38bta5ROMrOl
 7GO4Yzpxk7c0nwz6NVW0ewUifWjWMTroP7U3ujcnVR1PqlQrZCiVEglG5wMbV9Ghmutt
 8DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139709; x=1779744509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jGHnVuP8jIyMC8JIdhhrduGtNIGJ/j5NOLUiUoZFHBY=;
 b=nkq0YP1kbY+8CPqbP/LqtTac6e+e4lsKi5Bc+N9IakdG7DkdnO0u/yFYMXfq0V3ead
 ZzWCCnae43LbJ9/JgyMcy1e9zSLxrJIjfylkTar3zPD0H0uUsBTgcL+8GTdH7CZIYUFg
 GefS8h2WP6VWuoSUdnK8a4JAgAWYa5R/uUlaZ4Zz6uRngKoh6CwsK3t9LA4rw4F64qcg
 iqPs3Q8yPCqNzoj1/ktg3GWZajJ2Ty7d1HRCEVpQFSIAwuHi/yotwQWM7nhovpEgmgfo
 OL4MXlRietWLghIcu9Fvif9a3Di/lqO+oQU3DpA6E1gbl83zx9bUxaFrgCYkUsiSGqRs
 cvBg==
X-Gm-Message-State: AOJu0Yy2cKsKz69ityXbCZKw1+JqYX7fw8+BTwQeDyddVanwl9KLHZ3z
 2YhrJy922OS4Rn+Kt4fAqudB0Gi+1YQrXkV8heS0qnxsm64XajO15ywiLU7+2IILP0E=
X-Gm-Gg: Acq92OGQ8Z1HcjKxtvaBgkxnrcTrpxIZPO7NsHBIzJ+KS5aCzsCsASKm65/gZv41QHH
 sVIhrjspaUodABwz3e5qY4Raa+rgTNkECn/LfM2ItSNjY2kazJVWZGKWRGZuGud1FX7UmJYbLBu
 lcEGgkF8WqN3vJeS05JH3gzSC4iwXUl/wn/NNYBTICSLoC8jOhyH6c6K0OtCs5giOP3lpfjqt/A
 8fq1ScQ+JACatlGxZWZrJKGXSluaSuOMiTSnjmeB+2Mqgk1lGLncmuwsWW7psgH/CZwYZwO5PhD
 e1V/Z/68qqZUFuezIunIAILlJEYWffhgkFjE4Mh/Qg0IkzCB+7zfPnq21f9N3+IPfOcnu8Mnc7N
 r6C0xzeKrtPo/ERaqYtU83LmpuDj4Ag7s8KbLcN5LYu79SK2c9J/BiWqHcyKQade1p82+u//jLA
 Si3f3lrIedAQ==
X-Received: by 2002:a05:6830:3910:b0:7d7:4fc9:5204 with SMTP id
 46e09a7af769-7e4ea01a8bfmr11360487a34.2.1779139708849; 
 Mon, 18 May 2026 14:28:28 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:28 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:54 -0600
Subject: [PATCH v2 36/37] bsd-user: Add kmod, posix, and misc functions to
 os-misc.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-36-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Karim Taha <kariem.taha2.7@gmail.com>, Sean Bruno <sbruno@FreeBSD.org>, 
 Alexander Kabaev <kan@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8178; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=AEXzakBRiEw81OkCt4uOUOmVZS5H1ln6ibu6g6qBDME=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RJx7pk7hVDeU2lhpnTN4VKMgf9jk7AS2dT6
 bSJ6oQZL5yJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESQAKCRBsHNEofbAR
 AOPeEADhxq4TScRL/sJ26EKsajcDXL8ebRNBYXQRusjL6GOIv7j+WZ+wiHXL7Kw/zcr1/WYAd0s
 eG2bx8vtYZ800t6FCeXNQEAv2lW7QHecxA0EJEj4huEp0bvUcHOVGp1PcoiHqZVomjhNXiT4/iP
 puRYwrajr3tM7J3UkHSp2RG+zTLghIn4Ig1F0CEaBBy73miIu5mcr5onH8QjOMqzCDiLG81Cfs/
 tq03+J2wR+TSogDZRFF0t217TxLc5Xr4b3+D4BksKxzYsX2hctRyy+zbrGwJMZ3bI+LcjN5Hj2f
 XZZDIBtBXO4tmFFfB10uOmVe2rnDlwx5YN1Q3BNoNn2U4ZNasbrD3h3/DiMxWvDTVmDfggNSXcr
 YOlVMvJvvsV7WRm95G5PwamWBlZqjKVhxgXUh60WBJmfBNt8bzxmvMXGVWAY7CKWy5VC+FRS3tP
 VSOsB9vKdJb1s3sBsjhIiLxlsipK2kDGJnOhMQkdgL/gd+L13SmGoI2ALF2d9qDxfPP0d9sALM1
 cPhlsYwlh6yWoAC525B2Qpuf9E6yMOM5EEqn+bGjDsV4yxTpVnDb91XEefPAyzOoLMEewdkNh+Q
 K3W6kIkNGiWjuvVoOMW/CNB48EQ/ClmyqFG4I+oaMDud05FnLCDc1l1veLLhFKOUYp9csikLpqi
 I4nLz1qC/kotugA==
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

Complete os-misc.h with kernel module functions (modfnext, modfind,
kldload, kldunload, kldunloadf, kldfind, kldnext, kldstat,
kldfirstmod, kldsym), POSIX functions (posix_fallocate, posix_openpt),
getrandom, and kenv.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Alexander Kabaev <kan@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-misc.h | 274 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 274 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 74ed1d2f47..cc33d16abb 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -270,5 +270,279 @@ static inline abi_long do_freebsd_cpuset_setaffinity(cpulevel_t level,
  * care. Will reevaluate if examples are found that do matter.
  */
 
+/* modfnext(2) */
+static inline abi_long do_freebsd_modfnext(abi_long modid)
+{
+    return -TARGET_ENOENT;
+}
+
+/* modfind(2) */
+static inline abi_long do_freebsd_modfind(abi_ulong target_name)
+{
+    return -TARGET_ENOENT;
+}
+
+/* kldload(2) */
+static inline abi_long do_freebsd_kldload(abi_ulong target_name)
+{
+    return -TARGET_EPERM;
+}
+
+/* kldunload(2) */
+static inline abi_long do_freebsd_kldunload(abi_long fileid)
+{
+    return -TARGET_EPERM;
+}
+
+/* kldunloadf(2) */
+static inline abi_long do_freebsd_kldunloadf(abi_long fileid, abi_long flags)
+{
+    return -TARGET_EPERM;
+}
+
+/* kldfind(2) */
+static inline abi_long do_freebsd_kldfind(abi_ulong target_name)
+{
+    return -TARGET_ENOENT;
+}
+
+/* kldnext(2) */
+static inline abi_long do_freebsd_kldnext(abi_long fileid)
+{
+    return -TARGET_ENOENT;
+}
+
+
+/* kldstat(2) */
+static inline abi_long do_freebsd_kldstat(abi_long fileid,
+        abi_ulong target_stat)
+{
+    return -TARGET_ENOENT;
+}
+
+/* kldfirstmod(2) */
+static inline abi_long do_freebsd_kldfirstmod(abi_long fileid)
+{
+    return -TARGET_ENOENT;
+}
+
+/* kldsym(2) */
+static inline abi_long do_freebsd_kldsym(abi_long fileid, abi_long cmd,
+        abi_ulong target_data)
+{
+    return -TARGET_ENOENT;
+}
+
+/*
+ * New posix calls
+ */
+
+#if TARGET_ABI_BITS == 32
+static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
+{
+#ifdef TARGET_BIG_ENDIAN
+    return ((uint64_t)word0 << 32) | word1;
+#else
+    return ((uint64_t)word1 << 32) | word0;
+#endif
+}
+#else /* TARGET_ABI_BITS == 32 */
+static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
+{
+    return word0;
+}
+#endif /* TARGET_ABI_BITS != 32 */
+
+/* posix_fallocate(2) */
+static inline abi_long do_freebsd_posix_fallocate(abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
+{
+
+#if TARGET_ABI_BITS == 32
+    return get_errno(posix_fallocate(arg1, target_offset64(arg3, arg4),
+        target_offset64(arg5, arg6)));
+#else
+    return get_errno(posix_fallocate(arg1, arg2, arg3));
+#endif
+}
+
+/* posix_openpt(2) */
+static inline abi_long do_freebsd_posix_openpt(abi_long flags)
+{
+
+    return get_errno(posix_openpt(flags));
+}
+
+/*
+ * shm_open2 isn't exported, but the __sys_ alias is. We can use either for the
+ * static version, but to dynamically link we have to use the sys version.
+ */
+int __sys_shm_open2(const char *path, int flags, mode_t mode, int shmflags,
+    const char *);
+
+/* shm_open2(2) */
+static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
+    abi_long mode, abi_ulong shmflags, abi_ulong nameptr)
+{
+    int ret;
+    void *uname, *upath;
+
+    if (pathptr == (uintptr_t)SHM_ANON) {
+        upath = SHM_ANON;
+    } else {
+        upath = lock_user_string(pathptr);
+        if (upath == NULL) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    uname = NULL;
+    if (nameptr != 0) {
+        uname = lock_user_string(nameptr);
+        if (uname == NULL) {
+            unlock_user(upath, pathptr, 0);
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(__sys_shm_open2(upath,
+                target_to_host_bitmask(flags, fcntl_flags_tbl), mode,
+                target_to_host_bitmask(shmflags, shmflag_flags_tbl), uname));
+
+    if (upath != SHM_ANON) {
+        unlock_user(upath, pathptr, 0);
+    }
+    if (uname != NULL) {
+        unlock_user(uname, nameptr, 0);
+    }
+    return ret;
+}
+
+/* shm_rename(2) */
+static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
+        abi_ulong flags)
+{
+    int ret;
+    void *ufrom, *uto;
+
+    ufrom = lock_user_string(fromptr);
+    if (ufrom == NULL) {
+        return -TARGET_EFAULT;
+    }
+    uto = lock_user_string(toptr);
+    if (uto == NULL) {
+        unlock_user(ufrom, fromptr, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_rename(ufrom, uto, flags));
+    unlock_user(ufrom, fromptr, 0);
+    unlock_user(uto, toptr, 0);
+
+    return ret;
+}
+
+#if defined(CONFIG_GETRANDOM)
+static inline abi_long do_freebsd_getrandom(abi_ulong buf, abi_ulong buflen,
+        abi_ulong flags)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user(VERIFY_WRITE, buf, buflen, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getrandom(p, buflen, flags));
+    unlock_user(p, buf, ret);
+
+    return ret;
+}
+#endif
+
+static inline abi_long do_freebsd_kenv(abi_long action, abi_ulong name,
+    abi_ulong value, abi_long len)
+{
+    abi_long ret;
+    void *gname = NULL;         /* unlocked in cases where set */
+    void *gvalue = NULL;        /* unlocked in cases where set */
+
+    ret = -TARGET_EINVAL;
+    switch (action) {
+    case KENV_GET:
+        gname = lock_user_string(name);
+        if (gname == NULL) {
+            ret = -TARGET_EFAULT;
+            break;
+        }
+        gvalue = lock_user(VERIFY_WRITE, value, len, 0);
+        if (gvalue == NULL) {
+            ret = -TARGET_EFAULT;
+            break;
+        }
+        ret = get_errno(kenv(action, gname, gvalue, len));
+        if (ret > 0) {
+            len = ret;
+        } else {
+            len = 0;
+        }
+        break;
+    case KENV_SET:
+        gname = lock_user_string(name);
+        if (gname == NULL) {
+            ret = -TARGET_EFAULT;
+            break;
+        }
+        gvalue = lock_user(VERIFY_READ, value, len, 1);
+        if (gvalue == NULL) {
+            ret = -TARGET_EFAULT;
+            break;
+        }
+        ret = get_errno(kenv(action, gname, gvalue, len));
+        unlock_user(gvalue, value, 0);
+        gvalue = NULL;
+        break;
+    case KENV_UNSET:
+        gname = lock_user_string(name);
+        if (gname == NULL) {
+            ret = -TARGET_EFAULT;
+            break;
+        }
+        /* value and name ignored, per kenv(2) */
+        ret = get_errno(kenv(action, gname, NULL, 0));
+        break;
+    /* All three treated the same */
+    case KENV_DUMP:
+    case KENV_DUMP_LOADER:
+    case KENV_DUMP_STATIC:
+        /* value == NULL -> just return length */
+        if (value != 0) {
+            gvalue = lock_user(VERIFY_WRITE, value, len, 0);
+            if (gvalue == NULL) {
+                ret = -TARGET_EFAULT;
+                break;
+            }
+        }
+        /* name is ignored, per kenv(2) */
+        ret = get_errno(kenv(action, NULL, gvalue, len));
+        if (ret > 0) {
+            len = ret;
+        } else {
+            len = 0;
+        }
+        break;
+    default:
+        ret = -TARGET_EINVAL;
+        break;
+    }
+
+    /* Unmap everything mapped */
+    if (gvalue != NULL) {
+        unlock_user(gvalue, value, len);
+    }
+    if (gname != NULL) {
+        unlock_user(gname, name, 0);
+    }
+
+    return ret;
+}
 
 #endif /* OS_MISC_H */

-- 
2.52.0


