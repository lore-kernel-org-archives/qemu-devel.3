Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7945DE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfir-0004Tp-Gg; Fri, 20 Dec 2024 11:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfik-0003jk-7L
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:22 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfii-0008Ff-B3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:21 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so1633606f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711558; x=1735316358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v56JompxPLKPsYxp/BZ65nIAlGi/uwwkXsl2uLdTi1s=;
 b=yTEaRjLaOLC/nH036+q/0v3Z3levp+A90WgNvkyRYwtOtTALFQ8AzsGnDNgkPZzNVM
 QddUuiCL0L5Hs4xh9LBySH0eRHIeLAiZ2WU3Qlh3truG3GGEsK/cgki7iTouysUAQBGD
 tcl6IeRozJF+nvKQCz89qK1Oq6zPvEcMGZ8Ffib7oKi8wVJoHFa++giGCJ1QxrDb/KWw
 ehuUgbOgfD/cETBTP/tXFLiyjx0BmSLrCZ4Dh8lwN4VssyR8pwF/uAN3NsDp8cTGrsOt
 meN71GnqwsniZauCtv2iwBlslpldN4lAKnJ6XwIgoBdgLD7+Pp4H4jS1OOdomWsig3ZA
 JOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711558; x=1735316358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v56JompxPLKPsYxp/BZ65nIAlGi/uwwkXsl2uLdTi1s=;
 b=YXgO8llKhbrBcvrCGJH4Z6usHPi8yWb6aLctkwg9a7P57hksiMdQ27kRKpEbD635Ma
 6/bAiz7hd5yapUfdyXpWwH0iNkvhFuwrxoLY6UF6YAHP0yDl75jCXi0YwLU5AHYgaFPj
 2tMDiWH0/nfEwlAgHdh9sx5t6LN7o6XLn0dT2IJN3li/5RcQdkWmncvnPV7Z6r2gjnYE
 zKM9G6EN8FjNXkwlqNq6QbYGjP79BWZLd3ed9YhoPbvP2MbDHu/3zqyqAy6Sd9dpijPO
 62B+t5HVHPGF7QQJhcaGEA/X9rSatG836lCmn5J776/UcjFF2sEkGU8uzw8vVrjV+b6I
 88sw==
X-Gm-Message-State: AOJu0Yz42k+9AfjCQgXvdjbm7YMgiOwk/PoEq6ezecxm3rPSK7q4uzSW
 Qs8+75FhS9gG06+o+ZVR1DZt1gST2GuSEhxBGc1PiXgrZR6TXMVo4xmbv4+GlBK2BZPR4OkyeQK
 W
X-Gm-Gg: ASbGncv8PK6x2RqBud4WxX2StKLlZYL4jrIn5PT7oWVft8R1CbNFWLozlU20gJObt4D
 RpU/LcTTv4VYhkg4Hi2AEPd/u6XKKEDgmV9HPCylctXrTSgqD4/jn1oTSZULnwE92srjAXTcqH/
 ZnNpX3E555YAgYBvVgqoo8vLxOZJ2hoS1vWNp6o4ZLnlxvuc22ejmXj/qX+NNM+8y4vFpLvxg/b
 dXKoyeRsBjsEQEThScCOk4M+n4z2OmRXO6Kt+SraIsFwjW63nvAZ6r8VEyqgmfePjaQmt8K4Wg=
X-Google-Smtp-Source: AGHT+IGGaJDhR8It2vMqnB1USyrtS2iDy8u7Xt9NOWceyZOEfSDC9F4CTVzFaEGOYPfl0wOc+emj5A==
X-Received: by 2002:a5d:5847:0:b0:385:f6de:6266 with SMTP id
 ffacd0b85a97d-38a221fd10cmr3641047f8f.24.1734711558322; 
 Fri, 20 Dec 2024 08:19:18 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847214sm4380946f8f.46.2024.12.20.08.19.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 45/59] accel/tcg: Declare cpu_loop_exit_requested() in
 'exec/cpu-common.h'
Date: Fri, 20 Dec 2024 17:15:36 +0100
Message-ID: <20241220161551.89317-46-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Move cpu_loop_exit_requested() declaration to "exec/cpu-common.h",
along with the related cpu_loop_exit_noexc(), cpu_loop_exit(),
cpu_loop_exit_atomic() and cpu_loop_exit_restore() methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241217140648.98538-1-philmd@linaro.org>
---
 include/exec/cpu-common.h     | 18 ++++++++++++++++++
 include/exec/exec-all.h       | 17 -----------------
 accel/tcg/cpu-exec.c          |  2 +-
 target/arm/tcg/helper-a64.c   |  1 +
 target/s390x/tcg/mem_helper.c |  1 +
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 638dc806a5f..0cf9a3d369c 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -186,6 +186,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 void list_cpus(void);
 
 #ifdef CONFIG_TCG
+#include "qemu/atomic.h"
 
 bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
 void tcg_cflags_set(CPUState *cpu, uint32_t flags);
@@ -218,6 +219,23 @@ bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
  */
 bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
 
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
+
 G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
 #endif /* CONFIG_TCG */
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index c4a6ad3af2d..d9045c9ac4c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -27,23 +27,6 @@
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
 
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
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index e9eaab223f9..c07e59cd0b1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -25,7 +25,7 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "trace.h"
 #include "disas/disas.h"
-#include "exec/exec-all.h"
+#include "exec/cpu-common.h"
 #include "exec/page-protection.h"
 #include "tcg/tcg.h"
 #include "qemu/atomic.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index b6af2a59d63..0e130501fd6 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -28,6 +28,7 @@
 #include "qemu/bitops.h"
 #include "internals.h"
 #include "qemu/crc32c.h"
+#include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 307388e5bd1..32717acb7d1 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -24,6 +24,7 @@
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
+#include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
-- 
2.47.1


