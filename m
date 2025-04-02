Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C79C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 20:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0543-0001fY-SY; Wed, 02 Apr 2025 16:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0541-0001fB-6l
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:51:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u053z-0003Vc-Fa
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:51:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394a823036so1621485e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 13:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627113; x=1744231913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5N4L3guCN8JF+0GLyMHnBGKGYM6I3bXNhCG63p6xTsc=;
 b=oYAgXKraP7OrMM0T8dmMXCExPZoXDiu0Juqo7oC1uEnsHsS5fQ6koOZg6EbFllNcJd
 3FvzX6r0vpIk4YLDXkm/EpwArMrakoD+DRsE4iGnwfqqCAkS0LmyiAIsYVAmZSTU4TKW
 7w4q/cWa5sgUEkvI/uKeskQ3GEkOiuk0/EyieA1L/IsZL9DjIgaCwLfKGK87PjWX9WyP
 3due3UdwWEFyQmTNdTGVGjq1wGRspas/rNJTs2eXacz9AES7wcHxhLeDwq8YQybyPkAc
 6D3Ncu+3weym39hGipolVXf6945h1vvvEfPwvoLznm/a4cWoXecORZk3ynHtsogJxCPX
 Rn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627113; x=1744231913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5N4L3guCN8JF+0GLyMHnBGKGYM6I3bXNhCG63p6xTsc=;
 b=ddMzhjjZU7/UY5mwr4Gn9U0fKW5ms7yrhgXzeh/FHBs9X4fdy/S8c++C1sfnXKgAOu
 aQXDeLCRhflpyhHBGIQCIwrtOu4OQLav7fc7F+ojnLvueb3OKJI1mSxZhnKuveFT+NMD
 +XlRxuIGZyGDi2H4wZeSBopBq7iAu6XD4DFOh1qmmL3RwiEPzSQPq8TPrQ1SFFIhX2WB
 wOwWpgEyeKfFqN1WWp3BBl0VX0uvXgQ/ZOBypBLwIMsVue88x0jUpH1/kUBRxS8eKYjv
 gvqeG21wqPsMeBHhwDMK/eKc71uZt6S3PyiaXmPf35WoByT0y7e/KFR69E/JVY1JYuHK
 7C0Q==
X-Gm-Message-State: AOJu0YyVMX7floVSr0fNNmoWBolLGD1q3KLa/WdvMRy9G6+0T0w04tax
 Zh+Kk/L6G4qq3Fj7Q7tQV1P7gvN85N4beF1UuEUU5fln+tRH+yk3E1VN+tXx39ErpKjJvlRE0Ba
 1
X-Gm-Gg: ASbGnctntbFU+/TA6ClR2vc1FLKfEkQpvY7ehsZBGjQ9BatRJY7OfYUxhziWSTBM+V3
 opknCrTMAfEbnxcf3kyQzPtszOknMDBNahbxqYikoAZl5nxne1lPGz0DF6aungKw8hzXnWudXg1
 XU5znGiLWLr0XwM+a19V+ZnCoyOKw3mTE8xQYXGcGbznwjJt8ftUj5bW9DtQj9xb3bI2HZGwINd
 m61sssWmb9R8lPxRUPvkIKVNeqwILol4uu+2etTsB3bccJgSip8nMvynR8cXyc82nlnknqthdKx
 8Pm/cEH6IrTKNYbL8a3pXN3XBeqQP+4TKAk7V1HIyHfLclD0s7O/CllWIpkjQFrA/Sk4eMi4TCa
 8Fr5OrwHtg53y7ozMTjg=
X-Google-Smtp-Source: AGHT+IFPtgU9yf0blNaXTQBOlSi1ZLMzKm2T4Duf/kCz5GaSuMCjHofcHVWHPmkWcgu5ihaQF/AJTw==
X-Received: by 2002:a05:600c:470f:b0:43c:e305:6d50 with SMTP id
 5b1f17b1804b1-43eb5c95bf9mr35185005e9.24.1743627113264; 
 Wed, 02 Apr 2025 13:51:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b4e4sm1759465e9.20.2025.04.02.13.51.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 13:51:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.0?] target/riscv: Do not expose rv128 CPU on user mode
 emulation
Date: Wed,  2 Apr 2025 22:51:51 +0200
Message-ID: <20250402205151.51415-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

As Richard mentioned:

  We should allow RV128 in user-mode at all until there's a
  kernel abi for it.

Remove the experimental 'x-rv128' CPU on user emulation
(since it is experimental, no deprecation period is required).

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c         | 10 ++++------
 target/riscv/tcg/tcg-cpu.c |  5 +++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 430b02d2a58..ad534cee51f 100644
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
index 19ab324cb2a..50e81b2e521 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1048,7 +1048,6 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
 static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
 
     if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
@@ -1057,6 +1056,9 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
+#ifndef CONFIG_USER_ONLY
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+
     if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_setg(errp,
@@ -1065,7 +1067,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-#ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
-- 
2.47.1


