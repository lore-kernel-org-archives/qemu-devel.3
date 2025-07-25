Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA02C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 14:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufJKI-0000ul-CC; Fri, 25 Jul 2025 10:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufJJy-0000Qm-Ni
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:22:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufJJw-0006Sa-0N
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:22:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so12472155e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753453366; x=1754058166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2eBTk096GXFEkw+GcPppkxQp95yxSxNKTxwnP4oO7Y=;
 b=bu4Vgt/oaeSyXmOgPbxSkAi+0xPDT/bQAUam/A/m5DoCOznD/nVNbgIbC0V9IEcZCg
 o3nc0X7fHI3/W9byikBRG6yze9jiV4N44lK0LzM6jxAABcKshnIt1LnmmssKy7OkGNkp
 mUK491I55igHzuB+15FkDTAdINB/byy9miH3FdIpEmI/2/dXknUlJIQ4D+B74hBU1YZH
 ekji0IqzhFjffTb8nlkBwTP11RrDPVgqQsBjubl6s4YjrahiiS/Hp9Vnbgr481E/AECj
 kdJ02sY9ksPRR2wQSIAxNqAywMeSgsQlH5xbfghIaEbBJAMyLG5imyKeoSkNnazcrBfK
 LMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753453366; x=1754058166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2eBTk096GXFEkw+GcPppkxQp95yxSxNKTxwnP4oO7Y=;
 b=YolVoxw55BIcDJUbA28Z2WNf+tN4m3xlfcbWCTpJx9OytaLIfuCbwE5NyhGFtjkuO5
 9hqYOS6ELtqKTPs9T8Re6P4Z91o9BKsb+dT065ufshjVi6aBBnEIXiL1jZ6zGNfqm2bh
 Lr++W7V2Mg6t+wtjjDazt7HwE7NBSOWG8doyuZE/eehOAMYTHSH/RY963SFZxtPLInvS
 Jy6YXumTeJDlVWupjeZ6omSaw1907eFwtWUZgQzq5+0N4e7q7jv9RZUzo+/XYn9HgUu+
 WTO3z9Dw4ubyz60LdZVE/SDYIo0ldbHdW66jfxpltm1vyyIw2PXj9NWjA3u50A3eHc1q
 N+4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeCePF7uabAsxn1SfWisE3xoECdpLZlY9ycB4oyy7rL9VQYoSxFxVcBVaOHpzLbsh+UmlwQTnPELwS@nongnu.org
X-Gm-Message-State: AOJu0Yx/stk32gvK175J590GM+Oj4WJIa76+YEb7S3eeGjpfyWjHWxO5
 XoD+L4h1AoJ5Da5LsO6AuxlmLCKc50YsWgxO6QNnQtC9qGYB5Rlhaa8E+EWHJPxx7iU=
X-Gm-Gg: ASbGnctMVjPCVYqrnMeuAODF8CLElTlWiQ3ql9KFEfzBzI3WIDQm8wSRguGwHsHusYr
 Ot+julR/Gn+Odrtwz01V4TAcD0LQLAqNjHfReM0vNQVTu2JBCe8SaAtH70P4UCn9jTQavVQqqi2
 l9l5xqs6yjzRbYZP9+6fk+l12hgnD9YemKXUCOOWkKpvUHcHXaIysTJZrQbvfexqPMiF33VVIMt
 7wt3Omsyr7j3oh+fJuCifPPBQbSE3ygmycOiomOk8dbfgrG3oslFdVzTYAIxMzuzG9YgXitiMOg
 uwHzqzq3UiDeGCWOpmt9LHorcQYxJQH44awZeoGfK2tv48JFSyE2XBFpQn+YG8SmAq0KTAy5+/z
 dZ+TjAAsW+uPxshSWu7SHqQF/Lbr5c25K7dA7+Xo=
X-Google-Smtp-Source: AGHT+IHp3pieLvso7pJYkfKAyuBH0TsE2ZQTP4tcU1UYaAc8tpAQrjDWKzRhQ6eh7+DASumN40qITw==
X-Received: by 2002:a05:600c:468a:b0:456:161c:3d6f with SMTP id
 5b1f17b1804b1-4587630558cmr19254605e9.11.1753453366311; 
 Fri, 25 Jul 2025 07:22:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778eb2bccsm67065f8f.7.2025.07.25.07.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 07:22:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH for-10.1 3/3] linux-user/aarch64: Support ZT_MAGIC signal
 frame record
Date: Fri, 25 Jul 2025 15:22:40 +0100
Message-ID: <20250725142240.3760452-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725142240.3760452-1-peter.maydell@linaro.org>
References: <20250725142240.3760452-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

FEAT_SME2 adds the ZT0 register, whose contents may need to be
preserved and restored on signal handler entry and exit.  This is
done with a new ZT_MAGIC record.  We forgot to implement support for
this in our linux-user code before enabling the SME2p1 emulation,
which meant that a signal handler using SME would corrupt the ZT0
register value, and code that attempted to unwind an exception from
inside a signal handler would not work.

Add the missing record handling.

Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/signal.c | 95 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index 9a903576add..943d63848cf 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -128,6 +128,23 @@ struct target_tpidr2_context {
     uint64_t tpidr2;
 };
 
+#define TARGET_ZT_MAGIC 0x5a544e01
+
+struct target_zt_context {
+    struct target_aarch64_ctx head;
+    uint16_t nregs;
+    uint16_t reserved[3];
+    /* ZTn register data immediately follows */
+};
+
+#define TARGET_ZT_SIG_REG_BYTES (512 / 8)
+#define TARGET_ZT_SIG_REGS_SIZE(n) (TARGET_ZT_SIG_REG_BYTES * (n))
+#define TARGET_ZT_SIG_CONTEXT_SIZE(n) (sizeof(struct target_zt_context) + \
+                                       TARGET_ZT_SIG_REGS_SIZE(n))
+#define TARGET_ZT_SIG_REGS_OFFSET sizeof(struct target_zt_context)
+QEMU_BUILD_BUG_ON(TARGET_ZT_SIG_REG_BYTES != \
+                  sizeof_field(CPUARMState, za_state.zt0));
+
 struct target_rt_sigframe {
     struct target_siginfo info;
     struct target_ucontext uc;
@@ -268,6 +285,28 @@ static void target_setup_tpidr2_record(struct target_tpidr2_context *tpidr2,
     __put_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
 }
 
+static void target_setup_zt_record(struct target_zt_context *zt,
+                                   CPUARMState *env, int size)
+{
+    uint64_t *z;
+
+    memset(zt, 0, sizeof(*zt));
+    __put_user(TARGET_ZT_MAGIC, &zt->head.magic);
+    __put_user(size, &zt->head.size);
+    /*
+     * The record format allows for multiple ZT regs, but
+     * currently there is only one, ZT0.
+     */
+    __put_user(1, &zt->nregs);
+    assert(size == TARGET_ZT_SIG_CONTEXT_SIZE(1));
+
+    /* ZT0 is the same byte-stream format as SVE regs and ZA */
+    z = (void *)zt + TARGET_ZT_SIG_REGS_OFFSET;
+    for (int i = 0; i < ARRAY_SIZE(env->za_state.zt0); i++) {
+        __put_user_e(env->za_state.zt0[i], z + i, le);
+    }
+}
+
 static void target_restore_general_frame(CPUARMState *env,
                                          struct target_rt_sigframe *sf)
 {
@@ -428,6 +467,33 @@ static bool target_restore_tpidr2_record(CPUARMState *env,
     return true;
 }
 
+static bool target_restore_zt_record(CPUARMState *env,
+                                     struct target_zt_context *zt, int size,
+                                     int svcr)
+{
+    uint16_t nregs;
+    uint64_t *z;
+
+    if (!cpu_isar_feature(aa64_sme2, env_archcpu(env))) {
+        return false;
+    }
+    if (!(FIELD_EX64(env->svcr, SVCR, ZA))) {
+        return false;
+    }
+
+    __get_user(nregs, &zt->nregs);
+
+    if (nregs != 1) {
+        return false;
+    }
+
+    z = (void *)zt + TARGET_ZT_SIG_REGS_OFFSET;
+    for (int i = 0; i < ARRAY_SIZE(env->za_state.zt0); i++) {
+        __get_user_e(env->za_state.zt0[i], z + i, le);
+    }
+    return true;
+}
+
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
@@ -436,10 +502,12 @@ static int target_restore_sigframe(CPUARMState *env,
     struct target_sve_context *sve = NULL;
     struct target_za_context *za = NULL;
     struct target_tpidr2_context *tpidr2 = NULL;
+    struct target_zt_context *zt = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
     int sve_size = 0;
     int za_size = 0;
+    int zt_size = 0;
     int svcr = 0;
 
     target_restore_general_frame(env, sf);
@@ -493,6 +561,14 @@ static int target_restore_sigframe(CPUARMState *env,
             tpidr2 = (struct target_tpidr2_context *)ctx;
             break;
 
+        case TARGET_ZT_MAGIC:
+            if (zt || size != TARGET_ZT_SIG_CONTEXT_SIZE(1)) {
+                goto err;
+            }
+            zt = (struct target_zt_context *)ctx;
+            zt_size = size;
+            break;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 goto err;
@@ -533,6 +609,13 @@ static int target_restore_sigframe(CPUARMState *env,
     if (tpidr2 && !target_restore_tpidr2_record(env, tpidr2)) {
         goto err;
     }
+    /*
+     * NB that we must restore ZT after ZA so the check that there's
+     * no ZT record if SVCR.ZA is 0 gets the right value of SVCR.
+     */
+    if (zt && !target_restore_zt_record(env, zt, zt_size, svcr)) {
+        goto err;
+    }
     if (env->svcr != svcr) {
         env->svcr = svcr;
         arm_rebuild_hflags(env);
@@ -605,7 +688,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                uc.tuc_mcontext.__reserved),
     };
     int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
-    int sve_size = 0, za_size = 0, tpidr2_size = 0;
+    int zt_ofs = 0;
+    int sve_size = 0, za_size = 0, tpidr2_size = 0, zt_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
     abi_ulong frame_addr, return_addr;
@@ -631,6 +715,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         }
         za_ofs = alloc_sigframe_space(za_size, &layout);
     }
+    if (cpu_isar_feature(aa64_sme2, env_archcpu(env)) &&
+        FIELD_EX64(env->svcr, SVCR, ZA)) {
+        /* If SME ZA storage is enabled, we must also save SME2 ZT0 */
+        zt_size = TARGET_ZT_SIG_CONTEXT_SIZE(1);
+        zt_ofs = alloc_sigframe_space(zt_size, &layout);
+    }
 
     if (layout.extra_ofs) {
         /* Reserve space for the extra end marker.  The standard end marker
@@ -686,6 +776,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         target_setup_tpidr2_record((void *)frame + tpidr2_ofs,
                                    env, tpidr2_size);
     }
+    if (zt_ofs) {
+        target_setup_zt_record((void *)frame + zt_ofs, env, zt_size);
+    }
 
     /* Set up the stack frame for unwinding.  */
     fr = (void *)frame + fr_ofs;
-- 
2.43.0


