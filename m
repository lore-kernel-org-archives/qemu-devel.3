Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBD6C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZp67-0005I4-Jv; Tue, 13 Feb 2024 04:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZp65-0005Hu-N6
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:29:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZp63-0006K6-JB
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:29:01 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYwsJ2dmBz6F95J;
 Tue, 13 Feb 2024 17:25:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id BF391140D1D;
 Tue, 13 Feb 2024 17:28:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 09:28:45 +0000
Date: Tue, 13 Feb 2024 09:28:45 +0000
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 5/9] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240213092845.00000dfc@Huawei.com>
In-Reply-To: <ZcKxpFWe5v5YkJqb@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-6-nifan.cxl@gmail.com>
 <20240124154721.0000451d@Huawei.com> <ZcKxpFWe5v5YkJqb@debian>
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


> > >      *cdat_table = g_steal_pointer(&table);
> > > @@ -445,11 +492,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> > >              range2_size_hi = ct3d->hostpmem->size >> 32;
> > >              range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> > >                               (ct3d->hostpmem->size & 0xF0000000);
> > > +        } else if (ct3d->dc.host_dc) {
> > > +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> > > +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> > > +                             (ct3d->dc.host_dc->size & 0xF0000000);  
> > 
> > I've forgotten if we came to a conclusion on whether these should include
> > DC or not...  My gut feeling is no because we don't know what to do
> > if they are both already in use.
> >   
> 
> QUESTION:
> 
> If we do not include DC, and there is no static ram/pmem capacity and
> only dynamic capacity, then the range registers will not be set, is that
> what we want?

I think that's a valid interpretation of the specification.
So for now go with that.

p.s. Sorry for slow response.  Debugging had me distracted from catching
up with the list.

