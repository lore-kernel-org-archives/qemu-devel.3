Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C44CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlN0-0000Vd-N9; Tue, 11 Nov 2025 05:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vIlMx-0000TY-H9; Tue, 11 Nov 2025 05:12:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vIlMt-00062w-PK; Tue, 11 Nov 2025 05:12:57 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5Mm45qsszHnHBC;
 Tue, 11 Nov 2025 18:12:36 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id ADFFA1402F3;
 Tue, 11 Nov 2025 18:12:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 10:12:52 +0000
Date: Tue, 11 Nov 2025 10:12:51 +0000
To: Gavin Shan <gshan@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <mchehab+huawei@kernel.org>, <gengdongjiu1@gmail.com>, <mst@redhat.com>,
 <imammedo@redhat.com>, <anisinha@redhat.com>, <peter.maydell@linaro.org>,
 <pbonzini@redhat.com>, <shan.gavin@gmail.com>, Hanjun Guo
 <guohanjun@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck
 <tony.luck@intel.com>, "Borislav Petkov" <bp@alien8.de>, Shuai Xue
 <xueshuai@linux.alibaba.com>, <linux-acpi@vger.kernel.org>,
 <linux-edac@vger.kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>
Subject: Re: [PATCH v3 8/8] target/arm/kvm: Support multiple memory CPERs
 injection
Message-ID: <20251111101251.00006e84@huawei.com>
In-Reply-To: <9fbd5344-947d-46bd-8754-16fc9e3fff05@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-9-gshan@redhat.com>
 <20251105143710.000041f5@huawei.com>
 <9fbd5344-947d-46bd-8754-16fc9e3fff05@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 6 Nov 2025 13:26:27 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Jonathan,
> 
> On 11/6/25 12:37 AM, Jonathan Cameron wrote:
> > On Wed,  5 Nov 2025 21:44:53 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >   
> >> In the combination of 64KiB host and 4KiB guest, a problematic host
> >> page affects 16x guest pages that can be owned by different threads.
> >> It means 16x memory errors can be raised at once due to the parallel
> >> accesses to those 16x guest pages on the guest. Unfortunately, QEMU
> >> can't deliver them one by one because we just one GHES error block,  
> > 
> > we have just one
> >   
> 
> Thanks, fixed locally.
> 
> >> corresponding one read acknowledgement register. It can eventually
> >> cause QEMU crash dump due to the contention on that register, meaning
> >> the current memory error can't be delivered before the previous error
> >> isn't acknowledged.
> >>
> >> Imporve push_ghes_memory_errors() to push 16x consecutive memory errors  
> > Improve
> >   
> 
> Thanks, fixed locally.
> 
> >> under this situation to avoid the contention on the read acknowledgement
> >> register.
> >>
> >> Signed-off-by: Gavin Shan <gshan@redhat.com>  
> > Hi Gavin
> > 
> > Silly question that never occurred to me before:
> > What happens if we just report a single larger error?
> > 
> > The CPER record has a Physical Address Mask that I think lets us say we
> > are only reporting at a 64KiB granularity.
> > 
> > In linux drivers/edac/ghes_edac.c seems to handle this via e->grain.
> > https://elixir.bootlin.com/linux/v6.18-rc4/source/drivers/edac/ghes_edac.c#L346
> > 
> > I haven't chased the whole path through to whether this does appropriate poisoning
> > on the guest though.
> >   
> 
> We have the following call trace to handle CPER error record. The e->grain
> originated from the Physical Address Mask is used to come up with the size
> for memory scrubbing at (a). The page isolation happens at (b) bases on the
> reported Physical Address. So a larger Physical Address Mask won't help to
> isolate more pages per my understanding.

Ok - thanks for walking this through!

So is that a kernel bug?  If we have a report of a problem that
effects multiple pages, why are we not isolating them all?

Which one are we isolating? Is it the first in the reported range or
do we have some means to see which address access resulted in an SEA?

+CC kernel APEI maintainers and related to see if they have a view on what should
be happening here.

The short version of the question is: Should the kernel should be isolating
multiple pages if a CPER record has a granularity of more than a page?

This could occur if we have a guest with smaller pages than the host.

> 
> do_sea
>    apei_claim_sea
>      ghes_notify_sea
>        ghes_in_nmi_spool_from_list
>          ghes_in_nmi_queue_one_entry
>          irq_work_queue                          // ghes_proc_irq_work
>            ghes_proc_in_irq
>              ghes_do_proc
>                atomic_notifier_call_chain        // (a) ghes_report_chain
>                  ghes_edac_report_mem_error
>                    edac_raw_mc_handle_error
>                 ghes_handle_memory_failure
>                   ghes_do_memory_failure
>                     memory_failure_cb
>                       memory_failure             // (b) Isolate the page
> 
> Thanks,
> Gavin
> 
> >> ---
> >>   target/arm/kvm.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++--
> >>   1 file changed, 50 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> >> index 5b151eda3c..d7de8262da 100644
> >> --- a/target/arm/kvm.c
> >> +++ b/target/arm/kvm.c
> >> @@ -11,6 +11,7 @@
> >>    */
> >>   
> >>   #include "qemu/osdep.h"
> >> +#include "qemu/units.h"
> >>   #include <sys/ioctl.h>
> >>   
> >>   #include <linux/kvm.h>
> >> @@ -2432,12 +2433,59 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
> >>   static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
> >>                                       uint64_t paddr, Error **errp)
> >>   {
> >> +    uint64_t val, start, end, guest_pgsz, host_pgsz;
> >>       uint64_t addresses[16];
> >> +    uint32_t num_of_addresses;
> >> +    int ret;
> >> +
> >> +    /*
> >> +     * Sort out the guest page size from TCR_EL1, which can be modified
> >> +     * by the guest from time to time. So we have to sort it out dynamically.
> >> +     */
> >> +    ret = read_sys_reg64(c->kvm_fd, &val, ARM64_SYS_REG(3, 0, 2, 0, 2));
> >> +    if (ret) {
> >> +        error_setg(errp, "Error %" PRId32 " to read TCR_EL1 register", ret);
> >> +        return;
> >> +    }
> >> +
> >> +    switch (extract64(val, 14, 2)) {
> >> +    case 0:
> >> +        guest_pgsz = 4 * KiB;
> >> +        break;
> >> +    case 1:
> >> +        guest_pgsz = 64 * KiB;
> >> +        break;
> >> +    case 2:
> >> +        guest_pgsz = 16 * KiB;
> >> +        break;
> >> +    default:
> >> +        error_setg(errp, "Unknown page size from TCR_EL1 (0x%" PRIx64 ")", val);
> >> +        return;
> >> +    }
> >> +
> >> +    host_pgsz = qemu_real_host_page_size();
> >> +    start = paddr & ~(host_pgsz - 1);
> >> +    end = start + host_pgsz;
> >> +    num_of_addresses = 0;
> >>   
> >> -    addresses[0] = paddr;
> >> +    while (start < end) {
> >> +        /*
> >> +         * The precise physical address is provided for the affected
> >> +         * guest page that contains @paddr. Otherwise, the starting
> >> +         * address of the guest page is provided.
> >> +         */
> >> +        if (paddr >= start && paddr < (start + guest_pgsz)) {
> >> +            addresses[num_of_addresses++] = paddr;
> >> +        } else {
> >> +            addresses[num_of_addresses++] = start;
> >> +        }
> >> +
> >> +        start += guest_pgsz;
> >> +    }
> >>   
> >>       kvm_cpu_synchronize_state(c);
> >> -    acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses, 1, errp);
> >> +    acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> >> +                            addresses, num_of_addresses, errp);
> >>       kvm_inject_arm_sea(c);
> >>   }
> >>     
> >   
> 
> 


