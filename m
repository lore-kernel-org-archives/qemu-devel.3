Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1029C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9U5F-0003kL-ES; Mon, 28 Apr 2025 15:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U5D-0003jH-Qu
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:24:03 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U5C-0007PB-7Y
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:24:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2240b4de12bso78563685ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745868240; x=1746473040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nQvphfEuGeh2n9SYU8tx7Ki7baxefxZJJlRlKKLmGY=;
 b=G3GBfRpHnv8BI6cNuR+F0RglBZ7SabogtvUXf0/UmwZBuQyr/DCcr/p1QW6PStkTD6
 rVylcxe9TOVMdy9DdknGKlyA9tg4bPqTqSmT3w7u1ipjMmuatYM/khcJRDIGHcRiEnfj
 0p2AYn34Ze9fTzNu2lJL3jigpUWmZ16Z/W/GEiIFGwd6MNSxsYy5mpntHvlnd0sAnFOe
 mZx91ZntEGAzAPGyiicn9D5mtghEE4y76CzFjeVu/hRehoXdonuyzsREQb/1EM27r5uz
 30Sa7jz9kqTBN8h/fkRqmR2nRPuf/JPBf6AwUWez8W4T2r2jdQeIdCJJQ0nTg9GIgEI6
 u0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868240; x=1746473040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nQvphfEuGeh2n9SYU8tx7Ki7baxefxZJJlRlKKLmGY=;
 b=XY9NC31lT14+TRLJxjPUC8wDbYxaDQslOr2tDR3IK+ESKGs0L9bKC6/7bucMN2bIQg
 xRkf21i1R7J6eHhU0YSbR+MXBaBCHaLwTtiW9oUJpvNFxhdw5LuzgWrvF2060xtrg+Nn
 EHvORPaeiOAJeXYUIPeCT7hvKRH4Qnbl9HA3SPyNGlIegBkxAQhwlPjquQb71ThzpPKG
 nON1JIZ3c3LXyazFJ7iVRDP3XZrnL3MVsQcnjj1wvVVGD67FGMoFfIVYrbvir9e/DVYn
 ShhLLb548joc10b8KqDMLFnEeFzFnnWNp6h5+E0EV03xLo1WGLedy0k1PJ+GX/fYRVvz
 2vQQ==
X-Gm-Message-State: AOJu0YzFw5KfhxMZsWg69J0vFOK2jACiYorrxfmUeX9eVtZaKqI+I2T8
 cdLOmp1h9tL20TUtxuvvqtqYAe+hZgloky+WTtsGiq703B9Rxu7lJFDzGDTZsRXNvXhseBHAloX
 kC/w=
X-Gm-Gg: ASbGncu26BL1zJxb8eIRRdIknhcDybqPfmKnAl3MOxrhvh6KPgPG8gCb97lcUbq71sB
 UHuCPwPfia/w/ruO3ikqPoGljHrS8f3Gxf2QZUv62EqfnNqEBMvyXaAKnOBaXGxjeZSnCY5cnSK
 M5ux5GoeqBSHtQCZD00TORR9GblfePR1AGuQQfTkBbU0jwOiMbNc1XcNIm27F9frCXWXBDX8VOQ
 I0FUbdxNsViTxwC3BYc9ndPKDwT7ZdvDhJlIvyfdSOhVEdUqDzug23Q2Mz2XO2MigHtVokjPC9O
 MZoxWtAUpaKTOoYPr/fX3825UnvK1axhgzzMLTYIQTDi40ebsTpVnrw=
X-Google-Smtp-Source: AGHT+IFO9/zjGz3SGatZpzmrZ+jY+EELMNE7T5WfBF2gOT1OUMsndKGSUPQW9i/qU/ct7w7WXehG1Q==
X-Received: by 2002:a17:902:ea03:b0:220:be86:a421 with SMTP id
 d9443c01a7336-22dc6a68648mr164813055ad.38.1745868240530; 
 Mon, 28 Apr 2025 12:24:00 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:906e:57d5:dca2:1ab3:20de])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4db99d3sm87300565ad.53.2025.04.28.12.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 12:24:00 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 9/9] target/riscv/kvm: add scounteren CSR
Date: Mon, 28 Apr 2025 16:23:23 -0300
Message-ID: <20250428192323.84992-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428192323.84992-1-dbarboza@ventanamicro.com>
References: <20250428192323.84992-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add support for the scounteren KVM CSR. Note that env->scounteren is a
32 bit and all KVM CSRs are target_ulong, so scounteren will be capped
to 32 bits read/writes.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 53c34b43a2..209fe769df 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -251,6 +251,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
     KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
     KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
     KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
+    KVM_CSR_CFG("scounteren", scounteren, RISCV_CSR_REG(scounteren)),
     KVM_CSR_CFG("senvcfg",    senvcfg,    RISCV_CSR_REG(senvcfg)),
 };
 
@@ -703,6 +704,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->stval = 0;
     env->mip = 0;
     env->satp = 0;
+    env->scounteren = 0;
     env->senvcfg = 0;
 }
 
-- 
2.49.0


