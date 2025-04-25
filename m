Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F84C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 12:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HvN-0007PN-RH; Fri, 25 Apr 2025 08:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u8HvL-0007OV-I3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:12:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u8HvJ-0002mt-LR
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:12:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso2220076f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745583170; x=1746187970; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KsZbVntz61oea4I9vKgPtHvh0FZUfeKMD9DSBLAI6Jg=;
 b=ERuzZmnDjR2BoSvJvgbps67mhQ6D3ykdfp1kFkFnM7AcR4EFd3GlHk6X+qucYgRfLB
 J5sOfIU5IIUXKg/l+Lh4ML7YwEyhbxxARP3EdHvQUKmg1IIkRP/POFBHMpkwVFalfimv
 F2T3FZWLDeSDG663iXkA8wxJTM8Y85ddOL1CbnfUpD+OczUxoXVsLqXnSICfkxzNkA1H
 6AnMZSwZdR4xbqBNtkHX0Pw0221iFkHm2Cy1gZMt3bJVGz4Gu5Dq96rW1oj/hxnQVAt6
 b2MYZlg2uFO6vR7zRC2ROVMMOWMiF8m76A4GBHkBLQDX8gjIWhR4gZoDHuhHxnbeII6r
 ed1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745583170; x=1746187970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsZbVntz61oea4I9vKgPtHvh0FZUfeKMD9DSBLAI6Jg=;
 b=oh7QzOv5wXzPZojpamrO09YXPNMD1evCFqha8JGMWDLWOsUHUge3Iy6z25K9eIEAf9
 qxpHbn8FsyS1874W2RdeLmUpD6wsFiF0hjvRv8ob2Lj4pxIeKkLR5uoFu9PM3S92XcgP
 zKrHaGM5rieEaLAgUGb7RlsXUuHSUgcEn1QpxweTVMQ4jRU3JVQN63hlJWp5P+gem/xt
 kWIM3hvza+pJ74JdewOn8afb7twP+Ysd3Zmv5beQYEMllfvYtBheBJOgImwAtsRNdFL7
 2g+lBfzpum76RrV3FHgNbsLmtG2kgHpE630Kt+8QDvbkWJIx950Y/I5rcwyeK4HxMf6K
 Hojw==
X-Gm-Message-State: AOJu0YytWlYpFzRNJzpEvtCbU5wD16MqvC/uJayqgiYi8hd4LCVUIBT1
 /ipyM0L4cwrzVW9W3jXTDZrMK0sY8UdagzEadtDBeieORLCT7klESmNYvaqekFs=
X-Gm-Gg: ASbGncvp+gXvssqBMeds7U6AZYkDF9Pb2RjjsztoquFymqyCJxq+aGOCBaTWLg+GzPy
 r5SQmukKXtAXlPY6kWb1uqGDdsRdDm+uxXeLwC8/mycU3Xim54wBLHjj8GhoQ32EsN95SLG39ks
 lcy5nC/+4VZcqVnPwqHs3ZcDACQxZIb5KQEoZZmjRhBda98LY3KnoG1ARMsAOduyUqwp1RJDWga
 HC6p/+2+m5VdDt9K3rgR3YewJg9UTjAFdK2De2KienEwc15qqm1PMJSPRwRKjQDE0KBBIhD3xk/
 fECQi8w2S18ofcOjgYGDzL3ir5gz
X-Google-Smtp-Source: AGHT+IFltgaSnu+NQRT8JQTVq/kPwuQUiuq4uDFdzKtnx9c66sFgwltEZpiXzqtTHawaPCsNHclKOQ==
X-Received: by 2002:a05:6000:22ca:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-3a074cf18aamr1529689f8f.8.1745583170182; 
 Fri, 25 Apr 2025 05:12:50 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46538sm2193295f8f.64.2025.04.25.05.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 05:12:49 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:12:48 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH v2 9/9] target/riscv/kvm: add scounteren CSR
Message-ID: <20250425-6bc102914dd39e7896cefdff@orel>
References: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
 <20250425113705.2741457-10-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425113705.2741457-10-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x429.google.com
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

On Fri, Apr 25, 2025 at 08:37:05AM -0300, Daniel Henrique Barboza wrote:
> Now that CPURISCVState::scounteren is a target_ulong, add support for
> the scounteren KVM CSR.
> 
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index e37fa38c07..5db63e78e2 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -250,6 +250,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
>      KVM_CSR_CFG("sip", mip, RISCV_CSR_REG(sip)),
>      KVM_CSR_CFG("satp", satp, RISCV_CSR_REG(satp)),
>      KVM_CSR_CFG("senvcfg", senvcfg, RISCV_CSR_REG(senvcfg)),
> +    KVM_CSR_CFG("scounteren", scounteren, RISCV_CSR_REG(scounteren)),
>  };
>  
>  static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
> @@ -700,6 +701,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
>      env->mip = 0;
>      env->satp = 0;
>      env->senvcfg = 0;
> +    env->scounteren = 0;

Let's keep these in struct kvm_riscv_csr order here and everywhere else
they get listed, like in kvm_csr_cfgs[]

>  }
>  
>  static int kvm_riscv_get_regs_fp(CPUState *cs)
> -- 
> 2.49.0
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

