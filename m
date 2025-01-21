Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11453C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taG1Q-0004it-Tl; Tue, 21 Jan 2025 10:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taG1P-0004iW-Lk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:18:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taG1N-00047r-VY
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737472707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=09GfAX0PUsqH9rTv7k7skURbGxqO6nInp65k5nhUxV8=;
 b=FxY68pGVmiZXjQuwYL+vMWtJJZh+P/N1voJde7WroEBj9flxEMV6lUlncFMMt7oOYEOBiC
 p34UuOvfEA4g4QnAHixkvGPdjnalaZA/13knS45hsBsnlDkbUqUz2yWAYqQpO5RIwjt8nj
 j49UwT5tE7ZMb5rVrhLwL07tUmX0Zj0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-fQnXQDsnMmWL6Pm6ZdpJFg-1; Tue, 21 Jan 2025 10:18:23 -0500
X-MC-Unique: fQnXQDsnMmWL6Pm6ZdpJFg-1
X-Mimecast-MFC-AGG-ID: fQnXQDsnMmWL6Pm6ZdpJFg
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-467905ab1bbso187702981cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737472703; x=1738077503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09GfAX0PUsqH9rTv7k7skURbGxqO6nInp65k5nhUxV8=;
 b=tidIxwdNddLh6MSbYeStN6OsfPrwK43wAHurZc3btLcfiYncYfk9I1x2xI2QUMSVHQ
 ikVoyUo336VfNePehPIiE2CC7oX+zUJrTDmrLgAU5CDxF7Jz32co1lt9B0ovb/CpFYv5
 yaMv+/OM6U6zvPXlz5yRSIO0yPNoQw8J1XmoA4QDZm7SFqrrknVaqhB74Ig8blHBycsw
 i3xmbisn0hyU5ZmPfDE1oKPzmpgRSDGfm/qoNVUGuJm0Aey2fzoY2R+w/q7TgMSMob4X
 qW+WfToyQK2EtL/sx1oScg4IUMkfLcD+DpKxehhPlzPX/HWivQjQjAC2TDgCw9SmSI4m
 WhIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbPoqqpjLcRy6qyJ9C3aCDvi+a1a++UNrVIzpR8hY7ml4qNkIrTEjg9rGS7N83KGfugeO3fBnDgdtB@nongnu.org
X-Gm-Message-State: AOJu0YxqVWPvmUUvmEaE2u51VGbzPZNGq8XM8MyVezi+PBOET4aBQETG
 MGInvzmg4eNm0TjUsJlLPAL/3Eb8zQur5L24sxJVkeRCG7zfFYDr46i/DIbGlzKWiOEdOt7/2qF
 cnvwRcRMQDGZVgN2I5zjEyP42uHtM000PfZK1dgT0e1GTdcGb9UWc
X-Gm-Gg: ASbGncs7mVtnE1oLM+hgpsOeX0UyFE/i92PAvZLYkHoXzy9WMlIHngjiSFOgTqSgU+h
 Lp4eYSNJk40jgxsrfuy7jamidKCWC6ggLJekt3+ZN/ul9pHLYRED//qeRbZCSZK53WoTVJIMMhM
 Pv42H0pmzlkTeoC5qdwR/Hz7Ye5smoWp1k2pDBlJEnaq0n6CfWcq5+Fua8nYS8b+f+XAdy9KdBK
 FfBNo4l8s7BtM9wSfdcT7RJZG9uwmeMb6FshG2Op6IjXuw7yh/gud/qOB5ZGCb0f82Pn1jZvpzC
 2MBPv2IC+dnJyz/HB9JMxEaPzWiWt88=
X-Received: by 2002:a05:622a:38b:b0:46c:7646:4a1e with SMTP id
 d75a77b69052e-46e12a62966mr286440781cf.13.1737472702835; 
 Tue, 21 Jan 2025 07:18:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxR1uZcCuwoW2aFPUCORzZ6dwwEYoPsh6uPawIkQwwYuCSVsklLlGV/S//6f3s7+8ge5e9jA==
X-Received: by 2002:a05:622a:38b:b0:46c:7646:4a1e with SMTP id
 d75a77b69052e-46e12a62966mr286440391cf.13.1737472702548; 
 Tue, 21 Jan 2025 07:18:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e1030df9csm53752851cf.36.2025.01.21.07.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 07:18:21 -0800 (PST)
Date: Tue, 21 Jan 2025 10:18:19 -0500
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
Message-ID: <Z4-6u5_9NChu_KZq@x1n>
References: <58b96b74-bf9c-45d3-8c2e-459ec2206fc8@intel.com>
 <8c8e024d-03dc-4201-8038-9e9e60467fad@amd.com>
 <ca9bc239-d59b-4c53-9f14-aa212d543db9@intel.com>
 <4d22d3ce-a5a1-49f2-a578-8e0fe7d26893@amd.com>
 <2b799426-deaa-4644-aa17-6ef31899113b@intel.com>
 <2400268e-d26a-4933-80df-cfe44b38ae40@amd.com>
 <590432e1-4a26-4ae8-822f-ccfbac352e6b@intel.com>
 <2b2730f3-6e1a-4def-b126-078cf6249759@amd.com>
 <Z462F1Dwm6cUdCcy@x1n> <ZnmfUelBs3Cm0ZHd@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnmfUelBs3Cm0ZHd@yilunxu-OptiPlex-7050>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

On Tue, Jun 25, 2024 at 12:31:13AM +0800, Xu Yilun wrote:
> On Mon, Jan 20, 2025 at 03:46:15PM -0500, Peter Xu wrote:
> > On Mon, Jan 20, 2025 at 09:22:50PM +1100, Alexey Kardashevskiy wrote:
> > > > It is still uncertain how to implement the private MMIO. Our assumption
> > > > is the private MMIO would also create a memory region with
> > > > guest_memfd-like backend. Its mr->ram is true and should be managed by
> > > > RamdDiscardManager which can skip doing DMA_MAP in VFIO's region_add
> > > > listener.
> > > 
> > > My current working approach is to leave it as is in QEMU and VFIO.
> > 
> > Agreed.  Setting ram=true to even private MMIO sounds hackish, at least
> 
> The private MMIO refers to assigned MMIO, not emulated MMIO. IIUC,
> normal assigned MMIO is always set ram=true,
> 
> void memory_region_init_ram_device_ptr(MemoryRegion *mr,
>                                        Object *owner,
>                                        const char *name,
>                                        uint64_t size,
>                                        void *ptr)
> {
>     memory_region_init(mr, owner, name, size);
>     mr->ram = true;
> 
> 
> So I don't think ram=true is a problem here.

I see.  If there's always a host pointer then it looks valid.  So it means
the device private MMIOs are always mappable since the start?

Thanks,

-- 
Peter Xu


