Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6940C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJV-0004Zz-Ew; Tue, 11 Mar 2025 09:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEE-0005No-U3; Tue, 11 Mar 2025 09:01:06 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEA-0000B8-IC; Tue, 11 Mar 2025 09:01:01 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so8062867a91.2; 
 Tue, 11 Mar 2025 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698056; x=1742302856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QcWNxidF+8F14IOmySk+2TS0qLc2Hl5I2PiCaOol8E=;
 b=eL5sZd0Jnn1SuZ1B9g0xrkRT4NCcdK08rkgHNLqdvTYCusg3AYFvYdxXknsQhuUtPt
 aF0UR2o/xHHt4rxesnUcBiBev0AiAPFaXkLi3RuSXV8Y8bShvTyZ5lKLAqtj9ugcDEY0
 jsuFgqKfa/5Y+t1k+bDG1LGTff3+68NJo3/Ob2v1EE9I4kt/MDDflWO0weRoQ3iY6J6o
 DlCX+z9nTf4Ub+OCXaLzc9dcx7L0KeXOOHWEcvEqZjHOnwE/Mdt90uarTNWZS788nY5n
 VRmjfnzjWrEWjEPY1nA8EXij5qMsQEUESlZF76w+xx5I5zZqTlsEDNE8EUKoeCWOC3tA
 n4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698056; x=1742302856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6QcWNxidF+8F14IOmySk+2TS0qLc2Hl5I2PiCaOol8E=;
 b=FrUVxUemX+CGE0amQwJBx8Ot5jiWZ9AJOZ2gqPrLWSs/h7546B4hxRwg3yUbBFkqGO
 QZSaCyUXKdef5Jm1sUnWxwPYu6qR3TG0FbekgzvnPatPFzb7GKZswkeLojEfJ19lAODx
 TVqlMQMgW6m1P+s3ix1N76+a2jim1lLFGXabzrvqfhHS6AKq3XbNLMON3by64i1+osxW
 KsTm+2WBqqfjZLOnFwVgXExRcFU5BXbOIRBQG18C1KR2LIKuSu6NKj3RSfJBaoLDPSjI
 UrXqzi/jgbGLyb4/jxZPhaLsOCNCf08MPrBoKuynlsKjDwiwN+5FYm8ie5TXSqC4thi1
 LFDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULCnGTy5mGZ+3n8+80znvvFk19n3GDRiXuUJY4iGkNwQC9i2q4XJlUGyec0P3UuV6FlgvgqXpeOw==@nongnu.org
X-Gm-Message-State: AOJu0Yy+l+qLGvCJTuBJiZ7uniBbcYQdVjGMJ6cfEVLJ4JRGhAs6hdJw
 svo1AqezRV1KKkUBVnUYZffZXg8JotNvhGTBL0f+KzepErb5uSokQ7AlNg==
X-Gm-Gg: ASbGncvozUsh/PaXmXVEumBNcc/OtCDxcwGWfd8YeWtWTmYc7wuJb8lwtpRUmlJrrkI
 /nN0D1F4mLr6LkpQKloTsxJJn1PfEoGydd2Vl/5wf3+bqQcfGHjermFwLsRupqmSYgudZVxRkIS
 /9m25MgHPm5jVa5I8M6b4DWdvJft9YALXx71hQLLGHNiBvbjOiDZNJLojsTK+Glp5LIiEuc5XNd
 KGAEIcic06MeypcFnrC33yuKWLfvDgO8WahcSwiyQ/Ve+Zu/HTfl4WsNkk8dVZkd+Mv/HdA6P05
 B4ENXa3CABmUxQPVK4YbzXneJAHaJPQhS7uFTjMr03U4By+BKD4=
X-Google-Smtp-Source: AGHT+IHCy4rvVri/vTa/rnjuzFdLf5mF5P6ijmWnVC0Tsoonsvdoe3C9wE8weJlK9fPlu2zNDGd++Q==
X-Received: by 2002:a17:90b:278f:b0:2f7:4cce:ae37 with SMTP id
 98e67ed59e1d1-2ff7ce8958fmr30255905a91.18.1741698056295; 
 Tue, 11 Mar 2025 06:00:56 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 49/72] target/ppc: Restrict exception helpers to TCG
Date: Tue, 11 Mar 2025 22:57:43 +1000
Message-ID: <20250311125815.903177-50-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move exception helpers to tcg-excp_helper.c so they are
only built when TCG is selected. Preprocessor guards
are added for some helpers unused when CONFIG_USER_ONLY.

[npiggin: mention USER_ONLY change]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250127102620.39159-10-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c     | 34 --------------------------------
 target/ppc/tcg-excp_helper.c | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9e1a2ecc36..6a12402b23 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2504,41 +2504,7 @@ bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 #endif /* !CONFIG_USER_ONLY */
 
-/*****************************************************************************/
-/* Exceptions processing helpers */
-
-void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
-                            uint32_t error_code, uintptr_t raddr)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = exception;
-    env->error_code = error_code;
-    cpu_loop_exit_restore(cs, raddr);
-}
-
-void raise_exception_err(CPUPPCState *env, uint32_t exception,
-                         uint32_t error_code)
-{
-    raise_exception_err_ra(env, exception, error_code, 0);
-}
-
-void raise_exception(CPUPPCState *env, uint32_t exception)
-{
-    raise_exception_err_ra(env, exception, 0, 0);
-}
-
 #ifdef CONFIG_TCG
-void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
-                                uint32_t error_code)
-{
-    raise_exception_err_ra(env, exception, error_code, 0);
-}
-
-void helper_raise_exception(CPUPPCState *env, uint32_t exception)
-{
-    raise_exception_err_ra(env, exception, 0, 0);
-}
 
 #ifndef CONFIG_USER_ONLY
 void helper_store_msr(CPUPPCState *env, target_ulong val)
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 93c2d6b5a0..268a161459 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -19,15 +19,53 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "exec/cpu_ldst.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
 #include "system/runstate.h"
 
+#include "helper_regs.h"
 #include "hw/ppc/ppc.h"
 #include "internal.h"
 #include "cpu.h"
 #include "trace.h"
 
+/*****************************************************************************/
+/* Exceptions processing helpers */
+
+void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
+                            uint32_t error_code, uintptr_t raddr)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = exception;
+    env->error_code = error_code;
+    cpu_loop_exit_restore(cs, raddr);
+}
+
+void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
+                                uint32_t error_code)
+{
+    raise_exception_err_ra(env, exception, error_code, 0);
+}
+
+void helper_raise_exception(CPUPPCState *env, uint32_t exception)
+{
+    raise_exception_err_ra(env, exception, 0, 0);
+}
+
 #ifndef CONFIG_USER_ONLY
 
+void raise_exception_err(CPUPPCState *env, uint32_t exception,
+                                           uint32_t error_code)
+{
+    raise_exception_err_ra(env, exception, error_code, 0);
+}
+
+void raise_exception(CPUPPCState *env, uint32_t exception)
+{
+    raise_exception_err_ra(env, exception, 0, 0);
+}
+
 void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                  MMUAccessType access_type,
                                  int mmu_idx, uintptr_t retaddr)
-- 
2.47.1


