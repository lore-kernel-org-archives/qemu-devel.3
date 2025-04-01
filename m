Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AC4C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWhV-0006o5-9K; Tue, 01 Apr 2025 04:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhU-0006nl-72
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhR-0005wo-2L
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:23 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3996af42857so4104021f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495019; x=1744099819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZBdGHX5daAO9DhW5iyX6e5/CMk8Ip5nHUiptufYw5g=;
 b=pF+u94/4oxVWtMGZdhnOPZlL+LmMlNRShDvyy+SanxB6jFZizRjagyn6Pw2eE7DiAu
 Hcm33qp6HmxkAR3AH1zKoYDaJlwBlzkiZyj0KXBL42qbRSC6PD604OA9vNNKv+G29oLE
 wTAejh5UjrjJGwkYYTw2Weo1dA2+sXnktLJ3PYpo+TrNxx2blwgY7LVB/7WeImVhB3Ae
 wlj4RJi0sX/op1e3v7Z3lKcCCE9RJsawdFWJWbujQq9F86owoubVAtsHZBvGjbexU0Oz
 br1pno/2mQSS3TQZwm1EPjVuRXful+v42BDIajDgeg6ogQ5LOvp9Klv7GwgIb910CD0O
 UDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495019; x=1744099819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZBdGHX5daAO9DhW5iyX6e5/CMk8Ip5nHUiptufYw5g=;
 b=lD3qSagBU7KXRGuFxSfpCenmqNpPV8iyirl3/oEsaGI1gaj4Em6fzsNkKiYzWC/h4r
 ArjNYP5UIVjIL/f7TuREOUvHMA+oetGqxCZJWYipMGlgDzW29wQc4i+Co0k6dznV8B8U
 43anu30gvXawmRC3wRL8VhBLO3s8fExUfjYU6LwQJCPgAlvg+iNg2LAqePnfle+uAayv
 UMg7vxs5AAoebQwcfYGc69ewvFct4hZVfIGIUGUBNds5GN+5H9Tp+Zc/SGS3bdiJvktV
 Zm3elp/uPcBnpSLyLVzyfCRf/7+yPLFf8ZHNQEBALFvRvGZy69j2J38hOBreuf2+fZ2r
 uZFw==
X-Gm-Message-State: AOJu0YxEm5SnxLwfoAZw7yCAzmaSzfjeUxUk+wV7d3Q1/82EzRsBuOMh
 tPGRz5Y66fKdSnr8S+mGFnPtRIHILlX1PiwpOOTYEhOfNWVrZOnSk/xGCKugcAZ7JX0TkyrrpM7
 3
X-Gm-Gg: ASbGncus9BZ8JqgDFh0NvnVRBxt7BPo0wtHA9P1wECnI5gT5secEwiZqvv/JtqzAtgL
 AXLNYsskioo9ZkFro7suX0Zsky9FijurEgmXJbnnRfuUGBcGIitmwshT92kBigOc+MKGeJYET+G
 hRhKC8/NpXp6TskBsLt1+ST7U74WYdoL5yeU5Ryjeu1iwP9Ap2LWySGt+V+lXEM+j0LOhSt1QPk
 ATA7ZETHJt/E3kslbLvh+dN8ew9ikC73wLgn9H5eHlGzegHpYa9XNCLEoQ/ELEFbdwHH2RLF8Jb
 5T2DpjBHwLOU7J7r0sw/UcWNVZOTvEckFkmFVvaG/ezmMTbASuOm+aHbo8JeDhEistXPsQioO+v
 cXm9eAEYQJJF98SCp2cQ=
X-Google-Smtp-Source: AGHT+IEttQAuqT0AHyIyxS+nhdR2+lk15xX5QicKD6NKHwlCyGVxAQ7B0H3tUYkQSYL4iQ9SOZxcCw==
X-Received: by 2002:a05:6000:4023:b0:391:21e2:ec3b with SMTP id
 ffacd0b85a97d-39c11b7648amr8802431f8f.3.1743495019013; 
 Tue, 01 Apr 2025 01:10:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4351sm13659771f8f.98.2025.04.01.01.10.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 08/24] target/i386: Restrict cpu_mmu_index_kernel()
 to TCG
Date: Tue,  1 Apr 2025 10:09:21 +0200
Message-ID: <20250401080938.32278-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Move cpu_mmu_index_kernel() to seg_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h            |  1 -
 target/i386/tcg/seg_helper.h |  4 ++++
 target/i386/cpu.c            | 16 ----------------
 target/i386/tcg/seg_helper.c | 16 ++++++++++++++++
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 44ee263d8f1..e23a947a7c7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2598,7 +2598,6 @@ static inline bool is_mmu_index_32(int mmu_index)
 }
 
 int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
-int cpu_mmu_index_kernel(CPUX86State *env);
 
 #define CC_DST  (env->cc_dst)
 #define CC_SRC  (env->cc_src)
diff --git a/target/i386/tcg/seg_helper.h b/target/i386/tcg/seg_helper.h
index 6b8606cd6d8..ea98e1a98ed 100644
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
index af46c7a392a..0b74b9a3754 100644
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
index 71962113fb8..f4370202fed 100644
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
2.47.1


