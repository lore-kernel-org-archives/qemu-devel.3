Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164B0C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht8D-0004Rs-7Z; Tue, 11 Feb 2025 11:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht65-0006tH-Vl
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:57 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht63-0003Uj-Ha
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:53 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4394a823036so17359315e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291210; x=1739896010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aqkV0xjCTajJ3P+rZ10ePbD+Oe29v/TIuU4/7Qb75WM=;
 b=JWKbgRnZkYMCLPwQwwd7xTzEYB56p24rulwsN38VAT2Xbz6t2hknHCE89Mn8oJqOg4
 g++QnDFH/ViKQBBgYiBDozLIZf8i5R+oW5D94gWAI0dR317oiDTLcXwQUIkKjinaE2tf
 o/26wqPK3YxjVrFWl7sjv3cf8nOc0F1RLOmt/yvMIDnNVZ1py5JGjKkmEDjcPF7g0jY9
 5iEN65dcYckk9jcp0KX8o3tmbiE+Po8VnPwOZzOii2qGm0mbkoBy/z5LnPrSrpmRa3QS
 C3wJ1TtXCS/8J2ZZ3ssFmreN9ea3keDaTXPTJXe6K2X/uRs0WHZ68UzAlTLCkQYYdElQ
 tWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291210; x=1739896010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqkV0xjCTajJ3P+rZ10ePbD+Oe29v/TIuU4/7Qb75WM=;
 b=VWs46xmpUxBSQZx/AOR3v0sqDfUlbWUsErAOCA8dcGOFRoW7RN6uJ+9Ye0Ta9CmXnW
 zKi2VicjhTwkh+1IWggS++0Ow/fI2LpcoBaixSrx6jHzu130fdvkS2amdyBH28JhZ/cl
 cquCENL3ZrxJKkb5T95oGSfQ1LMfPlCV1RNnLNcO8BqcHoK+ZyNejXskA9CzZpk7Sfg6
 8s5RMivMS7qeq4SBc2dqKytlQlgdaCpUG90hNqc951rkTi9wAJ0M5G4udQWbtt++7qCN
 PMROifrLUQ6+e+a9uWldht6AMl7Ob9xBBOg0ynM7hpcJenbGPavkwlQgofiBjfI17LhO
 0h0g==
X-Gm-Message-State: AOJu0YyNHVEn+wwu5FZokG160lAdG3VgD/Tdf7WPXliSK4jWhOcj5mCx
 fCTSxMsjH3apPqUaOdzaVr7fjBkh3l0DDaektoN5Oz4qJIb3Rmxzf3SV0vqSWyKwK5b4DZCHdwO
 r
X-Gm-Gg: ASbGncu2KAC4jAd200QH9K0HbT591MYgIP5NqJkVAcNjGQK2EUCfgwjZ7KnWGUdBCEy
 YBgoEiWRCxYOpp+zbS+2yvRLkoQxx6S5wsY8ccb6lIpuAnUjDOnW2pnTTUkHXF194fdZfGgcYal
 1p2Zf5OeCCPAIwu6Iokw6T7tLbJ0VvF4jP5AxRwU/Ty7y4LhAaLfnYM0ShDo7HpZXc0jM8CUmGi
 m/9B6J31aU44jqkDuRbX1M3/v2GnYJwQQMowT2V9TLkzKV0XORDKRp6oLbJZKLe8M/kKMirtET9
 CaXOHVScPxAxtEyvYUrm
X-Google-Smtp-Source: AGHT+IG68xo3uJI8isWh5qlGyXU3Wi34AsITRv3h5xnIkRA9P2TGfP3vAlET2kG6wTd/n+RlST0IWg==
X-Received: by 2002:a05:600c:34ce:b0:439:3254:4bf1 with SMTP id
 5b1f17b1804b1-43932544f7cmr107098555e9.8.1739291209882; 
 Tue, 11 Feb 2025 08:26:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/68] target/arm: Handle FPCR.AH in SVE FMLSLB,
 FMLSLT (vectors)
Date: Tue, 11 Feb 2025 16:25:36 +0000
Message-Id: <20250211162554.4135349-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Handle FPCR.AH's requirement to not negate the sign of a NaN in SVE
FMLSL (indexed), using the usual trick of negating by XOR when AH=0
and by muladd flags when AH=1.

Since we have the CPUARMState* in the helper anyway, we can
look directly at env->vfp.fpcr and don't need toa pass in the
FPCR.AH value via the SIMD data word.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-33-richard.henderson@linaro.org
[PMM: tweaked commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 42bb43acd78..aefcd07ef00 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2178,19 +2178,28 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
                                CPUARMState *env, uint32_t desc)
 {
     intptr_t i, oprsz = simd_oprsz(desc);
-    uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
+    bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
+    int negx = 0, negf = 0;
+
+    if (is_s) {
+        if (env->vfp.fpcr & FPCR_AH) {
+            negf = float_muladd_negate_product;
+        } else {
+            negx = 0x8000;
+        }
+    }
 
     for (i = 0; i < oprsz; i += sizeof(float32)) {
-        float16 nn_16 = *(float16 *)(vn + H1_2(i + sel)) ^ negn;
+        float16 nn_16 = *(float16 *)(vn + H1_2(i + sel)) ^ negx;
         float16 mm_16 = *(float16 *)(vm + H1_2(i + sel));
         float32 nn = float16_to_float32_by_bits(nn_16, fz16);
         float32 mm = float16_to_float32_by_bits(mm_16, fz16);
         float32 aa = *(float32 *)(va + H1_4(i));
 
-        *(float32 *)(vd + H1_4(i)) = float32_muladd(nn, mm, aa, 0, status);
+        *(float32 *)(vd + H1_4(i)) = float32_muladd(nn, mm, aa, negf, status);
     }
 }
 
-- 
2.34.1


