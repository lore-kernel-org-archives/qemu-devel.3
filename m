Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA54CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 13:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNsE9-0000kC-QX; Fri, 15 May 2026 09:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNsDy-0000jg-BS
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNsDv-0003pf-LW
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778850301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulkmUAhtRpja62reBJj4JgMvnFww5lTP0z3gSfKAELU=;
 b=AliBfix8n1bRpj39W4Xt+8Zdr625u7HUT6GO9shHfyeqsFPFsk+bkWo58OXbQ2iUBmbLga
 DR6XLIU8XhJr9FVQdoGi5Ot4cF/axlbQf4OenRJmsg8twHH+nUfydjmCg82wPWgnI398zI
 rjFcts160JqJomq8CVsQJ85Ngl3k+1o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-7L6GStlnOaCiQug2tEKDUA-1; Fri, 15 May 2026 09:04:59 -0400
X-MC-Unique: 7L6GStlnOaCiQug2tEKDUA-1
X-Mimecast-MFC-AGG-ID: 7L6GStlnOaCiQug2tEKDUA_1778850299
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fed2519daso3594305e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778850298; x=1779455098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulkmUAhtRpja62reBJj4JgMvnFww5lTP0z3gSfKAELU=;
 b=owCHU/Suzr/UVZaM3bk2pMLeVJqEpGGKtJBThPkmz4jOl+pGJbje2aLeVMYk6ExMMR
 a8P8yJZRr6FGInha8QWe1I61xIM2pAakfMEt4a3MmY/QjEnbDlvUsvyT3PycRPwtdXDJ
 we8+esfO5JZJ+GR+uOqvF2jbAa6NWS7Gzbb2rYU+63Nh8wNzbAzvGSY2VHKMniQD9YkR
 C4gJk1pZjnS0rrNnoWbmj8wIuU4/XibOB09o4p1UaKCSQfwb4LcuUuA40lh47zZSqzOX
 asoopiiU3eGgnpLAf8FP5NRraxNEVY/ooYZcLai0kLj4FDQ2O9Y2A+bXahrGuHBN3G1c
 WEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850298; x=1779455098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ulkmUAhtRpja62reBJj4JgMvnFww5lTP0z3gSfKAELU=;
 b=KwUDMkpq5qwrn4gmfg7RKzJLAvNLdFv6eeMRfuZYHCjJc1ORLByKuTefVk2pkW2iLw
 SZtBBRAaXB+s0CRc3Lr+DhRoOsADpiZMSN8ZS2gLEde5f9KJi8CsjmTPA/VihsnVeZLu
 c0tqHbnDvC0kuLGtg2/w3vvDVnLAuwBAhe6lg11EEwv5YXfwsm7nsP07hhwkSpGDCite
 6bM1sXQLsR2TkZZIe6LxwyvJE6dV9kfTdL56PCIE9mt1FnVRgLWK8vEC4Kvq5DsIlHf5
 Jh4JBKLdYZPR3S/xMMd3xucH/j3pWWVL9xnPH5copnKKQL8pNRqZruX8I6ESMitlsazL
 v5DQ==
X-Gm-Message-State: AOJu0YxEN2oFSkpG/NF+D8Ug25XjDfxoL+Ct3wgrX0oaXb9BYuMZZZ2x
 TFoHfpNoMePISwBj8/ytfrCawF3DTON9T9ifo8QUYYqGvk1q10IxFMxnxiA//bog47ome+gBTTH
 e5YavUGqg84x5zkU836xXetkPHhEedd4dbGUbpGATOJ+kxfro5x75wDgJ
X-Gm-Gg: Acq92OExO6WVEXJPQ7SAot79daMCtrf1UEKrKHoYFWfGL6iszlep5H7O4KdTJ5VGPNC
 OXBzXzsDHZXuedQY4em77ZdfsZYsHSKw+SoeCRmQtQR4eWKZHUDfoWrL11pDbAaESJUW3LtxaFh
 nD8JLpsKZgFeol+xqkeWCpBuTXYHWljDpgW3gSoyvWEdBS3eKc4wUns5E6jNDKhbk13FbFhB0eE
 PUU3qA1L4CFMDu0ff/fU2cg0d+bwL7HQV8FyoHI4ni465LJ1wqESqAIfl60zyeVLz+QWRImXAkZ
 6klzquSwUjXmigSUag3rCR3TEkQ/Y7ShfSD28N3gF+z9WrP9+XLUic9a9ZTpagxHdbAUB1dovlF
 XAf3aMg==
X-Received: by 2002:a05:600c:4e87:b0:48a:768b:eea9 with SMTP id
 5b1f17b1804b1-48fe60e51bamr58726165e9.4.1778850298378; 
 Fri, 15 May 2026 06:04:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e87:b0:48a:768b:eea9 with SMTP id
 5b1f17b1804b1-48fe60e51bamr58725385e9.4.1778850297874; 
 Fri, 15 May 2026 06:04:57 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768bcesm15827549f8f.4.2026.05.15.06.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:04:57 -0700 (PDT)
Date: Fri, 15 May 2026 15:04:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@redhat.com>, <gourry@gourry.net>,
 <jonathan.cameron@huawei.com>, <apopple@nvidia.com>,
 <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v7 1/1] numa: add 'memmap-type' option for memory type
 configuration
Message-ID: <20260515150453.409e0e3e@imammedo>
In-Reply-To: <d26cfb4b-d70e-415c-8747-904d94f8ccb2@amd.com>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <20260306082735.1106690-2-FangSheng.Huang@amd.com>
 <20260514150559.3148f9dc@imammedo>
 <d26cfb4b-d70e-415c-8747-904d94f8ccb2@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Fri, 15 May 2026 15:53:07 +0800
"Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com> wrote:

> On 5/14/2026 9:05 PM, Igor Mammedov wrote:
> > [You don't often get email from imammedo@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Fri, 6 Mar 2026 16:27:35 +0800
> > fanhuang <FangSheng.Huang@amd.com> wrote:
> >   
> >> Add a 'memmap-type' option to NUMA node configuration that allows
> >> specifying the memory type for a NUMA node.
> >>
> >> Supported values:
> >>    - normal:   Regular system RAM (E820 type 1, default)
> >>    - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF)
> >>    - reserved: Reserved memory (E820 type 2)
> >>
> >> The 'spm' type indicates Specific Purpose Memory - a hint to the guest
> >> that this memory might be managed by device drivers based on guest policy.
> >> The 'reserved' type marks memory as not usable as RAM.
> >>
> >> Note: This option is only supported on x86 platforms.
> >>
> >> Usage:
> >>    -numa node,nodeid=1,memdev=m1,memmap-type=spm  
> > 
> > in short:
> >    don't do it this way
> >    I'm against merging it as is, till you convince me otherwise.
> > 
> > more detailed answer:
> > 
> > * mandatory bashing chapter:
> > 
> > the more i look at it, the hackier this approach looks to me,
> > and what even worse that nonsense propagates to firmware.
> > 
> > Judging by commit message, the goal is to expose some RAM as
> > E820 SPM, to guest (that's it).
> > 
> > You however picked -numa node as a way to achieve that,
> > and then hack the numa code not to generate numa data for it (SRAT)
> > and massage e820 to exclude SPM from  RAM entries.
> > 
> > But at this stage I don't really see a good justification for hack(s)
> > this patch introduces (it's definitely is not in commit message not cover letter).
> > 
> > And until alternative approach is not explored and proved to be worse,
> > I'm against merging this patch.
> > 
> > * suggestion chapter:
> > 
> > I don't recall but I likely asked before
> > why not use device memory instead for it (aka DIMM device or some device derived
> > from device memory object and then add e820 entry for it).
> > 
> > It would be a way more simpler approach and impl. without need to resplit
> > anything in e820.
> > And no need for messing with firmware (SeaBIOS: RamSizeOver4G patch) nor EDK2.
> > 
> >  
> 
> Hi Igor,
> 
> Thanks for taking the time to review this -- and for the candor in
> the bashing chapter.  Before going into the bigger picture, let me
> re-establish one factual point that v7 didn't carry forward from
> the v6 cover letter.

feel free to bash my review as well, I hope that we end up with
clear picture what and why we are doing.

> 
> On SRAT generation:
> 
> v7 only suppresses SRAT for memmap-type=reserved.  memmap-type=spm
> nodes get a normal SRAT Memory Affinity entry.  This was shown
> explicitly in the v6 cover letter, which v7 didn't carry forward
> since v7 is a single-patch series.  For the spm case:
> 
>      [    0.042582] ACPI: SRAT: Node 1 PXM 1 [mem 0x280000000-0x47fffffff]
> 
> Full transcript with all three memmap-type variants side by side:
> https://lore.kernel.org/qemu-devel/20260226105023.256568-1-FangSheng.Huang@amd.com/
> 
> The bigger picture -- real-world context that drove the design:

bigger picture should be somewhere in commit message so later on
a reader could understand why we are doing it at all/this way.
 
lets continue with questions wrt impl.

> The use case is GPU/accelerator HBM exposed to the OS as SPM.  On
> bare metal, the platform firmware:
> 
>    - emits E820 type 0xEFFFFFFF (SOFT_RESERVED) for the HBM region;
>    - emits ACPI SRAT memory affinity entries that bind HBM to a
>      dedicated proximity domain (NUMA node);
>    - tags the accelerator's PCI device with _PXM matching that node.
> 
> That gives the device driver a stable lookup chain at runtime:
> 
>      dev -> pci_dev_to_node(dev) -> SRAT walk -> HBM GPA range

it looks kind of convoluted, isn't it.
PCI devices were supposed to be self describing/discoverable.
Preferably without above mentioned firmware 'hooks'.
Above example could be just early impl. issues, rather than by
design issue.

> NUMA node here is not incidental -- it is the OS-exposed
> intermediary ID that the device driver uses to find its own HBM.
> This is the in-tree path used by accelerator drivers today.

I'm assuming GPU is exposed as some composite PCI/CXL device.
and use-case is its pass-through to guest.

Perhaps we can't do anything about it now.
But shouldn't device driver discover its own memory (HBM and what not)
without external parties that magically gain knowledge about parts of
device that driver supposedly driving the device has not a clue about? 
How doesn bios know about SPM when device's driver with knowledge of
device internals knows nothing about?
 
> The "-numa node + memmap-type=spm + E820 SOFT_RESERVED" combo in
> v7 is a direct 1:1 model of this BM topology.  The E820 retyping
> in the patch is exactly what makes the guest-visible E820 match
> what BM firmware emits for the same kind of region.
> 
> On the DIMM / device-memory alternative:

wrt modeling GPU pass-through, my 1st attempt would be
to make -device gpu-foo take everything need to compose the device
(like in real hw) and be done with it (and PCI/CXL machinery would
take care of mapping/exposing memory to guest).
Why we aren't doing it?

barring that, and assuming we have to pass SPM as a separate memory
(why and why it should be exposed in E820 and at boot time only?)
I'd try -device foo-memory approach.

> David pointed this out in the v6 thread, and Gregory's reply in
> this thread reinforces the same point -- DIMM / NVDIMM ranges are
> described in E820 only as the hotplug area.  SPM needs to be in
> the boot E820 from the start so the OS classifies it as SP and
> treats it accordingly.  Going via DIMM would also detach the
> memory from the NUMA topology (no SRAT entry tied to the device's
> _PXM), which breaks the dev -> node -> SRAT -> HBM lookup the
> driver relies on.

Where we should bend modeling to driver behavior is questionable.
But I don't know nearly enough about subj, it could be parallel discussion.
But we need capture 'why' somewhere in commit message, to give
a justification for going pass-through as a separate memory approach.
 
For now lets leave it alone.

wrt my suggestion using memory-device.
It's true that the device memory region has started as hotpluggable memory.
But that's impl. detail, nothing fundamentally prevents us from
describing mix of present at boot time memory devices within it in e820/SRAT.
 
Answer to why DIMMs aren't in e820 was for us to avoid dealing with
linux kernel putting that memory into zone_normal instead of zone_movable.
On real hardware, one is likely to see all present at boot dimms, in e820
and SRAT.
For already existing memory devices, I'd like us continue dodging e820,
so we wouldn't break existing deployments. however for a new memory device
we don't have such limitations.

What I'd try is:
 1: inherit spm-memory device from memory-device
       (all memory mapping and APCI memory device descriptors, can be made
        to pick it along with DIMM devices) 
 2: figure out why device driver has to fetch memory map
   and proximity from static tables as opposed to getting it dynamically
   from _PXM -> maped-memory range. (at the time PCI devices enum runs, all ACPI
   info incl. run time one is fully accessible to in-kernel users)
   i.e. try to make driver work with runtime proximity
 3. if #2 is impossible, we can try to expose SPM memory devices in e820,
     and partition SRAT to match actual device_memory region layout. 

 
> Happy to dig into any of this further, or to reshape parts you
> still see as too hacky.
> 
> Best regards,
> FangSheng Huang (Jerry)
> >   
> 


