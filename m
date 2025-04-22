Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0623AC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JNe-0002UF-W4; Tue, 22 Apr 2025 15:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLs-00016n-7o
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLq-0006gn-7l
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2279915e06eso58612715ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350332; x=1745955132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHzIFD1toGdj6HYrHyt+UU2Mbk/NX+AyaF0biHg+m+k=;
 b=fXB0kVn/aVd24jiOX+rs4Ly8P0Pl2bcvxN+uLwtzJTI5kLLSlXZAr9tGqmUPm7bDwf
 qhx/1DPeXgk+/WT3fbUU6jYzQgk/MjMsi4enw0j0Xrn1SapwhPmWAw9KgE3A572k2ebE
 bYHwp3EK/qJcnqlxekGKWTPphQR9c22dWlfE6d9zbcEzhJy5EEp0MwJkq4jgmZYJUqZo
 trGIVSIIrHeUnLFFc7g9JBtGFcq1MOSJB4eE2bFYffXN5vK1nLVuqfFy7/rZEGvErxeH
 2Q4bPhNYJWsT+N2UhcIiKJd3SaP8IlpuJjd1rIxYyorARqynTc9B6QShcKYCcyK7RwQQ
 yFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350332; x=1745955132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHzIFD1toGdj6HYrHyt+UU2Mbk/NX+AyaF0biHg+m+k=;
 b=m9Zu3h3DBAEg54X5hY+59F+wB8loI5vcmJ7+CqXQbCWpORhQNTG+7Tg0jCRBuF1tLN
 E/rG2H9Nyid4OL7rGnVtS2z9XMftHe1Y541rrDkAt6xpWJANWXDJyWB7BHUKwaQ6+So+
 yoRyw168iopIidgIWuxocb4kbmvzfGCYf9MRxNcqEAL8dKTNtkm9Ir9pT3qK/idhl0CB
 bHLq0Hnboh+/08NQ8/0m0Yg2soNL0Kqcq761yFBH9tMrXGPmuQ7+0et504WYfbxRAoma
 FIZFHhmHwAue5UcsP8shM8z1jetIxfGYQJ448FByDSWIleXXWorey4bNydagqebGBd17
 JzDw==
X-Gm-Message-State: AOJu0Yxlvige+TffcRtaWrn2PD/YnjDRAKKoNhka7mnOSGNEI2EIfidk
 uJO39baQ17cd8WSPBT0y3RezbVP+PqrIvcqyHoGUWKCxlpc9mSZE6zTF9nvD9l41axjGdVpE+1v
 m
X-Gm-Gg: ASbGncvqpcQvhUwQe+9qMuOu0Hb8qVHCHQRZ0vGrFXEsJxdr5pewkY56dd6/Hdtqxi2
 uhuoXDWDhGjg54yUlZXEqIAmEKzl+2AlZejMtqCpwBwHKKER81hw1f6QjUYuSEJMXyuUPxOmWPu
 xA+GmSxExZFEnoPG4Xy96YUIzAzL5esTfl/tQWIHHb5uG/ROq1l4SjnhWE8IcXevCtSkaxRIUCp
 W2QsRVFnFJTI9qEDznDJTdcYmgvGNUon4dVGqqN88Jm8kT18lP1glJLlIkqpr1CzbHG0XinmV8V
 49geyZW/ehvUKwGPPnRV1EDQZqn2QGJU25FUHCPXsrjcrX5zsrkOnER6UY7lJGjUpeGkIm3lqlU
 =
X-Google-Smtp-Source: AGHT+IG1jfX66ZydW0eiqvrfGJTshjrTNE4+dTZTUx285nMH2wIIaYZcnI4EMBxQeZAgZSCsa83NnQ==
X-Received: by 2002:a17:902:f60a:b0:223:60ce:2451 with SMTP id
 d9443c01a7336-22c5359c344mr234896925ad.15.1745350332479; 
 Tue, 22 Apr 2025 12:32:12 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 079/147] target/i386: Restrict cpu_mmu_index_kernel() to TCG
Date: Tue, 22 Apr 2025 12:27:08 -0700
Message-ID: <20250422192819.302784-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
index 76f24446a5..db9f01a11b 100644
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
index af46c7a392..0b74b9a375 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8669,22 +8669,6 @@ static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
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


