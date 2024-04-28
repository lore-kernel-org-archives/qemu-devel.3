Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79B2C25B10
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 21:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CPl-0003Ax-F0; Sun, 28 Apr 2024 17:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPi-00035V-J7
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:50:27 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPW-0001JO-0n
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:50:26 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso4807725a12.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714341010; x=1714945810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0n+ImpRw4HIvF2HMD0Mqry3BChMB8K31XsSyFCMilH8=;
 b=l/j7oLb6VBJricJ7aSp9NlbvLArVslOrxKocx4ulcOEWruW71vDibugY66SmscOnRZ
 MbUsUdLFlUYtrqwNawduWqrlMtUGoNCOYH2bKG2joHbFusL7+uc7csAMNRggKyPC8MFT
 nHEG1FkCh5o32eY5y8AIjQXRsnuODeJlapA5vjUTBGUDuDymsTsjuaNqs6JC27fgrfQU
 GGyIj4xiuVYr2x3G+J4fapqeeGld6hz184GggNDlxF+QWijDCTpiLrImTMsbsJhncfVg
 WmPid0b7YrhF/MwuqlY3bFsGhB10jqTLQEbUbhPgArFUNEc6SasbVKrXtVlgumAynrqq
 M4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714341010; x=1714945810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0n+ImpRw4HIvF2HMD0Mqry3BChMB8K31XsSyFCMilH8=;
 b=XskhTnGKPRmFXC5ZB84erNMvclDbITItgMuRGZyGLjBUuLc2yI7K5RAOMCvOwspnNB
 uDBvMk6GC8g5TGwJDry0///r+ron/PvO1qSP+oo/kQz8U+gk8b/cmCV8xE5k8NNKCGDL
 e3BCcNyQ1o04UIrBtmtSou2UO9tuSm3lWshTKGYvjMQ0xrvjOuRUZDdJrPqRdXuXFl6T
 K2I67SoyvHootJmG3X7bfba3uBjer9ViSVGBNXnqN4CkKcNVEi00H4hSxbMREaN+RK2Z
 09lUjs2aD0bGwI/a8yKsNNFlQN83SOe+/zfAi8SrZ+R58ucPR3upn0nIMODuvZqywHFS
 r/WA==
X-Gm-Message-State: AOJu0YyD5Uv6Sr13rtc6QjbydNIdzN2LQ+pNZcSy0wlJPrmLK0MmozPh
 beKS3/mlgtdJSWcIg12NVQMjVGcBJafelqnjKwqXsshuzixV7m7TMrJjEyZGvJoNRd0PiLIcGdD
 T
X-Google-Smtp-Source: AGHT+IGSWeifh3Lv5EF0o0K0SXk2o+AFID6PNmICHRfvw0hLoJDLJJ/23GfPhcTdLCJn6oE+IIJ12A==
X-Received: by 2002:a50:d752:0:b0:572:727f:d0db with SMTP id
 i18-20020a50d752000000b00572727fd0dbmr2475784edj.15.1714341010733; 
 Sun, 28 Apr 2024 14:50:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 i32-20020a0564020f2000b005723bcad44bsm4472844eda.41.2024.04.28.14.50.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 14:50:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/12] accel/tcg: Restrict cpu_loop_exit_requested() to TCG
Date: Sun, 28 Apr 2024 23:49:12 +0200
Message-ID: <20240428214915.10339-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428214915.10339-1-philmd@linaro.org>
References: <20240428214915.10339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

cpu_loop_exit_requested() is specific to TCG, move it
to "exec/translate-all.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/exec-all.h       | 17 -----------------
 include/exec/translate-all.h  | 20 ++++++++++++++++++++
 target/arm/tcg/helper-a64.c   |  1 +
 target/s390x/tcg/mem_helper.c |  1 +
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4c5e470581..2be7ef1809 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -29,23 +29,6 @@
 #include "exec/translation-block.h"
 #include "qemu/clang-tsa.h"
 
-/**
- * cpu_loop_exit_requested:
- * @cpu: The CPU state to be tested
- *
- * Indicate if somebody asked for a return of the CPU to the main loop
- * (e.g., via cpu_exit() or cpu_interrupt()).
- *
- * This is helpful for architectures that support interruptible
- * instructions. After writing back all state to registers/memory, this
- * call can be used to check if it makes sense to return to the main loop
- * or to continue executing the interruptible instruction.
- */
-static inline bool cpu_loop_exit_requested(CPUState *cpu)
-{
-    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
-}
-
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* cputlb.c */
 /**
diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
index 85c9460c7c..dd26f70378 100644
--- a/include/exec/translate-all.h
+++ b/include/exec/translate-all.h
@@ -19,8 +19,28 @@
 #ifndef TRANSLATE_ALL_H
 #define TRANSLATE_ALL_H
 
+#include "qemu/atomic.h"
 #include "exec/exec-all.h"
+#include "hw/core/cpu.h"
 
+#ifdef CONFIG_TCG
+/**
+ * cpu_loop_exit_requested:
+ * @cpu: The CPU state to be tested
+ *
+ * Indicate if somebody asked for a return of the CPU to the main loop
+ * (e.g., via cpu_exit() or cpu_interrupt()).
+ *
+ * This is helpful for architectures that support interruptible
+ * instructions. After writing back all state to registers/memory, this
+ * call can be used to check if it makes sense to return to the main loop
+ * or to continue executing the interruptible instruction.
+ */
+static inline bool cpu_loop_exit_requested(CPUState *cpu)
+{
+    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
+}
+#endif
 
 /* translate-all.c */
 void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 0ea8668ab4..f78430da0d 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -29,6 +29,7 @@
 #include "internals.h"
 #include "qemu/crc32c.h"
 #include "exec/exec-all.h"
+#include "exec/translate-all.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 6a308c5553..17fab5e8be 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -25,6 +25,7 @@
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/translate-all.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
 #include "hw/core/tcg-cpu-ops.h"
-- 
2.41.0


