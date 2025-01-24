Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D13C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMSS-0006x1-4T; Fri, 24 Jan 2025 11:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tbMSQ-0006vT-7U
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:22:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tbMSO-0004m7-3n
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737735772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=51dnXDvsNcSCF08xduw6b/Qmzvzq46UpLQCneaoBf8Y=;
 b=PWyZ8ud32AVSRhf1ZVzEHy7Wh2DxjLAzYew1170mYmYlsWr6LkNrtS+wWvnPoI0Ji/gC9b
 P92jjTeFlUQt4qVIDwUSDHZZKWBqYhMzZv5EviREoiOp9K2sAOdzuJog8CB/ww4hgmGaEl
 FjR/p/HVzTHYFTJE6nMsW31fW+nU1j4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-pHFkaJwEOl-Zfpb6PeKNRw-1; Fri, 24 Jan 2025 11:22:51 -0500
X-MC-Unique: pHFkaJwEOl-Zfpb6PeKNRw-1
X-Mimecast-MFC-AGG-ID: pHFkaJwEOl-Zfpb6PeKNRw
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5f8d5e499a5so1355615eaf.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737735769; x=1738340569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51dnXDvsNcSCF08xduw6b/Qmzvzq46UpLQCneaoBf8Y=;
 b=IAnm01c4M42YlW1HULk9E7Wy0b1EZZ3dEDpCw3oiGdeev560OK5HCHsFPAu7VG4AjJ
 lawUF0EY3VvRYl012HaOKaWgVX7BX6uV5OH8C5hupZPd+bGmW+f2dAhKeWlMeLxeJdTU
 oBwx5xdnti95Jf9fp3MY7TAlyMQ/UhRuqkIUshxHE7K3MFJ4EawNpK3DbfNcNu1b7pqw
 Qea2FeOcFmfwRg8xrmbmIOxif6dMhXR2K8xGRB/KoCMpvVKDT3HXL1NckOpY4KC8Gdea
 01uW7sDx+T2T4AFd7G3r6MpEV0DIVdcFngMyBHCdK7JdnXEUKRnEmhXuXL9TP1EZ/SWS
 +k/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRes0qoCJi7dtkf1ho3tGKXiMrTKkoy/acbODTvrwu+H/FvacsxMscxqOe293e0swRQyXj6UYVK+LO@nongnu.org
X-Gm-Message-State: AOJu0YzGCHSQ36GIc1IpQehwo6c7tvUCjkZiDQypPrt7eB94B9bUKt1F
 KKiY7XYtKKYo6fVDCJ92IBu4NNSzxckn2UCKpSMFcCA1KxkhybaxDwOQ3fB2zrd8xhIt933WCQo
 Giehon2MFhM1XM/LeJrpk0kjDENO2BaLZSFENS7pCYg+ZhYzli87ZmDaALH6Z
X-Gm-Gg: ASbGnct04npWvTt8VqOou99dzn3XlH754nUqG+C8CT6PiG6SCxGV9YTC6zKK4DpkaMQ
 C16ISX9M4jzYxgPLKVw7xmyXt9zVFJHcKQ2Er5NNhAsHzxLtTUksswktKgR5X4JBrtn7wEebfJ3
 m8nfJit2Kujfhwe83UxVVWiM0F8rqr/eaaZDB+v80Dwoau5kI+5B09hUTFEeq4/cO6yGCYnpkPX
 pX3Z5xknR2Q/QLJhnlLcwEDHMnelm+K9lHQ4IvYXnFGl96e92dqE4ZKrskwGr8V8QC6gcpb3Jp7
 Z9UIBWr8it0UfalJrmfo1X7a/6ROJDU=
X-Received: by 2002:a05:6214:19c8:b0:6d8:cff9:f373 with SMTP id
 6a1803df08f44-6e1b21c4106mr427082876d6.30.1737734153259; 
 Fri, 24 Jan 2025 07:55:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz9G2Pe5z23hXavPMrogrJhKCVJEtNpCmuOw2NH/cjb1ms5gHZUdf8IgcLgtK64ImsjBm57w==
X-Received: by 2002:a05:6214:19c8:b0:6d8:cff9:f373 with SMTP id
 6a1803df08f44-6e1b21c4106mr427082656d6.30.1737734152916; 
 Fri, 24 Jan 2025 07:55:52 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e20525abf0sm9759386d6.54.2025.01.24.07.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 07:55:52 -0800 (PST)
Date: Fri, 24 Jan 2025 10:55:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z5O4BSCjlhhu4rrw@x1n>
References: <2b2730f3-6e1a-4def-b126-078cf6249759@amd.com>
 <Z462F1Dwm6cUdCcy@x1n> <ZnmfUelBs3Cm0ZHd@yilunxu-OptiPlex-7050>
 <Z4-6u5_9NChu_KZq@x1n>
 <95a14f7d-4782-40b3-a55d-7cf67b911bbe@amd.com>
 <Z5C9SzXxX7M1DBE3@yilunxu-OptiPlex-7050> <Z5EgFaWIyjIiOZnv@x1n>
 <Z5INAQjxyYhwyc+1@yilunxu-OptiPlex-7050> <Z5Jylb73kDJ6HTEZ@x1n>
 <Z5NhwW/IXaLfvjvb@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5NhwW/IXaLfvjvb@yilunxu-OptiPlex-7050>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 24, 2025 at 05:47:45PM +0800, Xu Yilun wrote:
> On Thu, Jan 23, 2025 at 11:47:17AM -0500, Peter Xu wrote:
> > On Thu, Jan 23, 2025 at 05:33:53PM +0800, Xu Yilun wrote:
> > > On Wed, Jan 22, 2025 at 11:43:01AM -0500, Peter Xu wrote:
> > > > On Wed, Jan 22, 2025 at 05:41:31PM +0800, Xu Yilun wrote:
> > > > > On Wed, Jan 22, 2025 at 03:30:05PM +1100, Alexey Kardashevskiy wrote:
> > > > > > 
> > > > > > 
> > > > > > On 22/1/25 02:18, Peter Xu wrote:
> > > > > > > On Tue, Jun 25, 2024 at 12:31:13AM +0800, Xu Yilun wrote:
> > > > > > > > On Mon, Jan 20, 2025 at 03:46:15PM -0500, Peter Xu wrote:
> > > > > > > > > On Mon, Jan 20, 2025 at 09:22:50PM +1100, Alexey Kardashevskiy wrote:
> > > > > > > > > > > It is still uncertain how to implement the private MMIO. Our assumption
> > > > > > > > > > > is the private MMIO would also create a memory region with
> > > > > > > > > > > guest_memfd-like backend. Its mr->ram is true and should be managed by
> > > > > > > > > > > RamdDiscardManager which can skip doing DMA_MAP in VFIO's region_add
> > > > > > > > > > > listener.
> > > > > > > > > > 
> > > > > > > > > > My current working approach is to leave it as is in QEMU and VFIO.
> > > > > > > > > 
> > > > > > > > > Agreed.  Setting ram=true to even private MMIO sounds hackish, at least
> > > > > > > > 
> > > > > > > > The private MMIO refers to assigned MMIO, not emulated MMIO. IIUC,
> > > > > > > > normal assigned MMIO is always set ram=true,
> > > > > > > > 
> > > > > > > > void memory_region_init_ram_device_ptr(MemoryRegion *mr,
> > > > > > > >                                         Object *owner,
> > > > > > > >                                         const char *name,
> > > > > > > >                                         uint64_t size,
> > > > > > > >                                         void *ptr)
> > > > 
> > > > [1]
> > > > 
> > > > > > > > {
> > > > > > > >      memory_region_init(mr, owner, name, size);
> > > > > > > >      mr->ram = true;
> > > > > > > > 
> > > > > > > > 
> > > > > > > > So I don't think ram=true is a problem here.
> > > > > > > 
> > > > > > > I see.  If there's always a host pointer then it looks valid.  So it means
> > > > > > > the device private MMIOs are always mappable since the start?
> > > > > > 
> > > > > > Yes. VFIO owns the mapping and does not treat shared/private MMIO any
> > > > > > different at the moment. Thanks,
> > > > > 
> > > > > mm.. I'm actually expecting private MMIO not have a host pointer, just
> > > > > as private memory do.
> > > > > 
> > > > > But I'm not sure why having host pointer correlates mr->ram == true.
> > > > 
> > > > If there is no host pointer, what would you pass into "ptr" as referenced
> > > > at [1] above when creating the private MMIO memory region?
> > > 
> > > Sorry for confusion. I mean existing MMIO region use set mr->ram = true,
> > > and unmappable region (gmem) also set mr->ram = true. So don't know why
> > > mr->ram = true for private MMIO is hackish.
> > 
> > That's exactly what I had on the question in the previous email - please
> > have a look at what QEMU does right now with memory_access_is_direct().
> 
> I see memory_access_is_direct() should exclude mr->ram_device == true, which
> is the case for normal assigned MMIO and for private assigned MMIO. So
> this func is not a problem.

I'm not sure even if so.

VFIO's current use case is pretty special - it still has a host pointer,
it's just that things like memcpy() might not be always suitable to be
applied on MMIO mapped regions.  Alex explained the rational in commit
4a2e242bbb3.  I mean, the host pointer is valid even if ram_device=true in
this case.  Even if no direct access allowed (memcpy, etc.) it still
operates on the host address using ram_device_mem_ops.

> 
> But I think flatview_access_allowed() is a problem that it doesn't filter
> out the private memory. When memory is converted to private, the result
> of host access can't be what you want and should be errored out. IOW,
> the host ptr is sometimes invalid.
> 
> > I'm not 100% sure it'll work if the host pointer doesn't exist.
> > 
> > Let's take one user of it to be explicit: flatview_write_continue_step()
> > will try to access the ram pointer if it's direct:
> > 
> >     if (!memory_access_is_direct(mr, true)) {
> >         ...
> >     } else {
> >         /* RAM case */
> >         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
> >                                                false, true);
> > 
> >         memmove(ram_ptr, buf, *l);
> >         invalidate_and_set_dirty(mr, mr_addr, *l);
> > 
> >         return MEMTX_OK;
> >     }
> > 
> > I don't see how QEMU could work yet if one MR set ram=true but without a
> > host pointer..
> > 
> > As discussed previously, IMHO it's okay that the pointer is not accessible,
> 
> Maybe I missed something in previous discussion, I assume it is OK cause
> no address_space_rw is happening on this host ptr when memory is
> private, is it?

Yes, and when there is a mapped host address and someone tries to access an
address that is bound to a private page, QEMU should get a SIGBUS.  This
code is not ready yet for gmem, but I believe it'll work like that when
in-place gmem folio conversions will be ready.  So far QEMU's gmem works by
providing two layers of memory backends, which is IMHO pretty tricky.

> 
> > but still I assume QEMU assumes the pointer at least existed for a ram=on
> > MR.  I don't know whether it's suitable to set ram=on if the pointer
> > doesn't ever exist.
> 
> In theory, any code logic should not depends on an invalid pointer. I
> think a NULL pointer would be much better than a invalid pointer, at
> least you can check whether to access. So if you think an invalid
> pointer is OK, a NULL pointer should be also OK.

Definitely not suggesting to install an invalid pointer anywhere.  The
mapped pointer will still be valid for gmem for example, but the fault
isn't.  We need to differenciate two things (1) virtual address mapping,
then (2) permission and accesses on the folios / pages of the mapping.
Here I think it's okay if the host pointer is correctly mapped.

For your private MMIO use case, my question is if there's no host pointer
to be mapped anyway, then what's the benefit to make the MR to be ram=on?
Can we simply make it a normal IO memory region?  The only benefit of a
ram=on MR is, IMHO, being able to be accessed as RAM-like.  If there's no
host pointer at all, I don't yet understand how that helps private MMIO
from working.

Thanks,

-- 
Peter Xu


