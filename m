Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC8ECAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4P-0002mX-TR; Tue, 16 Sep 2025 14:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4L-0002fU-JR
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4J-0001Yp-N0
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45f29dd8490so28411115e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045978; x=1758650778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iJXgjCpBilcdbaSRNWIXr2Xsvv7vQk5GhQFN3jN+8R8=;
 b=LNdMK0U8MQvq+Sw5C0SnazuV36uYgBcwuIxGm0e96PK1lwyYBlLdd8TzFEa9iC5kLJ
 x6t+XRfDKOhGMnE9x2Rwi/lVms5nMGCN0jiSq/GarPs4IKzqw3RmKTdviUGg0mIn2WB2
 F3ri2to431GcO+TYops0Ifj+TI91zLqrhIKd2gfhGMysBYO8ha+7KCZVZEOD9EzCUXAj
 MwIz5Wg4JDNgwE/3pFm1B8/YboLn6MM6y30NBT4QkKohfES1B0HNS9rYWd4SRT3NzuB7
 dkB5Xj/Mfcl6R9jC+rSPdrQtLjCIUvRs/IKBzi7s1//wq5b3Iu9xQRkopouPRjHSYvbo
 WhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045978; x=1758650778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJXgjCpBilcdbaSRNWIXr2Xsvv7vQk5GhQFN3jN+8R8=;
 b=Xdaqwc4cEsN80cGambsx8sVDV9UXmAiTwQhTEf8xCQgUOJVPBCAhMQ54731QhGvueQ
 BWYJ97FOclmDoss9OqXQh3I3PWTsjGfAASnyCZIZUQwvasaFdd6QNgVSgOt5c4eBYlE5
 qRhGVNWS7/m21RJy3nw4i13JGqZB0+UhpG5BM4PtfyZyHtK7Jo6iiAfTeFxUZGnuaiFp
 fUy9udJqK4+zcV6/T3xIvs1x4m9ou7VZ7AtsqwGqq0NXpw9Y33cz2djNkPdxQTWad3Se
 zCuCrrizo4Nxw+htIJqeaQoDPXJm+MT2l1ehcETmqSTA3O2ASQZRnMNp1mi3uBIQ45PZ
 e9Tg==
X-Gm-Message-State: AOJu0YwJIQe9MYOp3k127MbKkiBAYyt1+6752+h7CcLiow09m5PXxs8j
 VWk0Ruvo5pGHu7H0fWdrkarX0hNFBG8OrvXr/VJhJfekZD7gz4VhlFxbwCHeCLc8HHJRr0GDJUb
 nzI9X
X-Gm-Gg: ASbGnctxO1UvjB6604L3qu9O7uxD4iram445n0AFmoNMB1pgnEX/ID2FvZFF515mYvW
 dhG2IgNkUr8a+RJ7Z/J1dWG6ehuArWog2y/ucoXmnjyfre0rDZYvHKGmPY/mKzeIhj48O5fwFgt
 JvnsMMi97IEPVKx6UeBki3CD9jZ2x//kANU9KWuMyeQBDYuBnLGHlcDOkJWJZPOKViqCPkJGKdL
 bLOWRw+3BFPJSoH6b53bv9dKqQzx/sHDr7TRLw1bgxSuPc38AqCQRcPxayGib6L4jLBV7j/3z83
 JfZTC4xvfi6aj3FzM1FNp4TK4EemWW15p5aNZpsmtWgDstZjVRVOJ05FEDMD22imq9X6sN02qco
 tMxK88VAT2f0aYnBFrC8D+78VWQiOfqjPN4xwDgM=
X-Google-Smtp-Source: AGHT+IE6cMcRK+maLGIOIJxs3AAuAsMqRQv+aK2vCDveh4GdVgTjeUEzO9gwPVw2w5j7gRu0Z3+a4A==
X-Received: by 2002:a05:600c:6d41:b0:45b:47e1:ef68 with SMTP id
 5b1f17b1804b1-45f21208123mr113111675e9.35.1758045977884; 
 Tue, 16 Sep 2025 11:06:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/36] linux-user/aarch64: Generate ESR signal records
Date: Tue, 16 Sep 2025 19:05:38 +0100
Message-ID: <20250916180611.1481266-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250830054128.448363-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/cpu_loop.c |  3 +++
 linux-user/aarch64/signal.c   | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 7ad26316dea..6060572eed3 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -33,6 +33,9 @@ static void signal_for_exception(CPUARMState *env, vaddr addr)
     uint32_t syn = env->exception.syndrome;
     int si_code, si_signo;
 
+    /* Let signal delivery see that ESR is live. */
+    env->cp15.esr_el[1] = syn;
+
     switch (syn_get_ec(syn)) {
     case EC_DATAABORT:
     case EC_INSNABORT:
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index 668353bbda4..ef97be3ac7b 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -65,6 +65,13 @@ struct target_fpsimd_context {
     uint64_t vregs[32 * 2]; /* really uint128_t vregs[32] */
 };
 
+#define TARGET_ESR_MAGIC    0x45535201
+
+struct target_esr_context {
+    struct target_aarch64_ctx head;
+    uint64_t esr;
+};
+
 #define TARGET_EXTRA_MAGIC  0x45585401
 
 struct target_extra_context {
@@ -201,6 +208,14 @@ static void target_setup_fpsimd_record(struct target_fpsimd_context *fpsimd,
     }
 }
 
+static void target_setup_esr_record(struct target_esr_context *ctx,
+                                    CPUARMState *env)
+{
+    __put_user(TARGET_ESR_MAGIC, &ctx->head.magic);
+    __put_user(sizeof(*ctx), &ctx->head.size);
+    __put_user(env->cp15.esr_el[1], &ctx->esr);
+}
+
 static void target_setup_extra_record(struct target_extra_context *extra,
                                       uint64_t datap, uint32_t extra_size)
 {
@@ -531,6 +546,9 @@ static int target_restore_sigframe(CPUARMState *env,
             fpsimd = (struct target_fpsimd_context *)ctx;
             break;
 
+        case TARGET_ESR_MAGIC:
+            break; /* ignore */
+
         case TARGET_SVE_MAGIC:
             if (sve || size < sizeof(struct target_sve_context)) {
                 goto err;
@@ -683,7 +701,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                uc.tuc_mcontext.__reserved),
     };
     int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
-    int zt_ofs = 0;
+    int zt_ofs = 0, esr_ofs = 0;
     int sve_size = 0, za_size = 0, tpidr2_size = 0, zt_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
@@ -693,6 +711,15 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     fpsimd_ofs = alloc_sigframe_space(sizeof(struct target_fpsimd_context),
                                       &layout);
 
+    /*
+     * In user mode, ESR_EL1 is only set by cpu_loop while queueing the
+     * signal, and it's only valid for the one sync insn.
+     */
+    if (env->cp15.esr_el[1]) {
+        esr_ofs = alloc_sigframe_space(sizeof(struct target_esr_context),
+                                       &layout);
+    }
+
     /* SVE state needs saving only if it exists.  */
     if (cpu_isar_feature(aa64_sve, env_archcpu(env)) ||
         cpu_isar_feature(aa64_sme, env_archcpu(env))) {
@@ -754,6 +781,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
 
     target_setup_general_frame(frame, env, set);
     target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
+    if (esr_ofs) {
+        target_setup_esr_record((void *)frame + esr_ofs, env);
+        /* Leave ESR_EL1 clear while it's not relevant. */
+        env->cp15.esr_el[1] = 0;
+    }
     target_setup_end_record((void *)frame + layout.std_end_ofs);
     if (layout.extra_ofs) {
         target_setup_extra_record((void *)frame + layout.extra_ofs,
-- 
2.43.0


