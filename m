Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C42E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Y7-0008NR-8F; Fri, 13 Dec 2024 12:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wx-0006tb-Lr
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:49 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wv-0001Tp-AV
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:47 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so1351483f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111164; x=1734715964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nyg3hHWYvzMVHGHFrG6Pm7O2QdQHuSqbcEqkeJB/Av0=;
 b=ByYRkmzekkw645rN3OWKkNlZ99ilN/VMrVaovliz5S9W73C8jTYRMvCILNWQF1/Fz6
 3HZbzJocK+dkIrE3qVlN8rsxxrG9ExvETG8gterrIzCpNIhcq2Y8hT0PDNs7fyT95x0m
 NtidPSntu4HbFuLKLS95QKwu3jxRyDSLXOJyL07Ze4TnaX3SEmnIEoJf0pzIbrDLsQv7
 dK31D9aq76fqEiR3zaFk7oENVZO1jioR4Liy/OYR0hhnFsinp9d82dToX5Hw6P/YRGAb
 PbiDvBWA5NnZnlITQAFvGhxC7v0xmBzWPHrzIgFDm4Qs+cfSLVncWGdaiuag46RVfPyg
 a92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111164; x=1734715964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nyg3hHWYvzMVHGHFrG6Pm7O2QdQHuSqbcEqkeJB/Av0=;
 b=IGXvrj8XxcK5Iozew3714I5LgQ9MY6Nd2M97h6DrXLzD3iLYwunTopRze5s41FrIVF
 BHPhtqJV3HodhpOKRqxlf3yQtbDKSJOFmQp8bQtno+5CdyNxB1m8BoDTVIpzg/sH5CPJ
 hSI6dpfCJfDo+rK9Pj5RLEFxNT4n+XL6y+WGuRMM2Z3/+OhnbpRpKA15EcWbswF8F6Ux
 ++T203MFsLr7KReLgaQ5t/61FePiQ4eI4se5YPR3bi7MGu7nHHkt9yX/wrrJM9hwDd3d
 IFyzzLDY8Y9pForq3z6kmHgf8PNwc3VL0FVs/F64rarUIXz9Qy80iXFEsC34vwK7RDxr
 OKPw==
X-Gm-Message-State: AOJu0YxDNhECuRkhbF9N1dtGhfc13ujViMQw72qsQV30AJC8wGs1TWl7
 gHhqEENIc7aH6KrhdidunMPOZO7UQjnWK6NBpvKHVzmCmiC1lnZSy1i+D/+jcFkNdrV1MJYbqae
 E
X-Gm-Gg: ASbGncv4I7Mp9fvNMhf0UczGxM9fscEkXo5GzSpo+acehOJQttRgXl3ofMYZIKV56PI
 8AryUkoGncyaU4AUb3TxEVxZGyWAMiVpX0rKp5Fl9kn+DM3+4MtNVouoKUSs5nbEvbcdxpu+9+k
 qnPRq5F5Oa7+98wJVfVnwlrV8qo/UNtqQtPWDAnkxFs0TA3e3Nm6cCuB6MtIzY19FiPd3qr+zMv
 uePXdwnKWcRGMiX2STbLUwYM3vK/5XXrRCJ9Mg/+Yn8puMcSuJOAr5wKv3mfw==
X-Google-Smtp-Source: AGHT+IEUYO9jAEhmLlUd+6k7rj3puk1ihqZgxA3aGQsn4f6nS9KBouqbh5Jd0UnjaEGEA16H8cs/mQ==
X-Received: by 2002:a5d:47c6:0:b0:386:37bb:ddf8 with SMTP id
 ffacd0b85a97d-387887b8642mr6746433f8f.6.1734111163726; 
 Fri, 13 Dec 2024 09:32:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/85] target/arm: Convert disas_logic_reg to decodetree
Date: Fri, 13 Dec 2024 17:31:15 +0000
Message-Id: <20241213173229.3308926-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This includes AND, BIC, ORR, ORN, EOR, EON, ANDS, BICS (shifted reg).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |   9 +++
 target/arm/tcg/translate-a64.c | 117 ++++++++++++---------------------
 2 files changed, 51 insertions(+), 75 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 0e04ab6ce45..8e2949d2361 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d92fe682998..ecc8899dd84 100644
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
-- 
2.34.1


