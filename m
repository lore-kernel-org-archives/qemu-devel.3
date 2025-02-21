Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12A3C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlSPH-0004Ji-Lm; Fri, 21 Feb 2025 07:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlSP6-0004EW-3L
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:45:22 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlSOv-0001aG-0S
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:45:07 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f31f7731fso1032530f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740141903; x=1740746703; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AlHmfew6mJon304VdZYxG1YyGTsjIeTLnY1/4AtNcq4=;
 b=UDNbJSUmthcN/I8u0ucstVs1/9IxElz9pvvXdjbh0EILiNFW79Uzi8xyWHKR/z/dnA
 et+MbSFEulzkyy5l+4QTohczI2CnEN49PKS1PPUevEgEiUGv75hJIOiVK6Q+eRK165nu
 E2RUWV6TAkHoZOmHuHBl9wg2hUfhK1ug49VbDghYjJh47P/foTsgaB5h7Fnrzdb3mOI3
 oOBSn9iEYxPlwAcyxytizT6QsC0Eh98Tr5JigBvnE3sG+V9wSujvjALarzX9hdojWGfy
 owoePj4WirH/JeDoH0abie1l1esDWuUSxAe1agEjnSmmGRKayfPHzbfdykBhrIFbCDgY
 VSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740141903; x=1740746703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlHmfew6mJon304VdZYxG1YyGTsjIeTLnY1/4AtNcq4=;
 b=gYXXtUUpQWTDHKU+p96EgmdeyjjWVhNGC/GDrwmbsrvu70B3g2U4Yb1UnMqwDgqcFP
 zJ/WS3P+fDIE3jwMvFPrii8SMdOtxiP11EwveUAdykR1csXjzcrYDvPkzDdB0U52xs63
 SwhOxCTbpgfiD6EwiGLjhgX82pQV8l1flL/IrPQ1HS8cWmI9uQ46zBzlM+ybeq0vA9n1
 r97rlDm2KRTuK1NVl73bDx4yxOrNYjCKyKQqHMPzYwDXSFbnIfRhWNuKTXJENbgWE3WQ
 iRqzMgA5uHt8K/wgbtl32VWNUuQH9uM8WebSAOTHxcu+H9LaYKWJzJeDc4vOCnO6Z63M
 5D+w==
X-Gm-Message-State: AOJu0YwyAMN4KMuFKqd9K3SfHx1yRNfNxELVfD8KcmONV4v0xiaYIDKp
 9Pl/QzDssgF+/2DafnqJu+2tx9R8HBtKGHC54ZeWEbadq72AKa7FIh7Veowrqq8=
X-Gm-Gg: ASbGnctFM4Flo/uKCwSqBht9c3PbdnxyH+zclFVYv07Jvc01+aLbe5hOUd2hWy2t1g4
 bV985kSS0gQIKJABv2qjKv+2Rm3xEcU48bNyou5Y47bq/oF1piF0TeMH/cAVhgQGLAevuRLvyh3
 tYs4VUc+ussqXH0ba3DI0qabNEd52067S0QmikoNAjnM4nm6jTkXi7S5iHDIhvuBhpdzB8QuWN6
 B6e76ASVZujNldzWIMOPE0ij5/emDnZBZ2hR7CzhcnT5md/ZqD1lyzvDgAkFFiViVFbDNKclIIN
 MhI6rLd+U041xQ==
X-Google-Smtp-Source: AGHT+IEsNejglwHljlFJwYChj6+fRqTYUlijuumV11uFTiscFGfinzC/+tuSK7Q7SGktSz1GCoqQbQ==
X-Received: by 2002:a5d:59a3:0:b0:38d:e15e:17e9 with SMTP id
 ffacd0b85a97d-38f6f0b2161mr3500462f8f.35.1740141902849; 
 Fri, 21 Feb 2025 04:45:02 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f5b38sm16348475e9.24.2025.02.21.04.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:45:02 -0800 (PST)
Date: Fri, 21 Feb 2025 13:45:01 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v2 3/3] target/riscv/kvm: add missing KVM CSRs
Message-ID: <20250221-4dff31114d91734968b5a05c@orel>
References: <20250221122623.495188-1-dbarboza@ventanamicro.com>
 <20250221122623.495188-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221122623.495188-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x432.google.com
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

On Fri, Feb 21, 2025 at 09:26:23AM -0300, Daniel Henrique Barboza wrote:
> We're missing scounteren and senvcfg CSRs, both already present in the
> KVM UAPI.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index f14fcc58bb..017ca82226 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -616,6 +616,8 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
>      env->stval = 0;
>      env->mip = 0;
>      env->satp = 0;
> +    env->scounteren = 0;
> +    env->senvcfg = 0;
>  }
>  
>  static int kvm_riscv_get_regs_csr(CPUState *cs)
> @@ -631,6 +633,8 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>      KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
>      KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
>      KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
> +    KVM_RISCV_GET_CSR(cs, env, scounteren, env->scounteren);
> +    KVM_RISCV_GET_CSR(cs, env, senvcfg, env->senvcfg);
>  
>      return 0;
>  }
> @@ -648,6 +652,8 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>      KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
>      KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
>      KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
> +    KVM_RISCV_SET_CSR(cs, env, scounteren, env->scounteren);
> +    KVM_RISCV_SET_CSR(cs, env, senvcfg, env->senvcfg);
>  
>      return 0;
>  }
> -- 
> 2.48.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

