Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C309BE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xk-0007p4-OL; Fri, 13 Dec 2024 12:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XS-0007Dj-Qm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:21 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XQ-0001bw-Cx
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so1128323f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111194; x=1734715994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fDdtnlLPu66cn6d1r0KkSZdgC2ryDDOvIhyzfjEy2GE=;
 b=LFJzy0c1z3G7PH08aRUaCT2iREeWDngV6hI8jdRM3IbG9EaWZ3dVlIQ3BW6Amk2a8Q
 BVlAbS0qzk8jTPQn+awj7YCNcJqyWznysDlyCrB99ys1JXz2CwonNGx6QNJRVJe/mIRo
 6rpXF9m5FChXreunvx35hTgQ01ZD0/5FUCz87yU1k4lrRPeyVSSkPNRYC0SmTM1xhx6r
 kVdz8+0WFQtQSh1vfwrYLmq9Rc/CTFbuqHmggBELCAjuxeH4eKQbtMlwlO6FTi6tLu7I
 pW5qul1XZZ9MOihi4GPBt0fOLIsO9EOEHxgfKRPrycPtGuxYwFyEJHCrYisKDkIgOnvI
 kO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111194; x=1734715994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDdtnlLPu66cn6d1r0KkSZdgC2ryDDOvIhyzfjEy2GE=;
 b=s7TFxWb9f9oNLMefpSlaJiX7MA+jq5oS5668Y3tihRKmrVhdO+Jaqwri4LcOSUSBjf
 NekLxBfehMBp88l3qaFrHOXz6FslNw3QgouSOjav6UyCsQoYuQeOQ7hb5nnhObay7C0E
 NaOXrB1GpAiTPbr3e6buDM4ZHP5i9yrwORkp+4tomkGW4DQpt32f9vjxdbm2THRFbGBK
 FqO1j8/pyW8DpCz9XHz1nF1hVezmFHHexSjRVxIFjc//1P6TSuJ3GFGIL6aDt8iXwq0/
 rNTzwV2r6uKouy287SB1ZddJ138EQmoAzm5JsB7hABHAYc8WwchZvFfpGtCkfZZQEbzw
 tpYA==
X-Gm-Message-State: AOJu0YwjQQbeUJ7kkL9VrIbd786cXwIzQd6331tJSCNhGEH8pzgkYVvu
 V1y0sTpmKymQlK1LfgRwt1h7tl1PErvCiz/Cu1mgkc36ePHmJOs+envupi5t55RiSWQdpLuQ515
 l
X-Gm-Gg: ASbGncsR8z9bI8ObbJs0re2Z0GtRrbUDCjBv+XtLXPOhbssk6LZL78xCQNlH3JOtWwF
 KAZLfCJabrq3ITutKWHuyVGGuntk4iEYsqranRfT0gONdsGHTa+pFjinksb1JQRMcxiMi0982Vm
 uZnwFrhrsDtkMv8NVseIekqTyRIIaUS2r504ZZEuQ4P2OP4NvrZG7U6EzRJxTTkzyJZLOGBXj5M
 Q34sAAyONQxZMgNnVLxP/Qo7x4lI4IzfcvZ0LDcK5/mP53rAKopX9bkDrdXpQ==
X-Google-Smtp-Source: AGHT+IHo/kfNw10iiAIQxO9zk27gRZVuYaVTh1aCOQtThFIZt9t5duBIkMn3EyHAZomC2WO7dk6GsQ==
X-Received: by 2002:a05:6000:2ad:b0:385:ee59:44eb with SMTP id
 ffacd0b85a97d-3888e0bd28amr3270071f8f.33.1734111194640; 
 Fri, 13 Dec 2024 09:33:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/85] target/arm: Convert CNT, NOT, RBIT (vector) to decodetree
Date: Fri, 13 Dec 2024 17:31:44 +0000
Message-Id: <20241213173229.3308926-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
Message-id: 20241211163036.2297116-41-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 34 ++++++----------------------------
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 32355ee6331..bac81eec7e6 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -71,6 +71,7 @@
 @rrr_q1e3       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=3
 @rrrr_q1e3      ........ ... rm:5 . ra:5 rn:5 rd:5      &qrrrr_e q=1 esz=3
 
+@qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
 @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
@@ -1643,3 +1644,6 @@ ABS_v           0.00 1110 ..1 00000 10111 0 ..... .....     @qrr_e
 NEG_v           0.10 1110 ..1 00000 10111 0 ..... .....     @qrr_e
 CLS_v           0.00 1110 ..1 00000 01001 0 ..... .....     @qrr_e
 CLZ_v           0.10 1110 ..1 00000 01001 0 ..... .....     @qrr_e
+CNT_v           0.00 1110 001 00000 01011 0 ..... .....     @qrr_b
+NOT_v           0.10 1110 001 00000 01011 0 ..... .....     @qrr_b
+RBIT_v          0.10 1110 011 00000 01011 0 ..... .....     @qrr_b
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3e0c061b3c0..aff1984a224 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8915,6 +8915,9 @@ static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 
 TRANS(ABS_v, do_gvec_fn2, a, tcg_gen_gvec_abs)
 TRANS(NEG_v, do_gvec_fn2, a, tcg_gen_gvec_neg)
+TRANS(NOT_v, do_gvec_fn2, a, tcg_gen_gvec_not)
+TRANS(CNT_v, do_gvec_fn2, a, gen_gvec_cnt)
+TRANS(RBIT_v, do_gvec_fn2, a, gen_gvec_rbit)
 
 static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
@@ -9229,12 +9232,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     TCGCond cond;
 
     switch (opcode) {
-    case 0x5: /* NOT */
-        /* This opcode is shared with CNT and RBIT but we have earlier
-         * enforced that size == 3 if and only if this is the NOT insn.
-         */
-        tcg_gen_not_i64(tcg_rd, tcg_rn);
-        break;
     case 0xa: /* CMLT */
         cond = TCG_COND_LT;
     do_cmop:
@@ -9291,6 +9288,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         break;
     default:
     case 0x4: /* CLS, CLZ */
+    case 0x5: /* NOT */
     case 0x7: /* SQABS, SQNEG */
     case 0xb: /* ABS, NEG */
         g_assert_not_reached();
@@ -10072,19 +10070,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0x1: /* REV16 */
         handle_rev(s, opcode, u, is_q, size, rn, rd);
         return;
-    case 0x5: /* CNT, NOT, RBIT */
-        if (u && size == 0) {
-            /* NOT */
-            break;
-        } else if (u && size == 1) {
-            /* RBIT */
-            break;
-        } else if (!u && size == 0) {
-            /* CNT */
-            break;
-        }
-        unallocated_encoding(s);
-        return;
     case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
     case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         if (size == 3) {
@@ -10302,6 +10287,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     default:
     case 0x3: /* SUQADD, USQADD */
     case 0x4: /* CLS, CLZ */
+    case 0x5: /* CNT, NOT, RBIT */
     case 0x7: /* SQABS, SQNEG */
     case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
@@ -10324,15 +10310,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x5: /* CNT, NOT, RBIT */
-        if (!u) {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cnt, 0);
-        } else if (size) {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_rbit, 0);
-        } else {
-            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_not, 0);
-        }
-        return;
     case 0x8: /* CMGT, CMGE */
         if (u) {
             gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cge0, size);
@@ -10351,6 +10328,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clt0, size);
         return;
     case 0x4: /* CLZ, CLS */
+    case 0x5: /* CNT, NOT, RBIT */
     case 0xb:
         g_assert_not_reached();
     }
-- 
2.34.1


