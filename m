Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A666C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HVN-0003gp-B4; Fri, 25 Apr 2025 07:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u8HVL-0003dX-DZ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:46:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u8HVI-0007hf-Ui
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:46:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so13303645e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745581559; x=1746186359; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iOes3K7CPhsSuuyUDXbTsMFDDgK2U71Enz8RrTYu5kg=;
 b=i1lr+5cAbVpyKupwXzB28mxBc6VIpsoz6x13QhJmOhUZefLphQXh/trlsXNosShHow
 o226teQnPkTgk7PKqd/ORWJSaBBlbuTJHelqOzJ/t8KwYDhJot209qpILoEi718AIHAa
 AKdPwfJ/hYB4h5mBXtRezT4TC98E6fSPlhSSRlmluxGIH9p+9RYPwHuhMkAef1UuaUf2
 vgbMW2HlZBzEuw8RWANyCVeznBTtViuFILa2QLzdQxdfhiGBCexCAT6ok7LOwK3a223D
 NshaSEN75TVJ5Y4rkPnLM/tt+qTe8johVhlTnSTc4rWbKwoKWVD7xFIzUnF+S8qM2j1d
 lDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745581559; x=1746186359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOes3K7CPhsSuuyUDXbTsMFDDgK2U71Enz8RrTYu5kg=;
 b=JcEYmoFqz8xGA9RPe5UUs953BBcMVW80mM7KCWcWCMuCeOZGKBG5i4qMgZt6rcphi9
 KUV9Suscr08nYJnzcX5Qc/r5zgXeB+R0a/b139XJJ5kO1aPXbH5m959QjuOe4zbE9vsa
 R7NRhillBrrwcjVss3yjP6mAwQR9uWGw7XberPpuFjYwJ5Mcfyfgh7eOfBx6fJsFbsJK
 MPmopSh4c2QOrOArlrrG3Md0zYJYSo9Be7s0qLb0B2VLkN1bev8d7ZSObI0+dWaxRgiT
 JCobzjBlZkrQdabm6z8xZhy+A2ct+EfTV5P7W7x6/hBHISR1HW+g9nz3FhHy+4jGaOEM
 N3MQ==
X-Gm-Message-State: AOJu0YyRNgYJ0V9QVWfn4J6PTe8CQQv7yiUpRBwk8ON55b/I2x3mw6id
 Ks3ktBRZ+UujeYKO9QA360Sv5+SyuZRqmd6M+yHd+/4Fyy9hnxR9tQVys9royQM=
X-Gm-Gg: ASbGncsG2wmAo6q7G3ScyLE0rBACzDMNd8lDu0kFFVCBY4YggziAfSW8aGfYswm38kM
 DYAUfN0yzTabpBKu1BWMJISW5SInQNWyh4rXFXUuQVIah8cJgfRvWeAeot1xeKTm0X7ijLWA5SL
 jFqXFbwKUtECfGFu1VrJnYjClfpnabmaHnz2kZJIeIRL6CHbwpqGjkm4pBQSSLw9YRDWmx4askl
 B+O8+Vb2m1G9WezINbruQW/YL8rkT0PQJ4OFdS4fVSjey2WFadxyzYQ7vvO48ZLj3FRx52MkYOx
 qatNuYg/9XwY0nkvVUGnQ+wS5AJM
X-Google-Smtp-Source: AGHT+IFOCp09BDW9AEdgFUoiokiuizc3KzySIzwcmHPPAqyKpt4TD9AQ0V6+opbrFOF31BORzdMk3Q==
X-Received: by 2002:a05:600c:b8f:b0:43c:f597:d582 with SMTP id
 5b1f17b1804b1-440a65ba234mr15445135e9.1.1745581558847; 
 Fri, 25 Apr 2025 04:45:58 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e47307sm2135892f8f.65.2025.04.25.04.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 04:45:58 -0700 (PDT)
Date: Fri, 25 Apr 2025 13:45:57 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH v2 3/9] target/riscv/kvm: turn u32/u64 reg functions in
 macros
Message-ID: <20250425-b84985838e1b75c6bf1cc189@orel>
References: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
 <20250425113705.2741457-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425113705.2741457-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x333.google.com
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


sed s/in/into/ <<<$SUBJECT

On Fri, Apr 25, 2025 at 08:36:59AM -0300, Daniel Henrique Barboza wrote:
> This change is motivated by a future change w.r.t CSRs management. We
> want to handle them the same way as KVM extensions, i.e. a static array
> with KVMCPUConfig objs that will be read/write during init and so on.
> But to do that properly we must be able to declare a static array that
> hold KVM regs.
> 
> C does not allow to init static arrays and use functions as
> initializers, e.g. we can't do:
> 
> .kvm_reg_id = kvm_riscv_reg_id_ulong(...)
> 
> When instantiating the array. We can do that with macros though, so our
> goal is turn kvm_riscv_reg_ulong() in a macro. It is cleaner to turn
> every other reg_id_*() function in macros, and ulong will end up using
> the macros for u32 and u64, so we'll start with them.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6ba122f360..c91ecdfe59 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -58,6 +58,12 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
>  
>  static bool cap_has_mp_state;
>  
> +#define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
> +                                         type | idx)
> +
> +#define KVM_RISCV_REG_ID_U64(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U64 | \
> +                                         type | idx)
> +
>  static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type,
>                                   uint64_t idx)
>  {
> @@ -76,16 +82,6 @@ static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type,
>      return id;
>  }
>  
> -static uint64_t kvm_riscv_reg_id_u32(uint64_t type, uint64_t idx)
> -{
> -    return KVM_REG_RISCV | KVM_REG_SIZE_U32 | type | idx;
> -}
> -
> -static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
> -{
> -    return KVM_REG_RISCV | KVM_REG_SIZE_U64 | type | idx;
> -}
> -
>  static uint64_t kvm_encode_reg_size_id(uint64_t id, size_t size_b)
>  {
>      uint64_t size_ctz = __builtin_ctz(size_b);
> @@ -119,12 +115,12 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
>      kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
>                             KVM_REG_RISCV_CONFIG_REG(name))
>  
> -#define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER, \
> +#define RISCV_TIMER_REG(name)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_TIMER, \
>                   KVM_REG_RISCV_TIMER_REG(name))
>  
> -#define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, idx)
> +#define RISCV_FP_F_REG(idx)  KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_F, idx)
>  
> -#define RISCV_FP_D_REG(idx)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_FP_D, idx)
> +#define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, idx)
>  
>  #define RISCV_VECTOR_CSR_REG(env, name) \
>      kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
> -- 
> 2.49.0
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

