Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714FFFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaV-0004Fg-T9; Tue, 07 Apr 2026 15:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaU-0004DS-7l
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:50 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaS-0007PS-2I
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:49 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35c206f0481so5232680a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591987; x=1776196787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQL9Hl0FES8WTZXjDlYkXc+8OCIhCSx/KV6Dh9R+V+E=;
 b=EA5xIjAkeMUtwKuQptlDbPBPvQVCVnud5dR9rbXhtfam4mqXHWliB/XrLg1uttsL+I
 v/OD60ocwJKOSHNG5GBV22WUKMXpbJcuYMU7HaSWsxmty2ov8x76iIclVWhfQEng4cSO
 GGzO4wiTQjCzNUy2y46Vf905bTtnYuHuoLz9BwrPFQ3M0yiCJ1mBJwQAU41I/rjuhq1e
 Me/Tmq1QLfoiM7u5bX2A+Qvkuprc7uTml9dczhTDVq9b3KJF7wVv1YK4Hzyj1F16BQhT
 1vRNQ2/4c8uHC9KaqAJ5CydfVi5o/bsm0jFk3GjJB0l7dvjZlT1u28nfCKdMIWw/wLof
 xUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591987; x=1776196787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KQL9Hl0FES8WTZXjDlYkXc+8OCIhCSx/KV6Dh9R+V+E=;
 b=Bq3sAjqrAOUKtbVDeuoUVZxS9fxGRwF53KOMLDcGWF039R3G8WZl0n8jfxM1B09RqV
 fsRXjXucqhudiimUZ/C/CwqpQJTyc2bhYvOdZJH1YUjC3+o2KtzUilbIwoemFvRI4IO5
 rHYZNdibqWS6kquAbGW+avCH9rMLA1FnEAa4w03hUewjNwyFj6mUzKi/FK1V0ELTfhJz
 weuYjH2h3L7A5c0VIRRdb2fZ6Zc5LFWWmrYNWKm03IEUfJvDWSOfG2kBZeJ7pjKVYhJw
 ZYhoZVIsLsMqDrDdE1Jefc1J03xjLXDJ65IRs2pnfD2gz6iXMheYRA7gDKUyoTd1uV9j
 CeQA==
X-Gm-Message-State: AOJu0YyC2xfxGbFsEG4kflEeWDtBRIYU8T6LfO4O2lC6zB5faJ+DjJaS
 7l6ibvv/DB57/lUh6MM23SgKRBZwt71QxqM7i4G7S1maMPAx4y7HRvxHYKFMysMBvu26Dtq7h2B
 hGxPIEbE=
X-Gm-Gg: AeBDietDb9khJgRjy4xBceGWadnKT3W90pUrqKOB7/8sFZedQUyykextU0IBysxTqcZ
 COSqiGxfpu+X/xyfZG/s1aj2/40o4XICDpbvj24tQGE1wClRe3mx0BybHKn/7vtmKMVAABw1xp8
 t4DfgxIPeIkrEcH4xrlzvsJiEFG6kc4Fa7JLoFnpOBjy21oWGj3IBQzAhIB2w1eGnRBY6ho3WGo
 3P/MY+Jiw5T8ZAgAOQMw74ksC7nzy3yt4yX1zkYo3dH+qSNd0+CcSsi2d8Jefh0tvwLZjBZL3zi
 4eGMqHvjQw/3QRBT3ozItzrkIfJXjT8kC9jc4hezJFPEYeCAZ7ch53X3OYMkThu7h8r+pI6teLH
 KmXCMiCf6YXJGjGgD7NjXkPhPZE/RP1OqNifEj0Q92lwXLEpxmcKtTeRezllXCsHkO4qMv5F2i5
 wjVdCnS8JOEHQmKJYn8huH6NcGPDieUfTh3TAysteCKgMuOKXT+LDPE/uYxojlpZeGldPjKBj7u
 qPSWjMUdb2tbRM=
X-Received: by 2002:a17:90b:5583:b0:35a:329:73d8 with SMTP id
 98e67ed59e1d1-35de67a0817mr16559057a91.4.1775591986365; 
 Tue, 07 Apr 2026 12:59:46 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 17/21] target/arm/tcg/arm_ldst.h: merge in translate.c
Date: Tue,  7 Apr 2026 12:59:18 -0700
Message-ID: <20260407195922.196410-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

Only translate.c uses those functions, thus move them back to this file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/arm_ldst.h  | 47 --------------------------------------
 target/arm/tcg/translate.c | 22 +++++++++++++++++-
 2 files changed, 21 insertions(+), 48 deletions(-)

diff --git a/target/arm/tcg/arm_ldst.h b/target/arm/tcg/arm_ldst.h
index cee0548a1c7..e69de29bb2d 100644
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
index 0b3b4ab86be..20f5bdcbe2c 100644
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
@@ -6281,6 +6280,20 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     }
 }
 
+/* Ditto, for a halfword (Thumb) instruction */
+static uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
+                              target_ulong addr, bool sctlr_b)
+{
+#ifndef CONFIG_USER_ONLY
+    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
+       within each word.  Undo that now.  */
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
@@ -6515,6 +6528,13 @@ static void arm_post_translate_insn(DisasContext *dc)
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
2.47.3


