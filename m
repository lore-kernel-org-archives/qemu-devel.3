Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755CECD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoO-0006wZ-6P; Thu, 04 Jun 2026 19:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoJ-0006tQ-CT
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:15 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoH-000809-11
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:15 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c0aa420401so9825875ad.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616952; x=1781221752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYh5LzAhOZD5isybeA4Rz2JQCXMIBKO7pEbfbYnzmSI=;
 b=nOSQcT+IQ4T2cg8WYmj8p1MyrlCZFBi2//CBLna6OQsbl06jKobkvJ3wwxwh4kqaLY
 ma6bGAucF3BqNcw/XzqcBra7QSte4Q3oiJNYna0GIBeiTGDKoxo4Drn4+5ZMzfw6qQKe
 JNvPLXmb057uJb0y4ZeY9p/QZv/0kLsXdlZnXJpLnbFPvPbvJB8ff+Poz8vxhBJh33u6
 8mkXLBiBLlHcMs4rJPUoY07VRbH6p8NAyOV2XdGuK9LDGDGBdydthexHRvbTZmyHMURb
 uXi0+juWdHizHJsbdbAULbblo10N+EW6C71mE+O5jcqmRXIWwmXM5YJn8oFDUfW//QNa
 8iEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616952; x=1781221752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CYh5LzAhOZD5isybeA4Rz2JQCXMIBKO7pEbfbYnzmSI=;
 b=soZmHsqX5mRTFR0UEhxvWwC5BMWziCI7ga5QGVkiiEkH5geQssxadlncvFFPy8cRho
 J91BHRRXZbHDJnDHms2FD7YeXuA+Kvc6oLxEH3e1l1LwNheb9dE4misL9pPDkAegFXKc
 fbEsumYl3KGBVf0ZNnElNUQNwM1m5OzZa37Hi4hdtqd/PCAo+2iU28vRgO+jtR1H+WIg
 npoIui4hjtMzccJbVqwHzfrRRDeV3GqeOi/Y7bE1bBkFkLADu9r6TMw8JDecyTMjtmtM
 8Uigv4IjF9KlwO1dthczWsTGY+U9xv0FXbf8CmsR3OPGS+Lds2G9egP9TY1X8NvVU0+n
 Kyvw==
X-Gm-Message-State: AOJu0YxDd9n/vASZBruIW/1w6Yln0hd4uMHkDy1jyLGu4U19TZIbwvSt
 kEe8xVvTLs16nEZOZjHpRu4KgfrfBVVGtusekOKP3iIXpgv/X2F68DU0+TyVzCimgRI6g1A4ua6
 CjqBZQ9w=
X-Gm-Gg: Acq92OH59mE9g6rxXrEWwEUGeIzg/2l2HVYKBkgFVWoGfcLwrv81YMbHooQta4RD5Xo
 P0I824vphUwE7VzY7BbxCSrxhR2Z9ynVyPchcHBeMipNeN3UvA2SkTR5H9kr0b4JKsyy6janSMM
 G9v5hNHJEGAW3cEkhVVDSFk9JKp8IcN3KvSFzN10h4E0EdLzLxpW0GLlseD+ULtU8ziFAW4EjKM
 +CWkb/5FwEc0yvNdff/KlvtBfuKhUh7ETmrdTJb71CNU2YXCvuxb0A3hdDW9zZQI1xzPdrT/Tlv
 hkHgkqX6rbfXQ2SjePGvpJQ/ckv3DKAZnj93yWvmj4Op4JAw1hH1EyZxuEBJjrIKYHg9uIOEgbZ
 pQ0Fs/SwvyMwoX6mo9QuBUsGuxJLYBrJ1BbSNjUMBE2JcneA6jfqTV+k3lvJfdWaw1tWFfDUM3q
 H/BYrDlQ3Q/iF/GhkJEvnzsFCrw+eWz/ENBWxZKcoSfGrwLvv4CA==
X-Received: by 2002:a17:903:2a87:b0:2bf:13b0:f8ed with SMTP id
 d9443c01a7336-2c1e7b2ce09mr9063815ad.3.1780616951573; 
 Thu, 04 Jun 2026 16:49:11 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 25/25] target/arm: Use expand_pred_N for helper_sve_not_zpz_N
Date: Thu,  4 Jun 2026 16:48:52 -0700
Message-ID: <20260604234852.573178-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

These is a bitwise operation; with expand_pred_N,
we can always operate on uint64_t.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 43 ++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 57c7823feb..9c0477a0af 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -917,12 +917,45 @@ DO_ZPZ(sve_ah_fneg_h, uint16_t, H1_2, DO_AH_FNEG_H)
 DO_ZPZ(sve_ah_fneg_s, uint32_t, H1_4, DO_AH_FNEG_S)
 DO_ZPZ_D(sve_ah_fneg_d, uint64_t, DO_AH_FNEG_D)
 
-#define DO_NOT(N)    (~N)
+static inline void
+sve_not_zpz(uint64_t *d, uint64_t *n, uint8_t *pg, uint32_t desc,
+            uint64_t (*expand)(uint8_t))
+{
+    intptr_t opr_sz = simd_oprsz(desc) / 8;
+    bool zeroing = simd_data(desc) & 1;
 
-DO_ZPZ(sve_not_zpz_b, uint8_t, H1, DO_NOT)
-DO_ZPZ(sve_not_zpz_h, uint16_t, H1_2, DO_NOT)
-DO_ZPZ(sve_not_zpz_s, uint32_t, H1_4, DO_NOT)
-DO_ZPZ_D(sve_not_zpz_d, uint64_t, DO_NOT)
+    if (zeroing) {
+        for (intptr_t i = 0; i < opr_sz; ++i) {
+            uint64_t p = expand(pg[H1(i)]);
+            d[i] = ~n[i] & p;
+        }
+    } else {
+        for (intptr_t i = 0; i < opr_sz; ++i) {
+            uint64_t p = expand(pg[H1(i)]);
+            d[i] = (~n[i] & p) | (d[i] & ~p);
+        }
+    }
+}
+
+void HELPER(sve_not_zpz_b)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_b);
+}
+
+void HELPER(sve_not_zpz_h)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_h);
+}
+
+void HELPER(sve_not_zpz_s)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_s);
+}
+
+void HELPER(sve_not_zpz_d)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_d);
+}
 
 #define DO_SXTB(N)    ((int8_t)N)
 #define DO_SXTH(N)    ((int16_t)N)
-- 
2.43.0


