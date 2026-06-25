Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E561CDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcnEg-000155-5L; Thu, 25 Jun 2026 12:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wcnEW-000147-4Q
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wcnES-0007v1-8p
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782406035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mv2e/saDz5F/Jj5ghuxYree2ZuUFNTyvAA+473uasE4=;
 b=CKG1mHWdH/s9i5Q71/KhaxEVvv7vG/YXPFGdp01kFBUcyv0zssOWz//Xv8TmGaxrTyLkkQ
 BhrE6vsm0Yf467JyFdohM38z6onvXloBi1odtHIUZYwUNCOm46mHACQZ02d+4ki6QlYXk7
 HgiRX1S+8FdyM5x8dsRPPbRDrSDebCQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-PJX_5Jq1OFCGw4ZVCzk9sA-1; Thu, 25 Jun 2026 12:47:14 -0400
X-MC-Unique: PJX_5Jq1OFCGw4ZVCzk9sA-1
X-Mimecast-MFC-AGG-ID: PJX_5Jq1OFCGw4ZVCzk9sA_1782406032
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4625e71d3ccso1006071f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782406032; x=1783010832; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mv2e/saDz5F/Jj5ghuxYree2ZuUFNTyvAA+473uasE4=;
 b=B+QxXNI9QYm/LgTYy0t2JjPwlkwjkhGokpDI6SV/8Njp5cBN/RkP4eprQuejGAPcXK
 4K5xNKqA2gmw8SURcFlA5HfeI7omPbDLVjOwit57dc3/PChEfWTVT6z/+Nb0824MG/dM
 Vg1aM2S6RIVL1CQgCDVNluCufdPGN5K/9/XufaooG1pZHSH8DfoGFHKACEEXvUQ6QvSu
 aJotrf9CsCwKBZtaSudLxtiqNn3DUHWPoPtvZqL2aTp+4M8TtK/mVQ7jd3+jjOSPXjlf
 EPhhs/7nSGtnvFEnk7R79/CZicbu3PQie4VE38KJPPka5PGaovF23S1iSR7zPv0TXPgT
 V15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782406032; x=1783010832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mv2e/saDz5F/Jj5ghuxYree2ZuUFNTyvAA+473uasE4=;
 b=tNXDqysnwcH0VpaeDgTX5ltZRpvrSJ8QPsHXaZvcSXuti5uhp707H2W6zbd7HNGQ8J
 /E7ff+EgdmzU72D5QEkiHcZVlpum86ArCCAzUpv/1Fe1mNhewzYKm3NTzjDg18EdOdpc
 hdV0BpkSlwRXoZ5t1nyaY+XtI4RnGKgKE/ooAz49t/imsXhElZX2pW9JRJUGPrCvqj97
 nKIODzombMv20MIn2ePCn76/6457Gn2Dj/5bOFRA+aY9DRMUv6YvPfi0TGfKAs/lcVnj
 LxTg1CU3Qq9vhaBwXnCIXpVZyB3kUUXG5atxtVJdysFnHGOTFP10dujAAl1vbPIb6pdR
 4oPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aEbxbYvzxrt5V98WpWjLeVpWxuQ6Vmf5ostWgkjSGZ77GzpHlv8sMpPzY5uZ3aGEIeG2L8/iDS8kM@nongnu.org
X-Gm-Message-State: AOJu0YwyfEdN72vGBXLdcXTa3TMTT3z8VaeVzK6+RSgMTBsvJ5xDLhEV
 Spr6k1FQ58ToVVyZXoMDATM9yo7LflKgUEyA/3iNov+fBjAnoiE8v55g0/vG6gcAP1kEIjAjfVp
 so2cMeUPqSXLn1D7tLTXa7vx+qujURF8qH4JOCjP5PSKT+z3r6SPN/hR4NgL+dkDR
X-Gm-Gg: AfdE7cnTsX6w/9oePbFFx/jV23LB1TZTmKvrtrgZBDVloBByBOQxjHnO9q7gISircTy
 XWEwGh93P57ejLC3WqoUQO8qNyyGEvaavr85epEeuUM0GIKNrYlxuqvLBCcDX5NjcVUhsZd7hlT
 Sdk5ttGsfab41pGIicHoUstLv6cpqIXWrhbR/5XZkFY4UsQn5bMcFDWgfeUIERflsPuOgKNGbTJ
 J+FwJgxLNwspp4XHORb0bi1QF3zRjjm+jvz3YxjDj0CqUnOLaEN+Nwtwi9lrETrue+9+AdksiD4
 VQOSz2YvhbrMKh5XaSD/oWvUtQzuoFKA+xwymVn6l+n190Qa+IRC7T4vzQiEfPiFGLkXDO0GBUT
 LVQV6vD4bBJUTSkRjIeuGzk+zC4IinHpp
X-Received: by 2002:a05:600c:5756:b0:492:690e:9fb8 with SMTP id
 5b1f17b1804b1-492690ea0b0mr5458345e9.15.1782406031821; 
 Thu, 25 Jun 2026 09:47:11 -0700 (PDT)
X-Received: by 2002:a05:600c:5756:b0:492:690e:9fb8 with SMTP id
 5b1f17b1804b1-492690ea0b0mr5457955e9.15.1782406031191; 
 Thu, 25 Jun 2026 09:47:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dd5f9da4fsm7012260f8f.23.2026.06.25.09.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 09:47:10 -0700 (PDT)
Date: Thu, 25 Jun 2026 12:47:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260625123119-mutt-send-email-mst@kernel.org>
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
 <CAFEAcA-mf14=jpRFHarAbN6AbQwvW=Yu6WB1JiNMsECEdaxD3A@mail.gmail.com>
 <20260625070551-mutt-send-email-mst@kernel.org>
 <CAFEAcA8YJZq9TqrUd0zTnewAdVDm5y6UV7BJQZ0C60TZ=RT98Q@mail.gmail.com>
 <20260625091334-mutt-send-email-mst@kernel.org>
 <CAFEAcA8xK+t3-prEphtkq-o9UY2mgS6cowhs880GOaxL9dKSGw@mail.gmail.com>
 <20260625101817-mutt-send-email-mst@kernel.org>
 <CAFEAcA8-Un+Q1yBDqLWCLPRwtgTA_VhJqGobgZChrFhAeVfG8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8-Un+Q1yBDqLWCLPRwtgTA_VhJqGobgZChrFhAeVfG8A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 25, 2026 at 04:23:47PM +0100, Peter Maydell wrote:
> On Thu, 25 Jun 2026 at 15:52, Michael S. Tsirkin <mst@redhat.com> wrote:
> > I think there is exactly 1 kinda reasonable case. A 2 byte read/write at
> > offset 0x1 within a dword. This maps nicely to even classical PCI byte
> > enable mechanism and so yes it works if your CPU can initiate these
> > things, and it's atomic.
> >
> > I tried reading LEDCTL on e1000e:
> >
> >        byte  @ 0xe00: 0x64
> >        byte  @ 0xe01: 0x2a
> >        byte  @ 0xe02: 0x00
> >        byte  @ 0xe03: 0x00
> >        word  @ 0xe00: 0x2a64
> >        word  @ 0xe01: 0x002a
> >
> > Works fine.
> 
> The e1000e datasheet actually documents what it does in this
> case (slightly surprising, since hardware engineers love to
> leave this kind of corner case undocumented):
> 
> # For registers that should be accessed as 32-bit double words,
> # partial writes (less than a 32-bit double word) does not take
> # effect (such as, the write is ignored).
> # Partial reads
> # return all 32 bits of data regardless of the byte enables.
> #
> # Note: Partial reads to clear-by-read registers (such as, ICR)
> # can have unexpected results since all 32 bits are actually read
> # regardless of the byte enables. Partial reads should not be done.
> 
> So for this specific device that access is out-of-spec.

You mean that access to clear by read should not be done, right?

> I guess what I'm wondering is: can we just have code
> that does an aligned exact-width access in the 1/2/4/8
> byte aligned case, and the host's best approximation to
> an unaligned exact-width access for the 2/4/8 byte
> unaligned case?

That's my idea, too.

> (so on sparc you get multiple smaller
> accesses, and on most archs including x86 and arm you
> get an unaligned load).

I thought unaligned load from uncacheable on arm is
also a fault?

> That would mean the guest could
> potentially provoke a fault on the load/store on an
> access to a passthrough device, but if you give the
> guest passthrough access it can very likely provoke
> a fault anyway, depending on exactly what the device is.
> 
> I think the most likely reason for an unaligned access
> in this codepath is "it's actually RAM, either really
> host RAM or else something memory-like in a BAR", and
> either way if the guest does a 4-byte unaligned access
> then doing a 4-byte unaligned access seems better than
> second-guessing it, even on non-x86.
> 
> -- PMM

Right though remember: whether it's RAM doesn't matter. What matters is
how we map it.  qemu might fault because it maps NC but guest maps
cacheable and it's ok.

But, all this in theory. At a high level, I personally think going with
what you propose as a 1st approximation is entirely reasonable, except
for one thing: we really should not crash qemu, since access can be from
guest userspace.

qemu should know how things are mapped, and predict it will fault.
Approximating by splitting in that case sounds reasonable.



-- 
MST


