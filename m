Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40F7C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HNS-0001Gs-6K; Fri, 25 Apr 2025 07:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8HNP-0001Fi-Uz
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:37:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8HNN-0006Za-6F
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:37:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22c3407a87aso33110175ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 04:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745581066; x=1746185866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1w8u6svcQru1pIlMWqNvHitq2SXpUDJnfU1RyWgJhw=;
 b=U2HYJtHU/ka0omBsUHGNaiFYVtvYz0m5WsxG4HGi+tSX6AVUcYA+yjup5GwMW7N3RW
 5mV+dxTzXijd0EwfV6GFMtqCFQ4pd3fsEW4i415XZy3pQkBw7TvgcODdGvtGJVkzD1LY
 ZHfCReqg/ZeRZqDN09ccmlEIEQ8Tah6umrkcGCORUYHfbUC2OaSRPPBJF7bo8n+TFILq
 dInq56n3PU2BVCdszyshQxCht80KPf6PQ1wE468PCJB3vDXgewCnGz9+bZm1mJkz0sew
 gIj2isPvLAhP+RFb4YWxBe2Slo0zt15yebs1y/lkaLRV1opNDJ8GHm7PgbbUaNJFZibK
 uHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745581066; x=1746185866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1w8u6svcQru1pIlMWqNvHitq2SXpUDJnfU1RyWgJhw=;
 b=CawNB2S+eoFJe9wmGLydXaVAKButoywMhddyFMsj0qVsg+Hzw7rPrErXG9pX23VhkB
 hlgHhBnVxG8u1l7AC04VVZQIs1VroO53nfxZAvypWwZi+yPPUlaDnH6e3NLxlvWvTv2Q
 fGdXVZZSe83ue8yEZKCWfNyGEzs3oH2BxV4+0fE0EuPqDORlHG5rlNb5DHEaPU1LiZE6
 J1zELl71CtQ1nQU6GxLRFupdpjA8heIgx2W4STyCqbjrOKP1q4OBlqVHHUH/R233r06E
 hywAuZORdI9qnoAemL3T1TxY3VoDASU6gwC9tMR43WRIg0zlsCSQCNOUH/IgCL0q+VQZ
 17ag==
X-Gm-Message-State: AOJu0Yzp9eb0XwOpqNyj/hXjmrTO5R2nYgcJAwYwsyoqhjjOMi8HQyrF
 Ke0HXVLrQUwsItsfJ13OCYKoHo7VUXqSWPxPDVUc/LWSL6RXKG6CjKPMy4fZ19ljl5EmAKzS96G
 6
X-Gm-Gg: ASbGncsN3xaAZofHOd5ahZFVDwMsDG1JdA4X1HCH4FdPCoAv6TTER41TkOW/xSKgDpi
 2jVUigrOnUg0GsB8m6NzEJYTaUi1CbmsnlgfHt5xcchUfPCP0/qVzhaVx8l/LFA7hZZMdxmhZwH
 bEIJlUcDRZuxkTfa1n5lsQg+3BTtYS4q8Zx7h9d7GEjTlwsZ23lrx+maMZunKNw94eqk6f9GTO8
 tEpYzNfxHTL1DNZOEMANCHZcvtm1Cqofw2CwuTXjC+s2wATfwFIGU7Aj8sSyDfWJJZ21TBds3GT
 PIVOzLkdMw9ZwaQf6N9+H2GJBto9O0ilN6kCUu6ivnXFY8Ao9fwkk0V8q+q0b9HDZMh6
X-Google-Smtp-Source: AGHT+IFlce0m4rWNSwhxYRVKUUAk+vjcKfE4HvD8JjzcbX20Z1DOSsYj/BmE8Fo48wyLYORtxCJV2A==
X-Received: by 2002:a17:903:32c8:b0:224:1c41:a4bc with SMTP id
 d9443c01a7336-22dbf5ee6bdmr32105685ad.12.1745581066044; 
 Fri, 25 Apr 2025 04:37:46 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7a40sm29881055ad.147.2025.04.25.04.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 04:37:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 9/9] target/riscv/kvm: add scounteren CSR
Date: Fri, 25 Apr 2025 08:37:05 -0300
Message-ID: <20250425113705.2741457-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
References: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

Now that CPURISCVState::scounteren is a target_ulong, add support for
the scounteren KVM CSR.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index e37fa38c07..5db63e78e2 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -250,6 +250,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
     KVM_CSR_CFG("sip", mip, RISCV_CSR_REG(sip)),
     KVM_CSR_CFG("satp", satp, RISCV_CSR_REG(satp)),
     KVM_CSR_CFG("senvcfg", senvcfg, RISCV_CSR_REG(senvcfg)),
+    KVM_CSR_CFG("scounteren", scounteren, RISCV_CSR_REG(scounteren)),
 };
 
 static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
@@ -700,6 +701,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->mip = 0;
     env->satp = 0;
     env->senvcfg = 0;
+    env->scounteren = 0;
 }
 
 static int kvm_riscv_get_regs_fp(CPUState *cs)
-- 
2.49.0


