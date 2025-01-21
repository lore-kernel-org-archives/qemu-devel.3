Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53E3C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taHDl-0001fw-RS; Tue, 21 Jan 2025 11:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taHDh-0001eY-Pm
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:35:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taHDf-00013Y-Ge
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737477313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5IicrbX29/PlrHURDmORDtKf+izW4RsJs/gkYLbWILo=;
 b=I8nMmVZJ8HRAnLxmDlgaeCR9bdjEmc2nWUT44R3oyKOHr1HsRBlFkkx0gLq5cJcGNtV0bm
 x/djbJZyLbdPwQ0G0819Iylm6eJVIVdUKVZixOhbAGeNOIzt55FukETt+vkdXjH+L2f2Iv
 4JIt5MoR2g6TjOwCUHsh3k+37jibGaM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-1elxP1c9MYK2UBuoXsV18w-1; Tue, 21 Jan 2025 11:35:12 -0500
X-MC-Unique: 1elxP1c9MYK2UBuoXsV18w-1
X-Mimecast-MFC-AGG-ID: 1elxP1c9MYK2UBuoXsV18w
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4675c482d6cso107210491cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737477311; x=1738082111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IicrbX29/PlrHURDmORDtKf+izW4RsJs/gkYLbWILo=;
 b=CRBH6j11GKcZDDzc75OvOeUTpvazDqVKcXzaCx960UZ0dW/EbnsRtu/r0BeF/nD0kH
 4UuNFB3iQKrJSRw9JDOsdohc4f9I97EKmTAR2XHzuB5/I3rNeQBJ3Cq73OBBGxDsZcvi
 8LNkCKAWbPHVpdnpPNbreTa4Q2vAbVkd9TLMc+wyg1/hM14PuBQp+v56+oWdRfsZa53E
 KdHrCh6uik9vN4acn1Az4SBI8nI5Mlv7+CFY3bvKTiY1ReqVaxhJcYZ0ILmXI16eFiAW
 EgCVCk7BXqGBwmEGPJ57x2fYzl7okxaHsIpEzez9FqPkcP91U0z7Awu5WTtBPDvo3gjY
 CR+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5JB6lSmcaorJz1qTqJhEwGdWFas0kml30SsSJQpAW+6d5hSBgcorOxT/aWwGy+O6bSxQHONIlCuHM@nongnu.org
X-Gm-Message-State: AOJu0YxK8TLseYj5r31tY9qXwZCtfjFFkOQnBKZ7pvhkrheFHF/KPe1d
 CkhSbLC9q76WvcFtMfMkehzJkrhb89QTmHvHQl1dMIs9ggbQcsKKp/p07kHkYq413Jr9lBpkzHu
 1OU0RoI6/vb8BH+oSZdwpmyFl7ew/u04LhcJVvg2FIs9R4efo5hKn
X-Gm-Gg: ASbGncsGLo/JpCPeseQyP9gsreBS2NhJZaqlBxTo7G21DRCoe2h1v3URVvv9ZXT1PeM
 c+wpDSF/dDDcpGFmNdV02r55QfeDoNZq0uY5ydF++X9T5bcZm5MVU+iJ3AB2eYptex/VxIhul0a
 Y8qF5IpzZBo/nROFhLZbeZR6BhgUubN4gBthnrobBXpkVargeoc9rF2iy8/bGKiD2qvlayZxo/W
 XGVGAS0p2mlv6vjURks0yf3l4YacBL8RKmRgZ3p9pFEOobYl4Q92WO8mlN4csbO2NEANpS4ZNSY
 BBANry4bHpDA2SfkhETsHLpUUzGXa7Y=
X-Received: by 2002:ac8:7f89:0:b0:46c:782f:5f6c with SMTP id
 d75a77b69052e-46e12b20fbamr274079441cf.14.1737477311527; 
 Tue, 21 Jan 2025 08:35:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEDpP3v3NvNnq0mrgQd+4/LqRJpg4iDbCa/9Y9xWB0RMJdvo/z2nBzTqrMy4G/8FCeBpRGtw==
X-Received: by 2002:ac8:7f89:0:b0:46c:782f:5f6c with SMTP id
 d75a77b69052e-46e12b20fbamr274078981cf.14.1737477311163; 
 Tue, 21 Jan 2025 08:35:11 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614ef236sm569680685a.108.2025.01.21.08.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 08:35:10 -0800 (PST)
Date: Tue, 21 Jan 2025 11:35:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z4_MvGSq2B4zptGB@x1n>
References: <20241213070852.106092-3-chenyi.qiang@intel.com>
 <d0b30448-5061-4e35-97ba-2d360d77f150@amd.com>
 <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <9dfde186-e3af-40e3-b79f-ad4c71a4b911@redhat.com>
 <c1723a70-68d8-4211-85f1-d4538ef2d7f7@amd.com>
 <f3aaffe7-7045-4288-8675-349115a867ce@redhat.com>
 <Z46GIsAcXJTPQ8yN@x1n>
 <7e60d2d8-9ee9-4e97-8a45-bd35a3b7b2a2@redhat.com>
 <Z46W7Ltk-CWjmCEj@x1n>
 <8e144c26-b1f4-4156-b959-93dc19ab2984@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e144c26-b1f4-4156-b959-93dc19ab2984@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 21, 2025 at 09:35:26AM +0800, Chenyi Qiang wrote:
> 
> 
> On 1/21/2025 2:33 AM, Peter Xu wrote:
> > On Mon, Jan 20, 2025 at 06:54:14PM +0100, David Hildenbrand wrote:
> >> On 20.01.25 18:21, Peter Xu wrote:
> >>> On Mon, Jan 20, 2025 at 11:48:39AM +0100, David Hildenbrand wrote:
> >>>> Sorry, I was traveling end of last week. I wrote a mail on the train and
> >>>> apparently it was swallowed somehow ...
> >>>>
> >>>>>> Not sure that's the right place. Isn't it the (cc) machine that controls
> >>>>>> the state?
> >>>>>
> >>>>> KVM does, via MemoryRegion->RAMBlock->guest_memfd.
> >>>>
> >>>> Right; I consider KVM part of the machine.
> >>>>
> >>>>
> >>>>>
> >>>>>> It's not really the memory backend, that's just the memory provider.
> >>>>>
> >>>>> Sorry but is not "providing memory" the purpose of "memory backend"? :)
> >>>>
> >>>> Hehe, what I wanted to say is that a memory backend is just something to
> >>>> create a RAMBlock. There are different ways to create a RAMBlock, even
> >>>> guest_memfd ones.
> >>>>
> >>>> guest_memfd is stored per RAMBlock. I assume the state should be stored per
> >>>> RAMBlock as well, maybe as part of a "guest_memfd state" thing.
> >>>>
> >>>> Now, the question is, who is the manager?
> >>>>
> >>>> 1) The machine. KVM requests the machine to perform the transition, and the
> >>>> machine takes care of updating the guest_memfd state and notifying any
> >>>> listeners.
> >>>>
> >>>> 2) The RAMBlock. Then we need some other Object to trigger that. Maybe
> >>>> RAMBlock would have to become an object, or we allocate separate objects.
> >>>>
> >>>> I'm leaning towards 1), but I might be missing something.
> >>>
> >>> A pure question: how do we process the bios gmemfds?  I assume they're
> >>> shared when VM starts if QEMU needs to load the bios into it, but are they
> >>> always shared, or can they be converted to private later?
> >>
> >> You're probably looking for memory_region_init_ram_guest_memfd().
> > 
> > Yes, but I didn't see whether such gmemfd needs conversions there.  I saw
> > an answer though from Chenyi in another email:
> > 
> > https://lore.kernel.org/all/fc7194ee-ed21-4f6b-bf87-147a47f5f074@intel.com/
> > 
> > So I suppose the BIOS region must support private / share conversions too,
> > just like the rest part.
> 
> Yes, the BIOS region can support conversion as well. I think guest_memfd
> backed memory regions all follow the same sequence during setup time:
> 
> guest_memfd is shared when the guest_memfd fd is created by
> kvm_create_guest_memfd() in ram_block_add(), But it will sooner be
> converted to private just after kvm_set_user_memory_region() in
> kvm_set_phys_mem(). So at the boot time of cc VM, the default attribute
> is private. During runtime, the vBIOS can also do the conversion if it
> wants.

I see.

> 
> > 
> > Though in that case, I'm not 100% sure whether that could also be done by
> > reusing the major guest memfd with some specific offset regions.
> 
> Not sure if I understand you clearly. guest_memfd is per-Ramblock. It
> will have its own slot. So the vBIOS can use its own guest_memfd to get
> the specific offset regions.

Sorry to be confusing, please feel free to ignore my previous comment.
That came from a very limited mindset that maybe one confidential VM should
only have one gmemfd..

Now I see it looks like it's by design open to multiple gmemfds for each
VM, then it's definitely ok that bios has its own.

Do you know why the bios needs to be convertable?  I wonder whether the VM
can copy it over to a private region and do whatever it wants, e.g.  attest
the bios being valid.  However this is also more of a pure question.. and
it can be offtopic to this series, so feel free to ignore.

Thanks,

-- 
Peter Xu


