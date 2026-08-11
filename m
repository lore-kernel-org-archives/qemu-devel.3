Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A699C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteXJ-0005VX-47; Tue, 11 Aug 2026 00:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXH-0005TU-G7
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXF-0002o6-Og
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2d004f135b1so5127235ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424180; x=1787028980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=znaicsl0xu9NxwW1ItNiJYgK2axSlmGzwZKRBjMfMJI=;
 b=PSl0dUO7RdPOCt1QAYSEjF2rkPSKet+Juf9MUHBIoPE/sQUenYgZ6nQXC1ELjOMnRz
 f1diS3Knt1XxRgsP5aIW5+WjunIeU8Lwzs4jnB9DsDHo8LU2SO/s3F4JAUfDeD9xSJIi
 e9enyWV21KTqEkbeR4nLoeuCyzK1grnbeEPAXBJ+nmBpZbgD/OOUY7C5xVQxVji0uxjM
 /NpZFu3Jic2Kt9FWdMxUZDKlaz50hRi78d+ju+mrBgiJ/76vKWBhBgEYoyGbVYIeS9Sa
 t6njSTlZxmfvKo9vGe+1C4p3EQXYa7RxCNdbSm+z+eQGPe/DnfdOvKsndh5pBbnix6gv
 F9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424180; x=1787028980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=znaicsl0xu9NxwW1ItNiJYgK2axSlmGzwZKRBjMfMJI=;
 b=MgTZNIqxAsinRR5v7L/E79Q56yy2L/PgOGg8RSpqgTFRIWuHVS2NGRIIZ2XYE57jUm
 Trklzu6IzbEzdExTOHUg0VHyF1Hk8wpQJFqMyH/UJWp6Z0e9Iqp0/w4LyOkt8m0xJUvj
 jY/p1W7jNY73eBNxX/NVzbTNdDY92grl59wBKV0QJyzJsStJrzoctgKke2P8Q/aggoMW
 CL7qFXiimrI2yhXskZTQxwUZ6U/VjhhkOO84EmF7OF7KYYZ2f6/e+TMp1qwJkHswNbh6
 gZ9rOzaQh32V6Me6Z3lyQYe6W9q+ze1XzJFuqYrA5AMzejDP/BO8gDtpvRMuwHNn5Vr2
 Kciw==
X-Gm-Message-State: AOJu0Yz7XWtK+ahxJaHRjg3OlXR3xQ9+aFIPJzEUbDfu4+J6gyahYWZ9
 hsflhBI2w29o7640OJ4PCW/p0cLTIcmYKIZ0CxVSV/tQFYRtmuY6cXPcOCixQQyGb8BKsSb7dr9
 08Aij
X-Gm-Gg: AR+sD10dTGkcNykNDx7eYXjfMzAKeBm0eF+e2I3Q/0znhlAvNeyXwzfJzdtzBL4I9E3
 E9AJq4OUPHbOrlit0M/YXHKo8nSPjDhmpoFsICH3sAg9JP63IGg0OGfeu+luNFq1b/BZs1R+jwh
 sk3qeVMG2sMqpDLT7EMZarh1fPZBHL3+MiKU1u0EyT0l3aabGo+Y+qTsCAITFrJSZSwi+xCKeFU
 8T75Gfa8GF5eFzl7tb3yhU7Snu4BRH+xf36RMECbREMMucWD/HG6p5PyJPThC3vuqGx10UQ+SBw
 nHRAjClCymgHQS8rbJi9FIpFDluSZf8Y8cvPdOXyzHn97T2fvYU0ubwWvKGFcwzjdWg030rGOfu
 3gnjS7hd97Wejg6HLqGyQrMWjBEfC/L2nc6ZneL/L+bgjU+LCf+NM4fD2Nj35yn3pp/sT666UdV
 VHIdPcduLoOviYWj98+h6s4Ibva9JtAv0W++Jy+WWq16OmdFw1BO1lGfOr68mMwfDnGXGtDKt7G
 0AtWv/Z/xEZBrLEsi2CiVxCvrlnHvA=
X-Received: by 2002:a17:90b:4f92:b0:38d:ec31:4840 with SMTP id
 98e67ed59e1d1-392ec60be4emr655096a91.13.1786424180090; 
 Mon, 10 Aug 2026 21:56:20 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/16] tests/tcg/loongarch64: Tidy test_bit.c
Date: Mon, 10 Aug 2026 21:56:04 -0700
Message-ID: <20260811045605.1246543-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Use one macro for all test templates.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/loongarch64/test_bit.c | 69 +++++++-------------------------
 1 file changed, 15 insertions(+), 54 deletions(-)

diff --git a/tests/tcg/loongarch64/test_bit.c b/tests/tcg/loongarch64/test_bit.c
index a6d9904909..69b2eaac78 100644
--- a/tests/tcg/loongarch64/test_bit.c
+++ b/tests/tcg/loongarch64/test_bit.c
@@ -2,62 +2,23 @@
 #include <inttypes.h>
 
 #define ARRAY_SIZE(X) (sizeof(X) / sizeof(*(X)))
-#define TEST_CLO(N)                                     \
-static uint64_t test_clo_##N(uint64_t rj)               \
-{                                                       \
-    uint64_t rd = 0;                                    \
-                                                        \
-    asm volatile("clo."#N" %0, %1\n\t"                  \
-                 : "=r"(rd)                             \
-                 : "r"(rj)                              \
-                 : );                                   \
-    return rd;                                          \
+
+#define TEST(C, I)                                       \
+static uint64_t test_##C(uint64_t rj)                    \
+{                                                        \
+    uint64_t rd;                                         \
+    asm volatile(I " %0, %1\n\t" : "=r"(rd) : "r"(rj));  \
+    return rd;                                           \
 }
 
-#define TEST_CLZ(N)                                     \
-static uint64_t test_clz_##N(uint64_t rj)               \
-{                                                       \
-    uint64_t rd = 0;                                    \
-                                                        \
-    asm volatile("clz."#N" %0, %1\n\t"                  \
-                 : "=r"(rd)                             \
-                 : "r"(rj)                              \
-                 : );                                   \
-    return rd;                                          \
-}
-
-#define TEST_CTO(N)                                     \
-static uint64_t test_cto_##N(uint64_t rj)               \
-{                                                       \
-    uint64_t rd = 0;                                    \
-                                                        \
-    asm volatile("cto."#N" %0, %1\n\t"                  \
-                 : "=r"(rd)                             \
-                 : "r"(rj)                              \
-                 : );                                   \
-    return rd;                                          \
-}
-
-#define TEST_CTZ(N)                                     \
-static uint64_t test_ctz_##N(uint64_t rj)               \
-{                                                       \
-    uint64_t rd = 0;                                    \
-                                                        \
-    asm volatile("ctz."#N" %0, %1\n\t"                  \
-                 : "=r"(rd)                             \
-                 : "r"(rj)                              \
-                 : );                                   \
-    return rd;                                          \
-}
-
-TEST_CLO(w)
-TEST_CLO(d)
-TEST_CLZ(w)
-TEST_CLZ(d)
-TEST_CTO(w)
-TEST_CTO(d)
-TEST_CTZ(w)
-TEST_CTZ(d)
+TEST(clo_w, "clo.w")
+TEST(clo_d, "clo.d")
+TEST(clz_w, "clz.w")
+TEST(clz_d, "clz.d")
+TEST(cto_w, "cto.w")
+TEST(cto_d, "cto.d")
+TEST(ctz_w, "ctz.w")
+TEST(ctz_d, "ctz.d")
 
 struct vector {
     uint64_t (*func)(uint64_t);
-- 
2.43.0


