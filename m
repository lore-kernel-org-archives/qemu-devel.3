Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E580CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxd-0002RX-7m; Fri, 15 May 2026 17:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxb-0002Kr-3y
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:43 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxZ-000349-2O
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:42 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso289717a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880040; x=1779484840;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IrMMoabXD1vDy5mBiaoVZ3/U9UO0LZTkgVKpr6QcPFs=;
 b=Ru0dn+RYYcuXS6RZUTNbK8HeFcE/cTTEV0I052gsg5w5xbLItyoP2wZlqkpBVhXeUO
 b/+P/kdq5hT6Vfcy07HCcby79T0qiSZr/kND9rDgTAHDZmrE3MaMJN778wIg8AN/T9rz
 soudX2Q+gf/Xywqv+jTym+FKSi51cfQ8wBV8574bRY+0skY71nILAV5uD++Qh84h9vpl
 LE73sLvLdiYi7tU+WUAMZ9XLyc4jWbeuc1pBON47msCHqk+dMVX9TyI/LKaU9XVtGGfb
 EsYJJLU8cosQDJzqBiPFrTmqSw/+iyKLYOShNR2f/PVKLrLiKAy3TUeIj2Wgrfjh1VDm
 xMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880040; x=1779484840;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IrMMoabXD1vDy5mBiaoVZ3/U9UO0LZTkgVKpr6QcPFs=;
 b=ik2ALQK/34nJoBnMYo2d9KaBPP4JS0sLmEryZ3FFM+pTUiB/UW7C/j+BSj5MXTqeA3
 1KGnUDm9vg+c9Nd5BDNpdvwcfiGl3kFAqojsKOVjCae+oJvibZD0E7enAAlxKaHESVrN
 ebE4iQYoMDHrzdGEJPkxBWszCw78vLASxghazO1VMcH9wMiI8q+WMGS/9DF7UnLosSID
 G04AAV8WDQmr/3BG7UlgauBUfY4Kmmu/hZjaBJsltB0Da/HoP0qhuDlCiPGpwf3XBqdG
 TSb+uOwktZ7kOzvyqEmm7dgS4j2a6ch5WBjApfldvGm9tT0+UI4X0ZgXXDMzn5HDHGn9
 HQ+w==
X-Gm-Message-State: AOJu0YyJAHTFpP8WMq+jxU7nvf6FG5WPMMp7JKFjqAEQ3fh+7/qkV1wY
 lvQ7Y1dUuxhdzDNJTcYKfPzwxqTufnS9K6fKm/M90zt6sCrfHTURZaq8gJaDvPHgkT4=
X-Gm-Gg: Acq92OGUxi+X1wuJF8TAhhKWTAoBJgQeV/ZPh2q3eseXovYRqGOrsoZswo1EH5yxuZ3
 kNZp7xCbAsEbFAPxDFd3+it+CNv9ieTWXpfwKiqRIA/DcV2VJz8jm4z0ZRKUoT+YqlKYRfU4yEY
 5mHVSD5h76/fs5byeuUY07AtvxH1ZJTTayvoT21CsP+YUgtACfGZvTLzLajGXqQwX4rzt5d+daD
 21UINzkNAUokQutfbIN3l15XHvdk+By+ycbXV6p9swm73+ORUfA0Q9ETGBXoDWDl4lQ1lx/E5AU
 1Wd7pX64UiCJjGQmJnugq0l8ibSduruLuMPu9QTl3Tz9uSWRS0ce3onZFmlHKCwS+q7dnBHXHNo
 /7TNLc0+193fIzFpyAGEl+tSN58OmpdNibJhoZEnCrdPkKsZPqgtUYs9mVWAXf6lr/i1vu2yZLo
 y/633cgMpDR3WtbTqvVFEk
X-Received: by 2002:a05:6830:3697:b0:7dc:c4ae:a66f with SMTP id
 46e09a7af769-7e4ea19ab40mr4059602a34.7.1778880039975; 
 Fri, 15 May 2026 14:20:39 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:35 -0600
Subject: [PATCH 36/66] bsd-user: Add kmod, posix, and misc functions to
 os-misc.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-36-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Karim Taha <kariem.taha2.7@gmail.com>, Sean Bruno <sbruno@FreeBSD.org>, 
 Alexander Kabaev <kan@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7992; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=GtRJkZ1PLy4FUdfDIt1tXU3qtIhL7bL9aQtGKWWJegw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43l57CJdo10+ghFVSZd3CHGF5Ldw4yjzmrkv
 qf/fXo9MPOJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5QAKCRBsHNEofbAR
 AKp5D/47K3s5gD7E4kz8R1V14kGT374oOWNs+VKwC//UZamULGseWw8lPrXXXnUsOm9ZQm/OBdt
 Z0s7USqhk1E3ztqEAVU0KZauG298nGwB0u/BFUvHvHBknntI1lMUjnsUEt9i7jeRyMp52UNGP0r
 eRvuH3PD8nVupc0DdK9SEW8csCCJH2FjJcKwwRdLjRX1+HkrByVDbdW8RBsimgZSqBfGNR1w+9r
 MvX8mNQf4R6bIHdIQzeHAkT7nqf10rLGBA9rjhhskyu3qryTWwKD9vxOBI/oXHWivD1jg8pX3oT
 mED2+m2cCkesX6ncccd2daI8BI4M3CxyKmtLHXI0jPWpqiWei5pC2v/b6RyhoUkWCPzog9qV7p9
 NqVt8/UZHnlDZS0k3oxAuJZzkHEFavKU/1UqIeiQFoKL0Y6Jg3UnBDQPsU04I6fQFwZs7YaI42a
 FpnePIKzb0kje7/MRTOUDrOvuHaVdU43mr9hF9Y3+E9qvUJCqJQ34Kwqd8lHnwUHW7QYjvzlYG3
 kau/0AtYNuDw2utK+SpPmhmFLyVoImAYKxYV3/H3LfJ6CGaA5Rbf0BeYWrn1CD8i9Fx+yPl+11H
 YQe+3Tv/Ocr9/CFEkJnAobPPfAxBjKaT0EE1RQpoPH5IDK5D2wx138FLYsHIXK3dTZBpm9U1vN0
 6v/A1Ln7XMv1Yxg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
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
 bsd-user/freebsd/os-misc.h | 268 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 268 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 74ed1d2f47..7ee903a5ba 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -270,5 +270,273 @@ static inline abi_long do_freebsd_cpuset_setaffinity(cpulevel_t level,
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
+        ret = kenv(action, gname, gvalue, len);
+        if (ret > 0) {
+                len = ret;
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
+        ret = kenv(action, gname, gvalue, len);
+        break;
+    case KENV_UNSET:
+        gname = lock_user_string(name);
+        if (gname == NULL) {
+            ret = -TARGET_EFAULT;
+            break;
+        }
+        /* value and name ignored, per kenv(2) */
+        ret = kenv(action, gname, NULL, 0);
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
+        ret = kenv(action, NULL, gvalue, len);
+        if (ret > 0) {
+                len = ret;
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


