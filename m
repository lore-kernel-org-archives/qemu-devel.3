Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB53C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadQ-0005yG-7D; Mon, 29 Jan 2024 18:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadP-0005xq-0c
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:47 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadM-0008Oq-W9
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:46 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6ddf26eba3cso2121606a34.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569304; x=1707174104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=blFzc6YcDRkiR8B9Edly+GRoesCmaBH2nX316LvuRkc=;
 b=KCjk9Luj2kwf1EnQVSxcIkrXxyH/tKdy/egGxxDPQbThu5IOqzJ1XtOm933Veg5I38
 ZOs0ToLj3oN4yoSerUuPTXlUau3n1LpAFzVUQK95eR/NR4fgdx8MuaJYmq+AOZrdMCaI
 H/DrJtXmZiPa5RzVRGe1EEvs9iNYug0DAdYTd4JndeGfZX+84v4t2sPMsu46h+OQ9sDG
 bdqvup+A9sMOO/z5GRDZkf0S9s3O7ByRZu5vkZOkvJVkUAVGwsjbRe59284gaWy5mOQD
 PFYs0IX7b69BbXGzt2rbqirwb1KbVGwfWtSmTjTDjsIUuHfaPVse9lNoJ/5SxEBqAfuN
 sq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569304; x=1707174104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=blFzc6YcDRkiR8B9Edly+GRoesCmaBH2nX316LvuRkc=;
 b=Kst6v1iEIUNVaV2wSdx9IRwHqp7Ol2Yz80sH/E5H+BxHttL5BqZ/ub1AmlcoX9ppwy
 xyl+XJRbGWNhtVr3erHGtjydNhEMNsgZBqdnPGUZuLIadmXmQuDpSp81r3Hm16BurvY0
 PyKsH4mGUled/wtVrUm6PQrSuZFadsS/TVCdpzCW/fUHNgj9nR0Oc46ACEuSq+xRXYaJ
 +ZN9pL/N8qs86AwZrW8rx8SHmC1VJpqGZI503w5gtE0LRI+2d31jjkdavc70k7OSe0W/
 p/TyEFAf6H+Zf24ObEOeDNzXNjV1kQ41R0EhByzt2ECqzZNHPI2wqnHcVP5VLSHQu3B7
 goDA==
X-Gm-Message-State: AOJu0YyDSnfC+/SeWVGwlK302/7nWLdE/0WmuABEHZQwiPxFnhARvoe1
 FISlw5ntyTFvzFnrktggxn8q5lBaTGYSfiUheoryOtvS5V7XmzRkiDlx4k/IbgPPk4ctptaQTNV
 ExsU=
X-Google-Smtp-Source: AGHT+IF7pWujJumVMn2IoJ2nvf83N6fpWpLtQiwiO6wZuUaxCSc0KBf/tIVhUbpU/p4JD+IJp3oLKw==
X-Received: by 2002:a05:6358:4b4e:b0:178:7d95:2913 with SMTP id
 ks14-20020a0563584b4e00b001787d952913mr2074311rwc.34.1706569303886; 
 Mon, 29 Jan 2024 15:01:43 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/31] include/exec: Move cpu_*()/cpu_env() to common header
Date: Tue, 30 Jan 2024 09:00:58 +1000
Message-Id: <20240129230121.8091-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

Functions are target independent.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-17-anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    | 25 -------------------------
 include/exec/cpu-common.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index edee87d3f4..8501a33dbf 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -384,33 +384,8 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
 
 #endif /* !CONFIG_USER_ONLY */
 
-/* accel/tcg/cpu-exec.c */
-int cpu_exec(CPUState *cpu);
-
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
-/**
- * env_archcpu(env)
- * @env: The architecture environment
- *
- * Return the ArchCPU associated with the environment.
- */
-static inline ArchCPU *env_archcpu(CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
-
-/**
- * env_cpu(env)
- * @env: The architecture environment
- *
- * Return the CPUState associated with the environment.
- */
-static inline CPUState *env_cpu(CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
-
 #endif /* CPU_ALL_H */
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 608708ea48..dcbd5f5783 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -7,6 +7,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
 #endif
+#include "hw/core/cpu.h"
 
 #define EXCP_INTERRUPT  0x10000 /* async interruption */
 #define EXCP_HLT        0x10001 /* hlt instruction reached */
@@ -236,4 +237,29 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
  */
 #define PAGE_PASSTHROUGH 0x0800
 
+/* accel/tcg/cpu-exec.c */
+int cpu_exec(CPUState *cpu);
+
+/**
+ * env_archcpu(env)
+ * @env: The architecture environment
+ *
+ * Return the ArchCPU associated with the environment.
+ */
+static inline ArchCPU *env_archcpu(CPUArchState *env)
+{
+    return (void *)env - sizeof(CPUState);
+}
+
+/**
+ * env_cpu(env)
+ * @env: The architecture environment
+ *
+ * Return the CPUState associated with the environment.
+ */
+static inline CPUState *env_cpu(CPUArchState *env)
+{
+    return (void *)env - sizeof(CPUState);
+}
+
 #endif /* CPU_COMMON_H */
-- 
2.34.1


