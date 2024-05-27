Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C779C25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhki-0007Fv-BQ; Mon, 27 May 2024 17:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkg-0007Fi-S5
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkf-0003fR-5H
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f8e9878514so103484b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844768; x=1717449568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46LsBPS23w0SvLb9dLTSj/Il+XV1H31c1isFbkBvWK0=;
 b=bjlyKaI1rEFFvq7VriaS7RMhcIYvgjbW7g9KI+kQs7FcmK8WYhWS5YUBHpDXwoehAd
 GwaXK4GT3FzCmHdWyNNStb7EHHx3S94FyMdyXn9q4ANvHOMora+nYSgI3nhAl1aRakqp
 tWqFBbwvCHoGBVQvhzjsHCmx9pu/6ltmUh8aGquRe4r1C5TKGSDj7KjFtEOVwYCffX1K
 JNIwME6M4Aw9yo5GAFTNR5bctevwV4TEpu0vP4WhOBY3y+3lpOwVo8SbqRvA+/enWDYf
 CyvLku3+maXovM0A8qOqynZUe2DFQjHLfndyDvsqiYSsbODhfjnAjG7e4IwwdMz1jAMD
 ZI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844768; x=1717449568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=46LsBPS23w0SvLb9dLTSj/Il+XV1H31c1isFbkBvWK0=;
 b=d5Tztln0RRH/d5hj8AtCZTcW6MVmZTz64HWbq2FRw1TFP9qYXnx2swog0NQ5avrhLQ
 Tl9IOvF55ZsOmt3AhJdN8YLQ8f6CSaYm0qG8+CSWhNS4ZE55Xq/3ScyJtS7fn2uJgZDA
 L9YeIsDf+lRhR5bKkIb9+mAeivrO25wEOjNBHIuoKdq71OtQe0B6mlAvHSO2ayjR4xCU
 Po52XN6am5Jlyri03FpLJ67n1tjFJKTuWrVI9ybX10SxCkiOm1Kqk0eAK5wX554GDp/x
 dOElmvlGniONhq8SGost38RG2/bc/P8mPfYbOg3gN0npbbgMXNvv93P4ejVoDSthAjpB
 p9nA==
X-Gm-Message-State: AOJu0Yw/wOgZaMoXI0WEfy5gjkpEL3WItWQ/tgC1/2XDiJBXKk2ew26C
 pGWjHN31CdResICG4/5vf+vNS/JgJCsj4f8Xi+Ks1TPO3TJLJs0vnqezKq/GChyIHjeVpbRvxlV
 6
X-Google-Smtp-Source: AGHT+IGs7dbdUgZRF2WRszGqq/cRMEjhQX2rkMSxC9dNBll2pfpU3f2QXZHpWWafqjqW1m00IixRdQ==
X-Received: by 2002:a05:6a00:e8b:b0:6f8:caf2:ee95 with SMTP id
 d2e1a72fcca58-6f8f308f955mr11832847b3a.9.1716844767910; 
 Mon, 27 May 2024 14:19:27 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 16/18] tcg/loongarch64: Split out vdvjukN in tcg_out_vec_op
Date: Mon, 27 May 2024 14:19:10 -0700
Message-Id: <20240527211912.14060-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes a bug in the immediate shifts, because the exact
encoding depends on the element size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 58 ++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 54f7bc9d14..5d2a6b2ca2 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1901,6 +1901,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn rotrv_vec_insn[4] = {
         OPC_VROTR_B, OPC_VROTR_H, OPC_VROTR_W, OPC_VROTR_D
     };
+    static const LoongArchInsn rotri_vec_insn[4] = {
+        OPC_VROTRI_B, OPC_VROTRI_H, OPC_VROTRI_W, OPC_VROTRI_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -2034,15 +2037,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sarv_vec:
         insn = sarv_vec_insn[vece];
         goto vdvjvk;
-    case INDEX_op_shli_vec:
-        tcg_out32(s, encode_vdvjuk3_insn(shli_vec_insn[vece], a0, a1, a2));
-        break;
-    case INDEX_op_shri_vec:
-        tcg_out32(s, encode_vdvjuk3_insn(shri_vec_insn[vece], a0, a1, a2));
-        break;
-    case INDEX_op_sari_vec:
-        tcg_out32(s, encode_vdvjuk3_insn(sari_vec_insn[vece], a0, a1, a2));
-        break;
     case INDEX_op_rotlv_vec:
         /* rotlv_vec a1, a2 = rotrv_vec a1, -a2 */
         tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], TCG_VEC_TMP0, a2));
@@ -2051,26 +2045,20 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_rotrv_vec:
         insn = rotrv_vec_insn[vece];
         goto vdvjvk;
+    case INDEX_op_shli_vec:
+        insn = shli_vec_insn[vece];
+        goto vdvjukN;
+    case INDEX_op_shri_vec:
+        insn = shri_vec_insn[vece];
+        goto vdvjukN;
+    case INDEX_op_sari_vec:
+        insn = sari_vec_insn[vece];
+        goto vdvjukN;
     case INDEX_op_rotli_vec:
         /* rotli_vec a1, a2 = rotri_vec a1, -a2 */
         a2 = extract32(-a2, 0, 3 + vece);
-        switch (vece) {
-        case MO_8:
-            tcg_out_opc_vrotri_b(s, a0, a1, a2);
-            break;
-        case MO_16:
-            tcg_out_opc_vrotri_h(s, a0, a1, a2);
-            break;
-        case MO_32:
-            tcg_out_opc_vrotri_w(s, a0, a1, a2);
-            break;
-        case MO_64:
-            tcg_out_opc_vrotri_d(s, a0, a1, a2);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        break;
+        insn = rotri_vec_insn[vece];
+        goto vdvjukN;
     case INDEX_op_bitsel_vec:
         /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
         tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
@@ -2083,6 +2071,24 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     vdvjvk:
         tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
         break;
+    vdvjukN:
+        switch (vece) {
+        case MO_8:
+            tcg_out32(s, encode_vdvjuk3_insn(insn, a0, a1, a2));
+            break;
+        case MO_16:
+            tcg_out32(s, encode_vdvjuk4_insn(insn, a0, a1, a2));
+            break;
+        case MO_32:
+            tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, a2));
+            break;
+        case MO_64:
+            tcg_out32(s, encode_vdvjuk6_insn(insn, a0, a1, a2));
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
     }
 }
 
-- 
2.34.1


