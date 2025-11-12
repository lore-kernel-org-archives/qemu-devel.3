Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A6FCD3435
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 17:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJEnv-0000Le-FE; Wed, 12 Nov 2025 12:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJEnW-0007kQ-RV
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:38:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJEnV-0001cT-16
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762969100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8UuWD0cVZtSExOoD5bQQSMBrEDDsWPntKGLzXFYzCY=;
 b=dtYNif4OtA4Yj/oFlfczLzevm7GdBOpb0x9hJmP1Jh8SeZQyYm8mxO0SxzuXgwmv2VUZe4
 cTaiVBCPyyzXLMj9hCpI4aqa2pZSVTUGtPyBvvS3CZ5nm6mlg89ZPCCaupeRBKdWBkGKik
 vVvtJMeuzOCSA7Fg2QvKGzgZOYWlmlc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-zdacvmDFPp2g7fdJM02SMQ-1; Wed, 12 Nov 2025 12:38:17 -0500
X-MC-Unique: zdacvmDFPp2g7fdJM02SMQ-1
X-Mimecast-MFC-AGG-ID: zdacvmDFPp2g7fdJM02SMQ_1762969096
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3416dc5754fso1590803a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762969096; x=1763573896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y8UuWD0cVZtSExOoD5bQQSMBrEDDsWPntKGLzXFYzCY=;
 b=fAoltU0Cw9QAjUbmw39+6YbF7SWxTgvHKrWSpyteQT4LMq8zGA2Ccz2W26H/NSX/W3
 VgyhDZahskxq2Ql0GLSi4+yEfa1yJ+MYXvdssukVcmvuH0q7YGp860jh5j4OclkkPMTK
 q1Rd8P+5pLw6QVP7vMNDDWZ2ajTHJSmdKjsjI+P2dXM5oMMXF4zIzDQn8BkGQipc2zWB
 /8FvUztcAB0WzDUq0dM4SC7zGxuC6JbfRhaGZSYJQU50NRIa3+w+s9G1suy7wfUn79/v
 /Nhx7loQBU6WDG/2rGm3/zYHeK1P5VMQLJ10I0gTzjp8HIgIyNnU8DnmETtEXEY8ucuS
 7QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762969096; x=1763573896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y8UuWD0cVZtSExOoD5bQQSMBrEDDsWPntKGLzXFYzCY=;
 b=PfRZWPPabogclZKx1qB6Ch553Ohavczt5cwmEVDhpQqxrx0O2FwsOKVD/OW6Y03cWf
 HRb2p7NLdQtDmJw1xNk98LtzzvrXMsVJJ+2TKuGWws/10NNm2iJB1+WRHcKE5iwpZ9xI
 PNVPUvrH2tHA9sTcgM/UtdLLmSphSv5eF7E2TOVsCvAUMeqUYzk78qb51aErxZFeFQ80
 LCwqlE/Xx9B0iRN18DVlclpWnGBDgJ2nwYMo96EPIEPLbUC7N+Z/rvkkxOdyP1pKXyzv
 T2BdLXw2KYBoCy3Pz39cqcQS1H1m4thyxVheJ4LYnAVN12NAAqh6h9/QU/QjF0yUlYxU
 tB5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFl+o4x6MM2yCgRTrUVe4BHU4fdmhurzdWnq3Le4i6eb04DhHDaNHXgXTq6RTfLF++psFyTfC32b+B@nongnu.org
X-Gm-Message-State: AOJu0YzX6m8bGLmEdz38MiIZNMyWUw7oWDoZ/DWK+YCebfdRCEcbGby9
 d1mQ/MmC3OgTaVgbU6ykA+l4Z9l405jcqkbcTYHS3a8Ev429b50ydDZSRaMpuid9LhAFtQJhPXb
 Jf50cogxOvxF9OZH2uGYQsuqqMFxjCGo/T7Pj9lncpCHy3nkMF5hYSMQ2
X-Gm-Gg: ASbGnctl7c6FY28zL8l098UCipf0k8ri2/D9APL3yNF1nIPBJj9COxSo1EisgSKQqr5
 TuHqEJMExiK7CeCfryWoHtG/q34bj7la9sHtU9n4Adnou6NLnlGKC8rP365KClcplZ1w/cbP/oy
 GGT9+gs6UbOqHfLnfX+je9p60xpbyHeqJr9eRbMi7DRQi9i5hqMC0Hpkh8kzr1srn9xaPpKREin
 uDbHwVgcTQ+WD0F18LLEN09pUPwjRNIMrnKekpMu999I99aQVrcXyQ4Gk9b5jcfU/xoPaeL7ZEt
 Zs0SsdXWPA+IB8p3AF3H6TTvNFtLbUB9rNMEm+/dMpoDAPiXvqRwDpQKSDasrlX6vjzeTwbw1t8
 0F90bT1saWTis5FyEZBqhNpwHih5iSCfG9bg97hc=
X-Received: by 2002:a17:90b:3885:b0:32e:4924:6902 with SMTP id
 98e67ed59e1d1-343dddd8d65mr4565386a91.3.1762969096138; 
 Wed, 12 Nov 2025 09:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUaC9ich0ZoagTbceFGe7Ueh+T5vSSjZU1Ge1Qebra4soG9ygWiX9UzuLsk3Bl/vXsmPozUA==
X-Received: by 2002:a17:90b:3885:b0:32e:4924:6902 with SMTP id
 98e67ed59e1d1-343dddd8d65mr4565350a91.3.1762969095697; 
 Wed, 12 Nov 2025 09:38:15 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e072c53esm3327868a91.9.2025.11.12.09.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 09:38:15 -0800 (PST)
Message-ID: <2103b25a-b446-42c7-908e-5609ab6b7f43@redhat.com>
Date: Thu, 13 Nov 2025 03:38:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] acpi/ghes: Use error_abort in
 acpi_ghes_memory_errors()
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com, Markus Armbruster <armbru@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-7-gshan@redhat.com>
 <2c3b388e-e002-466a-9b03-cafefcfc9d19@linaro.org>
 <4af87665-14b1-41a4-8ed9-d3c9dfc087b8@redhat.com>
 <20251112134928.3f2ebb40@fedora>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251112134928.3f2ebb40@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Igor,

On 11/12/25 10:49 PM, Igor Mammedov wrote:
> On Tue, 11 Nov 2025 13:58:46 +1000
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> On 11/11/25 12:54 AM, Philippe Mathieu-Daudé wrote:
>>> On 5/11/25 12:44, Gavin Shan wrote:
>>>> Use error_abort in acpi_ghes_memory_errors() so that the caller needn't
>>>> explicitly call abort() on errors. With this change, its return value
>>>> isn't needed any more.
>>>>
>>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    hw/acpi/ghes-stub.c    |  6 +++---
>>>>    hw/acpi/ghes.c         | 15 ++++-----------
>>>>    include/hw/acpi/ghes.h |  5 +++--
>>>>    target/arm/kvm.c       | 10 +++-------
>>>>    4 files changed, 13 insertions(+), 23 deletions(-)
>>>
>>>    
>>>> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
>>>> index f73908985d..35c7bbbb01 100644
>>>> --- a/include/hw/acpi/ghes.h
>>>> +++ b/include/hw/acpi/ghes.h
>>>> @@ -98,8 +98,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>>>>                         const char *oem_id, const char *oem_table_id);
>>>>    void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>>>>                              GArray *hardware_errors);
>>>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>>> -                            uint64_t *addresses, uint32_t num_of_addresses);
>>>> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>>> +                             uint64_t *addresses, uint32_t num_of_addresses,
>>>> +                             Error **errp);
>>>
>>> This is an anti-pattern w.r.t. commit e3fe3988d78 ("error: Document
>>> Error API usage rules"), because it can be called with an errp distinct
>>> of &error_abort.
>>>
>>> If you really want to abort(), remove the errp argument, directly call
>>> abort() and rename as acpi_ghes_memory_abort_on_errors().
>>>    
>>
>> Thanks for pointing it out. I will improve this like below in next revision.
>>
>> - Drop 'errp' argument from acpi_ghes_memory_errors(), but I prefer to keep
>>     the function name.
>>
>> - In acpi_ghes_memory_errors(), a local variable 'Error *err' is added and
>>     pass it to ghes_record_cper_errors(), which is also called by QMP handler
>>     qmp_inject_ghes_v2_error().
>>
>> Please let me know if there are any more improvements needed.
>>
>>>>    void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>>>                                 uint16_t source_id, Error **errp);
>>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>>> index 459ca4a9b0..a889315606 100644
>>>> --- a/target/arm/kvm.c
>>>> +++ b/target/arm/kvm.c
>>>> @@ -2458,13 +2458,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>>>                addresses[0] = paddr;
>>>>                if (code == BUS_MCEERR_AR) {
>>>>                    kvm_cpu_synchronize_state(c);
>>>> -                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>>>> -                                             addresses, 1)) {
>>>> -                    kvm_inject_arm_sea(c);
>>>> -                } else {
>>>> -                    error_report("failed to record the error");
>>>> -                    abort();
>>>> -                }
>>>> +                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>>>> +                                        addresses, 1, &error_abort);
> 
> I guess that was my request,
> with calling abort() directly you have to print error separately,
> while using 'error_abort' is much more cleaner (as this hunk demonstrates)
> 

error_abort has been replaced by error_fatal as Markus suggested in another
reply.

>>>> +                kvm_inject_arm_sea(c);
>>>>                }
>>>>                return;
>>>>            }
>>>    

Thanks,
Gavin


