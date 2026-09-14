Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB71C88E77
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6FnZ-00037z-R5; Mon, 14 Sep 2026 19:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnU-00036M-IW
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:12 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnT-0007F1-1r
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:12 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fb334e72so25985955ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789427350; x=1790032150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HQIdXS2w1K3qctAQOmJPs0x8dOSjRImkqsuFqsC0g24=;
 b=Bz6YlWio15mda6ta8azi9obV+9ReACPCM5Scp/ldPfaWL/ZGs7aSQXN8CBM4rqnRxi
 STSDGwSJ1RGrFzo6T4uVVOjxbum5dFDBCJimluS6cuURLje7QhOyGcwBl8llOlaHit6w
 T8vv3aNWvcy1rn4U2g4b0h5NHXQ69RlK0KMZtRYGl9ZnATBEDAna7gf4/enP+C+Oh+IJ
 StKT0xSVQ6YPV4ju+EeMe8wAQiiJJX4VrUNFWHdCZHMsk2u3luVe6t4vkvOpC2BRToik
 AhHZvIDiiIVMFXoPqWZzbAc4OPi7akWk/YvHsZWqCbPYZMNEczc8H4c/ii7IEfk97bjU
 ET5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427350; x=1790032150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HQIdXS2w1K3qctAQOmJPs0x8dOSjRImkqsuFqsC0g24=;
 b=qbaG0C9GmLD3xe9+QSgCihZcCpH7pk6vj3uR0CiUyORVQE1YnG9zISuYY8JimICGPw
 mB9E5wp3FG+COwPdlUnFhtcwq6IGxDhN2RSXl1IwnGqPdrmIFepE0Y6aTX94as29Xz8O
 liz+hZxGzs1AfAuBZ78CkKHdj1lTe9RLwjvHq5BMb4gs8Q3bWhmrlcSKCwipsYi2I/dG
 27Xqk3AFbE2EhoMXox3y/G53eGRl5b77Yzp0jc1H3ETyPj34dT/Zjioub1z8xEPoEvLP
 M4Qy67sFtEGZ//dyKsZkl70xF5fyY5kuqts8ITdlu1Up4Ueb/LJL4AX0kMR9dOnNAP1i
 JWag==
X-Gm-Message-State: AFuF++nDyYDy9uqlRMRi2A7tyqcPjODb+Wpb8Bci2yLR6vn07tIpmV6M
 zOd3DZktg5+WGLnNB51ac7iIgtZYFdbczW0TNznKfx3NAb+qfG81uqhVOw1kN+HbK/gw4qETaQR
 TluTDfGE=
X-Gm-Gg: AYBFou2Jpn0AYWLp0/rIidl8kvbmN319Q6+KuOSlhtHxvgPKSrtuh6XaJJF/HjB3jst
 R6j0j/qOMXh5FIVXbRpDSA47eRUltOcPjjeg/kP1VT0ysRmuvTbW1P+dekeLjgDY+RMdkYovKQk
 /1QBFu7ERde+sAjkpPga4T2Nk56tW+Porumic73KW2HIOCmwLHIen7VzurL6aeFtX32o/gmzNUh
 pFGdRsejtM0OR26iI00TH15eiCc4F9eUPEE8XYpUwKlMNgognZDSu1q8wLQXi63zWqNYxUtuKkO
 vWZ6pnSEZBHf+aQvr0qiLlFasWDINPLMMkT84XUGBIsrzIZWmCD9VtY3nf+wRTMI5wwBKVOZ7u+
 wquV1c8Dno+VkLew2kgy4e9O/WUkpxOJ66xCKl76WBRbQVvY/Cl695IJhab16N0v5qVR27j7Ef7
 LK83OVZxfFouBUKFffpuFHay3l1HaIaz4oYNc4ggRf0NEq7eDs0c29a9cPAmfUQnMBwLpcmUUNN
 2AKcdqXrvjDWb4X1Q==
X-Received: by 2002:a17:903:94e:b0:2db:117e:cf50 with SMTP id
 d9443c01a7336-2dd6c5bfe2bmr113793235ad.4.1789427349633; 
 Mon, 14 Sep 2026 16:09:09 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9a3casm28054447eec.12.2026.09.14.16.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:09:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com
Subject: [PATCH 6/6] target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32CPS
Date: Mon, 14 Sep 2026 13:08:58 -1000
Message-ID: <20260914230901.1781309-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230901.1781309-1-richard.henderson@linaro.org>
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Use movcond instead of a pair of branches to perform
the computation, packed in a new gen_cps_i32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 42 +++++++++------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 293eeb46c23..a38f4da12ba 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -2640,39 +2640,19 @@ static void gen_mxu_s32movzn(DisasContext *ctx, TCGCond cond)
  *    Update XRa if XRc < 0 by value of 0 - XRb
  *    else XRa = XRb
  */
+
+static void gen_cps_i32(TCGv_i32 a, TCGv_i32 b, TCGv_i32 c)
+{
+    TCGv_i32 n = tcg_temp_new_i32();
+    TCGv_i32 z = tcg_constant_i32(0);
+
+    tcg_gen_neg_i32(n, b);
+    tcg_gen_movcond_i32(TCG_COND_LT, a, c, z, n, b);
+}
+
 static void gen_mxu_S32CPS(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely(XRb == 0)) {
-        /* XRc make no sense 0 - 0 = 0 -> just set destination to zero */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRc == 0)) {
-        /* condition always false -> just move XRb to XRa */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        TCGv_i32 t0 = tcg_temp_new_i32();
-        TCGLabel *l_not_less = gen_new_label();
-        TCGLabel *l_done = gen_new_label();
-
-        tcg_gen_brcondi_i32(TCG_COND_GE, mxu_gpr[XRc - 1], 0, l_not_less);
-        tcg_gen_neg_i32(t0, mxu_gpr[XRb - 1]);
-        tcg_gen_br(l_done);
-        gen_set_label(l_not_less);
-        gen_load_mxu_gpr(t0, XRb);
-        gen_set_label(l_done);
-        gen_store_mxu_gpr(t0, XRa);
-    }
+    gen_mxu_logic(ctx, gen_cps_i32);
 }
 
 /*
-- 
2.53.0


