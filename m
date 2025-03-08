Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BE5C28B25
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38x-0004q2-Jr; Sat, 08 Mar 2025 17:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38Q-0004X5-Fh
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:10 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38O-0005Ka-3o
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:09 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223594b3c6dso54087205ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474746; x=1742079546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ky+UumnxoIb+tnFry+ljy4Y3+GeAuN7ZJzdcCFzcPCY=;
 b=FuJ6GJPsIFnwjls7icYgZPqyl+X2Oce/Az9nrMy04hsdAG9F8LP89IekRIvD3uS6x9
 5fxRvmQp37+8WwuRVooxh4lRcgdilKQqBDvrsjC2A6NIeFKrgj3xw7ZBNxMWrlQk5SUr
 OtxVNsjuTRwVbHK96ne3zX5RIot/DUgPdGkHMdkw/7kSIkj2lEYmclR0iNiIpmaol0/R
 ++r/iE2LpGc7/mTdzOl8TEOsuGUtH0Jo3YFcW4ZUVDLfBVNXTtfAtmD1mZpseyXE/KAA
 7M//i3QcebgEGUjuezSHX1FEY5X+8XUEoRhzxjua6h9bQHq+79YxaDIevJ0wfIf5EyuS
 UymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474746; x=1742079546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ky+UumnxoIb+tnFry+ljy4Y3+GeAuN7ZJzdcCFzcPCY=;
 b=E493kJBbV2UVMiqLRRf8DdRKGlV2cyRg1pRCQ2SRwcaOR6MfGJnZbBn3OIjWBrLRUe
 I8Z97pHLgRqerP7cesFJjJLOjaH5zdfXzhMODa/YIKwarU6NIX8Lrn7W5KJFpUixcm/7
 zLcd89CZO5SQ8GeuhYdxjGahZ27khAPGMvcG2VpkXChdk7+rma8AXfFHyBtOYEnvRfME
 4Z6ay0Bl44BH6QpRqcfBi3MBfbvEzUrvHKHmI0zphTIlPXmURPG2y+efdOpLHoVwu04K
 BZ4sue/qanTva00HtI6zGRTHIn+4plnO6xwT7BAt6a8VK2zNKvJv12FGE2RWd3bvqapn
 ovRg==
X-Gm-Message-State: AOJu0YwaOxGB7rReSr4KlPVLxSoU/KJf5xNRLL2I9k/FfUFE1dk8wUMe
 3dBBJii0NqcmZvTpkrvNt54wN36G9MaMyvACUCL7xvs1MBsxN3r3LcZ0SnUvHFHpffCaCrKhMtl
 F
X-Gm-Gg: ASbGncu0IZK5aaaAEc14F87jrprD4ZfeIGGxUB5XK/MOuDrSVIAx878ITir1yIqLcCn
 5inpTvvUDZrJrUByJWdBlaly/LNNw1JxQ9tguWbXY8riVsej9U/JJ/z+yVtCuBm4U0qW/eMJ0Kl
 l4i1t7KmtldD+c/nnXzhVWOupCKsF2S23Y8p6bQ/XolBR96p5KL8gUYBoaI4VE/iMnmAKAw77Mg
 RBCtnYW6M5YZx2+1AjU4+S/R64su3o0kfPX4B309lkoCj0hILR0tl/hJRshJFSyG+eSlBGrVBpZ
 jkfqrfVDi4x5ChSDKLn4zN+b5F7CNhu/0B3gnTRioqwM2Sj0nC8R5V8uH0sV7d3HPojzxQn4xSA
 i
X-Google-Smtp-Source: AGHT+IFjKwsfVD0gnzdJNZ+j5TUlBOdLicA0dRSRk+xAM5b96YMOPZKnUcxue0QSUiNK5AbrgDJ6Rw==
X-Received: by 2002:a17:902:cccf:b0:224:194c:694c with SMTP id
 d9443c01a7336-22428aaeb6dmr169373625ad.28.1741474746633; 
 Sat, 08 Mar 2025 14:59:06 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/23] include/exec: Split out exec/cpu-interrupt.h
Date: Sat,  8 Mar 2025 14:58:43 -0800
Message-ID: <20250308225902.1208237-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Some of these bits are actually common to all cpus; while the
reset have common reservations for target-specific usage.
While generic code cannot know what the target-specific usage is,
common code can know what to do with the bits, e.g. single-step.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h       | 53 +--------------------------
 include/exec/cpu-interrupt.h | 70 ++++++++++++++++++++++++++++++++++++
 include/exec/poison.h        | 13 -------
 3 files changed, 71 insertions(+), 65 deletions(-)
 create mode 100644 include/exec/cpu-interrupt.h

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8f7aebb088..9e6724097c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -21,6 +21,7 @@
 
 #include "exec/page-protection.h"
 #include "exec/cpu-common.h"
+#include "exec/cpu-interrupt.h"
 #include "exec/memory.h"
 #include "exec/tswap.h"
 #include "hw/core/cpu.h"
@@ -109,58 +110,6 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 
 CPUArchState *cpu_copy(CPUArchState *env);
 
-/* Flags for use in ENV->INTERRUPT_PENDING.
-
-   The numbers assigned here are non-sequential in order to preserve
-   binary compatibility with the vmstate dump.  Bit 0 (0x0001) was
-   previously used for CPU_INTERRUPT_EXIT, and is cleared when loading
-   the vmstate dump.  */
-
-/* External hardware interrupt pending.  This is typically used for
-   interrupts from devices.  */
-#define CPU_INTERRUPT_HARD        0x0002
-
-/* Exit the current TB.  This is typically used when some system-level device
-   makes some change to the memory mapping.  E.g. the a20 line change.  */
-#define CPU_INTERRUPT_EXITTB      0x0004
-
-/* Halt the CPU.  */
-#define CPU_INTERRUPT_HALT        0x0020
-
-/* Debug event pending.  */
-#define CPU_INTERRUPT_DEBUG       0x0080
-
-/* Reset signal.  */
-#define CPU_INTERRUPT_RESET       0x0400
-
-/* Several target-specific external hardware interrupts.  Each target/cpu.h
-   should define proper names based on these defines.  */
-#define CPU_INTERRUPT_TGT_EXT_0   0x0008
-#define CPU_INTERRUPT_TGT_EXT_1   0x0010
-#define CPU_INTERRUPT_TGT_EXT_2   0x0040
-#define CPU_INTERRUPT_TGT_EXT_3   0x0200
-#define CPU_INTERRUPT_TGT_EXT_4   0x1000
-
-/* Several target-specific internal interrupts.  These differ from the
-   preceding target-specific interrupts in that they are intended to
-   originate from within the cpu itself, typically in response to some
-   instruction being executed.  These, therefore, are not masked while
-   single-stepping within the debugger.  */
-#define CPU_INTERRUPT_TGT_INT_0   0x0100
-#define CPU_INTERRUPT_TGT_INT_1   0x0800
-#define CPU_INTERRUPT_TGT_INT_2   0x2000
-
-/* First unused bit: 0x4000.  */
-
-/* The set of all bits that should be masked when single-stepping.  */
-#define CPU_INTERRUPT_SSTEP_MASK \
-    (CPU_INTERRUPT_HARD          \
-     | CPU_INTERRUPT_TGT_EXT_0   \
-     | CPU_INTERRUPT_TGT_EXT_1   \
-     | CPU_INTERRUPT_TGT_EXT_2   \
-     | CPU_INTERRUPT_TGT_EXT_3   \
-     | CPU_INTERRUPT_TGT_EXT_4)
-
 #include "cpu.h"
 
 #ifdef CONFIG_USER_ONLY
diff --git a/include/exec/cpu-interrupt.h b/include/exec/cpu-interrupt.h
new file mode 100644
index 0000000000..40715193ca
--- /dev/null
+++ b/include/exec/cpu-interrupt.h
@@ -0,0 +1,70 @@
+/*
+ * Flags for use with cpu_interrupt()
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef CPU_INTERRUPT_H
+#define CPU_INTERRUPT_H
+
+/*
+ * The numbers assigned here are non-sequential in order to preserve binary
+ * compatibility with the vmstate dump.  Bit 0 (0x0001) was previously used
+ * for CPU_INTERRUPT_EXIT, and is cleared when loading the vmstate dump.
+ */
+
+/*
+ * External hardware interrupt pending.
+ * This is typically used for interrupts from devices.
+ */
+#define CPU_INTERRUPT_HARD        0x0002
+
+/*
+ * Exit the current TB.  This is typically used when some system-level device
+ * makes some change to the memory mapping.  E.g. the a20 line change.
+ */
+#define CPU_INTERRUPT_EXITTB      0x0004
+
+/* Halt the CPU.  */
+#define CPU_INTERRUPT_HALT        0x0020
+
+/* Debug event pending.  */
+#define CPU_INTERRUPT_DEBUG       0x0080
+
+/* Reset signal.  */
+#define CPU_INTERRUPT_RESET       0x0400
+
+/*
+ * Several target-specific external hardware interrupts.  Each target/cpu.h
+ * should define proper names based on these defines.
+ */
+#define CPU_INTERRUPT_TGT_EXT_0   0x0008
+#define CPU_INTERRUPT_TGT_EXT_1   0x0010
+#define CPU_INTERRUPT_TGT_EXT_2   0x0040
+#define CPU_INTERRUPT_TGT_EXT_3   0x0200
+#define CPU_INTERRUPT_TGT_EXT_4   0x1000
+
+/*
+ * Several target-specific internal interrupts.  These differ from the
+ * preceding target-specific interrupts in that they are intended to
+ * originate from within the cpu itself, typically in response to some
+ * instruction being executed.  These, therefore, are not masked while
+ * single-stepping within the debugger.
+ */
+#define CPU_INTERRUPT_TGT_INT_0   0x0100
+#define CPU_INTERRUPT_TGT_INT_1   0x0800
+#define CPU_INTERRUPT_TGT_INT_2   0x2000
+
+/* First unused bit: 0x4000.  */
+
+/* The set of all bits that should be masked when single-stepping.  */
+#define CPU_INTERRUPT_SSTEP_MASK \
+    (CPU_INTERRUPT_HARD          \
+     | CPU_INTERRUPT_TGT_EXT_0   \
+     | CPU_INTERRUPT_TGT_EXT_1   \
+     | CPU_INTERRUPT_TGT_EXT_2   \
+     | CPU_INTERRUPT_TGT_EXT_3   \
+     | CPU_INTERRUPT_TGT_EXT_4)
+
+#endif /* CPU_INTERRUPT_H */
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 35721366d7..8ed04b3108 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -46,19 +46,6 @@
 
 #pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
 
-#pragma GCC poison CPU_INTERRUPT_HARD
-#pragma GCC poison CPU_INTERRUPT_EXITTB
-#pragma GCC poison CPU_INTERRUPT_HALT
-#pragma GCC poison CPU_INTERRUPT_DEBUG
-#pragma GCC poison CPU_INTERRUPT_TGT_EXT_0
-#pragma GCC poison CPU_INTERRUPT_TGT_EXT_1
-#pragma GCC poison CPU_INTERRUPT_TGT_EXT_2
-#pragma GCC poison CPU_INTERRUPT_TGT_EXT_3
-#pragma GCC poison CPU_INTERRUPT_TGT_EXT_4
-#pragma GCC poison CPU_INTERRUPT_TGT_INT_0
-#pragma GCC poison CPU_INTERRUPT_TGT_INT_1
-#pragma GCC poison CPU_INTERRUPT_TGT_INT_2
-
 #pragma GCC poison CONFIG_ALPHA_DIS
 #pragma GCC poison CONFIG_HPPA_DIS
 #pragma GCC poison CONFIG_I386_DIS
-- 
2.43.0


