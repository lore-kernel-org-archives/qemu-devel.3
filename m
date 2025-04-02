Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882B9C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 10:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzvNA-0006uE-JA; Wed, 02 Apr 2025 06:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzvN9-0006ti-IA
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:31:03 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzvN7-0007aa-0g
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:31:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso62515295e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 03:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743589859; x=1744194659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OZDHI+zGbGkxkMlquNobUBcmxvdT0JwthT7/jNdyBcI=;
 b=qQUk4ZY6fDirMOvkezevcryeKmw72zrOonptIUmSuOdxC3eea1mV6JPSyVeaLb15SF
 1fp9v4CrXS0Uzya3mE9JWrnSolw2FhNnQbCAN+3J4+t3EDzxeQ3F2ixI8nQ7HPWhnr5n
 Le2URDk1kYIoPEWWgsUeHU/ajOJZhNevMl1BLfdCqZsx+sypEW2lm1CIrqzXZ4ULoUU5
 FWT3cyZOv7VeR4bi35o09v+x5+sy6MDmbNxyDSs7DQT6cKTuQIyftxtWY6dwrLBa6Kxd
 Y4gXu2FngihxpTm/Ds2BlHGEMWMiP5EUIGcAssFNJEwxWpApj0N2C2RWcGaHFYu08gYI
 TTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743589859; x=1744194659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OZDHI+zGbGkxkMlquNobUBcmxvdT0JwthT7/jNdyBcI=;
 b=BAcRUUpBCBjxdWSdvcKDskyS/UJEN2mL00qFDDP57juL4TfMcqi0VNz2S1buY9hK5B
 +NJWTIvPA3JR6dzYaXU/S59fi7T8UBVxqF/zf+w4JtNeLVWNEZak3tFJmv2N0JTZ6Ud4
 u2aHc9/CocSQ14LjQxxRuVwXUf9V4ph+uHpMoUAQ7eAzymzX+Oc7KwHWQ/yTRQmo3jSi
 Sdt1yFqlkRjdrmDY2Cz4UuuEP9zl4W8K4wpanvCIhKThQKvTQlBBUIdNgXfa4G2ju/RG
 S+9y3cCJQBK9+wrD+K+Mnd7aPWXfTtlu/sQyTtPgH4ehLiq5qCH/mMssYP9wrmLLPJLo
 H1IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaiS90LmgAP7tZ4zmT9dFjoFTMg+ofNAG0XtII6SHi5r4t9vI8WlnNPsoPlmIZ2seE6/zwgmdmmYiA@nongnu.org
X-Gm-Message-State: AOJu0YzKPNB5gvbPu2zWkj+XDEUycJttDYbq4yIjZnTMioiKIQgUKgH3
 8ruM+3oTcP0irpHNMLiDxwwlkfH04IZSBFgRXXSn4Kwv6fukP09n3xQObX1P95w=
X-Gm-Gg: ASbGncuz8WZbz4umu09FCJDpCFCn7jhsvxS4E38BIm2v7Cp0R9XzLIL/hMiis1Mic1S
 2qFTPN42ONnov2GpYmldHZa3KrQ9YKj7kL5942ymMHmhfXk5Xs1Mb+vyl09bdR7Y6qefqZbpjQJ
 s6txqBosM4XdbzsyktyQeoFjzp+cWbfiIGAwijELwsoiN8Or3UlNZL/ohB8QnaVUuRTJ9vWIaFb
 3soFGkdlm0Q225fvpkLY9WzCxxM95NdPPA9qvfA3thQtaoAbWtrWErYjkhW32YyIBrueGzXcJbw
 3u3v32kXTuQDg9baEjeLi1P0z2Ll6aMx3WcgLMsMmhUoQKPYFa/2Gh6VcJUVOYlc/n/yDJtcXd/
 n0KSkvj80Ab8+
X-Google-Smtp-Source: AGHT+IFFPC1xRyng98W+zKmwacjgAQepJnCiBEehbNHwhgjYGnFs2lyyCJ5jPlYgs5drShWGfBr1/g==
X-Received: by 2002:a05:600c:3d05:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-43eada7b857mr34406345e9.20.1743589859140; 
 Wed, 02 Apr 2025 03:30:59 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb5fc688fsm16499035e9.4.2025.04.02.03.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 03:30:58 -0700 (PDT)
Message-ID: <d3059aa1-952b-46b9-bb96-dace60664f49@linaro.org>
Date: Wed, 2 Apr 2025 12:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 1/5] qtest/bios-tables-test: Add test for -M
 virt,its=off
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
 <20250331221239.87150-2-philmd@linaro.org>
 <1d1362a0-b544-476c-a305-a7d2212db423@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1d1362a0-b544-476c-a305-a7d2212db423@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 2/4/25 08:41, Gustavo Romero wrote:
> Hi Phil,
> 
> On 3/31/25 19:12, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Please, put commit message (body) into the commits.
> 
> For example, the commit message here could quickly explain that the FACP 
> table
> changed because virtualization=on (due to PSCI conduit). I'm assuming
> virtualization is set to on because gic-version=max and so GICv4 is 
> selected for
> testing. It also could be that  we want to exercise its=off when Arm 
> Virtualization
> Extensions are enabled, which is the common use case (I understand that ITS
> can be used also with virtualization=off).
> 
> Finally, the commit message could mention at the end which struct
> vanishes in APIC table and why IO remapping table is affected by
> ITS on/off.
> 
> A good commit message always help in code spelunking :)

I simply copied the reproducer from the issue, so I'll mention that.
(https://gitlab.com/qemu-project/qemu/-/issues/2886)

> 
> 
>> ---
>>   tests/qtest/bios-tables-test.c            |  22 ++++++++++++++++++++++
>>   tests/data/acpi/aarch64/virt/APIC.its_off | Bin 0 -> 184 bytes
>>   tests/data/acpi/aarch64/virt/FACP.its_off | Bin 0 -> 276 bytes
>>   tests/data/acpi/aarch64/virt/IORT.its_off | Bin 0 -> 236 bytes
>>   4 files changed, 22 insertions(+)
>>   create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>>   create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
>>   create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
>>
>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables- 
>> test.c
>> index 0a333ec4353..55366bf4956 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -2146,6 +2146,26 @@ static void 
>> test_acpi_aarch64_virt_tcg_topology(void)
>>       free_test_data(&data);
>>   }
>> +static void test_acpi_aarch64_virt_tcg_its_off(void)
>> +{
>> +    test_data data = {
>> +        .machine = "virt",
>> +        .arch = "aarch64",
>> +        .variant = ".its_off",
>> +        .tcg_only = true,
>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>> +        .cd = "tests/data/uefi-boot-images/bios-tables- 
>> test.aarch64.iso.qcow2",
>> +        .ram_start = 0x40000000ULL,
>> +        .scan_len = 128ULL * 1024 * 1024,
>> +    };
>> +
>> +    test_acpi_one("-cpu cortex-a57 "
>> +                  "-M virtualization=on,secure=off "
>> +                  "-M gic-version=max,its=off,iommu=smmuv3", &data);
>> +    free_test_data(&data);
>> +}
>> +
>>   static void test_acpi_q35_viot(void)
>>   {
>>       test_data data = {
>> @@ -2577,6 +2597,8 @@ int main(int argc, char *argv[])
>>                              test_acpi_aarch64_virt_tcg_acpi_hmat);
>>               qtest_add_func("acpi/virt/topology",
>>                              test_acpi_aarch64_virt_tcg_topology);
>> +            qtest_add_func("acpi/virt/its_off",
>> +                           test_acpi_aarch64_virt_tcg_its_off);
>>               qtest_add_func("acpi/virt/numamem",
>>                              test_acpi_aarch64_virt_tcg_numamem);
>>               qtest_add_func("acpi/virt/memhp", 
>> test_acpi_aarch64_virt_tcg_memhp);
>> diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/ 
>> acpi/aarch64/virt/APIC.its_off
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..c37d05d6e05805304f10afe73eb7cb9100fcccfa
>> GIT binary patch
>> literal 184
>> zcmZ<^@O0k6z`($=+{xeBBUr&HBEVSz2pEB4AU24G0Uik$i-7~iVgWL^17JJ`2AFzr
>> bgb+@aBn}xq0gwb2)Q)cq{30-g9B_L93G4|0
>>
>> literal 0
>> HcmV?d00001
>>
>> diff --git a/tests/data/acpi/aarch64/virt/FACP.its_off b/tests/data/ 
>> acpi/aarch64/virt/FACP.its_off
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..606dac3fe4b55c31fd68b25d3a4127eeef227434
>> GIT binary patch
>> literal 276
>> zcmZ>BbPf<<WME(uaq@Te2v%^42yj*a0-z8Bhz+8t3j|P&V`N}P6&N^PpsQ~v$aVnZ
>> CVg~^L
>>
>> literal 0
>> HcmV?d00001
>>
>> diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/ 
>> acpi/aarch64/virt/IORT.its_off
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..0fceb820d509e852ca0849baf568a8e93e426738
>> GIT binary patch
>> literal 236
>> zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=RgMkDCNC*yK9F_<M77!bR
>> zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@
>> R!2`+%Dg6Hr$N|zYvjDIZ5CH%H
>>
>> literal 0
>> HcmV?d00001
>>
> 
> I think the prescription for the acrobatics to update the ACPI expected
> tables says the blobs here should be empty (blob files are added empty)
> and at the same time they are listed in tests/qtest/bios-tables-test- 
> allowed-diff.h:
> 
>   * 1. add empty files for new tables, if any, under tests/data/acpi
>   * 2. list any changed files in tests/qtest/bios-tables-test-allowed- 
> diff.h
>   * 3. commit the above *before* making changes that affect the tables
> 
> (from tests/qtest/bios-tables-test.c header)
> 
> If that's correct, this patch should be merged with the following one 
> (2/5) and
> IORT.its_off and FACP.its_off should also be listed in
> tests/qtest/bios-tables-test-allowed-diff.h so the empty blobs won't 
> trigger
> a test failure.

I shouldn't have included the ACPI data in this patch but in the
following. IIUC, if no data/$TABLE.$variant, then the generic
data/$TABLE is used.

> 
> Then patch 5/5 should add the expected/updated blobs and drop the 
> *.its_off from
> bios-tables-test-allowed-diff.h. Patches 3/5 and 4/5 are sandwiched
> between (1/5 + 2/5) and (5/5).
> 
> At least that's what I get from:
> 
>   * The resulting patchset/pull request then looks like this:
>   * - patch 1: list changed files in tests/qtest/bios-tables-test- 
> allowed-diff.h.
>   * - patches 2 - n: real changes, may contain multiple patches.
>   * - patch n + 1: update golden master binaries and empty tests/qtest/ 
> bios-tables-test-allowed-diff.h
> 
> Otherwise the change looks good.
> 
> 
> Cheers,
> Gustavo


