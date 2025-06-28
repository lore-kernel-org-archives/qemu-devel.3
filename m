Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F738C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 19:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVbRz-0000V0-HF; Sat, 28 Jun 2025 15:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbRx-0000U9-M0
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:42:57 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbRv-0007Lg-H8
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:42:57 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7d41b04bf6fso96029685a.0
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751139774; x=1751744574; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8cFAKCpZ94rojrIIQVS0isZGEm4RULTPYcXzNgvCux4=;
 b=VeFEmSXMhJ+0hBKdAB0mwP8RpR792dd60DcWBQUfoNhSjsa+H4a8tUA9hTMF5sQrEL
 Or9+DBh4y2z24Q+x6AZU8xI0bIt64UauaJp8+eBUvcJz1zaAhexdgcEnpERWVaG6Ur0C
 wwH3wLT6yTeRHm8gMFN7EhfqhLFzv1hglRzdW1AI8qT5rFo0uJSwaP+4YKylsjY+5UX+
 yxD3ZBHB+dgAPpELEC1mmr+2OYlTyJnqQRrNwZJghNZ5sI/upkABBLn5dB6YMQbjsryB
 M+OLKgf/nnI4mev0Cv/avyWLzTDjvLnzCF8FimIshyrWhwdc8bQ3lU6VYK5H/7euCrTH
 Se+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751139774; x=1751744574;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8cFAKCpZ94rojrIIQVS0isZGEm4RULTPYcXzNgvCux4=;
 b=lWvZUJm98M3gRVNnvDp4ipuGJXkQbqiHjh+TkII4jTYaiWHTKfjejZtDaMc6lAukbq
 eg6JGv29Ec6nRs+wth0fL672je70rxjtx1Ezq34gkHfdtthqvZMVWhHxyAiQZImjq+5k
 28lJoPpfRqmY3NSPIKXu1MDCfwmAH+rJywHiBEv+yYikRTUYw3nioYoKZFXiTQMXM5kG
 kU12Q/u1TvTuwxs0QBqb0/E74FBOhKsdxX5bLn4fkO/eAH54G1ASy+V01pxfOE2cNCh5
 Tl+vgJFV2nYTHIt9neEH/e3v0leI4kaMryajxO4dM3yDKjoeQxd8SMOawDmOcnzLTwR3
 eNVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWQ9ACibA7aO70H7JA7zv1j7HIZkmuorwWq6zVRC+L6MrJTyrc/lFvFsVPsHzX+5R5k+U4LUItKU+2@nongnu.org
X-Gm-Message-State: AOJu0YzyotdXFW6umAE7oWKibX3eNzy4Hdx80oQ6v6nul1tvL8WDMwyP
 sYRSrm1tNhVtaDYMB63enzoojFlGvYbU1CJ8G7pir4JUoEggKKua06R6xwqfgSNiOhs=
X-Gm-Gg: ASbGnctYRuy9ZBYaLIH145hg6MatxLE1pt+o+S+v4wWIBtIrrFjomPTi4r3gkVk1dKW
 VYp0DSt5+uOQCMc7Q0+7oIpXmPmh+0qTXQy7qwmDSG+bueFrhbWTcbfjWB15h3vhq/VaXyw+060
 yHUkfNLNMn3GtHh7W/R5X4GAgIAnA4emcYUcU20pFdSDeiWFQRgoTmmKO6CN0ahexWnIkgoskdh
 eKwR3wgYdwrn6R3umVLit6ra8VAm8ZIOUHpCbWCBC004mHqJANE+q6U+g3rRwkKUrZmGqZIMiEu
 oPvKBdXnG7p3YWFK+d9mVWVCuIvFzPSM1oHnfquTk7USindBf2VHgv36zSLCmrIlJNgmxcGKcQ=
 =
X-Google-Smtp-Source: AGHT+IGCD8YQkKPEdVLSn9wkzwZ4R76YUA1qFX8wuyOw2+qymxi3ua1KPj4FOUQVqo/GNFqhxWSsRg==
X-Received: by 2002:a05:620a:444b:b0:7d2:2822:3f79 with SMTP id
 af79cd13be357-7d443906621mr1102945885a.13.1751139773786; 
 Sat, 28 Jun 2025 12:42:53 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.58.88])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443204c00sm335321385a.74.2025.06.28.12.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Jun 2025 12:42:53 -0700 (PDT)
Message-ID: <875034d4-c891-44db-bb09-0036ce932118@linaro.org>
Date: Sat, 28 Jun 2025 16:43:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] hw/arm/virt-acpi-build: Factor out
 create_its_idmaps
To: eric.auger@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
 <20250623135749.691137-6-gustavo.romero@linaro.org>
 <6990669d-7750-4f30-a11f-6ac06ffb266c@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <6990669d-7750-4f30-a11f-6ac06ffb266c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x733.google.com
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

Thanks a lot for another round of reviews :)

On 6/27/25 12:28, Eric Auger wrote:
> Hi Gustavo,
> 
> On 6/23/25 3:57 PM, Gustavo Romero wrote:
>> Factor out a new function, create_its_idmaps(), from the current
> I would call it build_rc_its_idmap() to be clearer on what relationship
> we build.
>> build_iort code. Add proper comments to it clarifying how the ID ranges
>> that go directly to the ITS Group node are computed based on the ones
>> that go to the SMMU node.
>>
>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   hw/arm/virt-acpi-build.c | 64 +++++++++++++++++++++++++---------------
>>   1 file changed, 41 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index e9cd3fb351..40a782a498 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -266,6 +266,42 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>>       return idmap_a->input_base - idmap_b->input_base;
>>   }
>>   
>> +/* Compute ID ranges (RIDs) from RC that do directly to the ITS Group node */
> s/do/go
> Ior use the spec terminology: that are directed to the ITS Group node

Thanks, I stuck to "directed to" in v6.


>> +static void create_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
>> +{
>> +    AcpiIortIdMapping *idmap;
>> +    AcpiIortIdMapping next_range = {0};
>> +
>> +    /*
>> +     * Based on the RID ranges that go to the SMMU, determine the bypassed RID
> same here
>> +     * ranges, i.e., the ones that go directly to the ITS Group node, by
>> +     * subtracting the SMMU-bound ranges from the full RID range, 0x0000–0xFFFF.
> substracting

I believe that "subtracting" is the correct form (but I'm not a native English speaker, of course).
It seems the "substract" is sometimes used in ancient texts and I do see them occurring in the
commit messages, but they occur much less frequently than "subtract":

gromero@gromero0:/mnt/git/qemu_/build$ git log | grep substract | wc -l
13
gromero@gromero0:/mnt/git/qemu_/build$ git log | grep subtract | wc -l
188


Cheers,
Gustavo

>> +     */
>> +     for (int i = 0; i < smmu_idmaps->len; i++) {
>> +        idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>> +
>> +        if (next_range.input_base < idmap->input_base) {
>> +            next_range.id_count = idmap->input_base - next_range.input_base;
>> +            g_array_append_val(its_idmaps, next_range);
>> +        }
>> +
>> +        next_range.input_base = idmap->input_base + idmap->id_count;
>> +    }
>> +
>> +    /*
>> +     * Append the last RC -> ITS ID mapping.
>> +     *
>> +     * RIDs are 16-bit, according to the PCI Express 2.0 Base Specification, rev
>> +     * 0.9, section 2.2.6.2, "Transaction Descriptor - Transaction ID Field",
>> +     * hence, the end of the range is 0x10000.
>> +     */
>> +    if (next_range.input_base < 0x10000) {
>> +        next_range.id_count = 0x10000 - next_range.input_base;
>> +        g_array_append_val(its_idmaps, next_range);
>> +    }
>> +}
>> +
>> +
>>   /*
>>    * Input Output Remapping Table (IORT)
>>    * Conforms to "IO Remapping Table System Software on ARM Platforms",
>> @@ -276,7 +312,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>   {
>>       int i, nb_nodes, rc_mapping_count;
>>       size_t node_size, smmu_offset = 0;
>> -    AcpiIortIdMapping *idmap;
>>       uint32_t id = 0;
>>       GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>>       GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>> @@ -287,34 +322,17 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>       acpi_table_begin(&table, table_data);
>>   
>>       if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>> -        AcpiIortIdMapping next_range = {0};
>> -
>>           object_child_foreach_recursive(object_get_root(),
>>                                          iort_host_bridges, smmu_idmaps);
>>   
>>           /* Sort the smmu idmap by input_base */
>>           g_array_sort(smmu_idmaps, iort_idmap_compare);
>>   
>> -        /*
>> -         * Split the whole RIDs by mapping from RC to SMMU,
>> -         * build the ID mapping from RC to ITS directly.
>> -         */
>> -        for (i = 0; i < smmu_idmaps->len; i++) {
>> -            idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>> -
>> -            if (next_range.input_base < idmap->input_base) {
>> -                next_range.id_count = idmap->input_base - next_range.input_base;
>> -                g_array_append_val(its_idmaps, next_range);
>> -            }
>> -
>> -            next_range.input_base = idmap->input_base + idmap->id_count;
>> -        }
>> -
>> -        /* Append the last RC -> ITS ID mapping */
>> -        if (next_range.input_base < 0x10000) {
>> -            next_range.id_count = 0x10000 - next_range.input_base;
>> -            g_array_append_val(its_idmaps, next_range);
>> -        }
>> +	/*
>> +	 * Knowing the ID ranges from the RC to the SMMU, it's possible to
>> +	 * determine the ID ranges from RC that go directly to ITS.
> are directed to
>> +	 */
>> +        create_its_idmaps(its_idmaps, smmu_idmaps);
>>   
>>           nb_nodes = 3; /* RC, ITS, SMMUv3 */
>>           rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
> Thanks
> 
> Eric
> 


