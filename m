Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E62C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZp8w-0006mA-E0; Tue, 13 Feb 2024 04:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZp8v-0006lz-1I
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:31:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZp8t-0006mf-HD
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:31:56 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYwww2TkPz6F97k;
 Tue, 13 Feb 2024 17:28:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id BEA021413D4;
 Tue, 13 Feb 2024 17:31:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 09:31:53 +0000
Date: Tue, 13 Feb 2024 09:31:52 +0000
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 9/9] hw/mem/cxl_type3: Add dpa range validation for
 accesses to dc regions
Message-ID: <20240213093152.000017d5@Huawei.com>
In-Reply-To: <ZcZ3LU9bM20Lomce@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-10-nifan.cxl@gmail.com>
 <20240124165815.00007e46@Huawei.com> <ZcZ3LU9bM20Lomce@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index 43cea3d818..4ec65a751a 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c  
> >   
> > > +/*
> > > + * Check whether a DPA range [dpa, dpa + len) has been backed with DC extents.
> > > + * Used when validating read/write to dc regions
> > > + */
> > > +bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > > +                                  uint64_t len)
> > > +{
> > > +    CXLDCDRegion *region;
> > > +    uint64_t nbits;
> > > +    long nr;
> > > +
> > > +    region = cxl_find_dc_region(ct3d, dpa, len);
> > > +    if (!region) {
> > > +        return false;
> > > +    }
> > > +
> > > +    nr = (dpa - region->base) / region->block_size;
> > > +    nbits = DIV_ROUND_UP(len, region->block_size);
> > > +    return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;  
> > I'm not sure how this works... Is it taking a size or an end point?
> > 
> > Linux equivalent takes size, so I'd expect
> > 
> >     return find_next_zero_bit(region->blk_bitmap, nbits, nr);
> > Perhaps a comment would avoid any future confusion on this.
> >   
> 
> My understanding is that the size is the size of the bitmap, which is
> also end of the range to check, not the length of the range to check.
> 
> The function find_next_zero_bit(bitmap, size, offset) checks the bitmap range
> [offset, size) to find the next unset bit, for the above test, we want to
> check range [nr, nr + nbits), so the arguments passed to the function
> should be right.
> 
> In the definition of the function, whenever offset >= size, it returns size
> because size is the end of the range, So if we pass nbits and nr
> to the function and nr >= nbits, which can be common, meaning (dpa-region_base)
> \> len, the function will always return true; that is not what we want.  
> 
> To sum up, the second parameter of the function should always be the end
> of the range to check, for our case, it is nr + nbits.
Ok. Thanks for the explanation. That sounds good to me

Jonathan

> 
> Fan

