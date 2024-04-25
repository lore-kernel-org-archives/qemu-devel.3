Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608C2C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWN-0001xv-BM; Thu, 25 Apr 2024 06:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWM-0001xS-FT
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:06 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWK-000751-Oz
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-343d2b20c4bso605454f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041603; x=1714646403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=957rAqnR2jdbtNnjgxfqiz7CRvR1nL/QXsIUUvuurzY=;
 b=i4et7G0tr6OLfDSOHucAWHm/rDT+IhiKqY+c9xiwX10PL0tMvtAmNnNxYOvN11Ke9+
 UsScK4r3TZDfpkx06CxzLJT1BPuTaCa57WDKvLg0HGiWxaIx20VIohTrfPUU3rViarcW
 uGL+hv1JF2AabOdg+YCKjvqfTLRdCfskcdkz5IP1fqE5XvgjFr6qh6IMpR8WWch7clPR
 MP3+X89EQTmwWg5meS/RuGTBgJZ6r5zwDqJVQDEa7YhFw2NhPdHNjdoeYyGR8Qx9fUWd
 7sqcaF9Y0gEn3QYEk8XGShnBKmYNlIw7W9vi0kpUn671sZr/gC9PZHJVZ8ySxKVO0FCJ
 lX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041603; x=1714646403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=957rAqnR2jdbtNnjgxfqiz7CRvR1nL/QXsIUUvuurzY=;
 b=H7sBMriT+71a28l2Lx2lQd1oaGa9MhlmVea9T9NZdLRqvEQI8GRxwv1/owqecnkQs+
 f0PCXe9hf8vuiAUbwQFlKvDtcRG3eSL/o7fEnNU3aYU6Pmj4SRbLMhk0vmXs3NRJScQS
 B1TK9W6JYDO5qa+qX9z6y6VsLwY50fGoodEPKcB2a47vj4X8wmmu/OQkDLVbyiIyQ4ru
 ZEWezfTte0rsFQMzT+M5TIqDvFzlrmdrfTqQ20HP7SqJZ+EymEX/WaKHDxclUXtccyeM
 LBC1Ha9TYE14rflbH2ZgfaMnNKxkKR3iO7v+Dad0r5QpljS76N4shRqOse4kKqVgZ+Uv
 qnpQ==
X-Gm-Message-State: AOJu0YykC4Hw28B/IGdOD3XwYR2J92NS0h582lm+WoKDeZKR05BIZxva
 Ily1dfOomYy17nh/rMJyvsPWo5Kbtog4hfrWCH7PGq2i3oCc5JOb22E/5ItLtcNbfVnQAtZa1cd
 a
X-Google-Smtp-Source: AGHT+IF57MvCH0I+WRvuZIvG4vQo1H2m8Na0/u8rmqxDPUb6n9oeSOS3vISd3nPf/cr1z5K3H2yEdQ==
X-Received: by 2002:adf:8b5d:0:b0:34b:2a61:b3c9 with SMTP id
 v29-20020adf8b5d000000b0034b2a61b3c9mr4093361wra.40.1714041602822; 
 Thu, 25 Apr 2024 03:40:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/37] target/arm: Implement ALLINT MSR (immediate)
Date: Thu, 25 Apr 2024 11:39:25 +0100
Message-Id: <20240425103958.3237225-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Add ALLINT MSR (immediate) to decodetree, in which the CRm is 0b000x. The
EL0 check is necessary to ALLINT, and the EL1 check is necessary when
imm == 1. So implement it inline for EL2/3, or EL1 with imm==0. Avoid the
unconditional write to pc and use raise_exception_ra to unwind.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-5-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.h    |  1 +
 target/arm/tcg/a64.decode      |  1 +
 target/arm/tcg/helper-a64.c    | 12 ++++++++++++
 target/arm/tcg/translate-a64.c | 19 +++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 575a5dab7dc..05181653999 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -22,6 +22,7 @@ DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(msr_i_spsel, void, env, i32)
 DEF_HELPER_2(msr_i_daifset, void, env, i32)
 DEF_HELPER_2(msr_i_daifclear, void, env, i32)
+DEF_HELPER_1(msr_set_allint_el1, void, env)
 DEF_HELPER_3(vfp_cmph_a64, i64, f16, f16, ptr)
 DEF_HELPER_3(vfp_cmpeh_a64, i64, f16, f16, ptr)
 DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, ptr)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8a20dce3c8f..0e7656fd158 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -207,6 +207,7 @@ MSR_i_DIT       1101 0101 0000 0 011 0100 .... 010 11111 @msr_i
 MSR_i_TCO       1101 0101 0000 0 011 0100 .... 100 11111 @msr_i
 MSR_i_DAIFSET   1101 0101 0000 0 011 0100 .... 110 11111 @msr_i
 MSR_i_DAIFCLEAR 1101 0101 0000 0 011 0100 .... 111 11111 @msr_i
+MSR_i_ALLINT    1101 0101 0000 0 001 0100 000 imm:1 000 11111
 MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
 
 # MRS, MSR (register), SYS, SYSL. These are all essentially the
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 29f3ef274ae..0ea8668ab4c 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -66,6 +66,18 @@ void HELPER(msr_i_spsel)(CPUARMState *env, uint32_t imm)
     update_spsel(env, imm);
 }
 
+void HELPER(msr_set_allint_el1)(CPUARMState *env)
+{
+    /* ALLINT update to PSTATE. */
+    if (arm_hcrx_el2_eff(env) & HCRX_TALLINT) {
+        raise_exception_ra(env, EXCP_UDEF,
+                           syn_aa64_sysregtrap(0, 1, 0, 4, 1, 0x1f, 0), 2,
+                           GETPC());
+    }
+
+    env->pstate |= PSTATE_ALLINT;
+}
+
 static void daif_check(CPUARMState *env, uint32_t op,
                        uint32_t imm, uintptr_t ra)
 {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2666d527111..976094a5c80 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2036,6 +2036,25 @@ static bool trans_MSR_i_DAIFCLEAR(DisasContext *s, arg_i *a)
     return true;
 }
 
+static bool trans_MSR_i_ALLINT(DisasContext *s, arg_i *a)
+{
+    if (!dc_isar_feature(aa64_nmi, s) || s->current_el == 0) {
+        return false;
+    }
+
+    if (a->imm == 0) {
+        clear_pstate_bits(PSTATE_ALLINT);
+    } else if (s->current_el > 1) {
+        set_pstate_bits(PSTATE_ALLINT);
+    } else {
+        gen_helper_msr_set_allint_el1(tcg_env);
+    }
+
+    /* Exit the cpu loop to re-evaluate pending IRQs. */
+    s->base.is_jmp = DISAS_UPDATE_EXIT;
+    return true;
+}
+
 static bool trans_MSR_i_SVCR(DisasContext *s, arg_MSR_i_SVCR *a)
 {
     if (!dc_isar_feature(aa64_sme, s) || a->mask == 0) {
-- 
2.34.1


