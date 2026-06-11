Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2F7CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXi4x-0000Xr-6f; Thu, 11 Jun 2026 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXi4v-0000XS-Rs
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:16:25 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXi4t-0004a1-46
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:16:25 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-660e9fef1d4so23866d50.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781194582; cv=none;
 d=google.com; s=arc-20240605;
 b=cRZ/hLcx9jYUtlG1TQXHsZVB/vDpKStmK/PHo6G1xxR0ZfPPy0sSiwJZFCXGCPMjoh
 N6R584xYMlbPckfMzPKjsc2M+oD2ufiYeTDLG2XBXDMq2r2uJLh1ixawrfQD+B65myZg
 3cyUTEdIttMQM+OqCXKzDDI3UzqsWfABxOBvh/rsAFNuIb7ALmUFO2cg1o0RPaFcSd6f
 BWJSnlyQgTRuZDTzv60lexJAmtDHmKH3QnhtY8KfutF634IcNQnebU/Gql3ZgEuauKiL
 ng06EjHGPA8GoszH5CtP8ZW2mrLswBNL4dkfpGU7/K/1m+GGY6AFTASPncB6i20ueY6m
 sE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xUmoMIwGTbcrbCC6JvCEjJZ9CcWnCdUNicDJi5Vh0Z8=;
 fh=U+3o4ZpqOzpfJs4I+LY40BzzQfLLCMVGmxphhWg/rhA=;
 b=Ty+hLqt5AKK878MSjwNHczlvpnfoUTqRWO2SSXrpxMRHJv+q5D0upjEqFe0GBnVwgj
 sUCNSky70FKVX8gDyqi0cjh6LvYHIcUbWU2Jke61spVqTK8q0ktkIXpGmS+pLl/YORXd
 qdRZ/SHtx4Tw1NQ9skZXbTxNO3h/dJ9DEa8U3m1/cvuaDatCiAkLLjkQ9BZPeqVv0I1m
 Rkf37+Uvm5+Gw9BgqtnsnVNVko1VH8Iv4/Cz+B/htvgKq217SEhuuOV7QE3+GtYcFQoo
 AjBy6HGqhPwu3Av5d9PXZtCaBQZCcHNkp3gzY7oxjZIIZqsi+XQGwUtXcUv6u75gAgUA
 Ic4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781194582; x=1781799382; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xUmoMIwGTbcrbCC6JvCEjJZ9CcWnCdUNicDJi5Vh0Z8=;
 b=MXNAKzDU91zR5yECLhCUnuPtqUITPAs6Szx9Rfnga00BUpzcYbPHNunVEiQ7WaLfX8
 p5+6OJSs4LNbvSX2k87yZ/6uLwDAAHPDtH87NfyaIhOWccaYC71H4ZUXpXw5VtZqrEV8
 SW6JDdKumAiz3pzwyktp1NASJg/T6rCta0QxZNNZkl6t8xvY9gJj/5OHqCQKNsiYgk+b
 ErpzzeIN7uGOBAhVD8m/bRJoITsn/Tp7Et10zIMs4nLImox0xDBwG86L3RG+CnhEB1BX
 EBuM+75c0g7x4NxbymO2gEJFVRYQu1vg5mRXncH4E/3ad+UnvXnI9kkwcrgxdY+Qq7go
 Mvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781194582; x=1781799382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUmoMIwGTbcrbCC6JvCEjJZ9CcWnCdUNicDJi5Vh0Z8=;
 b=KSdCPk2n3ex4f5viXG8kZ+tjSgjinuaXsdYHCwXxtgktzxkvTyyvtzb1qVHnJ0sfNz
 6d66EHKFZte1krZFijP+IHhjCyhNfbdAM5j4xHVEhWFxQG8Ew/aP2qzU663lC3/Dz0/Z
 G4b0Q6TMh2nou2fRXDWIqLClapEggzHN61K0gB9eU9fUckVzc2GtPGtUgpKaVlHt0MZL
 W2HRgifvR5JTzwmzzMciJnZCVPz7fkz1SL35h98mZbGsEC29mpM6TmykJzJmt+gog4y+
 FBpyU4ue4TUXfDBV4WMzMlyxrF35Azuc+HjFTAcRjHFHdE4k6NN43rV+vklZ25owveUC
 vktQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+A/KFSETUtsuqNGdI7Ssqeb/p1l5pMNt4kOfb5eSqxRDv2vvK2nBIPSqquOrDmhyfy6vgO5v5jzZ/X@nongnu.org
X-Gm-Message-State: AOJu0YyJoeqOl9OdUekHUAkcDaL0rocqBH+0CCcUff3oUphO6ZUyOp2h
 Nwc595y4CAJ1CCLNE1nBC7Xc1/E4RkeifcS/qpkGikkK0ylrDE7qphqwLhKK+Ch7gSkCEwgDwFu
 GlNgouTUXFnKuTj+Vh7p+gQEs9E6oSO1hKvMVXd4xOA==
X-Gm-Gg: Acq92OHlFCyQgZSJHa36MYWxKmnmx28/LWlKXJkJ04KKTMX5Sk0F+RRcGVbrlTwzBdD
 OYuAjM1CRPQqJwIPTCajy/SO7KxOhDDF0YPJp7D2q3+I3FBP0xURVEeIlBBtWeNU+4bJJSf6P8S
 cmjk9scBk+lE83wXPb746uRGZwa8C4TkUNL0K4VoZJ1ZXmycEpoGnTHWws6SG3vUMKrR6A+O17c
 HNq/08RlsVrTd+zPI0r5Me+x9YlmuljpdE3aXiEJ9v9WOChV2a2NGYBEVGVuTrbYwzyz+uYih6q
 YTmPaBmJtIo0VtfFAYj3T/npOmIdfU0SzP7wQvbtqdxEyr7SXHh46xvNTSMmeec91pQ=
X-Received: by 2002:a05:690e:4181:b0:656:b6bb:7c3b with SMTP id
 956f58d0204a3-66269868efdmr3227566d50.37.1781194581379; Thu, 11 Jun 2026
 09:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <1e9515c9-7e32-4d95-9b73-aab8bf10bddc@redhat.com>
 <20260611012217-mutt-send-email-mst@kernel.org>
 <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
 <20260611023428-mutt-send-email-mst@kernel.org>
 <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
 <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
 <20260611093049-mutt-send-email-mst@kernel.org>
 <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
 <20260611110156-mutt-send-email-mst@kernel.org>
 <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
 <20260611114811-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260611114811-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2026 17:16:09 +0100
X-Gm-Features: AVVi8CdePoAeiefJlG2VpvU0xB-1bm5JoQPIhM-bInn9BGA7tjp7z1krSFxyvjM
Message-ID: <CAFEAcA9HUGfDgHjvCemPPNkp6FfvQp+4y7qCnw+ROFpG3+ybMw@mail.gmail.com>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Pavel Hrdina <phrdina@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com, 
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>, 
 David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 11 Jun 2026 at 16:57, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 11, 2026 at 04:29:49PM +0100, Peter Maydell wrote:
> > On Thu, 11 Jun 2026 at 16:05, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > What is "OK"? If the BAR is RAM and I write into it, I will overwrite
> > > data guest stored there. Is that "OK"?
> >
> > By "OK" I mean it behaves like RAM: any kind of load or store
> > will work, at any width and any alignment.
> > That is what makes
> > it OK to return the pointer from address_space_map(), where
> > the caller will treat it as any other C host pointer (e.g.
> > assigning it to a C struct pointer and then writing to fields
> > in that struct), like virtio does:
> >
> >         iov[num_sg].iov_base = dma_memory_map(vdev->dma_as, pa, &len,
> >                                               is_write ?
> >                                               DMA_DIRECTION_FROM_DEVICE :
> >                                               DMA_DIRECTION_TO_DEVICE,
> >                                               MEMTXATTRS_UNSPECIFIED);
> >         if (!iov[num_sg].iov_base) {
> >             virtio_error(vdev, "virtio: bogus descriptor or out of resources");
> >             goto out;
> >         }
> > [etc]
> >
> > This is only safe when the pointer is something we can
> > handle as if it were a pointer to normal RAM (because the
> > C compiler makes no promises about only doing correctly
> > aligned and sized accesses: to it, memory is memory).
>
>
>
> Safe as in what? Work meaning what?
>
> mmap of a device register is a standard API in Linux, it gives you a
> pointer and no, it does not imply that "any access" will not make your
> box go up in smoke, and never did.

Yes. So you need to be careful about what you do with the
pointers you get into something you mmap()ed. In particular,
if it's not actually RAM then you can't just hand it to the
C compiler and say "this is a pointer to some data structure",
because the C compiler is not going to restrict itself to
only doing the things that the hardware says are in spec.
That's why we don't want to mark these memory regions as
"direct access OK".

> > > If the BAR is RAM and I write into it, I will overwrite
> > > data guest stored there. Is that "OK"?
> >
> > If the guest said "please DMA to this address" then they're
> > expecting you to overwrite that data, yes.
>
> The "If the guest said" is critical here. It's not OK
> at a random time and place of your choosing, and never will be.
>
> It's exactly what I said: if we are doing what guest does,
> like fixed length memcpy does,
> then we are good. If instead we are replacing guest accesses
> with different ones like variable length memcpy does,
> we'll get issues.

But these accesses are not guest accesses. They're device
accesses (by a device model doing DMA, including the virtio
device). So "what access might we do" depends on the device spec.
There's no "guest software did a 4 byte write" that we're
converting into something else.

> > Merging in your other reply:
> >
> > >> The
> > >> problem is that for some PCI devices (like the network card
> > >> mentioned in 4a2e242bbb30's commit message) the BAR is *not*
> > >> safe for arbitrary access (because the actual real host hardware
> > >> inside it is not RAM).
> > >
> > > But we don't do arbitrary access. Why would we?
> >
> > If we mark the MR as "direct access OK", then we do, or might do.
>
> what does this might mean?

It means that by marking the MR as "direct access" we say
"these are permitted". Whether they happen or not depends
on what the code in QEMU does and what the C compiler does
with that. If you don't want them, don't say they're OK.

> > The bug the commit is fixing is exactly that there is a codepath
> > that uses the latitude that marking the MR as direct access permits.
>
>
> No, the bug is that a 4 byte fixed length access was converted
> to a variable length memcpy function call which started
> doing single byte accesses.
>
>
> >
> > > There's no such thing as "not safe for direct access" in PCI.
> > > All operations are memory operations.
> > > What can be unsafe is accesses of specific width and length.
> >
> > I think we're talking at cross purposes here. By "safe for
> > direct access" I mean exactly that arbitrary width and
> > length and alignment are permitted.
>
> This is a strong demands that QEMU simply never needs.

It does for address_space_map(). That's what that gives you.

> > This is what
> > memory_region_supports_direct_access() is testing.
> > If the PCI BAR can't handle arbitrary widths etc then that
> > function mustn't return true for its MR.
> >
> > (Though if we ever get into trying to address_space_map()
> > a BAR like that something is going to go wrong anyway, because
> > the "not OK for direct access" path fills and empties the bounce
> > buffer by calling flatview_read() and address_space_write(),
> > which aren't going to honour any theoretical alignment requirements.
> > Perhaps that kind of BAR should just flat out not be one we handle
> > with a ram_device MR?)
>
>
> mmap of a device is a standard thing that everyone did on unix, for
> decades. just don't do things, with a device, that a driver does not do.
>
> > > > (I think there are places where we do need to be more careful about
> > > > what we do with accesses to real RAM, for where we're emulating a
> > > > device write to RAM that's updating a data structure shared with the
> > > > guest, and things like writing multiple times can cause problems.
> > > > https://lore.kernel.org/qemu-devel/CAFEAcA8dwHV8F48kb-013rxkG9kKcZhym9_qarKmoeUfeh0YWw@mail.gmail.com/
> > > > is an unrelated example of that, which I haven't done detailed
> > > > analysis of yet.)
> >
> > > If it does not work, then QEMU is broken:
> > >
> > >
> > > /*
> > >  * Any compiler worth its salt will turn these memcpy into native unaligned
> > >  * operations.  Thus we don't need to play games with packed attributes, or
> > >  * inline byte-by-byte stores.
> > >  * Some compilation environments (eg some fortify-source implementations)
> > >  * may intercept memcpy() in a way that defeats the compiler optimization,
> > >  * though, so we use __builtin_memcpy() to give ourselves the best chance
> > >  * of good performance.
> > >  */
> >
> > Good point. (Though if I were an optimizing compiler I might
> > be tempted to optimize a switch() on the length where each
> > case called memmove with a fixed length argument back into a
> > single call to memmove...)
> >
> > I suspect your suggested flatview changes would fix that e1000
> > bug. But I don't think they're the right thing for this problem.

> Then I'd like to see an example where we have an actual good reason
> to do execute arbitrary width accesses on device RAM when the
> driver does not execute them, please.

That's the case we started with, with this GPU where the
virtio data structures are in this PCI BAR. We want the
virtio backend to have the freedom to say "I'm just going
to assume the ring buffer etc is in RAM, and I don't need to
care about carefully ensuring that I only do word accesses".
That's why it uses address_space_map()/dma_memory_map().

-- PMM

