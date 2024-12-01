Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8031D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWm-0001JI-Nr; Sun, 01 Dec 2024 10:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWk-0001G3-3Q
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:26 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWi-00049X-9z
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:25 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ea47651a10so1256481b6e.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065583; x=1733670383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hn1DooFW9yjO/34NI8hQORVL1+S9bswoCGIJ1fI74z8=;
 b=XnpaBplvrsUmbV5DD0NBe+DESSRtfsjupGYsENMhX6T6pVar1hge85+dJJTGtRgJUh
 Ozs2Y7fBEto/1tNEm92f6N2hcNMJHEvYTzmSg4ht8lymQe1x8xaKYQJJ2X1SF1n1CqqL
 mr/m+Rwsw8aLA/tEkzXHzb4WCB2hJ/fMy3Y77BUXuVb+4kx7MbF64PVtcWUi0nQ1RgLq
 ckVugjeO9kDjga5b0yyRdsoeTiQmPr4MBYumqGx3p+5vMpTI1Ni3YPvXVWx/K0k/xKRX
 0Ks5++iJ/yBtaMGDvXpeyc3I6KR1yrIKRrwvpppzcRZi+5SsZgxy0zFcgT6mEyICx0lQ
 dkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065583; x=1733670383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hn1DooFW9yjO/34NI8hQORVL1+S9bswoCGIJ1fI74z8=;
 b=hLwcCJGxqiBN9OvaH0BA58zdDvSv5X1Tc7aExm65NIw+GSGba3Q4mwQANhp5OtR0Qz
 NZKdGL2+6ExSR5Qk3yio5sOT4vbDjKMa1pAAz85Rzvh4ZY3KIl8xKlzJVNDpW2bCCDPq
 vCKPKTkxsieScgtZDGgYri6L7NhMAogrW9ntXJ9x2vijl0lGyR7jTcGvkK7fTM7ozde7
 +TdIEz4fCURLfXm4dquYVPK31kkOz+3K+zfQ0keQqRrYZra+tyj6PPJhfhWlyw6tfVfg
 4hWMTqRToBToZNH4Vr7cx0lNaahJREjBlTvN/DCPEGDC9IXvHpdiSYhrBLv2tx9bx1k9
 AhVA==
X-Gm-Message-State: AOJu0YzKVNJ7bH+hOkW8/xkuCNQiVF+/tln3GiKjiZAeC7WKn0BQxAzN
 RFXBA/XNrewJqcLDarMtbm2hOm/N7V2pVFBCjq4ZWzcVGrET28rC4AJbs0K/mBgmgRWdpgIipRD
 AlOY=
X-Gm-Gg: ASbGncs471a7jWquyea4neXzgFo+2zIsTwCPKkeosMOxtQs1kweUpzUpgL87HuJpSQW
 pZ9228rPfnIK5rvjAEhdSKJI/CPQtUlZL/6UepQDxNw8n6tE7dRDjvyDDwqn0FZgGgW+5xuKj0x
 dbnBYs1U+WhOSgPC9RQEMNyH/K8Eh7C4jWQHp83bVev05+1GLwVqxCjG87I1OSxcfAGwoCDz3+a
 pVG7yWGe5wFzUFUUSBhBIpP1nsP5MJo/HWisldAsJwE1nbCJrFtB01p4YBGbnJZZgrGRefIjOPy
 inxc2fLmiHFewnH25LHyV4mZv+r9YBwKfcnB
X-Google-Smtp-Source: AGHT+IFrjKICNyuSHDufXXZqbkY5V3vtdEwCKO/+Hy0n26814yrBc2tC8T4ZXwR+10oeRUQPVr4DsA==
X-Received: by 2002:a05:6808:1802:b0:3e6:147:6c5 with SMTP id
 5614622812f47-3ea6dbd471cmr14257552b6e.10.1733065583049; 
 Sun, 01 Dec 2024 07:06:23 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/67] target/arm: Convert disas_logic_reg to decodetree
Date: Sun,  1 Dec 2024 09:05:10 -0600
Message-ID: <20241201150607.12812-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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
index 0e04ab6ce4..53629119b2 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -716,6 +716,15 @@ XPACI           1 10 11010110 00001 010000 11111 rd:5
 XPACD           1 10 11010110 00001 010001 11111 rd:5
 
 # Logical (shifted reg)
+
+&logic_shift    rd rn rm sf sa st n
+@logic_shift    sf:1 .. ..... st:2 n:1 rm:5 sa:6 rn:5 rd:5
+
+AND_r           . 00 01010 .. . ..... ...... ..... .....  @logic_shift
+ORR_r           . 01 01010 .. . ..... ...... ..... .....  @logic_shift
+EOR_r           . 10 01010 .. . ..... ...... ..... .....  @logic_shift
+ANDS_r          . 11 01010 .. . ..... ...... ..... .....  @logic_shift
+
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
 # Add/subtract (carry)
-- 
2.43.0


