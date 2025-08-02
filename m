Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20418C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLIz-00012s-3Z; Sat, 02 Aug 2025 19:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIc-0000xF-3k
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:58 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIa-00016W-4B
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:57 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-741a59f64c8so411966a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175955; x=1754780755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plVtBvS4s1Af7rRNKV3HXQo32RvMRB2lbK947p094co=;
 b=r+6DSxtgJfqGPm+9lOHypgP4FAf7dVjsvydsQ4oJWKewhBH3ZsQPwz/DPPZGeeNyR6
 Fj0XY+OranWvqb36Rda8ZShbla4CXfrjHP1BOFf18E7+J3HvOMS08nCfNfiUzv0P+gZQ
 YZK7AOrNb+bEOtw1EXGl1ldw9OmhH89K5Bj89XjQCQ28AhjTOQoxALI5huJUgqFk9lfT
 h/H1tInzpKnaEBRV4JTvNSII/bROhKVbpYFX95FJAOIKubd0l6mAlXNm5jr9yc7fr5Er
 NO6J1zH8A4NQ/iKlbFVreuWmpr8YkJ9juBUCpkoZMiURANIFmGUqHT3fiZLnG9b+jePs
 2tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175955; x=1754780755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plVtBvS4s1Af7rRNKV3HXQo32RvMRB2lbK947p094co=;
 b=EvBRACQMcuoLsyg7oGbGh03JMRe/+AYTyFyjXkhu+JLyfHcZ/8rH+7XiOmZUjR4mP7
 zLDLwSD5jDiZO1fnGOsRJE39+feQVtle+vtM9EO6jIIEnowbBUVpcW51L/U6zu/gL+ot
 h/T5U0sHes2GrLrERP+BeAMNG9YfHsx0lmcpo6dLSbuZGBNxtajJdTiXwAeSfYy3wnkh
 vIcMLY2SfAzH0rtEBXF1KdD38yeJNd82qWUJt9cqxquZPG8ZCmU8ATs4qL8kITtnVIod
 eDubUOxKFNQByehOTI7HsEEtRvUPwicGzq6Ys3aFtX65VpiORqPcJU2gHvw3czpQro+m
 9wqg==
X-Gm-Message-State: AOJu0YyTFXDrNq507iHejxBzxxHbBBxgE0Y+1OBkCNDSDtp9XLHHTJei
 fxmjYnehLVvftctwq2aZwazPjBU5Sio8DRi9g6fh20zq7hhRcw+iRO+Hk9a13+DOdrKgBTUsU7Z
 90XY/keE=
X-Gm-Gg: ASbGncv/SQ+2HLkdsgsKDzZkDAjSpHc97TP/JXSI7qfrfDfExSCahUAypdDjYLXApiz
 +Qasurztn5VDWLX6CfdaxEx+b0R7ILJ2cWDPX6bdOEceyMTjq0p/Vi/x5bZEtrEwiBJ8bYKZRQ0
 AzaDu8EiFUgMaHGCsv5AjD7IOYO8UfgY+j17cPOol5XEMvIbxFHlAllh2j53zpeuSGPi9dBPUhA
 1H96iGQ7dJIkOkrqk+6bn+VJTjvE97odjTnB9BzGsZbg1QH0jWg5OiScNGaft0GlIpwASZxYyGw
 s4HmdF6/9BWqd/grUpbt/GM6R8iEjweLcqKm2uO2FFo4qVMYv2eCvGV5WpxGJhM4qPi1nCG8R+2
 VkCxlg8wdS/xFZUPYpjLZkonw66yF5fM10j5kTmEkcwIPqUV23DzaiBZ5HQ96BRw=
X-Google-Smtp-Source: AGHT+IF1CSO4Ox5tXabODioJwSkQK9og620KZ+J9av09Uq9jFNr2bOz/14CYGF5Mft3M4eHm9D9xhQ==
X-Received: by 2002:a05:6808:13cc:b0:41c:e002:9bee with SMTP id
 5614622812f47-433f0252f13mr2601371b6e.15.1754175954656; 
 Sat, 02 Aug 2025 16:05:54 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 12/95] linux-user: Move get_elf_hwcap to sh4/elfload.c
Date: Sun,  3 Aug 2025 09:03:36 +1000
Message-ID: <20250802230459.412251-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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


