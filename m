Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A5BC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 18:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OwJ-0005OK-Ru; Thu, 03 Apr 2025 14:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u0OwE-0005M4-W2
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u0OwB-0006tA-L9
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743703510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3ILeFiZ0Gnr22wpV5Hdg22mygGi1e/PkrI5XMuPU6s=;
 b=TABDs7/dcdxwiLBOjnTha6HAcG4LZge6M8XGU3ikSqNmcjydrkgoeBzxwSALxvOh5GEYPp
 kKrY9qqq4umKdFrvO5db+YVUwE+gJ6JQER4UrWxXej2Ts8EvO8rZqUsWKkNrJWnwZYFQgg
 2b3CRUu9tM33yZaLNCrcMIXPAsHWl1k=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-gh02RlXbPhq8C3eID_k7jg-1; Thu, 03 Apr 2025 14:05:09 -0400
X-MC-Unique: gh02RlXbPhq8C3eID_k7jg-1
X-Mimecast-MFC-AGG-ID: gh02RlXbPhq8C3eID_k7jg_1743703509
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-85e80e2fbcdso22254239f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 11:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743703509; x=1744308309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H3ILeFiZ0Gnr22wpV5Hdg22mygGi1e/PkrI5XMuPU6s=;
 b=w3ZkG+8WkbmI++PAG3HubR4NqbdSnGERJv7FcMbZgKGtNMfzocq2/hbzCsFp3/6O3K
 bjaPi4e2bPT+yzBLlRBYnBoQwMGwj08lQJR54BjlUi3v6maL7qqZmLmMdzUVpQYxSinv
 1gn99zo8pyfwslY7ddZDfMJWhHFSH/ZMWE+bwqapJteqBKnuuKcwD2Ij7ZStJRxzOXjf
 4Bdovrie4rdVriiEQpV7vlqDNra1RuciRPWwr9x3rz/vdEBC4H2tvZ0o685BZSAQevgN
 yp8Fhxe57hPGtPdyJ9/XPKrh44mkjt61MouFmc9W7VeAYpTwVTDZiuFiegeSZXmz5Uln
 BNSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1ylgXxODiEgSwd78jfh+eGHofkwdTXvAlc+L8ZL20NNNDgQU2lzM+MxFz/HnIX3ZFAN5WJZieNngu@nongnu.org
X-Gm-Message-State: AOJu0Yzsj/0RQDxW/g/1BNGJ7nmYq482FTzIZAWH2mhs+tfHF34Jtkuq
 +S3LUvfWiP2e5RdfwuNAHMnq5rcQNLYJ8FlboHWoG/IuX7aSMg0g/99TmYbjG0Q6y3/zP/g0Tzn
 278PPwU1zv2LcmrbW6HRHS1nE0S1yMtzfR4lUo9yz1KKfTfFpHmon
X-Gm-Gg: ASbGncv9jk+8IyAf0aMBFIIlggsOKTQ9T7kOWrvUiMk+hjdpkH2L8XfMPmItrZHT0CP
 Kj3vLJeKT5LR/m7osE7eReY2Jj3Fzmv2lANUI6TbsOizMAIs9eGzSZCfJlcEWmtatpTa8w+0AIp
 UpNkFpj748v/EKdS9bqaHi0Ja9jBjrxgxE3/OtRx2SAJqQ2/X+y5HUGyHVJEDKN53an4BjxcHDt
 Jetv8wgXQpE/+B/fh1yGMOvafnvgdJrH++ujHCz9gDGYpOJ15JCM+kBOtgBOBG1ODxOZpic9Ujz
 4Lx+72FQ3PJLI4C/hv8=
X-Received: by 2002:a92:cdae:0:b0:3d4:3c21:ba67 with SMTP id
 e9e14a558f8ab-3d6e3f759b7mr1280425ab.3.1743703508702; 
 Thu, 03 Apr 2025 11:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ1SerGhcgqf92YoyascdKHfEvmYBcD+Vgi2F+6hW3oCy44FFAFI6uR4mmnaeGlOhJGPO0xQ==
X-Received: by 2002:a92:cdae:0:b0:3d4:3c21:ba67 with SMTP id
 e9e14a558f8ab-3d6e3f759b7mr1280235ab.3.1743703508341; 
 Thu, 03 Apr 2025 11:05:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d6de79ef3esm4008255ab.10.2025.04.03.11.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 11:05:06 -0700 (PDT)
Date: Thu, 3 Apr 2025 12:05:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, fam@euphon.net, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, thuth@redhat.com, mjrosato@linux.ibm.com,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 0/3] Enable QEMU NVMe userspace driver on s390x
Message-ID: <20250403120504.2f660171.alex.williamson@redhat.com>
In-Reply-To: <2c244588-b37b-4e86-863e-ef462343edad@linux.ibm.com>
References: <20250401172246.2688-1-alifm@linux.ibm.com>
 <20250402155152.GE304512@fedora>
 <2c11a602415f0780030d4e68a28eee7ffcdd8cb7.camel@linux.ibm.com>
 <20250403154442.GA349582@fedora>
 <20250403102704.7e1f4452.alex.williamson@redhat.com>
 <2c244588-b37b-4e86-863e-ef462343edad@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
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

On Thu, 3 Apr 2025 10:33:52 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 4/3/2025 9:27 AM, Alex Williamson wrote:
> > On Thu, 3 Apr 2025 11:44:42 -0400
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >  
> >> On Thu, Apr 03, 2025 at 09:47:26AM +0200, Niklas Schnelle wrote:  
> >>> On Wed, 2025-04-02 at 11:51 -0400, Stefan Hajnoczi wrote:  
> >>>> On Tue, Apr 01, 2025 at 10:22:43AM -0700, Farhan Ali wrote:  
> >>>>> Hi,
> >>>>>
> >>>>> Recently on s390x we have enabled mmap support for vfio-pci devices [1].  
> >>>> Hi Alex,
> >>>> I wanted to bring this to your attention. Feel free to merge it through
> >>>> the VFIO tree, otherwise I will merge it once you have taken a look.
> >>>>
> >>>> Thanks,
> >>>> Stefan
> >>>>      
> >>>>> This allows us to take advantage and use userspace drivers on s390x. However,
> >>>>> on s390x we have special instructions for MMIO access. Starting with z15
> >>>>> (and newer platforms) we have new PCI Memory I/O (MIO) instructions which
> >>>>> operate on virtually mapped PCI memory spaces, and can be used from userspace.
> >>>>> On older platforms we would fallback to using existing system calls for MMIO access.
> >>>>>
> >>>>> This patch series introduces support the PCI MIO instructions, and enables s390x
> >>>>> support for the userspace NVMe driver on s390x. I would appreciate any review/feedback
> >>>>> on the patches.
> >>>>>
> >>>>> Thanks
> >>>>> Farhan  
> >>> Hi Stefan,
> >>>
> >>> the kernel patch actually made it into Linus' tree for v6.15 already as
> >>> commit aa9f168d55dc ("s390/pci: Support mmap() of PCI resources except
> >>> for ISM devices") plus prerequisites. This went via the PCI tree
> >>> because they included a change to struct pci_dev and also enabled
> >>> mmap() on PCI resource files. Alex reviewed an earlier version and was
> >>> the one who suggested to also enable mmap() on PCI resources.  
> >> The introduction of a new QEMU API for accessing MMIO BARs in this
> >> series is something Alex might be interested in as QEMU VFIO maintainer.
> >> That wouldn't have been part of the kernel patch review.
> >>
> >> If he's aware of the new API he can encourage other VFIO users to use it
> >> in the future so that you won't need to convert them to work on s390x
> >> again.  
> > I don't claim any jurisdiction over the vfio-nvme driver.  In general
> > vfio users should be using either vfio_region_ops, ram_device_mem_ops,
> > or directly mapping MMIO into the VM address space.  The first uses
> > pread/write through the region offset, irrespective of the type of
> > memory, the second provides the type of access used here where we're
> > dereferencing into an mmap, and the last if of course the preferred
> > mechanism where available.
> >
> > It is curious that the proposal here doesn't include any changes to
> > ram_device_mem_ops for more generically enabling MMIO access on s390x.
> > Thanks,
> >
> > Alex  
> 
> 
> Hi Alex,
>  From my understanding the ram_device_mem_ops sets up the BAR access for 
> a guest passthrough device. Unfortunately today an s390x KVM guest 
> doesn't use and have support for these MIO instructions. We wanted to 
> use this series as an initial test vehicle of the mmap support.

Right, ram_device_mem_ops is what we'll use to access a BAR that
supports mmap but for whatever reason we're accessing it directly
through the mmap.  For instance if an overlapping quirk prevents the
page from being mapped to the VM or we have some back channel mechanism
where the VMM is interacting with the BAR.

I bring it up here because it's effectively the same kind of access
you're adding with these helpers and would need to be addressed if this
were generically enabling vfio mmap access on s390x.

Prior to commit 2b8fe81b3c2e ("system/memory: use ldn_he_p/stn_he_p")
the mmio helpers here might have been a drop-in replacement for the
dereferencing of mmap offsets, but something would need to be done
about the explicit PCI assumption introduced here and the possibility
of unaligned accesses that the noted commit tries to resolve.  Thanks,

Alex


