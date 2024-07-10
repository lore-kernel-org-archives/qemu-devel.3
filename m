Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3F2C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 03:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRO0N-0008Pz-11; Tue, 09 Jul 2024 23:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0G-0008BH-QN
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:24 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0A-0003hT-VA
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:24 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70b0013cf33so4155629b3a.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 20:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720582097; x=1721186897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByDJpGTONoGP2rmXxeNWIrC+a/ufe7ypFp2it50e4Uc=;
 b=COjCasmTkIByz0TEkqukcYdWwYE1oNEGbARKS56ZoNPpen1ilvQWQQhcGwvltz5sQf
 ObAXqX7RJcVNqjumEfNkyO+5eqgYYu0zNzV6AKmct45xbkUzA+nSNMVSYhxxbJnxonEg
 pzQsbwb0LT0+5LhvVD+5Io6U6zAFkCGNoiZT5ut8Xf+wpt+Z3NZQ/yPjK2shoL089yKh
 Q7XpqLpCQl3ljwe/jVB7gLpXMWcrOxvqaj3+lriWVYp5GK5JlLqSh3MYHaK1tDrGIhV4
 Stskipdy2tYW0CaaMdtUH7yeHVcjdfwHpJVppj1LSKG7FNCaqYZXUv851s5lhFswXTXZ
 lz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720582097; x=1721186897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ByDJpGTONoGP2rmXxeNWIrC+a/ufe7ypFp2it50e4Uc=;
 b=DPePlUHBZhV/We99aUygeX2XCT+x2jM3WNXau98+m7proVWBzBycpcOwf+QpNrmLp+
 15MliDQl1YnnprCk8dqasZ1Fag6Yh+NmsTko5i4RgESNUEAp0GWLR4uKt4UPJyAD8Hvm
 kfdgArUqfoayb9JuQlxot3MJ2J3W3kUOkDHW+Glr7+dlfdV6VjW0UlutDQurAc2fsrz9
 5IOm8CF5vhzorYavzK4gCweP2tAVlXvYPDw17e/HPNmI86GW6jrY96HXMQMB1F0Muw3i
 lIerUZnjP+yunj6+f5x9BDU/kuY1d7romruQjrrcB5dpBFRsqyriNk0yY8FL36Pm+VF2
 +4Cw==
X-Gm-Message-State: AOJu0Yztj06kw2EEYhpLYrEQ+HqGK5Wt8D2SwFw6wdxJVxOmQ40PHjx7
 25Do4JqXI+qUg3uiKFmXZH2g3ph4WD0bhHJI+58Vh5KyC7vEBz+l5Jz0IJkfrUQ42egdraZDz8D
 F3/Q=
X-Google-Smtp-Source: AGHT+IFNRPg6klpjzm7zPQE2KkEYFhn0dLdOAgMNOVgAHVjoOaDpvZQlg/981SQ4fDLNlfnIdvj5BQ==
X-Received: by 2002:a05:6a00:4650:b0:706:6af8:e081 with SMTP id
 d2e1a72fcca58-70b434f6421mr4961422b3a.1.1720582097269; 
 Tue, 09 Jul 2024 20:28:17 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438f5679sm2687280b3a.90.2024.07.09.20.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 20:28:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, max.chou@sifive.com
Subject: [PATCH v2 01/13] accel/tcg: Move {set,
 clear}_helper_retaddr to cpu_ldst.h
Date: Tue,  9 Jul 2024 20:28:02 -0700
Message-ID: <20240710032814.104643-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710032814.104643-1-richard.henderson@linaro.org>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
index 6711b58e0b..0aa42591bf 100644
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


