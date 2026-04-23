Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C2BF99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtg-0006RG-08; Thu, 23 Apr 2026 06:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqte-0006Qq-Qr
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtd-00025U-4H
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso37566585e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938576; x=1777543376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qDefFzP6x4fZXVOqtLO7cnEFxusLKsm++Fb1g5MTiJA=;
 b=bJg3GUjHpb75mBhB39s6wu9k56DWgRgPKKPXCkqU+CBEatq/1sNghp68aCy16u10p1
 qK1CjCMbBXrwfOgo8RorF3C5/5hAXCv1v73pJBA13k1A8luWeyUSRxO7+2adBsUC7F0A
 V0v0cHocINmTggbZl5O67Ql568wGA9MgFfLM8HzW9mUfkV4WJdH/U80kmuLn2meZuNfk
 1BXPP5TPQvARe23TUbtvZLzMccFCGuUH9HouqXXw9S7X8yXBjCs9TzsPI3C7Fbpx9aa3
 amRiW2DVCju30S2bqkWxDEORMNjp9YTVZnzNGLCWi+et7IoE6+Xh7kRa+uGa+K/nS5s9
 3GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938576; x=1777543376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qDefFzP6x4fZXVOqtLO7cnEFxusLKsm++Fb1g5MTiJA=;
 b=JFuGPn09/n/YKJzG9Dt9uZ57ejDBt0GNImbIS7SYchdU2uRvmRioBTM1tTUfUUCo+U
 efMs5ErlzFjFy5XUR62lC6Tf6FpyAcvEz52zKStD+zw/DiJSsXQ0+QR2Ca5VKaw1oyRs
 PG0HWhEaK3yb/PcH1BGbdvaEyffEIik9CjrsoJm4fF3Gnx99mTunmjFs4WSvxiwcXxdX
 1JWh5FEwlWWeUksG+GQXHYsUeeyztxStgjaVD0Z5Vh/MSdlbIdVrGB4Hrh7+v9esbkgs
 lchscbLM42ZWCK9lWqMr30nj5iqRXWT1TDmRRL9Q1X/2Mu3+g/9NLYbAYYE8IpuYL6Ed
 8Mrw==
X-Gm-Message-State: AOJu0Yy2pJeypYeuJWi+H2e4luBDEFfh2YUn0pYUzouKJkm9zKTETUaD
 evcC/hig/3++PJFlpo9L46B++kXxApepVoozyQ8LaTEKaoEMEoLYbIcZjHYivBK3qHrlcoWsSwd
 e2GvM
X-Gm-Gg: AeBDievYvV3VsIosYLAwrxdhct2SLYNZEOu7DemwBiY2MtmA8nKkNMHRCSTf1Rl572m
 yFFfHmYTfrJSu1qXaxgm/ykWIh9WPvR2X3P5Rk1aJyxy61uEW4Msji11uBMKqQ+wWE+6kNQfoQ9
 TRxH0B1hPmdRcEbg3oubhEUyyFS2EtmkRkE1gYp4S+7nmww6C1DBn7hW/ye+lhJEnnz1zxh5RkL
 dgAg3xWpGNDBxiYS/S/vuXfwOqYesI7BgL1DaUXiU0PG+0JsX+eD48Q9SPdmfvDoK+ZAVB0kYEC
 wnIhcu1LHtFMgrMGSrAppElDuwplFTjUAOBKkz6Ysyk/I8/+OwBu/hvmRZKB0FelS7Iq5S4tXTT
 u90VEaeaXVJINXrDDNj0xoIB4sWxRT/M1ptpwMuiQJfdXsCsOPEOk0qeiUQZ2mqnDHV0xqJNAfW
 wnODOXSQvsiMNKAtph9s/0mej9c0CAvLwDPQUIr4VFbnXbvAJj1N0UNPPfTltvf+U/dTpS6s7kq
 iLvDVHZ/3J+XgKzk/fc1AWzYwO04W36mq0hVzHTMg==
X-Received: by 2002:a05:6000:4203:b0:43d:242:b9bb with SMTP id
 ffacd0b85a97d-43fe3dc5c80mr40356297f8f.18.1776938575364; 
 Thu, 23 Apr 2026 03:02:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/59] target/arm/tcg/translate.c: extract
 aarch64_translate_code()
Date: Thu, 23 Apr 2026 11:01:52 +0100
Message-ID: <20260423100229.2941820-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

This allows to get rid of TARGET_AARCH64, and helps with next patch
which will define at runtime tcg address type, by adding a second entry
point in a different source file.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-14-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h         |  2 ++
 target/arm/tcg/stubs32.c       |  7 +++++++
 target/arm/tcg/translate-a64.c |  9 +++++++++
 target/arm/tcg/translate.c     | 19 +++++++++----------
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6b16f1a560..af5e9a1acf 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -381,6 +381,8 @@ void arm_init_cpreg_list(ARMCPU *cpu);
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
+void aarch64_translate_code(CPUState *cs, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc);
 void arm_translate_code(CPUState *cs, TranslationBlock *tb,
                         int *max_insns, vaddr pc, void *host_pc);
 
diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
index c5a0bc61f4..3945dc49e5 100644
--- a/target/arm/tcg/stubs32.c
+++ b/target/arm/tcg/stubs32.c
@@ -3,6 +3,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "target/arm/internals.h"
 #include "target/arm/tcg/translate.h"
 
 
@@ -15,3 +16,9 @@ void a64_translate_init(void)
 {
     /* Don't initialize for 32 bits. Call site will be fixed later. */
 }
+
+void aarch64_translate_code(CPUState *cs, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 35ad7530c4..7533a4d01b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
+#include "exec/translator.h"
 #include "helper-a64.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
@@ -10949,3 +10950,11 @@ const TranslatorOps aarch64_translator_ops = {
     .translate_insn     = aarch64_tr_translate_insn,
     .tb_stop            = aarch64_tr_tb_stop,
 };
+
+void aarch64_translate_code(CPUState *cpu, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc)
+{
+     DisasContext dc = {};
+     translator_loop(cpu, tb, max_insns, pc, host_pc,
+                     &aarch64_translator_ops, &dc.base);
+}
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 204f965799..9ab926b118 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -28,6 +28,7 @@
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 #include "exec/target_page.h"
+#include "exec/translator.h"
 #include "helper.h"
 #include "helper-mve.h"
 
@@ -6878,18 +6879,16 @@ static const TranslatorOps thumb_translator_ops = {
 void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
                         int *max_insns, vaddr pc, void *host_pc)
 {
-    DisasContext dc = { };
-    const TranslatorOps *ops = &arm_translator_ops;
     CPUARMTBFlags tb_flags = arm_tbflags_from_tb(tb);
 
-    if (EX_TBFLAG_AM32(tb_flags, THUMB)) {
-        ops = &thumb_translator_ops;
-    }
-#ifdef TARGET_AARCH64
     if (EX_TBFLAG_ANY(tb_flags, AARCH64_STATE)) {
-        ops = &aarch64_translator_ops;
+        aarch64_translate_code(cpu, tb, max_insns, pc, host_pc);
+    } else {
+        DisasContext dc = { };
+        translator_loop(cpu, tb, max_insns, pc, host_pc,
+                        (EX_TBFLAG_AM32(tb_flags, THUMB)
+                        ? &thumb_translator_ops
+                        : &arm_translator_ops),
+                        &dc.base);
     }
-#endif
-
-    translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base);
 }
-- 
2.43.0


