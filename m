Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3537AC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFx6-0002ux-A9; Fri, 28 Mar 2025 16:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFx0-0002sk-Jn
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:10 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFwy-0007o7-Ct
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:10 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3f6dccdcadaso1708189b6e.2
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743192307; x=1743797107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZg1pklGiSZQ4vU+3tGBO6lhROLm4HbFNDbqrkRsdUg=;
 b=u3bz9JHHxWKjRX8Z7Ntx/bK6lUJZmGlWSB4O9dbDn4HKHGrcdD0o9G38NyrmeReSNb
 rqk31or8reKgzm7+znPYYGcAZ1WRbxzdZ8E2DMS7R2ynguzep+EfmWc5WXT4LwjDQ3mC
 XA+73nmpYOA/xxZ7dXY8tvvewkTa4z8pDDWzjUJsOcCPbEdYWTNAp6P/gjLRe6EeQKfP
 BYAvwge4evQLhPztWTkvt0UygHtze41ZVVVaJHfDriX0DKsB/BHEPJf3S+B8PrDI3Lw2
 w29toUoNuUTs+vMtkvrvBypibCJtHX5YIxzySPwm0/BjWEsqaefJC5DXv3N1uG0zfVp/
 DiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192307; x=1743797107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZg1pklGiSZQ4vU+3tGBO6lhROLm4HbFNDbqrkRsdUg=;
 b=bgItVLgZVIH/pHUuiknW7u4r8GxIgTQozf0Bfwh8ZxXN5UFidrQscjz1hWk5R4On7z
 O9v7dhOoehwNCHErFq1D+76u4DRHvL0OZoh8nJu4ZPxWfRHYsp7Be607dT6dbSdjOPj+
 3958BcEhFoOUo9arZ21CpuedNlRmkN8uTSij8C4j2W/fJMVo1iAcri7gtHEuOV1t8bn3
 MdrQs4KHj+Hc80Y/U/5MylolgnPOr7q5WaWSvA1C4Z1fPOMRoh9qtRRnRf/4Rdi7LR/r
 BvUahfs7YpQ0lcMziD2T/3T0tu/KPuV0eZw0Adl+3kwjTnbp+jPHRCLZ1xb4ha9e8m4q
 ZOPQ==
X-Gm-Message-State: AOJu0Yxjw4GhALQP8u8QosQhiE8rtUj12OWqTs4UQT9C4StcrTYoAUdw
 BFWRBXqeT1snPlQ2styc7gh1jl1eD32RE9iq2veMVyQxw/jMgzrkMaexVpSjxqWVeCqnvOw5zU3
 E
X-Gm-Gg: ASbGncslUOC3jQJ/2TpCqkIJJ/mFpxPgATQar/VIqOCzqeZaz8UPwCoLVCM3lxapMRO
 mlMD0SPod7E5TkoWKstnDL4yTsILzepJ43Ppg5g47uNe1Qiwr9ThwmU7/2+V6yXiHXXhVC7wFAN
 P6KKEM0K8EBOLy4ELOudVbaz+iaj660CpbZ2zVNAj+v2wugCclneclH1GK4wYt7F6MRh29jW50F
 FL2m8a61I3dH3Ku7J+LcI5R3YtWkEvT0vE7QtRy7cXLyhhpSy2rvFv45+S+SQoYulPC2fWC9Dkt
 ruGxdVVxYrEbD2zDbxXmy8rQHj3ltki80S6JE+hjUCE6VmIW5wQwPP8YlqATpECt3WAN6mMwRiA
 5/0XEEDyyBrXqIgL7O6+XVg==
X-Google-Smtp-Source: AGHT+IEo7hgZYZqkY7nQS/lM6LySyiBRleqcJGnM9DgsESCVPGhVvc9T9ID+1XC6wXPWr82enEbJNA==
X-Received: by 2002:a05:6808:2112:b0:3fe:aebe:d60d with SMTP id
 5614622812f47-3ff0f54bb45mr404490b6e.21.1743192306772; 
 Fri, 28 Mar 2025 13:05:06 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff052799b6sm465104b6e.37.2025.03.28.13.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 13:05:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 6/9] accel/tcg: Split out tlb-bounds.h
Date: Fri, 28 Mar 2025 15:04:56 -0500
Message-ID: <20250328200459.483089-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328200459.483089-1-richard.henderson@linaro.org>
References: <20250328200459.483089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

The CPU_TLB_DYN_{MIN,MAX}_BITS definitions are not required
outside of cputlb.c and translate-all.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h   | 27 ---------------------------
 accel/tcg/tlb-bounds.h    | 32 ++++++++++++++++++++++++++++++++
 accel/tcg/cputlb.c        |  1 +
 accel/tcg/translate-all.c |  1 +
 4 files changed, 34 insertions(+), 27 deletions(-)
 create mode 100644 accel/tcg/tlb-bounds.h

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index f9a06bcbab..08538e2896 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -22,33 +22,6 @@
  */
 #define GETPC_ADJ   2
 
-#ifdef CONFIG_SOFTMMU
-
-#define CPU_TLB_DYN_MIN_BITS 6
-#define CPU_TLB_DYN_DEFAULT_BITS 8
-
-# if HOST_LONG_BITS == 32
-/* Make sure we do not require a double-word shift for the TLB load */
-#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
-# else /* HOST_LONG_BITS == 64 */
-/*
- * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
- * 2**34 == 16G of address space. This is roughly what one would expect a
- * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
- * Skylake's Level-2 STLB has 16 1G entries.
- * Also, make sure we do not size the TLB past the guest's address space.
- */
-#  ifdef TARGET_PAGE_BITS_VARY
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  else
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  endif
-# endif
-
-#endif /* CONFIG_SOFTMMU */
-
 void tb_lock_page0(tb_page_addr_t);
 
 #ifdef CONFIG_USER_ONLY
diff --git a/accel/tcg/tlb-bounds.h b/accel/tcg/tlb-bounds.h
new file mode 100644
index 0000000000..efd34d4793
--- /dev/null
+++ b/accel/tcg/tlb-bounds.h
@@ -0,0 +1,32 @@
+/*
+ * softmmu size bounds
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_TLB_BOUNDS_H
+#define ACCEL_TCG_TLB_BOUNDS_H
+
+#define CPU_TLB_DYN_MIN_BITS 6
+#define CPU_TLB_DYN_DEFAULT_BITS 8
+
+# if HOST_LONG_BITS == 32
+/* Make sure we do not require a double-word shift for the TLB load */
+#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
+# else /* HOST_LONG_BITS == 64 */
+/*
+ * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
+ * 2**34 == 16G of address space. This is roughly what one would expect a
+ * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
+ * Skylake's Level-2 STLB has 16 1G entries.
+ * Also, make sure we do not size the TLB past the guest's address space.
+ */
+#  ifdef TARGET_PAGE_BITS_VARY
+#   define CPU_TLB_DYN_MAX_BITS                                  \
+    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
+#  else
+#   define CPU_TLB_DYN_MAX_BITS                                  \
+    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
+#  endif
+# endif
+
+#endif /* ACCEL_TCG_TLB_BOUNDS_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 28c47d4872..a717f357d5 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -41,6 +41,7 @@
 #include "trace.h"
 #include "tb-hash.h"
 #include "tb-internal.h"
+#include "tlb-bounds.h"
 #include "internal-common.h"
 #include "internal-target.h"
 #ifdef CONFIG_PLUGIN
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index bb161ae61a..87fb6c51d3 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -47,6 +47,7 @@
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "tb-internal.h"
+#include "tlb-bounds.h"
 #include "exec/translator.h"
 #include "exec/tb-flush.h"
 #include "qemu/bitmap.h"
-- 
2.43.0


