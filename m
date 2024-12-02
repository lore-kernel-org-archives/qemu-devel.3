Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2B0D7831A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6GI-00021C-A9; Mon, 02 Dec 2024 08:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6FR-0001k4-QY
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:13:59 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6FN-000369-Oq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:13:56 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434a9f2da82so36525585e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145232; x=1733750032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uI1GHeNAVBACaAOyrekRei9EE5yyDUO5Im1pzl3+9DM=;
 b=D5ei9pNmV7f8pzXMOmDq9lUhWciw8XltwFGlVWzD1liSNfwrQ5dtmoSBw/2uCp5t+h
 o4INDhFC3PFgMY7nQZbc7/3qla0543760H46P3jxQKA3P858nOkcpxDcYdErBkKwgqPv
 EIogSm4hJiUyRkCH3cnIqpzzvTX8tDcj44z6efJeDFJ++dfB1YH3FzPbATYDi3iN872C
 jle3Ne5Sa4lXQxhW6V1Fius+ba3+uj0IihYDoC3xL+MDChGfmK4yqegtiIm/rFjQ3p3W
 ueVWw67bdD5Z3gZZ44YofF/hBwQW72gcSxjWlS0BScWuGku5588SqCrto6EBegdHtsnr
 7ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145232; x=1733750032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uI1GHeNAVBACaAOyrekRei9EE5yyDUO5Im1pzl3+9DM=;
 b=DSfSQZwRme5qxNKyXYZzyA0Fkqg9RvoJWpAjY/d5os909ptnhuOFTarWCspVktV3jH
 iIgE11Jjx17+8ndfEBvfkI941V7OwAHRRNRHQgwLPQIRifx0+CxA3UrD1u+3w5L0IP6t
 HlL7HenQXjuDaowUm2EOYNVf6oVeXp6HkoU0p5I5jbxDnSke8gjLnffL1I5TNk8o0OU3
 mWL00bY7tFLtEMl6IxK8h9PSXowsVpnp42O6vf6xOKbojm3fge5n8/57v4uDjvsW1FRu
 +vrCVIykW/9KswACo99lGEr1hGR3hhtwIF/7IL7qv448b91QgcwBTLuHNUinfk3BfrqM
 Canw==
X-Gm-Message-State: AOJu0YyY0I0LFxWRUCKG+stG//BSVD+pU3EMdXiWtCc97QE2R82/IJMY
 dv0g+zFx006Sm1jT62cVJWpKe7zjbfdX5UBqojZId9ZdLSZmFlxbARZ/WMDBFHS22eQJZl7Bja1
 g
X-Gm-Gg: ASbGncvR8AfhIUZe7VoVgH1VoPfWxajqbf4GhlVWTVQy8evXLZptLxfZnqse60HHxWN
 qRNMDRZvDHM0oHXLcU+bCQ3OeIVH5v1Kd251E49mivgJZvA4pbXr2Rbg936VfeVutHJKaVBjbvq
 Vrwtwc1063/v0w4xrUHOOw8TTlLffwzNRTT+eFdzhEyx1H4G2LAvuj+uSholjWokFOxfL3UdoaP
 7Ua9s/ulFDdGT4lafsZIEz/sfqB9xtsde53ppLvX++O80Z76Z4hGnY=
X-Google-Smtp-Source: AGHT+IE3HY3Zmx7VHI2U1o+7kzmrqBCN6P/KD891ThH3cDUW8P24XUquBX9h9pjzJ8Nvf6/yFJ2y/g==
X-Received: by 2002:a05:600c:4fd6:b0:434:a781:f5d2 with SMTP id
 5b1f17b1804b1-434a9db8483mr197860975e9.5.1733145232101; 
 Mon, 02 Dec 2024 05:13:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:13:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 02/54] fpu: Check for default_nan_mode before
 calling pickNaNMulAdd
Date: Mon,  2 Dec 2024 13:12:55 +0000
Message-Id: <20241202131347.498124-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

If the target sets default_nan_mode then we're always going to return
the default NaN, and pickNaNMulAdd() no longer has any side effects.
For consistency with pickNaN(), check for default_nan_mode before
calling pickNaNMulAdd().

When we convert pickNaNMulAdd() to allow runtime selection of the NaN
propagation rule, this means we won't have to make the targets which
use default_nan_mode also set a propagation rule.

Since RiscV always uses default_nan_mode, this allows us to remove
its ifdef case from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc      | 8 ++++++--
 fpu/softfloat-specialize.c.inc | 9 +++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index d63cd957a19..aac1f9cd28c 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -77,9 +77,13 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
     }
 
-    which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, s);
+    if (s->default_nan_mode) {
+        which = 3;
+    } else {
+        which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, s);
+    }
 
-    if (s->default_nan_mode || which == 3) {
+    if (which == 3) {
         parts_default_nan(a, s);
         return a;
     }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index c557c41b2af..81a67eb67b5 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -475,6 +475,13 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
                          bool infzero, float_status *status)
 {
+    /*
+     * We guarantee not to require the target to tell us how to
+     * pick a NaN if we're always returning the default NaN.
+     * But if we're not in default-NaN mode then the target must
+     * specify.
+     */
+    assert(!status->default_nan_mode);
 #if defined(TARGET_ARM)
     /* For ARM, the (inf,zero,qnan) case sets InvalidOp and returns
      * the default NaN
@@ -578,8 +585,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     } else {
         return 1;
     }
-#elif defined(TARGET_RISCV)
-    return 3; /* default NaN */
 #elif defined(TARGET_S390X)
     if (infzero) {
         return 3;
-- 
2.34.1


