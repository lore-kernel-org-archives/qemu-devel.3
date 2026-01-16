Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEA3D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgabq-0007jF-Gi; Thu, 15 Jan 2026 22:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabo-0007Wn-VC
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:48 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabn-0005pn-1l
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:48 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-29efd139227so10002765ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534486; x=1769139286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9G7CRzjGckeYSeIr9MRvFLtIOKXPKdQ7GnAe48PSp8=;
 b=ZsVF9FHCLDdhJWXp/C67NKAQF7rs70zfudqzclBqQ740b+s2dTdxtHgUuEn3KcdH0S
 Ce9Sff0cRJEKI+So2+ODTRwctm7M3jF+lptvth3VbvrkWq/hVVMX2lBb1i9Kef/B3wZK
 e5a5mVzAkTsAJ9+Uym5ToIyYNGFLoxBKV5fryhgULF6j7fVNECcJJxvRjSPDnxAxR6tR
 d9uMNhQGNNziffv5lvL8o4pRDhlf8Skh3fdTh/ALoIAzBZzso/pP1BstVab2KZ45cB5u
 /qawJpfsWxk83vepaX7LZQiPIQVhhrfvpxi/Ux0AaS+hvEVU1b83JIPzomg32ayBo0SP
 iVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534486; x=1769139286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C9G7CRzjGckeYSeIr9MRvFLtIOKXPKdQ7GnAe48PSp8=;
 b=P8nPv8k8XGYPwJQSvqWLoyoPldG//GI0cjsoOJMmxJ+/7EQhobDD1T3h02P19lCXou
 YH6RbIR5hMVe/qcmdsgzmAD9uluCwIubMqeNGGeQz2EbzSspIp9a7qrrfWhZet6Bunjt
 xTjMl6+MDiXNJm3HS53r5E5N44hdERDRk7hqG5IVCikPNGlsR/ZYcfBmLuFz7QsPa1j7
 neqEajrQU7auPIiGKHGrrJ7E1WSlKj1RuNPn3XidzgevDKPEinrCl6JgnSC9BogLo2tp
 DKn/z9+cN1RmxjTzapTaUPPRJh1f6KiYSbTteLINbfU8cfaGk0F4EeAN6EdiPG48I6KF
 0A7w==
X-Gm-Message-State: AOJu0YxdMrfbSjE0eufVdE8CIBjo/OfTrycdg1JfALioErpvgTtw6pdk
 48nO+eelS14L1+ICVzJMdM3FA7x5Se5enoX90Qii0LLJMEobus+kPm3kf45dLDBAssZmACxjaKa
 xyXbGRuOboA==
X-Gm-Gg: AY/fxX7jYudMTRKRSCb466Vdm4+MImm8ZBre6kUP0agRFqtXNLnlWmFZ5rIM29pWg/N
 knWQcNZu/DTm70vvXr7S3tjGx56f29IjLslk0ZQx9Q6xtXs3TknNn1MY1x6bKp2oAUNNJezA3pg
 B5Lv38R2KpCr3ICuR3YagD0DOdb7B+wRF+o4BX0kywiQDaxbpe07iQYH37S0ovEMay6I3OQ0H70
 oZqqW16LTwCqEbRzm0ZQQHa/bxsNl9k/1dut7MHchcd/a54co4sb1F5vjQplIp/iAkC37kuFvm1
 P7Ku7JAl5T8ChCKidRjoXhnSqx4nKaRo+iUw2sSYkMOo3LAU+Hkf1nVSvkgqD1ibE8+gdMIgnNL
 yzppQ5e5R1p6DrL2LKJEDPXkV8CEvt4hxrcs/3amN3omTXYqhh3a6VwN5TFUm419zcmDjmKeo0x
 45vIuDuphJvKE3p6M2IQ==
X-Received: by 2002:a17:902:f652:b0:269:8d1b:40c3 with SMTP id
 d9443c01a7336-2a71888abfdmr15869545ad.12.1768534485534; 
 Thu, 15 Jan 2026 19:34:45 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 23/58] tcg: Make TCG_TARGET_REG_BITS common
Date: Fri, 16 Jan 2026 14:32:29 +1100
Message-ID: <20260116033305.51162-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since we only support 64-bit hosts, there's no real need
to parameterize TCG_TARGET_REG_BITS.  It seems worth holding
on to the identifier though, for documentation purposes.

Move one tcg/*/tcg-target-reg-bits.h to tcg/target-reg-bits.h
and remove the others.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/helper-info.h                     |  2 +-
 .../tcg/target-reg-bits.h                     |  8 +++----
 include/tcg/tcg.h                             |  2 +-
 tcg/aarch64/tcg-target-reg-bits.h             | 12 -----------
 tcg/loongarch64/tcg-target-reg-bits.h         | 21 -------------------
 tcg/mips64/tcg-target-reg-bits.h              | 16 --------------
 tcg/riscv64/tcg-target-reg-bits.h             | 19 -----------------
 tcg/s390x/tcg-target-reg-bits.h               | 17 ---------------
 tcg/sparc64/tcg-target-reg-bits.h             | 12 -----------
 tcg/tci/tcg-target-reg-bits.h                 | 18 ----------------
 tcg/x86_64/tcg-target-reg-bits.h              | 16 --------------
 11 files changed, 6 insertions(+), 137 deletions(-)
 rename tcg/ppc64/tcg-target-reg-bits.h => include/tcg/target-reg-bits.h (71%)
 delete mode 100644 tcg/aarch64/tcg-target-reg-bits.h
 delete mode 100644 tcg/loongarch64/tcg-target-reg-bits.h
 delete mode 100644 tcg/mips64/tcg-target-reg-bits.h
 delete mode 100644 tcg/riscv64/tcg-target-reg-bits.h
 delete mode 100644 tcg/s390x/tcg-target-reg-bits.h
 delete mode 100644 tcg/sparc64/tcg-target-reg-bits.h
 delete mode 100644 tcg/tci/tcg-target-reg-bits.h
 delete mode 100644 tcg/x86_64/tcg-target-reg-bits.h

diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 49a27e4eae..d5bda83a2e 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -24,7 +24,7 @@
 #include <ffi.h>
 #pragma GCC diagnostic pop
 #endif
-#include "tcg-target-reg-bits.h"
+#include "tcg/target-reg-bits.h"
 
 #define MAX_CALL_IARGS  7
 
diff --git a/tcg/ppc64/tcg-target-reg-bits.h b/include/tcg/target-reg-bits.h
similarity index 71%
rename from tcg/ppc64/tcg-target-reg-bits.h
rename to include/tcg/target-reg-bits.h
index 3a15d7bee4..8f4ad3ed99 100644
--- a/tcg/ppc64/tcg-target-reg-bits.h
+++ b/include/tcg/target-reg-bits.h
@@ -7,10 +7,10 @@
 #ifndef TCG_TARGET_REG_BITS_H
 #define TCG_TARGET_REG_BITS_H
 
-#ifndef _ARCH_PPC64
-# error Expecting 64-bit host architecture
-#endif
-
+/*
+ * We only support 64-bit hosts now.
+ * Retain the identifier for documentation.
+ */
 #define TCG_TARGET_REG_BITS  64
 
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a6d9aa50d4..067150c542 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -31,7 +31,7 @@
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "tcg/tcg-mo.h"
-#include "tcg-target-reg-bits.h"
+#include "tcg/target-reg-bits.h"
 #include "tcg-target.h"
 #include "tcg/tcg-cond.h"
 #include "tcg/insn-start-words.h"
diff --git a/tcg/aarch64/tcg-target-reg-bits.h b/tcg/aarch64/tcg-target-reg-bits.h
deleted file mode 100644
index 3b57a1aafb..0000000000
--- a/tcg/aarch64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Define target-specific register size
- * Copyright (c) 2023 Linaro
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-#define TCG_TARGET_REG_BITS  64
-
-#endif
diff --git a/tcg/loongarch64/tcg-target-reg-bits.h b/tcg/loongarch64/tcg-target-reg-bits.h
deleted file mode 100644
index 51373ad70a..0000000000
--- a/tcg/loongarch64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2021 WANG Xuerui <git@xen0n.name>
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-/*
- * Loongson removed the (incomplete) 32-bit support from kernel and toolchain
- * for the initial upstreaming of this architecture, so don't bother and just
- * support the LP64* ABI for now.
- */
-#if defined(__loongarch64)
-# define TCG_TARGET_REG_BITS 64
-#else
-# error unsupported LoongArch register size
-#endif
-
-#endif
diff --git a/tcg/mips64/tcg-target-reg-bits.h b/tcg/mips64/tcg-target-reg-bits.h
deleted file mode 100644
index ee346a3f25..0000000000
--- a/tcg/mips64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2008-2009 Arnaud Patard <arnaud.patard@rtp-net.org>
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-#if !defined(_MIPS_SIM) || _MIPS_SIM != _ABI64
-# error "Unknown ABI"
-#endif
-
-#define TCG_TARGET_REG_BITS 64
-
-#endif
diff --git a/tcg/riscv64/tcg-target-reg-bits.h b/tcg/riscv64/tcg-target-reg-bits.h
deleted file mode 100644
index 761ca0d774..0000000000
--- a/tcg/riscv64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2018 SiFive, Inc
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-/*
- * We don't support oversize guests.
- * Since we will only build tcg once, this in turn requires a 64-bit host.
- */
-#if __riscv_xlen != 64
-#error "unsupported code generation mode"
-#endif
-#define TCG_TARGET_REG_BITS 64
-
-#endif
diff --git a/tcg/s390x/tcg-target-reg-bits.h b/tcg/s390x/tcg-target-reg-bits.h
deleted file mode 100644
index b01414e09d..0000000000
--- a/tcg/s390x/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2009 Ulrich Hecht <uli@suse.de>
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-/* We only support generating code for 64-bit mode.  */
-#if UINTPTR_MAX == UINT64_MAX
-# define TCG_TARGET_REG_BITS 64
-#else
-# error "unsupported code generation mode"
-#endif
-
-#endif
diff --git a/tcg/sparc64/tcg-target-reg-bits.h b/tcg/sparc64/tcg-target-reg-bits.h
deleted file mode 100644
index 34a6711013..0000000000
--- a/tcg/sparc64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2023 Linaro
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-#define TCG_TARGET_REG_BITS  64
-
-#endif
diff --git a/tcg/tci/tcg-target-reg-bits.h b/tcg/tci/tcg-target-reg-bits.h
deleted file mode 100644
index dcb1a203f8..0000000000
--- a/tcg/tci/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2009, 2011 Stefan Weil
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-#if UINTPTR_MAX == UINT32_MAX
-# define TCG_TARGET_REG_BITS 32
-#elif UINTPTR_MAX == UINT64_MAX
-# define TCG_TARGET_REG_BITS 64
-#else
-# error Unknown pointer size for tci target
-#endif
-
-#endif
diff --git a/tcg/x86_64/tcg-target-reg-bits.h b/tcg/x86_64/tcg-target-reg-bits.h
deleted file mode 100644
index fc3377e829..0000000000
--- a/tcg/x86_64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2008 Fabrice Bellard
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-#ifdef __x86_64__
-# define TCG_TARGET_REG_BITS  64
-#else
-# error
-#endif
-
-#endif
-- 
2.43.0


