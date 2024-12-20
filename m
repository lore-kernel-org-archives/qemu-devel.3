Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BB6E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfih-0003TL-VF; Fri, 20 Dec 2024 11:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfib-0002ag-AC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:13 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiZ-0008Ef-3J
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:12 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso20263875e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711549; x=1735316349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJe0InTlBUAjWEm5xiP9chgyYvTxYPda1BH0conYBG8=;
 b=Augm+EctumBWNE4fvhGKn9LM5N3am0WXEVunz4CnOV37CBGJhJQusguiixpBvkanJn
 DthbjDRSw7hYYAfGapIF0pm4x5yK2n46crExZEVV0+XxtKMtwyuuul3DsSnD3+0A94FW
 kUJLk4HLDZc5+JuyUnnjYCvq7yQEpa5QotLR/U3e0F+o6m5PJk0PcuMPRTYOVPJdCdkN
 KvzBLYMR/KBdUYYkrrE9ofKTo1UZ+/z8URxuKBPO71wQ7LSKFeCsCoqqLmgI8GXRotYG
 kJlw38atx5UujoW+whjVVsd9TPD1Nt6DYJqg+DuPPhrXoe2RIwfwXy/VGMDHAMHcoP9x
 EmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711549; x=1735316349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJe0InTlBUAjWEm5xiP9chgyYvTxYPda1BH0conYBG8=;
 b=RPZ6RfYsvhe1dNxYgANSM7q4yTxDyyuRHFhmLHxLSe5asyABFrAK0laQGS9wkpvd/X
 OnMcUuVFIQJY8L2vUWKklsAjvqZnIhu0NFNSC5VudA28E35ZY2sn21vsWiOo08KY2Pqh
 0chxRFW0fhiBm2ZjWQEIHIC/7+CJu3vvmLWjOYSkMHaITh9wMtd2L4JOGm6DGd9U0jNS
 Swrk7iPdr2IL/RrO3WK1rYfOe4DU0OnKVfWiWwi9Ep2kVdBws+fBjIp2hhtxkyad+yQL
 hrVW2+UPQEx+qrO/xPXCaeyXI4E+WNdTO2MAAzKkinlv8SaizduVioapSvmHnas9onTA
 lQaQ==
X-Gm-Message-State: AOJu0YyTmPzT3EABIP/h7ZldTt7qI02e+aLaLBh0taR7kvIbPQFIwqEd
 NjfpStfEOYuinFjFM/dnXJ3LyFOmqNRvs6ItvQCQoySQs7ztIgvRZYvsOz+t3qRg/rue8ifRRqj
 c
X-Gm-Gg: ASbGncvWSIxBrg9teTIpJnkr7rpEswXlFqqF0Zpro3Npw+ZY327XAtGEQiObfdbFeAn
 6oWkxm20x3zJqmoYVuOzgUCcjIU7IFdxBbDwNp41aVSnxD548ovC/CWrkzFP54mkQUCxc9a9bbw
 tVnDmIe22Fq1cGZyTVU0A8MnIhSSES2TfzE+2URi+FwCh297Eqt+lv71/AW49ZuavMp5gSio4Ng
 AEgciVVNGbognnfVMQd9qRYLMnl58fJWjmAq223C35uNoAKv+Wr7xBffwVrraiC9SLc9CEkBVY=
X-Google-Smtp-Source: AGHT+IFoDTeXW1NM4xi/lTIfL7HuWpqYKL2sO/r/zkfESA2WgD2N6U3CS0auD6IbblnNEemi7UOCMw==
X-Received: by 2002:a5d:59a4:0:b0:385:df17:2148 with SMTP id
 ffacd0b85a97d-38a1a2641b7mr6518026f8f.20.1734711549419; 
 Fri, 20 Dec 2024 08:19:09 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8474a9sm4353134f8f.52.2024.12.20.08.19.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 43/59] target/sparc: Move sparc_restore_state_to_opc() to cpu.c
Date: Fri, 20 Dec 2024 17:15:34 +0100
Message-ID: <20241220161551.89317-44-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Most targets define their restore_state_to_opc() handler in cpu.c.
In order to keep SPARC aligned, move sparc_restore_state_to_opc()
from translate.c to cpu.c.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20241115152053.66442-4-philmd@linaro.org>
[PMD: Move definitions to new target/sparc/translate.h]
---
 target/sparc/cpu.h       |  4 ----
 target/sparc/translate.h | 17 +++++++++++++++++
 target/sparc/cpu.c       | 24 ++++++++++++++++++++++++
 target/sparc/translate.c | 31 +------------------------------
 4 files changed, 42 insertions(+), 34 deletions(-)
 create mode 100644 target/sparc/translate.h

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index e9ccec6175f..5c981234bb3 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -607,12 +607,8 @@ int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                               uint8_t *buf, int len, bool is_write);
 #endif
 
-
 /* translate.c */
 void sparc_tcg_init(void);
-void sparc_restore_state_to_opc(CPUState *cs,
-                                const TranslationBlock *tb,
-                                const uint64_t *data);
 
 /* fop_helper.c */
 target_ulong cpu_get_fsr(CPUSPARCState *);
diff --git a/target/sparc/translate.h b/target/sparc/translate.h
new file mode 100644
index 00000000000..a46fa4f124b
--- /dev/null
+++ b/target/sparc/translate.h
@@ -0,0 +1,17 @@
+/*
+ * QEMU translation definitions for SPARC
+ *
+ * Copyright (c) 2024 Linaro, Ltd
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef SPARC_TRANSLATION_H
+#define SPARC_TRANSLATION_H
+
+/* Dynamic PC, must exit to main loop. */
+#define DYNAMIC_PC         1
+/* Dynamic PC, one of two values according to jump_pc[T2]. */
+#define JUMP_PC            2
+/* Dynamic PC, may lookup next TB. */
+#define DYNAMIC_PC_LOOKUP  3
+
+#endif
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index b11f3248d82..fc0c66afecf 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -27,6 +27,7 @@
 #include "qapi/visitor.h"
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
+#include "target/sparc/translate.h"
 
 //#define DEBUG_FEATURES
 
@@ -751,6 +752,29 @@ void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
     *pflags = flags;
 }
 
+static void sparc_restore_state_to_opc(CPUState *cs,
+                                       const TranslationBlock *tb,
+                                       const uint64_t *data)
+{
+    CPUSPARCState *env = cpu_env(cs);
+    target_ulong pc = data[0];
+    target_ulong npc = data[1];
+
+    env->pc = pc;
+    if (npc == DYNAMIC_PC) {
+        /* dynamic NPC: already stored */
+    } else if (npc & JUMP_PC) {
+        /* jump PC: use 'cond' and the jump targets of the translation */
+        if (env->cond) {
+            env->npc = npc & ~3;
+        } else {
+            env->npc = pc + 4;
+        }
+    } else {
+        env->npc = npc;
+    }
+}
+
 static bool sparc_cpu_has_work(CPUState *cs)
 {
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 322319a1288..ac063772310 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -30,6 +30,7 @@
 #include "exec/log.h"
 #include "fpu/softfloat.h"
 #include "asi.h"
+#include "target/sparc/translate.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -101,13 +102,6 @@
 # define MAXTL_MASK                             0
 #endif
 
-/* Dynamic PC, must exit to main loop. */
-#define DYNAMIC_PC         1
-/* Dynamic PC, one of two values according to jump_pc[T2]. */
-#define JUMP_PC            2
-/* Dynamic PC, may lookup next TB. */
-#define DYNAMIC_PC_LOOKUP  3
-
 #define DISAS_EXIT  DISAS_TARGET_0
 
 /* global register indexes */
@@ -5881,26 +5875,3 @@ void sparc_tcg_init(void)
                                          gregnames[i]);
     }
 }
-
-void sparc_restore_state_to_opc(CPUState *cs,
-                                const TranslationBlock *tb,
-                                const uint64_t *data)
-{
-    CPUSPARCState *env = cpu_env(cs);
-    target_ulong pc = data[0];
-    target_ulong npc = data[1];
-
-    env->pc = pc;
-    if (npc == DYNAMIC_PC) {
-        /* dynamic NPC: already stored */
-    } else if (npc & JUMP_PC) {
-        /* jump PC: use 'cond' and the jump targets of the translation */
-        if (env->cond) {
-            env->npc = npc & ~3;
-        } else {
-            env->npc = pc + 4;
-        }
-    } else {
-        env->npc = npc;
-    }
-}
-- 
2.47.1


