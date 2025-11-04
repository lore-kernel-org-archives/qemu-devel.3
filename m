Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD5DCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 12:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGJf-0000GC-TO; Tue, 04 Nov 2025 07:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vGGJb-0000FF-Da; Tue, 04 Nov 2025 07:39:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vGGJX-0005AR-Tr; Tue, 04 Nov 2025 07:39:11 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d16y63gGrzJ46lR;
 Tue,  4 Nov 2025 20:21:34 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 01FB51402F3;
 Tue,  4 Nov 2025 20:21:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 12:21:53 +0000
Date: Tue, 4 Nov 2025 12:21:51 +0000
To: Igor Mammedov <imammedo@redhat.com>
CC: Gavin Shan <gshan@redhat.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <mst@redhat.com>, <anisinha@redhat.com>,
 <gengdongjiu1@gmail.com>, <peter.maydell@linaro.org>, <pbonzini@redhat.com>,
 <mchehab+huawei@kernel.org>, <shan.gavin@gmail.com>
Subject: Re: [PATCH RESEND v2 3/3] target/arm/kvm: Support multiple memory
 CPERs injection
Message-ID: <20251104122151.00006feb@huawei.com>
In-Reply-To: <20251103105216.1f4241d7@fedora>
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-4-gshan@redhat.com>
 <20251017162746.2a99015b@fedora>
 <a635de53-71fa-4edb-87c0-8775722c284d@redhat.com>
 <20251031145539.3551b0a5@fedora>
 <88a41137-d5fb-4b61-a3f2-dd73133c17ec@redhat.com>
 <20251103105216.1f4241d7@fedora>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 3 Nov 2025 10:52:16 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 3 Nov 2025 09:02:54 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
> > On 10/31/25 11:55 PM, Igor Mammedov wrote:  
> > > On Sun, 19 Oct 2025 10:36:16 +1000
> > > Gavin Shan <gshan@redhat.com> wrote:    
> > >> On 10/18/25 12:27 AM, Igor Mammedov wrote:    
> > >>> On Tue,  7 Oct 2025 16:08:10 +1000
> > >>> Gavin Shan <gshan@redhat.com> wrote:
> > >>>        
> > >>>> In the combination of 64KB host and 4KB guest, a problematic host page
> > >>>> affects 16x guest pages. In this specific case, it's reasonable to
> > >>>> push 16 consecutive memory CPERs. Otherwise, QEMU can run into core
> > >>>> dump due to the current error can't be delivered as the previous error
> > >>>> isn't acknoledges. It's caused by the nature the host page can be
> > >>>> accessed in parallel due to the mismatched host and guest page sizes.    
> > >>>
> > >>> can you explain a bit more what goes wrong?
> > >>>
> > >>> I'm especially interested in parallel access you've mentioned
> > >>> and why batch adding error records is needed
> > >>> as opposed to adding records every time invalid access happens?
> > >>>
> > >>> PS:
> > >>> Assume I don't remember details on how HEST works,
> > >>> Answering it in this format also should improve commit message
> > >>> making it more digestible for uninitiated.
> > >>>        
> > >>
> > >> Thanks for your review and I'm trying to answer your question below. Please let
> > >> me know if there are more questions.
> > >>
> > >> There are two signals (BUS_MCEERR_AR and BUS_MCEERR_AO) and BUS_MCEERR_AR is
> > >> concerned here. This signal BUS_MCEERR_AR is sent by host's stage2 page fault
> > >> handler when the resolved host page has been marked as marked as poisoned.
> > >> The stage2 page fault handler is invoked on every access to the host page.
> > >>
> > >> In the combination where host and guest has 64KB and 4KB separately, A 64KB
> > >> host page corresponds to 16x consecutive 4KB guest pages. It means we're
> > >> accessing the 64KB host page when any of those 16x consecutive 4KB guest pages
> > >> is accessed. In other words, a problematic 64KB host page affects the accesses
> > >> on 16x 4KB guest pages. Those 16x 4KB guest pages can be owned by different
> > >> threads on the guest and they run in parallel, potentially to access those
> > >> 16x 4KB guest pages in parallel. It potentially leading to 16x BUS_MCEERR_AR
> > >> signals at one point.
> > >>
> > >> In current implementation, the error record is built as the following calltrace
> > >> indicates. There are 16 error records in the extreme case (parallel accesses on
> > >> 16x 4KB guest pages, mapped to one 64KB host page). However, we can't handle
> > >> multiple error records at once due to the acknowledgement mechanism in
> > >> ghes_record_cper_errors(). For example, the first error record has been sent,
> > >> but not consumed by the guest yet. We fail to send the second error record.
> > >>
> > >> kvm_arch_on_sigbus_vcpu
> > >>     acpi_ghes_memory_errors
> > >>       ghes_gen_err_data_uncorrectable_recoverable      // Generic Error Data Entry
> > >>       acpi_ghes_build_append_mem_cper                  // Memory Error
> > >>       ghes_record_cper_errors
> > >>         
> > >> So this series improves this situation by simply sending 16x error records in
> > >> one shot for the combination of 64KB host + 4KB guest.    
> > > 
> > > 1) What I'm concerned about is that it target one specific case only.
> > > Imagine if 1st cpu get error on page1 and another on page2=(page1+host_page_size)
> > > and so on for other CPUs. Then we are back where we were before this series.
> > > 
> > > Also in abstract future when ARM gets 1Gb pages, that won't scale well.
> > > 
> > > Can we instead of making up CPERs to cover whole host page,
> > > create 1/vcpu GHES source?
> > > That way when vcpu trips over bad page, it would have its own
> > > error status block to put errors in.
> > > That would address [1] and deterministically scale
> > > (well assuming that multiple SEA error sources are possible in theory)
> > >     
> > 
> > I think it's a good idea to have individual error source for each vCPU. In this
> > way, the read_ack_reg won't be a limitation. I hope Jonathan is ok to this scheme.
> > 
> > Currently, we have two (fixed) error sources like below. I assume the index of
> > the error source per vCPU will starts from (ACPI_HEST_SRC_ID_QMP + 1) based on
> > CPUState::cpu_index.  
> 
> I'd suggest ditch cpu index and use arch_id instead.
> 
> > 
> > enum AcpiGhesSourceID {
> >      ACPI_HEST_SRC_ID_SYNC,
> >      ACPI_HEST_SRC_ID_QMP,       /* Use it only for QMP injected errors */
> > };
> > 
> >   
> > > PS:
> > > I also wonder what real HW does when it gets in similar situation
> > > (i.e. error status block is not yet acknowledged but another async
> > > error arrived for the same error source)?

On a real hardware platform it can just queue them in firmware or block until
the second CPU to arrive can proceed. Once first is processed the second is
then exposed.

The particular case seen here of a sudden burst of errors in memory due to
corruption of a larger range doesn't have an obvious equivalent as the CPER
record carries granularity and you don't have the problem of 16 contiguous
PA pages mapping to non contiguous GPA.

> > >     
> > 
> > I believe real HW also have this specific issue. As to ARM64, I ever did some
> > google search and was told the error follows the firmware-first policy and
> > handled by a component of trustfirmware-a. However, I was unable to get the
> > source code. So it's hard for me to know how this specific issue is handled
> > there.  

First thing is that I'd never make any assumptions about consistency of how this
handled on different arm arch platforms. The only consistency is at the ACPI / UEFI
spec level. Ours for example often have management controllers for RAS handling
that are completely independent of what is running on the CPUs (e.g. TFA).
All that actually matters though is there is considerable software involved in
marshalling this data and that marshalling is not always per PE.
 
We have far fewer GHESv2 entries than we have CPUs but there are multiple of them
with different types of error routed through particular subsets. I'm not sure of the
exact way that this is done but we don't share GHESv2 for fatal and non fatal for
instance.  The kernel doesn't care what comes down each pipe so I've never looked
at it closely.

> 
> Perhaps Jonathan can help with finding how real hw works around it?
> 
> My idea using per cpu source is just a speculation based on spec
> on how workaround the problem,
> I don't really know if guest OS will be able to handle it (aka,
> need to be tested is it's viable). That also probably was a reason
> in previous review, why should've waited for multiple sources
> support be be merged first before this series.

Per vCPU should work fine but I do like the approach here of reporting
all the related errors in one go as they represent the underlying nature
of the error granularity tracking. If anyone ever poisons at the 1GiB level
on the host they are on their own - so I think that it will only ever be
the finest granularity supported (so worse case 64KiB).

Jonathan

> 
>  
> > Thanks,
> > Gavin
> >   
> > >>>> Imporve push_ghes_memory_errors() to push 16x consecutive memory CPERs
> > >>>> for this specific case. The maximal error block size is bumped to 4KB,
> > >>>> providing enough storage space for those 16x memory CPERs.
> > >>>>
> > >>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> > >>>> ---
> > >>>>    hw/acpi/ghes.c   |  2 +-
> > >>>>    target/arm/kvm.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
> > >>>>    2 files changed, 46 insertions(+), 2 deletions(-)
> > >>>>
> > >>>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > >>>> index 045b77715f..5c87b3a027 100644
> > >>>> --- a/hw/acpi/ghes.c
> > >>>> +++ b/hw/acpi/ghes.c
> > >>>> @@ -33,7 +33,7 @@
> > >>>>    #define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
> > >>>>    
> > >>>>    /* The max size in bytes for one error block */
> > >>>> -#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> > >>>> +#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (4 * KiB)
> > >>>>    
> > >>>>    /* Generic Hardware Error Source version 2 */
> > >>>>    #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
> > >>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > >>>> index c5d5b3b16e..3ecb85e4b7 100644
> > >>>> --- a/target/arm/kvm.c
> > >>>> +++ b/target/arm/kvm.c
> > >>>> @@ -11,6 +11,7 @@
> > >>>>     */
> > >>>>    
> > >>>>    #include "qemu/osdep.h"
> > >>>> +#include "qemu/units.h"
> > >>>>    #include <sys/ioctl.h>
> > >>>>    
> > >>>>    #include <linux/kvm.h>
> > >>>> @@ -2433,10 +2434,53 @@ static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
> > >>>>                                        uint64_t paddr)
> > >>>>    {
> > >>>>        GArray *addresses = g_array_new(false, false, sizeof(paddr));
> > >>>> +    uint64_t val, start, end, guest_pgsz, host_pgsz;
> > >>>>        int ret;
> > >>>>    
> > >>>>        kvm_cpu_synchronize_state(c);
> > >>>> -    g_array_append_vals(addresses, &paddr, 1);
> > >>>> +
> > >>>> +    /*
> > >>>> +     * Sort out the guest page size from TCR_EL1, which can be modified
> > >>>> +     * by the guest from time to time. So we have to sort it out dynamically.
> > >>>> +     */
> > >>>> +    ret = read_sys_reg64(c->kvm_fd, &val, ARM64_SYS_REG(3, 0, 2, 0, 2));
> > >>>> +    if (ret) {
> > >>>> +        goto error;
> > >>>> +    }
> > >>>> +
> > >>>> +    switch (extract64(val, 14, 2)) {
> > >>>> +    case 0:
> > >>>> +        guest_pgsz = 4 * KiB;
> > >>>> +        break;
> > >>>> +    case 1:
> > >>>> +        guest_pgsz = 64 * KiB;
> > >>>> +        break;
> > >>>> +    case 2:
> > >>>> +        guest_pgsz = 16 * KiB;
> > >>>> +        break;
> > >>>> +    default:
> > >>>> +        error_report("unknown page size from TCR_EL1 (0x%" PRIx64 ")", val);
> > >>>> +        goto error;
> > >>>> +    }
> > >>>> +
> > >>>> +    host_pgsz = qemu_real_host_page_size();
> > >>>> +    start = paddr & ~(host_pgsz - 1);
> > >>>> +    end = start + host_pgsz;
> > >>>> +    while (start < end) {
> > >>>> +        /*
> > >>>> +         * The precise physical address is provided for the affected
> > >>>> +         * guest page that contains @paddr. Otherwise, the starting
> > >>>> +         * address of the guest page is provided.
> > >>>> +         */
> > >>>> +        if (paddr >= start && paddr < (start + guest_pgsz)) {
> > >>>> +            g_array_append_vals(addresses, &paddr, 1);
> > >>>> +        } else {
> > >>>> +            g_array_append_vals(addresses, &start, 1);
> > >>>> +        }
> > >>>> +
> > >>>> +        start += guest_pgsz;
> > >>>> +    }
> > >>>> +
> > >>>>        ret = acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses);
> > >>>>        if (ret) {
> > >>>>            goto error;    
> > >>>        
> > >>    
> > >     
> >   
> 
> 


