Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188F6D4A5FA
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgacn-0003L7-Dx; Thu, 15 Jan 2026 22:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacm-0003KO-B0
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:48 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgack-0006SH-Pe
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:48 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81e93c5961cso1305831b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534545; x=1769139345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUs/qizOln6k9oFq1nxTBHzlXvp7JuDaMx2406hQaG0=;
 b=FyWR5ZOr+7TnN5kojPdFKaSpc1ukKRns72mlhgutjuepZEQRB535P93k/DJIwtvcw3
 SIeK8SBfcJkfpKURqaZpq/vnX/H5WmCNDzEnAG52oFURZq8J8J+XZFmN8by7dVd7+vbx
 0d7T5C+S3vOsoPltJezJ34YlcuL93AdrtsijzzOYuCUXtZjq1JEXz5GdLtnJuwTETZ4+
 vFkGJhkLqaaEHH1tWYHLWKicK2appiLO+EKR04qDKT34s7SREQYRx7UMeNEz7QlmnyR3
 Nvo2kEywoGw9qBaSnZIf7HK8j89lRzRDt8tN94YkU0s0ZWCafJ61a/zJmpHWPDgdCyKe
 nzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534545; x=1769139345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pUs/qizOln6k9oFq1nxTBHzlXvp7JuDaMx2406hQaG0=;
 b=R/dKOQ1wSBUWcWrQVG9nu/Z1VhmypELYrw2gsel9djP9bl0HcqaNc5EMUV1jKbvASC
 KqubwHaY6H7bAfG3N8wTnkb1unpjUQ7M/QE9qKzMzCAz5RHJ3On99ZkbshGJbnQ0Kixe
 jwtQ5iBwz1drQJoqaYRER3p3tOVGDuLgKMz+1Q5pjAbvrwlaz/gRkIrdhu5Tm3NunVFN
 E/9SnlIrmkiTWnGxV3JYr5jKuJxgfQ9t7QTWSsSEuLveFBG+sowS0siRDfqpxdYrMGHo
 0KaXMm0hOiYAFWIk5gvgW9ONwUD/07Rw2e4pHfeIIspor19dJa2So5n+0JWW7Vn/85Ct
 omdw==
X-Gm-Message-State: AOJu0YzOeNCTU80GUiVWCzOSIuzN8SuJOJqFWOKVW1CZwsnlLirUmlk7
 zdrOEG9+X1Hf0VcHAOAjwgQc+d77CeWZQESJ4e3DEG3rdcLML/SHw4XbiivZi5qmxfVD6nJiEKw
 HzmRCD778IA==
X-Gm-Gg: AY/fxX6q36Yb7G6W3ve2jhPCVqqQc6nxOmiLU+ZCHmEdt3+9/WtHUtYlNNIWaU+JNW7
 9YgnxNIWGpFRk3wSDigx6vF7Gakub0J9mjQRq3yf5lknRLSorqYYwh/HfhLl8Q1D6kcurNyVZgi
 k9GtvnozKnZKQzZKbFtp/1cRtCQdxM/Z0joMrH61pC+sYAG3/YeE4BO8MANpQSyc0Rz23Xsd3wo
 xsj8v+F7TDsfusEPa/xNt702hzgTMTKoMZ4laS+M1SR0052x+mAqCiUpEaKWQ491c1g0JihNsHZ
 khlK4upt/ziHxhLsIvGQQazRYXEPo/DPPbHLz0nJqDrKqs39ESDHyLn6P8ektWjHNhxBxBHbSC5
 P3YG+rO7Te7jetPCsrPhnSCmOdOVyPqy/cBcEMz2lYYbQRiFR4vN7yYYc9m/7msEcocn+FwLuG1
 wk9/ZOe58d5qcXxq+NYA==
X-Received: by 2002:a05:6a00:1d0f:b0:7e8:450c:61a4 with SMTP id
 d2e1a72fcca58-81fa02fd38cmr1574137b3a.59.1768534545260; 
 Thu, 15 Jan 2026 19:35:45 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 39/58] target/i386/tcg: Drop TCG_TARGET_REG_BITS test
Date: Fri, 16 Jan 2026 14:32:45 +1100
Message-ID: <20260116033305.51162-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 41bf047b8d..639a1eb638 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2094,34 +2094,15 @@ static void gen_IMUL3(DisasContext *s, X86DecodedInsn *decode)
 
     case MO_32:
 #ifdef TARGET_X86_64
-        if (TCG_TARGET_REG_BITS == 64) {
-            /*
-             * This produces fewer TCG ops, and better code if flags are needed,
-             * but it requires a 64-bit multiply even if they are not.  Use it
-             * only if the target has 64-bits registers.
-             *
-             * s->T0 is already sign-extended.
-             */
-            tcg_gen_ext32s_tl(s->T1, s->T1);
-            tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-            /* Compare the full result to the extension of the truncated result.  */
-            tcg_gen_ext32s_tl(s->T1, s->T0);
-            cc_src_rhs = s->T0;
-        } else {
-            /* Variant that only needs a 32-bit widening multiply.  */
-            TCGv_i32 hi = tcg_temp_new_i32();
-            TCGv_i32 lo = tcg_temp_new_i32();
-            tcg_gen_trunc_tl_i32(lo, s->T0);
-            tcg_gen_trunc_tl_i32(hi, s->T1);
-            tcg_gen_muls2_i32(lo, hi, lo, hi);
-            tcg_gen_extu_i32_tl(s->T0, lo);
-
-            cc_src_rhs = tcg_temp_new();
-            tcg_gen_extu_i32_tl(cc_src_rhs, hi);
-            /* Compare the high part to the sign bit of the truncated result */
-            tcg_gen_sari_i32(lo, lo, 31);
-            tcg_gen_extu_i32_tl(s->T1, lo);
-        }
+        /*
+         * This produces fewer TCG ops, and better code if flags are needed.
+         * s->T0 is already sign-extended.
+         */
+        tcg_gen_ext32s_tl(s->T1, s->T1);
+        tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+        /* Compare the full result to the extension of the truncated result.  */
+        tcg_gen_ext32s_tl(s->T1, s->T0);
+        cc_src_rhs = s->T0;
         break;
 
     case MO_64:
-- 
2.43.0


