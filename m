Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125BDC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kxk-0006lY-7H; Wed, 23 Apr 2025 21:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwm-0004pE-GT
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:14 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwj-0005TE-P2
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:11 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so373073b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456407; x=1746061207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Judoew0yyRM+ZQdcs+U7k7YNBkFAe4iaEkKni645IrU=;
 b=JRiRZa5aWKCLMvLiWcV32HG8w/+tFttgp0iyX1QG3JZkIpH12Q4bIQDoLO1S9PZVvG
 VwYigDdGl4lRI7CQO4gQxc++95eW/fFu4N+bgxq2gADmEXHcA0RMu+q3yBXbnROr7Ow1
 NEUWQHeG52UKMOWtKzF5rXcP+JotpjOTuV2AiL7idqRTWm2Ki/KuxYe4IXrowvB5gCm4
 s3Qgr+UO9cOb60WHBmSNS3/j5MHWByjkJ+GdUZiHTiyEebjVLC9ToTUiLQ9/pMlNvmr+
 xZ5sWcoYwF7hFIF4n9+KoDYrUljqX9d++C1y8fBOhYFppWe0LRueMirxVu6vXdX1sitE
 T6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456407; x=1746061207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Judoew0yyRM+ZQdcs+U7k7YNBkFAe4iaEkKni645IrU=;
 b=R1S/tazFMxX479FzxM293zrxGnx7AYs/DUefHa+qm0NhGW5IBa92RxBo1ucuC/XcBN
 821ocXeb5TDf5+M8fcdQ0Q4Ug+NuoyvkMORvrXoLtUHN6Ygh9OKmzk4WgBZn1UgCbhQF
 1L7sKNi/0ug0FYL8buxIioI55lNpqN28yqGSd+en5BuYk6JUF++ii4XEFFvcNEhJeDSX
 MWJhFaF/UzQXO1M3Fl7D0EwIj9M5VpTxjeRdQ2voAbpfFvrGmTGAKNXcXdrbArXsuRvY
 xuSeDbkwKAwOJLSlzKTII3K2gW3X2FRVPmO9SJET6IGjwXxlUtLvw2NJdN7tDwsFe/R6
 1Vcg==
X-Gm-Message-State: AOJu0Ywwj/64HH8pz1Z4rqkKai5NbZ2qGe66YkQICJYr2vS7bqGzTNDH
 jblDmXNq1Ac9xr4FKaz1vAbM8ovvwdzmQ4fzuj3jaIpHmWvvTQjxbcpRRVfCqlkcmByPn0qAIxT
 j
X-Gm-Gg: ASbGncvmBBHRB2TUSsbf3uEmDIvQz0YHyBRBDtrFhv5d1C1eWpCgYv0m0dgP8PHADwq
 fHiwl5o82MdFj2aBCZyi/KQ8AtTyeN9o1uTyp8YjRxIUbBugotO6IoGVmme0oUcZjXy7cOeXWUR
 kGGqV4cU+2gsVwDGZP0yB5GzabzqlLCfbXk0RimXLGWf6m/3AXQFz3yPcPx241Ko/VM8ikE9NhS
 MdAjmEr4KUhErTWs0p65DSWKmDPyGEXLBAGxCA8TKyJ3PRaj/d9QRsezYcE4YG0yL9c5LnefbF2
 1B4j2oVJ53aP7hEIkrfEz0G6J1aFbVBJsSZGpYqSw1LpnM+JkYSE2b9JH2ciRn4nf6KBw7W9w6U
 HMHoaJ1skBQ==
X-Google-Smtp-Source: AGHT+IEUV5aF+g7SRwso+9NY2+Zn9bz25xXC2jjLUYy0zk3NhZSU9Z6zflw91mn4RztczFk+BOEZGQ==
X-Received: by 2002:a05:6a20:3d90:b0:1fd:f48b:f397 with SMTP id
 adf61e73a8af0-20444f0e8fcmr697526637.23.1745456406938; 
 Wed, 23 Apr 2025 18:00:06 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 126/148] target/riscv: Do not expose rv128 CPU on user mode
 emulation
Date: Wed, 23 Apr 2025 17:49:11 -0700
Message-ID: <20250424004934.598783-127-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

As Richard mentioned:

  We should allow RV128 in user-mode at all until there's a
  kernel abi for it.

Remove the experimental 'x-rv128' CPU on user emulation
(since it is experimental, no deprecation period is required).

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c         | 10 ++++------
 target/riscv/tcg/tcg-cpu.c |  5 +++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 430b02d2a5..ad534cee51 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -697,7 +697,7 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 #endif
 }
 
-#ifdef CONFIG_TCG
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 static void rv128_base_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -708,11 +708,9 @@ static void rv128_base_cpu_init(Object *obj)
 
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
-#endif
 }
-#endif /* CONFIG_TCG */
+#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
 
 static void rv64i_bare_cpu_init(Object *obj)
 {
@@ -3255,9 +3253,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
-#ifdef CONFIG_TCG
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
-#endif /* CONFIG_TCG */
+#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 710449d17e..5d0429b4d0 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1046,7 +1046,6 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
 static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
 
     if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
@@ -1055,6 +1054,9 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
+#ifndef CONFIG_USER_ONLY
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+
     if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_setg(errp,
@@ -1063,7 +1065,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-#ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
-- 
2.43.0


