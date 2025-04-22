Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A9AC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSm-0005EB-RF; Tue, 22 Apr 2025 15:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSA-0003yj-Kn
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JS8-0007Kh-5T
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224171d6826so79703425ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350723; x=1745955523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Judoew0yyRM+ZQdcs+U7k7YNBkFAe4iaEkKni645IrU=;
 b=plLJg203C4IacsbSeZoFAP74DZms0SqwdQ9qbF/k6ZP1xMw27ORjkn+RM0tqbNjKrs
 YFw2J9NtgWYvrtQBQrBcBMDurNI4R9XIjZcN09UCdnasRZXlpBYU9++NdU7mPX8mUc28
 VWc0KFab7epiZAbFyX691B65yfh/9hvTKf5xbFOgZVY2V6wzDCr+jCpMDQG4ll4pdmJG
 QtwWIaoavHK4HvG9aZxdV3QvvoSYWfJy8u4hooHkxbDMjq6KEees0KhrRSgKmySqSvmG
 S6ns2+nrE7B4Ww1eFv+XGPuduq4QyNH6Xj6SfMquMuDB3RVGbhxWO/tYOPcpEZISP4Rk
 eyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350723; x=1745955523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Judoew0yyRM+ZQdcs+U7k7YNBkFAe4iaEkKni645IrU=;
 b=KdyDVEJj8Ql9TRVUiaulkHd2vMuaIbdcVTa1U0qGD2+c1XZVWxSSYHOSgoSEHkXz3v
 UXD7BDNEBTWKekaxz8ZbCQWg1BOJ9s7i+rrIwFGD4S+R0C+seJh6iyYhcpNsUOrIumva
 MMqCIEFa+UXsuTfAt1R3S3vp+7PushoXgobg+4AafODAntnIoxtpPFOSQZxf9kUEl7QN
 UqyprMAwlEpeKFaKDkiCOmT5H728lW8kylIaK06vI/Ud8ib6moj/6w02++Nx7JVYCaEr
 Dk17cqEucQR35pipJggal8L6MFOTVmEb7NE30Q4xGTQriSDbEnbtYT7tKrbCAKGjnMn4
 1MLQ==
X-Gm-Message-State: AOJu0YwFkbfFhu5/E5IuaEwbLAKjfXwdqQvzZ8bUMB7KS58Ct+h7ygWa
 l6G5MZnHYaMSqGzHCBbUAOWnPl/kleeR1txA58EMrGWmi0elN6xiPnPy21kdxgtqTl0kjaDXVWa
 q
X-Gm-Gg: ASbGncsdMADDfnfB0vEYFBUma5mddgNtOTweQDAD6mqflCwaXBW+ABwAQSRJ3s4Jmog
 hlCOs7/nJL5VgeliBSWVuPTCUEM2m8Sm8EuM9EDcpTyKlv1Ek/RRoGG+xeZXMdxPxkAAk7gzy5v
 QCc3zVQ2Ruco7h2bmZIrghInllbsnQUk9tWZT3KLyA5StUmHOKP8+PqpVyuQw1Oc0sSq0kR6zIM
 6VZ5uou4SDnnfnKMN8N1hwPOU2a8qfm8aMF5Gv+SkjiSoLDieBxdgjFlPNjR1ZtNNJqcB13eQS1
 se0y59A9iLfV8SmV+/bhqmG0qIXAcbFGRr+HfrDbeVH12u6qddQbevRNsculh7BZBATh0a0cCcM
 =
X-Google-Smtp-Source: AGHT+IGIEcL5Ju4FvRcR5+eAeXoYGCjLzcKRumWzc4fIs7ifNbn1v1AZVfqKacEPRMLVcZ4IDF/A3w==
X-Received: by 2002:a17:902:ce01:b0:21f:7082:1137 with SMTP id
 d9443c01a7336-22c5357d158mr292873555ad.22.1745350722846; 
 Tue, 22 Apr 2025 12:38:42 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 125/147] target/riscv: Do not expose rv128 CPU on user mode
 emulation
Date: Tue, 22 Apr 2025 12:27:54 -0700
Message-ID: <20250422192819.302784-126-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


