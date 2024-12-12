Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D76DE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoL2-0005Pt-1E; Thu, 12 Dec 2024 13:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoL0-0005MR-7o
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:02 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoKy-0006ah-Gw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:01 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so797642a91.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029699; x=1734634499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzjyx87cr+skPITGE7mdTMDmXSYN6jRMWc7DyfPZwow=;
 b=YhHQ769nD7Xxa6qwvZJ4RlhDc+cy/LyLYfkNVNG6EC7S97dUUBXSJ38dcQdnlc3cxC
 ypkzCsjKUYxQrtiQyDaVJ+HDWXc1HASzTMlaT8euncCCCQq2UhuiO2V79msxhjdoyyhd
 1pc8Rpqw7wzvDYsuaSufgCVAKz5eVxdJVB+mWJqb6dUOlBAbhrf/lfXRL33bhESSFQAI
 wX0Tr30zgJhIo1LvJX4cCrNbMW6d1ia4st2ToHUUBgRa90zl6aadMZT5RX7LXsB8OxoE
 woIpJ6d5jMNmsssPbsZ6Gky8fbdpjThCad3eI7a+nzomDxOyDvKtF5UKGuv2XKwMQci0
 3KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029699; x=1734634499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzjyx87cr+skPITGE7mdTMDmXSYN6jRMWc7DyfPZwow=;
 b=sQho6znuCzRm40FxnVaFdraVXkQOrBvVr6xZ5yZx0ik0I0Tm07KIWPN9V+lqK1KFwN
 SEDwaOkDZwDMzTVj1An7kxFBsfb64qkqie27brq36xN3WIeV9V6HHElOy7b3t7Sje+UB
 qaYcQp7761voKEUubJvPalUdkxkF074GkIuJH++5MaSp+tGdoII+UxCSFzM9NIPVj2QO
 MnrAoRet+ERYXQFylV38wGqf3P1zdZJF7fPCKjh1/2IAS370k3WIqIXjc/T8g0sDD85A
 GKZ8/rTKygEgoLb36ZMHWXZ4pkJX2J3GH13nkPtBaYfH7HPYf1gBpDijNAkw3scNts4v
 RGnQ==
X-Gm-Message-State: AOJu0YxDdGgkm0Kndl0P30+6opZxCwh8hCy+LaKq6lSZV1RcAEpXD/hK
 PzYTqfOPTx7rYux/UapGLIQQ3Owzg7e6eMF9rWVr4BoVgMR9L11PE0OhCWyDrLOb5bwUrRfnmhP
 0
X-Gm-Gg: ASbGnctUd+hFEZbIesjsd8rjwPemQCft0NW/lW9UOKsIfh0OClDRsKnr/D42Uv8JA1t
 okDoKfif5Htuqr5CIKP85xs9uuiv9CYywWzEgcczS9lD0V2CU7XSZrEXIrp+3unbwmYRV8pXKj0
 b0D26t/Z8lhLckg9WRrq/D4GLPLaOALLK5oir8vlqKvQ3eDA0QhpNzNkh4Fu0iDgec4gBU1pSt6
 XfFKUgroGUU9HA9u3KrPTlJLt1VlG5CKZdfKIVR3fiC9Dw+rUdIiu6PONka2W0U0OJKSTuESeem
 mHl+D7sIJeHEsB00eD8HpjoWxhXd/As=
X-Google-Smtp-Source: AGHT+IEpGCCOj8kx4DZKiQn/bz1/tnVJbhk9n7xObcFHKKw2JXjOt5CZWWDoG2dnZnO8c2K1b32DMw==
X-Received: by 2002:a17:90b:1647:b0:2ee:b2e6:4276 with SMTP id
 98e67ed59e1d1-2f12802cf81mr11413213a91.27.1734029698931; 
 Thu, 12 Dec 2024 10:54:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142daeed8sm1740256a91.16.2024.12.12.10.54.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:54:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/18] accel/tcg: Move page_[un]protect() to
 'user/page-protection.h'
Date: Thu, 12 Dec 2024 19:53:29 +0100
Message-ID: <20241212185341.2857-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1031.google.com
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
index 471a384b222..521fdde0aa2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3918,7 +3918,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 }
 
 #ifdef USE_ELF_CORE_DUMP
-#include "exec/translate-all.h"
+#include "user/page-protection.h"
 
 /*
  * Definitions to generate Intel SVR4-like core files.
-- 
2.45.2


