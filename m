Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02D2E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xa-0007QR-QS; Fri, 13 Dec 2024 12:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X5-0006zY-Hi
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:57 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X2-0001VC-Hk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:54 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so14319465e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111171; x=1734715971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZvncCZGSa1vg6hVRE3miBkbSWKwyhFzzATKLnSY+0DA=;
 b=DJMT0N8OPSkUJ+ehJf7Bntvo38uUvyY6mBKOeB4TSHm0F6ONqv78/n+4UmaCQaVqcG
 WR5uyw3UUTyFpbaEwIZzc+6SfJydEQ+6AQnpYRX+u4uBv4Nb5ov1Cq6Vwe7Kp0CauUV3
 GGdiuv/IyrGuDnRU+5IpYszqdnZPt0MUSpf6Ra6S0pyHBopPSV68K3YfAbvDXv0nWBAb
 No/MyKqgfqsQyh04b3j412i6tjKpc+8EqV2IkRkgZGvt90VKzxubTLsggkGyN3cFngLZ
 IzQimIDNByULEsNiPalKIlXrJzXKvOutWats265Dhvf5KiTH5pMjs7YQnfwWCw5lhLQL
 Cw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111171; x=1734715971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZvncCZGSa1vg6hVRE3miBkbSWKwyhFzzATKLnSY+0DA=;
 b=J3hN5XgYInOAhCYqO9Wqhf1a/tmM65Q3JVlDXze/9zU/Z+SbDdOdAgkTocteoUniWs
 F+gYkZknsxp1d511b+5r+w+6euNNNEStyYvha0n4k7TrZ2JtDXlD0wpBbYaO+7vbrt4Y
 Y12v2QM/3dfB+8X15VzsugyMk2pz0MWMSVai84FTktUsv+PYWZ665Uh6S4H1rXWhHuk6
 RyzXGcdThjeKJAbLxXoId5+ybA7ZTrvZEUrM9kcNQauP7jkHAaJAMIMWToFjHJHWs0nH
 Buyt2ZiVBBfY11Wtky1Dmvg0zBRiUNsbyr7CJPN0crPY/xBx7TaDTx5kYfYbuKWfZJTn
 JquA==
X-Gm-Message-State: AOJu0YyOvwl1a2q2BS5wi+4d6C5U9ZskIbzqouLLWvSrME9Uk/MwMs8O
 AIfUTpdzjae/VQ3tj5qR0gCABStk+SOlDtYTAetp66ApH0NZBNgkFrbzoVNayscbufEJBpfKZns
 s
X-Gm-Gg: ASbGncu5nWvfGS3NvGJ0KUTmfow1if+G6jA7aA+ujNEf/bFEZPuM4yOP9IJvymuEhpZ
 65N7UAv3iYA+pWUIhdMWa1QvJEwzsYaKOPl3qT1WvbRr8L7TG8P7halB1KBXeRy2IjKpegeMAY1
 S5GKqK7CDgIf9vk/+awhDmgQZtNMxbgaohNuei5tCGgtXRgCpkQOPkRNRAtxav4nxRHghG3z/O8
 eAlB25xunQM4l6sAoOp1t8/yumlwx3gBWvHwmEF6me22DOoRiBhf8DMuBpc2w==
X-Google-Smtp-Source: AGHT+IHMxJbx0uRBjM8/iCCPFHBPOPwvAbY+oM+kAyU+4Ha3Q2/wRrLLK+X0Fjny6Tn7RR2e2uUTvA==
X-Received: by 2002:a05:600c:3109:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-4362aa94626mr30094175e9.21.1734111171055; 
 Fri, 13 Dec 2024 09:32:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/85] target/arm: Convert CCMP, CCMN to decodetree
Date: Fri, 13 Dec 2024 17:31:22 +0000
Message-Id: <20241213173229.3308926-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  6 ++--
 target/arm/tcg/translate-a64.c | 66 +++++++++++-----------------------
 2 files changed, 25 insertions(+), 47 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ae2c6831d77..a9d7d571995 100644
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
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 774689641d0..56a445a3c28 100644
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
-- 
2.34.1


