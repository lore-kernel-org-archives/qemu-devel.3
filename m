Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122E2E8383F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7Ir-0006G2-5H; Mon, 16 Feb 2026 17:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vs7Io-0006FV-PV
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:42:50 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vs7Im-0005HJ-Il
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:42:50 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a7a23f5915so19535055ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771281767; x=1771886567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/5ftDsAj1fPgg5RsG3LKmEy4aqdFaCzXj8WaSTCOxEo=;
 b=n4TOjcBmdNt/Zfu2JpgheebsX/6ng74fP0sVVZd/Ch1EXM1LC2qqkbsmO1g7GMSWwz
 +rLOvbFsMSVcla7cnZe8yaz0TddtBYqCRlxHY9JqDZGoM8yOvF6L2SY87asiwQwW6oMD
 pAvs1rSN5+AYMVmdD+kUilzVrheOOoCeQU0+NC1aJ2cvzC4LRPAU2qcWySsmcTPFloax
 ywliHk82evw4GqUhBqMgFMsExWBF0cFLZw4QCc71bie5lz0xEnJ5UjeU6BQvA/i2kUp0
 6yYgyxiKgoRuCsV8sfvmxvT7UcH8xB+am9HnfrZRY/5j+idI1h9larP7CN2m7WpdrJfy
 RecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771281767; x=1771886567;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/5ftDsAj1fPgg5RsG3LKmEy4aqdFaCzXj8WaSTCOxEo=;
 b=LCl8FOAURdWQg/3lG7PXOeFxfKs0ovDMP70FeLB4IXQI9ueJRbrpFCrHBfNr9xlKu/
 VicArOZWXTaFglYjnjUw7EXXe8c7acueBKcpsGPNXa1W/A/7AooFQwIZthlDoyGj7/JR
 X2CPdENVGNQWznDDbpDotF6v4Vrl3NFaA7ikQSA7tp/uilinIUIU/DpsJNVLmRHqnDEJ
 w5QSUuxMsx7aivfVxPzMZlZIGj+xfw43GhNTBSiiI2glk7UMbMS0zAJxbt/la+4h18rK
 fBkSDUDQeP6gjL0/Kj3rMsPw6VUo8MTLNQ3EKSphXrpzWajTay/QOp7KX4sxAXfVQhe1
 L4TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGiZH9Oe1x78d7m/m+GUJ5KBvpOat1rlu3eeThyKC+n3TbQkSxRTHXLjsM7Tnkqw8D11kfOS8C4SRC@nongnu.org
X-Gm-Message-State: AOJu0Yy1NZHe5xxNGXB4h7jeDC9JgiAfJXCuLe3396ngX/NgXAd1pY3N
 GDDH8cAOKy4WqFfgXYTbDSpTDFHYi7o0Q9gnuMt1ua5dADziR5/s+a5XpmgU6Ewk2Mo=
X-Gm-Gg: AZuq6aLZUGRcDrwS63hFxJl7gpgwiTgCUXqKQIIk/hr35eqqjs47iO7A+t5OsU6xqC4
 m9jA9cMxEGKL0OCdrnXDclU7gxQLacdgx0lMKvdtfKrfsf1pY43Mm4ZYz3ycJvRyGkJDUNZh59Z
 QEnaJlLnoH+sX+hvdpnMOp/UaRg+Vvb3VUZvUUjsyP/V+MaAyWxQ0gyzjA90ET7WgXlRuY06CXL
 CNUNd6nfoceyDVp5DNQuWHX8mypKjUA3147JAyAaOuBSrbRUz+tiLtr5h7NkmNRUN2eggAztsRL
 L7z3NSU2SlhAP54Kkz7JWG9uEVKFdZci4tzg2qb4UDrs1sRJ17TzWxH/Zpj9HYgH0WGSH0OqWeL
 t5SnBfpWeOUGf1BnX3B1HXeDZOKYjdlhQBxRlvqyNGCusB5t9e3bLw3PdmXUr9EdlNuMBRhuNSp
 KSZTmG+8WwBG1KiLUQ0VXSUSFKeoLDZjO3x912YgdSx8Eg5O0EB3CV323/Ameq1UqzNVjAlZ5vm
 iYBnYOcsuZRcd5mUSOZlcY05xEyf4zcNTFpHgXV6s8/XL9L+r9tqTs=
X-Received: by 2002:a17:903:1a44:b0:2a1:1074:4199 with SMTP id
 d9443c01a7336-2ab505b6446mr111206065ad.32.1771281766456; 
 Mon, 16 Feb 2026 14:42:46 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1e87:e093:79fa:89a7?
 (bg30dhzpjwwrss5hh6ty.ip6.superloop.au.
 [2401:d002:dc0f:2100:1e87:e093:79fa:89a7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadb858sm78516205ad.61.2026.02.16.14.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 14:42:46 -0800 (PST)
Message-ID: <80517977-f2ca-48c4-a300-67ef7220246e@linaro.org>
Date: Tue, 17 Feb 2026 08:42:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] hw/riscv: Set IOMMU PAS via property
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260216-phys_addr-v5-0-29d522f1339c@rev.ng>
 <20260216-phys_addr-v5-6-29d522f1339c@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260216-phys_addr-v5-6-29d522f1339c@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/17/26 02:28, Anton Johansson wrote:
> Replaces the only remaining use of TARGET_PHYS_ADDR_SPACE_BITS for RISCV
> with a property RISCVIOMMUState::pas_bits that gets written to the
> capabilities field upon device realization.  This write needs to happen
> at realize-time to ensure the property has been set.
> 
> For the virt machine and sysbus device, pas_bits is set by
> virt_machine_init() to either 34 or 56 bits, retaining previous behaviour.
> However, for the PCI device we do not have access to the CPU state, and
> instead use the maximum riscv64 value of 56 bits.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   hw/riscv/riscv-iommu.h     | 1 +
>   hw/riscv/riscv-iommu-pci.c | 3 +++
>   hw/riscv/riscv-iommu.c     | 8 ++++----
>   hw/riscv/virt.c            | 7 +++++++
>   4 files changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 2dabd86941..2a9f6fccd5 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -34,6 +34,7 @@ struct RISCVIOMMUState {
>       /*< public >*/
>       uint32_t version;     /* Reported interface version number */
>       uint32_t pid_bits;    /* process identifier width */
> +    uint32_t pas_bits;    /* physical address bits */
>       uint32_t bus;         /* PCI bus mapping for non-root endpoints */
>   
>       uint64_t cap;         /* IOMMU supported capabilities */
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> index 5f7d359204..14dd5f3857 100644
> --- a/hw/riscv/riscv-iommu-pci.c
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -158,6 +158,9 @@ static void riscv_iommu_pci_init(Object *obj)
>   
>       iommu->icvec_avail_vectors = RISCV_IOMMU_PCI_ICVEC_VECTORS;
>       riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_MSI);
> +
> +    /* Report maximum physical address size of riscv64 */
> +    iommu->pas_bits = 56;
>   }
>   
>   static const Property riscv_iommu_pci_properties[] = {
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b46b337375..98345b1280 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2453,10 +2453,6 @@ static void riscv_iommu_instance_init(Object *obj)
>       /* Enable translation debug interface */
>       s->cap = RISCV_IOMMU_CAP_DBG;
>   
> -    /* Report QEMU target physical address space limits */
> -    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> -                       TARGET_PHYS_ADDR_SPACE_BITS);
> -
>       /* TODO: method to report supported PID bits */
>       s->pid_bits = 8; /* restricted to size of MemTxAttrs.pid */
>       s->cap |= RISCV_IOMMU_CAP_PD8;
> @@ -2487,6 +2483,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>   {
>       RISCVIOMMUState *s = RISCV_IOMMU(dev);
>   
> +    /* Report QEMU target physical address space limits. */
> +    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS, s->pas_bits);
> +
>       s->cap |= s->version & RISCV_IOMMU_CAP_VERSION;
>       if (s->enable_msi) {
>           s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
> @@ -2645,6 +2644,7 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
>   static const Property riscv_iommu_properties[] = {
>       DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>           RISCV_IOMMU_SPEC_DOT_VER),
> +    DEFINE_PROP_UINT32("pas-bits", RISCVIOMMUState, pas_bits, 0),
>       DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
>       DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
>           LIMIT_CACHE_IOT),
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 07e66b3936..bbce2fb667 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1739,6 +1739,13 @@ static void virt_machine_init(MachineState *machine)
>           object_property_set_link(OBJECT(iommu_sys), "irqchip",
>                                    OBJECT(mmio_irqchip),
>                                    &error_fatal);
> +        /*
> +         * For riscv64 use a physical address size of 56 bits (44 bit PPN),
> +         * and for riscv32 use 34 bits (22 bit PPN).
> +         */
> +        object_property_set_uint(OBJECT(iommu_sys), "pas-bits",
> +                                 riscv_is_32bit(&s->soc[0]) ? 34 : 56,
> +                                 &error_fatal);
>   
>           sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
>       }
> 


