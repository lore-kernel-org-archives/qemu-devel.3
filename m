Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C299CC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 12:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc2YB-0001Zu-HE; Mon, 19 Feb 2024 07:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc2Y9-0001QR-BW
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:15:09 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc2Y6-0000Ri-DM
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:15:09 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdhFw5hG3z6K5wt;
 Mon, 19 Feb 2024 20:11:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 29FE3140D26;
 Mon, 19 Feb 2024 20:14:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 12:14:56 +0000
Date: Mon, 19 Feb 2024 12:14:55 +0000
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
 "Gregory Price" <gregory.price@memverge.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
 <dimitrios.palyvos@zptcorp.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be
 in mmio memory.
Message-ID: <20240219121455.0000387d@Huawei.com>
In-Reply-To: <4b00b67d-cb3c-4173-bb7f-1ae68cdfbada@linaro.org>
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
 <4b00b67d-cb3c-4173-bb7f-1ae68cdfbada@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Thu, 15 Feb 2024 09:30:27 -1000
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 2/15/24 05:01, Jonathan Cameron wrote:
> > On i386, after fixing the page walking code to work with pages in
> > MMIO memory (specifically CXL emulated interleaved memory),
> > a crash was seen in an interrupt handling path.
> > 
> > Useful part of bt
> > 
> > Peter identified this as being due to the BQL already being
> > held when the page table walker encounters MMIO memory and attempts
> > to take the lock again.  There are other examples of similar paths
> > TCG, so this follows the approach taken in those of simply checking
> > if the lock is already held and if it is, don't take it again.
> > 
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   accel/tcg/cputlb.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 047cd2cc0a..3b8d178707 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
> >                                  int mmu_idx, MMUAccessType type, uintptr_t ra)
> >   {
> >       MemoryRegionSection *section;
> > +    bool locked = bql_locked();
> >       MemoryRegion *mr;
> >       hwaddr mr_offset;
> >       MemTxAttrs attrs;
> > @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
> >       section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
> >       mr = section->mr;
> >   
> > -    bql_lock();
> > +    if (!locked) {
> > +        bql_lock();
> > +    }
> >       ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
> >                             type, ra, mr, mr_offset);
> > -    bql_unlock();
> > +    if (!locked) {
> > +        bql_unlock();
> > +    }  
> 
> On top of other comments, I'm never keen on this type of test/lock/test/unlock.  When this 
> kind of thing is encountered, it means we should have been using a recursive lock in the 
> first place.

Hi Richard,

Whilst I agree this stuff is really ugly, is it practical to fix it for this case?
Or was intent here to make a general comment on QEMU locking?

Jonathan


> 
> 
> r~


