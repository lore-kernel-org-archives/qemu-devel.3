Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8435BC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 23:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufRXF-0002uT-MN; Fri, 25 Jul 2025 19:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRXE-0002tY-6o
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:09:04 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRXC-0001pg-DV
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:09:03 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso34933925ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753484941; x=1754089741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsvBS8RBB7nukj1RPR1Xen8yV7uvDqzTtw/ihslv+1c=;
 b=U+XOLW1JlbYr+73+RwgwnlZZD/1ymv6f+8modRYIx0rult4z95vazNVnY74eR48G9P
 3+e9R/Td2KUmMdxuTqXfxEijKIXthNIMqayLyWrjMM9M3NKSUk317gyK7K0cS79LWZWF
 j5zZ05K6r/j+z65aOg/UDaT1zpBH861oCrhQMO9UzWw0NxKJtR8whzq3zfdjNz0/zcLu
 zKXwIygiZvA80H9DPm4AVrhb67XTnUv/F0321YlgSaKEjKUJXsNy9+Q/YiLkZc9rx5M7
 qgLchf66O/6Y3ccNBbvptac08RYm+H9hyLrVmRwln6jcnlszmtn2oE/Y0+nlZFTSPHPH
 NjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753484941; x=1754089741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsvBS8RBB7nukj1RPR1Xen8yV7uvDqzTtw/ihslv+1c=;
 b=UdolHKa+341YZvxhmnko59tVBnbx1z2Q3fCtlJXZDbzk+EcJyMywaigY/R87OgAaB6
 uj8LcLBj9IisP/RPPv0RLZYtmh5VycMgghK+97yMEDorTtNhHC9XJOWKPd9/CpceM+P/
 hgTjYdH2iKQmkG8K5cTImtoVcNnqk1oBgSsS7A/5WusziCWOxKNUcOKLkkBDXIY1jniU
 nMSYtxJ6UYvTD2kd3oWPfybU5Ih3ueaOr42Nyvh32S3nvxFNkMUitVf1Mx+eOE35sHmc
 oM5RcE4p8CvSU1gU0bqyDXr2lVSfA0VOxEAIXpZYibh5vSOPES2WHxMA9eaDZMr4ebyf
 zBRA==
X-Gm-Message-State: AOJu0YzWKohbCacps3EtXQNSKLkqN9AcoH583qHq14ebfUWrUYhGSfoQ
 ik12bfhN1AulRyZRQ3vSiU8/iQdbBTHG57XpDu568We7AuZf6uG8+N5QE2QME/WU9vqbFYH0u8U
 2jztc
X-Gm-Gg: ASbGncvO8EYSuyrKrIJJtM9BV/E1/mltvryODYbPbMKsRtvIVjrTe3pA8foQupSapmu
 ye/gqoZegk0xEfxsAjO10eR7MraswWotIwLizUTgYli1GFdlIDi3MaWCV/kLYv+FNe1Hp+wVHZo
 Gbo/+yLXNeltwcMt6dhFyMKpw8sv0NdyN36dDttBz1mjGv70FNDeh9V1BnDQBHlm5izUO4eeq6w
 t53Xo2Xr8LRfAUJz09KXegJU0+xgNyQNtKGrc26FBf+4I6qn061V+piCZEanbgjQpH+Hcvr7yjx
 fBly5JYXTw7LDI4JPhFZbqPQw0k1EVBZM0Y+2A4nuFSukDFLait0MDWDHVi9buRS1tCJ63v6Pw/
 aD0BF0BOfrIXdiD25sRnYIskBe2AzfAvC9nJNsUIT10BdbubN9ResEE7EaPttYsYtHINi75w3E8
 qIPH3g+2nxuA==
X-Google-Smtp-Source: AGHT+IH/89yTIVTKk7THzRKY4KiWdJzGtX+b4B9vcy2j2FvBwvr99YfL/Ra6zzBZKU/iB2X/XnLCVg==
X-Received: by 2002:a17:902:e84e:b0:23c:7b9e:1638 with SMTP id
 d9443c01a7336-23fb3166c84mr59855855ad.35.1753484940923; 
 Fri, 25 Jul 2025 16:09:00 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe545368sm5033375ad.172.2025.07.25.16.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 16:09:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 3/3] linux-user/aarch64: Generate ESR signal records
Date: Fri, 25 Jul 2025 13:08:49 -1000
Message-ID: <20250725230849.13026-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725230849.13026-1-richard.henderson@linaro.org>
References: <20250725230849.13026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


