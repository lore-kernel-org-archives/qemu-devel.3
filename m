Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C76EC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6Iz-0002Fr-WC; Mon, 22 Jul 2024 23:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6Iv-0002Bo-6R
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:11 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6Ip-0001kc-WE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:08 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6659e81bc68so52243477b3.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705700; x=1722310500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afR5Mh7AuJ+l97gjVcHTy2tuYfmOnsauTdcz7zi2zaI=;
 b=imMlddUMOwjwA6Pm1fYb3YtpGYemVnbZEbt1q5b2kglFugItnitziWgbDsYNBuy2ka
 SMzHaNzmooHxgjDazPOD+QxUqyStvdmX2VH76B144S9z5YCFGfDqx3Yu59C+MevhxRXB
 pxFPba10jBmVv325TY15NsWLaZPZM0j/IW9gxU9khIRsonwDlGKwlhQCOdX9ZlQQ5jEe
 2zXb4RJaL0Xq9s0oM0RR+MdQCCCktirrDzGOZqTuOpcEoX2WYaZi9dACXTdybtR+LRzd
 1KtGv806WzLERdSAkbhb0zjQqq9YboE1WXBsh4rKF2vGXUikv5tQ+FH0QZaT3M1kCkG1
 KFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705700; x=1722310500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=afR5Mh7AuJ+l97gjVcHTy2tuYfmOnsauTdcz7zi2zaI=;
 b=jL/v61mcookhWoHxjLZF6NVkJNgAwh6CXQZtNJ2hyn/e1lZgtWPuJjwIK2qA36g+ZT
 /Pl6st+FHByhdkM4UH0i5gHGUyvFoCs1wyfU3GELslQkAuDSJqgi5jxm/TodYQZz83yT
 NUCKIyyR6fD1XWmj1DWmqze/fVUvPPujTtFVWJ5oxar4VDoXsPgY2sklZKcKt2grljlA
 qlYQb/6kFQ+0/g+5+bxKSxtJ2vv0ADpjhZ9VQ6ifqbm8MgzsgOtkOJXtvoAucVgw0eAW
 vlUgiyqHg/mcPtN4EYf0Pqmrl+wB8H8dgW6jr+lhWyt4RqVdwktFF3PXr9+kPx95Oi2q
 TvmQ==
X-Gm-Message-State: AOJu0YwIx2zPWPpDZobH5n+bz4cRR86M2pXW0h20vMMfHfwrh/RJm1tT
 1FK/q9KvkkLx4PsQNCL+gaiAAPXehlg/1MaPe2PrKQxst8o8CKK4FW2XiB6PQ3GTVVzYUi6RDFn
 xlZB1XQ==
X-Google-Smtp-Source: AGHT+IGg0Bi0Og+aYHlptA18vLJmrCKVPQ6whU19jrHq1QqppRZqExUNw56Zb7IyfkRYlW7cEOipHw==
X-Received: by 2002:a05:690c:3208:b0:62f:2553:d3b3 with SMTP id
 00721157ae682-66ada1fc141mr105800277b3.29.1721705700204; 
 Mon, 22 Jul 2024 20:35:00 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:34:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 01/12] accel/tcg: Move {set,
 clear}_helper_retaddr to cpu_ldst.h
Date: Tue, 23 Jul 2024 13:34:40 +1000
Message-ID: <20240723033451.546151-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1132.google.com
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

Use of these in helpers goes hand-in-hand with tlb_vaddr_to_host
and other probing functions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-retaddr.h | 28 ----------------------------
 include/exec/cpu_ldst.h  | 34 ++++++++++++++++++++++++++++++++++
 accel/tcg/cpu-exec.c     |  3 ---
 accel/tcg/user-exec.c    |  1 -
 4 files changed, 34 insertions(+), 32 deletions(-)
 delete mode 100644 accel/tcg/user-retaddr.h

diff --git a/accel/tcg/user-retaddr.h b/accel/tcg/user-retaddr.h
deleted file mode 100644
index e0f57e1994..0000000000
--- a/accel/tcg/user-retaddr.h
+++ /dev/null
@@ -1,28 +0,0 @@
-#ifndef ACCEL_TCG_USER_RETADDR_H
-#define ACCEL_TCG_USER_RETADDR_H
-
-#include "qemu/atomic.h"
-
-extern __thread uintptr_t helper_retaddr;
-
-static inline void set_helper_retaddr(uintptr_t ra)
-{
-    helper_retaddr = ra;
-    /*
-     * Ensure that this write is visible to the SIGSEGV handler that
-     * may be invoked due to a subsequent invalid memory operation.
-     */
-    signal_barrier();
-}
-
-static inline void clear_helper_retaddr(void)
-{
-    /*
-     * Ensure that previous memory operations have succeeded before
-     * removing the data visible to the signal handler.
-     */
-    signal_barrier();
-    helper_retaddr = 0;
-}
-
-#endif
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 71009f84f5..dac12bd8eb 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -379,4 +379,38 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
                         MMUAccessType access_type, int mmu_idx);
 #endif
 
+/*
+ * For user-only, helpers that use guest to host address translation
+ * must protect the actual host memory access by recording 'retaddr'
+ * for the signal handler.  This is required for a race condition in
+ * which another thread unmaps the page between a probe and the
+ * actual access.
+ */
+#ifdef CONFIG_USER_ONLY
+extern __thread uintptr_t helper_retaddr;
+
+static inline void set_helper_retaddr(uintptr_t ra)
+{
+    helper_retaddr = ra;
+    /*
+     * Ensure that this write is visible to the SIGSEGV handler that
+     * may be invoked due to a subsequent invalid memory operation.
+     */
+    signal_barrier();
+}
+
+static inline void clear_helper_retaddr(void)
+{
+    /*
+     * Ensure that previous memory operations have succeeded before
+     * removing the data visible to the signal handler.
+     */
+    signal_barrier();
+    helper_retaddr = 0;
+}
+#else
+#define set_helper_retaddr(ra)   do { } while (0)
+#define clear_helper_retaddr()   do { } while (0)
+#endif
+
 #endif /* CPU_LDST_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9010dad073..8163295f34 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -41,9 +41,6 @@
 #include "tb-context.h"
 #include "internal-common.h"
 #include "internal-target.h"
-#if defined(CONFIG_USER_ONLY)
-#include "user-retaddr.h"
-#endif
 
 /* -icount align implementation. */
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 80d24540ed..7ddc47b0ba 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -33,7 +33,6 @@
 #include "tcg/tcg-ldst.h"
 #include "internal-common.h"
 #include "internal-target.h"
-#include "user-retaddr.h"
 
 __thread uintptr_t helper_retaddr;
 
-- 
2.43.0


