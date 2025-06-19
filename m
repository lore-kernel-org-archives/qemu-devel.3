Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9671EC7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 17:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSIjZ-0001IP-PL; Thu, 19 Jun 2025 13:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uSIjP-0001Hr-Ro
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 13:07:20 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uSIjN-0003Rl-Fj
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 13:07:19 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-748e63d4b05so530662b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 10:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750352835; x=1750957635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jll/2OF16vBpj1RgCeTtn0mBj/Ho38D8H1rIBCC+nOs=;
 b=Ga4cfxo0lE/i67CJ6qBNYcvhozrKmEo3wXaetd9r+G211qN8zOAI7jC/KoezZsLbMp
 rsrjs7IvSKYPSXg7Hj2pIzWcPXolWLXs/w4lr/tYKFnSCHrr5XQzOYpvAtJRj8LgPTyx
 mjGFUN62bDBOL03Tb3MYBVTw4QORhjgbFABPKmOx8f+LSiBdOC9Ab6WK8ORBod54VP6m
 Wvvk9wMt7NX8GoPqnM/yJ6ofG4qi9W+IBp+iIoEdorS0g4QbXYBaWwQVo08qYfjwXWW2
 jZSXrtpzp4STvsi8YXDydrqYrtJ6wuHQeNMEThU7k4TqV0j/EIZa+EXU4xq4YVts9BH6
 su5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750352835; x=1750957635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jll/2OF16vBpj1RgCeTtn0mBj/Ho38D8H1rIBCC+nOs=;
 b=fm42zW/68MPdL/bQTCNHxVj7SdXhLdkMT488uTwhYScAhd00ID03LoLdMhj6vACoGf
 +jSL1lHp4hP8bR9KYH7TVg7A/GimfIgQYzCdBGY8aZ/WWa9DhyzntQhiZZL4F8xUB4f+
 CXrnioYw+pntJFBI6y7QOUY5fFWRPNZX1fB+DQn9XKHuZz8QPg10MszhpJszZPAfSmkz
 qnthNSM3imLlwc7/jKOhCt4qN5d4CUp4OWuwUxGe1vVWhDd1gq4FLuSqK4bWewx2Wjjn
 SskyCPRD8+GqnmusFhO+rmQHvbyBOLLPYvJVL9XTiDdSD+HuI5WzseOk5/33Cf9kRYd6
 lmyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmNpU/nJ0B8zBEXXMMENdCTWAvZikEgln0rxios1lNsyIOAjI52gNfSH+nOW8VCPyHnUQvASw+NDmR@nongnu.org
X-Gm-Message-State: AOJu0YxW3MRs5FEl9K7aTe4mrm3rN6wjfi3I2Rw9jVihOl/SE73QHHqd
 /6uZGhJZvLO6epnn+wuYl85eaLx8GqSv67AJ1zdbSStsQEPWZ7I2S/eFco9ksz+G0Lo=
X-Gm-Gg: ASbGncsv6AX/V5zoGn04L51MXs9yFXbWliVNmACu8hkV8LhBY24PwNWf9P8IVDTDA+F
 H4q28A0ywSxwJ47fkPaHNXV14b8jH79NznlLkRp1xqEanIegSaroUdiK73BQZRaD1fo0/eMEmlu
 DfiszljJZ3HHYO5H9B6yyJyZ3LguO/ZzChbWZ5S1Yt+Wr67Apf7tVq3NbEO2xhMuaWtuFzaWCXZ
 MM08XR5VGgKrwTghrlvZuFV+d6onuQ8x74zivQjtXXQRiri95GdsUJ6FTC1CdJOdcmAC/UfQvNB
 D7tILmFCEVWishTijzzovCu/UXNXIWoySopns/mtcLtMPdsUQH3T+YtLSzUCqetA9nlLsH6Cjg=
 =
X-Google-Smtp-Source: AGHT+IEcQD+iM5dzT1mlqtovayUFGR9kigzcwB+Npw7tH3Lxerm48HzH0/niYYRWnfq99fe88FvJMw==
X-Received: by 2002:a05:6a20:e609:b0:216:1ea0:a526 with SMTP id
 adf61e73a8af0-21fbd5ddde0mr38311580637.40.1750352835306; 
 Thu, 19 Jun 2025 10:07:15 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.60.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a64be0asm250750b3a.126.2025.06.19.10.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 10:07:14 -0700 (PDT)
Message-ID: <53c901c4-f408-43f6-a9aa-49f8fed59e98@linaro.org>
Date: Thu, 19 Jun 2025 14:07:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] hw/arm/virt-acpi-build: Fix comment in build_iort
To: eric.auger@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <20250616131824.425315-5-gustavo.romero@linaro.org>
 <db5aa1ab-cec7-4de1-b14f-bba978e7d7f7@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <db5aa1ab-cec7-4de1-b14f-bba978e7d7f7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Eric,

On 6/17/25 10:22, Eric Auger wrote:
> Hi Gustavo,
> 
> On 6/16/25 3:18 PM, Gustavo Romero wrote:
>> The comment about the mapping from SMMU to ITS is incorrect and it reads
>> "RC -> ITS". The code in question actually maps SMMU -> ITS, so the
>> mapping in question is not direct. The direct mapping, i.e., RC -> ITS,
>> is handled a bit further down in the code, in the else block, and we
>> take the opportunity to update that as well, adding "RC -> ITS" to the
>> text so it's easier to see it's the direct map to the ITS Group node.
>>
>> Signed-off-by Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   hw/arm/virt-acpi-build.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 9eee284c80..6990bce3bb 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -407,23 +407,27 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>       if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>>           AcpiIortIdMapping *range;
>>   
>> -        /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
>> +        /* Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3. */
> yes this is what the code builds at this location.
>>           for (i = 0; i < smmu_idmaps->len; i++) {
>>               range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>> -            /* output IORT node is the smmuv3 node */
>> +            /* Output IORT node is the SMMUv3 node. */
>>               build_iort_id_mapping(table_data, range->input_base,
>>                                     range->id_count, smmu_offset);
>>           }
>>   
>> -        /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
>> +        /* Map DeviceIDs (input) from SMMUv3 to ITS Group nodes: SMMU -> ITS. */
> But here I am confused. To me the its_idmaps matches the idmap between
> RC and ITS. I understand this is built from holes left by bypassed
> buses. See the build_iort() implementation. The comment at

ah, thanks! I see. Indeed, it's mapping the RC -> ITS, not the SMMU -> ITS.
I'll fix it in v5.

One thing that confused me, which I think is actually ok, is that the
output ID range from SMMU 0x000-0xFFFF) overlaps the output ID range
from the RC (e.g. 0x100-0xFFFF) because the SMMU output range is defined as
always taking the whole 16-bit range in:

[...]
    366         build_append_int_noprefix(table_data, irq + 1, 4); /* PRI */
    367         build_append_int_noprefix(table_data, irq + 3, 4); /* GERR */
    368         build_append_int_noprefix(table_data, irq + 2, 4); /* Sync */
    369         build_append_int_noprefix(table_data, 0, 4); /* Proximity domain */
    370         /* DeviceID mapping index (ignored since interrupts are GSIV based) */
    371         build_append_int_noprefix(table_data, 0, 4);
    372
    373         /* output IORT node is the ITS group node (the first node) */
    374         build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET); <=========== HERE
    375     }
    376
    377     /* Table 17 Root Complex Node */


I think that's ok since ITS can disambiguate the Device IDs from SMMU and from RC.


>          /*
>           * Split the whole RIDs by mapping from RC to SMMU,
>           * build the ID mapping from RC to ITS directly.
>           */
>          for (i = 0; i < smmu_idmaps->len; i++) {
>              idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> 
>              if (next_range.input_base < idmap->input_base) {
>                  next_range.id_count = idmap->input_base -
> next_range.input_base;
>                  g_array_append_val(its_idmaps, next_range);
>              }
> 
>              next_range.input_base = idmap->input_base + idmap->id_count;
>          }
> 
> is not crystal clear but it looks like filling the holes into its_idmap.

k, I'll create a helper as you suggested in 7/8 to populate the its_idmaps.

  > Besides there is another "Its group" instance to be replaced by ITS Group

Pardon, what do you mean? Another text to be replaced or it's just a comment
about the "else" block when smmu is off?

Thanks!


Cheers,
Gustavo

> Eric
> 
>>           for (i = 0; i < its_idmaps->len; i++) {
>>               range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
>> -            /* output IORT node is the ITS group node (the first node) */
>> +            /* Output IORT node is the ITS Group node (the first node). */
>>               build_iort_id_mapping(table_data, range->input_base,
>>                                     range->id_count, IORT_NODE_OFFSET);
>>           }
>>       } else {
>> -        /* output IORT node is the ITS group node (the first node) */
>> +        /*
>> +         * Map bypassed RIDs (input) (don't go through the SMMU) to ITS Group
>> +         * nodes: RC -> ITS.
>> +         * Output IORT node is the ITS Group node (the first node).
>> +         */
>>           build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>>       }
>>   
> 


