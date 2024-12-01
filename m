Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBE3D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWx-0001RO-Tb; Sun, 01 Dec 2024 10:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWr-0001N0-HZ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:33 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWp-0004CE-HA
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:33 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5f1e560d973so1728814eaf.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065590; x=1733670390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSeN8uV754VeQZXFsQOC17BF2SkJdmbFae/IrzP2P+g=;
 b=s14hPMbnBiLRtKasd6mjyAAYJ++bKXlWdjkJtFjOlq7EKpIAuHqvpiCd/cCtRHfzsY
 fUCd5j76Hi71/vB9rS8zoqVfi8YiBPjMNLP4Cvyf2HzmzFwIAsNsSZUkbTBep2k6+p6d
 Wtkz4vfJTHsskHOO7fM+V3kJ5p+xxftW9qG8eDDJuaap914o6l0V2JQa4SalMqyIAWTC
 AeBEHScE5YPKOyph1uxmYrtFQZDmY1b3+coCRjc5VMTcj/jJ13GNOrvzxp3RIxghOQJX
 hlB1HO2swRagZQvApL8zRjYGiyARoWcoiLiYxGpAdFvSoclozSjsE+ROI6ioDlPoCIhL
 3QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065590; x=1733670390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSeN8uV754VeQZXFsQOC17BF2SkJdmbFae/IrzP2P+g=;
 b=pxn5glV3wL677c+gBQI5aA5mt86k7lmv9PYYOsdxYCSupFWOWZRaSum9ltSpB9Usv5
 /T2idpis671ePhMSIhWxcpNWhSjiOOLUICMFcBYeqqIw3Ak0vtpxK8OtHlJOEq2z2X1X
 plUm9Jhd4YlyFWlibFynJ1q0bmP/t7n3AfLjAZDDHCQJnQtCiWSt9GlJE7BxVdlh8L+p
 SuqHlSWmStHI9RCN0GokN+o7+bhXLZIV+9zyWyLqOW14FXHiuVhUpT77tXZupz7s83lk
 M2+kVuuHbZR9C0OTi98IR8V/h2CKvDc6BAGE+9GOsEdKFehF01XbkBDXeQACA/YiWIB8
 bdYQ==
X-Gm-Message-State: AOJu0Yy0ZwlhZ3pVYVKKKtrcFOAfmofWj5jTfH1WVtqdt0VaLm00XYhT
 w8rfUINTyQkn+sHrtqeOQEDTIwN/GJ0DkNp2Qvjrpwmzrr+Wua7br9KyLof4Xw4qhbAKwuQgYzt
 1H4s=
X-Gm-Gg: ASbGnctpHa0/ZjYjaomX3RGMWmIsLZTDZq8JNo78y4Fh20UacK/NNtReX9Uv1vEahwh
 tUDVM1O77zSumdZhKMP7ERKXtnyJkc/Oa9sjWALOKDKk8i3oA3xX/6UCQiJ5uOd0y1c9NmwdCMO
 Ywa3HAklZZJjws1t+TdGni90C4uJF0xJvas0GUXRKZtYw9Ss/2NOHp+I4DjzjKVSpCsLN4pi2H+
 CmLmGxFlgJ6pHrOtcp2bBMxqZpg+DIsR9iYBbl7VikFx0zAv6tbfOn6W+6XAifbN6WJTtPNdH7A
 Td8NksRPj+nnuBhc0IzXCTOdE2FcL+qxKZDB
X-Google-Smtp-Source: AGHT+IGvFF46ZzfcURwY1aNLMp6/hPpLsVmiUD0sGwArrRcK+FEFAL3ZtFUB/mbw4EeCCUrfQdEAEg==
X-Received: by 2002:a05:6820:20c:b0:5f1:ed20:b7b2 with SMTP id
 006d021491bc7-5f217a1ad3fmr8661770eaf.4.1733065590212; 
 Sun, 01 Dec 2024 07:06:30 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 18/67] target/arm: Convert CCMP, CCMN to decodetree
Date: Sun,  1 Dec 2024 09:05:17 -0600
Message-ID: <20241201150607.12812-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 66 +++++++++++-----------------------
 target/arm/tcg/a64.decode      |  6 ++--
 2 files changed, 25 insertions(+), 47 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 774689641d..56a445a3c2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8092,68 +8092,46 @@ static bool do_setf(DisasContext *s, int rn, int shift)
 TRANS_FEAT(SETF8, aa64_condm_4, do_setf, a->rn, 24)
 TRANS_FEAT(SETF16, aa64_condm_4, do_setf, a->rn, 16)
 
-/* Conditional compare (immediate / register)
- *  31 30 29 28 27 26 25 24 23 22 21  20    16 15  12  11  10  9   5  4 3   0
- * +--+--+--+------------------------+--------+------+----+--+------+--+-----+
- * |sf|op| S| 1  1  0  1  0  0  1  0 |imm5/rm | cond |i/r |o2|  Rn  |o3|nzcv |
- * +--+--+--+------------------------+--------+------+----+--+------+--+-----+
- *        [1]                             y                [0]       [0]
- */
-static void disas_cc(DisasContext *s, uint32_t insn)
+/* CCMP, CCMN */
+static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
 {
-    unsigned int sf, op, y, cond, rn, nzcv, is_imm;
-    TCGv_i32 tcg_t0, tcg_t1, tcg_t2;
-    TCGv_i64 tcg_tmp, tcg_y, tcg_rn;
+    TCGv_i32 tcg_t0 = tcg_temp_new_i32();
+    TCGv_i32 tcg_t1 = tcg_temp_new_i32();
+    TCGv_i32 tcg_t2 = tcg_temp_new_i32();
+    TCGv_i64 tcg_tmp = tcg_temp_new_i64();
+    TCGv_i64 tcg_rn, tcg_y;
     DisasCompare c;
-
-    if (!extract32(insn, 29, 1)) {
-        unallocated_encoding(s);
-        return;
-    }
-    if (insn & (1 << 10 | 1 << 4)) {
-        unallocated_encoding(s);
-        return;
-    }
-    sf = extract32(insn, 31, 1);
-    op = extract32(insn, 30, 1);
-    is_imm = extract32(insn, 11, 1);
-    y = extract32(insn, 16, 5); /* y = rm (reg) or imm5 (imm) */
-    cond = extract32(insn, 12, 4);
-    rn = extract32(insn, 5, 5);
-    nzcv = extract32(insn, 0, 4);
+    unsigned nzcv;
 
     /* Set T0 = !COND.  */
-    tcg_t0 = tcg_temp_new_i32();
-    arm_test_cc(&c, cond);
+    arm_test_cc(&c, a->cond);
     tcg_gen_setcondi_i32(tcg_invert_cond(c.cond), tcg_t0, c.value, 0);
 
     /* Load the arguments for the new comparison.  */
-    if (is_imm) {
-        tcg_y = tcg_temp_new_i64();
-        tcg_gen_movi_i64(tcg_y, y);
+    if (a->imm) {
+        tcg_y = tcg_constant_i64(a->y);
     } else {
-        tcg_y = cpu_reg(s, y);
+        tcg_y = cpu_reg(s, a->y);
     }
-    tcg_rn = cpu_reg(s, rn);
+    tcg_rn = cpu_reg(s, a->rn);
 
     /* Set the flags for the new comparison.  */
-    tcg_tmp = tcg_temp_new_i64();
-    if (op) {
-        gen_sub_CC(sf, tcg_tmp, tcg_rn, tcg_y);
+    if (a->op) {
+        gen_sub_CC(a->sf, tcg_tmp, tcg_rn, tcg_y);
     } else {
-        gen_add_CC(sf, tcg_tmp, tcg_rn, tcg_y);
+        gen_add_CC(a->sf, tcg_tmp, tcg_rn, tcg_y);
     }
 
-    /* If COND was false, force the flags to #nzcv.  Compute two masks
+    /*
+     * If COND was false, force the flags to #nzcv.  Compute two masks
      * to help with this: T1 = (COND ? 0 : -1), T2 = (COND ? -1 : 0).
      * For tcg hosts that support ANDC, we can make do with just T1.
      * In either case, allow the tcg optimizer to delete any unused mask.
      */
-    tcg_t1 = tcg_temp_new_i32();
-    tcg_t2 = tcg_temp_new_i32();
     tcg_gen_neg_i32(tcg_t1, tcg_t0);
     tcg_gen_subi_i32(tcg_t2, tcg_t0, 1);
 
+    nzcv = a->nzcv;
     if (nzcv & 8) { /* N */
         tcg_gen_or_i32(cpu_NF, cpu_NF, tcg_t1);
     } else {
@@ -8190,6 +8168,7 @@ static void disas_cc(DisasContext *s, uint32_t insn)
             tcg_gen_and_i32(cpu_VF, cpu_VF, tcg_t2);
         }
     }
+    return true;
 }
 
 /* Conditional select
@@ -8266,10 +8245,6 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     }
 
     switch (op2) {
-    case 0x2: /* Conditional compare */
-        disas_cc(s, insn); /* both imm and reg forms */
-        break;
-
     case 0x4: /* Conditional select */
         disas_cond_select(s, insn);
         break;
@@ -8277,6 +8252,7 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     default:
     do_unallocated:
     case 0x0:
+    case 0x2: /* Conditional compare */
     case 0x6: /* Data-processing */
     case 0x8 ... 0xf: /* (3 source) */
         unallocated_encoding(s);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1228c41679..b339adee6f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -761,8 +761,10 @@ RMIF            1 01 11010000 imm:6 00001 rn:5 0 mask:4
 SETF8           0 01 11010000 00000 000010 rn:5 01101
 SETF16          0 01 11010000 00000 010010 rn:5 01101
 
-# Conditional compare (regster)
-# Conditional compare (immediate)
+# Conditional compare
+
+CCMP            sf:1 op:1 1 11010010 y:5 cond:4 imm:1 0 rn:5 0 nzcv:4
+
 # Conditional select
 # Data Processing (3-source)
 
-- 
2.43.0


