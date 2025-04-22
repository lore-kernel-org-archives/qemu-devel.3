Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958CEC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JT7-0006N7-LB; Tue, 22 Apr 2025 15:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSQ-0004MB-1n
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSN-0007Nw-73
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:01 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22c33677183so65874685ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350737; x=1745955537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TW4N3ReYmKveN3DtkTRFhUmPoxz9JDSNytNFvFcor3s=;
 b=ltj6Rp4PuGgS1vYQe7Q1ica0xDvbxsNvFGUjeYwi59ukvKceSaNefi59UHP9agYH/V
 /qdy4jsHi+hdaXyVDIEweBsGbMuOmdxoqe7yXHlJWPc7912360tV8Q2lD3L/eo3wOUIC
 XI2wQp+XIHoUx63FdLdBbPH85q0MoFRkuqB+IeeZj9TUTTIJXDIo+Shu5tGvz8sZYAzS
 MlnDEYaQJWTI7fKfJltXZuvwwaEPZ3RtC6Yw13y6tSHktUdx+Zz0C4VbcKngcwuoh3uh
 6mC1sj6WO/S9qlY9zt/QfoFkxp4Rk8Za5yzjfyc/KRTwkmqIus3vG0rhWSZQGdOFeEIz
 TRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350737; x=1745955537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TW4N3ReYmKveN3DtkTRFhUmPoxz9JDSNytNFvFcor3s=;
 b=FrsZprrkcfdMjF+WajURaKV4EWEYg6qrBv9JWubq0tTQOyXLiLQzRfFUwLEH2UEsDJ
 41Pw7+R6wb4KEHKksdSKzUA8pV8o+2LdDgr6Oi64BKDInYfI0kYhfrRZuSQAHS9UdC4E
 DVvpUsYwbiIJqRuVSJRuwcPW7QMHq9sqppWPILAiQUlGdZ6rr0q4MrqCRCwCIxm+kCK9
 A15k1VzKJYDIub1C7sACy5UIgnvSJnpLmK6pIU5acNo3Gkkf6i2Feu2NaYUZNC3eISqj
 TzjASLIve2q6exxbjYZyk8Y/185KV88rcYGWSyGVLyKP/tMODULGBltfdyah3hcB+rTo
 Dsjw==
X-Gm-Message-State: AOJu0YyvSpZ93aev7F7oTWnWepNVMHBLH4Q90bKDynbWxN0bEdIaGytY
 RhrFSHpV6NjSACtTyrMF1iROGRDLVpf4fIuTKWdM3MBgf7hQ/EdX+IUQsh9r8mtnrP8IEhwjev6
 X
X-Gm-Gg: ASbGncuhSS3Elk4nwExYYOkqzgV2Qpila3acvB/61+BEOCvYCSKabNXrMBJXCIYbycI
 RAGx088/vCfagEk7nLSdwl8pbGSya04uWK8GpLxxu6RZa06tK+XFks7+YluQeii193W/LKJ0Ifv
 Nj4e1Cr+WyXiKcEVC2wrUWy5GlC89z100LgWr/iY66GBV7vB+JiMmFSm3ssTBxWRp6C/5NSYCoA
 +nSsZ5btVmhBkdfxFYjdCcir9ZoxPQUkOr86BGQyM31VueXaI9gF0DtoSt7YqCkk0pOhRh9rFjm
 i0mbVinVvXoxZloA0e0nzZyqQLITH1wlSM9Dqtf2VMR13D1WDDt6eAsVHfI14LoEgUhIYBGnbXb
 1kwOC51xgTw==
X-Google-Smtp-Source: AGHT+IFBP8BXSno0ocNf5zHGzoEvSQ8K01g8QYaLPu6p5KMfevvtuWHn+qmG3jzCGBcThPldjCz1jg==
X-Received: by 2002:a17:903:11c5:b0:221:85:f384 with SMTP id
 d9443c01a7336-22c5359c36cmr229258785ad.16.1745350737383; 
 Tue, 22 Apr 2025 12:38:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 146/147] target/i386: Remove AccelCPUClass::cpu_class_init need
Date: Tue, 22 Apr 2025 12:28:15 -0700
Message-ID: <20250422192819.302784-147-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Expose x86_tcg_ops symbol, then directly set it as
CPUClass::tcg_ops in TYPE_X86_CPU's class_init(),
using CONFIG_TCG #ifdef'ry. No need for the
AccelCPUClass::cpu_class_init() handler anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250405161320.76854-3-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/tcg-cpu.h |  4 ++++
 target/i386/cpu.c         |  4 ++++
 target/i386/tcg/tcg-cpu.c | 14 +-------------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/tcg-cpu.h b/target/i386/tcg/tcg-cpu.h
index 7580f8afb4..85bcd61678 100644
--- a/target/i386/tcg/tcg-cpu.h
+++ b/target/i386/tcg/tcg-cpu.h
@@ -19,6 +19,8 @@
 #ifndef TCG_CPU_H
 #define TCG_CPU_H
 
+#include "cpu.h"
+
 #define XSAVE_FCW_FSW_OFFSET    0x000
 #define XSAVE_FTW_FOP_OFFSET    0x004
 #define XSAVE_CWD_RIP_OFFSET    0x008
@@ -76,6 +78,8 @@ QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, zmm_hi256_state) != XSAVE_ZMM_HI256_OFF
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, hi16_zmm_state) != XSAVE_HI16_ZMM_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, pkru_state) != XSAVE_PKRU_OFFSET);
 
+extern const TCGCPUOps x86_tcg_ops;
+
 bool tcg_cpu_realizefn(CPUState *cs, Error **errp);
 
 int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d930ebd262..31487f4b28 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -43,6 +43,7 @@
 #include "hw/boards.h"
 #include "hw/i386/sgx-epc.h"
 #endif
+#include "tcg/tcg-cpu.h"
 
 #include "disas/capstone.h"
 #include "cpu-internal.h"
@@ -8903,6 +8904,9 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &i386_sysemu_ops;
 #endif /* !CONFIG_USER_ONLY */
+#ifdef CONFIG_TCG
+    cc->tcg_ops = &x86_tcg_ops;
+#endif /* CONFIG_TCG */
 
     cc->gdb_arch_name = x86_gdb_arch_name;
 #ifdef TARGET_X86_64
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index d941df0956..e13d0f6f86 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -124,7 +124,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 
 #include "accel/tcg/cpu-ops.h"
 
-static const TCGCPUOps x86_tcg_ops = {
+const TCGCPUOps x86_tcg_ops = {
     /*
      * The x86 has a strong memory model with some store-after-load re-ordering
      */
@@ -152,17 +152,6 @@ static const TCGCPUOps x86_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void x86_tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
-{
-    /* for x86, all cpus use the same set of operations */
-    cc->tcg_ops = &x86_tcg_ops;
-}
-
-static void x86_tcg_cpu_class_init(CPUClass *cc)
-{
-    cc->init_accel_cpu = x86_tcg_cpu_init_ops;
-}
-
 static void x86_tcg_cpu_xsave_init(void)
 {
 #define XO(bit, field) \
@@ -211,7 +200,6 @@ static void x86_tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
     acc->cpu_target_realize = tcg_cpu_realizefn;
 #endif /* CONFIG_USER_ONLY */
 
-    acc->cpu_class_init = x86_tcg_cpu_class_init;
     acc->cpu_instance_init = x86_tcg_cpu_instance_init;
 }
 static const TypeInfo x86_tcg_cpu_accel_type_info = {
-- 
2.43.0


