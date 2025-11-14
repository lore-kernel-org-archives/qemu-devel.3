Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEBACE7AA2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 09:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJqOx-0002Jl-3L; Fri, 14 Nov 2025 04:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJqOd-00029f-7V
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJqOa-0006us-V7
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763113627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2ttCOZcsS6Qp3eMp39FfDAEkp1YgNaggeUCdvXKV2E=;
 b=OlzLJ5eLt8bvie4LQDDWmNyomeQC9KOcPEtmdWOEyWET02pRyEkwrBXUu9TcnSozYpEVoi
 wu+PqsYRlycnJq2UIr6TY038i28NG/8+BiuRZKcueaTz3+LaLaTdQgEviX/gER4zv9sxWR
 aRTK1Zg1ZhSDK+TxNDlxjKUz4PhgoLU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-uNXn7sjSMwGBae1v0YeEjw-1; Fri, 14 Nov 2025 04:47:04 -0500
X-MC-Unique: uNXn7sjSMwGBae1v0YeEjw-1
X-Mimecast-MFC-AGG-ID: uNXn7sjSMwGBae1v0YeEjw_1763113623
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2958a134514so24424205ad.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 01:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763113622; x=1763718422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v2ttCOZcsS6Qp3eMp39FfDAEkp1YgNaggeUCdvXKV2E=;
 b=gAoraT3Mh/Ao6NCGaTS+Ozv9fUW/QN4ijIyHwlz0KzsD0ZNc56w4+LwJgv5Utxc8Eh
 158ZVM2GxtxTO/VmvWnkA5C0Yi7czh/ESQmUfO0DE5QNFUF7Upjq2xqX+HDhwn292ByW
 ztRazr78p8HnUM4ykSuyM6ViOnfKXKMZsPCu02Su7erVsslsD3iAplRdDnlaAQqjH0wi
 /RAJYbJYw/Jje/OBjg8cz7Fdm5niUcwuG5ixWqCUzQwR3AtBoENw1SZ2i4AS68VY7qvu
 cUzkafz19Y4oVVU33Kvg/AauLE/PjRpAhLizbwS5N6kePnCBXQ5xXEH4CTqeumcCvUVs
 8ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763113622; x=1763718422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v2ttCOZcsS6Qp3eMp39FfDAEkp1YgNaggeUCdvXKV2E=;
 b=ceyNAXTYx/HyyeA/0bZ/jUhKow2sjYLZFtvo1T+w4iOT08kETGC5yOVJkPCvK6B1d8
 3mT5S3uZ6oKpjeyMPv8EgQn8F+ch+y3XLdh4xO+gRe5NtfjTWD/wBxUhxqIwdLbkVtaa
 3QO3UdFT7ZLbaRpiM3qZYrZjNmBn/Y6U5WBy9OA8/p0LGBfoUhqJRpQ6Mb4SUNIF+dgG
 U6cJQv8m3ENfrO0POtsP9raLu4FLxX+gu6HV1bFXWAZtS5DKzMXlk2BQ/5Gvj1i8sz9C
 iN9oirgMF3n/+uB/ZEc0oeft++0ur2RIc3idOyaPq1mOl0SX3Fd8Uios1mdSyHoKzYsN
 XntQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD8CCkTkubOB8F22qCqnBE+iDV4ptLN/1uSQp++BL1kfn9xUzr+Zvmri7arUYQEFsu0QwiByXFLJwz@nongnu.org
X-Gm-Message-State: AOJu0YxQchHH6y+ZvfCHYTIcA/8VD8PyeW3aJkvnCBno6I7U+8UhB8dP
 gvGnswxW+adbODJ327m2/XB+iDJZTOH2h3GhewBEWfU/gmwb4736ZMVBb93nKXLsBE6f+C+ELQF
 f5O+wFnlFYWg/pC5ysOEUV3XlQ2Dh6CkeBIpq6rk7eXw3CzsbKyw4alk+1nmnQzHc
X-Gm-Gg: ASbGncsfOzUQJRO2IJVbk5c8kXd4tlkYuxwzFQ2/2ZBhxp/ZhvMVHbHtadzhDLjhGpL
 0kVJmyaXXb08e/7cIYoJ6+hjw1eGKhCaLLMM3Qz6/BgQmZ9KcUA8gPh4iOGqTFOIzJ2VYj+F/g3
 Dm6bEQTR1stim/9pIA89U38V1QNXkMrYS/i1WH1dQ79wPhlxMJlPGLWUQp1Vq+YPpI2EbFV3k/S
 WBp4XIMRnxHiitDg0DjVPUhJ/yYVDNO2rHfmLkR7RGONyJMhgvfyODnmEpBvoX+9xSqA7HczOQd
 jtdyyW2uJVVp9KmJxl9/krNcbBNzksbrP5BAAC/HmbBh8Nb82Gv1G1yXo7kqpWqlfKkUm77wxYN
 dAXN2x/SMh6LBmEf1ZOru5ZlJ2UBF3cFJWT2gkxU=
X-Received: by 2002:a17:903:a8f:b0:25c:8745:4a58 with SMTP id
 d9443c01a7336-2986a6b7c5dmr31680765ad.3.1763113622411; 
 Fri, 14 Nov 2025 01:47:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/4X/rTRSF2XpKMtrNxX3twv/5UpKh/LILbLve84kV/cCctqz1uCT3o4QAJOMS3DUBnY7d1Q==
X-Received: by 2002:a17:903:a8f:b0:25c:8745:4a58 with SMTP id
 d9443c01a7336-2986a6b7c5dmr31680535ad.3.1763113622035; 
 Fri, 14 Nov 2025 01:47:02 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bc36e8a58cfsm4243812a12.10.2025.11.14.01.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 01:47:01 -0800 (PST)
Message-ID: <0202443c-6446-460b-8a2c-2042dcfaf9cd@redhat.com>
Date: Fri, 14 Nov 2025 19:46:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] acpi/ghes: Use error_fatal in
 acpi_ghes_memory_errors()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com
References: <20251112172535.403042-1-gshan@redhat.com>
 <20251112172535.403042-8-gshan@redhat.com> <878qga5qi7.fsf@pond.sub.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <878qga5qi7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Markus,

On 11/13/25 5:41 PM, Markus Armbruster wrote:
> Gavin Shan <gshan@redhat.com> writes:
> 
>> Use error_fatal in acpi_ghes_memory_errors() so that the caller
>> needn't explicitly terminate on errors. With error_fatal, a qemu
>> core dump won't be provided as it doesn't provide anything needed
>> by debugging.
>>
>> There is no way to call ghes-stu.c::acpi_ghes_memory_errors(), an
>> abort() is put there as explicit marker. Besides, the return value
>> of acpi_ghes_memory_errors() is changed from 'int' to 'bool' as
>> the error indicator. ghes_record_cper_errors() also return a 'bool'
>> value for that, to be compatible to what is documented in error.h.
>>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> This commit does a number of things:
> 
> 1. Change abort() to exit() on error, and drop the extra error message
> "failed to record the error".
> 
> 2. Use &error_fatal to separate concerns and simplify the caller.  This
> item covers both the new Error ** parameter and the returning bool
> instead of void.
> 
> 3. Make the unreachable stub abort().
> 
> The commit message could use polish to make the three distinct things
> more clear.
> 
> In general, patches that do just one thing are easier to understand and
> describe (in the commit message) than patches that do multiple things.
> That said, a single commit feels okay in this case.  Up to you.
> 

Yes, it would be nice to do one thing per patch. I will split this into
3 patches as you suggested in next revision. I would wait a while to see
if Igor has more comments prior to next revision.

>> ---
>>   hw/acpi/ghes-stub.c    |  7 ++++---
>>   hw/acpi/ghes.c         | 27 +++++++++++++--------------
>>   include/hw/acpi/ghes.h |  7 ++++---
>>   target/arm/kvm.c       | 10 +++-------
>>   4 files changed, 24 insertions(+), 27 deletions(-)
>>
>> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
>> index 4faf573aeb..fc7374b0a6 100644
>> --- a/hw/acpi/ghes-stub.c
>> +++ b/hw/acpi/ghes-stub.c
>> @@ -11,10 +11,11 @@
>>   #include "qemu/osdep.h"
>>   #include "hw/acpi/ghes.h"
>>   
>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> -                            uint64_t *addresses, uint32_t num_of_addresses)
>> +bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> +                             uint64_t *addresses, uint32_t num_of_addresses,
>> +                             Error **errp)
>>   {
>> -    return -1;
>> +    abort();
>>   }
>>   
>>   AcpiGhesState *acpi_ghes_get_state(void)
>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>> index d3d6c11197..7160cf37d0 100644
>> --- a/hw/acpi/ghes.c
>> +++ b/hw/acpi/ghes.c
>> @@ -508,14 +508,14 @@ static bool get_ghes_source_offsets(uint16_t source_id,
>>   NotifierList acpi_generic_error_notifiers =
>>       NOTIFIER_LIST_INITIALIZER(acpi_generic_error_notifiers);
>>   
>> -void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>> +bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>                                uint16_t source_id, Error **errp)
>>   {
>>       uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
>>   
>>       if (len > ghes_max_raw_data_length(ags)) {
>>           error_setg(errp, "GHES CPER record is too big: %zd", len);
>> -        return;
>> +        return false;
>>       }
>>   
>>       if (!ags->use_hest_addr) {
>> @@ -524,7 +524,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>       } else if (!get_ghes_source_offsets(source_id,
>>                       le64_to_cpu(ags->hest_addr_le), &cper_addr,
>>                       &read_ack_register_addr, errp)) {
>> -            return;
>> +            return false;
>>       }
>>   
>>       cpu_physical_memory_read(read_ack_register_addr,
>> @@ -535,7 +535,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>           error_setg(errp,
>>                      "OSPM does not acknowledge previous error,"
>>                      " so can not record CPER for current error anymore");
>> -        return;
>> +        return false;
>>       }
>>   
>>       read_ack_register = cpu_to_le64(0);
>> @@ -550,10 +550,13 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>       cpu_physical_memory_write(cper_addr, cper, len);
>>   
>>       notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
>> +
>> +    return true;
>>   }
>>   
>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> -                            uint64_t *addresses, uint32_t num_of_addresses)
>> +bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> +                             uint64_t *addresses, uint32_t num_of_addresses,
>> +                             Error **errp)
>>   {
>>       /* Memory Error Section Type */
>>       const uint8_t guid[] =
>> @@ -564,10 +567,10 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>        * Table 17-13 Generic Error Data Entry
>>        */
>>       QemuUUID fru_id = {};
>> -    Error *errp = NULL;
>>       int data_length;
>>       GArray *block;
>>       uint32_t block_status = 0, i;
>> +    bool ret;
>>   
>>       block = g_array_new(false, true /* clear */, 1);
>>   
>> @@ -605,16 +608,12 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>       }
>>   
>>       /* Report the error */
> 
> This comment is now stale.  I'd simply drop it.
> 

Indeed, thanks.

>> -    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
>> +    ret = ghes_record_cper_errors(ags, block->data, block->len,
>> +                                  source_id, errp);
>>   
>>       g_array_free(block, true);
>>   
>> -    if (errp) {
>> -        error_report_err(errp);
>> -        return -1;
>> -    }
>> -
>> -    return 0;
>> +    return ret;
> 
> I figure you could use g_autoptr() to simplify this further.  Something
> along the lines of
> 
>         g_autoptr(GArray) block = g_array_new(false, true, 1);
> 
>         [...]
> 
>         return ghes_record_cper_errors(ags, block->data, block->len,
>                                        source_id, errp);
> 

Yes. It seems the pattern g_autoptr(GArray) isn't widely used in QEMU yet.
I will have one separate patch for this before the patches improving the
error (Error instead of memory error) handling in next revision.


>>   }
>>   
>>   AcpiGhesState *acpi_ghes_get_state(void)
>> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
>> index f7b084c039..c1f01ac25c 100644
>> --- a/include/hw/acpi/ghes.h
>> +++ b/include/hw/acpi/ghes.h
>> @@ -99,9 +99,10 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>>                        const char *oem_id, const char *oem_table_id);
>>   void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>>                             GArray *hardware_errors);
>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> -                            uint64_t *addresses, uint32_t num_of_addresses);
>> -void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>> +bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> +                             uint64_t *addresses, uint32_t num_of_addresses,
>> +                             Error **errp);
>> +bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>                                uint16_t source_id, Error **errp);
>>   
>>   /**
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 459ca4a9b0..b8c3ad2ad9 100644
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
>> +                                        addresses, 1, &error_fatal);
>> +                kvm_inject_arm_sea(c);
>>               }
>>               return;
>>           }
> 
> Readability improves nicely here.
> 

Yes :-)

Thanks,
Gavin



