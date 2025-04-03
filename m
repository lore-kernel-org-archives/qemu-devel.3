Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1950C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 21:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0S2s-0000vu-De; Thu, 03 Apr 2025 17:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u0S2q-0000vC-SM
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u0S2p-000529-6s
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743715454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1dcUR44GTmZzJ2fXV1+bxLH67ofCsP/WmGs9aFhtGk=;
 b=P0psVSabufj1T6DFUjUMKkLEuzOcDIyRKDAXRqqC9f4C7cIkfm0dymabPASAcceV3FnK8C
 IYMizggDD0UXp1HG0vEuATxRfpEPBgAy3+oYiPT54B9QpVjBmCUr4V+pd6Ld/qfudoOXxv
 4whAXzL4sGohMaQcjW8QsvPvcdI4YdM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-Za0SrUtrOTaVlqnBqfIzHw-1; Thu, 03 Apr 2025 17:24:12 -0400
X-MC-Unique: Za0SrUtrOTaVlqnBqfIzHw-1
X-Mimecast-MFC-AGG-ID: Za0SrUtrOTaVlqnBqfIzHw_1743715449
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-85b3e93e052so12190839f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 14:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743715449; x=1744320249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1dcUR44GTmZzJ2fXV1+bxLH67ofCsP/WmGs9aFhtGk=;
 b=YUv4xvxbdImqp92jbm6+jg+bQFhNnVy357UdPxcywy7eTC4tQjZ6p3RH8qlptXFwer
 18XLbe0BJ2Tw3EbtNpk+VCCZqAXKcIKN/4rO6fUlzBiMfgqmW+3SRCece9iTuLHE1osu
 zHaVBtrTH3h1JMHcKLczOJroVLt0+Dflmqg2o4yEzhROzve8tkwSz+6Hkxa96bSo+EXL
 UDJ9SsWLEV1fSfVV8ig4hSkNeP672ZP2muVTIcDuYz0s94DwFe3kVTEkt4LpmVY4Hu75
 FGnNb0S3am+ySqlhNmTGPBToQD2zIMcR00WNXOJboDEC+jL0g3zPoHCxsor2UCaIIvr5
 wLaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLn1v1Ox5dDcgqA+o3xh48ahHd2sfsdfmlc48d6+HhLDQiBk0GX4bV8GJlA/4JgHe6HGwpbZN8NORO@nongnu.org
X-Gm-Message-State: AOJu0Yw91EyEtCBbFqFUBJJOwseVVmvLk2BJfY6QU6TGoyQkqZfr5krE
 oy7x3agFP3ydN2mg2D6e+qjAJqOkvCZ9a3ZjjoAmRoWANzrK8rGdUb8Kh3zbCQCWuE4HIWeqGIA
 2TKmd2zxVoeB+JNAHB+cFCQpxQLH2vvJ4zCDwag+jdwc5SRNf+9Pg
X-Gm-Gg: ASbGnctEopg3AZWPbDqrRmmy4dgzKezYSiEtSbOSzNp+C7HzpxBJIevNnzmkPE/4ao9
 adwuDHUR6r/PQ2TMrnIvTtvuSpcHUBTkwYIQK6eg+enS+kf2oeTOmF3IgsNwbU4L3pK5MM51iLi
 a/z12bL1XpYf10mEurjWpSCRYdlUMLAlCcOm3eZgbtT5d1qagoCvsx1iiYij+ofZDhy6ZRM/XxX
 BHFlyDyajegXLbUIsV4qI4anz97gkmr4VK9VEmu+MaznUt31sEWo/UsFy5Rr/DOOdlfLHIfH7fp
 5QmJrpOBKuSPDWL14Ks=
X-Received: by 2002:a05:6e02:b4c:b0:3d3:e605:7157 with SMTP id
 e9e14a558f8ab-3d6e3f63b12mr3190075ab.4.1743715448673; 
 Thu, 03 Apr 2025 14:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8tW6SR/fS3rWo8+/D9BhVFSx+HI4ir5nyCRVguadWUkVvHThRnSDQDfdx4pZ5yHj6JJPyVg==
X-Received: by 2002:a05:6e02:b4c:b0:3d3:e605:7157 with SMTP id
 e9e14a558f8ab-3d6e3f63b12mr3189865ab.4.1743715448145; 
 Thu, 03 Apr 2025 14:24:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d6de95e8b1sm4687325ab.58.2025.04.03.14.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 14:24:06 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:24:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, fam@euphon.net, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, thuth@redhat.com, mjrosato@linux.ibm.com,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, venture@google.com,
 crauer@google.com, pefoley@google.com, david@redhat.com
Subject: Re: [PATCH v3 0/3] Enable QEMU NVMe userspace driver on s390x
Message-ID: <20250403152402.1373f0b2.alex.williamson@redhat.com>
In-Reply-To: <d9e4feb3-351c-4c0b-8c8e-a5141e80ed5e@linux.ibm.com>
References: <20250401172246.2688-1-alifm@linux.ibm.com>
 <20250402155152.GE304512@fedora>
 <2c11a602415f0780030d4e68a28eee7ffcdd8cb7.camel@linux.ibm.com>
 <20250403154442.GA349582@fedora>
 <20250403102704.7e1f4452.alex.williamson@redhat.com>
 <2c244588-b37b-4e86-863e-ef462343edad@linux.ibm.com>
 <20250403120504.2f660171.alex.williamson@redhat.com>
 <d9e4feb3-351c-4c0b-8c8e-a5141e80ed5e@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
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

On Thu, 3 Apr 2025 13:33:17 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 4/3/2025 11:05 AM, Alex Williamson wrote:
> > On Thu, 3 Apr 2025 10:33:52 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >  
> >> On 4/3/2025 9:27 AM, Alex Williamson wrote:  
> >>> On Thu, 3 Apr 2025 11:44:42 -0400
> >>> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >>>     
> >>>> On Thu, Apr 03, 2025 at 09:47:26AM +0200, Niklas Schnelle wrote:  
> >>>>> On Wed, 2025-04-02 at 11:51 -0400, Stefan Hajnoczi wrote:  
> >>>>>> On Tue, Apr 01, 2025 at 10:22:43AM -0700, Farhan Ali wrote:  
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> Recently on s390x we have enabled mmap support for vfio-pci devices [1].  
> >>>>>> Hi Alex,
> >>>>>> I wanted to bring this to your attention. Feel free to merge it through
> >>>>>> the VFIO tree, otherwise I will merge it once you have taken a look.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Stefan
> >>>>>>         
> >>>>>>> This allows us to take advantage and use userspace drivers on s390x. However,
> >>>>>>> on s390x we have special instructions for MMIO access. Starting with z15
> >>>>>>> (and newer platforms) we have new PCI Memory I/O (MIO) instructions which
> >>>>>>> operate on virtually mapped PCI memory spaces, and can be used from userspace.
> >>>>>>> On older platforms we would fallback to using existing system calls for MMIO access.
> >>>>>>>
> >>>>>>> This patch series introduces support the PCI MIO instructions, and enables s390x
> >>>>>>> support for the userspace NVMe driver on s390x. I would appreciate any review/feedback
> >>>>>>> on the patches.
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>> Farhan  
> >>>>> Hi Stefan,
> >>>>>
> >>>>> the kernel patch actually made it into Linus' tree for v6.15 already as
> >>>>> commit aa9f168d55dc ("s390/pci: Support mmap() of PCI resources except
> >>>>> for ISM devices") plus prerequisites. This went via the PCI tree
> >>>>> because they included a change to struct pci_dev and also enabled
> >>>>> mmap() on PCI resource files. Alex reviewed an earlier version and was
> >>>>> the one who suggested to also enable mmap() on PCI resources.  
> >>>> The introduction of a new QEMU API for accessing MMIO BARs in this
> >>>> series is something Alex might be interested in as QEMU VFIO maintainer.
> >>>> That wouldn't have been part of the kernel patch review.
> >>>>
> >>>> If he's aware of the new API he can encourage other VFIO users to use it
> >>>> in the future so that you won't need to convert them to work on s390x
> >>>> again.  
> >>> I don't claim any jurisdiction over the vfio-nvme driver.  In general
> >>> vfio users should be using either vfio_region_ops, ram_device_mem_ops,
> >>> or directly mapping MMIO into the VM address space.  The first uses
> >>> pread/write through the region offset, irrespective of the type of
> >>> memory, the second provides the type of access used here where we're
> >>> dereferencing into an mmap, and the last if of course the preferred
> >>> mechanism where available.
> >>>
> >>> It is curious that the proposal here doesn't include any changes to
> >>> ram_device_mem_ops for more generically enabling MMIO access on s390x.
> >>> Thanks,
> >>>
> >>> Alex  
> >>
> >> Hi Alex,
> >>   From my understanding the ram_device_mem_ops sets up the BAR access for
> >> a guest passthrough device. Unfortunately today an s390x KVM guest
> >> doesn't use and have support for these MIO instructions. We wanted to
> >> use this series as an initial test vehicle of the mmap support.  
> > Right, ram_device_mem_ops is what we'll use to access a BAR that
> > supports mmap but for whatever reason we're accessing it directly
> > through the mmap.  For instance if an overlapping quirk prevents the
> > page from being mapped to the VM or we have some back channel mechanism
> > where the VMM is interacting with the BAR.
> >
> > I bring it up here because it's effectively the same kind of access
> > you're adding with these helpers and would need to be addressed if this
> > were generically enabling vfio mmap access on s390x.  
> 
> On s390x the use of the MIO instructions is limited to only PCI access. 
> So i am not sure if we should generically apply this to all vfio mmap 
> access (for non PCI devices).
> 
> 
> >
> > Prior to commit 2b8fe81b3c2e ("system/memory: use ldn_he_p/stn_he_p")
> > the mmio helpers here might have been a drop-in replacement for the
> > dereferencing of mmap offsets, but something would need to be done
> > about the explicit PCI assumption introduced here and the possibility
> > of unaligned accesses that the noted commit tries to resolve.  Thanks,
> >
> > Alex  
> 
> AFAICT in qemu today the ram_device_mem_ops is used for non PCI vfio 
> mmap cases. For s390x these helpers should be restricted to PCI 
> accesses. For the unaligned accesses (thanks for pointing out that 
> commmit!), are you suggesting we use the ld*_he_p/st*_he_p functions in 
> the helpers i defined? Though those functions don't seem to be doing 
> volatile accesses.

TBH, it's not clear to me that 2b8fe81b3c2e is correct.  We implemented
the ram_device MemoryRegion specifically to avoid memory access
optimizations that are not compatible with MMIO, but I see that these
{ld,st}*_he_pe operations are using __builtin_memcpy.  I'm not a
compiler aficionado, but is __builtin_memcpy guaranteed to use an
instruction set compatible with MMIO?

Cc: folks related to that commit.

The original issue that brought us ram_device was a very obscure
alignment of a memory region versus a device quirk only seen with
assignment of specific RTL NICs.

The description for commit 4a2e242bbb30 ("memory: Don't use memcpy for
ram_device regions") also addresses unaligned accesses, we don't expect
drivers to use them and we don't want them to work differently in a VM
than they might on bare metal.  We can debate whether that's valid or
not, but that was the intent.

Have we re-introduced the chance that we're using optimized
instructions only meant to target RAM here or is __builtin_memcpy
implicitly safe for MMIO?  Thanks,

Alex


