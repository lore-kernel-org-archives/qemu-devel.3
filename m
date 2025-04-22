Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5618AC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQh-0000b4-Rt; Tue, 22 Apr 2025 15:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP1-0005B4-DT
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:31 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOy-00074a-Hi
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:30 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224171d6826so79658355ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350526; x=1745955326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyKtevNAmC2eZUOXDG2VlAgB8+znbswT4cFJTBgj39o=;
 b=bZJFr79w4boekFPjMKLY2mvuyr+RjISeO/Drdn+Hu/pe+9U3o0t5Ref/5ZRAfCBC1E
 WsPamYgkzgadMIwec+Bl4t8DhEnwX0S4CGxasB5GMiTHkUQOnuXXymYTj7LufMb5JRgj
 UPgMqoy4S3qvb0f3X6593XAnSJmE7flm19jH9yn5cNXYF1PPz39n1GWa27brjuSKPErL
 2dCvkZtP9LngHCt1D1KwE9eKQudLzIP0/eaH1hvmuEOAnHA8UFp+z2RnMIv0pgRvfKvA
 SPKY7YgXn1ol2bsEZ0VaBas6qJweXirtpB0OA436x4sg2ik22U6LBjYI9/v+WmVoZOUd
 +q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350526; x=1745955326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XyKtevNAmC2eZUOXDG2VlAgB8+znbswT4cFJTBgj39o=;
 b=MAr0njnGuSIlAVEBTJoVxGPAGQ3H3lerFGrPAl9YxaWKzuDBQr6f6pLFyBgwCyxLyk
 agJ4SKD4vYjxdUkmZKJ8vJhHGpXIfLibS1t/rGI+6BYPGjwPUCOAz+6svtvHWlyqQ/Wy
 7EowIfwAwCzkiRPGZFHqfdtU6LiJKOpUR3X+yBachBQw/UYFAFHcLbS9UOvZ9aARss5X
 hXz2E76C9F8dKOsCsY+vSHhZNtfjtsddU7wYesiYaT/blVWEfjhQrkl2+VmCQs9nVkcb
 hHai0Mk968EG/QrLhFo0JlJ8lsM7Er3ve7f9A7AYFpS1b4ivmP8AH24KeQzrZDJhfHL6
 Ankg==
X-Gm-Message-State: AOJu0YwKN1ErujXlDBu0KvZAHH7HFtdMVlQvHCCMz5LCym3ZCGpd+/h6
 KnOWDns994GuseRXoLmESklt46toOjxpGApovLY+6+BqJbqu+n/qBVykOI1e0WAknZjVL8tnm84
 n
X-Gm-Gg: ASbGncuGZpEDixW6OYm0V3462VbT7Wdy81o75otZcv3o25wvBtjuDPLoIT5qiI33iXu
 FlLkzk+ir5v5pk0/oOuB1ByeK0Vog0SX2Hhj3VdAs2doOYYKpRPh4ExXPUAACtSzW+mqUuOMXap
 xmcEIBqiE6mZBJZGPbpB4RGi4K/b36iV28136Xcv1Lww9eYW4BbBqwkjc7XJnJ9CNLBtraZNNes
 DyX7uz2Lxz1AcDkgjyoJSsln1RChOfL5xQN7PdgcwDWXETPwKDNT3ddlANsAEVV6vUNUijsIG9H
 enbeT1l/oTPL5m8pH9rt95DKyzCHfh7ytDnPNH4OF9+IjupS61kekWJqeTFbY27rYh691xPA5D8
 =
X-Google-Smtp-Source: AGHT+IFJ54L200hTGpkePGGV3r7BnF6R8RDsNMcgyQGtv82Q3FKUD0UOQN1VjGrrDU4m0OQnFh2tCA==
X-Received: by 2002:a17:903:2410:b0:220:be86:a421 with SMTP id
 d9443c01a7336-22c536050f6mr274854035ad.38.1745350526017; 
 Tue, 22 Apr 2025 12:35:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 100/147] page-vary: Restrict scope of TARGET_PAGE_BITS_MIN
Date: Tue, 22 Apr 2025 12:27:29 -0700
Message-ID: <20250422192819.302784-101-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


