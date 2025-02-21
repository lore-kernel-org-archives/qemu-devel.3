Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53C3C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlOXT-0006dm-7h; Fri, 21 Feb 2025 03:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlOXR-0006bs-08
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlOXP-0001BU-3e
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:36 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38de1a5f039so1551708f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 00:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740127053; x=1740731853; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1rGPbfcy/xIAluf2Och4444kyuNn2+vPPgTl1UY91QU=;
 b=ZkpiOGmr9V8KKix/fft+Kb3qDstSexsPjLm4OWt8UsJByj3zlbJkujA1NSGpEoDSfJ
 5pmaU2pmXc3SYnkn9lkg3JZ9moV4TpmmRrrNGNaOzkWsJnzS6L38EjBVweKFsgeI5gZz
 tssgZ/TUG/M8GkXNyrxdB5Ku/rs3JyHGysqVIBCQknMamMSBcYdsbgrPaK8KruS3ZAXz
 YZ7G/EvTdTWix1AQuMSQg/nBWe76AWmSmfPkOhtfj35Tbbx01yvnFmg36otGg+Xg7jXv
 lsezctmISVeDB/d9og01Y+73ITEhEqxfalrfSkO1D09jbmHEzDTWWgIgVkraCnbrxnjw
 pUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740127053; x=1740731853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rGPbfcy/xIAluf2Och4444kyuNn2+vPPgTl1UY91QU=;
 b=ooD/HSC7WKdMMNbbPCZjZASL6GY5oOr45fFrnPGxUeVyHTAmDkJGRUZyiIYzKIhwqy
 EM9YflncTaJUObco6SR0irYP8Jc0m/jp43e2Q+cG3cmdOwNirdooQZr6TyUVOozQd2Hf
 CxO4MPDlrqRWA5WwwZ3Cuw6/+8BishG3/TkUXB43M+dwwMjA7UoGfs40XWGgaX+yloT6
 lZvv/qHmJeosbm40UVPLP9evqiCUL3XeJl5FRIQ63xxG8dkexZEwRWr/eL0+pmPQlr1b
 wcLCcsw2VJfNjN2dKtguzdDFGKy68Uyd/2tnbKLJ8einxUAuVGdHMKNo8AwjX+XqRmTK
 0IdA==
X-Gm-Message-State: AOJu0YyxGx6PBpcoqg+zqdZ90hE2iO4oapMQCM4nya3bbs71XY6TrioP
 OfpiphTQmkiagvm1T309gtKIZlwlbaRpeI33Rtgoillm7UsA7vL1lvLuxz0AVK4=
X-Gm-Gg: ASbGnctVke6IbXbtkAmHTpc5fLk5KmmbihIFgawwVOG0Mb6UCxgSRdWW/7F79wbasya
 HRvsT4nsvFTxzP81TXVwmfFCp14W3L3V2+uGWXm15iUOP76uUsSfMdFwu1SPTPb8cWvcwz160t+
 j9qgx80XekmfF2m8XHOM/0UmCbYmTwU+h28EzTTK4WNZFO3TsFeTeBRWmEs0CBCmry95uK1hvg4
 YCZLOFfVeYCt29TBMIrDYKaMz91+bsHy0PtQv+1a8gpubuS4dbDX5RsaayfOEimvhdcJE5r+5kh
 poQBms1pPPGcSQ==
X-Google-Smtp-Source: AGHT+IEzm2UqUYw3PWtWVyHC4jaliWCj1DZk7UTZuVjD6KBtehPILRk0j6G+bj0YuEFOq8yTwfHnLA==
X-Received: by 2002:a05:6000:178f:b0:38c:5cd0:ecf3 with SMTP id
 ffacd0b85a97d-38f6e756a90mr1913930f8f.11.1740127053278; 
 Fri, 21 Feb 2025 00:37:33 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f23c2sm10260895e9.17.2025.02.21.00.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 00:37:32 -0800 (PST)
Date: Fri, 21 Feb 2025 09:37:32 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 2/3] target/riscv/kvm: use env->sie to read/write 'sie' CSR
Message-ID: <20250221-770a4da9465046f4fae9dc20@orel>
References: <20250220161313.127376-1-dbarboza@ventanamicro.com>
 <20250220161313.127376-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220161313.127376-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x433.google.com
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

On Thu, Feb 20, 2025 at 01:13:12PM -0300, Daniel Henrique Barboza wrote:
> Using env->sie is clearer than using env->mie.

Maybe? Just as sstatus is a subset of mstatus, sip and sie can be
subsets of mip and mie. However, the AIA can change sip/sie so they
no longer alias mip/mie, which is why we have 'mvip' an 'sie' members
in CPURISCVState. In the end, for KVM, it doesn't really matter since
this is just s/r storage. I'd probably just drop this patch and keep
using mie. Otherwise, what about mip?

Thanks,
drew

> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 484b6afe7c..fea03f3657 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -610,7 +610,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>      CPURISCVState *env = &RISCV_CPU(cs)->env;
>  
>      KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
> -    KVM_RISCV_GET_CSR(cs, env, sie, env->mie);
> +    KVM_RISCV_GET_CSR(cs, env, sie, env->sie);
>      KVM_RISCV_GET_CSR(cs, env, stvec, env->stvec);
>      KVM_RISCV_GET_CSR(cs, env, sscratch, env->sscratch);
>      KVM_RISCV_GET_CSR(cs, env, sepc, env->sepc);
> @@ -627,7 +627,7 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>      CPURISCVState *env = &RISCV_CPU(cs)->env;
>  
>      KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
> -    KVM_RISCV_SET_CSR(cs, env, sie, env->mie);
> +    KVM_RISCV_SET_CSR(cs, env, sie, env->sie);
>      KVM_RISCV_SET_CSR(cs, env, stvec, env->stvec);
>      KVM_RISCV_SET_CSR(cs, env, sscratch, env->sscratch);
>      KVM_RISCV_SET_CSR(cs, env, sepc, env->sepc);
> -- 
> 2.48.1
> 
> 

