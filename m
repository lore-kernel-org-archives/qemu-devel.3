Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19908C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYtj-0001f9-Ni; Tue, 17 Jun 2025 12:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uRYll-0002Gq-HC
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:02:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uRYla-0001e6-J0
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:02:35 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso5126302b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750176135; x=1750780935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o6n9QnxZQEp3aVXoKzmKc1ufO76DC8Dyqg4znXD0ODE=;
 b=WNkul4euTE4dLeRtBhYkiU4uILSkWsG2HLMXJ9hprzXbaXeyWyl6n9R2Ln5716/EN+
 er5FK4oF1CgdDXkiuBnB1RYFcZwGESDQqPMnXDdBi4wdiNqiJ7+6RwQpiXZc5JMWGjNf
 lFLYvj9p0eQibLIWshuVuIQ2v16fGJUeKbbRmLcasLVpEY/FCcAEQMt9cofP+ZrhGGny
 LRAoINWh6xNtVcaFY8QX+yDQRRy3iXHyrxtH9dmDCsk0654aYP/IuUFkiDx7Yy4/Etb2
 d4V51v5OCuQrOmESJfZ4QZilJYLER6i/x2BG/tUAdrKpqCBsfrJAr38KkOtZUqM5aQ3g
 t87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750176135; x=1750780935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o6n9QnxZQEp3aVXoKzmKc1ufO76DC8Dyqg4znXD0ODE=;
 b=LUjxyOL5OrHxk/HIvM/VRc8B1y3BQ6ujltjGjBN8fBm/cz8cRgIs9oY3NUwcf7SD2o
 /jd+TNkFZd+9GPK3MPQeqI3appXSu3c41JQZKggPFK7a8Vk47co+uBEwlBJnY2jdWZ4h
 TsMC9Fq3WqC26pcEsoj3nS2KLBin9SuALMuKA9NlwE9bHhLFh8Blkg+k+QoWO+Kw2UOB
 a7ynykEJgGhr/9D/Ersb7wYS9jbi6KkvTQ/EE3yMcysarFMqbyVGVzKMrx/+vpl8vFNr
 +tINM8mA5SqFhu1S4ZH/tBnH7jmE1NaKUvtmd6RkB7UbV+jkDc+x/ryut2tn41lS+qIe
 TpdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4CwHmACB+PGnljIyHJ81Gso9ijqI239i5mNN7Vpk9/KdQchg0hsZTehOCT+zDe1C0yJnXj4BfRfKh@nongnu.org
X-Gm-Message-State: AOJu0YyZ8ij9CD+SlF+MIm6yY6/g0W2Jdg2V2RFt901XH0RCxbrDlHel
 V8YCjRfnXI3RO4YnpkM2rHRdT7klL9wvIgeBr76g3Ol19OW9ZDfMze+xVLYfBToZl78=
X-Gm-Gg: ASbGncthJR9VsF1AT7fKMCLLM/SgEClqWrGfjHMh4Kr8fbILGHEHMhANOhlIjKTg5gU
 TW678MXsvnAQdwE6b75GFSYPIQg8JXmA0nAOgqkzwX+0cTlCA3Ue+9Ichth4GQRq+tGL0/GeS2+
 mpH57eM7q5HLARBI0/k3yu5fQS3LZPU3vl/liumwC9nxKX3qcJG02EoNFODyHwQRJNf/Qtk6ERU
 UE8sbkVof//RzupWtF/S034qpsSPhcyqScQTatvMlzEq8yga5tPcyUrRULm39xd0yESZwfNK5W8
 YiKRIisgluRpgrCMcKWGkFzZy/Zyv3RkNjB6+JzmtqOkcOt3r9b0WpHBUiIi+EIw5/7BE9Cy3A=
 =
X-Google-Smtp-Source: AGHT+IG7ORcj7hGyKP+K1856xWSJPgMTHtIdaYK3iwTAMrhn3+7Xef4Xwk08qX2sE5VKyVHzwCuMWA==
X-Received: by 2002:a05:6a00:4f82:b0:748:2ebf:7418 with SMTP id
 d2e1a72fcca58-7489d00e68bmr21133244b3a.24.1750176134470; 
 Tue, 17 Jun 2025 09:02:14 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.60.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74890005f47sm9406061b3a.51.2025.06.17.09.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 09:02:14 -0700 (PDT)
Message-ID: <e1c05a4c-ead6-437e-9287-84b77fcc9df4@linaro.org>
Date: Tue, 17 Jun 2025 13:01:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] qtest/bios-tables-test: Add test for when ITS is
 off on aarch64
To: eric.auger@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <20250616131824.425315-6-gustavo.romero@linaro.org>
 <fe166574-9e53-4e27-9c12-c91f3fc774c7@redhat.com>
 <3881403f-c618-47d1-afec-27592bd7be99@linaro.org>
 <74c1948a-3c90-431b-805f-b5a4238beecb@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <74c1948a-3c90-431b-805f-b5a4238beecb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/17/25 12:51, Eric Auger wrote:
> 
> 
> On 6/17/25 5:12 PM, Gustavo Romero wrote:
>> Hi Eric,
>>
>> On 6/17/25 10:34, Eric Auger wrote:
>>> Hi Gustavo,
>>>
>>> On 6/16/25 3:18 PM, Gustavo Romero wrote:
>>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>
>>>> Arm64 GIC ITS (Interrupt Translation Service) is an optional piece of
>>>> hardware introduced in GICv3 and, being optional, it can be disabled
>>>> in QEMU aarch64 VMs that support it using machine option "its=off",
>>>> like, for instance: "-M virt,its=off".
>>>>
>>>> In ACPI, the ITS is advertised, if present, in the MADT (aka APIC)
>>>> table and the remappings from the Root Complex (RC) and from the SMMU
>>> I would rephrase "and the remappings" by "while the RID mappings from
>>> ..."
>>
>> hmm true. Do you think it would be even better to say something like:
>>
>> "while the RID and StreamID mappings from the RC and from the SMMU nodes
>> to the ITS Group nodes are described in the IORT table."?
>>
>> I'm saying that because I understand the map from RC to ITS is from
>> a RID to a DeviceID, while map from the SMMU to ITS is from a StreamID to
>> a DeviceID, hence say "while the RID and StreamID". Does it make sense?
> I think I won't bother and would simply talk about "ID mappings" which
> is the generic term used in the IORT spec.

But I just dove into it because you suggested to use "RID" (aka ReqID, aka
Requestor ID, ah, I "love" these variations in specs), so I thought, well
RIDs are related to RC and StreamIDs related to SMMU, so, actually, you meant
"while the ID mappings from" instead of "while the RID mappings"?


Cheers,
Gustavo

>>
>>>> nodes to the ITS Group nodes are described in the IORT table.
>>>>
>>>> This new test verifies that when the "its=off" option is passed to the
>>>> machine the ITS-related data is correctly pruned from the ACPI tables.
>>>>
>>>> The new blobs for this test will be added in a following commit.
>>>>
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
>>>>    tests/qtest/bios-tables-test.c              | 21
>>>> +++++++++++++++++++++
>>>>    2 files changed, 23 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h
>>>> b/tests/qtest/bios-tables-test-allowed-diff.h
>>>> index dfb8523c8b..a88198d5c2 100644
>>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>> I still fail to understand whether empty tables + update if the
>>>
>>> bios-tables-test-allowed-diff.h need to be done prior to adding the
>>> new test.
>>>
>>>    * How to add or update the tests or commit changes that affect ACPI
>>> tables:
>>>    * Contributor:
>>>    * 1. add empty files for new tables, if any, under tests/data/acpi
>>>    * 2. list any changed files in
>>> tests/qtest/bios-tables-test-allowed-diff.h
>>>    * 3. commit the above *before* making changes that affect the tables
>>
>> I think the best reference I have to it is the reply from Igor to me
>> here:
>>
>> https://lore.kernel.org/qemu-devel/20250506173640.5ed03a16@imammedo.users.ipa.redhat.com/
>>
>>
>> I understand there are two possibilities when adding a new test:
>>
>> 1) Like in the steps above, 1., 2., and 3., which are taken from the
>> bios-tables-test.c.
>>
>> That gives option A:
>>
>> A Patch 1: New empty files uuder tests/data/acpi + list of them in
>> tests/qtest/bios-tables-test-allowed-diff.h
>> A Patch 2: New test (since the blobs are wrong but we added them in
>> Patch 1 to allow list, there is no fail in test
>> A Patch 3: Update blobs (actually you are adding the real blobs, or
>> updating from empty to real one)
>>
>> or (what I'm doing here), option B:
>>
>> B Patch 1: (A Patch 1) + (A Patch 2)
>> B Patch 2: Like (A Patch 3), i.e., just update the blobs (add the real
>> ones)
>>
>> This is the sequence Igor confirmed it's ok:
>>
>>> - Patch 1     : Add the new test, add the empty blobs *.suffix files,
>>> whitelist such a blobs
>>> - Patch 2     : Update the blobs in Patch 1 with the ones that make
>>> the new test pass and remove them from the whitelist
>>
>> Also, Igor says it's ok to add to the allow list the blobs that change
>> at the same time
>> we add test that changes the very same blobs even when updating an
>> existing test (not adding a
>> new one, which is slight variation):
>>
>>> - Patch 3     : Add the APIC.suffix blob to the whitelist (the table
>>> that changes due to the fix)
>>> - Patch 4 - n : Fix(es)
>>
>> "3 is not binary so it can be folded into 4 or be a separate patch
>> (either way works for me)"
>>   
>> The important thingy is to follow the rules:
>>
>> 1) Don't make a commit which fails the tests
>> 2) Don't fold a blob with the commit that changes the blob
>>
>> That's my current understanding about it.
>>
>> Let me know if that makes sense to you. We need to reach a consensus
>> on this, confusing as
>> these acrobatics may be! :)
> 
> Actually I checked your patch and effectively it does not produce any
> checkpatch error related to bios-tables-test rules so your patch is OK
> (yesterday I discovered with the ACPI PCI HP series that checkpatch
> points out infractions to bios-tables-test.c rules!). Since it results
> in less patches I think it is better. May be worth to clarify that
> directly in bios-tables-test.c though.
> 
> Cheers
> 
> Eric
>>
>>
>> Cheers,
>> Gustavo
>>
>>>> @@ -1 +1,3 @@
>>>>    /* List of comma-separated changed AML files to ignore */
>>>> +"tests/data/acpi/aarch64/virt/APIC.its_off",
>>>> +"tests/data/acpi/aarch64/virt/IORT.its_off",
>>>> diff --git a/tests/qtest/bios-tables-test.c
>>>> b/tests/qtest/bios-tables-test.c
>>>> index 0b2bdf9d0d..4201ec1131 100644
>>>> --- a/tests/qtest/bios-tables-test.c
>>>> +++ b/tests/qtest/bios-tables-test.c
>>>> @@ -2146,6 +2146,25 @@ static void
>>>> test_acpi_aarch64_virt_tcg_topology(void)
>>>>        free_test_data(&data);
>>>>    }
>>>>    +static void test_acpi_aarch64_virt_tcg_its_off(void)
>>>> +{
>>>> +    test_data data = {
>>>> +        .machine = "virt",
>>>> +        .arch = "aarch64",
>>>> +        .variant =".its_off",
>>> you have a checkpatch error here.
>>
>> ouch, thanks, will fix in v5.
>>
>>
>> Cheers,
>> Gustavo
>>
>>>> +        .tcg_only = true,
>>>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>>>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>>>> +        .cd =
>>>> "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
>>>> +        .ram_start = 0x40000000ULL,
>>>> +        .scan_len = 128ULL * 1024 * 1024,
>>>> +    };
>>>> +
>>>> +    test_acpi_one("-cpu cortex-a57 "
>>>> +                  "-M gic-version=3,iommu=smmuv3,its=off", &data);
>>>> +    free_test_data(&data);
>>>> +}
>>>> +
>>>>    static void test_acpi_q35_viot(void)
>>>>    {
>>>>        test_data data = {
>>>> @@ -2577,6 +2596,8 @@ int main(int argc, char *argv[])
>>>>                               test_acpi_aarch64_virt_tcg_acpi_hmat);
>>>>                qtest_add_func("acpi/virt/topology",
>>>>                               test_acpi_aarch64_virt_tcg_topology);
>>>> +            qtest_add_func("acpi/virt/its_off",
>>>> +                           test_acpi_aarch64_virt_tcg_its_off);
>>>>                qtest_add_func("acpi/virt/numamem",
>>>>                               test_acpi_aarch64_virt_tcg_numamem);
>>>>                qtest_add_func("acpi/virt/memhp",
>>>> test_acpi_aarch64_virt_tcg_memhp);
>>> Thanks
>>>
>>> Eric
>>>
>>
> 


