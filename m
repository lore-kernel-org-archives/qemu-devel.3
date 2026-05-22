Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF9ACD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXzF-0001pO-7i; Fri, 22 May 2026 18:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxv-0007lJ-8S
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:37 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxs-0008KE-M2
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:34 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3660ab73adbso5591566a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487410; x=1780092210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7LrqnCZWislAjdzjKOxxr1dhsIsKTHY94bIvQqnEMg=;
 b=i3+3pyg1IqFkhe4cmv+5izlUOFLyHjcPaKvZCPsJX3vFoekIYxmFGurcS2xpeZtQcP
 BNldijV4gqgcYbPjuRBLcuqIsTLbKc2GwZiazXQF+zkwN1P80rKoLSqUnHE3qZsTq5se
 qHCwztSSaX4bfPWtNSuWRd1vs4MqF2+N/gWYNim4F/EfFVB027gvHe2+cFikWKuT3F8g
 Ppj8S9IPq568GmCBqx8xHkmnaEMWXrOo6GvvdecKKTeRvKWdihuQ/lP18GeSojDK8K3z
 hegNntbhdXRZ9Aq5s1cbQPrwjin/nIcXrgl6vpSuPMuDZz30rVd5gWG54C40Cbbx2GVF
 O3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487410; x=1780092210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J7LrqnCZWislAjdzjKOxxr1dhsIsKTHY94bIvQqnEMg=;
 b=Sx8jFTRN8xHRzSCuZqvdZL78IywM5C0bmbC7hoa+g3GZ1kPw8ungX4AlXXFcGrrHh0
 3aKN01iwctkK+2vDhHtOhqtFqMFTgtjCAggOtWB508lAubSw6U38l8bER3LHx7JCVLDn
 +aP4JDHWgUm5zsrqe+WN8zYIAN/lOgOdGIIe1wGXnVAbzfvDtK8mcWb4JYVimaeOMvp3
 VPc0fHLJE09hnCKkU32QnpK4PMBWZxQPdRiHMdQJJ/mkPTSuE9lBBMpAVd0MOTVHGAcB
 cc4DocPgcioIb12mzbrIgAVdq3eY8IE28FZpImryOSdouTcPUqfeJuUpMzJdMTyNZ32v
 As7g==
X-Gm-Message-State: AOJu0YzMwbU5eKDu36KlDDw3hmYj5Rbd2KKon+sXALKDBl0Fd7ijM904
 FTRGuAVZSFF/ziEOR8Tl2IS9CMX/V/aWKr1Vl6xXhlOcjar2XQ4uCQzEMGulrTOYHI5eueqnJrc
 eGU4q
X-Gm-Gg: Acq92OEti0fhGpclpKBNDbgWnEAkt8MJGhG6mQIdwpR7BySpHC8Okp+oHbzpvH8ypYz
 pAyEpEbD+IaAJAI9RrEK9/zQ9r/n8c6ZrWeOgSjcvufpokk4bvAImAmTB+zZTEQheRBXdBymCQu
 8c8SW4LpkTnV8r8Ro8D5t7UlnvauN/7uHVlp7pn3ZB80EwPBKK3HHUwIoh6RKH0TCrsFT7s2JSU
 nBFnAZTMa8NgG/woEOBmL3L6Xt6S7AHMjf38tn8nGBIeZtvzeAZpaqfLfcrxrGfrlhNOlbvx2c/
 Aq8HhQ0H1xq86s2fH5aMkyjiYl99MRTikNWmVKUBNIx7xQ3o6Z32oQrKuArZHIsC12G7sUup7Qr
 VzWGAurM4lbtgEj9Hvse5kwDe+au97oGSapoNVtAiVvjXcjT3xF/qg2ZpLSdlH57edTBf13QeKJ
 y28daWlQ/i6XpxmFe5IfoaCQeqqpKz
X-Received: by 2002:a17:90b:1d44:b0:369:7944:d723 with SMTP id
 98e67ed59e1d1-36a6bb5a6bfmr3524077a91.4.1779487410430; 
 Fri, 22 May 2026 15:03:30 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 23/64] target/arm: Move vectors_overlap to vec_internal.h
Date: Fri, 22 May 2026 15:02:25 -0700
Message-ID: <20260522220306.235200-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

We will shortly need this outside of sme_helper.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 8 ++++++++
 target/arm/tcg/sme_helper.c   | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 758e3db1c3..84f7f15228 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -21,6 +21,7 @@
 #define TARGET_ARM_VEC_INTERNAL_H
 
 #include "fpu/softfloat.h"
+#include "vector-type.h"
 
 typedef struct CPUArchState CPUARMState;
 
@@ -463,6 +464,13 @@ static inline void depositn(uint64_t *p, unsigned pos,
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
index ab5999c592..0055e97a2b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -33,12 +33,6 @@
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


