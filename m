Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D31D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 14:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ4gn-0007Ad-LG; Mon, 01 Dec 2025 09:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ4gk-0007AJ-GS
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:15:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ4gh-0007xB-8E
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764598534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRimqVUdrfhnSN8lnxeb4rNnaVCQkkqSk+hKq8qjfsQ=;
 b=VVxhp39e6AQA0I2O5/1P1lS1P7ylTHeij3bmGsfuOan21o4rNz1+rd374Pk6tBKMGx0SfI
 w0+ba1kZ/6R05X12xKPkBiUmEKYwcehdiw93T365gCQsvyNY69ZmtkVmuzzON+mJMasO2F
 ci0Ubopa6YwbHxK9WYLEjtXT3oBt21w=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-eVoBgN_xP0yQwqNyLJYWCA-1; Mon, 01 Dec 2025 09:15:33 -0500
X-MC-Unique: eVoBgN_xP0yQwqNyLJYWCA-1
X-Mimecast-MFC-AGG-ID: eVoBgN_xP0yQwqNyLJYWCA_1764598532
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2955f0b8895so48342775ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 06:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764598531; x=1765203331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lRimqVUdrfhnSN8lnxeb4rNnaVCQkkqSk+hKq8qjfsQ=;
 b=BErWbOm3OoVCJX/o5YJA0YzxKRspl92j+gmQ8TWS46gtuyIyC0wkVcucpuznhVNLpE
 UL95zJtWzt4qO9dC2idlKrr9RdX4Zyr1RhBLoXMWnl7UczhyrBbWoZmG4TPaf03SRLhX
 lhk8080kr0oszvrHYa2rTnz8EiftcGsNoeacEEQ5upGblN1VOHmjcY03w3wF0D+hUHKK
 D4VaL05fKtb5s+jmKdDPnaj3CFuBTpDN7jHxJcFz5Nr+JSh653TgZhesEDAtwck6ogWx
 TTzbUO40UX9VH3QaGcBxnNQmCHD0p2nAJZqlzi9x3N2dyvEKQmPuoUTnMC5OdL+GQT4s
 ulCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764598531; x=1765203331;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lRimqVUdrfhnSN8lnxeb4rNnaVCQkkqSk+hKq8qjfsQ=;
 b=DJerrVsnohOpbOWRSc8CZ2PuBCHzJDVZ55W5eBNPD4ArBr3YJnQpqag1dnxFeptNkJ
 04jl9Tqj+3vBWcE7qwBMS7J+nWm2Ri7tFjYtvBZUv7b849JmYxalzhl9p/31TbSJqKBj
 1/kjZD6aftWoKR8z9MU5COcEazA92BT6d41szj68zDLatLkgZk8Bk+Bm94njHQck0x7f
 iK5JKzk+C9unJUT0dmv7gTyz/xxRRFOG8EU40VZ2h+MZdMuTsv2osMMo93nNFjLdd0t1
 1V/M7EjiiN6wNfoD2RCP1cmCXkXwpM1Khn5eDyWCt88w8vXdmMxrQDlY96i7qEqjbHJ5
 z2WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9MQpc0EIEvtvWqLTfMqgCcFVAl2QvkXNP0MiO4QM77cl0cdM6x7NezeOkeQRHCtgFZPWj7UDfGkvQ@nongnu.org
X-Gm-Message-State: AOJu0YxZP74b+L4CIpcsQPFPcqiq1xBoJpWRiTlzM741DVeLb2eVHJYj
 y/dAyXmBXal+N+fTQBOyTkazmwkNL9AI6WKOfSATi0bnLYCJ/9Huvh0QXgfVcJnO56ZWLMUx09T
 cz0CYRnLlLKtDPfwqyIItG1GS1hlvdQn5CH/FEeMBHMLfjAsBuL+Cy/H4URTFH9+i
X-Gm-Gg: ASbGncu1RsxHQcHbMzqAskYvmAPUnMEu6QiQasjaZaIaSvx2lJGcnAGxXNtRAYYPUVf
 U9JOSFwD7uLge9SI+0U4OGwAlditVJaZ/8A0hks782dLoutokr9mFS+Dwnh4vSb/1m2cUjj60n7
 Mma6LD4b2TSCwdY/AF26rlbFbtkJxE27jNiLf/P1WBetUzoKODn7Mnmn277NBa6UC22CQztqMex
 5BbWyK9Tm6Ll1siG2Cf70Txy35gPujfG41+BelUvcWJcgU/Y0Y3wYtdvl13jmFWGvS0XVP680+C
 1Z4KKxasUFlmeLcs2wslwi6ODcDuy981PD06LYgkUH+2MhgY5UYoTAL4hJSBnPr6IYuWoGD1zck
 W4Av92FFTyq1WHpdvN6IuQ/JQvlfZMlVLC6T22dUHi3vlK7JYjg==
X-Received: by 2002:a17:90b:5626:b0:343:cfa1:c458 with SMTP id
 98e67ed59e1d1-3473346ea40mr39657198a91.18.1764598531286; 
 Mon, 01 Dec 2025 06:15:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErX3sPZK0s5undad65f7ioCTdwRsgWt3H5r43OEblW7IcWgqWTJDlkp5rhcnRowawH75DkVQ==
X-Received: by 2002:a17:90b:5626:b0:343:cfa1:c458 with SMTP id
 98e67ed59e1d1-3473346ea40mr39657105a91.18.1764598530456; 
 Mon, 01 Dec 2025 06:15:30 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3476a7bd7f3sm16975827a91.13.2025.12.01.06.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 06:15:29 -0800 (PST)
Message-ID: <7893cf54-8fc6-47dc-a1a1-ebb8fd0f6036@redhat.com>
Date: Tue, 2 Dec 2025 00:15:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] acpi/ghes: Bail early on error from
 get_ghes_source_offsets()
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251127004435.2098335-5-gshan@redhat.com>
 <20251201111048.17551273@imammedo>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251201111048.17551273@imammedo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Igor,

On 12/1/25 8:10 PM, Igor Mammedov wrote:
> On Thu, 27 Nov 2025 10:44:34 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> For one particular error (Error), we can't call error_setg() for twice.
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> I can't really parse that
> maybe rephrase it to make some sense?
> 

I will drop this sentence in v2.

>> Otherwise, the assert(*errp == NULL) will be triggered unexpectedly in
>> error_setv(). In ghes_record_cper_errors(), get_ghes_source_offsets()
>> can return a error initialized by error_setg(). Without bailing on
>> this error, it can call into the second error_setg() due to the
>> unexpected value from the read acknowledgement register.
>>
>> Bail early in ghes_record_cper_errors() when error is received from
>> get_ghes_source_offsets() to avoid the exception.
>>

With above sentence dropped, the commit log improved to something like
below in v2.

In ghes_record_cper_errors(), get_ghes_source_offsets() can return
a error initialized by error_setg(). Without bailing on this error,
it can call into the second error_setg() due to the unexpected value
returned from the read acknowledgement register. The second error_setg()
can trigger assert(*errp == NULL) in its callee error_setv(), which
isn't expected.
     
Bail early in ghes_record_cper_errors() when error is received from
get_ghes_source_offsets() to avoid the unexpected behavior.


>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> patch itself LGTM
> and with commit message fixed
>    Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
>> ---
>>   hw/acpi/ghes.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>> index 6366c74248..c35883dfa9 100644
>> --- a/hw/acpi/ghes.c
>> +++ b/hw/acpi/ghes.c
>> @@ -443,7 +443,7 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>>       *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
>>   }
>>   
>> -static void get_ghes_source_offsets(uint16_t source_id,
>> +static bool get_ghes_source_offsets(uint16_t source_id,
>>                                       uint64_t hest_addr,
>>                                       uint64_t *cper_addr,
>>                                       uint64_t *read_ack_start_addr,
>> @@ -474,7 +474,7 @@ static void get_ghes_source_offsets(uint16_t source_id,
>>           /* For now, we only know the size of GHESv2 table */
>>           if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
>>               error_setg(errp, "HEST: type %d not supported.", type);
>> -            return;
>> +            return false;
>>           }
>>   
>>           /* Compare CPER source ID at the GHESv2 structure */
>> @@ -488,7 +488,7 @@ static void get_ghes_source_offsets(uint16_t source_id,
>>       }
>>       if (i == num_sources) {
>>           error_setg(errp, "HEST: Source %d not found.", source_id);
>> -        return;
>> +        return false;
>>       }
>>   
>>       /* Navigate through table address pointers */
>> @@ -508,6 +508,8 @@ static void get_ghes_source_offsets(uint16_t source_id,
>>       cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
>>                                sizeof(*read_ack_start_addr));
>>       *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
>> +
>> +    return true;
>>   }
>>   
>>   NotifierList acpi_generic_error_notifiers =
>> @@ -526,9 +528,10 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>       if (!ags->use_hest_addr) {
>>           get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>>                                &cper_addr, &read_ack_register_addr);
>> -    } else {
>> -        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
>> -                                &cper_addr, &read_ack_register_addr, errp);
>> +    } else if (!get_ghes_source_offsets(source_id,
>> +                    le64_to_cpu(ags->hest_addr_le),
>> +                    &cper_addr, &read_ack_register_addr, errp)) {
>> +            return;
>>       }
>>   
>>       cpu_physical_memory_read(read_ack_register_addr,
> 

Thanks,
Gavin


