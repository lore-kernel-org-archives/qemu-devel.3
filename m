Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7577C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 10:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzvQY-00006X-OJ; Wed, 02 Apr 2025 06:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzvQO-00005x-Dg
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:34:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzvQM-0000ME-3s
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:34:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso420038f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 03:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743590060; x=1744194860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zjqm5otoX3blaef8ZeheL7iB1TbA1gOguF8Ug2ztT/A=;
 b=YQPDAwrQX6FvAkexpJFpXcWqxlBM1IphTQ4Tt7aSKqWNMKZ/2IiizkFteEbwk4cN7G
 Tu3zghSA0nswklt2jLOGTovhGOkLv6ru47eXHYprCkck9nl1HipsKa6HEvkVbH/xjvLk
 wLWNSGUI++avmxlVlgzbFbQOXPncbnz3jQhsyvdZsz3dlvbRVEn4HcQwXW35gAqhYAEM
 UbA/V81qEQZj7BskmhQMc7SaEbv/G0pdDKluTCz2FH+2Pe2eVk0wZMejKffkZ1xDhuGO
 zm78FIqS584fsXWSNXornRoRzA54+aoLD+6l41dw1uLL3QtcGRKTtit3cteXilak97SL
 spnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743590060; x=1744194860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zjqm5otoX3blaef8ZeheL7iB1TbA1gOguF8Ug2ztT/A=;
 b=WABeaThagXt6FUaNgwrSLIqd0moD9y0w71XTJv/ws7gy/HjANSqsFqbVLmEoF4PfoW
 qpEZjn394Nw8d4WPXqV4m70LgSqHXVkYv8k7H4AmehmQmKlDZ6t0cNEDYgb/0RP5Mamu
 CGby8RNp4IGG7N6PeZWwapKGKjmjFtNyOZUo3YQCJaE91Zf23AzQZ0HDcUGhDf9IdxGd
 z1YmPDotv3q1Jj6i+B2IRIc/gEKRnQRXd35VyjHdylED0cs30AhOb2/cUljm03zyyneK
 dvsJcjKF8DKGbAGKY1ja+UPKDoBQtGjby9Ikv5c85rp0EmU9meCkRE54X/0uzjTeyDuV
 LQOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV84UK+KVr0w84MWjRnS37sjaH6Hxln/Kucz9eBPtIk77OidVH6G3mVkTqUgSNZ2cXmqUmFnRm1xev+@nongnu.org
X-Gm-Message-State: AOJu0YwEkFYXSZ2Rd8xHT4tJanD9xvOzW21rbHIir8kLDPXtJ/mEcsIY
 isb1ju4HSvMZqFMUtUU6lKAhXYs2qoT7dckvwuo6bgJHmSFkZVimAPFcSRwfBu0=
X-Gm-Gg: ASbGncv6O4WoUjAn+uftH+xDwKZrZc7T3ALyxaceh0Zz/T+N7M9Zvl0dLh6LOsM8gMw
 Xs6182OvaPVD6ZgulnsdsDbmjgwsJMwGrbRugPnpuL81MV6FIizAw4FYnZ7xlbAdhXBTFYtR62+
 n/StRgXgTSVX3SEBhhCzSlV9bfz156KwK8PtIo0kfC6V8EpQ+QLVoIQkmpxiMC+J75F8YOE17Gg
 KWIXNl3R2AloJJ5ZwbeddPqu3Fg7q85yLkHp8FsrPYAvACDCB6oErErthz9o0rpdmicRdXW3evx
 4ebT8AUEMokVuD/zsNf3NLze0OmqweCSgwB9TmcmrvIW8czqCNFOxbnNx7Sv96BPoZvulqja5Og
 wnEwfK5bBXiYT
X-Google-Smtp-Source: AGHT+IF460CDB2yG3B21THHSkkFby4GVIEHuOPI4OwezCvgPqiGO70GVB+N1pUF9S21jzXk0J5mdcQ==
X-Received: by 2002:a05:6000:40d9:b0:39c:cc7:3c93 with SMTP id
 ffacd0b85a97d-39c2a67875emr1362429f8f.18.1743590060390; 
 Wed, 02 Apr 2025 03:34:20 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663860sm16765603f8f.39.2025.04.02.03.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 03:34:19 -0700 (PDT)
Message-ID: <b34b6ab3-ac42-4d94-a30d-0d8ebed960f5@linaro.org>
Date: Wed, 2 Apr 2025 12:34:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 5/5] qtest/bios-tables-test: Update
 aarch64/virt/APIC.its_off blob
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
 <20250331221239.87150-6-philmd@linaro.org>
 <98b286c5-f48f-4dec-b6c7-3e1ca2156735@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <98b286c5-f48f-4dec-b6c7-3e1ca2156735@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 2/4/25 08:45, Gustavo Romero wrote:
> Hi Phil,
> 
> On 3/31/25 19:12, Philippe Mathieu-Daudé wrote:
>> Changes in the tables:
>>
>>    @@ -1,32 +1,32 @@
>>     /*
>>      * Intel ACPI Component Architecture
>>      * AML/ASL+ Disassembler version 20240927 (64-bit version)
>>      * Copyright (c) 2000 - 2023 Intel Corporation
>>      *
>>      * Disassembly of tests/data/acpi/aarch64/virt/APIC.its_off
>>      *
>>      * ACPI Data Table [APIC]
>>      *
>>      * Format: [HexOffset DecimalOffset ByteLength]  FieldName : 
>> FieldValue (in hex)
>>      */
>>
>>     [000h 0000 004h]                   Signature : "APIC"    [Multiple 
>> APIC Description Table (MADT)]
>>    -[004h 0004 004h]                Table Length : 000000B8
>>    +[004h 0004 004h]                Table Length : 000000A4
>>     [008h 0008 001h]                    Revision : 04
>>    -[009h 0009 001h]                    Checksum : A7
>>    +[009h 0009 001h]                    Checksum : EE
>>     [00Ah 0010 006h]                      Oem ID : "BOCHS "
>>     [010h 0016 008h]                Oem Table ID : "BXPC    "
>>     [018h 0024 004h]                Oem Revision : 00000001
>>     [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>>     [020h 0032 004h]       Asl Compiler Revision : 00000001
>>
>>     [024h 0036 004h]          Local Apic Address : 00000000
>>     [028h 0040 004h]       Flags (decoded below) : 00000000
>>                              PC-AT Compatibility : 0
>>
>>     [02Ch 0044 001h]               Subtable Type : 0C [Generic 
>> Interrupt Distributor]
>>     [02Dh 0045 001h]                      Length : 18
>>     [02Eh 0046 002h]                    Reserved : 0000
>>     [030h 0048 004h]       Local GIC Hardware ID : 00000000
>>     [034h 0052 008h]                Base Address : 0000000008000000
>>     [03Ch 0060 004h]              Interrupt Base : 00000000
>>    @@ -49,37 +49,29 @@
>>     [06Ch 0108 008h]    Virtual GIC Base Address : 0000000000000000
>>     [074h 0116 008h] Hypervisor GIC Base Address : 0000000000000000
>>     [07Ch 0124 004h]       Virtual GIC Interrupt : 00000019
>>     [080h 0128 008h]  Redistributor Base Address : 0000000000000000
>>     [088h 0136 008h]                   ARM MPIDR : 0000000000000000
>>     [090h 0144 001h]            Efficiency Class : 00
>>     [091h 0145 001h]                    Reserved : 00
>>     [092h 0146 002h]      SPE Overflow Interrupt : 0000
>>     [094h 0148 002h]              TRBE Interrupt : 100E
>>
>>     [094h 0148 001h]               Subtable Type : 0E [Generic 
>> Interrupt Redistributor]
>>     [095h 0149 001h]                      Length : 10
>>     [097h 0151 002h]                    Reserved : 0000
>>     [098h 0152 008h]                Base Address : 00000000080A0000
>>     [0A0h 0160 004h]                      Length : 00F60000
>>
>>    -[0A4h 0164 001h]               Subtable Type : 0F [Generic 
>> Interrupt Translator]
>>    -[0A5h 0165 001h]                      Length : 14
>>    -[0A7h 0167 002h]                    Reserved : 0000
>>    -[0A8h 0168 004h]              Translation ID : 00000000
>>    -[0ACh 0172 008h]                Base Address : 0000000008080000
>>    -[0B4h 0180 004h]                    Reserved : 00000000
>>    +Raw Table Data: Length 164 (0xA4)
>>
>>    -Raw Table Data: Length 184 (0xB8)
>>    -
>>    -    0000: 41 50 49 43 B8 00 00 00 04 A7 42 4F 43 48 53 20  // 
>> APIC......BOCHS
>>    +    0000: 41 50 49 43 A4 00 00 00 04 EE 42 4F 43 48 53 20  // 
>> APIC......BOCHS
>>         0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // 
>> BXPC    ....BXPC
>>         0020: 01 00 00 00 00 00 00 00 00 00 00 00 0C 18 00 
>> 00  // ................
>>         0030: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 
>> 00  // ................
>>         0040: 04 00 00 00 0B 50 00 00 00 00 00 00 00 00 00 
>> 00  // .....P..........
>>         0050: 01 00 00 00 00 00 00 00 17 00 00 00 00 00 00 
>> 00  // ................
>>         0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
>> 00  // ................
>>         0070: 00 00 00 00 00 00 00 00 00 00 00 00 19 00 00 
>> 00  // ................
>>         0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
>> 00  // ................
>>         0090: 00 00 00 00 0E 10 00 00 00 00 0A 08 00 00 00 
>> 00  // ................
>>    -    00A0: 00 00 F6 00 0F 14 00 00 00 00 00 00 00 00 08 
>> 08  // ................
>>    -    00B0: 00 00 00 00 00 00 00 
>> 00                          // ........
>>    +    00A0: 00 00 F6 00                                      // ....
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>>   tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 184 -> 164 bytes
>>   2 files changed, 1 deletion(-)
>>
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/ 
>> qtest/bios-tables-test-allowed-diff.h
>> index bfc4d601243..dfb8523c8bf 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1,2 +1 @@
>>   /* List of comma-separated changed AML files to ignore */
>> -"tests/data/acpi/aarch64/virt/APIC.its_off",
>> diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/ 
>> acpi/aarch64/virt/APIC.its_off
>> index 
>> c37d05d6e05805304f10afe73eb7cb9100fcccfa..f24ac8fbff5261a52434abcfcff96dbdc7709de4 100644
>> GIT binary patch
>> delta 18
>> ZcmdnNxP+0*F~HM#2?GNI%e#qOvj8xy1yKM1
>>
>> delta 39
>> jcmZ3&xPy_)F~HM#2Ll5G%kqg_vqbnsfJ`vp;DE6Jpmzmj
> 
> If the change affects other tables besides APIC (IORT and FACP in this 
> series),
> then I think that's the moment to update all the correct blobs (final 
> versions)
> and drop the list of blobs in bios-tables-test-allowed-diff.h. I also 
> think it's
> better to list all the table diffs in the commit message, not only the 
> diff for
> the APIC table.

When following the script steps with V=2, I only see diff change in the
MADT table.

Igor, am I missing something?

> 
> Cheers,
> Gustavo


