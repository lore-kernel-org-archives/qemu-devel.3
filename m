Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA5CC531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmpMr-0000VE-1q; Thu, 23 Jul 2026 05:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wmpMp-0000U1-2t
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 05:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wmpMk-0003fS-Do
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 05:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784797517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/CpFpa3YQWIViCBA7uvSk/o+fAJelb5NUfE93VtZvu4=;
 b=J0U9bF4QXvWCDBYyqWSnO9EzsXJqIyaZrOlM8wPlKMERL9lXAFKz1LNMfipQT7vtc7JNrU
 +awzq1ei6z0yOQg0hKLB3C0z7/lF9r+n9mK0yIMh4dtGRLn+BZ1teAR1Kqtvmt3vQgVxTf
 noOXVk8RWnXzcS4G66Oqrct0lHwK2fc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-bR8Bcy3AOUGKFeOEdNFjpQ-1; Thu, 23 Jul 2026 05:05:15 -0400
X-MC-Unique: bR8Bcy3AOUGKFeOEdNFjpQ-1
X-Mimecast-MFC-AGG-ID: bR8Bcy3AOUGKFeOEdNFjpQ_1784797514
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f7700ffdeso173518f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784797514; x=1785402314; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/CpFpa3YQWIViCBA7uvSk/o+fAJelb5NUfE93VtZvu4=;
 b=hwkZoPQ1kW0rZRmPr4t2ooUD1KAXxlVcKmuFrOJkjPHLVNDvCdwRB3tI8VLYn8Pto3
 91aRrJJwu4t1w6+SFKW8NArZ+2Ucgh/s3PBgOxN+SjR+uTy0BN6aI1uTZjNRJR1eB8ls
 JwWYuhoylpmA8FNXX903YM+LvYbyc171Tfl0gGjmrm1TROhZLlM7RAg6auJwLzvDBgZa
 5aTDqIAQtHX2a8ZqhKBq62kC5BqtgfSBV/+WtFc/aQbnndXnqvpenN4nniCknB03dK/+
 SpPs4OMt+JcYmJbPNs8wSDjYsZzGyHDAXYzvmU7ATP/hNq9TRYHo9nL+0Ku+9B+TSH6o
 zC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784797514; x=1785402314;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/CpFpa3YQWIViCBA7uvSk/o+fAJelb5NUfE93VtZvu4=;
 b=S1y/FXht3P+KhYkIlJWB/1s41FDBkUyCxptaagiEgSlPqBIl6OU81OOi+K0YiQLjsw
 oWdatlECBxt/CF0CRqhb0q+88CyrV1fhBoTlBPD8s4Ivwc7/yOGcq1Sp2oK4Xk1fJuDX
 siAmGzleOrLC4olIwDlrwyfFwZ0VR7aabvKEo5ZXlVYL6OODmGJV4JbdQv55cx683aT/
 4QY24yLrtO6xMY7k/5JT4GFKvO1QDxE4SKAnlFM39PoPQd6Fs4j6um4kp0g2R2d6nb+U
 GYp/orz9g41xcRt6bJQnrShvfxUWb/DUbKwUnybK21ZX5g33iLVQBHI8JEEi1B/HpQXJ
 ijJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpK9Ok5rvgVrkxZZ6VVFSUfzy42Z0vXQRqDe7PR6TRenaTionCcuxu2Q2P32fsQTZGin/Juz9eIxVXl@nongnu.org
X-Gm-Message-State: AOJu0Yy+wugspUOd3bR1wR/YuA5pip3aCMunG5ILOgnKO0P0ja9pn/Mq
 41YX5HdAzG6ZJ8LQCF5S5+8B914PEoGiGoAP6W/ZRCRNTbGfWtJia/ZZnreX5WR6QLcD61sxkEB
 Wv8EI92nDLAQkYTp76FIJGWIzL/MKGfnU29SOQP4IVzyok0UjBwM3tbeQ
X-Gm-Gg: AR+sD12TxzcNSaOmVEcM7OMRvXjFTvYmkJqXliEYgxLrKuzF5jdEsKls1Hs8xSvb8RA
 OWpoU3FwGeztpRijR3NI1dc7dikSwgnaQYY0EfpdomOhQVr190W9FbGnQ6Trb5+SbDdOYsB69dC
 oNLiC2U+6bmBl2zBRzezaJ8kiwnrRRXYuhyjXBj5xd1yGrs2lfbOlez/Gg8TTM2l98VN5HPnLMy
 Lv92WN2v/9AtLKOXGV1BGeInu+ZN77UdDlak3g7mL2TTLrqbfmelg8WZauzY3IJFmffgDQaZ7Sn
 RgRJ1JOAm0VgHmHOUkZhQ4pkWT7AG5CxQ7N6kulJcZZQgMovK6XhsFZ1pRQbBQaz34cOXggUS32
 98zaCbbNV758Nkt7Nuol3uQ==
X-Received: by 2002:a05:6000:4b1d:b0:47f:7fd1:9602 with SMTP id
 ffacd0b85a97d-47f8da5fa48mr2591304f8f.11.1784797513592; 
 Thu, 23 Jul 2026 02:05:13 -0700 (PDT)
X-Received: by 2002:a05:6000:4b1d:b0:47f:7fd1:9602 with SMTP id
 ffacd0b85a97d-47f8da5fa48mr2591201f8f.11.1784797512736; 
 Thu, 23 Jul 2026 02:05:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm12810261f8f.16.2026.07.23.02.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:05:11 -0700 (PDT)
Date: Thu, 23 Jul 2026 05:05:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: Peter Xu <peterx@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260723045428-mutt-send-email-mst@kernel.org>
References: <CAFEAcA-O6Z4JrVV0DL_tta6khRyUta_Zz5mJt6OszaW1mu0o6Q@mail.gmail.com>
 <20260717095407-mutt-send-email-mst@kernel.org>
 <9c2ad22a-e768-4a07-85a2-01ce1fc14368@oss.qualcomm.com>
 <59882c5b-545d-4768-8bf4-723fed97a801@redhat.com>
 <al-eCtxGjG4HHEbl@x1.local>
 <6210e178-a93f-4411-810a-41edb1fb656e@redhat.com>
 <20260722015422-mutt-send-email-mst@kernel.org>
 <amDyvgR09OJssENX@x1.local>
 <20260723015708-mutt-send-email-mst@kernel.org>
 <71d88d00-5b41-49d2-b649-8a6ea47abc4d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71d88d00-5b41-49d2-b649-8a6ea47abc4d@oss.qualcomm.com>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 23, 2026 at 10:52:11AM +0200, Philippe Mathieu-Daudé wrote:
> On 23/7/26 08:04, Michael S. Tsirkin wrote:
> > On Wed, Jul 22, 2026 at 12:41:34PM -0400, Peter Xu wrote:
> > > On Wed, Jul 22, 2026 at 01:58:18AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Jul 22, 2026 at 10:53:27AM +1000, Gavin Shan wrote:
> > > > > On 7/22/26 2:27 AM, Peter Xu wrote:
> > > > > > On Tue, Jul 21, 2026 at 03:37:53PM +1000, Gavin Shan wrote:
> > > > > > > If Peter is fine with two variants for x86 and non-x86 architectures.
> > > > > > > I can post (v4) for further review. That will be something like below
> > > > > > > and let me know if there are any other improvements are needed.
> > > > > > 
> > > > > > I have a generic question on the "unaligned access for x86": I think the
> > > > > > question is about the one Michael raised here on unaligned access may break
> > > > > > x86 here:
> > > > > > 
> > > > > >     https://lore.kernel.org/qemu-devel/20260617022330-mutt-send-email-mst@kernel.org/
> > > > > > 
> > > > > >     3. (theoretical concern) also on x86, unaligned accesses are
> > > > > >     possible on guest and host, so converting an unaligned access to a
> > > > > >     series of aligned ones can in theory break devices.
> > > > > > 
> > > > > > Is that a real problem we need to consider, or can we start with unified
> > > > > > approach and leave it for later?
> > > > > > 
> > > > > 
> > > > > I'm leaving this question to Michael.
> > > > 
> > > > Knowing what I know about hardware designers, it's something someone
> > > > somewhere does)
> > > > It can be made a separate patch, just to show - it should be all of
> > > > ~10LOC.
> > > 
> > > It's only about removal of anything that might be controversial for now,
> > > thanks.  I also wonder if anything would break, then it's more solid proof
> > > that per-arch change is required.
> > 
> > Repeating:
> > 	I think there is exactly 1 kinda reasonable case. A 2 byte read/write at
> > 	offset 0x1 within a dword. This maps nicely to even classical PCI byte
> > 	enable mechanism and so yes it works if your CPU can initiate these
> > 	things, and it's atomic.
> 
> Isn't this out of the CPU arch, dealt with at the bus level?
> 
> It looks we try to be clever with modern PCI code by optimizing this
> access -- not saying we can change that, I know it is too late after
> 20+ years -- relying on hw behavior that was done that way to support
> legacy hw, in particular broken I/O accesses.

Not sure what the question is.  We were dicussing how to emulate unaligned
accesses from x86 guests if they happen.
On an x86 host we can do that easily, and it's just a couple of LOC.
Though Peter Maydell dislikes host arch specific code. But I hope
if it's a separate patch on top and it is visible how small it is,
he will reconsider)
On other hosts we can't emulate them 100%, we either need to split
to byte accesses or over-access and mask. Byte accesses feel safer.
What qemu currently does with memmove is clearly not safe in the
general case.



As for optimizing - there is space for optimization e.g. vfio could
report the properties of a BAR to userspace for optimization
purposes. On x86 you can then get good speed with just memmove.
Other arches you will likely need to write arch specific code.
But this has to do with e.g. DMA into device BAR not CPU accesses.
As an aside, it is a pity qemu uses same thing for DMA and CPU access,
we know how virtio accesses work and this might allow optimization.

> 
> For Alpha / HPPA / MIPS there were ASIC in the PCI I/O path to handle
> these odd unaligned accesses inherited from x86 world.

Right.

> > It's easy to find more examples of such hardware if one looks. For example,
> > LEDCTL on e1000e:
> > 
> > 20260625101817-mutt-send-email-mst@kernel.org
> > 
> > 
> > A claim that no software uses this hardware capability is the strong
> > claim that needs proof, not the other way around.
> > 
> > 
> > What to do on non-x86? reading a dword might work, or reading
> > byte by byte might work. Both can cause issues, just different ones,
> > but given we did byte by byte previously i guess let's keep
> > doing that.
> > 
> > 
> > > > 
> > > > > > PS: I apologize if I missed important piece of info along the way; I didn't
> > > > > > follow closely on the discussion on this topic in the past few weeks.
> > > > > > 
> > > > > > One thing to mention is, what we change should only need to affect
> > > > > > ram_device, AFAIU.. so most memcpy()/memmove() shouldn't be changed for any
> > > > > > arch when it's pure RAM.
> > > > > > 
> > > > > 
> > > > > It depends. This patch intends to fix issue [1] in the lower layer by using
> > > > > the newly added accessors (qemu_ram_{copy, move}) on all directly accessible
> > > > > regions including the regular (pure) RAM region. Otherwise, the newly added
> > > > > accessors should be limited to ram_device regions only as you said.
> > > > > 
> > > > > [1] https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn/
> > > > > 
> > > > > Thanks,
> > > > > Gavin
> > > > 
> > > > using memcpy()/memmove() to emulate guest's atomics is generally
> > > > kinda broken.
> > > > but yes there are architectures where doing it to device ram is
> > > > more broken than doing it to regular ram.
> > > 
> > > If we keep memcpy()/memmove() for len>8 (aligned or not), I am thinking no
> > > perf issue will happen, then looks like we can indeed change this even for
> > > pure RAM operations, which we can't identify in case of e1000e driver use
> > > case.
> > > 
> > > Then does it mean we should not use __builtin_memcpy()/memmove()?  Even if
> > > we know constants 1/2/4/8 would work there, why not we go ahead and use
> > > qatomics, which is even more future proof?  I also stumbled on top of
> > > commit 77b1757090 ("include/qemu/bswap.h: Use __builtin_memcpy() in
> > > accessor functions"), which seems to say the same thing "for the long
> > > term".
> > > 
> > > For "should we still do unaligned access if the guest did it, so as to keep
> > > the original behavior of a bare metal" question, are we on the same page
> > > that we should just break it into aligned accesses for all archs?  I think
> > > it means, we will not be able to emulate guest faults correctly as what
> > > will happen on bare metal, but we're missing the fault injection logics
> > > anyway, so whenever it's implemented we _could_ switch it back to unaligned
> > > accesses.  Before that, breaking unaligned seems like a better way to go to
> > > (1) satisfy all legit users, and (2) don't make QEMU crash by guest
> > > operations.
> > > 
> > > Last, one silly question: why do we need any helper named with *memcpy*, if
> > > memmove is always superior (to consider range overlap)?  Can we stick with
> > > memmove all over the places?
> > > 
> > > Thanks,
> > > 
> > > -- 
> > > Peter Xu
> > 
> > 


