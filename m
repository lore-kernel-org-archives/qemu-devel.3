Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8D2CCFA00
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 22:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFgpY-0003ga-FA; Sun, 02 Nov 2025 17:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vFgpR-0003fu-Bv
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vFgpO-0008S6-0g
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762123531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8d8S2xUzgj+mrBrYPWvOjf+k48CAlwVF/c/e8nNh9k=;
 b=AwItE7UZBjDWos2uawQpKRS5Pcm0oVxCxJLmRXndG+Jw5nwz3r5O7MM//qnKvlKPEwttcx
 DynrPoFjgh+v9P9ISJyLG1e8jrzLFYbIPBBqNKmWhcTATdLrrJVCL1YHjLKoGUiKNYKxY5
 K+w+PkEOilBP+aK79HWclENiJalRZGA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-vNfJgPJ-OgeeTkHeVJg9bw-1; Sun, 02 Nov 2025 17:45:30 -0500
X-MC-Unique: vNfJgPJ-OgeeTkHeVJg9bw-1
X-Mimecast-MFC-AGG-ID: vNfJgPJ-OgeeTkHeVJg9bw_1762123529
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-295952a4dd6so8408255ad.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 14:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762123529; x=1762728329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y8d8S2xUzgj+mrBrYPWvOjf+k48CAlwVF/c/e8nNh9k=;
 b=lXzcIzZOa1qCJmuSg4ylv7TqiIz7nrKjrhMTStdQYTeHF0w33reIlyyR/s9eh4DXUp
 h0lCqJzrb76Wso2+zeftzpUyr2fiwbZG6cw3LT1j/VdIwnAE+bNmcxKr5YxFgME0/tHt
 pIXcXymZuQkQLFe+IQlJm2PznxYMp2v5Wa4T5lvnJ4rhJmEmaOeNY9xGR+JWFMx0Y53z
 rabwOrf/zpMuBb3MKj8b5DDWjJ2Mpp4d4tYuqoMMs3/XD+PJJKINO/X9c2lG96y/FlwF
 bQRhBoNKnSxGwZRBIr/kHPCMXSw6y79AySnMHN3q7U4tUTc86rRjBtGgWU0pZMwhWlVd
 aemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762123529; x=1762728329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y8d8S2xUzgj+mrBrYPWvOjf+k48CAlwVF/c/e8nNh9k=;
 b=XYO7+SgL8Yc43rKlmJBEps07K01V1gMFEsguZzrbN9DD9/0O3apkv6xb1ryJmcpd3s
 SpYTWsJBZ3JQg7cZyMRnNtcGvogISM30c6rJ3vERzOKDI0px0fyo5dHR42zklMhuROB4
 F+6a47R93JuI/wnLuwRAVPsMd/3FrCAAq2J/ClMfWlm49EamT8BIsDsBZiK4g9vhCv+r
 JuQcWm9gc/mFBmfOHCmVJ3pXAsF6c2D5vygLDagD5KuCmAazNIo88hBnlge0PHdzvxLZ
 Kdnk1iHJcfdrEC8fm6tT/3YSPjP2r8iJjXIXovPs+EUYGUQD1B9ubTjARfFBZ62sI91P
 Hxbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlNUYsXM2SZfMnWE30in6eC8i8g7C6ldnwZTLYJ2P8dklLrvCI3gx8XC6k6QbFswk1Cxar9R30OzQd@nongnu.org
X-Gm-Message-State: AOJu0Yx5e7jkLzRE3hOlCcH+aF99LpB6uNpBYCBKgBFCujzdSJf44On2
 6yzu/DGtAkZ6/jFzFNxWijQkp0frAlLOOOuxsKYdrVhfkKN2eW2vtfXh6wHX/OTmrQHsdwyVeXz
 znmYOrTTtf5Q616Ygea+S5kNRisS8ILtF4CCgCgESG8OUDOcE5J5Djpok
X-Gm-Gg: ASbGnctHWj12lndvtgKCjBXLjWBQX4q7WVRovI+to3EObOzZJlhuWHqSLeqSBJ42s/H
 w23DYFrwXqcYKeh8KUGe84JJNJaD/hQHuISrVrGlAh3cUmjG9wC4XMiVVsHViLja/U1ltnzxb54
 JCm1paI1KKTudmJS6eXMi0pGVQ97gBcEiGf9m1Pyk9+Mhco7UKRoHvxrWn7gb4LCBVb9qkvyByP
 +6+WvD3dRB2waj0MEEHGcbJstYk/VW2Ut8MPho1t3xIcpkFxDQ4j6YQQqiKlrkMXA9iNOBwvp9q
 BFF+5lxe2TD26bOLO5DOj/vhNhyneiugOGH7rf5I3g/b4NTWjPEsXafhgmeUmTG+XJnUbWgu2kW
 U9fPkENlg9kiKme8E3uXSQNfRkMCf/fskO7VZd7Q=
X-Received: by 2002:a17:902:db0f:b0:295:3141:4d54 with SMTP id
 d9443c01a7336-2953141500bmr114923945ad.18.1762123528925; 
 Sun, 02 Nov 2025 14:45:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpFm814j7GAKlbphVBlai9uR6hmBezuNkZuaJ8kJQxWwYtEOFceRSOP2l8JPwTgCiJKOdw6w==
X-Received: by 2002:a17:902:db0f:b0:295:3141:4d54 with SMTP id
 d9443c01a7336-2953141500bmr114923785ad.18.1762123528443; 
 Sun, 02 Nov 2025 14:45:28 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f096a44sm5423449a91.2.2025.11.02.14.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 14:45:27 -0800 (PST)
Message-ID: <adf9d0f6-4d27-47fe-8153-28e07fa28394@redhat.com>
Date: Mon, 3 Nov 2025 08:45:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/3] acpi/ghes: Extend acpi_ghes_memory_errors()
 to support multiple CPERs
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, gengdongjiu1@gmail.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, mchehab+huawei@kernel.org,
 shan.gavin@gmail.com
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-2-gshan@redhat.com>
 <20251031095850.00002589@huawei.com> <20251031100823.00001c8d@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251031100823.00001c8d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 10/31/25 8:08 PM, Jonathan Cameron wrote:
> On Fri, 31 Oct 2025 09:58:50 +0000
> Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
>> On Tue,  7 Oct 2025 16:08:08 +1000
>> Gavin Shan <gshan@redhat.com> wrote:
>>
>>> In the situation where host and guest has 64KB and 4KB page sizes, one
>>> error on the host's page affects 16 guest's pages. we need to send 16
>>> consective errors in this specific case.
>>
>> Hi Gavin,
>>
>> Sorry this one has been on my to review list far too long.
>>

No worries. Thanks for your review and comments. Igor suggested to have
separate error source for each vCPU. In that way, there will have multiple
read_ack_reg and the specific issue addressed by this series can be resolved.

Answering your question below.

>>>
>>> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
>>> hunk of code to generate the GHES error status is pulled out from
>>> ghes_gen_err_data_uncorrectable_recoverable().
>>
>> I think this description needs to be more detailed wrt to how those
>> multiple CPERs are handled.  Specifically that they are in a single
>> error status block (so should only represent related errors.)
>>
>> This is to make it clear this isn't queuing events, but instead just
>> presenting them as one block.
>>
>>>
>>> No functional changes intended.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   hw/acpi/ghes-stub.c    |  2 +-
>>>   hw/acpi/ghes.c         | 27 ++++++++++++++-------------
>>>   include/hw/acpi/ghes.h |  2 +-
>>>   target/arm/kvm.c       |  7 ++++++-
>>>   4 files changed, 22 insertions(+), 16 deletions(-)
>>
>>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>>> index 06555905ce..045b77715f 100644
>>> --- a/hw/acpi/ghes.c
>>> +++ b/hw/acpi/ghes.c
>>> @@ -214,18 +214,13 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
>>>   
>>>   static void
>>>   ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
>>> -                                            const uint8_t *section_type,
>>> -                                            int data_length)
>>> +                                            const uint8_t *section_type)
>>>   {
>>>       /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
>>>        * Table 17-13 Generic Error Data Entry
>>>        */
>>>       QemuUUID fru_id = {};
>>>   
>>> -    /* Build the new generic error status block header */
>>> -    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
>>> -        0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
>>> -]
>>
>> With this bit gone, is it worth having the helper?  Perhaps just move
>> the remains to where it is called.
>>

Ack.

>>>       /* Build this new generic error data entry header */
>>>       acpi_ghes_generic_error_data(block, section_type,
>>>           ACPI_CPER_SEV_RECOVERABLE, 0, 0,
>>
>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>> index 4f769d69b3..9a47ac9e3a 100644
>>> --- a/target/arm/kvm.c
>>> +++ b/target/arm/kvm.c
>>> @@ -2434,6 +2434,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>>       ram_addr_t ram_addr;
>>>       hwaddr paddr;
>>>       AcpiGhesState *ags;
>>> +    GArray *addresses;
>>>   
>>>       assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>>>   
>>> @@ -2442,6 +2443,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>>           ram_addr = qemu_ram_addr_from_host(addr);
>>>           if (ram_addr != RAM_ADDR_INVALID &&
>>>               kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
>>> +            addresses = g_array_new(false, false, sizeof(paddr));
>>
>> Given you are going to free in all paths, maybe a g_autofree?
> 
> Oddly there is no use of g_auto() with g_array in qemu. Ah well, next suggestion is
> my preference anyway.
> 

Something like below can be used, and GArray is interchangeable to a regular array.
I guess GArray is preferred in QEMU.

     g_autoptr(GArray) sources = g_array_new(false, true,
                                             sizeof(AcpiNotificationSourceId));

>>
>> Also, we know this only grows to a fixed max size (16 after patch 3), so maybe just
>> provide a hwaddr paddrs[16]; and pass forwards the count?
>>
>>>               kvm_hwpoison_page_add(ram_addr);
>>>               /*
>>>                * If this is a BUS_MCEERR_AR, we know we have been called
>>> @@ -2454,16 +2456,19 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>>                * later from the main thread, so doing the injection of
>>>                * the error would be more complicated.
>>>                */
>>> +            g_array_append_vals(addresses, &paddr, 1);
>>>               if (code == BUS_MCEERR_AR) {
>>>                   kvm_cpu_synchronize_state(c);
>>>                   if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>>> -                                             paddr)) {
>>> +                                             addresses)) {
>>>                       kvm_inject_arm_sea(c);
>>>                   } else {
>>>                       error_report("failed to record the error");
>>>                       abort();
>>>                   }
>>>               }
>>> +
>>> +            g_array_free(addresses, true);
>>>               return;
>>>           }
>>>           if (code == BUS_MCEERR_AO) {
>>

Thanks,
Gavin


