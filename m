Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2E5C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzLU-0004v4-L9; Tue, 25 Feb 2025 13:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJe-0000DU-W4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:59 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJY-0002HS-UB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:57 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso60289185e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506738; x=1741111538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9tK7aZMwwxowa7tqyYPjyzaoV+MdzmwMZbJPQFTnklQ=;
 b=ylyPd7HPFm6BRXnw93+f9IllEESEf6XC85UgHdr/mhKJli5DZgRwsTKfUhulLG1Mmd
 5kUf/wQgkIfFSB9TucVg6zUTWF//8ZJmKj2DiJ2NSYh/8Z8zEFeu/WMQyqbCKcbuaf72
 WH4iYrbH2TS0Zu5njHJ0PoII+Bo+bEI+qkdvOT1526OzOimn8TbjoVLUhd8+p0i9Se1e
 6h64mij0Pt0rUyLlxBUc0bHqn8ZQrUYYytr4BNvyavaj0q3l+bTQigB3r8sG0HMbbBQV
 EmQ3ru/ReIEAY9iNcHTJE0bEn6PMDin8s235phP+NuOAomC31m5pw7bYXxC+AhnIsRze
 OEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506738; x=1741111538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tK7aZMwwxowa7tqyYPjyzaoV+MdzmwMZbJPQFTnklQ=;
 b=RvIrW/73BwG1ZJUcVtrSWgW8sCgN6qjPByRZVqLnsExOxGJpneZs9dgrjZYxT6tjQM
 2Bg3jxjflDoSEQJo9v+J44kiUNmkNKAqDSbpKnCmHxVBO5UQM87pQcJqjWby9B1aZ7D+
 0QNuaNc1PE6MqeI63oXkkDjskwPXAzsCx+J4bB3ZcXOLcEqWqJADA2Upm8lw8fpuqlGt
 Tg91Cl7CMFA42mSK3LPDSvIeVmhBACeQv5TONu4h5gqFefXci6KSX2wbxJCi6GlqZCgu
 j1qTMKewRXH2J77CPj7bloOS7pNuz11e9h1iW2eUbmyu8kaQfrQhc2MM1Ih+g1NmMgCu
 SCjA==
X-Gm-Message-State: AOJu0YxKQ7J0i/8nWlhS2jep7axD2OJWVDlFMBWVulX8UsntDj4HLkZm
 NJQQQm2UGdU2a+PUCltRY7fYo6W2+H33Pv5fjNn7fxzHm6pzXrUs7fhPcYxNWomsHwBXLn67fQA
 7
X-Gm-Gg: ASbGnct1ALyL6SMW8YAgSZZqOCVFt5EfMzwrzUIwAoVuEul1pELLkaz4btEJ4I0z5kT
 r9l+5KYXi4cD+vUCgypY+ZQk1gHgaMzPcHjBht5dCTiLG8zacrn4trKxDsQFr5KNefFjoRsYLsv
 xZU4yo7xzeGFwu3DV+PmepiyzIzxRAoLWzAVZr8wrbptUgS9oXiE+amzqSu6sA+Km2/wEnsl88s
 qKW4YkXaG7DFe5AiOBYDA8eKSlhpS4R5YxBw0zi2PKOctMT4Jd1YRiOZeS6d5Oaoi0SYUhJAwPR
 Xepx5HlHMWA7ATX2i2qC9FvojSI5wSZW
X-Google-Smtp-Source: AGHT+IEwWzlKoU9kJioXZxWrVk5kEggJUgOqVT4wYyDPRSaQVVuYv6Xc9mdCUQ1T0kj6712JM1hH5w==
X-Received: by 2002:a05:600c:1ca9:b0:439:94f8:fc79 with SMTP id
 5b1f17b1804b1-43ab7ae46efmr16915755e9.0.1740506738204; 
 Tue, 25 Feb 2025 10:05:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/43] target/arm: Move FPSCR get/set helpers to
 tcg/vfp_helper.c
Date: Tue, 25 Feb 2025 18:04:48 +0000
Message-ID: <20250225180510.1318207-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Currently the helper_vfp_get_fpscr() and helper_vfp_set_fpscr()
functions do the actual work of updating the FPSCR, and we have
wrappers vfp_get_fpscr() and vfp_set_fpscr() which we use for calls
from other QEMU C code.

Flip these around so that it is vfp_get_fpscr() and vfp_set_fpscr()
which do the actual work, and helper_vfp_get_fpscr() and
helper_vfp_set_fpscr() which are the wrappers; this allows us to move
them to tcg/vfp_helper.c.

Since this is the last HELPER() we had in arm/vfp_helper.c, we can
drop the include of helper-proto.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250221190957.811948-3-peter.maydell@linaro.org
---
 target/arm/tcg/vfp_helper.c | 10 ++++++++++
 target/arm/vfp_helper.c     | 15 ++-------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index aa580ff64c7..cd6e0d0edab 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -1128,3 +1128,13 @@ void HELPER(check_hcr_el2_trap)(CPUARMState *env, uint32_t rt, uint32_t reg)
 
     raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
 }
+
+uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
+{
+    return vfp_get_fpscr(env);
+}
+
+void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
+{
+    vfp_set_fpscr(env, val);
+}
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 0e849d8d4dc..0919acb7b89 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "fpu/softfloat.h"
@@ -298,17 +297,12 @@ uint32_t vfp_get_fpsr(CPUARMState *env)
     return fpsr;
 }
 
-uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
+uint32_t vfp_get_fpscr(CPUARMState *env)
 {
     return (vfp_get_fpcr(env) & FPSCR_FPCR_MASK) |
         (vfp_get_fpsr(env) & FPSCR_FPSR_MASK);
 }
 
-uint32_t vfp_get_fpscr(CPUARMState *env)
-{
-    return HELPER(vfp_get_fpscr)(env);
-}
-
 void vfp_set_fpsr(CPUARMState *env, uint32_t val)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -402,13 +396,8 @@ void vfp_set_fpcr(CPUARMState *env, uint32_t val)
     vfp_set_fpcr_masked(env, val, MAKE_64BIT_MASK(0, 32));
 }
 
-void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
+void vfp_set_fpscr(CPUARMState *env, uint32_t val)
 {
     vfp_set_fpcr_masked(env, val, FPSCR_FPCR_MASK);
     vfp_set_fpsr(env, val & FPSCR_FPSR_MASK);
 }
-
-void vfp_set_fpscr(CPUARMState *env, uint32_t val)
-{
-    HELPER(vfp_set_fpscr)(env, val);
-}
-- 
2.43.0


