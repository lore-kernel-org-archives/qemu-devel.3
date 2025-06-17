Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3E1C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYzr-0006jY-Hj; Tue, 17 Jun 2025 12:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uRYqC-0005lz-RW
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:07:19 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uRYq7-0002Th-5z
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:07:16 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-313154270bbso6458407a91.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750176429; x=1750781229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dPooGodvHOd25Hd926Qo9oypTPkB595thoSSxi84ong=;
 b=rP5Y7sAVIhqjA4cJFFAejRvJ/A3QaBVc93JG178mY70qSMjOLi2R8KKWQcXSIIKeWU
 3PYvPbt2hBo9a6AHKKDRUm16LHphTGiGy79iVWa2PjF0LcyA3xi5f5FVlEZCcxIJJKCM
 ZyXgYfUtE4wzTY0zJvZUQXj/gekALXfO55Mb0glsZ1E6himxjlx6+dviOYtNFOWC82vD
 ULVTDJlJsnEtHOAEBZI5EKUFJJmVJGagP3SAnnE9csSWlOGnV+lfQfICph7eec3sNgqT
 C36xhoX4WpeWr0mvH1M4KGyxTB8NlmLxubVNI4bW0HRg6N867lflqCQzNYnwJthDQOb2
 S7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750176429; x=1750781229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dPooGodvHOd25Hd926Qo9oypTPkB595thoSSxi84ong=;
 b=IR5jG3kaYnc73WHpUKIgUNpg6NPFH0LhIH56KCp6dIgbYkdOK+DSaXHEuLKBboK8Tf
 gafzlLmPG89FZqu9Os5ZROxvlAsQr0w6ftLRFDQPcQov0SzH4lp6xm4pO4wnJ0NKBoHP
 i3CAaNpk1Cu5i6r5Gpp2T6Bl2rMues97GLWP+wkJjbO1NZUnZsPwzgW9c1sTQ7SUroaE
 cL1wxI0iWccfy7iAhZyLAeFtPO1GBvclEI5+HbHROX/u8KYJ21kd0F93AdpqZSt0Gnl9
 TBYAFjd25f4Vddf7552VTGU0KFdE4BNerxn2MJ1ZTtwb0VCvKp8V/GotEfJZT4JTPFeW
 DGEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoP92plS1s47L/G65FT9nmWAF5/XgWD5/nbDrrNSC8cXgr77rv1SxQrbNqFjNhfvUdm1Plq9c7hKJb@nongnu.org
X-Gm-Message-State: AOJu0YzwcMQ8+lXGxE1eJ8mX7djOwr2ys8dVxbH7XmidmuGcIXD5RRHX
 FpfpZP6ei+c3eU7vyMAE1rHB3DkvI2tN/l5EX4two3pO8oy7t2DZ2o4vMkAmlhobA6M=
X-Gm-Gg: ASbGncvg6wBkuze3dtwAq8pK2coRw30tuSju5IYFw5kI3Hjey9cCzmcCmCypCU3vqHg
 +nNq4dh8/XJZALhvKl0AzZh6wtmmKnHu1O7joy/LtZ8SXgELdcV8ql2eX3YHO0H8THCZFq4Qto9
 SYTVDeqaVvlwoVA5vleGzVWliwA8iKmlBj/za31shNl7ZabDOH9/xWbU/aatX6nzQ8Gxz+kXLBs
 YnUiwB0XsaV4BskMSP4IeNh3C2kSBn/bjZcbAfgFBqJ181o+AydQDVqG47sn+y0CPngFN0h27HZ
 i3t4YD83MHbFA/K8kRNtcw4apejgra5xvvPyG5FICzpbCe3WFBljeRtg360+l5pUfMFcqVTmEA=
 =
X-Google-Smtp-Source: AGHT+IFtFXA0xCexhG7ezEYeGusVFz2h2wR9DiTKZsUvW4VMIi55VULTSoUi9FXA306bINke54IKhg==
X-Received: by 2002:a17:90b:35cc:b0:30e:3718:e9d with SMTP id
 98e67ed59e1d1-313f1d5077fmr21766876a91.35.1750176428956; 
 Tue, 17 Jun 2025 09:07:08 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.60.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313c1b2b545sm10805794a91.0.2025.06.17.09.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 09:07:08 -0700 (PDT)
Message-ID: <825d1a10-0e47-4a73-a274-a01380785ec4@linaro.org>
Date: Tue, 17 Jun 2025 13:06:53 -0300
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1031.google.com
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
>>
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

oh I didn't know it! wow, glad Option B passes the checkpatch scrutinity heh

Yes I think I can update the doc now I confirmed with Igor the details.

I'll cc Igor and you when submitting the doc improvement.

Thanks.


Cheers,
Gustavo

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


