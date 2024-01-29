Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E48C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 17:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUVeq-00068E-96; Mon, 29 Jan 2024 12:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rUVeo-00066C-Bj
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:42:54 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rUVel-0000AF-2L
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:42:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e775695c6so26915815e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 09:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706550169; x=1707154969; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hi/bPxvY91tpMbomroYUdB5TmR8GTew2hRnVvF7LSD0=;
 b=KSNTE8y8pv/zSbokDKVbhQwzhkcqRhJ8NGzQ/7Pba55JbvwELwkyjEWl1/iN9vxyuL
 LmHVSt+j43sXNnOm6C/97IELZbvYDTbvHkfKI/pWjsBlrLswo+ZXsOOewfXvdY5OTc1O
 wHcUmgMyvBX9ep97swum7Y9LbVmGHna0b6Mn1Q62/LKcvUijwN1TkRAuwf5b3diGzbyt
 ybVIu+mimJ+Un5+Te9VMnmLglR98A5F6FhRbnwBHjObezmAgR3nY33BWXvtE9zxs/xaX
 i9DBmULd7pfJ17P60rIethbb5Fnw+W3l4XDIZePnSwTtnsfOVjL/rEZbIL8mFUrzRb7o
 YF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550169; x=1707154969;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hi/bPxvY91tpMbomroYUdB5TmR8GTew2hRnVvF7LSD0=;
 b=HT371sgf2QBwfc3oV5kF+pY+mSWQbz9j4oCVjvaT95UtTSnu2h2sHARhdbgOzhziyr
 AOIZHUUo5+6YayCXWqWJMvNm6VgMmxOExAddTYYpjwLNIT3d1/NepOGm0P9fo8n9ltso
 inN3FN2Fb6G+pbE3KbrSPENnD7zyQCELdqVcxVfLzprFdnz9J9+QixNHpBbhW2cJipVl
 AduUREMM3jtzVI1IXzQXSATs/2xDz5VGRXLELo/Xhz+QC9O0CBAMVCkGT5F3dSPjBSoC
 zm2sxAi0GCgCMkDlBtpoaSD/dQmMOeOHZykWV9x6fhf7Y7o6knlSvtBma6Qa4YjjvBs2
 hi9Q==
X-Gm-Message-State: AOJu0YzkcH4Vn1Qi4ynpRgSJsP2lwDHJtMTFK/sXOZp+SMgYuzlUZuDH
 57Q1QyWq25tIQ/wRjF2EJGt17tJTeIrUxHJSvqJvhCq62DwY+zLEg4+idwZ3cM0=
X-Google-Smtp-Source: AGHT+IEUgoQxsS8Vrophi89FwoJzlzFLb1EY56/vNtkmhhsEwSEuUFsd6Bln8mCCRK5gJuyahdy21Q==
X-Received: by 2002:a1c:4b10:0:b0:40e:6922:7960 with SMTP id
 y16-20020a1c4b10000000b0040e69227960mr6101062wma.29.1706550169185; 
 Mon, 29 Jan 2024 09:42:49 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 c17-20020a5d5291000000b0033ae4ba8ca0sm6235735wrv.82.2024.01.29.09.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:42:48 -0800 (PST)
Date: Mon, 29 Jan 2024 17:42:50 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, peterx@redhat.com, yanghliu@redhat.com,
 mst@redhat.com, clg@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH 0/3] VIRTIO-IOMMU: Introduce an aw-bits option
Message-ID: <20240129174250.GA1306334@myrica>
References: <20240123181753.413961-1-eric.auger@redhat.com>
 <20240129122332.GA909471@myrica>
 <670991f9-e483-4acb-9ae9-6bad47b962b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670991f9-e483-4acb-9ae9-6bad47b962b1@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jan 29, 2024 at 03:07:41PM +0100, Eric Auger wrote:
> Hi Jean-Philippe,
> 
> On 1/29/24 13:23, Jean-Philippe Brucker wrote:
> > Hi Eric,
> >
> > On Tue, Jan 23, 2024 at 07:15:54PM +0100, Eric Auger wrote:
> >> In [1] and [2] we attempted to fix a case where a VFIO-PCI device
> >> protected with a virtio-iommu is assigned to an x86 guest. On x86
> >> the physical IOMMU may have an address width (gaw) of 39 or 48 bits
> >> whereas the virtio-iommu exposes a 64b input address space by default.
> >> Hence the guest may try to use the full 64b space and DMA MAP
> >> failures may be encountered. To work around this issue we endeavoured
> >> to pass usable host IOVA regions (excluding the out of range space) from
> >> VFIO to the virtio-iommu device so that the virtio-iommu driver can
> >> query those latter during the probe request and let the guest iommu
> >> kernel subsystem carve them out.
> >>
> >> However if there are several devices in the same iommu group,
> >> only the reserved regions of the first one are taken into
> >> account by the iommu subsystem of the guest. This generally
> >> works on baremetal because devices are not going to
> >> expose different reserved regions. However in our case, this
> >> may prevent from taking into account the host iommu geometry.
> >>
> >> So the simplest solution to this problem looks to introduce an
> >> input address width option, aw-bits, which matches what is
> >> done on the intel-iommu. By default, from now on it is set
> >> to 39 bits with pc_q35 and 64b with arm virt.
> > Doesn't Arm have the same problem?  The TTB0 page tables limit what can be
> > mapped to 48-bit, or 52-bit when SMMU_IDR5.VAX==1 and granule is 64kB.
> > A Linux host driver could configure smaller VA sizes:
> > * SMMUv2 limits the VA to SMMU_IDR2.UBS (upstream bus size) which
> >   can go as low as 32-bit (I'm assuming we don't care about 32-bit hosts).
> Yes I think we can ignore that use case.
> > * SMMUv3 currently limits the VA to CONFIG_ARM64_VA_BITS, which
> >   could be as low as 36 bits (but realistically 39, since 36 depends on
> >   16kB pages and CONFIG_EXPERT).
> Further reading "3.4.1 Input address size and Virtual Address size" ooks
> indeed SMMU_IDR5.VAX gives info on the physical SMMU actual
> implementation max (which matches intel iommu gaw). I missed that. Now I
> am confused about should we limit VAS to 39 to accomodate of the worst
> case host SW configuration or shall we use 48 instead?

I don't know what's best either. 48 should be fine if hosts normally
enable VA_BITS_48 (I see debian has it [1], not sure how to find the
others).

[1] https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/config/arm64/config?ref_type=heads#L18

> If we set such a low 39b value, won't it prevent some guests from
> properly working?

It's not that low, since it gives each endpoint a private 512GB address
space, but yes there might be special cases that reach the limit. Maybe
assign a multi-queue NIC to a 256-vCPU guest, and if you want per-vCPU DMA
pools, then with a 39-bit address space you only get 2GB per vCPU. With
48-bit you get 1TB which should be plenty.

52-bit private IOVA space doesn't seem useful, I doubt we'll ever need to
support that on the MAP/UNMAP interface.

So I guess 48-bit can be the default, and users with special setups can
override aw-bits.

Thanks,
Jean

