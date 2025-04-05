Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C33EC3601A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16AA-00010A-LX; Sat, 05 Apr 2025 12:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16A2-0000m7-Gm
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16A0-0005Hl-Jk
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso27241035e9.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869659; x=1744474459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyHyqUVPAmJjyMO6Sr/Bf3FWzhnRIjw+jQa7gHGhFEQ=;
 b=OK49d9lX1FT+kF/t7hLHhGBWOtCoFzzT3nzIdmQZn/xsbpL353eFtTxaP5dxsTotdw
 ae6iPvcIdY7UEebcbg/CFmbYkF3Ujm1jAurpfF10u6Uue7AWq8IZnuOZQxgkweIriiWI
 1zBqe/V3EatRrOn5dxTUbgM1bwdl+fsjf7vvbWsp6ds/KndjWWESC65RqOz/oRMres83
 qbhqwtuEB+KWiZaECqt4P4C7eTXI4Sw8Yz3YAjPz4M4Jxlryk8/qu9ve1Jqio1AIp7mh
 +elM460bQYaVaVjtJv9HA5ozQfBj4PQcitg1Ehh0GJjYB4uHTK5M1yQ6bRfoXOzWpu0f
 A6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869659; x=1744474459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FyHyqUVPAmJjyMO6Sr/Bf3FWzhnRIjw+jQa7gHGhFEQ=;
 b=xTY8psDI18MkryqK4hKDEn5eotDHqXknmadbmEmL1pONxeNE2yaELMkDkmwxH6LXUs
 nN2hyxZWXrp3ftH1aTfugwjYWhVjVPeeC+7R0a+iLOeu+E4AYeeX6edIoD2TNlHfdD25
 FFj8BScbDx7/nzokhetZfn6wdgCcgGbN/1viPxIkojvISOWWt3oFEPBbsVPBpylAvsBe
 Lszv/PHs5SWMil/sMOsy32to2U2WK6GpdeaJzogpuPKuYsgBW+GZOoNZMbaeS1G+pJuw
 tS9BYC4ZTkF1qo9dwe4UuRPr7jgOtcH50cDSm/PRe3hZx6wk8ZJXnt1XykgOCmo9PTVk
 YNtg==
X-Gm-Message-State: AOJu0Yx3yLnaq998YwkWGaqjz89qwbG4N5c40mBK7CBJNOQOx9lTuFeL
 ad+uZ1Y2p9wAa9wepi86B84PFxe1QBSP+z7DjIqy0Hhga1xBpwsLme29ByXngmDwIr/SzYc/MWh
 l
X-Gm-Gg: ASbGncujN5ZKH30o18HZKl7OBSxfh+4dyA4O0v1rYbSQm9SDrGoYrh7SFBZEDRMdwW2
 Irv0DgxBUothE3pGtN15vODbYAFfqRXNv+XZ+qfr0DgDq5zuZW4riaVFGttTCjqUSozeYLRsY2B
 EtKdhpQ18mFin+1d8WaHg6x+Ya5nnmHZdReWZtFTKqS4KP4TaYIVWUECTItlWwR2rTl0pfmk8WP
 KL60qkHeG30k7nPvPqi6sr7K/tpvzzxlqfg7rPGdb7WGdu69QJU+welE+rTXvmAo9GIJ51XNtVu
 0tucXADYBIc53L8ozLnO4ibQlfhle45BA44Io/KzEQ9lIhSeXY4YdrC8NfozsEOKwF1SJZ6/NLo
 kJyiqTVPjDxp9gIC9WrJ0+Bz0
X-Google-Smtp-Source: AGHT+IG1xYrq95nrV5Lt4x7VkObg0TZgbj0CZhbN9dRZGD9iDg1LNG9y4exR3qA6QwdjEcoB7CW3Rw==
X-Received: by 2002:a05:600c:a07:b0:43c:fb95:c752 with SMTP id
 5b1f17b1804b1-43ecf843e91mr78422055e9.3.1743869658654; 
 Sat, 05 Apr 2025 09:14:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364ec90sm76959905e9.27.2025.04.05.09.14.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:14:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 12/16] tcg: Move cpu_req_mo() macro to
 target-agnostic 'backend-ldst.h'
Date: Sat,  5 Apr 2025 18:13:16 +0200
Message-ID: <20250405161320.76854-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 accel/tcg/backend-ldst.h    | 41 +++++++++++++++++++++++++++++++++++++
 accel/tcg/internal-target.h | 28 -------------------------
 accel/tcg/cputlb.c          |  1 +
 accel/tcg/user-exec.c       |  1 +
 4 files changed, 43 insertions(+), 28 deletions(-)
 create mode 100644 accel/tcg/backend-ldst.h

diff --git a/accel/tcg/backend-ldst.h b/accel/tcg/backend-ldst.h
new file mode 100644
index 00000000000..9c3a407a5af
--- /dev/null
+++ b/accel/tcg/backend-ldst.h
@@ -0,0 +1,41 @@
+/*
+ * Internal memory barrier helpers for QEMU (target agnostic)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_BACKEND_LDST_H
+#define ACCEL_TCG_BACKEND_LDST_H
+
+#include "tcg-target-mo.h"
+
+/**
+ * tcg_req_mo:
+ * @guest_mo: Guest default memory order
+ * @type: TCGBar
+ *
+ * Filter @type to the barrier that is required for the guest
+ * memory ordering vs the host memory ordering.  A non-zero
+ * result indicates that some barrier is required.
+ */
+#define tcg_req_mo(guest_mo, type) \
+    ((type) & guest_mo & ~TCG_TARGET_DEFAULT_MO)
+
+/**
+ * cpu_req_mo:
+ * @cpu: CPUState
+ * @type: TCGBar
+ *
+ * If tcg_req_mo indicates a barrier for @type is required
+ * for the guest memory model, issue a host memory barrier.
+ */
+#define cpu_req_mo(cpu, type)     \
+    do {                          \
+        if (tcg_req_mo(cpu->cc->tcg_ops->guest_default_memory_order, type)) { \
+            smp_mb();             \
+        }                         \
+    } while (0)
+
+#endif
diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index f5a3fd7e402..9a9cef31406 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -13,7 +13,6 @@
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tb-internal.h"
-#include "tcg-target-mo.h"
 #include "exec/mmap-lock.h"
 
 /*
@@ -44,31 +43,4 @@ void page_table_config_init(void);
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_USER_ONLY */
 
-/**
- * tcg_req_mo:
- * @guest_mo: Guest default memory order
- * @type: TCGBar
- *
- * Filter @type to the barrier that is required for the guest
- * memory ordering vs the host memory ordering.  A non-zero
- * result indicates that some barrier is required.
- */
-#define tcg_req_mo(guest_mo, type) \
-    ((type) & guest_mo & ~TCG_TARGET_DEFAULT_MO)
-
-/**
- * cpu_req_mo:
- * @cpu: CPUState
- * @type: TCGBar
- *
- * If tcg_req_mo indicates a barrier for @type is required
- * for the guest memory model, issue a host memory barrier.
- */
-#define cpu_req_mo(cpu, type)     \
-    do {                          \
-        if (tcg_req_mo(cpu->cc->tcg_ops->guest_default_memory_order, type)) { \
-            smp_mb();             \
-        }                         \
-    } while (0)
-
 #endif /* ACCEL_TCG_INTERNAL_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 35b1ff03a51..d9fb68d7198 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -48,6 +48,7 @@
 #include "qemu/plugin-memory.h"
 #endif
 #include "tcg/tcg-ldst.h"
+#include "backend-ldst.h"
 
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 3f4d6824460..5eef8e7f186 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -37,6 +37,7 @@
 #include "qemu/int128.h"
 #include "trace.h"
 #include "tcg/tcg-ldst.h"
+#include "backend-ldst.h"
 #include "internal-common.h"
 #include "internal-target.h"
 #include "tb-internal.h"
-- 
2.47.1


