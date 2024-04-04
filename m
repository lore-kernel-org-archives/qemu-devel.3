Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A97DCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 13:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNHr-0004fz-S5; Thu, 04 Apr 2024 09:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rsNHq-0004fk-5h
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:37:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rsNHn-0004Ec-5r
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:37:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9Mxg3Zsyz6J7DR;
 Thu,  4 Apr 2024 21:32:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id AFE8F1400DC;
 Thu,  4 Apr 2024 21:37:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 14:37:33 +0100
Date: Thu, 4 Apr 2024 14:37:33 +0100
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
 <gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>, 
 <tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
 <emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
 <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, <nvdimm@lists.linux.dev>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Linux Memory
 Management List" <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang"
 <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 <qemu-devel@nongnu.org>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v10 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
Message-ID: <20240404143733.00004594@Huawei.com>
In-Reply-To: <CAKPbEqoJZe+HWHhCvBTVSHXffGY2ign3Htp4pfbFb4YVJS_Q2A@mail.gmail.com>
References: <20240402001739.2521623-1-horenchuang@bytedance.com>
 <20240402001739.2521623-3-horenchuang@bytedance.com>
 <20240403180425.00003be0@Huawei.com>
 <CAKPbEqoJZe+HWHhCvBTVSHXffGY2ign3Htp4pfbFb4YVJS_Q2A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

<snip>

> > > @@ -858,7 +910,8 @@ static int __init memory_tier_init(void)
> > >        * For now we can have 4 faster memory tiers with smaller adistance
> > >        * than default DRAM tier.
> > >        */
> > > -     default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> > > +     default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
> > > +                                                                     &default_memory_types);  
> >
> > Unusual indenting.  Align with just after (
> >  
> 
> Aligning with "(" will exceed 100 columns. Would that be acceptable?
I think we are talking cross purposes.

	default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
						      &default_memory_types);  

Is what I was suggesting.

> 
> > >       if (IS_ERR(default_dram_type))
> > >               panic("%s() failed to allocate default DRAM tier\n", __func__);
> > >
> > > @@ -868,6 +921,14 @@ static int __init memory_tier_init(void)
> > >        * types assigned.
> > >        */
> > >       for_each_node_state(node, N_MEMORY) {
> > > +             if (!node_state(node, N_CPU))
> > > +                     /*
> > > +                      * Defer memory tier initialization on CPUless numa nodes.
> > > +                      * These will be initialized after firmware and devices are  
> >
> > I think this wraps at just over 80 chars.  Seems silly to wrap so tightly and not
> > quite fit under 80. (this is about 83 chars.
> >  
> 
> I can fix this.
> I have a question. From my patch, this is <80 chars. However,
> in an email, this is >80 chars. Does that mean we need to
> count the number of chars in an email, not in a patch? Or if I
> missed something? like vim configuration or?

3 tabs + 1 space + the text from * (58)
= 24 + 1 + 58 = 83

Advantage of using claws email for kernel stuff is it has a nice per character
ruler at the top of the window.

I wonder if you have a different tab indent size?  The kernel uses 8
characters.  It might explain the few other odd indents if perhaps
you have it at 4 in your editor?

https://www.kernel.org/doc/html/v4.10/process/coding-style.html

Jonathan

> 
> > > +                      * initialized.
> > > +                      */
> > > +                     continue;
> > > +
> > >               memtier = set_node_memory_tier(node);
> > >               if (IS_ERR(memtier))
> > >                       /*  
> >  
> 
> 


