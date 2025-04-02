Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EE8C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05G8-0004eD-PL; Wed, 02 Apr 2025 17:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05G5-0004WJ-6s
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05G3-0006BH-DU
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-399749152b4so156836f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627862; x=1744232662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=otAebrlqjks0xdosMESbVdYJKbOSKS4XSMvbAuZe/VA=;
 b=PWTifuQX7fPsOSFe0VAIUpGeGc3MyB0VYGFu+PdFJV76sNzr0i7+CSXGhHppfxf9M5
 Bua/sdLpyEErpVTE2gbqiIlAGLaeCk8lL1tM4SDDFFFWMAKtIkSOkvM2lj8dP6eeNwAO
 HHzT/aPAltN7UNrWmcudlwBBCHJWheMQoZP4DT5V03iOpu8AvCKblZ93QyEV8nKadxeA
 ic9pvOZv4sGga8jKZ0SlFlmBsXTMYTWcoGuWMfWp++8wtIYRM7Zp69Zi6piTaXVCrola
 sMjSyWWiAMEjUEHRM9KfG0JIABIpfoIFPy8ErdtwwUvq0FL/p3dlUoFe0Rn0S9EKnyvl
 RV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627862; x=1744232662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otAebrlqjks0xdosMESbVdYJKbOSKS4XSMvbAuZe/VA=;
 b=gmvELOLw4TxniJT0ZSVlmd91A+AJPawylfTOTMftcP0Cm1f/wsWZ5ZZUOmHliTWRnl
 rEsBBB/9NHbRT3jfwLOWHb1+v+LgO4TcOfZDCOXSG+A9K5biJsR0At0pv9zMLRU/bPPi
 ogIyhArGlyLg9NTbP5al229YXksWmtEkyrq0fEyS1kVtSBTo5iVsK/i2EPgFbzzQ6q20
 siU01Y5EWPaix5V3GLs5yEuyCw/sevi8HVL49lQsELzkpD/bo2t4CqynduVcMXoVF9/z
 jLesXfviYIxFwD7bffDXMCQ40c/GsCRvbq0tMYmZwjhDyC/XZU/5G94jXQ/LhWiFs8Ix
 Bvbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYkz6krGFR0yG4UZUKEcbT1tyVWLPVAvmBMVWVKINyGSFL4l7SyCB14TkxJSWlmriFkyUE3b8KD9JO@nongnu.org
X-Gm-Message-State: AOJu0Yx+mvAeWIPwKEgxUliKEw1wjt6zcDNmMF/ByDr+zhORnnTyFwDi
 nlKdmxwUuagCCh8gGvn9chsU/4av0sJUwQOY9hYohUeOPMweYGB3iFNU2Qa89lIqoremUYQb205
 I
X-Gm-Gg: ASbGncvjz4Pcj0CJ7UUJGIK25m/4UP7e7uIAY5erYENz0jOW5o67KIKFV6+Qr4L1UI6
 BcfkO3FskJbRGTZZeYzcpFNljqRHcMXSDGXEBtzewQddcWFYv6qTU2navwVBPjywprEigxU8gzT
 nbOE4qVCu8ZnFRdcJmC9NQd+AvUeWsB04RPf1PKzsm6BAxs6DPhwGsW1Y20M/Fe2pEqODMVCzI3
 NcvXeYgO+eVteen5YGGpLkHMluyqWZXwtPUUxhs6g2Te/Q1RiHlnzXhNx9aThGA0pDQqeTDZjNS
 dnCOjuoiT77pr5tJkrCV3y6toi09q0W1VDZzewpLcuxIF9gY069wg/+OqRbMMtXqGvrVmSKo+mO
 fleR5aYShmIIKkOokf2M=
X-Google-Smtp-Source: AGHT+IGX1tTPrvqv6azm0U5hOWIFnj7LhFfLvW51P2WmPkebD5nCc2+y+S5VwM0Z2ZgqnQOBtxXvFw==
X-Received: by 2002:a05:6000:2a83:b0:39c:1257:febb with SMTP id
 ffacd0b85a97d-39c23674c2amr5058501f8f.59.1743627862009; 
 Wed, 02 Apr 2025 14:04:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663623sm18149772f8f.35.2025.04.02.14.04.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 11/43] target/i386: Restrict SoftMMU mmu_index() to
 TCG
Date: Wed,  2 Apr 2025 23:02:56 +0200
Message-ID: <20250402210328.52897-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            |  2 --
 target/i386/tcg/tcg-cpu.h    |  2 ++
 target/i386/cpu.c            | 18 ------------------
 target/i386/tcg/seg_helper.c |  1 +
 target/i386/tcg/tcg-cpu.c    | 18 ++++++++++++++++++
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a557dccf3e2..16d76df34b2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2595,8 +2595,6 @@ static inline bool is_mmu_index_32(int mmu_index)
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


