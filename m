Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D44C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfKS-0001Ck-Eo; Fri, 20 Jun 2025 13:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfK6-0000do-DY
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfK3-0004En-GW
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450dd065828so15563405e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439678; x=1751044478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKQzzq9lLqdwf03s1WVF2qDMjalaq94J2kEAmGiPnJg=;
 b=ihpbS+aZ+2x3n1nlxK5R5adhGqpCkBJyiQriBcfi5tuUXQd4kKIqRUirTY7lW6Toa7
 j+ikUNhJm4X404Lv0BY6+ZafqYPL1pKtCrUhGpN4Ye+RrSBw0nZbLCZQDh0PnMNW47nc
 rn8CGJg79D9qaK5qnuBsSCrl4jOmmlTh1Kc/QnRrpMVLvmFHvJDZVR+3qaOlMvRziUKu
 8wbnzS4SKr9A3vzIg/9rkSnVNwc6EN1YaX+u54KpJQz9jA9CSFv+BO9oF9Ly8IUaxIRr
 nXd9jGCK7MN1/XinZu3WqukvZ5QYCUGZ7CWcWzUg/62v1OwnkJAFqbwk/VdQlqF9ZW1q
 MqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439678; x=1751044478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKQzzq9lLqdwf03s1WVF2qDMjalaq94J2kEAmGiPnJg=;
 b=U9BgMaF01GvoUJBujEmzeF5LqR4nk4Ar+HQbnagnDweCPKlxCvgmpAZ01hl/uw07HB
 NpXhFEjX/u4Fft0y0eOtl+mPdV7OGkq07SoxYgYBxSvYOhi4g/reMw77Ck5JWF+Q+Yqz
 GnUydSy3v+QpEsknfRfQ+7Fl4R4FNnihhGajInKvzd4yjt7DoBG7Kshzv7H2TbG5hkpC
 cOpZ8Ay5zROe1pu9K0B9MYKcaxO1cdaHxvndJsjIHSw8Xt1AmSWw8ENkpHjNgeSspJfp
 XGOkW88ZkgWTSDE6iW6FPRqioEZQuQy8kdrPqL5Cvx/D/soHJ6cKCvn/xumE9GXbouY0
 pwEg==
X-Gm-Message-State: AOJu0YzYQaFKAU/hP9YlC121kiLw64naSmET73x1DvBqU6PzeVrAyKQX
 CO6/FmvGU9rWYgrMNZOv/SzucORpf9sjL0IT0GItAdyeo3TOIwM27zn+xpuzeCrvYePyzbBvAG+
 1ytFkiOQ=
X-Gm-Gg: ASbGnctWi/L6GJ413H7gDe5zqnwwISdwyoDc4Kk81YJuDPFFplpX1Zw8/WlammM4Gli
 UdZKCV5+fpVkKmTvYhmSuEG9R0GFX3hO0R2lApnrQGF+sx3oVZyo2Gz2DfCgGiIRcVZSlwmNbFp
 1z0TYl/5WYGOi3XCgpqP1tOLT9QpQN+ktrlRDeOmIsLZOs+RqhpahgyF1ih9FAc8PqKCG4dOVsr
 mglYmsPJgIRE2mjOlHFn9Xf4nwb3fprttNdapPCk8mokx221hQsQV55i9CIUYpu/ePs0sjDWq6M
 Cc/ITUM69ID7MHaduPzPq0AzIWxdyobNy+qQsz7WI1/GXd2EOptp+R4mY1taaNUHBP5fm8MyppF
 4FLsIc9xYtB/+O/WC4sPyEGfFaoIzQY1Zzmq6
X-Google-Smtp-Source: AGHT+IHBpy1rtOp0zhDj9xbzdkOOZ6deJ3qkm8c7r0Kr49K8QEK/Tn2PIUc9H5NhbKotkGiBYbTaMQ==
X-Received: by 2002:a05:600c:474b:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-453659badb1mr31933585e9.27.1750439677661; 
 Fri, 20 Jun 2025 10:14:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536470826fsm30586025e9.36.2025.06.20.10.14.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:14:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 11/48] accel: Move supports_guest_debug() declaration
 to AccelClass
Date: Fri, 20 Jun 2025 19:13:04 +0200
Message-ID: <20250620171342.92678-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
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

AccelOpsClass is for methods dealing with vCPUs.
When only dealing with AccelState, AccelClass is sufficient.

In order to have AccelClass methods instrospect their state,
we need to pass AccelState by argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h       | 1 +
 include/system/accel-ops.h | 1 -
 include/system/hvf.h       | 2 +-
 accel/hvf/hvf-accel-ops.c  | 2 +-
 accel/tcg/tcg-accel-ops.c  | 6 ------
 accel/tcg/tcg-all.c        | 6 ++++++
 gdbstub/system.c           | 7 ++++---
 target/arm/hvf/hvf.c       | 2 +-
 target/i386/hvf/hvf.c      | 2 +-
 9 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 2831e61de08..b807cca6678 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -50,6 +50,7 @@ typedef struct AccelClass {
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
+    bool (*supports_guest_debug)(AccelState *as);
     int (*gdbstub_supported_sstep_flags)(AccelState *as);
 
     bool *allowed;
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index a863fe59388..51faf47ac69 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -65,7 +65,6 @@ struct AccelOpsClass {
     int64_t (*get_elapsed_ticks)(void);
 
     /* gdbstub hooks */
-    bool (*supports_guest_debug)(void);
     int (*update_guest_debug)(CPUState *cpu);
     int (*insert_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
     int (*remove_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
diff --git a/include/system/hvf.h b/include/system/hvf.h
index 8c4409a13f1..7b9384d816c 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -71,7 +71,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu);
 /*
  * Return whether the guest supports debugging.
  */
-bool hvf_arch_supports_guest_debug(void);
+bool hvf_arch_supports_guest_debug(AccelState *as);
 
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 3797cab2bf6..45dd4baa321 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -364,6 +364,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->name = "HVF";
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
+    ac->supports_guest_debug = hvf_arch_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
 }
 
@@ -600,7 +601,6 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_breakpoint = hvf_remove_breakpoint;
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
-    ops->supports_guest_debug = hvf_arch_supports_guest_debug;
 };
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 37b4b21f882..07b1ec4ea50 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -106,11 +106,6 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
     }
 }
 
-static bool tcg_supports_guest_debug(void)
-{
-    return true;
-}
-
 /* Translate GDB watchpoint type to a flags value for cpu_watchpoint_* */
 static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
 {
@@ -218,7 +213,6 @@ static void tcg_accel_ops_init(AccelClass *ac)
     }
 
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
-    ops->supports_guest_debug = tcg_supports_guest_debug;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
     ops->remove_all_breakpoints = tcg_remove_all_breakpoints;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 4eb49c6407d..164bba41ed9 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -219,6 +219,11 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
     qatomic_set(&one_insn_per_tb, value);
 }
 
+static bool tcg_supports_guest_debug(AccelState *as)
+{
+    return true;
+}
+
 static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
 {
     /*
@@ -242,6 +247,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     ac->cpu_common_realize = tcg_exec_realizefn;
     ac->cpu_common_unrealize = tcg_exec_unrealizefn;
     ac->allowed = &tcg_allowed;
+    ac->supports_guest_debug = tcg_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
 
     object_class_property_add_str(oc, "thread",
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 8a32d8e1a1d..bced226fd94 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -634,9 +634,10 @@ int gdb_signal_to_target(int sig)
 
 bool gdb_supports_guest_debug(void)
 {
-    const AccelOpsClass *ops = cpus_get_accel();
-    if (ops->supports_guest_debug) {
-        return ops->supports_guest_debug();
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    if (acc->supports_guest_debug) {
+        return acc->supports_guest_debug(accel);
     }
     return false;
 }
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 87cd323c14d..48ce83eb8fc 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2409,7 +2409,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
     hvf_arch_set_traps(cpu);
 }
 
-bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(AccelState *as)
 {
     return true;
 }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 28484496710..bcf30662bec 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -1024,7 +1024,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
 {
 }
 
-bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(AccelState *as)
 {
     return false;
 }
-- 
2.49.0


