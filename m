Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733D0C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFxB-0002wD-BT; Fri, 28 Mar 2025 16:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFx3-0002uD-LH
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:13 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFx1-0007pF-GF
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:13 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72bccda48cbso1630576a34.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743192310; x=1743797110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIJnvFGOy/E91AR0rUZiWO2SS/DFBq2FPcdK2nKCqCw=;
 b=du8PeL0367oSlx7zeR74gbDC8Z0w1l6dprdO4/OZcQ0X8tUAMp2SslfTgpTZSUUhyX
 9zxgNx4S7jmW0AfYy4rN90R6dWj7O2LtoV6Ut20JfdCPB6F8x8mEgmPELJi4JuHQRHZc
 nMNKGkVFykFe8wFxExnoLzc0vuWwJrvlmeVV4ShTQ2ut7sbIFs3OxW3cHDh+ZJhV1DCv
 8LmYmVKb9PqCYEX8Zfhwfo/cgdS8RoCLP+7gU4cyOfGViR1JhxBECKkzCioW1jHTPy+h
 gX8OHkCpckh8PTKYA2vewqthudhxuE2ElAUt7c1jRjirxhDK4BWjdjR3QAjioJonOq/a
 5zJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192310; x=1743797110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIJnvFGOy/E91AR0rUZiWO2SS/DFBq2FPcdK2nKCqCw=;
 b=aRtzKVNai1m+Xey4GSrjTVy1kR9ocRGT1mRRCErF9yW+tUkPuX+xbzqVAKMllTvQ6M
 dZ3SYmJBle4PuZBy6yZnzypxWa6lJaAdn/rvOZTRxL6pnNI7AB13ePVV1zXKTc0bH2qn
 YVQr8VKV7NnbjI+mzA/4GCLqI227r7bauqYXJdcJAGXIsdlf3lP75vEXsC77EzoodHS8
 myR9Njj3NS0jz53FxoOIYZR6an0E6ngNpDYVMvyu9WScaRTwFnP8BeNDdiANHJdMIich
 qowh0zJHEag8CyUUeENtLII2batLza+QODTXZvidRLflyM8jKOSAk1oDE4xqu+oUDHKi
 ahUQ==
X-Gm-Message-State: AOJu0Yz4A8KEOGU/K7Wf+Khwos96f+IpaxngSVQpKG69lWBAbdzJf6/O
 tm87Gk6ezKNM7bPaVlQ2tAPwog5COpdJ3vYId9J/h4dTqjuuWXxQeOrbp0B6H9o/JA4RfjyRPJg
 W
X-Gm-Gg: ASbGncv9XUCWisS9tQWGdKL9BksZyuYQp8QPD1EMbwnC5kFk9edWO5Ovho6AFCmRqRO
 2OWlOBdyIzCZ9mlnpLo3FcGCgD1q19bJBKNOBoIiyOXNCVusZmXfa6heN8pXvR3g3ROi3LIILzW
 atgpDZ8THQ8BlidL74QBIvUSeUbwscHbnscHDJLloCS7+tR0EKXtrFH2NKOr6NOgc3S8/HCGgpa
 5j+QK9Yd4L+ceW1z+linWTmI/ummYQ8eheyfkQw3MHDbTr3L2DcrBUnhZzHm4qTNzZgvcXh0c4t
 j8vXTQLeDlgr4i4xVGrPubwgrABLkfDSWZY3hiSCCIKiZArvJV9pRl91uijh3r85kVNWW8Sj3N1
 XHXpq3w4/LbA=
X-Google-Smtp-Source: AGHT+IEr6oM1WtuEN0j/TYxW8or0zlVD+RxwNVZAhOKVsuDEmIiewVYPQysb0a3owB4ymSvzRRlHMQ==
X-Received: by 2002:a05:6808:1c0a:b0:3fa:7909:271f with SMTP id
 5614622812f47-3ff0f50470dmr594640b6e.5.1743192309554; 
 Fri, 28 Mar 2025 13:05:09 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff052799b6sm465104b6e.37.2025.03.28.13.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 13:05:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 9/9] page-vary: Restrict scope of TARGET_PAGE_BITS_MIN
Date: Fri, 28 Mar 2025 15:04:59 -0500
Message-ID: <20250328200459.483089-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328200459.483089-1-richard.henderson@linaro.org>
References: <20250328200459.483089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

The only place we really need to know the minimum is within
page-vary-target.c.  Rename the target/arm TARGET_PAGE_BITS_MIN
to TARGE_PAGE_BITS_LEGACY to emphasize what it really means.
Move the assertions related to minimum page size as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h    | 10 ++--------
 include/exec/poison.h      |  1 +
 include/exec/target_page.h |  1 -
 include/qemu/osdep.h       |  6 ++++++
 target/alpha/cpu-param.h   |  1 -
 target/arm/cpu-param.h     |  3 +--
 target/ppc/cpu-param.h     |  1 -
 accel/tcg/cputlb.c         |  1 -
 page-vary-target.c         | 39 +++++++++++++++++++++++++++++++++++---
 9 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 9f955f53fd..e01acb7c90 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -34,14 +34,8 @@
 #ifndef TARGET_VIRT_ADDR_SPACE_BITS
 # error TARGET_VIRT_ADDR_SPACE_BITS must be defined in cpu-param.h
 #endif
-#ifndef TARGET_PAGE_BITS
-# ifdef TARGET_PAGE_BITS_VARY
-#  ifndef TARGET_PAGE_BITS_MIN
-#   error TARGET_PAGE_BITS_MIN must be defined in cpu-param.h
-#  endif
-# else
-#  error TARGET_PAGE_BITS must be defined in cpu-param.h
-# endif
+#if !defined(TARGET_PAGE_BITS) && !defined(TARGET_PAGE_BITS_VARY)
+# error TARGET_PAGE_BITS must be defined in cpu-param.h
 #endif
 
 #include "exec/target_long.h"
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 4180a5a489..c4f7ee22bf 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -44,6 +44,7 @@
 #pragma GCC poison TARGET_FMT_lu
 
 #pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
+#pragma GCC poison TARGET_PAGE_BITS_LEGACY
 
 #pragma GCC poison CONFIG_ALPHA_DIS
 #pragma GCC poison CONFIG_HPPA_DIS
diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index e4bd7f7767..ca0ebbc8bb 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -41,7 +41,6 @@ extern const TargetPageBits target_page;
 # endif
 # define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
 #else
-# define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 # define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
 # define TARGET_PAGE_MASK    ((TARGET_PAGE_TYPE)-1 << TARGET_PAGE_BITS)
 #endif
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4397a90680..321a52d7f0 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -50,6 +50,12 @@
  */
 #pragma GCC poison TARGET_WORDS_BIGENDIAN
 
+/*
+ * TARGET_PAGE_BITS_MIN was repaced by TARGET_PAGE_BITS_LEGACY
+ * for system mode.  Prevent it from creeping back in.
+ */
+#pragma GCC poison TARGET_PAGE_BITS_MIN
+
 #include "qemu/compiler.h"
 
 /* Older versions of C++ don't get definitions of various macros from
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index ff06e41497..63989e71c0 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -18,7 +18,6 @@
  * a 4k minimum to match x86 host, which can minimize emulation issues.
  */
 # define TARGET_PAGE_BITS_VARY
-# define TARGET_PAGE_BITS_MIN 12
 # define TARGET_VIRT_ADDR_SPACE_BITS  63
 #else
 # define TARGET_PAGE_BITS 13
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 896b35bd6d..a7ae42d17d 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -24,7 +24,6 @@
 # else
 /* Allow user-only to vary page size from 4k */
 #  define TARGET_PAGE_BITS_VARY
-#  define TARGET_PAGE_BITS_MIN  12
 # endif
 # else
 #  define TARGET_PAGE_BITS 12
@@ -35,7 +34,7 @@
  * have to support 1K tiny pages.
  */
 # define TARGET_PAGE_BITS_VARY
-# define TARGET_PAGE_BITS_MIN  10
+# define TARGET_PAGE_BITS_LEGACY 10
 #endif /* !CONFIG_USER_ONLY */
 
 /* ARM processors have a weak memory model */
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 6c4525fdf3..553ad2f4c6 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -33,7 +33,6 @@
 #ifdef CONFIG_USER_ONLY
 /* Allow user-only to vary page size from 4k */
 # define TARGET_PAGE_BITS_VARY
-# define TARGET_PAGE_BITS_MIN 12
 #else
 # define TARGET_PAGE_BITS 12
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 39314e86f3..0de46903dd 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -49,7 +49,6 @@
 #endif
 #include "tcg/tcg-ldst.h"
 
-QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
diff --git a/page-vary-target.c b/page-vary-target.c
index 6251d948cf..d83f9a6a90 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -23,19 +23,45 @@
 #include "exec/page-vary.h"
 #include "exec/target_page.h"
 
+
+/*
+ * For system mode, the minimum comes from the number of bits
+ * required for maximum alignment (6) and the number of bits
+ * required for TLB_FLAGS_MASK (3).
+ *
+ * For user mode, TARGET_PAGE_BITS_VARY is a hack to allow the target
+ * page size to match the host page size.  Mostly, this reduces the
+ * ordinary target page size to run on a host with 4KiB pages (i.e. x86).
+ * There is no true minimum required by the implementation, but keep the
+ * same minimum as for system mode for sanity.
+ * See linux-user/mmap.c, mmap_h_lt_g and mmap_h_gt_g.
+ */
+#define TARGET_PAGE_BITS__MIN 9
+
+#ifndef TARGET_PAGE_BITS_VARY
+QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS__MIN);
+#endif
+
+#ifndef CONFIG_USER_ONLY
+#include "exec/tlb-flags.h"
+
+QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS__MIN) - 1));
+
 int migration_legacy_page_bits(void)
 {
 #ifdef TARGET_PAGE_BITS_VARY
-    return TARGET_PAGE_BITS_MIN;
+    QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS_LEGACY < TARGET_PAGE_BITS__MIN);
+    return TARGET_PAGE_BITS_LEGACY;
 #else
     return TARGET_PAGE_BITS;
 #endif
 }
+#endif
 
 bool set_preferred_target_page_bits(int bits)
 {
+    assert(bits >= TARGET_PAGE_BITS__MIN);
 #ifdef TARGET_PAGE_BITS_VARY
-    assert(bits >= TARGET_PAGE_BITS_MIN);
     return set_preferred_target_page_bits_common(bits);
 #else
     return true;
@@ -44,5 +70,12 @@ bool set_preferred_target_page_bits(int bits)
 
 void finalize_target_page_bits(void)
 {
-    finalize_target_page_bits_common(TARGET_PAGE_BITS_MIN);
+#ifndef TARGET_PAGE_BITS_VARY
+    finalize_target_page_bits_common(TARGET_PAGE_BITS);
+#elif defined(CONFIG_USER_ONLY)
+    assert(target_page.bits != 0);
+    finalize_target_page_bits_common(target_page.bits);
+#else
+    finalize_target_page_bits_common(TARGET_PAGE_BITS_LEGACY);
+#endif
 }
-- 
2.43.0


