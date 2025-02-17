Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287CFC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1mr-0004Wx-Du; Mon, 17 Feb 2025 09:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tk1mp-0004WK-SO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:07:51 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tk1mn-0007VK-1B
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:07:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4397e5d5d99so6933595e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1739801267; x=1740406067; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PmgIdukFgg81QXZfPCUuO0nynNv6ogOqUR1G17GCxqc=;
 b=IwCguBIoJaRXYMdJTaH7BwoxbHSiujF358e0R13CEyDJNDsxFTSzq47pfQTy1YXXE4
 nrJFl8aYKwcbeP9iykDwPM15nxVca8VrSMk7KgEwrzgCCdeVGOaU1a6TnrIFVYNE/CGx
 Z3fczXjAEG2b0mMbfMRyCMBV27bWj6NV+B8BJ8aY2tKkt+UBmlSh3YW3fsIfAa1++NRi
 O47D32zlRS/UklhJQj+FhI174nXy1Xo2RNI+/QosW7l+r7G8u5NfhnQd8Rs1Ld4yV8W2
 iyzqjWklCDsKimdJJ0z+m5un4Fzr3KM5zgg0gTD/7EJeQQplejRXEJRouuZYKh8d7D8J
 ChOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739801267; x=1740406067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmgIdukFgg81QXZfPCUuO0nynNv6ogOqUR1G17GCxqc=;
 b=q5Dw5fArIyzcukYD/2XSlmml6ltfjPwp85cV59+unnEHqqDvkd9utbyoU+ehesZj4G
 qglLX2TSPElSR3kQvVa5hzZbIjzqk16zSprwPqE68IcWxAnWXNJ03wPIE6jMyVR2XEq4
 zVVamQK6G1zAUKCgNcW0ba4m1edArXKsmLlV1Ibf1nK9UFouQS8YeBWx2JNuIg8Tzbls
 eJM4UPL8Q/OMERjhnRAne1qOeRCvgCag+YlNafSC7qlx3fxPpcpHw0lvRS1jjhGnVQxp
 KXtmH6ZJfq5EqnnfHnGoPuKiTm+9jhsDi2EVV2C1ak4soJWUHY7pmsTcxgi2NoD4MKd4
 +yCA==
X-Gm-Message-State: AOJu0YwGVwGw5MqQK47ziwy+iWSqol+UGdXbI7lt+I842O7sAHpaA2p/
 Fnzlrf9BjcTFIWKRlDzOi8GttEG8piir0AOSGCdNOQOmuOFo/HpX6hekrt2wcBo=
X-Gm-Gg: ASbGncug53Y6bmKHTP4DDwgY6j85mYnkKL8WRNJqTs0EON2Z6thWLNvz0YY3mSJJbkr
 j4hxPAkBVZzLJX3JgZqMLeBWVvsIVQxecEFEePME+0j4QE7IQ7w5HEomDLCiEmlMh/pk7NFN2bw
 5f6uz5JLLpO9l9ipHeZqPegj7DeVVyryrLbnbq140F5s4MlvLeCOECgeWqnZNCrVrGh3NdcY9ei
 TWMD6gAaZm9k392D69W4u+lI32aW9kTuSwYAwdijLY8zPvun9sj//V2Fhkr+fzwPA2/HaC6ER6P
 8jA=
X-Google-Smtp-Source: AGHT+IGe7x0l83EZz1S/BnhFgczyBH4ehZ+RcGMIT/e8NK1/Km22GXFwIO145autYnZjIxvKc/jHdA==
X-Received: by 2002:a05:6000:18a9:b0:38b:ed1c:a70d with SMTP id
 ffacd0b85a97d-38f33e87e68mr12298332f8f.0.1739801266538; 
 Mon, 17 Feb 2025 06:07:46 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b432asm12115256f8f.6.2025.02.17.06.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 06:07:46 -0800 (PST)
Date: Mon, 17 Feb 2025 15:07:45 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 7/8] target/riscv/kvm: rename riscv-aia to riscv-imsic
Message-ID: <20250217-9d3c0d38ed66b1a8257b4515@orel>
References: <20250217081730.9000-1-yongxuan.wang@sifive.com>
 <20250217081730.9000-8-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217081730.9000-8-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32c.google.com
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

On Mon, Feb 17, 2025 at 04:17:27PM +0800, Yong-Xuan Wang wrote:
> The riscv-aia property only controls the in-kernel IMSIC mode, the
> emulation of AIA MSI mode is controlled by the kernel-irqchip property.
> Rename the riscv-aia property to riscv-imsic to prevent the confusion.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 52 ++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index c047d5f36951..ab53b76ab81f 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1798,9 +1798,9 @@ void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
>      }
>  }
>  
> -static int aia_mode;
> +static int imsic_mode;
>  
> -static const char *kvm_aia_mode_str(uint64_t mode)
> +static const char *kvm_imsic_mode_str(uint64_t mode)
>  {
>      switch (mode) {
>      case KVM_DEV_RISCV_AIA_MODE_EMUL:
> @@ -1813,19 +1813,19 @@ static const char *kvm_aia_mode_str(uint64_t mode)
>      };
>  }
>  
> -static char *riscv_get_kvm_aia(Object *obj, Error **errp)
> +static char *riscv_get_kvm_imsic(Object *obj, Error **errp)
>  {
> -    return g_strdup(kvm_aia_mode_str(aia_mode));
> +    return g_strdup(kvm_imsic_mode_str(imsic_mode));
>  }
>  
> -static void riscv_set_kvm_aia(Object *obj, const char *val, Error **errp)
> +static void riscv_set_kvm_imsic(Object *obj, const char *val, Error **errp)
>  {
>      if (!strcmp(val, "emul")) {
> -        aia_mode = KVM_DEV_RISCV_AIA_MODE_EMUL;
> +        imsic_mode = KVM_DEV_RISCV_AIA_MODE_EMUL;
>      } else if (!strcmp(val, "hwaccel")) {
> -        aia_mode = KVM_DEV_RISCV_AIA_MODE_HWACCEL;
> +        imsic_mode = KVM_DEV_RISCV_AIA_MODE_HWACCEL;
>      } else if (!strcmp(val, "auto")) {
> -        aia_mode = KVM_DEV_RISCV_AIA_MODE_AUTO;
> +        imsic_mode = KVM_DEV_RISCV_AIA_MODE_AUTO;
>      } else {
>          error_setg(errp, "Invalid KVM AIA mode");
>          error_append_hint(errp, "Valid values are emul, hwaccel, and auto.\n");
> @@ -1834,13 +1834,15 @@ static void riscv_set_kvm_aia(Object *obj, const char *val, Error **errp)
>  
>  void kvm_arch_accel_class_init(ObjectClass *oc)
>  {
> -    object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia,
> -                                  riscv_set_kvm_aia);
> -    object_class_property_set_description(oc, "riscv-aia",
> -        "Set KVM AIA mode. Valid values are 'emul', 'hwaccel' and 'auto'. "
> -        "Changing KVM AIA modes relies on host support. Defaults to 'auto' "
> -        "if the host supports it");
> -    object_property_set_default_str(object_class_property_find(oc, "riscv-aia"),
> +    object_class_property_add_str(oc, "riscv-imsic", riscv_get_kvm_imsic,
> +                                  riscv_set_kvm_imsic);
> +    object_class_property_set_description(oc, "riscv-imsic",
> +        "Set KVM IMSIC mode. Valid values are 'emul', 'hwaccel' and 'auto'. "
> +        "Changing KVM IMSIC modes relies on host support. Defaults to 'auto' "
> +        "if the host supports it. This property only takes effect when the "
> +        "kernel-irqchip=on|split when using AIA MSI.");
> +    object_property_set_default_str(object_class_property_find(oc,
> +                                                               "riscv-imsic"),
>                                      "auto");

We can't change property names without deprecating the old name (which
isn't likely worth it).

Thanks,
drew


>  }
>  
> @@ -1851,7 +1853,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>  {
>      int ret, i;
>      int aia_fd = -1;
> -    uint64_t default_aia_mode;
> +    uint64_t default_imsic_mode;
>      uint64_t socket_count = riscv_socket_count(machine);
>      uint64_t max_hart_per_socket = 0;
>      uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
> @@ -1867,24 +1869,24 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>  
>      ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>                              KVM_DEV_RISCV_AIA_CONFIG_MODE,
> -                            &default_aia_mode, false, NULL);
> +                            &default_imsic_mode, false, NULL);
>      if (ret < 0) {
> -        error_report("KVM AIA: failed to get current KVM AIA mode");
> +        error_report("KVM AIA: failed to get current KVM IMSIC mode");
>          exit(1);
>      }
>  
> -    if (default_aia_mode != aia_mode) {
> +    if (default_imsic_mode != imsic_mode) {
>          ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>                                  KVM_DEV_RISCV_AIA_CONFIG_MODE,
> -                                &aia_mode, true, NULL);
> +                                &imsic_mode, true, NULL);
>          if (ret < 0) {
> -            warn_report("KVM AIA: failed to set KVM AIA mode '%s', using "
> +            warn_report("KVM AIA: failed to set KVM IMSIC mode '%s', using "
>                          "default host mode '%s'",
> -                        kvm_aia_mode_str(aia_mode),
> -                        kvm_aia_mode_str(default_aia_mode));
> +                        kvm_imsic_mode_str(imsic_mode),
> +                        kvm_imsic_mode_str(default_imsic_mode));
>  
> -            /* failed to change AIA mode, use default */
> -            aia_mode = default_aia_mode;
> +            /* failed to change IMSIC mode, use default */
> +            imsic_mode = default_imsic_mode;
>          }
>      }
>  
> -- 
> 2.17.1
> 

