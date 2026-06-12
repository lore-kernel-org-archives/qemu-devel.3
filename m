Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0912CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY9NO-00075a-Jb; Fri, 12 Jun 2026 17:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY9NI-000711-Vd
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY9NG-0001k5-C5
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781299497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kf/0p+kM/RyZrZMZCQeWzkoZNn7wAKkWoBPGpCtjdAE=;
 b=VflOfrQNQvkqorg20qeAxfJHJGv16bH7fj7NgL4OcnG0UqbTQU/31fGzi/Lrc/HZl/dwPh
 vBdkZQdW9KzmqX+7cba6uG8YQA0/3tjDdpQuRlQDzlOnN5I21jRlZgAMmItiR1feQBEnBR
 pbWGXjaCWgWkWf8L8dj3+2XtY6zV5Dg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-j_CWcTBWMP-6GnmGnlvWOw-1; Fri, 12 Jun 2026 17:24:56 -0400
X-MC-Unique: j_CWcTBWMP-6GnmGnlvWOw-1
X-Mimecast-MFC-AGG-ID: j_CWcTBWMP-6GnmGnlvWOw_1781299495
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8cceb0317b3so21365166d6.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781299495; x=1781904295; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kf/0p+kM/RyZrZMZCQeWzkoZNn7wAKkWoBPGpCtjdAE=;
 b=R9xNEHjjIjxozmjOUCobq8N/hRkKyUE92Xnq1nSKWsNWU7SZdrzVxz4t0fU7qxIHYR
 6D8W4lpbeLFLwRCj4k/EenNBOK3yHUkvUbZrWyJmyFWf4JgXIqtzQJ8t+U4E13+C+/Xo
 +jDj0ZVaoPUr9kPE7HDyzgYDsOUlFTabT9SYwdWDKBcnW29ksCGRZGp2mHEe5Y2doA8O
 s1Jh9xA+BUGzZbuuI3zP3uG+vUvimW2oBnU/OhYzdAszclUPA3W2D0gtfbqs+1E4Zmz4
 hN9AnKmhd4Wc29rgtBV0E9HRUetwk7HubVAcZ5wgEr/KcldyqylJKJpXd4fp0AhDDLmc
 bvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781299495; x=1781904295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kf/0p+kM/RyZrZMZCQeWzkoZNn7wAKkWoBPGpCtjdAE=;
 b=RIBNlr+xO8jnU2XcUKeb0vr5V/YQUB6zNBOKVZf7j8aX8AJ1NBaiXMoGAYo2R6YHnc
 2kWG+Zqs9J95FQgeF2mfPyXCszc/JpPau5OuudnkmezXFzCjl/PaYBE2KCiuZDeTW6Y/
 6LBhfSQ8gRdx++hF3Z+E3d2xEyJxivUnLBHtjnOrOIEu1k0grIXAKS/FC5QSDCQJ3w/G
 uB/99OEZ+sEHo6sA4KPvEugcO1qz5xSfUwpc8hNy7uuvJ8ny2d8gOYxR+1c4nWLtu/Fx
 2ToH4ymfXdj8mmM4PIybL9s5kwSwy99o9kNNTV9+lNqZ5+IYLjDaauE6jug9zZM1p3RO
 P0Aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WFQXxz6ame17ebZErweh54bPrTEind9GQmjtqJvK+LATFQQq04ozrCnypjhPgVltA5b6snw5y2XSO@nongnu.org
X-Gm-Message-State: AOJu0Yz236YoTbtVTOq2g9E8vCVyzIA5D0Rbzo74Qz5Z8cYfsVQ4qGcF
 iBqjL9NY4cicBAX3oYbxt4lGddOpNChJE9wExOWTRdcYD7uVcXuzI/z/9/X98SfT6QNg+5rTtuY
 8Fbzm/0fSVzy0J7ArPzyebyD3BTYjCl/OgZCFc01RLN/qk1Dmzj3Ao6QV
X-Gm-Gg: Acq92OFGs1ElEEaxZdG+9qSJzegj/XrRCrQ0bmIw3x8DNRcGF4QF5uyPyVO0HAvmmhf
 C2m9GUhLcopA41XK6pGlFaoujMvHOy0SFK4JM4M0AvzeNNh51y2RdFvsbX35BEYrwP/z807ur7W
 blhtWnc/i+fIgPzWS3r1VqVUAZeMZIVhpcF4Ax9k3sEVjeL1HbYonMVDpP8wY8x3t/+SM6mjLrk
 74ULU3oTNKr+xdGmxXWzY1W5I5SZzteOLhiTXPNGtcUTkbEQPQSwcUPvEShOPP657Tr8jICu/DO
 7PQI8fanmHOMZCdX0ltyY7x9lM+D+f6G2qxfFM2viTUxIUsJdqEMwKZq4c99EAh9WOSUJBXbBAX
 rZJEY245ZA8IpYyk=
X-Received: by 2002:a05:620a:230d:20b0:915:a34e:cb68 with SMTP id
 af79cd13be357-9161bcb2c3bmr517691985a.34.1781299495272; 
 Fri, 12 Jun 2026 14:24:55 -0700 (PDT)
X-Received: by 2002:a05:620a:230d:20b0:915:a34e:cb68 with SMTP id
 af79cd13be357-9161bcb2c3bmr517686685a.34.1781299494670; 
 Fri, 12 Jun 2026 14:24:54 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a006ef0sm314103185a.24.2026.06.12.14.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 14:24:54 -0700 (PDT)
Date: Fri, 12 Jun 2026 17:24:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex@shazbot.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <aix5JKoRXYlS8hbC@x1.local>
References: <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
 <20260611114811-mutt-send-email-mst@kernel.org>
 <CAFEAcA9HUGfDgHjvCemPPNkp6FfvQp+4y7qCnw+ROFpG3+ybMw@mail.gmail.com>
 <20260611123952-mutt-send-email-mst@kernel.org>
 <CAFEAcA8vOMd64cCkfCyc1wNbjEY+bnhFPce-V_WbAuXrUnP8cw@mail.gmail.com>
 <20260611130037-mutt-send-email-mst@kernel.org>
 <air8hrlhrkaoJ4wi@x1.local>
 <20260611164624-mutt-send-email-mst@kernel.org>
 <aismn4D1wXI6tipv@x1.local> <20260612134423.648c335a@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612134423.648c335a@shazbot.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Jun 12, 2026 at 01:44:23PM -0600, Alex Williamson wrote:
> On Thu, 11 Jun 2026 17:20:31 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Thu, Jun 11, 2026 at 04:52:20PM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jun 11, 2026 at 02:20:54PM -0400, Peter Xu wrote:  
> > > > On Thu, Jun 11, 2026 at 01:02:34PM -0400, Michael S. Tsirkin wrote:  
> > > > > On Thu, Jun 11, 2026 at 05:53:54PM +0100, Peter Maydell wrote:  
> > > > > > On Thu, 11 Jun 2026 at 17:42, Michael S. Tsirkin <mst@redhat.com> wrote:  
> > > > > > >
> > > > > > > On Thu, Jun 11, 2026 at 05:16:09PM +0100, Peter Maydell wrote:  
> > > > > > > > On Thu, 11 Jun 2026 at 16:57, Michael S. Tsirkin <mst@redhat.com> wrote:  
> > > > > > > > > Then I'd like to see an example where we have an actual good reason
> > > > > > > > > to do execute arbitrary width accesses on device RAM when the
> > > > > > > > > driver does not execute them, please.  
> > > > > > > >
> > > > > > > > That's the case we started with, with this GPU where the
> > > > > > > > virtio data structures are in this PCI BAR. We want the
> > > > > > > > virtio backend to have the freedom to say "I'm just going
> > > > > > > > to assume the ring buffer etc is in RAM, and I don't need to
> > > > > > > > care about carefully ensuring that I only do word accesses".  
> > > > > > >
> > > > > > > virtio backend does not need to assume anything. any spec
> > > > > > > compliant guest guarantees it. any address given to
> > > > > > > a virtio device is ram.  
> > > > > > 
> > > > > > OK, but how do we tell if the mmap() PCI BAR we have is RAM
> > > > > > or not ? Some of them are, some of them aren't...
> > > > > > 
> > > > > > -- PMM  
> > > > > 
> > > > > We don't care? If guest asked a virtio device to access
> > > > > memory then that memory better support accesses guest
> > > > > requested, and on virtio that means any width.  
> > > > 
> > > > Yes that's also my understanding that QEMU shouldn't care, if on bare metal
> > > > if it is a grey area with undefined behavior, then QEMU should also be fine
> > > > to make it undefined.
> > > > 
> > > > Only one (IMHO, very slight..) concern is, if such "undefined behavior"
> > > > operation may crash QEMU rather than causing a sigbus like what normally
> > > > would happen on a bare metal.  
> > > 
> > > bus errors are uncommon on bare metal. they aren't usually
> > > handled all that well.  
> > 
> > Ah, not something I was expecting to happen regularly.
> > 
> > In this case, the whole concern is about a possible malicious guest that
> > might have installed a VFIO assigned device MMIO region (which may be
> > register based; RAM-based is non-issue) to be a DMA target of anything.
> > 
> > >   
> > > >  I'll put that discussion at last since I
> > > > don't know if it's that important.
> > > > 
> > > > So taking that e1000 bug into account,  
> > > 
> > > Won't the patch I sent resolve e1000 too?  
> > 
> > If you mean:
> > 
> > https://lore.kernel.org/r/20260611093049-mutt-send-email-mst@kernel.org
> > 
> > Roughly, yes. But it is only to show the idea, not really a real patch?
> > 
> > I think we need to cover all the rest details (I mentioned all these in my
> > previous reply too below):
> > 
> > - we should better leave memcpy()/memmove() as before for non-ram-device,
> >   only do that for ram-devices
> > 
> > - per PeterM's comment, __builtin_memmove() may still have unwanted side
> >   effects (I agree, it looks broken before and maybe we were lucky?)  need
> >   to switch to atomics?
> > 
> > - two spots missing per my previous email here:
> > 
> >   https://lore.kernel.org/all/aimEl9QQ_LTRPLtd@x1.local/
> > 
> >   IIUC we should also fix these two, or is it intended to be left?
> > 
> >   address_space_read()
> >   address_space_write_rom()
> > 
> > >   
> > > > looks like we have more of such user
> > > > that wants explicit control over the memory operations, likely with
> > > > attibutes:
> > > > 
> > > > - Aligned only
> > > > 
> > > > - No vectored inst
> > > > 
> > > > - No possible duplication (perhaps it means, only use atomic access??? per
> > > >   PeterM's explanation in another email)
> > > > 
> > > > I wonder if we should do this by default to all IOs, I think it might have
> > > > an unwanted impact on general perf.  One idea is we can introduce a new bit
> > > > in MemTxAttrs: say, mmio_strict, which will follow above stricter rule of
> > > > doing IO.
> > > > 
> > > > Then for ram_device, when doing memory access we should also use the same
> > > > set, hence something like:
> > > > 
> > > >   if (memory_access_is_direct(mr, ...)) {
> > > >     if (MemTxAttrs.mmio_strict || memory_region_is_ram_device(mr)) {
> > > >         memmove_strict_mmio(); // or memmove_no_vector(), or ...
> > > >     }
> > > >   }
> > > > 
> > > > I also want to bring us to the same page on differenciating two things:
> > > > 
> > > > - about direct access definition: so far, I want to define this almost as
> > > >   "it is directly accessible from host virtual address space".  It means
> > > >   ram_device definitely falls into this category, so it's a sub-category
> > > >   only but enforces strict mmio as above
> > > > 
> > > > - bounce buffer: I want to make sure we're on the same page this is
> > > >   something totally solving different problem of what we're looking at for
> > > >   ram_device.  Essentially this is only needed if mem is not "direct
> > > >   access".  Otherwise we shouldn't need it (including ram_device).  
> > > 
> > > 
> > > I think ram_device_direct_access is a hack that should go away.
> > > It's a work around for a memory core bug that we should just fix.  
> > 
> > I didn't find ram_device_direct_access, if you meant ram_device_mem_ops, I
> > agree it'll be nice if we can avoid it.
> > 
> > > 
> > > 
> > >   
> > > > I'm not sure if above sounds reasonable.  The hope is with that we should
> > > > fix both this GPU and e1000 issues (e1000, and maybe other places, needs to
> > > > start passing MemTxAttrs.mmio_strict, though, if we want to keep the
> > > > default to be still fast-path to use memcpy()/memmove()?).
> > > > 
> > > > Thanks,
> > > > 
> > > > =========================
> > > > 
> > > > Two cases here on the concern:
> > > > 
> > > > (1) if fully emulated device, non-issue afaiu because whatever DMA does
> > > > (with vectored ops) will only apply to QEMU process (like a bounce
> > > > buffer..) so it won't crash,
> > > > 
> > > > (2) if it's a VFIO device (not the GPU case, but when like realtek and some
> > > > guest driver registers it as a DMA target), logically the guest should
> > > > receive a bus error, but for QEMU's case it may crash QEMU with SIGBUS:  
> > > 
> > > what and why would crash qemu?  
> > 
> > If what Alex described issue happened in commit 4a2e242bbb ("memory: Don't
> > use memcpy for ram_device regions"), IIUC it will crash qemu, but maybe I
> > was wrong.  Alex knows the best.
> > 
> > So in general, we don't want malicious guest to be able to DoS the host
> > process (hence, to me "niche security use case"..).
> 
> Trying to figure out where to jump into this thread.  4a2e242bbb was
> required because memcpy will be optimized to use instructions that
> shouldn't target MMIO.  IIRC, in the case of the RTL NIC we were
> getting SSE instructions to MMIO.  At the time, we weren't thinking
> about P2P DMA, the virtualized access was a result of the quirks for
> RTL causing the trap into QEMU rather than directly accessing through
> the mmap.  Performance and bulk transfers were not a priority.
> 
> Alignment was really not a consideration.  The commit log even refers
> to unaligned accesses.  It was just a matter of chunking to the maximum
> width available for the size.
> 
> If a more optimized path is now necessary, I'd just recommend not using
> something like memcpy or memmove, make sure it's restricted to
> operations that are valid for MMIO address spaces.  Bouncing through
> QEMU should not introduce RAM-specific memory optimizations.  Thanks,

I assume that aligns with the plan, thanks Alex.
 
So is that rtl8168 device?  I wonder if it could reproduce with other
similar cases too.

Any suggestion if we want to double check a new change don't regress the
use case (e.g. the old guest tests that triggered this)?  Or I wonder if
you think code reviews on this would be enough (by being sure about the
vectored instruction is the core of problem).

Thanks,

-- 
Peter Xu


