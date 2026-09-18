Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C94C982D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAk-0005nn-4t; Fri, 18 Sep 2026 00:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAh-0005mp-J7
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:59 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAf-0004Pu-4C
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:59 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0d1779dso211144a34.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705556; x=1790310356;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+NBXimqoQQ0eySg4SRX2YtJiiePOn19fFAO959rW4UE=;
 b=hVvdyaAglxdBclV6v3A9PlZiO7fSKQNtLkew/h2WAITSwS5UD1/qrBE3nmXLxDakKu
 OJkEMsOqwT3Tv9zrIln9ZQsr6lyrGmTRr7pZg1Ct6B/c5rjT4sapGtoQVNbPhU+EBV6d
 GXMTpHpyV4JLM90izX1j0k5EOC4GEL40hxZO96nW+SS53IyalbVtx+y18UW+aaa2fGlN
 L7N29+PDfwVMCPinKtGaNAl6kXuOB2TBoS3Dw8P6Je2pAqRU2liOgh0iRT1Md4rm9zHR
 WpQxG3GgQzZ6Hdf1n4vqrDOSNoxMujlJK1aN6dJpZ5hhnfvZqjvnVclgDP00DycRTRHO
 c+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705556; x=1790310356;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+NBXimqoQQ0eySg4SRX2YtJiiePOn19fFAO959rW4UE=;
 b=xAA4k6f6N5LLK0eQ6YF7wMwSI5q572L03lAtKBeNUPzwyiNKITC2Jve1f5r5MQeSnG
 /DTOl8foOqNAFg/VCzZ/Gj4qWRDij+TkKGfAmicWPs5ImftrWqeklNp5u/DxflQdMSAI
 rfa33eql9oujh2JsoeKNq/W3Z2ZPewUswFVsfnXnIEoo5YSkARxzAJIsmaZyZZNq/Vj2
 KhoLT9FzwiVQ/MTm5J8tiNgTT5I5nselWo4q8s2Dske0zg5zr65wt/nG610eGaIiQeoq
 QezzBXflgcdRGZeicvjAsUeVWOJLYJA2sjrTMHi1E/yuVacZb/IAiKqL6ya4kpQ+yda0
 mLvA==
X-Gm-Message-State: AFuF++kzwYndTUaC78xg49OjL6CaczVKbvO2Jg8WfOCElW8dAxwwqDzY
 SLmobt33O7Sw1xq2lUGCv4jaR73O2Dx6xx+4ZipLs57BleP3xAupl9GrMHNpe7rFsO2ckwEXw5C
 Vxtukn7s=
X-Gm-Gg: AYBFou3mop/Fu465DUOQ/l9LZi6i2GWvQDBEI0bhvXfUHjCzJjbSUCwVhTkFYT5nl/d
 zF2Q04DOtOPHmQnE+tjtb/yiR3Yx0YKu1YpSzeAyRw7UPNxFHBfuXgB+z8EYDqXXXAap+unRm+j
 WQZRtgh2UHoOTbBNaM19oati6DIE/MDVTXIcmhu+GnqSHYOZUIk+FZH5O5joUXIqSoWN63pzyGC
 cysrgBtIhzius5+HxTcXlyFUJAuJ+rO2myMgbHaBQ/qs9KYowtrAMHWV2D9VI5fQ6D8Ev9Nc3TI
 PzH7leR4rCofkjIcrjBxoprAK0ITsuhjCpEt9mPWbntJF/wZlX1gh3ao7Kq330pi4soJC+ice6e
 GSuoD9EpdNfrmGUibmP5feLzy7KPRqihUnw/De+FrMVKDWyCzvfTefdSGuPcAckNp/SPSQmiRdI
 IzSUKgV9ooqpbNBNejBq0PlEagqvuUgdZJhFSc6+Ncls3beSzSvtehjvQTQw==
X-Received: by 2002:a05:6830:650a:b0:804:ca33:4aff with SMTP id
 46e09a7af769-80de0e50a9cmr1444819a34.9.1789705555802; 
 Thu, 17 Sep 2026 21:25:55 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:55 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>, Sean Bruno <sbruno@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 38/41] bsd-user: Add scheduler and cpuset functions to os-misc.h
Date: Thu, 17 Sep 2026 22:24:19 -0600
Message-ID: <20260918042422.38713-39-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.h        |  18 ++
 bsd-user/freebsd/os-misc.h | 466 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 480 insertions(+), 4 deletions(-)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 7efc5b4c92..b9973dbedf 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -400,4 +400,22 @@ static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,
     return get_errno(setpriority(which, who, prio));
 }
 
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
 #endif /* !BSD_PROC_H */
diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index d9979b2a8b..0f87b21cc8 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -11,6 +11,363 @@
 #include <sys/cpuset.h>
 #include <sys/random.h>
 #include <sched.h>
+#include <kenv.h>
+
+/* sched_setparam(2) */
+static inline abi_long do_freebsd_sched_setparam(pid_t pid,
+        abi_ulong target_sp_addr)
+{
+    abi_long ret;
+    struct sched_param host_sp;
+
+    ret = get_user_s32(host_sp.sched_priority, target_sp_addr);
+    if (!is_error(ret)) {
+        ret = get_errno(sched_setparam(pid, &host_sp));
+    }
+    return ret;
+}
+
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
+    }
+    return ret;
+}
+
+/* sched_setscheduler(2) */
+static inline abi_long do_freebsd_sched_setscheduler(pid_t pid, int policy,
+        abi_ulong target_sp_addr)
+{
+    abi_long ret;
+    struct sched_param host_sp;
+
+    ret = get_user_s32(host_sp.sched_priority, target_sp_addr);
+    if (!is_error(ret)) {
+        ret = get_errno(sched_setscheduler(pid, policy, &host_sp));
+    }
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
+/* sched_rr_get_interval(2) */
+static inline abi_long do_freebsd_sched_rr_get_interval(pid_t pid,
+        abi_ulong target_ts_addr)
+{
+    abi_long ret;
+    struct timespec host_ts;
+
+    ret = get_errno(sched_rr_get_interval(pid, &host_ts));
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_timespec(target_ts_addr, &host_ts);
+    }
+    return ret;
+}
+
+/* cpuset(2) */
+static inline abi_long do_freebsd_cpuset(abi_ulong target_cpuid)
+{
+    abi_long ret;
+    cpusetid_t setid;
+
+    ret = get_errno(cpuset(&setid));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return put_user_s32(setid, target_cpuid);
+}
+
+#define target_to_host_cpuset_which(hp, t) do { \
+    (*hp) = t;                               \
+} while (0)
+
+#define target_to_host_cpuset_level(hp, t) do { \
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
+    }
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
+    target_to_host_cpuset_which(&which, arg1);
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
+static abi_long copy_from_user_cpuset_mask(cpuset_t *mask,
+                                           abi_ulong target_mask_addr)
+{
+    int i, j, k;
+    abi_ulong b, *target_mask;
+
+    target_mask = lock_user(VERIFY_READ, target_mask_addr,
+                            CPU_SETSIZE / 8, 1);
+    if (target_mask == NULL) {
+        return -TARGET_EFAULT;
+    }
+    CPU_ZERO(mask);
+    k = 0;
+    for (i = 0; i < ((CPU_SETSIZE / 8) / sizeof(abi_ulong)); i++) {
+        __get_user(b, &target_mask[i]);
+        for (j = 0; j < TARGET_ABI_BITS; j++) {
+            if ((b >> j) & 1) {
+                CPU_SET(k, mask);
+            }
+            k++;
+        }
+    }
+    unlock_user(target_mask, target_mask_addr, 0);
+
+    return 0;
+}
+
+static abi_long copy_to_user_cpuset_mask(abi_ulong target_mask_addr,
+        cpuset_t *mask)
+{
+    int i, j, k;
+    abi_ulong b, *target_mask;
+
+    target_mask = lock_user(VERIFY_WRITE, target_mask_addr,
+                            CPU_SETSIZE / 8, 0);
+    if (target_mask == NULL) {
+        return -TARGET_EFAULT;
+    }
+    k = 0;
+    for (i = 0; i < ((CPU_SETSIZE / 8) / sizeof(abi_ulong)); i++) {
+        b = 0;
+        for (j = 0; j < TARGET_ABI_BITS; j++) {
+            b |= ((CPU_ISSET(k, mask) != 0) << j);
+            k++;
+        }
+        __put_user(b, &target_mask[i]);
+    }
+    unlock_user(target_mask, target_mask_addr, (CPU_SETSIZE / 8));
+
+    return 0;
+}
+
+/* cpuset_getaffinity(2) */
+/* cpuset_getaffinity(cpulevel_t, cpuwhich_t, id_t, size_t, cpuset_t *); */
+static inline abi_long do_freebsd_cpuset_getaffinity(cpulevel_t level,
+        cpuwhich_t which, abi_ulong arg3, abi_ulong arg4, abi_ulong arg5,
+        abi_ulong arg6)
+{
+    cpuset_t mask;
+    abi_long ret;
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
+    ret = get_errno(cpuset_getaffinity(level, which, id, setsize, &mask));
+    if (ret == 0) {
+        ret = copy_to_user_cpuset_mask(target_mask, &mask);
+    }
+
+    return ret;
+}
+
+/* cpuset_setaffinity(2) */
+/* cpuset_setaffinity(cpulevel_t, cpuwhich_t, id_t, size_t, const cpuset_t *);*/
+static inline abi_long do_freebsd_cpuset_setaffinity(cpulevel_t level,
+        cpuwhich_t which, abi_ulong arg3, abi_ulong arg4, abi_ulong arg5,
+        abi_ulong arg6)
+{
+    cpuset_t mask;
+    abi_long ret;
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
+    ret = copy_from_user_cpuset_mask(&mask, target_mask);
+    if (ret == 0) {
+        ret = get_errno(cpuset_setaffinity(level, which, id, setsize,
+                                           &mask));
+    }
+
+    return ret;
+}
+
+/*
+ * Pretend there are no modules loaded into the kernel. Don't allow loading or
+ * unloading of modules. This works well for tests, and little else seems to
+ * care. Will reevaluate if examples are found that do matter.
+ */
+
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
 
 /*
  * shm_open2 isn't exported, but the __sys_ alias is. We can use either for the
@@ -19,7 +376,6 @@
 int __sys_shm_open2(const char *path, int flags, mode_t mode, int shmflags,
     const char *);
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
 /* shm_open2(2) */
 static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
     abi_long mode, abi_ulong shmflags, abi_ulong nameptr)
@@ -56,9 +412,7 @@ static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
     }
     return ret;
 }
-#endif /* __FreeBSD_version >= 1300048 */
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
 /* shm_rename(2) */
 static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
         abi_ulong flags)
@@ -81,6 +435,110 @@ static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
 
     return ret;
 }
-#endif /* __FreeBSD_version >= 1300049 */
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
2.55.0


