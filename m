Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C1CC5B555
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQ7R-0003uc-8a; Tue, 03 Jun 2025 07:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQ7P-0003uN-Le
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:47:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQ7N-00087k-Gg
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:47:47 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451e24dfe1aso11312155e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748951261; x=1749556061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bxdX57L9XEsK0QR7hOg7ft63dzQoae0gdmj7vmM2cPI=;
 b=HDWbn/Ll3o9sWWxLgBUcQLyFRxfntApkFl/urDGJjngNWIyIJtPQ4vzBcgQSw44VKF
 ByIJ/IiObf2qE0ChJVxKogX8fVjuqv10nx59PGl5ZnNm9CJlC5QFEcHf8QIb7Xp10bNV
 /Hnk4xuaFVa5MgxRFY5+c2969c5J30am8me4Z5qH9/6RB5e8A5wyIZxK7WnkCgyRWH1r
 h83TLtTGvhZClYuAMjOp97zsc8qiFeTn6GTqPSIy1QUT+P2tQB40TUD56Yi293IoPlrc
 SSd8vWAFlyT/QhnR4dNkEsLxHEWCxWsGDEURGUL4wrvOZCXbUYDuPsKAhaK1O1fVu542
 MewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748951261; x=1749556061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxdX57L9XEsK0QR7hOg7ft63dzQoae0gdmj7vmM2cPI=;
 b=ETKTEbFH/NfSiq4TnSX9ftQcXitpgepm2hjNuekAZX2zKVW5WU7XTZJ/xIZIuncBrX
 Vez971eRj2+JJKVh7rmKTwuWz710FTRK8UBrfh7h5l912iCnW79t0Uk94VfQZwKZIq0J
 jEURp10pPnDPpK4CIa/WdbnGJjw7KD58yuOR/3JTVrbaFicdLKync8yfKEa+anewl3UE
 XFz99SnN523NCHKef0BBdLFs/AVPN2hkW0H1Y+Aiet9fnMCIf6lQmnyCnY8F7KFE6/6v
 g9vEYFB9bo0CMAgdZ2PGd9hhfaLgCma0LrDr1UztXdRSdZxDwBgAPIUy+8/9TI6lEJqW
 jhVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw750FxaLJhpDnXK8iw1PLLoPfAh+Hf7mH1JS7DayquL7lAGdybp9skV/jpMPuF8VP6JBpZaJngDnK@nongnu.org
X-Gm-Message-State: AOJu0Yw2pCd1CfYMuO12rU2vPkylUswhvQJUbqcRSFLq7M769IZy8p6s
 rcOa+4gEeZn590YJOCgBi58laRxEV0bjBbEozNq0UVpVf4Q6DIbjVeXsjy1+5n/QbN4=
X-Gm-Gg: ASbGncveTn3kC9M4VTddkWBzQsY7EIL6BLimbGH9wMXWOWQv1tD3LzJmcFldsVZ+9Q5
 +cVivjY3b6pIDNxnEHhnXmq8QkoT/P0+btOMiVua0r9VBXrixFFDfzfKZZAsXQI5iWcmwRHZf0c
 tMt5PjwtEzcD16wZ+ChSZqtLhfqTXyA+iCKPRYTKxeOc1SrJCa4YKYl1DEyasTHeoJ4vfdkIwMJ
 xQFoJsG6xUXUfBUCm5dP7kn5i5Pg8tsfijdSBtHtlD0VP+1laph8kMcdkbIG147sMJpmYs72cuj
 A7mqvY0vNjgDl9K6V2oWR6aZ7pXidAv+xGkSQjZHKkYwO2Q0dldvXAZmjiT/ebSGrvBzBwWfQBR
 Ndis1jMARjvXS1/asGLJlGtoZ
X-Google-Smtp-Source: AGHT+IE9JMPwIrj8+n2biBcvXLQWduHKUoaDT1l6HRAQmR6Nx8wFcHdZxAgKh+jGzxi0ETW3DUdaHQ==
X-Received: by 2002:a05:6000:420d:b0:3a3:7753:20ff with SMTP id
 ffacd0b85a97d-3a4f7a36f76mr13963084f8f.35.1748951261296; 
 Tue, 03 Jun 2025 04:47:41 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6cd15sm18300021f8f.39.2025.06.03.04.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:47:40 -0700 (PDT)
Message-ID: <edea1739-3ac8-452d-b1f6-41196be2f37f@linaro.org>
Date: Tue, 3 Jun 2025 13:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] hw/pci-host/raven: Use correct parameter in direct
 access ops
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <6205b7eb571626ccc7fb017132e705a49fa3a6ff.1746374076.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6205b7eb571626ccc7fb017132e705a49fa3a6ff.1746374076.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 4/5/25 18:01, BALATON Zoltan wrote:
> Instead of passing unneeded enclosing objects to the config direct
> access ops that only need the bus we can pass that directly thus
> simplifying the functions.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index d7a0bde382..c39e95b45f 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -65,16 +65,12 @@ static inline uint32_t raven_idsel_to_addr(hwaddr addr)
>   static void raven_mmcfg_write(void *opaque, hwaddr addr, uint64_t val,
>                                 unsigned int size)
>   {
> -    PREPPCIState *s = opaque;
> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> -    pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);

Something like this is clearer IMHO:

        PCIBus *hbus = opaque;

        pci_data_write(hbus, raven_idsel_to_addr(addr), val, size);

> +    pci_data_write(opaque, raven_idsel_to_addr(addr), val, size);
>   }
>   
>   static uint64_t raven_mmcfg_read(void *opaque, hwaddr addr, unsigned int size)
>   {
> -    PREPPCIState *s = opaque;
> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> -    return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);

Ditto.

> +    return pci_data_read(opaque, raven_idsel_to_addr(addr), size);
>   }
>   
>   static const MemoryRegionOps raven_mmcfg_ops = {
> @@ -233,7 +229,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>                             "pci-conf-data", 4);
>       memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
>   
> -    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_mmcfg_ops, s,
> +    memory_region_init_io(&h->mmcfg, OBJECT(h), &raven_mmcfg_ops, h->bus,
>                             "pci-mmcfg", 0x00400000);
>       memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);
>   

Casting the opaque:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


