Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E192F36B98
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 07:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBSQr-0001Zw-A0; Sat, 11 Apr 2026 03:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBSQp-0001ZQ-4S
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:07:03 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBSQn-0000zm-AK
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:07:02 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-415c8a4d2e6so1350584fac.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 00:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775891218; x=1776496018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnbBviPfCRVExB4FeTwpdafOvkA6EOmi1jkVfNSRtXs=;
 b=LbKVGRp5c1VgPBqcydGISHTmu+HA0LtJBVtjU7O56TxTfZdonGZNQy/Ac4rA4cn7Tz
 aYtG2uYxe5PeTlXBHlv1edafiRGqM+pSb4ZPHQfyy89exZx1WA/xFZ7xGHCiDGPoNR7p
 1umTV+JSs6scRcOlXKejDFeE5jMxu8pr2t82RawBzMiSPzGnXoqQ964fGxNktl5k3JAF
 V9tinzVb4L8TMRCnVNG9I5a9WFASPal/7QphB14DGh7x0fm7Fw2fV0xHqwljnAi9Zogb
 uHftBJZnuq85yENnVC39XauGWNHRbS5upNx4O5aDaWj7jd2aG9owBJXOw26xaV2OsNS3
 BKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775891218; x=1776496018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JnbBviPfCRVExB4FeTwpdafOvkA6EOmi1jkVfNSRtXs=;
 b=owolZRoZt5071OA96npvhSSqWiH4GB1UA8+p4wCCQAImgXc5FkHIG+S4S2ky7qb+AL
 PshgUuGkJd4osm+kc0HJBXaYkKjm2O22yEkJ5DR7QvFhr3ziSiEWIIrgaoBnRgx/yCs4
 6dFFmgFfyZx8hjJ4zbrIWWi3D3R5Bg4jW0LINEgpbiF1CHST+tIdTwkFJN4m6vcmDXTE
 asbkdD1haHcAecBHDE4N9ndjAZJ5/YXBjYPnGBzkYFDXe5A2ZKuLq79yutYJWK7jkfct
 RbzJZQPw3agQVFRwZOO0tYGIdE3nqGP52IMlb0Hohl0WBKlIpVvY0RWYUer5V3qCTRd+
 IEfQ==
X-Gm-Message-State: AOJu0YwDWCJxIktgzUb5B9ohnVbYnuk4408oWNg48vwMDJ2fCHhLTAWy
 IDFjazW8/WEbk7Fp97vZivT8Zv6DtzRCthp4YDEL11Vj3982QrHJuUWYCdIWtcUX/Wc=
X-Gm-Gg: AeBDieteyogI8fIQgcLFX1ql2GP3kZGP2htXhvY2vBFdVHxxzucBTCQxM1wgyk9GJFU
 U7gUnQXytW06Mq+VqRPiiqIIslARnMTslDbSsZj8MOpx6w7RbMQ9GpYNdwDtajVcO+LljLpVdsB
 4gM3yE6fVNtj8YYf3RFFSjngIBVNWM8dpuS9Skf2NBhKGcbvZ3wp+LpHeFQrgPBSgYDEXrXB1QB
 B77dhIQrGmwd6lVxkn1B/CfrJTudNf9DWQrQ8PLuhCcBZhZ7qnRI4LMg2XHcKTbqiRFIOyOBl7B
 E9rI+47u33ARBiePaK25fZOBQMlyM3gsKnv293p6GTxhMQ14bxW5P1JV6G3ifx/N43FcUJqnF5r
 yMaBAf1LQ3iFqF1yYUhjkyYikXro+jImkLqQ8kuACvxTcF87gZzJR99bjfpYq1k+vQo3NvwOPpZ
 8RVHO/DCJo8LXgM0QIs5amL2EqEIX0Y3E2Gq1LDB/a0pEMonMuNPcVy3QLLybUgR81jEWWdkPlC
 TMsseivNJn14W8X2DTRJyRWcO3oRbW1nIdygb+FHs9Kk2pSftP+aYQ+5jJ4iNaPGn/cRhA=
X-Received: by 2002:a05:6808:2202:b0:450:4782:2b0e with SMTP id
 5614622812f47-4789d03fd6bmr2947587b6e.15.1775891218559; 
 Sat, 11 Apr 2026 00:06:58 -0700 (PDT)
Received: from Mac.localdomain (71-218-253-186.hlrn.qwest.net.
 [71.218.253.186]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a0f1e841sm2651091b6e.5.2026.04.11.00.06.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 11 Apr 2026 00:06:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 3/9] target/mips: add Octeon LA* atomic instructions
Date: Sat, 11 Apr 2026 01:06:29 -0600
Message-ID: <20260411070637.72421-3-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411070637.72421-1-james.hilliard1@gmail.com>
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2a.google.com
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

These operations are architecturally distinct from SAA/SAAD and are
used by existing Octeon user-mode code for atomic counters, bit
operations, and exchange-style updates.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 target/mips/tcg/octeon.decode      |  17 +++
 target/mips/tcg/octeon_translate.c | 170 +++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d90a194b54..0f5fe83609 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -59,6 +59,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
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
 
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 67b8634dff..9ac20196de 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -232,6 +232,164 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
     return true;
 }
 
+static bool trans_la_common(DisasContext *ctx, int base, int add, int rd,
+                            int64_t imm, bool dw)
+{
+    TCGv addr = tcg_temp_new();
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (dw) {
+        check_mips_64(ctx);
+        if (ctx->base.is_jmp != DISAS_NEXT) {
+            return true;
+        }
+#if TARGET_LONG_BITS == 64
+        TCGv value = tcg_temp_new();
+        TCGv old = tcg_temp_new();
+        MemOp amo = mo_endian(ctx) | MO_UQ | ctx->default_tcg_memop_mask;
+
+        if (add >= 0) {
+            gen_load_gpr(value, add);
+        } else {
+            tcg_gen_movi_tl(value, imm);
+        }
+
+        tcg_gen_atomic_fetch_add_tl(old, addr, value, ctx->mem_idx, amo);
+        gen_store_gpr(old, rd);
+#endif
+    } else {
+        TCGv old = tcg_temp_new();
+        TCGv_i32 value32 = tcg_temp_new_i32();
+        TCGv_i32 old32 = tcg_temp_new_i32();
+        MemOp amo = mo_endian(ctx) | MO_UL | ctx->default_tcg_memop_mask;
+
+        if (add < 0) {
+            tcg_gen_movi_i32(value32, imm);
+        } else {
+            TCGv value = tcg_temp_new();
+
+            gen_load_gpr(value, add);
+            tcg_gen_trunc_tl_i32(value32, value);
+        }
+
+        tcg_gen_atomic_fetch_add_i32(old32, addr, value32, ctx->mem_idx, amo);
+        tcg_gen_ext_i32_tl(old, old32);
+        gen_store_gpr(old, rd);
+    }
+
+    return true;
+}
+
+static bool trans_law_common(DisasContext *ctx, int base, int add, int rd,
+                             int64_t imm, bool dw)
+{
+    TCGv addr = tcg_temp_new();
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (dw) {
+        check_mips_64(ctx);
+        if (ctx->base.is_jmp != DISAS_NEXT) {
+            return true;
+        }
+#if TARGET_LONG_BITS == 64
+        TCGv value = tcg_temp_new();
+        TCGv old = tcg_temp_new();
+        MemOp amo = mo_endian(ctx) | MO_UQ | ctx->default_tcg_memop_mask;
+
+        if (add >= 0) {
+            gen_load_gpr(value, add);
+        } else {
+            tcg_gen_movi_tl(value, imm);
+        }
+
+        tcg_gen_atomic_xchg_tl(old, addr, value, ctx->mem_idx, amo);
+        gen_store_gpr(old, rd);
+#endif
+    } else {
+        TCGv old = tcg_temp_new();
+        TCGv_i32 value32 = tcg_temp_new_i32();
+        TCGv_i32 old32 = tcg_temp_new_i32();
+        MemOp amo = mo_endian(ctx) | MO_UL | ctx->default_tcg_memop_mask;
+
+        if (add >= 0) {
+            TCGv value = tcg_temp_new();
+
+            gen_load_gpr(value, add);
+            tcg_gen_trunc_tl_i32(value32, value);
+        } else {
+            tcg_gen_movi_i32(value32, imm);
+        }
+
+        tcg_gen_atomic_xchg_i32(old32, addr, value32, ctx->mem_idx, amo);
+        tcg_gen_ext_i32_tl(old, old32);
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
     TCGv addr = tcg_temp_new();
@@ -314,6 +472,18 @@ static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
 
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


