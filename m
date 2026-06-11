Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87AECD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXiUR-0007al-Qn; Thu, 11 Jun 2026 12:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXiUQ-0007ZH-8H
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXiUN-0003eh-0d
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781196161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vz8WRZyRZD08qe0X3pdvgZUjSNzc00xUHJIcEocm79Y=;
 b=XRtwZbyIShLMsyTXQnKPCs95Ymw+dBBHFxnpz46g3ryMqN2h9Ujse72DmXakqoloy6U7i4
 wuYLTBrZV+cKuAVxSIIaXssABlEpLfLG/eFcZis7cdA/NN7gKcRZFADZYC5/+9sGjsAvhO
 ysrUcx+eQYJFwk0MLq6psYv19uaDkm0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-k_uoGX_XORC3iaYvTO4mSA-1; Thu, 11 Jun 2026 12:42:38 -0400
X-MC-Unique: k_uoGX_XORC3iaYvTO4mSA-1
X-Mimecast-MFC-AGG-ID: k_uoGX_XORC3iaYvTO4mSA_1781196157
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4601daf4c65so6537f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781196157; x=1781800957; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vz8WRZyRZD08qe0X3pdvgZUjSNzc00xUHJIcEocm79Y=;
 b=D2RnvBvgn7P5qjljxXxaUkqWbhbfrgAtXUMvT0wWDBHLy5v3ajUav78EgWk8qoRpmE
 tlxOmFNKQ9l6LOFdCMHC9Ubmuj/u0pZZNLmDToCaU30ycdQX1jGQX4N5BhJsBXdYhQgf
 zl8Gx4BvG3Nmsz0VJFS8ofBriTvSAZWc1jgjZpmDT73wleNqFkrVC1tUKCsH4o3B+Os7
 mimb2mMXDf5ef7rd+5Rf6IYl7YA6UYnv0xZEKwccVo8WVnb7TuD5Uo1ByzMHxbDt6lsB
 itmzTinC46Lf6JDa6rvwJiG+cGTplinoFAPPAD9fgL9RZD9jrTmTX2PUj5+vC+eJPBgS
 uqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781196157; x=1781800957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vz8WRZyRZD08qe0X3pdvgZUjSNzc00xUHJIcEocm79Y=;
 b=Mih4aJdtHaZSpdaxgceDviOGUeClKeOjoxvbgkRv46PzWIHL0VDCOw4Eyp7nd5Ob92
 zLbu19iyOFsOYxpUzJ6bJt5AAIdszwFzUPADgWjm8JQ/0r9QhFv5AaqG7dhfs0bj/gLW
 erWVxJ+/yyrFgvwLs6IpHRrtZBRgIUh1U6/pgwM5JUp/sXLdeerrgrkXL3okdt6BA/OG
 5sg5TjBm5Q/5yYC31uzjWAB1W4ZelIVCrnRyvr1SpwWSkcMoPUFrQeyCxvW7KtUnHQ14
 d2q5Ca0Efy0Bt90THOJoksmy2+cyAYONtV47G+dAwUqAYLINyQhqBAA8HJaAi5uXk2Z6
 gWpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GZnnLBEo/FzfetlGi74r866IYPsHwfhZ1VSszKzNsFCOPvDUwJRYgYqwlFm+/YqCl3OTgEdQKbZz5@nongnu.org
X-Gm-Message-State: AOJu0YxmJPF0uu2UZSB8kOSXI/iZ3O60Jh8QSsl0Q3qKRn6PVub6qc43
 oPkOJdr7sYe/fsRv67s8TaIF2bs3sSje1w2NTUGCjhpVVS6yJFUrFpFxWf9/p/lZB1sLl0BXnlo
 f5XEsqNbj68PEYWYvCXXGRkJHvZcts9Xg5BKIB0XPGNF50DxLcuVG+ps+
X-Gm-Gg: Acq92OELQR621RyiuqWar+/YjXHprnCxkGTlwiebDshjglOxR4Q7T/GVKfZvYcGSwxM
 USeQo6HU5yElkXQXp6aZBTTpFL8uRThnpREJwGQvCVRyaAFq85FwvHSqu9UJtopAX3x29I7ldxq
 tcPmPd6AoaEVGwfOuVR6KkGhhtE+nrZp717kBr30mtyUujOkFZjipuBOCdGjMP9DTZ1yQMPzQgy
 unRp3CZ0uIHc08AqI60YopVhG5DsgiaCESFd4k81NqLP91l71YvHGaO/tPdXgPJrfrWXb5s7mYL
 RvvdYfCj/NU6th0wDGuS4nHhYSyJez2cG3hiN4tw5nMj+1wdTRXeR5dS+SGYDkDIqUZDHELN0xj
 LoTti1s0GpANXu8y54HZN96NOsY/m+1X9Dm+3NrArwUA=
X-Received: by 2002:a05:600d:844e:20b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-490e5617b6amr37868555e9.24.1781196156885; 
 Thu, 11 Jun 2026 09:42:36 -0700 (PDT)
X-Received: by 2002:a05:600d:844e:20b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-490e5617b6amr37868095e9.24.1781196156185; 
 Thu, 11 Jun 2026 09:42:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ea52sm84293085e9.2.2026.06.11.09.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:42:35 -0700 (PDT)
Date: Thu, 11 Jun 2026 12:42:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260611123952-mutt-send-email-mst@kernel.org>
References: <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
 <20260611023428-mutt-send-email-mst@kernel.org>
 <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
 <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
 <20260611093049-mutt-send-email-mst@kernel.org>
 <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
 <20260611110156-mutt-send-email-mst@kernel.org>
 <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
 <20260611114811-mutt-send-email-mst@kernel.org>
 <CAFEAcA9HUGfDgHjvCemPPNkp6FfvQp+4y7qCnw+ROFpG3+ybMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9HUGfDgHjvCemPPNkp6FfvQp+4y7qCnw+ROFpG3+ybMw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 11, 2026 at 05:16:09PM +0100, Peter Maydell wrote:
> On Thu, 11 Jun 2026 at 16:57, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 11, 2026 at 04:29:49PM +0100, Peter Maydell wrote:
> > > On Thu, 11 Jun 2026 at 16:05, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > What is "OK"? If the BAR is RAM and I write into it, I will overwrite
> > > > data guest stored there. Is that "OK"?
> > >
> > > By "OK" I mean it behaves like RAM: any kind of load or store
> > > will work, at any width and any alignment.
> > > That is what makes
> > > it OK to return the pointer from address_space_map(), where
> > > the caller will treat it as any other C host pointer (e.g.
> > > assigning it to a C struct pointer and then writing to fields
> > > in that struct), like virtio does:
> > >
> > >         iov[num_sg].iov_base = dma_memory_map(vdev->dma_as, pa, &len,
> > >                                               is_write ?
> > >                                               DMA_DIRECTION_FROM_DEVICE :
> > >                                               DMA_DIRECTION_TO_DEVICE,
> > >                                               MEMTXATTRS_UNSPECIFIED);
> > >         if (!iov[num_sg].iov_base) {
> > >             virtio_error(vdev, "virtio: bogus descriptor or out of resources");
> > >             goto out;
> > >         }
> > > [etc]
> > >
> > > This is only safe when the pointer is something we can
> > > handle as if it were a pointer to normal RAM (because the
> > > C compiler makes no promises about only doing correctly
> > > aligned and sized accesses: to it, memory is memory).
> >
> >
> >
> > Safe as in what? Work meaning what?
> >
> > mmap of a device register is a standard API in Linux, it gives you a
> > pointer and no, it does not imply that "any access" will not make your
> > box go up in smoke, and never did.
> 
> Yes. So you need to be careful about what you do with the
> pointers you get into something you mmap()ed. In particular,
> if it's not actually RAM then you can't just hand it to the
> C compiler and say "this is a pointer to some data structure",
> because the C compiler is not going to restrict itself to
> only doing the things that the hardware says are in spec.
> That's why we don't want to mark these memory regions as
> "direct access OK".
> 
> > > > If the BAR is RAM and I write into it, I will overwrite
> > > > data guest stored there. Is that "OK"?
> > >
> > > If the guest said "please DMA to this address" then they're
> > > expecting you to overwrite that data, yes.
> >
> > The "If the guest said" is critical here. It's not OK
> > at a random time and place of your choosing, and never will be.
> >
> > It's exactly what I said: if we are doing what guest does,
> > like fixed length memcpy does,
> > then we are good. If instead we are replacing guest accesses
> > with different ones like variable length memcpy does,
> > we'll get issues.
> 
> But these accesses are not guest accesses. They're device
> accesses (by a device model doing DMA, including the virtio
> device). So "what access might we do" depends on the device spec.
> There's no "guest software did a 4 byte write" that we're
> converting into something else.


Device does it because guest told it to do it.
It is really the same.

> > > Merging in your other reply:
> > >
> > > >> The
> > > >> problem is that for some PCI devices (like the network card
> > > >> mentioned in 4a2e242bbb30's commit message) the BAR is *not*
> > > >> safe for arbitrary access (because the actual real host hardware
> > > >> inside it is not RAM).
> > > >
> > > > But we don't do arbitrary access. Why would we?
> > >
> > > If we mark the MR as "direct access OK", then we do, or might do.
> >
> > what does this might mean?
> 
> It means that by marking the MR as "direct access" we say
> "these are permitted". Whether they happen or not depends
> on what the code in QEMU does and what the C compiler does
> with that. If you don't want them, don't say they're OK.
> 
> > > The bug the commit is fixing is exactly that there is a codepath
> > > that uses the latitude that marking the MR as direct access permits.
> >
> >
> > No, the bug is that a 4 byte fixed length access was converted
> > to a variable length memcpy function call which started
> > doing single byte accesses.
> >
> >
> > >
> > > > There's no such thing as "not safe for direct access" in PCI.
> > > > All operations are memory operations.
> > > > What can be unsafe is accesses of specific width and length.
> > >
> > > I think we're talking at cross purposes here. By "safe for
> > > direct access" I mean exactly that arbitrary width and
> > > length and alignment are permitted.
> >
> > This is a strong demands that QEMU simply never needs.
> 
> It does for address_space_map(). That's what that gives you.

yes no part of qem use that.

> > > This is what
> > > memory_region_supports_direct_access() is testing.
> > > If the PCI BAR can't handle arbitrary widths etc then that
> > > function mustn't return true for its MR.
> > >
> > > (Though if we ever get into trying to address_space_map()
> > > a BAR like that something is going to go wrong anyway, because
> > > the "not OK for direct access" path fills and empties the bounce
> > > buffer by calling flatview_read() and address_space_write(),
> > > which aren't going to honour any theoretical alignment requirements.
> > > Perhaps that kind of BAR should just flat out not be one we handle
> > > with a ram_device MR?)
> >
> >
> > mmap of a device is a standard thing that everyone did on unix, for
> > decades. just don't do things, with a device, that a driver does not do.
> >
> > > > > (I think there are places where we do need to be more careful about
> > > > > what we do with accesses to real RAM, for where we're emulating a
> > > > > device write to RAM that's updating a data structure shared with the
> > > > > guest, and things like writing multiple times can cause problems.
> > > > > https://lore.kernel.org/qemu-devel/CAFEAcA8dwHV8F48kb-013rxkG9kKcZhym9_qarKmoeUfeh0YWw@mail.gmail.com/
> > > > > is an unrelated example of that, which I haven't done detailed
> > > > > analysis of yet.)
> > >
> > > > If it does not work, then QEMU is broken:
> > > >
> > > >
> > > > /*
> > > >  * Any compiler worth its salt will turn these memcpy into native unaligned
> > > >  * operations.  Thus we don't need to play games with packed attributes, or
> > > >  * inline byte-by-byte stores.
> > > >  * Some compilation environments (eg some fortify-source implementations)
> > > >  * may intercept memcpy() in a way that defeats the compiler optimization,
> > > >  * though, so we use __builtin_memcpy() to give ourselves the best chance
> > > >  * of good performance.
> > > >  */
> > >
> > > Good point. (Though if I were an optimizing compiler I might
> > > be tempted to optimize a switch() on the length where each
> > > case called memmove with a fixed length argument back into a
> > > single call to memmove...)
> > >
> > > I suspect your suggested flatview changes would fix that e1000
> > > bug. But I don't think they're the right thing for this problem.
> 
> > Then I'd like to see an example where we have an actual good reason
> > to do execute arbitrary width accesses on device RAM when the
> > driver does not execute them, please.
> 
> That's the case we started with, with this GPU where the
> virtio data structures are in this PCI BAR. We want the
> virtio backend to have the freedom to say "I'm just going
> to assume the ring buffer etc is in RAM, and I don't need to
> care about carefully ensuring that I only do word accesses".

virtio backend does not need to assume anything. any spec
compliant guest guarantees it. any address given to
a virtio device is ram.


> That's why it uses address_space_map()/dma_memory_map().

Nope.  It could use QEMUSGList just as well. map is just easier.

> 
> -- PMM


