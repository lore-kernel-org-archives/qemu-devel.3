Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3833BC369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 22:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3MrU-0005NI-F5; Fri, 11 Apr 2025 18:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u3MrR-0005Md-5p
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 18:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u3MrO-00008E-PH
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 18:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744410508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWnfUd6k4P9NlmExxmFPZX/bCpaZxupoTcVIWf067G4=;
 b=H1M8+YqEfQmWkpJ+z0r4pavYKZRgNhzzb1PLG5emlE6NFUXrk0cGPbrAIHUfEmsWqvxvzI
 CI7JefcwHGHEyQOELPoQ38puoH+fs38VT6m8haiRotx/q417gpXs1JC793EJPMpxzbnIrv
 UUgKPXW1yzQgqmKrBDe2BVpzv0+HGic=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-y2UHa-P2OGuZ-5hc6YAFGg-1; Fri, 11 Apr 2025 18:28:26 -0400
X-MC-Unique: y2UHa-P2OGuZ-5hc6YAFGg-1
X-Mimecast-MFC-AGG-ID: y2UHa-P2OGuZ-5hc6YAFGg_1744410506
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-86184fbd7a2so12189639f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 15:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744410506; x=1745015306;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hWnfUd6k4P9NlmExxmFPZX/bCpaZxupoTcVIWf067G4=;
 b=hwmg3IZlAiPafeZlASwpTdTOXcPKGRhScOPCTOIKd8SGdlp2waMJ9KzwR/Wb2Mesag
 4vxixxTrfE1E98/YZbrC/d7cvV9M76Lnll4LP0HGXLkje6Prhus/K5QtKGZVksonAchT
 BGsX50quueBn8sq06QOxhSLGSpQ3m3O57cPEtiFzQqJNjBRI8IXF9GvQDxCTXOTn9V8g
 gnURY+WZ9gSPuJHqfnElF7eKOqOO14SvL7GTpvuIY/6Sp3orb8/AO+X+bHOz1fXXJ/7k
 i/T4D4kiLYLeJzHu8cD9Hjz52fLCxNBJc9EaQvqI/4OQq8vh1VIRzrKsQjS5Fh6e7mKM
 hvEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuelAepj4u1Fc739iBF8UMgDzLD8B9+RDIcNLeBDv5ZywWMN0fvV0NxLkGmPA5x24JYKRBOZWs9epr@nongnu.org
X-Gm-Message-State: AOJu0Yy4YzqB4kdPBRJzyxh8XFAh8b9YelFzCv4pmyr0J1oeawQX8foq
 5ZLstuW5bt7sV0iARHdK+g6Ko/jWsIJWyHqOPoGyjABu2zpbq9tlfj84Fg9me78TOXPpKRmR4JS
 n5H/4pfwVUITO7aSXq6EWh7DIMbQSn9DAcLx/M+7txcKGK5ZHZLmJ
X-Gm-Gg: ASbGncvF0ocslpFxoXv4MC3PmXXv0ipywMfFiRtSZfDr0cmwcpFeQaZ0kYAykY1ZIc1
 pyz5cybUP1YZPVFmDdk3xzFfuN72iI8evJs1aRiXXj/YV5ZrNGJ+FbkPQj0ZzKHDHCQjh2wHPiP
 WtIzVjiZMpDGjLVRjHx2gar6Sn1f1jxJ7E+AwuxbEH9MsVOtZXGIUENs/h1PdkOgiU83itQ+w6Z
 WJIUGYlmBaJ61OP+clURaONbCJWN9mZUvIpe793TISTw5/LbEDamD6I+Q53NC6jhVJGRQvjBNM6
 mSRLZ9BAn70RzSI=
X-Received: by 2002:a05:6602:29c6:b0:85e:12c1:fe90 with SMTP id
 ca18e2360f4ac-8617ffef834mr108252839f.5.1744410505809; 
 Fri, 11 Apr 2025 15:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5KWGz25iHHBCcRgpTz5lMrp9vL56Nm16GIv/aev5RnWAz9aRU4vXOoZU7cP0n/+e1gb+DGw==
X-Received: by 2002:a05:6602:29c6:b0:85e:12c1:fe90 with SMTP id
 ca18e2360f4ac-8617ffef834mr108251339f.5.1744410505235; 
 Fri, 11 Apr 2025 15:28:25 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8616522dcf2sm112277339f.3.2025.04.11.15.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 15:28:23 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:28:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, fam@euphon.net, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, thuth@redhat.com, mjrosato@linux.ibm.com,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, venture@google.com,
 crauer@google.com, pefoley@google.com, david@redhat.com
Subject: Re: [PATCH v3 0/3] Enable QEMU NVMe userspace driver on s390x
Message-ID: <20250411162819.1526fb12.alex.williamson@redhat.com>
In-Reply-To: <efa82601-4775-4b9f-9d7f-49f788d2f13f@linux.ibm.com>
References: <20250401172246.2688-1-alifm@linux.ibm.com>
 <20250402155152.GE304512@fedora>
 <2c11a602415f0780030d4e68a28eee7ffcdd8cb7.camel@linux.ibm.com>
 <20250403154442.GA349582@fedora>
 <20250403102704.7e1f4452.alex.williamson@redhat.com>
 <2c244588-b37b-4e86-863e-ef462343edad@linux.ibm.com>
 <20250403120504.2f660171.alex.williamson@redhat.com>
 <d9e4feb3-351c-4c0b-8c8e-a5141e80ed5e@linux.ibm.com>
 <20250403152402.1373f0b2.alex.williamson@redhat.com>
 <efa82601-4775-4b9f-9d7f-49f788d2f13f@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 10 Apr 2025 09:07:51 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 4/3/2025 2:24 PM, Alex Williamson wrote:
> > On Thu, 3 Apr 2025 13:33:17 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >  
> >> On 4/3/2025 11:05 AM, Alex Williamson wrote:  
> >>> On Thu, 3 Apr 2025 10:33:52 -0700
> >>> Farhan Ali <alifm@linux.ibm.com> wrote:
> >>>     
> >>>> On 4/3/2025 9:27 AM, Alex Williamson wrote:  
> >>>>> On Thu, 3 Apr 2025 11:44:42 -0400
> >>>>> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >>>>>        
> >>>>>> On Thu, Apr 03, 2025 at 09:47:26AM +0200, Niklas Schnelle wrote:  
> >>>>>>> On Wed, 2025-04-02 at 11:51 -0400, Stefan Hajnoczi wrote:  
> >>>>>>>> On Tue, Apr 01, 2025 at 10:22:43AM -0700, Farhan Ali wrote:  
> >>>>>>>>> Hi,
> >>>>>>>>>
> >>>>>>>>> Recently on s390x we have enabled mmap support for vfio-pci devices [1].  
> >>>>>>>> Hi Alex,
> >>>>>>>> I wanted to bring this to your attention. Feel free to merge it through
> >>>>>>>> the VFIO tree, otherwise I will merge it once you have taken a look.
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Stefan
> >>>>>>>>            
> >>>>>>>>> This allows us to take advantage and use userspace drivers on s390x. However,
> >>>>>>>>> on s390x we have special instructions for MMIO access. Starting with z15
> >>>>>>>>> (and newer platforms) we have new PCI Memory I/O (MIO) instructions which
> >>>>>>>>> operate on virtually mapped PCI memory spaces, and can be used from userspace.
> >>>>>>>>> On older platforms we would fallback to using existing system calls for MMIO access.
> >>>>>>>>>
> >>>>>>>>> This patch series introduces support the PCI MIO instructions, and enables s390x
> >>>>>>>>> support for the userspace NVMe driver on s390x. I would appreciate any review/feedback
> >>>>>>>>> on the patches.
> >>>>>>>>>
> >>>>>>>>> Thanks
> >>>>>>>>> Farhan  
> >>>>>>> Hi Stefan,
> >>>>>>>
> >>>>>>> the kernel patch actually made it into Linus' tree for v6.15 already as
> >>>>>>> commit aa9f168d55dc ("s390/pci: Support mmap() of PCI resources except
> >>>>>>> for ISM devices") plus prerequisites. This went via the PCI tree
> >>>>>>> because they included a change to struct pci_dev and also enabled
> >>>>>>> mmap() on PCI resource files. Alex reviewed an earlier version and was
> >>>>>>> the one who suggested to also enable mmap() on PCI resources.  
> >>>>>> The introduction of a new QEMU API for accessing MMIO BARs in this
> >>>>>> series is something Alex might be interested in as QEMU VFIO maintainer.
> >>>>>> That wouldn't have been part of the kernel patch review.
> >>>>>>
> >>>>>> If he's aware of the new API he can encourage other VFIO users to use it
> >>>>>> in the future so that you won't need to convert them to work on s390x
> >>>>>> again.  
> >>>>> I don't claim any jurisdiction over the vfio-nvme driver.  In general
> >>>>> vfio users should be using either vfio_region_ops, ram_device_mem_ops,
> >>>>> or directly mapping MMIO into the VM address space.  The first uses
> >>>>> pread/write through the region offset, irrespective of the type of
> >>>>> memory, the second provides the type of access used here where we're
> >>>>> dereferencing into an mmap, and the last if of course the preferred
> >>>>> mechanism where available.
> >>>>>
> >>>>> It is curious that the proposal here doesn't include any changes to
> >>>>> ram_device_mem_ops for more generically enabling MMIO access on s390x.
> >>>>> Thanks,
> >>>>>
> >>>>> Alex  
> >>>> Hi Alex,
> >>>>    From my understanding the ram_device_mem_ops sets up the BAR access for
> >>>> a guest passthrough device. Unfortunately today an s390x KVM guest
> >>>> doesn't use and have support for these MIO instructions. We wanted to
> >>>> use this series as an initial test vehicle of the mmap support.  
> >>> Right, ram_device_mem_ops is what we'll use to access a BAR that
> >>> supports mmap but for whatever reason we're accessing it directly
> >>> through the mmap.  For instance if an overlapping quirk prevents the
> >>> page from being mapped to the VM or we have some back channel mechanism
> >>> where the VMM is interacting with the BAR.
> >>>
> >>> I bring it up here because it's effectively the same kind of access
> >>> you're adding with these helpers and would need to be addressed if this
> >>> were generically enabling vfio mmap access on s390x.  
> >> On s390x the use of the MIO instructions is limited to only PCI access.
> >> So i am not sure if we should generically apply this to all vfio mmap
> >> access (for non PCI devices).
> >>
> >>  
> >>> Prior to commit 2b8fe81b3c2e ("system/memory: use ldn_he_p/stn_he_p")
> >>> the mmio helpers here might have been a drop-in replacement for the
> >>> dereferencing of mmap offsets, but something would need to be done
> >>> about the explicit PCI assumption introduced here and the possibility
> >>> of unaligned accesses that the noted commit tries to resolve.  Thanks,
> >>>
> >>> Alex  
> >> AFAICT in qemu today the ram_device_mem_ops is used for non PCI vfio
> >> mmap cases. For s390x these helpers should be restricted to PCI
> >> accesses. For the unaligned accesses (thanks for pointing out that
> >> commmit!), are you suggesting we use the ld*_he_p/st*_he_p functions in
> >> the helpers i defined? Though those functions don't seem to be doing
> >> volatile accesses.  
> > TBH, it's not clear to me that 2b8fe81b3c2e is correct.  We implemented
> > the ram_device MemoryRegion specifically to avoid memory access
> > optimizations that are not compatible with MMIO, but I see that these
> > {ld,st}*_he_pe operations are using __builtin_memcpy.  I'm not a
> > compiler aficionado, but is __builtin_memcpy guaranteed to use an
> > instruction set compatible with MMIO?
> >
> > Cc: folks related to that commit.
> >
> > The original issue that brought us ram_device was a very obscure
> > alignment of a memory region versus a device quirk only seen with
> > assignment of specific RTL NICs.
> >
> > The description for commit 4a2e242bbb30 ("memory: Don't use memcpy for
> > ram_device regions") also addresses unaligned accesses, we don't expect
> > drivers to use them and we don't want them to work differently in a VM
> > than they might on bare metal.  We can debate whether that's valid or
> > not, but that was the intent.
> >
> > Have we re-introduced the chance that we're using optimized
> > instructions only meant to target RAM here or is __builtin_memcpy
> > implicitly safe for MMIO?  Thanks,
> >
> > Alex  
> 
> 
> Hi Stefan, Alex
> 
> 
> Polite ping. Following up to understand how we should proceed with this 
> series. Please let me know if there are any concerns that i haven't 
> addressed?

I disassembled the current implementation using ldn_he_p/stn_he_p on
x86_64 and it doesn't appear to introduce any of the mmx/sse optimized
optimized code that we were trying to get away from in introducing the
ram_device MemoryRegion and getting away from memcpy.  I wish I had
some assurance that __builtin_memcpy won't invoke such operations, but
it seems unlikely that it would for the discrete, fundamental size
operations we're asking of it.  Therefore, maybe it is advisable to use
the ld*_he_p/st*_he_p helpers rather than open code the memory derefs.

It's unfortunate that s390x needs to specifically restrict this access
to PCI memory, but maybe that means that PCI specific version of these
helpers are only created for s390x and elsewhere #define'd to the
generic ld/st helpers, which maybe means the main interface should be a
host_pci_{ld,st}n_he_p (maybe "le" given the implementation) type
function.  I don't know if we'd then create a ram_pci_device variant
memory region ops for use in vfio-pci, but it should probably be coded
with that in mind.  Thanks,

Alex


