Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5E2E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoLu-0006yS-2q; Thu, 12 Dec 2024 13:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoLl-0006jt-0K
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:51 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoLh-0006qD-L3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:47 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so795133a91.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029743; x=1734634543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1n7XC7xi+MDcynuS7YvQbch88e08UKjXYajcUgA5ak=;
 b=CNSjHlhSyr9lqq7Z+7AMERGjgaSDBMhB++VW/nid6vN4e8UvDEwMx38+9rJaq9AFTQ
 yKDqgBkB+/MvYiJSDjCCHuIQfMA9wbFTOmi7b2kE1NsNbUKTDw33ie812IvhBU1LewCP
 kgLg5j4TC8aGffPmEDN2eijHTZL4hrwMyMmH0GlZgyRv1OB3O3zQ1l69xYa0PMgE98le
 DEjjLL5nrBDVxM4DZEk24jYh3Hu/FzGV937NKscXgYU9QbpnImwp3YETC0JyLD97w59D
 QQHQAcCgz5COrbx+v0trhJf2Y9Ry1UepTY1N3R/tYugE3OZHFRz1edkr0KHZ7gsmV32g
 QmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029743; x=1734634543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1n7XC7xi+MDcynuS7YvQbch88e08UKjXYajcUgA5ak=;
 b=Pp8ljpLbWZlel/gBpRrMCLN8vCnthVV8GaTXZzMae1kJImGy3DDbgsep5zcqQvduHR
 TZLx3Ur2JGnVpq+ZnqsLSxKOtUMLm0nLnKHSIiZhcM1A+wvdBhQ/T0PbTTpL1xrzk4FU
 VV3UcIl4Brqi/r8N/mhE/dXxtrr38nEG3FRHGkREE7RyfxY/G4MK1xw+epZQ6TLRyKTk
 xtpFBAt7GuWVsIX91T1Qy9ZYh0OV+QfcEwxAldlZN6N5ztfhMnKpwilWv3ADJoLs0Ifb
 wX1dqT6uiOUtdu7P6o8rz9QtG7gLgT8HwRsNi7v81e7AuMA08ShHOCoD4gvaKI/Jzdk4
 esww==
X-Gm-Message-State: AOJu0Yw8HxukOYu5yxLUCffEU8jLGfrQWg6T5BIIykRU1kqO8gxl5anD
 zqTLVLXGW84/F7ygE1NmQr0aiQqpjyMte8nOS2Fz4/TnGr+hB048isXGqWN8ch8vZBycNt+/xue
 q
X-Gm-Gg: ASbGncuQYEfOQLfEbYlKkCGfpVL1htrU3JAqHPAExMOKPln2gPCqVsSy6JLfqHCSzsH
 ylBuQ4ZdK89dCfjCOhEuZH/749YChSu5uWscLNwjz4ymq7HPjGv9nDPgRBycnTHYODSs6EuUiG1
 2toOxga8FmQy4nWSJZgr8E/hzQ4kdkAOqciJKTiylGLdhcW1VG0CzGVBrxnOZqPVrZByeU0UdON
 Y/Jer2kQZP4dyl3R69qLGFE8uiG8SfrQTq6wrLmiWE1hiXbaauvgz0MyFqefclnudD5jh/UinDj
 YZciAy/5mpPnqaSbAGgidOmGnvIFMnw=
X-Google-Smtp-Source: AGHT+IHxMrXErsgg5aA8HGY51xHibK/19ppf4Y6eZwr+JG3+GG1ZHq1hG0tqfh193adkaqF3LQ5p7Q==
X-Received: by 2002:a17:90b:2e4e:b0:2ea:8d1e:a85f with SMTP id
 98e67ed59e1d1-2f127fd7c19mr14135244a91.17.1734029743673; 
 Thu, 12 Dec 2024 10:55:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142de360fsm1612797a91.27.2024.12.12.10.55.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:55:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/18] accel/tcg: Move TranslationBlock declarations to
 'tb-internal.h'
Date: Thu, 12 Dec 2024 19:53:33 +0100
Message-ID: <20241212185341.2857-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102a.google.com
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
index 451cf13e876..4f6eebd90ec 100644
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
2.45.2


