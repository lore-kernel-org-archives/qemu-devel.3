Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F19DC531CF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmtld-0003ho-6Z; Thu, 23 Jul 2026 09:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wmtlY-0003g1-6p
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wmtlV-0002B7-JC
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZu67FW3xTs3nqnJrhKrgjeo2rgGgFL3o3EmVubG598=;
 b=AzudBxZByVbwoD4fTtU0vxg+0u7ydN6yyh8ZVkT47FVPQRnD3sKER3j6/9a3Ia99NzCH9D
 3mdaNSdwORRbGG2dOBLb3FTmZL1dQ43grTSx7qecXVLRafCpJrhXXieMyFwnM3RwZjgU3D
 4Jq9lXDjxBbfPVnZ51H4Ro1YRxPgM2g=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-28fx1F0ONayCtsGN1kpmhg-1; Thu, 23 Jul 2026 09:47:04 -0400
X-MC-Unique: 28fx1F0ONayCtsGN1kpmhg-1
X-Mimecast-MFC-AGG-ID: 28fx1F0ONayCtsGN1kpmhg_1784814423
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-976cd199486so21059241.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784814423; x=1785419223; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xZu67FW3xTs3nqnJrhKrgjeo2rgGgFL3o3EmVubG598=;
 b=HCv5pRm5Q+l+YTgwesv0dVqTKm40DtljICZJxZEwhC0k9w079agDFdXTdxUoAuWIMp
 LZM7iWdpYo2p1Xj4oXNv5hc3NW1gr4JS2HFOtmY9iXgBanIFBVO4EMxji2ag9zEdYduT
 33xiNLfa08UOkG9L3LBU31YhdUWiT4LiQdS2KkFDDg9WcphARhtkExyqobF7EZNRdq0F
 qgrrOcdmzmfmzuRHdnOzHBdarCRV6H4konyiGJSKRkiNrsWJ8yInlrzJZtdkbGju3Rzq
 LKCrPri2zjRxlyVSi5kk6yi4n0/XUx6VLHL+zmyEKWWTHALFTvZXSwpAg9IFyhSlaKL6
 BEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784814423; x=1785419223;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xZu67FW3xTs3nqnJrhKrgjeo2rgGgFL3o3EmVubG598=;
 b=mFzNOlH7aOiu2dwAHZPLXCmColmBgNCopbv4fSqSMxe0gEW9IIMGDzpl1VfMfqih1F
 X2CxEv8DYJeWoQq345CTwEnVeaBJS3Btz0MndFjPrfHamG5ZZ4mNM/49MLjtCaGVF8AP
 oZtCD7/iNDlWPbavXSGAOrrBzb69M1XZGTj/VYU+mBAC7WdisQUP7CW47F+5mtsio401
 lrBgVQqoUyOxQZvpWgNHZtEVEiCwD0oBGrX2g3NOVS8ywPtvApl7WEK1dHaSBG7jPGFr
 BRiNq+U4uuPOzDjQZZFiRqcODgUO8mO27uPKtfGGpjOlukOqoQoWNocy6pa+zvXQ31nF
 Qrhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlnL8Ura8Hqzr/m3cqjC8n5mf9VSS4FxN6F83iv1jt5TDWDJK2RgGza1Wf58Q1Sxt2NDt4sny61/X1@nongnu.org
X-Gm-Message-State: AOJu0YyQIwdi3C17wK+yAudUzZiSxIwGskQYcGIcgyTPwrxj/aBrHhww
 H79vjhXszMpwzfNzUglesp51Xmxk41t2nezlQRh/PoMAzl3fC4Sz92uErRv0D/8z3PGXHA7CeYc
 KGxqJOxrmOu6Xifnwv9jZ1g1auWlogmxCILR6v5HF9Kb6XqozM7RWBbqh
X-Gm-Gg: AR+sD11BZkvkchtkGzvYO9/VkhwNppxmvOgf/nh/kisnGZDWwL3TGapPXEbOXG2s3df
 3Kz2JNCMzftN8nbSbPM6qX4kc40GZ6KJQfXeqQi9ViFZrceHUJARwLPKADAfLAGjKs0haqeAJdq
 W5H7u87Yq9NWhKZT2MGdxttf1EMZ6rGIMpCqbJNxcj5QxjD4KtC+cRBs765gyYkPNQavgxBNdWK
 Kawd3TzVIHj43t8kuHhpb2vnJEx5M1dza95gi9tobU8Z9azuLVZgVpzClBDClfUv2CYb2rq490T
 /myuhxUwvHUikGp+8k2vYGnHDJT9fztawfgeHZ77yjXz0TDtdZDz3cV7uZ+YDssms8jliAXV
X-Received: by 2002:a05:6122:6991:b0:5bf:bb66:414f with SMTP id
 71dfb90a1353d-5c2da1ad401mr1158482e0c.11.1784814422520; 
 Thu, 23 Jul 2026 06:47:02 -0700 (PDT)
X-Received: by 2002:a05:6122:6991:b0:5bf:bb66:414f with SMTP id
 71dfb90a1353d-5c2da1ad401mr1158446e0c.11.1784814421630; 
 Thu, 23 Jul 2026 06:47:01 -0700 (PDT)
Received: from x1.local ([2605:8d80:6c29:c98e:204b:552e:32b9:cf20])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c2c64f6d8esm5819671e0c.15.2026.07.23.06.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:47:01 -0700 (PDT)
Date: Thu, 23 Jul 2026 09:46:57 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Gavin Shan <gshan@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <amIbUYN3teCLXTh-@x1.local>
References: <20260717095407-mutt-send-email-mst@kernel.org>
 <9c2ad22a-e768-4a07-85a2-01ce1fc14368@oss.qualcomm.com>
 <59882c5b-545d-4768-8bf4-723fed97a801@redhat.com>
 <al-eCtxGjG4HHEbl@x1.local>
 <6210e178-a93f-4411-810a-41edb1fb656e@redhat.com>
 <20260722015422-mutt-send-email-mst@kernel.org>
 <amDyvgR09OJssENX@x1.local>
 <20260723015708-mutt-send-email-mst@kernel.org>
 <71d88d00-5b41-49d2-b649-8a6ea47abc4d@oss.qualcomm.com>
 <20260723045428-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260723045428-mutt-send-email-mst@kernel.org>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Jul 23, 2026 at 05:05:08AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 23, 2026 at 10:52:11AM +0200, Philippe Mathieu-Daudé wrote:
> > On 23/7/26 08:04, Michael S. Tsirkin wrote:
> > > On Wed, Jul 22, 2026 at 12:41:34PM -0400, Peter Xu wrote:
> > > > On Wed, Jul 22, 2026 at 01:58:18AM -0400, Michael S. Tsirkin wrote:
> > > > > On Wed, Jul 22, 2026 at 10:53:27AM +1000, Gavin Shan wrote:
> > > > > > On 7/22/26 2:27 AM, Peter Xu wrote:
> > > > > > > On Tue, Jul 21, 2026 at 03:37:53PM +1000, Gavin Shan wrote:
> > > > > > > > If Peter is fine with two variants for x86 and non-x86 architectures.
> > > > > > > > I can post (v4) for further review. That will be something like below
> > > > > > > > and let me know if there are any other improvements are needed.
> > > > > > > 
> > > > > > > I have a generic question on the "unaligned access for x86": I think the
> > > > > > > question is about the one Michael raised here on unaligned access may break
> > > > > > > x86 here:
> > > > > > > 
> > > > > > >     https://lore.kernel.org/qemu-devel/20260617022330-mutt-send-email-mst@kernel.org/
> > > > > > > 
> > > > > > >     3. (theoretical concern) also on x86, unaligned accesses are
> > > > > > >     possible on guest and host, so converting an unaligned access to a
> > > > > > >     series of aligned ones can in theory break devices.
> > > > > > > 
> > > > > > > Is that a real problem we need to consider, or can we start with unified
> > > > > > > approach and leave it for later?
> > > > > > > 
> > > > > > 
> > > > > > I'm leaving this question to Michael.
> > > > > 
> > > > > Knowing what I know about hardware designers, it's something someone
> > > > > somewhere does)
> > > > > It can be made a separate patch, just to show - it should be all of
> > > > > ~10LOC.
> > > > 
> > > > It's only about removal of anything that might be controversial for now,
> > > > thanks.  I also wonder if anything would break, then it's more solid proof
> > > > that per-arch change is required.
> > > 
> > > Repeating:
> > > 	I think there is exactly 1 kinda reasonable case. A 2 byte read/write at
> > > 	offset 0x1 within a dword. This maps nicely to even classical PCI byte
> > > 	enable mechanism and so yes it works if your CPU can initiate these
> > > 	things, and it's atomic.
> > 
> > Isn't this out of the CPU arch, dealt with at the bus level?
> > 
> > It looks we try to be clever with modern PCI code by optimizing this
> > access -- not saying we can change that, I know it is too late after
> > 20+ years -- relying on hw behavior that was done that way to support
> > legacy hw, in particular broken I/O accesses.
> 
> Not sure what the question is.  We were dicussing how to emulate unaligned
> accesses from x86 guests if they happen.
> On an x86 host we can do that easily, and it's just a couple of LOC.
> Though Peter Maydell dislikes host arch specific code. But I hope
> if it's a separate patch on top and it is visible how small it is,
> he will reconsider)

Yes, if we still want x86 specific change, it would be better to be put
separately.

Said so, I don't think the e1000e LEDCTL test illustrated what might
break..  Isn't that only an exmaple showing unaligned access is
"supported", however nothing breaks even if we use 1B*2?

My question was more about a real breakage, hence whenever it happened
"it's more solid proof that per-arch change is required".

> On other hosts we can't emulate them 100%, we either need to split
> to byte accesses or over-access and mask. Byte accesses feel safer.
> What qemu currently does with memmove is clearly not safe in the
> general case.

We should have another option that is not arch-dependent but keep the
unaligned behavior.

For current master, AFAIU we do unaligned access for both ram_device and
rest. Say, even with ram_device_mem_ops, it has both .unaligned=true for
both .valid & .impl.  I think it means indeed we have unaligned behavior
even for ram_device.  It also means what matters in regards to the Realtek
bug was only about aligned access (with subpage presence).

I think it means we can always keep unaligned to stick with
memcpy()/memmove(), but only use atomic ops for the aligned cases of
1/2/4/8.  With that, I think we can also remove ram_device_mem_ops and fix
the bounce buffer issue.

I think it means we'll stick with memcpy()/memmove() for all archs for
unaligned, which is again not safe... but that can be an existing but
separate problem to solve too.

One more thing to mention below...

> 
> 
> 
> As for optimizing - there is space for optimization e.g. vfio could
> report the properties of a BAR to userspace for optimization
> purposes. On x86 you can then get good speed with just memmove.
> Other arches you will likely need to write arch specific code.
> But this has to do with e.g. DMA into device BAR not CPU accesses.
> As an aside, it is a pity qemu uses same thing for DMA and CPU access,
> we know how virtio accesses work and this might allow optimization.
> 
> > 
> > For Alpha / HPPA / MIPS there were ASIC in the PCI I/O path to handle
> > these odd unaligned accesses inherited from x86 world.
> 
> Right.
> 
> > > It's easy to find more examples of such hardware if one looks. For example,
> > > LEDCTL on e1000e:
> > > 
> > > 20260625101817-mutt-send-email-mst@kernel.org
> > > 
> > > 
> > > A claim that no software uses this hardware capability is the strong
> > > claim that needs proof, not the other way around.
> > > 
> > > 
> > > What to do on non-x86? reading a dword might work, or reading
> > > byte by byte might work. Both can cause issues, just different ones,
> > > but given we did byte by byte previously i guess let's keep
> > > doing that.
> > > 
> > > 
> > > > > 
> > > > > > > PS: I apologize if I missed important piece of info along the way; I didn't
> > > > > > > follow closely on the discussion on this topic in the past few weeks.
> > > > > > > 
> > > > > > > One thing to mention is, what we change should only need to affect
> > > > > > > ram_device, AFAIU.. so most memcpy()/memmove() shouldn't be changed for any
> > > > > > > arch when it's pure RAM.
> > > > > > > 
> > > > > > 
> > > > > > It depends. This patch intends to fix issue [1] in the lower layer by using
> > > > > > the newly added accessors (qemu_ram_{copy, move}) on all directly accessible
> > > > > > regions including the regular (pure) RAM region. Otherwise, the newly added
> > > > > > accessors should be limited to ram_device regions only as you said.
> > > > > > 
> > > > > > [1] https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn/
> > > > > > 
> > > > > > Thanks,
> > > > > > Gavin
> > > > > 
> > > > > using memcpy()/memmove() to emulate guest's atomics is generally
> > > > > kinda broken.
> > > > > but yes there are architectures where doing it to device ram is
> > > > > more broken than doing it to regular ram.

.. please someone (at least.. Gavin?) still have a look at below.  It could
matter how the next version looks, especially I want to make sure if we
should get rid of __builtin_*() in the new helpers.

Thanks,

> > > > 
> > > > If we keep memcpy()/memmove() for len>8 (aligned or not), I am thinking no
> > > > perf issue will happen, then looks like we can indeed change this even for
> > > > pure RAM operations, which we can't identify in case of e1000e driver use
> > > > case.
> > > > 
> > > > Then does it mean we should not use __builtin_memcpy()/memmove()?  Even if
> > > > we know constants 1/2/4/8 would work there, why not we go ahead and use
> > > > qatomics, which is even more future proof?  I also stumbled on top of
> > > > commit 77b1757090 ("include/qemu/bswap.h: Use __builtin_memcpy() in
> > > > accessor functions"), which seems to say the same thing "for the long
> > > > term".
> > > > 
> > > > For "should we still do unaligned access if the guest did it, so as to keep
> > > > the original behavior of a bare metal" question, are we on the same page
> > > > that we should just break it into aligned accesses for all archs?  I think
> > > > it means, we will not be able to emulate guest faults correctly as what
> > > > will happen on bare metal, but we're missing the fault injection logics
> > > > anyway, so whenever it's implemented we _could_ switch it back to unaligned
> > > > accesses.  Before that, breaking unaligned seems like a better way to go to
> > > > (1) satisfy all legit users, and (2) don't make QEMU crash by guest
> > > > operations.
> > > > 
> > > > Last, one silly question: why do we need any helper named with *memcpy*, if
> > > > memmove is always superior (to consider range overlap)?  Can we stick with
> > > > memmove all over the places?
> > > > 
> > > > Thanks,
> > > > 
> > > > -- 
> > > > Peter Xu
> > > 
> > > 
> 

-- 
Peter Xu


