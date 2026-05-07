Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0EBCD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OV-0000Qe-Lv; Thu, 07 May 2026 19:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OT-0000Oc-0i
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:37 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OR-00015l-BU
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:36 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso833318a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197474; x=1778802274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWru1QCIwOGhRVfqONB531T6JUAP9Yz4VcrPsm570nM=;
 b=N60e+rhs64XQOAfjXQeI7o9bTGr9rQBK4IzRCD/8pmayjWY9NishpVc9DVYhYnysu/
 qndCciYIiz215BD4TQpxmllSZBzzuicXOUpMfYY97+65bBMotee1rFOajU/qHTZRuTW0
 JN9RCAfCmr8CXpvdfPvWsut41ThcoW2Q9U7KQ+NkIVkMySrsdpM9rehPqRs8vtrWsNhE
 sT6UzIjBzYcI81xhuZw1Pg4T1XM/7qrS9vtNHDQTSi7HATmAKoL7SPtCiPYjta2/0QDh
 e0/CPqwrUrq9hiTfkngaBdtwkF5cOR2pB2adpUC3aU1OcbWhGIFBUvbxcG0p+FtrxPBz
 zC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197474; x=1778802274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zWru1QCIwOGhRVfqONB531T6JUAP9Yz4VcrPsm570nM=;
 b=CM8fGOfk+MouDdHfZc/KtF79qha3vse5YNiGtF0doPCFhyIcB4xbOqG3SN5Mc1GPVe
 hiiJER5yr6Aa3b808PYKzVJc+kcxi9DW5HyfkVIS8ByLBeVm0ZL+ufh2PjK7bUZ7NDtX
 WHah4sS50fc9PllrB5tsXiFz5OFbd/YUF/3gY2ikjWAuKieuS6D93p4MQzpeEguERn4t
 Kp0RVlYx1DPAYZCqJFuJfUw5tqjKuEdldKR8CdivcJcP53cb3723bhoBTnCQnLFyYrPL
 B899O2B6cugtX8q3pJMw54s07tyGnzirLYdJopxB+U0GZadrTSPNmNHvOj9uVOghiKXf
 GWvg==
X-Gm-Message-State: AOJu0Yy6zLDDU3mLjvHfK6N7u3kgPXUqF9s14XSs6B4oTQgc5CZIAoSh
 WgiHrCArNfTOxr6W6JHi0EirP/eC5CvtVcemg1Bi9kTuIUoABAE8E130aegZJ0/QpYQ5pqEGQOX
 UaPar
X-Gm-Gg: AeBDietCno2/b7pGNJQm5Tp6o3osL9iJwcQjebZkpLy/Ucudtxsj2JOlH+2cfqUVfKC
 Y8z9OrNklGh7bToP676IVn8jli3uy96d+93io2DWKxrvq6ITTpcMv1h2ykP4JmCDL963kE83rcF
 IHj0xTMpvMBr60Swt6IHFsWsV9WNK3GC0ExRewysISgFQp2QqLu4UXUCBgWJ6cOg1sIJrbOCnLD
 xU1X2dbmYgdcgBJR8dnEgMvEHZToj5adCNerbQge6C3MCcYlicxWSQO6XiT+BNBEewLTaZQrwI8
 aAh6wfMw6lIO5NHk7Uav7P5TQ0r3toWcx8n/M7Y0WwoPqxZzl3eq5jjuf/kNaFQqylg6p+W/13C
 X0jxYKZ1mScR63zCdAjywzCDUb3mzt3TQWyHSbrzju95ks7ES5jzwMMPXpKiTU5QzlZRRyHK7qd
 FAoaLw1N4n+Z2JBE2nWU2Osy1FWAneYE/Y2PGtjOVx8IYHcdbyYqCJ2CB+
X-Received: by 2002:a05:6830:b82:b0:7d7:e6cb:836f with SMTP id
 46e09a7af769-7e1df02641bmr6481206a34.19.1778197474276; 
 Thu, 07 May 2026 16:44:34 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 21/60] target/arm: Move vectors_overlap to vec_internal.h
Date: Thu,  7 May 2026 18:43:34 -0500
Message-ID: <20260507234413.643512-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

We will shortly need this outside of sme_helper.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 8 ++++++++
 target/arm/tcg/sme_helper.c   | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 68b1116171..b906d2a2e6 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -21,6 +21,7 @@
 #define TARGET_ARM_VEC_INTERNAL_H
 
 #include "fpu/softfloat.h"
+#include "vector-type.h"
 
 typedef struct CPUArchState CPUARMState;
 
@@ -457,6 +458,13 @@ static inline void depositn(uint64_t *p, unsigned pos,
     }
 }
 
+/* Determine if [x, x+nx) overlaps [y, y+ny). */
+static inline bool vectors_overlap(ARMVectorReg *x, unsigned nx,
+                                   ARMVectorReg *y, unsigned ny)
+{
+    return !(x + nx <= y || y + ny <= x);
+}
+
 #define DO_3OP(NAME, FUNC, TYPE) \
 void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
                   float_status * stat, uint32_t desc)                      \
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 16b96890cc..7ef6f5d71b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -34,12 +34,6 @@
 #define HELPER_H "tcg/helper-sme-defs.h"
 #include "exec/helper-info.c.inc"
 
-static bool vectors_overlap(ARMVectorReg *x, unsigned nx,
-                            ARMVectorReg *y, unsigned ny)
-{
-    return !(x + nx <= y || y + ny <= x);
-}
-
 void helper_set_svcr(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     aarch64_set_svcr(env, val, mask);
-- 
2.43.0


