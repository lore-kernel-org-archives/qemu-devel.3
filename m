Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ED2CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDPFE-0008N9-60; Mon, 27 Oct 2025 11:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDPEy-0008Lx-6W
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:34:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDPEp-0007Rg-C0
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:34:35 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-427007b1fe5so4113255f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761579260; x=1762184060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yyaNuhiP0oSyhP5qe6kD2aU8TGlSMCfflWmebAij0a8=;
 b=ki65l7MXHe9d8jSWdY0rxddmYGYcrbRK/Uhm1CGoaEffA9/3+goydykcKXV5LLlETR
 HbCDZS/Vgf5ETDtKwt14GZQUXIxu9BgPomgOrgr45IUUNBKg/SzWwOhqgTmzqwqpq/kd
 e72N4Vu8jBPaeuqjh1zmUOTnggi8izm0V1NzHcdmcl0ptLf4cAxLg2gVvMDJxfxfh6i/
 W1lTWYR3aXUlptVcNIeLQi1eGsTu3M+HCbrH1Tfa4YNKKnlJdv/J2THDXOx4wWrILQyh
 dMZd3pfANJzcFbfiP8tDE6OGKEtCCf8k6UQngJEpOprrFrJoFwt5cfB5Zw5zWDPmFzix
 nHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761579260; x=1762184060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yyaNuhiP0oSyhP5qe6kD2aU8TGlSMCfflWmebAij0a8=;
 b=Gc5ESe/iVAb0ydJpbQhEfoWGqcYzkf7+DNXDpfEfjhjJs6JECS0HUyIOKsad1pYP5R
 kDWRY3x/2Uw6EO6MmEw0tTeC6fnPBvG6MKoK/C9b/OMrcoK6JU1D/BZJD2tF9tKDR/J0
 qCwwFxWpmzzp6eDzoc5SuXgYF1T7YKUTtcqr89EQSf+eAOy4+lahaqPR7PG+7p/gY0ML
 c49wmRFKD8FWfGnb7QT8XwvliyUOQjvDhOjV7VpbRyU9MQDSjueY65TiO7jWxKUtInFY
 +YJcFUIAyMA7MKy5xQxvhzdnzYVONA6Dsq2jdM9kOodkg6/yhYB1R/t7+9djmAce0jb5
 m08A==
X-Gm-Message-State: AOJu0Yy9t9G7n/gpdSiAU6NpN1+d1aGcXVeC/jtqssoAVhv0b8wxKxb6
 GeF0kp0nxZKMZiRa4hWWinIalDTF2Ok6lsIL7t9IU970XUV3n2BThwgYVqjP3smd5BwUhQfGavG
 4vxbf83Q=
X-Gm-Gg: ASbGncu93c+CJVWCnAyhoe62FuXVD5DpiGcfTJH9JI2drHyeXtsvQQVjQE8Qe8erxNc
 kzHs3XYBQn8st7BDuzLSXACxFAJ+e2k72DSKVKAF+6/DiVvlZqRBCsLN8PWIipuRbMwAMHqx4lg
 DMYg1Zw7OTsJIv9D1wnAx8Gf6nMOb8fu9M8gZnMEA/Qul4jlgAyOsdcLdKr43Xxmbkonu4KIH47
 XJIV/sIWQhTDqfqXsLuy1zoO88NcwaD2KV3LkrretRhL9ohuDicoZrXygeOnIAxA9Ob81OA3szL
 72XTVi7MhM3IqOAykWCsmB18B0v8Q5nB8qWqH3gL+rVn7N+2Lt28Zsy/Hl/j7ql8mIt66pEV1lu
 uBk1yfnchCLzJknZTPHSFFsLU8QTJRhRtKawFf37QkF7KFccU6TrkGV5fEVuFRCXmw5n+GB4Qt1
 in+gSFZFmt+wcRzhhSm75lKxMONaatBuoxz9xtcKT8NTY=
X-Google-Smtp-Source: AGHT+IE89s3inf6BUysdQlehTsNXu0uHeAZxKaGhDON/SkpiSPaBhv9DSaYS0bIJKgYiBL497eiRUA==
X-Received: by 2002:a5d:5d02:0:b0:401:e7a8:5c8d with SMTP id
 ffacd0b85a97d-429a7e52b37mr113805f8f.6.1761579260082; 
 Mon, 27 Oct 2025 08:34:20 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb55asm14902131f8f.17.2025.10.27.08.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 08:34:19 -0700 (PDT)
Message-ID: <63200028-6c8f-4380-ad5a-48b18d8c3964@linaro.org>
Date: Mon, 27 Oct 2025 16:34:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/pci-host/dino: Re-use generic pci_host_data_le_ops
 MemoryRegionOps
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Helge Deller <deller@gmx.de>
References: <20251027133037.70487-1-philmd@linaro.org>
 <20251027133037.70487-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027133037.70487-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 27/10/25 14:30, Philippe Mathieu-Daudé wrote:
> Avoid duplicating code, clear the "config-reg-check-high-bit"
> property in .instance_init() in order to re-use the generic
> pci_host_data_le_ops MemoryRegionOps.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci-host/dino.c | 30 ++++++++----------------------
>   1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
> index 924053499c1..e317167dbfa 100644
> --- a/hw/pci-host/dino.c
> +++ b/hw/pci-host/dino.c
> @@ -302,27 +302,6 @@ static const VMStateDescription vmstate_dino = {
>       }
>   };
>   
> -/* Unlike pci_config_data_le_ops, no check of high bit set in config_reg.  */
> -
> -static uint64_t dino_config_data_read(void *opaque, hwaddr addr, unsigned len)
> -{
> -    PCIHostState *s = opaque;
> -    return pci_data_read(s->bus, s->config_reg | (addr & 3), len);
> -}
> -
> -static void dino_config_data_write(void *opaque, hwaddr addr,
> -                                   uint64_t val, unsigned len)
> -{
> -    PCIHostState *s = opaque;
> -    pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
> -}
> -
> -static const MemoryRegionOps dino_config_data_ops = {
> -    .read = dino_config_data_read,
> -    .write = dino_config_data_write,
> -    .endianness = DEVICE_LITTLE_ENDIAN,
> -};
> -
>   static uint64_t dino_config_addr_read(void *opaque, hwaddr addr, unsigned len)
>   {
>       DinoState *s = opaque;
> @@ -410,6 +389,12 @@ static void dino_pcihost_reset(DeviceState *dev)
>       s->toc_addr = 0xFFFA0030; /* IO_COMMAND of CPU */
>   }
>   
> +static void dino_pcihost_instance_init(Object *obj)
> +{
> +    object_property_set_bool(obj, "config-reg-check-high-bit", false,
> +                             &error_fatal);
> +}
> +
>   static void dino_pcihost_realize(DeviceState *dev, Error **errp)
>   {
>       DinoState *s = DINO_PCI_HOST_BRIDGE(dev);
> @@ -424,7 +409,7 @@ static void dino_pcihost_realize(DeviceState *dev, Error **errp)
>                             &dino_config_addr_ops, DEVICE(s),
>                             "pci-conf-idx", 4);
>       memory_region_init_io(&phb->data_mem, OBJECT(phb),
> -                          &dino_config_data_ops, DEVICE(s),
> +                          &pci_host_data_le_ops, DEVICE(s),

Pre-existing but better to pass the correct opaque type:

                              &pci_host_data_le_ops, phb,

>                             "pci-conf-data", 4);
>       memory_region_add_subregion(&s->this_mem, DINO_PCI_CONFIG_ADDR,
>                                   &phb->conf_mem);
> @@ -505,6 +490,7 @@ static const TypeInfo dino_pcihost_info = {
>       .name          = TYPE_DINO_PCI_HOST_BRIDGE,
>       .parent        = TYPE_PCI_HOST_BRIDGE,
>       .instance_size = sizeof(DinoState),
> +    .instance_init = dino_pcihost_instance_init,
>       .class_init    = dino_pcihost_class_init,
>   };
>   


