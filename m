Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E62CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbd0-0005aO-7n; Tue, 19 Mar 2024 11:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcy-0005Zk-Uz
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:48 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcu-0004tc-UR
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:48 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d2505352e6so64679001fa.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863023; x=1711467823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wt+1/nVbm4UwUNrHtwVfJccIMKB4kkx/gPc6B1UnmDE=;
 b=M+xLodN6o4YytlQ0BuvMaMGvZHAc4IcZDYBgEDDHXEFUS44nQZFSjkqpDYr4DHfcEs
 29EgGNGLkO6rvEpMO7dCBrx6OB5m8tyMBx7V+xvpvLPSDYIM7Ux171sNGs07EwFJDFMh
 Y2TI9jRMctvbh6VmepB/xOfm06Um/OYbDrsSlkvcJ2KMqOm8dUfcIe6K4TBSXYvnaoAm
 5dktWuUHwZsh58Ob4dmVSFoP8yrHVZD171OlK8FdoLbdZCL6DRT5/+BvzCybVm1Ubaxw
 T45xUKDv9fniInOmNzHQzWAqbR3lOLQ2G+BfVUh9FRU/XuA+CVdEPaaToMMxnQ7tv4I2
 3u2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863023; x=1711467823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wt+1/nVbm4UwUNrHtwVfJccIMKB4kkx/gPc6B1UnmDE=;
 b=ESTRv4UFVRN/c5MaoAsiizsz6qsoiin6IL7hVxHnSec1QdM+vizRE+mNuLqSCYOhB0
 S0gx16jZA/7/mdUZFqQIyaUx5TQ1gJfZGs1mKXxT5tGEZAmCp18GWMH+q6vKuLqL/Wfo
 2yrHu7/woF2KKhr6b9dzGJNyBR/zcWw2mcA9ilu27lw49ZCipiVTGpRr32sIVWhzjAsQ
 n9sP53uj+GgiMNmcVzMeGh4maPxU4GepE/RRy1azKQlrG1NgGS7BzmAdnQFnDGgQ+9bO
 SCL/6U5hPYrF1+IgFdzmjys4HUKKlULxO3y//jdX0dGEwFrikcWFdXhxEvPhEbly7PBs
 5frQ==
X-Gm-Message-State: AOJu0YySFkaAuxWhSJ+oi6SyvmZbFzYRKMdwdMazaBeuHPI2i3vYRITz
 8/uYZn2gabikAoQYJqnh8pmNjuyMC8Yvl/gR7WNWM+HzIjuF+bZbJfskNIPxYW6EjjFQ7Evz78Z
 g
X-Google-Smtp-Source: AGHT+IFlPVA6+46gHooYcC+IWoC3HQmzd+iRk6Nw7Da+Qr2A6IiWlww3lTAf8UqzoiR9v7CRPIMB8A==
X-Received: by 2002:a2e:6d02:0:b0:2d2:e44e:a5cc with SMTP id
 i2-20020a2e6d02000000b002d2e44ea5ccmr10123039ljc.46.1710863022845; 
 Tue, 19 Mar 2024 08:43:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 fm24-20020a05600c0c1800b00414650448a7sm2379716wmb.11.2024.03.19.08.43.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:43:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH-for-9.1 07/27] target/cris: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:36 +0100
Message-ID: <20240319154258.71206-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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
 target/cris/cpu.h | 12 ------------
 target/cris/cpu.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index dbd6fb05f0..6df53f49c4 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -273,16 +273,4 @@ enum {
 
 #include "exec/cpu-all.h"
 
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-static inline void cpu_get_tb_cpu_state(CPUCRISState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = env->dslot |
-            (env->pregs[PR_CCS] & (S_FLAG | P_FLAG | U_FLAG
-				     | X_FLAG | PFIX_FLAG));
-}
-
 #endif
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index eb4bddcb7e..8d0b92b96d 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -51,6 +51,15 @@ static void cris_restore_state_to_opc(CPUState *cs,
     cpu->env.pc = data[0];
 }
 
+static void cris_get_cpu_state(CPUCRISState *env, vaddr *pc,
+                               uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = env->dslot |
+        (env->pregs[PR_CCS] & (S_FLAG | P_FLAG | U_FLAG | X_FLAG | PFIX_FLAG));
+}
+
 static bool cris_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
@@ -182,6 +191,7 @@ static const struct SysemuCPUOps cris_sysemu_ops = {
 static const TCGCPUOps crisv10_tcg_ops = {
     .initialize = cris_initialize_crisv10_tcg,
     .restore_state_to_opc = cris_restore_state_to_opc,
+    .get_cpu_state = cris_get_cpu_state,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = cris_cpu_tlb_fill,
@@ -193,6 +203,7 @@ static const TCGCPUOps crisv10_tcg_ops = {
 static const TCGCPUOps crisv32_tcg_ops = {
     .initialize = cris_initialize_tcg,
     .restore_state_to_opc = cris_restore_state_to_opc,
+    .get_cpu_state = cris_get_cpu_state,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = cris_cpu_tlb_fill,
-- 
2.41.0


