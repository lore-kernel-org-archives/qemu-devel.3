Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9D8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 03:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIfX5-0003Pv-V2; Mon, 10 Nov 2025 22:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIfX2-0003OJ-HY
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 22:59:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIfX0-0007iW-Fu
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 22:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762833536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W40hsoHZzfYuXfaygXOzFaBww57/LsJq5UosWDuMl6E=;
 b=G1ZEfcAnzXQxskKX4GJ+QDyUMWhxB6RwFLYvGZUx1yXPQYBpP838he9cSu2IGEh6/US6V7
 ErPQJ18wo0Xbg0CWqbXfkMk0t5JxRHzqlN2YJiIWXoKSELI/uNDM+Fro5O6ZQHjQfnydHu
 6aF3lIvjH+VyBgJvglaRFVhZv33JD8M=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-HIKRtLotMJCrnVE5JDc1HQ-1; Mon, 10 Nov 2025 22:58:54 -0500
X-MC-Unique: HIKRtLotMJCrnVE5JDc1HQ-1
X-Mimecast-MFC-AGG-ID: HIKRtLotMJCrnVE5JDc1HQ_1762833534
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-297f3710070so70800755ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 19:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762833534; x=1763438334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W40hsoHZzfYuXfaygXOzFaBww57/LsJq5UosWDuMl6E=;
 b=V0tBERy8Vqo9S5so4BiYfP6ub8onfvZZZdCVEHqqJ7IEqj6bfazWqcKKEjejfpZy7N
 HZDa/Mjv7JSyvBmlFDjXz3aSPKn5cTBAjkf8sxWX0OMJqDDqiqqJumjxyh0jNiAwHkr7
 HFoU7CzcQrhMytw/ICc01wlmWK687YYCdRorkPhmtcSik7dc6hqTttcBb/wriCtbaX6r
 B5/u5zhZheCM3nJWIHquffkRZIqNx6IWmZd9kiFlBm5kAOsrottIWiLQ92t+iRDdaorv
 yWVak6XHJn/Dd3Qzfn+0YZuVx3/wTEPnnRrO2/viURA0JBTkv9djoDfzlj2pxwdxnRRh
 c+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762833534; x=1763438334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W40hsoHZzfYuXfaygXOzFaBww57/LsJq5UosWDuMl6E=;
 b=beGsbBe/Yw+XuqYalTHG1iLCZ/KnMjTqMucyap+xfLbWQFysidUDN5iOR7tlTJ4ymM
 NM+w+Wq6zIsCygCZXFKlqZ4paMez8eLfk0va9EtOQDyEQEP+SGhMd16kAbu3MnarjNYo
 xRANVtzlF/nAinVQQTMB25ObcanK9Uid1NL5m4zOg3ejZORCIUdy+dvHEOlLINK/d0zT
 ELybcHPoMWrT1dw1PX4vZ3Wh+P6uysxhJ1f2FsfIP8hxheQviHAisOshvAW9OrqTrVVZ
 7fjjiHnRAQBj9BRitxH3HqTPGPzVVnMXnBUJf7fe1/iSdfMbfUvqVHfsUvWfdFEc8KoK
 RJFQ==
X-Gm-Message-State: AOJu0YxLvXirLyJBpX9IJ1vWjgt2elFWLSM1lKwbiygmKwgXOFoPuz99
 fw72Iv0cQwFUZDLZgD7y6JfQkNNwi64BAiTe1w1r/aRsElmaIgEr1/N590G+7qxgOs4iePDiH1O
 S8BEuDdZv7dO/qmYvd0RsDanVjAic+z3NHbBoeX1AeeSSmN+/pWdrKB9q
X-Gm-Gg: ASbGncuphCQNGuNpjcIqCuE/nnu11w27kO1dEppzg98XIELWd9+bABCEZHzME11QtD3
 bQePgYOtHaMeovJLdtMH/PbA4noOTSaaM4hRGrcgJn3GRDRdrC3hHZDDU5L132LBQAC/DOa7NwH
 Mrq+abWEaQWjeuqqbE/431g2B90f4v0hoZhyX+OAcabdqr6wtz4+AzNt4lzmykLYJdIu6CpJ7fX
 hIJLs3fryW8MVwahxApRNZXPSYweKvgJzFx3Ehs2MXcnuXVdo+Xt7+S06zbzBtJVpL5nRZo04Mn
 ljSgc51KypjcRtx2Vhqanyn33UaDLUhexcsEMl0ra4x97hwrjcI2dScB92F5JRxhK2BrnSORKat
 oCZ4bqI8wzzHM8HW5ks4QhFSQ4y5j1PH9IRJtFes=
X-Received: by 2002:a17:902:e382:b0:295:596f:850a with SMTP id
 d9443c01a7336-297e540d840mr91473125ad.5.1762833533777; 
 Mon, 10 Nov 2025 19:58:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRiUjnlI8y2+BW369QpuPGR9v1JePfWAQHOQ8q9RivJSZEl0zKgmbjr0c8sGrPSuBWFYnnuw==
X-Received: by 2002:a17:902:e382:b0:295:596f:850a with SMTP id
 d9443c01a7336-297e540d840mr91472905ad.5.1762833533393; 
 Mon, 10 Nov 2025 19:58:53 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c8f07csm167324385ad.78.2025.11.10.19.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 19:58:52 -0800 (PST)
Message-ID: <4af87665-14b1-41a4-8ed9-d3c9dfc087b8@redhat.com>
Date: Tue, 11 Nov 2025 13:58:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] acpi/ghes: Use error_abort in
 acpi_ghes_memory_errors()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com,
 Markus Armbruster <armbru@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-7-gshan@redhat.com>
 <2c3b388e-e002-466a-9b03-cafefcfc9d19@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <2c3b388e-e002-466a-9b03-cafefcfc9d19@linaro.org>
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

Hi Philippe,

On 11/11/25 12:54 AM, Philippe Mathieu-Daudé wrote:
> On 5/11/25 12:44, Gavin Shan wrote:
>> Use error_abort in acpi_ghes_memory_errors() so that the caller needn't
>> explicitly call abort() on errors. With this change, its return value
>> isn't needed any more.
>>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/acpi/ghes-stub.c    |  6 +++---
>>   hw/acpi/ghes.c         | 15 ++++-----------
>>   include/hw/acpi/ghes.h |  5 +++--
>>   target/arm/kvm.c       | 10 +++-------
>>   4 files changed, 13 insertions(+), 23 deletions(-)
> 
> 
>> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
>> index f73908985d..35c7bbbb01 100644
>> --- a/include/hw/acpi/ghes.h
>> +++ b/include/hw/acpi/ghes.h
>> @@ -98,8 +98,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>>                        const char *oem_id, const char *oem_table_id);
>>   void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>>                             GArray *hardware_errors);
>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> -                            uint64_t *addresses, uint32_t num_of_addresses);
>> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> +                             uint64_t *addresses, uint32_t num_of_addresses,
>> +                             Error **errp);
> 
> This is an anti-pattern w.r.t. commit e3fe3988d78 ("error: Document
> Error API usage rules"), because it can be called with an errp distinct
> of &error_abort.
> 
> If you really want to abort(), remove the errp argument, directly call
> abort() and rename as acpi_ghes_memory_abort_on_errors().
> 

Thanks for pointing it out. I will improve this like below in next revision.

- Drop 'errp' argument from acpi_ghes_memory_errors(), but I prefer to keep
   the function name.

- In acpi_ghes_memory_errors(), a local variable 'Error *err' is added and
   pass it to ghes_record_cper_errors(), which is also called by QMP handler
   qmp_inject_ghes_v2_error().

Please let me know if there are any more improvements needed.

>>   void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>                                uint16_t source_id, Error **errp);
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 459ca4a9b0..a889315606 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -2458,13 +2458,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>               addresses[0] = paddr;
>>               if (code == BUS_MCEERR_AR) {
>>                   kvm_cpu_synchronize_state(c);
>> -                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>> -                                             addresses, 1)) {
>> -                    kvm_inject_arm_sea(c);
>> -                } else {
>> -                    error_report("failed to record the error");
>> -                    abort();
>> -                }
>> +                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>> +                                        addresses, 1, &error_abort);
>> +                kvm_inject_arm_sea(c);
>>               }
>>               return;
>>           }
> 

Thanks,
Gavin


