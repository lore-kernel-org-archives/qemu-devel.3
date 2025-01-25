Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F9DC0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbihT-0005V9-I1; Sat, 25 Jan 2025 11:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigo-0004zp-Ct
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:22 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigl-0000mr-25
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:18 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so1576072f8f.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821233; x=1738426033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HrE30xT1EmuXt0tg0kaHmGrX7iIi1CpOMZL7K4RG6J8=;
 b=KDSjV8K3x+ZucaXuRw5Cb3C07VOUJ1/+FQnCyEyib3y+QPyaBvazHZxKuPErI9BgEC
 RsucQVM2/OtJbqwhMz+Ka8ckIvh/WKzHnJ7euxefusiEMwJPeFkcMvfq6mej8MDyEzFk
 l63SKDsI9oJEMcLfSk0bu0lN7rLtGh7Fc3JhFe+VfNzWc/jUlO5DKN8UvULgrgOop2PV
 AHn3OtMuXfT7asNtYwvYE2ZyZq8slj/0Kr84Kc5Mh0SwScAnIgdY4kNXS+B0b7zOFwjL
 oxXwzKrHgrLr5MPOktZ2EbAOK6ZtLBRarrNx/MuP1B6TWmO51NQYTi0R2PSsw6kWI3Rb
 ZR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821233; x=1738426033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HrE30xT1EmuXt0tg0kaHmGrX7iIi1CpOMZL7K4RG6J8=;
 b=sZSN7AVIbR+dobLKZGfBVhYO0WoJtugoDIlw2sFCW6psjd2uZ7yk3bfOx4wiiX3oxU
 mj2tI7M1fdj7lNTd0evK2FCI1G+0+paUAkSFEZVFmdfeBgT4+J6t/x+7WRMzK5p34J1p
 YmRDCSLcCc2V6hz01GkkHfo6xaHHTGq2DBraGFbSnMjPHU+lsZr6xK6voJsRxKiKdFBe
 Fycb1AJOb9MNejOW7OmNMqSqjDkSEKEN1WS1LCtbjP818wnfgC0GIs7/NNDYEdm0ztfZ
 IELEVkrHs/tQiIqagqB990UTt2xkxeBLLUCLYcI8+umLuDnd3mFMua905xD5K5qG0cQ2
 VIew==
X-Gm-Message-State: AOJu0YwSsdbWJNdrxM4vpUs43yYV3nCCWUAaiwhOkFXTjmR7zqop5r7w
 FmM0OEUO3cJqYxBQq+EBVltu/eSPa4Pz1IYYVrbjidkEk+yCRgh3OIx6SybXBVe47uh8n+2tPV0
 NqQM=
X-Gm-Gg: ASbGncuGhezYiHQYJAxlKCNqGRdlXUZxw+dH/GjshVFbRldxO8cQAMwKqWbRZdi0Uv2
 n7HIU6kxkkrlCFS7FdYxNFSZZ+r1DWgVGzSaeK1dC+7rx/6AgaFL5tHasMwpMn3/MOd5pCMqdbP
 p8z4y3yToCtBSUUZRU/7GeHIN1XwlV6qaiyucSE5PIio7s2SnHC3eofUvBFEI2/R3HeQ3aHY2NR
 PdhcX3EJzpW8oQHQWoZ6fmWIp/2ntsJm+WwJgbF/Dm8QuP7TKVz9dJ4ljUj1IlEcl0phHytud5J
 SYZLPL+tzzT6taoQZd5Ns/C2tlJaZ1XgOksZfSP4I6ECNtelYgxgTfH2eQmK
X-Google-Smtp-Source: AGHT+IHLhJh2YqNnHE3fSUV3On0ysIelj39LxAbMChPmUDOa62DMFtRr/OpccKkMtbpmSQ1MOKkwaQ==
X-Received: by 2002:adf:cc90:0:b0:38a:4b8a:e47d with SMTP id
 ffacd0b85a97d-38bf5674f99mr24452337f8f.26.1737821232905; 
 Sat, 25 Jan 2025 08:07:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb02dsm5896988f8f.70.2025.01.25.08.07.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:07:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 16/24] target/riscv: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:44 +0100
Message-ID: <20250125160552.20546-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: qemu-riscv@nongnu.org
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
index 3d4bd157d2c..4a7e02d9a99 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1010,9 +1010,9 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
+#ifndef CONFIG_USER_ONLY
 bool riscv_cpu_has_work(CPUState *cs)
 {
-#ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     /*
@@ -1022,10 +1022,8 @@ bool riscv_cpu_has_work(CPUState *cs)
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
@@ -2912,6 +2910,7 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps riscv_sysemu_ops = {
+    .has_work = riscv_cpu_has_work,
     .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
@@ -2933,7 +2932,6 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = riscv_cpu_class_by_name;
-    cc->has_work = riscv_cpu_has_work;
     cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
-- 
2.47.1


