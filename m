Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C0BC3601F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05IK-0002kW-3T; Wed, 02 Apr 2025 17:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05IF-0002Ov-Ja
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05ID-0007NU-Bw
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso164673f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627996; x=1744232796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L8SHXY7quqVLUdERWzrSzETmomVo6s5h7gElI2540pM=;
 b=QtaNiq/qjuqagNTvYrrYD7yYhYkLZObsHcGkCmvc3VU22H22U0mgHEd9UyQLH5YJHQ
 KbvkxcZ1YpdYYO4vLX3Tf1DhbfEEY+lT4Uix2jG5ogYxrM0uMOrQ+2L1auGhLDoEUzUG
 NT9x94ROgqetS2zPfTLnELTaNVcb/0mqZatAL1mDXgOkoS60uIHLiDWWUqY2hB7+mEuK
 3KOa58wElSFmOOdkb0L7b853N/TWSgtqx4Z+x6vUzeicYuU/7ZjOwW7fdnel07BzElgL
 I4WcWZJuGziQBO3/qky27otAV8H+Blqk951Aum+gS7vpmaWqpN02Iv/t1uUQ3Pv6CrcR
 E4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627996; x=1744232796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8SHXY7quqVLUdERWzrSzETmomVo6s5h7gElI2540pM=;
 b=C320oG4L6h+VNBT+HYOkN6Rc+n/YKGQyE84vmonkzIS9e7uehH4D7nJ86Xhc1SfOKf
 DLSSDZSoEq8/u6V53j2EGSLZwFXfB47p9G97ZhB0I15urDv2gAfdhg2KMROuTNERYxBx
 zIIfO/AhoKj1O4vbCTEZF6nZLtz6imlGz9NQTax8H2OVBC5cVyIOnwDI4C2b7bDW20DP
 mIny2zoVFnCkgz3n7EzH5kiOv3BE3U/G5sfFAL4Cr4kPN+9H0R0ii9wFVHLSlNDiac+f
 81Q+dVxHdYXXXtFlwFKbwlzgCgRTUoz0iWIOtX/SnpH0ZV3XKjtbIEASqJcxR9RwdZDn
 AeEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1F37/y4un9HYSX8aX3FX/ZGo+B7lfBHLIO9EO1kusUYkkyRc3ZjISrYvukbWWT4e7LYKh79mE7ASQ@nongnu.org
X-Gm-Message-State: AOJu0Yx1X5W5LZMMpavWbUD09w5GBtPtZBkKUp7maNeD3IFgS4IBgv5B
 S2xiyKsJnBbpZ7/dYBjTNaE572MpbekK3+DXvzebEtcphBdlhUIG/srXW0UVTNCar6n5Mxne7Ej
 p
X-Gm-Gg: ASbGnctD7nHb7DQLrzLoDE1/XxmlNmhqP9TVyb39z7D/k/o0TCYw51Wfwf13LFNMGwS
 klWMn/mA8kbhzPNGN+huOk50qNyOWwam2GYYuZuz3HOcf2a48+n61DQAW5fMYSTj6f2TJViQu/t
 nVy2IPMrYd933Y0b2SuwYs+nQD/6cW12ybpaAwrKuoLeW0myhEyzmn3IKMr1QStnIhNokf9aons
 HJ8286bMJ59qKUnIqDCRLWWrDM7+GwnlrdAsAJNbnXU4p1LV+ge/fDyV6oxcqSonZVyngJWQY8E
 r0V3rtOsYpW74qkE3ThiqlbrW40Bd44LbYLL13zLxLUEt5sAvPbgpQJLarfDCPgGLx/gg7vn2fg
 j3jffJuh92r/9AsS807wcQdO4efQLXg==
X-Google-Smtp-Source: AGHT+IEJNhYq77EX0R2R+447cKHCT7QAaHTw/ufcbRBm3+I9YUJ8X/pIh1KD7jJqeo0aB+fiz1DUIQ==
X-Received: by 2002:a05:6000:4383:b0:39c:1404:312f with SMTP id
 ffacd0b85a97d-39c2f8c6371mr111917f8f.1.1743627995827; 
 Wed, 02 Apr 2025 14:06:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e12bsm18250964f8f.62.2025.04.02.14.06.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:06:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 38/43] tcg: Move cpu_req_mo() macro to
 target-agnostic 'backend-ldst.h'
Date: Wed,  2 Apr 2025 23:03:23 +0200
Message-ID: <20250402210328.52897-39-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
 accel/tcg/internal-common.h | 27 ++++++++++++++++++++++++
 accel/tcg/internal-target.h | 28 -------------------------
 accel/tcg/cputlb.c          |  1 +
 accel/tcg/user-exec.c       |  1 +
 5 files changed, 70 insertions(+), 28 deletions(-)
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
diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 2f00560d102..829ae9389d2 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -108,4 +108,31 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
     return get_page_addr_code_hostp(env, addr, NULL);
 }
 
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
 #endif
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


