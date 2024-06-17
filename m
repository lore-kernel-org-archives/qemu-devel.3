Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC43DC2BA15
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 16:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJExx-0005ED-FC; Mon, 17 Jun 2024 12:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJExt-0005DH-Dr
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:12:18 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJExq-00089j-4G
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:12:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so31732275ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718640732; x=1719245532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RU8dA+BndeNrGR5fmXLNETHnH3CX1uGkm7Et/jlHqU4=;
 b=ixvzRaxiCLUDbC+0dEFLceP11No3+ZsmKGwJrV/dqxS2MR6li7VGCINHQQTzLngfEj
 KaoKdssUQ1zLN39+NXUOsGORAzbyfJMNEajk+Lp5Kq6yRSkaC6NJhGddHRMEh9L1ppI1
 PPwUUeDT3ZPQTGH8Y9MIyITH4HDGxOuVdo4qrE1ZKdmik2BkVQR39zyVLLXamKSIIdhR
 VNS/x0lfpRZzJPzhp9rWSRremWtRCeqdkYVFFUYEU5a4iDfufN+yfCVpYIbfjWyjtcAX
 DghUuwt9QsvKnukqaVUHlXdylMX2nNkgScFBm2O3CEm8zQXgsuxIi4NId9KYn/BIVEyg
 qAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718640732; x=1719245532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RU8dA+BndeNrGR5fmXLNETHnH3CX1uGkm7Et/jlHqU4=;
 b=XY8CpQh69Bh8+7i5fpLxbz8sZDuSN8S6waBc/qIasGYm24FdDwu4xYnXU8otND8X43
 S8gS1NGLxCcILnD2LClgrR+IRkp6EAG0W3u7QyZSxD7RRLv6pYWqVBaDJQ2YTeDYwViZ
 3nSi2hEwfEF8CCzyWL4ks8QAYxrx13kiy6q7ISjnk0sanYt8wDWJUNzWj/95EnVpXsnK
 u6nWK4mWDDch1Po+US00psGpT5ZzCOMlzwV0E1An4Kh49/BYAisOPtYZ4DW4UWpJ0SIv
 7/kmVSsZuGg1s8rBDbJvXfBoaVkN8g6WEgV0JHB3Z49d5ADTYUkrtNQWYhO1xsdF61MZ
 XffA==
X-Gm-Message-State: AOJu0Yxlod7ug8jY5LtCuD0S4G8FAma7ZOQjV8FMdb/O3ynNAa8FuyUY
 uDZ0TdoATnek6JHYnYjoIkw6rWlB4mryPYLvxKOMfi+c0HiNY3Zg/muwKfBW4PVtg3ubeHBQ2gL
 u
X-Google-Smtp-Source: AGHT+IF/qsnKg/4aTfAIl2gtKghIQ4ppenJ+kMkp5nLfVZ6fdjFLs1STDROPOYDkatlT7ewlhrnOww==
X-Received: by 2002:a17:902:d492:b0:1f6:6a94:76c5 with SMTP id
 d9443c01a7336-1f98b23f6e5mr1392295ad.20.1718640732423; 
 Mon, 17 Jun 2024 09:12:12 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee8317sm80829285ad.145.2024.06.17.09.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 09:12:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 1/3] target/i386: Introduce x86_mmu_index_{kernel_,}pl
Date: Mon, 17 Jun 2024 09:12:08 -0700
Message-Id: <20240617161210.4639-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617161210.4639-1-richard.henderson@linaro.org>
References: <20240617161210.4639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Disconnect mmu index computation from the current pl
as stored in env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 12 +++---------
 target/i386/cpu.c | 27 ++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8fe28b67e0..a528c30616 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2432,15 +2432,9 @@ static inline bool is_mmu_index_32(int mmu_index)
     return mmu_index & 1;
 }
 
-static inline int cpu_mmu_index_kernel(CPUX86State *env)
-{
-    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
-    int mmu_index_base =
-        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
-        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK)) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
-
-    return mmu_index_base + mmu_index_32;
-}
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
+int x86_mmu_index_kernel_pl(CPUX86State *env, unsigned pl);
+int cpu_mmu_index_kernel(CPUX86State *env);
 
 #define CC_DST  (env->cc_dst)
 #define CC_SRC  (env->cc_src)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7466217d5e..ee7767046d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8107,18 +8107,39 @@ static bool x86_cpu_has_work(CPUState *cs)
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
 
-static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
 {
-    CPUX86State *env = cpu_env(cs);
     int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
     int mmu_index_base =
-        (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER64_IDX :
+        pl == 3 ? MMU_USER64_IDX :
         !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
         (env->eflags & AC_MASK) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
 
     return mmu_index_base + mmu_index_32;
 }
 
+static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUX86State *env = cpu_env(cs);
+    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
+}
+
+int x86_mmu_index_kernel_pl(CPUX86State *env, unsigned pl)
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
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     X86CPU *cpu = X86_CPU(cs);
-- 
2.34.1


