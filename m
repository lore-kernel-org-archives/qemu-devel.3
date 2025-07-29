Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12854C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguV3-0000XG-V7; Tue, 29 Jul 2025 20:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFg-000251-Pt
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:10 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFa-00046E-Ng
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:58 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b3507b63c6fso6542273a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833651; x=1754438451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vwXX72bT0hdUpN/EvIn1LJHfScPNRgxUHXGHlv+hV9I=;
 b=cRrDNtXXnbv96WHrebHetvV7Yb4Qedp24tQG+PPqoq7vBUCLJCYfMTw5lUXjtSmXaK
 URNV1rMTQSiQtLkxAd6egH3RUBlCXGLLtt2dldR9eMpr6nYbbMjcBZYcd4xEEaSCQ4be
 0J8xoEspNLwoRfk3kgPX679bmCx7ENyLcynTbIQUuYpcvoPV1udbMXUKMi28KuqZOzDb
 sBbylDcXF8lCY+Vg6oTl4M+4UGsPBGi7r4fzPVGz9Jolfnwkg6dTsdrWP9pdGZQoVV6L
 Ed5lI8QDRdYUW5RBkXhFimr5y3zSf1E7iJkrgPCHdW+LwWsiGVrayMDys24gMe5OVpPa
 gbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833651; x=1754438451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwXX72bT0hdUpN/EvIn1LJHfScPNRgxUHXGHlv+hV9I=;
 b=P4rFVFEZbgUL/i7wRuCSsKrRobpL9TEvfFXCPUm/kCA1HVgkOJf46F0YcHGkmqeP8c
 D+od0Xx0tkO9db5hMr/6vfx8WVLdPEgmu+Th2ZuMbGXFto+sQuiyUiX4JyIKYoiCMK68
 JAIqG6yN3Gij5eyR8EvynLqRY7zGcV0Y2Hw73V167XfkNtomJFJ4wvyMbZgyiE+n1KJG
 H4wflTi9QTLigtJUVNWhA5Dcx47w2K6Hck9LG3DYt1ol3mP0aY729SjGxki8OLkGUUGb
 g+ES8tEklzBIjDSp2blje3HZmVpFKjVyoKycmCridQ9ixtSrAb0/f9y0N+vSJAjPN//R
 h1RQ==
X-Gm-Message-State: AOJu0YzUMmzGN6mHtcraiJINLJa+3mHSSCLsyGGu0XqzQgAsfG1D0I6D
 JPOg9OuBpmEGh2oJ17WdcfwVxUP/H/0fawMBBrWV6XoAwECwmUcCFMgb6oG4aiZfV/VArbh3Nva
 NoZrZ
X-Gm-Gg: ASbGncvColyVFVc0h0TfqIpi783hFe4gXC+rF0alWT5bZVf55wYgr8xM4dbJZCy5N1Z
 QueQRxOJueBVi0pDYlk4cj+/1cZzi6Kc1qNvDKMA8TmWLtEwPk/EZG7CzGrgDfERuSPuUDcF+41
 69CmaNNjMwQeldLFE97BULQGFJBmO6I3KwF2VhghQj5W/LWrRv/JdRZzm4PRDvLx0XuffdmU957
 2ACm9UQISTfu5BlFukpknYukYYYmo7bCHbDgjvZ+Z5sPMrzrNKi4XkRSBFZ9GCVuaPAW0nOnnot
 D1Cl98Cg0PVQE0WUBObm/CXBRE6tdhinhs+RmDXjT5DMKpWncnPHHRo86HXrx9/VvBmxJc04VB6
 xQjzcdTGoFfCG8vqXZBsDGGb+vAkoatakcGgxz1TEeegMDR5lGtkTAP4L2K84xPb07lIPU9Lkdv
 N0iCD/tqRc8Q==
X-Google-Smtp-Source: AGHT+IGq8conUtnzTc7UGSClQChBXByB5QXZUy31IGY1GGXNvO1Q72BMk/gfRIIQCgDsaMgEhuJ5sQ==
X-Received: by 2002:a05:6a20:94cb:b0:215:ead1:b867 with SMTP id
 adf61e73a8af0-23dc0d4820cmr1987438637.14.1753833650862; 
 Tue, 29 Jul 2025 17:00:50 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/89] linux-user/mips: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:02 -1000
Message-ID: <20250730000003.599084-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Note that init_thread had set cp0_status in target_pt_regs, but
target_cpu_copy_regs did not copy to env.  This turns out to be
ok because mips_cpu_reset_hold initializes CP0_Status properly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c       |  8 +-------
 linux-user/mips/cpu_loop.c | 16 ++++++----------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4095f7615d..e295dda0bd 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -587,13 +587,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->cp0_status = 2 << CP0St_KSU;
-    regs->cp0_epc = infop->entry;
-    regs->regs[29] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
 #define ELF_NREG 45
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 6405806eb0..e67b8a2e46 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -211,12 +211,9 @@ done_syscall:
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    CPUState *cpu = env_cpu(env);
-    TaskState *ts = get_task_state(cpu);
-    struct image_info *info = ts->info;
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
     struct mode_req {
         bool single;
@@ -245,12 +242,11 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 
     struct mode_req prog_req;
     struct mode_req interp_req;
+    target_ulong entry = info->entry;
 
-    for(i = 0; i < 32; i++) {
-        env->active_tc.gpr[i] = regs->regs[i];
-    }
-    env->active_tc.PC = regs->cp0_epc & ~(target_ulong)1;
-    if (regs->cp0_epc & 1) {
+    env->active_tc.gpr[29] = info->start_stack;
+    env->active_tc.PC = entry & ~(target_ulong)1;
+    if (entry & 1) {
         env->hflags |= MIPS_HFLAG_M16;
     }
 
-- 
2.43.0


