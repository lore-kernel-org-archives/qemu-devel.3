Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42731C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kKZ-0002jW-Kr; Tue, 29 Apr 2025 08:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKQ-0002Ya-MQ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:51 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKO-0004NV-Nt
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:50 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30820167b47so5819357a91.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745930686; x=1746535486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLAKtSByZPkbwLOMWEWkl5uORyVUUQ5Q0ynhQjz8M4I=;
 b=egbJykF1AipJY/c7bnE4N0w0UpykP0WrDbtdhjQVAzW4DyJGrjKTsJet1vDbS2gwuF
 eQqC9jhtBNgBeFtjQ9Vh12LLv+fRuJhMEXmWZjZ1wPBVA3goDE2skdg1m/ljoXWAy0pJ
 PhEaiAmeYM95P7Y/JJfSubElClvEqNkx7px4Y6h1R+zBBuwU3a+ZNJKHbID5juxARUDY
 XfNCM9sWcti6phyHvTpSl9kRTDReD24Fp4FcCklvqBLcH1xz9wf5ZHcT2k+f7dKQa0vA
 lyASI1k3VviGdJH4xM9UEGlLrtCukn6Q172RYrLwfrKv595/iVS7/X5hpj9MjDdFxtnG
 0tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745930686; x=1746535486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLAKtSByZPkbwLOMWEWkl5uORyVUUQ5Q0ynhQjz8M4I=;
 b=R/uOO6un4OBu6s4Dz7QmEmb4H3C+9MgASYPXtGJC0BkwCoaGfDk3aWnCmIU+5X9cmd
 u8w97lkZdYiKbTyhuFYsY9ky4k3EDdz9d6c2ys6P/E8lhES2CedK9d56pgfxOblXwkih
 jK8LNpSDXtjY/nvjShfVKOb+Mn+EIZ5ImovtfJ5vbHREiqgvLDEBgA0VSAvWhVduI05K
 DEwmjGOEttv2gxM1GtP/GB84plpURUjMV4GFHtRYfjOFGZh97cKK2jPGpI9vqVrSTMhC
 hLqCm/CKJnyEabFVEak8FIJZihGsDK/DJ/v0/Kq4YriVIM0aRT7fCEsa7lcqdixA4494
 MLCg==
X-Gm-Message-State: AOJu0Yzm26OWaESyXopKYjfIWrR+lBVFyJquuXDR1+8DJEgf6jJCZ6Mz
 9HAj04gLV+++cW1SLXc/eeFkSyuEAjcGVMCDFixYB4uzQZYr+cCgeddQybt45tYBZ3jpZg7QSdu
 J
X-Gm-Gg: ASbGncsZjziqIXc/imTRZ6FH9Gss4ELfdYby6VuSlAZDznvTet56ogU2aiS564hHmgF
 ofQcUyjPTym9jG0q3h9KmIyg1tHY+8Acjaqtrl5f67GlTN6eg8avTngSbP9pEgNlEtMKEKgGbVo
 KxLYi1OaXDxJcLK1k4qP7XMjnozeL7UR2HDj84PpGkKwPe45OHYPbC1oV6I0m8wTp1/VPCFkhJE
 Li8lVgXJ09W31oV46rqSWSg2GA6iK1g969vSx+bkl8E2eMrP38z9JAznQR4YeAIXHq9fK8OF5CN
 BT+ktYBCoGo3BgAKiFFltgw3hWHC6dM6qWbz7/YiT+M=
X-Google-Smtp-Source: AGHT+IFkJErRsiaXwNaEsHBdH2BCQMafFZcQ3joCdFl0WSuJtH7/E5ZMOt2zGaQHQrIAArAUq65d7Q==
X-Received: by 2002:a17:90b:264b:b0:2fe:b907:5e5a with SMTP id
 98e67ed59e1d1-30a22467d74mr4050029a91.10.1745930685570; 
 Tue, 29 Apr 2025 05:44:45 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef04ba89sm11001161a91.10.2025.04.29.05.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:44:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 8/9] target/riscv/kvm: read/write KVM regs via env size
Date: Tue, 29 Apr 2025 09:44:20 -0300
Message-ID: <20250429124421.223883-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429124421.223883-1-dbarboza@ventanamicro.com>
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102a.google.com
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

We're going to add support for scounteren in the next patch. KVM defines
as a target_ulong CSR, while QEMU defines env->scounteren as a 32 bit
field. This will cause the current code to read/write a 64 bit CSR in a
32 bit field when running in a 64 bit CPU.

To prevent that, change the current logic to honor the size of the QEMU
storage instead of the KVM CSR reg.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5efee8adb2..d55361962d 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -135,6 +135,7 @@ typedef struct KVMCPUConfig {
     const char *description;
     target_ulong offset;
     uint64_t kvm_reg_id;
+    uint32_t prop_size;
     bool user_set;
     bool supported;
 } KVMCPUConfig;
@@ -237,6 +238,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 
 #define KVM_CSR_CFG(_name, _env_prop, reg_id) \
     {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
+     .prop_size = sizeof(((CPURISCVState *)0)->_env_prop), \
      .kvm_reg_id = reg_id}
 
 static KVMCPUConfig kvm_csr_cfgs[] = {
@@ -646,9 +648,9 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
             return ret;
         }
 
-        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
-            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
-        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+        if (csr_cfg->prop_size == sizeof(uint32_t)) {
+            kvm_cpu_csr_set_u32(cpu, csr_cfg, (uint32_t)reg);
+        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
             kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
         } else {
             g_assert_not_reached();
@@ -671,9 +673,9 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
             continue;
         }
 
-        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
+        if (csr_cfg->prop_size == sizeof(uint32_t)) {
             reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
-        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
             reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
         } else {
             g_assert_not_reached();
-- 
2.49.0


