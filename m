Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC7DC87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 07:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufvx4-0001zJ-HL; Sun, 27 Jul 2025 03:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufvx0-0001dw-Ht
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:37:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufvww-0000RL-5l
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:37:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-23dea2e01e4so45360515ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 00:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753601857; x=1754206657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwjBPriEpgWCIREacLQj88BT3mZvJe6+6xfNZxOr24E=;
 b=zYt9Q5CCW/m4M7Ga2jxQBkki5nvuHPyzPxBpWBETQEpUoQvJUZ1leQmInirIG8Ql1a
 3+xW0Yfo1pSvutBCXFg6Dt2qMMvCWE4INvmlCEv5Re8rk/i4aw5aMrQOkLCUI2P683/+
 a0uniSG/eyb0rJOzvb6Rfeeyvupg9kV1o2sXOgxExfUDKB8Je/l1vSV6zI9iDbvVHJur
 gIkbPDGhLCFx2yYWAqkExECCB/btT8HFzTWfXAcMeH+KCEWKr4sTegAPa0roFzbEXmcI
 tfjdK8Uinzz8hh/SWrTGPDm7h2wgNm/g1xWZAA5FeV1IGQduYsahEYCv7YCBW4EGzuDP
 7S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753601857; x=1754206657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FwjBPriEpgWCIREacLQj88BT3mZvJe6+6xfNZxOr24E=;
 b=uexEaZ6s6A7MYyFbXV+4N2sKCm1G1sQp/dNmAO2/qlnSXjpnHljLRcebUzcX/LrQEY
 fYgMwA/qRIpkHZwOhbJ1XI9i18dOdVSQphk8Zv/QXgGiIjxzKVzL4jevdLdgvz6WuZh7
 MX8k2nj5EueQXkIyS9xyy2mTS6omZ0RUNCqslGuKSYhzklaZtnxcWN+Urn/Af2UFWyJb
 pS5M7u2OIDnl/ug32dcOYwjlaJtleguHmSzIsxIUlJfkYRFLcuWQPM+lqLk+t8Zo+4BM
 o4EwdYiWLoK8pC8dUWxnSge1BJA48ensxUh3EmNlpNwamaXeOX8tZbVI8wwzJdpkSGi2
 MmdQ==
X-Gm-Message-State: AOJu0Yyny8Cjd2OjBnAvUocqONcSRoS33PBgn7vV0XsxcioVN6qfbEsV
 Wj2j1wvu/+25NuK+Zw6ITDVnkySVv9vviin3IDPNjy/M3PQ5B3oVoSwEINz8XJOyxwrJ8ssY7CP
 EHjgc
X-Gm-Gg: ASbGncudgoazmbbQdh2mh7SDa8yppFc69GKjaBMOMmMf9fgUd3y+1+CN3Ycpb5h+HBR
 IlC2py95zWs/A0YQdzTBnLwoTP5W3yhvCjchy11qbnYDGZXccsU9yWXxmlwtpSVXKeoG17OUYYz
 5wO8kxIVcqwl/jQa6x+OzFYHOUzevQ0Pgmr4GF6UiUGSDrh0k9dZytLLxtvpZNQBVnLYXpoxk4C
 hXtgCgRuRkToPppQyuGsAQLj9V7H5EphOHn+t8jWkxeUu5q8avCrJs/TSBqjXzoddXHy+w41woy
 x9qFbG24XC5nyvXGu56FlVjClGUApxL3NYVLeIwQxjmfZ9xBQOB3tuZg9sU+3sC1eM1ZT+HmYkA
 Zz5ZveMQyfoBlLeTkqe9S9SmfvUoNLKzRAwroM6uMJ2jixqn4i0a/cAQQSmYgWPP/NzSFZHhUiA
 QN5CID0CxY2w==
X-Google-Smtp-Source: AGHT+IH+5EcNcoYgF2SEcA0x9UYDBNiANA4DfBKWYgvKmfslEc1uPXKfYWoA0ADI2iplK1TjxY88Pg==
X-Received: by 2002:a17:903:1b6d:b0:23e:ea0:63c0 with SMTP id
 d9443c01a7336-23fb30e5e90mr119623505ad.41.1753601856757; 
 Sun, 27 Jul 2025 00:37:36 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe327443sm29824635ad.44.2025.07.27.00.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 00:37:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 3/3] linux-user/aarch64: Support ZT_MAGIC signal frame record
Date: Sat, 26 Jul 2025 21:37:28 -1000
Message-ID: <20250727073728.82913-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727073728.82913-1-richard.henderson@linaro.org>
References: <20250727073728.82913-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250725175510.3864231-4-peter.maydell@linaro.org>
---
 linux-user/aarch64/signal.c | 93 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index f28ba80754..668353bbda 100644
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
@@ -424,6 +463,30 @@ static void target_restore_tpidr2_record(CPUARMState *env,
     __get_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
 }
 
+static bool target_restore_zt_record(CPUARMState *env,
+                                     struct target_zt_context *zt, int size,
+                                     int svcr)
+{
+    uint16_t nregs;
+    uint64_t *z;
+
+    if (!(FIELD_EX64(svcr, SVCR, ZA))) {
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
@@ -432,10 +495,12 @@ static int target_restore_sigframe(CPUARMState *env,
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
@@ -490,6 +555,15 @@ static int target_restore_sigframe(CPUARMState *env,
             tpidr2 = (struct target_tpidr2_context *)ctx;
             break;
 
+        case TARGET_ZT_MAGIC:
+            if (zt || size != TARGET_ZT_SIG_CONTEXT_SIZE(1) ||
+                !cpu_isar_feature(aa64_sme2, env_archcpu(env))) {
+                goto err;
+            }
+            zt = (struct target_zt_context *)ctx;
+            zt_size = size;
+            break;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 goto err;
@@ -530,6 +604,13 @@ static int target_restore_sigframe(CPUARMState *env,
     if (tpidr2) {
         target_restore_tpidr2_record(env, tpidr2);
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
@@ -602,7 +683,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                uc.tuc_mcontext.__reserved),
     };
     int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
-    int sve_size = 0, za_size = 0, tpidr2_size = 0;
+    int zt_ofs = 0;
+    int sve_size = 0, za_size = 0, tpidr2_size = 0, zt_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
     abi_ulong frame_addr, return_addr;
@@ -628,6 +710,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
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
@@ -682,6 +770,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     if (tpidr2_ofs) {
         target_setup_tpidr2_record((void *)frame + tpidr2_ofs, env);
     }
+    if (zt_ofs) {
+        target_setup_zt_record((void *)frame + zt_ofs, env, zt_size);
+    }
 
     /* Set up the stack frame for unwinding.  */
     fr = (void *)frame + fr_ofs;
-- 
2.43.0


