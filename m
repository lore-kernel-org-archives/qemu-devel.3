Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D95E6F08F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 13:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY2oR-0000kA-IS; Tue, 23 Dec 2025 08:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vY2oM-0000gK-JU
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 08:52:29 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vY2oL-0001rh-0R
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 08:52:26 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso34946795e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 05:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766497941; x=1767102741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u7wWlYmrAgO8bdyvhnML4oxM6/37y8Frcf8ePZRcyKI=;
 b=seBAGXVYhaksUzdb1A0G3EMARZoJayEcS5NHcjCV4eD5rsbISvHuHFaJo/ltAq05EG
 RLYJoBkI5HErlBwMPOtobnbNXEu9l/ABpRkQ1BvVDKzEGg16Pa9xNutR8/mKoOQNbRha
 /wL0VLOaiteMcfh8117qUOLJztnRGnmsZuapEoCrr7dM2yawoRvmXfnpK9Pb5AoLWP04
 pAeSSocHw8PBT4hlxzyJdjZxUaVX6kIA26y6b3Eu0Uy/Cnl62EYw7b2G64Hdsa0rWtBE
 hMBxF5MnWPGlkXVS3L7mkQaxoZtuHSe2L5b5coAlRSfYcUY/EhhViq/NVi1lvLR6EPxW
 poAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766497941; x=1767102741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u7wWlYmrAgO8bdyvhnML4oxM6/37y8Frcf8ePZRcyKI=;
 b=LexrXr4yxoyt0ZKWt20BYY5z6qLxJcg3f9TfJsxyG4KdOZqrul8vDpbCMSmwyBevD4
 zKtLrcoSAWRjWI3ThriB2n6asaUPaXH59i1JrG83q5YRywKX4bWdE4M1GW7Ireu1PiyB
 S1uszv9PZgQ7YZXDaJPrkj1wPEaXzCn5D8NvrhU2K3+R4Eka3o+FHrXenYEDTa18GbgF
 YbeiaGrd8OtaWZCAM6Reyi8zJpARscJodusiVXRPvpWqp2viW447Dw6dQ7rPp2cG9at6
 EwzzmrooGGhgew3k8BPE4Ge3ign6zHQ0ZVRy+Rx08CHjh8KAc7222XL8YKFtDmAWyNN2
 rdgA==
X-Gm-Message-State: AOJu0YyHQIzympsmh5hohdM/DDQtW1FY4eZZjKfpzV/zwnHKEzCgefNi
 ukouTRX+dAOnqTvxXWcpSH1zpy7A8d284Z01DifDoEnq7YfxQsOlTg37HFgjRWqJwBlZ2bKnOub
 syB0RZxY=
X-Gm-Gg: AY/fxX7YbAn2c8yHEssNKOOPznfPEW0FdcDosWXABPmxrsowdLfIuMpikVVNNRQ1UOq
 iZQWn/U67SSq/TZ9ZYaFy8kl4QLUtfvGVWbYNXaztCSKzCxZHVQd7ovpA7ZjUe3NvyXX1qqBdj4
 TtWvDeAADxAUSEhoQ9lL3lKEOPohYuCYCI0Rjk3nFOK8NRHOS479oAPhVPsQ80ZNncG/CuwVm/y
 kh8YfdoIrUtPXIoGS8FzxcYHF4Hu9V6vlA87pf10Au8pTtSYiFPzm9snoB+wK414C14ryIjXdfk
 e2GOHdVrFmQqSi8fq5Tiltvxa9Eo6Sn7UwV2ehKN0BrDJ8mCrZ4TsCGQILuMEL2bQUIAev8ZtbQ
 cDn8w36l5hjGSzR1V4rpl/nDSRjbFZ9GBuQTDj3hvmGR+9l8LHfpjiGoAbCZ74bx40n/Lw6/z0S
 Q+nEn/kotU11XzQJOSdrlpTmE1CsuLzIpc25OcIOsdNLFYQhDRRjlkIg==
X-Google-Smtp-Source: AGHT+IHY3b9w9/ffeZ+kRSrOgmP0cO1xsu23FCA/h21rxre0kJLpxgdQCz5l6p51Qr2qlyLo6/dLLA==
X-Received: by 2002:a05:600c:6299:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-47d1959ae49mr161903205e9.35.1766497941432; 
 Tue, 23 Dec 2025 05:52:21 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be26a81b6sm300752415e9.0.2025.12.23.05.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Dec 2025 05:52:20 -0800 (PST)
Message-ID: <3d5a30fd-fb49-42a1-ba1e-e2c4bfc58f83@linaro.org>
Date: Tue, 23 Dec 2025 14:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: Use correct bus aperture for device container size
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20251124114754.79831-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251124114754.79831-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

ping?

On 24/11/25 12:47, Philippe Mathieu-Daudé wrote:
> Before commit 3716d5902d7 ("pci: introduce a bus master container")
> device view of the bus address space was correctly sized to the
> bus aperture, but then it always used a 64-bit aperture. Restore
> the previous behavior, so devices on 32-bit PCI only see 32-bit
> address space.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci/pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b1eba348e06..64f33b9de04 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1375,7 +1375,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>       pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>   
>       memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
> -                       "bus master container", UINT64_MAX);
> +                       "bus master container",
> +                       memory_region_size(bus->address_space_mem));
>       address_space_init(&pci_dev->bus_master_as,
>                          &pci_dev->bus_master_container_region, pci_dev->name);
>       pci_dev->bus_master_as.max_bounce_buffer_size =


