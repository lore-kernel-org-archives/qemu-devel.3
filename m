Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39325E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfiV-0001y8-7O; Fri, 20 Dec 2024 11:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhe-0008TY-1j
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:15 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhc-00088B-9m
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:13 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so1694622f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711490; x=1735316290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUhI1KlGgJYlVEl4/+Mrb4v5c4DsGSBlMngzAO/DbMw=;
 b=BWHPdK0sDFjyiOkuOgn42TT50jFCBJ2eKf3JKtNTijswR/OsnEisU+SPMtkNVrRuAB
 bdQMQD93nURrXojYc6e49ruLmkyNwogUJO308M2zty50jHDUVNP0lzJS32wuxDCk9EbS
 u/DK0nJbH2Sp6pobFRDCayMhwGYXqzM5Au1GU1NSHAAKTKifYxjayhX9E71EFf2+Nq2K
 zByD2QHMDNyss6iPT5jYGvreTTpnvJjzgBobX6zMsTqtB4nbZ+czeR72HIr8zrUa2OzH
 T3/y6RAprAWulU0rV+9EmYgKPYL6COgHQQdwHGds55kyKRQ7rBVEm1NuTmNis9Wm+GGx
 6oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711490; x=1735316290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUhI1KlGgJYlVEl4/+Mrb4v5c4DsGSBlMngzAO/DbMw=;
 b=QUgLkjhWtrZlCaMNwwdWrbpcOOXAeejvBuhhFWtn00J+AcbJaZVOScIInUE6JLjjfS
 k0YH9gleYNTOfE8QnRCMsnnCI3ilQrtRmBfu54FNLZXLyIhDjwfs/f/461L0hfMlt+np
 0qu7ySFKdxrpHnTeVVfxWjnMUWZ8ugLYnwOub0DoE8evOhTmXnsmJvMphCbarenIL0+4
 iFB4j5sPLqY78JWo1REExHmmUeCWGK6aA6EtkktqaEXg5LzfywcoxW/AgCQ41M1ylGWb
 TZUecs3lkJ4l/k9ei3jCksWqFQ15FtJGLRSaI++O7aGWBSFA5GHZRoI9bIXD/KQx15Mh
 zDOA==
X-Gm-Message-State: AOJu0YwxVKBDow+JG91p4Dmju+rSbqFKLvN/9XqL05qoG52Du1IyKi2j
 85X1SgwY1s8UAqyui5u8EVQ4gYfuRqat+1pOJiwtIL0ijljS++1zPx/jfCnAopVsMrdkL7QhGjT
 7
X-Gm-Gg: ASbGncvsrHtHP+sQpl1P0B/6L0dSSYSSwUQguT694A+7gsqIMkEjYMFQiGlc67zeuM2
 +Dqi0FwB/gM+RUV4S7fqVgTJgX0IhT6ck838OSMDg2Wx5y+7st0BPGD7IiFnlMA/vXEGAPIRpvq
 5S0YVcAnLUrK3A8PmY+8lzgSJuvCNfntu21dK0vmBuNN1GJyxRwdII3cpfwUFcVp5S2tqYAyZva
 CE4Y/AjLugQvOVQy7b75k3D90UwaA7lRnyiuL0b+V2Pkf9QbmGlg32msSI8a18oP5JNC/99FLA=
X-Google-Smtp-Source: AGHT+IHjiY4OsrQfpAtX0vcSJ9yFQ4/P9NlRCH/FfVytuvKzlMjmtU1eVqW9ejp4DY9NWlcMCUEOqw==
X-Received: by 2002:adf:a30f:0:b0:38a:2658:bbc7 with SMTP id
 ffacd0b85a97d-38a2658bc1bmr43604f8f.29.1734711490390; 
 Fri, 20 Dec 2024 08:18:10 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8474b6sm4396936f8f.51.2024.12.20.08.18.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 30/59] accel/tcg: Un-inline log_pc()
Date: Fri, 20 Dec 2024 17:15:21 +0100
Message-ID: <20241220161551.89317-31-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

log_pc() is only used within cpu-exec.c, no need to
expose it via "internal-target.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-10-philmd@linaro.org>
---
 accel/tcg/internal-target.h | 10 ----------
 accel/tcg/cpu-exec.c        | 11 +++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 6f4ec0bd424..0437d798295 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -72,16 +72,6 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 
 bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
 
-/* Return the current PC from CPU, which may be cached in TB. */
-static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
-{
-    if (tb_cflags(tb) & CF_PCREL) {
-        return cpu->cc->get_pc(cpu);
-    } else {
-        return tb->pc;
-    }
-}
-
 /**
  * tcg_req_mo:
  * @type: TCGBar
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f82870a1e2a..396fa6f4a6b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -21,6 +21,7 @@
 #include "qemu/qemu-print.h"
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
+#include "hw/core/cpu.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "trace.h"
 #include "disas/disas.h"
@@ -434,6 +435,16 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     return tb->tc.ptr;
 }
 
+/* Return the current PC from CPU, which may be cached in TB. */
+static vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
+{
+    if (tb_cflags(tb) & CF_PCREL) {
+        return cpu->cc->get_pc(cpu);
+    } else {
+        return tb->pc;
+    }
+}
+
 /* Execute a TB, and fix up the CPU state afterwards if necessary */
 /*
  * Disable CFI checks.
-- 
2.47.1


