Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1451C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 12:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYPBR-0000aw-TQ; Thu, 16 Jan 2025 07:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYPBO-0000TF-V8
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:41:11 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYPBM-0003iV-Ss
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:41:10 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ebc678b5c9so577242b6e.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 04:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737031264; x=1737636064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yHr/thHl0Pqp9/aPVplGb+KVLdIqWX3rtBZC0y7+oOI=;
 b=B1XwhFeothEla8KGY2/acZjpr0EzmrnYw6eryF6azA5zyWT/va66sqrap/BYq/hSAI
 2qbs7cJ2Pt8GNanst9RI7a+YQp/Dk34AfXpWSsG6t9jDHA8muSGm/OXKoN+GRX03KkES
 d/bzz5trG0anu5HGOnLKyV4UDiYsWXExp446zicCut2iT8AEw5inU/4GSPiZ4nCM5HBg
 kylwj2VRYvpEILuPNvhgCcCCe5M+2siARoyebNuhsu51JJhZab8UOG4HM9HNElot9+Yv
 VHXYgi5qAhGPJd4+i737+NmDLM8V1JvlCsi0vo04N0Eo3oiemjodIj4d+bH6m+cfDnfn
 VR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737031264; x=1737636064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yHr/thHl0Pqp9/aPVplGb+KVLdIqWX3rtBZC0y7+oOI=;
 b=Knn/V21O3dPd9Np1hCMNv7ydEGisMdFIjk8BbQdGybcjizUEQ/d0qUEPjilzmJnhp4
 vfWYK1n4mrFh0JStjkii1P60WLIvLeEVgoCTqEDU9ml1e+lzn5gha8L4dAxmUTWNk2+i
 ajeN4cBlmlnNNmQAWyQiQk1ZB/1pRuOI2ZG+D3xlbNUTCNprzITgoCviotBhr7V/mAEN
 4GxHPWwpJUSOhJUF73R3eDCKy1e16P1Fv3GIPVGItPOUJrImtdghW0lIL9AC4tiSdhIk
 t3KkcLu86cuZOzpul9nJ3ljVi3eJaVdmrw+Xt2j5iJrwuKq4L3JogvOHERFY1zLagWQU
 C2aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc+jYhv6XnXRd/8WvkCdhvUgoBQ0j+AJCGPZliJXxg8Qb5SyGZoawODdJQh/+6p4AUpMplEJYZYEwE@nongnu.org
X-Gm-Message-State: AOJu0YznyGt/2YqHp8KKbB3nsgfcawPdEE+DXo40JsF9aOdqYsOCvMlM
 +0xf+YZRPACmYdPpi1g1gR/GaqWR7ORE/YJOO4FvqOSi12rhTknsB5n0GyprvGc=
X-Gm-Gg: ASbGncu17E5i/Ts808PRfszkInorm3g8OTRo6np/QOGEijDdg+B4wzl/XMCABDy41Yu
 pAERNsteKp5Mx0huo9Xk0M+DasdfWMw7y1MsFPDSOkQ5n3Y4RUBAThX+MyeC0mD2sjnSlW9adPH
 XEldWhPPcy/PmmJbPu7QCuc6dxRXLB1z3abGV2TYc5IFDmnHoQmggy1CG+9ACy3tG1qNX239rFj
 CtVRBzj28+vCzzqZE/mJmW54r9IOYg9sV825pxRyCoWFQZma7UNjaDFwhiP5sU1C97un9c=
X-Google-Smtp-Source: AGHT+IEfic0JF87hjS6ph0rzOMfaHfjjVoSE9SSeL4LSiPH1rN6IjjqglU/ZnJnAe/GMvu+bDZ3vjw==
X-Received: by 2002:a05:6808:1449:b0:3e6:6097:847d with SMTP id
 5614622812f47-3ef2ebf8a75mr22500109b6e.7.1737031264619; 
 Thu, 16 Jan 2025 04:41:04 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f037654176sm5762191b6e.14.2025.01.16.04.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 04:41:03 -0800 (PST)
Message-ID: <423806dd-34f3-4d78-ae69-688f965c92e8@ventanamicro.com>
Date: Thu, 16 Jan 2025 09:40:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] hw/riscv/riscv-iommu: Acquire device IDs
 dynamically
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:MCIMX7D SABRE / i..." <qemu-arm@nongnu.org>
References: <20241216004857.9367-1-jason.chien@sifive.com>
 <20241216004857.9367-6-jason.chien@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241216004857.9367-6-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22c.google.com
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



On 12/15/24 9:48 PM, Jason Chien wrote:
> When all memory transactions from a PCIe host write to the same IOMMU
> memory region, we need to distinguish the source device dynamically.
> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---

I'm not sure whether this should be squashed in patch 4 but the code LGTM,
so either way:


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/riscv-iommu.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index f5d53a36b2..e4b7008306 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -48,6 +48,7 @@ struct RISCVIOMMUSpace {
>       RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
>       uint32_t devid;             /* Requester identifier, AKA device_id */
>       bool notifier;              /* IOMMU unmap notifier enabled */
> +    bool dynamic_devid;         /* Acquiring device_id dynamically */
>       QLIST_ENTRY(RISCVIOMMUSpace) list;
>   };
>   
> @@ -1184,7 +1185,8 @@ static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
>   }
>   
>   /* Find or allocate address space for a given device */
> -static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
> +static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid,
> +                                       bool dynamic)
>   {
>       RISCVIOMMUSpace *as;
>   
> @@ -1203,6 +1205,7 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
>   
>           as->iommu = s;
>           as->devid = devid;
> +        as->dynamic_devid = dynamic;
>   
>           snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
>               PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->devid));
> @@ -2415,7 +2418,8 @@ static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
>   
>       /* Find first matching IOMMU */
>       while (s != NULL && as == NULL) {
> -        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
> +        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn),
> +                               false);
>           s = s->iommus.le_next;
>       }
>   
> @@ -2438,11 +2442,10 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>           pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
>       } else if (bus->iommu_ops && bus->iommu_ops->set_memory_region) {
>           /*
> -         * TODO:
>            * All memory transactions of this bus will be directed to this AS.
>            * We need to distinguish the source device dynamically.
>            */
> -        AddressSpace *as = riscv_iommu_space(iommu, 0);
> +        AddressSpace *as = riscv_iommu_space(iommu, 0, true);
>           pci_setup_iommu_downstream_mem(bus, as->root);
>       } else {
>           error_setg(errp, "can't register secondary IOMMU for PCI bus #%d",
> @@ -2453,6 +2456,12 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>   static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr,
>       MemTxAttrs attrs)
>   {
> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
> +
> +    if (as->dynamic_devid) {
> +        as->devid = attrs.requester_id;
> +    }
> +
>       return attrs.unspecified ? RISCV_IOMMU_NOPROCID : (int)attrs.pid;
>   }
>   


