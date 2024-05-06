Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47488C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xcw-0004Fm-3m; Mon, 06 May 2024 08:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcW-0002QI-5s
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:04 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcT-00025Y-AW
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:03 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34d8d11a523so860204f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999138; x=1715603938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2P2Lp6Z6ney+zSdOdvmSI8h/fve28/uqRuYWe+tRCYc=;
 b=tXlWHPcHhzVz4qJYEFJhFI0bYhRwNL1uCBON+XwQKj5VUy1EfGM2nDOoJdnqPeHfe6
 2YZQH5wLHkI+wW5dIzmsIe0vhaSqp+YMkMBEafcHTw6S3r2OtvB6C1/f3Q79kJixk0BU
 w5xx+g92psGhJbMprGQkkJ5FL8r4VrKnI5UH7itQyLQrB0xQycXY6n3dWbPD7yallA2g
 SBjqkbjhf36LD6kYrxyuNHVL4CQLgi/6bgV3zwdF4BaBxhIglAO8/9b0loRc6CDW9wLc
 Y2pOoj3lVdPf+a6mR/m6bc0d4y9Seh2gVvcsSZTq8TIQ5Pk2sVWDpPBmzarVzBp3yjgm
 SR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999138; x=1715603938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2P2Lp6Z6ney+zSdOdvmSI8h/fve28/uqRuYWe+tRCYc=;
 b=jzMIkQkjUE9ugUZ2915aVlzX04jy1mQf5VnTYEj61QuSFmXkWhHNwlficx6BOmGl4o
 +SmEsUnVYKZLizOWuj1TYnTaO67jqJrdXCUvVXHqLdSH93yPapykCT/6k1/N+RVMUAsJ
 r2IX1DrOflBWupMkLdUIlF/KZ4aJFOhHH9d7kOfsuv72RilAo10/boREbCpGSK6mfniu
 naqiS70gp0kHZ0DYgAsV8UwQ6vxElJ8n9oBcBhcd4+XLE+wch01NcBfDXbcvb+GBa0Le
 IapM/G9HO+HaFrTsDLG28ZGcUx3LxZ3XNlmzk4JHj58RP8LDzaQxEdNLPtjA1XRW7Dmh
 bKzQ==
X-Gm-Message-State: AOJu0YzlvjktS3yA4NDzZUeASNPi+YSq9sateuSF2POJBd4+FmDT0Aqj
 Bq4QP+JiyErAd5N0Rerg2FekKezBVMXZNTxoreAB40x+FlC6fr5gGt+zCGfMqwuTjkOov/Yeb3A
 9
X-Google-Smtp-Source: AGHT+IGhEPmAtROJixUHN/3NgaDB4Ez+iwE/km2Vs3xU3kNnIhilr8fe9S4BRqVyF9oHidW67WmMvg==
X-Received: by 2002:a5d:6a83:0:b0:34c:c4fe:63d with SMTP id
 s3-20020a5d6a83000000b0034cc4fe063dmr7072541wru.29.1714999138632; 
 Mon, 06 May 2024 05:38:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 n15-20020adff08f000000b00343eac2acc4sm10630140wro.111.2024.05.06.05.38.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:38:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/28] accel/tcg: Move @plugin_mem_cbs from CPUState to
 CPUNegativeOffsetState
Date: Mon,  6 May 2024 14:37:12 +0200
Message-ID: <20240506123728.65278-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
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

@plugin_mem_cbs is accessed by tcg generated code, move it
to CPUNegativeOffsetState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240429213050.55177-4-philmd@linaro.org>
---
 accel/tcg/internal-common.h |  2 +-
 include/hw/core/cpu.h       | 13 +++++++------
 include/qemu/plugin.h       |  2 +-
 accel/tcg/plugin-gen.c      |  6 +++---
 plugins/core.c              |  2 +-
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index cbeff39e3e..cff43d221b 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -35,7 +35,7 @@ static inline bool cpu_in_serial_context(CPUState *cs)
 static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
 {
 #ifdef CONFIG_PLUGIN
-    return !!cpu->plugin_mem_cbs;
+    return !!cpu->neg.plugin_mem_cbs;
 #else
     return false;
 #endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a001bafcf8..6efd7353be 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -342,9 +342,16 @@ typedef union IcountDecr {
  * CPUNegativeOffsetState: Elements of CPUState most efficiently accessed
  *                         from CPUArchState, via small negative offsets.
  * @can_do_io: True if memory-mapped IO is allowed.
+ * @plugin_mem_cbs: active plugin memory callbacks
  */
 typedef struct CPUNegativeOffsetState {
     CPUTLB tlb;
+#ifdef CONFIG_PLUGIN
+    /*
+     * The callback pointer are accessed via TCG (see gen_empty_mem_helper).
+     */
+    GArray *plugin_mem_cbs;
+#endif
     IcountDecr icount_decr;
     bool can_do_io;
 } CPUNegativeOffsetState;
@@ -416,7 +423,6 @@ struct qemu_work_item;
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
  * @work_list: List of pending asynchronous work.
- * @plugin_mem_cbs: active plugin memory callbacks
  * @plugin_state: per-CPU plugin state
  * @ignore_memory_transaction_failures: Cached copy of the MachineState
  *    flag of the same name: allows the board to suppress calling of the
@@ -511,11 +517,6 @@ struct CPUState {
     QemuLockCnt in_ioctl_lock;
 
 #ifdef CONFIG_PLUGIN
-    /*
-     * The callback pointer stays in the main CPUState as it is
-     * accessed via TCG (see gen_empty_mem_helper).
-     */
-    GArray *plugin_mem_cbs;
     CPUPluginState *plugin_state;
 #endif
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 18062528c1..b535bfd5de 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -180,7 +180,7 @@ void qemu_plugin_add_dyn_cb_arr(GArray *arr);
 
 static inline void qemu_plugin_disable_mem_helpers(CPUState *cpu)
 {
-    cpu->plugin_mem_cbs = NULL;
+    cpu->neg.plugin_mem_cbs = NULL;
 }
 
 /**
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 3db74ae9bf..49f5d1c2e4 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -55,7 +55,7 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
      * Tracking memory accesses performed from helpers requires extra work.
      * If an instruction is emulated with helpers, we do two things:
      * (1) copy the CB descriptors, and keep track of it so that they can be
-     * freed later on, and (2) point CPUState.plugin_mem_cbs to the
+     * freed later on, and (2) point CPUState.neg.plugin_mem_cbs to the
      * descriptors, so that we can read them at run-time
      * (i.e. when the helper executes).
      * This run-time access is performed from qemu_plugin_vcpu_mem_cb.
@@ -90,14 +90,14 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     qemu_plugin_add_dyn_cb_arr(arr);
 
     tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
-                   offsetof(CPUState, plugin_mem_cbs) -
+                   offsetof(CPUState, neg.plugin_mem_cbs) -
                    offsetof(ArchCPU, env));
 }
 
 static void gen_disable_mem_helper(void)
 {
     tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
-                   offsetof(CPUState, plugin_mem_cbs) -
+                   offsetof(CPUState, neg.plugin_mem_cbs) -
                    offsetof(ArchCPU, env));
 }
 
diff --git a/plugins/core.c b/plugins/core.c
index 081323dafc..1e58a57bf1 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -533,7 +533,7 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
-    GArray *arr = cpu->plugin_mem_cbs;
+    GArray *arr = cpu->neg.plugin_mem_cbs;
     size_t i;
 
     if (arr == NULL) {
-- 
2.41.0


