Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D209CD484C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI5-0005Ez-0N; Mon, 11 May 2026 14:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHY-0004jl-TS
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:09 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHW-0002pm-SZ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:08 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dccb8644c4so2422282a34.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523786; x=1779128586; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T69P05u80FP16DZG5zP8y7vdBjPqc7mC4DbwV5goiCM=;
 b=qku1VJP4WkkRD9cuMe645qJkL2DPFfoHYO1XbucyxsxIKZ7CWLu5c8BriHu8BadYpf
 /an36RVjOMxujtAQZNlJrT1W9LNA+kymuqN3QhnaBeGNHfixSEyLhiIkC+5wHG789Kxl
 VA3xKEFUNVXM5R/K4+NtnmgVGDY+lWSTTwld9ggpSQd2nFGMH9sMkivWwK0qvIQQnfhw
 kF7y2Y/5dRNF1BocgH50ogCGp6a37Ox7XEBgbn6GHasa5Ulcc1IskX57JLeUNBMczHfm
 FdWY7XZjcL0GvLQfjo78kwucfL0E2/wqVr4+lJfFEXM7eXf0UV/vhjcb5YWT2WD/GXsw
 jSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523786; x=1779128586;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T69P05u80FP16DZG5zP8y7vdBjPqc7mC4DbwV5goiCM=;
 b=D4h9zS3DT0Eyw8QKvrIn5r+u9ruB99ZeoqQLKfx0XIPhhLbg9IrFhXVIlLP98g+lJ3
 gY98zb5MOYeji1CD7WaOG2jrJXA9cvkfPLD1Er6ZDHRm4t8GKTSFtB0+29Q94/CSH6XS
 IqwnYEGY4lf/RMlhKAgmFss8DtlV5u9piyEjR2FlhirJIisz2h8eT4+l4MauRqN3V0zC
 CkRSfE2V8B/DJpnhQUj+qEi/vM+X/wogcEBn2kpw4oMCCb5OuJQ4s7gIlTb+L03jlq6E
 Z7fYxSY1r822VLxzXzYZzhZ/axO1VADbAzyE7+9KiuPByzNURecI1T5MLfFHo9XboBlF
 aeQg==
X-Gm-Message-State: AOJu0YztKRqbueQVcLOYfRhJEyJoGHio0nD/e9CopvOE8SWdKiMIcTTr
 iKYNlb5lI25ibhR4Qe1l5tclJ4pFKLcUaOtjWisb5mZcGDh1J6T57IGh
X-Gm-Gg: Acq92OE84hxWiD0AWezcW8K4IfNXOeAGUemAfC9c2OE1zoOGs6Z1/HJewvolC40GBi6
 vqIEWUOH/iYVfsu4GcFLp0gqmxxIyXvj5yEk+esE5PChdR1kGe3mYWGCsaMiGuWFCdOwHKbUlmF
 pjyXY3iRFmTDHVwF+D3AtUUEJyDQnKaT0r0e+ayqRsxnIZtpipfCP1KZnfhRncL0Yp644SQjYUA
 kVh4GdjvTwJi0+gSpBBOmqGi9h329j8l2APqdYOBhnIv7ogWqpj5h3SlthSUDEkBls0oqYCp1EI
 mMmHny3sdHf3+oXPT1X2DGRJ0UaFPYjvJ23Vr1a20Ts+l57l06JA3RcQR+/X3sPZiNPisvedwkB
 BL8+X0OQil+YFaS4oL+rzdefp1nSFAkIq/DIbFiZW51busalSGbXGVFvDGBdB/uLiEb0FNdPNML
 5Kk6BR1nuy4bSm4FnqVpzMcdEdreaH+98fT4KqoG+CEDvIe1Gj/IPzAAPvTGGmyvc/Ln3KGDpJK
 Z2Y2WlUl9YfDBsP8SXNmsBREWH/SZ455q64h0ApC8su235t71y1lZNNqU4Qu6A9S+n5
X-Received: by 2002:a05:6830:6a13:b0:7de:84b5:88e3 with SMTP id
 46e09a7af769-7e1def6b71dmr15036681a34.8.1778523785782; 
 Mon, 11 May 2026 11:23:05 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:46 -0600
Subject: [PATCH v6 15/35] target/mips: add Octeon MTM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-15-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x335.google.com
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

MTM0 loads the low Octeon3 multiplier operand pair from rs/rt into
MPL[0] and MPL[3], starts a new multiplier chain, sets MPL[1] to zero,
and resets partial products. Model the architecturally unpredictable
MPL[2], MPL[4], and MPL[5] lanes as zero for deterministic emulation.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 two-source rt high-lane operand and document that
    legacy one-source MTM encodings use rt == $zero.

Changes v5 -> v6:
  - Clarify the CN71XX-defined MPL1 zeroing and the modeled-zero
    unpredictable MPL lanes.
---
 target/mips/tcg/octeon.decode      |  2 ++
 target/mips/tcg/octeon_translate.c | 57 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 5377f7b3ef..bf1dab61e1 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -43,6 +43,8 @@ SEQ          011100 ..... ..... ..... 00000 101010 @r3
 SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
+&r2          rs rt
+MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 75b28c4338..4507f8a5bc 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -198,6 +198,62 @@ static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
     return true;
 }
 
+static void octeon_store_mpl(unsigned int index, TCGv_i64 value)
+{
+    tcg_gen_st_i64(value, tcg_env,
+                   offsetof(CPUMIPSState, active_tc.octeon.MPL) +
+                   index * sizeof(uint64_t));
+}
+
+static void octeon_store_p(unsigned int index, TCGv_i64 value)
+{
+    tcg_gen_st_i64(value, tcg_env,
+                   offsetof(CPUMIPSState, active_tc.octeon.P) +
+                   index * sizeof(uint64_t));
+}
+
+static void octeon_zero_partial_product_state(void)
+{
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    for (int i = 0; i < OCTEON_MULTIPLIER_REGS; i++) {
+        octeon_store_p(i, zero);
+    }
+}
+
+static void octeon_reset_mtm0_mpl_state(void)
+{
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    /*
+     * MTM0 defines MPL1 as zero; model the architecturally unpredictable
+     * MPL2/MPL4/MPL5 lanes as zero for deterministic emulation.
+     */
+    octeon_store_mpl(1, zero);
+    octeon_store_mpl(2, zero);
+    octeon_store_mpl(4, zero);
+    octeon_store_mpl(5, zero);
+}
+
+static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    /*
+     * Octeon3 two-source MTM forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(value, a->rs);
+    octeon_store_mpl(index, value);
+    gen_load_gpr(value, a->rt);
+    octeon_store_mpl(index + 3, value);
+    if (index == 0) {
+        octeon_reset_mtm0_mpl_state();
+    }
+    octeon_zero_partial_product_state();
+    return true;
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
@@ -207,3 +263,4 @@ TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
+TRANS(MTM0, trans_mtm, 0);

-- 
2.54.0


