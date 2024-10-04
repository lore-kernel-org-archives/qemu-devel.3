Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25031CF8850
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlDi-0004jN-Af; Fri, 04 Oct 2024 12:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlDh-0004ij-BK
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:31:57 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlDe-0005ej-Hm
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:31:56 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fac47f0b1aso29892941fa.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059512; x=1728664312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ah2mpPOVGVx2cY8doZ+1TV8yPkrfA9ibyFMVLGjjZzw=;
 b=v5TLkMKGGU3jeDF43StLz8TirJz0aBZKBok9P9hgKt3RubmDjJhFiCyfe5HHUDSXx9
 H6S91S95yjS6H6JWc0VzH4k3UU1KdUyl0tqrZ+UoexJ/zDRx5Uxv82Rshe8o17CR6k/d
 Mh33ZCPJP6QU56TE2F5+o+Ci9HaQ793HxQ4P22zSNi6ZLpEK2UOEZSNO8YEpH2Go+b2V
 xHa4bv/3hQea4uWsE7jSVSEOaW3P89CfBpxuYcQWLp869MF0oVsoIm5LhSz4jWrUb9t7
 TnwbM6PPMbZ4CCrIScPwjAFUJYp525J9TvrUhrqOZzg8zZCQf4Sjnmd6tw59Fel21UKs
 YrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059512; x=1728664312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ah2mpPOVGVx2cY8doZ+1TV8yPkrfA9ibyFMVLGjjZzw=;
 b=KRwlDHi/1fM+KzS1Y0sQndpsOih3Yu8SjkkXa2FpvGPq8vDqMfnRCqtXYSbPekOAfX
 Mivd55gLH77hNVR3NcSVYcVqYaUJi1ALFBW5vsXoiXwkBRtzhk+MT5iIeczHhEGcW1s6
 66ujUSFe9oRkIAFUVVCxyIr33PtrsIkoz8NAVJmxYaogPxvyWaxidIO+Fv8cpOXo2foK
 JUWSyy8kLsKLN1oAu2yO3TwP+zMgHjml2E9vNPQAH50VtcVQwW9gUSfhJEFndUwtBkMv
 PYoGNWguplZj1VhE2l3FmjxxLj4dODOcVoRDXth6qjbz8M06fq/iNLAsKRQLCBUTGJMU
 Ypgg==
X-Gm-Message-State: AOJu0YysdSvivKW5SE88FfmzCNNMO1YQuopbA7CdbjfJ6pta3NJyMsmE
 MmcldFX1tQt6F9lLqXUWlVxZ97YYjTiTzNDfAZqVTNgTiyYacGT8N5JH1lmtujLrYIQwLwXogEt
 6Y9Gt8A==
X-Google-Smtp-Source: AGHT+IFnOCgeednwzvnQ9fVYAH8BPIYN0wgVj41VvvPP8r9V3726wqo75sRYfr3Ng047GYTEWxPl5g==
X-Received: by 2002:a05:651c:154a:b0:2ef:2cdb:5053 with SMTP id
 38308e7fff4ca-2faf3d8a8e9mr14915461fa.37.1728059512245; 
 Fri, 04 Oct 2024 09:31:52 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9b3a945sm197011fa.127.2024.10.04.09.31.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:31:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/25] target/s390x: Replace ldtul_p() -> ldq_p()
Date: Fri,  4 Oct 2024 13:30:20 -0300
Message-ID: <20241004163042.85922-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

The S390X  target is only built for 64-bit.
Using ldtul_p() is pointless, replace by ldq_p().

Mechanical change doing:

  $ sed -i -e 's/ldtul_p/ldq_p/' $(git grep -wl ldtul_p target/s390x/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/gdbstub.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index a9f4eb92adf..9ffec0bccbc 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -46,7 +46,7 @@ int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int s390_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUS390XState *env = cpu_env(cs);
-    target_ulong tmpl = ldtul_p(mem_buf);
+    target_ulong tmpl = ldq_p(mem_buf);
 
     switch (n) {
     case S390_PSWM_REGNUM:
@@ -126,7 +126,7 @@ static int cpu_write_fp_reg(CPUState *cs, uint8_t *mem_buf, int n)
         env->fpc = ldl_p(mem_buf);
         return 4;
     case S390_F0_REGNUM ... S390_F15_REGNUM:
-        *get_freg(env, n - S390_F0_REGNUM) = ldtul_p(mem_buf);
+        *get_freg(env, n - S390_F0_REGNUM) = ldq_p(mem_buf);
         return 8;
     default:
         return 0;
@@ -167,11 +167,11 @@ static int cpu_write_vreg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_V0L_REGNUM ... S390_V15L_REGNUM:
-        env->vregs[n][1] = ldtul_p(mem_buf + 8);
+        env->vregs[n][1] = ldq_p(mem_buf + 8);
         return 8;
     case S390_V16_REGNUM ... S390_V31_REGNUM:
-        env->vregs[n][0] = ldtul_p(mem_buf);
-        env->vregs[n][1] = ldtul_p(mem_buf + 8);
+        env->vregs[n][0] = ldq_p(mem_buf);
+        env->vregs[n][1] = ldq_p(mem_buf + 8);
         return 16;
     default:
         return 0;
@@ -203,7 +203,7 @@ static int cpu_write_c_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_C0_REGNUM ... S390_C15_REGNUM:
-        env->cregs[n] = ldtul_p(mem_buf);
+        env->cregs[n] = ldq_p(mem_buf);
         if (tcg_enabled()) {
             tlb_flush(env_cpu(env));
         }
@@ -246,19 +246,19 @@ static int cpu_write_virt_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_VIRT_CKC_REGNUM:
-        env->ckc = ldtul_p(mem_buf);
+        env->ckc = ldq_p(mem_buf);
         cpu_synchronize_post_init(cs);
         return 8;
     case S390_VIRT_CPUTM_REGNUM:
-        env->cputm = ldtul_p(mem_buf);
+        env->cputm = ldq_p(mem_buf);
         cpu_synchronize_post_init(cs);
         return 8;
     case S390_VIRT_BEA_REGNUM:
-        env->gbea = ldtul_p(mem_buf);
+        env->gbea = ldq_p(mem_buf);
         cpu_synchronize_post_init(cs);
         return 8;
     case S390_VIRT_PREFIX_REGNUM:
-        env->psa = ldtul_p(mem_buf);
+        env->psa = ldq_p(mem_buf);
         cpu_synchronize_post_init(cs);
         return 8;
     default:
@@ -298,19 +298,19 @@ static int cpu_write_virt_kvm_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_VIRT_KVM_PP_REGNUM:
-        env->pp = ldtul_p(mem_buf);
+        env->pp = ldq_p(mem_buf);
         cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_KVM_PFT_REGNUM:
-        env->pfault_token = ldtul_p(mem_buf);
+        env->pfault_token = ldq_p(mem_buf);
         cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_KVM_PFS_REGNUM:
-        env->pfault_select = ldtul_p(mem_buf);
+        env->pfault_select = ldq_p(mem_buf);
         cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_KVM_PFC_REGNUM:
-        env->pfault_compare = ldtul_p(mem_buf);
+        env->pfault_compare = ldq_p(mem_buf);
         cpu_synchronize_post_init(env_cpu(env));
         return 8;
     default:
@@ -338,7 +338,7 @@ static int cpu_write_gs_reg(CPUState *cs, uint8_t *mem_buf, int n)
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
 
-    env->gscb[n] = ldtul_p(mem_buf);
+    env->gscb[n] = ldq_p(mem_buf);
     cpu_synchronize_post_init(env_cpu(env));
     return 8;
 }
-- 
2.45.2


