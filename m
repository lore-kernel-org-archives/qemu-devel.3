Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E35DC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9mSd-00077A-Um; Tue, 29 Apr 2025 11:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u9mSX-00073o-Mf
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:01:21 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u9mSV-0000Gb-Rh
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:01:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so5177644f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745938878; x=1746543678; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+cMJfChjBSBP2ccnqJVsUfxZYMhTeyHWd6pJNZd1f+Q=;
 b=AnjUM93PLlUKN0TsfXP0bQKHmwr4CLRdOgEt5WBEwsnbYCq1lLyVosGZu6dXJxgPLl
 /9YuZCrwwIItQS7yLKzf4IeiwylpGTUJtNVk/1cL3dOf4/RCpug2yqgpYXb1yeKAqC5X
 8mRxE3BKd+fpARAS7TupprMpIAD0OgpwplBPdCFH6j+7NCD7piAUU78/qGvWIoh+kL1g
 buoIE4cwh37T2qe5dBj+NvBimV1nBZ6DS6/sRkFKpSJj9nZ2bk5nYkxVr6leeo98QILq
 ASKseM//Hn8yVN3pD5MIRX+F/WVF1Wi7BiH8ELk9fJlNGEIf3qfYLiTgJa8Baq1fie7k
 g3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745938878; x=1746543678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cMJfChjBSBP2ccnqJVsUfxZYMhTeyHWd6pJNZd1f+Q=;
 b=wGI3eM941YutzMVQMmLJAqWzOMZgeMU/mGdskOwA97O3nDYPe4w6ayRnRjSFV7ni5X
 2Rj2898sOtPtwnB8bqyYP6Z+ltfIZvtiCEzRDjy4KRJd4BJKZssjQlNjM/kb0qs5RR2e
 ePngVSb7XV5ns5qWUMCMspSC/LsTZmp2iSy65JyfyMdu7OL1E8kaUAL+Rrer4tX61jUv
 d5KxuL+KlnfDA/sOjQkTXzmRvN978H5+dn3zSBgZOXD+Bfb5DRatFKPS6O52Z08+scAZ
 QZDhH1vi/HWvfD7OxCPxnMYycHvL0wcmhWR1VJal4VuE25eZR6/0ZFBDRwAEWEnJmXcC
 BFEg==
X-Gm-Message-State: AOJu0YxXpUGl9f0S77SPS7NCn9gQ54TQTfRUO8VhDSXYm2ERBZjXeD1h
 Cda5TTytjEX7PEFlaPVz5CmUwAq5aEySxGT42EYlGS7EOcqZUqvnbTp015wtJJQ=
X-Gm-Gg: ASbGnctAxOBziKv7TPacK35ObMFaNLkZx9gGOpiifT4LUVW1rkvcJw3uLzJz5/sQk3F
 S9UDfxIifnYpyT8RNHKyEaSlOtui/q8aTTlcVIzvNO31FovZbGWE0E3pqH+ouELlPky8Pt6qlR2
 1+5y4sFOjgVyakc1H8pBaEP9M1+O81bOkdMB75udZjM7dj1GCkPB4FDXs3VXFXa/+p3meX8kicO
 DdzNNRnxm3bkHgLrX/F2d1HBzNcH04owDW5RQnaICnZMRQmMGuZScdncTyE0C/80fhWTIKOyXKu
 ooOoZZAbilY1iMRbFJFfe1m08zkV
X-Google-Smtp-Source: AGHT+IEFyIJdyAkmt2+nZ8oQ4niYy0tHwpRBw2ajAfhbQz9aif+YKpAcD0ShcDJSJewFpg7s/qlshQ==
X-Received: by 2002:a05:6000:420a:b0:39c:f0d:9146 with SMTP id
 ffacd0b85a97d-3a08ad779f7mr2813635f8f.45.1745938876995; 
 Tue, 29 Apr 2025 08:01:16 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46869sm14207678f8f.72.2025.04.29.08.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 08:01:16 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:01:15 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Subject: Re: [PATCH v5 8/9] target/riscv/kvm: read/write KVM regs via env size
Message-ID: <20250429-a0df0d9ceb3eb53328bf909b@orel>
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
 <20250429124421.223883-9-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429124421.223883-9-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x431.google.com
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

On Tue, Apr 29, 2025 at 09:44:20AM -0300, Daniel Henrique Barboza wrote:
> We're going to add support for scounteren in the next patch. KVM defines
> as a target_ulong CSR, while QEMU defines env->scounteren as a 32 bit
> field. This will cause the current code to read/write a 64 bit CSR in a
> 32 bit field when running in a 64 bit CPU.
> 
> To prevent that, change the current logic to honor the size of the QEMU
> storage instead of the KVM CSR reg.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5efee8adb2..d55361962d 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -135,6 +135,7 @@ typedef struct KVMCPUConfig {
>      const char *description;
>      target_ulong offset;
>      uint64_t kvm_reg_id;
> +    uint32_t prop_size;
>      bool user_set;
>      bool supported;
>  } KVMCPUConfig;
> @@ -237,6 +238,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
>  
>  #define KVM_CSR_CFG(_name, _env_prop, reg_id) \
>      {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
> +     .prop_size = sizeof(((CPURISCVState *)0)->_env_prop), \
>       .kvm_reg_id = reg_id}
>  
>  static KVMCPUConfig kvm_csr_cfgs[] = {
> @@ -646,9 +648,9 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>              return ret;
>          }
>  
> -        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
> -            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
> -        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
> +        if (csr_cfg->prop_size == sizeof(uint32_t)) {
> +            kvm_cpu_csr_set_u32(cpu, csr_cfg, (uint32_t)reg);
> +        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
>              kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
>          } else {
>              g_assert_not_reached();
> @@ -671,9 +673,9 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>              continue;
>          }
>  
> -        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
> +        if (csr_cfg->prop_size == sizeof(uint32_t)) {
>              reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
> -        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
> +        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
>              reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
>          } else {
>              g_assert_not_reached();
> -- 
> 2.49.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

