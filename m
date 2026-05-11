Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B1ACD484C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHb-0004kj-Lg; Mon, 11 May 2026 14:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHQ-0004hY-Gh
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:00 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHN-0002fj-TX
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:00 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e363c6141dso3047611a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523776; x=1779128576; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nr1RHhakz2fMCwd5oVw8Lh14BokGT3MnBkKAzUjV7o8=;
 b=M90wcVcnYxxuPX8qs6ng1oJ3MJuIcCkD575x9ktsGl4McmbRlF+2uJjd9ZWMdtW12X
 aQ2Oc1emoagrk2awdSizzuJBagVKpBTeAP1bdabfp/yTs7VGyct+j04lYDXUGHoPkYUb
 RMGrLg0cgHLIrom/vI0tBLfsY4M+ydh/M4wpHIzuwqZ+560FmSTcgFPrgW5G6PFVEk5p
 bT+9XiFS5ysLYTdIS+ps3S2+enYNwQyeF3tkXe7O8dZNq1XjOkcesf5VVM7lv94ZGinc
 9cP2opYL02iqUoCGcb1HDOGQjfwtqFPs3YUm5nxEs9hA2SXS1O7qfuYYgWdzSzomLK8K
 vdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523776; x=1779128576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nr1RHhakz2fMCwd5oVw8Lh14BokGT3MnBkKAzUjV7o8=;
 b=fAZWXb837ynVyTlkTm6BhiYNLUiZF50GPof9RYyHTWji6nXzT8aC+ibTnV91akn3pW
 opOxAJDzOcmYt7awapfoN7QMt4zDVOo69OqlHmitVbBWNXknABSTl2L1UX055GUXkOfM
 seCsp7q2iPBOvr8qeONhR6LzypRmSd5r7n6GbWkP/xmrbHlr2/dTuF5DWme1m1vXP07n
 Obf8h5RM78XhHAgNN2tbvReQtay7n1nmZJJ7RuIwroTtpUU6y2u9Qv/vvmPPjHDaCmNa
 y8UvdxVZMi+A+mkuVwOekbDULUvcr6b/tvyijutip3BWc97TU7lAE3co/ScR6sd1bNEX
 FBUw==
X-Gm-Message-State: AOJu0YwyC0oMc85myiMI4aSjTsJiOPeW++SkAXXV73pFTpA0cDEhF9fT
 fpv+kjqm175GHBPIQbhQgii7W2Y1j0iegYe+k5AjHbJUpm/Wie/k6QBi
X-Gm-Gg: Acq92OG8VkbGPLWII0hzESw+bCqs7T2veoH/j5/X5wNeEIh74wXmi5jo+4ZtA9yWGaq
 ugJ3b0Hoprr9N2gEIYIzBe2uMASKy1HXmi6M6M/8ZGy4jo16I+/1nHmJPL/5esqGqQ8lc6EAPfM
 D5J2Jpac58Kge6Z49fwtgLFtSJISQJXu773PTUGRT2ugNtUcHNIy0GehvYLbdmQv+f6ghAZie4F
 7D+B21IybI8dtCu/dlT3ohG7uupe774HTVrAvIKFt/YC1kfqKeZk6LNbM4Sg9h68TIi0GY7fIwj
 nAREBmXU1frzvn1JOGDubGsTgaHUNSGnKCD39MvIudEZMT0Gxc8ApLNNCy83TV1iL5L20QQGyOK
 HOumSI7pCQebw70/gL/TpvrGtMQoy3b9Ig4GKpGejIUbviXpHVKuN4e3OZ7mgKnUU4EYZ5QmNee
 maXRvt+6awOx/v4go2t+gUY3qj2FqKhS6WfZD8UASxSJvLczQLg9UJHFXJKD9jvMPwgNfArg+kC
 sLuG5JbRcAX6osgNZpKZQIXCHoHC2f9wD6fuK6kWQp6GlCwvFNk4yaGVA8tVIz2+B52RN697mFu
 F9E=
X-Received: by 2002:a05:6830:6734:b0:7de:42d5:6243 with SMTP id
 46e09a7af769-7e1df0da8c3mr15487439a34.13.1778523775975; 
 Mon, 11 May 2026 11:22:55 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:22:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:36 -0600
Subject: [PATCH v6 05/35] target/mips: split Octeon SEQ/SNE decode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-5-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32e.google.com
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

Decode the equality and inequality forms as explicit SEQ/SNE and
SEQI/SNEI instructions rather than using shared generated SEQNE/SEQNEI
entries.

The explicit decoder names match the architectural mnemonics, which makes
the translator entry points and trace/debug output easier to correlate
with the instruction set.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the SEQ/SNE decode cleanup out of the Octeon arithmetic
    instruction patch.  (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Remove the decoded ne field now that the instructions are split.
  - Reuse @r3 for SEQ/SNE and pass the TCG condition into a shared
    translator helper.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  7 +++--
 target/mips/tcg/octeon_translate.c | 52 ++++++++++++++++++++------------------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 102a05860d..a2bfd0751d 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -30,6 +30,7 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
 # SNEI rt, rs, immediate
 
 @r3          ...... rs:5 rt:5 rd:5 ..... ......
+&cmpi        rs rt imm
 %bitfield_p  0:1 6:5
 @bitfield    ...... rs:5 rt:5 lenm1:5 ..... ..... . p=%bitfield_p
 
@@ -38,8 +39,10 @@ DMUL         011100 ..... ..... ..... 00000 000011 @r3
 EXTS         011100 ..... ..... ..... ..... 11101 . @bitfield
 CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
 POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
-SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
-SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
+SEQ          011100 ..... ..... ..... 00000 101010 @r3
+SNE          011100 ..... ..... ..... 00000 101011 @r3
+SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
+SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 4dd7626835..8e49e16b5a 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -121,52 +121,54 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
     return true;
 }
 
-static bool trans_SEQNE(DisasContext *ctx, arg_SEQNE *a)
+static bool do_seq_sne(DisasContext *ctx, const arg_decode_ext_octeon1 *a,
+                       TCGCond cond)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
 
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    if (a->ne) {
-        tcg_gen_setcond_i64(TCG_COND_NE, cpu_gpr[a->rd], t1, t0);
-    } else {
-        tcg_gen_setcond_i64(TCG_COND_EQ, cpu_gpr[a->rd], t1, t0);
-    }
+    tcg_gen_setcond_i64(cond, t0, t1, t0);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
-static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
+static bool trans_SEQ(DisasContext *ctx, arg_SEQ *a)
 {
-    TCGv_i64 t0;
+    return do_seq_sne(ctx, a, TCG_COND_EQ);
+}
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
+static bool trans_SNE(DisasContext *ctx, arg_SNE *a)
+{
+    return do_seq_sne(ctx, a, TCG_COND_NE);
+}
 
-    t0 = tcg_temp_new_i64();
+static bool do_seqi_snei(DisasContext *ctx, const arg_cmpi *a, TCGCond cond)
+{
+    TCGv_i64 t0;
 
+    t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
 
-    /* Sign-extend to 64 bit value */
-    target_ulong imm = a->imm;
-    if (a->ne) {
-        tcg_gen_setcondi_i64(TCG_COND_NE, cpu_gpr[a->rt], t0, imm);
-    } else {
-        tcg_gen_setcondi_i64(TCG_COND_EQ, cpu_gpr[a->rt], t0, imm);
-    }
+    tcg_gen_setcondi_i64(cond, t0, t0, a->imm);
+    gen_store_gpr(t0, a->rt);
     return true;
 }
 
+static bool trans_SEQI(DisasContext *ctx, arg_SEQI *a)
+{
+    return do_seqi_snei(ctx, a, TCG_COND_EQ);
+}
+
+static bool trans_SNEI(DisasContext *ctx, arg_SNEI *a)
+{
+    return do_seqi_snei(ctx, a, TCG_COND_NE);
+}
+
 static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 {
     gen_lx(ctx, a->rd, a->base, a->index, mop);

-- 
2.54.0


