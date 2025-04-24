Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECF3C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kyY-0008H5-Fp; Wed, 23 Apr 2025 21:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwy-0005RJ-0M
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwv-0005Xc-Hn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225477548e1so5257455ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456420; x=1746061220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lgi2ZSVQ13wT2MCsVR2Sol/xGooWiIWNyPhzHZZ9Q0k=;
 b=GbpJShh0m2EcKxP93T2QMBBw0ykBmXncUd3Kg7bRHYkUWA79yowu6rGVyDc0+hSG+8
 BRg5nD1wZW+LO55JMQ6u6lBNlI8fMzvmwZeK7Pw7mzfNPu31yZrsi78Sl4NNqGpzs0yM
 wxkGQ8OsTRX7165a8Zr9Xm90QsmIMQ1PpdujCRf65Y8IlHD9xWafCguFrRZ5MOlGsZke
 wBRlT05x4KOryn4UZb1JSKkqrc1LEP5i3WRQGruxLkU8mSURa2tegujbnHoDFPun05Zk
 u7N7F+9FMiKP0mkJ/PVO2cBBGdnlc2Li7ar4dF6ldsOj487yCf1IeRdDhZQoJeA//9SA
 dvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456420; x=1746061220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lgi2ZSVQ13wT2MCsVR2Sol/xGooWiIWNyPhzHZZ9Q0k=;
 b=Xdzd36it2mFWqSW3NMJIy7JA+WoDNUpaoaIGzFNBV2LSEJgmcoSWpsB1EUqgTWixTC
 i1uYQLfKagzcOqPZqww97VCMrPe3A6lPYuRq6Pc1e/ryeS1UZHHmW8uKgxzhslBpgjId
 vwyrf+p60dPGqzPgyRW1+x6G+oMHdHyhpy8u3RQutVJwRrNK1tWNpWk8wez6FNh34qXW
 Juo9U11XynZK3UYHaVbx2HAs/TbTsrbOLFE77CPmOX5bwwehcPyxMoOLmQTOeYfBe0yL
 FiCu+iFcshMS4zcaNwqFHNf6yVJ/0Mkgao1GGg1MZjOMowffeZ+FVgWNPJIqmrLeeeJO
 DCaw==
X-Gm-Message-State: AOJu0YxZcawVCsS7Ezl9fNMGckVQKtZijVUPza2FsQHLF6r0PuuDUIly
 fMAMz82Y5tU9A5JjfOu9sxIvsdMyqqlcGkdpmMacENovgzzyCDRGQA9n8OM1hQamJPFjcvyfc7r
 j
X-Gm-Gg: ASbGnct2J7hNX4xALuiYSOOujInH7sZmCbO4HuJfwREzMn2F1W8HQFwW2qNvCnAo/jK
 +6p1Bh83/7uufKTZaqoMK/PsAF+SFSKC1ISR118jrHbilq5pNB7S6EBvTRkOLUphObO9pw7CM58
 0PXzyiaO1rikt3eGyOCO8VyvQRspW3eaWF+CRJSqmaSSTuf3/cB9tUrXpaodBzrwl2gHPuef/WG
 qLaPuR5NjezsHSzhqzW/0b4IbC+fhHinjg2kjrkJAMLquX6XtybcxjfhzXheSuHvWHHPMRNvg2E
 xJPHvr0cjYK6robM5J2XwdaOIwO0vdlAZKh/7FEP32AW5UkYxYYHiZDay1aKKJdnSqTEKmkCfWg
 =
X-Google-Smtp-Source: AGHT+IHuDc5L+5hvxr2AI4pEt+z4f67wa6Fv/nuA9rIADwSDhJ1mc8Xq15USSdXK0xNXougF4gsM2A==
X-Received: by 2002:a17:903:230a:b0:21f:4649:fd49 with SMTP id
 d9443c01a7336-22db3db67dcmr7906825ad.49.1745456419748; 
 Wed, 23 Apr 2025 18:00:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 142/148] tcg: Move qemu_tcg_mttcg_enabled() to 'system/tcg.h'
Date: Wed, 23 Apr 2025 17:49:27 -0700
Message-ID: <20250424004934.598783-143-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

qemu_tcg_mttcg_enabled() is specific to 1/ TCG and
2/ system emulation. Move the prototype declaration
to "system/tcg.h", reducing 'mttcg_enabled' variable
scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250403220420.78937-17-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h      |  9 ---------
 include/system/tcg.h       |  8 ++++++++
 accel/tcg/tcg-all.c        | 17 ++++++++++++++---
 target/riscv/tcg/tcg-cpu.c |  1 +
 4 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 10b6b25b34..c8d6abff19 100644
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
index 73229648c6..7622dcea30 100644
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
index 3efc7350eb..bb759cec07 100644
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
@@ -106,14 +117,14 @@ static int tcg_init_machine(MachineState *ms)
     unsigned max_threads = 1;
 
     tcg_allowed = true;
-    mttcg_enabled = s->mttcg_enabled;
 
     page_init();
     tb_htable_init();
 
 #ifndef CONFIG_USER_ONLY
-    if (mttcg_enabled) {
+    if (s->mttcg_enabled) {
         max_threads = ms->smp.max_cpus;
+        mttcg_enabled = true;
     }
 #endif
     tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_threads);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 50e81b2e52..88f7cdb887 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -36,6 +36,7 @@
 #include "tcg/tcg.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
+#include "system/tcg.h"
 #endif
 
 /* Hash that stores user set extensions */
-- 
2.43.0


