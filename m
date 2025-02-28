Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C274C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to0Ug-0007RR-Nf; Fri, 28 Feb 2025 08:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1to0UY-0007PU-QY
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:33:31 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1to0UR-0003Hl-Ne
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:33:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso13549705e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 05:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740749596; x=1741354396; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aDunVQWwNW7VC09jfEEoUzT5xw1HesdU3D9g2CzzH/I=;
 b=nsXushVIu22HI9O099GrOpLgF7ABs7uI1lLMtEPznsRnp4T4dW2+InBh01yLfiAS0j
 Qn/26Ol0It49gfJ3Sbv8DW1ZqzKay4NoIVyJIxIRHe7/bzzNzafR38DB0m8P+bkwKdz+
 HlN2qsFc3szGVMGloqNLgN+AsbgDWfA6SCmVXQPSJQbkoXBWDDvMdd46jeb7BFbgXZ5j
 fO5Bi1+c8TXwo4UDVC5lx/p5ZsawN5+OrHak8EaaRwL2gqv0SqwhB69/Ce+Pb+6zNPGp
 6CKbtnwKEkom0+4FiMB1HGvi6F9ytE+t6xezzzmyDyCFooMc/GKOEn0SV4OmbrLRMO7g
 e7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740749596; x=1741354396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDunVQWwNW7VC09jfEEoUzT5xw1HesdU3D9g2CzzH/I=;
 b=fGntdJdKwpdp/yGt5sR1spu3nUGm/GTDI44t3PduZGlnvKgLEUOyUeom5ps3UwV1py
 Jegdjr9USyBLcJDcY7OmaLD96xnxB+cAMedzTOPSfVX2E1ibsN0CULTeK9e0A7z4MnOz
 eytRgvMn1IRuYbiIKSpfxHUH3AaSgWam9WK+q5rG6J8aN3X3GYm0oJ0sMyLBKKQRvMOW
 J/L3JJ1xzh0W1AUiRKw2jfL7HW1LyyfmLEz4PpQy3NosVWiDAIysUyxuOj6ALkAUYZ7b
 GNBbnMEOVKrSsfRUJdsHUvooPsoUHcaOzrfrRVWJPmjJ6Zi9JEfwDC8/lXj9I6odamWr
 clpQ==
X-Gm-Message-State: AOJu0YyrjQQAkbHfFRf64Xc7uWwxkXDUxdX4oevnMBzCwNFMcvkd15g8
 Po9FRb5IegAyMk1IQ1KjKYVHODIs5h5NSpeftoq+KNWF5rxXwdDxJKsKVTufk/I=
X-Gm-Gg: ASbGncsk0xAM+3xAAh0e7nW7/RPtxMKc2jgTt8+KTzIieVFWbNHs9r3mal2sS+iBGDl
 eM48EKOXX+KI6GmMZtcH2wzkveC8nJ+B/jkCcPfNtkG/a06kS3R37P7eQugo5EKgI6/WNQaVi8S
 1h4le4bH8r/TmpNAv+oHNSGBgHMchs8tdc32HmyUA7PWPijUUXiUSYZumIe1XgocNk/IOoAe12V
 Jg3CwEFcRYiLBvn2Mad8W6GzMnr6nc8xcl7kPyRoAnYoTqD+wA6cyJnI2Nuwcp9I+BwbK4XVQz8
 aJHgNtmMsbT4LA==
X-Google-Smtp-Source: AGHT+IFAlnC/dUIv5d+Yarpg28X7ZIDP5qSwenuRlxBS8JqU6gH2bOKJtymuKmuLg2EI6UZRI9Q7yw==
X-Received: by 2002:a05:600c:1548:b0:439:685e:d4c8 with SMTP id
 5b1f17b1804b1-43ba66fec18mr30150455e9.15.1740749596123; 
 Fri, 28 Feb 2025 05:33:16 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5711fcsm92605425e9.28.2025.02.28.05.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 05:33:15 -0800 (PST)
Date: Fri, 28 Feb 2025 14:33:14 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v2 7/8] docs: update the description about RISC-V AIA
Message-ID: <20250228-2444e574d55bf88c1427e28b@orel>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
 <20250224082417.31382-8-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224082417.31382-8-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x332.google.com
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

On Mon, Feb 24, 2025 at 04:24:14PM +0800, Yong-Xuan Wang wrote:
> Add the description about "-accel kvm,kernel-irqchip=off" into
> docs/specs/riscv-aia.rst and docs/system/riscv/virt.rst.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  docs/specs/riscv-aia.rst   | 24 ++++++++++++++++++------
>  docs/system/riscv/virt.rst | 10 ++++++----
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/docs/specs/riscv-aia.rst b/docs/specs/riscv-aia.rst
> index 8097e2f89744..38797cca4998 100644
> --- a/docs/specs/riscv-aia.rst
> +++ b/docs/specs/riscv-aia.rst
> @@ -25,11 +25,16 @@ When running KVM:
>  - no m-mode is provided, so there is no m-mode APLIC or IMSIC emulation regardless of
>    the AIA mode chosen
>  - with "aia=aplic", s-mode APLIC will be emulated by userspace
> -- with "aia=aplic-imsic" there are two possibilities.  If no additional KVM option
> -  is provided there will be no APLIC or IMSIC emulation in userspace, and the virtual
> -  machine will use the provided in-kernel APLIC and IMSIC controllers.  If the user
> -  chooses to use the irqchip in split mode via "-accel kvm,kernel-irqchip=split",
> -  s-mode APLIC will be emulated while using the s-mode IMSIC from the irqchip
> +- with "aia=aplic-imsic" there are three possibilities.
> +    - If no additional KVM option is provided there will be no APLIC or IMSIC emulation
> +      in userspace, and the virtual machine will use the provided in-kernel APLIC and
> +      IMSIC controllers.
> +    - If the user chooses to use the irqchip in split mode via
> +      "-accel kvm,kernel-irqchip=split", s-mode APLIC will be emulated while using
> +      the s-mode IMSIC from the irqchip.
> +    - If the user disables the in-kernel irqchip via "-accel kvm,kernel-irqchip=off",
> +      both s-mode APLIC and IMSIC controller will be emulated.
> +
>  
>  The following table summarizes how the AIA and accelerator options defines what
>  we will emulate in userspace:
> @@ -75,9 +80,16 @@ we will emulate in userspace:
>       - in-kernel
>       - in-kernel
>     * - kvm
> -     - irqchip=split
> +     - kernel-irqchip=split
>       - aplic-imsic
>       - n/a
>       - n/a
>       - emul
>       - in-kernel
> +   * - kvm
> +     - kernel-irqchip=off
> +     - aplic-imsic
> +     - n/a
> +     - n/a
> +     - emul
> +     - emul
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 60850970ce83..96d7ee1ebc64 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -129,12 +129,14 @@ The following machine-specific options are supported:
>    MSIs. When not specified, this option is assumed to be "none" which selects
>    SiFive PLIC to handle wired interrupts.
>  
> -  This option also interacts with '-accel kvm'.  When using "aia=aplic-imsic"
> -  with KVM, it is possible to set the use of the kernel irqchip in split mode
> +  This option also interacts with '-accel kvm', when using "aia=aplic-imsic"
> +  with KVM.  It is possible to set the use of the kernel irqchip in split mode
>    by using "-accel kvm,kernel-irqchip=split".  In this case the ``virt`` machine
>    will emulate the APLIC controller instead of using the APLIC controller from
> -  the irqchip.  See :ref:`riscv-aia` for more details on all available AIA
> -  modes.
> +  the in-kernel irqchip. Or the kernel irqchip can be disabled by using
> +  "-accel kvm,kernel-irqchip=off". In this case the ``virt`` machine will
> +  emulate the APLIC and IMSIC controller in user-space instead of using in-kernel
> +  irqchip.  See :ref:`riscv-aia` for more details on all available AIA modes.
>  
>  - aia-guests=nnn
>  
> -- 
> 2.17.1
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

