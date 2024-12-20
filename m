Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC87E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfiZ-0002Jm-RK; Fri, 20 Dec 2024 11:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhU-00087o-DV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:05 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhR-00086R-Nq
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:03 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so1694420f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711477; x=1735316277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VsSwq4xHHCQtvJtv5T9NcsaTQceZkYJfKQ5PctlxJTo=;
 b=U0hhFJnGzOsO7Nkux6Rd+2HWf/nBgSmYx14MdGDriYM1Lwzp3UgPLy5HdKQbmtv72y
 mR3/1A0ZrGjSi8UUNwUtKNUF7dYorOoIYUF5h2Q/IUQ5nmPMObLTdvbN2qW/r6hxCT11
 lX7Zr9zsMtgYi79BzLII5XGioAbswUwzxZl1jxZQI9i9J+jOfik0RsXkzLHpPsmZxZ5G
 s5WCzeH0iJ5o1fHP3FL+ZHfSI6ixDIxUEvAAQsybMExgLXxqUxMKtl0N8wHRKUdMdali
 iDaC4JWsFqTzifXlKPZFmSVq2rS81XmqZXUeL63RPnGL+OP9Qfg3HJpXF3eRes8WYpBP
 wQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711477; x=1735316277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VsSwq4xHHCQtvJtv5T9NcsaTQceZkYJfKQ5PctlxJTo=;
 b=U/rQwNU0B9kTrCvrDFlYbo3khz22PCzhAYTxJSAHFRItV6oLIMcdcD9rEBV08+QsnL
 0ZnWQCzXJYFxn0Pj4qD7LIYx1Y2HoOLHRUahZsHgd66tZ7pDtgQgKfgB8GDrsLFjIYJv
 e80ZsNVCiHHj4DDP6moNPLrpRHgD3t3DGSSvgicLpsXV8ek+BL5kg29ewu/voMvndNav
 IdQ/+WkcJJuWfmQ3fV8skg9zE1cix8Z05ZdWHDfpt36OlJdUEcxDIVbgb9EOw2VUYT5r
 npq7DpUSyWQAmOuaqq1UrDB78dooDBkxlZ36LrBhB7Kwbrfee1tiw4DSUcI1NLee329Z
 M7iQ==
X-Gm-Message-State: AOJu0YwstWSXZKPRheza8wVb0Sqy2tznQ+6EnScbHLqV3z/0l+mYjrU/
 Rdh37dfJ9h3bx5VQE12Ymtpz8ckbyowFaD/S4dLUzJqicnpFYQalaMKPNhYnqEw8Q50sWvR3sPF
 6
X-Gm-Gg: ASbGnctLndPX+fBad5kklsi18euWKWgW83PZ0tqSDNXSwBATc/9sqgu5Dn32R6PJRdZ
 uEHQ+fF6RjQtk+EXZskDJx/5F6HcyG3vcW3LUbdcAcD704pmMifyDhTA5kcamx+LKIHxxdIbE0l
 Mm85bmGDJ5R35NgswgAsspenfA/Ob+8oaRIt9dnmXV22pGczAd2gOpqO+MhZ6EZPnwMpQvd5uLy
 2FJoe+nI1BwNheKMMQBw5CznQ3pE35LiB+RgvhDh8+SWBuFzfHediFoQF4o3GB/w2bzABR+PoM=
X-Google-Smtp-Source: AGHT+IH2mqa6VeTz47aA7x2rBrUTUxrgH+2cLEzQih7HY5faTqkAYJ+3yqUDQQNE6q/BZDA6de8Gmw==
X-Received: by 2002:a05:6000:178c:b0:381:b68f:d14b with SMTP id
 ffacd0b85a97d-38a223f75c8mr3729758f8f.45.1734711476897; 
 Fri, 20 Dec 2024 08:17:56 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8471dcsm4418155f8f.48.2024.12.20.08.17.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 27/59] accel/tcg: Move page_[un]protect() to
 'user/page-protection.h'
Date: Fri, 20 Dec 2024 17:15:18 +0100
Message-ID: <20241220161551.89317-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-7-philmd@linaro.org>
---
 accel/tcg/internal-target.h    |  1 +
 include/exec/translate-all.h   |  5 -----
 include/user/page-protection.h | 20 ++++++++++++++++++++
 accel/tcg/user-exec.c          |  2 +-
 linux-user/elfload.c           |  2 +-
 5 files changed, 23 insertions(+), 7 deletions(-)
 create mode 100644 include/user/page-protection.h

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index fe109724c68..a03c05315a4 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -37,6 +37,7 @@ void page_table_config_init(void);
 #endif
 
 #ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
 /*
  * For user-only, page_protect sets the page read-only.
  * Since most execution is already on read-only pages, and we'd need to
diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
index c50661a05d5..039668ff8ac 100644
--- a/include/exec/translate-all.h
+++ b/include/exec/translate-all.h
@@ -25,9 +25,4 @@
 /* translate-all.c */
 void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
-#ifdef CONFIG_USER_ONLY
-void page_protect(tb_page_addr_t page_addr);
-int page_unprotect(tb_page_addr_t address, uintptr_t pc);
-#endif
-
 #endif /* TRANSLATE_ALL_H */
diff --git a/include/user/page-protection.h b/include/user/page-protection.h
new file mode 100644
index 00000000000..448c7a03449
--- /dev/null
+++ b/include/user/page-protection.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU page protection declarations.
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1+
+ */
+#ifndef USER_PAGE_PROTECTION_H
+#define USER_PAGE_PROTECTION_H
+
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
+
+#include "exec/translation-block.h"
+
+void page_protect(tb_page_addr_t page_addr);
+int page_unprotect(tb_page_addr_t address, uintptr_t pc);
+
+#endif
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 4ed6dd19f30..636932303bb 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -25,7 +25,7 @@
 #include "qemu/rcu.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/main-loop.h"
-#include "exec/translate-all.h"
+#include "user/page-protection.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "qemu/atomic128.h"
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 471a384b222..effd3ab47ef 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -8,6 +8,7 @@
 
 #include "qemu.h"
 #include "user/tswap-target.h"
+#include "user/page-protection.h"
 #include "exec/page-protection.h"
 #include "user/guest-base.h"
 #include "user-internals.h"
@@ -3918,7 +3919,6 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 }
 
 #ifdef USE_ELF_CORE_DUMP
-#include "exec/translate-all.h"
 
 /*
  * Definitions to generate Intel SVR4-like core files.
-- 
2.47.1


