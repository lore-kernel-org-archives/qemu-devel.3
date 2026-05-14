Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C84BCD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2a-0003gh-Mx; Thu, 14 May 2026 13:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0y-0000qR-8h
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:29 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0q-00044j-TP
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:27 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-479ef2b7979so5843219b6e.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780299; x=1779385099; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fb1FH2/2JoydC2L5Godhcdlq1xmTJRUNsT0uHvG/piU=;
 b=SjBqMfswDQxcHPM37R5gujVnyqCfVqczahxBNzDdWiJlgomAzgX98zm4KgYg2ehDn4
 qb2EmHoludrbE3uNlhmuVAv1l3WFbGj9V4iJikyOHmpgerAtsvltkIaBlmvwCepjuRYw
 I8MrzimMkbULPKfjQ7gDvxehHfIj7TBvi+rgaNjYoxYnkapeXYs3Y5o0bUHu4BE2Wocs
 RRhrQ+MyQh7sa57HDkXiEDVtp61lRWtvDH+/IHLag3X03lDkvlfJrxU/SUjJwaTr0Mmx
 1DoGtBSIqdKpaws5y6gaxBOl8ymDiblMlhjTwoDHwsRRryIuoigkg7xAuFwXsHjBymr2
 nUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780299; x=1779385099;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fb1FH2/2JoydC2L5Godhcdlq1xmTJRUNsT0uHvG/piU=;
 b=kDAllljRzIaxwWbAQCSFEI8p+i0ot+aLa52p4GnYKTtCI0RKcTfNhAyMsurnehpO03
 Bhrt8lrfFxh6FvL7UrWn7Bk17xYpqWeQvAdepT4UtYZHxNmxK8Znnv0AHszNxlPG69U2
 dQCTzzavJyaBT+g07f3+NKS+xdb0Ou9bDCf4jXq9STU6RDYrUHddWlGsSasg+AYWQkyj
 tm6dDqSt1daAARrU52YuGZyBnPvWO/30qQpr+puxB+dfdBkisgFzoWNhvVDPsA+9G+2W
 2a84ErZ+jR6rpBEcRLopYa1YORRbVnwEb4noeZ9VdvE58K7vVVHtyfeyqCvHLW8r9K1c
 HuyQ==
X-Gm-Message-State: AOJu0YyqWs7/gSdpvZUg9pGs6/+iOdZxC9wuwNV9eprj77W6hVWei+6n
 1ecFShskuMRkVRU4C7NtOUc+ugnOgpq5igxZJaQu/g0eJefKoR+JJH/e
X-Gm-Gg: Acq92OHpHaS/sTCCUIefWz7b+cut9Inj4MyJ6hx9Cu1WDKpfP83N2DAxmgJRUww20sK
 DuT5soggtfH2J1bOStWQRTvtAKS5NXpoKkAuKgEb/f1Xc53YC90yarzSuNMUhNzdkYEwY7j9htC
 OfP0KelWbdo9078g+KaES4LS1eMHqGww9n9R8sGA2Fi/HY2+vR8dhZXVx+lU3a39Pm3jtiVEF0T
 lchLkepw3v8yTHwRwJoQUuWYBVIYeXBJt/QWKLRtTTtUaBZO4tpCeoI7GFLdARgkwmndOv7hS77
 GbdkO/2ccy8hVTIqRvpXYJqpW3qvWArj1ex7CEv2cqAxznhMgNlfU3geZaAOLNNljZkEoX9sMtQ
 1pA58cgzjRs/DnoBCqS8tswED+YnVgL5AMUrU7OFAWHArdEUZda7UapfNLodDkS24ghXju8j4Ca
 OVy0NtFmnBXRAvFVtVJE4uOaj8NgNtauJm5wBpxDljCMTSKGYXHAQFGn2LxzFrMfr5eBa63rvS4
 w6Hm0vGn2V7k4+tCCuWgxxV3zHtYH3m1rJ4+ucf0QPb6DiT+0JxSwVCwkRjycGQ14yJ
X-Received: by 2002:a05:6820:1b05:b0:696:2674:8a18 with SMTP id
 006d021491bc7-69c943688ffmr297895eaf.35.1778780298965; 
 Thu, 14 May 2026 10:38:18 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:15 -0600
Subject: [PATCH v7 26/35] target/mips: add Octeon LA* atomic instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-26-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x230.google.com
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

Changes v2 -> v3:
  - Drop redundant TARGET_LONG_BITS guards from doubleword atomic paths.
    (suggested by Richard Henderson)
  - Group LA* translator wrappers by argument shape instead of adding one
    wrapper per instruction.  (suggested by Richard Henderson)

Changes v3 -> v4:
  - Use i64 atomic helpers for both word and doubleword paths and select
    word sign-extension through MO_SL.  (suggested by Richard Henderson)

Changes v5 -> v6:
  - Rename the shared translator helpers to distinguish fetch-add and
    exchange operations.
---
 target/mips/tcg/octeon.decode      | 17 +++++++++
 target/mips/tcg/octeon_translate.c | 74 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 989762fffc..ee1d636e4e 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -64,6 +64,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
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
 ZCB          011100 base:5 00000 00000 1110- 011111 &zcb
 
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f5c976db0d..b4a4243560 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -195,6 +195,68 @@ TRANS(SAAD, trans_saa, MO_64);
 TRANS(QMAC,  trans_qmac, gen_helper_octeon_qmac);
 TRANS(QMACS, trans_qmac, gen_helper_octeon_qmacs);
 
+static bool trans_la_fetch_add(DisasContext *ctx, int base, int add_reg,
+                               int rd, int64_t imm, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (add_reg >= 0) {
+        gen_load_gpr(value, add_reg);
+    } else {
+        tcg_gen_movi_i64(value, imm);
+    }
+
+    tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+    gen_store_gpr(old, rd);
+    return true;
+}
+
+static bool trans_la_xchg(DisasContext *ctx, int base, int add_reg, int rd,
+                          int64_t imm, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (add_reg >= 0) {
+        gen_load_gpr(value, add_reg);
+    } else {
+        tcg_gen_movi_i64(value, imm);
+    }
+
+    tcg_gen_atomic_xchg_i64(old, addr, value, ctx->mem_idx, amo);
+    gen_store_gpr(old, rd);
+    return true;
+}
+
+static bool do_la_imm_add(DisasContext *ctx, arg_la *a, int64_t imm, MemOp mop)
+{
+    return trans_la_fetch_add(ctx, a->base, -1, a->rd, imm, mop);
+}
+
+static bool do_la_reg_add(DisasContext *ctx, arg_laa *a, MemOp mop)
+{
+    return trans_la_fetch_add(ctx, a->base, a->add, a->rd, 0, mop);
+}
+
+static bool do_la_imm_xchg(DisasContext *ctx, arg_la *a, int64_t imm, MemOp mop)
+{
+    return trans_la_xchg(ctx, a->base, -1, a->rd, imm, mop);
+}
+
+static bool do_la_reg_xchg(DisasContext *ctx, arg_laa *a, MemOp mop)
+{
+    return trans_la_xchg(ctx, a->base, a->add, a->rd, 0, mop);
+}
+
 static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
 {
     TCGv_i64 addr = tcg_temp_new_i64();
@@ -319,6 +381,18 @@ static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
     return true;
 }
 
+TRANS(LAI,  do_la_imm_add, 1, MO_SL);
+TRANS(LAID, do_la_imm_add, 1, MO_UQ);
+TRANS(LAD,  do_la_imm_add, -1, MO_SL);
+TRANS(LADD, do_la_imm_add, -1, MO_UQ);
+TRANS(LAA,  do_la_reg_add, MO_SL);
+TRANS(LAAD, do_la_reg_add, MO_UQ);
+TRANS(LAS,  do_la_imm_xchg, -1, MO_SL);
+TRANS(LASD, do_la_imm_xchg, -1, MO_UQ);
+TRANS(LAC,  do_la_imm_xchg, 0, MO_SL);
+TRANS(LACD, do_la_imm_xchg, 0, MO_UQ);
+TRANS(LAW,  do_la_reg_xchg, MO_SL);
+TRANS(LAWD, do_la_reg_xchg, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


