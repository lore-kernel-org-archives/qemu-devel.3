Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F642C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VFl-000097-DF; Thu, 03 Apr 2025 20:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0VFj-00006f-JK
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:49:47 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0VFg-0004Fv-QW
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:49:47 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso1199234a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743727783; x=1744332583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CS6Xgd2KJEc//ERHQ5aJ7Kn0Z+NdSLS5oXrJy+c57JE=;
 b=SG+6yuKnrsXZGx9B1jPRxHZ2vDFeHayz6aTcnXNTe2iVcfAOtwpz21GpS2YnyNSA9k
 SjzNzp2fj/o8LjOG/nEgE3TnosIliXZa+HaDuJOdhAKDk2i2P9waKqv/BE4rumMRczqL
 tcGAfUXFur0duym7G+Q7jJS9lsfIY9EvQS9O+eMhMXaBdTvJTFg0avJ0y9v8WDPLDbId
 3Cs863UAHgnDdZCfW/D/14nCd5myt8/nwvWwnhJvU6LTWbIZz5rPKtV/OX2nfYnQgh9J
 noSM1mwgwo5RFMNPQeJTD0ps7DpMl6I5onwBCQVfM2AMsBuWaHQCO0FOKCEtz7V7PKO/
 K54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743727783; x=1744332583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CS6Xgd2KJEc//ERHQ5aJ7Kn0Z+NdSLS5oXrJy+c57JE=;
 b=GSBP9PR/1ijJlwWtlXC9DfV9xl8zGuT8xCwfTrDEEVVA6DEwcEMpE/pTC2qu4F6aq0
 5Xr9lg3Q1b/XzAX05p9JfWbD6akTuPocrV/EHXulh0OIgUkLIk1nPz2PHwqVujjFmDYD
 yzGKzHZLGROIUlLiHKZ7Yt/sw/mP8XOrCbotcr4SZ1rwXU7IliKm6WoykzT2i9PzLkOw
 LjWD9whR+I2rZuco41Svdb09ZcbgmFweMlaWumMl4sstLmaC45tajaMlKWB4xd+0aQ9M
 l7fALf1ERd6b5txM+UZHKYBOJfs7kJaYP12/CH27RdMPcc2BzOCdlMjwJAcWBnfHFUtU
 IPxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrwsuwIEf+hx008+CuiNhsncFTzO1C9aC7mfNeE0PUOf/zj4gtbF4gVU30NeX9/Py402cgcHZ9twWe@nongnu.org
X-Gm-Message-State: AOJu0Yyc6IaNVfdlzrQnTdNkHllz4CCx58RjaEZY68TAhVgyuZBVHebV
 SjeAdD9YfJPRW7jjYR4Bq00ppJNbgFbCQ7w4TmvnCKHpRTXa6z7oYbuDrP0tTmk=
X-Gm-Gg: ASbGnctMhXsZTJWIBvjPTuIOmBuap8nRABKcKRGA4i5XzmWDxqrs/jtTBacShdz+QCW
 f2J8DUomWVgv4dlyBy1mHF/yJPx/9pPnwPFPEhrTo2uWzJaqaxICuQgnDMFkT+gF6k/ETyModxy
 InZFLX3mfj2xInAeTV4kpRWcSXuU3bj4a9Vr2MryeNlzvo/er2ecVvCuG5c8bsQc1xuIF0ArjAN
 1hfam19onCs6L6FHxdwXQLJwb0cBiS2HP6mj90oIhswsR9NujSIyb+XRkQeeOxFN3Tw55o9xqpK
 eNkOOoshmJ7KDNC3l8Q8nTmisMw9Y0MRIlfoXp6fKnXI7m916+SRL/cq
X-Google-Smtp-Source: AGHT+IFnUclgY8q7BBzGLCNlfAnSrZJE8NibR9m84eB3MTPYLvtpDypOJrFXBbg6YFLZLJV68Qm98Q==
X-Received: by 2002:a17:90b:574d:b0:2ff:62f3:5b19 with SMTP id
 98e67ed59e1d1-306a48650f8mr2345985a91.13.1743727782652; 
 Thu, 03 Apr 2025 17:49:42 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.46])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-305983d801csm2420924a91.43.2025.04.03.17.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 17:49:42 -0700 (PDT)
Message-ID: <ba44c84a-2e45-4a1b-98e2-9db2a6c1bde5@linaro.org>
Date: Thu, 3 Apr 2025 21:49:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 1/5] qtest/bios-tables-test: Add test for -M
 virt,its=off
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
 <20250331221239.87150-2-philmd@linaro.org>
 <1d1362a0-b544-476c-a305-a7d2212db423@linaro.org>
 <d3059aa1-952b-46b9-bb96-dace60664f49@linaro.org>
 <62bbeff2-f892-44d1-b190-8c4541acf16d@linaro.org>
 <3153ea58-61e0-4abf-9e24-11f98f95f9f6@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <3153ea58-61e0-4abf-9e24-11f98f95f9f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Phil,

On 4/3/25 09:47, Philippe Mathieu-Daudé wrote:
> On 3/4/25 08:25, Gustavo Romero wrote:
>> Hi Phil,
>>
>> On 4/2/25 07:30, Philippe Mathieu-Daudé wrote:
>>> On 2/4/25 08:41, Gustavo Romero wrote:
>>>> Hi Phil,
>>>>
>>>> On 3/31/25 19:12, Philippe Mathieu-Daudé wrote:
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>
>>>> Please, put commit message (body) into the commits.
>>>>
>>>> For example, the commit message here could quickly explain that the FACP table
>>>> changed because virtualization=on (due to PSCI conduit). I'm assuming
>>>> virtualization is set to on because gic-version=max and so GICv4 is selected for
>>>> testing. It also could be that  we want to exercise its=off when Arm Virtualization
>>>> Extensions are enabled, which is the common use case (I understand that ITS
>>>> can be used also with virtualization=off).
>>>>
>>>> Finally, the commit message could mention at the end which struct
>>>> vanishes in APIC table and why IO remapping table is affected by
>>>> ITS on/off.
>>>>
>>>> A good commit message always help in code spelunking :)
>>>
>>> I simply copied the reproducer from the issue, so I'll mention that.
>>> (https://gitlab.com/qemu-project/qemu/-/issues/2886)
>>>
>>>>
>>>>
>>>>> ---
>>>>>   tests/qtest/bios-tables-test.c            |  22 ++++++++++++++++++ ++++
>>>>>   tests/data/acpi/aarch64/virt/APIC.its_off | Bin 0 -> 184 bytes
>>>>>   tests/data/acpi/aarch64/virt/FACP.its_off | Bin 0 -> 276 bytes
>>>>>   tests/data/acpi/aarch64/virt/IORT.its_off | Bin 0 -> 236 bytes
>>>>>   4 files changed, 22 insertions(+)
>>>>>   create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>>>>>   create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
>>>>>   create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
>>>>>
>>>>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios- tables- test.c
>>>>> index 0a333ec4353..55366bf4956 100644
>>>>> --- a/tests/qtest/bios-tables-test.c
>>>>> +++ b/tests/qtest/bios-tables-test.c
>>>>> @@ -2146,6 +2146,26 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>>>>>       free_test_data(&data);
>>>>>   }
>>>>> +static void test_acpi_aarch64_virt_tcg_its_off(void)
>>>>> +{
>>>>> +    test_data data = {
>>>>> +        .machine = "virt",
>>>>> +        .arch = "aarch64",
>>>>> +        .variant = ".its_off",
>>>>> +        .tcg_only = true,
>>>>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>>>>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>>>>> +        .cd = "tests/data/uefi-boot-images/bios-tables- test.aarch64.iso.qcow2",
>>>>> +        .ram_start = 0x40000000ULL,
>>>>> +        .scan_len = 128ULL * 1024 * 1024,
>>>>> +    };
>>>>> +
>>>>> +    test_acpi_one("-cpu cortex-a57 "
>>>>> +                  "-M virtualization=on,secure=off "
>>>>> +                  "-M gic-version=max,its=off,iommu=smmuv3", &data);
>>>>> +    free_test_data(&data);
>>>>> +}
>>>>> +
>>>>>   static void test_acpi_q35_viot(void)
>>>>>   {
>>>>>       test_data data = {
>>>>> @@ -2577,6 +2597,8 @@ int main(int argc, char *argv[])
>>>>>                              test_acpi_aarch64_virt_tcg_acpi_hmat);
>>>>>               qtest_add_func("acpi/virt/topology",
>>>>>                              test_acpi_aarch64_virt_tcg_topology);
>>>>> +            qtest_add_func("acpi/virt/its_off",
>>>>> +                           test_acpi_aarch64_virt_tcg_its_off);
>>>>>               qtest_add_func("acpi/virt/numamem",
>>>>>                              test_acpi_aarch64_virt_tcg_numamem);
>>>>>               qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
>>>>> diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/ acpi/aarch64/virt/APIC.its_off
>>>>> new file mode 100644
>>>>> index 0000000000000000000000000000000000000000..c37d05d6e05805304f10afe73eb7cb9100fcccfa
>>>>> GIT binary patch
>>>>> literal 184
>>>>> zcmZ<^@O0k6z`($=+{xeBBUr&HBEVSz2pEB4AU24G0Uik$i-7~iVgWL^17JJ`2AFzr
>>>>> bgb+@aBn}xq0gwb2)Q)cq{30-g9B_L93G4|0
>>>>>
>>>>> literal 0
>>>>> HcmV?d00001
>>>>>
>>>>> diff --git a/tests/data/acpi/aarch64/virt/FACP.its_off b/tests/data/ acpi/aarch64/virt/FACP.its_off
>>>>> new file mode 100644
>>>>> index 0000000000000000000000000000000000000000..606dac3fe4b55c31fd68b25d3a4127eeef227434
>>>>> GIT binary patch
>>>>> literal 276
>>>>> zcmZ>BbPf<<WME(uaq@Te2v%^42yj*a0-z8Bhz+8t3j|P&V`N}P6&N^PpsQ~v$aVnZ
>>>>> CVg~^L
>>>>>
>>>>> literal 0
>>>>> HcmV?d00001
>>>>>
>>>>> diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/ acpi/aarch64/virt/IORT.its_off
>>>>> new file mode 100644
>>>>> index 0000000000000000000000000000000000000000..0fceb820d509e852ca0849baf568a8e93e426738
>>>>> GIT binary patch
>>>>> literal 236
>>>>> zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=RgMkDCNC*yK9F_<M77!bR
>>>>> zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@
>>>>> R!2`+%Dg6Hr$N|zYvjDIZ5CH%H
>>>>>
>>>>> literal 0
>>>>> HcmV?d00001
>>>>>
>>>>
>>>> I think the prescription for the acrobatics to update the ACPI expected
>>>> tables says the blobs here should be empty (blob files are added empty)
>>>> and at the same time they are listed in tests/qtest/bios-tables-test- allowed-diff.h:
>>>>
>>>>   * 1. add empty files for new tables, if any, under tests/data/acpi
>>>>   * 2. list any changed files in tests/qtest/bios-tables-test- allowed- diff.h
>>>>   * 3. commit the above *before* making changes that affect the tables
>>>>
>>>> (from tests/qtest/bios-tables-test.c header)
>>>>
>>>> If that's correct, this patch should be merged with the following one (2/5) and
>>>> IORT.its_off and FACP.its_off should also be listed in
>>>> tests/qtest/bios-tables-test-allowed-diff.h so the empty blobs won't trigger
>>>> a test failure.
>>>
>>> I shouldn't have included the ACPI data in this patch but in the
>>> following. IIUC, if no data/$TABLE.$variant, then the generic
>>> data/$TABLE is used.
>>
>> Yeah, it's correct that if no data/$TABLE.$variant is found then data/ $TABLE is
>> used as a fallback. But my point actually was that in the first patch you should
>> create the blob .its_off variants for tables affected by the main change but
>> they must be empty, as per Step 1. in the prescription; and add them to the
>> "ignore list" (tests/qtest/bios-tables-test-allowed-diff.h) so they don't fail
>> the test, as per Step 2.
> 
> Without data files:
> 
> stderr:
> acpi-test: Warning! FACP binary file mismatch. Actual [aml:/tmp/aml-379632], Expected [aml:tests/data/acpi/aarch64/virt/FACP].
> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
> acpi-test: Warning! FACP mismatch. Actual [asl:/tmp/asl-2XA732.dsl, aml:/tmp/aml-379632], Expected [asl:/tmp/asl-LO1632.dsl, aml:tests/data/acpi/aarch64/virt/FACP].
> acpi-test: Warning! APIC binary file mismatch. Actual [aml:/tmp/aml-ZCA732], Expected [aml:tests/data/acpi/aarch64/virt/APIC].
> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
> acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-0XH832.dsl, aml:/tmp/aml-ZCA732], Expected [asl:/tmp/asl-YBK832.dsl, aml:tests/data/acpi/aarch64/virt/APIC].
> acpi-test: Warning! IORT binary file mismatch. Actual [aml:/tmp/aml-GX9632], Expected [aml:tests/data/acpi/aarch64/virt/IORT].
> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
> acpi-test: Warning! IORT mismatch. Actual [asl:/tmp/asl-SPM832.dsl, aml:/tmp/aml-GX9632], Expected [asl:/tmp/asl-4SP832.dsl, aml:tests/data/acpi/aarch64/virt/IORT].
> **
> ERROR:../../tests/qtest/bios-tables-test.c:554:test_acpi_asl: assertion failed: (all_tables_match)

This is expected because if variant blobs are missing then data/$TABLE ones are used as the
blobs to be compared against the VM tables. Adding the data/$TABLE.$variant to the
"ignore list" (tests/qtest/bios-tables-test-allowed-diff.h) has no effect and so the test fails.


> With empty data files:
> 
> stderr:
> Warning! zero length expected file 'tests/data/acpi/aarch64/virt/FACP.its_off'
> Warning! zero length expected file 'tests/data/acpi/aarch64/virt/APIC.its_off'
> Warning! zero length expected file 'tests/data/acpi/aarch64/virt/IORT.its_off'
> Warning! zero length expected file 'tests/data/acpi/aarch64/virt/FACP.its_off'
> Warning! zero length expected file 'tests/data/acpi/aarch64/virt/APIC.its_off'
> Warning! zero length expected file 'tests/data/acpi/aarch64/virt/IORT.its_off'
> acpi-test: Warning!  binary file mismatch. Actual [aml:/tmp/aml-T6YE42], Expected [aml:tests/data/acpi/aarch64/virt/FACP.its_off].
> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
> acpi-test: Warning!  mismatch. Actual [asl:/tmp/asl-FG0E42.dsl, aml:/tmp/aml-T6YE42], Expected [asl:/tmp/asl-SE2E42.dsl, aml:tests/data/acpi/aarch64/virt/FACP.its_off].
> acpi-test: Warning!  binary file mismatch. Actual [aml:/tmp/aml-0DZE42], Expected [aml:tests/data/acpi/aarch64/virt/APIC.its_off].
> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
> acpi-test: Warning!  mismatch. Actual [asl:/tmp/asl-3G3E42.dsl, aml:/tmp/aml-0DZE42], Expected [asl:/tmp/asl-RV4E42.dsl, aml:tests/data/acpi/aarch64/virt/APIC.its_off].
> acpi-test: Warning!  binary file mismatch. Actual [aml:/tmp/aml-YH0E42], Expected [aml:tests/data/acpi/aarch64/virt/IORT.its_off].
> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
> acpi-test: Warning!  mismatch. Actual [asl:/tmp/asl-BX4E42.dsl, aml:/tmp/aml-YH0E42], Expected [asl:/tmp/asl-OL7E42.dsl, aml:tests/data/acpi/aarch64/virt/IORT.its_off].
> **
> ERROR:../../tests/qtest/bios-tables-test.c:554:test_acpi_asl: assertion failed: (all_tables_match)

But are you adding the data/$TABLE.variant (*.its_off) blobs to "ignore list"? If you add them to
tests/qtest/bios-tables-test-allowed-diff.h then the test pass (the warnings happen but not
assert is hit, as expected):

gromero@gromero0:/mnt/git/qemu_/build$ git log -1
commit c429ecebbea4633e1eaed15a16fb675629ffa03f (HEAD)
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Tue Apr 1 00:12:35 2025 +0200

     qtest/bios-tables-test: Add test for -M virt,its=off
     
     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
gromero@gromero0:/mnt/git/qemu_$ find -name \*.its_off -ls # empty .its_off blobs
   4083505      0 -rw-rw-r--   1 gromero  gromero         0 Apr  3 23:29 ./tests/data/acpi/aarch64/virt/FACP.its_off
   4083315      0 -rw-rw-r--   1 gromero  gromero         0 Apr  3 23:29 ./tests/data/acpi/aarch64/virt/APIC.its_off
   4084089      0 -rw-rw-r--   1 gromero  gromero         0 Apr  3 23:29 ./tests/data/acpi/aarch64/virt/IORT.its_off
gromero@gromero0:/mnt/git/qemu_$ git diff # .its_off blobs added to the "ignore list"
diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
index c37d05d6e0..e69de29bb2 100644
Binary files a/tests/data/acpi/aarch64/virt/APIC.its_off and b/tests/data/acpi/aarch64/virt/APIC.its_off differ
diff --git a/tests/data/acpi/aarch64/virt/FACP.its_off b/tests/data/acpi/aarch64/virt/FACP.its_off
index 606dac3fe4..e69de29bb2 100644
Binary files a/tests/data/acpi/aarch64/virt/FACP.its_off and b/tests/data/acpi/aarch64/virt/FACP.its_off differ
diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
index 0fceb820d5..e69de29bb2 100644
Binary files a/tests/data/acpi/aarch64/virt/IORT.its_off and b/tests/data/acpi/aarch64/virt/IORT.its_off differ
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..23591a55df 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
  /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/FACP.its_off", "tests/data/acpi/aarch64/virt/APIC.its_off", "tests/data/acpi/aarch64/virt/IORT.its_off",
gromero@gromero0:/mnt/git/qemu_$ cd build
gromero@gromero0:/mnt/git/qemu_/build$ make -j 32 check V=2 |& tail -10


Ok:                 320
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            11
Timeout:            0

Full log written to /mnt/git/qemu_/build/meson-logs/testlog.txt
gromero@gromero0:/mnt/git/qemu_/build$ grep "assertion failed" /mnt/git/qemu_/build/meson-logs/testlog.txt
gromero@gromero0:/mnt/git/qemu_/build$


This is what I understand steps 1. and 2. in the prescription are saying.

That said, for you series I think your approach makes sense: you add the correct blobs
in the same patch you introduce the new test, so the test _does not_ fail with the "ignore list" empty.


Cheers,
Gustavo
  
>> But on second thoughts I think Step 1. in prescription is confusing. 
> 
> I'll try to improve that.
> 
>> Anyways,
>> what you're doing here is sensible.
>>
>> Here (1/5), you're adding a new test, with new VM options. The new VM options
>> (different in comparison to the ¨baseline" data/$TABLE) cause changes to three
>> ACPI tables: APIC, FACP, and IORT, because:
>>
>> - APIC: GICv2 is update to GICv4 due to gic-version=max + virtualization=on => GICv4
>>          and the addition of Subtable type 0xF for GIC ITS Structure (even tho its=off
>>          in the VM option, since that's the bug to be fixed down the road)
>>
>> - FACP: Change of PSCI conduit due to virtualization=on option:
>> -                       Must use HVC for PSCI : 1
>> +                       Must use HVC for PSCI : 0 (use SMC instead)
>> because of logic in machvirt_init():
>> [...]
>>      } else if (vms->virt) { /* vms->virt is true is virtualization=on */
>>          vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
>>      } else {
>>          vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
>>      }
>>
>> - IORT: A new node is added for SMMUv3 due to option iommu=smmuv3.
>>
>>
>> I think it's correct to add the blobs for .its_off to this patch, otherwise the test will
>> fail and, moreover, they are the results of the options being used for the new test.
>> As an alternative, you could add the *.its_off to tests/qtest/bios- tables-test-allowed-diff.h
>> so the differences would be ignored and the test passes, but really I think it makes
>> more sense as you're doing here.
>>
>> The next patch (2/5) becomes, as you said in the commit message, a preparation for the
>> real changes (the fix), which will break temporarily the test, hence in 2/5 you add it
>> to the "ignore list", which is actually what Step 2. in the prescription recommends.
>>
>> Thus:
>>
>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> 
> Thanks!
> 


