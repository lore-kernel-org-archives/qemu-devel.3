Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA72CA0FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPS9-000235-V8; Wed, 27 Aug 2025 19:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPS4-0001sG-Hi
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPS1-0004BM-Ky
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:11 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-771e1e64fbbso476392b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336868; x=1756941668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHUbngbNrOIebBs0pvinM66UBm6mSJ9+oXdPY+2wgcQ=;
 b=NPlgRCOOUzpjfp7UfqkLplUAYpPcSgcMuG9d4dPwQgTlZCWbLO2Fx1wETYqEvtM8wJ
 4cD4yOjtgkfmmCvDKe9r8fli9cJ64+jIIa3rqsqGk86ThTDxdQ7jfojyJeijtPP6YlfA
 8DaZjcGjUcFzPAZSu6eWmGdSgJv22OEZulkffCI5ULPMTy0a5Z2chLATnJ8WBbqHyPhv
 K4cf7Vlx5ul03TKQbhD3RVZMp32sB4v17Am7BJL1OEz7yk4cuU6rfs0QqrPnTqcCcsfT
 eOsH4hWKf23Av9msJA/cFITO42mnTRO8/uGOCb09NnvDv/df10qwLSCGLmxKfeiQH6dF
 VFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336868; x=1756941668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHUbngbNrOIebBs0pvinM66UBm6mSJ9+oXdPY+2wgcQ=;
 b=HxC45g8SjPKkyn+TFuJxa8h+ufSwa9j5nb7QRCMzxLqFyKR41Z8Hi720HxWVvawkSW
 GAp26c5TCh88CP/8ICquyIOYAfweizKKW6hqxH8nZulf9wDPZK7b6Ip+UuVm53jBO2yP
 jIBQD2N9eE9DXrgG3rnvFSjMjKpw75JZRYe0sDO6njcBsmdxt0uAqEZ2G0zhEJl52R03
 sy8tYizeg0efypgs9GVGRJ4IcBhUzC8+jQnflhSMKCWqHJWikQa3npaK+yDhrAAfXshg
 /a3l9iSkSD0keq4Z8fOmb6yb6qacJXRqfDkOJl9WuJrF3yvCfN3WsEHBcS42e4fgRPsT
 s7Lg==
X-Gm-Message-State: AOJu0YxSAiVEVrZEWnWjwG9H2JNOM5gb01v0oI3VyDV8o+UCWGmx2dbB
 rMgn2x1aiFuO2PlhPlzzSnhVtLHOCyTgz9zRFp2OZJsvLkKjFWsB15WJNrJT7LWKzNXkNar6RpJ
 QI1x/ZQU=
X-Gm-Gg: ASbGncvQWqTiGQbv1IScy1orWSDsIMCfDKVqX5v9Jl/l+Gm0RjKAzc2KZnNEATMyyhR
 w+zTbtZVOHfVsvJuhU0uwnQ3wVUo3HvPrZonJe/sGzZ8WlREVZg0GuCKyKrOqTCmgPaGcQIoD1n
 6ftDLbBWOllJ9fryEAp8qds4IjdrKjARzy6GUo/jdYwAFjdtwT6IWrnXIm/UF3v6JPt1MOEUqJH
 2BffJVo63YF3wqxtKazzw0k3RxVEi54q+IaFEQyizBfDIhHhL9YHKWlMR1317v1Ln7J6zBSE8Ct
 fpCwJyipqA3FKCdmpDEBY5OlcY50gzwUexotcDWg8doJPKzwFHS2sFS97tCYwgBdt82Zd9YvRbc
 wWnULWZ1mHWKc0yGERqmLJD2Krg==
X-Google-Smtp-Source: AGHT+IEnDdUVEfIf6OZ+NFFAA4+t0zNDxTSeLmCdiUqgRYo8sq9x9T93XrY8tGNInLYRPB4D9/deVA==
X-Received: by 2002:a05:6a00:4f85:b0:772:1d9:eed8 with SMTP id
 d2e1a72fcca58-77201d9f2f2mr6844457b3a.11.1756336867820; 
 Wed, 27 Aug 2025 16:21:07 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/46] linux-user: Move get_elf_hwcap to riscv/elfload.c
Date: Thu, 28 Aug 2025 09:19:51 +1000
Message-ID: <20250827232023.50398-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
As this is the last instance of get_elf_hwcap to be converted,
remove the ifdef around the declaration in loader.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h           |  5 -----
 linux-user/riscv/target_elf.h |  2 ++
 linux-user/elfload.c          | 14 +-------------
 linux-user/riscv/elfload.c    | 12 ++++++++++++
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index c14e69f551..729723cc06 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -101,13 +101,8 @@ extern unsigned long guest_stack_size;
 /* Note that Elf32 and Elf64 use uint32_t for e_flags. */
 const char *get_elf_cpu_model(uint32_t eflags);
 
-#if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
-    || defined(TARGET_SPARC) || defined(TARGET_PPC) \
-    || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS) \
-    || defined(TARGET_SH4) || defined(TARGET_S390X)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
-#endif
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 
diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index bfe86105d0..48d9af557b 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef RISCV_TARGET_ELF_H
 #define RISCV_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ba8593368d..ce4055b0e9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1099,19 +1099,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-#define MISA_BIT(EXT) (1 << (EXT - 'A'))
-    RISCVCPU *cpu = RISCV_CPU(thread_cpu);
-    uint32_t mask = MISA_BIT('I') | MISA_BIT('M') | MISA_BIT('A')
-                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C')
-                    | MISA_BIT('V');
-
-    return cpu->env.misa_ext & mask;
-#undef MISA_BIT
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
diff --git a/linux-user/riscv/elfload.c b/linux-user/riscv/elfload.c
index f92adb7308..2e7d622232 100644
--- a/linux-user/riscv/elfload.c
+++ b/linux-user/riscv/elfload.c
@@ -9,3 +9,15 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "max";
 }
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+#define MISA_BIT(EXT) (1 << (EXT - 'A'))
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint32_t mask = MISA_BIT('I') | MISA_BIT('M') | MISA_BIT('A')
+                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C')
+                    | MISA_BIT('V');
+
+    return cpu->env.misa_ext & mask;
+#undef MISA_BIT
+}
-- 
2.43.0


