Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBAEC27C43
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByJL-0000eZ-1M; Tue, 28 May 2024 11:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJE-0000e8-NK
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:16 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJC-000759-Mk
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:16 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52388d9ca98so1604696e87.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716908412; x=1717513212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQcbwizGTPGLe0I7sDsQyBs7g4DJMYLbmLP09XmJRR0=;
 b=Czex2/t8O7se/uXPr0z5QwXQFhYB8DeINFLrTEKcaT90yNsZm7idmEurYh4WEqAJpX
 jMfr1l0uNx8mKEI4UYmQjreeuAjJTgDzxlLJH/MPw4ATrPoFybMn3ap2lHAUaB1CsCz0
 DktJDTOIwSiZQVsBDzD/IXfXJZQvuGjQHS3HKJSP0laHELWCIo4LAsyjfH7CLmOhUErk
 DFSyHL+R5vXxwLUFjtRfQZnIzrXvnZREHjO7RIqX3JFcjASXqROksFYEKZD+mA9OlE4A
 8QZPPxwLEi/NsehS+MD6U0N19fmmqNFGQCFaOqIJwGRKrnzqJdoGYENFfwrE58+BAzxq
 ru9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716908412; x=1717513212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQcbwizGTPGLe0I7sDsQyBs7g4DJMYLbmLP09XmJRR0=;
 b=Zrov4+S00WfkrnPhn+UJTRsOiFC6JDAsb2eEwQqvVAoczT0O2GQq45SQ18Zw0ySkFD
 ejwSjX7meGAkKalVbSKNV50PyjCoMReqTfi7nrcaQt8fBV8d24v6iaOzjcU2LiVqyemF
 yljwaW68gWD+JqOzwnsn18xXgdTbxg/o5GbPQC8tRTtbC0jErGYtiDfms0uCsD6WBmuf
 ounJOVWzu7bHQ2Y1ajV0FLcOr3DV+shsQcoWN7q808MWDuEq7GNBGaioaq3dmkUy/8gc
 Uj6p4npXbFHYUSv2mgzjRKe//udPuBKOV+1GhaYNYARn8a2wTxIhPN6cX8q5AibXUPvd
 qO1Q==
X-Gm-Message-State: AOJu0Yz9akHzZfZyGrFgdh6jD8WPlHtZDic0elHdaV3FGtYWvxAEKrU4
 AcAZG+6tTIIZCR/b02b77hXEJ5vVfT1VmzAAqTAO3ep8INnZHF8Igk18/sXHDTU2yTAik6AOPfs
 A
X-Google-Smtp-Source: AGHT+IFIQ7KEHCMux0H8Ej1oxRWl03Ai+4ju5ILl7EZbvYQXHjzBEBsx3vPnpSEAnbddwGSJBxRJIw==
X-Received: by 2002:ac2:46e2:0:b0:51f:4d57:6812 with SMTP id
 2adb3069b0e04-5296594cfc7mr9627468e87.19.1716908412379; 
 Tue, 28 May 2024 08:00:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.214.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cd9fed2sm622256666b.187.2024.05.28.08.00.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 08:00:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/6] accel: Clarify accel_cpu_common_[un]realize() use
 unassigned vCPU
Date: Tue, 28 May 2024 16:59:49 +0200
Message-ID: <20240528145953.65398-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240528145953.65398-1-philmd@linaro.org>
References: <20240528145953.65398-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In preparation of introducing [un]realize handlers for
when vCPUs are assigned, rename current handlers using
the '_unassigned' suffix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h |  4 ++--
 include/qemu/accel.h        | 17 +++++++++++------
 accel/accel-target.c        | 11 ++++++-----
 accel/tcg/cpu-exec.c        |  4 ++--
 accel/tcg/tcg-all.c         |  4 ++--
 cpu-target.c                |  4 ++--
 6 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index a8fc3db774..ec2c6317b7 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -53,7 +53,7 @@ TranslationBlock *tb_link_page(TranslationBlock *tb);
 void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc);
 
-bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
-void tcg_exec_unrealizefn(CPUState *cpu);
+bool tcg_exec_realize_unassigned(CPUState *cpu, Error **errp);
+void tcg_exec_unrealize_unassigned(CPUState *cpu);
 
 #endif
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 972a849a2b..dd18c41dc0 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -43,8 +43,8 @@ typedef struct AccelClass {
     bool (*has_memory)(MachineState *ms, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 #endif
-    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
-    void (*cpu_common_unrealize)(CPUState *cpu);
+    bool (*cpu_common_realize_unassigned)(CPUState *cpu, Error **errp);
+    void (*cpu_common_unrealize_unassigned)(CPUState *cpu);
 
     /* gdbstub related hooks */
     int (*gdbstub_supported_sstep_flags)(void);
@@ -92,17 +92,22 @@ void accel_setup_post(MachineState *ms);
 void accel_cpu_instance_init(CPUState *cpu);
 
 /**
- * accel_cpu_common_realize:
+ * accel_cpu_common_realize_unassigned:
  * @cpu: The CPU that needs to call accel-specific cpu realization.
  * @errp: currently unused.
+ *
+ * The @cpu index is not yet assigned.
  */
-bool accel_cpu_common_realize(CPUState *cpu, Error **errp);
+bool accel_cpu_common_realize_unassigned(CPUState *cpu, Error **errp);
 
 /**
- * accel_cpu_common_unrealize:
+ * accel_cpu_common_unrealize_unassigned:
  * @cpu: The CPU that needs to call accel-specific cpu unrealization.
+ *
+ * The @cpu index is no more assigned, @cpu has been removed from the global
+ * #cpus_queue.
  */
-void accel_cpu_common_unrealize(CPUState *cpu);
+void accel_cpu_common_unrealize_unassigned(CPUState *cpu);
 
 /**
  * accel_supported_gdbstub_sstep_flags:
diff --git a/accel/accel-target.c b/accel/accel-target.c
index 08626c00c2..e0a79c0fce 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -119,7 +119,7 @@ void accel_cpu_instance_init(CPUState *cpu)
     }
 }
 
-bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
+bool accel_cpu_common_realize_unassigned(CPUState *cpu, Error **errp)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     AccelState *accel = current_accel();
@@ -132,21 +132,22 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     }
 
     /* generic realization */
-    if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
+    if (acc->cpu_common_realize_unassigned
+            && !acc->cpu_common_realize_unassigned(cpu, errp)) {
         return false;
     }
 
     return true;
 }
 
-void accel_cpu_common_unrealize(CPUState *cpu)
+void accel_cpu_common_unrealize_unassigned(CPUState *cpu)
 {
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
     /* generic unrealization */
-    if (acc->cpu_common_unrealize) {
-        acc->cpu_common_unrealize(cpu);
+    if (acc->cpu_common_unrealize_unassigned) {
+        acc->cpu_common_unrealize_unassigned(cpu);
     }
 }
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 2972f75b96..08769cf91e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1074,7 +1074,7 @@ int cpu_exec(CPUState *cpu)
     return ret;
 }
 
-bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
+bool tcg_exec_realize_unassigned(CPUState *cpu, Error **errp)
 {
     static bool tcg_target_initialized;
 
@@ -1094,7 +1094,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 }
 
 /* undo the initializations in reverse order */
-void tcg_exec_unrealizefn(CPUState *cpu)
+void tcg_exec_unrealize_unassigned(CPUState *cpu)
 {
 #ifndef CONFIG_USER_ONLY
     tcg_iommu_free_notifier_list(cpu);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 2090907dba..c08a6acc21 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -227,8 +227,8 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
-    ac->cpu_common_realize = tcg_exec_realizefn;
-    ac->cpu_common_unrealize = tcg_exec_unrealizefn;
+    ac->cpu_common_realize_unassigned = tcg_exec_realize_unassigned;
+    ac->cpu_common_unrealize_unassigned = tcg_exec_unrealize_unassigned;
     ac->allowed = &tcg_allowed;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
 
diff --git a/cpu-target.c b/cpu-target.c
index 5af120e8aa..9ab5a28cb5 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -136,7 +136,7 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
     /* cache the cpu class for the hotpath */
     cpu->cc = CPU_GET_CLASS(cpu);
 
-    if (!accel_cpu_common_realize(cpu, errp)) {
+    if (!accel_cpu_common_realize_unassigned(cpu, errp)) {
         return false;
     }
 
@@ -176,7 +176,7 @@ void cpu_exec_unrealizefn(CPUState *cpu)
      * Now that the vCPU has been removed from the RCU list, we can call
      * accel_cpu_common_unrealize, which may free fields using call_rcu.
      */
-    accel_cpu_common_unrealize(cpu);
+    accel_cpu_common_unrealize_unassigned(cpu);
 }
 
 /*
-- 
2.41.0


