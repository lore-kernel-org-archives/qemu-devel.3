Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF482C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 17:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPPwq-00027a-6w; Thu, 04 Jul 2024 13:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPPwo-00027F-9N
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 13:08:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPPwl-0006jI-Fj
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 13:08:41 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFNP12qNzz67Hm8;
 Fri,  5 Jul 2024 01:07:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id C7BFF14065C;
 Fri,  5 Jul 2024 01:08:24 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Jul
 2024 18:08:24 +0100
Date: Thu, 4 Jul 2024 18:08:23 +0100
To: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
 <gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>, 
 <tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
 <emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
 <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>,
 "SeongJae  Park" <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
 Chuang" <horenchuang@bytedance.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@gmail.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/1] memory tier: consolidate the initialization of
 memory tiers
Message-ID: <20240704180823.0000212d@Huawei.com>
In-Reply-To: <84b43294411bb1fe0ed58f2da59abf554ef48f7d@linux.dev>
References: <20240628060925.303309-1-horen.chuang@linux.dev>
 <20240628060925.303309-2-horen.chuang@linux.dev>
 <20240702142535.00003dc0@Huawei.com>
 <84b43294411bb1fe0ed58f2da59abf554ef48f7d@linux.dev>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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


Hi,

> > > 
> > >  static int __init memory_tier_init(void)
> > > 
> > >  {
> > > 
> > >  - int ret, node;
> > > 
> > >  - struct memory_tier *memtier;
> > > 
> > >  + int ret;
> > > 
> > >  
> > > 
> > >  ret = subsys_virtual_register(&memory_tier_subsys, NULL);
> > > 
> > >  if (ret)
> > > 
> > >  @@ -887,7 +897,8 @@ static int __init memory_tier_init(void)
> > > 
> > >  GFP_KERNEL);
> > > 
> > >  WARN_ON(!node_demotion);
> > > 
> > >  #endif
> > > 
> > >  - mutex_lock(&memory_tier_lock);
> > > 
> > >  +
> > > 
> > >  + guard(mutex)(&memory_tier_lock);
> > >   
> > 
> > If this was safe to do without the rest of the change (I think so)
> > 
> > then better to pull that out as a trivial precursor so less noise
> > 
> > in here.
> >   
> 
> Do you mean instead of using guard(mutex)(),
> use mutex_lock() as it was? or?
> 

Code as here, but possibly pull the guard(mutex) part out as
a patch 1 as it's an unrelated improvement to the rest of the set
which would be in patch 2.

Not particularly important though as you've sent a v3 in the
meantime and it's fine to have it in one patch.

> > > 
> > > /*
> > > 
> > >  * For now we can have 4 faster memory tiers with smaller adistance
> > > 
> > >  * than default DRAM tier.
> > > 
> > >  @@ -897,29 +908,9 @@ static int __init memory_tier_init(void)
> > > 
> > >  if (IS_ERR(default_dram_type))
> > > 
> > >  panic("%s() failed to allocate default DRAM tier\n", __func__);
> > > 
> > >  
> > > 
> > >  - /*
> > > 
> > >  - * Look at all the existing N_MEMORY nodes and add them to
> > > 
> > >  - * default memory tier or to a tier if we already have memory
> > > 
> > >  - * types assigned.
> > > 
> > >  - */
> > > 
> > >  - for_each_node_state(node, N_MEMORY) {
> > > 
> > >  - if (!node_state(node, N_CPU))
> > > 
> > >  - /*
> > > 
> > >  - * Defer memory tier initialization on
> > > 
> > >  - * CPUless numa nodes. These will be initialized
> > > 
> > >  - * after firmware and devices are initialized.
> > > 
> > >  - */
> > > 
> > >  - continue;
> > > 
> > >  -
> > > 
> > >  - memtier = set_node_memory_tier(node);
> > > 
> > >  - if (IS_ERR(memtier))
> > > 
> > >  - /*
> > > 
> > >  - * Continue with memtiers we are able to setup
> > > 
> > >  - */
> > > 
> > >  - break;
> > > 
> > >  - }
> > > 
> > >  - establish_demotion_targets();
> > > 
> > >  - mutex_unlock(&memory_tier_lock);
> > > 
> > >  + /* Record nodes with memory and CPU to set default DRAM performance. */
> > > 
> > >  + nodes_and(default_dram_nodes, node_states[N_MEMORY],
> > > 
> > >  + node_states[N_CPU]);
> > >   
> > 
> > There are systems where (for various esoteric reasons, such as describing an
> > 
> > association with some other memory that isn't DRAM where the granularity
> > 
> > doesn't match) the CPU nodes contain no DRAM but rather it's one node away.
> > 
> > Handling that can be a job for another day though.
> >   
> 
> Thank you for informing me of this situation.
> Sounds like handling that also requires a mapping table between
> the CPU and the corresponding DRAM.

I've not yet looked at how it interacts with this, but
from an ACPI point of view it's just 'near' in SLIT and
HMAT.  The nearest thing to a description is
Memory Proximity Domain Attributes structures in HMAT.
That allows you to describe the location of the memory
controller, but in this type of system there may be
a many to 1 mapping (interleaving across memory controllers
in some CPU only nodes) for example.

Anyhow, guess I need to spin up some emulated machines and
see what breaks :)

Jonathan

