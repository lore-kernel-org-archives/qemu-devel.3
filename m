Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826CAC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 09:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlOv6-00058B-44; Fri, 21 Feb 2025 04:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlOv4-00057c-4z
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 04:02:02 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlOv2-0004E6-A6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 04:02:01 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-439950a45daso11320465e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 01:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740128518; x=1740733318; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qyWAQhf9ep+xgs8onKwae5E1/HQ/xgzLfE/85LPIDxg=;
 b=BvpPnmYG7rvwk0D6i8HL1LhQub2dfOIdWqymCph3sgWmV0aiOk5hgzow+duv5uqjMD
 1u4MPNKP/+/ZGcpmb5+j+nf0sQL/7CUYAwVCD93X7dQVohkzGt9RUuQcao/aqs/Vgtjf
 J/YpURbFlJst59+IHS69FC8Nh8TLtdKr14qgGQR/rvJXnT4tvB2y319XSab5CIBHQf7u
 Pxow1tPxPigwp0uJ2y5KINLOhKYMOD4B+bUW2YflImp5V6MVI4P/1d8HDTx7hNTPCdah
 G5Cv3OmTe9/KIL4VJbeVx1PQbm9e6ENUegMAGfqXppoTuUb7YUA3QHVM/86D48JpRN66
 FiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740128518; x=1740733318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyWAQhf9ep+xgs8onKwae5E1/HQ/xgzLfE/85LPIDxg=;
 b=DTBhZtpe+LB+wyIqMdboVpfUeIuqFlLDu9Fw7p7MtSib8eJktJWE9NxFVfh48ExETh
 zM9nN9ujtlc3DgxrLTyf8GQjz4ApmKRLMUCyTGa1hPWIru7DbDFJ56pvmLVO7w85RdgG
 a2rzvQdO+Z6ir+eU9q6bzKqg1fRi5BrCh6B3tS4Bai1wV/hgXFJYiCQvYQ415U/8yEZ5
 0SKJnydVA1nBHxOk7c7m1zWNPDx9sAdl76+Yx8sWfqDqLATGcx4xGc3SoJcToLVK+Jiu
 4KeViBW5J2SmRKrbXnFuMEMFeZLnHVjaF8GIsmMa3HNqaFp1DelBKjMfpWHYwmEdqHYi
 OWQw==
X-Gm-Message-State: AOJu0YxZ1+YrgD/OiauwR5M0r4WB72Ld2Ih4ArI+ZQ5gXHoHQUAFbfDi
 O6tLxEgf3RRv86r8xZbogu2EU4dbdbBSc0JaGadS9zHTJQPh3KzMP+/83g1Xk0I=
X-Gm-Gg: ASbGncvEnZXuKzw0EYQi1UNyJpp/AR9oCBkH4QT1Q4mGcrdA8OHR4cgqwovyqpxIxhx
 oefmZqWrKdjO3Rujqeao/QKzZcVXE/ac+JGS6dN0vVgUMmy5M25L0LrOoT6mcgXYlKQWhYzJvWp
 pGS/aJK2m1m6CLadisMRUkzj59et76qwvk1NXEXP7YLvzdQw7UW+LpNdTW5y73mFOMYAM1VVgGp
 zA/vmkwZuvKh6HESED+UVbRhABVtVqfqpa/3ZvRVCmP1UQlui6DypG0usWQgxxndUGD9Vc/XYX3
 5d0cRj9NJy0ZuA==
X-Google-Smtp-Source: AGHT+IHjZ7G76debS3b1xBr7Yn7Iz62YozXMQ0VGZdWkdcj1i2l+TimR0m1UQ0kUHfOROefq+F+Fpw==
X-Received: by 2002:a05:6000:2a8:b0:38f:2a53:1d78 with SMTP id
 ffacd0b85a97d-38f6e759571mr2130924f8f.10.1740128518476; 
 Fri, 21 Feb 2025 01:01:58 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5923sm23005888f8f.74.2025.02.21.01.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 01:01:58 -0800 (PST)
Date: Fri, 21 Feb 2025 10:01:57 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 3/3] target/riscv/kvm: reset all available KVM CSRs in
 kvm_reset()
Message-ID: <20250221-d80c128acaf0210e80461d56@orel>
References: <20250220161313.127376-1-dbarboza@ventanamicro.com>
 <20250220161313.127376-4-dbarboza@ventanamicro.com>
 <20250221-1fab8b0e1e23a31880880f11@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-1fab8b0e1e23a31880880f11@orel>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32b.google.com
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

On Fri, Feb 21, 2025 at 09:45:35AM +0100, Andrew Jones wrote:
> On Thu, Feb 20, 2025 at 01:13:13PM -0300, Daniel Henrique Barboza wrote:
> > Explictly reset env->mstatus and env->sie.
> 
> mie was already getting set to zero, so that should have just been renamed
> in the last patch, but I still think we should drop the last patch.
> 
> > Add a comment about env->mip
> > being read/written into KVM 'sip' CSR.
> > 
> > We're also not read/writing 'scounteren' which is available in the KVM
> > UAPI. Add it in kvm_reset() and get/put_regs_csr().
> > 
> > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > ---
> >  target/riscv/kvm/kvm-cpu.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > index fea03f3657..ee7a9295b4 100644
> > --- a/target/riscv/kvm/kvm-cpu.c
> > +++ b/target/riscv/kvm/kvm-cpu.c
> > @@ -618,6 +618,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
> >      KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
> >      KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
> >      KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
> > +    KVM_RISCV_GET_CSR(cs, env, scounteren, env->scounteren);
> 
> senvcfg is also missing.
> 
> >  
> >      return 0;
> >  }
> > @@ -635,6 +636,7 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
> >      KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
> >      KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
> >      KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
> > +    KVM_RISCV_SET_CSR(cs, env, scounteren, env->scounteren);
> >  
> >      return 0;
> >  }
> > @@ -1609,6 +1611,10 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
> >      env->pc = cpu->env.kernel_addr;
> >      env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
> >      env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
> > +
> > +    /* sstatus is read/written into mstatus */
> 
> How about just a single comment above this function stating that we
> reset all registers that we will s/r with csr get/put. Interested
> parties can go look at get or put to see the mappings.
> 
> > +    env->mstatus = 0;
> > +    env->sie = 0;
> >      env->satp = 0;
> >      env->mie = 0;
> >      env->stvec = 0;
> > @@ -1616,7 +1622,9 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
> >      env->sepc = 0;
> >      env->scause = 0;
> >      env->stval = 0;
> > +    /* sip is read/written into mip */
> >      env->mip = 0;
> > +    env->scounteren = 0;

It'd be nice to put all the above register assignments in the order of
struct kvm_riscv_csr, like get/put do.

Thanks,
drew


> >  }
> >  
> >  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
> > -- 
> > 2.48.1
> > 
> >
> 
> Thanks,
> drew

