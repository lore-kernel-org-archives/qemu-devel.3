Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E2FC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 12:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Hmj-0002vB-8j; Fri, 25 Apr 2025 08:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u8Hmg-0002sK-PZ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:03:58 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u8Hme-0001fs-Vm
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:03:58 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso1584441f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745582635; x=1746187435; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zJR8yi3hbw3Q6j3g2Hmlrb3ZfGm19J3qQeE/6YRi7vg=;
 b=oIcQ/u/+5JjKmAKkhjql3qYozyjNBxSeyxBlXepkSj7Tpuy9hDUT/5pdrxjqaQvVoh
 lqheLQ+/t9mdwXLwTF/rTcCk5/JWYP5DUdCEiqW/1rzoHRqtdr3eHspi/Eve+VkxcBog
 Z6JutzF9p5VbMddby2BAIB49jCnm7/uWVW7kqseyylRyNlt30NZNjd0IMkHMT7691JvF
 EM1dcr+FL1Gb1wfS0Kcbbc+U6MJphTaxH3SIUIb2lfK0LosZeV3jc8TRKuEgOQNWZwyt
 46L8oUz+NB1zFfbOBSWtk1hsXAab682PcbSjum39wW2VqdVU3Q2xFs3H6JmwfYF3g3Gn
 hyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745582635; x=1746187435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJR8yi3hbw3Q6j3g2Hmlrb3ZfGm19J3qQeE/6YRi7vg=;
 b=Lwt1DgEH/abnLAjxvAQIhFdklrfwT85lx5iWs9FnLAjVRBlKpbMG+xZ4qqpi6qGlN/
 4bCXNsizNfSc8jONBNOBHhs1riu/Z9AQoKd/XlZ7jxKXlQI32UeeEPMjyacrqmX0KEzc
 7Ax2xEq1hNN6hkpQG0UD55PXVR1yNA5h9TxOflQVI+diOEYo57B1nw7qZOOWSOHVCgAo
 XUth5FSJ8sZM+CJkM3wumwudv7D0qyoM3aFLHm42qfL1HFVQyWd73exEehZhrcIu/iYN
 7CMDtzOzaDcIs2sPyalODS+7fM+io1o9YPlP0H195Jgm6nG9waudLT3Bis0n3yOKTbKD
 Ypwg==
X-Gm-Message-State: AOJu0Yw33Av2yCuf1bLzYGDkIsgZFQJDkjjBtAMjx3cBuwo6RC41q6Ve
 boUuhVQMJ5YHB4m6HM50v8uk3H6hSk6FX5hdD+GmLy/jVkGsWlHAK4pvBJYd5iY=
X-Gm-Gg: ASbGncvYkeNwz0+QHgfs0LJGGIDFs8U5L9MkrqIKKkdF1GjD09OGzLDor6FwR6SkxLw
 Qkcn8p9//Y4XookkaiBca+MqUqamgOtqale/UNIP+a4fFoTuOGIcfy7Cm2xpCNTh0PaU2UYNvG9
 sqIKeyX7DhrKQa0SAzIW2IPuy15oHshSjkHdA4i8bUYTrGP+8tEf6FIPFxZZaQuR+pSwKA8W70D
 FMCZmxXWvEAzAzsXJiH37XywGfH6wdlrHtXeyhVwcceuOukMOx1v5xoxUzjs98jCEgQM5SZh9QU
 XJM54BaOsS6UPcnPOoXAmTpP/9QE02KqbWgBu24=
X-Google-Smtp-Source: AGHT+IFcqIQOS6TwKooRooiWFYjSz9Yk61vMsZaSXRTIzrnsEdgrd/VX6evzTfMmi+yTU4H3llaEsQ==
X-Received: by 2002:adf:e6cb:0:b0:39e:f9e8:d083 with SMTP id
 ffacd0b85a97d-3a074f852a7mr1233367f8f.50.1745582634883; 
 Fri, 25 Apr 2025 05:03:54 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46976sm2171311f8f.63.2025.04.25.05.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 05:03:54 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:03:53 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH v2 7/9] target/riscv/kvm: add senvcfg CSR
Message-ID: <20250425-88d2d0e9f009c84db9b695d1@orel>
References: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
 <20250425113705.2741457-8-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425113705.2741457-8-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42f.google.com
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

On Fri, Apr 25, 2025 at 08:37:03AM -0300, Daniel Henrique Barboza wrote:
> We're missing the senvcfg CSRs which is already present in the
> KVM UAPI.
> 
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index f341085ba1..e37fa38c07 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -249,6 +249,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
>      KVM_CSR_CFG("stval", stval, RISCV_CSR_REG(stval)),
>      KVM_CSR_CFG("sip", mip, RISCV_CSR_REG(sip)),
>      KVM_CSR_CFG("satp", satp, RISCV_CSR_REG(satp)),
> +    KVM_CSR_CFG("senvcfg", senvcfg, RISCV_CSR_REG(senvcfg)),
>  };
>  
>  static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
> @@ -698,6 +699,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
>      env->stval = 0;
>      env->mip = 0;
>      env->satp = 0;
> +    env->senvcfg = 0;
>  }
>  
>  static int kvm_riscv_get_regs_fp(CPUState *cs)
> -- 
> 2.49.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

