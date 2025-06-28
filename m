Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AD4C7EE39
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 19:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVbSo-0000pw-Vc; Sat, 28 Jun 2025 15:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbSm-0000mi-AE
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:43:48 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbSk-0007PD-5k
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:43:48 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7d0a0bcd3f3so347227085a.1
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751139825; x=1751744625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3febMVu0X5KFhPdL2zwTsQIDWAfULnvvVNn5EAdat80=;
 b=G9I81Bf/ZqZYPNg4iweWpj6yGMLxqheiHus/c2pyN8Xl4Agabb9UcdGg7YsCpkZkhS
 31BJBYLLb1odvKOOYduquC3mfck1/CVx5eC5axEhCxwrJzaWF82qnY1TfU3iXSOf8uXf
 8tdQJ7irmHQyG7InQbjwIBSfXcCLLYAVkBfGb87fXZKvhWYYuOjxOXRvHYhtDMCjewxq
 ch+YJvXCui3ALp8BXmJeIPDdXRjAf73hVua1ryty2xnd1NzQTovZMXwQ2y8dH7tFA02h
 XfxwRIRJdI68DjkdCzNEhco7COs1t4e8uRTX9QFDrYkAR+20qijMtu92NT+KkPwM6ayW
 a/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751139825; x=1751744625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3febMVu0X5KFhPdL2zwTsQIDWAfULnvvVNn5EAdat80=;
 b=vSatVKJ8ehS7zSiioT12GbyuZmRbkTADOw6ubIZCIPRNHrA4x5yesjDh3808Wi8+M9
 aXkbN8K58pSCv98ZrPQdXyEwWVSIXkjtnwl7jNIp241Mi2ucKAy/j1BqeDhdhbQ7Qu/o
 omggVcWairwzDzSlEcREljuAAEKbV5hC0B8Q0rslYbHtJVzDAFp1fF5JdEjwE9Y2zmUl
 VbHrMU1JPlVut3jhwqt5ZB1IMCZaTDpuiGlHn2ytHvPU3vZ0u1VBatxKfyJe/F6dpiSr
 rHCUXMD2PITZnqtmtPYZfqNuRzC9CIppAN7fVvXN0sZJTlj1sZZ9VidL/sZqBd8NoYK8
 ReWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULUxOKI272qMKlfUsRoO3otu58iqDKyLojiIsSKKfz3vvU/vOI4AYJE+eutcYEFlJhNTZsdZVaLSjL@nongnu.org
X-Gm-Message-State: AOJu0YyglwCOCFG8pyDZyi8nlwiC+iZaJ7ZR7tfOcSBIcp2FAbJvqto6
 qwCU/QoFs1erEcx001w5/4gAjanxHPUnGAf+V/bxTHeAnbI8q4Uf3Xb7S+YBQ2+A9p0=
X-Gm-Gg: ASbGncuK2Scc3tinmVS1Up4AXID04KO6+5LGGBNcEWDt6GzCoie/U1HgtWgHqanhiDS
 DFLWKe7wOACAEzMG0p+8HpCi2vy9JcvDPtW39s0kALKMKKb9HwXmAfGpYkvlALWpOuQ4WJyj484
 joYzEq8AkQWSiKanKJbqWG6NMYiqUCn92EYrS1xqkECVwAj228BH1KS+BqTKIlAy7+nIyF1E9+H
 fo3xvCJkUlFajnee0/Vo6nr4qq/mXVT1HKEka42N7sgtgXtSipvW1KEMvL7Ww7U28WG7JuqBCJM
 6TIBYJoVPFybYiyCe9Jz/RvxpVlhgCESqlSnYQbc/Whi5v79Xxe62mJSb8wF6xTIyanvqdXs32A
 QDnXOYzE1
X-Google-Smtp-Source: AGHT+IGguvOPNXhWsYjleLw6zKR6nVVKQ0gnbcCBPqK0K/Q9ZZlNsVp3PTCV3IIsPJRuw+awwCSX1g==
X-Received: by 2002:a05:620a:6983:b0:7d0:9acc:c86b with SMTP id
 af79cd13be357-7d44418ce27mr757932185a.19.1751139824792; 
 Sat, 28 Jun 2025 12:43:44 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.58.88])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44322d63csm332921885a.95.2025.06.28.12.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Jun 2025 12:43:44 -0700 (PDT)
Message-ID: <85259079-e40c-4550-b251-c35110557d3f@linaro.org>
Date: Sat, 28 Jun 2025 16:44:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] hw/arm/virt-acpi-build: Fix ACPI IORT and MADT
 tables when its=off
To: eric.auger@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
 <20250623135749.691137-9-gustavo.romero@linaro.org>
 <5e0e0aa6-cc09-4aa3-b48c-65de8273549c@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <5e0e0aa6-cc09-4aa3-b48c-65de8273549c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x730.google.com
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

On 6/27/25 12:44, Eric Auger wrote:
> Hi Gustavo,
> 
> On 6/23/25 3:57 PM, Gustavo Romero wrote:
>> Currently, the ITS Group nodes in the IORT table and the GIC ITS Struct
>> in the MADT table are always generated, even if GIC ITS is not available
>> on the machine.
>>
>> This commit fixes it by not generating the ITS Group nodes, not mapping
>> any other node to them, and not advertising the GIC ITS in the MADT
>> table, when GIC ITS is not available on the machine.
>>
>> Since the fix changes the MADT and IORT tables, add the blobs for the
>> "its=off" test to the allow list and update them in the next commit.
>>
>> Reported-by: Udo Steinberg <udo@hypervisor.org>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2886
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Co-authored-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/virt-acpi-build.c                    | 128 ++++++++++++--------
>>   tests/qtest/bios-tables-test-allowed-diff.h |   2 +
>>   2 files changed, 80 insertions(+), 50 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 40a782a498..17ae46804a 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -328,17 +328,27 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>           /* Sort the smmu idmap by input_base */
>>           g_array_sort(smmu_idmaps, iort_idmap_compare);
>>   
>> -	/*
>> -	 * Knowing the ID ranges from the RC to the SMMU, it's possible to
>> -	 * determine the ID ranges from RC that go directly to ITS.
>> -	 */
>> -        create_its_idmaps(its_idmaps, smmu_idmaps);
>> -
>> -        nb_nodes = 3; /* RC, ITS, SMMUv3 */
>> -        rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
>> +        nb_nodes = 2; /* RC and SMMUv3 */
>> +        rc_mapping_count = smmu_idmaps->len;
>> +
>> +        if (vms->its) {
>> +            /*
>> +             * Knowing the ID ranges from the RC to the SMMU, it's possible to
>> +             * determine the ID ranges from RC that go directly to ITS.
>> +             */
>> +            create_its_idmaps(its_idmaps, smmu_idmaps);
>> +
>> +            nb_nodes++; /* ITS */
>> +            rc_mapping_count += its_idmaps->len;
>> +        }
>>       } else {
>> -        nb_nodes = 2; /* RC, ITS */
>> -        rc_mapping_count = 1;
>> +        if (vms->its) {
>> +            nb_nodes = 2; /* RC and ITS */
>> +            rc_mapping_count = 1; /* Direct map to ITS */
>> +        } else {
>> +            nb_nodes = 1; /* RC only */
>> +            rc_mapping_count = 0; /* No output mapping */
>> +        }
>>       }
>>       /* Number of IORT Nodes */
>>       build_append_int_noprefix(table_data, nb_nodes, 4);
>> @@ -347,31 +357,43 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>       build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
>>       build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>>   
>> -    /* Table 12 ITS Group Format */
>> -    build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
>> -    node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
>> -    build_append_int_noprefix(table_data, node_size, 2); /* Length */
>> -    build_append_int_noprefix(table_data, 1, 1); /* Revision */
>> -    build_append_int_noprefix(table_data, id++, 4); /* Identifier */
>> -    build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
>> -    build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
>> -    build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
>> -    /* GIC ITS Identifier Array */
>> -    build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
>> +    if (vms->its) {
>> +        /* Table 12 ITS Group Format */
>> +        build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
>> +        node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
>> +        build_append_int_noprefix(table_data, node_size, 2); /* Length */
>> +        build_append_int_noprefix(table_data, 1, 1); /* Revision */
>> +        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
>> +        build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
>> +        build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
>> +        build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
>> +        /* GIC ITS Identifier Array */
>> +        build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
>> +    }
>>   
>>       if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>>           int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
>> -
>> +        int num_id_mappings, offset_to_id_array;
>> +
>> +        if (vms->its) {
>> +            num_id_mappings = 1; /* ITS Group node */
> While at it, I would suggest to rename num_id_mappings into
> smmu_mapping_count for consistency with
> 
> rc_mapping_count.
> 
> Also I would recommend to rename smmu_idmaps and its_idmaps into rc_smmu_idmaps and rc_its_idmaps to make things clearer. But that be done outside of thise series if you prefer.

Thanks, that's indeed a nice change for clarification. I've done it in v6.


> Otherwise this looks good.

I was not sure if I had to add your R-b in v6 after I addressed your comments so
I left v6 without a R-b.


Cheers,
Gustavo

> Thanks
> 
> Eric
> 
>> +            offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
>> +        } else {
>> +            num_id_mappings = 0; /* No ID mappings */
>> +            offset_to_id_array = 0; /* No ID mappings array */
>> +        }
>>           smmu_offset = table_data->len - table.table_offset;
>>           /* Table 9 SMMUv3 Format */
>>           build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
>> -        node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
>> +        node_size =  SMMU_V3_ENTRY_SIZE +
>> +                     (ID_MAPPING_ENTRY_SIZE * num_id_mappings);
>>           build_append_int_noprefix(table_data, node_size, 2); /* Length */
>>           build_append_int_noprefix(table_data, 4, 1); /* Revision */
>>           build_append_int_noprefix(table_data, id++, 4); /* Identifier */
>> -        build_append_int_noprefix(table_data, 1, 4); /* Number of ID mappings */
>> +        /* Number of ID mappings */
>> +        build_append_int_noprefix(table_data, num_id_mappings, 4);
>>           /* Reference to ID Array */
>> -        build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
>> +        build_append_int_noprefix(table_data, offset_to_id_array, 4);
>>           /* Base address */
>>           build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
>>           /* Flags */
>> @@ -387,9 +409,11 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>           build_append_int_noprefix(table_data, 0, 4); /* Proximity domain */
>>           /* DeviceID mapping index (ignored since interrupts are GSIV based) */
>>           build_append_int_noprefix(table_data, 0, 4);
>> -
>> -        /* Output IORT node is the ITS Group node (the first node) */
>> -        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>> +        /* Array of ID mappings */
>> +        if (num_id_mappings) {
>> +            /* Output IORT node is the ITS Group node (the first node). */
>> +            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>> +        }
>>       }
>>   
>>       /* Table 17 Root Complex Node */
>> @@ -430,7 +454,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>            *
>>            * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS) is
>>            * defined in the SMMUv3 table, where all SMMUv3 IDs are mapped to the
>> -         * ITS Group node.
>> +         * ITS Group node, if ITS is available.
>>            */
>>           for (i = 0; i < smmu_idmaps->len; i++) {
>>               range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>> @@ -439,15 +463,17 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>                                     range->id_count, smmu_offset);
>>           }
>>   
>> -        /*
>> -         * Map bypassed (don't go throught the SMMU) RIDs (input) to ITS Group
>> -         * node directly: RC -> ITS.
>> -         */
>> -        for (i = 0; i < its_idmaps->len; i++) {
>> -            range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
>> -            /* Output IORT node is the ITS Group node (the first node). */
>> -            build_iort_id_mapping(table_data, range->input_base,
>> -                                  range->id_count, IORT_NODE_OFFSET);
>> +        if (vms->its) {
>> +            /*
>> +             * Map bypassed (don't go throught the SMMU) RIDs (input) to ITS Group
>> +             * node directly: RC -> ITS.
>> +             */
>> +            for (i = 0; i < its_idmaps->len; i++) {
>> +                range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
>> +                /* Output IORT node is the ITS Group node (the first node). */
>> +                build_iort_id_mapping(table_data, range->input_base,
>> +                                      range->id_count, IORT_NODE_OFFSET);
>> +            }
>>           }
>>       } else {
>>           /*
>> @@ -768,18 +794,20 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>                                             memmap[VIRT_HIGH_GIC_REDIST2].size);
>>           }
>>   
>> -        /*
>> -         * ACPI spec, Revision 6.0 Errata A
>> -         * (original 6.0 definition has invalid Length)
>> -         * 5.2.12.18 GIC ITS Structure
>> -         */
>> -        build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
>> -        build_append_int_noprefix(table_data, 20, 1);   /* Length */
>> -        build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
>> -        build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
>> -        /* Physical Base Address */
>> -        build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
>> -        build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
>> +        if (vms->its) {
>> +            /*
>> +             * ACPI spec, Revision 6.0 Errata A
>> +             * (original 6.0 definition has invalid Length)
>> +             * 5.2.12.18 GIC ITS Structure
>> +             */
>> +            build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
>> +            build_append_int_noprefix(table_data, 20, 1);   /* Length */
>> +            build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
>> +            build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
>> +            /* Physical Base Address */
>> +            build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
>> +            build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
>> +        }
>>       } else {
>>           const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
>>   
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>> index dfb8523c8b..a88198d5c2 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1 +1,3 @@
>>   /* List of comma-separated changed AML files to ignore */
>> +"tests/data/acpi/aarch64/virt/APIC.its_off",
>> +"tests/data/acpi/aarch64/virt/IORT.its_off",
> 


