Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66691C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBb-0005kJ-H5; Fri, 25 Apr 2025 18:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7n-0005Xc-Dn
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:24 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7k-0001OC-7M
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so31145705ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618538; x=1746223338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WglycbPcE3zC2RAMMKBRHGhj/1SPbsKRWhmjSwvRD/8=;
 b=ooGkf82rksQPkTy99RIJEg7zVG5MGNboHFpPxqAIbES2a0i4MCX6Wq1wDdJpWpVR7R
 2+n/Wba4BtCVMXxTLtRLL0m0h5qJKAdG8lK1fB/yv1lNLDMLzwPoqG45Sps0JbeUAUM1
 kuMLy0xiTSnJOqyfErMh3CSjgm6cNc+2ZtijVhZDN2tesvMo10GtD/C/E+pp8u1r2ACH
 PEtBqEekxM1IQfNjqJXurE+Dnqn3JlMnJOh/A+AIcUw3+J5pbc8K6PGq6/Nlcm57WRVU
 OS7bYAiunW+YOm7I/Aj/69glv0MJZEQ5b8dNg9en0QX5aJhJbQQYqiUtjjxMiWbGnCUv
 juhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618538; x=1746223338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WglycbPcE3zC2RAMMKBRHGhj/1SPbsKRWhmjSwvRD/8=;
 b=j137j5ZCOGKZEs6xqRUfflSKXAt5Z0YIvh2FkKd1DQsx5jDMVHXP5Ox/xy7GfsLB3M
 /bxdgyjQvpO74rzcdie5vnywnmtGohP8OMjzVTAQxK4ssx/dPoroThHi1CqPNOqQIVxv
 boYFnFs0dYjKfeQEHyKSajdvF6CuZGx0s6AtEyO8X58hMKIkqrI+xGNHQ+cS3BS8AKHy
 RN0GgNQBVKucJxUdvXBYvANNbbanb4cEA9lyZSbeQCre+gMg6xEVa1A9bQyrdVE4EPtc
 a4FXApXLJBhVhp6ljK8KhuXeb617YLQmvcbaXThFvEX7Z/NcTYH3ig8Ev8V9QMgeoEve
 DM0g==
X-Gm-Message-State: AOJu0YwAxrSh1m4VyRfLgi6R5/114RPNSsi7Cm9S5geguCyWeK2ATOzh
 In3KSiLDMgboZMjLZgpQPIjeHIijrFyP79YTkm+ggOIHPu04iNI/UFVmMqdcGdBYxSAm6+vT0Ev
 o
X-Gm-Gg: ASbGncs8ugRYl9Hdppklk60Im6z/ZieZKoWOfrrj3YrW9puiL6WOfWa9E1D7eIfHio1
 ZCYuwcOSzPkoYwvxpZ1N3SCjj7EIdUQ9YfIVdoAx7ZghRF5uSoabcBdgB5NMiGHyYlq/GS0meLT
 sxXi6AkDDdcPs4zD8yQfzsQrslNk+MQmgUSxlZ1ZutrlqW/mL646GMUmkLsJpe3mJQ3wvgZq3fh
 yGdCJOO98u7g8RqH7VyGAp6FKYenThFizzJGWI9kIDCOhzfFls7FyycwcPVphVw/xL0xd/OZYAt
 KiCcwHN30ie0NzmoS+jBM8CkLtrp4LMaXGkyXtzuwA65e0pymVqk5GiCDtd42FMpZ9ols5E2TUz
 RgiprbxyZbg==
X-Google-Smtp-Source: AGHT+IGUO6slccRW9oCpbY0krSx4dCKPGZmkJ8bAwVxGZ+gIhDpLCaG8yDNZ5xhZoe+ZdlftUmJhAQ==
X-Received: by 2002:a17:902:da88:b0:223:5ca1:3b0b with SMTP id
 d9443c01a7336-22dbf62c6edmr61836715ad.40.1745618538326; 
 Fri, 25 Apr 2025 15:02:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 110/159] tcg: Expand fallback add2 with 32-bit operations
Date: Fri, 25 Apr 2025 14:54:04 -0700
Message-ID: <20250425215454.886111-111-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

No need to expand to i64 to perform the add.
This is smaller on a loongarch64 host, e.g.

	bstrpick_d  r28, r27, 31, 0
	bstrpick_d  r29, r24, 31, 0
	add_d       r28, r28, r29
	addi_w      r29, r28, 0
	srai_d      r28, r28, 32
  ---
	add_w       r28, r27, r24
	sltu        r29, r28, r24

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index edbb214f7c..8b1356c526 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1105,14 +1105,15 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     if (TCG_TARGET_HAS_add2_i32) {
         tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_concat_i32_i64(t0, al, ah);
-        tcg_gen_concat_i32_i64(t1, bl, bh);
-        tcg_gen_add_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+        tcg_gen_add_i32(t0, al, bl);
+        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, al);
+        tcg_gen_add_i32(rh, ah, bh);
+        tcg_gen_add_i32(rh, rh, t1);
+        tcg_gen_mov_i32(rl, t0);
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(t1);
     }
 }
 
-- 
2.43.0


