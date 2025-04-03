Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129E3C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Sgy-0001Uf-OP; Thu, 03 Apr 2025 18:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sgw-0001Py-Mb
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sgu-00040m-Js
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so9676975e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717939; x=1744322739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyHyqUVPAmJjyMO6Sr/Bf3FWzhnRIjw+jQa7gHGhFEQ=;
 b=yuNZ2OuYTrqAbBtFQPGQhYIXUlmoh5+88Jb2I6h8TJwGg0dNGRM5j8Ayq6uoHywmfC
 hJA8LTy4kMcu9mnVPd0MPlp1EPh+vNwMcC/D1xTjdGgtdubwQGyHUoyUod1FJhxqmtQO
 hegeCxin8XjB2Llh3ShTyfDeIlXpj81nZHF0eP7px7cU15wVCfwLWQMF/qGrL82NomZ9
 t2JbWF9jM+NyjjYc7A7zFCNAoN302ufjAPgCr7mPPUHsjTBiMV/yx2EOZT0iabLhnVbA
 qj4LgN242/27lr2EqJztULjbnn2evVKNiy/6ABum+OGu0RnkCMbDOyZdv7zKkgwxBH2X
 eZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717939; x=1744322739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FyHyqUVPAmJjyMO6Sr/Bf3FWzhnRIjw+jQa7gHGhFEQ=;
 b=hQv88y1Znh0QNYBQUMP2kY3ulg+Cp7ixxfSdzr1YxxD2nia/5J/nSmA+Qwjq7zKWP4
 nXKFMUrfHhFhdCLfKscDKNF8UHWQUueOeXWLuJi+p1QAERec7Y/f0yjvWUqr+lfVe0Tw
 ofszL6/Erk0oDzoV7SaZSukUVrt+gAh+zGEyUKyVHejyynA0ozQVbA0ugRridhKzgx+l
 n7IB/QPHz8v6xCfH7R0IaQb0Dwu71sk5Z8kgrufvcLzuIJpAFN5Q7RhkAemOw/hFAdp/
 zhy7FwOEAExfcO5XzjK3Ypau8I+jb2w5mKlXS28pyiz5VHolFouGm4iUDMrVmE/hjNpv
 TxoQ==
X-Gm-Message-State: AOJu0YyP2rHzwFIIDnkSLt+Ko5LocJNXH8ErZuyKsUCZj17psAqAPJi5
 nzVtf0PS3VbOIVpvGOZLNotgf7YdlvyLlqYPimzMVgVzReAG7KrGPWL6MzVJ4f4/wIZzv4u509l
 2
X-Gm-Gg: ASbGncta36+anET/T6p89lPn6NrHgo67anjfzPgQSxvEsmfH+vHZHyv2yFFPvHDBXm3
 QRiLt9FKLUc0aJf4c2WmUHmH1JH2VpOHrE4f5spxhE2Zwf5J8GLkUHHCNk3ImwNpjPu24BnMm1U
 T6l/hvTXvc1r/P2dFTHkhiPWpfO54AhUn08ZpLiZ8VQYgbwJJulktkb7a8xYIlMOanPxZSYjRAE
 OcHxVUeHXhYyhvuDGWP8zjcjEa2gqTr7WhbTkXUpVONLiEzLL+7vQCMcFshJ1bYxuEldpUWh7T2
 9A7MIM1xkKA5pKyA0RodV40s6u5koRNLHZSWEVrVDDYudUMMB8LceVIALaK62W8L4SGQgCsrICG
 RijWuPtSILKOrh/y9twMHniUa
X-Google-Smtp-Source: AGHT+IGoa28LNTQUqBGHzhQywr9zfKp1WvboX0jrO+iygYKMwS9qIjRIp7DXSS6Ppy26eqPCvldduA==
X-Received: by 2002:a05:600c:510d:b0:43c:fe90:1279 with SMTP id
 5b1f17b1804b1-43ecf9c36f6mr4033495e9.21.1743717938790; 
 Thu, 03 Apr 2025 15:05:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b4e4sm32600865e9.20.2025.04.03.15.05.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:05:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 15/19] tcg: Move cpu_req_mo() macro to
 target-agnostic 'backend-ldst.h'
Date: Fri,  4 Apr 2025 00:04:15 +0200
Message-ID: <20250403220420.78937-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


