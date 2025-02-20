Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1BBC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9B8-0008OW-Ud; Thu, 20 Feb 2025 11:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tl9B7-0008NQ-LR
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:13:33 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tl9B6-0007Hp-2e
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:13:33 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso23964735ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740068010; x=1740672810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnvQ9cuHygS6JjjK+o31ZflMYYOqbA8EhtHcyFl2E2k=;
 b=Ntx62Sinjob2m1IBvn5xAFVsUrYShegpQW1YPNa4KRwpt24GWbCwxStJG5UBac6gC/
 76Oox1VCcg2kQyWlSTBAyMxixHgZbufVDL0SS4uX4HHOkvXUP9VekpISTKVjwA/j/iTV
 MMyeo2lOIIkcXxinLgeJr34w5Su8TX7HClIY9NHMqNudy/htcfK6Z4b8cR+yW/Nl18Qk
 A56qwnggS6ymJhfCLU7CwB7xdct8Zx1YsJEGQSixfT44U0pwUR8VtMkDQK/r3ehTPDrn
 5/IDpzF/6guxLgZI6LGeXACNjyFPCYJqxrEie7ntTpjBIQhQ4FkfwawBAJBuRB+hKWjh
 dLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068010; x=1740672810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qnvQ9cuHygS6JjjK+o31ZflMYYOqbA8EhtHcyFl2E2k=;
 b=ZGufNMpsuxmRFZuyMyRv1cW+w8xlfRw04JjrBcUiwiz9gYSQzm1rlY414L3+R9SnfC
 bvKCRyYElEig5TQjaYKCouYJysQCmSxvz+Zh5CvOn/OQbUI8Vl/99+UQ5iHsYuKDcud9
 AAq+fkBwJQeLq2i2WKHI36ODULKsl8sm/aNWugg78c2oETcBgElRtY7hjBUE1BpsKLCw
 lVwgLDLYIF8YZ3MtO6XcA0/Xta83Pa/9Cibb6WQTALEH/nfCBCv2NQoPlCbNMPexPDS9
 UWcgvDt9jx8NrY4V63AREmdqd+jcjepJaQWKsDK7Eowq4yuL6OrUoEWrwl7kpwip55+D
 JiBg==
X-Gm-Message-State: AOJu0YwwPFeWYHZ2hgT1/sWwWKyn460ntH3YUV0E6QseJ+QgrGwWlYg4
 K6OLWyoRtvdXS0b4yRolh3w1BKUcNALtOqbCtKYdhSmEMGxkrL0YOxlAvbdGzCDY65gT8Jugtg7
 S
X-Gm-Gg: ASbGncsXUyqS656TDpY2c0Un52ss3ublpV+se2QJYbU576XCR6YuPPjN9Nj6KbOWGoq
 M0INRG59uniZEc9atOPkbl+xWW9210AtKZ9RuXGjvM8IuE9ZOTcvQqQRF8Nxv38xRyiR+wDqN4i
 mu2yJ2rdaxHxpA9gm2gNMJzPXKVwLqfp5Ec4pEJXIbnrEDohbPfsRI1xLrfwtxxK9q3BkvMfDA7
 +C9o0K1Lrr81FPWbpQYZgl82NOqDDY3RBDQRA0du2g12TNBZ21+wsZ+WJbqk0KRFLZjCY/dikV2
 tet9nJU2Xl3M9bgwtA==
X-Google-Smtp-Source: AGHT+IF7qg/nAKrRf2bIhKIIaR+koI+Ix4VMnGxIXEdT5Nrhvr5j22A1Wl4ahx+4+d8PloaCKM6x6Q==
X-Received: by 2002:a05:6a21:6004:b0:1ee:e4f0:62a with SMTP id
 adf61e73a8af0-1eee4f008a3mr6193126637.20.1740068010195; 
 Thu, 20 Feb 2025 08:13:30 -0800 (PST)
Received: from grind.. ([187.11.154.120]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254618dsm14074072b3a.26.2025.02.20.08.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:13:29 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/3] target/riscv/kvm: reset all available KVM CSRs in
 kvm_reset()
Date: Thu, 20 Feb 2025 13:13:13 -0300
Message-ID: <20250220161313.127376-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220161313.127376-1-dbarboza@ventanamicro.com>
References: <20250220161313.127376-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

Explictly reset env->mstatus and env->sie. Add a comment about env->mip
being read/written into KVM 'sip' CSR.

We're also not read/writing 'scounteren' which is available in the KVM
UAPI. Add it in kvm_reset() and get/put_regs_csr().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index fea03f3657..ee7a9295b4 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -618,6 +618,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
     KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_GET_CSR(cs, env, scounteren, env->scounteren);
 
     return 0;
 }
@@ -635,6 +636,7 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
     KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_SET_CSR(cs, env, scounteren, env->scounteren);
 
     return 0;
 }
@@ -1609,6 +1611,10 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
     env->pc = cpu->env.kernel_addr;
     env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
     env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
+
+    /* sstatus is read/written into mstatus */
+    env->mstatus = 0;
+    env->sie = 0;
     env->satp = 0;
     env->mie = 0;
     env->stvec = 0;
@@ -1616,7 +1622,9 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
     env->sepc = 0;
     env->scause = 0;
     env->stval = 0;
+    /* sip is read/written into mip */
     env->mip = 0;
+    env->scounteren = 0;
 }
 
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
-- 
2.48.1


