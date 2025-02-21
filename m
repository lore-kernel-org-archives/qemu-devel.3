Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DE6C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlODm-0000dX-Mx; Fri, 21 Feb 2025 03:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlODh-0000cJ-N0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:17:16 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlODd-0006sw-7c
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:17:13 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f325dd9e6so915143f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 00:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740125827; x=1740730627; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VJ2O4QlqGIHJZcAki+1tAAOoP8Um3PUVmiLBnfF9/x4=;
 b=pBhyco9Ulr7Vr+dEPiewucXsf5NlnJLR9/aj05rcWATlZkjSsuHkhylYtglwTW1p+9
 nFKY2FAmx3D36z6VwPA9BJU8EscoGacuKvhQf/beUqjAlVTO83zjNLSENqbInd71YMz9
 8cX8SdcpkSjw3MrdfbCnRaKpK1BX5CSyZGY9n5IlHSOvMRmP8XUrRWZNGwW8908PPuua
 HEz+9u/pGyGg4Tb+n1XJHvNKOHnfDKrluTfXQsxc+bM5iXC+8qg4ELsQAszEWrNgC/YE
 Ep+F9tehJ94hQiJi90sNPfoc1aI06mYxk8nfwBWHnwNbv/+7X86HzFNQpW05v0eYi2Fv
 rQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740125827; x=1740730627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJ2O4QlqGIHJZcAki+1tAAOoP8Um3PUVmiLBnfF9/x4=;
 b=HOIeAUM9az8TwIfK/9xqIrf6aJTDQMBBnjEuzTcmDJmPSPvfAe6v6fo3GlvZ18ZDoy
 WLVIq/dexMAAbWyK9Ynl6Vhq/uBv6ddtCBIvG7dHziwUYm8mAA4PvKiOZPtpLewRVlWQ
 e+DmVNYmrOli81wfzdxyQ5HURmqfbj9eerWMnQ99j0vRr4k7NExJl6BYQImVLUe0FFnU
 qV/+6JNbve4rR/jJ2yLtjlJKdV1xROgB0nxbIY8WlsQLvOlwygX6kGyl+SH9vkB9aynr
 eYeE2go5a7pwViICzZocKsiXho98KOGMIBL0thuZtzZM5mIXKo1Ml1M44hDSOZsKlilS
 RAhw==
X-Gm-Message-State: AOJu0YzNP9tAkiZwbomF9f55NBNwqxrE539Q805i09UlL8ts1ypw5UB8
 QK3QMEqbuPDcf4IZxXQ6sXV1jHZWfh5qzRuyHs+Ao7FAZQuOddDm0qrlkPCIDvk=
X-Gm-Gg: ASbGnctozpKowF95hfHnN4PGs5O1+OwzfL51KBXCpMILTTGz+Ce3BxQhxZUvGeU7Qtb
 hqUAzFmg9lHg8D9LYCANnhLoPf43bPj6JgjGS7jMhyR7zGr3EJWsRv0OLo5abZjedWcSsVu6Eco
 TJ2PqpicDtv65Jhmcjmfra3N40iwT0ceLuhVtD4ODLuWcx8fdRUvfwFHh7LV4d1YgyvQo6gtquh
 AwG2A6aK8vpyFIZZRtjLUmsy4PegGd8FG6YCjH6gXM7kfePY8GX2ECOXjcMYvWkNQoHTZpJK9Fy
 JjgUw0vnKwvNSQ==
X-Google-Smtp-Source: AGHT+IFLZXuPzJatWnO2rKvUxAKhpRlgR7D4/8wvBJ0n+r2kqEnQyRZ0gSjwIqkoHsgjSJXMAV9wmw==
X-Received: by 2002:a5d:64ab:0:b0:38f:3735:68e with SMTP id
 ffacd0b85a97d-38f6f0d102fmr1710372f8f.46.1740125827005; 
 Fri, 21 Feb 2025 00:17:07 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f85c2sm23463039f8f.91.2025.02.21.00.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 00:17:06 -0800 (PST)
Date: Fri, 21 Feb 2025 09:17:05 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 1/3] target/riscv/cpu: ignore TCG init for KVM CPUs in
 reset_hold
Message-ID: <20250221-c821005cfd03e3fd07df4817@orel>
References: <20250220161313.127376-1-dbarboza@ventanamicro.com>
 <20250220161313.127376-2-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220161313.127376-2-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x434.google.com
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

On Thu, Feb 20, 2025 at 01:13:11PM -0300, Daniel Henrique Barboza wrote:
> riscv_cpu_reset_hold() does a lot of TCG-related initializations that
> aren't relevant for KVM, but nevertheless are impacting the reset state
> of KVM vcpus.
> 
> When running a KVM guest, kvm_riscv_reset_vcpu() is called at the end of
> reset_hold(). At that point env->mstatus is initialized to a non-zero
> value, and it will be use to write 'sstatus' in the vcpu
> (kvm_arch_put_registers() then kvm_riscv_put_regs_csr()).
> 
> Do an early exit in riscv_cpu_reset_hold() if we're running KVM. All the
> KVM reset procedure will be centered in kvm_riscv_reset_vcpu().
> 
> While we're at it, remove the kvm_enabled() check in
> kvm_riscv_reset_vcpu() since it's already being gated in
> riscv_cpu_reset_hold().
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 9 +++++----
>  target/riscv/kvm/kvm-cpu.c | 3 ---
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 522d6584e4..8e6e629ec4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1050,6 +1050,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>          mcc->parent_phases.hold(obj, type);
>      }
>  #ifndef CONFIG_USER_ONLY
> +    if (kvm_enabled()) {
> +        kvm_riscv_reset_vcpu(cpu);
> +        return;
> +    }
> +
>      env->misa_mxl = mcc->misa_mxl_max;
>      env->priv = PRV_M;
>      env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
> @@ -1146,10 +1151,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>          env->rnmip = 0;
>          env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
>      }
> -
> -    if (kvm_enabled()) {
> -        kvm_riscv_reset_vcpu(cpu);
> -    }
>  #endif
>  }
>  
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 23ce779359..484b6afe7c 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1603,9 +1603,6 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
>      CPURISCVState *env = &cpu->env;
>      int i;
>  
> -    if (!kvm_enabled()) {
> -        return;
> -    }
>      for (i = 0; i < 32; i++) {
>          env->gpr[i] = 0;
>      }
> -- 
> 2.48.1
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

