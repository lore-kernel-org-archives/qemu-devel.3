Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B21ACA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPS0-0001oZ-Ef; Wed, 27 Aug 2025 19:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRy-0001nc-Ff
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRw-0004Am-Fz
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7718408baf7so401671b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336862; x=1756941662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plVtBvS4s1Af7rRNKV3HXQo32RvMRB2lbK947p094co=;
 b=JmumVz8H5PuYzpXp4Dk0LbjrmYBOR5OSkcPV4nIntOgszsfbVXwZ6lGtu8v2OQ5vRb
 WCUjaTtfQSLiZDyXBdQQ6/YhngVCcxuxFfRDFPZQP1vUgy3Z9jDfjU9jb9uy4VfP1B3K
 /1XjQM8gn2IJBTkRFf6fCpbSiu0+ckMcF0lqarTyQqxywJ6HhsyjkKoYYqah4Ri302XQ
 4G/VregtLKZR3MAKxCrO6dkbfrel8xtNEryBSLuhrwIonlX/mVtx31EBI2BSQWFsfHJP
 5pN5dY5RLZc+mGmHx4STRtoKwreTbmAsxEtrMbxWwWbIAiO+Zd5PPcPMKubwiZLBJ04f
 scQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336862; x=1756941662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plVtBvS4s1Af7rRNKV3HXQo32RvMRB2lbK947p094co=;
 b=rLNQS/npqgTZwH+pnkt2uC27bhAKxx8E63jjFvASszfEPBkNmxANXmMsJ4drgbVWE8
 RdCfzYl5Wlu0/76vBVwXVvlwnnr/ozpnsqmC7RDFK5vzwlIWqUIKQq+WK24aFFrhg9rj
 mP2yT+tKuzHuSGqFwvnrvAXGw0hLPzcPDfYnH6vxwnoXb9toB7sBWtZGqKugU4/yS/JQ
 ROnmGvbSM3J/N/b9dV0vLTdfJ1GZF5m+vaL7ObqDk+8cJrI1zUww2osGBuacVkZT0pnQ
 xI8YBrx7QPpvVtcgEkdfqxNSj3tUmmLrA6I8K6aIHSc3dCU0aEPlixbg9zMQ5i5H/ToZ
 HOXg==
X-Gm-Message-State: AOJu0YznD671Xbe6uvKSoUzZgxJdiw/gvSqT9FAdpmUUNZCybA1Thafu
 CN0iS504ZHemVlYbYkWY56TGf9BqJqkhsJVpU39BiD9Vb4BbLW44noIC/R47vgf2FVrIq2JTZir
 dfZYXKnQ=
X-Gm-Gg: ASbGncvWkYhz6bDCfle7KLvOxAWSU+NCLIvvF8MDG7eyYReYivJF3W5NweHzx+VwFWx
 ICWwkKum65FKoIW7+AKRZHFfS3Pmb+V2d0v7JGmJ+3LreEqtpqID28A8HVJpEH+RmdGAtgWE/UB
 8+WSyXR1Gce/0cpqXkQgJdV4VuQKYPUku1PiKzcX5Ap8j9oM0SYy78pkCv3syVUnXHu14zHv7Nu
 Xhj5zMJiIU4qwvnjgOAn/w1u/nYRTGOA9xU4OWLy+UbOu1ro7eOtvnyCF2AywoVvVjHwn0d/tQr
 /m3SiP69yE3a7PzON/ZdlfByFqr8gfDiF0BT+4k/l3LoBPvd/7IJiroZ1yEisnsGxKzS9bnhleK
 N6iZfImJ3kugx0l59MSt3MLra5bFqSH1bp7q4
X-Google-Smtp-Source: AGHT+IHUZKzZJOlKhbIeq7GccDLDfIa7sViAR7a7JcnuOGVs24/gBvvqoq/xGLCSMVVT9DmWjGYyUg==
X-Received: by 2002:a05:6a00:1746:b0:772:101f:5e46 with SMTP id
 d2e1a72fcca58-772101f7245mr3050817b3a.12.1756336862566; 
 Wed, 27 Aug 2025 16:21:02 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/46] linux-user: Move get_elf_hwcap to sh4/elfload.c
Date: Thu, 28 Aug 2025 09:19:49 +1000
Message-ID: <20250827232023.50398-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Change the return type to abi_ulong, and pass in the cpu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h         |  3 ++-
 linux-user/sh4/target_elf.h |  2 ++
 linux-user/elfload.c        | 29 +----------------------------
 linux-user/sh4/elfload.c    | 27 +++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 04457737dd..d8a9399807 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -103,7 +103,8 @@ const char *get_elf_cpu_model(uint32_t eflags);
 
 #if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
     || defined(TARGET_SPARC) || defined(TARGET_PPC) \
-    || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS)
+    || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS) \
+    || defined(TARGET_SH4)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index d17011bd75..badd0f5371 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef SH4_TARGET_ELF_H
 #define SH4_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index dc3f502277..7e1c11c39f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -963,34 +963,7 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-enum {
-    SH_CPU_HAS_FPU            = 0x0001, /* Hardware FPU support */
-    SH_CPU_HAS_P2_FLUSH_BUG   = 0x0002, /* Need to flush the cache in P2 area */
-    SH_CPU_HAS_MMU_PAGE_ASSOC = 0x0004, /* SH3: TLB way selection bit support */
-    SH_CPU_HAS_DSP            = 0x0008, /* SH-DSP: DSP support */
-    SH_CPU_HAS_PERF_COUNTER   = 0x0010, /* Hardware performance counters */
-    SH_CPU_HAS_PTEA           = 0x0020, /* PTEA register */
-    SH_CPU_HAS_LLSC           = 0x0040, /* movli.l/movco.l */
-    SH_CPU_HAS_L2_CACHE       = 0x0080, /* Secondary cache / URAM */
-    SH_CPU_HAS_OP32           = 0x0100, /* 32-bit instruction support */
-    SH_CPU_HAS_PTEAEX         = 0x0200, /* PTE ASID Extension support */
-};
-
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-    SuperHCPU *cpu = SUPERH_CPU(thread_cpu);
-    uint32_t hwcap = 0;
-
-    hwcap |= SH_CPU_HAS_FPU;
-
-    if (cpu->env.features & SH_FEATURE_SH4A) {
-        hwcap |= SH_CPU_HAS_LLSC;
-    }
-
-    return hwcap;
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 #endif
 
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index 546034ec07..99ad4f6334 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
@@ -9,3 +9,30 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "sh7785";
 }
+
+enum {
+    SH_CPU_HAS_FPU            = 0x0001, /* Hardware FPU support */
+    SH_CPU_HAS_P2_FLUSH_BUG   = 0x0002, /* Need to flush the cache in P2 area */
+    SH_CPU_HAS_MMU_PAGE_ASSOC = 0x0004, /* SH3: TLB way selection bit support */
+    SH_CPU_HAS_DSP            = 0x0008, /* SH-DSP: DSP support */
+    SH_CPU_HAS_PERF_COUNTER   = 0x0010, /* Hardware performance counters */
+    SH_CPU_HAS_PTEA           = 0x0020, /* PTEA register */
+    SH_CPU_HAS_LLSC           = 0x0040, /* movli.l/movco.l */
+    SH_CPU_HAS_L2_CACHE       = 0x0080, /* Secondary cache / URAM */
+    SH_CPU_HAS_OP32           = 0x0100, /* 32-bit instruction support */
+    SH_CPU_HAS_PTEAEX         = 0x0200, /* PTE ASID Extension support */
+};
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    SuperHCPU *cpu = SUPERH_CPU(cs);
+    abi_ulong hwcap = 0;
+
+    hwcap |= SH_CPU_HAS_FPU;
+
+    if (cpu->env.features & SH_FEATURE_SH4A) {
+        hwcap |= SH_CPU_HAS_LLSC;
+    }
+
+    return hwcap;
+}
-- 
2.43.0


