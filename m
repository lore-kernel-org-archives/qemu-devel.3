Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD73C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 19:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlYPY-0006LW-Vy; Fri, 21 Feb 2025 14:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlYPX-0006Jw-HH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 14:10:07 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlYPU-00046D-Gd
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 14:10:07 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4398ec2abc2so21555505e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 11:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740165002; x=1740769802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=psLz427g16MJMWGLUupBo7uTcJrzhpucl+zyFztvGko=;
 b=evOd6rypVOoh/RUOIn9UrTHnoAzmIIPft/1d2PLkgQ2jc4RtCHyOog87Q7q2JxKO6u
 fbdfrlc/fnyT1p34vjPWRNPw8qIB5RDHjcuV5czzCmKRBKnedniRf6G4iUX1rMWIki3O
 zQ/IrDc9rLj+Cyqq6h74wZ+l58kU72BNXAzZ3mj7ETQoWnA44EKMlw+QY9PX1+CnyjS4
 N8gjvc+o9PLWM7GQmvSnd3vN3XUNUuF37APco18neSFrCxvZKwl55rrWZX2ULNfmXPuO
 UYZnp7/7EkSogDZPrrsYvtGug20/JybisKHgFMdVFY2Dm2wDqF1ESDWdDcXUpkAKVu+D
 Qh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740165002; x=1740769802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psLz427g16MJMWGLUupBo7uTcJrzhpucl+zyFztvGko=;
 b=T33bl3CgNz8aoUNDYE9MfxqD932iC2RlcnDK6QtovdQvbbSdcJya6kMbS28Tc9KWXa
 5Th7kGmpV0GTa9hWNGDhtMn7Zf8pegNlQiGoEpjqTy0vt5mysunCwtG0VZVhHq870wU9
 VHhpCOQJ7kH3gEpl4fjyYnF8Nd24k/4Dt8v7oBbwMnO7WnT9S7oBBXrwLVw5lSd2AWcF
 +qQVMP7oRn3UDEpBKSQNeZDy9LZ9GmXE6iJw6BuZQ4HQLKrC7/PEqx54BwaWJp7oW+CM
 oi3aU8PvxPw/03TWAqhuqm/hYq0lKkj9Rs0H3lUyDeJxbiJYrGsJg9NhXA5BRvRbTzW/
 0mYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT/dQS9fB8IKYzKwfwO6IIcSv/EuGTfJV+Mb0V6dqgAMtD1HJPrGLgcL1zFYDBmnjB4KtzIpVGEsHU@nongnu.org
X-Gm-Message-State: AOJu0YwEP6r/KiUNXKsDC1VEu7+N5pMqLCR/LxOq1BMx4X12rzI9TQ3X
 OEB/jmICbm7IgaQu3sMppH3AbGpLOw5l8VZoGbgS/aTagI2AuPmymjKkMtMrcuD+hQqnNih28xm
 k
X-Gm-Gg: ASbGncszBmrNNpPpErJ37VF0V19Ms7BC72AWg1CIqOgQkrnmIB+3bU0kQf6OQtQcDfx
 i4V6KSm+PnfqM8mEyuVKeE5k8ftra2pLuFAy+rRmA5Pw+iNqE9t8G+jt3rGHnkjbDgjna/JTLOH
 MYvbRnqMmyN1CVb/hXGQWUMS7qHf+c0dbTtGrKZCHBFBAAj1oqmqUrecVzR/l5WF7BN5G5Lnvvh
 aLXZbJiWZfjgC52V93Nb4YTPzIRVinjWCisYozgRl2R8zYBg4J8QjF9ZvrfFtvfnj6orSQkzuuC
 mLb9bBAPHak4mEHiAkEr2eEQGmYXVpE1
X-Google-Smtp-Source: AGHT+IGY1EdmwGAjjKX6WfWeG5dj+cOiMlpb4S3vjx9XbHYYOaOSAWHaDJaCO0FmhBYM0EUSkAZPbQ==
X-Received: by 2002:a05:6000:1867:b0:38f:4fa6:68df with SMTP id
 ffacd0b85a97d-38f6f0d1fa2mr4328488f8f.51.1740165001845; 
 Fri, 21 Feb 2025 11:10:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddbe0sm24392478f8f.39.2025.02.21.11.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 11:10:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/4] target/arm: Move FPSCR get/set helpers to tcg/vfp_helper.c
Date: Fri, 21 Feb 2025 19:09:54 +0000
Message-ID: <20250221190957.811948-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221190957.811948-1-peter.maydell@linaro.org>
References: <20250221190957.811948-1-peter.maydell@linaro.org>
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


