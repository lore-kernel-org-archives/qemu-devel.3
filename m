Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B31C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mb4-0006EX-EX; Tue, 30 Apr 2024 08:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mb2-0006EG-IM
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:32 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mb0-0001ls-SZ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:32 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso7145780a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480108; x=1715084908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hkxy+q36ycHAd+y0qweEznlxDOkt7GiSqjsKlga6SbM=;
 b=cmkkvxkor0QS3ssLiEzPKl2uhhizZ/NIxWUKRiHMN2YzdpCbPa2ilEpCD4dA+MfOqX
 aXAdZbPhynmzGEkwK+HfJ0nnTpfYXx0cfkr+F9C05dgtB/TYKn5ZMgffPpu0hJnl2eb9
 B7wYfI1A4qobU+H+x428EK+G9aUAkTnjVV264zfjWTz/ElHlSxQ5qtr7PHwyhOWnJNuD
 Qc/56lO6BcQmpRxmOi+b/7KQJLC50hCSGo6HGuM0q9u8he/bbj3bpTL7TuHuo9jAOhfQ
 AcbQH1yikv510wJvUtqjE+rtPcJripB1yooVjH8qrplEAN7dIOzYtKVT/b4d31Sla/ve
 +F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480108; x=1715084908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hkxy+q36ycHAd+y0qweEznlxDOkt7GiSqjsKlga6SbM=;
 b=qYKij0WQOLhWwEUYhg4I23rYdvJaROxSCx7kYSIJN/rdqUp5qaNhOiNgcUVdjCMjvR
 k1n27bV2wxjSYZpdUQEMOIApKIonbKR2IIAgWSyY3mdgjEGX+LolBzhXAIckz+hJJIH6
 2ALkV/zyCymGSp7vgczyRyAdBKn4pBnjwEN51+VEpxwAwvvMuPueu10C5OMaqIgFNW6i
 ZrKlUbQC0hMF2Zq7mpDuIpYdJLNeu/9p0TMBZCnKgHUgfRrYZ7PY4HfhMyQhtGTJ42Mk
 qhC6iWop0kpykVE9nsu3f9B2V6IsXRli49j+EDSFYNK8riWDaU8MK+U39yWrsLvwPFWW
 TYlQ==
X-Gm-Message-State: AOJu0YxxHpcyXPv7v+62carwitgz1BnmpZykG19pnn2sC7Z5kaGIG5sp
 XaTY5q21vrkzQzFYSRTdrSTzxjYY90iffxbDcwfhZcS9yP5H86DF52nWa6rHaYyZBPIwQbdFVVt
 g
X-Google-Smtp-Source: AGHT+IHjEWPI9Domke9SWwtpjDi7d3TvSbDXHacq1X09ORtcXkMU2RY5nCO65Fp9UuMOYz8TQ1LuxQ==
X-Received: by 2002:a17:906:414:b0:a55:bd8e:b6ef with SMTP id
 d20-20020a170906041400b00a55bd8eb6efmr8786834eja.37.1714480107781; 
 Tue, 30 Apr 2024 05:28:27 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 h26-20020a17090619da00b00a588729de82sm8190841ejd.142.2024.04.30.05.28.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:28:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/13] accel/tcg: Move @plugin_mem_cbs from CPUState to
 CPUNegativeOffsetState
Date: Tue, 30 Apr 2024 14:27:57 +0200
Message-ID: <20240430122808.72025-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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
 accel/tcg/plugin-gen.c      |  5 +++--
 plugins/core.c              |  2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 5061687900..867426500f 100644
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
index 55555be618..571ef3e514 100644
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
@@ -509,11 +515,6 @@ struct CPUState {
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
index 41db748eda..99a32446e9 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -229,7 +229,7 @@ void qemu_plugin_add_dyn_cb_arr(GArray *arr);
 
 static inline void qemu_plugin_disable_mem_helpers(CPUState *cpu)
 {
-    cpu->plugin_mem_cbs = NULL;
+    cpu->neg.plugin_mem_cbs = NULL;
 }
 
 /**
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index cd78ef94a1..fd268c79b5 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -178,7 +178,7 @@ static void gen_empty_mem_helper(void)
     TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
 
     tcg_gen_movi_ptr(ptr, 0);
-    tcg_gen_st_ptr(ptr, tcg_env, offsetof(CPUState, plugin_mem_cbs) -
+    tcg_gen_st_ptr(ptr, tcg_env, offsetof(CPUState, neg.plugin_mem_cbs) -
                                  offsetof(ArchCPU, env));
     tcg_temp_free_ptr(ptr);
 }
@@ -634,7 +634,8 @@ void plugin_gen_disable_mem_helpers(void)
         return;
     }
     tcg_gen_st_ptr(tcg_constant_ptr(NULL), tcg_env,
-                   offsetof(CPUState, plugin_mem_cbs) - offsetof(ArchCPU, env));
+                   offsetof(CPUState, neg.plugin_mem_cbs) -
+                   offsetof(ArchCPU, env));
 }
 
 static void plugin_gen_tb_udata(const struct qemu_plugin_tb *ptb,
diff --git a/plugins/core.c b/plugins/core.c
index 09c98382f5..a097d02788 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -496,7 +496,7 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
-    GArray *arr = cpu->plugin_mem_cbs;
+    GArray *arr = cpu->neg.plugin_mem_cbs;
     size_t i;
 
     if (arr == NULL) {
-- 
2.41.0


