Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7118CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJAoX-0000GP-Vf; Wed, 12 Nov 2025 08:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vJAeA-0002PP-MR
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:12:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vJAdt-00040Y-GH
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762953128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqMdb/I2BFn4AosMOWm8zsvTL9oex8k0WENWcYzWA0Q=;
 b=JXpKyHXys5bJGdvv61jUMiUtvztZh6PRqZtWEPw7Y7o4SH8D7EMj5LUqcLPvRDSMTplR33
 euLiaL1IQjOaxLVnw9UUjeIsVW6WWvfY17yIJW4EoTeARdMDh8X1TUp7GrKVYI+TfDWkG0
 h6O3no06DF3t4Z6f1Vwhcd5cqmQaItA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-fLcBpCtENC-m6s8f746DAg-1; Wed, 12 Nov 2025 08:12:07 -0500
X-MC-Unique: fLcBpCtENC-m6s8f746DAg-1
X-Mimecast-MFC-AGG-ID: fLcBpCtENC-m6s8f746DAg_1762953126
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47788165c97so5093935e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762953126; x=1763557926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqMdb/I2BFn4AosMOWm8zsvTL9oex8k0WENWcYzWA0Q=;
 b=rywIWM50kJlcljfaYhVVYqtTmsjdVR6GeXccnvSVWDyve+N3F0eT+TwPTEwg1I3k5E
 Zc7aJap24OkL4TaAhMFByf5N+XDENffH9IyQJ43wsat07waz/0iDplvlzLW9YfUe+61K
 GP22+B38isI4AwRyOkr2njj8eTzbf0YW9pe4HtMWTeD9CO/HNGJ2Ud4xHtCemnT2bOqx
 lzSXbvkcvMbbmXbF7vU3iG+sHsWSy91JF5NCKHle7Dp8+9+0ca9gsaBHW3MPPAMlPMm1
 RNSj9/lBAVfi4mxLbWs9DXde2Y009lEo4IqNVTUT/tQ1Ov6EZB8Jb3I451QEe2cMBMD/
 fE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762953126; x=1763557926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XqMdb/I2BFn4AosMOWm8zsvTL9oex8k0WENWcYzWA0Q=;
 b=Rftu5HggCCtbLYkhzmz4SeqIIBZZk2hWR0830rK4mDZYu0jf3f9PEpQtOAdbbcjyz4
 nK85njFhijiPdDqnExtjs7tLNx8VstU5kYdv9LRK6N3/WIME4Fazs6eJCvxJ/gHT1NjO
 fKS80qEfVnFWFVxQfJqhF5oaulkEj9cGRKSrShXxD5cWZZICv9wMmwe+WTV36q096Dr5
 MHkzbnGW4HhYmjG8L0kXrg7epCYI4jCJdDJpXH8C66T8BHCKsamX8Ox0J00D/mAVYQyR
 hbL0BtIoQZI7/0NFeTP2HT2b0bbCywWvyLBscCwgzouSuW076RaNhjCdmVgsM9YiqczJ
 rJqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGMq1RbYN70qsalMa8QoGKF0K2EE4l0jfFrdLpAaaQ4ZI4rUzJ295tk0TZ2A0cHw+zdkEO3sCgyovs@nongnu.org
X-Gm-Message-State: AOJu0Yzu56J5N/vcyFPcLEdk4u2eB2ifGMB3wfHzB5aapMVm2rrkuLW1
 fZQ70aEOpriTCNK4K4M9XVvnQn+1v1mRpllIY9u8UZTfHd/w6a22ZIDPy7clBr77Qm+IJuHLb5X
 JFr1h97VnwhVfVYyob52WbE9ODjddXERPNQElJBhGqjMJ+X2NKDjVPCVZ
X-Gm-Gg: ASbGncvFgVDfBhY8xMQxIcT8C09OoOGR9IJjiFWq4/Msixq6qNkbTuNieZGtIDgzdZy
 ziIIasyWXIP+Ncg8Od9HE4cnQrwEwOdmEd47qYA7dRoBWKpF95wwja/EBvLFmVSKitMd5FNtQWE
 HHoth1JTtZBuPjlC7T8duUI6gnPaKj/v8aW3QjjLbnxEYLCmZBRjgEAuKsWut657pvaQ43v9a9h
 N/Qy5mLUcmCA7231rXLNrjpveuxV6QeBu1RJ2+sASb24+a5Rnqx8UGO6Zl/+Ln8CKs8gY+8HI/g
 BWPHtDHzq5LAVGMKdH4/zo7hwL7F7FLlSq0Qi5/nRsu0uUS7YrN4+PS0ZMqumfvQtQ==
X-Received: by 2002:a05:600c:4f8f:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-477870a6e5fmr30834205e9.32.1762953125768; 
 Wed, 12 Nov 2025 05:12:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcDW44KLT7kFwITiECQtO7x4WCjTUei14UBJUpvsCg5UH2FgOa1qJS4nAMPrjG0GBPtQ6dbA==
X-Received: by 2002:a05:600c:4f8f:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-477870a6e5fmr30833915e9.32.1762953125270; 
 Wed, 12 Nov 2025 05:12:05 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e3a62esm35819575e9.3.2025.11.12.05.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 05:12:04 -0800 (PST)
Date: Wed, 12 Nov 2025 14:12:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH v3 4/8] acpi/ghes: Extend acpi_ghes_memory_errors() to
 support multiple CPERs
Message-ID: <20251112141203.7d663088@fedora>
In-Reply-To: <659b0d40-6b06-42a8-ba7d-73dd2dcdf0f0@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-5-gshan@redhat.com>
 <20251110153801.258be29d@fedora>
 <659b0d40-6b06-42a8-ba7d-73dd2dcdf0f0@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, 11 Nov 2025 14:40:42 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Igor,
> 
> On 11/11/25 12:38 AM, Igor Mammedov wrote:
> > On Wed,  5 Nov 2025 21:44:49 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >   
> >> In the situation where host and guest has 64KiB and 4KiB page sizes,
> >> one problematic host page affects 16 guest pages. we need to send 16
> >> consective errors in this specific case.  
> > 
> > I still don't like it, since it won't fix anything in case of more than
> > 1 broken host pages. (in v2 discussion quickly went hugepages route
> > and futility of recovering from them).
> > 
> > If having per vCPU source is not desirable,
> > can we stall all other vcpus that touch poisoned pages until
> > error is acked by guest and then let another VCPU to queue its own error?
> >   
> 
> We're trying to avoid the guest from suddenly disappearing due to the QEMU
> crash, instead of recovering from the memory errors. To keep the guest
> accessible, system administrators still get a chance to collect important
> information from the guest.
> 
> The idea of stalling the vCPU which is accessing any poisoned pages and
> retry on delivering the error was proposed in v1, but was rejected.
> 
> https://lists.nongnu.org/archive/html/qemu-arm/2025-02/msg01071.html

that depends on what outcome we do wish for.
Described deadlock might be even desired vs QEMU abort() as it lets
guest admin to collect VM crash dump.

But honestly I'd go with per/vCPU approach if it's possible,
as that still get guest side chance to recover.


> As the intention of this series is just to improve the memory error
> reporting, to avoid QEMU crash if possible, it sounds reasonable to send
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
that,
this series doesn't do that as it would still crash QEMU if another
vCPU faults on another faulty host page (i.e. not the one we've generated CPERs)

You also mentioned in previous review that with per vCPU error source
variant that QEMU would abort elsewhere (is it fixable?).

> 16x consecutive CPERs in one shot for this specific case (4KB guest on
> 64KB host).

I don't object to generating 16x CPERs per fault as that obviously
should reduce # of guest exits. 



Given it's rather late in release cycle,
we probably can handle 1 page case 1st as in this series,
with followup series to switch to per/vCPU variant once new merge
window opens (assuming I can coax a promise from you to follow up on that).

>As to hugetlb cases, it's different story. If the hugetlb
> folio (page) size is small enough (like 64KB), we can leverage current
> design to send consecutive CPERs. I don't think there are too much we
> can do if hugetlb folio size is large enough (from 2MB to 16GB).
> 
> >   
> >> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
> >> hunk of code to generate the GHES error status is pulled out from
> >> ghes_gen_err_data_uncorrectable_recoverable(). The status field of
> >> generic error status block is also updated accordingly if multiple
> >> error data entries are contained in the generic error status block.  
> > 
> > I don't mind much translating 64K page error into several 4K CPER
> > records, so this part is fine. But it's hardly a solution to the generic
> > problem.
> >   
> 
> Note that I don't expect a memory error storm from the hardware level.
> In that case, it's a good sign indicating the memory DIMM has been totally
> broken and needs a replacement :-)
> 
> >>
> >> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >> ---
> >>   hw/acpi/ghes-stub.c    |  2 +-
> >>   hw/acpi/ghes.c         | 60 +++++++++++++++++++++++-------------------
> >>   include/hw/acpi/ghes.h |  2 +-
> >>   target/arm/kvm.c       |  4 ++-
> >>   4 files changed, 38 insertions(+), 30 deletions(-)
> >>  
> > ...  
> >> @@ -577,10 +568,25 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> >>       assert((data_length + ACPI_GHES_GESB_SIZE) <=
> >>               ACPI_GHES_MAX_RAW_DATA_LENGTH);
> >>   
> >> -    ghes_gen_err_data_uncorrectable_recoverable(block, guid, data_length);
> >> +    /* Build the new generic error status block header */
> >> +    block_status = (1 << ACPI_GEBS_UNCORRECTABLE) |
> >> +                   (num_of_addresses << ACPI_GEBS_ERROR_DATA_ENTRIES);  
> >                         ^^^^^^^^^^^^^^
> > maybe assert in case it won't fit into bit field
> >   
> 
> Yep, Same thing was suggested by Philippe.
> 
> >> +    if (num_of_addresses > 1) {
> >> +        block_status |= ACPI_GEBS_MULTIPLE_UNCORRECTABLE;
> >> +    }
> >> +
> >> +    acpi_ghes_generic_error_status(block, block_status, 0, 0,
> >> +                                   data_length, ACPI_CPER_SEV_RECOVERABLE);
> >>   
> >> -    /* Build the memory section CPER for above new generic error data entry */
> >> -    acpi_ghes_build_append_mem_cper(block, physical_address);
> >> +    for (i = 0; i < num_of_addresses; i++) {
> >> +        /* Build generic error data entries */
> >> +        acpi_ghes_generic_error_data(block, guid,
> >> +                                     ACPI_CPER_SEV_RECOVERABLE, 0, 0,
> >> +                                     ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
> >> +
> >> +        /* Memory section CPER on top of the generic error data entry */
> >> +        acpi_ghes_build_append_mem_cper(block, addresses[i]);
> >> +    }
> >>   
> >>       /* Report the error */
> >>       ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
> >> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> >> index df2ecbf6e4..f73908985d 100644
> >> --- a/include/hw/acpi/ghes.h
> >> +++ b/include/hw/acpi/ghes.h
> >> @@ -99,7 +99,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> >>   void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
> >>                             GArray *hardware_errors);
> >>   int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> >> -                            uint64_t error_physical_addr);
> >> +                            uint64_t *addresses, uint32_t num_of_addresses);
> >>   void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
> >>                                uint16_t source_id, Error **errp);
> >>   
> >> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> >> index 0d57081e69..459ca4a9b0 100644
> >> --- a/target/arm/kvm.c
> >> +++ b/target/arm/kvm.c
> >> @@ -2434,6 +2434,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> >>       ram_addr_t ram_addr;
> >>       hwaddr paddr;
> >>       AcpiGhesState *ags;
> >> +    uint64_t addresses[16];
> >>   
> >>       assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
> >>   
> >> @@ -2454,10 +2455,11 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> >>                * later from the main thread, so doing the injection of
> >>                * the error would be more complicated.
> >>                */
> >> +            addresses[0] = paddr;
> >>               if (code == BUS_MCEERR_AR) {
> >>                   kvm_cpu_synchronize_state(c);
> >>                   if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> >> -                                             paddr)) {
> >> +                                             addresses, 1)) {
> >>                       kvm_inject_arm_sea(c);
> >>                   } else {
> >>                       error_report("failed to record the error");  
> >   
> 
> Thanks,
> Gavin
> 


