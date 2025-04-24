Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B603FC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kvs-0002tq-2P; Wed, 23 Apr 2025 20:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktW-0005uH-SQ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktU-00056M-KQ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2295d78b45cso6761825ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456207; x=1746061007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/MtxezZDzd5ayKGwSKtUCDFVjLPy/nFfpXlQklcK64=;
 b=TSc/FloaBoaepsFrI2RKCj+PBQdIB1WFOGWkdnHbO5PcA/3TEz5aXsf/HYBgFhYbzt
 uAvegi9k6xkXT7maELmhLrIcuHVd/ioWFVs/e0gPc5J7fBor4oLackb+i3J4Yd96TaeU
 NwuH/ZZbnHeryvfJwPt7fxkbVk5TtZKp+FvsWQKluY7HOB2+amtWzFXjNDDkD3gfJAO3
 MukuSrFBQ3qZcrrprMhefAEbu05X/93n6Gz5nMjXD+Gd5IFF12MNLye6EKEAWifFQNOq
 7RqsmYf83bUNIGA0Vjrd9Ef1tfkBJZLRSenQpHxjvbAQLlQJ6jfapk0NsM3KCxiTAvf1
 xYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456207; x=1746061007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K/MtxezZDzd5ayKGwSKtUCDFVjLPy/nFfpXlQklcK64=;
 b=p6JKLFzXxIXskqdWD8kzicFXeyNoe9jL7/QhZT+1Fe3/0MPN0514Qj1l6L5ER9/Dc3
 ciVbjsjGcOUV6zczO3XTpx5iznarcBunPrQMuUEKsST79xl94FjTzpkAYDXYS6qEe3YD
 etcJAHm/SWmRROOGo/38MYWtIVXKo4+0xlWO7rvCKXWG9QzwKMbWBSRvGjFKUYvJjSMl
 kMG0yoXydVdp2pD1mlXSSy0IN1Mk0JhSn0lrMKczZ/uhGBuVET50zxZk11h/7XnZENpc
 SiCYYwSE3OwECgMy3ufCDbWbXF/joxmdYmd+HklceqoE3Bi86eA+pzNjimceQoeJ2uSo
 Em5g==
X-Gm-Message-State: AOJu0YwnsPVJcsBBv26hdBAhE7OYF6UFZlZaV8ZN8fr8oQvpZFW3AaE3
 ETx2N1AMB8FS8FK57B+M0e/7PVBRLOPxXvPkX+OH682GR8Aki7fkLef2rD0th3TYNlF79rL/GIo
 o
X-Gm-Gg: ASbGncuxB2TcvXHAG6xRICansOBV964Wf8rHt1EYsGiZa9vfJYC4T8zDNoGZoi4kiVI
 BsFPDSsh0rhRPHJvUaTbN304qgYuQcmCzU/0aPDCu8rFYwKGPABFbkAWUacyPel0GW9dyFGQMLQ
 8UbD18AQ57a7x7ebYJ0QBhqvDKY5zm7jFhdbx+gl+K1Oi4dkV1nTPH4d8ZOluIqtasrb1IwA5n4
 2DDZDPywOxhv7nX9lqMY7YcCRGwFGY+0HfQt+pRI8/BNfQvdt1lg/nDvLfPlm0qtA5HQAx8MXAF
 kp9FV/FKi7OpP+uTJZmqCQgI4qYwYerNvodwSyCp+sPORQHD9SJs0lrMEzxBWl03N3F+wj2/lUQ
 =
X-Google-Smtp-Source: AGHT+IGzZ+LQkfeABjk+z4RNsmFHFZvWWVz9AX8hzygEWT32tkmJay9WXAzR3n7fJUVEFpkg0UcK5Q==
X-Received: by 2002:a17:903:3c50:b0:21f:85ee:f2df with SMTP id
 d9443c01a7336-22db3bd0f26mr9474845ad.15.1745456206833; 
 Wed, 23 Apr 2025 17:56:46 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 098/148] include/exec: Redefine tlb-flags with absolute values
Date: Wed, 23 Apr 2025 17:48:43 -0700
Message-ID: <20250424004934.598783-99-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Don't base the values on TARGET_PAGE_BITS_MIN, but do verify
that TLB_FLAGS_MASK does not overlap minimum page size.
All targets now have the same placement for these flags,
simplifying mmu management when we enable heterogeneous systems.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tlb-flags.h | 68 +++++++++++++++++++---------------------
 accel/tcg/cputlb.c       |  2 ++
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
index 54a6bae768..357e79095c 100644
--- a/include/exec/tlb-flags.h
+++ b/include/exec/tlb-flags.h
@@ -19,54 +19,29 @@
 #ifndef TLB_FLAGS_H
 #define TLB_FLAGS_H
 
-#include "exec/cpu-defs.h"
+/*
+ * Flags returned for lookup of a TLB virtual address.
+ */
 
 #ifdef CONFIG_USER_ONLY
 
 /*
- * Allow some level of source compatibility with softmmu.  We do not
- * support any of the more exotic features, so only invalid pages may
- * be signaled by probe_access_flags().
+ * Allow some level of source compatibility with softmmu.
+ * Invalid is set when the page does not have requested permissions.
+ * MMIO is set when we want the target helper to use the functional
+ * interface for load/store so that plugins see the access.
  */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
-#define TLB_WATCHPOINT      0
+#define TLB_INVALID_MASK     (1 << 0)
+#define TLB_MMIO             (1 << 1)
+#define TLB_WATCHPOINT       0
 
 #else
 
-/*
- * Flags stored in the low bits of the TLB virtual address.
- * These are defined so that fast path ram access is all zeros.
- * The flags all must be between TARGET_PAGE_BITS and
- * maximum address alignment bit.
- *
- * Use TARGET_PAGE_BITS_MIN so that these bits are constant
- * when TARGET_PAGE_BITS_VARY is in effect.
- *
- * The count, if not the placement of these bits is known
- * to tcg/tcg-op-ldst.c, check_max_alignment().
- */
-/* Zero if TLB entry is valid.  */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-/*
- * Set if TLB entry references a clean RAM page.  The iotlb entry will
- * contain the page physical address.
- */
-#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
-/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
-#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 3))
-
-/*
- * Use this mask to check interception with an alignment mask
- * in a TCG backend.
- */
-#define TLB_FLAGS_MASK \
-    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_FORCE_SLOW)
-
 /*
  * Flags stored in CPUTLBEntryFull.slow_flags[x].
  * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
  */
+
 /* Set if TLB entry requires byte swap.  */
 #define TLB_BSWAP            (1 << 0)
 /* Set if TLB entry contains a watchpoint.  */
@@ -82,6 +57,27 @@
     (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED | \
      TLB_DISCARD_WRITE | TLB_MMIO)
 
+/*
+ * Flags stored in CPUTLBEntry.addr_idx[x].
+ * These must be above the largest alignment (64 bytes),
+ * and below the smallest page size (1024 bytes).
+ * This leaves bits [9:6] available for use.
+ */
+
+/* Zero if TLB entry is valid.  */
+#define TLB_INVALID_MASK     (1 << 6)
+/* Set if TLB entry references a clean RAM page.  */
+#define TLB_NOTDIRTY         (1 << 7)
+/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
+#define TLB_FORCE_SLOW       (1 << 8)
+
+/*
+ * Use this mask to check interception with an alignment mask
+ * in a TCG backend.
+ */
+#define TLB_FLAGS_MASK \
+    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_FORCE_SLOW)
+
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a717f357d5..39314e86f3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -49,6 +49,8 @@
 #endif
 #include "tcg/tcg-ldst.h"
 
+QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
+
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
 /* #define DEBUG_TLB_LOG */
-- 
2.43.0


