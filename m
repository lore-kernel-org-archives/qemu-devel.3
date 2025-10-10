Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA95CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FOx-00047f-QP; Fri, 10 Oct 2025 11:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FOq-00040T-Fx
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FOj-0002LC-0r
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so26301645e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760111462; x=1760716262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOgvEperfmmhjYR9nWj6nkwOWDN1Ec965EjpgT7isgU=;
 b=JRNkYdA9yGV0mg1S6NF/w0F4BVWsiybCwJo/NmG3D7gL65amWnJ5ZrUfWZhEbI18gM
 /7cbaXDqVP/FzpaDr0LCgF8QjFpXDx4Ur9uz2x6hQyZBQIdeSu05qqS7REi5V4NEv8Us
 XHFn584BM3YejF7RzwB6HY/ar+/khEZcP+nJSALZURZCKdSTT9lXr08npDe/Is9TN8NI
 FV6cswM162+Ls0Xp0ktSuuNU1ENkY423Nhvsnf8oZk9D4rqPBakAyxq04vgnUmbXBND/
 L2rNJu41s/m6J1LpyvYG76z5dEG0GN77Gs+VoC7iknwiVWLhxI9xLc3UMvBHUsI9z/uW
 ofLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111462; x=1760716262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lOgvEperfmmhjYR9nWj6nkwOWDN1Ec965EjpgT7isgU=;
 b=ATGVRzaOIaZu27TCxnD8hK5KDRshQA5JLjzHE4B/I9nGvn8ulIu5mAqky1gGkzeQ0q
 x2/x2cHjPce0UFkjW9zchWy+keojYYGwskWbiJKVU2j32vzlESe+yJUk55SjRi9IV4vd
 yWSXybNv3FzCKnSiPzIS4Bro/iN3GwgeknJJjBLmSB4rnNUY7+3nmVlSTfP5tVsYnonW
 0Oofyb7X5APSXmDSahO7XQiEYyQBa/mcutfiYVVkrjUZq4jL4Cvm9qiEsgahXmgMRyFM
 UnePAbZlRH2+4yhiNh+8LYt1ptOTUjdLxtZw4WZku0Hjp2VmJOLZlEsBW3zAGgi6m4Zr
 OuCQ==
X-Gm-Message-State: AOJu0YzOXcyeZCkzTwijIc9vQNoXLuvno0iZatj382D9FEY4KzqJylWA
 xHIpaa0ESaM++NnS5gbU8f6BwmqOkW0Z+cuMJVkRKRN84vedpu7l77sdIl6lMYQwwGsgGSEcETQ
 hTpVF5yTCLA==
X-Gm-Gg: ASbGnct2rV0KOSzCvjrXnAuf7ZekL3ejVVUkzgH/L4BQRMzEfdv6bsV9Y7Tcc8D5lC4
 l8g7JcbDyeFim5IWTNllboX2ydpOetIxkP+9vAi05oQJryJHcUOYuXNewFY+vEVCW0xFfJMiOXd
 2mSl5apg9Hu+kPnCp9qnmQGoU7+AyQM/SNF7ITeD874juwlLzFfEaQ882yM7fyNW9YyWhHCRKNg
 uOmGH/8mWqIAGBOiHRrrTAZ86nY1vQVsCIxtpqdh45qSRuWGszVItzchFZSGC9uXhAutnBOBg+S
 n/Cw0Y8iuvdNxD6YINhpvkVzDA0BDm1Eofq8FQm0F/YoPxYSGZW1jLXnYDwr+R10hd0crXUe9sg
 OwXtaoIYhiGqw90UVo+EcQDQHCyoPFspT+f0y6ELAEXcKbla+welEybz5Tq8gm/S4IhyKzDmDxK
 tP+NvNGjfIzglfapjJZaeONuQSASInBg==
X-Google-Smtp-Source: AGHT+IHIsPjK9jj9sn681SRgOd5WmHBVonNYlP+5Z5ZkdjFFPAE5vJ6AIjx/WJhjnrN1lzAgrKmvZw==
X-Received: by 2002:a05:600c:528b:b0:46e:5cb5:8ca5 with SMTP id
 5b1f17b1804b1-46fa9b164edmr92043975e9.35.1760111462547; 
 Fri, 10 Oct 2025 08:51:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49c4027sm50904555e9.17.2025.10.10.08.51.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 08:51:02 -0700 (PDT)
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
Subject: [PATCH 03/13] target/riscv: Conceal MO_TE within gen_amo()
Date: Fri, 10 Oct 2025 17:50:34 +0200
Message-ID: <20251010155045.78220-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010155045.78220-1-philmd@linaro.org>
References: <20251010155045.78220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All callers of gen_amo() set the MO_TE flag. Set it once in
the callee.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/translate.c                    |  1 +
 target/riscv/insn_trans/trans_rva.c.inc     | 36 ++++++++++-----------
 target/riscv/insn_trans/trans_rvzabha.c.inc | 18 +++++------
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9a53aecbfe9..94af9853cfe 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1135,6 +1135,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size = mop & MO_SIZE;
 
+    mop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
         mop |= MO_ATOM_WITHIN16;
     } else {
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 10e4c55efda..e0fbfafdde4 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -111,55 +111,55 @@ static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SL);
 }
 
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SL);
 }
 
 static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SL);
 }
 
 static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SL);
 }
 
 static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SL);
 }
 
 static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SL);
 }
 
 static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SL);
 }
 
 static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SL);
 }
 
 static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SL);
 }
 
 static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
@@ -180,61 +180,61 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_UQ);
 }
 
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_UQ);
 }
 
 static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_UQ);
 }
 
 static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_UQ);
 }
 
 static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_UQ);
 }
 
 static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_UQ);
 }
 
 static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_UQ);
 }
 
 static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_UQ);
 }
 
 static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_UQ);
 }
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
index 25db42d24cd..c1f99b65f09 100644
--- a/target/riscv/insn_trans/trans_rvzabha.c.inc
+++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
@@ -79,55 +79,55 @@ static bool trans_amomaxu_b(DisasContext *ctx, arg_amomaxu_b *a)
 static bool trans_amoswap_h(DisasContext *ctx, arg_amoswap_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SW);
 }
 
 static bool trans_amoadd_h(DisasContext *ctx, arg_amoadd_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SW);
 }
 
 static bool trans_amoxor_h(DisasContext *ctx, arg_amoxor_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SW);
 }
 
 static bool trans_amoand_h(DisasContext *ctx, arg_amoand_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SW);
 }
 
 static bool trans_amoor_h(DisasContext *ctx, arg_amoor_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SW);
 }
 
 static bool trans_amomin_h(DisasContext *ctx, arg_amomin_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SW);
 }
 
 static bool trans_amomax_h(DisasContext *ctx, arg_amomax_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SW);
 }
 
 static bool trans_amominu_h(DisasContext *ctx, arg_amominu_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SW);
 }
 
 static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SW);
 }
 
 static bool trans_amocas_b(DisasContext *ctx, arg_amocas_b *a)
-- 
2.51.0


