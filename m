Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1921AE6B244
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 11:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6q5n-0004J7-Id; Fri, 01 Nov 2024 07:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6q5k-0004Gt-D5
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:45:25 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6q5g-0008Ps-KM
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:45:22 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720c2db824eso1347055b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730461519; x=1731066319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E0a+XLtNlJ3S11rchV6Of5MW8vyVRGyYOCdBEmauSOY=;
 b=LytgbUxhqm90FB9u/oSJNpzXAyQIWzkZ8ux2WgSUpeY+MK6VFi5ZBoNM7mICRnYYDl
 68bpsKyl2g8fnTQmZxRJ2kEtXVJHAbzQOrINfgHHYUgFYlHYLfXaPRMpmR7cVGBuI1SQ
 rM437KkZOLIPgnDceyD4ENOHORAjt9yLUvz5ep8Dlx3KeBX86XoKF1xh8kHGNwV4Bjz9
 EDxOfS5Fd2EVFPfJVyG75RAj+Cl9d7YNvW9Ipkl+yDAJbWP9RNzE0bs2xMkfa6J2xMN0
 OjvRUKh3RQb82zbETMzdimcznBJ6Gep5lFw7/qmZlH2FGW+q3/yJ7xbaNJLd/YhteU2w
 cnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730461519; x=1731066319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E0a+XLtNlJ3S11rchV6Of5MW8vyVRGyYOCdBEmauSOY=;
 b=eMbp9ZluDqtEk/olidE37gaQeb2Gacm6gw0s5TPrwDEen2lmjDcgf+cwhpS/zj+pcW
 08jZbaemXvTppUyEgQ7Kc2DPFFWW61cLPhPobfok3jO6lzH0yA0FGjgQRlXycMLLp7mh
 9nMMMf+ksyEHQHlnMskInboDv6bfbzR749IeBTCxJTkxOHtI8/OlW3nEX1MjEuhxOMHY
 xGGokJMD5C6i7Gthow4tiaIsd9p4ZPAiqybtRsf8SRf9x+D74shA5Ct/eRE4NXvkcmJY
 lF4l/7lXZrOPcjF1cB0Hm5MiePaExgqc4sf92QFtcKQOqDpgpsEqVVWJHYvJ2PiUi50V
 YnOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIOEwNbfdCTcRuYMe0srxbwaWTzKU7rGL91+lucif0agSL7KDBglP/5mmxIuHo+bzkPMu4jhnIHh7x@nongnu.org
X-Gm-Message-State: AOJu0YxArCm2qz5M2kBE0ZtZwqiIftqsd00YO+E7qMjGRukcGPH7OQ5n
 5THLaaanCk8RL/M4XSImQckj0kxpHfE7U3/DwRKu7BpmcyRYfw7Ci9boKHqVVO8poLoAQlcpukE
 H
X-Google-Smtp-Source: AGHT+IFX9NnP9uaqquDCDVSEk7Uy8obp5Pug98D2mwk93e7dPbNPkKPWEqNa52HhTU1JdHYJqCcQOQ==
X-Received: by 2002:a05:6a00:2384:b0:71e:68ae:aaed with SMTP id
 d2e1a72fcca58-72062f81e6dmr29558711b3a.1.1730461518735; 
 Fri, 01 Nov 2024 04:45:18 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2c3e08sm2447394b3a.105.2024.11.01.04.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 04:45:18 -0700 (PDT)
Message-ID: <8ec6e960-8305-456c-b8f9-4c0dd14e51ff@ventanamicro.com>
Date: Fri, 1 Nov 2024 08:45:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/riscv: virt: prevent to use AIA MSI when host
 doesn't support it
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com, 
 jim.shu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
References: <20241101083606.5122-1-yongxuan.wang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241101083606.5122-1-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
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



On 11/1/24 5:36 AM, Yong-Xuan Wang wrote:
> Currently QEMU will continue to emulate the AIA MSI devices and enable the
> AIA extension for guest OS when the host kernel doesn't support the
> in-kernel AIA irqchip. This will cause an illegal instruction exception
> when the guest OS uses the IMSIC devices. Add additional checks to ensure
> the guest OS only uses the AIA MSI device when the host kernel supports
> the in-kernel AIA chip.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---
>   hw/riscv/virt.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 45a8c4f8190d..0d8e047844a6 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1567,12 +1567,19 @@ static void virt_machine_init(MachineState *machine)
>           }
>       }
>   
> -    if (kvm_enabled() && virt_use_kvm_aia(s)) {
> -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> -                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
> -                             memmap[VIRT_APLIC_S].base,
> -                             memmap[VIRT_IMSIC_S].base,
> -                             s->aia_guests);
> +    if (kvm_enabled() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
> +        if (virt_use_kvm_aia(s)) {
> +            kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> +                                 VIRT_IRQCHIP_NUM_SOURCES,
> +                                 VIRT_IRQCHIP_NUM_MSIS,
> +                                 memmap[VIRT_APLIC_S].base,
> +                                 memmap[VIRT_IMSIC_S].base,
> +                                 s->aia_guests);
> +        } else {
> +            error_report("Host machine doesn't support in-kernel APLIC MSI, "
> +                         "please use aia=none or aia=aplic");
> +            exit(1);
> +        }

As you said in the commit msg it looks like we have a bug in this particular path: kvm accel,
aia=aplic-imsic, no irqchip present. Erroring out is one possible solution but I wonder why we
couldn't just emulate the APLIC and IMSIC controllers in this case. We have code that does
that in TCG, so it would be a matter of adding the needed plumbing to treat KVM AIA without
irqchip == TCG AIA.

Drew, care to weight in? Thanks,


Daniel


>       }
>   
>       if (riscv_is_32bit(&s->soc[0])) {

