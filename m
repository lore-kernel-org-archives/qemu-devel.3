Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74540CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNnu-0001ok-Ay; Wed, 24 Jun 2026 09:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wcNnR-0001b2-UP
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:37:42 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wcNnQ-00015h-9X
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:37:41 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4624a44e152so912854f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782308258; x=1782913058; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DY8kuxxNwlc1FK61o3Rtv6tRPc70RdExCw4u34E/thM=;
 b=C/s9YA7OkkM/iZOA1LtiwOEWM9QSxktiXDsc1Q+x9EqHpV7Iis4rm9mLJydyygcrAK
 DweexJ0biAhYZpbgBDUJJni2G0+DRa74Mj2h3uV8n7T35IrBD2T7gYoyF3ASwOYffiqP
 +gbobjBdFSGha5nUwQQbjD+5t0jU1VJ+Ddadx8bKhBx5+DIIj2LPJIgstwu00vmlsu3K
 iQJF2VbZJ/aKqycPLOVk00LpTkP9PS0WxPAIH+J9y7m9VH0aNOU0vlJ/3opoouYcaTGx
 9Zh9779wxQUkyCHxRX4DB5hsSQ/ScLoow+Pl47HCwVCJXSAOedSGPvQljMULfBrkhwsK
 /I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782308258; x=1782913058;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DY8kuxxNwlc1FK61o3Rtv6tRPc70RdExCw4u34E/thM=;
 b=hlfztVOOE9QnTjI0C387ajSGYUzO1nyjNLsZmMFOPZwcAXNozgPo0NADpw25gbnkL+
 zP3AHmu3HcT2YO0r/KEObU7fLO+crjjuUdgZANX8/hZf6OAep0zhIEXQEH87SSAFeLaE
 u+Q2TDvcDjeoALQVfLXsEa1Ana1gsRlf/lQZ6mztPvd4wm/fmxGaH3AwVwEeuYRguuQ9
 hPW8RlfuN/pr3KDwU4sXN4hFJQ9Kfc/1UruSiThEJBesVvYQSURxrIRkGsciAS5cJpf6
 mWv2o3vm0Z2MqsGwKsY2yQuzDUuFfp0QAZ0sGQ9l4cdXycwHFczPz58dVSD73R3Lt24U
 6LeQ==
X-Gm-Message-State: AOJu0YxgDOyqbFLieDZPobG3MyRcz2JcnQGKcgbaJC/uJyqYf0TvsvFx
 chE/iMJfxM3zKRlfOyM+V7Hr4JoJ3NMNs4MUB5w0/ci2n7306n1y++94Z0WyGvmRM2k=
X-Gm-Gg: AfdE7cl6mdc2oy72Kxz6wzXSucHQi3c69g/dFPI6FmvmnizJ5T5crfkDftBD/K3TZIX
 vbGGE6Kr1rrtrvOBCbOTzr9WLtGZgHeJM/6hIvxBIFBYAPL1wgVtqy9sHyzLhp64tF0j880Kknl
 fTUkidIRznAqG4tZLKgE8ZTJaH1jEtbgTxVuA4rYZsNYBNNJEk9CCisgruRLgEiyBhHoIAVXo+J
 N2flMzSXZaqGtep/sqWqvKX8pPvi0t1VYcAhhShHTp5Gin5XLJ1KijSRdHsdGoghTO4rfpMtrxa
 fqaOWIgXZGXsSHWaf5IOJ/4vsYAnGmaUknSeoMmTsYYt+UTbar/qGYPy3P1bodyZcU9dGNO8974
 aVqZ5cB9wvjmQy98kjTgbOTnvwzytkkcTqYAro5FGkft/ZXjKRijRXW2p5pWBcexFh/DCfUNEK6
 6g0k62i2HqV08mDwSF7OVfLWzOpA==
X-Received: by 2002:a05:6000:2911:b0:43b:5672:efe with SMTP id
 ffacd0b85a97d-46c04a35bd8mr5927872f8f.9.1782308258474; 
 Wed, 24 Jun 2026 06:37:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:2e21:1ee8:260f:9a76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1e840efdsm6646334f8f.5.2026.06.24.06.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 06:37:37 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 24 Jun 2026 14:37:26 +0100
Subject: [PATCH v2 2/6] target/arm/tcg: Allow vector FP conversions with FPRCVT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-jmac-fprcvt-v2-2-dc6cf8e512b6@linaro.org>
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
In-Reply-To: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Alex Bennee <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x434.google.com
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

FEAT_FPRCVT allows the vector forms of FCVTXX and [US]CVTF in streaming
mode which would otherwise only be available in nonstreaming mode.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/tcg/translate-a64.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 07f985a5f0..1a0868eaf0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9915,7 +9915,14 @@ static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, MemOp src_mop_int,
                       bool is_signed)
 {
     TCGv_i64 tcg_int;
-    int check = fp_access_check_scalar_hsd(s, a->esz);
+    int check;
+
+    /* FEAT_FPRCVT allows vector forms in streaming mode */
+    if (dc_isar_feature(aa64_fprcvt, s)) {
+        s->is_nonstreaming = false;
+    }
+
+    check = fp_access_check_scalar_hsd(s, a->esz);
 
     if (check <= 0) {
         return check == 0;
@@ -10120,7 +10127,14 @@ static bool do_fcvt_f(DisasContext *s, arg_fcvt *a,
                       ARMFPRounding rmode, bool is_signed)
 {
     TCGv_i64 tcg_int;
-    int check = fp_access_check_scalar_hsd(s, a->esz);
+    int check;
+
+    /* FEAT_FPRCVT allows vector forms in streaming mode */
+    if (dc_isar_feature(aa64_fprcvt, s)) {
+        s->is_nonstreaming = false;
+    }
+
+    check = fp_access_check_scalar_hsd(s, a->esz);
 
     if (check <= 0) {
         return check == 0;

-- 
2.43.0


