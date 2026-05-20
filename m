Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46BBCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkgl-0007oz-Cb; Wed, 20 May 2026 13:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkgT-0007MO-Rv
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:26:25 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkgR-0004Ob-QX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:26:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso61690155e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297974; x=1779902774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZUn1sDP88Z8+UtSPwDII7B77ZqjW4rgF/4PuSkFRU4=;
 b=Q9gdpTp3VoXu44FiUqlL0kY7boe+KGEadSKeFOvB9+uF53hV949S0h3UFAoGjX+DJX
 y5ijH/ZcmI+e1cAokyMjZnkdQ+yZkEnku0yfed/KeOzI6byH0OdA7SaosY3TKyib58Aq
 t0KMplH4KSC6cJ0VONpiLTV5Z8qGqWebwAUSy3+tMxBy05HzNjE++3zooC1uParFeE94
 JSf6lb//RarFg2us56Pkh2hM5eh1PFxtciuIPtIrtlj4aJxTnZu0TwVbw6hrVLelt6Ze
 qcERDGzrmjgPeL7zKWfNW809kphq8Dvq0AxIFv3Wdq0wIDWnJjE+kGQED6erHqlFZDo+
 Q7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297974; x=1779902774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oZUn1sDP88Z8+UtSPwDII7B77ZqjW4rgF/4PuSkFRU4=;
 b=EVFOPrDgs/qBMDIRHtVCsueprWcevqOm1BNTvASjVi1QHOMj0K9VUCkpktNBvbMWxV
 eW6qX4zbDR5zUcBNPScxjTQCWtlOTHaGm2J9dS8Be9S1I2SihvbIZWF9RMms9XfukOCK
 yWPxT49oL+62PL76hKS4WtZDjgEYoFnbWHj7JsQ2zorCtkxti5S9nVQmHlA6k2bYE9QK
 xN2aEglxCm/zkzv+yuMqz5qM5ZA4Dd5Zkh6+Z8ubni2x7+hjZQ2oaKuOxeSPddewPqwa
 nomh6av3SNz62jdzXpCO/6Kt9RgZUK5UYn53hdY1WETCO6tvDzPuupfujKukkUpUgHaC
 be6w==
X-Gm-Message-State: AOJu0Yzhx/vgAqXIpNSzIddb66wnCcpwMXEmsoHyDaBITPDaJOleFV5X
 XhLdGQh3bAZBXIiAEiHq+cNcneqDiEYOYBd9W+RSNwCoxC35KaT8qef/gC/Iu3jwtGKwng55s8C
 mwNrmyOE=
X-Gm-Gg: Acq92OEVERAmlKv0M8NjUK3fgNvONgO2JqH/kphRoW5VjmPmmdHEGH/0afa2nkySL6C
 AuBnhAoREz8ZgaFwr5APlowTYEhni75dYFlqYSL6hDEMIF/v489L8EsVrJznI/nuukSrkhnDj9Q
 ZOIC4VxDO3VC0gvoOgXJd3b9r2oXsf2wAwIO2GWLGhott1pI/44W5kdlu0I47Ls1V4CIvd2cRI7
 itFD7et392qIa/lO59OVMC2oGNJgwvFlMiEeI1ahijXrMOiHDaH9egklZ4jpcW/xoRVK+Av43mb
 4T9Lx2+lbb7meA5qF9STTCEWN5ejTdFu4KGbyHPDdumjkfFTejyUql5BjtLe4NTJAmuNSFQZyky
 07xhYtxLGM40k2qpP0LgohDgyp8bCboIRwmGTEfKzIfvGsCUodIvcRJSWYpJjBcq+4wqxBcvz3x
 IVE8nbBXAYtWVjVyK2JWRzsKoZqu9P7JKg2vJ9gskOhbsIq9duJkmtH16lp1i0agPVpQV3z+E1O
 Oh/IMEE0a4=
X-Received: by 2002:a05:600c:34c3:b0:48f:d0f7:78f1 with SMTP id
 5b1f17b1804b1-48fe60e4e27mr405631265e9.4.1779297973722; 
 Wed, 20 May 2026 10:26:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4902ea3d876sm16012485e9.30.2026.05.20.10.26.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:26:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 24/24] target/mips: add Octeon LA* atomic instructions
Date: Wed, 20 May 2026 19:23:12 +0200
Message-ID: <20260520172313.23777-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 target/mips/tcg/octeon.decode      | 17 +++++++++++
 target/mips/tcg/octeon_translate.c | 49 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

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
index 90bd68cbf25..47d46999487 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -185,6 +185,55 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 TRANS(SAA,  trans_saa, MO_32);
 TRANS(SAAD, trans_saa, MO_64);
 
+typedef void AtomicThreeOpFn(TCGv_i64, TCGv_va, TCGv_i64, TCGArg, MemOp);
+
+static bool do_atomic_ld(DisasContext *ctx, AtomicThreeOpFn *atomic_fn,
+                         int base, int add_reg, int rd, int64_t imm, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    TCGv_i64 value;
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (add_reg >= 0) {
+        value = tcg_temp_new_i64();
+        gen_load_gpr(value, add_reg);
+    } else {
+        value = tcg_constant_i64(imm);
+    }
+
+    atomic_fn(old, addr, value, ctx->mem_idx, amo);
+    gen_store_gpr(old, rd);
+    return true;
+}
+
+static bool do_atomic_la(DisasContext *ctx, arg_la *a, AtomicThreeOpFn *fn,
+                         int64_t imm, MemOp mop)
+{
+    return do_atomic_ld(ctx, fn, a->base, -1, a->rd, imm, mop);
+}
+
+static bool do_atomic_laa(DisasContext *ctx, arg_laa *a, AtomicThreeOpFn *fn,
+                          int64_t imm, MemOp mop)
+{
+    return do_atomic_ld(ctx, fn, a->base, a->add, a->rd, imm, mop);
+}
+
+TRANS(LAI,  do_atomic_la,  tcg_gen_atomic_fetch_add_i64,  1, MO_SL);
+TRANS(LAID, do_atomic_la,  tcg_gen_atomic_fetch_add_i64,  1, MO_UQ);
+TRANS(LAD,  do_atomic_la,  tcg_gen_atomic_fetch_add_i64, -1, MO_SL);
+TRANS(LADD, do_atomic_la,  tcg_gen_atomic_fetch_add_i64, -1, MO_UQ);
+TRANS(LAA,  do_atomic_laa, tcg_gen_atomic_fetch_add_i64,  0, MO_SL);
+TRANS(LAAD, do_atomic_laa, tcg_gen_atomic_fetch_add_i64,  0, MO_UQ);
+TRANS(LAS,  do_atomic_la,  tcg_gen_atomic_xchg_i64,      -1, MO_SL);
+TRANS(LASD, do_atomic_la,  tcg_gen_atomic_xchg_i64,      -1, MO_UQ);
+TRANS(LAC,  do_atomic_la,  tcg_gen_atomic_xchg_i64,       0, MO_SL);
+TRANS(LACD, do_atomic_la,  tcg_gen_atomic_xchg_i64,       0, MO_UQ);
+TRANS(LAW,  do_atomic_laa, tcg_gen_atomic_xchg_i64,       0, MO_SL);
+TRANS(LAWD, do_atomic_laa, tcg_gen_atomic_xchg_i64,       0, MO_UQ);
+
 static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
 {
     TCGv_i64 addr = tcg_temp_new_i64();
-- 
2.53.0


