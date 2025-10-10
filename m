Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF85CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FOv-00046v-Dd; Fri, 10 Oct 2025 11:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FOt-000444-1G
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:23 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FOp-0002Qe-8m
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:22 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-421b93ee372so1191054f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760111473; x=1760716273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INU/6HBzbxJS6q0dUKjKn+LhKStUfKignIWA0XqcwIc=;
 b=u4lZ6garkLxY9wkBDIWYAM2+szsIJdmfp2DGm8zjtjADcDEvTjCsnfZVD/8t8cBxh0
 Z+MmpFhKPd4aA0c0DTsDWnw5EYF1o7ZipHwVoqxHgb1e8Ha49Jl6+ZcIrsYqRKFEy4pq
 2LDfSMkCKNyXdF9mneGZDZ2WX0hOGCw2aBt4HsTc0kXaQHg4HUzLqrPFiZzUeE2I8GDu
 sUvr/sEaI+t869A31w8NoYrcYdVhs1ZalhzR8Zc3XCEmXWAkGEar+S9+Hyb1P/2dFjKJ
 9dfQcA8c6qBsAOwRoMxNSDNeis/qLJnihQAEOoju5gnRuGGhanYXcwFQZur36hr2UQPx
 5O4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111473; x=1760716273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INU/6HBzbxJS6q0dUKjKn+LhKStUfKignIWA0XqcwIc=;
 b=EikgRKXdkSvLgcFpcO195V2KaF//+b4+beVAWp0niCcjQTe4w0Bb1U5c0iUZKs4WK0
 bqJMkQpK1Q0PAEqV9mnimNILoORxttrig3RJIBUOAW4lbtdbwci+FbDqM00rNwsVvjhF
 BAZ3o4g5QN1ogQtrn4SYrmLL+RyA+5E0TAif16gV2ftNwlJAEbZQi/kmBscL8rfWUJHJ
 UykA9LSCgkH+6mZ4LpWIMK2xnZ1Qs2BqCLUJvSfoYajH9BOha9EushaHQh/GrLycJCV5
 YILyBdc9TxLjNl6FvfZUE3WJ5o+2QsVSBsV/3qirNXkbOH9PhCv/YkIeXehpaej/VgQI
 Xcew==
X-Gm-Message-State: AOJu0YzNz3PCwfXdFwlvRvCUVjEqSVkCmh8Fs4iZ/Y287aF0bNdPZ6qj
 gl5tvUFX9oWhhvRai5qsWc1SnsLvddHUxYF6oy5mg8H8HVNp6T92Bbj7drj6me7Ez+W16DMAJIF
 rc+pxOX8R+Q==
X-Gm-Gg: ASbGnctGTYzlJZzzFTJTu6bt7SUb46MuqYzo1sLzHe48LAjHFhxJptg+trOdIe6LAUm
 1tVaW02qblQUPFOql2+cgWGK3qPQOugt6ywIg61bWfCfnbReOB6W7LmzpBXRKyL4aoA3xcd4SOI
 wMtqENb41IQpFEcj7hAixa8QSE2lfbuyliivV7d4+grE2E4Nza0PZp55M78Q7BJPjGFoWusSmdz
 jz1bgUAnvRmlFViCyVtMGQwZublEk+LjwfF+ebCJrfGcg5H8dkr/7H+Y07eYdjjp67FFq92Nvma
 8ulmh1g0SRV0BqnmK4qV+0kMq+y3GI8KTlcIZfYpnUghEJhxGpi5qcR9fdKjZKal2b6FoqVTHC3
 xwv2ej0ZLnRlcY+CSiaqPIF56zvXHxCcTKIc/EPsfH914etz+ETdsvEFqiOw/vjPWqBrXhWhTqD
 hR0R0UWsPi808oYc+X/mg=
X-Google-Smtp-Source: AGHT+IGklwTfVjPa+Z0qe0fNHhWFR4v+//mK6iD/Clnmm7TG6g4wtEuUzPmqvDFHQsT0os14Y1x8eA==
X-Received: by 2002:a05:6000:18a6:b0:425:8538:d3f6 with SMTP id
 ffacd0b85a97d-42667177dfcmr7286266f8f.19.1760111472519; 
 Fri, 10 Oct 2025 08:51:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e81d2sm4735909f8f.49.2025.10.10.08.51.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 08:51:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/13] target/riscv: Conceal MO_TE within gen_load() /
 gen_store()
Date: Fri, 10 Oct 2025 17:50:36 +0200
Message-ID: <20251010155045.78220-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010155045.78220-1-philmd@linaro.org>
References: <20251010155045.78220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

All callers of gen_load() / gen_store() set the MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_rvi.c.inc   | 24 ++++++++++++-----------
 target/riscv/insn_trans/trans_rvzce.c.inc |  6 +++---
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 8194ea5073e..8db3e78baab 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -404,6 +404,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
     bool out;
 
+    memop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -428,24 +429,24 @@ static bool trans_lb(DisasContext *ctx, arg_lb *a)
 
 static bool trans_lh(DisasContext *ctx, arg_lh *a)
 {
-    return gen_load(ctx, a, MO_TE | MO_SW);
+    return gen_load(ctx, a, MO_SW);
 }
 
 static bool trans_lw(DisasContext *ctx, arg_lw *a)
 {
-    return gen_load(ctx, a, MO_TE | MO_SL);
+    return gen_load(ctx, a, MO_SL);
 }
 
 static bool trans_ld(DisasContext *ctx, arg_ld *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
-    return gen_load(ctx, a, MO_TE | MO_SQ);
+    return gen_load(ctx, a, MO_SQ);
 }
 
 static bool trans_lq(DisasContext *ctx, arg_lq *a)
 {
     REQUIRE_128BIT(ctx);
-    return gen_load(ctx, a, MO_TE | MO_UO);
+    return gen_load(ctx, a, MO_UO);
 }
 
 static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
@@ -455,19 +456,19 @@ static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
 
 static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
 {
-    return gen_load(ctx, a, MO_TE | MO_UW);
+    return gen_load(ctx, a, MO_UW);
 }
 
 static bool trans_lwu(DisasContext *ctx, arg_lwu *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
-    return gen_load(ctx, a, MO_TE | MO_UL);
+    return gen_load(ctx, a, MO_UL);
 }
 
 static bool trans_ldu(DisasContext *ctx, arg_ldu *a)
 {
     REQUIRE_128BIT(ctx);
-    return gen_load(ctx, a, MO_TE | MO_UQ);
+    return gen_load(ctx, a, MO_UQ);
 }
 
 static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
@@ -507,6 +508,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
 
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
+    memop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -525,24 +527,24 @@ static bool trans_sb(DisasContext *ctx, arg_sb *a)
 
 static bool trans_sh(DisasContext *ctx, arg_sh *a)
 {
-    return gen_store(ctx, a, MO_TE | MO_SW);
+    return gen_store(ctx, a, MO_SW);
 }
 
 static bool trans_sw(DisasContext *ctx, arg_sw *a)
 {
-    return gen_store(ctx, a, MO_TE | MO_SL);
+    return gen_store(ctx, a, MO_SL);
 }
 
 static bool trans_sd(DisasContext *ctx, arg_sd *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
-    return gen_store(ctx, a, MO_TE | MO_UQ);
+    return gen_store(ctx, a, MO_UQ);
 }
 
 static bool trans_sq(DisasContext *ctx, arg_sq *a)
 {
     REQUIRE_128BIT(ctx);
-    return gen_store(ctx, a, MO_TE | MO_UO);
+    return gen_store(ctx, a, MO_UO);
 }
 
 static bool trans_addd(DisasContext *ctx, arg_addd *a)
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index d1301794324..c8dc102c8e3 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -88,13 +88,13 @@ static bool trans_c_lbu(DisasContext *ctx, arg_c_lbu *a)
 static bool trans_c_lhu(DisasContext *ctx, arg_c_lhu *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_load(ctx, a, MO_TE | MO_UW);
+    return gen_load(ctx, a, MO_UW);
 }
 
 static bool trans_c_lh(DisasContext *ctx, arg_c_lh *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_load(ctx, a, MO_TE | MO_SW);
+    return gen_load(ctx, a, MO_SW);
 }
 
 static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
@@ -106,7 +106,7 @@ static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
 static bool trans_c_sh(DisasContext *ctx, arg_c_sh *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_store(ctx, a, MO_TE | MO_UW);
+    return gen_store(ctx, a, MO_UW);
 }
 
 #define X_S0    8
-- 
2.51.0


