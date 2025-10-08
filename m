Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBFBCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cCt-0000eA-Kt; Wed, 08 Oct 2025 18:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCd-0000As-9P
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCL-0007Mj-3j
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:06 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7841da939deso283486b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960785; x=1760565585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fNvE/0VLywPk9VR9GyOGl84ab7Le9+vvxZH9uub5Ig=;
 b=hb/6UFz2jw2ikyXm/FJvWFED2a0lIy2yfOonidJSorJbc94tkP0kZpE4a1ETVvJWKu
 NjcaShQwAak4Ye0yPO1W0Rk8Flc13ohkr/Rq3r8D+gJSU1R5TKoIV6oBMTRqv3FjZxsn
 1Qa8XyH484GqxdFZR4CLPrfU7B8QzUSTGo/X11X0PXROnkuekXs+k7BNsNLfUFoQ4rzc
 l16jy6X+t+CAzyf7+UcjBHJQayueY5NnEwgfxY1MEXx4NvMZ+8IfQ/B8Vj5nRr7/IrRp
 pZsNYDldXPb32IP0JvmwMNjNIOUhajmC67ILzUSSXTsJZi64qqzTYU1MrALI63paPmJI
 kPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960785; x=1760565585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fNvE/0VLywPk9VR9GyOGl84ab7Le9+vvxZH9uub5Ig=;
 b=mJN8ixM3bUY0cg4O1ntrbnrk+zBnolj5B1MsqOmzECb2Qi3FvA0THQ+iDVFpsqxqyC
 WldjZm3jQhCmazBTrKttNmF1eIp/lTmT2se3V5aMQLQFBs07ya2tW50qSoRKtLM5eCcD
 HLOGRmFTLYEA7tXMSQFho2BA7rrXwTEj4dLbYwQqCvGR1T6hPGINdXye5fUf48IennAM
 vzXCHsVnY81ysQ6MKmyAvrjqrnovRzxqV0avK1wDJdsbydUyO4+IrqhE0S4p5umIqLJL
 iV2SrStIdyoAn9CXH+pUdRPwjWT7511uxyMm6z5DihrtRyNKQDZkHPLVG3c5+5rx5WGM
 Gg3g==
X-Gm-Message-State: AOJu0YwcZkI3kl+sM7yEsuSsLX0xmVcN/2ZHTcdNnraZPrZDDi071QoN
 OLU56IJdvcMrc/7AEEz7sdPWJAqN+YNkeqN7StZzIqDR00sWRaPhX9RqyOuUGI07OkCxlZDWaQb
 ojUN9E1k=
X-Gm-Gg: ASbGncvreHmN42GbL+eFZDpIaoyInDjgVEzsXftoYT95bbmu9L3jXQwru+ah6//C9pp
 N19HCxbTKqWhoy3ExDH/bg1DKhM/gpMTWsxXGvOLuUJo8EuPSyvQwaJm+9/6nFZk7c9S6RoAJrq
 6RsAee8z5QWeiG10sJYcvOqo4xP+YCwm2PJI8cjaqQZBVyPm7GcRen+igiGh7FFndCBVa4Enl4v
 kFgj42tf3hWVf+f2QuvJ4HJCrp1Iu/OcymZFsNv40u4DEs9LRyKnS3PvKt37oRw8H3JKphpKqck
 lf8j740zKdZKeaTmM4Cj3yOXy+se/xxKs6dfIxJBxDHfa+frZ1niILQNDWf96ASL0iNBrYIWgJk
 iQabhrQ0zJ7u/RQVItx9cFbaxIE7EywuHND3OfWjYSEtgqiq9aDARpiYJ
X-Google-Smtp-Source: AGHT+IF+v0fIFZHoT01sMNEq9j/CbwJRarmWIuO4Qtl6eAEqFjURgigeWA/7PrZR7dyVVCbi2InbjA==
X-Received: by 2002:a05:6a00:1706:b0:77f:50df:df31 with SMTP id
 d2e1a72fcca58-793870523b6mr4711671b3a.20.1759960784761; 
 Wed, 08 Oct 2025 14:59:44 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 46/73] target/arm: Implement GCSSTR, GCSSTTR
Date: Wed,  8 Oct 2025 14:55:46 -0700
Message-ID: <20251008215613.300150-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Note that CreateAccDescGCS() does not enable tagchecked,
and Data Aborts from GCS instructions do not set iss.isv.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c037119cdf..b72aa968cd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -139,6 +139,12 @@ static int core_a64_user_mem_index(DisasContext *s, bool unpriv)
     return arm_to_core_mmu_idx(full_a64_user_mem_index(s, unpriv));
 }
 
+/* For a given translation regime, return the core mmu_idx for gcs access. */
+static int core_gcs_mem_index(ARMMMUIdx armidx)
+{
+    return arm_to_core_mmu_idx(regime_to_gcs(armidx));
+}
+
 static void set_btype_raw(int val)
 {
     tcg_gen_st_i32(tcg_constant_i32(val), tcg_env,
@@ -3989,6 +3995,42 @@ static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
     return true;
 }
 
+static bool trans_GCSSTR(DisasContext *s, arg_GCSSTR *a)
+{
+    ARMMMUIdx armidx;
+
+    if (!dc_isar_feature(aa64_gcs, s)) {
+        return false;
+    }
+
+    /*
+     * The pseudocode for GCSSTTR is
+     *
+     *   effective_el = AArch64.IsUnprivAccessPriv() ? PSTATE.EL : EL0;
+     *   if (effective_el == PSTATE.EL) CheckGCSSTREnabled();
+     *
+     * We have cached the result of IsUnprivAccessPriv in DisasContext,
+     * but since we need the result of full_a64_user_mem_index anyway,
+     * use the mmu_idx test as a proxy for the effective_el test.
+     */
+    armidx = full_a64_user_mem_index(s, a->unpriv);
+    if (armidx == s->mmu_idx && s->gcsstr_el != 0) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF,
+                              syn_gcs_gcsstr(a->rn, a->rt),
+                              s->gcsstr_el);
+        return true;
+    }
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    tcg_gen_qemu_st_i64(cpu_reg(s, a->rt),
+                        clean_data_tbi(s, cpu_reg_sp(s, a->rn)),
+                        core_gcs_mem_index(armidx),
+                        finalize_memop(s, MO_64 | MO_ALIGN));
+    return true;
+}
+
 static bool trans_LD_mult(DisasContext *s, arg_ldst_mult *a)
 {
     TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8283a9c83d..2ae73f443a 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -571,6 +571,9 @@ LDAPR_i         10 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext
 LDAPR_i         00 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=0
 LDAPR_i         01 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=1
 
+# GCSSTR, GCSSTTR
+GCSSTR          11011001 000 11111 000 unpriv:1 11 rn:5 rt:5
+
 # Load/store multiple structures
 # The 4-bit opcode in [15:12] encodes repeat count and structure elements
 &ldst_mult      rm rn rt sz q p rpt selem
-- 
2.43.0


