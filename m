Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC501C3601B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWhZ-0006oh-Rb; Tue, 01 Apr 2025 04:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhY-0006oZ-Q5
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhW-0005x5-0z
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:28 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso57950455e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495024; x=1744099824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLT+75V3t7RNN4nMFI51bEe1MWRh5zKTcQJOkQ4RnJY=;
 b=nw24V9IjPvPoWFmxYsModK1+HAfbKSFdc//0bKeYreW8w6JdpY0aun/v2UvqwuAAYA
 rmshCsbq++EiE+4twLFLsLFlgDaAUdT+a8yhoHV86SAx3g9HTIcer12/5Ortxoj1mJze
 1VNU6nZX+eMjxZRXqoSa6xXfiULxDi3S4SVdI8JXLBk59T92gMRzka4tvzgmG7QKf7x2
 zOy+QFY2rBxbKvS9+qiiWeOI0oDRdFfQo8Vxpvrw4pYN+wjdS5YVdLZ95GMhKjj8tyqV
 EetFDpDV9YwoMbkc62RVjiH003GCqw+Lip8owgXuX7U8k2s2n4zgmZbbpliEaNEGVsU1
 PHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495024; x=1744099824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLT+75V3t7RNN4nMFI51bEe1MWRh5zKTcQJOkQ4RnJY=;
 b=KGcglFAJFPpj7YI4Fzv0Im3LQJPswHwulQ3YatHCnMq8f0thbsshPuFie37PnL+Mdr
 OCCUHNEV7DKrRakfYi3RI/AVXL5KDFf5Dc2QRbrve6Q0bYQMe8FtOGjNSN5JQv8zohoN
 4iipuDzeDtynwCdvGLjXfht2+twwKOuZ3mx3tsxSC/fYsaGvyAZWLY8Vm5MCLcbrheV4
 BaxBj+1Yb0cUow2n0PIfL6mM6RhgVr0lD0OoZUfQXMlU3QD0IzQDlSseavqJNoW7tgNz
 fnfTcf7sFi6onU5blcWFfIYsHtL6YMQtPzSLMGYbaPdKswRIRuihIT3blE9iwODBvvNV
 iYXg==
X-Gm-Message-State: AOJu0Ywg+tXZhvvM2vc3hoHWfZAEPIq1nChT0w036QXj/HVWqT6toYiY
 Fxd3LEDvlK6N87DZxkt6LEA4JrjVh4tZEq+bc/ZnXNUAiIV58MPnhCvaR4V4IUakQ0XmXtboTbw
 s
X-Gm-Gg: ASbGnctM45FzSs3w4kFyieN+hGW1ueamGHLAIC5bCkSsPamXHgtgXNaRFJlKv7uopoc
 KBZGeS5NDs5frMLVDMH8ZkAGZnpdcK9QUPdEAloU+/QT56wPbI+gKu0bbdv0JMR8B37iAesREKL
 XqYDtK56AQNhTQvRGCyDEDjOMBbajNzmoZWkGwrG9IXSf/xW3vtbSFfDG9ji+oCfTXSSyxf4d5u
 krKpySwzb8gpjzP2SKDNN5sdwVpl/fHyWYHeBKpWhh/ykbEDJbdaClghjvXtEkvkX464MgRMPKB
 XwbzXd2Hum30MLnLINpkLSviDXvXbLOYOJSXqdrXaJNKRHckeiXxX/VJgh7QiMlIk0IsVTIxGUG
 uEpboXqKGcYgDFGuvUbQ=
X-Google-Smtp-Source: AGHT+IEA240eT2UcEirI+tY1FiLuMZYbWa6m/bvO61o/e0hhGdjDgpCum+kA+VwwWEoHpW0smkV2nw==
X-Received: by 2002:a05:600c:8711:b0:43d:49eb:9675 with SMTP id
 5b1f17b1804b1-43ea6b5ea46mr22206805e9.22.1743495023694; 
 Tue, 01 Apr 2025 01:10:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a8e0asm13312750f8f.101.2025.04.01.01.10.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 09/24] target/i386: Restrict SoftMMU mmu_index() to
 TCG
Date: Tue,  1 Apr 2025 10:09:22 +0200
Message-ID: <20250401080938.32278-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Move x86_cpu_mmu_index() to tcg-cpu.c, convert
CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h            |  2 --
 target/i386/tcg/tcg-cpu.h    |  2 ++
 target/i386/cpu.c            | 18 ------------------
 target/i386/tcg/seg_helper.c |  1 +
 target/i386/tcg/tcg-cpu.c    | 18 ++++++++++++++++++
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e23a947a7c7..35c16302bdc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2597,8 +2597,6 @@ static inline bool is_mmu_index_32(int mmu_index)
     return mmu_index & 1;
 }
 
-int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
-
 #define CC_DST  (env->cc_dst)
 #define CC_SRC  (env->cc_src)
 #define CC_SRC2 (env->cc_src2)
diff --git a/target/i386/tcg/tcg-cpu.h b/target/i386/tcg/tcg-cpu.h
index 53a84944551..7580f8afb4f 100644
--- a/target/i386/tcg/tcg-cpu.h
+++ b/target/i386/tcg/tcg-cpu.h
@@ -78,4 +78,6 @@ QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, pkru_state) != XSAVE_PKRU_OFFSET);
 
 bool tcg_cpu_realizefn(CPUState *cs, Error **errp);
 
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
+
 #endif /* TCG_CPU_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0b74b9a3754..d930ebd262e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8652,23 +8652,6 @@ static bool x86_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
-{
-    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
-    int mmu_index_base =
-        pl == 3 ? MMU_USER64_IDX :
-        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
-        (env->eflags & AC_MASK) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
-
-    return mmu_index_base + mmu_index_32;
-}
-
-static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    CPUX86State *env = cpu_env(cs);
-    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
-}
-
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -8910,7 +8893,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = x86_cpu_class_by_name;
     cc->parse_features = x86_cpu_parse_featurestr;
-    cc->mmu_index = x86_cpu_mmu_index;
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
     cc->get_pc = x86_cpu_get_pc;
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index f4370202fed..9dfbc4208cd 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -28,6 +28,7 @@
 #include "helper-tcg.h"
 #include "seg_helper.h"
 #include "access.h"
+#include "tcg-cpu.h"
 
 #ifdef TARGET_X86_64
 #define SET_ESP(val, sp_mask)                                   \
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 36b8dc78a3e..35b17f2b183 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -94,6 +94,23 @@ static void x86_restore_state_to_opc(CPUState *cs,
     }
 }
 
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
+{
+    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
+    int mmu_index_base =
+        pl == 3 ? MMU_USER64_IDX :
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        (env->eflags & AC_MASK) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
+
+    return mmu_index_base + mmu_index_32;
+}
+
+static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUX86State *env = cpu_env(cs);
+    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool x86_debug_check_breakpoint(CPUState *cs)
 {
@@ -112,6 +129,7 @@ static const TCGCPUOps x86_tcg_ops = {
     .translate_code = x86_translate_code,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
     .restore_state_to_opc = x86_restore_state_to_opc,
+    .mmu_index = x86_cpu_mmu_index,
     .cpu_exec_enter = x86_cpu_exec_enter,
     .cpu_exec_exit = x86_cpu_exec_exit,
 #ifdef CONFIG_USER_ONLY
-- 
2.47.1


