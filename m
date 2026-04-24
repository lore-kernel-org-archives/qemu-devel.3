Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E75FB44A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8DG-0001e4-85; Fri, 24 Apr 2026 00:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Cu-0000XL-J4
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:01 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Cr-0003A6-Pr
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:59 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so5593442fac.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005116; x=1777609916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvhMkH32psM3D8lph3Pv20uEhqe8qrK6g7LCI4lgg/I=;
 b=kErJXbt2hlwvbYYGo2PyowW7yavTggaYl+IpQ4MiDfPgREim6T1lQ1Tb+bNocNIY3r
 5CekK/psCBjs0EFZcHEh8RQqvPAgpH76BrRRJJkQIvF1T4jMFmdaVwLUYNm4Bnuad/g1
 IzPJptCkq9i8vyqwzN3S8FKVJonYrJBLIWP13aBwZYoCZZETU/lWGdx/z5vMtVHRqoh/
 pBIqpdB8KsD11ad81tETfxEYnQzeHfcizzoyDBb2SJWprVQctQmpW6nrwrAbB1687CvX
 RTYcv191PG3Pv7QOdCMe1QfTUBYBGqR0eO/TrFQD9AGE0sVHgDR3Dk5bYda90HHaRcpW
 8+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005116; x=1777609916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VvhMkH32psM3D8lph3Pv20uEhqe8qrK6g7LCI4lgg/I=;
 b=pxzDwjSIHitjymPGkTzypgk+ZgE8PRthslvfYCP1gn5JLqHwTWGBkxY2mvbPcBwC/V
 vMwhW320+arZSeUmeNH4OI9LkU4T8sVoLfXAIOkPjC/brB468RPBzUzchMKH5Hpphkah
 6frB/ldtpvpylUw9JvDD2Z1Ygvxrbh79I57M/q4v8RRg6LastrE/+gYN0N+VskBo95Tv
 kQ832OtZTwDRJXZRIEwOEttMik1CroNk1PaOV+ir2RAUSPcPxTJqPwP9/0sOT1AyhBiM
 Ycmo6QOVdhSnaLeit47xV00cz+iD2bmfyYOa3uGj5CdiVWWWhkGNyiv0iNYcmDHbjaKh
 HCjw==
X-Gm-Message-State: AOJu0Ywy/ZQtOxKA3gpagnt/wYbqMuIvH1aDcoSEVviJ4Q4ulIae7PJP
 Thg6b9rPSIQG2oN9YaZHZUyI0k5udJ66tbq3MPcLYP+XtcWZso072k3QM4k6zYo3AnJc7XMtHxa
 Nd9OzazM=
X-Gm-Gg: AeBDiet5OxqoiStc084Y0PPKRfG+Tldyh+nLt3G4Gom63PbFS8nX86HXNPrP1LyKRKE
 R3eUyCJX8bB+fXLfiP1Ox62h9KnvtBmsZ1lGWqjyAgasPIzEGGijwT60cGYo9HW5nTbCWJb8UwR
 +4v6FkXIcS+Gq8+WvqeYxv4xakqTwfJesL7W3d6HtH8xovRHzaqhjdxk5ZJxm2UiHlJX5DGvGtR
 vfXJBe13/wI8RcCa8Ks3RM+wAKhDH0JI5AoCfK2q2YnzwIhD3RQaUpHf6K3HsxQeIYB8QOl5MVl
 PbrdpPERPIFrCJCXPr9qIkchlv+nRjS4I1tui1l3gPUEEoVHO6ZSfgsfD4Q9y5g6Q03jk/5lq8S
 oZpMjxjQIzcllogh7L5uZv9+df7BkFF8u0Ylpk+mcAu4RdYIbb9gYicB004/LbMDYaNQv9ZntRj
 Eid89EVDLw+0Efv8R0wo96e7GrHMVjmtfSTUX2kJs6msacnFL5bFsHavpSosz6Ng==
X-Received: by 2002:a05:6871:e405:b0:42f:beec:92d3 with SMTP id
 586e51a60fabf-42fbeeca16bmr7202572fac.14.1777005116502; 
 Thu, 23 Apr 2026 21:31:56 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 22/40] target/arm: Move vectors_overlap to vec_internal.h
Date: Fri, 24 Apr 2026 14:29:56 +1000
Message-ID: <20260424043014.46305-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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
index b647399b18..dbc098d49a 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -21,6 +21,7 @@
 #define TARGET_ARM_VEC_INTERNAL_H
 
 #include "fpu/softfloat.h"
+#include "vector-type.h"
 
 typedef struct CPUArchState CPUARMState;
 
@@ -461,6 +462,13 @@ static inline void depositn(uint64_t *p, unsigned pos,
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


