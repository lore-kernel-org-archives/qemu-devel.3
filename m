Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A560C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krc-0005GR-LT; Wed, 23 Apr 2025 20:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015p-Sg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqN-0004lp-1W
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso535207b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456014; x=1746060814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFv25Ex4Z7rH8n6+d4m5k/9OCPtpQ36hSXK/gOJIqjc=;
 b=FwDIVFucvmK8vUOrACvsAgoKHCo3VQWiMktmOEVyWBZyzFjqytvZk8ZY32UKisTZ+n
 B3N4ljho39RKsdM1Q0xAOMcXAnTrYIWgJ+GRIAD3zNhyPPwNnnpyLKIRqWUjDI/BJ1dl
 NQ19BnYK7nKXK6KdVa4soZphjyN5e7NdyFku5VaAntu1UXI2xiF0/BT5DpV109Z57wgq
 4KQZcxXcclyEWyVRjMrLtNNODTUfbM5yz5W18gewdN8HSMUcmoPvc+hg/ebvVOXW2iVw
 iD8ulK+o9WURqaw0cIR4bB5ziqTjGBgwvQRJxu+tfeaAmhSacp3DN2l3iSf0XGYQPgeY
 rYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456014; x=1746060814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFv25Ex4Z7rH8n6+d4m5k/9OCPtpQ36hSXK/gOJIqjc=;
 b=JlNk5fT2SyOiVQLYtVBNw9sJNdM7g66D4g71KkTwE7hhk7TYhOdgHXnCrtjtUFQ6OP
 98zuao0YJVfO1M0WMRWlW/z0kf5ox49ojVuD/A9crmnazzna714dU2bMZvp/jfIerOOl
 Fg4aHdDEj6slzNBjlS6mGdKcuPGgXt6lj23pWhMiGJemyKlSA3iD7a0TMB5Nfjeg0hlg
 L2OPz/7CnIr8ibfKlDibTJ/zAJOZwXLyvgCz/yLVTTJWcxkymfk1+sabPk5C90HthATm
 LQBlgMgnRA1wVEGO7ayjKJ5ZN21Fuw3bHu0EDXEejBord3H1kK32x6tc2lIwx3hd9LvR
 aUig==
X-Gm-Message-State: AOJu0Ywrolu0GYJQYJPu4DRZuCk/gfYdecnZjuHkirw8ZSm7a86Ssdh6
 mqqTpaNSPzimEz3Vmn5pJ0m5o8vQzUwOBgawlXPkSrMguCPHJEphNGSJR4qdZn5jgt167hrja/U
 2
X-Gm-Gg: ASbGncuqvqwA2pAH5GoXTMmQwxkwwidloDyJbia5yWGgP0+b178fON7iZmUhRdYbAU7
 MnrvdQwmabJT2PS2+a94T59m7Q1XdNN8+pQSl7XXlroHJ1vClkqjGGy5CtQcGEv2iW2I8tyvcex
 5GzJTZH2XA87++szRbhX3igvqgb6BaU490X8nwggGPygKo+eKH1/78JWsdQph/MBaVVfja2HUG+
 4nY0b+iunCo5m5argzMYOQHfiv9Hl2Apge3re5suK5JqLTmDr4Rff0+d1IgXZ2vV0yj55lAY3Gx
 Ju2j4KPH3Yi/qm6O8/Ubbn7d4IlcYGdmJNeuV7GzAOD8Ix14iFDGFHnbU7i1PV0CksKspsVGBV6
 lHyqycSEW5g==
X-Google-Smtp-Source: AGHT+IEGop4SoCOz/049mLW7ZPIc6Dt3sRNG/fuSJoFUN4C0A7kqrWy4eQxURjYMLC9fnbe2/8fpXA==
X-Received: by 2002:a05:6a00:9287:b0:736:546c:eb69 with SMTP id
 d2e1a72fcca58-73e245e3df6mr932620b3a.9.1745456013530; 
 Wed, 23 Apr 2025 17:53:33 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 079/148] target/i386: Restrict cpu_mmu_index_kernel() to TCG
Date: Wed, 23 Apr 2025 17:48:24 -0700
Message-ID: <20250424004934.598783-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Move cpu_mmu_index_kernel() to seg_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-9-philmd@linaro.org>
---
 target/i386/cpu.h            |  1 -
 target/i386/tcg/seg_helper.h |  4 ++++
 target/i386/cpu.c            | 16 ----------------
 target/i386/tcg/seg_helper.c | 16 ++++++++++++++++
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 119efc6c60..c9f39e99d3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2598,7 +2598,6 @@ static inline bool is_mmu_index_32(int mmu_index)
 }
 
 int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
-int cpu_mmu_index_kernel(CPUX86State *env);
 
 #define CC_DST  (env->cc_dst)
 #define CC_SRC  (env->cc_src)
diff --git a/target/i386/tcg/seg_helper.h b/target/i386/tcg/seg_helper.h
index 6b8606cd6d..ea98e1a98e 100644
--- a/target/i386/tcg/seg_helper.h
+++ b/target/i386/tcg/seg_helper.h
@@ -20,6 +20,8 @@
 #ifndef SEG_HELPER_H
 #define SEG_HELPER_H
 
+#include "cpu.h"
+
 //#define DEBUG_PCALL
 
 #ifdef DEBUG_PCALL
@@ -31,6 +33,8 @@
 # define LOG_PCALL_STATE(cpu) do { } while (0)
 #endif
 
+int cpu_mmu_index_kernel(CPUX86State *env);
+
 /*
  * TODO: Convert callers to compute cpu_mmu_index_kernel once
  * and use *_mmuidx_ra directly.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c596e2174d..fd85663833 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8681,22 +8681,6 @@ static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
     return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
 }
 
-static int x86_mmu_index_kernel_pl(CPUX86State *env, unsigned pl)
-{
-    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
-    int mmu_index_base =
-        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
-        (pl < 3 && (env->eflags & AC_MASK)
-         ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX);
-
-    return mmu_index_base + mmu_index_32;
-}
-
-int cpu_mmu_index_kernel(CPUX86State *env)
-{
-    return x86_mmu_index_kernel_pl(env, env->hflags & HF_CPL_MASK);
-}
-
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 71962113fb..f4370202fe 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -128,6 +128,22 @@ int get_pg_mode(CPUX86State *env)
     return pg_mode;
 }
 
+static int x86_mmu_index_kernel_pl(CPUX86State *env, unsigned pl)
+{
+    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
+    int mmu_index_base =
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        (pl < 3 && (env->eflags & AC_MASK)
+         ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX);
+
+    return mmu_index_base + mmu_index_32;
+}
+
+int cpu_mmu_index_kernel(CPUX86State *env)
+{
+    return x86_mmu_index_kernel_pl(env, env->hflags & HF_CPL_MASK);
+}
+
 /* return non zero if error */
 static inline int load_segment_ra(CPUX86State *env, uint32_t *e1_ptr,
                                uint32_t *e2_ptr, int selector,
-- 
2.43.0


