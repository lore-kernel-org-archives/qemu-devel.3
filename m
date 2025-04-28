Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A811FC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UoQ-0005B7-5Y; Mon, 28 Apr 2025 16:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoK-00059O-A5
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:40 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoI-0000dc-8L
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:40 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so5354687b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871036; x=1746475836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+n4RhIHR0cuxbPipMJgmtXxRf5dTdpav7njhLYYg6Y=;
 b=M2Qd+1bUoXnfiS5F1pRKb3nrOk0oNkZnRm0nF4yx49GIwr5ts7fhbsLhQwmEXCUBlN
 EcuetWwcxgXaN3XJYvHrQZkINZF53+Vd1yzOr3BTuA89cxoQrRtEDCpGgYrA/Og3Sxpc
 9JAccPfr94fOGWcRNbQ3OGwnFnhWTB6VoEYtL7aPNmIpZQcmmPOHMXyaP7AS8eILC/w6
 Ju1YSvnO8XB/xklaYg4NMA2+YQR4UCDlfqQ2yEOybnjXmHpudnFq2Ne1OicecB8h+/km
 B8QJvaSXne/dIKWfLMIwhevHEAgeB7mBeQa+3UbkEi1rsmqXnyxJL1YviEFnlKa8MdiI
 +DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871036; x=1746475836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+n4RhIHR0cuxbPipMJgmtXxRf5dTdpav7njhLYYg6Y=;
 b=kB0BxQXFCGVennkTNorwBZ+dXPTrA6b4rw3ncwKh/c6WzyfX545JUTWN5CHowYds7n
 hXdxpgN+9/Uuyhsdp1hDp2BkWmET7zkWywawrcZW0GEitixNWuRCl08qERyVjrnHG0I3
 YHQSWVIPqo854Uo3p/E76Y+VDqGp+TLGdTTDT/ZFwEr0QSZNJ88VOVuCDybBA0rjhSf+
 MBvl+OrqIcGCd0kpkVIZT5HYcrCVqYFkH1Se/Spf8H1ZVbGhOhtNhZUD2RcFpf4KaA/L
 5KKtUNOAmFv/0PqiJhONN9+MMJw9q03CWpEJb7ndhBjiXz7xmPK1Tl5AaHjpYDNW8qjQ
 fgOg==
X-Gm-Message-State: AOJu0YxfhSRXaDUPQ/B7FHE2N5CDjjF0C55+R28cc6Xcu+CVIURvXocb
 0Zp4pNi7XrB0QxtXUutHptUKNp/gS2nuD3Tq6IlNndiG9dgKj4ioh3Q0+JvOtOowUY/xMavNWpX
 J
X-Gm-Gg: ASbGncteMP2C+mF2++vJCkv7C1AtKDw0kqfpgU6vsRlmemU3TldP3UII6BRuQWzZS99
 OpJqreq7gzhRXYtXG1ttgbyMPQlL0e1rz3V7g56elytHzHGOm476ZI90x9o8zQDhBmbbbpXlOIe
 B79KOHnxm+tiSBwRWd5jcbJ513v5kCITMF4/VnPlkNryeSzky1SxOt4CVNYMdsESqydUlDiUWGh
 6gYQxTCxGAXvK1Z27kv3dxljMYfK8nVMqh6bpRH0QPQN3ITOP368+98oCVCtcBdbzCv0YT3YGI/
 zQQeuXKauE0GOWaDC19P6NoOOudEgqVFB2o3myRGHMXj1/lCyVkMZ2RJapVLqhWDe4gX3TAAUKI
 =
X-Google-Smtp-Source: AGHT+IFVpRoLxclrgt5s4dny2egrp3qe0W3jejM6MlhEG/6N9GznS1fhf+L9qm6bc9iUuS6uKvdWdA==
X-Received: by 2002:a05:6a00:1706:b0:73e:23be:11fc with SMTP id
 d2e1a72fcca58-7402722f838mr1310115b3a.22.1745871036468; 
 Mon, 28 Apr 2025 13:10:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912fb9sm8469976b3a.34.2025.04.28.13.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:10:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 09/10] accel/tcg: Split out accel/tcg/helper-retaddr.h
Date: Mon, 28 Apr 2025 13:10:27 -0700
Message-ID: <20250428201028.1699157-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428201028.1699157-1-richard.henderson@linaro.org>
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Move set_helper_retaddr and clear_helper_retaddr
to a new header file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ldst.h       | 34 -----------------------
 include/accel/tcg/helper-retaddr.h | 43 ++++++++++++++++++++++++++++++
 accel/tcg/cpu-exec.c               |  1 +
 accel/tcg/user-exec.c              |  1 +
 target/arm/tcg/helper-a64.c        |  1 +
 target/arm/tcg/sme_helper.c        |  1 +
 target/arm/tcg/sve_helper.c        |  1 +
 target/ppc/mem_helper.c            |  1 +
 target/s390x/tcg/mem_helper.c      |  1 +
 9 files changed, 50 insertions(+), 34 deletions(-)
 create mode 100644 include/accel/tcg/helper-retaddr.h

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index f97a730703..44a62b54da 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -526,38 +526,4 @@ void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
                         MMUAccessType access_type, int mmu_idx);
 #endif
 
-/*
- * For user-only, helpers that use guest to host address translation
- * must protect the actual host memory access by recording 'retaddr'
- * for the signal handler.  This is required for a race condition in
- * which another thread unmaps the page between a probe and the
- * actual access.
- */
-#ifdef CONFIG_USER_ONLY
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
-#else
-#define set_helper_retaddr(ra)   do { } while (0)
-#define clear_helper_retaddr()   do { } while (0)
-#endif
-
 #endif /* ACCEL_TCG_CPU_LDST_H */
diff --git a/include/accel/tcg/helper-retaddr.h b/include/accel/tcg/helper-retaddr.h
new file mode 100644
index 0000000000..037fda2b83
--- /dev/null
+++ b/include/accel/tcg/helper-retaddr.h
@@ -0,0 +1,43 @@
+/*
+ * Get user helper pc for memory unwinding.
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_HELPER_RETADDR_H
+#define ACCEL_TCG_HELPER_RETADDR_H
+
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
+#endif /* ACCEL_TCG_HELPER_RETADDR_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index a10a2c5f29..985abb1269 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -24,6 +24,7 @@
 #include "hw/core/cpu.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/cpu-common.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 70feee8df9..68e01fc584 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -26,6 +26,7 @@
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "user/cpu_loop.h"
 #include "qemu/main-loop.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 9cffda07cd..4f618ae390 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -30,6 +30,7 @@
 #include "qemu/crc32c.h"
 #include "exec/cpu-common.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 3226895cae..de0c6e54d4 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "qemu/int128.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9f20ecb51d..a2c363a4e1 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -30,6 +30,7 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/probe.h"
 #ifdef CONFIG_USER_ONLY
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index aa1af44d22..6ab71a6fcb 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "helper_regs.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "internal.h"
 #include "qemu/atomic128.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 857005b120..a03609a140 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -32,6 +32,7 @@
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
 
-- 
2.43.0


