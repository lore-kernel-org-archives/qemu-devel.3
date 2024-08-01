Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52ADC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXLY-0001Ly-LQ; Thu, 01 Aug 2024 11:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZXLV-000199-8S
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZXLT-0005pU-NR
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722524639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=harx82TFcoQIcECbfllH51jR31LaBjnkPeCc/sWUtbY=;
 b=Qhvy1x0Ig7zvUJpH3eXmtYrzqFJ8YyRZV5tfNfHdrlRwDBG4jmE7MHd5Mfjg6AEF7Syf2m
 ljTMzUmbKIVKR0JEXSW6RGN4hUX7Lzs/R+L3dKIDC8TNh5tdekQ8sZSKx/64pavGgmONi/
 NsMopO3TY/mzLsm3EI0e35tv8BFsu5Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-lLrg6CXmOTydQlx63B1sQA-1; Thu, 01 Aug 2024 11:03:57 -0400
X-MC-Unique: lLrg6CXmOTydQlx63B1sQA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7a97665b8bso632238766b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722524636; x=1723129436;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=harx82TFcoQIcECbfllH51jR31LaBjnkPeCc/sWUtbY=;
 b=k2sHClhDOZ1wZ9kvk0blpFNUTVPV6NTHXL86FET5kPgk9+R7CTjXRN5Ogi/PFfgsGU
 o+kDnj7+duXC95zSMyYP4FiaqEDZHbraodOXTAhIZkwnGvijjT1D0RDULYkWdRjnn4Tp
 DuDzHWWqKfEUHLahdxJtxbyjn9APptFq8CkQyCt4x9AKI3s11q2JPW9eqI3U4QjIfQGW
 Le5GTgQAtQS2H8FVEg6M5GjwEGDgaBE2PR5LvNRigjc3NO+scBG6XhpaldwrKzzBtT16
 Uuvofuxcryn/burmcamvwI2QRBUzLAxHudSx7Ba5aUq8eVfej/RpSK5RSFy9CdO81Qki
 eYIw==
X-Gm-Message-State: AOJu0YzqXnlzQiWf67p4+GEX7N5Myv/zmIJfeFoy2EdddihSLKCSSpvJ
 08pLoTQFaSHl/Gg+L6QxoEC1J9UNv56xV1ic6ixViXyOcSL3N6PqMd7Vne4F6G5klo5ljT6/a0R
 IBJICD0PwxS1/KO6/NncKINbMBpAu5dzLC3F1Ukyj6xlE3zkcugOfgRQDyTGs
X-Received: by 2002:a17:907:7b8a:b0:a77:cca9:b21c with SMTP id
 a640c23a62f3a-a7dc4e8c3e5mr43552066b.34.1722524636051; 
 Thu, 01 Aug 2024 08:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLMvB3/EgsWlvqMCYloPyjYaSNTjWknhDo23OoG1WCL7rExqqiOE6lKd5+KQ6UrstqZgxhzA==
X-Received: by 2002:a17:907:7b8a:b0:a77:cca9:b21c with SMTP id
 a640c23a62f3a-a7dc4e8c3e5mr43542666b.34.1722524634952; 
 Thu, 01 Aug 2024 08:03:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab2388bsm910084066b.45.2024.08.01.08.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:03:54 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:03:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH-for-9.1 v2 2/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
Message-ID: <20240801110338-mutt-send-email-mst@kernel.org>
References: <20240801145630.52680-1-philmd@linaro.org>
 <20240801145630.52680-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801145630.52680-3-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 01, 2024 at 04:56:30PM +0200, Philippe Mathieu-Daudé wrote:
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
>  hw/pci-host/gt64120.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index b68d647753..344baf55db 100644
> --- a/hw/pci-host/gt64120.c
> +++ b/hw/pci-host/gt64120.c
> @@ -1224,6 +1224,13 @@ static void gt64120_pci_reset_hold(Object *obj, ResetType type)
>                   PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
>      pci_config_set_prog_interface(d->config, 0);
>  
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff001);
> +

weird to change wmask on reset.

>      pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
>      pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
>      pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x1c000000);
> -- 
> 2.45.2


