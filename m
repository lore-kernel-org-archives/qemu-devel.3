Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C271C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbigN-0004cw-5b; Sat, 25 Jan 2025 11:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigF-0004SC-P2
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:44 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigE-0000kV-25
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:43 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38634c35129so2770855f8f.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821200; x=1738426000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFxXNpC5yVfbLd+sXWLwj9ZcwKFDj0iGBJJhc1kZZeQ=;
 b=ooKhTioMfOLQhxxJBHpcBOA5SGRAs0ch/ObzD9QR3Vc6bZJQ8RTxVoOtr7PdArKFwY
 mSfsJ5Gxq5iRbMZ39Hs2zvda+4t6ldWJRyFA9tEhOc6+EM/3nIZfB3BtplGh/QyRd7EC
 IttjAUCt+Oix7Xdcb8d0qXTgk9Z1RtSS9+1CjWgApxkG6CHKlffzYGrrj0Hi2ohgdig2
 lePf8MfkStwr4J9IgfdkskTazSix3gwi7nLKzudSJIHde7DRpkVVyQaFPuZFnhD2y3PK
 MsTQmF3nRHlMvpHAs+MeuIsu8yXEwB8AVON+DtIqivP0b9R1Uw1wOdHc24Kg9yOBeWZC
 R0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821200; x=1738426000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFxXNpC5yVfbLd+sXWLwj9ZcwKFDj0iGBJJhc1kZZeQ=;
 b=vpbn9FoGkWAH5GcLUf5KNBlEUOyUFsOFrXo9txjNjVrCg8XmqUSyciQTC+kb6ZFAb2
 LqPDwyO3CWUajJKx8HYQ8KZOl8xmgTYWkScoshMpHSvZrH/tACzptV/7RA3IlsZokZDW
 ZsFUM6kwIft4uAGJ9vypNTVKTA/YTKW1zS3Zsey89pSiHqD8H6y65yVnEVKohcVAaQiO
 kWtYu6+LQoZNv02PmSD4FfpGzVVnvrmyyE+6KLElPboq+bW3Rd86Bi1kusMr3YRacmlT
 JIcpqcA1nhD76oCyhai1MBwo5yjmUQDEj7HvBSEWLeIECKUZ1BS7qq6fdC1aXXQ59Ipq
 RVoA==
X-Gm-Message-State: AOJu0YxVyJ1GpLFO3UmCQSUkQ9BruyYGrXtAKTel9xP/HIb5Hlh5bJ3I
 joNI1KM73CHxZ7GDXxgcG4okUw2VCMTQJft8ytItpPyZfKsPg6DHXswN1kjnu5UNV0wTtIlQ9lg
 l4TA=
X-Gm-Gg: ASbGncv//XI4dkh+YYfp4MDiCN2yKxrbIsibNQCy2zeE4mRVE7wf6M9xIklDKanGvXw
 bcy2pU8T/OQxJFHZfgcTdoaJrKFYWm62/8RoQWs/zLemrQ/hXWbt3QijF5R39c2AwPvdxlMRMyf
 lCKIsEM7y2DLv8J5in+1INuPyq+I5NMPWpZijlt/AC9t5E6HQd4GJkWIL9qgLy/iHv6tbLWWVU/
 p4FCFBwd1rcZYDRU4yzUmsD0CVxTEfl1+AM5FYaBAiyY7bP57A6KAMMjixx7FhZ19sPtrobpr/L
 nyC8TyrUIohs6w/RYnHhkkNfzqxVn83GGz88OXBwUvPUBOX/T+TKfbJEg7em
X-Google-Smtp-Source: AGHT+IFXxNkkIAel2yXAFQqMOua606u74PK7nSvBr06WlLQcgeCRt+/UUayPs6Lz/zmN7aB+PlvKqA==
X-Received: by 2002:a5d:5f56:0:b0:385:e176:4420 with SMTP id
 ffacd0b85a97d-38bf567800cmr33027278f8f.10.1737821199685; 
 Sat, 25 Jan 2025 08:06:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188d5dsm6088635f8f.55.2025.01.25.08.06.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/24] target/i386: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:37 +0100
Message-ID: <20250125160552.20546-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
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

Move has_work() from CPUClass to SysemuCPUOps,
restrict x86_cpu_pending_interrupt() to system.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 4 ++--
 target/i386/cpu.c | 8 +++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b26e25ba15e..869b8598cd5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2289,8 +2289,6 @@ struct X86CPUClass {
 extern const VMStateDescription vmstate_x86_cpu;
 #endif
 
-int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
-
 int x86_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
                              int cpuid, DumpState *s);
 int x86_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
@@ -2313,6 +2311,8 @@ void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 #ifndef CONFIG_USER_ONLY
+int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
+
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 int cpu_get_pic_interrupt(CPUX86State *s);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b9c11022c4..51faba4e0b4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8256,16 +8256,15 @@ static vaddr x86_cpu_get_pc(CPUState *cs)
     return cpu->env.eip + cpu->env.segs[R_CS].base;
 }
 
+#if !defined(CONFIG_USER_ONLY)
 int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-#if !defined(CONFIG_USER_ONLY)
     if (interrupt_request & CPU_INTERRUPT_POLL) {
         return CPU_INTERRUPT_POLL;
     }
-#endif
     if (interrupt_request & CPU_INTERRUPT_SIPI) {
         return CPU_INTERRUPT_SIPI;
     }
@@ -8286,14 +8285,12 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
                      (env->eflags & IF_MASK &&
                       !(env->hflags & HF_INHIBIT_IRQ_MASK))))) {
             return CPU_INTERRUPT_HARD;
-#if !defined(CONFIG_USER_ONLY)
         } else if (env->hflags2 & HF2_VGIF_MASK) {
             if((interrupt_request & CPU_INTERRUPT_VIRQ) &&
                    (env->eflags & IF_MASK) &&
                    !(env->hflags & HF_INHIBIT_IRQ_MASK)) {
                         return CPU_INTERRUPT_VIRQ;
             }
-#endif
         }
     }
 
@@ -8304,6 +8301,7 @@ static bool x86_cpu_has_work(CPUState *cs)
 {
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
 {
@@ -8544,6 +8542,7 @@ static const Property x86_cpu_properties[] = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps i386_sysemu_ops = {
+    .has_work = x86_cpu_has_work,
     .get_memory_mapping = x86_cpu_get_memory_mapping,
     .get_paging_enabled = x86_cpu_get_paging_enabled,
     .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
@@ -8577,7 +8576,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = x86_cpu_class_by_name;
     cc->parse_features = x86_cpu_parse_featurestr;
-    cc->has_work = x86_cpu_has_work;
     cc->mmu_index = x86_cpu_mmu_index;
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
-- 
2.47.1


