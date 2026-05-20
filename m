Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54236CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfB9-0000jh-IZ; Wed, 20 May 2026 07:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfAe-0000aL-KG
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:33:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfAc-0005V9-Ls
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:33:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so51312775e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276781; x=1779881581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3tB4I2+pMdnmR9l2bJ++U+op0Fphm1lK4xLfeLa6Zo=;
 b=pPl4hdnxcjfguEDIz5gHYVC+dtRX6T5R0Ha4VIw+BHYFqeAP4eBqLbq4s9Iw8n+WfC
 6kjUdyh2YB8B/NKzTTc6bQiMmsB4kE0dtGxcEDBTq1il7uUXZF+55q1CMmemEDtb2q0T
 sZrWjjBYFVgTha42dvqyNrHj/CD1o57rHtEKV96lNZBNYdu9rcFyq8LHhfzL6tIEbelZ
 7EkEo6xPl9teYozPbfC/RKBUKN2fCGYgF2RvX0FfW02R3u1Y8ffZeMzqIe/W1tq3x0FL
 mMEe1ibnY4t3ByI4/4W3l+z0CwE2/gv77wRXXQk0UJkZl7Grv6XyAMrgbKJ5anINCKlR
 W2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276781; x=1779881581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l3tB4I2+pMdnmR9l2bJ++U+op0Fphm1lK4xLfeLa6Zo=;
 b=r3n+WSrC/Cf2hxuzp1HdTghej4INMwqO4svNZW9KmJjvwN2bBcC2OrAdP1MOb10+Rj
 9oca9alOVLdW+fm6r2hZodH6Q1agNI9710nhJQu/5oWcIQUEg5P92+X6E+o8WCHocs83
 Ub+iz9JVlD8tc3zlDZbhGLtSXBFpw+ulrfu2fFiIgJYrNSxI7M6tRGix5GXej7abCZbS
 tTlf2pTrkxsRxaSH/e1M2tHfwnBRnGuXH37N964J+nYaJHw+wOIAJ95ARksVJBIy0dU0
 7Xue4D6znCzTNBJ8rwLehfg+gQQoYSkxQZ0fOvu2tEI1WT7eMc7f1WmnXFFVetgnp49c
 6A4A==
X-Gm-Message-State: AOJu0YxsQmfcRov1//7trmlp7DXZFVK87d7/J2PV9DmvgETNTIi7kqaH
 2dSiVzuYQmf3KPD6r1xX+kJKY+idb5hAiWnSzHQWN0qm5YiipPoMkuw1snrBfmzwxlCYEXuchhT
 8cKvFQuw=
X-Gm-Gg: Acq92OEw2dfiKnAP4KNFkkbyJ3VzgV2ITm9j8QecgxPCP1mmKsMfdElXcQml0aIBrHI
 qPMa65qsnkkcl6oLSODFkWGFUVU/igeUyVC3NhHbThi1Ir+dNE/sngnXNnXNhq4G94Oa21nySVC
 K9hpNI+INgahwNHzFEFo7V3RbafLewVUtb1dpjP4+u4PgC9Xcc6WFGjblXzrFp03YBgkwU+OXpX
 Nfz5BhOId9NlfWD9k5anQcd1DyDy0b0y3tpMnpXxzyZxqqorI8xZgEko6Pfq9bkkC6AsDYOOCyI
 7sZcYH189Gnc75tT7SRYptal8gqMYPRZcGrjA6/dpbwfCMOLg/f4rKk5nys1TEj988+3HiQwz47
 sRaQoZhLKm1ldmvPSAHqmk0fe01Ay6EQVyRMTRMDyP+c3FTE0FMTn35HwMNPh5tvW+s4vsqyCax
 iM3gasu6cM2GjJCGqXCIpI6w8fHwOuiOm+9IgbsReXGJY58ZeWjGjQ2hO4A+ObW/b6ziQJzbuMN
 p688A==
X-Received: by 2002:a05:600c:1f89:b0:48e:526e:101a with SMTP id
 5b1f17b1804b1-48fe60e7a13mr344800065e9.12.1779272466747; 
 Wed, 20 May 2026 03:21:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe57943b2sm397586955e9.8.2026.05.20.03.21.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:21:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 24/24] target/mips: add Octeon LA* atomic instructions
Date: Wed, 20 May 2026 12:18:05 +0200
Message-ID: <20260520101807.9971-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Implement the Octeon LA* read-modify-write atomic instruction family:
LAI/LAID, LAD/LADD, LAA/LAAD, LAS/LASD, LAC/LACD, and LAW/LAWD.

These operations are architecturally distinct from SAA/SAAD and are used
by existing Octeon user-mode code for atomic counters, bit operations,
and exchange-style updates.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      | 17 +++++++
 target/mips/tcg/octeon_translate.c | 75 ++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 2d02b4e0bc3..1e44c588dd6 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -68,6 +68,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
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
index 684236b1a87..eff46c30a09 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -177,6 +177,68 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 TRANS(SAA,  trans_saa, MO_32);
 TRANS(SAAD, trans_saa, MO_64);
 
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
@@ -418,3 +480,16 @@ static bool trans_QMACS(DisasContext *ctx, arg_QMACS *a)
     tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
     return true;
 }
+
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
-- 
2.53.0


