Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F860C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadou-0000xi-MY; Wed, 22 Jan 2025 11:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tador-0000xO-36
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:43:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tadop-00048z-D8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737564186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3y0fMZSE7a+ty4qcm/cQWGtpuEjSKpLOhWLAcuXU2f0=;
 b=LYVa0uMOeruWKGr4VIHW0uEvmLut/1P554HlzZCAHeyAuXN1C7lF+o62ABTf+atih1XTT3
 CE9VHuou5FXdV6Z74UoaDeVIna55cEWtUw6MXom9KeuBEtgF42fwQTJFAy16xehKWD4Zsq
 BGrygCuNPkJ4/BA+BkEVqY17HF/yHzc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-h19pdPFsPnaz1vA7fR5m1w-1; Wed, 22 Jan 2025 11:43:05 -0500
X-MC-Unique: h19pdPFsPnaz1vA7fR5m1w-1
X-Mimecast-MFC-AGG-ID: h19pdPFsPnaz1vA7fR5m1w
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-468f80df8caso129070801cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737564184; x=1738168984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3y0fMZSE7a+ty4qcm/cQWGtpuEjSKpLOhWLAcuXU2f0=;
 b=k1l09bQmaXH6+RCInnbsl8Ts/49D3l+dbotDXA6SxHET63vdPT05mHJBvB7rBIsz9f
 Ow0W+wQGREfaS+PTPNxviFYxbETGi9/QSkMjspf27H49UgvQZA6/kzIU8cIK95JhVcFF
 DImj29eBwG2jq2/xojVNSzaDPXPrLAsinyy25Uo4u/YYhQ53bGBWhaDraKPg8J3fwuoA
 ch2dxpdsk4t4D1xGApKTDYCh3OBAZPAWY+xrT0KEvUT8n2lDtPPcP5IdXy6raWY+EQ+f
 0W4406wrDAceu1/L0xHK92puGsNfscpELKZ0jge66xwrZoL41w3ldC8z4UAiKQdW/H+4
 YvJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDOSKAgjD65AzbMEUPJEAyk/aIFD0TtR496vFCfHhgnUuA7EGD5Tsk9965Y/twhDmmLAPyKSLRFHXB@nongnu.org
X-Gm-Message-State: AOJu0YyQ/Qa4bFw57qsOD7dPc4VA+SdhlD9MEj6IT+rFqaIt1I3J6UeQ
 SMEdizboJQjz0Nur/kVT2HFEhUbsoqY0zDAoKtMEce9KY7bnYATtQ56+/+MjzRMduXACyG2L3Lo
 s4tJ101L6wa0uoDx/c6NZv+g6WdRBd/JoBncKAtfjUJXJbDEjAjKR
X-Gm-Gg: ASbGncs4lqamhDippWS5h+FG4R73HD4viLetEf3O6TgpmmObODdQJJRqI2U9yRnxbHe
 SIvowdQbXRNIXH0lnOs1JhmzGs0ClRdWSTyEIcC6oX/HDYLSV0Esgs4nOKSWapxo0+HXfEZkfvD
 kHpD6Vm2o0vGEL2vLqgHEQI1RH9r6jt7myQCtfRzn1q0H+45PxnixIJ66qIAJRZ1kWeokIhVZBI
 kHmGt8frG3HSIRfg+NvlEf5Csifrpb3x+245ME7tz8knZoX8nqOsggRGm5sBzfSuQPqLhlx65CB
 YOktxBqN2nl+OcLk4Q76NCsjEsoJWRQ=
X-Received: by 2002:ac8:7f83:0:b0:467:681c:425f with SMTP id
 d75a77b69052e-46e12a1e89amr335229471cf.4.1737564184261; 
 Wed, 22 Jan 2025 08:43:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETxltspJm2hV7oT91UaMx+gaN/Hy/EpGHdI43Wk+riEdrbGMvExnVUyAvjtxygRe6Mo7vWDQ==
X-Received: by 2002:ac8:7f83:0:b0:467:681c:425f with SMTP id
 d75a77b69052e-46e12a1e89amr335229041cf.4.1737564183924; 
 Wed, 22 Jan 2025 08:43:03 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e102ec205sm65385351cf.11.2025.01.22.08.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:43:03 -0800 (PST)
Date: Wed, 22 Jan 2025 11:43:01 -0500
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
Message-ID: <Z5EgFaWIyjIiOZnv@x1n>
References: <4d22d3ce-a5a1-49f2-a578-8e0fe7d26893@amd.com>
 <2b799426-deaa-4644-aa17-6ef31899113b@intel.com>
 <2400268e-d26a-4933-80df-cfe44b38ae40@amd.com>
 <590432e1-4a26-4ae8-822f-ccfbac352e6b@intel.com>
 <2b2730f3-6e1a-4def-b126-078cf6249759@amd.com>
 <Z462F1Dwm6cUdCcy@x1n> <ZnmfUelBs3Cm0ZHd@yilunxu-OptiPlex-7050>
 <Z4-6u5_9NChu_KZq@x1n>
 <95a14f7d-4782-40b3-a55d-7cf67b911bbe@amd.com>
 <Z5C9SzXxX7M1DBE3@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5C9SzXxX7M1DBE3@yilunxu-OptiPlex-7050>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 22, 2025 at 05:41:31PM +0800, Xu Yilun wrote:
> On Wed, Jan 22, 2025 at 03:30:05PM +1100, Alexey Kardashevskiy wrote:
> > 
> > 
> > On 22/1/25 02:18, Peter Xu wrote:
> > > On Tue, Jun 25, 2024 at 12:31:13AM +0800, Xu Yilun wrote:
> > > > On Mon, Jan 20, 2025 at 03:46:15PM -0500, Peter Xu wrote:
> > > > > On Mon, Jan 20, 2025 at 09:22:50PM +1100, Alexey Kardashevskiy wrote:
> > > > > > > It is still uncertain how to implement the private MMIO. Our assumption
> > > > > > > is the private MMIO would also create a memory region with
> > > > > > > guest_memfd-like backend. Its mr->ram is true and should be managed by
> > > > > > > RamdDiscardManager which can skip doing DMA_MAP in VFIO's region_add
> > > > > > > listener.
> > > > > > 
> > > > > > My current working approach is to leave it as is in QEMU and VFIO.
> > > > > 
> > > > > Agreed.  Setting ram=true to even private MMIO sounds hackish, at least
> > > > 
> > > > The private MMIO refers to assigned MMIO, not emulated MMIO. IIUC,
> > > > normal assigned MMIO is always set ram=true,
> > > > 
> > > > void memory_region_init_ram_device_ptr(MemoryRegion *mr,
> > > >                                         Object *owner,
> > > >                                         const char *name,
> > > >                                         uint64_t size,
> > > >                                         void *ptr)

[1]

> > > > {
> > > >      memory_region_init(mr, owner, name, size);
> > > >      mr->ram = true;
> > > > 
> > > > 
> > > > So I don't think ram=true is a problem here.
> > > 
> > > I see.  If there's always a host pointer then it looks valid.  So it means
> > > the device private MMIOs are always mappable since the start?
> > 
> > Yes. VFIO owns the mapping and does not treat shared/private MMIO any
> > different at the moment. Thanks,
> 
> mm.. I'm actually expecting private MMIO not have a host pointer, just
> as private memory do.
> 
> But I'm not sure why having host pointer correlates mr->ram == true.

If there is no host pointer, what would you pass into "ptr" as referenced
at [1] above when creating the private MMIO memory region?

OTOH, IIUC guest private memory finally can also have a host pointer (aka,
mmap()-able), it's just that even if it exists, accessing it may crash QEMU
if it's private.

Thanks,

-- 
Peter Xu


