Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B971F4BB7A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuy88-0002Kc-OW; Tue, 24 Feb 2026 14:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuy7h-0001tQ-5B
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:31:10 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuy7b-0000pq-5Q
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:31:08 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so914535e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771961460; x=1772566260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5mvKXt71l6TX2SjTD1rBiImXi8PdwKcev8DyFv9G1A=;
 b=rkVsOSiSFJlQkVnRGcfGIPIYkgXUSZ4shBRCFnDQ2NQ7Z1yzaYk2VEpi1RcDyHvhtu
 yHED5K62CtkioxOCy+/XKoPJKEYiRWYgS0AwZos7sizj366fGg1WZ6FbsUWZg4qLPUD4
 TpBwi4jP2bosg6No6RIxPpcSATRis3viihvzWCEwTxvajsU9sXZHyJPKbfftG1zID9m+
 wYktPpl9PiZGBzG4O8q+eQx0W3l9rzn/eWbnwd3GA+eZiwuWSiZjoR3nJC6THb1XWKrt
 7dPF42Ep1kiG15Jo0aScb4A4chnHyDa0yTgEplWYBku02szlFtadO5SmBV6jhHIHG5L8
 DIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961460; x=1772566260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q5mvKXt71l6TX2SjTD1rBiImXi8PdwKcev8DyFv9G1A=;
 b=XGLzYDl+Xdb8JJNWtcP6Xc5yzgQDOnpqHhDhUPTTqKfePYS6B94n5ZvgJAYVczJgcM
 da1x8jiHrMPLsgjOkLc/aIM/e7T1PSUU9+RdBKBxH49oyntZG484j67uvTubSozlAdxy
 Mh02PkNBH5s/DcW1Vj/ZZ7MyYKuY4599Ah6Rbb0Mzm2HvDCASOZ0+WUel2+8Ss/eVoBD
 jSwIj1iI2zyj/UQTZZNxchFJnYI/A0oFAXfvOdO9/TzSRyE1UV/W0YTWkNC9Y6iQeIuP
 3ow54e1dlok5A5kDlaRoLrAyp5lvjGTd+F/r6UATxLY4Bfu1gNlFrhv+iXhWiZSYOJsh
 m/LA==
X-Gm-Message-State: AOJu0Yx2sInZPKSA/p5lm4WN3LFwf5Y5CX1djCbBT1QMDgh2nNMak4L6
 HObECSwu2Ahg37XU11sOCuwqUexS5HFN8oyVHTZNhbKordhbsO9c83W28N8ey1xp5v9UhZLbICL
 MaDeCYro=
X-Gm-Gg: AZuq6aLrxutIPua6RBeXzj0c4HDCbbD4NOizLBN9ohhErWRJVCC6O1/PIHnbWbhpLd3
 /aQCTgXc2n86J5A4bTtczNU3AXR82qB23DX3ep4H+auMap9axXzpN4fFXoc0IqVSIPx/HkNXd0B
 YJ4iFMB/8nLV3TzfqxT/C5RshSTt0rUP9agaEGOkgXLBSb+BajYkUrGR+jcV09IgJEcvSFZ4fK6
 5WRnpMrUOmNc5LJ6b7jjRVsm0mzd1CgHFEDee51dqV4i8V52C8v9Hd0PKzWArs6nIQyv0IRBuwk
 t//NaLJcBENISJi80p11mBbfh9gGIWnQxhJD6/6f7yrzDgrHeerO1cdF3EFSBLoeE6w6MTWVnUH
 lAkkXGTHgHxdEYmTIDKdlg+/9AU4EPPHp/nQn8w3uCdiDXR/kikqwgXKw0e7GBIWHQocd4KGF3L
 M26dyMORJSbp+3HeVfkffeSJIVXxn8sienQTUgHypZ08yX0mhujvNVjKZqKfbC6rjjTyiB0agE
X-Received: by 2002:a05:600c:8b56:b0:483:7b99:131d with SMTP id
 5b1f17b1804b1-483bd75e26emr21201015e9.16.1771961460101; 
 Tue, 24 Feb 2026 11:31:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7031f3sm18692815e9.6.2026.02.24.11.30.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 11:30:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH 4/5] target/tcg: Rename raise_exception() helpers
Date: Tue, 24 Feb 2026 20:30:26 +0100
Message-ID: <20260224193028.2370-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224193028.2370-1-philmd@linaro.org>
References: <20260224193028.2370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In order to avoid symbol name clash when building
a single binary, rename TCG helpers prefixing with
the target name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/gen_tcg.h      | 2 +-
 target/hexagon/helper.h       | 2 +-
 target/i386/helper.h          | 2 +-
 target/m68k/helper.h          | 2 +-
 target/microblaze/helper.h    | 2 +-
 target/ppc/helper.h           | 2 +-
 target/sparc/helper.h         | 2 +-
 target/hexagon/op_helper.c    | 2 +-
 target/hexagon/translate.c    | 2 +-
 target/i386/tcg/excp_helper.c | 2 +-
 target/i386/tcg/translate.c   | 2 +-
 target/m68k/op_helper.c       | 2 +-
 target/m68k/translate.c       | 2 +-
 target/microblaze/op_helper.c | 2 +-
 target/microblaze/translate.c | 2 +-
 target/ppc/tcg-excp_helper.c  | 2 +-
 target/ppc/translate.c        | 6 +++---
 target/sparc/helper.c         | 2 +-
 target/sparc/translate.c      | 6 +++---
 19 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 7b96dab9185..7ceab81817c 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1365,7 +1365,7 @@
         uiV = uiV; \
         tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->pkt->pc); \
         TCGv excp = tcg_constant_tl(HEX_EVENT_TRAP0); \
-        gen_helper_raise_exception(tcg_env, excp); \
+        gen_helper_hexagon_raise_exception(tcg_env, excp); \
     } while (0)
 #endif
 
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 64456822bc1..021f9364ad8 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -18,7 +18,7 @@
 #include "internal.h"
 #include "helper_protos_generated.h.inc"
 
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32)
+DEF_HELPER_FLAGS_2(hexagon_raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
diff --git a/target/i386/helper.h b/target/i386/helper.h
index 3f67098f11f..8099c40cc90 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -56,7 +56,7 @@ DEF_HELPER_2(syscall, void, env, int)
 DEF_HELPER_2(sysret, void, env, int)
 DEF_HELPER_FLAGS_1(pause, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_3(raise_interrupt, TCG_CALL_NO_WG, noreturn, env, int, int)
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
+DEF_HELPER_FLAGS_2(x86_raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
 DEF_HELPER_FLAGS_1(icebp, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_3(boundw, void, env, tl, int)
 DEF_HELPER_3(boundl, void, env, tl, int)
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 0bda8f8152d..a76d455cde1 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -111,7 +111,7 @@ DEF_HELPER_3(set_mac_extu, void, env, i32, i32)
 DEF_HELPER_2(flush_flags, void, env, i32)
 DEF_HELPER_2(set_ccr, void, env, i32)
 DEF_HELPER_FLAGS_1(get_ccr, TCG_CALL_NO_WG_SE, i32, env)
-DEF_HELPER_2(raise_exception, noreturn, env, i32)
+DEF_HELPER_2(m68k_raise_exception, noreturn, env, i32)
 
 DEF_HELPER_FLAGS_3(bfffo_reg, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 
diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 1429c1727ef..e589a8422f0 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,4 +1,4 @@
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
+DEF_HELPER_FLAGS_2(microblaze_raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index e99c8c824b4..3548af5f1c0 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -1,5 +1,5 @@
 DEF_HELPER_FLAGS_3(raise_exception_err, TCG_CALL_NO_WG, noreturn, env, i32, i32)
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
+DEF_HELPER_FLAGS_2(ppc_raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_4(TW, TCG_CALL_NO_WG, void, env, tl, tl, i32)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_4(TD, TCG_CALL_NO_WG, void, env, tl, tl, i32)
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 3a7f7dc1296..6de773445fe 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -53,7 +53,7 @@ DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, i32, env, i128, i128)
 DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, i32, env, i128, i128)
 DEF_HELPER_FLAGS_3(flcmps, TCG_CALL_NO_RWG_SE, i32, env, f32, f32)
 DEF_HELPER_FLAGS_3(flcmpd, TCG_CALL_NO_RWG_SE, i32, env, f64, f64)
-DEF_HELPER_2(raise_exception, noreturn, env, int)
+DEF_HELPER_2(sparc_raise_exception, noreturn, env, int)
 
 DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_WG, f64, env, f64, f64)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 368391bb846..605fd95e2a5 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -46,7 +46,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
     cpu_loop_exit_restore(cs, pc);
 }
 
-G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp)
+G_NORETURN void HELPER(hexagon_raise_exception)(CPUHexagonState *env, uint32_t excp)
 {
     hexagon_raise_exception_err(env, excp, 0);
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8a223f6e13e..8e6949640ee 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -119,7 +119,7 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
 
 static void gen_exception_raw(int excp)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
+    gen_helper_hexagon_raise_exception(tcg_env, tcg_constant_i32(excp));
 }
 
 static void gen_exec_counters(DisasContext *ctx)
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 32f2784e923..f503f1863ee 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -31,7 +31,7 @@ G_NORETURN void helper_raise_interrupt(CPUX86State *env, int intno,
     raise_interrupt(env, intno, next_eip_addend);
 }
 
-G_NORETURN void helper_raise_exception(CPUX86State *env, int exception_index)
+G_NORETURN void helper_x86_raise_exception(CPUX86State *env, int exception_index)
 {
     raise_exception(env, exception_index);
 }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 14210d569f7..adcc887d80f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1515,7 +1515,7 @@ static void gen_exception(DisasContext *s, int trapno)
 {
     gen_update_cc_op(s);
     gen_update_eip_cur(s);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(trapno));
+    gen_helper_x86_raise_exception(tcg_env, tcg_constant_i32(trapno));
     s->base.is_jmp = DISAS_NORETURN;
 }
 
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 8148a8852e7..be4edcbc5b8 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -552,7 +552,7 @@ G_NORETURN static void raise_exception(CPUM68KState *env, int tt)
     raise_exception_ra(env, tt, 0);
 }
 
-void HELPER(raise_exception)(CPUM68KState *env, uint32_t tt)
+void HELPER(m68k_raise_exception)(CPUM68KState *env, uint32_t tt)
 {
     raise_exception(env, tt);
 }
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index abc1c79f3cd..e169d252935 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -252,7 +252,7 @@ static void gen_jmp(DisasContext *s, TCGv dest)
 
 static void gen_raise_exception(int nr)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(nr));
+    gen_helper_m68k_raise_exception(tcg_env, tcg_constant_i32(nr));
 }
 
 static void gen_raise_exception_format2(DisasContext *s, int nr,
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 31da2c7c3ae..6f964635244 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -61,7 +61,7 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
     return 0xdead0000 | id;
 }
 
-void helper_raise_exception(CPUMBState *env, uint32_t index)
+void helper_microblaze_raise_exception(CPUMBState *env, uint32_t index)
 {
     CPUState *cs = env_cpu(env);
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8b896abf0e5..0f753c1595d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -97,7 +97,7 @@ static void t_sync_flags(DisasContext *dc)
 
 static void gen_raise_exception(DisasContext *dc, uint32_t index)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(index));
+    gen_helper_microblaze_raise_exception(tcg_env, tcg_constant_i32(index));
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 5e6c1e326d4..3f4fd7f0c23 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -49,7 +49,7 @@ void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
     raise_exception_err_ra(env, exception, error_code, 0);
 }
 
-void helper_raise_exception(CPUPPCState *env, uint32_t exception)
+void helper_ppc_raise_exception(CPUPPCState *env, uint32_t exception)
 {
     raise_exception_err_ra(env, exception, 0, 0);
 }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a09a6df93fd..f26b0281737 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -334,7 +334,7 @@ static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
 
     gen_update_nip(ctx, nip);
     t0 = tcg_constant_i32(excp);
-    gen_helper_raise_exception(tcg_env, t0);
+    gen_helper_ppc_raise_exception(tcg_env, t0);
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -377,8 +377,8 @@ static void gen_debug_exception(DisasContext *ctx, bool rfi_type)
         gen_load_spr(t0, SPR_BOOKE_DBSR);
         tcg_gen_ori_tl(t0, t0, dbsr);
         gen_store_spr(SPR_BOOKE_DBSR, t0);
-        gen_helper_raise_exception(tcg_env,
-                                   tcg_constant_i32(POWERPC_EXCP_DEBUG));
+        gen_helper_ppc_raise_exception(tcg_env,
+                                       tcg_constant_i32(POWERPC_EXCP_DEBUG));
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
         if (!rfi_type) { /* BookS does not single step rfi type instructions */
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index c5d88de37c9..7b0023fba45 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -32,7 +32,7 @@ void cpu_raise_exception_ra(CPUSPARCState *env, int tt, uintptr_t ra)
     cpu_loop_exit_restore(cs, ra);
 }
 
-void helper_raise_exception(CPUSPARCState *env, int tt)
+void helper_sparc_raise_exception(CPUSPARCState *env, int tt)
 {
     CPUState *cs = env_cpu(env);
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7e8558dbbd8..3e4e6f14748 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1048,7 +1048,7 @@ static void gen_exception(DisasContext *dc, int which)
 {
     finishing_insn(dc);
     save_state(dc);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(which));
+    gen_helper_sparc_raise_exception(tcg_env, tcg_constant_i32(which));
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -2811,7 +2811,7 @@ static bool do_tcc(DisasContext *dc, int cond, int cc,
     /* Trap always.  */
     if (cond == 8) {
         save_state(dc);
-        gen_helper_raise_exception(tcg_env, trap);
+        gen_helper_sparc_raise_exception(tcg_env, trap);
         dc->base.is_jmp = DISAS_NORETURN;
         return true;
     }
@@ -5833,7 +5833,7 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         if (e->npc % 4 == 0) {
             tcg_gen_movi_tl(cpu_npc, e->npc);
         }
-        gen_helper_raise_exception(tcg_env, e->excp);
+        gen_helper_sparc_raise_exception(tcg_env, e->excp);
 
         e_next = e->next;
         g_free(e);
-- 
2.52.0


