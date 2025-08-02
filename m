Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475F8C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLgi-0006vd-08; Sat, 02 Aug 2025 19:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgB-0006LI-Ul
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:32 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgA-0004pZ-Ee
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:19 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3004ade907bso1003175fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177417; x=1754782217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsvBS8RBB7nukj1RPR1Xen8yV7uvDqzTtw/ihslv+1c=;
 b=ksKK0yNP5L5s6C7Owr9cOMWbLLy0yJWGjW7RP28X7xqn9Tl205aEpmgjY5DTcc0Lyy
 V8IF3g8N1E0oRagMvgmmXVNLJd6rgrmZPMiX4CcvPUI/UGNJj/+26YFuD4p0igmcPJGy
 7/4FzCw/RLsGgOS/bAKijvFlTDYiviRBmfr7rFmoPx74UhJn0w5uKgwo0Bjs8pr3Zq2Y
 bzitVuU44GOIUAp9m5lxw2ZzC0dDNd2Qt6n70s/LO0kj0RkHkGiLnPZShwTbJ4kE7+a1
 kKDpMO2VWgzoXKOlHJUp6zSQjY6Uqo7SlsAiZ5dnlGZc1YyjVK4ZhTOUTB0h1ZJ0YmAv
 gsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177417; x=1754782217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsvBS8RBB7nukj1RPR1Xen8yV7uvDqzTtw/ihslv+1c=;
 b=fuMM/IBJX+Tr37CN0DsCQj04f3Mme16dcm9bK9FRF4UjGbrsNqETzXXOC4BaEdNnKB
 yjHZwY0Piq2EG77uvUIutHFTUiTd45L/X4Nw8NJ1W8Hws/ky7NbicuOd+MDZZw7lhACS
 I9clAhArcgw915mzwkj6HTPpdFqkp3nIPPsdahvNdGtVgh6YYVVSse2IX6U/a9Q3YGCM
 NjDU/e3rzLB7bcCx91vBNpADkPID84nNBk7wewMgXa0ohvlvVz20RB3bZmy2ecbqrvca
 tSJ0hd04R2pD5Cuk3nDYkU4DbNAltPqbckhvXhtGKOEHlK8+Cv2ujZSFbssCwpA9z28b
 KiBA==
X-Gm-Message-State: AOJu0YzxWrGNBR7HWVC0BjRH3vckfr4uZ5Ez7EZ4qjKPyQjmGMj6o97b
 i92FQ4leSCOFbzlvkqGY/MzoB2PBboKiYIFheQBC8X6Ro0Q42UwwsE8acIbVb/n5neLntkIUsJR
 R83+sn58=
X-Gm-Gg: ASbGncu1yO/WmMF8/OWPbdsZ+h/8x9YhGjaCZTxC+oHIJz4YZh6jysLqp+Km8qZpnVY
 CULco/rLz3ZxHwSydbTB/XTGDNa7467D7Su3OGT+OeMXsSXEF58lpwBl7X0H35PTxbRUu/jQmEU
 pNybBrEvOmTJsuNn/5ZSxgBUXwgDI3XDux0oXCCfT6hnbPwwMvT4X1SShrB5r0TFLg64nsNAXYe
 VTBSdMJv3nXckp7IRENmuis5mZpXVl+FsDGrOxVLF3FJAy0FmVQuLYt6YH+cPfDAS7f4e3AM2tx
 h0qvj5gTXZAyxSJJ3RHDFM/1iCAwECSOxp6FsxLBHNR8p9g81umiwe1QIGAbbU8qSCstDBzgVJc
 lbmTioCyLxEhCPGh4VZEOBQvuwv2a/9n8NEct2j3jGadXwsTG29ul
X-Google-Smtp-Source: AGHT+IFxQXq89PP0el1O6Y+gX7pjV8DeiRX4UIIBGDHceUmOrEFXpFcyyDXac3RoWa6XLQfGwKbUbA==
X-Received: by 2002:a05:6870:a99c:b0:29e:2d18:2718 with SMTP id
 586e51a60fabf-30b67a05a9emr2698528fac.28.1754177416974; 
 Sat, 02 Aug 2025 16:30:16 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:30:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 03/85] linux-user/aarch64: Generate ESR signal records
Date: Sun,  3 Aug 2025 09:28:31 +1000
Message-ID: <20250802232953.413294-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c |  3 +++
 linux-user/aarch64/signal.c   | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 098578978e..7e9788abfb 100644
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
index 668353bbda..ef97be3ac7 100644
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


