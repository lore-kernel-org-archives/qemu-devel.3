Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5C8C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6ji-0004mN-Up; Mon, 17 Feb 2025 14:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tk6ja-0004ls-QX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:24:51 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tk6jV-0007GV-Ub
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:24:47 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72720daed05so951547a34.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1739820284; x=1740425084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z57rBUpy+3bXfxd7SLy4EaQ+Xx2PXfEUSe2X0cbH7dw=;
 b=PNpO5tsIg/1mBrEtKtTQyphK18v4R+HMrH8sF6QK0TmiVdLVyKL2y8KO0/Va5TZ9ha
 Hn2iLRcl/jkXsxzCAG7Ak+q61LwUCgEvR0TAoSeU4GKFTNcOGyYRGu7/8S3Y/jvzfxxc
 f/DSZXMrkE1aJNTy1hdVi9waLdyxcBDJ84A4opydGvCngHVlA6mTCBdZrAy669KfTt9Z
 QKRkQBIEaStEzMl5agKlTprFgsHKjaof5I8KYssaxlFrIaW4FFc8UJjv1yWQcW44JT2Z
 QU20Un1Zr0Smjwn6iv6TKc/DoVHD3KT6xSFBjTQfAY3argtguVNl5V9mP6iZ1xnh6BoY
 Xkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820284; x=1740425084;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z57rBUpy+3bXfxd7SLy4EaQ+Xx2PXfEUSe2X0cbH7dw=;
 b=ClDnACK+UE5x3+Aefg/krxlXbbVd6ZLqFG6Z1MlOzs4ufyov8DfeV7Njr415EAZxuI
 HmNzH3jzT549vfINDHAyO7GD9enzgOueHN2j7l1BOKP8m2NOIwVSPqlWLWavr6n9T/xq
 IBm1nXhzMqb5rXYkFfhsh2zZl+Cs0RPW42FEyg9KPAR9fmAvDCto2TLZAvmDd5nZz0tO
 /R5arQ5rYFu9tm2iWXIwlMCdFIqjwN8ZJGgUMAB6PcgKkdga+Lq55gz+H6oULQrJUeDc
 3ti02Oq7jVUSgCbpTB5LswBd77qYTyg/HPng+mezK4N3n97VLU8DtXAygGUgAK8OY0lU
 AU1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3X4LpjY5FT0517FMT3ico9QCBG0zID5TjVR8x+NmWpWv0DtUbU6lp6AwVeJwf+fZ8SRfLJhEpRc+N@nongnu.org
X-Gm-Message-State: AOJu0YwW/M99F/tWieQ1OYVlKwQ39S5IfLQnY7s2/s6ke4LJX6X2EqdX
 Esbd7MWZoK0T4LAZnChf3dFoRvwX4r8DpEgbna6jn/MYh5tJsr4xH/gD8Pb1irw=
X-Gm-Gg: ASbGncsLzptcTbcATrN2se3sEVdHtJuyOUwsAjmSF8Pzx3bdk0PXqsbE/y41zbZRji2
 Haz2CaZ6cb/SawMQzkrjMv1bzhMn2v7irv1GuwKSXkolkEY45XoMIo+uIythnIIDr2kGKpbPq6w
 52QlLaecIeMsXK5IfrrM98GnxeYO5EzlGffzhG8PQOMiaOOU2HWWX6BQCjqwVX8ujikZFV8yYvO
 cO1idt4wMcKu8954/PECHwiV0SJdlzHXHUNJzJCLVvZuV+rjxIVOcJuFWNzEbdeVy1JJnQwlwdN
 ekhbw2Q476/M69ETwnLuSjBYD4+kcUFhGXKKpZzDeziP56yX8S/AR4BdMlSrK/xMeruqWA==
X-Google-Smtp-Source: AGHT+IHxegcxtxQi1dqfkSq0Wq1JAlHSW9B5g5r8/7gauYJsFxC971a5M8ZF4vTIRv+aRNKQf9pwmw==
X-Received: by 2002:a05:6830:380a:b0:727:13e:f26d with SMTP id
 46e09a7af769-7271203636dmr6431658a34.2.1739820283891; 
 Mon, 17 Feb 2025 11:24:43 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:6edb:f473:a9df:d551:443b?
 ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-727001cdc37sm3365169a34.3.2025.02.17.11.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:24:43 -0800 (PST)
Message-ID: <37cbfff3-9571-47e5-b955-41a85c7ef730@ventanamicro.com>
Date: Mon, 17 Feb 2025 16:24:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 1/4] hw/riscv/virt: KVM AIA refinement
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com, 
 jim.shu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250217081927.10613-1-yongxuan.wang@sifive.com>
 <20250217081927.10613-2-yongxuan.wang@sifive.com>
Content-Language: en-US
In-Reply-To: <20250217081927.10613-2-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x335.google.com
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



On 2/17/25 5:19 AM, Yong-Xuan Wang wrote:
> KVM AIA is only needed to be set when the virt machine use the AIA MSI.
> So we can move the KVM AIA configuration into virt_create_aia() to reduce
> the condition checking.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---

Unfortunately this doesn't work.

The reason is that kvm_riscv_aia_create(), as it is now, is called only once
during virt_machine_init() and it's already handling initialization for each socket:


     for (socket = 0; socket < socket_count; socket++) {
         socket_imsic_base = imsic_base + socket * (1U << group_shift);
         hart_count = riscv_socket_hart_count(machine, socket);
         base_hart = riscv_socket_first_hartid(machine, socket);

         if (max_hart_per_socket < hart_count) {
             max_hart_per_socket = hart_count;
         }

         for (i = 0; i < hart_count; i++) {
             imsic_addr = socket_imsic_base + i * IMSIC_HART_SIZE(guest_bits);
             ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR,
                                     KVM_DEV_RISCV_AIA_ADDR_IMSIC(i + base_hart),
                                     &imsic_addr, true, NULL);
             if (ret < 0) {
                 error_report("KVM AIA: failed to set the IMSIC address for hart %d", i);
                 exit(1);
             }
         }
     }

After this change, kvm_riscv_aia_create() is being called once for each socket since it's
now being called inside virt_create_aia(). And this will cause errors when running qemu-kvm
with more than one socket:

./qemu-system-riscv64 \
	-machine virt,accel=kvm,aia=aplic-imsic -m 2G \
	-object memory-backend-ram,size=1G,id=m0 \
	-object memory-backend-ram,size=1G,id=m1 \
	-smp 2,sockets=2,cores=1,threads=1 \
	-numa node,memdev=m0,cpus=0,nodeid=0 \
	-numa node,memdev=m1,cpus=1,nodeid=1 \
         (...)
qemu-system-riscv64: KVM AIA: failed to set the IMSIC address for hart 0


To make this patch work we would need changes in kvm_riscv_aia_create() to handle just the
current socket. The loop I mentioned above is one place, and there's another place where
we set group_bits and group_shift if socket_count > 1.

To be honest I'm not sure if all these extra required changes are worth the simplification
this patch is proposing.


Thanks,

Daniel





>   hw/riscv/virt.c | 79 +++++++++++++++++++++++--------------------------
>   1 file changed, 37 insertions(+), 42 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index dae46f4733cd..a52117ef71ee 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -58,14 +58,6 @@
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
>   
> -/* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
> -static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
> -{
> -    bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
> -
> -    return riscv_is_kvm_aia_aplic_imsic(msimode);
> -}
> -
>   static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
>   {
>       bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
> @@ -1298,10 +1290,12 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
>       return ret;
>   }
>   
> -static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
> +static DeviceState *virt_create_aia(RISCVVirtState *s,
>                                       const MemMapEntry *memmap, int socket,
>                                       int base_hartid, int hart_count)
>   {
> +    RISCVVirtAIAType aia_type = s->aia_type;
> +    int aia_guests = s->aia_guests;
>       int i;
>       hwaddr addr = 0;
>       uint32_t guest_bits;
> @@ -1309,6 +1303,28 @@ static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
>       DeviceState *aplic_m = NULL;
>       bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
>   
> +    if (!kvm_enabled()) {
> +        /* Per-socket M-level APLIC */
> +        aplic_m = riscv_aplic_create(memmap[VIRT_APLIC_M].base +
> +                                     socket * memmap[VIRT_APLIC_M].size,
> +                                     memmap[VIRT_APLIC_M].size,
> +                                     (msimode) ? 0 : base_hartid,
> +                                     (msimode) ? 0 : hart_count,
> +                                     VIRT_IRQCHIP_NUM_SOURCES,
> +                                     VIRT_IRQCHIP_NUM_PRIO_BITS,
> +                                     msimode, true, NULL);
> +    }
> +
> +    /* Per-socket S-level APLIC */
> +    aplic_s = riscv_aplic_create(memmap[VIRT_APLIC_S].base +
> +                                 socket * memmap[VIRT_APLIC_S].size,
> +                                 memmap[VIRT_APLIC_S].size,
> +                                 (msimode) ? 0 : base_hartid,
> +                                 (msimode) ? 0 : hart_count,
> +                                 VIRT_IRQCHIP_NUM_SOURCES,
> +                                 VIRT_IRQCHIP_NUM_PRIO_BITS,
> +                                 msimode, false, aplic_m);
> +
>       if (msimode) {
>           if (!kvm_enabled()) {
>               /* Per-socket M-level IMSICs */
> @@ -1329,32 +1345,20 @@ static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
>                                  base_hartid + i, false, 1 + aia_guests,
>                                  VIRT_IRQCHIP_NUM_MSIS);
>           }
> -    }
>   
> -    if (!kvm_enabled()) {
> -        /* Per-socket M-level APLIC */
> -        aplic_m = riscv_aplic_create(memmap[VIRT_APLIC_M].base +
> -                                     socket * memmap[VIRT_APLIC_M].size,
> -                                     memmap[VIRT_APLIC_M].size,
> -                                     (msimode) ? 0 : base_hartid,
> -                                     (msimode) ? 0 : hart_count,
> -                                     VIRT_IRQCHIP_NUM_SOURCES,
> -                                     VIRT_IRQCHIP_NUM_PRIO_BITS,
> -                                     msimode, true, NULL);
> -    }
>   
> -    /* Per-socket S-level APLIC */
> -    aplic_s = riscv_aplic_create(memmap[VIRT_APLIC_S].base +
> -                                 socket * memmap[VIRT_APLIC_S].size,
> -                                 memmap[VIRT_APLIC_S].size,
> -                                 (msimode) ? 0 : base_hartid,
> -                                 (msimode) ? 0 : hart_count,
> +        if (kvm_irqchip_in_kernel()) {
> +            kvm_riscv_aia_create(MACHINE(s), IMSIC_MMIO_GROUP_MIN_SHIFT,
>                                    VIRT_IRQCHIP_NUM_SOURCES,
> -                                 VIRT_IRQCHIP_NUM_PRIO_BITS,
> -                                 msimode, false, aplic_m);
> +                                 VIRT_IRQCHIP_NUM_MSIS,
> +                                 memmap[VIRT_APLIC_S].base,
> +                                 memmap[VIRT_IMSIC_S].base,
> +                                 aia_guests);
> +        }
>   
> -    if (kvm_enabled() && msimode) {
> -        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr);
> +        if (kvm_enabled()) {
> +            riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr);
> +        }
>       }
>   
>       return kvm_enabled() ? aplic_s : aplic_m;
> @@ -1621,9 +1625,8 @@ static void virt_machine_init(MachineState *machine)
>               s->irqchip[i] = virt_create_plic(memmap, i,
>                                                base_hartid, hart_count);
>           } else {
> -            s->irqchip[i] = virt_create_aia(s->aia_type, s->aia_guests,
> -                                            memmap, i, base_hartid,
> -                                            hart_count);
> +            s->irqchip[i] = virt_create_aia(s, memmap, i,
> +                                            base_hartid, hart_count);
>           }
>   
>           /* Try to use different IRQCHIP instance based device type */
> @@ -1641,14 +1644,6 @@ static void virt_machine_init(MachineState *machine)
>           }
>       }
>   
> -    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
> -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> -                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
> -                             memmap[VIRT_APLIC_S].base,
> -                             memmap[VIRT_IMSIC_S].base,
> -                             s->aia_guests);
> -    }
> -
>       if (riscv_is_32bit(&s->soc[0])) {
>   #if HOST_LONG_BITS == 64
>           /* limit RAM size in a 32-bit system */


