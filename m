Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2DAF327D4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEtN-0003wr-Om; Tue, 21 Apr 2026 13:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEtC-0003nZ-0g
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:28:01 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEt6-0006hr-Gl
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:55 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso379757a34.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792465; x=1777397265; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dyhSVxFzZNOrVlRzPjL3hlTh6qJUz61vh/f8LgovAlo=;
 b=WsDcpe8tt57MUrirM7LsqayGpwM2++0EjqjLRi+yydEQxc5BhQAw4u4t/5HGOnl/sg
 0nvwcMk7bQZQAoL6z/XQIiToyWm1aJKqh5016UAw6hGBGWkxNKVmMej8OahvODukoAug
 by9qRcgIKA+TK4feJjOFET3mUXn6pF8GovXM7euZ7FET+smS56z5R/Px2xMcJ0CaaAWN
 pbdF4+1CysWZSW3JRMjceeQKvHHlVSQ+3nO8W4EFMoGCzkajqa6y+6YW/KoYio9HmsJo
 JO9vb2PLpD5JFlHYHAzIMpvRY/Ypgsgv0wtbRC4fTfS84f8ZVJ3w804x9aur7YvD0Qh+
 AJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792465; x=1777397265;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dyhSVxFzZNOrVlRzPjL3hlTh6qJUz61vh/f8LgovAlo=;
 b=IBMKcSPrIqX3V062B9qocuYlHMLN5xJRU5Tu/LX6b+XCrGHiSBxp8OmgdTbH+bzk6/
 uvuyUuginYzRDvR06CRXcemrsCNtbmuQNypLhI1eECGtfFFjvP7q5ckcm4SwrDhke++z
 62ifXvdCwU2Wh8o3uR2T8vWUaNLFrmNP54mjSHVA5dMWPu9b7XalEkYqAioQywd6LAqu
 Lbt7Dk22+Xu5p5Ufi8jKOI72lTiYmw8KkDSFslCvfcFIFMBajTKSyM7dstIH9ppvfhZB
 aWuzCx68YPWseB7bUk1JyxXn18bH7aGgq/laZRKLsF/6xaM9NT4IB/ftWN2EWguKhRKc
 e6zw==
X-Gm-Message-State: AOJu0Yw4Oqzxl0GTdQb+U1//bi+tRvEBBh2+RtOjkys1i6nAhU5ItFIJ
 L/BUprqmQydmH732qoHXZ5Rqw9oJLN6SuoR2UpX+vsw2BSs2EktjXwnT
X-Gm-Gg: AeBDieuSeOT7ezrIS84SH7UAI2bGMf1ei/+7rQbEr+iWspbfTQBcOYGrvsR2/zdtxFF
 +tMtoUFzrPmqMZltHUZS1XxfRBzrYwXy+yNk3HMIpxBl1CyqGqzEh3KIYRS0fqa4wz1Cwr+wl8M
 HVyRBqNsQwVbVmsa6k3sjq6GxB6IGMema0brXuQEzACtbykgtx/kVYQ8O17Q89Jpj8Ncy3uQyKR
 GXaspqd+snxtAs5MeJtH28y17iHx7eb9Z4p/IctdZ7PWPhGjpvHn5ncjqIjg4XY+FzSA0XEdUtg
 5lHozyIYWX0k4TwXSqWdaqul4devSvIveJjKYJKZEg9wKGf1JWi4NfsQcIF8UF2vKSnTXLCbmbu
 6g98fgXkrIvq4pudIqVPn1K/RiiYZjvqdxOcvNarSUYvxN4TjvKyMfV5R9o6Q7TGx0xq+ykzeXN
 6l90scMNl1TWBRxZnLeth8P4b6/kto6WFP1I9jQhRSqFwpYYM9NMEJNYd5WLqlzN1xfXhtWT+jX
 ayO9eUwi1LTLGLa3hpyGPclNtasG/bdXrfIopOFLhKwspl5pmGoRDNYTowZXdiPnnx4hsWmF4rt
 6ApxuQ==
X-Received: by 2002:a4a:edca:0:b0:692:3df6:79c6 with SMTP id
 006d021491bc7-69462f24574mr9876123eaf.49.1776792464810; 
 Tue, 21 Apr 2026 10:27:44 -0700 (PDT)
Received: from mac.localdomain (97-118-149-104.hlrn.qwest.net.
 [97.118.149.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm12209290fac.0.2026.04.21.10.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:27:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 21 Apr 2026 11:27:33 -0600
Subject: [PATCH v2 06/13] target/mips: add Octeon LA* atomic instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-mips-octeon-missing-insns-v2-v2-6-a0791df188c9@gmail.com>
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Implement the Octeon LA* read-modify-write atomic instruction family:
LAI/LAID, LAD/LADD, LAA/LAAD, LAS/LASD, LAC/LACD, and LAW/LAWD.

These operations are architecturally distinct from SAA/SAAD and are used
by existing Octeon user-mode code for atomic counters, bit operations,
and exchange-style updates.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Keep LA* atomics naturally aligned per Octeon L2 transaction
    semantics.
  - Use explicit i64 TCG ops in the LA* translator paths.  (suggested by
    Philippe Mathieu-Daudé)
---
 target/mips/tcg/octeon.decode      |  17 ++++
 target/mips/tcg/octeon_translate.c | 170 +++++++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 2eb15aa17f..9dcc5a6ae0 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -60,6 +60,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&la          base rd
+&laa         base add rd
+@la          ...... base:5 ..... rd:5 ........... &la
+@laa         ...... base:5 add:5 rd:5 ........... &laa
+LAI          011100 ..... 00000 ..... 00010 011111 @la
+LAID         011100 ..... 00000 ..... 00011 011111 @la
+LAD          011100 ..... 00000 ..... 00110 011111 @la
+LADD         011100 ..... 00000 ..... 00111 011111 @la
+LAA          011100 ..... ..... ..... 10010 011111 @laa
+LAAD         011100 ..... ..... ..... 10011 011111 @laa
+LAS          011100 ..... 00000 ..... 01010 011111 @la
+LASD         011100 ..... 00000 ..... 01011 011111 @la
+LAC          011100 ..... 00000 ..... 01110 011111 @la
+LACD         011100 ..... 00000 ..... 01111 011111 @la
+LAW          011100 ..... ..... ..... 10110 011111 @laa
+LAWD         011100 ..... ..... ..... 10111 011111 @laa
+
 &zcb         base
 ZCB          011100 base:5 00000 00000 11100 011111 &zcb
 ZCBT         011100 base:5 00000 00000 11101 011111 &zcb
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index cdb4d36c8e..6309cd5fff 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -254,6 +254,164 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
     return true;
 }
 
+static bool trans_la_common(DisasContext *ctx, int base, int add_reg, int rd,
+                            int64_t imm, bool dw)
+{
+    if (dw && !octeon_check_64(ctx)) {
+        return true;
+    }
+
+    TCGv_i64 addr = tcg_temp_new_i64();
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (dw) {
+#if TARGET_LONG_BITS == 64
+        TCGv_i64 value = tcg_temp_new_i64();
+        TCGv_i64 old = tcg_temp_new_i64();
+        MemOp amo = mo_endian(ctx) | MO_UQ | MO_ALIGN;
+
+        if (add_reg >= 0) {
+            gen_load_gpr(value, add_reg);
+        } else {
+            tcg_gen_movi_i64(value, imm);
+        }
+
+        tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+        gen_store_gpr(old, rd);
+#endif
+    } else {
+        TCGv_i64 old = tcg_temp_new_i64();
+        TCGv_i32 value32 = tcg_temp_new_i32();
+        TCGv_i32 old32 = tcg_temp_new_i32();
+        MemOp amo = mo_endian(ctx) | MO_UL | MO_ALIGN;
+
+        if (add_reg < 0) {
+            tcg_gen_movi_i32(value32, imm);
+        } else {
+            TCGv_i64 value = tcg_temp_new_i64();
+
+            gen_load_gpr(value, add_reg);
+            tcg_gen_extrl_i64_i32(value32, value);
+        }
+
+        tcg_gen_atomic_fetch_add_i32(old32, addr, value32, ctx->mem_idx, amo);
+        tcg_gen_ext_i32_i64(old, old32);
+        gen_store_gpr(old, rd);
+    }
+
+    return true;
+}
+
+static bool trans_law_common(DisasContext *ctx, int base, int add_reg, int rd,
+                             int64_t imm, bool dw)
+{
+    if (dw && !octeon_check_64(ctx)) {
+        return true;
+    }
+
+    TCGv_i64 addr = tcg_temp_new_i64();
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (dw) {
+#if TARGET_LONG_BITS == 64
+        TCGv_i64 value = tcg_temp_new_i64();
+        TCGv_i64 old = tcg_temp_new_i64();
+        MemOp amo = mo_endian(ctx) | MO_UQ | MO_ALIGN;
+
+        if (add_reg >= 0) {
+            gen_load_gpr(value, add_reg);
+        } else {
+            tcg_gen_movi_i64(value, imm);
+        }
+
+        tcg_gen_atomic_xchg_i64(old, addr, value, ctx->mem_idx, amo);
+        gen_store_gpr(old, rd);
+#endif
+    } else {
+        TCGv_i64 old = tcg_temp_new_i64();
+        TCGv_i32 value32 = tcg_temp_new_i32();
+        TCGv_i32 old32 = tcg_temp_new_i32();
+        MemOp amo = mo_endian(ctx) | MO_UL | MO_ALIGN;
+
+        if (add_reg >= 0) {
+            TCGv_i64 value = tcg_temp_new_i64();
+
+            gen_load_gpr(value, add_reg);
+            tcg_gen_extrl_i64_i32(value32, value);
+        } else {
+            tcg_gen_movi_i32(value32, imm);
+        }
+
+        tcg_gen_atomic_xchg_i32(old32, addr, value32, ctx->mem_idx, amo);
+        tcg_gen_ext_i32_i64(old, old32);
+        gen_store_gpr(old, rd);
+    }
+
+    return true;
+}
+
+static bool trans_lai(DisasContext *ctx, arg_la *a, int unused)
+{
+    return trans_la_common(ctx, a->base, -1, a->rd, 1, false);
+}
+
+static bool trans_laid(DisasContext *ctx, arg_la *a, int unused)
+{
+    return trans_la_common(ctx, a->base, -1, a->rd, 1, true);
+}
+
+static bool trans_lad(DisasContext *ctx, arg_la *a, int unused)
+{
+    return trans_la_common(ctx, a->base, -1, a->rd, -1, false);
+}
+
+static bool trans_ladd(DisasContext *ctx, arg_la *a, int unused)
+{
+    return trans_la_common(ctx, a->base, -1, a->rd, -1, true);
+}
+
+static bool trans_laa(DisasContext *ctx, arg_laa *a, int unused)
+{
+    return trans_la_common(ctx, a->base, a->add, a->rd, 0, false);
+}
+
+static bool trans_laad(DisasContext *ctx, arg_laa *a, int unused)
+{
+    return trans_la_common(ctx, a->base, a->add, a->rd, 0, true);
+}
+
+static bool trans_las(DisasContext *ctx, arg_la *a, int unused)
+{
+    return trans_law_common(ctx, a->base, -1, a->rd, -1, false);
+}
+
+static bool trans_lasd(DisasContext *ctx, arg_la *a, int unused)
+{
+    return trans_law_common(ctx, a->base, -1, a->rd, -1, true);
+}
+
+static bool trans_lac(DisasContext *ctx, arg_la *a, int unused)
+{
+    return trans_law_common(ctx, a->base, -1, a->rd, 0, false);
+}
+
+static bool trans_lacd(DisasContext *ctx, arg_la *a, int unused)
+{
+    return trans_law_common(ctx, a->base, -1, a->rd, 0, true);
+}
+
+static bool trans_law(DisasContext *ctx, arg_laa *a, int unused)
+{
+    return trans_law_common(ctx, a->base, a->add, a->rd, 0, false);
+}
+
+static bool trans_lawd(DisasContext *ctx, arg_laa *a, int unused)
+{
+    return trans_law_common(ctx, a->base, a->add, a->rd, 0, true);
+}
+
 static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
 {
     TCGv_i64 addr = tcg_temp_new_i64();
@@ -376,6 +534,18 @@ static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
 
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
+TRANS(LAI,  trans_lai, 0);
+TRANS(LAID, trans_laid, 0);
+TRANS(LAD,  trans_lad, 0);
+TRANS(LADD, trans_ladd, 0);
+TRANS(LAA,  trans_laa, 0);
+TRANS(LAAD, trans_laad, 0);
+TRANS(LAS,  trans_las, 0);
+TRANS(LASD, trans_lasd, 0);
+TRANS(LAC,  trans_lac, 0);
+TRANS(LACD, trans_lacd, 0);
+TRANS(LAW,  trans_law, 0);
+TRANS(LAWD, trans_lawd, 0);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.53.0


