Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C9AE6F06E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 16:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6uey-0001o1-Rv; Fri, 01 Nov 2024 12:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t6uev-0001lK-GN
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:38:01 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t6ues-0002MZ-Tp
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:38:01 -0400
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-53a097aa3daso2111289e87.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 09:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730479076; x=1731083876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tKrAZ+mKXrvBoNUf4MqRD6ioCmyK4Mh5D+Js5KbRj/0=;
 b=FvWiT5wKolrrqzk5DVEpDzdNJtD6jbpTT0ax3BNGRbLPXxbtiAg10xGoX86f4ZAn8+
 Zm557+bJWeSq05k96rVD0RUO7/JdSo0IEo3a+8eGPMhGii/KPlKi174Dvju3ndOSQdIE
 IeS80uOtv5U4rTqpHxRciQQgybI9sGI4LZDmlrJX6wgnSWq41/AcKqng4XqXvcgw1cvb
 QV725akGwsJcD5DSJO85Dt+ds2avLsP19Mn29ctK4NQc0JqV3eforevfPjXFOZ2eddVB
 lirJYf7UnYjYsMAI71Z2IMXGHbtI3xvg0kpfGg09uCEi1YpnQ7fCm2VSiA3i2hKtkEES
 82TA==
X-Gm-Message-State: AOJu0Yyjs6zbqDGa6ciyI9VgxKhVrzvb3mDBpRgWihTwXreEg4M73KpC
 sfi8okokzmPc/VHrK0dy8yf9tOa53fQIzTnbr8AT1w0wTaF4EvTH
X-Google-Smtp-Source: AGHT+IFwvEkqjYJlIbHsj3CtFZ0Z0uCBzvGW4Oy6+OeqH+GtACzWfjcT5VmaqCMXy4r4qjew+eU3FQ==
X-Received: by 2002:a05:6512:3b8c:b0:539:d22c:37bd with SMTP id
 2adb3069b0e04-53d65e02641mr2667007e87.36.1730479075374; 
 Fri, 01 Nov 2024 09:37:55 -0700 (PDT)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e7ca7sm66616845e9.24.2024.11.01.09.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 09:37:54 -0700 (PDT)
Date: Fri, 1 Nov 2024 17:37:53 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 09/36] next-cube: move SCSI CSRs from next-pc to the
 next-scsi device
Message-ID: <20241101173753.415f66b9@tpx1>
In-Reply-To: <a6df2717-e3b3-464e-87ca-d2c776d24900@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-10-mark.cave-ayland@ilande.co.uk>
 <20241028172122.23bcb98c@tpx1>
 <a6df2717-e3b3-464e-87ca-d2c776d24900@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.167.42; envelope-from=th.huth@gmail.com;
 helo=mail-lf1-f42.google.com
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

Am Mon, 28 Oct 2024 22:21:20 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> On 28/10/2024 16:21, Thomas Huth wrote:
> 
> > Am Wed, 23 Oct 2024 09:58:25 +0100
> > schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> >   
> >> The SCSI CSRs are located within the SCSI subsystem of the NeXT PC (Peripheral
> >> Contoller) which is now modelled as a separate QEMU device.
> >>
> >> Add a new VMStateDescription for the next-scsi device to enable the SCSI CSRs
> >> to be migrated.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> ---
> >>   hw/m68k/next-cube.c | 88 +++++++++++++++++++++++++++++++++++++++------
> >>   1 file changed, 78 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> >> index 266f57ac63..32466a425f 100644
> >> --- a/hw/m68k/next-cube.c
> >> +++ b/hw/m68k/next-cube.c
> >> @@ -93,6 +93,10 @@ struct NeXTSCSI {
> >>       MemoryRegion scsi_mem;
> >>   
> >>       SysBusESPState sysbus_esp;
> >> +
> >> +    MemoryRegion scsi_csr_mem;
> >> +    uint8_t scsi_csr_1;
> >> +    uint8_t scsi_csr_2;
> >>   };
> >>   
> >>   #define TYPE_NEXT_PC "next-pc"
> >> @@ -115,8 +119,6 @@ struct NeXTPC {
> >>       uint32_t led;
> >>   
> >>       NeXTSCSI next_scsi;
> >> -    uint8_t scsi_csr_1;
> >> -    uint8_t scsi_csr_2;
> >>   
> >>       qemu_irq scsi_reset;
> >>       qemu_irq scsi_dma;
> >> @@ -364,6 +366,7 @@ static const MemoryRegionOps next_mmio_ops = {
> >>   static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
> >>   {
> >>       NeXTPC *s = NEXT_PC(opaque);
> >> +    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
> >>       uint64_t val;
> >>   
> >>       switch (addr) {
> >> @@ -373,12 +376,12 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
> >>           break;
> >>   
> >>       case 0x14020:
> >> -        DPRINTF("SCSI 4020  STATUS READ %X\n", s->scsi_csr_1);
> >> -        val = s->scsi_csr_1;
> >> +        DPRINTF("SCSI 4020  STATUS READ %X\n", ns->scsi_csr_1);
> >> +        val = ns->scsi_csr_1;
> >>           break;
> >>   
> >>       case 0x14021:
> >> -        DPRINTF("SCSI 4021 STATUS READ %X\n", s->scsi_csr_2);
> >> +        DPRINTF("SCSI 4021 STATUS READ %X\n", ns->scsi_csr_2);
> >>           val = 0x40;
> >>           break;
> >>   
> >> @@ -411,6 +414,7 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
> >>                                unsigned size)
> >>   {
> >>       NeXTPC *s = NEXT_PC(opaque);
> >> +    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
> >>   
> >>       switch (addr) {
> >>       case 0x14108:
> >> @@ -445,7 +449,7 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
> >>               DPRINTF("SCSICSR Reset\n");
> >>               /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
> >>               qemu_irq_raise(s->scsi_reset);
> >> -            s->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
> >> +            ns->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
> >>               qemu_irq_lower(s->scsi_reset);
> >>           }
> >>           if (val & SCSICSR_DMADIR) {
> >> @@ -838,6 +842,54 @@ static void nextscsi_write(void *opaque, uint8_t *buf, int size)
> >>       nextdma_write(opaque, buf, size, NEXTDMA_SCSI);
> >>   }
> >>   
> >> +static void next_scsi_csr_write(void *opaque, hwaddr addr, uint64_t val,
> >> +                                unsigned size)
> >> +{
> >> +    NeXTSCSI *s = NEXT_SCSI(opaque);
> >> +
> >> +    switch (addr) {
> >> +    case 0:
> >> +        s->scsi_csr_1 = val;
> >> +        break;
> >> +
> >> +    case 1:
> >> +        s->scsi_csr_2 = val;
> >> +        break;  
> > 
> > The old code never set the scsi_csr_x directly like this, so I'm not sure
> > whether this is right?  
> 
> Well I initially did this on a hunch that something had gone wrong with an earlier 
> refactoring, but I just did a quick check with Previous and it also treats them as 
> normal registers (see 
> https://sourceforge.net/p/previous/code/HEAD/tree/trunk/src/esp.c#l160). So I think 
> this should be fine for now?

Ok, fine for me, but then please mention it in the commit description!

> > Also, maybe best squash this patch together with the next patch, otherwise
> > this is temporary change in behaviour, isn't it?  
> 
> If possible could I keep it as-is? It just means there is separation between the 
> change of the memory region topology and then consolidating the SCSI CSR access 
> routines in the following patch.

Sure, it was just a suggestion! Keep it separate if you prefer it that way.

 Thomas

