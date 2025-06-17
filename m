Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47708C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYil-0007tD-RU; Tue, 17 Jun 2025 11:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRYaj-0003Kp-GV
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRYaf-0007uE-JN
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750175471;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VS9urkfSFWt7AAn5yxzZ6Nil/NSfyk3gPz8NMoBeooM=;
 b=ZlML2LJ4xWIrjyBHIQ+yQkQuaddWsz1pJBK1QkqeKXNtimMAfx/XDWWIv+9Jq5oE3UGFV2
 i66uJwTXcwMYYOC/3TDPGaqsivnyQXOf4JgjrWTysCPpOgtxw214asgQgC5vU0IvdyW9u2
 je1f7QVqJlD/0sv70e1Lt/SEDR0Bz28=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-mLE1sjApOPioRrRJdvQwtw-1; Tue, 17 Jun 2025 11:51:10 -0400
X-MC-Unique: mLE1sjApOPioRrRJdvQwtw-1
X-Mimecast-MFC-AGG-ID: mLE1sjApOPioRrRJdvQwtw_1750175469
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d50eacafso36041405e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 08:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750175469; x=1750780269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VS9urkfSFWt7AAn5yxzZ6Nil/NSfyk3gPz8NMoBeooM=;
 b=h69Me7ZN8awJIL72Jp47+huZhVQWvV0XGL+0B69la7T1PSVPwxuo4u71EQK5l4dxrF
 SFST3/F49yA/r0QpgsJ/Gyb1KhCmX4RLRD1v3jbApyR15iqBFgWua9Wddp8ZWua/0Qnq
 SCvm0sMIsq1ela/E7exDRoE0kl3tpS3Y42K1DTJX1wfX2tqJQO8bQ9F8y6cbCZr/Q2rt
 4/jcg2GoJ3NDI6AggxRc64EntpEt6MjrASiEQfckGCEaccqznuJDtQeKuXJMZsa85ubu
 dkyG9HMZtMsAskeIkEiACfa+hHzi6ylB1lzzTDaTaLG1BYPBCXb3+G6W7Agf1VrLT/U7
 PNLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOJM0ziKsbyQuwxyJKQArpj/Ecv3ot2z2j8u790bM9cKwxgvMzCtIRWLUx8hMLNcChTfsub+mj+p1n@nongnu.org
X-Gm-Message-State: AOJu0Yynqo4rU/Blob11yUt9ut7pQLAaKvq0UPK4BK8L+vx86qjmWZQ7
 qLPRlpSnfGSFqotJKY+C4nbFcSgJgW8cjI/ycV1Md1JLHjc1zm5c4KFTPPznJevRMrh2nVPr8Io
 GSGyNHUD3HmAkZWbxngpzqaF1UCXt1Z9Nj68PrC21YtzJBN5ULlBwvjFB
X-Gm-Gg: ASbGncvoTWZNivS8fXO1Nt0g5DogeBQlzoZlWj1KwEGJEZLrmJfavkrrwEtOcxG00yI
 v32oWsCYdVMNwXWLV19brlIEv1GbJ8O6dXJ9Jkc6OSl/8q7cbbp3po3GXs1HCfK06K8WR5x71Na
 nWwNnYcVRYjaIvO4eVxsIkYEhEjW7PNFFB1MJt2pZs+5sXUxAyX/q1lDJcVpw5uj8LFwbRG2x3R
 OVo3c8vM66E5AcMfdK8trUKSHYV0wr4Imeb0KDPPLZt/KrBKfOpYch1K7uWH+BlXWW8DOusuYbz
 yeJhyt7crZGL9ayxAb0tVCrH2m2Tkj63cuWqlrQYPUggEDyrNA6GPBr6CuQI0Z8Ih5LWkg==
X-Received: by 2002:a05:600c:a00c:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-45353f6c370mr24876115e9.25.1750175469299; 
 Tue, 17 Jun 2025 08:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGokbolh5+wMjavNcW3U/wAa79plPfJoTUUv9f444Ko9Di03DaZjj6NSsxccaDjfr0Lu0OZpQ==
X-Received: by 2002:a05:600c:a00c:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-45353f6c370mr24875805e9.25.1750175468818; 
 Tue, 17 Jun 2025 08:51:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e25f207sm178883935e9.35.2025.06.17.08.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 08:51:08 -0700 (PDT)
Message-ID: <74c1948a-3c90-431b-805f-b5a4238beecb@redhat.com>
Date: Tue, 17 Jun 2025 17:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] qtest/bios-tables-test: Add test for when ITS is
 off on aarch64
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <20250616131824.425315-6-gustavo.romero@linaro.org>
 <fe166574-9e53-4e27-9c12-c91f3fc774c7@redhat.com>
 <3881403f-c618-47d1-afec-27592bd7be99@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <3881403f-c618-47d1-afec-27592bd7be99@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 6/17/25 5:12 PM, Gustavo Romero wrote:
> Hi Eric,
>
> On 6/17/25 10:34, Eric Auger wrote:
>> Hi Gustavo,
>>
>> On 6/16/25 3:18 PM, Gustavo Romero wrote:
>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> Arm64 GIC ITS (Interrupt Translation Service) is an optional piece of
>>> hardware introduced in GICv3 and, being optional, it can be disabled
>>> in QEMU aarch64 VMs that support it using machine option "its=off",
>>> like, for instance: "-M virt,its=off".
>>>
>>> In ACPI, the ITS is advertised, if present, in the MADT (aka APIC)
>>> table and the remappings from the Root Complex (RC) and from the SMMU
>> I would rephrase "and the remappings" by "while the RID mappings from
>> ..."
>
> hmm true. Do you think it would be even better to say something like:
>
> "while the RID and StreamID mappings from the RC and from the SMMU nodes
> to the ITS Group nodes are described in the IORT table."?
>
> I'm saying that because I understand the map from RC to ITS is from
> a RID to a DeviceID, while map from the SMMU to ITS is from a StreamID to
> a DeviceID, hence say "while the RID and StreamID". Does it make sense?
I think I won't bother and would simply talk about "ID mappings" which
is the generic term used in the IORT spec.
>
>
>>> nodes to the ITS Group nodes are described in the IORT table.
>>>
>>> This new test verifies that when the "its=off" option is passed to the
>>> machine the ITS-related data is correctly pruned from the ACPI tables.
>>>
>>> The new blobs for this test will be added in a following commit.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
>>>   tests/qtest/bios-tables-test.c              | 21
>>> +++++++++++++++++++++
>>>   2 files changed, 23 insertions(+)
>>>
>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h
>>> b/tests/qtest/bios-tables-test-allowed-diff.h
>>> index dfb8523c8b..a88198d5c2 100644
>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> I still fail to understand whether empty tables + update if the
>>
>> bios-tables-test-allowed-diff.h need to be done prior to adding the
>> new test.
>>
>>   * How to add or update the tests or commit changes that affect ACPI
>> tables:
>>   * Contributor:
>>   * 1. add empty files for new tables, if any, under tests/data/acpi
>>   * 2. list any changed files in
>> tests/qtest/bios-tables-test-allowed-diff.h
>>   * 3. commit the above *before* making changes that affect the tables
>
> I think the best reference I have to it is the reply from Igor to me
> here:
>
> https://lore.kernel.org/qemu-devel/20250506173640.5ed03a16@imammedo.users.ipa.redhat.com/
>
>
> I understand there are two possibilities when adding a new test:
>
> 1) Like in the steps above, 1., 2., and 3., which are taken from the
> bios-tables-test.c.
>
> That gives option A:
>
> A Patch 1: New empty files uuder tests/data/acpi + list of them in
> tests/qtest/bios-tables-test-allowed-diff.h
> A Patch 2: New test (since the blobs are wrong but we added them in
> Patch 1 to allow list, there is no fail in test
> A Patch 3: Update blobs (actually you are adding the real blobs, or
> updating from empty to real one)
>
> or (what I'm doing here), option B:
>
> B Patch 1: (A Patch 1) + (A Patch 2)
> B Patch 2: Like (A Patch 3), i.e., just update the blobs (add the real
> ones)
>
> This is the sequence Igor confirmed it's ok:
>
>> - Patch 1     : Add the new test, add the empty blobs *.suffix files,
>> whitelist such a blobs
>> - Patch 2     : Update the blobs in Patch 1 with the ones that make
>> the new test pass and remove them from the whitelist
>
> Also, Igor says it's ok to add to the allow list the blobs that change
> at the same time
> we add test that changes the very same blobs even when updating an
> existing test (not adding a
> new one, which is slight variation):
>
>> - Patch 3     : Add the APIC.suffix blob to the whitelist (the table
>> that changes due to the fix)
>> - Patch 4 - n : Fix(es)
>
> "3 is not binary so it can be folded into 4 or be a separate patch
> (either way works for me)"
>  
> The important thingy is to follow the rules:
>
> 1) Don't make a commit which fails the tests
> 2) Don't fold a blob with the commit that changes the blob
>
> That's my current understanding about it.
>
> Let me know if that makes sense to you. We need to reach a consensus
> on this, confusing as
> these acrobatics may be! :)

Actually I checked your patch and effectively it does not produce any
checkpatch error related to bios-tables-test rules so your patch is OK
(yesterday I discovered with the ACPI PCI HP series that checkpatch
points out infractions to bios-tables-test.c rules!). Since it results
in less patches I think it is better. May be worth to clarify that
directly in bios-tables-test.c though.

Cheers

Eric
>
>
> Cheers,
> Gustavo
>
>>> @@ -1 +1,3 @@
>>>   /* List of comma-separated changed AML files to ignore */
>>> +"tests/data/acpi/aarch64/virt/APIC.its_off",
>>> +"tests/data/acpi/aarch64/virt/IORT.its_off",
>>> diff --git a/tests/qtest/bios-tables-test.c
>>> b/tests/qtest/bios-tables-test.c
>>> index 0b2bdf9d0d..4201ec1131 100644
>>> --- a/tests/qtest/bios-tables-test.c
>>> +++ b/tests/qtest/bios-tables-test.c
>>> @@ -2146,6 +2146,25 @@ static void
>>> test_acpi_aarch64_virt_tcg_topology(void)
>>>       free_test_data(&data);
>>>   }
>>>   +static void test_acpi_aarch64_virt_tcg_its_off(void)
>>> +{
>>> +    test_data data = {
>>> +        .machine = "virt",
>>> +        .arch = "aarch64",
>>> +        .variant =".its_off",
>> you have a checkpatch error here.
>
> ouch, thanks, will fix in v5.
>
>
> Cheers,
> Gustavo
>
>>> +        .tcg_only = true,
>>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>>> +        .cd =
>>> "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
>>> +        .ram_start = 0x40000000ULL,
>>> +        .scan_len = 128ULL * 1024 * 1024,
>>> +    };
>>> +
>>> +    test_acpi_one("-cpu cortex-a57 "
>>> +                  "-M gic-version=3,iommu=smmuv3,its=off", &data);
>>> +    free_test_data(&data);
>>> +}
>>> +
>>>   static void test_acpi_q35_viot(void)
>>>   {
>>>       test_data data = {
>>> @@ -2577,6 +2596,8 @@ int main(int argc, char *argv[])
>>>                              test_acpi_aarch64_virt_tcg_acpi_hmat);
>>>               qtest_add_func("acpi/virt/topology",
>>>                              test_acpi_aarch64_virt_tcg_topology);
>>> +            qtest_add_func("acpi/virt/its_off",
>>> +                           test_acpi_aarch64_virt_tcg_its_off);
>>>               qtest_add_func("acpi/virt/numamem",
>>>                              test_acpi_aarch64_virt_tcg_numamem);
>>>               qtest_add_func("acpi/virt/memhp",
>>> test_acpi_aarch64_virt_tcg_memhp);
>> Thanks
>>
>> Eric
>>
>


