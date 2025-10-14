Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E56ACCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8b7w-0005VT-QZ; Tue, 14 Oct 2025 05:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8b7u-0005VH-RG
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8b7r-0001WL-52
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760433320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYTwBkE5zcmiIQc/FJADgnE3M2mMbJh1iVeCeeyvFX0=;
 b=BNE/dYjHLfMar8qzkEKUfEHGqzr8GbyHwFcjqThB7hvxWlJQexWFpND+0Ruzg1G+9Z3UX4
 o1pj2EIDmHbHQyaBAq7x2aCUJVgqj47R1WMsOVsQdphnhCqK+28R3Zgc5IsZaiTqVhCAd/
 TYFVykCDMYkrzGGEWJJSjsiCcB8ipUA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-CIbSbWrMMcyWVjLwQFbdow-1; Tue, 14 Oct 2025 05:15:19 -0400
X-MC-Unique: CIbSbWrMMcyWVjLwQFbdow-1
X-Mimecast-MFC-AGG-ID: CIbSbWrMMcyWVjLwQFbdow_1760433318
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3ed6540fso34207875e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 02:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760433318; x=1761038118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYTwBkE5zcmiIQc/FJADgnE3M2mMbJh1iVeCeeyvFX0=;
 b=BDYnvbSzMc8W/sNp0NDbvxlQB3Yk3yjoyneN1RUr9KrU6ek6CeHsIvzYvZuIUwL0iG
 qsrHEz8GLjJhTrz2o0alwGDC8pgC47kjdJWwY/itn2LAtE0mCy2sxsMZFXSj28KxnnAf
 28G/R6PO71fdS089LlO2QfX5SnSn2JUK2MlOIvakOwbM9At/HZEDLjfB5YVT3WIjbhys
 Edn7lwP/9DqC+ER7kjThCYN8eKuYYMiCIZknrTl9GrjtTQWA+YDOJP81rfHqzOoAop5S
 VuszhFYtolPZff49laqx1oEZ53hyfhGsjAYjAPFiC3/joss2NWdAAWgdeDBd6iyY5vDd
 tBAQ==
X-Gm-Message-State: AOJu0YxjBO70JIr1VxEbbi62bv9S8XsWGDY5gsJBt0KK9V7RWW6Sy7xB
 0bdSjwqPGc6KUCOqgT2Ydl7RGV6uu25RrZmNu3rVbMDjhn0xrFoAfNiLmfxZH1Y1SpaTVarbDQk
 KQ3Xp6dAe35EWdtVGwZlqrh1gccuczKFaW5ngDWv6NoYlzdFUab5reA7p
X-Gm-Gg: ASbGncuACobeV1un/FpQq94oWMqJK2JDMUvzqoN6G7WLxPxs/feZNxnm+gEzN+6mN0j
 sc+TlpFdN6/pHDcqtbNS9V/aRrOe23m5J8POnzjyPBOorXxxnZOdvRhPsK0T73NBGJhP1jsdjCy
 Sc5xtq8HkfB3wGBIdBjI5cbJe5Ca4aDkzzHn2A6aXGQVgtqlZ8Cbj8k7aG2hMenAdIs1rGcFVdu
 g86oDlJDXP8ziKgRtPGYclgO8Oyo6XSF79ugJGgWJ6zq7nrArPnCGampZpHNxL8PnxEl/Yf2HPR
 C0/xCF8Yil6rNaJVlFPrUwkMperPby+wkA==
X-Received: by 2002:a05:600c:6592:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-46fa9ec796bmr177974475e9.16.1760433317851; 
 Tue, 14 Oct 2025 02:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLU4dn0KcxdyqaV1nEFUT0lmMmvwEkYhla+GXByyP+yfWnJrTsQ08e378YafCXHB0m4AnzoA==
X-Received: by 2002:a05:600c:6592:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-46fa9ec796bmr177974155e9.16.1760433317300; 
 Tue, 14 Oct 2025 02:15:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4989601sm224893405e9.9.2025.10.14.02.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 02:15:16 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:15:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, alejandro.j.jimenez@oracle.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, aik@amd.com
Subject: Re: [PATCH v2 2/2] amd_iommu: Support 64 bit address for IOTLB lookup
Message-ID: <20251014051453-mutt-send-email-mst@kernel.org>
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-3-sarunkod@amd.com>
 <20251013041617-mutt-send-email-mst@kernel.org>
 <e4c5d25c-572c-45fe-8e64-b6f141c0f82e@amd.com>
 <20251014050512-mutt-send-email-mst@kernel.org>
 <17411c21-eaf2-41e2-b2e1-2102ec745637@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17411c21-eaf2-41e2-b2e1-2102ec745637@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 14, 2025 at 02:42:12PM +0530, Sairaj Kodilkar wrote:
> 
> 
> On 10/14/2025 2:35 PM, Michael S. Tsirkin wrote:
> > On Tue, Oct 14, 2025 at 02:34:28PM +0530, Sairaj Kodilkar wrote:
> > > 
> > > On 10/13/2025 1:49 PM, Michael S. Tsirkin wrote:
> > > > On Mon, Oct 13, 2025 at 10:30:46AM +0530, Sairaj Kodilkar wrote:
> > > > > Physical AMD IOMMU supports up to 64 bits of DMA address. When device tries
> > > > > to read or write from a given DMA address, IOMMU translates the address
> > > > > using page table assigned to that device. Since IOMMU uses per device page
> > > > > tables, the emulated IOMMU should use the cache tag of 68 bits
> > > > > (64 bit address - 12 bit page alignment + 16 bit device ID).
> > > > > 
> > > > > Current emulated AMD IOMMU uses GLib hash table to create software iotlb
> > > > > and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
> > > > > to 60 bits. This causes failure while setting up the device when guest is
> > > > > booted with "iommu.forcedac=1".
> > > > > 
> > > > > To solve this problem, Use 64 bit IOVA and 16 bit devid as key to store
> > > > > entries in IOTLB; Use upper 52 bits of IOVA (GFN) and lower 12 bits of
> > > > > the device ID to construct the 64 bit hash key in order avoid the
> > > > > truncation as much as possible (reducing hash collisions).
> > > > > 
> > > > > Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> > > > > Signed-off-by: Sairaj Kodilkar<sarunkod@amd.com>
> > > > I am wondering whether we need to limit how much host memory
> > > > can the shadow take. Because with so many bits, the sky is the limit ...
> > > > OTOH it's not directly caused by this patch, but it's something
> > > > we should think about maybe.
> > > I don't think I fully understand this. Do you mean the host memory
> > > taken by the pages used to build shadow page table ?
> > the memory used by the hash table.
> 
> Right now it defines macro 'AMDVI_IOTLB_MAX_SIZE'. If iotlb hash
> size is greater than that, code resets the hash table.
> Techinically, right way is to implement a policy such as LRU, which
> we can work on in future patches.
> 
> Thanks
> Sairaj

sounds good, thanks!

> > > > Something more to improve:
> > > > 
> > > > 
> > > > > ---
> > > > >    hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
> > > > >    hw/i386/amd_iommu.h |  4 ++--
> > > > >    2 files changed, 40 insertions(+), 21 deletions(-)
> > > > > 
> > > > > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> > > > > index b194e3294dd7..a218d147e53d 100644
> > > > > --- a/hw/i386/amd_iommu.c
> > > > > +++ b/hw/i386/amd_iommu.c
> > > > > @@ -106,6 +106,11 @@ typedef struct amdvi_as_key {
> > > > >        uint8_t devfn;
> > > > >    } amdvi_as_key;
> > > > > +typedef struct amdvi_iotlb_key {
> > > > > +    uint64_t gfn;
> > > > > +    uint16_t devid;
> > > > > +} amdvi_iotlb_key;
> > > > > +
> > > > Pls change struct and typedef names to match qemu coding style.
> > > Thanks
> > > Sairaj


