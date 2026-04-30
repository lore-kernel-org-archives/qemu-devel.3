Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972F9CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFAv-0008Be-R7; Wed, 29 Apr 2026 20:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAV-0007s3-R6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:22:15 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAU-0006c0-29
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:22:15 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8296dabef74so326047b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508533; x=1778113333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QG3SAWZXTLSfeqfkLdTcj+WQldu34LGY3+/Bb5YVXA=;
 b=Fe9lWuytxuIqwnojX2OiNIczR7vhZbb8kM2HCWDpoBAP6qZ9PkycJZUARoNEgrX9J0
 kT82zHsjtfrsivBnADFVUydB2FP/WT4Od2JWFmQfz/QZ2bkwybLKAYJsEmytLhawd//k
 1m1LFVnq7KVRQKztNDYczqXJhF9l7424Puvon1ejjK7l6cMw3J74sx135CtgHKglT0w6
 y2j46epA/GX7XD9ZqyiVS2qjDjVpoU8+GiB4O2Uz6IZW8vew2RL3SLtkycQUj91Z+HWs
 efDuOiQlprXs7/Noan4PRmfzvG5X3X5i4/9D2SWUAN9LO913mhGmBF/UP8+qnNwICg8e
 MNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508533; x=1778113333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7QG3SAWZXTLSfeqfkLdTcj+WQldu34LGY3+/Bb5YVXA=;
 b=I6Cj+WDWAx0nYO7aRLJa0wxnn3c3hwph+J1cHfKWbnbzpne7HvAQPGwlxMnkiETstC
 /2ypeVa/s+a/rASQeXPvVlj42gMFQJdpD4MT9SgIoxaaZpC57v0IWBKLRcIoMwz7R/vM
 50MFv3Pj/OJx9R8wBnW8Uu0leL8pb0viPFNnFcsTrL7WHnUUwAa27iL8VjpvgX2I4t3c
 c9ixiY520G6v3pn4BYJdnDq6UgAN9wJ+sKvKe7wqtr2z4gXXwyLL3lU3JS5f06JE6gi8
 SkbPRO9Wp75Hm8xpfh1Fp4FkAGL3x7SJmmlFNs6ecX0FB0yXKXY8iDPdaSUuJkdQUpGU
 MsRg==
X-Gm-Message-State: AOJu0Yz0jyT9A4PLEaB+byafKgC+QehmYsoor3R68qbcQwUB5Q3B6vCk
 sRgbcigArOn5DgeYD0ZbDDQH4NORVgrdZ0quPbB+g3WB4P/XeFbH8g4BJhieOQqz0M8+P3qXMDQ
 6n74em2g=
X-Gm-Gg: AeBDievWlGUxrAppILKqBp0/+e2FRxXA4VaPFo6gq3Du5p3oM1rYGVS/rfhPUvZnYMz
 hWYZaJlKYhJK5yZDLuAraKar7O7WfQ10xmrJMP0e9XRJFL3FcKLyeLJUbsAzFviy/uH/q615Zs5
 j6p0ZdsaojjSzHskiGQEi8DRmU3QDCRBRXGTMoHC+ghBSZ1l926kK92kUCvCuetrsLSmFyoP8O5
 unHzpcnvrmkNmCqfEoxeOxdBm6nWgM/yz7GP9kuxNGepZ5h8EXZc4GVT1FpbI58F18WJvYVetfh
 w9eM5PSrulgg2KFsNqPjyK6UIh+OgcA4eBrKquUSHJFV7caIHiDi9vl18WEBNzUmmi4hz0MpmoC
 uYfUEzyFSeM+WcxtkIHFMObrcR77L/6Z6K4eFNAG4IF03fgyVc1Uo7n1WUtWZDdinHgqBi6duIf
 lTjETRw4lgH5e2eKGO3KIczWGpU/eFo/isVMDizmLj
X-Received: by 2002:a05:6a00:1a86:b0:82f:623f:e5b3 with SMTP id
 d2e1a72fcca58-834fdbd8f0amr798455b3a.34.1777508532652; 
 Wed, 29 Apr 2026 17:22:12 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:22:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 37/47] target/arm: Enable FEAT_LUT for -cpu max
Date: Thu, 30 Apr 2026 10:20:36 +1000
Message-ID: <20260430002046.59739-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a377f67b9c..bc866c5a67 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1263,6 +1263,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* FEAT_CSSC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* FEAT_LUT */
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 44c7196d09..cf8771d541 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -101,6 +101,7 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LSE128 (128-bit Atomics)
+- FEAT_LUT (Lookup table instructions with 2-bit and 4-bit indices)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MEC (Memory Encryption Contexts)
 
-- 
2.43.0


