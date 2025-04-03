Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0A3C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 06:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0E7n-0005x9-HM; Thu, 03 Apr 2025 02:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0E7P-0005uj-FY
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 02:32:07 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0E7N-0008Kn-G2
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 02:32:03 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22423adf751so5448865ad.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743661919; x=1744266719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rhAyJkOpi68aEAQQTv65+9X/E2pd+e9U9MdxH77h+LE=;
 b=PFmLmtfhjq6gASKW7VqyAcp5WoVYkkweR8992Coid6BYgkULATprcGIIjlTVDfkuS5
 nw9pG7i4IL2Wo4Cm3CUM3AikTryhD8Yxxv3onTek2n5pJyHy3MaD4O1YhIosc5MjnLWz
 9ZNdRIXSCKuRCHGeR0C3d0c/uE9cbdplmhN6jYNuQhA9tGtbk91DWU2cd8Bl2MTEfVJ1
 GaoMxohqgB9fLlsLtFZOhsVch+5bkvcAzShaHVxz4aFe15GCdT5NRMzRuADG59F3CUZ4
 qpKfJRyRGnQPV+q3G+WKFZZhSPnLrRtsqZX/V0F2Y8DNVrQ2LsVQPhqRxBI3iyU/pXHD
 LCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743661919; x=1744266719;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rhAyJkOpi68aEAQQTv65+9X/E2pd+e9U9MdxH77h+LE=;
 b=j5e+KGnCr90QFoseYo85dC/0VFs4bs9n4px+UB3AnAewch1Hyb3xfIKZt7YZaPgPNo
 oBbDdqcum8ejNsfHsEY7vBjy++kisFifs8i/UpPMCj2kpLppdHL4riIR4UT+/lccVMZY
 VUi88xLSctY/co5oTyCZlD3zbM3a5vB+ZlMw7+IJLHuZB88Rak6wklkNMc0nIGwuF72l
 onhLeJxpK4+mVmXaUUBzTMdU8NPPjz8HQx4yQe0/Qr3Oe3yoKXJszMydMAmU1YvmYP+1
 0kERR2AZuXK+ZshuPFGNPyV3CNn4DMNCh9oP+w7h8ylivYkyMqJ9FhvpAJFd7cd5DUif
 Jqag==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3PiY8sn3kCVOSgrQbOthGCqcwpAJuiP+wW3+YDmrVVMaD0dfkbcSWSm/93gOLKx8hgZ/HFHjCNC/2@nongnu.org
X-Gm-Message-State: AOJu0YyRpFSlGISbbao0yJLk6ZvMVF6fJlJKqBWZPt5yV5MIsGfR7fJ3
 lV47SDiyPQ5Ux16kNzQrSEfl5LpSr8FOo/f7qEeOVSWsCKqCZYoKrSSVM+mcljg=
X-Gm-Gg: ASbGncv2VEXjFHca91VEI+1UNLR1Slc+x9vlgggYhpohJfMDWnUVsChMBU1VbuXID2D
 CG1lY5nWS7JAz/GGe+pZOgDrFxXJ1tEinPLhmhucYiC5j5CxHt86Dtm/vWTXULzMT+Qp2Fxa1mQ
 LuzUbg7NKsNYSCr2k+d2a0SWQYMVSzXKyIjqv37FJogUgThDYLTEvsfDrEPK1j2X4DTiHXhrS4O
 Jkme3W+8UTYJueORoymQG1G01Xz2SzwMIoKlDmrWVbXvJlBy6uqnnYIHpvzULUoC3n7lhXNSPg4
 SMop4zX02dXTK60z0Fzr7jQpNpEMeipioyQGoUoUZSojilvcmeTU19Ab
X-Google-Smtp-Source: AGHT+IG+A0/FB94IIs8HImgSe0/O3BqEuLMtbc9zhDOxx0lnkc6atNMqD4JN9uWgtIafFyc52trllg==
X-Received: by 2002:a17:903:2a90:b0:224:76f:9e4a with SMTP id
 d9443c01a7336-22993c0ddd4mr16027665ad.14.1743661918776; 
 Wed, 02 Apr 2025 23:31:58 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866080csm6656195ad.125.2025.04.02.23.31.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 23:31:58 -0700 (PDT)
Message-ID: <192fd8e8-c1fb-4537-b773-6b2548881d7f@linaro.org>
Date: Thu, 3 Apr 2025 03:31:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 5/5] qtest/bios-tables-test: Update
 aarch64/virt/APIC.its_off blob
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
 <20250331221239.87150-6-philmd@linaro.org>
 <98b286c5-f48f-4dec-b6c7-3e1ca2156735@linaro.org>
 <b34b6ab3-ac42-4d94-a30d-0d8ebed960f5@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <b34b6ab3-ac42-4d94-a30d-0d8ebed960f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/2/25 07:34, Philippe Mathieu-Daudé wrote:
> On 2/4/25 08:45, Gustavo Romero wrote:
>> Hi Phil,
>>
>> On 3/31/25 19:12, Philippe Mathieu-Daudé wrote:
>>> Changes in the tables:
>>>
>>>    @@ -1,32 +1,32 @@
>>>     /*
>>>      * Intel ACPI Component Architecture
>>>      * AML/ASL+ Disassembler version 20240927 (64-bit version)
>>>      * Copyright (c) 2000 - 2023 Intel Corporation
>>>      *
>>>      * Disassembly of tests/data/acpi/aarch64/virt/APIC.its_off
>>>      *
>>>      * ACPI Data Table [APIC]
>>>      *
>>>      * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>>>      */
>>>
>>>     [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
>>>    -[004h 0004 004h]                Table Length : 000000B8
>>>    +[004h 0004 004h]                Table Length : 000000A4
>>>     [008h 0008 001h]                    Revision : 04
>>>    -[009h 0009 001h]                    Checksum : A7
>>>    +[009h 0009 001h]                    Checksum : EE
>>>     [00Ah 0010 006h]                      Oem ID : "BOCHS "
>>>     [010h 0016 008h]                Oem Table ID : "BXPC    "
>>>     [018h 0024 004h]                Oem Revision : 00000001
>>>     [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>>>     [020h 0032 004h]       Asl Compiler Revision : 00000001
>>>
>>>     [024h 0036 004h]          Local Apic Address : 00000000
>>>     [028h 0040 004h]       Flags (decoded below) : 00000000
>>>                              PC-AT Compatibility : 0
>>>
>>>     [02Ch 0044 001h]               Subtable Type : 0C [Generic Interrupt Distributor]
>>>     [02Dh 0045 001h]                      Length : 18
>>>     [02Eh 0046 002h]                    Reserved : 0000
>>>     [030h 0048 004h]       Local GIC Hardware ID : 00000000
>>>     [034h 0052 008h]                Base Address : 0000000008000000
>>>     [03Ch 0060 004h]              Interrupt Base : 00000000
>>>    @@ -49,37 +49,29 @@
>>>     [06Ch 0108 008h]    Virtual GIC Base Address : 0000000000000000
>>>     [074h 0116 008h] Hypervisor GIC Base Address : 0000000000000000
>>>     [07Ch 0124 004h]       Virtual GIC Interrupt : 00000019
>>>     [080h 0128 008h]  Redistributor Base Address : 0000000000000000
>>>     [088h 0136 008h]                   ARM MPIDR : 0000000000000000
>>>     [090h 0144 001h]            Efficiency Class : 00
>>>     [091h 0145 001h]                    Reserved : 00
>>>     [092h 0146 002h]      SPE Overflow Interrupt : 0000
>>>     [094h 0148 002h]              TRBE Interrupt : 100E
>>>
>>>     [094h 0148 001h]               Subtable Type : 0E [Generic Interrupt Redistributor]
>>>     [095h 0149 001h]                      Length : 10
>>>     [097h 0151 002h]                    Reserved : 0000
>>>     [098h 0152 008h]                Base Address : 00000000080A0000
>>>     [0A0h 0160 004h]                      Length : 00F60000
>>>
>>>    -[0A4h 0164 001h]               Subtable Type : 0F [Generic Interrupt Translator]
>>>    -[0A5h 0165 001h]                      Length : 14
>>>    -[0A7h 0167 002h]                    Reserved : 0000
>>>    -[0A8h 0168 004h]              Translation ID : 00000000
>>>    -[0ACh 0172 008h]                Base Address : 0000000008080000
>>>    -[0B4h 0180 004h]                    Reserved : 00000000
>>>    +Raw Table Data: Length 164 (0xA4)
>>>
>>>    -Raw Table Data: Length 184 (0xB8)
>>>    -
>>>    -    0000: 41 50 49 43 B8 00 00 00 04 A7 42 4F 43 48 53 20  // APIC......BOCHS
>>>    +    0000: 41 50 49 43 A4 00 00 00 04 EE 42 4F 43 48 53 20  // APIC......BOCHS
>>>         0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
>>>         0020: 01 00 00 00 00 00 00 00 00 00 00 00 0C 18 00 00  // ................
>>>         0030: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00  // ................
>>>         0040: 04 00 00 00 0B 50 00 00 00 00 00 00 00 00 00 00  // .....P..........
>>>         0050: 01 00 00 00 00 00 00 00 17 00 00 00 00 00 00 00  // ................
>>>         0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>>>         0070: 00 00 00 00 00 00 00 00 00 00 00 00 19 00 00 00  // ................
>>>         0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>>>         0090: 00 00 00 00 0E 10 00 00 00 00 0A 08 00 00 00 00  // ................
>>>    -    00A0: 00 00 F6 00 0F 14 00 00 00 00 00 00 00 00 08 08  // ................
>>>    -    00B0: 00 00 00 00 00 00 00 00                          // ........
>>>    +    00A0: 00 00 F6 00                                      // ....
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>>>   tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 184 -> 164 bytes
>>>   2 files changed, 1 deletion(-)
>>>
>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/ qtest/bios-tables-test-allowed-diff.h
>>> index bfc4d601243..dfb8523c8bf 100644
>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>> @@ -1,2 +1 @@
>>>   /* List of comma-separated changed AML files to ignore */
>>> -"tests/data/acpi/aarch64/virt/APIC.its_off",
>>> diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/ acpi/aarch64/virt/APIC.its_off
>>> index c37d05d6e05805304f10afe73eb7cb9100fcccfa..f24ac8fbff5261a52434abcfcff96dbdc7709de4 100644
>>> GIT binary patch
>>> delta 18
>>> ZcmdnNxP+0*F~HM#2?GNI%e#qOvj8xy1yKM1
>>>
>>> delta 39
>>> jcmZ3&xPy_)F~HM#2Ll5G%kqg_vqbnsfJ`vp;DE6Jpmzmj
>>
>> If the change affects other tables besides APIC (IORT and FACP in this series),
>> then I think that's the moment to update all the correct blobs (final versions)
>> and drop the list of blobs in bios-tables-test-allowed-diff.h. I also think it's
>> better to list all the table diffs in the commit message, not only the diff for
>> the APIC table.
> 
> When following the script steps with V=2, I only see diff change in the
> MADT table.

I was thinking of the case if empty blobs were added to 1/5. Indeed, FACP table does
not change, sorry for the confusion.

After the fix just APIC table changes, so the patch is correctly listing it in the
commit message and removing it from the "ignore list".

However, as I mentioned in 3/5, the IORT table is being gated as well by its_enabled(),
so after the fix no IORT table is generated by QEMU, hence tests/qtest/bios-tables-test.c
never sees/loads any IORT table to compare against IORT.its_off added in 1/5. There are
no test failures but IORT.its_off is a "dead blob". I think it should be removed in this
patch just like APIC table blob is updated, for consistence.


Cheers,
Gustavo
  
> Igor, am I missing something?
> 
>>
>> Cheers,
>> Gustavo
> 


