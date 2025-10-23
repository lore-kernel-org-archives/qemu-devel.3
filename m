Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66ADCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54A-0003sD-DM; Thu, 23 Oct 2025 19:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC547-0003rn-SP
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:55 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC546-00076V-0t
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:55 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-292fd52d527so15542665ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263392; x=1761868192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGpmIeocnZY/4VSw8Tb8CrQJTwcXNtaQEyLBeJL6A8U=;
 b=F4p2LpIpiEM11be6G/TGtXXGP/i4Kc+23vobl1fxKJ44i/CsGfsSxtyfFQFU1hqo0X
 Fn7ZH3qwyIDvFxdyslbaem3JKsviqtdVSPqgU5Q8AWJV5fcsfK7jQHnGSB4Cu/mp9NeS
 BLVg5Vy+qCpvv7yFY3AxL/VkBNvtfRShZZwi6eoEWyKtgfHDQPBDwibi+fqK8SJU3mqd
 xh02H8FEDQLVMtHff9RV2uz9dtHHrioUfQL7OGTtGmnoP638fT3WC85IpOzGiEtOuG23
 /GfTTc2bfETSkVfyuwVtZ7m84iS+le2I92g0Vq0HVaNVNm623zNFrzB9YbmcoK+ZO4C3
 Ed4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263392; x=1761868192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGpmIeocnZY/4VSw8Tb8CrQJTwcXNtaQEyLBeJL6A8U=;
 b=K7OOEtlwkJYp28Klr9vmP+PNjLFvwMWDWN2jzCAtEabULfjkMXUq5mBgI2OYEaeYZe
 Gk1yy50sglyVTsgWkSZDunu16vwnddicMcqpjLuYuOVc8X7NNMvKyk+QhKw8knZMwXEZ
 pzrAG5AbZx84ayBNW3+F3JnQbHLSd0TeklS8GwQ7RiBmiKmutwt/t8QeU9JhY1ZSFVsN
 X9xKojOaCZ+OibHf6x9KXVmjaRES0Fi3vKs1m1HaE8Ris4spjJpLkrgDmW7Vf0mAs6O2
 K46alYjUO/CeWiB379RroOJURz9H7Z+37C4wPI+sdUO7X1azgkLVhi0GWWHWjyF5NP5f
 +xXA==
X-Gm-Message-State: AOJu0YzGmcH0j/AHyFl0iWavuzvbzV+2V793T14AF8srwwZAYbN+eFtV
 xgAo6RyL5KjcjiMWjqUZYprAtxMOfVcum/C6u1ktNBP1xkqtuUsjF+ZK46b+Cw==
X-Gm-Gg: ASbGnctH9reOrx7HaZl0eU1Rr7qBXRcZ47QaQ9ad2TYcLOJ5khhZENiatQVOqAQFxLO
 31x5PauNMxuaYfBOazGb6DrzdMwk8PNWHaTCv789+pdlUKPS8qRaOHVU1qNXvn+5JvNOYIdYTor
 3lgpcxycr6cXHGGVlJ9q1sZjkG0l2PzObBXBDiC1E8LIypa7yee861HLmAjxZqREQjA3EmbBOSq
 mrqhedf0GUCIi2DZpeXB/8joGDBAdZECbD8lehvNnf3XDHpUY2GWk5S4p2LIyGeeiZxa5kdh+01
 3ASLWON7g3q+vrNvHRJ0XxjA7oZws4ufcxeRSsF6mMVOncRyzL/xy32IxnxW5FXCSuH6qULjTzM
 eXBUCpYj0+pl8jtl6efFzJBsnhdefpDv+G4eQIbSola6pibETSgOpR9c2ykWrCqOINXcROu0uJq
 p2gg1jvluJaPb97mcx6zQ4TAVNQwZ+VmaseqLgWgfQ8xG34iYX4+UZ5gGSsXDy3C2Lf1UzOrHsI
 1mZXcWi
X-Google-Smtp-Source: AGHT+IGi5++S0MZzhF3sbSKuF5pSJGyGi+2KnfVsMzYoyDpWoHiJmx4IZxuSVVOdysM7P4Y/Nu4wQg==
X-Received: by 2002:a17:902:ea10:b0:269:ed31:6c50 with SMTP id
 d9443c01a7336-2948b95730fmr2410745ad.10.1761263391994; 
 Thu, 23 Oct 2025 16:49:51 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:49:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 04/25] target/riscv: Conceal MO_TE within gen_inc()
Date: Fri, 24 Oct 2025 09:49:06 +1000
Message-ID: <20251023234927.1864284-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

All callers of gen_inc() set the MO_TE flag. Set it once in
the callee.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-5-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 34 ++++++++++++----------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 754cb80e22..7e69906e5b 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -568,6 +568,7 @@ static bool gen_load_inc(DisasContext *ctx, arg_th_meminc *a, MemOp memop,
     TCGv rd = dest_gpr(ctx, a->rd);
     TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
 
+    memop |= MO_TE;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rd, rd);
@@ -588,6 +589,7 @@ static bool gen_store_inc(DisasContext *ctx, arg_th_meminc *a, MemOp memop,
     TCGv data = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
 
+    memop |= MO_TE;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rs1, rs1);
@@ -598,64 +600,64 @@ static bool trans_th_ldia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SQ, false);
+    return gen_load_inc(ctx, a, MO_SQ, false);
 }
 
 static bool trans_th_ldib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SQ, true);
+    return gen_load_inc(ctx, a, MO_SQ, true);
 }
 
 static bool trans_th_lwia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SL, false);
+    return gen_load_inc(ctx, a, MO_SL, false);
 }
 
 static bool trans_th_lwib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SL, true);
+    return gen_load_inc(ctx, a, MO_SL, true);
 }
 
 static bool trans_th_lwuia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_UL, false);
+    return gen_load_inc(ctx, a, MO_UL, false);
 }
 
 static bool trans_th_lwuib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_UL, true);
+    return gen_load_inc(ctx, a, MO_UL, true);
 }
 
 static bool trans_th_lhia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SW, false);
+    return gen_load_inc(ctx, a, MO_SW, false);
 }
 
 static bool trans_th_lhib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SW, true);
+    return gen_load_inc(ctx, a, MO_SW, true);
 }
 
 static bool trans_th_lhuia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_UW, false);
+    return gen_load_inc(ctx, a, MO_UW, false);
 }
 
 static bool trans_th_lhuib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_UW, true);
+    return gen_load_inc(ctx, a, MO_UW, true);
 }
 
 static bool trans_th_lbia(DisasContext *ctx, arg_th_meminc *a)
@@ -686,38 +688,38 @@ static bool trans_th_sdia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SQ, false);
+    return gen_store_inc(ctx, a, MO_SQ, false);
 }
 
 static bool trans_th_sdib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SQ, true);
+    return gen_store_inc(ctx, a, MO_SQ, true);
 }
 
 static bool trans_th_swia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SL, false);
+    return gen_store_inc(ctx, a, MO_SL, false);
 }
 
 static bool trans_th_swib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SL, true);
+    return gen_store_inc(ctx, a, MO_SL, true);
 }
 
 static bool trans_th_shia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SW, false);
+    return gen_store_inc(ctx, a, MO_SW, false);
 }
 
 static bool trans_th_shib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SW, true);
+    return gen_store_inc(ctx, a, MO_SW, true);
 }
 
 static bool trans_th_sbia(DisasContext *ctx, arg_th_meminc *a)
-- 
2.51.0


