Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26049C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoVA-00033k-I8; Wed, 07 May 2025 19:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTd-0000c6-6s
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:47:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTb-00039e-53
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:47:00 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22e6344326dso5100625ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661618; x=1747266418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWI42H1mGpC+qtJnGTlft49SFGxWloHLdh6QbAbdhzc=;
 b=gWggpCoBc99/MqcfabmgUSQythwwMnA1Ilwzn/tCrlGMGMMMHaJZOVW0mNL1/2MEwD
 x5xLbZcte0/kJAd2NWhqllsgtprzGr6yi9UIrteehjdX81qjAvuZYtYki13kPnnyzg8H
 PhkmnbE+0MyecN7zTm5tLgycyg2WgGu1X3AwZ1PJKGmLxwvr6SwxEfCY/gi7Alhx2ozx
 bfhPV18fWSF7s6ONBFbXxkSiae+KVWhIRGsrTGV4Hwq9WdJ4BmJArk5Esw9weOpPEeXA
 nVXJKvuDSS46m60etq9vlSZyYstXlP/5Qbo4012OKAA/juiMhCNsa78Vw7fq37XiAYR9
 2uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661618; x=1747266418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWI42H1mGpC+qtJnGTlft49SFGxWloHLdh6QbAbdhzc=;
 b=fXWaWIyPPLkxSDdfoh/i1gWhKnNK5nupQRA9/UmF9TJwjvF5SHFSDQpboLhyURxGwF
 8JpS5hfAUiDf1He537zbvlCO3lTgfvh/htHzkWFA0JqHVbSX5Xx85wFhLqlfudxxguvI
 ilElh0eWurl3XpDk82ssO58mzKNHthSCaiN+b39XeKuG/B0Ty2rOK4oIlyZFcFHENAEq
 gg87Eppd2KK91v/emxS9Jf52t9e97BQeK6dTU2CujEATody2s6h/SH+jOL4t82NgR9r9
 q/SX3z1CG57iWur06+IRUZDAgOShc1ucDprr/PNfhpq4zcgOw8EC629atJvz/li7m/nA
 jQxw==
X-Gm-Message-State: AOJu0Yy2vKaqzbxyFZUE4COncA3SxLclPbYBAbdKLx8Khmu/xGWnGbrq
 AgjOfHou6fYfb40GGnkY3ATsPh53ONVqup735Lt9Ih0iIzAmrNXBFstw45aS5Y1kUEZ681192my
 B4kRU/g==
X-Gm-Gg: ASbGncslnnU26ZndNgdUAEY2XSrU9YPqWCt3OKRkrjwwuyhNtJygwkbxIHRrdEldcWE
 wvsseTOub16SL6yCCk6BTch5quc79g1hPKbRDfSOHG2YLYs3QjZxbTT5K+HrCUaKhCeeoBMQ+a2
 QTo7bsf5IuNB1FGcc9ti2Q/cRrK2udwUdaE9qf2DAd23kMuM6SoSqP1V8AhjeKRaqPeuKJ85030
 KDu1582mv57JRYn/h1QPWN7+7s7AwybEbzC3+Ui0qHgcSZcO7ASq+ppVKTiJfApgOSuLObAsQdL
 4fPzfe+klN8Cp/k7YqLyfYzX9rv3qOtVReSmz9VG
X-Google-Smtp-Source: AGHT+IF+9FdcXEjg+vjvcbNJXKTc/SzGzp3tVqidhIc+lSQaQpxF9T3Yy5aNHSF14QdgE/W2bTVreQ==
X-Received: by 2002:a17:903:32c5:b0:211:e812:3948 with SMTP id
 d9443c01a7336-22e85367010mr21293255ad.0.1746661617799; 
 Wed, 07 May 2025 16:46:57 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e97absm100792435ad.62.2025.05.07.16.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:46:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 47/49] target/arm/tcg/tlb-insns: compile file once (system)
Date: Wed,  7 May 2025 16:42:38 -0700
Message-ID: <20250507234241.957746-48-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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


