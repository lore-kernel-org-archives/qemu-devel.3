Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BA8C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 15:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7cOI-00052K-H3; Wed, 23 Apr 2025 11:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7cOC-00051T-Mp
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7cOA-00063Z-SE
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745423511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZd1dKuVwWjDzz801aKoYZLpFio8buC1pvJ/vndbxzk=;
 b=ND8RrWu9KU/wZXfaXtmDK1O4Ndrcu5QYhGywP07vjT5h3Gh8jQ0cWRStDHqkzdXbz/VItI
 kAyxQKUR7ygsPLd53bLHt2d+QDpMFGsyaUpC/kBzXLdDCoVkagou/7M84ksB8iojj5oVn1
 3K+7H5QT7yA2K19eCJwAv4+L6TyBDt0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-0w3WSMj3MNqehl2TvWOnDQ-1; Wed, 23 Apr 2025 11:51:47 -0400
X-MC-Unique: 0w3WSMj3MNqehl2TvWOnDQ-1
X-Mimecast-MFC-AGG-ID: 0w3WSMj3MNqehl2TvWOnDQ_1745423505
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so35719695e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 08:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745423505; x=1746028305;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZd1dKuVwWjDzz801aKoYZLpFio8buC1pvJ/vndbxzk=;
 b=oF2pB2AwTQL5lYPIg3MOZu/J3ymW43HoIOWQtAkevat/vv3VLHgekyt8a7ljsTdesZ
 heVtjUmfxXiEE3JLNXlOSnUpNLuPuTztbKERN0gJtRFBU9b7N57uOo+zZ9vv7eh8hJFF
 HLDTfeTcFbvT38RgYWQ1fb7Bi968i/TBXJInrRBqg/fd0fWI3rv+7P6sjzlg4bMrMmzW
 Q7yCcSiDW+O7fKwpPHVs9vA/feIcNC86Rh5W+UFLO/TwDZBrPt3WSQl1ZSyCkzlGHtot
 yK2N6JTaaxEAVT1XmlpDx7k/D8oIkKUu2hDpenHYoNZgSsfMv4dv958PLogZXeDPjCZr
 gP2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeNjnF88250490ygBakfDVZA3HlSw1wQDQrCMs8f/I2MQBEWJV5KTu38HDJePxQ4OLMqbG5dsb20Cw@nongnu.org
X-Gm-Message-State: AOJu0YytPDzRKr2SrYQMaxpb2Ebjxi78LRX7BOulxjm10X/nu4aPBBEM
 x+FzXVc8rjC1w7H9aowVBGEuOX6mO9zg+GdlisfHgK/k5xDrjsCbW647GCIT00mrkPU1iTRtuxX
 4xRXm3jbfK5rf9+pnzbP+r/FWevimp5K+Z4ev9cG7UndsQYi5dG6G
X-Gm-Gg: ASbGncuhqsd0Iloe8Ri08CAdxxb+Unae4Nw6v0+65iUvM7jo2+IEoYrOdpFR7bjwKjt
 HsRMRDv2e2le0K7eXZSDZNkfv2p/RjG4vDsVG0qMuM+fohVqPFXxc6AJ+F26CbRpetv3YKMRKVo
 B9i7nxNoNHzJ5O4tl6oKKZtlA18QxAlyeVNsTrnu/PBVXCDxOXB2YL/q0HFJ7F13wQkTX8TSWRN
 oqv9xlVOCKa8Hs5gCSvY0uzkvQKG0Gp0b7alQVyxAduJMZ2i/Lf6kexmGh6LDgEed+d6ezSHP/j
 we8abg==
X-Received: by 2002:a05:600c:4707:b0:43c:efed:732c with SMTP id
 5b1f17b1804b1-4406ac27536mr136512585e9.28.1745423505362; 
 Wed, 23 Apr 2025 08:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZPgJKEN+P3DjTaNNJE+y6toNp4d/FsRcdg0iYG0E5Da0eo8d78nsPKG8ibAZTyhgmJKGi4A==
X-Received: by 2002:a05:600c:4707:b0:43c:efed:732c with SMTP id
 5b1f17b1804b1-4406ac27536mr136512385e9.28.1745423504981; 
 Wed, 23 Apr 2025 08:51:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4331a9sm19527686f8f.36.2025.04.23.08.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 08:51:44 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:51:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Yicong Yang <yangyicong@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 yangyicong@hisilicon.com, qemu-devel@nongnu.org,
 anisinha@redhat.com, imammedo@redhat.com, linuxarm@huawei.com,
 peter.maydell@linaro.org, prime.zeng@hisilicon.com,
 shameerali.kolothum.thodi@huawei.com, wangyanan55@huawei.com
Subject: Re: [PATCH v3 4/5] hw/acpi/aml-build: Update the revision of PPTT
 table
Message-ID: <20250423115024-mutt-send-email-mst@kernel.org>
References: <20250423114130.902-1-alireza.sanaee@huawei.com>
 <20250423114130.902-5-alireza.sanaee@huawei.com>
 <20250423083909-mutt-send-email-mst@kernel.org>
 <6b783651-e952-ffe9-6c49-7ee9459741c8@huawei.com>
 <20250423113447-mutt-send-email-mst@kernel.org>
 <20250423164720.000070b9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423164720.000070b9@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 23, 2025 at 04:47:20PM +0100, Jonathan Cameron wrote:
> On Wed, 23 Apr 2025 11:35:46 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Apr 23, 2025 at 10:15:42PM +0800, Yicong Yang wrote:
> > > On 2025/4/23 20:39, Michael S. Tsirkin wrote:  
> > > > On Wed, Apr 23, 2025 at 12:41:29PM +0100, Alireza Sanaee wrote:  
> > > >> From: Yicong Yang <yangyicong@hisilicon.com>
> > > >>
> > > >> The lastest ACPI spec 6.5 support PPTT revision 3. Update it
> > > >> by handy. This is compatible with previous revision.
> > > >>
> > > >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>  
> > > > 
> > > > 
> > > > I don't get it. Why are you updating it? Which features
> > > > from the new one are you using?
> > > >   
> > > 
> > > no new features for this patchset. considered updating it to the latest ACPI
> > > spec since we're going to touch the PPTT table and tested data.  
> > 
> > it's best to wait until there are actual features you need.
> > don't make changes for the sake of changes, there's always
> > some risk.
> 
> Once we add the cache description (Ali's other set) can we make
> sure we arbitrary decide to have separate cache structures.  The
> earlier table version allowed sharing of the entrees in the table
> which then became not allowed in the newer spec. That will smooth
> the path quite a bit and is a valid way to interpret the earlier spec.
> 
> If we do that, we can bring the IDs + the version update as a
> precursor to MPAM support series. I don't think we need them until
> that series (which is a way off being ready to merge yet!)
> 
> Jonathan

Why not. Sounds like all that can be made part of Ali's patchset?
I am also ok to merge things gradually, as long as it's
clear and documented in the commit log why we are
making the change and where things are going.

> > 
> > > >> ---
> > > >>  hw/acpi/aml-build.c | 2 +-
> > > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > >> index 3010325ca423..e5401dfdb1a8 100644
> > > >> --- a/hw/acpi/aml-build.c
> > > >> +++ b/hw/acpi/aml-build.c
> > > >> @@ -2155,7 +2155,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> > > >>      uint32_t pptt_start = table_data->len;
> > > >>      uint32_t root_offset;
> > > >>      int n;
> > > >> -    AcpiTable table = { .sig = "PPTT", .rev = 2,
> > > >> +    AcpiTable table = { .sig = "PPTT", .rev = 3,
> > > >>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> > > >>  
> > > >>      acpi_table_begin(&table, table_data);
> > > >> -- 
> > > >> 2.34.1  
> > > > 
> > > > 
> > > > .
> > > >   
> > 
> > 


