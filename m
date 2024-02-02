Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CF3C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmS5-0001BL-Sx; Fri, 02 Feb 2024 00:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmS4-0001Ad-3a
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:00 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmS2-0001ej-DN
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:59 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d7005ea1d0so316617a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853057; x=1707457857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CLw1/Gtxm8k7/hVT+/nUKJ1+Eret/bnzWs0hJWPqBU=;
 b=LRi6k5Yhvqbq4I+mjtEtyFUxZSE4uzoPsDSqx3C/vAjhvcfRO+MMhZ/C15u8Ycg+LQ
 ViF9083iKb+tRqRwmc8/7nwe6YV8Agx12G8k/75nFFKltvlZ5G5cGHcmnUnGQKwMrqdW
 uPEkrD7Or5qYEuuwG3uWaX1tS1yJOV1WTYdV5av+QMzNfBrkv5bojp4spfaUNHA3ZuaN
 4jNikSBmlch61KgXHoC9V49OSrylRYqWDESo/L0G1Cqu+JrXnJ4TVRgsyvG6RFog6pFW
 1pvBysSxr8Imc81FHVnDGFvDGt2eonYqms7C7Dw8aQrGLYAP0OmuMJvsEU2RRcKttDeG
 5rDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853057; x=1707457857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CLw1/Gtxm8k7/hVT+/nUKJ1+Eret/bnzWs0hJWPqBU=;
 b=KW2k4Re48Dnt2h1TSj/p2QOyBN+pvLs23S9Qk4jRCGEuK8SDHOJfny0cTYbbfJItb9
 yGM9tjU/KqS0e39ohrrxweCmi2ihzmTIcsB1SfzSaJMjsWrUNYIcK834XQb8phRoqvQM
 Zil6+V4mmgaSVsM38FPoxDqHn3R+86o9/+FecjH4vbjtpn8ThJRJUbsDmpRYypZE7y1u
 Vldetra7MOsFiW0itucbj8ZBKKjP2haVVFeN/lmCbndkspHwQYBY0Vk622at5wiK862D
 PaVacvB/70te5Hhvlck0uc6aBNGy14ORnD9Ry/N5hTqdYppBQgoHqrLmAoDR7gPiYmq2
 KPcQ==
X-Gm-Message-State: AOJu0YyviD/gG5FunjB+psS08rlWGWWjQU3u56XnTg2c5CCRWNpBqK6S
 zlWhoXjOhAJ7H/2S0vrQvYzLHFQuHkOz1S+T6xKGGJ4mOxP0HhqoOGYu5sbgdAEUrOD3UY9211Z
 gh0A=
X-Google-Smtp-Source: AGHT+IFwrIwsLJCFvmGvVrp2tqWk9TpixBT1mUeohYf1yVkbqOpbe8xB8QX8X0JMQ43QUHjV0TfHFg==
X-Received: by 2002:a05:6a20:d905:b0:19e:39cb:b35b with SMTP id
 jd5-20020a056a20d90500b0019e39cbb35bmr1753012pzb.12.1706853057195; 
 Thu, 01 Feb 2024 21:50:57 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:50:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/57] target/cris: Cache mem_index in DisasContext
Date: Fri,  2 Feb 2024 15:49:46 +1000
Message-Id: <20240202055036.684176-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Compute this value once for each translation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/translate.c         | 14 +++++---------
 target/cris/translate_v10.c.inc |  6 ++----
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index ee1402a9a3..7acea29a01 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -94,6 +94,7 @@ typedef struct DisasContext {
 
     CRISCPU *cpu;
     target_ulong pc, ppc;
+    int mem_index;
 
     /* Decoder.  */
         unsigned int (*decoder)(CPUCRISState *env, struct DisasContext *dc);
@@ -1008,37 +1009,31 @@ static inline void cris_prepare_jmp (DisasContext *dc, unsigned int type)
 
 static void gen_load64(DisasContext *dc, TCGv_i64 dst, TCGv addr)
 {
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
-
     /* If we get a fault on a delayslot we must keep the jmp state in
        the cpu-state to be able to re-execute the jmp.  */
     if (dc->delayed_branch == 1) {
         cris_store_direct_jmp(dc);
     }
 
-    tcg_gen_qemu_ld_i64(dst, addr, mem_index, MO_TEUQ);
+    tcg_gen_qemu_ld_i64(dst, addr, dc->mem_index, MO_TEUQ);
 }
 
 static void gen_load(DisasContext *dc, TCGv dst, TCGv addr, 
              unsigned int size, int sign)
 {
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
-
     /* If we get a fault on a delayslot we must keep the jmp state in
        the cpu-state to be able to re-execute the jmp.  */
     if (dc->delayed_branch == 1) {
         cris_store_direct_jmp(dc);
     }
 
-    tcg_gen_qemu_ld_tl(dst, addr, mem_index,
+    tcg_gen_qemu_ld_tl(dst, addr, dc->mem_index,
                        MO_TE + ctz32(size) + (sign ? MO_SIGN : 0));
 }
 
 static void gen_store (DisasContext *dc, TCGv addr, TCGv val,
                unsigned int size)
 {
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
-
     /* If we get a fault on a delayslot we must keep the jmp state in
        the cpu-state to be able to re-execute the jmp.  */
     if (dc->delayed_branch == 1) {
@@ -1055,7 +1050,7 @@ static void gen_store (DisasContext *dc, TCGv addr, TCGv val,
         return;
     }
 
-    tcg_gen_qemu_st_tl(val, addr, mem_index, MO_TE + ctz32(size));
+    tcg_gen_qemu_st_tl(val, addr, dc->mem_index, MO_TE + ctz32(size));
 
     if (dc->flags_x) {
         cris_evaluate_flags(dc);
@@ -2971,6 +2966,7 @@ static void cris_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->cpu = env_archcpu(env);
     dc->ppc = pc_start;
     dc->pc = pc_start;
+    dc->mem_index = cpu_mmu_index(env, false);
     dc->flags_uptodate = 1;
     dc->flags_x = tb_flags & X_FLAG;
     dc->cc_x_uptodate = 0;
diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.inc
index 6df599fdce..73fc27c15d 100644
--- a/target/cris/translate_v10.c.inc
+++ b/target/cris/translate_v10.c.inc
@@ -91,8 +91,6 @@ static void gen_store_v10_conditional(DisasContext *dc, TCGv addr, TCGv val,
 static void gen_store_v10(DisasContext *dc, TCGv addr, TCGv val,
                        unsigned int size)
 {
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
-
     /* If we get a fault on a delayslot we must keep the jmp state in
        the cpu-state to be able to re-execute the jmp.  */
     if (dc->delayed_branch == 1) {
@@ -101,11 +99,11 @@ static void gen_store_v10(DisasContext *dc, TCGv addr, TCGv val,
 
     /* Conditional writes. */
     if (dc->flags_x) {
-        gen_store_v10_conditional(dc, addr, val, size, mem_index);
+        gen_store_v10_conditional(dc, addr, val, size, dc->mem_index);
         return;
     }
 
-    tcg_gen_qemu_st_tl(val, addr, mem_index, ctz32(size) | MO_TE);
+    tcg_gen_qemu_st_tl(val, addr, dc->mem_index, ctz32(size) | MO_TE);
 }
 
 
-- 
2.34.1


