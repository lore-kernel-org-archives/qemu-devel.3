Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4489AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZSz4-0000OS-RP; Thu, 01 Aug 2024 06:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZSz3-0000Nx-9F
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZSz1-0007Us-LL
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722507870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ue0bwFEg3ak0yzV0XsNJ0siyWMjbU6WQfndneOoCMuk=;
 b=DU2fkPPAqkNYELftSKEWoPRptaGURADRTb7IS8J221fQJB2hnGl0mOjfMHnYd9chysyo0C
 Y4kUQKUYDs4SfUulM1i0EghK2DFr21c7c3ejWlLNYemyNFW4bvqfuC8BNEw/844evNmjMR
 YXcRb3rVVID1an2KGwnHQmmn5Itc2bM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-nkNTA9JwM6Obw2W9BMUEQg-1; Thu, 01 Aug 2024 06:24:28 -0400
X-MC-Unique: nkNTA9JwM6Obw2W9BMUEQg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7a97665b8bso608390566b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722507867; x=1723112667;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ue0bwFEg3ak0yzV0XsNJ0siyWMjbU6WQfndneOoCMuk=;
 b=I3lYpdvHVxS9s8OEuGW87aq+Vk5LgINs4Uq/MTgwPS9AcKsUvHYE0T1weKvlMMIVYz
 eCUt+xFF5+oN73119d2wkvrDj/nElZkD/O+lAHMlWUfGlBKURhzjd040ei17Hn+UESwY
 kSOrZUhZfELO5eJG4QGBGBCAYSkaISdCx/BTvbgKxpUbl3648u2JwFjSRBYQyOmV9+x5
 EXJ3Kyfe4kpj4PTvhLcMSpB+5Wd/1WxE6P7SwyVR7eLSw4gg2ENSe/j4lecVVLYH/ZTj
 oVQbfbjFg6sMWoMeKo1G+XaC77w47JlJvPSQkY4QgG/4+JJphtoQcccS3LkIrLsu4nRR
 v4dA==
X-Gm-Message-State: AOJu0YyMEOFu2nX0iqh+M+2+JzmUmkKYL3h8yw/Gk8IxslPCTLQtGZ1n
 elPnWgvsdToXbP0Reqt6d7msuoE+z4ufIYiK3CQEcYQoZQKQnWCYRNfeR+wdv+vlqjP17RKFSqa
 oSCTO3g7jEeI+jRk/murG9eMnW9VRObA7DtkbTJDqoY5Ttw3Jb8rG
X-Received: by 2002:a17:906:bc17:b0:a7a:8c8d:40ac with SMTP id
 a640c23a62f3a-a7daf4fc972mr189976766b.4.1722507867542; 
 Thu, 01 Aug 2024 03:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQwhi431Q8HVpbAao4OELzZ1P4Ap3H0TaEpvhulQ/ixG1w3MbWTClbE0JFUG8X+dW9Ss+uvw==
X-Received: by 2002:a17:906:bc17:b0:a7a:8c8d:40ac with SMTP id
 a640c23a62f3a-a7daf4fc972mr189973866b.4.1722507866700; 
 Thu, 01 Aug 2024 03:24:26 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad90fe2sm879132966b.156.2024.08.01.03.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:24:25 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:24:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH-for-9.1] hw/pci-host/gt64120: Set PCI base address
 register write mask
Message-ID: <20240801062148-mutt-send-email-mst@kernel.org>
References: <20240801091332.49256-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801091332.49256-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 01, 2024 at 11:13:32AM +0200, Philippe Mathieu-Daudé wrote:
> When booting Linux we see:
> 
>   PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>   pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>   pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>   pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>   pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
>   pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
>   pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
>   pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
>   pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
> 
> This is due to missing base address register write mask.
> Add it to get:
> 
>   PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>   pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>   pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>   pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>   pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff pref]
>   pci 0000:00:00.0: reg 0x14: [mem 0x01000000-0x01000fff pref]
>   pci 0000:00:00.0: reg 0x18: [mem 0x1c000000-0x1c000fff]
>   pci 0000:00:00.0: reg 0x1c: [mem 0x1f000000-0x1f000fff]
>   pci 0000:00:00.0: reg 0x20: [mem 0x1be00000-0x1be00fff]
>   pci 0000:00:00.0: reg 0x24: [io  0x14000000-0x14000007]
> 
> Mention the datasheet referenced. Remove the "Malta assumptions ahead"
> comment since the reset values from the datasheet are used.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/pci-host/gt64120.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index e02efc9e2e..0b00e98e0a 100644
> --- a/hw/pci-host/gt64120.c
> +++ b/hw/pci-host/gt64120.c
> @@ -1,6 +1,8 @@
>  /*
>   * QEMU GT64120 PCI host
>   *
> + * (Datasheet GT-64120 Rev 1.4 from Sep 14, 1999)
> + *
>   * Copyright (c) 2006,2007 Aurelien Jarno
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining a copy
> @@ -1213,17 +1215,28 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
>  
>  static void gt64120_pci_realize(PCIDevice *d, Error **errp)
>  {
> -    /* FIXME: Malta specific hw assumptions ahead */
> +
> +    /* Values from chapter 17.16 "PCI Configuration" */
> +
>      pci_set_word(d->config + PCI_COMMAND, 0);
>      pci_set_word(d->config + PCI_STATUS,
>                   PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
>      pci_config_set_prog_interface(d->config, 0);
> +
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff009);
> +

If you make these writeable, then you should set them on reset,
as opposed to unrealize.


>      pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
>      pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
>      pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x1c000000);
>      pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x1f000000);
>      pci_set_long(d->config + PCI_BASE_ADDRESS_4, 0x14000000);
>      pci_set_long(d->config + PCI_BASE_ADDRESS_5, 0x14000001);
> +
>      pci_set_byte(d->config + 0x3d, 0x01);
>  }
>  
> -- 
> 2.45.2


