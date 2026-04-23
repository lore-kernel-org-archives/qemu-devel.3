Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B425F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquW-0007Ag-D9; Thu, 23 Apr 2026 06:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtj-0006TF-Bv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:08 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqth-000287-GY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:03 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4411e1eba51so3072003f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938580; x=1777543380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jiyQOt8Idv0DVCCbXBGrIdQrWUe5DIPWOUWKcNILS1U=;
 b=GecMn9lyOOCqj98cJYuh3XEJ5kvV4GsjyQ5j47EoZsMNxTOIYzWbAwNmvZzWm/Jqdk
 VZ+IwjKPaB1Zxgw2AIeWNscG9y9ZRLMxdEmBX2ToydbEzZkehaiTWlijerVFkd6ob2Ej
 cuEvrVcPGqmOKv2I+LbiQvuCC+VJbSmMRlD3ofS8/j/f8V+9bB96C7ZGeRrGfSxDu2H9
 SzcyyiN5K312ZauQfTIBLiHXwKjGj61DSQJV5M3fYJh31FG+Ta3tBeW86QSsnGb77IUv
 wBBa2Jp0+MmRmLXZCqZ7tCehWzn2AJCdimPIldCWwRfFhQNIP31Z4kQPNGGUsgIUuyxU
 hkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938580; x=1777543380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jiyQOt8Idv0DVCCbXBGrIdQrWUe5DIPWOUWKcNILS1U=;
 b=SjJrBcKRXAvI4dYMil4DiPUysVAclwRj1a0gS0nKJM+RKeN0UoVG3U+/vp7cD7PMZ7
 01pqy2xCfVBiOOrThykdLfU9hI5/pWBACDDMJLa2sYO0ZCLcZ6Rotg7cSSLMVZ/Kpi/A
 lXzA29cNmb0xIr7n0QswMJT0BkTYa2pVZzggVncMwNz1LsOepV83pzHO02gXfBAwEJ92
 MUoT5CmwcvdReCzgB+9VLkUJxrsZx4daC4INxVTOI09j0XGUcAsTVhsLzdVaF51fibb6
 91yeHES3fSL9UQATxhVJxl1BFRjlT8/iHXFRyUCdcVCIwI/6gtzeGCQwzWpu/Lkph8wj
 zeng==
X-Gm-Message-State: AOJu0YxvG/Y80/CZr2fVbtKPMLCjnCNrnmlkyAQz5RE4NVRhcn5XbNHT
 vyoIJdgge5Gzyx2IGmlpUw+2N+s3Sz561gFY2uONGmfyaH38QBItPo4xcJvk06k4foMYhQO8aoy
 bafMc
X-Gm-Gg: AeBDievz9Ac9GCTfwMquuiNeZKy+GtPuQPVFbV54hBGAPa88a1qk/dr3G1YmfLzNhq3
 tcFTjKxVrpbIamclKYE351N1dSoqGFNzU4D6iFBFtftKoHFklSD+9CldEkUgDWWzXfHNlDsHjg2
 4s14hCRtO6Luwc6XgAk5RKy9PQTXspIJwXDrrRNLdZfuJUCTsjFv1DlaYClbE3KQgfEbwtRnTSN
 WQ1a9FTkaPv+Rh0RVDjsBsm9fv/a25yrCaIcPbFbNDJyk+cQ+RokqAfcB49PUNGj4zzfwvldixI
 0YqaiCXS4cpXCXIYW4gAMi7I/RHWw+FbET6MBfb/QfHpO+6UhWIZkOGj3iQ5zvhxokl7onkvNCd
 FUinK5AE40mzQSKG2BzeftBVUOAidINaW5F7Ui9NWu34o+zcD+vIazkj0M8rYVXDjQK1XICi0ZE
 1Ne6QcJJjw9vzJChSR0ipytFa+iAi/ENoU4BjxlJiXZ7JIRuct7lCoTNLsLVBu39gXu/GeWzq04
 0ExFVNbCQ5isEU8IP57/FyCkQtz99Ym7ONFP6+tJYUSRdvBeC57
X-Received: by 2002:a05:6000:1acf:b0:43d:7946:bae6 with SMTP id
 ffacd0b85a97d-43fe3e236c2mr39770618f8f.43.1776938579888; 
 Thu, 23 Apr 2026 03:02:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/59] target/arm/tcg/arm_ldst.h: merge in translate.c
Date: Thu, 23 Apr 2026 11:01:56 +0100
Message-ID: <20260423100229.2941820-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Only translate.c uses those functions, thus move them back to this file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260407222208.271838-18-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/arm_ldst.h  | 47 --------------------------------------
 target/arm/tcg/translate.c | 24 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 48 deletions(-)

diff --git a/target/arm/tcg/arm_ldst.h b/target/arm/tcg/arm_ldst.h
index cee0548a1c..e69de29bb2 100644
--- a/target/arm/tcg/arm_ldst.h
+++ b/target/arm/tcg/arm_ldst.h
@@ -1,47 +0,0 @@
-/*
- * ARM load/store instructions for code (armeb-user support)
- *
- *  Copyright (c) 2012 CodeSourcery, LLC
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef ARM_LDST_H
-#define ARM_LDST_H
-
-#include "exec/translator.h"
-#include "qemu/bswap.h"
-
-/* Load an instruction and return it in the standard little-endian order */
-static inline uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
-                                    target_ulong addr, bool sctlr_b)
-{
-    return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
-}
-
-/* Ditto, for a halfword (Thumb) instruction */
-static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
-                                     target_ulong addr, bool sctlr_b)
-{
-#ifndef CONFIG_USER_ONLY
-    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
-       within each word.  Undo that now.  */
-    if (sctlr_b) {
-        addr ^= 2;
-    }
-#endif
-    return translator_lduw_swap(env, s, addr, bswap_code(sctlr_b));
-}
-
-#endif
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 0b3b4ab86b..b6abaff490 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -25,7 +25,6 @@
 #define TCG_ADDRESS_BITS 32
 #include "tcg/tcg-op-mem.h"
 #include "qemu/log.h"
-#include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 #include "exec/target_page.h"
@@ -6281,6 +6280,22 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     }
 }
 
+/* Ditto, for a halfword (Thumb) instruction */
+static uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
+                              target_ulong addr, bool sctlr_b)
+{
+#ifndef CONFIG_USER_ONLY
+    /*
+     * In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
+     * within each word. Undo that now.
+     */
+    if (sctlr_b) {
+        addr ^= 2;
+    }
+#endif
+    return translator_lduw_swap(env, s, addr, bswap_code(sctlr_b));
+}
+
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
 {
     /* Return true if the insn at dc->base.pc_next might cross a page boundary.
@@ -6515,6 +6530,13 @@ static void arm_post_translate_insn(DisasContext *dc)
     }
 }
 
+/* Load an instruction and return it in the standard little-endian order */
+static uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
+                             target_ulong addr, bool sctlr_b)
+{
+    return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
+}
+
 static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-- 
2.43.0


