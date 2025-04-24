Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBABC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kx6-00065n-0y; Wed, 23 Apr 2025 21:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwu-0005CF-4Z
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:20 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwp-0005V4-SU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:19 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-aee79a0f192so238466a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456414; x=1746061214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=daDsqIY3JqZY3gWJRoer5Pq3HW0D1tA51SVXkh4oP34=;
 b=NO60wzXQHPv3pD/ll92Gr40PZiTqBqR5QqRR5/VgkWyb08GwYU9i5vJ/RRgMoTwoVl
 5HEKR480zAHrl3tu/yPA5lWboNJx1nQW1qvAtHEGrL+M8nGd04BkOv8d0fh6Fi0FdhPJ
 kHe/V9X96Pat8xz1HBzv7n2OG+zZ6tH8YE6psz2ZNf/faNYlxpn+I5jeAMP8f+ixm70A
 7kD9m+3X6ZmRSl3JU+n3zph2faV+NP8ViP7rNBjPDFA88DCBPG323/ID4rdzOgobwJcD
 /+F4/T4A9iO4RjpXWhKSrYQARCn1jjZvRa8ZJFC+XWM2lTBTYAGFEI6LxLfFjx20xTnY
 tk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456414; x=1746061214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=daDsqIY3JqZY3gWJRoer5Pq3HW0D1tA51SVXkh4oP34=;
 b=jHZbLxWG1bDojskhP1j+PXq1JwSgq7lCe4Ptw45cPbGNmc0P0WfPngJDuc9teDy7hc
 jopCn1t2ovqnW3/aBL1b/kNYcmR83Mv8Hc5bN+l64yGC//u5VZg+bQ8CHCW9TUgqU0eC
 tDOTX4i8PjYqwrPLSeS00Y5jsX51EfMNoapIbKuFhOwQMdLwE7An8hOdzsaCNF1RYqwC
 8H2PggJFSo16tvXALrgsAqxUh5ive+PYPEL8aSowyIBzHG7MKQnGube1ZDCFmFlg+Fbs
 4CgS6ycU4R4iFuszxi8qtxTJvs+l7C6Dmjk1cF7ITLL7nZr+lVAID0U9WZf95Xk3LZU1
 /9xA==
X-Gm-Message-State: AOJu0YwHST9BFPyCBO6SqHnurp0CLA9NkNmE3z6EAoC79FxxAx2C7xJZ
 O+pr0eVsrnJyMP7tvKjHvHa0cjOfP+gDwYesRtLvArQdrfpk9+siLtc0XwnvcmbvuMDnNI5oDX0
 j
X-Gm-Gg: ASbGncvs5OiLeijTHNP0vXZsoV0MqhbId5dar4Gd5hFqbL7ziWJDJeTNuwEqjSlrdDm
 +7TnBm/R+8Gjgvjk7/2jbsDwShQCm+DsXImrS4Lt2yR7tDRDpZns4qQiImaEaAqOL9CeEd+9Mjh
 gJnE65ONCPRk+xuykGXcL6f1WHuHLPO5Tljss1Oox9nFfMtDnwTAIpa654smHH9HEooC75iZmID
 pvWzNPWZ0ILncPfgqBhPys7h8ONUSRPdTwJeNGIn475ENid8JUjkdAvTmApKHMGbVxlW9G5FH0J
 nPXzv3egtjKJ5ZKCDAVdhPZMhl8d+OtTom4vQMeaRdl1O8knAUMw+9/RDhROzRLYtgXo/Wht1mo
 =
X-Google-Smtp-Source: AGHT+IF/elVMcD8jn2pGIbS57sIKy9JumvR+m9Fg2VJzhNIXqu9QdesAQxZTlPEKHK9Te08Bge2QQg==
X-Received: by 2002:a05:6a21:1510:b0:1fd:ecfa:b6d7 with SMTP id
 adf61e73a8af0-20444f2e8cdmr937021637.28.1745456414042; 
 Wed, 23 Apr 2025 18:00:14 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 135/148] tcg: Define guest_default_memory_order in TCGCPUOps
Date: Wed, 23 Apr 2025 17:49:20 -0700
Message-ID: <20250424004934.598783-136-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Add the TCGCPUOps::guest_default_memory_order field and have
each target initialize it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 8 ++++++++
 target/alpha/cpu.c          | 2 ++
 target/arm/cpu.c            | 2 ++
 target/arm/tcg/cpu-v7m.c    | 2 ++
 target/avr/cpu.c            | 1 +
 target/hexagon/cpu.c        | 1 +
 target/hppa/cpu.c           | 2 ++
 target/i386/tcg/tcg-cpu.c   | 1 +
 target/loongarch/cpu.c      | 2 ++
 target/m68k/cpu.c           | 2 ++
 target/microblaze/cpu.c     | 2 ++
 target/mips/cpu.c           | 2 ++
 target/openrisc/cpu.c       | 2 ++
 target/ppc/cpu_init.c       | 1 +
 target/riscv/tcg/tcg-cpu.c  | 2 ++
 target/rx/cpu.c             | 2 ++
 target/s390x/cpu.c          | 2 ++
 target/sh4/cpu.c            | 2 ++
 target/sparc/cpu.c          | 2 ++
 target/tricore/cpu.c        | 1 +
 target/xtensa/cpu.c         | 2 ++
 21 files changed, 43 insertions(+)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 106a0688da..a4932fc5d7 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -16,8 +16,16 @@
 #include "exec/memop.h"
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
+#include "tcg/tcg-mo.h"
 
 struct TCGCPUOps {
+
+    /**
+     * @guest_default_memory_order: default barrier that is required
+     *                              for the guest memory ordering.
+     */
+    TCGBar guest_default_memory_order;
+
     /**
      * @initialize: Initialize TCG state
      *
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 99d839a279..6f931117a2 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -235,6 +235,8 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps alpha_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = alpha_translate_init,
     .translate_code = alpha_translate_code,
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c9e043bc9b..3f20e258fd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2671,6 +2671,8 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
 
 #ifdef CONFIG_TCG
 static const TCGCPUOps arm_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 1a913faa50..4553fe9de0 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -232,6 +232,8 @@ static void cortex_m55_initfn(Object *obj)
 }
 
 static const TCGCPUOps arm_v7m_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index feb73e722b..67918684fa 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -224,6 +224,7 @@ static const struct SysemuCPUOps avr_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps avr_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
     .initialize = avr_cpu_tcg_init,
     .translate_code = avr_cpu_translate_code,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index ad1f303fbc..b12e0dccd0 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -325,6 +325,7 @@ static void hexagon_cpu_init(Object *obj)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hexagon_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
     .initialize = hexagon_translate_init,
     .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 51bff0c5d6..ac4560febe 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -253,6 +253,8 @@ static const struct SysemuCPUOps hppa_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hppa_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = hppa_translate_init,
     .translate_code = hppa_translate_code,
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 35b17f2b18..3e1b315340 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -125,6 +125,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps x86_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
     .initialize = tcg_x86_init,
     .translate_code = x86_translate_code,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 4cc8e02f70..ee74509a66 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -864,6 +864,8 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps loongarch_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = loongarch_translate_init,
     .translate_code = loongarch_translate_code,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 4409d8941c..bfde9b8594 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -589,6 +589,8 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps m68k_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = m68k_tcg_init,
     .translate_code = m68k_translate_code,
     .restore_state_to_opc = m68k_restore_state_to_opc,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index d10ae0702a..e46863574c 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -427,6 +427,8 @@ static const struct SysemuCPUOps mb_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps mb_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = mb_tcg_init,
     .translate_code = mb_translate_code,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index cb0d6dde0e..67a8550cc1 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -551,6 +551,8 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
 }
 
 static const TCGCPUOps mips_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = mips_tcg_init,
     .translate_code = mips_translate_code,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index dc55594a7d..e62c698a40 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -243,6 +243,8 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps openrisc_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = openrisc_translate_init,
     .translate_code = openrisc_translate_code,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index fd8c42069e..1cf18e0dae 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7479,6 +7479,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps ppc_tcg_ops = {
+  .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5d0429b4d0..ded2d68ad7 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -140,6 +140,8 @@ static void riscv_restore_state_to_opc(CPUState *cs,
 }
 
 static const TCGCPUOps riscv_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = riscv_translate_init,
     .translate_code = riscv_translate_code,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index e14d9cbef9..d7eac551fd 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -204,6 +204,8 @@ static const struct SysemuCPUOps rx_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps rx_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = rx_translate_init,
     .translate_code = rx_translate_code,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d15b1943e0..f232d82fa3 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -345,6 +345,8 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 }
 
 static const TCGCPUOps s390_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = s390x_translate_init,
     .translate_code = s390x_translate_code,
     .restore_state_to_opc = s390x_restore_state_to_opc,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index df093988cb..29f4be7ba9 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -262,6 +262,8 @@ static const struct SysemuCPUOps sh4_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps superh_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = sh4_translate_init,
     .translate_code = sh4_translate_code,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index af3cec43e7..ef04efcb18 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1001,6 +1001,8 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps sparc_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = sparc_tcg_init,
     .translate_code = sparc_translate_code,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 833a93d37a..3bf399335a 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -172,6 +172,7 @@ static const struct SysemuCPUOps tricore_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps tricore_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
     .initialize = tricore_tcg_init,
     .translate_code = tricore_translate_code,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 51f9ee9e89..2347106495 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -232,6 +232,8 @@ static const struct SysemuCPUOps xtensa_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps xtensa_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = xtensa_translate_init,
     .translate_code = xtensa_translate_code,
     .debug_excp_handler = xtensa_breakpoint_handler,
-- 
2.43.0


