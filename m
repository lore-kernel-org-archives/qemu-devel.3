Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5BDE8B39D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVOD-0000fv-Bl; Wed, 04 Feb 2026 00:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVOA-0000b9-Qn
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:19 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVO8-0003IN-UO
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:18 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a76f90872cso34061555ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770182715; x=1770787515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqXpo9wXtolgQ7gzPRkCZdp1OA2hHW5gDfgPCkKiZr8=;
 b=ZLjuJnIbovKUBt8tOWWPip3VsIYcyKuhcnKLhyaYXgpVzIf/R2rbw6o7XGsTCZ5A1y
 DfidmvmyusoxcWTpZSQa/YoTy+3roRxq0ydKe0H/dH5qSKF/P+6jHOH7MPucq68JquAd
 4V+oMqXv4VRfdB3hwSvTeeNemBh+O3Lfm1iN9Y41480twcZF+HB0Gmze2g7Pv2j3C5kd
 G0RiBgoYWh5VQCtp5eo5i6O5UrBLHNaW44S8XqdHdcqeIs0Hhl1DJSxFTnKGMbDbR46W
 rd2xeDMoP19YL+OCMc3qyOh0R/LotkJcYdLbYQEa2HnXDua9+6kiMgICpn1tZxIkMohq
 Q50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182715; x=1770787515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fqXpo9wXtolgQ7gzPRkCZdp1OA2hHW5gDfgPCkKiZr8=;
 b=Ajxwlm7KRpEuAIn2FYzzrDQS77rtx0YS9hdUd6fkx8DKDbKFNXs1mWgwkCdW01woon
 ABZ841sb1QC5k+oJaFZokUY+2SMfmnlCMJptv5P8k56et9KULNSiaU0l+YyVVRlFzGHm
 6q/lrRA3DqhUh6R8R/MzxAuyQ3zCgHFnw0nYBYjv+uDO2zq9/3Mn0L4eUW9CHzIpO5nY
 uNdjsyu8xILZ6boIJNfzB+YSlYABqQM/GDvlACUyYL16X1DNCL5u4s67FXKsfLRwCRh0
 t5HquTXaF4zlpkyS/dj/OW2JLzwRJmcQApKO8crr7c8UOT3fJzK4Gd7TN8NTNMVDLxWf
 dcGQ==
X-Gm-Message-State: AOJu0Yz2QSIOvsiB7lRa+iJaLBLT9zH4i1/PZXba4BbSZfYOudgmGbeG
 cNdBKK3pNdg/muA22Of1VDh6J6TUzEjJunX9szI9wnsFgJBoWw75J5rPsAAA7OeJlHh93rZ8x9J
 CKorBaCw=
X-Gm-Gg: AZuq6aI1jmFNEyFC0FGG7BeF6gq/uhNKA1oRe+rXy/0vWwqGXXUnXAAoxQvbVDFLEOf
 eUcLHhco1/zYwIBDAZumejYwQqQNY7k1emFJmNqzKDgYsYZxavOKtBghd5Mfp0WjC4OoOX+NzWf
 HLF/eMnPVoZbW6jjGni0HXTMuAUpTN7Qai28QJC6FI3LCCHsDcfAyEkIId41oPL9vVw9uY/D4WV
 E6wjjT4PNCxa9fldOlWpHnxonO796l+zcCoILj57kvhJPLLdp6lRMiCc3jeIATjau/ccd83sGSM
 TVVCaIS5cW5ye85uH7UKYjLYyHTtkk8x74xPw5NSa3Yk3S7UErOQZpiINV/lwJwkH9DhyszEO4c
 YlQWxp7deuFvY54cEjV/U5XEDQwZ1bYgocLQHLx237foKUU3omb3+ZasLdZkEzXrLHtEnXldCu7
 rBVhaVumXyv4/Ld9n7pL+XbRGw35TaykO6vHBLkvEHxgdmL5Li9mLZoZulU6Q=
X-Received: by 2002:a17:902:c411:b0:2a7:9b6e:33df with SMTP id
 d9443c01a7336-2a933fb25a4mr20097635ad.35.1770182715405; 
 Tue, 03 Feb 2026 21:25:15 -0800 (PST)
Received: from stoup.. (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933965c3esm10062015ad.67.2026.02.03.21.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:25:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 5/6] tcg: target-dependent lowering of extract to shr/and
Date: Wed,  4 Feb 2026 15:24:55 +1000
Message-ID: <20260204052456.970605-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204052456.970605-1-richard.henderson@linaro.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

Instead of assuming only small immediates are available for AND,
consult the backend in order to decide between SHL/SHR and SHR/AND.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[rth: Split from a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 078adce610..263d208002 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -907,6 +907,8 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
 void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
                          unsigned int ofs, unsigned int len)
 {
+    uint32_t mask;
+
     tcg_debug_assert(ofs < 32);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 32);
@@ -922,8 +924,10 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, ofs, len);
         return;
     }
+
+    mask = (1u << len) - 1;
     if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
+        tcg_gen_andi_i32(ret, arg, mask);
         return;
     }
 
@@ -934,18 +938,12 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
         return;
     }
 
-    /* ??? Ideally we'd know what values are available for immediate AND.
-       Assume that 8 bits are available, plus the special case of 16,
-       so that we get ext8u, ext16u.  */
-    switch (len) {
-    case 1 ... 8: case 16:
+    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I32, mask)) {
         tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_andi_i32(ret, ret, (1u << len) - 1);
-        break;
-    default:
+        tcg_gen_andi_i32(ret, ret, mask);
+    } else {
         tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
         tcg_gen_shri_i32(ret, ret, 32 - len);
-        break;
     }
 }
 
@@ -2121,6 +2119,8 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
 void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
                          unsigned int ofs, unsigned int len)
 {
+    uint64_t mask;
+
     tcg_debug_assert(ofs < 64);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 64);
@@ -2136,8 +2136,10 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, ofs, len);
         return;
     }
+
+    mask = (1ull << len) - 1;
     if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
+        tcg_gen_andi_i64(ret, arg, mask);
         return;
     }
 
@@ -2148,18 +2150,12 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         return;
     }
 
-    /* ??? Ideally we'd know what values are available for immediate AND.
-       Assume that 8 bits are available, plus the special cases of 16 and 32,
-       so that we get ext8u, ext16u, and ext32u.  */
-    switch (len) {
-    case 1 ... 8: case 16: case 32:
+    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I64, mask)) {
         tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_andi_i64(ret, ret, (1ull << len) - 1);
-        break;
-    default:
+        tcg_gen_andi_i64(ret, ret, mask);
+    } else {
         tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
         tcg_gen_shri_i64(ret, ret, 64 - len);
-        break;
     }
 }
 
-- 
2.43.0


