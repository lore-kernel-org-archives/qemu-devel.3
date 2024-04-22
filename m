Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9760BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 11:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rysGy-0003XK-Gi; Mon, 22 Apr 2024 07:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rysGw-0003Wu-R2
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 07:55:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rysGu-0004yv-OK
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 07:55:46 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNNx35QlFz6K9Mp;
 Mon, 22 Apr 2024 19:55:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 75D3E140119;
 Mon, 22 Apr 2024 19:55:41 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 12:55:40 +0100
Date: Mon, 22 Apr 2024 12:55:39 +0100
To: Gregory Price <gregory.price@memverge.com>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 06/12] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240422125539.00005b2b@huawei.com>
In-Reply-To: <ZiKpn7oSQWKkywwx@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-7-fan.ni@samsung.com>
 <ZiKpn7oSQWKkywwx@memverge.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 19 Apr 2024 13:27:59 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Thu, Apr 18, 2024 at 04:10:57PM -0700, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Add (file/memory backed) host backend for DCD. All the dynamic capacity
> > regions will share a single, large enough host backend. Set up address
> > space for DC regions to support read/write operations to dynamic capacity
> > for DCD.
> > 
> > With the change, the following support is added:
> > 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
> >    memory backend for dynamic capacity. Currently, all DC regions share one
> >    host backend;
> > 2. Add namespace for dynamic capacity for read/write support;
> > 3. Create cdat entries for each dynamic capacity region.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  |  16 ++--
> >  hw/mem/cxl_type3.c          | 172 +++++++++++++++++++++++++++++-------
> >  include/hw/cxl/cxl_device.h |   8 ++
> >  3 files changed, 160 insertions(+), 36 deletions(-)
> >   
> 
> A couple general comments in line for discussion, but patch looks good
> otherwise. Notes are mostly on improvements we could make that should
> not block this patch.
> 
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> 
> >  
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index a1fe268560..ac87398089 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -45,7 +45,8 @@ enum {
> >  
> >  static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> >                                            int dsmad_handle, uint64_t size,
> > -                                          bool is_pmem, uint64_t dpa_base)
> > +                                          bool is_pmem, bool is_dynamic,
> > +                                          uint64_t dpa_base)  
> 
> We should probably change the is_* fields into a flags field and do some
> error checking on the combination of flags.
> 
> >  {
> >      CDATDsmas *dsmas;
> >      CDATDslbis *dslbis0;
> > @@ -61,7 +62,8 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> >              .length = sizeof(*dsmas),
> >          },
> >          .DSMADhandle = dsmad_handle,
> > -        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> > +        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
> > +                 (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),  
> 
> For example, as noted elsewhere in the code, is_pmem+is_dynamic is not
> presently supported, so this shouldn't even be allowed in this function.
> 
> > +    if (dc_mr) {
> > +        int i;
> > +        uint64_t region_base = vmr_size + pmr_size;
> > +
> > +        /*
> > +         * TODO: we assume the dynamic capacity to be volatile for now.
> > +         * Non-volatile dynamic capacity will be added if needed in the
> > +         * future.
> > +         */  
> 
> Probably don't need to mark this TODO, can just leave it as a note.
> 
> Non-volatile dynamic capacity will coincide with shared memory, so it'll
> end up handled.  So this isn't really a TODO for this current work, and
> should read more like:
> 
> "Dynamic Capacity is always volatile, until shared memory is
> implemented"

I can sort of see your logic, but there is a difference between
volatile memory that is shared and persistent memory (typically whether
we need to care about deep flushes in some architectures) so I'd expected
volatile shared capacity to still be a thing, even if the host OS treats
it in most ways as persistent.

Also, persistent + DCD could be a thing without sharing sometime in the
future.

> 
> > +    } else if (ct3d->hostpmem) {
> >          range1_size_hi = ct3d->hostpmem->size >> 32;
> >          range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> >                           (ct3d->hostpmem->size & 0xF0000000);
> > +    } else {
> > +        /*
> > +         * For DCD with no static memory, set memory active, memory class bits.
> > +         * No range is set.
> > +         */
> > +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3;  
> 
> We should probably add defs for these fields at some point. Can be
> tabled for later work though.
Agreed - worth tidying up but not on critical path.

> 
> > +        /*
> > +         * TODO: set dc as volatile for now, non-volatile support can be added
> > +         * in the future if needed.
> > +         */
> > +        memory_region_set_nonvolatile(dc_mr, false);  
> 
> Again can probably drop the TODO and just leave a statement.
> 
> ~Gregory


