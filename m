Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCF6CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 07:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGusa-0007WR-94; Thu, 06 Nov 2025 02:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vGusY-0007VY-Kg
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 02:57:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vGusW-0001QN-Ga
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 02:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762415874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnqGOoBBs6TE2c0mh+SOxY2RQrVewAJeKPAP2OzNiO4=;
 b=ir1nvn/3w0F8PuAkQOo+Rf6jxcQa2E8aNRa3ZQirYWa2wDGE8mxDeD3F6O1qtimAhIT1cq
 9Jf78Ws6F6mFVO/5kHUFRDTbdmF4WRD29QI+cBbZIMGZmbVyNp/jJA9NlUAFooXXRKgfi4
 49EfQU7OwZJv5K4MkWuYZd4VNiF4TKY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-tzw8tJckO4mRzWMt6zLdug-1; Thu, 06 Nov 2025 02:57:52 -0500
X-MC-Unique: tzw8tJckO4mRzWMt6zLdug-1
X-Mimecast-MFC-AGG-ID: tzw8tJckO4mRzWMt6zLdug_1762415872
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso7544615e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 23:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762415871; x=1763020671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnqGOoBBs6TE2c0mh+SOxY2RQrVewAJeKPAP2OzNiO4=;
 b=iTwwGt/ypC6Un5RkDXFB1YoDSAqiTEsmemihTGcnJFw1XQt9S2W3yybi+R52FMb+Rf
 zC1y+W0SU0K6qq71gPsyQcJ51ASQJpXFtzxdavBVxhUmvLt/ydFPGytMvc5aguUb79sV
 3YyIHaxeoAilGrmJcsHfrfAHm0TULT4xoOItFp+GS2rglLE0krMkr3LGxd0I475guX+T
 XYjLDvL+8E8BAnsd05GFgLze+bQjYJRlmar+BCaxqrlMESeb49BlNqTS+EONxjBvnC7B
 pizu+cbCCuVmbO0jLtKX1lzY+LPB63wqKy7HBU+sCBBosndt3TuPzFeRtdzCUA7o8YXy
 Mntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762415871; x=1763020671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QnqGOoBBs6TE2c0mh+SOxY2RQrVewAJeKPAP2OzNiO4=;
 b=sn1Rd3uVIgrqoNSH395N52KSF5niH6cJFtcs3X6rwN7eVKl2WbnEVncWtdfaYIeC06
 zNvLEzK1Wd1h/9slGN03LL/g/No23SGIhmo2Hy5D6mlGRtOJ5CvAzYp/cQeEW/tamq7c
 gxc6Y+B0VsKwf6RK3zq+X8qu2oPiSRvRwvIDcnyMDPV26O71zdBHPHUoMdm4z/RhhrHv
 h8ZfZO826ohEVsl3lecElX12Ur/uJc5TH1bSxpwMDztItCpLo6NU6gD29LgY4Z6VovJE
 ByrtIp1Gpy24+AEzFKsEIRrPIFS9QTVduVHQ/cgMw7qrVKM7O8kr1Hdoie117Jicmjct
 3Gww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjtnyxYgoJ7RUTDm2osaSa6zN1o5rIOdRMRnIHtEaz65w0xekBYdw9LhGC/Qe3EnP7Zk14FLHrxQ3G@nongnu.org
X-Gm-Message-State: AOJu0Yz5aon1JpxwZODuC7q9ueXFwTBwEbmgL+559C8ksWayYqy7l73f
 E/BC7GVf+3xdwSPRjZcGAb0FZh+Nr53Kb7ZnZGGatIommue3bwAF+mS5+qY769VMj+Rf8M2Oh2L
 r/sYqmTkdtWVhxZEOxlV0yH7ogHrMu4atgZgMXW0YK/QEds4FZUROqVE/
X-Gm-Gg: ASbGncuKo9bXN9Fj9Nl8mJgVkv0dFYt9R2JemRXUZ9NpaNPBxtTkzu8JWSj07GZ9oAP
 sWL7jwocSwdxslCIeJRZccoWSbON1w/wF0aussC49IZHuwiKsC5hI1JaNzJ+yC3mXP0SWS8qZDq
 pg3vLDVdv44ihHKtOZLejZlQqO53QLqPnNUkjnKmxp+NuUE89YmjZDWeR13I7vnnxAXS8n/3Bp7
 DaSw4NsTvDkro+pslfcRWoyNoWE46mtPu17rL0TAwHkv61ORANKZKmbvemuxcJShfrIUhZD1uxd
 Yqw7N8VVW/8VZh6o1pw8SeVCMFnkMK/9nbfTyJJ6SE3EKbke0/aIHXFi9P4Iq/671Q==
X-Received: by 2002:a05:600c:46ce:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-4775cdc9053mr55585645e9.17.1762415871425; 
 Wed, 05 Nov 2025 23:57:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXVz6gtrcVTjVrzHeAZ+4ijzRBvSi8AV++A8EAVgdMQjL4T+CQu+M97yyqqUXJAM0nxyPpvA==
X-Received: by 2002:a05:600c:46ce:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-4775cdc9053mr55585435e9.17.1762415870942; 
 Wed, 05 Nov 2025 23:57:50 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb4ad537sm3384567f8f.42.2025.11.05.23.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 23:57:50 -0800 (PST)
Date: Thu, 6 Nov 2025 08:57:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, mchehab+huawei@kernel.org,
 Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: Re: [PATCH RESEND v2 3/3] target/arm/kvm: Support multiple memory
 CPERs injection
Message-ID: <20251106085748.2e5f6681@fedora>
In-Reply-To: <1cde8845-d72f-494f-b7b2-3d7329a7d1c0@redhat.com>
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-4-gshan@redhat.com>
 <20251017162746.2a99015b@fedora>
 <a635de53-71fa-4edb-87c0-8775722c284d@redhat.com>
 <20251031145539.3551b0a5@fedora>
 <88a41137-d5fb-4b61-a3f2-dd73133c17ec@redhat.com>
 <20251103105216.1f4241d7@fedora>
 <1cde8845-d72f-494f-b7b2-3d7329a7d1c0@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 4 Nov 2025 09:51:42 +1000
Gavin Shan <gshan@redhat.com> wrote:

> On 11/3/25 7:52 PM, Igor Mammedov wrote:
> > On Mon, 3 Nov 2025 09:02:54 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >   
> >> On 10/31/25 11:55 PM, Igor Mammedov wrote:  
> >>> On Sun, 19 Oct 2025 10:36:16 +1000
> >>> Gavin Shan <gshan@redhat.com> wrote:  
> >>>> On 10/18/25 12:27 AM, Igor Mammedov wrote:  
> >>>>> On Tue,  7 Oct 2025 16:08:10 +1000
> >>>>> Gavin Shan <gshan@redhat.com> wrote:
> >>>>>         
> >>>>>> In the combination of 64KB host and 4KB guest, a problematic host page
> >>>>>> affects 16x guest pages. In this specific case, it's reasonable to
> >>>>>> push 16 consecutive memory CPERs. Otherwise, QEMU can run into core
> >>>>>> dump due to the current error can't be delivered as the previous error
> >>>>>> isn't acknoledges. It's caused by the nature the host page can be
> >>>>>> accessed in parallel due to the mismatched host and guest page sizes.  
> >>>>>
> >>>>> can you explain a bit more what goes wrong?
> >>>>>
> >>>>> I'm especially interested in parallel access you've mentioned
> >>>>> and why batch adding error records is needed
> >>>>> as opposed to adding records every time invalid access happens?
> >>>>>
> >>>>> PS:
> >>>>> Assume I don't remember details on how HEST works,
> >>>>> Answering it in this format also should improve commit message
> >>>>> making it more digestible for uninitiated.
> >>>>>         
> >>>>
> >>>> Thanks for your review and I'm trying to answer your question below. Please let
> >>>> me know if there are more questions.
> >>>>
> >>>> There are two signals (BUS_MCEERR_AR and BUS_MCEERR_AO) and BUS_MCEERR_AR is
> >>>> concerned here. This signal BUS_MCEERR_AR is sent by host's stage2 page fault
> >>>> handler when the resolved host page has been marked as marked as poisoned.
> >>>> The stage2 page fault handler is invoked on every access to the host page.
> >>>>
> >>>> In the combination where host and guest has 64KB and 4KB separately, A 64KB
> >>>> host page corresponds to 16x consecutive 4KB guest pages. It means we're
> >>>> accessing the 64KB host page when any of those 16x consecutive 4KB guest pages
> >>>> is accessed. In other words, a problematic 64KB host page affects the accesses
> >>>> on 16x 4KB guest pages. Those 16x 4KB guest pages can be owned by different
> >>>> threads on the guest and they run in parallel, potentially to access those
> >>>> 16x 4KB guest pages in parallel. It potentially leading to 16x BUS_MCEERR_AR
> >>>> signals at one point.
> >>>>
> >>>> In current implementation, the error record is built as the following calltrace
> >>>> indicates. There are 16 error records in the extreme case (parallel accesses on
> >>>> 16x 4KB guest pages, mapped to one 64KB host page). However, we can't handle
> >>>> multiple error records at once due to the acknowledgement mechanism in
> >>>> ghes_record_cper_errors(). For example, the first error record has been sent,
> >>>> but not consumed by the guest yet. We fail to send the second error record.
> >>>>
> >>>> kvm_arch_on_sigbus_vcpu
> >>>>      acpi_ghes_memory_errors
> >>>>        ghes_gen_err_data_uncorrectable_recoverable      // Generic Error Data Entry
> >>>>        acpi_ghes_build_append_mem_cper                  // Memory Error
> >>>>        ghes_record_cper_errors
> >>>>          
> >>>> So this series improves this situation by simply sending 16x error records in
> >>>> one shot for the combination of 64KB host + 4KB guest.  
> >>>
> >>> 1) What I'm concerned about is that it target one specific case only.
> >>> Imagine if 1st cpu get error on page1 and another on page2=(page1+host_page_size)
> >>> and so on for other CPUs. Then we are back where we were before this series.
> >>>
> >>> Also in abstract future when ARM gets 1Gb pages, that won't scale well.
> >>>
> >>> Can we instead of making up CPERs to cover whole host page,
> >>> create 1/vcpu GHES source?
> >>> That way when vcpu trips over bad page, it would have its own
> >>> error status block to put errors in.
> >>> That would address [1] and deterministically scale
> >>> (well assuming that multiple SEA error sources are possible in theory)
> >>>      
> >>
> >> I think it's a good idea to have individual error source for each vCPU. In this
> >> way, the read_ack_reg won't be a limitation. I hope Jonathan is ok to this scheme.
> >>
> >> Currently, we have two (fixed) error sources like below. I assume the index of
> >> the error source per vCPU will starts from (ACPI_HEST_SRC_ID_QMP + 1) based on
> >> CPUState::cpu_index.  
> > 
> > I'd suggest ditch cpu index and use arch_id instead.
> >   
> 
> arch_id, which is returned from CPUClass::get_arch_id(), is uint64_t. The error
> source index is uint16_t, as defined in ACPI spec 6.5 (section 18.3.2.7 Generic
> Hardware Error Source). So I think CPUState::cpu_index is the appropriate error
> source index.

while for ARM cpu_index might work, it's not stable on targets where CPU hotplug
exists. Given it's generic ACPI code, It would be better to take this consideration
into account.

(aka make a map of arch_id to src_id if necessary)

> 
> >>
> >> enum AcpiGhesSourceID {
> >>       ACPI_HEST_SRC_ID_SYNC,
> >>       ACPI_HEST_SRC_ID_QMP,       /* Use it only for QMP injected errors */
> >> };
> >>
> >>  
> >>> PS:
> >>> I also wonder what real HW does when it gets in similar situation
> >>> (i.e. error status block is not yet acknowledged but another async
> >>> error arrived for the same error source)?
> >>>      
> >>
> >> I believe real HW also have this specific issue. As to ARM64, I ever did some
> >> google search and was told the error follows the firmware-first policy and
> >> handled by a component of trustfirmware-a. However, I was unable to get the
> >> source code. So it's hard for me to know how this specific issue is handled
> >> there.  
> > 
> > Perhaps Jonathan can help with finding how real hw works around it?
> > 
> > My idea using per cpu source is just a speculation based on spec
> > on how workaround the problem,
> > I don't really know if guest OS will be able to handle it (aka,
> > need to be tested is it's viable). That also probably was a reason
> > in previous review, why should've waited for multiple sources
> > support be be merged first before this series.
> >   
> 
> Well, the point is the guest won't be full functional until the the problematic
> host page is isolated and replaced by another host page. To avoid crash the qemu
> still gives customer a chance to collect important information from the guest
> by luck.
> 
> Thanks,
> Gavin
> 
> 
> >>  
> >>>>>> Imporve push_ghes_memory_errors() to push 16x consecutive memory CPERs
> >>>>>> for this specific case. The maximal error block size is bumped to 4KB,
> >>>>>> providing enough storage space for those 16x memory CPERs.
> >>>>>>
> >>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >>>>>> ---
> >>>>>>     hw/acpi/ghes.c   |  2 +-
> >>>>>>     target/arm/kvm.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
> >>>>>>     2 files changed, 46 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> >>>>>> index 045b77715f..5c87b3a027 100644
> >>>>>> --- a/hw/acpi/ghes.c
> >>>>>> +++ b/hw/acpi/ghes.c
> >>>>>> @@ -33,7 +33,7 @@
> >>>>>>     #define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
> >>>>>>     
> >>>>>>     /* The max size in bytes for one error block */
> >>>>>> -#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> >>>>>> +#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (4 * KiB)
> >>>>>>     
> >>>>>>     /* Generic Hardware Error Source version 2 */
> >>>>>>     #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
> >>>>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> >>>>>> index c5d5b3b16e..3ecb85e4b7 100644
> >>>>>> --- a/target/arm/kvm.c
> >>>>>> +++ b/target/arm/kvm.c
> >>>>>> @@ -11,6 +11,7 @@
> >>>>>>      */
> >>>>>>     
> >>>>>>     #include "qemu/osdep.h"
> >>>>>> +#include "qemu/units.h"
> >>>>>>     #include <sys/ioctl.h>
> >>>>>>     
> >>>>>>     #include <linux/kvm.h>
> >>>>>> @@ -2433,10 +2434,53 @@ static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
> >>>>>>                                         uint64_t paddr)
> >>>>>>     {
> >>>>>>         GArray *addresses = g_array_new(false, false, sizeof(paddr));
> >>>>>> +    uint64_t val, start, end, guest_pgsz, host_pgsz;
> >>>>>>         int ret;
> >>>>>>     
> >>>>>>         kvm_cpu_synchronize_state(c);
> >>>>>> -    g_array_append_vals(addresses, &paddr, 1);
> >>>>>> +
> >>>>>> +    /*
> >>>>>> +     * Sort out the guest page size from TCR_EL1, which can be modified
> >>>>>> +     * by the guest from time to time. So we have to sort it out dynamically.
> >>>>>> +     */
> >>>>>> +    ret = read_sys_reg64(c->kvm_fd, &val, ARM64_SYS_REG(3, 0, 2, 0, 2));
> >>>>>> +    if (ret) {
> >>>>>> +        goto error;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    switch (extract64(val, 14, 2)) {
> >>>>>> +    case 0:
> >>>>>> +        guest_pgsz = 4 * KiB;
> >>>>>> +        break;
> >>>>>> +    case 1:
> >>>>>> +        guest_pgsz = 64 * KiB;
> >>>>>> +        break;
> >>>>>> +    case 2:
> >>>>>> +        guest_pgsz = 16 * KiB;
> >>>>>> +        break;
> >>>>>> +    default:
> >>>>>> +        error_report("unknown page size from TCR_EL1 (0x%" PRIx64 ")", val);
> >>>>>> +        goto error;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    host_pgsz = qemu_real_host_page_size();
> >>>>>> +    start = paddr & ~(host_pgsz - 1);
> >>>>>> +    end = start + host_pgsz;
> >>>>>> +    while (start < end) {
> >>>>>> +        /*
> >>>>>> +         * The precise physical address is provided for the affected
> >>>>>> +         * guest page that contains @paddr. Otherwise, the starting
> >>>>>> +         * address of the guest page is provided.
> >>>>>> +         */
> >>>>>> +        if (paddr >= start && paddr < (start + guest_pgsz)) {
> >>>>>> +            g_array_append_vals(addresses, &paddr, 1);
> >>>>>> +        } else {
> >>>>>> +            g_array_append_vals(addresses, &start, 1);
> >>>>>> +        }
> >>>>>> +
> >>>>>> +        start += guest_pgsz;
> >>>>>> +    }
> >>>>>> +
> >>>>>>         ret = acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses);
> >>>>>>         if (ret) {
> >>>>>>             goto error;  
> >>>>>         
> >>>>     
> >>>      
> >>  
> >   
> 


