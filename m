Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913A1C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kw5-0003F3-NG; Wed, 23 Apr 2025 20:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktY-0005uk-Iw
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:56 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktV-00056o-MJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:51 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so364618b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456208; x=1746061008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyKtevNAmC2eZUOXDG2VlAgB8+znbswT4cFJTBgj39o=;
 b=sxURF97R7u7y6a/NKrFbcgoheEz3GuczlEuMdKAZto62dDpZdL6I2i7tLAxv/TB5DO
 0LWqq0L5dicBdzeBHavSRA44HahNKsRoCgasWTN871vdNCcJjwPsS569nKE/eE3uXY9j
 rbhthvPVzf54o6yJFLMAz+jFIqaLlY5xCOm1a1Pe9wJUVHVbldZLETrvRF50j6Z4Qrky
 TiM4k76XJ2JiTuh0nHWgMuV5FwYuydW/KeI3LYJXhxwPHjvqR26omWNATpyyis+FfVOD
 0PuD0KYvqt4zhLbL95Qb+B713SI/DRz3CBszL7xlnDvK8Y2KoiNOL0HQlVjSHwAU1ukb
 Ep0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456208; x=1746061008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XyKtevNAmC2eZUOXDG2VlAgB8+znbswT4cFJTBgj39o=;
 b=dbA6fmbI3Mkuxv8ffbT7eNrasiru1hkd3jYApehFOkuFfJ7Wygwt8pv/u1D0RUBOUv
 6X+Lhf4YvwF17IuhNxXnpJ2xURsnYPBQ52G3gTNBxgO8JeybS02qP1MyyPynPdyAvkbl
 /VtBrdcG6FfSWO3z0PZpvyNLX/xSwYXLbr7HAek8KLG4FANnmj0pXihRlIBQMvxWmtOo
 p+ntTyuP3ii9ukkqRdDIEDQtvgeFrwd4O31vSxBGeXuAqvh53+72TMZp4MSkZlPx7UgY
 5DDHR1CRCWwBuqjZiQw4m+rWID/cDt9OhTIkMDPpzjGDuneiEF3FcoezdbR3oLzWHe4O
 hNNA==
X-Gm-Message-State: AOJu0Yyrlu0+Nb5V2rhFr14qeFgBRQMmk1J59CQKXK0Z7nFB5GuU6xsD
 xo/g5FF9CUlBYC929a7b6JGrM9EVL57TaS4UkJghc9ctOPIQDsWeOb+/Olomi44yJ+rWHEKf8zd
 W
X-Gm-Gg: ASbGncuB3ZyXoB8qSIi4D0A9YNUAtRSkNOsdrCxFT6fYzN9SgAH4qu+Z6kYyIXNwGaA
 4MIAvcPAHueWNd0otRXgfezPtobPNR1O4FuM9m5z+lz8O2xz45uh5xnBC+PD2cRI094Y6i7p2X/
 h6/x+r4xrtNE9uW/c9HOuQcZrsFUzkBeNkPFFqUaOHIHMqzlaxivbFRot8NdcOopFruXUKYdkkI
 d7NlxnSiT/YpVN7/tL4xPQWEpQXrzHxZ+5oYezU9zdhoKM5hcrb8tltTO5VqyhSOUNRv2ghQ3JL
 fqNCn6WCCfaS1cEOMu8Auajas6v6omwOGvta6JGSe4I2QkPMaQbT1CrPKYGqbqQGoHGN6A9fWbU
 =
X-Google-Smtp-Source: AGHT+IH6+I8eRwLggFsODUtk2xQZ7e//3suL7gmnQkprKrQb1U7gVUb+/ywd1Q8LUHu7eCVAFfz12A==
X-Received: by 2002:a05:6a20:c6cb:b0:1f5:63f9:9eb4 with SMTP id
 adf61e73a8af0-20444fd40c9mr955156637.35.1745456208393; 
 Wed, 23 Apr 2025 17:56:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 100/148] page-vary: Restrict scope of TARGET_PAGE_BITS_MIN
Date: Wed, 23 Apr 2025 17:48:45 -0700
Message-ID: <20250424004934.598783-101-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
to TARGET_PAGE_BITS_LEGACY to emphasize what it really means.
Move the assertions related to minimum page size as well.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h    | 10 ++--------
 include/exec/target_page.h |  1 -
 target/alpha/cpu-param.h   |  1 -
 target/arm/cpu-param.h     |  3 +--
 target/ppc/cpu-param.h     |  1 -
 accel/tcg/cputlb.c         |  1 -
 page-vary-target.c         | 39 +++++++++++++++++++++++++++++++++++---
 7 files changed, 39 insertions(+), 17 deletions(-)

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
index 6251d948cf..49a32b4fe5 100644
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
+#define TARGET_PAGE_BITS_MIN 9
+
+#ifndef TARGET_PAGE_BITS_VARY
+QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
+#endif
+
+#ifndef CONFIG_USER_ONLY
+#include "exec/tlb-flags.h"
+
+QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
+
 int migration_legacy_page_bits(void)
 {
 #ifdef TARGET_PAGE_BITS_VARY
-    return TARGET_PAGE_BITS_MIN;
+    QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS_LEGACY < TARGET_PAGE_BITS_MIN);
+    return TARGET_PAGE_BITS_LEGACY;
 #else
     return TARGET_PAGE_BITS;
 #endif
 }
+#endif
 
 bool set_preferred_target_page_bits(int bits)
 {
-#ifdef TARGET_PAGE_BITS_VARY
     assert(bits >= TARGET_PAGE_BITS_MIN);
+#ifdef TARGET_PAGE_BITS_VARY
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


