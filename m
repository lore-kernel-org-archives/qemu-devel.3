Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F31C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JT9-0006Vh-GZ; Tue, 22 Apr 2025 15:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSN-0004Kd-I3
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:02 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSK-0007NM-2e
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:58 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so85309145ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350734; x=1745955534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lgi2ZSVQ13wT2MCsVR2Sol/xGooWiIWNyPhzHZZ9Q0k=;
 b=V9NV6X2gO9YPyy1sIz1UgClUCoovnkHdJjQ4Cb+t+z7MsFQssdm/EWdzO40/2fLerP
 Mhz6o+YtybiPJnjFiActyGNxE1lS59L40UWWBnbZFe1gGg/uIIevAAk7eQrTjgKKNjJQ
 lgU/0LJhhdLN69Z7WYcXk4qtBe/JqO7hEza6a4zF9+thCGU6+dqDkOv8DH9gTsdDSjOL
 btcXURLRE5l/4l6+1/ggcsiebKhUzeo/DTdqyRHbuycEz4+GsHvjKHmjEzK04p8MaGRK
 1w70ItkOLdq30sr2lPgsk9ByqyjFIzvnpaa7gX8wU8/wNWHrrKBm35dnHTXX6ivKGwLQ
 VO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350734; x=1745955534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lgi2ZSVQ13wT2MCsVR2Sol/xGooWiIWNyPhzHZZ9Q0k=;
 b=P7INJ0d17osGAbogwP1C7fqkUkSWpAxKb3YLcmapoiBFZUigLN+TQzWby6MZmNl8BQ
 aL+NUrjTkpDlVx88iyrYv4JffdhHG5qCcWykMuQ0Uv+8JqwN8MzMlUHh94ibDooMAyRb
 vmHA9/axGifx9Ldso5ECdaKRQGHdc8/ZAhek3LUuVF37/j4YuRD4ymqV1UMUu6BEW9Ae
 Vp+2fVoPS3aWrvOwjp0kJ9xQJmhBCbXACw0FAnFKVWhBJXWP88TFYczzzeK/AsoXtHHM
 AnyD9rcbrPqRNFIayP0o9c+4RULTAxCdhe+Wy3qBafwjhWfmETs3i5Pu5Yh3KIFbvipT
 DvLg==
X-Gm-Message-State: AOJu0YwVdHFaf6CG+7df0qMow4K1o/3rE8edSLd/ZRINPJwfCtU0uoHM
 avVst8UsDsORqwMEIlE9CSe7sR+2Vbhr6cYjLhS7MGYg8Pzzq/HN8L6eFxVC4JiC6g5qbdBe+e4
 8
X-Gm-Gg: ASbGncuIK/LBQz6Ee/SpuIxg+HZrzzH8MwIHa8BdzyPNkT09PA84WmM7JRksy+912X/
 KVRdou4ofmXh1fWNEksTvmjNS1mY+0K6/jVhhGrlCD+F4DWtovPnKhFaXlawmLkvthfdQ1Xizcg
 ya2JCQgEg0LT9jPj38SovZ3nqyF8lNno0hKRxYUXbhF/JrsONdZ0kZzsfiP4RRf9MuEijMeZB9N
 dmTtgpfhMU/eERt2cTt15YreBqBF7kY+mVttCuRJZfdLJtNytRuMhktbevzXfTtHCzwZSXdNNYy
 UPaWmJbiImNg6I4rant9gVLmVIa1S8ki32bDewOsIHWdAmhRVzJ9gMtKfVJD0cz8UAe2020EfM8
 =
X-Google-Smtp-Source: AGHT+IGr+gExjmgnV7yjdS5opKkbSYL+ooMSYnyKBhvKwkj+sNHat9/zjcOC6/XzXYh52nRO0x8s6g==
X-Received: by 2002:a17:902:e808:b0:223:8256:533d with SMTP id
 d9443c01a7336-22c536207d3mr243061725ad.46.1745350734114; 
 Tue, 22 Apr 2025 12:38:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 141/147] tcg: Move qemu_tcg_mttcg_enabled() to 'system/tcg.h'
Date: Tue, 22 Apr 2025 12:28:10 -0700
Message-ID: <20250422192819.302784-142-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


