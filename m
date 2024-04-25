Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6610DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s01UQ-0000v1-1R; Thu, 25 Apr 2024 11:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s01UL-0000tr-N9
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:58:23 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s01UJ-00035o-Ei
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:58:21 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e1baf0380so1616908a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1714060697; x=1714665497; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UTZfElggRQI9RVrbzMFzSRyoL6921zaZnVqvfBJHiQA=;
 b=i6jBTVf/IWEWnToTId1WE0xjquZ9vOQKX9hyxm+DHA4VV6y5I1XMh7m85jQit4QpMa
 pf5gL6eCYIwbCcNpwher1lpWzdLKCEvNItbVvhWr3V26hvCitax81ZeFNPlu6zG4KQNw
 vawzFYWOvtc4AWWUhOn2iujsw1ueqEuoHjQ5A7i3fnCppdXjjVJOUIIFE43KdqUrdqAS
 ZetnmHCrqDiOC8rnSc3HBEym1SNcSA3gweT5m3nbkCXtUjZ61CezXrhzmgIQYJ8CVecy
 b4nEOnO8Hk8/lY2lkIs6l5ecjEndqiaIGQV9uyEyAfaRX13e0DwaRvJNO96AvGABA0h/
 gCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714060697; x=1714665497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTZfElggRQI9RVrbzMFzSRyoL6921zaZnVqvfBJHiQA=;
 b=cjvo25abDpe0418qg1i+Z33IAxT/9GYnUpiDHT8/vSpnOsJexsoaXhhEkBeoE8yixh
 NchaAvE7maOfV/W2UtVDFN63v6yxaG/eZ1PXWbGBd7mXAIkeqHxsnMLyJqh++OJ/laLp
 kOEVT9PvHva11g+3Qg3GMjGZm/BdFLEeJvrqaP3qdG7b7FjWr89rwin/NMjQdAXFbMpQ
 uef1M4wzLyRIL6EtES7ve2I5F0hN7Ldug+CnY2vBRXFLacmLIu57WuCjHkbRFotflw2E
 mw2fDR04gZjVr+O08WATUIJIEwn8MeNB7Buv/ycf+aN1eQDcWiNJVng+28q2PRFTY698
 Itng==
X-Gm-Message-State: AOJu0Ywa0rRS2tlduYRbwgbYDy4eV/TzO6LWB7Wko71fXOHDwon6if/p
 3nTOOPHf0rPQy7/eh6P0gpWoNsF4e5i+J+EajIFGp/SVh/HNbAOKiZN6WstMPw0=
X-Google-Smtp-Source: AGHT+IFTeGe60j3tU1iI7FHg6jBs3UDW0lQrVMjcPpggiY4usD81BE6auY3pdP74sqEdM61GsDRmzw==
X-Received: by 2002:a17:906:145a:b0:a52:2d83:1483 with SMTP id
 q26-20020a170906145a00b00a522d831483mr85187ejc.53.1714060696790; 
 Thu, 25 Apr 2024 08:58:16 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a1709070b1100b00a558206b2c5sm8516279ejl.99.2024.04.25.08.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 08:58:16 -0700 (PDT)
Date: Thu, 25 Apr 2024 17:58:15 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v2 1/1] target/riscv/kvm: tolerate KVM disable ext errors
Message-ID: <20240425-92aa48159348b26bbae5edbc@orel>
References: <20240422171425.333037-1-dbarboza@ventanamicro.com>
 <20240422171425.333037-2-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422171425.333037-2-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x533.google.com
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

On Mon, Apr 22, 2024 at 02:14:25PM GMT, Daniel Henrique Barboza wrote:
> Running a KVM guest using a 6.9-rc3 kernel, in a 6.8 host that has zkr
> enabled, will fail with a kernel oops SIGILL right at the start. The
> reason is that we can't expose zkr without implementing the SEED CSR.
> Disabling zkr in the guest would be a workaround, but if the KVM doesn't
> allow it we'll error out and never boot.
> 
> In hindsight this is too strict. If we keep proceeding, despite not
> disabling the extension in the KVM vcpu, we'll not add the extension in
> the riscv,isa. The guest kernel will be unaware of the extension, i.e.
> it doesn't matter if the KVM vcpu has it enabled underneath or not. So
> it's ok to keep booting in this case.
> 
> Change our current logic to not error out if we fail to disable an
> extension in kvm_set_one_reg(), but show a warning and keep booting. It
> is important to throw a warning because we must make the user aware that
> the extension is still available in the vcpu, meaning that an
> ill-behaved guest can ignore the riscv,isa settings and  use the
> extension.
> 
> The case we're handling happens with an EINVAL error code. If we fail to
> disable the extension in KVM for any other reason, error out.
> 
> We'll also keep erroring out when we fail to enable an extension in KVM,
> since adding the extension in riscv,isa at this point will cause a guest
> malfunction because the extension isn't enabled in the vcpu.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6a6c6cae80..03e3fee607 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -427,10 +427,14 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
>          reg = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
>          ret = kvm_set_one_reg(cs, id, &reg);
>          if (ret != 0) {
> -            error_report("Unable to %s extension %s in KVM, error %d",
> -                         reg ? "enable" : "disable",
> -                         multi_ext_cfg->name, ret);
> -            exit(EXIT_FAILURE);
> +            if (!reg && ret == -EINVAL) {
> +                warn_report("KVM cannot disable extension %s",
> +                            multi_ext_cfg->name);
> +            } else {
> +                error_report("Unable to enable extension %s in KVM, error %d",
> +                             multi_ext_cfg->name, ret);
> +                exit(EXIT_FAILURE);
> +            }
>          }
>      }
>  }
> -- 
> 2.44.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

