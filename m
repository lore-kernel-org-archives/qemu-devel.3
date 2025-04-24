Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D37C369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kua-0007g4-Fr; Wed, 23 Apr 2025 20:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktW-0005uI-SQ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktT-00056E-TY
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:50 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so333645b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456206; x=1746061006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggbOR76BAcyXgvavB4mZvfqZnt/5CtPguoo3NLh6PJU=;
 b=PV/XGtWiyd2WMWIm5EhWOQ5CHeKgMCNh3l27Bz+V2UucRYL7OAvUJtVqC+IR8XaXXC
 5qc8UF34qSc4757c/5FvI+y0/uTXZ1J1RWAZfbMs7MTZYjc2DdqxGULca6rGXfGr/6h0
 /vM4bTZPyyameQa+4Y/LD7zsoXnUKZnqr6V7ULFgcyRnP51ptpJEdsWhVXaaRTJciVGH
 7pkNw3X099UMjnDq+8S3bI/Y4FgtyMqf8XUeriAqM6UH1Krki46Yhbhbtnh+4Vt2iWyt
 RjhbrYkmKPn4I7GjHsCmEQUqTNYOkGYkcMjWGBSxC1bqeT8+A2RkouLAIIkeEOw4vccQ
 r6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456206; x=1746061006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ggbOR76BAcyXgvavB4mZvfqZnt/5CtPguoo3NLh6PJU=;
 b=L5kXpdxmCJNViMWOLdhALbMVuQ3DuDOhaTek1p/1YmGthFxDsIia/VLC0XRqot8pMP
 4SW5mMs1qNChD7AQraXe4/T3F1+K/9f52ps83FsTB72nuocGl2PuompZtPW+LEzxwxKD
 1yUBeS79OQqM3WPBJlXJgXZ5JqUkBS+NU8YVRk2mswXu8A+7GPF97U0k7CuanVpdSjiB
 r81yO6jfZzNNkOZlszpQjj+0cEEK9grfGcEG2Qq5Lcr9Q8WsXsrDxtMC0Gnz998Gj2lL
 X2xWCq6guz1CDqzB7InD5DmfGE6cYu2EmGbWHg1VpKDYEvcq+bQuSOiL0Cg6ui/O6VLI
 ll/g==
X-Gm-Message-State: AOJu0Yx1gxd54PsUsqqVIpcmLUpZwa4BJyyOSXywm+csOz0apKsW2+7G
 ZqTMX+IR08RBgeWAhtxRECmb6o7Yqegr7lRWroaWOX0I5zfu6eH/JCDTZySccaYIXuPRBuwQ4a0
 X
X-Gm-Gg: ASbGnctuHbVCzc0Rqh5C+CH9eO/2KgusR8DiDEXi4kPNtzveYx32i+UBC6bFG7YQ4OR
 qrcIH+FBN4UryaqAsgwD1WvIVSJ3+Uu4q6Zr3WJTWR7a27tyQEsiYVC0YzL2Hx9EkuQvt4lbxAM
 fTpylGiA9NaEHU0pDXd6retmhgQIUBZJnA8MHPKlOfE0bL/jV7vMU+cnvgD+aJbrzL6MMicnPOB
 yeoB/+T7wBH+WDAR+WMkaX6I8zckXdnPNFQRkY7t0ApH5KNcVS0tqEYVqnTZmgw1C938uPzeiEx
 9pm72cnO1/X2K1QUhRkjo6HaPvJWC3jWh5tj3ZX7cSHZ8LhhEDVQjt5kwJfN5+7+aBDjj6WXiAM
 =
X-Google-Smtp-Source: AGHT+IFt235Olki5BRT4tEwRUyNhF3lF204SSq/fPJsXxrNWJj/OifH9BzUldyCwGimC+8yTC1CW2w==
X-Received: by 2002:a05:6a20:d706:b0:1f5:77bd:ecbc with SMTP id
 adf61e73a8af0-20444e9b3a8mr825739637.16.1745456206231; 
 Wed, 23 Apr 2025 17:56:46 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 097/148] accel/tcg: Split out tlb-bounds.h
Date: Wed, 23 Apr 2025 17:48:42 -0700
Message-ID: <20250424004934.598783-98-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


