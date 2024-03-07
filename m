Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D613CC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 14:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riER0-0003xJ-Nd; Thu, 07 Mar 2024 09:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riEQz-0003ww-L0
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:09:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riEQv-0000Ju-Jr
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:09:21 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrB4Q19MHz6D8c3;
 Thu,  7 Mar 2024 22:09:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 4AE8D140D1D;
 Thu,  7 Mar 2024 22:09:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 14:09:12 +0000
Date: Thu, 7 Mar 2024 14:09:11 +0000
To: Peter Xu <peterx@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH 2/3] physmem: Factor out body of
 flatview_read/write_continue() loop
Message-ID: <20240307140911.00003c1b@Huawei.com>
In-Reply-To: <ZeFpHr0KU6NWMv1x@x1n>
References: <20240215142817.1904-1-Jonathan.Cameron@huawei.com>
 <20240215142817.1904-3-Jonathan.Cameron@huawei.com>
 <ZeFnoBLJ_fKhLD8r@x1n> <ZeFpHr0KU6NWMv1x@x1n>
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

On Fri, 1 Mar 2024 13:35:26 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Fri, Mar 01, 2024 at 01:29:04PM +0800, Peter Xu wrote:
> > On Thu, Feb 15, 2024 at 02:28:16PM +0000, Jonathan Cameron wrote:  
> > > This code will be reused for the address_space_cached accessors
> > > shortly.
> > > 
> > > Also reduce scope of result variable now we aren't directly
> > > calling this in the loop.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  system/physmem.c | 165 ++++++++++++++++++++++++++++-------------------
> > >  1 file changed, 98 insertions(+), 67 deletions(-)
> > > 
> > > diff --git a/system/physmem.c b/system/physmem.c
> > > index 39b5ac751e..74f92bb3b8 100644
> > > --- a/system/physmem.c
> > > +++ b/system/physmem.c
> > > @@ -2677,6 +2677,54 @@ static bool flatview_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
> > >      return false;
> > >  }
> > >  
> > > +static MemTxResult flatview_write_continue_step(hwaddr addr,  
> 
> One more thing: this addr var is not used, afaict.  We could drop addr1
> below and use this to represent the MR offset.

I'm tempted to keep the addr1 where it is in the parameter list just so that
it matches up with the caller location but a rename makes a lot of sense.

> 
> I'm wondering whether we should start to use some better namings already
> for memory API functions to show obviously what AS it is describing.  From
> that POV, perhaps rename it to "mr_addr"?

I'll add a precursor patch renaming these for the functions this series touches.
We can tidy up other cases later.  I'll put a note in that patch below the cut
to observe that the rename makes sense more widely.

I've not picked up the RB given because of the parameter ordering question.

Thanks,

Jonathan

> 
> > > +                                                MemTxAttrs attrs,
> > > +                                                const uint8_t *buf,
> > > +                                                hwaddr len, hwaddr addr1,
> > > +                                                hwaddr *l, MemoryRegion *mr)
> > > +{
> > > +    if (!flatview_access_allowed(mr, attrs, addr1, *l)) {
> > > +        return MEMTX_ACCESS_ERROR;
> > > +    }
> > > +
> > > +    if (!memory_access_is_direct(mr, true)) {
> > > +        uint64_t val;
> > > +        MemTxResult result;
> > > +        bool release_lock = prepare_mmio_access(mr);
> > > +
> > > +        *l = memory_access_size(mr, *l, addr1);
> > > +        /* XXX: could force current_cpu to NULL to avoid
> > > +           potential bugs */
> > > +
> > > +        /*
> > > +         * Assure Coverity (and ourselves) that we are not going to OVERRUN
> > > +         * the buffer by following ldn_he_p().
> > > +         */
> > > +#ifdef QEMU_STATIC_ANALYSIS
> > > +        assert((*l == 1 && len >= 1) ||
> > > +               (*l == 2 && len >= 2) ||
> > > +               (*l == 4 && len >= 4) ||
> > > +               (*l == 8 && len >= 8));
> > > +#endif
> > > +        val = ldn_he_p(buf, *l);
> > > +        result = memory_region_dispatch_write(mr, addr1, val,
> > > +                                              size_memop(*l), attrs);
> > > +        if (release_lock) {
> > > +            bql_unlock();
> > > +        }
> > > +
> > > +        return result;
> > > +    } else {
> > > +        /* RAM case */
> > > +        uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, l, false);
> > > +
> > > +        memmove(ram_ptr, buf, *l);
> > > +        invalidate_and_set_dirty(mr, addr1, *l);
> > > +
> > > +        return MEMTX_OK;
> > > +    }
> > > +}
> > > +
> > >  /* Called within RCU critical section.  */
> > >  static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
> > >                                             MemTxAttrs attrs,
> > > @@ -2688,42 +2736,9 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
> > >      const uint8_t *buf = ptr;
> > >  
> > >      for (;;) {
> > > -        if (!flatview_access_allowed(mr, attrs, addr1, l)) {
> > > -            result |= MEMTX_ACCESS_ERROR;
> > > -            /* Keep going. */
> > > -        } else if (!memory_access_is_direct(mr, true)) {
> > > -            uint64_t val;
> > > -            bool release_lock = prepare_mmio_access(mr);
> > > -
> > > -            l = memory_access_size(mr, l, addr1);
> > > -            /* XXX: could force current_cpu to NULL to avoid
> > > -               potential bugs */
> > > -
> > > -            /*
> > > -             * Assure Coverity (and ourselves) that we are not going to OVERRUN
> > > -             * the buffer by following ldn_he_p().
> > > -             */
> > > -#ifdef QEMU_STATIC_ANALYSIS
> > > -            assert((l == 1 && len >= 1) ||
> > > -                   (l == 2 && len >= 2) ||
> > > -                   (l == 4 && len >= 4) ||
> > > -                   (l == 8 && len >= 8));
> > > -#endif
> > > -            val = ldn_he_p(buf, l);
> > > -            result |= memory_region_dispatch_write(mr, addr1, val,
> > > -                                                   size_memop(l), attrs);
> > > -            if (release_lock) {
> > > -                bql_unlock();
> > > -            }
> > > -
> > >  
> > > -        } else {
> > > -            /* RAM case */
> > > -            uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l,
> > > -                                                   false);
> > > -            memmove(ram_ptr, buf, l);
> > > -            invalidate_and_set_dirty(mr, addr1, l);
> > > -        }
> > > +        result |= flatview_write_continue_step(addr, attrs, buf, len, addr1, &l,
> > > +                                               mr);
> > >  
> > >          len -= l;
> > >          buf += l;
> > > @@ -2757,6 +2772,52 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
> > >                                     addr1, l, mr);
> > >  }
> > >  
> > > +static MemTxResult flatview_read_continue_step(hwaddr addr,
> > > +                                               MemTxAttrs attrs, uint8_t *buf,
> > > +                                               hwaddr len, hwaddr addr1,
> > > +                                               hwaddr *l,
> > > +                                               MemoryRegion *mr)
> > > +{
> > > +    if (!flatview_access_allowed(mr, attrs, addr1, *l)) {
> > > +        return  MEMTX_ACCESS_ERROR;  
> >                   |
> >                   ^ space
> >   
> > > +    }
> > > +
> > > +    if (!memory_access_is_direct(mr, false)) {
> > > +        /* I/O case */
> > > +        uint64_t val;
> > > +        MemTxResult result;
> > > +        bool release_lock = prepare_mmio_access(mr);
> > > +
> > > +        *l = memory_access_size(mr, *l, addr1);
> > > +        result = memory_region_dispatch_read(mr, addr1, &val,
> > > +                                                  size_memop(*l), attrs);  
> > 
> > Please do proper indents.
> > 
> > Other than that:
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > -- 
> > Peter Xu  
> 


