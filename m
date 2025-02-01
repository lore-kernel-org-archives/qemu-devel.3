Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71613C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZ2-0008FP-1V; Sat, 01 Feb 2025 11:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYe-0007Jp-0p
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYc-0001Jd-B3
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:23 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso31080375e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428081; x=1739032881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aqkV0xjCTajJ3P+rZ10ePbD+Oe29v/TIuU4/7Qb75WM=;
 b=BZ5SYvciqMuQPkO8a4hpzExq39fYlqtWpOsTwNtVuKBjVSM+H1qobA5LubYeW19tqd
 SmlQ/R3+Cmr6qWuRQ6OjQbm2hxoMiOI0sXBUkiMg5FIBFzS7jhWYidp/4cOXhKoXv0+d
 vxFf9iuy2n5G4BqkaYMM6yo9Fa1CF1mXp6UqI3r50lNEvu4NtktgTL0RvVmLArPCO2jT
 N5B+LBp4FQRVvaaIqe8iaB83ju4YXmSrgR/re74YsKAR48wRzM2pXwd3pKrnsDHjm4JE
 WqxQ8xItl05KzOBl/8FfXmTLltsEwI7xmIzkaQzUYomuvON1ztVbRLLa4KGgsw1UwNPW
 oGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428081; x=1739032881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqkV0xjCTajJ3P+rZ10ePbD+Oe29v/TIuU4/7Qb75WM=;
 b=Z5xbpkVkTO1Yc5NawMoypyB2hxhPNfZwra5cwWc34mYpi+L3OAE92kLFwoAg3H+l22
 0WAhEZ0K8pqPHdW9BcELw32wG1G8pRvvCWRZPJ+n+TOVb3UnJ3AbI9525cQl16zaJBel
 IDKLXgcJ59ERH3INzm166yYQnLI2lIQdCPAujbu0ciRtANrqCXqTM8iyokXp1sFDyX50
 GrtLrJ4YsfvJhPsTGWhTLpPkLk1CoNFGm8q/rvXsQNRo4qCxjhXZ+fB9VbxdBmpDSBB6
 2VYLQAcEEoNMwvkREYd5en0HmIg5MMh0Y6uVjdEqQ8NipBN/OpBp7BuxtBTbbScwALsd
 EbzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWJYh+6Kpjc5iF61szoZpD9xTNeG1PVeBNVGkODgMkOg2VaBTxgX31fosJZYIb1uYhiscrstlyRDpf@nongnu.org
X-Gm-Message-State: AOJu0YxegBxORVIeOCdSsWt8QATlnkSSMCHPbvqajaYpzjOemVhV3W0X
 jIOSH/PVSt06oVuKiY7/tsQduDhseX95OHGbwXRG9B4B/AzzJqD3m0J4ls+abAE=
X-Gm-Gg: ASbGncv3Ln98umfTwxaLnrT9fRTA5GuvSmMG+I5Baha7f37ow31F3Paq9hyE5WukZbS
 NdrGN99brreu6mRhrsgDTMMY97v2ygBcNy0dQ07vzOOywiPqKhcVMYepOqBHOd3dwvTP/Y7fvaW
 2FN9l4I9ajZyH2YzoV/VzOfX4MvmiQuIPVEf0m/nt457w6ViVxcFXMZRcM8uarjw0+R5zKnc85u
 30tJn+581zIYbuJu+duZfuh0EZwUrlA/tJ34mxOjtr8I6MXbUcYj20DH34kV+QjXvdVfDNcXmmW
 jg6A9eqsplEwKEzHd5Br
X-Google-Smtp-Source: AGHT+IHccjLmTK1Zzk/207PhBC0wXymGV2gi/SI3WzCetdJYNumnTEiPzO0DWhD1umPOdgSaMGTrVQ==
X-Received: by 2002:a05:600c:35c3:b0:436:9227:915 with SMTP id
 5b1f17b1804b1-438dc3c22ebmr122865355e9.9.1738428080872; 
 Sat, 01 Feb 2025 08:41:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 51/69] target/arm: Handle FPCR.AH in SVE FMLSLB,
 FMLSLT (vectors)
Date: Sat,  1 Feb 2025 16:39:54 +0000
Message-Id: <20250201164012.1660228-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
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


