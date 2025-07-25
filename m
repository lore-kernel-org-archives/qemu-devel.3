Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E87C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 14:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufJKH-0000qP-Ha; Fri, 25 Jul 2025 10:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufJJx-0000QP-9R
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:22:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufJJv-0006Ry-2d
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:22:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b776d57656so639731f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753453365; x=1754058165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvG0fxUvz8Y62ReZMLVv2RqS5GQS2D6eRWB6o9INM7U=;
 b=TkbifmxVnGNctKutmms261OHM96jFnlne8IRJYCPotU8C/qBIsDrRc1EYk6ymYJ+vJ
 L8TN6m8n5ZPe1eyE9icCFnvmBw0zwmy772iLoyYlOvo7DEcTqr/q4HbmLvgSiLTqGB1Q
 Xdd8Eo/Ff4R/4e0DTqT2oKdZTsonYivFdfw3uXhxOy8DEOQwibIg6+c9Op8chtt7Mahb
 cV5tvZfhQBpL6UemUG73IocJMY7mYUjUR7aqaIWqtAEUaXKrDwf6ZhPHhf5CaugY/+k+
 Q/FeRuNWbzS/FRDBhjM+mTzNMGKCbtmuniOu9qzcnfkc+QvxsundpeFmW55TuT2Mkoev
 lWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753453365; x=1754058165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qvG0fxUvz8Y62ReZMLVv2RqS5GQS2D6eRWB6o9INM7U=;
 b=Q6yKD4oqeUsILcx+lJ/Y0sv3Uy0Ls7DAxzoEfP1dfEVWUmlMN97nB8BQVom8m8lRbr
 5dQ9+iNqKO1o4FV6OLgCCAhlfKS7Cxgx07O+EJkx18BAFawIZcv54Pl8BgYErPb4KhjS
 gLOVFXbcB4vP3rI0paPlk26R3ZVt2KO3Z+SU9J/Iu6eJxHj/xUbN/0J5yrVbdUmdtblU
 yI9hcq1nE+L6GhoLhtmePBOqTR4AknkchQEu6mJYEA/3ERufDLVmrGX2p/ULpDQuCnqc
 ISaQxYQ2qycyTfblRwhv8C6CJ4M6VERBrlYgenD81V+KZV0IThjCZdDnxHQL4g9D6rXi
 jK9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8ucVS04APO9oT1yWo4Hb3SOnsMK6dHlRb9ll1zYaXCwqh6KUMVCjJcRjRXqTHDsXXyNvUE/k5jtwQ@nongnu.org
X-Gm-Message-State: AOJu0YwFi7oQ3Wl7mXeQLjWAnch91VmrDinHMplCWq/GpdT9Ys34mQxi
 O59a0cZK25+5mLnu/JcE3SMwYEnR3ZicnRtLGJsyJP55uJDdxD2uyVfmJqZzjtzW0zI=
X-Gm-Gg: ASbGncvNCAmlAjqsdFj9FF55AYnmFyqNF3SNx0ccbhxfRgFL6vtVOgz1tsKC70dG1eu
 Z7DAN2DXWhnyGk60rZ32BVjFuNrq89mwiwmkXCKW+03eKSuJgEy+5CaTJA618o9bnRBfVb97DlL
 2yymFDdrS/HXjKuJ30wq+GaeHp7ACPa+/PDKA0bk+qGQr39rZpOQrtyIuElFC1+RRhlt/eBPNPR
 vevNCIhRzby7uMmK4MjW3YuxRtxgto2A8vhEdiDDVzWUyA94JpXy/FuF0xdnPUSqmPRW+hO2wVo
 knPtyLQ+rYRunXAn4YRscQytZY9/2xGgz7Q5rUa6pjTZfuV0xi2HG1y4nytwg0VYVIT2RleiRrV
 HLJiKGZix8ryPQA6kMDArc4EeA1+8ekWCyeqXp+A=
X-Google-Smtp-Source: AGHT+IGtNffQ0vrEuFFyrbMzAASfuzQ/HNGc4JPqRujCOqVLeMAa9cfR4GSR1lp1iqmqlNIiUBNIoQ==
X-Received: by 2002:a05:6000:1887:b0:3b1:9259:3ead with SMTP id
 ffacd0b85a97d-3b776642745mr1792785f8f.28.1753453365150; 
 Fri, 25 Jul 2025 07:22:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778eb2bccsm67065f8f.7.2025.07.25.07.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 07:22:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH for-10.1 2/3] linux-user/aarch64: Support TPIDR2_MAGIC signal
 frame record
Date: Fri, 25 Jul 2025 15:22:39 +0100
Message-ID: <20250725142240.3760452-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725142240.3760452-1-peter.maydell@linaro.org>
References: <20250725142240.3760452-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

FEAT_SME adds the TPIDR2 userspace-accessible system register, which
is used as part of the procedure calling standard's lazy saving
scheme for the ZA registers:
 https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#66the-za-lazy-saving-scheme

The Linux kernel has a signal frame record for saving
and restoring this value when calling signal handlers, but
we forgot to implement this. The result is that code which
tries to unwind an exception out of a signal handler will
not work correctly.

Add support for the missing record.

Cc: qemu-stable@nongnu.org
Fixes: 78011586b90d1 ("target/arm: Enable SME for user-only")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/signal.c | 46 +++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index b4bab7c040d..9a903576add 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -121,6 +121,13 @@ struct target_za_context {
 #define TARGET_ZA_SIG_CONTEXT_SIZE(VQ) \
     TARGET_ZA_SIG_ZAV_OFFSET(VQ, VQ * TARGET_SVE_VQ_BYTES)
 
+#define TARGET_TPIDR2_MAGIC 0x54504902
+
+struct target_tpidr2_context {
+    struct target_aarch64_ctx head;
+    uint64_t tpidr2;
+};
+
 struct target_rt_sigframe {
     struct target_siginfo info;
     struct target_ucontext uc;
@@ -253,6 +260,14 @@ static void target_setup_za_record(struct target_za_context *za,
     }
 }
 
+static void target_setup_tpidr2_record(struct target_tpidr2_context *tpidr2,
+                                       CPUARMState *env, int size)
+{
+    __put_user(TARGET_TPIDR2_MAGIC, &tpidr2->head.magic);
+    __put_user(sizeof(struct target_tpidr2_context), &tpidr2->head.size);
+    __put_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
+}
+
 static void target_restore_general_frame(CPUARMState *env,
                                          struct target_rt_sigframe *sf)
 {
@@ -403,6 +418,16 @@ static bool target_restore_za_record(CPUARMState *env,
     return true;
 }
 
+static bool target_restore_tpidr2_record(CPUARMState *env,
+                                         struct target_tpidr2_context *tpidr2)
+{
+    if (!cpu_isar_feature(aa64_sme, env_archcpu(env))) {
+        return false;
+    }
+    __get_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
+    return true;
+}
+
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
@@ -410,6 +435,7 @@ static int target_restore_sigframe(CPUARMState *env,
     struct target_fpsimd_context *fpsimd = NULL;
     struct target_sve_context *sve = NULL;
     struct target_za_context *za = NULL;
+    struct target_tpidr2_context *tpidr2 = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
     int sve_size = 0;
@@ -460,6 +486,13 @@ static int target_restore_sigframe(CPUARMState *env,
             za_size = size;
             break;
 
+        case TARGET_TPIDR2_MAGIC:
+            if (tpidr2 || size != sizeof(struct target_tpidr2_context)) {
+                goto err;
+            }
+            tpidr2 = (struct target_tpidr2_context *)ctx;
+            break;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 goto err;
@@ -497,6 +530,9 @@ static int target_restore_sigframe(CPUARMState *env,
     if (za && !target_restore_za_record(env, za, za_size, &svcr)) {
         goto err;
     }
+    if (tpidr2 && !target_restore_tpidr2_record(env, tpidr2)) {
+        goto err;
+    }
     if (env->svcr != svcr) {
         env->svcr = svcr;
         arm_rebuild_hflags(env);
@@ -568,8 +604,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         .total_size = offsetof(struct target_rt_sigframe,
                                uc.tuc_mcontext.__reserved),
     };
-    int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0;
-    int sve_size = 0, za_size = 0;
+    int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
+    int sve_size = 0, za_size = 0, tpidr2_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
     abi_ulong frame_addr, return_addr;
@@ -585,6 +621,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         sve_ofs = alloc_sigframe_space(sve_size, &layout);
     }
     if (cpu_isar_feature(aa64_sme, env_archcpu(env))) {
+        tpidr2_size = sizeof(struct target_tpidr2_context);
+        tpidr2_ofs = alloc_sigframe_space(tpidr2_size, &layout);
         /* ZA state needs saving only if it is enabled.  */
         if (FIELD_EX64(env->svcr, SVCR, ZA)) {
             za_size = TARGET_ZA_SIG_CONTEXT_SIZE(sme_vq(env));
@@ -644,6 +682,10 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     if (za_ofs) {
         target_setup_za_record((void *)frame + za_ofs, env, za_size);
     }
+    if (tpidr2_ofs) {
+        target_setup_tpidr2_record((void *)frame + tpidr2_ofs,
+                                   env, tpidr2_size);
+    }
 
     /* Set up the stack frame for unwinding.  */
     fr = (void *)frame + fr_ofs;
-- 
2.43.0


