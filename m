Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C709C2BA1B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKqn-000865-EO; Sun, 09 Mar 2025 13:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqb-0007Mi-5a
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqZ-0004y6-CE
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so1626115e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542833; x=1742147633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6nHKP2gggF1XOmH1TzGcLN38oL/58EhyiN9pC8iNlcU=;
 b=VQjAqz9qhRSQ/no3eVD/2Zw1hQzF5Br16PHc6dVyEwaPYveEbIo84e/3IUoL6RK6Mj
 BmiHEncEd7vLRX8OJULjP9Mb2yYSosevTcQhbi7gvRrUKWesuRMluPliagWYmpZVOUVk
 0CJsXT5vdwgm8c6dg+zXBwjCh5Aw4WxFhS9DPx0XJSzEzpoRiExiTYZk+yg8aiRC43aQ
 Z+kpiJ8Dg1BmnuRUeu8oKDs/qPKDkX/WdU5Qq9iqZ8+S33hrXPyAKH9a2nwZ6Vt1tmka
 d3c1/lCqaTFIAN/cTibyWQ3cTkMH4KbQfptcanIShjL4ZxIVpxQr0OykQJYPmzlNSMWO
 3aBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542833; x=1742147633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6nHKP2gggF1XOmH1TzGcLN38oL/58EhyiN9pC8iNlcU=;
 b=kMikWp2TCn4epcTU8EaRBkR39BGX/l1TmvisKfpYHB9FQz7BWAAJQx/iNMZq7eopcV
 tWhan3oQudvRdrh7uA+agtkHkek7jx3CLisZTGde+mSQtcZPA/lPOCnP6aq4Q/ZI1qNb
 ZSUnPwiNYlGI5Mxnn4B1+a/8NQqgAvYc1UPlXK47cyWxAbTKa4KxcO6qtVzNsa6PNhM8
 UUw7wstkRSOO7iCxCs2Dpq2g4JV0j5JwYQTZawBd9oaccTSc4oHkpVT8aFseTXbJeQRo
 WEQCJ+1KRMd1xHlo7r5M/9+WTuEzWjAwg0IV7ifgjro7RUi1IupvL7wt8KCaS/UXh3XN
 oGUw==
X-Gm-Message-State: AOJu0YwDlKKRaIHtKrb94bt5CuP3pfBNTCucff3n+ZUlaK7+KG9FfKc7
 PcMJmT0cN2UstNashpWjTiqGkBOm4u8MLAZO2ckej2nZt6m8GG7SbwnDjtRagJNeMCqZW8Ko47V
 un8s=
X-Gm-Gg: ASbGncsxQhwEkHltRkGkqCHimslfIebKaAd6Iq9i0om+hNlGtulCWTM+4h9IXq02PTG
 9zlxke0rtmPYipp5vtCnLxRJk8uMoWNGJ/EyeYDZkJ6kJD76bgzRQG8u8kg8nsYpI/ieV+ME/2f
 acuocGxdRmIVaoiqup39pbpylJddXCOlpdVrecwhE20d7TGHmHeLW5J71uUO8pnjWb118xa8Eaj
 2gYW9J+Ox9XB1U2jDtiwn4YRkzikQPPjuL9fcnkCKVu81eIqzRKk+h9Pylczgm4W1oFPVoOg4ng
 NPjMINb/pW6E25iS0N6f4fN5xfNZE+plqeCYcN4jQYfenKiKe6qCyEHCFv8nubvA0n1xxCF8eQ1
 uzgR5U76nao90exHYWVjMYHgcIrDMFw==
X-Google-Smtp-Source: AGHT+IEArUtbYt/SZL4izrD0F6gzS5tbKR2c7c2YPZpTkthP3/kkgJ+Ph8IwGhCQLv4cJInw0K187Q==
X-Received: by 2002:a5d:584b:0:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-3913aeef970mr4446068f8f.8.1741542832953; 
 Sun, 09 Mar 2025 10:53:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c11e9desm12246338f8f.101.2025.03.09.10.53.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/38] target/i386: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:51 +0100
Message-ID: <20250309175207.43828-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Move has_work() from CPUClass to SysemuCPUOps,
restrict x86_cpu_pending_interrupt() to system.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-10-philmd@linaro.org>
---
 target/i386/cpu.h | 4 ++--
 target/i386/cpu.c | 8 +++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7882b63b9b6..76f24446a55 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2349,8 +2349,6 @@ struct X86CPUClass {
 extern const VMStateDescription vmstate_x86_cpu;
 #endif
 
-int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
-
 int x86_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
                              int cpuid, DumpState *s);
 int x86_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
@@ -2373,6 +2371,8 @@ void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 #ifndef CONFIG_USER_ONLY
+int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
+
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 int cpu_get_pic_interrupt(CPUX86State *s);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b3e1c2bca49..1b64ceaaba4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8604,16 +8604,15 @@ static vaddr x86_cpu_get_pc(CPUState *cs)
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
@@ -8634,14 +8633,12 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
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
 
@@ -8652,6 +8649,7 @@ static bool x86_cpu_has_work(CPUState *cs)
 {
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
 {
@@ -8893,6 +8891,7 @@ static const Property x86_cpu_properties[] = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps i386_sysemu_ops = {
+    .has_work = x86_cpu_has_work,
     .get_memory_mapping = x86_cpu_get_memory_mapping,
     .get_paging_enabled = x86_cpu_get_paging_enabled,
     .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
@@ -8926,7 +8925,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = x86_cpu_class_by_name;
     cc->parse_features = x86_cpu_parse_featurestr;
-    cc->has_work = x86_cpu_has_work;
     cc->mmu_index = x86_cpu_mmu_index;
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
-- 
2.47.1


