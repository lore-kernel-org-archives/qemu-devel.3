Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F75CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC546-0003rW-So; Thu, 23 Oct 2025 19:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC544-0003qv-EZ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC53z-00074y-Kc
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-292fd52d527so15541625ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263386; x=1761868186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3b3KiRFcodjeYXZ9z9ez1yB1uPskn9qGHHcHxHyxcw=;
 b=ds54htcPntKgo9gTBoy1CL0KMom1SKZSTSeb8JgZd0q1VogFHUDfFN1t+SXS/Dij0v
 rOBzSERpjpu5Sm89B8cUJ09ttoBhq/+ypED1ajtBzJ6QBdJxpphewkFfLytZg5AhU15p
 onpumrQvZHu2tpJIrUxz+hoyvHAG5IfthMsGwryp+ce/4Wm8+7oIqgo2vcPmVbMx+vpa
 Ud6E5ynpOaY/uE+vUZWRh7sSahEJZqdVdPXo4LfkhEwf1ttNZEAIKZzcaw5tuQf2/9jZ
 okHWLbDMMZVUxM72Gst0xSySTHPawEiuGtU0FCC+GJHk69gN1IHs57HIzPo/b5voC6/e
 JMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263386; x=1761868186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3b3KiRFcodjeYXZ9z9ez1yB1uPskn9qGHHcHxHyxcw=;
 b=lxITb59Tl5I0sYPNZx4L0GGLYTvdRQtfI/f75Zt7tHdrJOVWlxaNV/ENTdQqaKnoUv
 7QsoDT5d36H+lJIluHYV71n7zK2Fg40HOq14DmvUg+VA3rfgiiRuPgflTxqx1s/PrEFM
 WLQ4RDGY0CPSADFEruCRSCjbirlcxzwtm83rJ2h+snuvEg2beEjLOTok9M7FPAkjPYPC
 tiBgiS+y8ZK8UhdJqpCvQK4el/bmAF/+j2Vlvmnnw7cUAf3jRomSNN+neBTsQxkiP/qS
 gq62DhBeB76tSlCnPNSoyDxJvGkTuwIbFkzBntS9ZvmbUFmdB6SZBvRu2iPhjijfd7iB
 oWyg==
X-Gm-Message-State: AOJu0YyAt/R72tvrZREFBRVIhjvwM5BKiV0EIMxJBXZBup3mNlmuun4L
 PUnppbq7A2/j/H0+IYphWyE57AJLgzCwWtjctbvWNNNi7lwIkeiPmfyum8x5/w==
X-Gm-Gg: ASbGncvegx4J2/vBkCaV4YRD0Byn15YIRMHsqBowO0w5j39co2NhecW03Z+rHXUS/7X
 Gs3gMfE860LqA51gIsq83DCSKbsSGFxBQibKBQSM8u9wnZ7jwtQxCieCHov0htTx0g46E8aTagy
 rc2UTQBGSAiNACA44Y0fn9Fk1ZL74A7qOrSi28na1Jw4iBqukHvU9gJg09NrUJyZ9RzD2oCvSSG
 aSX6IDnmQhpsRQdc/Hc2xcLJcRbJwAaLWtEKgQqbgVdVdJupqO1jo0JAioWWKYaY/koxx9ZGqcl
 naehoUuF3RkqG/cw0rrg71l2UGBt/QDZ9wLJb3fIiibzETPtVQkvHhRSIDskgdceDN7dtKtXvXx
 zSahM2+bMHIp6npAdbit6Gtasc9txxXupVC45DZ4yIMFauJKz80DQQTdFn2DOJ5P48sK5hbE19m
 vy3as3F4C0pBDIhIkTW68m3SsdhsvQtDbn5jKdJzCIMV3qgYETVI5wxOhkz7BmJCC/GQOKiMYzl
 hphp6sjSu6H3i/gRyg=
X-Google-Smtp-Source: AGHT+IFMyMO9OF+w07jV5fCMlMigUGvGZf6NUxFTZb+B8ldV8p++74oY977vUfwLuHjYi2XLSIB0GA==
X-Received: by 2002:a17:902:e5cc:b0:270:4964:ad82 with SMTP id
 d9443c01a7336-2948ba0d9a1mr2195075ad.38.1761263385446; 
 Thu, 23 Oct 2025 16:49:45 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:49:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 02/25] target/riscv: Explode MO_TExx -> MO_TE | MO_xx
Date: Fri, 24 Oct 2025 09:49:04 +1000
Message-ID: <20251023234927.1864284-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Extract the implicit MO_TE definition in order to replace
it in the next commit.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/hexagon); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-3-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c                      | 16 ++--
 target/riscv/insn_trans/trans_rva.c.inc       | 44 ++++-----
 target/riscv/insn_trans/trans_rvd.c.inc       |  4 +-
 target/riscv/insn_trans/trans_rvf.c.inc       |  4 +-
 target/riscv/insn_trans/trans_rvi.c.inc       | 22 ++---
 target/riscv/insn_trans/trans_rvzabha.c.inc   | 20 ++---
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  8 +-
 target/riscv/insn_trans/trans_rvzce.c.inc     | 10 +--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 +-
 target/riscv/insn_trans/trans_xthead.c.inc    | 90 +++++++++----------
 11 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 8382aa94cb..c486f771d3 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -633,7 +633,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TEUW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
 
     return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -642,7 +642,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TEUL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
 
     return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -651,7 +651,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TEUQ, mmu_idx);
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ, mmu_idx);
 
     return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -669,7 +669,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TEUW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
 
     cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -678,7 +678,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TEUL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
 
     cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -687,7 +687,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TEUQ, mmu_idx);
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ, mmu_idx);
 
     cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -703,7 +703,7 @@ target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, true, ra);
-    MemOpIdx oi = make_memop_idx(MO_TEUW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
 
     return cpu_ldw_code_mmu(env, addr, oi, GETPC());
 }
@@ -712,7 +712,7 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, true, ra);
-    MemOpIdx oi = make_memop_idx(MO_TEUL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
 
     return cpu_ldl_code_mmu(env, addr, oi, ra);
 }
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 9cf3ae8019..10e4c55efd 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -99,142 +99,142 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
 static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
 {
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
+    return gen_lr(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
 }
 
 static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 {
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_sc(ctx, a, (MO_ALIGN | MO_TESL));
+    return gen_sc(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
 }
 
 static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SL);
 }
 
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SL);
 }
 
 static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SL);
 }
 
 static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SL);
 }
 
 static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SL);
 }
 
 static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SL);
 }
 
 static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SL);
 }
 
 static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SL);
 }
 
 static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SL);
 }
 
 static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_lr(ctx, a, MO_ALIGN | MO_TEUQ);
+    return gen_lr(ctx, a, MO_ALIGN | MO_TE | MO_UQ);
 }
 
 static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_sc(ctx, a, (MO_ALIGN | MO_TEUQ));
+    return gen_sc(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
 }
 
 static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_UQ);
 }
 
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TEUQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_UQ);
 }
 
 static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TEUQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_UQ);
 }
 
 static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TEUQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_UQ);
 }
 
 static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TEUQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_UQ);
 }
 
 static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TEUQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_UQ);
 }
 
 static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TEUQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_UQ);
 }
 
 static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TEUQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_UQ);
 }
 
 static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TEUQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_UQ);
 }
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 30883ea37c..3385820678 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -42,7 +42,7 @@
 static bool trans_fld(DisasContext *ctx, arg_fld *a)
 {
     TCGv addr;
-    MemOp memop = MO_TEUQ;
+    MemOp memop = MO_TE | MO_UQ;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
@@ -72,7 +72,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
 static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
 {
     TCGv addr;
-    MemOp memop = MO_TEUQ;
+    MemOp memop = MO_TE | MO_UQ;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index ed73afe089..150e2b9a7d 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -43,7 +43,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
 {
     TCGv_i64 dest;
     TCGv addr;
-    MemOp memop = MO_TEUL;
+    MemOp memop = MO_TE | MO_UL;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
@@ -65,7 +65,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
 static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
 {
     TCGv addr;
-    MemOp memop = MO_TEUL;
+    MemOp memop = MO_TE | MO_UL;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index b9c7160468..34012caf1e 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -426,24 +426,24 @@ static bool trans_lb(DisasContext *ctx, arg_lb *a)
 
 static bool trans_lh(DisasContext *ctx, arg_lh *a)
 {
-    return gen_load(ctx, a, MO_TESW);
+    return gen_load(ctx, a, MO_TE | MO_SW);
 }
 
 static bool trans_lw(DisasContext *ctx, arg_lw *a)
 {
-    return gen_load(ctx, a, MO_TESL);
+    return gen_load(ctx, a, MO_TE | MO_SL);
 }
 
 static bool trans_ld(DisasContext *ctx, arg_ld *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
-    return gen_load(ctx, a, MO_TESQ);
+    return gen_load(ctx, a, MO_TE | MO_SQ);
 }
 
 static bool trans_lq(DisasContext *ctx, arg_lq *a)
 {
     REQUIRE_128BIT(ctx);
-    return gen_load(ctx, a, MO_TEUO);
+    return gen_load(ctx, a, MO_TE | MO_UO);
 }
 
 static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
@@ -453,19 +453,19 @@ static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
 
 static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
 {
-    return gen_load(ctx, a, MO_TEUW);
+    return gen_load(ctx, a, MO_TE | MO_UW);
 }
 
 static bool trans_lwu(DisasContext *ctx, arg_lwu *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
-    return gen_load(ctx, a, MO_TEUL);
+    return gen_load(ctx, a, MO_TE | MO_UL);
 }
 
 static bool trans_ldu(DisasContext *ctx, arg_ldu *a)
 {
     REQUIRE_128BIT(ctx);
-    return gen_load(ctx, a, MO_TEUQ);
+    return gen_load(ctx, a, MO_TE | MO_UQ);
 }
 
 static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
@@ -521,24 +521,24 @@ static bool trans_sb(DisasContext *ctx, arg_sb *a)
 
 static bool trans_sh(DisasContext *ctx, arg_sh *a)
 {
-    return gen_store(ctx, a, MO_TESW);
+    return gen_store(ctx, a, MO_TE | MO_SW);
 }
 
 static bool trans_sw(DisasContext *ctx, arg_sw *a)
 {
-    return gen_store(ctx, a, MO_TESL);
+    return gen_store(ctx, a, MO_TE | MO_SL);
 }
 
 static bool trans_sd(DisasContext *ctx, arg_sd *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
-    return gen_store(ctx, a, MO_TEUQ);
+    return gen_store(ctx, a, MO_TE | MO_UQ);
 }
 
 static bool trans_sq(DisasContext *ctx, arg_sq *a)
 {
     REQUIRE_128BIT(ctx);
-    return gen_store(ctx, a, MO_TEUO);
+    return gen_store(ctx, a, MO_TE | MO_UO);
 }
 
 static bool trans_addd(DisasContext *ctx, arg_addd *a)
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
index ce8edcba62..25db42d24c 100644
--- a/target/riscv/insn_trans/trans_rvzabha.c.inc
+++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
@@ -79,55 +79,55 @@ static bool trans_amomaxu_b(DisasContext *ctx, arg_amomaxu_b *a)
 static bool trans_amoswap_h(DisasContext *ctx, arg_amoswap_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SW);
 }
 
 static bool trans_amoadd_h(DisasContext *ctx, arg_amoadd_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SW);
 }
 
 static bool trans_amoxor_h(DisasContext *ctx, arg_amoxor_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SW);
 }
 
 static bool trans_amoand_h(DisasContext *ctx, arg_amoand_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SW);
 }
 
 static bool trans_amoor_h(DisasContext *ctx, arg_amoor_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SW);
 }
 
 static bool trans_amomin_h(DisasContext *ctx, arg_amomin_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SW);
 }
 
 static bool trans_amomax_h(DisasContext *ctx, arg_amomax_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SW);
 }
 
 static bool trans_amominu_h(DisasContext *ctx, arg_amominu_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SW);
 }
 
 static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SW);
 }
 
 static bool trans_amocas_b(DisasContext *ctx, arg_amocas_b *a)
@@ -141,5 +141,5 @@ static bool trans_amocas_h(DisasContext *ctx, arg_amocas_h *a)
 {
     REQUIRE_ZACAS(ctx);
     REQUIRE_ZABHA(ctx);
-    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TESW);
+    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TE | MO_SW);
 }
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
index 15e688a033..5e7c7c92b7 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -25,7 +25,7 @@
 static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)
 {
     REQUIRE_ZACAS(ctx);
-    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TESL);
+    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TE | MO_SL);
 }
 
 static TCGv_i64 get_gpr_pair(DisasContext *ctx, int reg_num)
@@ -88,10 +88,10 @@ static bool trans_amocas_d(DisasContext *ctx, arg_amocas_d *a)
     REQUIRE_ZACAS(ctx);
     switch (get_ol(ctx)) {
     case MXL_RV32:
-        return gen_cmpxchg64(ctx, a, MO_ALIGN | MO_TEUQ);
+        return gen_cmpxchg64(ctx, a, MO_ALIGN | MO_TE | MO_UQ);
     case MXL_RV64:
     case MXL_RV128:
-        return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TEUQ);
+        return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TE | MO_UQ);
     default:
         g_assert_not_reached();
     }
@@ -123,7 +123,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
     tcg_gen_concat_i64_i128(dest, destl, desth);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx,
-                                (MO_ALIGN | MO_TEUO));
+                                (MO_ALIGN | MO_TE | MO_UO));
 
     tcg_gen_extr_i128_i64(destl, desth, dest);
 
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index dd15af0f54..d130179432 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -88,13 +88,13 @@ static bool trans_c_lbu(DisasContext *ctx, arg_c_lbu *a)
 static bool trans_c_lhu(DisasContext *ctx, arg_c_lhu *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_load(ctx, a, MO_TEUW);
+    return gen_load(ctx, a, MO_TE | MO_UW);
 }
 
 static bool trans_c_lh(DisasContext *ctx, arg_c_lh *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_load(ctx, a, MO_TESW);
+    return gen_load(ctx, a, MO_TE | MO_SW);
 }
 
 static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
@@ -106,7 +106,7 @@ static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
 static bool trans_c_sh(DisasContext *ctx, arg_c_sh *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_store(ctx, a, MO_TEUW);
+    return gen_store(ctx, a, MO_TE | MO_UW);
 }
 
 #define X_S0    8
@@ -175,7 +175,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
         return false;
     }
 
-    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_TEUL : MO_TEUQ;
+    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_TE | MO_UL : MO_TE | MO_UQ;
     int reg_size = memop_size(memop);
     target_ulong stack_adj = ROUND_UP(ctpop32(reg_bitmap) * reg_size, 16) +
                              a->spimm;
@@ -228,7 +228,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_push *a)
         return false;
     }
 
-    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_TEUL : MO_TEUQ;
+    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_TE | MO_UL : MO_TE | MO_UQ;
     int reg_size = memop_size(memop);
     target_ulong stack_adj = ROUND_UP(ctpop32(reg_bitmap) * reg_size, 16) +
                              a->spimm;
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
index bece48e600..eec478afcb 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -57,7 +57,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     }
 
     dest = cpu_fpr[a->rd];
-    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, MO_TEUW);
+    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, MO_TE | MO_UW);
     gen_nanbox_h(dest, dest);
 
     mark_fs_dirty(ctx);
@@ -79,7 +79,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
         t0 = temp;
     }
 
-    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUW);
+    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TE | MO_UW);
 
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index f4a1c12ca0..c555596617 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -105,7 +105,7 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
     src1 = get_address(ctx, a->rs1, 0);
 
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
-                           (MO_ALIGN | MO_TESL));
+                           (MO_ALIGN | MO_TE | MO_SL));
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
@@ -134,7 +134,7 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
     src1 = get_address(ctx, a->rs1, 0);
 
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
-                           (MO_ALIGN | MO_TESQ));
+                           (MO_ALIGN | MO_TE | MO_SQ));
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 22488412d4..754cb80e22 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -379,7 +379,7 @@ static bool trans_th_flrd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fload_idx(ctx, a, MO_TEUQ, false);
+    return gen_fload_idx(ctx, a, MO_TE | MO_UQ, false);
 }
 
 static bool trans_th_flrw(DisasContext *ctx, arg_th_memidx *a)
@@ -387,7 +387,7 @@ static bool trans_th_flrw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fload_idx(ctx, a, MO_TEUL, false);
+    return gen_fload_idx(ctx, a, MO_TE | MO_UL, false);
 }
 
 static bool trans_th_flurd(DisasContext *ctx, arg_th_memidx *a)
@@ -395,7 +395,7 @@ static bool trans_th_flurd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fload_idx(ctx, a, MO_TEUQ, true);
+    return gen_fload_idx(ctx, a, MO_TE | MO_UQ, true);
 }
 
 static bool trans_th_flurw(DisasContext *ctx, arg_th_memidx *a)
@@ -403,7 +403,7 @@ static bool trans_th_flurw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fload_idx(ctx, a, MO_TEUL, true);
+    return gen_fload_idx(ctx, a, MO_TE | MO_UL, true);
 }
 
 static bool trans_th_fsrd(DisasContext *ctx, arg_th_memidx *a)
@@ -411,7 +411,7 @@ static bool trans_th_fsrd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fstore_idx(ctx, a, MO_TEUQ, false);
+    return gen_fstore_idx(ctx, a, MO_TE | MO_UQ, false);
 }
 
 static bool trans_th_fsrw(DisasContext *ctx, arg_th_memidx *a)
@@ -419,7 +419,7 @@ static bool trans_th_fsrw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fstore_idx(ctx, a, MO_TEUL, false);
+    return gen_fstore_idx(ctx, a, MO_TE | MO_UL, false);
 }
 
 static bool trans_th_fsurd(DisasContext *ctx, arg_th_memidx *a)
@@ -427,7 +427,7 @@ static bool trans_th_fsurd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fstore_idx(ctx, a, MO_TEUQ, true);
+    return gen_fstore_idx(ctx, a, MO_TE | MO_UQ, true);
 }
 
 static bool trans_th_fsurw(DisasContext *ctx, arg_th_memidx *a)
@@ -435,7 +435,7 @@ static bool trans_th_fsurw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fstore_idx(ctx, a, MO_TEUL, true);
+    return gen_fstore_idx(ctx, a, MO_TE | MO_UL, true);
 }
 
 /* XTheadFmv */
@@ -598,64 +598,64 @@ static bool trans_th_ldia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TESQ, false);
+    return gen_load_inc(ctx, a, MO_TE | MO_SQ, false);
 }
 
 static bool trans_th_ldib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TESQ, true);
+    return gen_load_inc(ctx, a, MO_TE | MO_SQ, true);
 }
 
 static bool trans_th_lwia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TESL, false);
+    return gen_load_inc(ctx, a, MO_TE | MO_SL, false);
 }
 
 static bool trans_th_lwib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TESL, true);
+    return gen_load_inc(ctx, a, MO_TE | MO_SL, true);
 }
 
 static bool trans_th_lwuia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TEUL, false);
+    return gen_load_inc(ctx, a, MO_TE | MO_UL, false);
 }
 
 static bool trans_th_lwuib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TEUL, true);
+    return gen_load_inc(ctx, a, MO_TE | MO_UL, true);
 }
 
 static bool trans_th_lhia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TESW, false);
+    return gen_load_inc(ctx, a, MO_TE | MO_SW, false);
 }
 
 static bool trans_th_lhib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TESW, true);
+    return gen_load_inc(ctx, a, MO_TE | MO_SW, true);
 }
 
 static bool trans_th_lhuia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TEUW, false);
+    return gen_load_inc(ctx, a, MO_TE | MO_UW, false);
 }
 
 static bool trans_th_lhuib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TEUW, true);
+    return gen_load_inc(ctx, a, MO_TE | MO_UW, true);
 }
 
 static bool trans_th_lbia(DisasContext *ctx, arg_th_meminc *a)
@@ -686,38 +686,38 @@ static bool trans_th_sdia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_inc(ctx, a, MO_TESQ, false);
+    return gen_store_inc(ctx, a, MO_TE | MO_SQ, false);
 }
 
 static bool trans_th_sdib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_inc(ctx, a, MO_TESQ, true);
+    return gen_store_inc(ctx, a, MO_TE | MO_SQ, true);
 }
 
 static bool trans_th_swia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TESL, false);
+    return gen_store_inc(ctx, a, MO_TE | MO_SL, false);
 }
 
 static bool trans_th_swib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TESL, true);
+    return gen_store_inc(ctx, a, MO_TE | MO_SL, true);
 }
 
 static bool trans_th_shia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TESW, false);
+    return gen_store_inc(ctx, a, MO_TE | MO_SW, false);
 }
 
 static bool trans_th_shib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TESW, true);
+    return gen_store_inc(ctx, a, MO_TE | MO_SW, true);
 }
 
 static bool trans_th_sbia(DisasContext *ctx, arg_th_meminc *a)
@@ -769,32 +769,32 @@ static bool trans_th_lrd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TESQ, false);
+    return gen_load_idx(ctx, a, MO_TE | MO_SQ, false);
 }
 
 static bool trans_th_lrw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TESL, false);
+    return gen_load_idx(ctx, a, MO_TE | MO_SL, false);
 }
 
 static bool trans_th_lrwu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TEUL, false);
+    return gen_load_idx(ctx, a, MO_TE | MO_UL, false);
 }
 
 static bool trans_th_lrh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TESW, false);
+    return gen_load_idx(ctx, a, MO_TE | MO_SW, false);
 }
 
 static bool trans_th_lrhu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TEUW, false);
+    return gen_load_idx(ctx, a, MO_TE | MO_UW, false);
 }
 
 static bool trans_th_lrb(DisasContext *ctx, arg_th_memidx *a)
@@ -813,19 +813,19 @@ static bool trans_th_srd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_idx(ctx, a, MO_TESQ, false);
+    return gen_store_idx(ctx, a, MO_TE | MO_SQ, false);
 }
 
 static bool trans_th_srw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TESL, false);
+    return gen_store_idx(ctx, a, MO_TE | MO_SL, false);
 }
 
 static bool trans_th_srh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TESW, false);
+    return gen_store_idx(ctx, a, MO_TE | MO_SW, false);
 }
 
 static bool trans_th_srb(DisasContext *ctx, arg_th_memidx *a)
@@ -837,32 +837,32 @@ static bool trans_th_lurd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TESQ, true);
+    return gen_load_idx(ctx, a, MO_TE | MO_SQ, true);
 }
 
 static bool trans_th_lurw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TESL, true);
+    return gen_load_idx(ctx, a, MO_TE | MO_SL, true);
 }
 
 static bool trans_th_lurwu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TEUL, true);
+    return gen_load_idx(ctx, a, MO_TE | MO_UL, true);
 }
 
 static bool trans_th_lurh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TESW, true);
+    return gen_load_idx(ctx, a, MO_TE | MO_SW, true);
 }
 
 static bool trans_th_lurhu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TEUW, true);
+    return gen_load_idx(ctx, a, MO_TE | MO_UW, true);
 }
 
 static bool trans_th_lurb(DisasContext *ctx, arg_th_memidx *a)
@@ -881,19 +881,19 @@ static bool trans_th_surd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_idx(ctx, a, MO_TESQ, true);
+    return gen_store_idx(ctx, a, MO_TE | MO_SQ, true);
 }
 
 static bool trans_th_surw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TESL, true);
+    return gen_store_idx(ctx, a, MO_TE | MO_SL, true);
 }
 
 static bool trans_th_surh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TESW, true);
+    return gen_store_idx(ctx, a, MO_TE | MO_SW, true);
 }
 
 static bool trans_th_surb(DisasContext *ctx, arg_th_memidx *a)
@@ -931,19 +931,19 @@ static bool trans_th_ldd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_loadpair_tl(ctx, a, MO_TESQ, 4);
+    return gen_loadpair_tl(ctx, a, MO_TE | MO_SQ, 4);
 }
 
 static bool trans_th_lwd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
-    return gen_loadpair_tl(ctx, a, MO_TESL, 3);
+    return gen_loadpair_tl(ctx, a, MO_TE | MO_SL, 3);
 }
 
 static bool trans_th_lwud(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
-    return gen_loadpair_tl(ctx, a, MO_TEUL, 3);
+    return gen_loadpair_tl(ctx, a, MO_TE | MO_UL, 3);
 }
 
 static bool gen_storepair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
@@ -967,13 +967,13 @@ static bool trans_th_sdd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_storepair_tl(ctx, a, MO_TESQ, 4);
+    return gen_storepair_tl(ctx, a, MO_TE | MO_SQ, 4);
 }
 
 static bool trans_th_swd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
-    return gen_storepair_tl(ctx, a, MO_TESL, 3);
+    return gen_storepair_tl(ctx, a, MO_TE | MO_SL, 3);
 }
 
 /* XTheadSync */
-- 
2.51.0


