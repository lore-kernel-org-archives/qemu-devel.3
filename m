Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86621D10C1B
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 11:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t51Nv-0005sg-18; Sun, 27 Oct 2024 07:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t51Nt-0005sD-AB
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 07:24:37 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t51Nq-00039J-Sc
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 07:24:37 -0400
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5c99be0a4bbso4667493a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 04:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730028273; x=1730633073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JiaI/LEjVZSwrF2eCX6EEsFR32GthU64ZnXXEII8Sk=;
 b=SdleizYDpk0ZcQWr+L60cG5DAczgcHJ2TW44fX5nqnN1nei3u4IU4kbLmXMB4PwvgT
 gqI9Cp7oLMo+utjbtoy/JpqQNtB+nD+7CEKb6MIFMwJRLeLvLBEnqjWrEH7Pm8R2cWz9
 9OpRyXcHQ42tcakDIcG7qq+hokjahJb4FypyfNTw+I6yZSEucHYiL3w14tD957WqwtdG
 v8Q8hynfE1xypc8e1xy7mmj0ft5MgG6VqWWRCFCI79Ye698MMkPOS8g7kmLu8IGkHy+Q
 Rb6tYAoXDN53nmPBYwZcEhzkdBZbro8CsG03AlOP+QJcXGGSJEbcdhjMPPBUZEJk11qN
 lbBA==
X-Gm-Message-State: AOJu0YwPiIILUi7YgaYeP6jN07LKU0QnZUgegWHBGza1OPJahgeXaM1q
 fHcLScXgMH4JpkhjXt7gysG5v0HVQMvgAT+NdIqk8iWzTyTF1iyDmvmqMA==
X-Google-Smtp-Source: AGHT+IF4acxYE6OSEpxCC3D2oA97zdZPrRww6VCKn6CmKjwldxrZXzf/sPqdG4cGNaQa6t2BngL42w==
X-Received: by 2002:a05:6402:40c7:b0:5ca:e4e:59d6 with SMTP id
 4fb4d7f45d1cf-5cbbfa5483bmr3972485a12.26.1730028272895; 
 Sun, 27 Oct 2024 04:24:32 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb62c3646sm2286622a12.47.2024.10.27.04.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 04:24:31 -0700 (PDT)
Date: Sun, 27 Oct 2024 12:24:29 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 03/36] next-cube: remove overlap between next.dma and
 next.mmio memory regions
Message-ID: <20241027122429.50163254@tpx1>
In-Reply-To: <80f404f7-a8e7-4fcc-8e7d-d82d285113e5@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-4-mark.cave-ayland@ilande.co.uk>
 <20241026095648.15865fbb@tpx1>
 <80f404f7-a8e7-4fcc-8e7d-d82d285113e5@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.41; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f41.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
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

Am Sat, 26 Oct 2024 22:13:25 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> On 26/10/2024 08:56, Thomas Huth wrote:
> 
> > Am Wed, 23 Oct 2024 09:58:19 +0100
> > schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> >   
> >> Change the start of the next.mmio memory region so that it follows on directly
> >> after the next.dma memory region, adjusting the address offsets in
> >> next_mmio_read() and next_mmio_write() accordingly.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> ---
> >>   hw/m68k/next-cube.c | 28 ++++++++++++++--------------
> >>   1 file changed, 14 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> >> index 4e8e55a8bd..e1d94c1ce0 100644
> >> --- a/hw/m68k/next-cube.c
> >> +++ b/hw/m68k/next-cube.c
> >> @@ -266,23 +266,23 @@ static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
> >>       uint64_t val;
> >>   
> >>       switch (addr) {
> >> -    case 0x7000:
> >> +    case 0x2000:
> >>           /* DPRINTF("Read INT status: %x\n", s->int_status); */
> >>           val = s->int_status;
> >>           break;
> >>   
> >> -    case 0x7800:
> >> +    case 0x2800:
> >>           DPRINTF("MMIO Read INT mask: %x\n", s->int_mask);
> >>           val = s->int_mask;
> >>           break;
> >>   
> >> -    case 0xc000 ... 0xc003:
> >> -        val = extract32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
> >> +    case 0x7000 ... 0x7003:
> >> +        val = extract32(s->scr1, (4 - (addr - 0x7000) - size) << 3,
> >>                           size << 3);
> >>           break;
> >>   
> >> -    case 0xd000 ... 0xd003:
> >> -        val = extract32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
> >> +    case 0x8000 ... 0x8003:
> >> +        val = extract32(s->scr2, (4 - (addr - 0x8000) - size) << 3,
> >>                           size << 3);
> >>           break;
> >>   
> >> @@ -301,25 +301,25 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
> >>       NeXTPC *s = NEXT_PC(opaque);
> >>   
> >>       switch (addr) {
> >> -    case 0x7000:
> >> +    case 0x2000:
> >>           DPRINTF("INT Status old: %x new: %x\n", s->int_status,
> >>                   (unsigned int)val);
> >>           s->int_status = val;
> >>           break;
> >>   
> >> -    case 0x7800:
> >> +    case 0x2800:
> >>           DPRINTF("INT Mask old: %x new: %x\n", s->int_mask, (unsigned int)val);
> >>           s->int_mask  = val;
> >>           break;  
> > 
> > Could you please add comments at the end of the "case" lines, stating which
> > mmio addresses are handled in each case? Otherwise, it's harder to grep for
> > certain addresses later. E.g:
> > 
> >      case 0x2800:     /* 0x2007800 */  
> 
> If you think it will help? Presumably this is to aid with comparing with other source 
> code/documentation?

Yes, it will help with 1) debugging code that is running in the guest (so
you can find IO addresses that it is accessing more easily) and 2) help
when comparing the code with "Previous":

 https://sourceforge.net/p/previous/code/HEAD/tree/trunk/src/ioMemTabNEXT.c#l36

> >> @@ -1000,7 +1000,7 @@ static void next_cube_init(MachineState *machine)
> >>       sysbus_create_simple(TYPE_NEXTFB, 0x0B000000, NULL);
> >>   
> >>       /* MMIO */
> >> -    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02000000);
> >> +    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02005000);  
> > 
> > Why 0x02005000 and not directly 0x02007000 ?  
> 
> Before this patch the output of "info mtree" shows as follows:
> 
> (qemu) info mtree
> address-space: cpu-memory-0
> address-space: memory
>    0000000000000000-ffffffffffffffff (prio 0, i/o): system
>      0000000000000000-000000000001ffff (prio 0, rom): alias next.rom2 @next.rom 
> 0000000000000000-000000000001ffff
>      0000000001000000-000000000101ffff (prio 0, rom): next.rom
>      0000000002000000-0000000002004fff (prio 0, i/o): next.dma
>      0000000002000000-00000000020cffff (prio 0, i/o): next.mmio
>      000000000200e000-000000000200efff (prio 0, i/o): next.kbd
>      00000000020c0000-00000000020c003f (prio 0, ram): next.bmapmem
>      0000000002100000-000000000211ffff (prio 0, i/o): next.scr
>      0000000002114000-000000000211400f (prio 0, i/o): esp-regs
>      0000000002118000-0000000002118003 (prio 0, i/o): escc
>      0000000004000000-0000000007ffffff (prio 0, ram): next.ram
>      000000000b000000-000000000b1cb0ff (prio 0, ram): next-video
>      00000000820c0000-00000000820c003f (prio 0, ram): alias next.bmapmem2 
> @next.bmapmem 0000000000000000-000000000000003f
> 
> All this patch does is move the start of next.mmio to 0x2005000 to avoid the overlap.
> 
> > I think there is another range at 0x02006000 related to the ethernet
> > controller, so directly going with 0x02007000 might cause less friction
> > later when we add the NIC?  
> 
> By the end of the series, everything except the "global" registers in next.mmio have 
> their own memory region (or empty-slot if the target is unknown) so that "info mtree" 
> output looks like this:
> 
> (qemu) info mtree
> address-space: cpu-memory-0
> address-space: memory
>    0000000000000000-ffffffffffffffff (prio 0, i/o): system
>      0000000000000000-000000000001ffff (prio 0, rom): alias next.rom2 @next.rom 
> 0000000000000000-000000000001ffff
>      0000000001000000-000000000101ffff (prio 0, rom): next.rom
>      0000000002000000-0000000002004fff (prio 0, i/o): next.dma
>      0000000002005000-000000000200dfff (prio 0, i/o): next.mmio
>      000000000200e000-000000000200efff (prio 0, i/o): next.kbd
>      00000000020c0000-00000000020c003f (prio 0, ram): next.bmapmem
>      0000000002106000-000000000210601f (prio 0, i/o): next.en
>      0000000002110000-000000000211000f (prio -10000, i/o): empty-slot
>      0000000002112000-000000000211200f (prio -10000, i/o): empty-slot
>      0000000002114000-000000000211403f (prio 0, i/o): next.scsi
>        0000000002114000-000000000211400f (prio 0, i/o): esp-regs
>        0000000002114020-0000000002114021 (prio 0, i/o): csrs
>      0000000002114108-000000000211410b (prio 0, i/o): next.floppy
>      0000000002118000-0000000002118003 (prio 0, i/o): escc
>      0000000002118004-0000000002118013 (prio -10000, i/o): empty-slot
>      000000000211a000-000000000211a003 (prio 0, i/o): next.timer
>      0000000004000000-0000000007ffffff (prio 0, ram): next.ram
>      000000000b000000-000000000b1cb0ff (prio 0, ram): next-video
>      00000000820c0000-00000000820c003f (prio 0, ram): alias next.bmapmem2 
> @next.bmapmem 0000000000000000-000000000000003f
> 
> In this case next.en is a dummy memory region which can easily be replaced with a 
> proper device implementation: see the final version of next-cube.c after the series 
> at https://gitlab.com/mcayland/qemu/-/blob/next-cube-improvements/hw/m68k/next-cube.c.

If I get it right, the IO memory is mirrored at 0x2000000 and 0x2100000,
so the ethernet region should show up in both, 0x2006000 and 0x2106000 in
the end? ... those memory regions on the NeXT are very confusing, but at
least this is what I get from 
 https://sourceforge.net/p/previous/code/HEAD/tree/trunk/src/cpu/memory.c#l1167
(IO_bank is mapped twice, unless it's the 030 Cube)

So I think we should make sure that we can mirror the ethernet registers at
0x2006000, too?

 Thomas

