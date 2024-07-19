Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDC7C3DA64
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc6c-00053Q-GX; Thu, 18 Jul 2024 21:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc69-0003iK-70
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc62-0000q6-HH
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:45 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fc49c1f3e5so13757575ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721351260; x=1721956060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvZQYGxfhFbqPHPcUgtNXtbdH2OSgyvIGjZjBPS5VAI=;
 b=Qp/x/VGLybP0vyIxTGb+r6mCd8Zl1fLG16iE0QcK4JmBKN5F24wtlZheYeBmIPTRjY
 v/IbZg2QjfsBMlGy0PYxigUJ6omZ7p6r63vu9fsvRNuCzkVBHHsRScu71i/pVn1OkNli
 yplbRVXDp7dogSEip9DRDUyyHsLB4MMZQnIUTngy4GT0Rj3OqoyOuegjrycyecIE6P52
 4HKKUS7E74uTm+JdQgmGGUbvtcV8G99zjSGGXsCVaUcnsPWl8MSmDmVwBBeyos/aOvwK
 KIB2Y/tBFSixOxG1Qga/9xtck5ksgZUNkWPUPdhe216BZf7mKRS1pzdkjbBC+N7zcVUy
 PGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721351260; x=1721956060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qvZQYGxfhFbqPHPcUgtNXtbdH2OSgyvIGjZjBPS5VAI=;
 b=fgl2bOEVJti3gRCY6A8BKMeymdMmOMhobLnPOrimCjabWhZHhWTSaEoTyb+mRuhduM
 +nUfhRyl3fPzPMzw33vsUblEk2MuzawYMoCptvOAGMIkjXG+4MyXk+cda3ZNATGanVCQ
 xP6nA3oLuSInvI1hHC+pjb6LsRaHkk1PuEihLDqd0LADusiB7OGuLP7Jy2CJ3Zqh//oU
 4+GkT0/C9bb3Po4oEfDxqlbGrJ3hgBXW4BglB+GaQuy3Phxjysb0KWjigBe5gNCleQF2
 nv8Nm9X5jXySvkOO41JSHsgVChBVhhT6Wn/RGnaMTck2/T+qHR/p8QL/EOavIiDEWAag
 +wMw==
X-Gm-Message-State: AOJu0YxiwN8ETFSPKLUCKqmcigJ1Gv3Y0vTbzPBdtLtg/tkKyO4eI4MZ
 g92WeV4NIPDwp5Ona8jbclkz4hWEBoYU+zSa0uC0+gOuXzmfYAw26+OH5cGrTX/hoP9v3g2cAEs
 MiWUxpA==
X-Google-Smtp-Source: AGHT+IEhShR4rbjVadeAzsZ6y3mE12DJBk/PLdYiyQ7nyE6yqdqr13dYaQvcDp745V/4WD8olMBOHw==
X-Received: by 2002:a17:903:2451:b0:1fb:57e7:5bab with SMTP id
 d9443c01a7336-1fc4e16191fmr52789145ad.36.1721351259904; 
 Thu, 18 Jul 2024 18:07:39 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d07ad9sm2067415ad.177.2024.07.18.18.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 18:07:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v3 07/12] target/ppc: Merge helper_{dcbz,dcbzep}
Date: Fri, 19 Jul 2024 11:07:02 +1000
Message-ID: <20240719010707.1319675-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719010707.1319675-1-richard.henderson@linaro.org>
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Merge the two and pass the mmu_idx directly from translation.
Swap the argument order in dcbz_common to avoid extra swaps.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h     |  3 +--
 target/ppc/mem_helper.c | 14 ++++----------
 target/ppc/translate.c  |  4 ++--
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index afc56855ff..4fa089cbf9 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -46,8 +46,7 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
 DEF_HELPER_4(lsw, void, env, tl, i32, i32)
 DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
 DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
-DEF_HELPER_FLAGS_2(dcbz, TCG_CALL_NO_WG, void, env, tl)
-DEF_HELPER_FLAGS_2(dcbzep, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, int)
 #ifdef TARGET_PPC64
 DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
 #endif
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index d4957efd6e..24bae3b80c 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -271,7 +271,7 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
 }
 
 static void dcbz_common(CPUPPCState *env, target_ulong addr,
-                        int dcbz_size, int mmu_idx, uintptr_t retaddr)
+                        int mmu_idx, int dcbz_size, uintptr_t retaddr)
 {
     target_ulong mask = ~(target_ulong)(dcbz_size - 1);
     void *haddr;
@@ -296,15 +296,9 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     }
 }
 
-void helper_dcbz(CPUPPCState *env, target_ulong addr)
+void helper_dcbz(CPUPPCState *env, target_ulong addr, int mmu_idx)
 {
-    dcbz_common(env, addr, env->dcache_line_size,
-                ppc_env_mmu_index(env, false), GETPC());
-}
-
-void helper_dcbzep(CPUPPCState *env, target_ulong addr)
-{
-    dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GETPC());
+    dcbz_common(env, addr, mmu_idx, env->dcache_line_size, GETPC());
 }
 
 #ifdef TARGET_PPC64
@@ -320,7 +314,7 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr)
         dcbz_size = 32;
     }
 
-    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
+    dcbz_common(env, addr, ppc_env_mmu_index(env, false), dcbz_size, GETPC());
 }
 #endif
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9e472ab7ef..cba943a49d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4458,7 +4458,7 @@ static void gen_dcbz(DisasContext *ctx)
     }
 #endif
 
-    gen_helper_dcbz(tcg_env, tcgv_addr);
+    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(ctx->mem_idx));
 }
 
 /* dcbzep */
@@ -4468,7 +4468,7 @@ static void gen_dcbzep(DisasContext *ctx)
 
     gen_set_access_type(ctx, ACCESS_CACHE);
     gen_addr_reg_index(ctx, tcgv_addr);
-    gen_helper_dcbzep(tcg_env, tcgv_addr);
+    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(PPC_TLB_EPID_STORE));
 }
 
 /* dst / dstt */
-- 
2.43.0


