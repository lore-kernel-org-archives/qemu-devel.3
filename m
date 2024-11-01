Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCF7E6F06E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 16:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ucF-0000gr-Qc; Fri, 01 Nov 2024 12:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t6uc5-0000e7-HQ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:35:05 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t6uc2-00022K-WA
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:35:05 -0400
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so1208731f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 09:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730478900; x=1731083700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qgAu7qX8AdiRejp/9fk3koV0b20KYj8K8ot6PqfgLT4=;
 b=TKIB4ynGLzgr5fAw6YRyDYVwjy5O0n0xQ8ttBkqh03PUPREKj5ArUaC//GsJPQ6Jhz
 mtuIyJnHekrQs9owLlxAloc5BtwYSZ/TcsLYZGe+knLGsRd8+4awZ5rEDdsO7r0MDehs
 VnISXzIgnxlNeyWbnpVwgYKgsW03uF/NUBWTSNSp2Ig1ncmK5Y0wj3lrTej4lot4zCKx
 7UVKpfWEssR2434wdFUzpLAJzIWf7GEY9STjg8Z3DHb/K+xPO2qBvqnXQw7LqmheATPW
 cU8Hh8aLHDMHwQ1fIIHGU0VAw08GA/Yrc+fpBn2GTYWiymullcx61A5SJp4AxdfstFzd
 BxCw==
X-Gm-Message-State: AOJu0Yz3B4PEn5BhVg8AEbdKnKQux7vV88spknNuE055rhhBJHgEM55i
 +iZygM/yuLBMFLamRAZObmsj39C9zlBVGNrJRE43IO3y9pCUMFKQWa+gsA==
X-Google-Smtp-Source: AGHT+IEJn2YWvapYT3iU57lYPJ9SpZNxeHHJSkgLwPPiKzkrSRSSpxGK2axpx8juqnhnstvQYMYsWg==
X-Received: by 2002:a5d:6c69:0:b0:37e:eee5:80dc with SMTP id
 ffacd0b85a97d-381c14efbe8mr5853423f8f.28.1730478900277; 
 Fri, 01 Nov 2024 09:35:00 -0700 (PDT)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113dd95sm5662685f8f.83.2024.11.01.09.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 09:34:59 -0700 (PDT)
Date: Fri, 1 Nov 2024 17:34:58 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 13/36] next-cube: move ESCC to be QOM child of next-pc
 device
Message-ID: <20241101173458.5783e800@tpx1>
In-Reply-To: <0e056742-396c-4bc8-91a8-e0a9a4dfb805@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-14-mark.cave-ayland@ilande.co.uk>
 <20241028173939.6fada306@tpx1>
 <0e056742-396c-4bc8-91a8-e0a9a4dfb805@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.221.47; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f47.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Mon, 28 Oct 2024 22:28:58 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> On 28/10/2024 16:39, Thomas Huth wrote:
> > Am Wed, 23 Oct 2024 09:58:29 +0100
> > schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> >   
> >> Since the ESCC is part of the next-pc device, move the ESCC to be a QOM child
> >> of the next-pc device.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> ---
> >>   hw/m68k/next-cube.c | 54 ++++++++++++++++++++++-----------------------
> >>   1 file changed, 26 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> >> index 7f714640da..915dd80f6f 100644
> >> --- a/hw/m68k/next-cube.c
> >> +++ b/hw/m68k/next-cube.c
> >> @@ -124,6 +124,8 @@ struct NeXTPC {
> >>       qemu_irq scsi_reset;
> >>       qemu_irq scsi_dma;
> >>   
> >> +    ESCCState escc;
> >> +
> >>       NextRtc rtc;
> >>   };
> >>   
> >> @@ -978,31 +980,6 @@ static const MemoryRegionOps next_floppy_ops = {
> >>       .endianness = DEVICE_BIG_ENDIAN,
> >>   };
> >>   
> >> -static void next_escc_init(DeviceState *pcdev)
> >> -{
> >> -    NeXTPC *next_pc = NEXT_PC(pcdev);
> >> -    DeviceState *dev;
> >> -    SysBusDevice *s;
> >> -
> >> -    dev = qdev_new(TYPE_ESCC);
> >> -    qdev_prop_set_uint32(dev, "disabled", 0);
> >> -    qdev_prop_set_uint32(dev, "frequency", 9600 * 384);
> >> -    qdev_prop_set_uint32(dev, "it_shift", 0);
> >> -    qdev_prop_set_bit(dev, "bit_swap", true);
> >> -    qdev_prop_set_chr(dev, "chrB", serial_hd(1));
> >> -    qdev_prop_set_chr(dev, "chrA", serial_hd(0));
> >> -    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
> >> -    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
> >> -
> >> -    s = SYS_BUS_DEVICE(dev);
> >> -    sysbus_realize_and_unref(s, &error_fatal);
> >> -    sysbus_connect_irq(s, 0, qdev_get_gpio_in(pcdev, NEXT_SCC_I));
> >> -    sysbus_connect_irq(s, 1, qdev_get_gpio_in(pcdev, NEXT_SCC_DMA_I));
> >> -
> >> -    memory_region_add_subregion(&next_pc->scrmem, 0x18000,
> >> -                                sysbus_mmio_get_region(s, 0));
> >> -}
> >> -
> >>   static void next_pc_reset(DeviceState *dev)
> >>   {
> >>       NeXTPC *s = NEXT_PC(dev);
> >> @@ -1043,6 +1020,28 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
> >>       /* Floppy */
> >>       memory_region_add_subregion(&s->scrmem, 0x14108,
> >>                                   &s->floppy_mem);
> >> +
> >> +    /* ESCC */
> >> +    d = DEVICE(object_resolve_path_component(OBJECT(dev), "escc"));
> >> +    qdev_prop_set_uint32(d, "disabled", 0);
> >> +    qdev_prop_set_uint32(d, "frequency", 9600 * 384);
> >> +    qdev_prop_set_uint32(d, "it_shift", 0);
> >> +    qdev_prop_set_bit(d, "bit_swap", true);
> >> +    qdev_prop_set_chr(d, "chrB", serial_hd(1));
> >> +    qdev_prop_set_chr(d, "chrA", serial_hd(0));
> >> +    qdev_prop_set_uint32(d, "chnBtype", escc_serial);
> >> +    qdev_prop_set_uint32(d, "chnAtype", escc_serial);
> >> +
> >> +    sbd = SYS_BUS_DEVICE(d);
> >> +    if (!sysbus_realize(sbd, errp)) {
> >> +        return;
> >> +    }
> >> +    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(dev, NEXT_SCC_I));
> >> +    sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(dev, NEXT_SCC_DMA_I));
> >> +
> >> +    memory_region_add_subregion(&s->scrmem, 0x18000,
> >> +                                sysbus_mmio_get_region(sbd, 0));  
> > 
> > You could also keep the next_escc_init() function, and call next_escc_init()
> > here?  
> 
> Normally a non-QOM _init() function suffix is used to both init() and realize() a 
> device, whereas here since the ESCC device is a child of the next-pc device these 
> operations must be separate. I think I can see why this convention is used elsewhere 
> in the codebase, as otherwise you end up calling a function with a _init() prefix 
> from _realize() which can get confusing with respect to the QOM model...

Ok, fair point, then let's keep this patch as it is!

 Thomas

