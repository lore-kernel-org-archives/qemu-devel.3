Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1133DCAC5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 15:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyuWW-0001z5-Ra; Wed, 17 Sep 2025 11:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyuWR-0001yC-G7
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:56:45 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyuWP-0006Yc-Ir
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:56:43 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b5488c409d1so4569097a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758124589; x=1758729389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MjK3La289rCCIqcfZCNyIYiUhV+S1dwsM+vhTJJr0KQ=;
 b=nLoE80KzFCYcBnr59bm4LdPFA/NhrxOtZPkOYvnesuE8FwhNvCx6jOybbW+mdR/fLS
 MHzKGIMe/8NBt8ZkeveEXRmP+R2GqHxSyMx5fPIfAK1T1dkbzIxLx8DVYuBHXM14lsJ6
 dx5WfNtH/cLmEQqd7XOgk49lz10CasNwvQHPQDJAHi9qnPNxRAekS5mA32xxmostN6Xf
 HpXSULEckv+ph07C24WqO41mo5CzqKwV6/si7/dJJet11cfL19mK6uUZ7A4PrIy7LdM2
 LeljIVw1kYyPt/VqYwC564TVfi3zZyQtNZVqGwjQRdx8S7Psdl/dXGQZnsjsDRi6WMUn
 E1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758124589; x=1758729389;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjK3La289rCCIqcfZCNyIYiUhV+S1dwsM+vhTJJr0KQ=;
 b=RGTxISRwN2InUag8EJ3N6SOOyU/og+AzSG+9uPReA7OqZoMHTngGid3Z1qJe5U1Wcr
 3cmxU6kZZu4q8JHy79vIGZ2H7cR3tgrT0f11NfL4qt7TuC+6HBkRGROYjnRzhohlqQNH
 /Z9KD9JYux8TpUXMIF7Fw0zCNHtfmk2M17eI/fXh8Yz+RDNGPnqGJY9w1lA1XWPGBnUT
 Zq6/weEDDZnvj2wg8L7BKAhimqtBbTORFUBuOdEHyJoYU255pk/+zULqWept7/7jrh2p
 8jttHdyz15j5xOvyk8dvdUQpGdHvWJWL0zojiGYphbPDs9+cG/Rbg9Ow/2tVRLT1qvRL
 Ud2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUQsBmR10e79s/9UsAqZU5BhxdIL0a90A+fd0iWFNNpLfn6HZxCg57EgPuDDpMzvwbjBM/lMEVhtrD@nongnu.org
X-Gm-Message-State: AOJu0YyvCIXotfMVJjkvRANXmEqVplhw8uNnd+iywmTa0xJA/BNSjHzt
 CJ+2ePFcysyXXF4iwXqWQXiaY8LL827unWQCCS0kTOOtInub4QW0ngUhm6bsYz/PY1W828hCDxy
 BaFuc
X-Gm-Gg: ASbGncs/Nq4m06rLwpCKTmpsjeZEJCrq2xXXBY2z3a6ECmM90riSJvG+8lGwtMGoSps
 xLQ9IRx3jU2bHzYUjEknWRzH3FsdSDx6vw5b/VAoHcxQAnpIcWNBOhP2MY/6LGByRvMwJMWIPDk
 NDEVIF6gNljkj5f61BwfMsy0NXfg8oaF6YVeBNbv7iiEolm7HsJHc3sCwQzj3Erapolx3nqy4+l
 H1u2iUFPUlFk61fwhYWirJvNRmzHzQT+GW2Vrr2zvULmzynfSIBDZ7kxKBi5FhXECqqjYDzspl6
 SGKgolpAT3bC+FdGHK5ju6po8abq4Zvnfe1ZMdV28mEOEceaarS+5Y5phD8ZoqNAyncSFkk2Fna
 w1IwDORljJBXnxzP8Ut00JSPFOlH+ZIPV5aem
X-Google-Smtp-Source: AGHT+IFLI+NtdkAO0DqQgzjyhxqcy806u0dToLaYF0409foNEogcStgEtYtD/HqRPD4tpY8JMj6Egw==
X-Received: by 2002:a17:903:13d0:b0:254:2cd9:9c04 with SMTP id
 d9443c01a7336-26811ba49b5mr35825725ad.16.1758124589556; 
 Wed, 17 Sep 2025 08:56:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-267dbd64df2sm48348045ad.109.2025.09.17.08.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 08:56:29 -0700 (PDT)
Message-ID: <6cb5ae94-14b8-4315-8981-d1817b375059@linaro.org>
Date: Wed, 17 Sep 2025 08:56:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/35] hw/alpha: QOM-ify AddressSpace
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
References: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-qom-v1-4-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250917-qom-v1-4-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 9/17/25 05:56, Akihiko Odaki wrote:
> Make AddressSpaces QOM objects to ensure that they are destroyed when
> their owners are finalized and also to get a unique path for debugging
> output.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/alpha/typhoon.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index d2307b076897..7c38be2378ed 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -900,8 +900,8 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
>       memory_region_init_iommu(&s->pchip.iommu, sizeof(s->pchip.iommu),
>                                TYPE_TYPHOON_IOMMU_MEMORY_REGION, OBJECT(s),
>                                "iommu-typhoon", UINT64_MAX);
> -    address_space_init(&s->pchip.iommu_as, NULL, MEMORY_REGION(&s->pchip.iommu),
> -                       "pchip0-pci");
> +    address_space_init(&s->pchip.iommu_as, OBJECT(s),
> +                       MEMORY_REGION(&s->pchip.iommu), "pchip0-pci");
>       pci_setup_iommu(b, &typhoon_iommu_ops, s);
>   
>       /* Pchip0 PCI special/interrupt acknowledge, 0x801.F800.0000, 64MB.  */
> 


