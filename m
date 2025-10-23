Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39265CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54F-0003uB-Ep; Thu, 23 Oct 2025 19:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54B-0003sV-30
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:59 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC549-00077D-9c
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:58 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b67684e2904so1025999a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263395; x=1761868195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teMt2way951YBxY9HJbUv32x5kU3XvCldsY+jVeFn8s=;
 b=e7KpbI/Z+kxLQOkFKPx44hCVt3IfYghXYYnMiRbJyI4H4kxwcg+60062ZqpNCSiV8f
 daUj43OiF/gs0WWFLxnfh80VojOKPM7dcqo5l2fInb1S0G2nMXk2/+XzwGF/hMIjL3hW
 rPsITuAkN1Gnn3Cb6sqeFtY4KeiUAn2KiFR9m0CqCbvn172G0e2OXmN6ZHiXwsyJGGjr
 BQNV7nPLXRXK+ALc9rPfjIoDIQOo6RunsF97KyVSRMH2ZqVPr/aVGxu7lTVOhWSokeIu
 UE+iZ536l+2f9DxOg8Yx2pcp/PRk4elcr/L4WK6ihq15HqmFtFB4896UYTbARHEu+xSL
 661g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263395; x=1761868195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teMt2way951YBxY9HJbUv32x5kU3XvCldsY+jVeFn8s=;
 b=wljOwOtIeOSuGm6auQGViXd+YiMbSPfGdh4LdzAcnomFoJHH2kG/mXw3BPdffVVn12
 nBVvHTHj7VK17PCL+7dNHB0Mw2bPWkgL9XTZPB2HWuOY/eYHv685U0yV3qGlYW5c4myT
 LYuwLoSEYPZu3ZoKrtzmFjc4LGLFVGtpVS+rSFgt6xWqFXbxNPEbdg9Q0sYukQg8TwaR
 HiAYo4uMQcZTqc/29cotcHl8DDWaDCf17tRjMMDDwQ6GodzDhw9f7MiqLVgTpu8ecwea
 QWWRoo0WQscV5/BflE0F/KhHnfEVWf6KfLpPdRcwFdaQzm8ziWAEfNIGdOJXAuFP5rYM
 9jOA==
X-Gm-Message-State: AOJu0YykX2yCNgFAmCfjlsywgWVVQ6xjNn5BPdbVYyTtmG+E8CJFI5Uh
 2BCFiBZMTLbXCL2D02I9X9dJXRfRAMWeBZX3xOHn0A/dd4VR7yGm9+JItlvRRA==
X-Gm-Gg: ASbGnctXQZMeMlsb9bhpLqr672WqQxtMtRcBLfxJ/iJbAEsXz29fiko61I1F2oKlcXs
 bbEBOwuPA2lMrizrXtxKib/McjUkg6stjd+vBians2CWbiOJcrWgzKn0k09kJKDFWtL4wbQVhLc
 OqvMroTkJLqJva6c1MPQb0oxV6/QwmZ+QtIeVQn2lGGkFXRc9FO+VglXrGkPlVQy8Uyujr3CGSM
 pW4hzoj5/qMN/NeWSdFPtPz+2ImHVZo2DbUGilBTVdcKOvtCWCZoP78Cxz0THWrllxJAuG0zU5p
 73gsXVsLPs3tHRDQPZvIF/xVyaJHWHqKadzIQA9GAw37zn74Z8ye2F/eTnWf+iKNRVX5GZXdega
 p0BYsJKqulsgXNKjjaszy8dLqQOlNK0O7+WG0N6QuUSIS4DadWWEspeLey1OTPyuZqCuIPJLStb
 K1Qa9ox0Vtkbdaf0eeh3oez4DgIZwuzlxC7msbhmM/ggiGtG8vPifeBBMgqPkF8OfMzQpTrCGSZ
 mBDTre8IWnZB106NkU=
X-Google-Smtp-Source: AGHT+IGgKHd9+rt4yZ2rD/ykWn94DZ5J50051qTb3w4ND5JlPnvUn2VOP0wqqv4Murla28xpwuQu8g==
X-Received: by 2002:a17:902:ec87:b0:28e:681c:a7ed with SMTP id
 d9443c01a7336-2948ba0d5e4mr2497255ad.36.1761263395283; 
 Thu, 23 Oct 2025 16:49:55 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:49:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 05/25] target/riscv: Conceal MO_TE within gen_load() /
 gen_store()
Date: Fri, 24 Oct 2025 09:49:07 +1000
Message-ID: <20251023234927.1864284-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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

All callers of gen_load() / gen_store() set the MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-6-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc   | 24 ++++++++++++-----------
 target/riscv/insn_trans/trans_rvzce.c.inc |  6 +++---
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 34012caf1e..9a03058f46 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -402,6 +402,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
     bool out;
 
+    memop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -426,24 +427,24 @@ static bool trans_lb(DisasContext *ctx, arg_lb *a)
 
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
@@ -453,19 +454,19 @@ static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
 
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
@@ -503,6 +504,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
 
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
+    memop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -521,24 +523,24 @@ static bool trans_sb(DisasContext *ctx, arg_sb *a)
 
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
index d130179432..c8dc102c8e 100644
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


