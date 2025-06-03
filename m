Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6852CC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQAZ-0005Yu-Bf; Tue, 03 Jun 2025 07:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQAW-0005YT-Si
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:51:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQAP-0008Ub-A1
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:50:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442ea341570so38047345e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748951449; x=1749556249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Umh+HP+YIzfm01oCuEnx3dxYDMzG774+Azq2vEn7vxI=;
 b=D9/PF/9rzc24zMgfF8Pg917LNNsYgocxVk2tZ0Qap71D4Q5WBB2nivAO5PlqOoY1fa
 No+vLq+TL2eZ/rUZhEd1npoPDXFDZvh8tGSQqTq2XDkFw3OskOQsKLlv1E2g5Y6yP21U
 codgBqJlFz6IwTOZ+51Phr0uRWaDNhlrOiPaofeSVBjQLd0v8nLiNziEChMzdDa57V0e
 O/5AIoK2dadP3Bg8t9qYFesPBLrujmQlwH6g6YiNoMoVutA40nAoFG8SNuHpB9O+LfmW
 2Uj7hgu27N2CFC2mQxPTEeB9CzzqO89LWRiZf6IJGH0rNtmwhtNLhFNOFQYHAQX2e2Ho
 hGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748951449; x=1749556249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Umh+HP+YIzfm01oCuEnx3dxYDMzG774+Azq2vEn7vxI=;
 b=uTkcTZzlWUXttWYIL9LtcwHIliAsZc6GdN8EJc+QYEdakrc1bNlqP6mfZTgThC44x6
 v4sfVuvXYd1vaMexSXCA0Ugad1hzFPxs6beGDypMwE0VXIoWGUjwKZivuw1878gjRqPG
 gKqL0+/Wl+boPOrT67OglA53/LhbMzZEQG/sXeKRtKv35fcMlPeqOm8Ln9rUKfJHb0CC
 COf81s3fOQ8EQJCtu27yFh0VvOpYfidqHYv/jys+zANSPT8XboTADtExoiQbNEjmkjYd
 aFSz14hm/KEBwcRUWnRHu6Qn58dF7ahvRw57410GCkmsiq1gLdBgHzdQ3hgAQnoFDrZ5
 JeEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg6RYfXEByppeA8vrDXIGO2a+whuxpoAffio7+SYRbun8fse9EuPtYlJza9uy3X/NSea/raNjeFJbc@nongnu.org
X-Gm-Message-State: AOJu0Yx9vYrHxf5Gvd5Ptzd+l+JJYq7XSnxPe085g6qAZ9u0ZCDX+KPy
 IuAaSsowcT5B6YA9w1HNYT4hK3y3xXHVzrt88zbavI75cJ2VHAhDpEQXTMNLKZ3u1lo=
X-Gm-Gg: ASbGncuG+fg+dB+isMVnTuDpueN3l1l8dlJettYWpTmZD++hZCnODLf68kSlPkQVuKP
 g1b2ywgNXRWBZoOuQgptbsoh+IdLN07+Cht/J7NZUKOOJPQea+cyJefAOzn/AnIZIjJITZJiaxe
 MQm1EYq8zWeJy1Eh7X2IqkiLAZIU/GdDE1m9YU7MKzwtLn14tqgLPYgN/4mMxG65dqctLafWisJ
 mC+rrajkNryADtI7aDSn8QR4EdjQK++vToVUiX49f1zAiZ5Z5nCSAy6hFzUQwxTN8kcbdiN4W7T
 8+eZSUX8hefSFRD2mPdPV63EKFp++T894z0FA/eQjmE+mMrU35/VfcpSLh3GoIlBV2qpdMuQ+bT
 8rjz9xDuBBsGFaoxKD5ovxYObpDBZf3nsIZ29bf6047+3gQ==
X-Google-Smtp-Source: AGHT+IHjt7Prro2xyKHy1I9Z+o73vAJlUU0hBjTEZNIV6Mh8F35s9SR8F77axC2yXMBK1MEg1Z2QBw==
X-Received: by 2002:a05:600c:46cb:b0:450:d5f6:55f5 with SMTP id
 5b1f17b1804b1-450d882b463mr130586215e9.6.1748951449292; 
 Tue, 03 Jun 2025 04:50:49 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8012b09sm157144135e9.37.2025.06.03.04.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:50:48 -0700 (PDT)
Message-ID: <fb178d96-ee28-414c-a320-2b5b0ceee5e6@linaro.org>
Date: Tue, 3 Jun 2025 13:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] hw/pci-host/raven: Do not use parent object for
 mmcfg region
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <104976fab9e144328dd9c73efceeb75a759a83f7.1746374076.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <104976fab9e144328dd9c73efceeb75a759a83f7.1746374076.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 4/5/25 18:01, BALATON Zoltan wrote:
> The mmcfg field in PCIHostState is only used by raven for the PCI
> config direct access but is not actually needed as the memory region
> lifetime can be managed by the object given during init so use that
> and remove the unused field from PCIHostState.
> 

Well, this is the recommended way to avoid leaking MemoryRegions.

If QOM object allocates something, it should keep a reference to it,
allowing simpler eventual implementation of DeviceUnrealize handler.

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c       | 7 ++++---
>   include/hw/pci/pci_host.h | 1 -
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index c39e95b45f..7550c291c6 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -212,7 +212,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>       PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(dev);
> -    MemoryRegion *address_space_mem = get_system_memory();
> +    MemoryRegion *mr, *address_space_mem = get_system_memory();
>   
>       qdev_init_gpio_in(d, raven_change_gpio, 1);
>   
> @@ -229,9 +229,10 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>                             "pci-conf-data", 4);
>       memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
>   
> -    memory_region_init_io(&h->mmcfg, OBJECT(h), &raven_mmcfg_ops, h->bus,
> +    mr = g_new0(MemoryRegion, 1);
> +    memory_region_init_io(mr, OBJECT(h), &raven_mmcfg_ops, h->bus,
>                             "pci-mmcfg", 0x00400000);
> -    memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);
> +    memory_region_add_subregion(address_space_mem, 0x80800000, mr);
>   
>       memory_region_init_io(&s->pci_intack, OBJECT(s), &raven_intack_ops, s,
>                             "pci-intack", 1);
> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> index e52d8ec2cd..7c0285e2ff 100644
> --- a/include/hw/pci/pci_host.h
> +++ b/include/hw/pci/pci_host.h
> @@ -41,7 +41,6 @@ struct PCIHostState {
>   
>       MemoryRegion conf_mem;
>       MemoryRegion data_mem;
> -    MemoryRegion mmcfg;
>       uint32_t config_reg;
>       bool mig_enabled;
>       PCIBus *bus;


