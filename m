Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B240E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL32i-0000M6-QF; Tue, 10 Dec 2024 11:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32O-0007tj-KH
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:41 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32I-0007WI-4j
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:40 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-300479ca5c6so29294331fa.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847860; x=1734452660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TrtbMxhB7QypfthbdI/dreoH2lLNkOWwe1R5ZbE+fj8=;
 b=pEKSaCtaL97guwQWI9C9KYADOxffjoilOwDs4998ytAFVVtkrDOjJ74K62TWqETuZE
 1dCOyO6Z2VzHIh2tDWK4LK36tdk3OIq8YWyl10rF3X1cWdY1dWMn+KNoZGb8OQ97z3NW
 UN56QWziXuHxQ74sez3n+xsLnKZ1I8lh9peFkeuMo03U3f8gnTi4aqWoZ57ii0MvDGkt
 9zV2zqPjOgoRt15uMXMVTuW1/qJz8c9WatH03gZRztBy5tcrh84S++chHXwRGAKFPBXt
 wh3Qz3fvoDfVgAOA4lqHSII20kLc7vE0lZz32bLYBqn3vbcV5v5jV044qz3y3L/tvg4L
 dV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847860; x=1734452660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TrtbMxhB7QypfthbdI/dreoH2lLNkOWwe1R5ZbE+fj8=;
 b=GLaBfiTRh1S4Q4rr4ktbP6UPwrQ3Tpg679LVrDGapp8VJDoc51Oi3wvsKq2yR+q6+Q
 877DFFDNDLMovhlabbikYeYADVtxaQz829PTehWKu5XjJDW/uzjAiXt5JKqvoq74e6Fq
 BTJNbSLDDiquzH3Vb9YIh78ssO12+uuRtk6tPk9OxtdoNqoz8uzr22Er4GUHYHIWGP7M
 //b0Vo60XG95hDijWluvjrc8abq7Vd5g0WgmllDO2er2aBsyU3QXltz6X9MUsi9i2yR7
 oT8J18xckTL3NNyuSQ377gZtjtNl7ZuMLcpvfItajv5SdHh9DMGB1rYs7oI6pBzuCIH/
 ulig==
X-Gm-Message-State: AOJu0YyoiFFBQGg34kQq3KhpMvZYjCgRn2bao48KCAePGjAJaqXCdOQz
 uVYGcR9J2WsTjNSeLZgnIajFWN9VKwnXqQUaeIhzmyhqKLFMwCpDa0tw7ZinFqpghOYdE2oMQ+8
 q0hFVTyIH
X-Gm-Gg: ASbGncuUwpp4S4zhtGpWFI2++5BlHpP9GcyejN19oCh+gBcXXmm+vCPPICXdvV0US6M
 /rqQOZJlk2wvpIR+Bs7frnyI+P/rDQgLo9nOKKWMTbUaSY5dqzwcOBgiIk+4tg1hzlbgT1Z7Xlm
 gsN/MdY82bz1//zSnWjbj00y755kyg6g2Bgo7YMcO8/Z9RUJduJpNqD8R6GkXnx5HNxRLbySmCy
 EXtaqdNPtSsV4GtVxkDVzAknf4jPvUM9IYmTJf70Bf8xCy56F0lDyVykFE=
X-Google-Smtp-Source: AGHT+IEs//k5uJuw+gTkPF+rmO3mN/SqH57Ed2FwEJp40eO/yGBnIjx3sAqj9j7aQUTro2ZTEAVL0g==
X-Received: by 2002:a05:6512:6cc:b0:53f:22f8:74f with SMTP id
 2adb3069b0e04-54024107643mr2084979e87.44.1733847859655; 
 Tue, 10 Dec 2024 08:24:19 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 53/69] target/arm: Implement gen_gvec_fabs, gen_gvec_fneg
Date: Tue, 10 Dec 2024 10:17:17 -0600
Message-ID: <20241210161733.1830573-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22e.google.com
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

Move the current implementation out of translate-neon.c,
and extend to handle all element sizes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h      |  6 ++++++
 target/arm/tcg/gengvec.c        | 14 ++++++++++++++
 target/arm/tcg/translate-neon.c | 20 ++------------------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index edd775d564..b996de2c15 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -602,6 +602,12 @@ void gen_gvec_uaddlp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_uadalp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                      uint32_t opr_sz, uint32_t max_sz);
 
+/* These exclusively manipulate the sign bit. */
+void gen_gvec_fabs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz);
+void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 2755da8ac7..01c9d5436d 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2697,3 +2697,17 @@ void gen_gvec_uadalp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     assert(vece <= MO_32);
     tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
 }
+
+void gen_gvec_fabs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz)
+{
+    uint64_t s_bit = 1ull << ((8 << vece) - 1);
+    tcg_gen_gvec_andi(vece, dofs, aofs, s_bit - 1, oprsz, maxsz);
+}
+
+void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz)
+{
+    uint64_t s_bit = 1ull << ((8 << vece) - 1);
+    tcg_gen_gvec_xori(vece, dofs, aofs, s_bit, oprsz, maxsz);
+}
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 0821f10fad..b9b3d1c1fb 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3041,14 +3041,6 @@ static bool do_2misc(DisasContext *s, arg_2misc *a, NeonGenOneOpFn *fn)
     return true;
 }
 
-static void gen_VABS_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                       uint32_t oprsz, uint32_t maxsz)
-{
-    tcg_gen_gvec_andi(vece, rd_ofs, rm_ofs,
-                      vece == MO_16 ? 0x7fff : 0x7fffffff,
-                      oprsz, maxsz);
-}
-
 static bool trans_VABS_F(DisasContext *s, arg_2misc *a)
 {
     if (a->size == MO_16) {
@@ -3058,15 +3050,7 @@ static bool trans_VABS_F(DisasContext *s, arg_2misc *a)
     } else if (a->size != MO_32) {
         return false;
     }
-    return do_2misc_vec(s, a, gen_VABS_F);
-}
-
-static void gen_VNEG_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                       uint32_t oprsz, uint32_t maxsz)
-{
-    tcg_gen_gvec_xori(vece, rd_ofs, rm_ofs,
-                      vece == MO_16 ? 0x8000 : 0x80000000,
-                      oprsz, maxsz);
+    return do_2misc_vec(s, a, gen_gvec_fabs);
 }
 
 static bool trans_VNEG_F(DisasContext *s, arg_2misc *a)
@@ -3078,7 +3062,7 @@ static bool trans_VNEG_F(DisasContext *s, arg_2misc *a)
     } else if (a->size != MO_32) {
         return false;
     }
-    return do_2misc_vec(s, a, gen_VNEG_F);
+    return do_2misc_vec(s, a, gen_gvec_fneg);
 }
 
 static bool trans_VRECPE(DisasContext *s, arg_2misc *a)
-- 
2.43.0


