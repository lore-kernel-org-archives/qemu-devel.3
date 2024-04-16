Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9760C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 15:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwkJ2-0000Kg-SL; Tue, 16 Apr 2024 11:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rwkIz-0000KJ-MG
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:01:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rwkIu-0005Gu-Q6
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:01:05 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJnD161Cvz6K8wk;
 Tue, 16 Apr 2024 22:56:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 21F3D140B55;
 Tue, 16 Apr 2024 23:00:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 16:00:57 +0100
Date: Tue, 16 Apr 2024 16:00:56 +0100
To: fan <nifan.cxl@gmail.com>
CC: Gregory Price <gregory.price@memverge.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <20240416160056.0000325c@Huawei.com>
In-Reply-To: <Zh1lk8FWmf0oI7RM@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-11-nifan.cxl@gmail.com>
 <Zhm7ssKVGdGlR9Iq@memverge.com> <Zh1lk8FWmf0oI7RM@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Mon, 15 Apr 2024 10:37:00 -0700
fan <nifan.cxl@gmail.com> wrote:

> On Fri, Apr 12, 2024 at 06:54:42PM -0400, Gregory Price wrote:
> > On Mon, Mar 25, 2024 at 12:02:28PM -0700, nifan.cxl@gmail.com wrote:  
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > All dpa ranges in the DC regions are invalid to access until an extent
> > > covering the range has been added. Add a bitmap for each region to
> > > record whether a DC block in the region has been backed by DC extent.
> > > For the bitmap, a bit in the bitmap represents a DC block. When a DC
> > > extent is added, all the bits of the blocks in the extent will be set,
> > > which will be cleared when the extent is released.
> > > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > ---
> > >  hw/cxl/cxl-mailbox-utils.c  |  6 +++
> > >  hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
> > >  include/hw/cxl/cxl_device.h |  7 ++++
> > >  3 files changed, 89 insertions(+)
> > > 
> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index 7094e007b9..a0d2239176 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -1620,6 +1620,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> > >  
> > >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> > >          ct3d->dc.total_extent_count += 1;
> > > +        ct3_set_region_block_backed(ct3d, dpa, len);
> > >  
> > >          ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> > >          cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);  
> > 
> > while looking at the MHD code, we had decided to "reserve" the blocks in
> > the bitmap in the call to `qmp_cxl_process_dynamic_capacity` in order to
> > prevent a potential double-allocation (basically we need to sanity check
> > that two hosts aren't reserving the region PRIOR to the host being
> > notified).
> > 
> > I did not see any checks in the `qmp_cxl_process_dynamic_capacity` path
> > to prevent pending extents from being double-allocated.  Is this an
> > explicit choice?
> > 
> > I can see, for example, why you may want to allow the following in the
> > pending list: [Add X, Remove X, Add X].  I just want to know if this is
> > intentional or not. If not, you may consider adding a pending check
> > during the sanity check phase of `qmp_cxl_process_dynamic_capacity`
> > 
> > ~Gregory  
> 
> First, for remove request, pending list is not involved. See cxl r3.1,
> 9.13.3.3. Pending basically means "pending to add". 
> So for the above example, in the pending list, you can see [Add x, add x] if the
> event is not processed in time.
> Second, from the spec, I cannot find any text saying we cannot issue
> another add extent X if it is still pending.

I think there is text saying that the capacity is not released for reuse
by the device until it receives a response from the host.   Whilst
it's not explicit on offers to the same host, I'm not sure that matters.
So I don't think it is suppose to queue multiple extents...


> From the kernel side, if the first one is accepted, the second one will
> get rejected, and there is no issue there.
> If the first is reject for some reason, the second one can get
> accepted or rejected and do not need to worry about the first one.
> 
> 
> Fan
> 


