Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9A9C98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9klp-0008Sz-Vm; Thu, 24 Sep 2026 10:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klb-0008Ky-5e
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:46 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klY-0005Eu-84
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:42 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so1457074b3a.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790261379; x=1790866179; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wLANJOhsKzgAIyxNxKclEtyeVwaCU95k4ZeZIB2VDTc=;
 b=PcugtzDfVQRWzuWG3Jp5BRLsvlZHwuDcFqMIljrrMMfBpsaOm8C70GVyZjd2t2FaQq
 itG+5HXOzjFjN7YhLpoudT6ot099nqURW20NiPtZMRT1Li72e+SZwGiBeu0cZYJawfwA
 VVv57TZuQKhOwAKdsad/crr4FNgCmKq1eAWGiL7nY7ZC7PImiS/eVuMlVPlaDTohDFuR
 c2pfRj9B4EuRnDCDdK+gwwU1hm5FA/+EWB1nrhUUVkq94T0ssWYQX6alynzqYmstzSBX
 qetUnEMZopVgOGFiy+vWQpGMBYMTsXcEOkcpiCUNJGAXNVCnyl/EPqi+q1tpc8XhM08A
 JyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261379; x=1790866179;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wLANJOhsKzgAIyxNxKclEtyeVwaCU95k4ZeZIB2VDTc=;
 b=LpluBaf/I+gaP8FFADocKu2bZNUZbCnPZev8nCuZD866a4j1i1Ne9b38pGZeAlQxfu
 SxgzNJI0WpSNlbyNOOuhKpQxIFzpKuEVyRg0SWvPJEY4gOycyRPThLXmqdx/aza/XNW9
 /Dfd8L0O2Ixjt0GEPr4d0ocXulSzl67KsLtFKkEdm58opNvifhYtnvgeBJeBkVg0Sa7S
 HL3EQrrA5GgW2kb/eYG6wB7iq/h0RtX5HVj3DIjnVTEmmpAg+q9JtrIM+balV9H12AWY
 07uGsdpz1RWxQoccnzH/WXRU+ebzFvjapskMcexcsP+qt3iNN4KYEZxYnsHiGzlLTdlP
 +LMw==
X-Gm-Message-State: AFuF++nLQMkeUmPqwsgnR5SJ5QmQPpEQFPy0LY69hh267uxEOhqK9ZQV
 MhsJzOuWzQZ+twcJBz3r8E6EUdIO9Buoa3OqmxX7gBndSHVBt2G0v/3+sbFrJeD0Biv4TZh/K3P
 wJ6Fp
X-Gm-Gg: AYBFou3qv3twgrd1p936GC3+VM1A1v6lx1aH+q5wZ4d2IuGBjm4fEz3xafeqks7awAX
 cerFiMejyeUjMEQcVlg/gsglW2nQ/rkPdcL7a2c7k+v79j4g7EWdezxyi5/cLuSap/Q4zo3w0WU
 YdOJhCLaQ6N4l8dO75F2vK6E1ZEMmxihNZKTExFdCxW1lRkCYS4XdP2mD6bGKADf/Hrx+m6PSm5
 YwgKfaZXqG+qtlRTDNafb8wRk6s6+dulJ5GkU6PJjwU0OMylzL6jUMnX+UKHLj7lHs7Pf0E0F5W
 JTIz2IRL5oD4SiXRUQq1nvrAAGyt8urdiY/fOlCCqIdK1SlKG2KSHCoyj91ooiHCStssvhnPzqn
 R5KL32pvwzXWUcxHDaWbg5POKDckyFbRA10oCA7fZeFO05qlk/TOUQHi/sGnflP3MfEC2r03al9
 Lam9UV2O6D2JcNb9o/lVITi0JX8gw29IRzxylomrG4iJ6PcRLiJ16EJROTQquy5TVFtLoFhcm2d
 uObXXrIaZdNWEJfUTKKy6D3CAa3NQ==
X-Received: by 2002:a05:6a00:2283:b0:86b:43f6:67b7 with SMTP id
 d2e1a72fcca58-87e9898de76mr2216923b3a.4.1790261378580; 
 Thu, 24 Sep 2026 07:49:38 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dad3978sm3209818b3a.34.2026.09.24.07.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:49:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 7/8] target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32CPS
Date: Thu, 24 Sep 2026 07:49:30 -0700
Message-ID: <20260924144931.161335-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924144931.161335-1-richard.henderson@linaro.org>
References: <20260924144931.161335-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


