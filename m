Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9617CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 05:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHElv-0001Xl-0h; Fri, 07 Nov 2025 00:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vHElr-0001XP-3w
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 00:12:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vHElk-0004OL-Gr
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 00:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762492329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gxwjj+rCfDJwE/Na8JEwJJ2iSoX2xKyBJCOcH2ki+Y=;
 b=bw4R79sQBYHrvbD3I+fFNZqkvV+nG8wibgze4Uhcd+ByvtdQX8DE56Xeo33972bSTqW9VX
 WgK0wblkZA5wPlyhin1fbHEB6hrTgjOEXNTyuOsSICnnZGJLL0gBW678CqVQRd5ytCQ2s0
 Io+C8zkiDmHJ8alMUsD+o8gOpxi6cTg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-A8ZKPTG7Ofaqb6-9xWA8TA-1; Fri, 07 Nov 2025 00:12:07 -0500
X-MC-Unique: A8ZKPTG7Ofaqb6-9xWA8TA-1
X-Mimecast-MFC-AGG-ID: A8ZKPTG7Ofaqb6-9xWA8TA_1762492327
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7ae220b9d18so359978b3a.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 21:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762492326; x=1763097126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1gxwjj+rCfDJwE/Na8JEwJJ2iSoX2xKyBJCOcH2ki+Y=;
 b=WgEwfaC4JQKP2fH5M1T5g5KaII6UpUAY9saU3SU5IeGH/+Xc2PhfCPKds5w5FEhsmP
 WUK+DwoX1tS0+IpUh/vPDStbmI7SDWSQ41IsFq2SGUAIoa1nuacot96f+HUhSkIlDj4o
 6lmUq940IlUQRhIkVV8LhWd/S104gsi2C7yFJBeDLrAofg4sxg34kEkoGXIA3vCWWXDO
 2ZIfoPwlHKiN7afywk7mzIXv0FEpzrr6a5QUHXIPHoQwZV0qeV0jm8yRETLa7OdDL0UZ
 u6EWf2xcinm7aPQOMMDBnVFD8GyoTket9mC2rLgwluG6MglFiyDX+MD52nJDeSNuN4ts
 LLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762492326; x=1763097126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1gxwjj+rCfDJwE/Na8JEwJJ2iSoX2xKyBJCOcH2ki+Y=;
 b=lHPPjIroiPsBNWtWf+c+cL2iKwT6JACGus4QAlpx1v04V19Ff5ShS1QsDyfHpzxDVt
 BXiDfMtpfmKMgnvk9chwU3RenA21HxZavodyG+t9RGV4Tcy58HjFe6UIrVuQiVYKajLX
 Gp23r1s/I5YQsY85kzhTgpKjY06GkQjgISj9Ib973uypx9COZlcXgvXiCng2t0iN7q/J
 W0pAq+rzi9rubQIbCCmf4ZzQttZ93eJyuxQGFvoPkcaAup+/XqNtjPOfYMh2boVClqLI
 iZsW9/ze9zt+yf+zutrYmvFvcYSIv4cHkAVqUuehC6eGqUYAgAK98U+kQEXxmopLPUZU
 64fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSkMHAx2emqg8vefZnSit0YGsIY5FBalleGu6/ykzX1UlyCFh0TP7bKUpvDptpcVQNeKV0g7X37HFM@nongnu.org
X-Gm-Message-State: AOJu0Yw9+1JacvMbuAk+CYoU3nPK54dK5VwWg6zbd3SxrR6SlpD3HqqM
 jrg3yNwaDQCp0dI87bTUW1984cqFjV45o+kZfBVmiGotUvRtG2BtTHI7QriRa16WjcQAVNLoLvc
 iX3PbJZXImN+IQV1qOIPMOMQ1MMknldi2YrveZ4wHMZVpkUN1EMH1BI6U
X-Gm-Gg: ASbGncudfCkQ+Ak74sDGBTSvoUCc/2lyM4kA4zQc+dRyPqtDhKmtcAu3A/DPta+y0tf
 ng5qbvPHghSMgDe3Pfp6827e+e/rJarDD2+DsGu2LiBdVzJA2I/CjxtnnfZstkHF82cgXGMxmnS
 W/w3b/g5p0nSJA2/UJ5fmt93O/n5eF0qCzgz0Zz+Rc1ki/exUCrf5nZwbUGLeybntkINdJPofF5
 2KLdyMfn/449V/MIyROnw5Qdb0itWa4yV2vJPW6vOt3khyBpInfmnib2V0xnHLzK8n5jMkKm/2a
 09oarPt6e3Ti8Cw6mLhHTvjcclEDJneBz0PNEUGu2zDUETic5WrIJTFAmyKen4/rvP6fhc1H0B5
 bMLdIzljBcknucNrqHJvfTNu4vapfSEXhxxnM/PY=
X-Received: by 2002:a05:6a00:1813:b0:7a5:67cc:c837 with SMTP id
 d2e1a72fcca58-7b0bd3b193fmr2978693b3a.18.1762492326519; 
 Thu, 06 Nov 2025 21:12:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs3Cs9cSQe0RCC3MTrGxYF3FseyA8JTwFyfI+QnEfrmR2N7Dk4Y6H7KJLtvl/bfubdsvlpUw==
X-Received: by 2002:a05:6a00:1813:b0:7a5:67cc:c837 with SMTP id
 d2e1a72fcca58-7b0bd3b193fmr2978666b3a.18.1762492326115; 
 Thu, 06 Nov 2025 21:12:06 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0c9c08e53sm1446512b3a.22.2025.11.06.21.12.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 21:12:05 -0800 (PST)
Message-ID: <c96879f7-122c-4da9-bb2c-4b5b66e99033@redhat.com>
Date: Fri, 7 Nov 2025 15:11:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 3/3] target/arm/kvm: Support multiple memory
 CPERs injection
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 mchehab+huawei@kernel.org, shan.gavin@gmail.com,
 James Houghton <jthoughton@google.com>
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-4-gshan@redhat.com> <20251017162746.2a99015b@fedora>
 <a635de53-71fa-4edb-87c0-8775722c284d@redhat.com>
 <20251031145539.3551b0a5@fedora>
 <88a41137-d5fb-4b61-a3f2-dd73133c17ec@redhat.com>
 <20251103105216.1f4241d7@fedora> <20251104122151.00006feb@huawei.com>
 <a4960b41-dd92-408f-a5e8-620b35be212b@redhat.com>
 <20251105090242.00004f93@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251105090242.00004f93@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Jonathan,

On 11/5/25 7:02 PM, Jonathan Cameron wrote:

[...]

>>
>> I already had the prototype of error source per vcpu, which works fine for
>> 64KB-host-4KB-guest. However, it doesn't work for huge pages. For example,
>> a problematic 512MB huge page can cause heavy memory error storm to QEMU
>> where we absolutely can't handle.
>>
>> 1. Start the VM with hugetlb pages
>>
>> /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                                     \
>> -accel kvm -machine virt,gic-version=host,nvdimm=on,ras=on                                  \
>> -cpu host -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1                      \
>> -m 4096M,slots=16,maxmem=128G                                                               \
>> -object memory-backend-file,id=mem0,prealloc=on,mem-path=/dev/hugepages-524288kB,size=4096M \
>> -numa node,nodeid=0,cpus=0-7,memdev=mem0                                                    \
>>
>> 2. Run 'victim -d' on guest
>>
>> guest$ ./victim -d
>> physical address of (0xffff889d6000) = 0x11a7da000
>> Hit any key to trigger error:
>>
>> 3. Inject error from host
>>
>> host$ errinjct 0x11a7da000
>>
>> 4. QEMU crashes with error message "Bus error (core dumped)", which is triggered
>> the following path.
>>
>> sigbus_handler
>>     kvm_on_sigbus_vcpu           // have_sigbus_pending = 1
>>     sigbus_reraise
> 
> To me this sounds like something that should not be happening on the host unless
> a real memory error is detected that blows away the whole of / most of a huge page.
> I'm not sure we care about surviving that case if it isn't mapped using hugetlb/DAX or
> similar in the guest (so contiguous in both with contained impact in both).
> 
> I assume the issue is backing with hugetlbfs which doesn't have a sub huge page granularity
> for poison tracking.  I vaguely recall an effort to solve that
> https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/
> was the first thing google threw me. Looks like it got to v2.
> https://lore.kernel.org/linux-mm/20230218002819.1486479-1-jthoughton@google.com/
> 
> +CC James.
> 

For this particular case where the guest memory is backed by 512MB hugetlb pages.
There are 8 hugetlb pages since the guest has 4GB memory. I agree it's impossible
to recover from this extreme situation for a couple of factors: (1) A problematic
huge page is likely to be shared by multiple vCPUs. Multiple SIGBUS signals can be
raised at once, but we're unable to handle; (2) The instruction (TEXT section) of
guest's application or kernel can reside in the problematic huge page. Any instruction
fetch just leads to SIGBUS signal, meaning the vCPUs can't continue their executions.

I'm summarizing my findings for above case, to make this thread complete at least.

Only one pending SIGBUS signal is allowed by QEMU in current implementation. Otherwise,
it crashes in sigbus_handler() by a SIGBUS signal sent from sigbus_reraise().

   qemu
   ====
   sigbus_handler
     kvm_on_sigbus_vcpu
       have_sigbus_pending = true;
       qatomic_set(&cpu->exit_request, true)
            :
   kvm_cpu_exec
     kvm_cpu_kick_self
       kvm_cpu_kick
         qatomic_set(&cpu->kvm_run->immediate_exit, 1);
     kvm_vcpu_ioctl                                       // Return immediately
     kvm_arch_on_sigbus_vcpu
     have_sigbus_pending = true;

There are two SIGBUS signals raised by host before the target vCPU can be stopped. The
first one is raised by host when the memory error is handled.

   host
   ====
   memory_failure
     try_memory_failure_hugetlb
       get_huge_page_for_hwpoison
         __get_huge_page_for_hwpoison
           folio_set_hugetlb_hwpoison
     hwpoison_user_mappings
       collect_procs                                     // Collect tasks using the folio
       unmap_poisoned_folio
         try_to_unmap                                    // TTU_HWPOISON
           try_to_unmap_one
             mmu_notifier_invalidate_range_start
             swp_entry_to_pte(make_hwpoison_entry(subpage))
             set_huge_pte_at                             // Poisoned PMD
             mmu_notifier_invalidate_range_end
       kill_procs                                        // Raise SIGBUS
     identify_page_state


The second one is raised by the stage2 page fault handler due to the poisoned PMD.

   kvm_handle_guest_abort
     user_mem_abort
       __kvm_faultin_pfn
         kvm_follow_pfn
           hva_to_pfn
             hva_to_pfn_fast
             hva_to_pfn_slow
               get_user_pages_unlocked
                 __get_user_pages_locked
                   __get_user_pages
                     follow_page_mask                      // No PMD mapping
                     faultin_page
                       handle_mm_fault
                         hugetlb_fault
                           is_hugetlb_entry_hwpoisoned     // Return VM_FAULT_HWPOISON_LARGE
       kvm_send_hwpoison_signal                            // Raise SIGBUS

Thanks,
Gavin


