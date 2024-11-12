Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9883D41D5E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 06:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAkRx-00015T-HA; Tue, 12 Nov 2024 01:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAkRt-000154-CI
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 01:32:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAkRp-0002Xe-Jf
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 01:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731393139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0L/CgHHNNublx3TCfAwMAujjV8DdXdezaQK/9h7mk1A=;
 b=GmNzqreUS3wubJV6rT9WFHMERG+/b/YHCYraFzBau/o8N8GVB7VMI/FXa9wrlH7mBtthA9
 ZmkG9EjdBS/SZDddHWUcClgPjoKJR6aTQpeaunZcYmSlFP55ksiT1gbt2wkDJ6MgrljyOW
 M8EUZR2aGkdfw9H9nahk+1ecpZceJr0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-7Du0BpBpOjKRw1ZC7U56_A-1; Tue, 12 Nov 2024 01:32:16 -0500
X-MC-Unique: 7Du0BpBpOjKRw1ZC7U56_A-1
X-Mimecast-MFC-AGG-ID: 7Du0BpBpOjKRw1ZC7U56_A
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a9a1e429a8fso430954466b.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 22:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731393136; x=1731997936;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0L/CgHHNNublx3TCfAwMAujjV8DdXdezaQK/9h7mk1A=;
 b=VuNWVzJ5s0tErHqX3WQa7bQ95RTFEPM5TwjQG3Zmo4y0kh2jRyXBdiWQ8yY7+O/SBB
 SOtlYAVnRBapnyehgmopbf9qoIefPh+kjmA/ZIzR4AV+a83eUQC+/xBqmDTYIwbZuY5t
 GtkE3umglE4dCOPJoZHWsQn3m8SAG5RVc3ozokzzLbjxlB5fpU1F9lDYG5FOqCoqNC4y
 rdQa0NeOUXJhTMBfre6kbZ4a27szmzVFKCVKtg9maUXe5QFmHfG2fPvONr9wQxNj962o
 V+DVPc3q1Q1gYAgU5a8t0S5I3Fx6dL/B9PtWfe61oxZFW4f0lXlYzz6bnZs5lfGjPDCF
 Ta6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXIkGhQhVdYthtdudoJKrogPqf9u0qPhNJzhRKuZOCG04E0fEMnVgd6WhD/2XAPdMa9QQ3sjN8DtlS@nongnu.org
X-Gm-Message-State: AOJu0YxXn/hh8Jir68/Hi1JWNGBiEosleq8Ivw5voP5xvnwIoZPDRuiE
 3v/ChdDcv3s89Y/i2P9vhtJwuWK1bNPuMdfxwuomUFBEUXL1asClTY9zb0IsiuTqefWGoqNlVrH
 CkcJ0Gr9xx0SbIGhExGy4P9m/sGSy8vVCyY3TwHU5XVMXIMfzKJl0e1HDM7C1
X-Received: by 2002:a17:907:a4b:b0:a9a:dfa5:47d2 with SMTP id
 a640c23a62f3a-a9ef0019726mr1479030166b.59.1731393135679; 
 Mon, 11 Nov 2024 22:32:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx+13WME3QNoQwaL/dY5bh0KBsJmaxhLcrmMCUcGrw/PvKLJN+Fjj0GMz7UX2X8IgyABw76Q==
X-Received: by 2002:a17:907:a4b:b0:a9a:dfa5:47d2 with SMTP id
 a640c23a62f3a-a9ef0019726mr1479028666b.59.1731393135305; 
 Mon, 11 Nov 2024 22:32:15 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-175.web.vodafone.de.
 [109.42.50.175]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a18854sm685703166b.29.2024.11.11.22.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 22:32:14 -0800 (PST)
Message-ID: <2a318a7f-dd37-4fce-9106-7a85236c9408@redhat.com>
Date: Tue, 12 Nov 2024 07:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/8] usb/uhci: Move PCI-related code into a separate
 file
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
References: <20240906122542.3808997-1-linux@roeck-us.net>
 <20240906122542.3808997-4-linux@roeck-us.net>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240906122542.3808997-4-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

On 06/09/2024 14.25, Guenter Roeck wrote:
> Some machines (like Aspeed ARM) only have a sysbus UHCI controller.
> The current UHCI implementation only supports PCI based UHCI controllers.
> Move the UHCI-PCI device code into a separate file so that it is possible
> to create a sysbus UHCI device without PCI dependency.

  Hi Guenter,

I think there's a bug in here ...

> diff --git a/hw/usb/vt82c686-uhci-pci.c b/hw/usb/vt82c686-uhci-pci.c
> index 6162806172..7fdb4697f9 100644
> --- a/hw/usb/vt82c686-uhci-pci.c
> +++ b/hw/usb/vt82c686-uhci-pci.c
> @@ -1,17 +1,17 @@
>   #include "qemu/osdep.h"
>   #include "hw/irq.h"
>   #include "hw/isa/vt82c686.h"
> -#include "hcd-uhci.h"
> +#include "hcd-uhci-pci.h"
>   
>   static void uhci_isa_set_irq(void *opaque, int irq_num, int level)
>   {
> -    UHCIState *s = opaque;
> +    UHCIPCIState *s = opaque;

You use UHCIPCIState as parameter for the irq-related functions...

>       via_isa_set_irq(&s->dev, 0, level);
>   }
>   
>   static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
>   {
> -    UHCIState *s = UHCI(dev);
> +    UHCIPCIState *s = UHCI_PCI(dev);
>       uint8_t *pci_conf = s->dev.config;
>   
>       /* USB misc control 1/2 */
> @@ -21,12 +21,12 @@ static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
>       /* USB legacy support  */
>       pci_set_long(pci_conf + 0xc0, 0x00002000);
>   
> -    usb_uhci_common_realize(dev, errp);
> -    object_unref(s->irq);
> -    s->irq = qemu_allocate_irq(uhci_isa_set_irq, s, 0);
> +    usb_uhci_common_realize_pci(dev, errp);
> +    object_unref(s->state.irq);
> +    s->state.irq = qemu_allocate_irq(uhci_isa_set_irq, &s->state, 0);

... but you set it up with UHCIInfo as parameter here. I think this line 
should rather be:

     s->state.irq = qemu_allocate_irq(uhci_isa_set_irq, s, 0);

Shouldn't it?

  Thomas


