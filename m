Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1459CCF9E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjE-0000bz-Gd; Thu, 23 Oct 2025 00:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjC-0000bh-Tg
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:07 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjA-0007AP-91
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:05 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso339704b3a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192902; x=1761797702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGpmIeocnZY/4VSw8Tb8CrQJTwcXNtaQEyLBeJL6A8U=;
 b=Yr1IBhDdbUnUMdUksMPOn28NRGYkPxJpZXXiI+zrFhlmwzZaBsrvscyWAoxZGoSh27
 kunVmp8cexmtn6Tl/A6Y7P91lpkZvNklv/CqECNDVj8gnyfAR85ITe9u7mtc3wwV2koF
 +kJ7Pf52ZJTirKOEjiHAs10ZmVTuhE7aLwu8iK3cz5AP9uTeFLnTOidbeFxd3xmnrhYB
 Y2R3nyJ3Nv78H5zn8hCAU93nC4V3XI9TAt1ucBFQ7Tbx5uPdqO4iUuG1ozaFsEv8yahG
 7ccoD43KYDEHq453zNG6JPA1Fs4QAfalm93zN924rtLc2kEY0FIyjxPAHbmWv0SSdC4E
 24FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192902; x=1761797702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGpmIeocnZY/4VSw8Tb8CrQJTwcXNtaQEyLBeJL6A8U=;
 b=WKO1GwULcBuMIk1xz3JP9FSXjJfRdZMxz+r/a7vzop1PO+MH6lapRT4v7qOcltz/zN
 KJEI4q5J5TimLAHzW2KTlBMe7rLHRszj4GL+YPQCKKqXBY8yLocFpmI1d7CKqt0WEkzz
 LSd/q2UuFsel4zc4q6BHmxeJ4bqLjaF49ewTsaPy/lSx0SvxG6Kjaw7Xik56uSowAipd
 HtQj4k7Qw9wcj9XPHgRe/zxIrRFy1Wb6y+6Ou+eyG/UngajTSo/MxMvRH8qlP4i2kyx0
 RVJ1q9oaJn9AIulRdpKmMEN8LdHxaldgR1hMOxInxqsV6yAxE5LF+b0MTCzIUplmEyRW
 90Lg==
X-Gm-Message-State: AOJu0Yyz5VreaO77NKPlhScZAQvNOSlwAGzAtooDcZbLC+gD+VESRK9f
 i1dOMqfezJpV7Zd1J9Ig7JRChu7Mk7wyTsg/zsJ/ki0a680Hv5bkQF2mYlW5kA==
X-Gm-Gg: ASbGncuItUe1AKGeYeYROrOfavcCjW7t8lkPEgdb55eB1W9b3s4aQMoMxs3S30H/gsg
 YMZ2drzsCYpjt+4D/agro3BBzp6ORtu6pFOev5SJ5++l07ejGMQaS5Gorc2VGkOQKUhywaJuWgZ
 DpIDO16Xtpow9HbVpCy2WGsHnbMBRU5paST7zLKqga+Hm7toI3TJbBzLzPL9eP/YJttTHUMUoX3
 9rAQJhs2XdLEPEJyUzfEcYTWGrokI9y8vnJQ371IAvfPX38yTTDeDK7fAzmWXZe5FKZmzEjlc8J
 N0ih9qiDvnBF6YfJKc3icWARMEKTAxvIsQV8l+3c5gDMVvEgoRaR6GGs+L4tPGfYg+/fFZfto4j
 W8CruT70nN4NLU83pXmiEMR2ZGc7VgfteFnLOyuogDIjTYxgOsRbMN8cC1L+ndFO9g10Blwy1zS
 hVtZRSyD35AhFqqU8TyMUtIeuWT+T10dFk36uHeZ030i2vjN4p0v9WC7ri2dyWE0dBcbSnyKSti
 q7U6YlWgDbVxtQSVX+Z
X-Google-Smtp-Source: AGHT+IGF1hfHjYkxfvjEA8wQTBaQ837dJGGgebk4ft3Uh8d6qqpOcM16zfguMdFxiFNit3D2l1Az3Q==
X-Received: by 2002:a05:6a20:9144:b0:334:7d71:a61e with SMTP id
 adf61e73a8af0-334a854c923mr30546318637.21.1761192902480; 
 Wed, 22 Oct 2025 21:15:02 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/37] target/riscv: Conceal MO_TE within gen_inc()
Date: Thu, 23 Oct 2025 14:14:02 +1000
Message-ID: <20251023041435.1775208-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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


