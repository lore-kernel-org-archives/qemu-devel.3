Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5B5C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 15:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2XgQ-0004wu-Lb; Wed, 09 Apr 2025 11:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u2XgO-0004sv-O1
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 11:49:44 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u2XgM-0007kn-Lc
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 11:49:44 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-301d6cbbd5bso6814882a91.3
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744213780; x=1744818580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=940NqbKb+O1X9drvhQ2ttvWpopLBI4IZKc98V0PWB/o=;
 b=mgn9x/20qqsDH09CtDjJ9sjNdNUBRcHfE2OcnZ44zkLCgPbaGS0J3xQKwXvVu6hP2s
 0PDxZk9wEXc/Kf3wCxFd4edQC7gFTpel+SuWUuWOywss72x/wivG8OiSqNSy4GS+Naz1
 xR31/xwem83+i75G+RGZOUiOH5QYc+Ltg6N140gbxEgVDY4cEoXY0r1m0PdJwZ0fGU+n
 6xVPc8O6a79UXbcna4zHg8WuUn4LEPFqNr+kck/aBUntFkL0UTzRspQ+Ie0q7ZKGXTeI
 d9Q1sOLcAqZNA57zlGKG6WEPf1M+bk+YEUARBceO5RHw6LjIJVPj2QRgA6PvvVZQDEUx
 jhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744213780; x=1744818580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=940NqbKb+O1X9drvhQ2ttvWpopLBI4IZKc98V0PWB/o=;
 b=UedeCV/QDBRG7JpSmxoLIWmT48YSLyU1yK1pLSKRrHaJqKS50np8UK8YMvMlLDWas9
 DqXc8Bgfh+FOBwh1k+o3/6dirW0epodJqYJq4Il3xc1e2/aoTozpPHvX4ZMc8HMhlKWr
 HKF2h0WWYu+9eAYPzaL7vNiYH+dAqyNv3VVBbaBuunfriSrWgZwSPtDzHsZxZEK58Sh4
 hjFJrPPitaJW0Q7dmgo7b1b1GKPCIysD6WfMEF35vAKpyFcRQuE7kzyVLyHsp+rLwalJ
 xWvabeSRJ1imyEyzQQcbV5wTW5KOfnuOf0DqbkBW7UOHNGeHLkZH8RXY9jXiIr+7FilY
 6nyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAFLQECqwtodmOmLbkOdtoaDGgt+GQ0LmLr9Y+17KfE4oe+lyQZsbajN7Ezio4C6V6P0GSUiGrIEwI@nongnu.org
X-Gm-Message-State: AOJu0YzPmnQDKhN6PTdsckaRFKef9FPsdJe194Zqy627C6xkHjpE62Cb
 QzVtG4ZJICauWOcrj5hMfePtf5fAXT5P/VnEHrG5ucsnku/x0UmE+96UGddYvGg=
X-Gm-Gg: ASbGncsZoxwKaZP//ixMWunaEyTomULrgG/QFjy6LnHTu30oNRjn4LuqM7fNqQOdpRW
 3OLreOeI/8eTNqLsmvTVOrEM/kH3KW9HDM9NKGdVwWLHawzIzX0FIrLPQPl1ejEZ+BleaWwZyeS
 DgP2LFCRtaXVdJvILjmrSb4DqmOwLhTQGgTZ3oHKib+ogJfNGWfbaA3odnINmbtq0PEmQnnVNEy
 sJ8i83dxDZkhptr3abkY1WLXZyA3Ws27EEq4GvQGvDaDwwomQoBFqVmLUH/MEGlrRu2wZU1gT8r
 SfoQxn9mFiXoJPZ0xe8j0fuQv7ICHWmk5lTgXNZLh5c5ffX70lDUiL6RgxyGpZA=
X-Google-Smtp-Source: AGHT+IHlJPjP1EdHBldUh7oZwaqORrFVtYXcqN97bbJEiH3ZzyHbtcsoQ7hiLBJj4tiOL061eOjFlw==
X-Received: by 2002:a17:90b:524f:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-306dd32ce33mr4417565a91.11.1744213780520; 
 Wed, 09 Apr 2025 08:49:40 -0700 (PDT)
Received: from [192.168.0.102] ([152.250.123.8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df2fae27sm1618263a91.31.2025.04.09.08.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 08:49:40 -0700 (PDT)
Message-ID: <98b2676d-ad21-4c05-a165-12ae5e1b9c64@linaro.org>
Date: Wed, 9 Apr 2025 12:49:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 6/9] qtest/bios-tables-test: Whitelist
 aarch64/virt 'its_off' variant blobs
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-7-philmd@linaro.org>
 <671a6c82-ae10-4f3b-9d83-cecc32755206@linaro.org>
 <20250409160531.341c205e@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250409160531.341c205e@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102f.google.com
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

Hi Igor,

On 4/9/25 11:05, Igor Mammedov wrote:
> On Fri, 4 Apr 2025 00:01:22 -0300
> Gustavo Romero <gustavo.romero@linaro.org> wrote:
> 
>> Hi Phil,
>>
>> On 4/3/25 17:40, Philippe Mathieu-Daudé wrote:
>>> We are going to fix the test_acpi_aarch64_virt_tcg_its_off()
>>> test. In preparation, copy the ACPI tables which will be
>>> altered as 'its_off' variants, and whitelist them.
>>>
>>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    tests/qtest/bios-tables-test-allowed-diff.h |   3 +++
>>>    tests/qtest/bios-tables-test.c              |   1 +
>>>    tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
>>>    tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
>>>    tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
>>>    5 files changed, 4 insertions(+)
>>>    create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>>>    create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
>>>    create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
>>>
>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>>> index dfb8523c8bf..3421dd5adf3 100644
>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>> @@ -1 +1,4 @@
>>>    /* List of comma-separated changed AML files to ignore */
>>> +"tests/data/acpi/aarch64/virt/APIC.its_off",
>>> +"tests/data/acpi/aarch64/virt/FACP.its_off",
>>> +"tests/data/acpi/aarch64/virt/IORT.its_off",
>>
>> I think your first approach is the correct one: you add the blobs
>> when adding the new test, so they would go into patch 5/9 in this series,
>> making the test pass without adding anything to bios-tables-test-allowed-diff.h.
>> Then in this patch only add the APIC.its_off table to the bios-tables-test-allowed-diff.h
>> since that's the table that changes when the fix is in place, as you did in:
> 
> if APIC.its_off is the only one that's changing, but FACP/IORT blobs are the same
> as suffix-less blobs, one can omit copying FACP/IORT as test harness will fallback
> to suffix-less blob if the one with suffix isn't found.

OK. Just clarifying and for the records, this is not the case for this series


> if blobs are different from defaults then create empty blobs and whitelist them in the same patch
> then do your changes and then update blobs & wipeout withe list.

Thanks for confirming it. That's what I suggested to Phil in my first review and what
I understood from the prescription in bios-tables-test.c.

However, on second thoughts, for this particular series, isn't it better to have the following commit sequence instead:

1) Add the new test and the new blobs that make the test pass, i.e. APIC.suffix, FACP.suffix, and IORT.suffix (they are different than the default suffix-less blobs)
2) Whitelist only the APIC.suffix since that's the table that will change with the fix
3) Add the fix (which changes the APIC table so a new APIC.suffix blob is needed and also stops generating the IORT table, so no more IORT.suffix blob is necessary)
4) Finally, update only the APIC.suffix blob and remove the IORT.suffix blob and wipe out the whitelist

This way:

A) It's clear that only ACPI blob changed with the fix, because there is no addition of a FACP.suffix blob in 4) (it remains the same)
B) It's clear that the IORT table is removed with the fix and is not relevant anymore for the test

What do you think?


Cheers,
Gustavo

> Phil,
> the process is described in doc comment at the top of tests/qtest/bios-tables-test.c
> 
>> https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg07082.html
>>
>> Plus, adding the blobs, which are actually related to the test in the other
>> patch, and ignoring them at the same time looks confusing to me. I understand
>> that only the blob that changes (APIC.its_off) with the fix should be temporarily
>> ignored and, later, updated, as in your first series.
>>
>>
>> Cheers,
>> Gustavo
>>
>>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>>> index baaf199e01c..55366bf4956 100644
>>> --- a/tests/qtest/bios-tables-test.c
>>> +++ b/tests/qtest/bios-tables-test.c
>>> @@ -2151,6 +2151,7 @@ static void test_acpi_aarch64_virt_tcg_its_off(void)
>>>        test_data data = {
>>>            .machine = "virt",
>>>            .arch = "aarch64",
>>> +        .variant = ".its_off",
>>>            .tcg_only = true,
>>>            .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>>>            .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>>> diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..c37d05d6e05805304f10afe73eb7cb9100fcccfa
>>> GIT binary patch
>>> literal 184
>>> zcmZ<^@O0k6z`($=+{xeBBUr&HBEVSz2pEB4AU24G0Uik$i-7~iVgWL^17JJ`2AFzr
>>> bgb+@aBn}xq0gwb2)Q)cq{30-g9B_L93G4|0
>>>
>>> literal 0
>>> HcmV?d00001
>>>
>>> diff --git a/tests/data/acpi/aarch64/virt/FACP.its_off b/tests/data/acpi/aarch64/virt/FACP.its_off
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..606dac3fe4b55c31fd68b25d3a4127eeef227434
>>> GIT binary patch
>>> literal 276
>>> zcmZ>BbPf<<WME(uaq@Te2v%^42yj*a0-z8Bhz+8t3j|P&V`N}P6&N^PpsQ~v$aVnZ
>>> CVg~^L
>>>
>>> literal 0
>>> HcmV?d00001
>>>
>>> diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..0fceb820d509e852ca0849baf568a8e93e426738
>>> GIT binary patch
>>> literal 236
>>> zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=RgMkDCNC*yK9F_<M77!bR
>>> zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@
>>> R!2`+%Dg6Hr$N|zYvjDIZ5CH%H
>>>
>>> literal 0
>>> HcmV?d00001
>>>    
>>
> 


