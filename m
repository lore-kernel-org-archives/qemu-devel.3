Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B07C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThh-0005ZA-8g; Tue, 18 Aug 2026 19:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThf-0005LY-Lh
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:47 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThd-0005Km-0K
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:47 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4a45b3f0becso382110b6e.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097524; x=1787702324;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ckoly8ULlYNGScwbfNq6X6mcaiLluTXRydbAXzqO33c=;
 b=vxZER0g4oxXa+2MfDHKmzR6fNOxr0WCGYmtR/N3oOCP/jTvS2R2zeixjU8MRoDfJiq
 7hIMNJxpS9JdXjtlErjkRUKz+F5s6cfti22dQu4MdGwy1aOfXGvYTVQnOQBqshsC4sNk
 vvHORQXW+MJXWiKlmlCO0Og0JAI2qYsWbr+BPeeileOUZDAlaYdN63uP9E9rkKreIomH
 oGrxpvl9tLARFNNroPMzUhpizLScQqTeqQtDMq3weMtEe8qm+DRQdwDJIJbOgTDRtYMH
 71z50ilyNiT+78bgXRLbhYNZYizjZUr0lPfIgunATMbWNBVD0i63T239ImFuE/O5OSqz
 qZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097524; x=1787702324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ckoly8ULlYNGScwbfNq6X6mcaiLluTXRydbAXzqO33c=;
 b=XcwgFzzmonoZFkiBBmKfGdNctHqbXVDA3imiVdBQOxbC7gSQrVNKI1aYvFnwbvwDjo
 7EE0ZE9pnu37y4dY65mhmSQleLTnWOoVLVZQJqo2Nu6QxwN8IEuLy/G6mR64oeqEk3ql
 Lj2o00bv9ILhZKT0KPmFWX7WYop/QxufXqIiKMZkvKTZB3QWBKIepjzi4rcDdW/V2+41
 AZpGZ7eMRd1NoXcFqNuHSV5oKPWO88mqtezyvhWlY1vEGoVbOnO40lcMAaJbUGK/Yl1T
 +lvXINkdLKtY8O2hrfZhTgdnr4zTRsqlB+H5q81MCZIbIZl/uJdH8vo0jnTdmjFHB4iD
 4dLQ==
X-Gm-Message-State: AOJu0YylOyi+/0gMYcCGejsVAsPutwGqlWeV7fW3yzqCgzv17DLvNbDY
 pdG+4u90PMOpFzcxWSliyjqM+Gh+4R+8dHfRnuOaYw0fA9cd5dpUaHvvvXfxnr1N1EZOs7ikW+V
 SHtbItL8=
X-Gm-Gg: AR+sD10na7/rXN7O/LteXJLwSvM0AlHp/OWMi+8hQHa/gU1U0+CPfbfsVUCtN96e9Vw
 Cpzx80OsXOS4GGhBdp44F/lJHlAlcxgXuR/heeCq0QAuA9bhuGEBYBi/XenzgTWF6bphBdGFMcM
 BD5VYwSZQfp6hspKjLWCM2DzjDUEg5o7GUkk377d5F7EsvM/L+xfTExTEwi0qS0ajqsuEdnNhhM
 3pKpqP7Mq8cqa+Ktd3AZYm0+BNmP6S9hoXpH+R7lyuMX/UA7qYYy4IEOV7+1Yncm8MK51DhWtrK
 ZLd3jdzx6nw8OS/813/v+qs0Sq02IA/+eseog2SZa6pFGC6bcZm/m+XXp33uEgCcCWQfa52ow3e
 ZIsrWCGSKJyqZyZIevo8ZoXvQ5xr87pvRdPnB9RM2ErJ14O2GQq54jb65SqniZ3+ry30hYESsrJ
 y8WFetdP7fcVdoCB27s3/r5ia8In3tVPwb5Gf5RzpAEPXo4R4=
X-Received: by 2002:a05:6808:4fe7:b0:497:8f1:df07 with SMTP id
 5614622812f47-4b2bc93646dmr374420b6e.7.1787097523616; 
 Tue, 18 Aug 2026 16:58:43 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:30 -0600
Subject: [PATCH v4 37/40] bsd-user: Add scheduler and cpuset functions to
 os-misc.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-misc-2026q2-v4-37-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Sean Bruno <sbruno@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=15258; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=AxDWOGLGWgC02f8c6t0FDDSv6m8+unyeBX9qhUfmIYk=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFaVWLTt9dfqIj4VuKcFIpMvEQ0IucNJs07F
 UxI8oeAxeKJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxWhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBZ4w//TSPvdJbL1m5Tzs6ui31nv0wVGQiiDdi
 nVhRYygPre921FpZaR3RzpGL7xc+tfxSZVIDw7BEltGUDKlmPgx7nwvsJBAkwmEjaMvoeXCHTEo
 LPA+Z3ozt08NWsU6kpLVN6ajiJf6tJeJ63T3UH8CYw9BZKC7HfhQ0a/BBBMP4CVeikcXgVgTilA
 AvpaLyCQhM3XEnHHn1BaaBgM1Obfz3I2Fvj4JmGcjUJ0anOHdkwQRnFs6o7lGu+oDhQFlRwHbUk
 5eXUkTahiIRlEnCnxFTsReITkAqstde2PEgSg0GO/J+W/UvfTsxT+BdI3YdNFgl3Ire3ieIiL0S
 Ewqr+lbTXMbkzHlZogPhcblgWn3wceZqtVikUfi9sXWMzL+4Snig7weKNbJHQP5L9INmXBRqh/S
 /2ZSk7q+cenVviKcbceZeCfVULqFt8H7TukclobYX1rbwOZYc9MDLnH+jEFpXvmUDQQbYoPHiz1
 I6elIGO5tnz+0YUf/RwyTjhc9kG5Mog6x1w/oxHrzKHLkAGHJbEPuGcoEd4gUi03b6XM1GShiI2
 FyETMHfQsIuff9dzQTe4BYeqodroFOenz5rC5T3Nz1Xo0wt0qXrKO02w2k4cv10ehK+WTPI18a/
 pZhyGCNudkghln9Lv7cFDCUcVhX1oBbMwtF+rdj0Jgz2TSpfC0lI=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::233;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x233.google.com
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
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.h        |  18 ++
 bsd-user/freebsd/os-misc.h | 466 ++++++++++++++++++++++++++++++++++++++++++++-
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


