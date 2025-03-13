Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA50C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 12:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tshvt-0003gu-LF; Thu, 13 Mar 2025 08:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tshvr-0003ea-81
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:45:03 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tshvk-0003m1-Rw
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:45:02 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-301493f45aeso116204a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 05:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741869894; x=1742474694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D6feM5Xy+zarRq9YhH8FI7IPuKUW/t+Or20kqkXx3d8=;
 b=jLmZUqykW51Ha6Bnqnpcg0C90p1j8gsZlpnWO+PaNEHG1/HY9iYqduAt24ODYjSh42
 l2ylgGm6Fz9LAc1sNhqcyA+pYiHAO9hHgZYAosL/eRrrb+jDxLFhR/2JAyAFALp4AsHd
 QDdVAfa1r1Kb0lAWMyb/o5Tog60l0Cdwwxgp3hsWgQ+XU4Ew17RFQyEfE8Tfm9NxijUW
 S2I/KhU1CrAEJA87iCxLBbF5viUgU4NGHyNrkPrRGRoWIx8KwmrMJ+uaEXaQyjxQHAQJ
 9H9QzeQlDnqKcG4YMu3Z5EOr7rnSgKEoMr5rzf8m9C+uV3GIBXpXYP8bpG/6RWhT1N5D
 Ne6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741869894; x=1742474694;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D6feM5Xy+zarRq9YhH8FI7IPuKUW/t+Or20kqkXx3d8=;
 b=flJPZpSSiJFboTCG2F/8EAHMyPYZPBY3JtFyhxDNeEgeef/EbOYIbcjGLh51o/q5mN
 +mlJT39dV0qjpKMThd1G7uTspapTFyjj0ABpq7G05dEfxnYqOqP1FCRIdr6ihFJoaGpk
 541ybU585xxFMUJxTS4Pjl4at01MLpGS/ErchP5UYRDLuY+2sOT0o77AfUpOqyyTi4l+
 fbD1WXgzEBTTsmdA/Ov46SjCIfDaKZUsbCCYrrubFOtMmOSPfGpdtscWl6qrbj3a7Yar
 z2m9uZprl7Xw7jGPjW6nV6T89T1yiQcWR25C3Z+1gay3vRomCJgEP0K/e4XLBb24q+Zq
 k62w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG1D3EVVj8miGPyFkdGHNTieaC8Q/Pzx6A+7HY+SXOppV5erEGTULJf0+QeQdXKe6xgcAdBewkSNOQ@nongnu.org
X-Gm-Message-State: AOJu0YzBIDHSoq4mKfehfEGgsS9bzv8fKErcIL8NPjjA4smN7pgvyZH0
 lSEreeDPZoR6TSyQqxZlb8YOZR1eVtYIf9aer7dGRuw+XHEc/KtBBCtpvhdpaso=
X-Gm-Gg: ASbGnctxZcQ0+q6suHF+19BCd5vnkZp81OjUK2GmhyCwHZanM/JgjQ/gXuHAEAHEafh
 lWCMqqC04tQJPXL2z03MS02KuNrZl23KhkynRVk/v/DQJIkQyjb7FfPpAO8wdOfdYitzy3ron/x
 hNe5ELBFggvCy8NWNG3+0mzze3o6pXNEe3GmzWhHa+X8R5F4CMNwReH0VA4s44GElFOYiyno7ea
 xgU1yVzKFbwX43UWNOOm23FkdwZ54kqk98iTH9yhWDVSzFuO9jUwhzRpPW8NE+E1IApG5RSMf9d
 EwIuTTn7aVG4GUOD52UMW0Qnp2YbrDBfOf1doj8NzAa9DuConguxQqsLfkg=
X-Google-Smtp-Source: AGHT+IFw5OLNJZQDskE2fPXy5V18FpjqlRl+dDtg/2iXjhxYt92tumniX2AfQMCJnjosEaoD+X1M9Q==
X-Received: by 2002:a05:6a21:1519:b0:1f5:7280:1cdb with SMTP id
 adf61e73a8af0-1f572802b7amr25495560637.16.1741869894263; 
 Thu, 13 Mar 2025 05:44:54 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.117.79])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea95651sm1162523a12.73.2025.03.13.05.44.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 05:44:53 -0700 (PDT)
Message-ID: <f08a8ad9-186a-4983-9c7e-3976668ae8fd@ventanamicro.com>
Date: Thu, 13 Mar 2025 09:44:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/riscv/riscv-iommu: Connect the IOMMU with PCI
 hosts that have ATUs
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:MCIMX7D SABRE / i..." <qemu-arm@nongnu.org>
References: <20250307203952.13871-1-jason.chien@sifive.com>
 <20250307203952.13871-5-jason.chien@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250307203952.13871-5-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
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



On 3/7/25 5:39 PM, Jason Chien wrote:
> When the IOMMU detects that bus->iommu_ops has been registered, indicating
> the presence of an ATU, it sets the bus's downstream memory region to ensure
> transactions are directed to the IOMMU.
> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   hw/riscv/riscv-iommu.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index d46beb2d64..9701fe3831 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2628,11 +2628,16 @@ static const PCIIOMMUOps riscv_iommu_ops = {
>   void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>           Error **errp)
>   {
> -    if (bus->iommu_ops &&
> -        bus->iommu_ops->get_address_space == riscv_iommu_find_as) {
> -        /* Allow multiple IOMMUs on the same PCIe bus, link known devices */
> -        RISCVIOMMUState *last = (RISCVIOMMUState *)bus->iommu_opaque;
> -        QLIST_INSERT_AFTER(last, iommu, iommus);
> +    if (bus->iommu_ops) {
> +        if (bus->iommu_ops->get_address_space == riscv_iommu_find_as) {
> +            /* Allow multiple IOMMUs on the same PCIe bus, link known devices */
> +            RISCVIOMMUState *last = (RISCVIOMMUState *)bus->iommu_opaque;
> +            QLIST_INSERT_AFTER(last, iommu, iommus);
> +        } else {
> +            /* The bus has an ATU. Set its downsteam memory region. */
> +            AddressSpace *as = riscv_iommu_space(iommu, 0);
> +            pci_setup_iommu_downstream_mr(bus, as->root);
> +        }
>       } else if (!bus->iommu_ops && !bus->iommu_opaque) {
>           pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
>       } else {


