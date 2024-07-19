Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60713C3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc66-0003Um-AL; Thu, 18 Jul 2024 21:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc5i-0002oV-8f
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:23 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc5f-0000iO-Pl
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:21 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70b4267ccfcso337600b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721351238; x=1721956038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afR5Mh7AuJ+l97gjVcHTy2tuYfmOnsauTdcz7zi2zaI=;
 b=G3tdhOtNah+qVrGYaT8h6SC2Kj/UFyjRvVJbmESmHs4vtAq0uXh1OKPBUw3my3tKPn
 gJI6OP4KBrXxcUeqdBVnyzq0LAVE3UQ0EpYf/xdfohB8EmAKGkoBWEzMYVg1nlwm1SJ4
 MRsP43a94jhFSP5PQztMlIG17RrWAsJMMRKiwHhlDwl3BfqritYC7Uwtg1OCqU9VPVqD
 iMDEvL1RocXmdEuk3EEtUOkVC84/nAqChzYc48AeaS4mC2+goDPlWtuYQxnOtp1tnT+X
 DfJZ9E5s12hc810FcFP7umTaBn8dXhPPN0Kos0H74uSx2OB9MMU8uUyRnvd4pjb1zZ2p
 rGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721351238; x=1721956038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=afR5Mh7AuJ+l97gjVcHTy2tuYfmOnsauTdcz7zi2zaI=;
 b=rFHOqQZDW7sWqmnnQ8ROJ07dTbv/Mqjp+PJaoeoJuQWbh+5jzQD1XQXHqXeYlA8nK1
 FWdt2KbuTQXazAezT6GY+ZT14x1BFjipTV08KEAFpadFvhXKm5Kzuzg5Lw3NYnW4Vk6d
 MHKZv3OdjwE5IikF2gZ4pJP4LXSo6hgi9NfvzQNhO7UvvrsMgI0diXsZIiLgY5N4ZuA1
 RFNvaPWBmaN/0o8xlEigVVPDpOEXjZjewxCF5TFEFINx2GYa/XWrbbLzpd8ZTl1YpvyJ
 pmfb3ewBBW6kEXdcz3CIgLLJUmssBO46Zi9TOa46tixT88TIzgP4INHP/VKah1q7ur4f
 xbOg==
X-Gm-Message-State: AOJu0Yw7nbAR/Cm/cDN9hbWPOPksMUbi5CqKJPbKU0lr1Iw9L8ZnJcvB
 ifTGXmByWTPQaQiTRYeHxAfEkcVBBFz4MTzd2s/ksgM4VE+ylEEoQVgZlW1VlD78dPhOLs1EB4G
 QNeX3zg==
X-Google-Smtp-Source: AGHT+IEN8c8ycEDlgr59LbvMcJDMUbZM15uorvPF9CFw5qQGTbXo+Q6cI7SQ5JeKHUzsWBQerzDTLQ==
X-Received: by 2002:a05:6a21:4d8a:b0:1c3:cfc2:2b1f with SMTP id
 adf61e73a8af0-1c3fdd4d424mr6815533637.37.1721351237977; 
 Thu, 18 Jul 2024 18:07:17 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d07ad9sm2067415ad.177.2024.07.18.18.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 18:07:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 01/12] accel/tcg: Move {set,
 clear}_helper_retaddr to cpu_ldst.h
Date: Fri, 19 Jul 2024 11:06:56 +1000
Message-ID: <20240719010707.1319675-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719010707.1319675-1-richard.henderson@linaro.org>
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


