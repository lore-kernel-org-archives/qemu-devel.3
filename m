Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E6DC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 18:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKjG8-0003WT-Ln; Fri, 21 Jun 2024 14:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sKjG7-0003W7-3o
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 14:45:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sKjG3-00047g-T8
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 14:45:14 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5R852BTsz67Gnx;
 Sat, 22 Jun 2024 02:43:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 66116140B63;
 Sat, 22 Jun 2024 02:45:08 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 19:45:07 +0100
Date: Fri, 21 Jun 2024 19:45:06 +0100
To: Dan Williams <dan.j.williams@intel.com>
CC: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <ira.weiny@intel.com>,
 <alison.schofield@intel.com>, <dave.jiang@intel.com>,
 <vishal.l.verma@intel.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
 <tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 <linux-edac@vger.kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Message-ID: <20240621194506.000024aa@Huawei.com>
In-Reply-To: <6675bf92116ed_57ac294a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <20240620180239.00004d41@Huawei.com>
 <6675bf92116ed_57ac294a@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Fri, 21 Jun 2024 10:59:46 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 19 Jun 2024 00:53:10 +0800
> > Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> >   
> > > Background:
> > > Since CXL device is a memory device, while CPU consumes a poison page of 
> > > CXL device, it always triggers a MCE by interrupt (INT18), no matter 
> > > which-First path is configured.  This is the first report.  Then 
> > > currently, in FW-First path, the poison event is transferred according 
> > > to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES   
> > >  -> CPER -> trace report.  This is the second one.  These two reports    
> > > are indicating the same poisoning page, which is the so-called "duplicate
> > > report"[1].  And the memory_failure() handling I'm trying to add in
> > > OS-First path could also be another duplicate report.
> > > 
> > > Hope the flow below could make it easier to understand:
> > > CPU accesses bad memory on CXL device, then  
> > >  -> MCE (INT18), *always* report (1)
> > >  -> * FW-First (implemented now)
> > >       -> CXL device -> FW
> > > 	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)    
> > >     * OS-First (not implemented yet, I'm working on it)  
> > >       -> CXL device -> MSI
> > > 	      -> OS:CXL driver -> memory_failure() (2.b)    
> > > so, the (1) and (2.a/b) are duplicated.
> > > 
> > > (I didn't get response in my reply for [1] while I have to make patch to
> > > solve this problem, so please correct me if my understanding is wrong.)
> > > 
> > > This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
> > > to check whether the current poison page has been reported (if yes,
> > > stop the notifier chain, won't call the following memory_failure()
> > > to report), into `x86_mce_decoder_chain`.  In this way, if the poison
> > > page already handled(recorded and reported) in (1) or (2), the other one
> > > won't duplicate the report.  The record could be clear when
> > > cxl_clear_poison() is called.
> > > 
> > > [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>  
> > 
> > So poison can be cleared in a number of ways and a CXL poison clear command
> > is unfortunately only one of them.  Some architectures have instructions
> > that guarantee to write a whole cacheline and can clear things as well.
> > I believe x86 does for starters.  
> 
> Yes, movdir64b.

Equivalent arm64 instruction is not valid to normal memory. Lets say
no more on that :(

So who actually cares about recovering poisoned volatile memory?
I'd like to understand more on how significant a use case this is.
Whilst I can conjecture that its an extreme case of wanting to avoid
loosing the ability to create 1GiB or larger pages due to poison
is that a real problem for anyone today?  Note this is just the case
where you've reached an actual uncorrectable error and probably
/ possibly killed something, not the more common soft offlining
of memory due to correctable errors being detected.

> 
> > +CC linux-edac and related maintainers / reviewers.
> >     linux-mm and hwpoison maintainer.
> > 
> > So I think this needs a more general solution that encompasses 
> > more general cleanup of poison.  
> 
> I think unless the device has "List Poison" coverage for volatile ranges
> that the kernel should not worry about tracking this itself.

Maybe.  I think you can still get a media event for this as well
as synchronous poison so there may be a path to a double report, just
a more timely one hopefully.

> 
> Perhaps what is needed is that after successful memory_failure()
> handling when the page is known to be offline the device backing the
> memory can be notified that it is safe to repair the page and but it
> back into service, but I expect that would be comparison of the device's
> own poison tracking relative to the notification of successful page
> offline.

That would work. Elide the error handling if the page is known to
be offline due to poison.  Might be racey though but does it
really hurt if we occasionally report twice?

> > > +	rec = kmalloc(sizeof(struct cxl_mce_record), GFP_KERNEL);
> > > +	rec->hpa = hpa;
> > > +	list_add(&cxl_mce_records, &rec->node);
> > > +
> > > +	mutex_unlock(&cxl_mce_mutex);
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +void cxl_mce_clear(u64 hpa)
> > > +{
> > > +	struct cxl_mce_record *cur, *next;
> > > +	int rc;
> > > +
> > > +	rc = mutex_lock_interruptible(&cxl_mce_mutex);  
> > 
> > Maybe cond_guard().  
> 
> cond_guard() was rejected, you meant scoped_cond_guard()? But, then I
> think _interruptible is not appropriate here.

Ah yes.  Indeed scoped_cond_guard() but fair enough on the
interruptible point!


> 


