Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0B2C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKrZ-0001Gq-90; Sun, 09 Mar 2025 13:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrC-0000Zv-1C
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKr6-00054Q-43
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912e96c8e8so1818957f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542866; x=1742147666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AvjB3P0WeLn6QuXjictfvS8poYJ3HIL+ASsPoBqctfA=;
 b=xwGtDH8R6K+Ud1/OTFlefXwTUZTu0vUJMQURmFBXEoiOJZGSkd+YfXJT7we6LlShyU
 ekJ5v1Gk3j9P3eDMSnj/4DFZdkoCm+vx6S4cPlMxLa7kMT4J0lrsVXuslkMwb0kG35Ty
 jIFks8Rlxw2gXp94GRXjQxP1EmcMmGlmDZ1jLHCDL2HHaj1I7XkhvAjc0dqMZ+9BdK3V
 tSXG/MAkxm5Uooww+CCYkwJVCA6DJT4Kyq2LQRmZATAa1hmslLIy6Tncq0IW4hN1Pz19
 gmP1u9dzgzPqkU8rzzAHgVA8qG6PG5CgeZyHWx7wNqNQty+95Xnr5erkLtXacvTXCs1c
 dyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542866; x=1742147666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AvjB3P0WeLn6QuXjictfvS8poYJ3HIL+ASsPoBqctfA=;
 b=Z0Y7eYHudsL+K5K8fv6JH9LqnuZQCsN4Xg3H75MsN2rFl7K/b/uPJ7JQgOE5AIzT4f
 C6vGGSObgm540iwtLl9Dz3CyvcbGVbnBVHMht/dlnSdvs7Ns2UJEGncj27bq8uA1MZcC
 Rx+SOTJWkRTeEL5tob1AgmKQQqUh6BBBN/X5ixbOeM/8491LDR8aHi6ibvnZVcTalkG1
 P3RRkPGgdoS8nFdKaHAYe5rFmUMm/mRA75RDeUinKrUGa1GPrIS52tE26+Vm/EHb6Wn3
 zocBtSIqRB2aCHitMljjWX4N8AOGpHZ9eb7aOigZ+SDJSUKA/PQac1hbVfzLrqnkaale
 g/MQ==
X-Gm-Message-State: AOJu0YyPz+EYRg85WcdVFyXv+mxWxjyhgu3ka28XUNzXPsqcJhxczj1p
 cOLFfYzUK+cpQFtu/L1CMsLR/7rE74RwxF7SaCv4V0y0YYIHo6a6TjAjnO7mGcyyuEpeuM459Fm
 rOn8=
X-Gm-Gg: ASbGncuiNVsCNsSRSXOT4lcu2bV6r/TY5Re1MLJYoG+6lvwQ/WBkqiyPUku7CYFrb7I
 +J1lh/zMNEQsOWdpdu3zZktdi3rJUdU47O5VeDIGNI31fa8nxENNItoW06W55ZqJJbpyj7/QUSh
 FJWOwHX1AB3DdAmc0FMOETdY2zvKgqQ7+6t1ATgkUci3inv0GGlUHUUcnMhXGGaH+9TGLzPgVYN
 qTDouQh9QokxGcpckWdMlkU3b/goah9cyxJhdZTJsK6fT/zm1ICh8cou4r8wUW8MmMuRWU8mbr3
 4HYuJrVf/rRMlBKA+myTQrgTuuJrl7hNnVO/JvsITlBoX1IMCDm2ounxAoAJ8y4cAvOl1wWN8a8
 OmgUUMv3KYqdmoSvPbU0V56Ld40oIOg==
X-Google-Smtp-Source: AGHT+IEXYfgyF/IUzLtxLa83K2GGuWIvkzeW1ji8i7bI+4ynxpJGqDt9lnDUfwc0jRe+Z5qD7aofeQ==
X-Received: by 2002:a5d:64aa:0:b0:390:e853:85bd with SMTP id
 ffacd0b85a97d-39132db1108mr7323981f8f.48.1741542866082; 
 Sun, 09 Mar 2025 10:54:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfa97399esm2532275e9.14.2025.03.09.10.54.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/38] target/riscv: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:58 +0100
Message-ID: <20250309175207.43828-30-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-17-philmd@linaro.org>
---
 target/riscv/internals.h | 4 +++-
 target/riscv/cpu.c       | 8 +++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 67291933f84..213aff31d85 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -142,8 +142,10 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
     }
 }
 
-/* Our implementation of CPUClass::has_work */
+#ifndef CONFIG_USER_ONLY
+/* Our implementation of SysemuCPUOps::has_work */
 bool riscv_cpu_has_work(CPUState *cs);
+#endif
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1c000c30f8d..09ded6829a2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1006,9 +1006,9 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
+#ifndef CONFIG_USER_ONLY
 bool riscv_cpu_has_work(CPUState *cs)
 {
-#ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     /*
@@ -1018,10 +1018,8 @@ bool riscv_cpu_has_work(CPUState *cs)
     return riscv_cpu_all_pending(env) != 0 ||
         riscv_cpu_sirq_pending(env) != RISCV_EXCP_NONE ||
         riscv_cpu_vsirq_pending(env) != RISCV_EXCP_NONE;
-#else
-    return true;
-#endif
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -3029,6 +3027,7 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps riscv_sysemu_ops = {
+    .has_work = riscv_cpu_has_work,
     .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
@@ -3050,7 +3049,6 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = riscv_cpu_class_by_name;
-    cc->has_work = riscv_cpu_has_work;
     cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
-- 
2.47.1


