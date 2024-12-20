Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825E6E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfie-0002su-AN; Fri, 20 Dec 2024 11:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhj-0000Em-3a
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhg-00088q-Ie
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso15460225e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711495; x=1735316295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHn0+dNGjU/yg9Pqd/gB3HrxWjuGd4TsS8QR//rhXIU=;
 b=eT54a3TuP96jDoSAcynwwdUmYadDG0ewliBSDXsdcIS6AiVW21cDOxbT4GiPlbSho+
 Xg4yKLRUEPyc3P8WTw5n74Val/lqgHEJHjXVVeenhwvIbsKDLqtXYgYWa69n2iUK3aOS
 i1rso0RdCGISB7WERxJr2bWNDX70A4wVtRvjWq1FpDHWmaAhi7RewAhFyoe1J7pL2Bw+
 sGAjWLlVkstxwKybWEoyZWfjpkMq+keeDMCzZE8gnfz3iLUMFK9M27K3Pg3NA/vQNF+B
 L1QE/BQNku291Y4N98lLEvO7SmYIQpxK2j6X70Rq/Yux4S/R1CpLWryniIqp+wARvAC9
 KIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711495; x=1735316295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHn0+dNGjU/yg9Pqd/gB3HrxWjuGd4TsS8QR//rhXIU=;
 b=wM3R19ahVFhyi5FRl6NPrHo5OuNS93NSnvjxq6/lSah9Vits3cQmdPypryn9ivojHN
 jqg6EdWLv+LMZIB3cIPjxCLaY5BIsvYoYBybmzUUXYqees9PQb5mkqGuMI1zQwSOCdkd
 qpeqNi3BPww0/UBYRo3rUYGSQF5Dg057/mEvrSPR22BEqWJy36Xi37nXCt2GvXBdBzdx
 QuREAr8RphNx/BCH9MRmYfRwClPCQGhMPg5AMn12V6Fq9mCBBMvjGnhFCo8B78Z8MpPQ
 F0QLbXatnSvvoUm/t19l69Cn2Q6E+iEDAfVqmtNkky5vN4kwSKOAr9Ai83nFQ3aFPsvV
 EkHg==
X-Gm-Message-State: AOJu0YzIsDszT1hG9+S5pI0DUKncBu9/O1QukvtJwRDgxbHzClIp5FIP
 wgkN7OnNZcZHzueHP59gLw6idZSRbZp6k6Lj0DMUYwBordl/ctmX73J3g3PNGmyXaac2sM8cy+V
 p
X-Gm-Gg: ASbGncviyYkFPX7Sb0ILEHSOPEwHNfU7H4TReB6x5iBBxr+NJC660sY2Is/JkyeHiX/
 F1bp5CkvOBql1yLSo43I0zJ9mvxtjXHUCaQ/ukRy3D+6Ry/ApdjqE+SVd6gWG4AhR1A5fK58Rqe
 FG4H12S6dIgJerzEirIPejKjQihwohxWYo3MyrE34DFIRg3+ZSbF7BbnxwnPnt+tX4ThL08wHB5
 hq1uGmDCMVFiN7m5TcXkmOo6+9x7lbPBPfkVok0Rjx8A/EuM63xcGLkQ6r8++xr0WvPuXOTeqM=
X-Google-Smtp-Source: AGHT+IHBL0Vu3tA/gPIZpr3AHfOU/eBzaeJLITgmoFsVK3q8kPRm+ItX9nugj98VZzhYxE4H8dNVWA==
X-Received: by 2002:a05:6000:481e:b0:385:f417:ee3d with SMTP id
 ffacd0b85a97d-38a221fa5bbmr3576099f8f.35.1734711494860; 
 Fri, 20 Dec 2024 08:18:14 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acafesm4375189f8f.98.2024.12.20.08.18.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 31/59] accel/tcg: Move TranslationBlock declarations to
 'tb-internal.h'
Date: Fri, 20 Dec 2024 17:15:22 +0100
Message-ID: <20241220161551.89317-32-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Move declarations related to TranslationBlock out of the
generic "internal-target.h" to "tb-internal.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-11-philmd@linaro.org>
---
 accel/tcg/internal-target.h | 32 ------------------------------
 accel/tcg/tb-internal.h     | 39 +++++++++++++++++++++++++++++++++++++
 accel/tcg/cpu-exec.c        |  1 +
 accel/tcg/cputlb.c          |  1 +
 accel/tcg/tb-maint.c        |  1 +
 accel/tcg/translate-all.c   |  1 +
 accel/tcg/translator.c      |  1 +
 7 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 0437d798295..1cfa318dc6c 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -36,42 +36,10 @@ static inline void page_table_config_init(void) { }
 void page_table_config_init(void);
 #endif
 
-#ifdef CONFIG_USER_ONLY
-#include "user/page-protection.h"
-/*
- * For user-only, page_protect sets the page read-only.
- * Since most execution is already on read-only pages, and we'd need to
- * account for other TBs on the same page, defer undoing any page protection
- * until we receive the write fault.
- */
-static inline void tb_lock_page0(tb_page_addr_t p0)
-{
-    page_protect(p0);
-}
-
-static inline void tb_lock_page1(tb_page_addr_t p0, tb_page_addr_t p1)
-{
-    page_protect(p1);
-}
-
-static inline void tb_unlock_page1(tb_page_addr_t p0, tb_page_addr_t p1) { }
-static inline void tb_unlock_pages(TranslationBlock *tb) { }
-#else
-void tb_lock_page0(tb_page_addr_t);
-void tb_lock_page1(tb_page_addr_t, tb_page_addr_t);
-void tb_unlock_page1(tb_page_addr_t, tb_page_addr_t);
-void tb_unlock_pages(TranslationBlock *);
-#endif
-
 #ifdef CONFIG_SOFTMMU
-void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
-                                   unsigned size,
-                                   uintptr_t retaddr);
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_SOFTMMU */
 
-bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
-
 /**
  * tcg_req_mo:
  * @type: TCGBar
diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 8313f90fd71..90be61f296a 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -9,6 +9,45 @@
 #ifndef ACCEL_TCG_TB_INTERNAL_TARGET_H
 #define ACCEL_TCG_TB_INTERNAL_TARGET_H
 
+#include "exec/cpu-all.h"
+#include "exec/exec-all.h"
+#include "exec/translation-block.h"
+
+#ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
+/*
+ * For user-only, page_protect sets the page read-only.
+ * Since most execution is already on read-only pages, and we'd need to
+ * account for other TBs on the same page, defer undoing any page protection
+ * until we receive the write fault.
+ */
+static inline void tb_lock_page0(tb_page_addr_t p0)
+{
+    page_protect(p0);
+}
+
+static inline void tb_lock_page1(tb_page_addr_t p0, tb_page_addr_t p1)
+{
+    page_protect(p1);
+}
+
+static inline void tb_unlock_page1(tb_page_addr_t p0, tb_page_addr_t p1) { }
+static inline void tb_unlock_pages(TranslationBlock *tb) { }
+#else
+void tb_lock_page0(tb_page_addr_t);
+void tb_lock_page1(tb_page_addr_t, tb_page_addr_t);
+void tb_unlock_page1(tb_page_addr_t, tb_page_addr_t);
+void tb_unlock_pages(TranslationBlock *);
+#endif
+
+#ifdef CONFIG_SOFTMMU
+void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
+                                   unsigned size,
+                                   uintptr_t retaddr);
+#endif /* CONFIG_SOFTMMU */
+
+bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
+
 void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
 #endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 396fa6f4a6b..e9eaab223f9 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -41,6 +41,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "tb-internal.h"
 #include "internal-common.h"
 #include "internal-target.h"
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 337801feede..b4ccf0cdcb7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -40,6 +40,7 @@
 #include "tb-internal.h"
 #include "trace.h"
 #include "tb-hash.h"
+#include "tb-internal.h"
 #include "internal-common.h"
 #include "internal-target.h"
 #ifdef CONFIG_PLUGIN
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index bdf5a0b7d58..8e272cf790f 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -30,6 +30,7 @@
 #include "tcg/tcg.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "tb-internal.h"
 #include "internal-common.h"
 #include "internal-target.h"
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index bad3fce0ffb..572a8a87972 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -62,6 +62,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "tb-internal.h"
 #include "internal-common.h"
 #include "internal-target.h"
 #include "tcg/perf.h"
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index ff5dabc9014..ce5eae4349e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -19,6 +19,7 @@
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
 #include "disas/disas.h"
+#include "tb-internal.h"
 
 static void set_can_do_io(DisasContextBase *db, bool val)
 {
-- 
2.47.1


