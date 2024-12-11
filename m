Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B34E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPdh-00076I-6l; Wed, 11 Dec 2024 11:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPca-0004Ga-36
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:32 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcY-0001FL-7y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:31 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4676e708aeaso26629201cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934689; x=1734539489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mv4+39/cFGoJE7L8lZWTi5JvZoPChXZESu684RPUKCc=;
 b=ayS5X4dLrF2FDIOHD6Byo8WlivOEL9A/EAoRoTPguUKtQSrMNYp2LUJ/aWjJ9wpGVC
 1niap2EhE17Pixg7vB631D16w5EnMI2JYr6ZELa2kd9ucNejPog08sehn9uhTc2N+Ff0
 pqSZYZUhsl3Br3SXYNKLUkp7GiL1VYqiCeSO9otVIPniNQuvkwJGNkb9NA7s79S/IE43
 yab8gccHN52BqoznK/nNo8NlJ2vdx3HEtsO+MiRuiiEDbt9g5N9G9VDGlS1fpLnF1IIl
 lktKCemR5072m7R4qiIBU/hT2GM+6+TDcaeP5tLZRkd+n7b+6lFVnFnl0a/+D4y+ysRA
 cwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934689; x=1734539489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mv4+39/cFGoJE7L8lZWTi5JvZoPChXZESu684RPUKCc=;
 b=lS3EivsG0BoOg/fqqlSuJQuFaoFRhD3imAV/T0Mk0lYN3FNMnZ5DgZuoUW0x1i7s6f
 rPKWJIr8HKzWsDai351Z13z8ygoZ8ku0NczteyF/CflJURS+1S+AuWRbVvP9/n4NBj5V
 CZn/0uFAA9aYAYauet50oCn6f+Rk2JwWjZG87wKeSb6auHJFZZ/iAasf7Kb6RtLYxjQd
 DvYL48QdSODr7BwCmmfF6zqRKE9pXLNo1zfxNuIBDCt85ceKkN6aWJ3pJ/+lR2H6PcJV
 6C4bYi4Mah5sO11M10975kjEfb5QZWYEK/7nfQ/+yYcjzsVR2aVgMel1D+tUwsyBBf9Y
 88+Q==
X-Gm-Message-State: AOJu0YxTTepR6YmxudqC2cOe6CEBvTnPNJ7INNggBhvGsBu0/KdmrDxo
 wAc6KAFThwptJmSwKbwAQg/HDMVOBZMDNfkXd9cKTvws7Bl2K5VpdZxlVT1n9iHW7CIJC9aGAj2
 R6bgK2gdi
X-Gm-Gg: ASbGncsmGJaTJ49LNmlB2ra9kntrbqL6CCsIZRJSXIP0Mekrw70Jb7evemkMQbecMGh
 sxAIqMN+LlMoc85+kJI01TmIuEnm0ZrcaWWuG8YbhdaHkJhmWAHHJx13VdrL7CLD7/7U13UaGih
 bzpJVDoTR1JtzMf/hq8tG9WWIAekCao69WymV32n6dSumi7YGSKHKdZvdtHj1jxh4YhDoz34ue/
 WCczeN8fNTijwWiKj6r0JhAZHGlEBEQM1iC66S7hsoNclCAFBYtS/4FrbpYLw==
X-Google-Smtp-Source: AGHT+IErHSmEfGNAn/OMuGLr6UIdWt5R0d1XJkJ07FqFW5qQvFSh7jbMVtPhpaR7RWTO2nuR/cCvqg==
X-Received: by 2002:a05:622a:590e:b0:467:681c:425f with SMTP id
 d75a77b69052e-467892a260amr78255601cf.4.1733934689317; 
 Wed, 11 Dec 2024 08:31:29 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 11/69] target/arm: Convert disas_logic_reg to decodetree
Date: Wed, 11 Dec 2024 10:29:38 -0600
Message-ID: <20241211163036.2297116-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x836.google.com
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

This includes AND, BIC, ORR, ORN, EOR, EON, ANDS, BICS (shifted reg).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 117 ++++++++++++---------------------
 target/arm/tcg/a64.decode      |   9 +++
 2 files changed, 51 insertions(+), 75 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d92fe68299..ecc8899dd8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7805,96 +7805,65 @@ static bool do_xpac(DisasContext *s, int rd, NeonGenOne64OpEnvFn *fn)
 TRANS_FEAT(XPACI, aa64_pauth, do_xpac, a->rd, gen_helper_xpaci)
 TRANS_FEAT(XPACD, aa64_pauth, do_xpac, a->rd, gen_helper_xpacd)
 
-/* Logical (shifted register)
- *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
- * +----+-----+-----------+-------+---+------+--------+------+------+
- * | sf | opc | 0 1 0 1 0 | shift | N |  Rm  |  imm6  |  Rn  |  Rd  |
- * +----+-----+-----------+-------+---+------+--------+------+------+
- */
-static void disas_logic_reg(DisasContext *s, uint32_t insn)
+static bool do_logic_reg(DisasContext *s, arg_logic_shift *a,
+                         ArithTwoOp *fn, ArithTwoOp *inv_fn, bool setflags)
 {
     TCGv_i64 tcg_rd, tcg_rn, tcg_rm;
-    unsigned int sf, opc, shift_type, invert, rm, shift_amount, rn, rd;
 
-    sf = extract32(insn, 31, 1);
-    opc = extract32(insn, 29, 2);
-    shift_type = extract32(insn, 22, 2);
-    invert = extract32(insn, 21, 1);
-    rm = extract32(insn, 16, 5);
-    shift_amount = extract32(insn, 10, 6);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
-
-    if (!sf && (shift_amount & (1 << 5))) {
-        unallocated_encoding(s);
-        return;
+    if (!a->sf && (a->sa & (1 << 5))) {
+        return false;
     }
 
-    tcg_rd = cpu_reg(s, rd);
+    tcg_rd = cpu_reg(s, a->rd);
+    tcg_rn = cpu_reg(s, a->rn);
 
-    if (opc == 1 && shift_amount == 0 && shift_type == 0 && rn == 31) {
-        /* Unshifted ORR and ORN with WZR/XZR is the standard encoding for
-         * register-register MOV and MVN, so it is worth special casing.
-         */
-        tcg_rm = cpu_reg(s, rm);
-        if (invert) {
+    tcg_rm = read_cpu_reg(s, a->rm, a->sf);
+    if (a->sa) {
+        shift_reg_imm(tcg_rm, tcg_rm, a->sf, a->st, a->sa);
+    }
+
+    (a->n ? inv_fn : fn)(tcg_rd, tcg_rn, tcg_rm);
+    if (!a->sf) {
+        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
+    }
+    if (setflags) {
+        gen_logic_CC(a->sf, tcg_rd);
+    }
+    return true;
+}
+
+static bool trans_ORR_r(DisasContext *s, arg_logic_shift *a)
+{
+    /*
+     * Unshifted ORR and ORN with WZR/XZR is the standard encoding for
+     * register-register MOV and MVN, so it is worth special casing.
+     */
+    if (a->sa == 0 && a->st == 0 && a->rn == 31) {
+        TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+        TCGv_i64 tcg_rm = cpu_reg(s, a->rm);
+
+        if (a->n) {
             tcg_gen_not_i64(tcg_rd, tcg_rm);
-            if (!sf) {
+            if (!a->sf) {
                 tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
             }
         } else {
-            if (sf) {
+            if (a->sf) {
                 tcg_gen_mov_i64(tcg_rd, tcg_rm);
             } else {
                 tcg_gen_ext32u_i64(tcg_rd, tcg_rm);
             }
         }
-        return;
+        return true;
     }
 
-    tcg_rm = read_cpu_reg(s, rm, sf);
-
-    if (shift_amount) {
-        shift_reg_imm(tcg_rm, tcg_rm, sf, shift_type, shift_amount);
-    }
-
-    tcg_rn = cpu_reg(s, rn);
-
-    switch (opc | (invert << 2)) {
-    case 0: /* AND */
-    case 3: /* ANDS */
-        tcg_gen_and_i64(tcg_rd, tcg_rn, tcg_rm);
-        break;
-    case 1: /* ORR */
-        tcg_gen_or_i64(tcg_rd, tcg_rn, tcg_rm);
-        break;
-    case 2: /* EOR */
-        tcg_gen_xor_i64(tcg_rd, tcg_rn, tcg_rm);
-        break;
-    case 4: /* BIC */
-    case 7: /* BICS */
-        tcg_gen_andc_i64(tcg_rd, tcg_rn, tcg_rm);
-        break;
-    case 5: /* ORN */
-        tcg_gen_orc_i64(tcg_rd, tcg_rn, tcg_rm);
-        break;
-    case 6: /* EON */
-        tcg_gen_eqv_i64(tcg_rd, tcg_rn, tcg_rm);
-        break;
-    default:
-        assert(FALSE);
-        break;
-    }
-
-    if (!sf) {
-        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
-    }
-
-    if (opc == 3) {
-        gen_logic_CC(sf, tcg_rd);
-    }
+    return do_logic_reg(s, a, tcg_gen_or_i64, tcg_gen_orc_i64, false);
 }
 
+TRANS(AND_r, do_logic_reg, a, tcg_gen_and_i64, tcg_gen_andc_i64, false)
+TRANS(ANDS_r, do_logic_reg, a, tcg_gen_and_i64, tcg_gen_andc_i64, true)
+TRANS(EOR_r, do_logic_reg, a, tcg_gen_xor_i64, tcg_gen_eqv_i64, false)
+
 /*
  * Add/subtract (extended register)
  *
@@ -8411,11 +8380,9 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
                 /* Add/sub (shifted register) */
                 disas_add_sub_reg(s, insn);
             }
-        } else {
-            /* Logical (shifted register) */
-            disas_logic_reg(s, insn);
+            return;
         }
-        return;
+        goto do_unallocated;
     }
 
     switch (op2) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 0e04ab6ce4..8e2949d236 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -716,6 +716,15 @@ XPACI           1 10 11010110 00001 010000 11111 rd:5
 XPACD           1 10 11010110 00001 010001 11111 rd:5
 
 # Logical (shifted reg)
+
+&logic_shift    rd rn rm sf sa st n
+@logic_shift    sf:1 .. ..... st:2 n:1 rm:5 sa:6 rn:5 rd:5  &logic_shift
+
+AND_r           . 00 01010 .. . ..... ...... ..... .....    @logic_shift
+ORR_r           . 01 01010 .. . ..... ...... ..... .....    @logic_shift
+EOR_r           . 10 01010 .. . ..... ...... ..... .....    @logic_shift
+ANDS_r          . 11 01010 .. . ..... ...... ..... .....    @logic_shift
+
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
 # Add/subtract (carry)
-- 
2.43.0


