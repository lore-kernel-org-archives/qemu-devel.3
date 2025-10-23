Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DF2CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54K-0003vO-Oa; Thu, 23 Oct 2025 19:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54E-0003uF-NO
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54C-000784-Du
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:02 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2897522a1dfso14202275ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263399; x=1761868199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dT1VY6c3XA4W7tm/UffiQu1Cbfu56OKc9VjdmzDBxLA=;
 b=gb4Heeka+AWGX26AgYHlEXzmKLfEsboOuGlM9LXx5lOsnXol6lvFh2P43BWqYUvP0a
 T4Ufuj/vAxeEo/Dzucufk33kCea8aIJh3+mYQ7oBuSvqKNDZCQDftRUGhbbrVXHa6YDc
 D7BvkClCzFtHAM0OGl3N0hYOTNHqdb8q1Se4lRJ775KiLEqhZXTNiUV97LTYUuLKtgVy
 wJECF9gHsQzSp4PVFwTpbodZ1jNF6zgS/jlG/KppDtKyD9pm4+oB44g/oQJIXn65YGkD
 N1+Gr4NcS7+d1QESX6yJqu08XCN6zoZuqNA3RIQYkbQ18RruYkRgs1FLeor23ZBKG7V/
 zn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263399; x=1761868199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dT1VY6c3XA4W7tm/UffiQu1Cbfu56OKc9VjdmzDBxLA=;
 b=xHhP6oyyJ2LsmjlVmUx84UXaKP0kyWXY7oAT7pjy5nJe09PGZ2ZLHjSSwnVbAmg1KE
 NIrGuQQp2JopUhWRMFOimvMoChcGhPd9g/kOK/wQXCxHm1FBtei0faca1NnapAkAqREk
 cE0EjeuvgTejjs261ohq3pZS6g98eAdtWgvbXLujnzPb+kaA5oRZbqvh0lv0Dzbx9ACR
 KXkY7pKog3XTnJtIctWHUKpobVJvpHski013JCSUEXt0mfVYupqc0QtY4npzxGy2TLwW
 6CztIpraYiI7Bt6bwRne6eIJ/oM0bIkyzSMOxoae3irVf9RUjjk6y+vUp9tz5iyq5Icj
 7HFg==
X-Gm-Message-State: AOJu0YyErctV99Z6CzC4KPQGs1FHDHPSScs0OsgGwhvv4mN3xEh+oY+r
 YzBbZc8SOZt88D8H1gjhqMFNQahZClQL+KXSSqsqUG1b9CMmlsh1ISmIFzsO5Q==
X-Gm-Gg: ASbGncvseBMcN60+2GB8+wRr3ed8i0qCAXlSR+hqJaH4U0akk4lfhaIv72VwwtZyDQ7
 XnWX+lJspc+cbUBEkxT8KVQb1oSekE0pW4w1ZgOCZ/T+FaCGK6C7MuNqG0tvVxDK8oP+PZC3glK
 tL07DZNXntvDCRp3n9sFSpJgvAaRci+7lDQCuuCqCrCztF4/cYt/ODCnXkkMTKSPyd7cfpjoEZ6
 Y2GPg7oD9hr6MyjbNRLDNqvkUrRtq7g2AFlhwIOJB5bqnYXg6LpZh+NE9iC+j0QMYhEbcuWQgUq
 uHzz1bO4rr9uxroN5dBx0F9QNHFSfy2+1VM2w7In6uJ+q5sWIvCN6awk+X3ZuzcrN+csUgWhCP3
 eJicHs39Sm0+8k0nVQQwa6DURZe1+EiDV8h/qVouu1ETGhIwXmlNJROZJRHjPgnABhRkzKeDVAa
 wck7adJPeNAAdtTT/fRLy8F7ZBbT152K7TzMkimfkg7tP5Qudvs+Xi4fQSMkdQdmnBEOPXNfCcB
 IAQQG54FFVyk+f/AwU=
X-Google-Smtp-Source: AGHT+IG6B3yIRE4HJ07yBUcw3gsDmLmnMbWTiRBkGUNz5hRj4HLNs5/JHHB/Ay5Lpgn/97oYMFJVaA==
X-Received: by 2002:a17:902:cecb:b0:27e:ec72:f6d with SMTP id
 d9443c01a7336-2946de3d929mr51880115ad.11.1761263398609; 
 Thu, 23 Oct 2025 16:49:58 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:49:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 06/25] target/riscv: Conceal MO_TE within gen_load_idx() /
 gen_store_idx()
Date: Fri, 24 Oct 2025 09:49:08 +1000
Message-ID: <20251023234927.1864284-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

All callers of gen_load_idx() / gen_store_idx() set the MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-7-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 34 ++++++++++++----------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 7e69906e5b..70c563664a 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -745,6 +745,7 @@ static bool gen_load_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv rd = dest_gpr(ctx, a->rd);
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
+    memop |= MO_TE;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, rd);
 
@@ -762,6 +763,7 @@ static bool gen_store_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv data = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
+    memop |= MO_TE;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
 
     return true;
@@ -771,32 +773,32 @@ static bool trans_th_lrd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SQ, false);
+    return gen_load_idx(ctx, a, MO_SQ, false);
 }
 
 static bool trans_th_lrw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SL, false);
+    return gen_load_idx(ctx, a, MO_SL, false);
 }
 
 static bool trans_th_lrwu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_UL, false);
+    return gen_load_idx(ctx, a, MO_UL, false);
 }
 
 static bool trans_th_lrh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SW, false);
+    return gen_load_idx(ctx, a, MO_SW, false);
 }
 
 static bool trans_th_lrhu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_UW, false);
+    return gen_load_idx(ctx, a, MO_UW, false);
 }
 
 static bool trans_th_lrb(DisasContext *ctx, arg_th_memidx *a)
@@ -815,19 +817,19 @@ static bool trans_th_srd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SQ, false);
+    return gen_store_idx(ctx, a, MO_SQ, false);
 }
 
 static bool trans_th_srw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SL, false);
+    return gen_store_idx(ctx, a, MO_SL, false);
 }
 
 static bool trans_th_srh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SW, false);
+    return gen_store_idx(ctx, a, MO_SW, false);
 }
 
 static bool trans_th_srb(DisasContext *ctx, arg_th_memidx *a)
@@ -839,32 +841,32 @@ static bool trans_th_lurd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SQ, true);
+    return gen_load_idx(ctx, a, MO_SQ, true);
 }
 
 static bool trans_th_lurw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SL, true);
+    return gen_load_idx(ctx, a, MO_SL, true);
 }
 
 static bool trans_th_lurwu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_UL, true);
+    return gen_load_idx(ctx, a, MO_UL, true);
 }
 
 static bool trans_th_lurh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SW, true);
+    return gen_load_idx(ctx, a, MO_SW, true);
 }
 
 static bool trans_th_lurhu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_UW, true);
+    return gen_load_idx(ctx, a, MO_UW, true);
 }
 
 static bool trans_th_lurb(DisasContext *ctx, arg_th_memidx *a)
@@ -883,19 +885,19 @@ static bool trans_th_surd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SQ, true);
+    return gen_store_idx(ctx, a, MO_SQ, true);
 }
 
 static bool trans_th_surw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SL, true);
+    return gen_store_idx(ctx, a, MO_SL, true);
 }
 
 static bool trans_th_surh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SW, true);
+    return gen_store_idx(ctx, a, MO_SW, true);
 }
 
 static bool trans_th_surb(DisasContext *ctx, arg_th_memidx *a)
-- 
2.51.0


