Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C6CC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdT1-00088t-LB; Fri, 04 Jul 2025 06:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSw-0007y4-9Y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSt-0006wI-Uq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso557644f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624178; x=1752228978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a/ehok3HXLFMICTHZ9JCOL4fKFue6Luf24Tj+XvmPiI=;
 b=r+iN5v4K4L0TWY5hIx+Es73u0e1GcqJE+KoQe4jnoNhVL1yYcbxxHwFpmU2Me0p3oA
 Q9Se7cku8f761rLZzO1GnbnTImV6KlRwo9YsCp07UPn8ROfOyLMv2Fdx3aDLxzpUwCY1
 IPjjEdb01LFB4/eIX2vgC7SeKUo7JDg4vjFFkrJtJ/CPwt6muXdkYEWGMXL+CodNi6ty
 KiqFfuhdM9yhKoHI3kA5gcN5vCSwG1fskLxVkchyRtSvhNO+13yRxdfyFQ5+vJxMvUFb
 IZKkxMxj+ih9JvfnyNYhIoxE07TJKJWvuDflYPSTzWUJzEw7A/BSQe49/UP70tGhwsqp
 HwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624178; x=1752228978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/ehok3HXLFMICTHZ9JCOL4fKFue6Luf24Tj+XvmPiI=;
 b=XClgHq0jR6Fcgl0Lmitssv81IDGp/n8ww4POT/5wFrrMD9ccWeQYstWqnB6FEfdhtb
 sz1SRhf3i3pgGgCx7KtgFUSR5snJYJ6GUG8HjCwMr8BzywgWhTzsSaR94n1NpFbMFvBY
 9BmZlGfsKevS9GetrXZl+lwfsVSrejFl+u7qofrEcGZIBXUy08XjPy3E6A8B8quLZdpG
 pXf7olNGDL7cj728fHYZXteYXIlFytH83Recvooemb+isxuXwa+U0S1NpfTev5QqGUmK
 1X8GAPGfMTbT3g2R8VMMX5zwHXzwg3tjwwG98EV8PtvNo55JSooz0CIlIgPfeE8I5S+0
 OT8A==
X-Gm-Message-State: AOJu0YxUVJ+hS3PdERM+QBGUFZoDVukea/1v9D5AaUfb5FwfsfhrG3MN
 wx7V6ZIZWibmEHuQiU4JH/tQU4uZSo2xoK0QFZnOjo9Izh50LdsEURsJFrFKOTv7VagE1zdLpv+
 16h4bIaE=
X-Gm-Gg: ASbGncuPDwMLunPf9rYLqhx90QWK2gJGhv8nBQjmgIL5vRFmCghRbpK5a7eJU4GrdXU
 lRo98R49FkdDImHSTHBwoB5G5kZTTfTktC3SMGjYMFTEwj5IMP2iuMUux3mVuB37eElIavGePC1
 cvnW4ZcVKmVw1dPWq1UVkEJW+Zw8L+dwx2lP5BY5AO/u3gBnCNKYiP1ailqI6iI+sw5lPRbMPGr
 FYsSWAAZMN7L0FmBQjJnoi427E6x95NPLSCFcxCk6bUz5oZNp+FOoKYAr5H85x1HN6+BniqLMAd
 3zvLQ8sbpPjJSatpjzrLnqJLDs8HZaagXocD2sXFMh8Wxs3vieIcz3CczzjM31qP02rZ5+mmO8m
 omtTLd2azVX2hNmXrSDV4+UMxd0eZ5RQyHFpZ
X-Google-Smtp-Source: AGHT+IG9TjGkwo7efzyMwPuD+7B+75MU6aBwksawEK+7PQ6xES1fn1DI/9ZY4SPZQDp9z+P75HLPag==
X-Received: by 2002:a5d:6f15:0:b0:3a5:8977:e102 with SMTP id
 ffacd0b85a97d-3b497038cdamr1160706f8f.39.1751624177511; 
 Fri, 04 Jul 2025 03:16:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285c90esm2129300f8f.91.2025.07.04.03.16.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/31] accel: Keep reference to AccelOpsClass in AccelClass
Date: Fri,  4 Jul 2025 12:14:23 +0200
Message-ID: <20250704101433.8813-23-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Allow dereferencing AccelOpsClass outside of accel/accel-system.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250703173248.44995-30-philmd@linaro.org>
---
 include/qemu/accel.h       | 3 +++
 include/system/accel-ops.h | 3 ++-
 accel/accel-system.c       | 3 ++-
 accel/tcg/tcg-accel-ops.c  | 4 +++-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index fbd3d897fef..9dea3145429 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -37,6 +37,9 @@ typedef struct AccelClass {
     /*< public >*/
 
     const char *name;
+    /* Cached by accel_init_ops_interfaces() when created */
+    AccelOpsClass *ops;
+
     int (*init_machine)(MachineState *ms);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index e775ecc348c..a786c7d478a 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -10,6 +10,7 @@
 #ifndef ACCEL_OPS_H
 #define ACCEL_OPS_H
 
+#include "qemu/accel.h"
 #include "exec/vaddr.h"
 #include "qom/object.h"
 
@@ -31,7 +32,7 @@ struct AccelOpsClass {
     /*< public >*/
 
     /* initialization function called when accel is chosen */
-    void (*ops_init)(AccelOpsClass *ops);
+    void (*ops_init)(AccelClass *ac);
 
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
diff --git a/accel/accel-system.c b/accel/accel-system.c
index a0f562ae9ff..64bc991b1ce 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -85,8 +85,9 @@ void accel_init_ops_interfaces(AccelClass *ac)
      * non-NULL create_vcpu_thread operation.
      */
     ops = ACCEL_OPS_CLASS(oc);
+    ac->ops = ops;
     if (ops->ops_init) {
-        ops->ops_init(ops);
+        ops->ops_init(ac);
     }
     cpus_register_accel(ops);
 }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6116644d1c0..37b4b21f882 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -196,8 +196,10 @@ static inline void tcg_remove_all_breakpoints(CPUState *cpu)
     cpu_watchpoint_remove_all(cpu, BP_GDB);
 }
 
-static void tcg_accel_ops_init(AccelOpsClass *ops)
+static void tcg_accel_ops_init(AccelClass *ac)
 {
+    AccelOpsClass *ops = ac->ops;
+
     if (qemu_tcg_mttcg_enabled()) {
         ops->create_vcpu_thread = mttcg_start_vcpu_thread;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
-- 
2.49.0


