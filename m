Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842F7C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 21:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYsyM-0007tj-F4; Mon, 07 Jul 2025 17:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLF-0005Ka-77
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:33 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLD-0004JZ-0U
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:32 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4a5840ec53dso44594501cf.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919690; x=1752524490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q71VydINUJB4l7s4w8Ba4FQ4V0Afwv9Uv04JgcCuV6Y=;
 b=yuDNzpv0cYHZrfeyE5/ztx6n+D2ucrGq5KKhmgcUKGkLCWPINPX9XcQQ9+LviyI0JR
 rIbEolxk5tC0GUe6MnnysouoBLzO5rvoYH8YU9iA1SKNRTyLGC73TPoutuO1SckdHfaZ
 5zagOoWP0kTouKJO42W1DFP9A4si7PYOMa4iUAgozaLGnAlB3SUSfp1/lP0MkyQCZF1m
 YkynVD+VeYqWCgXS759FVBhad3DI0ZH51NZJGOpGI/LYUWApt1HmHnuBw4nWHoCwaGeI
 lPPHla7yhaP1opaHLnPbXPnwc3PX81pDZZNXoBTyGSMCUwlKOUslPQB5xwq4vBcpoGDj
 zxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919690; x=1752524490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q71VydINUJB4l7s4w8Ba4FQ4V0Afwv9Uv04JgcCuV6Y=;
 b=FWSLyRFmvNw2+PTzJUDj0rKVpf/Fe48w0VEQjm8+rce7BSsmusQSIwM2KX96shV0Yi
 E3ceXDNeHEihGj5wdaXPEoz54WpQbu3R0YprQ/vEQ+Kka3a+sXahneMU9yp24iIEnywy
 u7Pn+GeoQPxnXNUkQuGoBK1VfpoKxYWH8AChbt8W05e5Z/e+l5IoFnmjTK3N0ugCF3HQ
 /I1fpC6O6IlIoDP+04H37jg99fr5JeppqkUfGQ7iTTC4WyghOEhe/o7lYzYf8PfDCi1g
 6x07ftzJvLivvQO/LsxLY8B543QsldxB4Jgup+b/Duw0iTvFrMBFbWf7kyf4CLJbwnQ2
 FgLA==
X-Gm-Message-State: AOJu0YxYObVfjB7yLGyNZ+kykOeGYMmBa6UIfF1FRXrMLh7Q4cNYZBrr
 EVeQXxfwoqwhuG5Rk4544zxSzp8rspqo200rgbS/7INFCRfm/19JuCtf7Xhc3TxtJyGYujcLPfG
 2Dnrj3Es=
X-Gm-Gg: ASbGncv+IQYgA9f1FVs5pRfiEmLOYlYSw7EkXIHIOh8p/WRsDhKUDY4UjvOSjvztiVC
 d/aW3AX5TQDqq34inHpUe0l7wm2TFU2G8MGpM+lTGwTsNKlEzTSJC/ojkAUy8wy3ikxBYR2m3Or
 XxRzGW5sKCzSr9Hgk9KgZTPw7zeVHm8luFoKx4Nco3vSgbQP/aKMGROXwIRW4Apc0qyo3OFRHA1
 ZzX4hjilm7XDJRa/FwnGgCVGQoi0wbqvr9/rjh39WprThzzIaANY+3UepvZLzK32dQi+YVVmQxw
 Iq3OSmqGwwSesyztkaH5PEaeOuoHas9hqa8FhDPdtCUS3RkRAQg0NSxh2/PzPm7XkxEqC7QTf/4
 bBw3vW0xYKHu0pjX5
X-Google-Smtp-Source: AGHT+IEhl+nbz8GwgsJYSFaahTTERxIDUc5TU6XssStGLC0dDNE9duN0Gl5VKs5GUq9D1hQEGmir8A==
X-Received: by 2002:a05:622a:5588:b0:4a9:76fa:873d with SMTP id
 d75a77b69052e-4a9cccb00e4mr10038451cf.17.1751919689678; 
 Mon, 07 Jul 2025 13:21:29 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/20] target/arm: Convert v8m_security_lookup to access_perm
Date: Mon,  7 Jul 2025 14:20:59 -0600
Message-ID: <20250707202111.293787-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x831.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h    | 2 +-
 target/arm/ptw.c          | 8 ++++----
 target/arm/tcg/m_helper.c | 7 +++----
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 629aa7bc23..1781943fac 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1535,7 +1535,7 @@ typedef struct V8M_SAttributes {
 } V8M_SAttributes;
 
 void v8m_security_lookup(CPUARMState *env, uint32_t address,
-                         MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                         unsigned access_perm, ARMMMUIdx mmu_idx,
                          bool secure, V8M_SAttributes *sattrs);
 
 /* Cacheability and shareability attributes for a memory access */
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 78a9c21fab..709dfa2684 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2770,7 +2770,7 @@ static bool v8m_is_sau_exempt(CPUARMState *env,
 }
 
 void v8m_security_lookup(CPUARMState *env, uint32_t address,
-                         MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                         unsigned access_perm, ARMMMUIdx mmu_idx,
                          bool is_secure, V8M_SAttributes *sattrs)
 {
     /*
@@ -2793,12 +2793,12 @@ void v8m_security_lookup(CPUARMState *env, uint32_t address,
                    &idau_nsc);
     }
 
-    if (access_type == MMU_INST_FETCH && extract32(address, 28, 4) == 0xf) {
+    if ((access_perm & PAGE_EXEC) && extract32(address, 28, 4) == 0xf) {
         /* 0xf0000000..0xffffffff is always S for insn fetches */
         return;
     }
 
-    if (idau_exempt || v8m_is_sau_exempt(env, address, 1 << access_type)) {
+    if (idau_exempt || v8m_is_sau_exempt(env, address, access_perm)) {
         sattrs->ns = !is_secure;
         return;
     }
@@ -2891,7 +2891,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
     bool ret;
 
     if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-        v8m_security_lookup(env, address, access_type, mmu_idx,
+        v8m_security_lookup(env, address, 1 << access_type, mmu_idx,
                             secure, &sattrs);
         if (access_type == MMU_INST_FETCH) {
             /*
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 220a3b472f..e52ab261be 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -684,7 +684,7 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure,
     if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         V8M_SAttributes sattrs = {};
 
-        v8m_security_lookup(env, addr, MMU_DATA_LOAD, mmu_idx,
+        v8m_security_lookup(env, addr, PAGE_READ, mmu_idx,
                             targets_secure, &sattrs);
         if (sattrs.ns) {
             attrs.secure = false;
@@ -1996,7 +1996,7 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx, bool secure,
     ARMMMUFaultInfo fi = {};
     MemTxResult txres;
 
-    v8m_security_lookup(env, addr, MMU_INST_FETCH, mmu_idx, secure, &sattrs);
+    v8m_security_lookup(env, addr, PAGE_EXEC, mmu_idx, secure, &sattrs);
     if (!sattrs.nsc || sattrs.ns) {
         /*
          * This must be the second half of the insn, and it straddles a
@@ -2838,8 +2838,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     }
 
     if (env->v7m.secure) {
-        v8m_security_lookup(env, addr, MMU_DATA_LOAD, mmu_idx,
-                            targetsec, &sattrs);
+        v8m_security_lookup(env, addr, PAGE_READ, mmu_idx, targetsec, &sattrs);
         nsr = sattrs.ns && r;
         nsrw = sattrs.ns && rw;
     } else {
-- 
2.43.0


