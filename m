Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934CFC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05IN-0003Fk-Rf; Wed, 02 Apr 2025 17:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05IL-0002wF-DY
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:45 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05IJ-0007Ol-Dd
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:45 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso143723f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743628002; x=1744232802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kv473foA2Lz/6LlrfWieB+cyNxqB+oMm/dNGpDxxZmg=;
 b=NIiAOATHIoe8RNsSS6ykijgHkj55m+Zs+oDNGzeMFf3p8FrZwCw9Q1E2GPwIwQewLi
 NgUbwfVpBRRu13ZRdaXxC+q0121t0zwMsPigZQtBVSJ+WC7i5MrmPOClmNYvVH6dHigQ
 2dIch4ifZ24IaROS4xN3ms29VrkPsF+UsrSJs36oK1PTapE01L3Q437UnuXVJbfswUY/
 CUyWnEsdjIe3FhdulGHLMp/XoYiDSL9RxLcunRXvSKRPzpbPQuv58BVuVaNIbrTNHm6t
 PWDXvLjEfxK/i4Dj1d7At1qk/VaJr/e8C6/ea+EePWoAmEV7Ub67oIxgPlqMtNR9GRhn
 2wMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743628002; x=1744232802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kv473foA2Lz/6LlrfWieB+cyNxqB+oMm/dNGpDxxZmg=;
 b=NnOJ+hKEqfF+X2PTA2MmvmeAXBT1/aYxEFu8wh4/1/57V2ivZ1J6PTVa/SgIX8Zcsx
 vKjWT1ChNTHEkrYPti0zCwHpPdWKmnOFBgQt6vpKYgcZadLC2ZK7S6kzpuZjQdxrr98R
 oJbcegTqBnHCzxQTfSFwoeorS9M0h/ELKUE/hCv9K/NPCbhDHDE/SbSlQj/FMIkCnqiQ
 5Al1l//dvdAcAFx6p+ykg+Dz7UZqasFCcL+KqUM98QpNl4MZLk0lSK+SHENzoIv5Z2zf
 JqE0w7rC5zhqaNE0QUayvzVNteASmIHl3Xeu17gezhNKWZfUThovR0XfwFp4B6qMgX9c
 FdOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP3GbZJR7AxWPW9iNa1fEO8+6ev73d107ei6xtX0BxdOEA8HvM4J94gbjhxMrCa0vqLFcmzRmYM4ZX@nongnu.org
X-Gm-Message-State: AOJu0YwTdFFM9JxHXCc2NbpoNwvijmdzM55xvdQIKrqHWB92EEPJGRz2
 rfS495JKZP+QmxeNiUwymOjspF+w+HdNi55PzatM+jtrKPguaPy99Ig8u17yB3sHUJAyqR4XHd+
 S
X-Gm-Gg: ASbGncvf3TaI42RZLmarlrvITthg+YdjG2F1pzHi/cV1H8ANITf6D2au7/zGyewPR2G
 /uPi4iqZZxjJvDWVsXgVrPnh2D3VR8TgLOVOT/zho64VTPxJrcooDCIhk2zC/PhVv0IYF0vVDqp
 bBqBsEksDneM1E4yV+ueXJe951sPH5O4Q/NCxtp1bnzPZsCCMSnzVFRXqcPhbcML8ZKYGHSLB69
 BM06q0xJQtmSYLS76vNRy7wFPPpKywJeikhuFOMYqrE+ICACR9xRlBPFwrR6Cbn56GM8H4DagVW
 cDzqGwPE0FrDiSJsVRI99jynz/wHbnDkOsjFoQQH6YjnXfbtSbb4KFZe5VxytXqcymYT9SEag+a
 6TVl7L+wHpeQ62MdJx4A=
X-Google-Smtp-Source: AGHT+IGeaJyVsG2MGbu9FQS4OyrSTkXcMfboRWnXmBbbehpi9mjcHI/YzyXakdPGKVV7RJ+A+im19w==
X-Received: by 2002:a5d:64e9:0:b0:390:f9d0:5e4 with SMTP id
 ffacd0b85a97d-39c2f8d339dmr104432f8f.21.1743628002018; 
 Wed, 02 Apr 2025 14:06:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e33asm18167413f8f.66.2025.04.02.14.06.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:06:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 39/43] tcg: Move qemu_tcg_mttcg_enabled() to
 'system/tcg.h'
Date: Wed,  2 Apr 2025 23:03:24 +0200
Message-ID: <20250402210328.52897-40-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

qemu_tcg_mttcg_enabled() is specific to 1/ TCG and
2/ system emulation. Move the prototype declaration
to "system/tcg.h", reducing 'mttcg_enabled' variable
scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/core/cpu.h      |  9 ---------
 include/system/tcg.h       |  8 ++++++++
 accel/tcg/tcg-all.c        | 16 ++++++++++++++--
 target/riscv/tcg/tcg-cpu.c |  1 +
 tcg/region.c               |  4 +++-
 5 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 10b6b25b344..c8d6abff19a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -594,15 +594,6 @@ extern CPUTailQ cpus_queue;
 
 extern __thread CPUState *current_cpu;
 
-/**
- * qemu_tcg_mttcg_enabled:
- * Check whether we are running MultiThread TCG or not.
- *
- * Returns: %true if we are in MTTCG mode %false otherwise.
- */
-extern bool mttcg_enabled;
-#define qemu_tcg_mttcg_enabled() (mttcg_enabled)
-
 /**
  * cpu_paging_enabled:
  * @cpu: The CPU whose state is to be inspected.
diff --git a/include/system/tcg.h b/include/system/tcg.h
index 73229648c63..7622dcea302 100644
--- a/include/system/tcg.h
+++ b/include/system/tcg.h
@@ -17,4 +17,12 @@ extern bool tcg_allowed;
 #define tcg_enabled() 0
 #endif
 
+/**
+ * qemu_tcg_mttcg_enabled:
+ * Check whether we are running MultiThread TCG or not.
+ *
+ * Returns: %true if we are in MTTCG mode %false otherwise.
+ */
+bool qemu_tcg_mttcg_enabled(void);
+
 #endif
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index a5a1fd6a11e..b8874430d30 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -38,6 +38,7 @@
 #include "hw/qdev-core.h"
 #else
 #include "hw/boards.h"
+#include "system/tcg.h"
 #endif
 #include "internal-common.h"
 #include "cpu-param.h"
@@ -58,6 +59,17 @@ typedef struct TCGState TCGState;
 DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
                          TYPE_TCG_ACCEL)
 
+#ifndef CONFIG_USER_ONLY
+
+static bool mttcg_enabled;
+
+bool qemu_tcg_mttcg_enabled(void)
+{
+    return mttcg_enabled;
+}
+
+#endif /* !CONFIG_USER_ONLY */
+
 /*
  * We default to false if we know other options have been enabled
  * which are currently incompatible with MTTCG. Otherwise when each
@@ -97,7 +109,6 @@ static void tcg_accel_instance_init(Object *obj)
 #endif
 }
 
-bool mttcg_enabled;
 bool one_insn_per_tb;
 
 static int tcg_init_machine(MachineState *ms)
@@ -107,10 +118,11 @@ static int tcg_init_machine(MachineState *ms)
     unsigned max_cpus = 1;
 #else
     unsigned max_cpus = ms->smp.max_cpus;
+
+    mttcg_enabled = s->mttcg_enabled;
 #endif
 
     tcg_allowed = true;
-    mttcg_enabled = s->mttcg_enabled;
 
     page_init();
     tb_htable_init();
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 50e81b2e521..88f7cdb887c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -36,6 +36,7 @@
 #include "tcg/tcg.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
+#include "system/tcg.h"
 #endif
 
 /* Hash that stores user set extensions */
diff --git a/tcg/region.c b/tcg/region.c
index 478ec051c4b..56d2e988719 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -34,7 +34,9 @@
 #include "exec/translation-block.h"
 #include "tcg-internal.h"
 #include "host/cpuinfo.h"
-
+#ifndef CONFIG_USER_ONLY
+#include "system/tcg.h"
+#endif
 
 /*
  * Local source-level compatibility with Unix.
-- 
2.47.1


