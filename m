Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159C7C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVY-0004Ue-Su; Thu, 06 Mar 2025 10:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUD-0003ZE-AY
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:16 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDU9-0006d9-8H
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:10 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so9825045e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276207; x=1741881007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6AGaZhzI7b9cA8ZVzToMlsrK1z7aXcYWITqf5Z8tBA0=;
 b=ymQ0FTDlayj4NQ1xIKJ9WkgoEcCjcJH7HIyhbW6a3FpBgNpVNtXJQ3xNVK+2UU50+i
 tzh1zb7AQs8Rp0jXepbw8QRdAXqyQWYogS50GnHLxV9msYQg5GBOiaUA7sKCu8/oImAM
 7xag1hQzJbOmVtoYKMqdAKa/cw5WAqMbvHvDSZnICrkgIFjvF2fXQtCV0sffN84ksIAu
 9rnJsMv21+bUQImU4untliXFv6z0HdZdfvI17UEaEqqEv/Cig2D2d7ctKGrf1ANUvlbU
 Imds72er+zFTeRPhImCutJla+2AIYRzmU8II3H512Z8CZnohdyyk391PHbXFI0jBPfGT
 mmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276207; x=1741881007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6AGaZhzI7b9cA8ZVzToMlsrK1z7aXcYWITqf5Z8tBA0=;
 b=V4pb94FtwGyigPr+N17/fPeHEQHFXBdTix95w3spA+arLFl/YfPlrfkaGvWnyhQEc7
 lUPH8DUoeaigoCiISbaDXehX+dpm2YbyWaxq1AlIBKKrbc9h+6BqYizURo/kZKFDd6CO
 13z3BltEf22x0UPW/876cNS86iV8N9GuT5WQFGA9If+lVUUcjv3tvCTvZyCnmjPqb4Hj
 x1/loKU4zxwaalVs66QokRD2YsbZv+/QkBeGeIPAVuoK9ijVBbpzu9GvfHn1EpfEE3Lf
 ZoZXvL4SnAVz+ge289+mx0OfKchK6OLJxRVeZffRNjA4I7wSlVI9wommMxyIJZ+kNcUR
 y9QQ==
X-Gm-Message-State: AOJu0YxX91QdFRd4QaJe/9DmoLg4nbAcBdcCRhSsuN6ZJrUpmLVKwYfO
 mm1PUPypluNjkcIxHlJ1YR+rOIdy6EZhtcbppi5YjGXzTtftcuPv/FwSJvqNs0QJaR52VXXr+Ar
 10T4=
X-Gm-Gg: ASbGncvRyoOVpJWReOw2gnnx/3A5mF5/tI2G2KDQIKpnJTOmnC0mrX2/9M4P71uAhah
 MO4Ny+3xrd95ptTHP/xfmVaPF/vL+TQdMZEOEWoTbrmyWOKJiglDJ0a2WtuIt+oUcooGS008uk2
 0oab8amFr/D+acUfgM8wu9WwHPSUK//FBS70OcB94XpfNsFtkmDjf6Z2uxY8979EXbqbdtyDFVH
 hv5/Rg3pjPQ0ej5ZXMnDr/kUaKeR8AijP97WiN82ZxM3n2Fd6ufvy8rQtt3OPkDZUWzJV0fMzb7
 AfCwQi3WH68a7x79bTwz10hqCCDhEDcFPzC0QweYTx1ItbVry4LE9BK3O/td/whUFmGDXXzel6B
 SsoGOmSNx2rWoDgb2YGA=
X-Google-Smtp-Source: AGHT+IFETVjixvsV6BkR9fmitYdlYy3jpCoUYKhTblQjk5iW6quz3YdzEOkPAll7xQnu3ZrYGsLlaQ==
X-Received: by 2002:a05:600c:1c90:b0:43b:bfb7:e099 with SMTP id
 5b1f17b1804b1-43bd29d2a35mr71711185e9.29.1741276207042; 
 Thu, 06 Mar 2025 07:50:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93c9b6sm23352175e9.29.2025.03.06.07.50.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/54] target/rx: Ensure not being build on user emulation
Date: Thu,  6 Mar 2025 16:47:15 +0100
Message-ID: <20250306154737.70886-34-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Currently only system emulation is supported.
Assert no target code is built for user emulation.
Remove #ifdef'ry since more work is required before
being able to emulate a user process.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250121142341.17001-3-philmd@linaro.org>
---
 target/rx/cpu.h    | 6 ++++--
 target/rx/cpu.c    | 6 ------
 target/rx/helper.c | 4 ----
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 5ba1874bd76..349d61c4e40 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -26,6 +26,10 @@
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 
+#ifdef CONFIG_USER_ONLY
+#error "RX does not support user mode emulation"
+#endif
+
 /* PSW define */
 REG32(PSW, 0)
 FIELD(PSW, C, 0, 1)
@@ -129,11 +133,9 @@ struct RXCPUClass {
 #define CPU_RESOLVING_TYPE TYPE_RX_CPU
 
 const char *rx_crname(uint8_t cr);
-#ifndef CONFIG_USER_ONLY
 void rx_cpu_do_interrupt(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-#endif /* !CONFIG_USER_ONLY */
 void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 7d5fcbf76ac..17ede51cd11 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -192,13 +192,11 @@ static void rx_cpu_init(Object *obj)
     qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
 }
 
-#ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps rx_sysemu_ops = {
     .get_phys_page_debug = rx_cpu_get_phys_page_debug,
 };
-#endif
 
 #include "accel/tcg/cpu-ops.h"
 
@@ -209,11 +207,9 @@ static const TCGCPUOps rx_tcg_ops = {
     .restore_state_to_opc = rx_restore_state_to_opc,
     .tlb_fill = rx_cpu_tlb_fill,
 
-#ifndef CONFIG_USER_ONLY
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
     .cpu_exec_halt = rx_cpu_has_work,
     .do_interrupt = rx_cpu_do_interrupt,
-#endif /* !CONFIG_USER_ONLY */
 };
 
 static void rx_cpu_class_init(ObjectClass *klass, void *data)
@@ -235,9 +231,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
 
-#ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &rx_sysemu_ops;
-#endif
     cc->gdb_read_register = rx_cpu_gdb_read_register;
     cc->gdb_write_register = rx_cpu_gdb_write_register;
     cc->disas_set_info = rx_cpu_disas_set_info;
diff --git a/target/rx/helper.c b/target/rx/helper.c
index 80912e8dcb4..7f28e729891 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -40,8 +40,6 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
     env->psw_c = FIELD_EX32(psw, PSW, C);
 }
 
-#ifndef CONFIG_USER_ONLY
-
 #define INT_FLAGS (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR)
 void rx_cpu_do_interrupt(CPUState *cs)
 {
@@ -146,5 +144,3 @@ hwaddr rx_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     return addr;
 }
-
-#endif /* !CONFIG_USER_ONLY */
-- 
2.47.1


