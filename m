Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839E2C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsZ-0007Uw-86; Fri, 07 Mar 2025 13:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsO-0007RM-PE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:52 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsM-0007lG-PC
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:52 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fecba90cc3so4573505a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373809; x=1741978609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZWYvDukaHCKn8Evm+7YplK9ZxqRKLhmL0oVaH6y4jI=;
 b=Fya8TKmlPnOFMdrlY5Bhma/yZnzm6/Hshr/iKiiwsjXQUOD2ogmJtHD0Es3I1nvjp6
 kzHoZUXDLDe28ywR4SyDTRiBPXDJlI7ULgEyQemBJv73j4D3LM70wokD24XVDfpgNelY
 ghLcAexY4WxTyFAVSODsON7FBZVgiY93BX8SaqxvDLh0iuEa54zsJ4e7xJOcZAI2OPZx
 Q4lfmIJw/A6kkAchBYPHkoBWl+kJmEwWDk1ZrWU5A0EO3JDYaKFpoixbYJ74KYZv0fSW
 IiMPcxiPN4m2PW+lustG5SaKpYY7qdg84Rvzs9vPRco9XQGO0jCCZNZVq3bU0knAR5kj
 IIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373809; x=1741978609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZWYvDukaHCKn8Evm+7YplK9ZxqRKLhmL0oVaH6y4jI=;
 b=ci+VbYz1Pz8KupIy72B2z1SsQeBcelDP6qIoCDH/OpYyB5/s/GACpO5ztDZP6dQgeL
 JRz3d5J3BN6SD6tUORc1dooz79o//9jsrVsff4lG+g+lRT6TN/VWZDXcY2HlSZTIPfFg
 IFU0iZqlFCrN34W+7a0IlgAajmKWUPexo0ksrmLftwy5m7b6WHW1lnReJOc9z9lztzZr
 CB5wzqto4MgZoLogVsGppWeRQ51yrH24LKupGZiTjF7yswWGgdiJzE/LM7KHNUg5UdGr
 VMJncybgI6PNCIJ/JcJrtOjmfzslyqqxw4lFuh/DfcFP9Ev1JgTe88Bxw6OYGTwBHFp+
 L+Gw==
X-Gm-Message-State: AOJu0YwOBu1SzEZq1yKj+BVoki+K2FJbEN1RTnW/d+0JmbYWu3VZL7ai
 xTbAJBSfqp4vVD4+KyER1XXWWskYc4j7GaPMVBhE0uolmUnwtmqdmAsERZC2lgUWkuxiboNt2f0
 U
X-Gm-Gg: ASbGncsZWaTmGRyL54QUr/8eNX5hAgVm9KwOYMcu1YJOLvrWaoFCvEwD6XEx2r2G2U/
 8SpIzBLkjOlphQLIAQx4vdtpvz+DEb8Iw2Ra7JodZLgKRIszvm48FV0hk2WZ9IwyJ9GT2Brg0d7
 9BOJ1O+UHyrvWqYOIM16g/1wi5RwTaGB7Hur3I1kUrrTcyMFTJv2ykd49cXILb6GxC1BBYi60Pz
 j/gkaUGK0xaBo/c1nMINakew0FlbkbVSOSbjnPV9TC+0C1BtKmRNjED9DCn8uEloqxmEtPK8f/F
 EHmHcBUUT3FXkwkeKhUMXZl9ZxUuup2MiR+vPfkwUQcCkXnBQB4ef1ZIaezRbAk+4flSFei3YQ2
 4
X-Google-Smtp-Source: AGHT+IE70cx2fqD7V7rU/8JSAY/C0kQV5m7e0A7i4hqb43Jwd+uMX0sHLExq9eVPeIE2MqTMGU+pcA==
X-Received: by 2002:a17:90b:4c:b0:2ff:6a5f:9b39 with SMTP id
 98e67ed59e1d1-2ff7ce844b6mr8226390a91.18.1741373808901; 
 Fri, 07 Mar 2025 10:56:48 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 01/16] include/exec: Split out exec/cpu-interrupt.h
Date: Fri,  7 Mar 2025 10:56:30 -0800
Message-ID: <20250307185645.970034-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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


