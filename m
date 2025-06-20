Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321C8C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 06:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSVc2-00049D-0o; Fri, 20 Jun 2025 02:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSVbu-00048Z-EF
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 02:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSVbr-000471-Vz
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 02:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750402342;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNd8pxyRKBYHOOxHPV6siKNUfLozEByTZ8WWKyQJIow=;
 b=AILAgVoOscHTSMKHeEFwSL0yLiG2sjA3U0VVQfsoudW7Zf0Aeuae8OE3AbqvkpcDq0L8zA
 t32+wvoFNQCvOWT5IGt3UWSWxs4yYsMpWCSztbApyIua13uptZBph0yMfVPL6Etx22xhpA
 x5A+1WD0379/Vcmxa/vwUCbGDKzqknw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-FNW4ZbMnPrmGiHoIzwFM4g-1; Fri, 20 Jun 2025 02:52:20 -0400
X-MC-Unique: FNW4ZbMnPrmGiHoIzwFM4g-1
X-Mimecast-MFC-AGG-ID: FNW4ZbMnPrmGiHoIzwFM4g_1750402339
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450df53d461so12901775e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 23:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750402338; x=1751007138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cNd8pxyRKBYHOOxHPV6siKNUfLozEByTZ8WWKyQJIow=;
 b=J0hMCT5VcIiUFn0CoKpCrHh/nnU9XFgvKX/1wHTy92+fZJmGypuca0aj8zAe+lQdPt
 /pZu8KlAexWlhXpVVV0xK2Z8OiRGS7dUMs/5emJCfdlKLbTi8/Lcx16dzo3xio/qKSA+
 A4TrAtKiR310Px88/ua3ftHGrduz0PL/iE5YknppxoeGWIB5n4k1NlXbGwmrvP+87JCC
 x8z5gzA01+H/sE7fIQL4lCRLLMxUWSM5oE7q6ga9P6aqbrIsl6AFa1n2GrYC3SzqrurG
 63UmC41ud8HvPubncHWZ6Z4jpgeCh22/bRfVocSxGrW/kb/Sm/4i2lNRFnqvtF1SJmKg
 OyiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ9ovNiWXX0SAGFNaCLnae87ge7giIQSJFbEdwIsgoXVsXTC2+7Z7N+M+9G03Bqg1sSArBpqwkr/8s@nongnu.org
X-Gm-Message-State: AOJu0Yy3qSY06rx7AENiuby58trvSDs6Jrbvf1nbGK6rnY0zQ26OLnxm
 ZXNT1tEPau3PWJby5m08awO4bsTSSu0pjpoTJYUXEpk5Jo1Oko0gUPcuScuems2pe9qryvVbA8X
 zRyFBP3B8e69JtE3ZlizaEUBEwvB4piIx7k/+114WUStfzRxaAW6GpxiGDmkjtSBh
X-Gm-Gg: ASbGncvnWyEBG8j6GVjfg2+sKkqL2A+cLsDWrOg2SWsuKc+K3yc2s6+NGIo+ASbf839
 F2dbMRns70uqQc1L83bmPv67nOQ/YjdQdNgyhc1x1o5hVLmEkGDjdMvmvRAIiYu3Ih0mGxEfBUy
 loilv2qYJvdPxPNYxqLP2+2DLvIM205aO8A+aNHB9F/XfrsHCunqotMbHsceduGi5cTDA1VRI0t
 FBWBdIN+YWCZZQa1C3Bw5wMoy0nCBNVHFVEHSQrtwyI78+1LekFwKkIqk0rh9PJwJ7/Z1ppKGuS
 KfCycCwy9c5H+4FhgWwd/f+mS53uiqXf3bcG6TGQtjCFUevg/Y3ieguuVyW7hJ842EDPdw==
X-Received: by 2002:a05:600c:1c83:b0:453:5c30:a2c2 with SMTP id
 5b1f17b1804b1-453659ca60fmr11824055e9.8.1750402338348; 
 Thu, 19 Jun 2025 23:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJSqTrs0ur7TsxHDgj8Lkd2YyN8JGFx881Eyh4erw56d351163jTqQELJmQL4VrPK4A7E7Ag==
X-Received: by 2002:a05:600c:1c83:b0:453:5c30:a2c2 with SMTP id
 5b1f17b1804b1-453659ca60fmr11823825e9.8.1750402337887; 
 Thu, 19 Jun 2025 23:52:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d11920ebsm1213118f8f.94.2025.06.19.23.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 23:52:17 -0700 (PDT)
Message-ID: <34f801fd-2439-4042-baa0-3bc060104ec9@redhat.com>
Date: Fri, 20 Jun 2025 08:52:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] hw/arm/virt-acpi-build: Fix comment in build_iort
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <20250616131824.425315-5-gustavo.romero@linaro.org>
 <db5aa1ab-cec7-4de1-b14f-bba978e7d7f7@redhat.com>
 <53c901c4-f408-43f6-a9aa-49f8fed59e98@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <53c901c4-f408-43f6-a9aa-49f8fed59e98@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 6/19/25 7:07 PM, Gustavo Romero wrote:
> Hi Eric,
>
> On 6/17/25 10:22, Eric Auger wrote:
>> Hi Gustavo,
>>
>> On 6/16/25 3:18 PM, Gustavo Romero wrote:
>>> The comment about the mapping from SMMU to ITS is incorrect and it
>>> reads
>>> "RC -> ITS". The code in question actually maps SMMU -> ITS, so the
>>> mapping in question is not direct. The direct mapping, i.e., RC -> ITS,
>>> is handled a bit further down in the code, in the else block, and we
>>> take the opportunity to update that as well, adding "RC -> ITS" to the
>>> text so it's easier to see it's the direct map to the ITS Group node.
>>>
>>> Signed-off-by Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   hw/arm/virt-acpi-build.c | 14 +++++++++-----
>>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>> index 9eee284c80..6990bce3bb 100644
>>> --- a/hw/arm/virt-acpi-build.c
>>> +++ b/hw/arm/virt-acpi-build.c
>>> @@ -407,23 +407,27 @@ build_iort(GArray *table_data, BIOSLinker
>>> *linker, VirtMachineState *vms)
>>>       if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>>>           AcpiIortIdMapping *range;
>>>   -        /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3
>>> -> ITS */
>>> +        /* Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3. */
>> yes this is what the code builds at this location.
>>>           for (i = 0; i < smmu_idmaps->len; i++) {
>>>               range = &g_array_index(smmu_idmaps, AcpiIortIdMapping,
>>> i);
>>> -            /* output IORT node is the smmuv3 node */
>>> +            /* Output IORT node is the SMMUv3 node. */
>>>               build_iort_id_mapping(table_data, range->input_base,
>>>                                     range->id_count, smmu_offset);
>>>           }
>>>   -        /* bypassed RIDs connect to ITS group node directly: RC
>>> -> ITS */
>>> +        /* Map DeviceIDs (input) from SMMUv3 to ITS Group nodes:
>>> SMMU -> ITS. */
>> But here I am confused. To me the its_idmaps matches the idmap between
>> RC and ITS. I understand this is built from holes left by bypassed
>> buses. See the build_iort() implementation. The comment at
>
> ah, thanks! I see. Indeed, it's mapping the RC -> ITS, not the SMMU ->
> ITS.
> I'll fix it in v5.
>
> One thing that confused me, which I think is actually ok, is that the
> output ID range from SMMU 0x000-0xFFFF) overlaps the output ID range
> from the RC (e.g. 0x100-0xFFFF) because the SMMU output range is
> defined as
> always taking the whole 16-bit range in:

Agreed. However I think it is fine because those are ID mappings between
different input/output space pairs.
RC ->          ITS
      SMMU ->  ITS
>
> [...]
>    366         build_append_int_noprefix(table_data, irq + 1, 4); /*
> PRI */
>    367         build_append_int_noprefix(table_data, irq + 3, 4); /*
> GERR */
>    368         build_append_int_noprefix(table_data, irq + 2, 4); /*
> Sync */
>    369         build_append_int_noprefix(table_data, 0, 4); /*
> Proximity domain */
>    370         /* DeviceID mapping index (ignored since interrupts are
> GSIV based) */
>    371         build_append_int_noprefix(table_data, 0, 4);
>    372
>    373         /* output IORT node is the ITS group node (the first
> node) */
>    374         build_iort_id_mapping(table_data, 0, 0x10000,
> IORT_NODE_OFFSET); <=========== HERE
>    375     }
>    376
>    377     /* Table 17 Root Complex Node */
>
>
> I think that's ok since ITS can disambiguate the Device IDs from SMMU
> and from RC.
>
>
>>          /*
>>           * Split the whole RIDs by mapping from RC to SMMU,
>>           * build the ID mapping from RC to ITS directly.
>>           */
>>          for (i = 0; i < smmu_idmaps->len; i++) {
>>              idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>>
>>              if (next_range.input_base < idmap->input_base) {
>>                  next_range.id_count = idmap->input_base -
>> next_range.input_base;
>>                  g_array_append_val(its_idmaps, next_range);
>>              }
>>
>>              next_range.input_base = idmap->input_base +
>> idmap->id_count;
>>          }
>>
>> is not crystal clear but it looks like filling the holes into its_idmap.
>
> k, I'll create a helper as you suggested in 7/8 to populate the
> its_idmaps.
>
>  > Besides there is another "Its group" instance to be replaced by ITS
> Group
>
> Pardon, what do you mean? Another text to be replaced or it's just a
> comment
> about the "else" block when smmu is off?
sorry, I meant another string to be replaced in the file

Cheers

Eric
>
> Thanks!
>
>
> Cheers,
> Gustavo
>
>> Eric
>>
>>>           for (i = 0; i < its_idmaps->len; i++) {
>>>               range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
>>> -            /* output IORT node is the ITS group node (the first
>>> node) */
>>> +            /* Output IORT node is the ITS Group node (the first
>>> node). */
>>>               build_iort_id_mapping(table_data, range->input_base,
>>>                                     range->id_count, IORT_NODE_OFFSET);
>>>           }
>>>       } else {
>>> -        /* output IORT node is the ITS group node (the first node) */
>>> +        /*
>>> +         * Map bypassed RIDs (input) (don't go through the SMMU) to
>>> ITS Group
>>> +         * nodes: RC -> ITS.
>>> +         * Output IORT node is the ITS Group node (the first node).
>>> +         */
>>>           build_iort_id_mapping(table_data, 0, 0x10000,
>>> IORT_NODE_OFFSET);
>>>       }
>>>   
>>
>


