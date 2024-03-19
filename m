Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DECBCD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbf4-00030n-DD; Tue, 19 Mar 2024 11:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbed-0001mc-5q
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:45:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbea-0005qN-CY
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:45:30 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4146178270dso8472855e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863124; x=1711467924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuDVEU6xu2/Is+40NdFmTs6boTjeWsn71DRjetsl+yM=;
 b=w4dAN8yZnbe9OQi8Q5jpt9VuXwPdpincDvfrUkJG2ny8jJnZ2CkyG7Mgfr0rf8rrMC
 ZwZlO2SIR8xwkf0EYV6k1/ZE36N4MyZiFmFeeKigce+rNyYaLok+1hReEuyukCNmTEjl
 YY2QYAdaRPwbQKjvnJuGm3RIQkZxkuPophsayJ787RA0HvNamuSE/piBxbSvIZ28MOaF
 0sHm4mcMTYViEVWlgWjARkffUMSah01nqL9TLElfaPy1zzV+18R5WieJc18nq+ITuMuL
 rMVNePWAT0XUOqvhHvRH3LHnD0N5bTW6t6hKBHVNaSdz0HDZyAQ1gdG8+K2TmNLFvAsM
 3ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863124; x=1711467924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuDVEU6xu2/Is+40NdFmTs6boTjeWsn71DRjetsl+yM=;
 b=NyTFemnQAziHwXISY31rVWaipCzTsHxNve+IVETv7LWcf/aKvdEAQhsRsN/GJAD309
 He51cYxwKmcBaPDiY1Sn3LZwTc5mNX61D3y676NGgDqvXZAXRUbSH0YshZyTMrx+wXzM
 xM7nc3qtsv4R2GjWGLwZwnYDddefSrcD9//rl0uChhgcaqQ6kHR4LzZ4/o6THdADbvY7
 o+V9titF5Qx1LdtAgBVBwWCLKSJdZbqcS8ZLVycm6Dn1EAtJSpJ4BLS2XpH1tfS+3DcW
 fCKJDlfz3M3LXL7QKG0mTNZHzEfvSiXVDYgus/BOqg2mTlPxLaCtCQlR6N97L1VkJxna
 2ZsQ==
X-Gm-Message-State: AOJu0Yzt4M81L6ze62PLYCZlkWdx/8i0wgFSsSeYP2OurO0unR8PJ3sJ
 k35VB+Tgcws6bjz+DERB7xxoH5mb48Mklihm51/uYWXmYXaW/6q/bO348KV6bKH2jH9Rcw+DTNJ
 t
X-Google-Smtp-Source: AGHT+IHxFJnG06+VS6vpiApyx8TyF9NHxMcA1RBtUQkNgVbl/5uFYyEz/Cd+O99ikAQY0ZdKIVJgyw==
X-Received: by 2002:a05:600c:35ce:b0:414:5e9d:ad31 with SMTP id
 r14-20020a05600c35ce00b004145e9dad31mr2871529wmq.13.1710863124688; 
 Tue, 19 Mar 2024 08:45:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 dw11-20020a0560000dcb00b0033b66c2d61esm12578388wrb.48.2024.03.19.08.45.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:45:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH-for-9.1 25/27] target/tricore: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:54 +0100
Message-ID: <20240319154258.71206-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/cpu.h | 12 ------------
 target/tricore/cpu.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 220af69fc2..9537fef2b9 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -253,18 +253,6 @@ FIELD(TB_FLAGS, PRIV, 0, 2)
 void cpu_state_reset(CPUTriCoreState *s);
 void tricore_tcg_init(void);
 
-static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    uint32_t new_flags = 0;
-    *pc = env->PC;
-    *cs_base = 0;
-
-    new_flags |= FIELD_DP32(new_flags, TB_FLAGS, PRIV,
-            extract32(env->PSW, 10, 2));
-    *flags = new_flags;
-}
-
 #define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
 
 /* helpers.c */
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index a9af73aeb5..d6ac07a488 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -58,6 +58,18 @@ static void tricore_restore_state_to_opc(CPUState *cs,
     cpu_env(cs)->PC = data[0];
 }
 
+static void tricore_get_cpu_state(CPUTriCoreState *env, vaddr *pc,
+                                  uint64_t *cs_base, uint32_t *flags)
+{
+    uint32_t new_flags = 0;
+    *pc = env->PC;
+    *cs_base = 0;
+
+    new_flags |= FIELD_DP32(new_flags, TB_FLAGS, PRIV,
+                            extract32(env->PSW, 10, 2));
+    *flags = new_flags;
+}
+
 static void tricore_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -168,6 +180,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .initialize = tricore_tcg_init,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
+    .get_cpu_state = tricore_get_cpu_state,
     .tlb_fill = tricore_cpu_tlb_fill,
 };
 
-- 
2.41.0


