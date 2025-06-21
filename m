Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B6CC71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82k-0003iY-OB; Sat, 21 Jun 2025 19:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82T-0002N8-J7
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:25 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82R-0005BL-Pj
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:25 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-748fe69a7baso2622062b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550062; x=1751154862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kCGUo0zQtv5Ty7EFC/ZzR7PCp/6kK2tqVOF89Ssycqg=;
 b=bXse0r1I4Cxgvo1Vx08bu2ROczrKepAOMTHtavlDKrt4Ptily9ZWb+w7y4Xqet24cE
 rLt3ODC7Y90TKMu7yBMF7YhmxQpgNplh6Qjf5Otc3Iy/pF3xrqexVmF6loRjbykm9WIw
 5wDGokkIrtdxlONIY5h3tbDB/Gs9IQauSJEePmvYa4JIioXv+mLamaLXJWZGWBgn7UU6
 QFQnDithRbiQQjl3YdkXooGf2ri6COBZlaP8kNL7hFy3rt7LmcYby99Qiaay+DowkRv6
 BPs1iK1sFFih8iQokXUEj8VTZmHn9kAx11myEhbYH6vYO7wZ0uks/Vq9gG/mN9L73S9X
 o3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550062; x=1751154862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCGUo0zQtv5Ty7EFC/ZzR7PCp/6kK2tqVOF89Ssycqg=;
 b=aI6IKN0Wh8qvqJGxx1ulATRyInaCT44wweAOMTbUqsxmE01Yju22OwUNl3B45K2cBV
 /SHp88q2hwyt/Nu5KdhG4di5LdA5yPKFwhgv8gWvDJ6yFcD9StsLqLcrYCpyZN+xZEQ/
 q/5/RIQYu3HlVm0bIe7U5009JeMJphI4M7dzMmEt+SoUyG7iFtNg3GsFzzy/K86ogBzO
 58Jl29U/FVQMF4cZBkkMV+dLODozOeIfOWk8zQXcmE5m8dIz77rLh4V1jwMISqv/nySP
 MtFxlYSV6GK/e0Bn58op0y0yzfiUkdtBYr0zlWTAGxC7mMhuPkYYLakS+kRO3Pp/XCeb
 hBKw==
X-Gm-Message-State: AOJu0Yy+v9FdpVA0v3QjXK82oL1cC/NShB0SIT3+7t9Z8cbaywz6hI6w
 wlW1qrcoN409Aoc8h/mVwNU+lzzGatkb3JW4IXyzH7cv/CDvGGil8jC5oj9ibHUQXlDgmdKOZba
 bc7wRsGQ=
X-Gm-Gg: ASbGncupVfKDxZ+BiifwLNpxvjX2LSG/mQt22Zcd/O4RsyNj5JVqBmGFcydBR6HtorM
 ErEdAvcKO/zA1b9P/36Pf1C3LVR8ngwo0lhGYgLpzGndhAGBn/sHjNkbgfl9l9EiZv167PIqqbi
 StmpXif3rSGPaiS5QJXqlo7UOXJiT0/CEtjrq7aeu4RZueJBEsKudXQq7KCey+BRcI91N7nWVXz
 KxJZ2KEVHrmKOqEonJbRQqQC4QEGSc7Ige8uH8XzPrE53p2ZhTb/CY+J6NOzBA3jY08RvEKVHLG
 i9tfQcai2q3bry8l3IhLcnHjmoDk8ON+OfA40Je/IL6gIE8VtX6ICTNUOdx3wylqBC9ZREE6vd4
 6yUs9ds81IgMtjpxzd5/gm1j3zDqgk10=
X-Google-Smtp-Source: AGHT+IE8oP/TKiblNes/sYF+Eg3mApHMSmi6Ukc3OVBnt+14Em5d+rou2q6ZqLEk2omVlDeNT/L3Wg==
X-Received: by 2002:a05:6a00:2441:b0:748:fcfa:8be2 with SMTP id
 d2e1a72fcca58-7490d478702mr10041030b3a.2.1750550062430; 
 Sat, 21 Jun 2025 16:54:22 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 068/101] target/arm: Implement SME2 SEL
Date: Sat, 21 Jun 2025 16:50:04 -0700
Message-ID: <20250621235037.74091-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 25 +++++++++++++++++++++++++
 target/arm/tcg/sme.decode      |  9 +++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index f4af2dd98d..186d46ecbf 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1541,3 +1541,28 @@ static gen_helper_gvec_3 * const uclamp_fns[] = {
     gen_helper_sme2_uclamp_d,
 };
 TRANS(UCLAMP, do_clamp, a, uclamp_fns)
+
+static bool trans_SEL(DisasContext *s, arg_SEL *a)
+{
+    static gen_helper_gvec_4 * const fns[4] = {
+        gen_helper_sve_sel_zpzz_b, gen_helper_sve_sel_zpzz_h,
+        gen_helper_sve_sel_zpzz_s, gen_helper_sve_sel_zpzz_d
+    };
+
+    if (!dc_isar_feature(aa64_sme2, s)) {
+        return false;
+    }
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        gen_helper_gvec_4 *f = fns[a->esz];
+
+        for (int i = 0; i < a->n; ++i) {
+            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->zd + i),
+                               vec_full_reg_offset(s, a->zn + i),
+                               vec_full_reg_offset(s, a->zm + i),
+                               pred_full_reg_offset(s, a->pg),
+                               svl, svl, 0, f);
+        }
+    }
+    return true;
+}
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ca73a58a68..80fe02190c 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -876,3 +876,12 @@ UCLAMP          11000001 esz:2 1 zm:5 110001 zn:5 .... 1    \
                 &zzz_en zd=%zd_ax2 n=2
 UCLAMP          11000001 esz:2 1 zm:5 110011 zn:5 ...0 1    \
                 &zzz_en zd=%zd_ax4 n=4
+
+### SME2 Multi-vector SVE Select
+
+%sel_pg         10:3 !function=plus_8
+
+SEL             11000001 esz:2 1 ....0 100 ... ....0 ....0  \
+                n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2 pg=%sel_pg
+SEL             11000001 esz:2 1 ...01 100 ... ...00 ...00  \
+                n=4 zd=%zd_ax4 zn=%zn_ax4 zm=%zm_ax4 pg=%sel_pg
-- 
2.43.0


