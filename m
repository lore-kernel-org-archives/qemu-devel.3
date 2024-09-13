Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEDCFA375E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp8di-0001o6-Nd; Fri, 13 Sep 2024 11:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp8dc-0001l7-Lo
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp8da-0004NJ-K2
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726242909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ecke6lkoeU5mIwkL7dVkHe3ekMQJ1EJkevrhtfpo3j0=;
 b=irDKJLU42at+2vtyZJOa3DPEXEnny5yVgiFfaFDeGmBYyuqEx6B4z6kaLQIBjr3KwmXNfq
 yATmaiOUN8Yy9OtDXU20050juxODyH7/N+3rpFBk2y5XOAMGWuKmRnX2iXXdiG+ygq3OhA
 YNTvQqnJYNSS/iL/yHYCsF3GUoj0RSI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-rKoiS1njP3SVW_Louu2Osg-1; Fri, 13 Sep 2024 11:55:07 -0400
X-MC-Unique: rKoiS1njP3SVW_Louu2Osg-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5daa71823e0so2006866eaf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726242907; x=1726847707;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ecke6lkoeU5mIwkL7dVkHe3ekMQJ1EJkevrhtfpo3j0=;
 b=bAOygl5VXmlfVoZD26N0XrKNYm0SoEOv3T5Cp92z3Ik1pkaaysTt3n37GzcVE2aZNK
 8aIO9IcvlPfwpaRw9wL2HL0/yiVJFiDk8Iaql2EzzZU2liVC5cyCyXZUye4WL3SQtL+N
 u7NrGcbvwj+6KA86S5NnNepJKIgwaGCUfGKFWzo9gshLUMqp5eORL8PxmQHoIpH1ILEr
 ryXtPWZgOJxLnyNA3N6T0VwI8SO0mjRZ14MtKUFBe7+VNLPyi+VqS2ZKQ0BGdM3d+I8O
 c3nbBGAuJ51LE/Ldn3XiRS9ZSw552tnabhFS2oxW2UujF5zG6Az6+aQ83d1ilEVsYaF2
 ROgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWQ3ElHaS2HhGnY1CoBTCvLXRmjT4zH6+hoe2cJzqfbcoCEMWJBu/blLwHCOUF2UxRiptWt2e+MXEB@nongnu.org
X-Gm-Message-State: AOJu0YwXlgyenj42vZ8H/BXZze/NkszENd6czem5N0YKl3qKU+pA65WY
 4IXyx+dSrqbaDni42ibw3gujsGWuHo3O5fImllZqK3jnYoU/ttSUMDoXBhCAzlJs+dUo5RSCZkN
 zMHhN6SRuVC8wC1FE/ft74VFRg1aZKz4hh5l42+wnsLPe6EMeWjh5
X-Received: by 2002:a05:6359:5fa0:b0:1b8:21ed:7551 with SMTP id
 e5c5f4694b2df-1bb23de3e87mr449918655d.27.1726242906810; 
 Fri, 13 Sep 2024 08:55:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2bd+enDvUFXDsrFMC+vBgwACpvse6zYRt6tXZtIXI4oZR+BaI3u2/8VG6Ok6FNJfPgNUaOA==
X-Received: by 2002:a05:6359:5fa0:b0:1b8:21ed:7551 with SMTP id
 e5c5f4694b2df-1bb23de3e87mr449917155d.27.1726242906446; 
 Fri, 13 Sep 2024 08:55:06 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7945667sm677160885a.4.2024.09.13.08.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:55:05 -0700 (PDT)
Date: Fri, 13 Sep 2024 11:55:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mattias Nissler <mnissler@rivosinc.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
Message-ID: <ZuRgV7lS75BpDUox@x1n>
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <CAFEAcA-pVJozMoPnUU9TO=0KKH3iR95rf7XLj9EuaM7+Q-VZoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-pVJozMoPnUU9TO=0KKH3iR95rf7XLj9EuaM7+Q-VZoQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
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

On Thu, Sep 12, 2024 at 03:27:55PM +0100, Peter Maydell wrote:
> On Mon, 19 Aug 2024 at 14:56, Mattias Nissler <mnissler@rivosinc.com> wrote:
> >
> > When DMA memory can't be directly accessed, as is the case when
> > running the device model in a separate process without shareable DMA
> > file descriptors, bounce buffering is used.
> >
> > It is not uncommon for device models to request mapping of several DMA
> > regions at the same time. Examples include:
> >  * net devices, e.g. when transmitting a packet that is split across
> >    several TX descriptors (observed with igb)
> >  * USB host controllers, when handling a packet with multiple data TRBs
> >    (observed with xhci)
> >
> > Previously, qemu only provided a single bounce buffer per AddressSpace
> > and would fail DMA map requests while the buffer was already in use. In
> > turn, this would cause DMA failures that ultimately manifest as hardware
> > errors from the guest perspective.
> >
> > This change allocates DMA bounce buffers dynamically instead of
> > supporting only a single buffer. Thus, multiple DMA mappings work
> > correctly also when RAM can't be mmap()-ed.
> >
> > The total bounce buffer allocation size is limited individually for each
> > AddressSpace. The default limit is 4096 bytes, matching the previous
> > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > provided to configure the limit for PCI devices.
> >
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Acked-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> > @@ -3251,28 +3265,40 @@ void *address_space_map(AddressSpace *as,
> >      mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
> >
> >      if (!memory_access_is_direct(mr, is_write)) {
> > -        if (qatomic_xchg(&as->bounce.in_use, true)) {
> > +        size_t used = qatomic_read(&as->bounce_buffer_size);
> > +        for (;;) {
> > +            hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);
> > +            size_t new_size = used + alloc;
> > +            size_t actual =
> > +                qatomic_cmpxchg(&as->bounce_buffer_size, used, new_size);
> > +            if (actual == used) {
> > +                l = alloc;
> > +                break;
> > +            }
> > +            used = actual;
> > +        }
> > +
> > +        if (l == 0) {
> >              *plen = 0;
> >              return NULL;
> >          }
> > -        /* Avoid unbounded allocations */
> > -        l = MIN(l, TARGET_PAGE_SIZE);
> > -        as->bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
> > -        as->bounce.addr = addr;
> > -        as->bounce.len = l;
> >
> > +        BounceBuffer *bounce = g_malloc0(l + sizeof(BounceBuffer));
> > +        bounce->magic = BOUNCE_BUFFER_MAGIC;
> >          memory_region_ref(mr);
> > -        as->bounce.mr = mr;
> > +        bounce->mr = mr;
> > +        bounce->addr = addr;
> > +        bounce->len = l;
> > +
> >          if (!is_write) {
> >              flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> > -                          as->bounce.buffer, l);
> > +                          bounce->buffer, l);
> >          }
> >
> >          *plen = l;
> > -        return as->bounce.buffer;
> > +        return bounce->buffer;
> 
> Coverity is pretty unhappy about this trick, because it isn't able
> to recognise that we can figure out the address of 'bounce'
> from the address of 'bounce->buffer' and free it in the
> address_space_unmap() code, so it thinks that every use
> of address_space_map(), pci_dma_map(), etc, is a memory leak.
> We can mark all those as false positives, of course, but it got
> me wondering whether maybe we should have this function return
> a struct that has all the information address_space_unmap()
> needs rather than relying on it being able to figure it out
> from the host memory pointer...

Indeed that sounds like a viable option.  Looks like we don't have a lot of
address_space_map() users.

There might be some challenge on users who cache the results (rather than
immediately unmap() after using the buffer in the same function).  Still
doable but the changeset can spread all over, and also testing is harder if
just to get some coverage.

Not sure whether Mattias have some more clue when he's working on that.

Thanks,

-- 
Peter Xu


