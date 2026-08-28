Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE87C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x052J-0002rH-Ad; Fri, 28 Aug 2026 18:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x052I-0002qC-8X
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x052F-0002Kb-2d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d715f4a587so21368525ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787956010; x=1788560810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BlDhmUu6FRHdcxkTrfu/H3G5UIOzp8QqwoOoZ5rTi2Y=;
 b=eqNqd2GXpo1e5IZXjnU3Oiz4IX3esEg6HxdFlBSTLRpoLhe+l8nyI1RcYm/Rq7jrcQ
 2c3Eac9+6w5cxyaSQ/QQIxlVr6w1HozRuKTdZAmMJ1LJkdrJ5oKwTDlVibXO1MnF8k6X
 1dfCDYntvU349GCmT0Oxi/x+bh+RT8F55oxA6l6a1awaHr5f8nah1ocHnMfjrtL9MHSW
 zLhKoHRYvuO9ME5ZmJWtMSkqnxsDFdW9jO38LRTzCalebxo4nurc1huuMFrQFlcIMYuD
 mLRpbZXKkZWWJGycLxv5sv7dlFkfaUX5z7J972gft/OePZkytn1nFIFKddyrTPWnULMd
 ZlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787956010; x=1788560810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BlDhmUu6FRHdcxkTrfu/H3G5UIOzp8QqwoOoZ5rTi2Y=;
 b=MNyiLwUsVGdwUB6R1bi4k3pCaH+H8H3PCXOiC5ratfJUAYXPQb6/auDAHciGRTX0Fq
 ZJQT+UAHy3vcvH7cp4erOuLrgPJy3dTczW/hAvIfHI0dnqwzycI5WhRj94V3ZlTHDqhk
 vfTgLsd1yqUmaB8UtK9QXyjHOu6IKOhDPDoHgAs0yGViwRRMxGvydy1QDtPZvOv9khNN
 Ic2WVkHKWCCX/sEdojuM7ph/E7PklochaOFIGXWw82kDD7nqf+KDEqOmNtdtTHAmNhMm
 Ri210oTNj7eBBj8unqfd9eF5SNRRQsHCT3Fi9LGFZwvcHcZvyAvrdNHlmiFdkxfDZ5SB
 0XGw==
X-Gm-Message-State: AFuF++kMqKMwbOUy02rkPT+1UKZNodZOy06OM4nQgyDsBDJiTPbbC3X7
 md5YGoWt920BiyrTqBkg7b5OTwiwmTo0JBMNF7PnOV1X6R3xLNibLKya6p26MhYZsUzNPMLcQ9V
 wz3QqIVA=
X-Gm-Gg: AYBFou1cf2yP3ZuEIPoSEWitU179KEMfDIz14Bo/NJ5cSsq2jmhu3O/5SGCB0wgtUMZ
 Zmcchn5/2eqwwhJ+K/tUr7nGEOv4M8Bk8PpP/s2bdgv+x88gwMTHRXhd2IQFYz883tqwApzPzPh
 YsYHB4gb5d4KqyyHwfduQEifiZQRU5qjaicdOVZE5gTKAbuWpCP1zNamMbhGbA0nE0qXB7WtaoQ
 1wr7aLomb/XfkyXIEgfEJFIHC9EWCbwCpM2X7A2/Vd8SlotiAfiLyDkA4HPPoo4YGx6kPIsbNYh
 PzRkN8SADqJKB035HSdsHkVAAEJ1rQ2+bcQZjX40LQXwX82AsSmd3nIl1CWp4wiSgnIrhYnA26D
 Db6YuhaAAkzC5RUSQ7aMk4mrsoEzxE65LIB4mjc2aTvUyqp+/ooJeji5f1tNLpFkFVYpcHigExc
 xE7cbyFEUsK8ftC+qQPlFo8SsjjVvc4HoszfUiqEYMtGKLyxG2QDyJsgPMYWUAxS+FoRRtqpVi9
 4Tb0WlyJ+ksA3pJ3Mum
X-Received: by 2002:a17:903:1b25:b0:2d8:d4cc:5bb3 with SMTP id
 d9443c01a7336-2d8d4cc5d8bmr40860725ad.19.1787956009699; 
 Fri, 28 Aug 2026 15:26:49 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759640270sm9178355ad.34.2026.08.28.15.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:26:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/13] target/arm: Add PSTATE.UINJ to tbflags
Date: Fri, 28 Aug 2026 15:26:37 -0700
Message-ID: <20260828222639.1432046-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828222639.1432046-1-richard.henderson@linaro.org>
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               | 1 +
 target/arm/tcg/translate.h     | 2 ++
 target/arm/tcg/hflags.c        | 6 ++++++
 target/arm/tcg/translate-a64.c | 1 +
 target/arm/tcg/translate.c     | 1 +
 5 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b7ee215257f..4fe8bff998d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2483,6 +2483,7 @@ FIELD(TBFLAG_ANY, ALIGN_MEM, 10, 1)
 FIELD(TBFLAG_ANY, PSTATE__IL, 11, 1)
 FIELD(TBFLAG_ANY, FGT_ACTIVE, 12, 1)
 FIELD(TBFLAG_ANY, FGT_SVC, 13, 1)
+FIELD(TBFLAG_ANY, PSTATE__UINJ, 14, 1)
 
 /*
  * Bit usage when in AArch32 state, both A- and M-profile.
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 31f52a34a68..f633aa265f0 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -155,6 +155,8 @@ typedef struct DisasContext {
     bool align_mem;
     /* True if PSTATE.IL is set */
     bool pstate_il;
+    /* True if PSTATE.UINJ is set */
+    bool pstate_uinj;
     /* True if PSTATE.SM is set. */
     bool pstate_sm;
     /* True if PSTATE.ZA is set. */
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 296ec8101ab..174f4aa746f 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -292,6 +292,9 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
     if (env->uncached_cpsr & CPSR_IL) {
         DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
     }
+    if (env->pstate & PSTATE_UINJ) {
+        DP_TBFLAG_ANY(flags, PSTATE__UINJ, 1);
+    }
 
     /*
      * The SME exception we are testing for is raised via
@@ -513,6 +516,9 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     if (env->pstate & PSTATE_IL) {
         DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
     }
+    if (env->pstate & PSTATE_UINJ) {
+        DP_TBFLAG_ANY(flags, PSTATE__UINJ, 1);
+    }
 
     if (arm_fgt_active(env, el)) {
         DP_TBFLAG_ANY(flags, FGT_ACTIVE, 1);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4f9a93950b1..026a2a72d05 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11014,6 +11014,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
     dc->align_mem = EX_TBFLAG_ANY(tb_flags, ALIGN_MEM);
     dc->pstate_il = EX_TBFLAG_ANY(tb_flags, PSTATE__IL);
+    dc->pstate_uinj = EX_TBFLAG_ANY(tb_flags, PSTATE__UINJ);
     dc->fgt_active = EX_TBFLAG_ANY(tb_flags, FGT_ACTIVE);
     dc->fgt_svc = EX_TBFLAG_ANY(tb_flags, FGT_SVC);
     dc->trap_eret = EX_TBFLAG_A64(tb_flags, TRAP_ERET);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c866148383f..40929a6ef78 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6382,6 +6382,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
     dc->align_mem = EX_TBFLAG_ANY(tb_flags, ALIGN_MEM);
     dc->pstate_il = EX_TBFLAG_ANY(tb_flags, PSTATE__IL);
+    dc->pstate_uinj = EX_TBFLAG_ANY(tb_flags, PSTATE__UINJ);
     dc->fgt_active = EX_TBFLAG_ANY(tb_flags, FGT_ACTIVE);
     dc->fgt_svc = EX_TBFLAG_ANY(tb_flags, FGT_SVC);
 
-- 
2.53.0


