Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74383C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Yc-0007SR-4l; Wed, 02 Apr 2025 17:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05YY-0007Ph-TF
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05YW-00044B-Lm
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso1098595e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743629006; x=1744233806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L8SHXY7quqVLUdERWzrSzETmomVo6s5h7gElI2540pM=;
 b=lSqZgQPlMbbcjBQVjKzfBdS8ZJ26/ATiBr2nsP04JJBfxajhD9YWrMTmNnuCWuao3f
 PYPNm6bZ3/SIP2WJ41oWvzsJoZYmQyG/oloe8ay9trmK9DHfCPDkRCMcu6KZmpVoDS4C
 VYV05rsJJtSKGkyHWfWeSlZyJCh0S9MUNlMQdhEndXQnLVjzW1tu1CDcVi82Od6bwif/
 vSrjifk4+PKhwAy3K1Ol2gH9J5z2xv3bLMwdT6LTf19sbqPJB3fsAddua/0y25W3EHfg
 4H4qEzT0qs2/23em1FqaZpuGBEuv3G6ySu7N4ddiE2qD3gYv/X5XvsUCEC/LBYoVqTb9
 fZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743629006; x=1744233806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8SHXY7quqVLUdERWzrSzETmomVo6s5h7gElI2540pM=;
 b=RLKThBEW1JRCMfnYbcc2IrJ9EcQj+QVtuZtot0EJTeKqi42xAEFn0JZxJhAqN/uH1f
 M1zRiBIKVZF2CEwhNGv7rWwLymyu8LUu8lBHWBhSfuJEobgcbyWD8pB9zotosDFDOWF8
 bF6cogH83ziaMV+IRxUmMqk7RUqDZq0+kGZmnMGHzOgVPOcfenS81/cIAh6BlBdQYWxI
 jXgyqIXFtt/R+mv0qaxT+SmoRXTDmGY8Xv0LdGhoxMsAfB59TpSIjTwkZEZdfLxrXa1b
 tefXiBoflxSoTKOWhG8K0VX6ave9L5xTooz1PT9IesNyOqzAREeYanbK7cGgttLuleFt
 JoKQ==
X-Gm-Message-State: AOJu0YzCHBt2PyAeNrLIEYUTUvdukbhLASJh9p0DGezbkoNcXYC/0GhD
 /ACRcgJB/AeeaUESB9mkZNRbqLt8ZhcNjR6zvh896TT5Ktv5dWCobUohJkhK9x4BskySBwmTT1W
 X
X-Gm-Gg: ASbGncs0IFQRJHTzLcpIs2Ry/+t73ALi0FpmNJhk4YbRwgkvDN4L/VCcQUS0REcehuT
 oP3k8fag0wwCFUfqB5d+MqoIY/m0iYDT1TEyw05Ma7QA8DLss5XHHgupFFepIADcmN1zF1+tusb
 UQm4Gc9dpG7kI8ek/NuQxRt85Tai7TUMg2fTyLAM7/ve482DVfCae4DJ67Cmr3Ut4YI8yiFUYAu
 6lKQ3VU/EIpuGRgvyFc9hlP5rbc9mXiQMk0N1G1ntt04WwS8tXOqIt/AZgkxheG8WNNo+BTVCqc
 lsrSe/igKzZtBN8z+g8xeLhaigHkKSLE6qv11MVDizkjBs7hK+lpAsTnU38CcCy+PWWIgC0CMil
 T1SN+9bsRLSMF4DzmVyc=
X-Google-Smtp-Source: AGHT+IFi1j1rLvQRnSiw4U8ge6FeCRFwDu9trqTWuKLvR2Fs0ZTkg+89/6YYrPiscCPeg99jYQljng==
X-Received: by 2002:a05:600c:1992:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-43ec13fe02fmr2606645e9.17.1743629006550; 
 Wed, 02 Apr 2025 14:23:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec24ff85asm451385e9.22.2025.04.02.14.23.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:23:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 v2 38/43] tcg: Move cpu_req_mo() macro to
 target-agnostic 'backend-ldst.h'
Date: Wed,  2 Apr 2025 23:23:14 +0200
Message-ID: <20250402212319.58349-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402212319.58349-1-philmd@linaro.org>
References: <20250402212319.58349-1-philmd@linaro.org>
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


