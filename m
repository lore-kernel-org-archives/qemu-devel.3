Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0930CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXv-0008ML-Mh; Wed, 10 Jun 2026 12:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXO-0007aY-1v
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXL-0005TB-1J
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b8a97b11so77596295e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107933; x=1781712733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=El56dZdw91xVdKpOmDbdLupw4D1PeRbVSNshzuKZI5Y=;
 b=J1kh7KtA9AEd4YG7U3JZZJIlAM8G6St6h5A2wjsipjgrQyzPZBHIF4OjykZcaDeZCT
 e8ldAu1qtrTHzpDt+b4BRZTFtIx7goPPr58j6V423XSgxduqCiykZhykZz/7LWLij0Vr
 84YIpONeTxs5XwzmAOTUjTIHm940sv8faaOjuM3x/Iaqzg5UIz1OGyi/REvJzJX1dp5o
 VHEFsqTXk0r2uh09ptV3mC/XbCnIlk2a/Y1BZ5Xej8+m6g/2NIzYAlra9g8YdO4fA8on
 oFIaLQc+YvzW3QFEqK9qorE1vF2rld0Aa5IZwX+WnB+CD4C+2blY/o/CXJKyUAJgs5Cr
 Ikhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107933; x=1781712733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=El56dZdw91xVdKpOmDbdLupw4D1PeRbVSNshzuKZI5Y=;
 b=QOiCf2uRsg8c+R414D45ugkIyOv9VyVZ5xpGptqsvSjM3Ja0aB6iCskoudaQfgbFed
 u7VYbe/RpX+FsaciASawYRXLo0LjMzNGBEOE1huPeQugVBsiJGivCj3vtOAT9Ljv9ZrA
 VGw43X9UU3Em1qDwlQ40uFWuTY0wfqFlL2eW2vy9coDpC1GLm7qH6JbXgbctWAZsxDY6
 AJvcfSLR0T3zHm4uY/f3lsPfy+bJdG9KkA+bWhfweXdj4NLVx/zM5zCpCL9WtluB/EyF
 girBzu4eTmQ7/5cPLerEjzWhupNp/w/BzXWqX0i5+8eUipAbSVGyU4rOGnnJYVYNRxsM
 3vug==
X-Gm-Message-State: AOJu0YzXla4g0TipTCF4pNBiAD+7hGR+BYkPx9xjz2MBUPTPLovyQqc1
 /+v0lKLKRByhdeySZv90WGWHfl/qrAw/vflT7hMvt+rsFONZmDLruo18Vmz+KcRzX6yWN4DhNhH
 MyYvZ
X-Gm-Gg: Acq92OF7scvC9/p1mSPoOw/qP919ep2Vy4YLVQHt44xc1yynzpix8OnRMtHF+YdKohC
 KB5uO0TAi0irOW6z3jSHWhY7b8n0aIiREUGmbBQD3aAIqQbeFW4xsIYLR3tDZNnGLruJl78mSjO
 Y+Msf+fkOjWPkR+S7vcmgubmf2mJEgiCsVWnVMRluqGgBu+gDzoItDBPvEX2oyMrbNC5gpSokZ4
 pFFpXycWzNVCsJxzP8uGWpVERJNOdGmIcG+PHdohYGBVd9CYFuD46jMnarg1iPoGul0SQR06lul
 FpS0RIgCb3sEjrkxCsXHbu4/71Gepj5mjJ5+vyvlapzyqiNtryWZPOShrZB5QNyyNapayajkCgR
 KQQU3dA9bYLFDxP+RuDSo0LPpSEzbflGVDLS4eKhmTOj5MNZVRSPmSJ3KSwAszhd7E2+KU0HrGX
 Cna7FkXqL7HvLv4iRhMhtQN9v2gHka+MX0kQeJmeiZR3flaVw0wb3dVgkjidGZFbTncpXmLNLcp
 AIXa3EwJU5EklH8/Am3bxZ2pfpRKAFB+dX+ANhVYFE=
X-Received: by 2002:a05:600c:45c4:b0:490:4ee0:82ff with SMTP id
 5b1f17b1804b1-490c25fcfafmr438106795e9.27.1781107933305; 
 Wed, 10 Jun 2026 09:12:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/71] target/arm: add MTX to MTEDESC and DisasContext
Date: Wed, 10 Jun 2026 17:10:58 +0100
Message-ID: <20260610161202.2235298-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

Add fields for MTX to DisasContext and MTEDESC. With MTE4, the fields
will be needed in future patches that alter tag check, tag load and tag
store behavior.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-6-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               | 1 +
 target/arm/tcg/hflags.c        | 2 ++
 target/arm/tcg/translate-a64.c | 7 +++++++
 target/arm/tcg/translate.h     | 1 +
 4 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 08f04a57af..dd939ab22b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2536,6 +2536,7 @@ FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
 FIELD(TBFLAG_A64, FPMR_EL, 45, 2)
 FIELD(TBFLAG_A64, MTE_STORE_ONLY, 47, 1)
 FIELD(TBFLAG_A64, MTE0_STORE_ONLY, 48, 1)
+FIELD(TBFLAG_A64, MTX, 49, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index d9d783489c..0716ca98fd 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -500,6 +500,8 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
         /* Cache TCMA as well as TBI. */
         DP_TBFLAG_A64(flags, TCMA, aa64_va_parameter_tcma(tcr, mmu_idx));
+        /* Cache MTX. */
+        DP_TBFLAG_A64(flags, MTX, mtx);
     }
 
     if (cpu_isar_feature(aa64_gcs, env_archcpu(env))) {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5165d964ab..b5c9c9c166 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -312,6 +312,7 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, ALIGN, memop_alignment_bits(memop));
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, memop_size(memop) - 1);
 
         ret = tcg_temp_new_i64();
@@ -345,6 +346,7 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, ALIGN, memop_alignment_bits(single_mop));
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, total_size - 1);
 
         ret = tcg_temp_new_i64();
@@ -3093,6 +3095,7 @@ static void handle_sys(DisasContext *s, bool isread,
             desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
             desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
             desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+            desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
 
             tcg_rt = tcg_temp_new_i64();
             gen_helper_mte_check_zva(tcg_rt, tcg_env,
@@ -4960,6 +4963,7 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue,
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, true);
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         /* SIZEM1 and ALIGN we leave 0 (byte write) */
     }
     /* The helper function always needs the memidx even with MTE disabled */
@@ -5014,11 +5018,13 @@ static bool do_CPY(DisasContext *s, arg_cpy *a, bool is_epilogue, CpyFn fn)
     if (s->mte_active[runpriv]) {
         rdesc = FIELD_DP32(rdesc, MTEDESC, TBI, s->tbid);
         rdesc = FIELD_DP32(rdesc, MTEDESC, TCMA, s->tcma);
+        rdesc = FIELD_DP32(rdesc, MTEDESC, MTX, s->mtx);
     }
     if (s->mte_active[wunpriv]) {
         wdesc = FIELD_DP32(wdesc, MTEDESC, TBI, s->tbid);
         wdesc = FIELD_DP32(wdesc, MTEDESC, TCMA, s->tcma);
         wdesc = FIELD_DP32(wdesc, MTEDESC, WRITE, true);
+        wdesc = FIELD_DP32(wdesc, MTEDESC, MTX, s->mtx);
     }
     /* The helper function needs these parts of the descriptor regardless */
     rdesc = FIELD_DP32(rdesc, MTEDESC, MIDX, rmemidx);
@@ -10809,6 +10815,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->mte_active[1] = EX_TBFLAG_A64(tb_flags, MTE0_ACTIVE);
     dc->mte_store_only[0] = EX_TBFLAG_A64(tb_flags, MTE_STORE_ONLY);
     dc->mte_store_only[1] = EX_TBFLAG_A64(tb_flags, MTE0_STORE_ONLY);
+    dc->mtx = EX_TBFLAG_A64(tb_flags, MTX);
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 551c6ff347..37a7268b32 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -82,6 +82,7 @@ typedef struct DisasContext {
     uint8_t tbii;      /* TBI1|TBI0 for insns */
     uint8_t tbid;      /* TBI1|TBI0 for data */
     uint8_t tcma;      /* TCMA1|TCMA0 for MTE */
+    uint8_t mtx;       /* MTX1|MTX0 for MTE */
     bool ns;        /* Use non-secure CPREG bank on access */
     int fp_excp_el; /* FP exception EL or 0 if enabled */
     int sve_excp_el; /* SVE exception EL or 0 if enabled */
-- 
2.43.0


