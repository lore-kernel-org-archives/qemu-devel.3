Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2CDF9B609
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUeq-0007Jg-Ht; Wed, 22 Apr 2026 06:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeM-0006yl-5V
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeD-0002NN-Lb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so37141405e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776853050; x=1777457850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9WNiVc32x9uwc9Kvl3F3IabOVkUVJfyhaJuWqhRbgs=;
 b=lpf5FT+fG4RvwdNrOLYAt5rVTc6OTeMRM5if5IFQX7ZTpGzjeeiMpcSF48dL4T8rf6
 nS9Nv/aIibuPHhOhSJLdfM2t8Kdee+dh6GERxsODMgEdshIReJiHHiBNKq+Iv0LqEy4M
 muMJeRKelFwE33Tz8vWkYVMiP/yfC0Qmbt8um8EBKKlspnsMs23Y2tXmijUThWLuxwF8
 y9VNWZWvLBdAOvGhV655rYNyBmODBjpc6OyB39dhRWItB1pTmENriOOw2f9OZnLqkbXg
 TO6QKmzA0Je7z1sQe5BbJCuQ/OarnSwCRMnPOqfBsdB0eY2IFVKRaap9jLbTo4M78yGb
 X4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853050; x=1777457850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V9WNiVc32x9uwc9Kvl3F3IabOVkUVJfyhaJuWqhRbgs=;
 b=bd2/rY6dwqf/K7HiqDpSlvswWP8X9/9GB7vpixxjrM1EhtIwjA1e2MTTqgccU6VH+H
 ocFx7mCsJeSxl2N4uZVmnWE3Axrsa4xr6m9vLLKsSP+7YCnDqVgrF7Diqx176aPMBIZP
 zR/lnv8hLilLSS3doo7g0aKZswLOyBjoGIIQ7JJjSWMThBekKXCqUEzDlEeC4rkZ5ePk
 s5ro/GHHCfHTzJGwgydroyLKuWC5xM/46JOF+WWoNOaEC5TGY1wwM1IW8lwESXU2+RtF
 cDS0cGVuGWhJ4TulvWqzuhm3k+ZqnTFtkPC1vJby1VXYbJg5mj5ilIfTWMqNRe69pAs5
 9ibQ==
X-Gm-Message-State: AOJu0Yy6hUFfNdJ6Vje0DS1L6Bjq+yt5FJ545ejwe91N6JupPqWVYvRx
 AeJgoI518tWw/aGg0gLUPzqGvrr6IrotChj8Lp/BmBXUW0ju7LonsllREWTEZEf3g24=
X-Gm-Gg: AeBDietd6O0Mfc07MW4OHfd1IJlWdywpeU+dz9XSH2lR8jSbDJ2+/LXsyLiqWZMn366
 44O4iV+TdNB9OsG0vYJ1pRX2vLfEBQztyIpNkkLE9CzV9fT+N7ploRie/MRk40eIKVaSmWBVI2D
 8OJrx6XBBUnj04mwyzxSj3jAMqDPv2m9n0LBbXezr3V/A0aon46dQI9ayibGuHwYBygYwpttANX
 yEZ+IstirfdLOXBwjpCHC+cApj8KRNQVNIBgYTsnSxDqmOl5tgOH0IjDez/Y5BD/Rj4BYpTbxLm
 uLAvqD672Vqp4ceZDdbLRzvGA0tKcXUJzlHPYszT9odzmCdsF6AEJkOpi6ULQaQWwZ1tyxLTemg
 3KlOyxDV6UJCs4KumWtkvnM3hax+/5w2kv30KqD9bYPZMDQy+OKUkLpUqFKi8ZgboIlNCvqGNrS
 z9mSy/VxJzNogBtZl3a0Bs8pvXj87txlUCtw==
X-Received: by 2002:a05:600c:5254:b0:488:8bdd:cfcc with SMTP id
 5b1f17b1804b1-488fb6e62a8mr333377305e9.0.1776853049667; 
 Wed, 22 Apr 2026 03:17:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm420040875e9.1.2026.04.22.03.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 72EA26153F;
 Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 25/31] target/arm: redefine event stream fields
Date: Wed, 22 Apr 2026 11:10:36 +0100
Message-ID: <20260422101043.1234229-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

The event stream control bits are the same for both CNTHCTL and
CNTKCTL so rather than duplicating the definitions rename them to be
useful in both cases.

We will need these in a later commit when we start implementing event
streams.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h | 11 +++++++----
 target/arm/helper.c    |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 85980f0e69a..dc593f1fec8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -263,14 +263,17 @@ FIELD(VSTCR, SA, 30, 1)
  * have different bit definitions, and EL1PCTEN might be
  * bit 0 or bit 10. We use _E2H1 and _E2H0 suffixes to
  * disambiguate if necessary.
+ *
+ * The event stream bits (EVN*) are in the same position for
+ * CNTKCTL_EL1/CTNKCTL.
  */
 FIELD(CNTHCTL, EL0PCTEN_E2H1, 0, 1)
 FIELD(CNTHCTL, EL0VCTEN_E2H1, 1, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H0, 0, 1)
 FIELD(CNTHCTL, EL1PCEN_E2H0, 1, 1)
-FIELD(CNTHCTL, EVNTEN, 2, 1)
-FIELD(CNTHCTL, EVNTDIR, 3, 1)
-FIELD(CNTHCTL, EVNTI, 4, 4)
+FIELD(CNTxCTL, EVNTEN, 2, 1)
+FIELD(CNTxCTL, EVNTDIR, 3, 1)
+FIELD(CNTxCTL, EVNTI, 4, 4)
 FIELD(CNTHCTL, EL0VTEN, 8, 1)
 FIELD(CNTHCTL, EL0PTEN, 9, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H1, 10, 1)
@@ -280,7 +283,7 @@ FIELD(CNTHCTL, EL1TVT, 13, 1)
 FIELD(CNTHCTL, EL1TVCT, 14, 1)
 FIELD(CNTHCTL, EL1NVPCT, 15, 1)
 FIELD(CNTHCTL, EL1NVVCT, 16, 1)
-FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTxCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 40dd070d2c1..81a07ca42d0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1746,9 +1746,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint32_t valid_mask =
         R_CNTHCTL_EL0PCTEN_E2H1_MASK |
         R_CNTHCTL_EL0VCTEN_E2H1_MASK |
-        R_CNTHCTL_EVNTEN_MASK |
-        R_CNTHCTL_EVNTDIR_MASK |
-        R_CNTHCTL_EVNTI_MASK |
+        R_CNTxCTL_EVNTEN_MASK |
+        R_CNTxCTL_EVNTDIR_MASK |
+        R_CNTxCTL_EVNTI_MASK |
         R_CNTHCTL_EL0VTEN_MASK |
         R_CNTHCTL_EL0PTEN_MASK |
         R_CNTHCTL_EL1PCTEN_E2H1_MASK |
@@ -1763,7 +1763,7 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
             R_CNTHCTL_EL1TVCT_MASK |
             R_CNTHCTL_EL1NVPCT_MASK |
             R_CNTHCTL_EL1NVVCT_MASK |
-            R_CNTHCTL_EVNTIS_MASK;
+            R_CNTxCTL_EVNTIS_MASK;
     }
     if (cpu_isar_feature(aa64_ecv, cpu)) {
         valid_mask |= R_CNTHCTL_ECV_MASK;
-- 
2.47.3


