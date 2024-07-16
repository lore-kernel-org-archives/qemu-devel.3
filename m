Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB129C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmcy-0007UF-IT; Tue, 16 Jul 2024 14:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmcx-0007Q5-DR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmcv-00018Y-FF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4267300145eso46440675e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153411; x=1721758211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhnQiVznBi2Zvr4gz5/6RuKKxU2+0PGgb84J5GpHddM=;
 b=Nr059V3YPWAL576zT/ugBT3wpUfKI4c1vfxR30jvp2+OA5dil/PFbmfsVb5P2l631d
 5YxUt0RmYV7mPQFBK3eZAT3lH0iYlSRcNUyZ7XGGUmlUGfMCTC6IYvyIeCXcMc6COf2U
 uM38KSJw0i4DOXc0yzJl0BbAUDOADWeRWS8qH5ezVOazhQdHfINDZ+kO3XDgz9ZRzW7A
 WYp/a9ErQ7/J9T3nl7mfYaX0n6+UqrWwJvjr0g6buRXmLNvU+Y5KJR4dZQC1LSRnok+7
 8wGC9fdpDBKys6cEs9uoB2odbnzbkyO4Avo00PTciF+iyW9i8ckDTge9RT68kauixm4t
 y22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153411; x=1721758211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhnQiVznBi2Zvr4gz5/6RuKKxU2+0PGgb84J5GpHddM=;
 b=dY/1b21erS90oYvwzRoHVb4XQcFduvIYIzbJg52Wh+GAxDNVZJawDQvcaipA4ghI6X
 poRnY1r9+e5DyrDlkjuJ7qYr64KEIqm8+9K0krA/lxCn5n8b5BHlYC/4L8zJa/vZMGoI
 FZxZuBESvqJxzL6WzxxqX2ajrRD2LpdRK/4C9+pWxzzE/J5L6DjreY0WBLtBTteyj3xV
 tXWfEM0wPSuqKbrqeVAYN8wt9bkSRzK/vEjy4F2MmndlnG1f49JDDV6uY6Tdj9M23fu4
 ychzTlGMFB9ZaIsKl01vNuJBgeCkmgtmZCaN8LGNhF2uKtoDX8p2f5QOzm+cuXbgItVI
 eLCg==
X-Gm-Message-State: AOJu0YwRhDtvVX4RrKS1Q/+relo1b82zmMjOfbDu5wJlYYe4TEjEQG5s
 jr3OhcOjgtU87fd0GKfx2SnbEPNIS9UWIKHT2WBJxm2VXF8IzWmg4bSWKR7lRm9d0Q58pCISxlu
 wYSEG9A==
X-Google-Smtp-Source: AGHT+IHuaSKGAxkkhcc+BX8GYIpzsfDHUx19p+2EsFnI5Q9kTQ1kcf7jaOLGlTjANzhZBPHKs9WCBQ==
X-Received: by 2002:a05:600c:3548:b0:426:6f87:65fc with SMTP id
 5b1f17b1804b1-427ba6872f1mr28007535e9.17.1721153411661; 
 Tue, 16 Jul 2024 11:10:11 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb50fsm138130745e9.38.2024.07.16.11.10.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:10:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/13] accel/tcg: Make cpu_exec_interrupt hook mandatory
Date: Tue, 16 Jul 2024 20:09:32 +0200
Message-ID: <20240716180941.40211-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The TCGCPUOps::cpu_exec_interrupt hook is currently not mandatory; if
it is left NULL then we treat it as if it had returned false. However
since pretty much every architecture needs to handle interrupts,
almost every target we have provides the hook. The one exception is
Tricore, which doesn't currently implement the architectural
interrupt handling.

Add a "do nothing" implementation of cpu_exec_hook for Tricore,
assert on startup that the CPU does provide the hook, and remove
the runtime NULL check before calling it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240712113949.4146855-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 4 ++--
 target/tricore/cpu.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 245fd6327d..9010dad073 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -857,8 +857,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         else {
             const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
-            if (tcg_ops->cpu_exec_interrupt &&
-                tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
+            if (tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
                 if (!tcg_ops->need_replay_interrupt ||
                     tcg_ops->need_replay_interrupt(interrupt_request)) {
                     replay_interrupt();
@@ -1080,6 +1079,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         /* Check mandatory TCGCPUOps handlers */
 #ifndef CONFIG_USER_ONLY
         assert(cpu->cc->tcg_ops->cpu_exec_halt);
+        assert(cpu->cc->tcg_ops->cpu_exec_interrupt);
 #endif /* !CONFIG_USER_ONLY */
         cpu->cc->tcg_ops->initialize();
         tcg_target_initialized = true;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 4d9c0368f2..1a26171590 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -155,6 +155,11 @@ static void tc37x_initfn(Object *obj)
     set_feature(&cpu->env, TRICORE_FEATURE_162);
 }
 
+static bool tricore_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    /* Interrupts are not implemented */
+    return false;
+}
 
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -169,6 +174,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
     .tlb_fill = tricore_cpu_tlb_fill,
+    .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
 };
 
-- 
2.41.0


