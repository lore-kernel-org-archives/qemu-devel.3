Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D43C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCfr-0002W0-10; Thu, 07 Mar 2024 07:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riCfn-0002Vk-GN
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:16:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riCfj-0000nH-Ec
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:16:31 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr7Z145Hcz6JB95;
 Thu,  7 Mar 2024 20:16:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 3D65014155A;
 Thu,  7 Mar 2024 20:16:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:16:06 +0000
Date: Thu, 7 Mar 2024 12:16:05 +0000
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 06/13] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240307121605.00002d7f@Huawei.com>
In-Reply-To: <ZejAh2O7fDBCcG-N@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-7-nifan.cxl@gmail.com>
 <20240306162816.00002e0e@Huawei.com> <ZejAh2O7fDBCcG-N@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

> > > @@ -868,16 +974,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> > >                                         AddressSpace **as,
> > >                                         uint64_t *dpa_offset)
> > >  {
> > > -    MemoryRegion *vmr = NULL, *pmr = NULL;
> > > +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> > > +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
> > >  
> > >      if (ct3d->hostvmem) {
> > >          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > > +        vmr_size = memory_region_size(vmr);
> > >      }
> > >      if (ct3d->hostpmem) {
> > >          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > > +        pmr_size = memory_region_size(pmr);
> > > +    }
> > > +    if (ct3d->dc.host_dc) {
> > > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > > +        /* Do we want dc_size to be dc_mr->size or not?? */  
> > 
> > Maybe - definitely don't want to leave this comment here
> > unanswered and I think you enforce it above anyway.
> > 
> > So if we get here ct3d->dc.total_capacity == memory_region_size(ct3d->dc.host_dc);
> > As such we could just not stash total_capacity at all?  
> 
> I cannot identify a case where these two will be different. But
> total_capacity is referenced at quite some places, it may be nice to have
> it so we do not need to call the function to get the value every time?

I kind of like having it via one path so that there is no confusion
for the reader, but up to you on this one.  The function called is trivial
(other than some magic to handle very large memory regions) so
this is just a readability question, not a perf one.

Whatever, don't leave the question behind.  Find to have something
that says they are always the same size if you don't get rid
of the total_capacity representation.


Jonathan

