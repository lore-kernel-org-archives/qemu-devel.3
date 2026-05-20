Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F2DCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgn-0001DU-FK; Wed, 20 May 2026 00:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgl-0001Co-SW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:47 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgi-0003q6-Mn
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:47 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbe437b072so2203792a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251862; x=1779856662; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wGjbiQzXhTzZCgVVJ0XKJGCOtGh1D26h4qODBf+H8sg=;
 b=YR1i/0AtDkWF+szJdddMegNESfpNCoM/lc1htw01qjQ+Pzy3ofQGss3fTgs4A08d5K
 OFoyZehoEpU4F9Y0Liuoo4rjNYpECc2Gd4uNqzj/FeqFYzGTj3B2tkCVySPPQlosg/ob
 bI0VOGNruN6fVCHiucBYaiAG0uZWdK8f69lJUnhShm1z6WixLNdSVseJcpRGtYDU9c0W
 hi0VKqxSb24EkSYMnOR4XlWlffxv8pil/YiQ2GqBXiOg4dfyLSvdzAGM4q1d5CFwVOis
 v5PWyqv2poBgetODPsPLMxdNMK0A6oysS46EG/20pFeYTmhTQYk5PhCioVXKqI9Jpyji
 XkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251862; x=1779856662;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wGjbiQzXhTzZCgVVJ0XKJGCOtGh1D26h4qODBf+H8sg=;
 b=cyK90UiOYE+zpI9/L3Qw0+8hd8HMh/9FbdYBxaqR+2YkdoDYYg9gSnW2o29yEYwdQe
 L7ZaVbBWFXzdpjzExCmrJfONgS84g81hzNUwBzDSUg4CarvNRnUccEIsyw5UTQLWiuPB
 RA3i6HQocuFPcTDUavTv4otI+QVvTDTJIg8WSWOgOGDBiDdGIi/zGaV7TTC2HOwqZ9GL
 FO5RZk8c83FvDc4CFhmfoohYF/vaiO65wfGgM0L+UwX830pWVs/rqEqHd4HTj7s62auf
 ULyKlho8Oondl00mSppTlKHxxIDNEGs3rvHXrwQuHH9I/o9afHyEmUrmapqOI5QJbX9s
 NBzg==
X-Gm-Message-State: AOJu0Yw0djoSc0f3lej4R/A7pDKOCJRL/4Jvejf0rB2/c3yIhExrCRdZ
 ATdAKW5oLrSyXtegmSjtLpwAWp+ihD/FjsZ8N/77uXxlQgVFD67NPNWO
X-Gm-Gg: Acq92OExAyEy/FTEeoU6pt2DHMvJvrmKz0bLoh4y9dJkhClgALhtfbDoQE2XEe8Nntq
 ytIc42SUn/6nmcFER1+yTf4RfRgbAp3RcNGMunpzvVflRqcIcAuDxCt2zgBsvWhYn9clsKVBVQI
 ifNFRFWlTU2iZ9pek3H1T7il55EodM9eehCL1Pik2xgXzsZxIZoLsXKWx9G+EYEjNeNaYHlw0a/
 D7biZtJgo+1sMzYMRHV2DydRkxpngbjdGrjhQihcEim95EB2t0GuJBeoQISdK05wEw9eM+RUii3
 pyVNvNfDnxZyvLzGXjzY/MsRhOtnTHcmdtk+iuuR9CTqq3DlPGmdnbZJyzk6hY9f8iLkwYDXS/E
 CPvpOJpewlRxAw9+x4EGXaOsJQ+X5ccUxb4qDlRITS8EXp1Ulp7LXZt+RWO729ETIUpBOqK5CPc
 XaOHTseiT2bSYYNKyo4H0a2JOthLY9jbKfoR77ek5vK6EIMR9HoBcEI6wEqx295EMMzgiHZ3Vna
 2+6yPcOUiartWzKslgq83iYI0Z4tY7ejHpKOz8K/ArqtNYaH+vhLGTu07HhqC3RboCu
X-Received: by 2002:a05:6830:6187:b0:7d7:e6cb:836f with SMTP id
 46e09a7af769-7e4f2bad231mr14348711a34.19.1779251861921; 
 Tue, 19 May 2026 21:37:41 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:17 -0600
Subject: [PATCH v10 23/45] target/mips: add Octeon LA* atomic instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-23-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x334.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
 target/mips/tcg/octeon_translate.c | 75 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 2d02b4e0bc..1e44c588dd 100644
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
index e068fd8698..55cefe0903 100644
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
@@ -416,3 +478,16 @@ static bool trans_QMACS(DisasContext *ctx, arg_QMACS *a)
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
2.54.0


