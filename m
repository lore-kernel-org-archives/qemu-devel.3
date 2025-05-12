Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F56FC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXcM-0003a5-07; Mon, 12 May 2025 14:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaH-0001fB-VH
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:09:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaF-0000Tu-81
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:09:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so1245027b3a.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073337; x=1747678137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWI42H1mGpC+qtJnGTlft49SFGxWloHLdh6QbAbdhzc=;
 b=cNLSHBU8ArKVyTy8heEkxobhItu2aMFPAlD/UrEOwwM2+Ic/dnkFo5r2ngdan0zbC6
 zrNo8+lF7L6bG3vVHCwm38OimB5AdtQzIqvfkHd3pL8BqD3wdd3WDAPEoyqoyuhC6BmH
 DYyncFcvwxJAUWU45w37ICHOdTo6cA+KZBGp7pR+uf6eh20qymokn54venz3JfCVzj/o
 8SIETJmbxyVrTcytdB0o+wVW4IZfaH3YnP5mqnxEIQmQG4Xi4FT56gBL7gDlsL7yh9gA
 EVklVjT8x13HWfiI3WSX+CAUNDKrRmmR5+D7c8Py9m4ZE+rYFt6YlBpsg4iI/ixBuMpz
 uJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073337; x=1747678137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWI42H1mGpC+qtJnGTlft49SFGxWloHLdh6QbAbdhzc=;
 b=tR0fInw5rbrI+iWGJ2iqxzU+AaXDqq9yc3eTAXZuTF4FL7AIkIG4bDvBEDitrY3I0d
 uRb2NGbkWRmNbgpzoUb2mPdumkAp6PIugHK4lI4iIPSTSk4fbLCcnGWDR7LVr223zjo+
 VTyv1hewSTHmAae+An2bszfExfYTuJNhZLvjgW8FCAXz/Wvn6ROZE9Smzw0uHb75f11R
 rCQAcuMClqUg2oReOsMp+W1iEg4mUsbvfUZsr1SmXMQZiRf4Vbrqz7ZNGvrBzrgZ63cv
 Zk34FqrNTaXgfqhLHCXlw83jJ5Rswzh8YA5YjKoNGNzjwU3o7B2wxoGBpA/QdeDmkzvi
 xqPw==
X-Gm-Message-State: AOJu0YyaGvpqTJNgU2sgXBP7u5/I9IF4y5sRFVdrjvgSsdVdU+TsxwQL
 TMVWMQqD7HB4E9x3JIRI0F7QMXt/TsaFu6aWQutPVt2HW9cDwq+Lm/ISjhbX7Qe5uMYzabRSPGn
 y
X-Gm-Gg: ASbGncvYc18VtqV66wMjOROaJBjE2H2qhnW9xZjEI+oWOU7hdTRv7tQSKn5QlVAHw+I
 RoFzT3v+7XUJJioh57C/BMHA5Aa8e62aZeyRlztMKFVcVqjrlSmNCn/XOrHNY19bWlhZAphe+TZ
 qjkpqosap59d2+9ugeUTKWLpmEhX+9MPthtRMwJ0udo0JASaim+oPHFKJUfovsEgck4QlsgU+JH
 v5mMmRkSeF5Zna3vEWtPZIEJ6XQwMAtvR25WOgsQnnfrgVTR8Nz2Owz6bHjky0WAsGroD/dfZOj
 WqlQ0GrdqsbNVqt/iRE4Vbb9rlIV5Xojiiz0E//pG4XLmDnNKV8=
X-Google-Smtp-Source: AGHT+IHtnl15XBTtEr1mY8dLt6bXrBUqTmVSSEupohhsnj2Dz63VmmRIZJFm31uUpKt4D1dkYmWtPw==
X-Received: by 2002:a05:6a00:23c8:b0:737:9b:582a with SMTP id
 d2e1a72fcca58-7423c087158mr22392781b3a.24.1747073337534; 
 Mon, 12 May 2025 11:08:57 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237705499sm6438580b3a.33.2025.05.12.11.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:08:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 46/48] target/arm/tcg/tlb-insns: compile file once (system)
Date: Mon, 12 May 2025 11:05:00 -0700
Message-ID: <20250512180502.2395029-47-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

aarch64 specific code is guarded by cpu_isar_feature(aa64*), so it's
safe to expose it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/tlb-insns.c | 7 -------
 target/arm/tcg/meson.build | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 0407ad5542d..95c26c6d463 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -35,7 +35,6 @@ static CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-#ifdef TARGET_AARCH64
 /* Check for traps from EL1 due to HCR_EL2.TTLB or TTLBOS. */
 static CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
                                     bool isread)
@@ -46,7 +45,6 @@ static CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
     }
     return CP_ACCESS_OK;
 }
-#endif
 
 /* IS variants of TLB operations must affect all cores */
 static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -802,7 +800,6 @@ static const ARMCPRegInfo tlbi_el3_cp_reginfo[] = {
       .writefn = tlbi_aa64_vae3_write },
 };
 
-#ifdef TARGET_AARCH64
 typedef struct {
     uint64_t base;
     uint64_t length;
@@ -1270,8 +1267,6 @@ static const ARMCPRegInfo tlbi_rme_reginfo[] = {
       .writefn = tlbi_aa64_paallos_write },
 };
 
-#endif
-
 void define_tlb_insn_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -1299,7 +1294,6 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         define_arm_cp_regs(cpu, tlbi_el3_cp_reginfo);
     }
-#ifdef TARGET_AARCH64
     if (cpu_isar_feature(aa64_tlbirange, cpu)) {
         define_arm_cp_regs(cpu, tlbirange_reginfo);
     }
@@ -1309,5 +1303,4 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_rme, cpu)) {
         define_arm_cp_regs(cpu, tlbi_rme_reginfo);
     }
-#endif
 }
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 49c8f4390a1..5d326585401 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'tlb-insns.c',
   'arith_helper.c',
   'vfp_helper.c',
 ))
@@ -68,6 +67,7 @@ arm_common_system_ss.add(files(
   'iwmmxt_helper.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'tlb-insns.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
-- 
2.47.2


