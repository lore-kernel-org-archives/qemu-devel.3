Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4D3D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy8K-0001oX-E8; Fri, 15 Nov 2024 10:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8J-0001oM-DC
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:15 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8H-00045H-QW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:15 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so15834675e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731684071; x=1732288871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzsaTbH/TKzp8tqs/UlH1bp9VqSjjTrJOViR/Wph0HQ=;
 b=SSD8KP13PVIm5XMoKG/p7LRjIqGP3pT9fqdQ/xNTpYWlW63kQxSwdBMIVd30QPix/u
 9E68mf5o0r1nwz86983LC9mHBr0Cl18v4J5U7cBKeJEONXOK5GWF09xFK9skTf7x/S3v
 Y72Hn6+CoPM7FNIwpv7D6IKtN3p3epT5rT1Dk7ULi0vRtE/TI611+9Q1dOWXa3zK44X1
 d3XEc5S5DpJQyugPDvIbdTmTb35AsH942oH5w5gXwkilxsuNLEOB1lvYooN1+Ui8ztEs
 eDBoXNAwy9aNtOlnp7BdYi03ZNsJ6FKtQCWfpXlbKWmkczsCQf9z0PTv64yV98UTMUS5
 FoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731684071; x=1732288871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzsaTbH/TKzp8tqs/UlH1bp9VqSjjTrJOViR/Wph0HQ=;
 b=az9Sz/++sJpukaoCBHzW15QBihKwrMP3FXb33GSpQLRNUN9abjmXBa3OXRbXSJRtrP
 mrOV5SiHzLdlt3vsLkjps5ZeQIynk5+Tq2d9VBApcpOSJ0Jl4WGccbxqiScjp0pNSGiY
 OrVNOj0DYxrB8Jvrko2JaHs2/8icWL1C2mb7sblwhqEMyiz8p90TaluLG9Hwn4gdsQ+n
 7LmbPImsHRf/vQIxOHa5aUYPKC5NlLFNd8QsiQpXvpQ9ZU0Uu382W/mPaf9sMoSCX0pC
 sxQm3PxvtyZR3ytpJb3w6tyABfj5OHkG9gsHg+wfkskZAe47fcdtL9yov02WFeVBFTVb
 7Oug==
X-Gm-Message-State: AOJu0Yytw5jQnKgBsr26sinlzcMxJIA6Wcf9ytjmm3KvYpUSsQeH+udb
 QmBsrDhQCJY9YwPgK8IfkCExcEPHXHLFbkK2IW5tn6V1f3AyZR5pGX0XKAH7Li+tDWfK3U1qZs7
 y
X-Google-Smtp-Source: AGHT+IF3yC99cTCgXvfRbDp7cGVEg27uPQx9XuZipM7vsZvLqMT12uoo+ojpjZ8Virl5ejx+xIh1FA==
X-Received: by 2002:a05:600c:4595:b0:42c:b80e:5e50 with SMTP id
 5b1f17b1804b1-432df67991emr26832545e9.0.1731684070978; 
 Fri, 15 Nov 2024 07:21:10 -0800 (PST)
Received: from localhost.localdomain ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0ae45sm57136675e9.30.2024.11.15.07.21.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Nov 2024 07:21:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/10] target/sparc: Move sparc_restore_state_to_opc() to cpu.c
Date: Fri, 15 Nov 2024 16:20:46 +0100
Message-ID: <20241115152053.66442-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115152053.66442-1-philmd@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
---
 target/sparc/cpu.h       | 11 ++++++++---
 target/sparc/cpu.c       | 23 +++++++++++++++++++++++
 target/sparc/translate.c | 32 --------------------------------
 3 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index f517e5a383..bcb3566a92 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -607,12 +607,17 @@ int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                               uint8_t *buf, int len, bool is_write);
 #endif
 
+/* Dynamic PC, must exit to main loop. */
+#define DYNAMIC_PC         1
+/* Dynamic PC, one of two values according to jump_pc[T2]. */
+#define JUMP_PC            2
+/* Dynamic PC, may lookup next TB. */
+#define DYNAMIC_PC_LOOKUP  3
+
+#define DISAS_EXIT  DISAS_TARGET_0
 
 /* translate.c */
 void sparc_tcg_init(void);
-void sparc_restore_state_to_opc(CPUState *cs,
-                                const TranslationBlock *tb,
-                                const uint64_t *data);
 
 /* fop_helper.c */
 target_ulong cpu_get_fsr(CPUSPARCState *);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index dd7af86de7..59db8c8472 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -713,6 +713,29 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
     cpu->env.npc = tb->cs_base;
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
index cdd0a95c03..9942e78412 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -101,15 +101,6 @@
 # define MAXTL_MASK                             0
 #endif
 
-/* Dynamic PC, must exit to main loop. */
-#define DYNAMIC_PC         1
-/* Dynamic PC, one of two values according to jump_pc[T2]. */
-#define JUMP_PC            2
-/* Dynamic PC, may lookup next TB. */
-#define DYNAMIC_PC_LOOKUP  3
-
-#define DISAS_EXIT  DISAS_TARGET_0
-
 /* global register indexes */
 static TCGv_ptr cpu_regwptr;
 static TCGv cpu_pc, cpu_npc;
@@ -5881,26 +5872,3 @@ void sparc_tcg_init(void)
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
2.45.2


