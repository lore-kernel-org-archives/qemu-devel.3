Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C22CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 06:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIhSm-0006Vi-6n; Tue, 11 Nov 2025 01:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIhSi-0006Sl-3V
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 01:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIhSf-0007k6-HS
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 01:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762840955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=koH81FTGaXA6b5zb+G0vk5e0prX1lbQsjBrO4oK8u+E=;
 b=dr//QQc/G4uiM/l6oWCwWv5kFRfUlTzoFo/N3vpmVDugs4EvKfuUYHxpGhrUfpaSFOvSi9
 A/3/7NdR2LA28q4psQdpHMAtx1KnjDt6X40HztcLioFdHdgDy7I5OZ6R0wTMLwg8ftziqC
 dB4Bu9bDlOKfFV6UmAAULs1QIcS7OQE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141--ojs10eyNHychStXce7EIg-1; Tue, 11 Nov 2025 01:02:33 -0500
X-MC-Unique: -ojs10eyNHychStXce7EIg-1
X-Mimecast-MFC-AGG-ID: -ojs10eyNHychStXce7EIg_1762840952
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3438744f11bso2917666a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 22:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762840952; x=1763445752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=koH81FTGaXA6b5zb+G0vk5e0prX1lbQsjBrO4oK8u+E=;
 b=aiLdxnS1VO8BqHhCnjo3KF8ZvsfwgBsjTlV1hTOodiBwd0oFlSpLT0G5DX6zDex6At
 xbkIYUxWc/M0UAWJhwk4+jL5SJteUQggzisCxcCdPHrGGELLsYXLXBsFW90JGQ6TJO6Z
 zkgDVmRwxHIRF/kkFdxIzY9bN1mqcDaS9q/9FhdAsgYQK+mxbKzzWU5Q2SslYbk+3BrK
 X6i6/RTuJo8dwYWtrLe+bY8SrGwAfPECbPRBg4IKXiXW/AgCi8dl05/cVZxxq4JHDkDZ
 zdEk6y5UATNU6n339JjuTlXncuGQdpzE2N+1HlB2R6B0X1UfBsgxkZBK9cFNTuOBLHRq
 44yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762840952; x=1763445752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=koH81FTGaXA6b5zb+G0vk5e0prX1lbQsjBrO4oK8u+E=;
 b=VPkAREAfvaGZW6mQgxLqGrlIue1p6N5I5DoWPp8AjE7yEvaHZ529+Q+rn9JAsWKC3s
 fpEHFj0QOUwGy1s/hTpeFR5n6kI9ZXhXnv8nMwkWgtindKxMHtQrjOEEqcI2VmAnE9hx
 e5unE9nPJOgHyRpcESDJ52GGOm0Ly32BzcJe0XzEfYsliVHBJViCWJelSpT3Az3t4fzJ
 MqFcvZat8rMnVvUyDHz7s5XXipKOhqteWIkSTaT73qcvI2qX5Eb7iKiLNCh5jfVu0LrR
 MFdQCKetIvSY8XnlEfh1pxemml+kXSMlmKs6wRta3ZkWSa9O7cyKrmZW6myqsOXlnlPb
 2vNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUGeqaNGqvAUmR5wYAHS4/ntLJ6dtr6+HWlOUkxWznC26MT2Go34m6ACiPySVRgzkpUo5jsk5RVbHv@nongnu.org
X-Gm-Message-State: AOJu0YyiDzk1s59zCVhEIFsEyYyJlINBvw8Ep2BaCOdZ0Knzj5VcvBD7
 2YtbbTb/NZsSiKvoKwwWZVwQqgWCaq5Rr+GswwXUjGv5FpXXEJrr8We5aSwwlPs/GfTPPiWsjm9
 /IdkCvY5KwXxO/5KE+XQ2lCIy+7KpRTOVS0puP0J6rgmobTQewmMzlO49
X-Gm-Gg: ASbGncvl8KEf5Nh4mBxKMSUpNs4b9k3wkP3I8oeo0CgTJq8jcRM+JNEltPxH9Fnlmp9
 iN6JfnR/ZERS340pIxqVhEqmqVlSnZnHzM3wO902WXMRKR4x5oBvUHsWTG6fuCu6ramS/YtXO9Y
 WtsNYPUn6aV3S4fhK45U/b5gMMwJkDHU5tFU9gCjBTZ9hGn8T450gMYxdcOE3gsmlOd7ZHzziHT
 kknbF+V5RdX9yOX4c7klkWYzsx8ZXBri0ZS1TFlRx1eyJO1/WHzARIzLRrB/zZLMQFr240QgJDD
 zy9yePnUFjxrJeAAz6U+6UOrF9ZP4xv08u5HVQlkAc7RUo20fRaizSNyNG16wJ3IHGo9pEbbYhT
 +XSCv7nmNhrrd9mwq80RnJ3l//0eSlif31YbiK/E=
X-Received: by 2002:a17:90b:17cb:b0:340:e521:bc73 with SMTP id
 98e67ed59e1d1-3436cb73b73mr12513648a91.5.1762840951923; 
 Mon, 10 Nov 2025 22:02:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzPdJPk3Wrt3JCPxia0buuUMKIFZVDvMzforq2lAJo6mRKfjyheZLW//gK9V1l/tF0uLzxkw==
X-Received: by 2002:a17:90b:17cb:b0:340:e521:bc73 with SMTP id
 98e67ed59e1d1-3436cb73b73mr12513610a91.5.1762840951465; 
 Mon, 10 Nov 2025 22:02:31 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343c52046f6sm512563a91.14.2025.11.10.22.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 22:02:30 -0800 (PST)
Message-ID: <b673bf36-cf1b-4103-bce8-0465a1385403@redhat.com>
Date: Tue, 11 Nov 2025 16:02:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] acpi/ghes: Use error_abort in
 acpi_ghes_memory_errors()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-7-gshan@redhat.com> <87o6p9gmy4.fsf@pond.sub.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <87o6p9gmy4.fsf@pond.sub.org>
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

Hi Markus,

On 11/11/25 3:25 PM, Markus Armbruster wrote:
> Gavin Shan <gshan@redhat.com> writes:
> 
>> Use error_abort in acpi_ghes_memory_errors() so that the caller needn't
>> explicitly call abort() on errors. With this change, its return value
>> isn't needed any more.
>>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/acpi/ghes-stub.c    |  6 +++---
>>   hw/acpi/ghes.c         | 15 ++++-----------
>>   include/hw/acpi/ghes.h |  5 +++--
>>   target/arm/kvm.c       | 10 +++-------
>>   4 files changed, 13 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
>> index 4faf573aeb..4ef914ffc5 100644
>> --- a/hw/acpi/ghes-stub.c
>> +++ b/hw/acpi/ghes-stub.c
>> @@ -11,10 +11,10 @@
>>   #include "qemu/osdep.h"
>>   #include "hw/acpi/ghes.h"
>>   
>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> -                            uint64_t *addresses, uint32_t num_of_addresses)
>> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> +                             uint64_t *addresses, uint32_t num_of_addresses,
>> +                             Error **errp)
>>   {
>> -    return -1;
>>   }
> 
> Before the patch, this function always fails: it returns -1.
> 
> Afterwards, it always succeeds: it doesn't set @errp.
> 
> Which one is correct?
> 

Both are correct. This variant is only used on !CONFIG_ACPI_APEI. In this case,
there is no chance to call this variant in the only caller kvm_arch_on_sigbus_vcpu().
acpi_ghes_get_state() returns NULL on !CONFIG_ACPI_APEI there.

>>   
>>   AcpiGhesState *acpi_ghes_get_state(void)
>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>> index 055e5d719a..aa469c03f2 100644
>> --- a/hw/acpi/ghes.c
>> +++ b/hw/acpi/ghes.c
>> @@ -543,8 +543,9 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>       notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
>>   }
>>   
>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> -                            uint64_t *addresses, uint32_t num_of_addresses)
>> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> +                             uint64_t *addresses, uint32_t num_of_addresses,
>> +                             Error **errp)
> 
> qapi/error.h:
> 
>   * - Whenever practical, also return a value that indicates success /
>   *   failure.  This can make the error checking more concise, and can
>   *   avoid useless error object creation and destruction.  Note that
>   *   we still have many functions returning void.  We recommend
>   *   • bool-valued functions return true on success / false on failure,
>   *   • pointer-valued functions return non-null / null pointer, and
>   *   • integer-valued functions return non-negative / negative.
> 

Question: If it's deterministic that caller passes @error_abort or @error_fatal
to acpi_ghes_memory_errors(), QEMU crashes with a core dump or exit before its
caller to check the return value. In this case, it's still preferred for
acpi_ghes_memory_errors() returns a value to indicate the success or failure?

>>   {
>>       /* Memory Error Section Type */
>>       const uint8_t guid[] =
>> @@ -555,7 +556,6 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>        * Table 17-13 Generic Error Data Entry
>>        */
>>       QemuUUID fru_id = {};
>> -    Error *errp = NULL;
>>       int data_length;
>>       GArray *block;
>>       uint32_t block_status, i;
>> @@ -592,16 +592,9 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>       }
>>   
>>       /* Report the error */
>> -    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
>> +    ghes_record_cper_errors(ags, block->data, block->len, source_id, errp);
>>   
>>       g_array_free(block, true);
>> -
>> -    if (errp) {
>> -        error_report_err(errp);
>> -        return -1;
>> -    }
>> -
>> -    return 0;
>>   }
> 
> The error reporting moves into the caller.
> 

Similar question as above. If it's deterministic for the caller passes @error_abort
or @error_fatal to acpi_ghes_memory_errors() and then to ghes_record_cper_errors(),
QEMU crashes with a core dump or exit before error_report_err(errp) can be executed.
In this case, it's still preferred to have error_report_err(&error_abort) or
error_report_err(&error_fatal) in its caller?

>>   
>>   AcpiGhesState *acpi_ghes_get_state(void)
>> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
>> index f73908985d..35c7bbbb01 100644
>> --- a/include/hw/acpi/ghes.h
>> +++ b/include/hw/acpi/ghes.h
>> @@ -98,8 +98,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>>                        const char *oem_id, const char *oem_table_id);
>>   void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>>                             GArray *hardware_errors);
>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> -                            uint64_t *addresses, uint32_t num_of_addresses);
>> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> +                             uint64_t *addresses, uint32_t num_of_addresses,
>> +                             Error **errp);
>>   void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>                                uint16_t source_id, Error **errp);
>>   
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 459ca4a9b0..a889315606 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -2458,13 +2458,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>               addresses[0] = paddr;
>>               if (code == BUS_MCEERR_AR) {
>>                   kvm_cpu_synchronize_state(c);
>> -                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>> -                                             addresses, 1)) {
>> -                    kvm_inject_arm_sea(c);
>> -                } else {
>> -                    error_report("failed to record the error");
>> -                    abort();
>> -                }
>> +                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>> +                                        addresses, 1, &error_abort);
>> +                kvm_inject_arm_sea(c);
> 
> Before the patch, we get two error reports, like this:
> 
>      qemu-system-FOO: OSPM does not acknowledge previous error, so can not record CPER for current error anymore
>      qemu-system-FOO: failed to record the error
>      Aborted (core dumped)
> 
> Such error cascades should be avoided.
> 
> Afterwards, we get one:
> 
>      Unexpected error at SOURCE-FILE:LINE-NUMBER:
>      qemu-system-FOO: OSPM does not acknowledge previous error, so can not record CPER for current error anymore
>      Aborted (core dumped)
> 
> Are all errors reported by acpi_ghes_memory_errors() programming errors,
> i.e. when an error is reported, there's a bug for us to fix?
> 
> If not, abort() is wrong before the patch, and &error_abort is wrong
> afterwards.
> 
> You can use &error_fatal for fatal errors that are not programming
> errors.
> 

No, there is no programming errors and the core dump is actually no sense.

It makes more sense for the caller to pass @error_fatal down to acpi_ghes_memory_errors().

>>               }
>>               return;
>>           }
> 

Thanks,
Gavin


