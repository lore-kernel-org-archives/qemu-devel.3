Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C94C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TAZ-0007eS-7F; Thu, 17 Apr 2025 13:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5TAV-0007c8-Dm
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:36:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5TAT-0002G6-7o
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:36:55 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so958894b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744911411; x=1745516211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g45C9jLKx991ecB/gjq5fkQ1idoaBzHMXAu1i6Ompk4=;
 b=ADI0lmvlMpRBIf/pommP04JqfufNrylL1Qg7aO4gYMmJ32n4cZobJN6Jl79d6d50yM
 0CAgpGFHwThpLIWmsV4Jqn/P4zF7JyCa9d9cy9J5HXE1XXJW7kH++B+pkahRfj07c6dF
 GAroXb6wNvipGY0KWm8aBmQ0fit7tOVKAgWgg6x2SZ9a6XT17Zowa6tegfW7SwNCX/vH
 IrjQb2prQJG4LpFTY4NnLyMCFrAJfY7d4nkB0IeSPU7GLHD6SgC42LTzsekv+lOVyJq0
 DZCGfprCO0bGgdn3UkGKWLOSJLukPXkMJ4N15o6PsU/PEAAXpaqp+JUufuQywpoNMv7x
 +AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744911411; x=1745516211;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g45C9jLKx991ecB/gjq5fkQ1idoaBzHMXAu1i6Ompk4=;
 b=J5Of6gg+GKn/Ik+jIwCMoRyTB2PtNdB+3W3chHMX1wRqWPVCDgoxVeHPNKM5/OQ0UF
 ONiM3ri1Sd8fNqUsoxQCwvsV8ePJZp1cEHHqEQ7bWSDDzgNzXbDBPp/RgjUtz7pJw9xp
 hGqqRD7zXejYDL6cQFaP1g+Xr9YkWmE7NdyA0KyqoLPjnZo+hPEvWnvrFHzhrNW8BXgk
 8XGhTOpfXE/zJ2wG5mOhU7MRsrtvsP9kUkhWRL5dnANAKgvZd/Tw1M5om0bMf+KWWI+D
 Cy03mU2cEvSkwQPFkA6+wIjfkdwHkmqKGffzOpuYU9K5LA5tqIsNENMfSdyyfveSiBBT
 lhaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3uflEfq4PIEI4ActZhaogZ+ofwjfCfryhTX/Su/SQwHmSUM1XCIflkKHsWJcywAwXO74rEypNS1UM@nongnu.org
X-Gm-Message-State: AOJu0Yx7pcmTvSZnxNgIJR5jESRYLKfO7hKoJ534WFLM8hw7i6gCftiU
 3j5zXvR+RI8bnIeLM0oHuzrO0yj+oBgswg5XxZQ4smgnthn70WdfXNnTLEObgVU=
X-Gm-Gg: ASbGncsawSsLESGbF/E7nJUpVOGszniRCElm+ApQI+zypQ/GiFXb/LhjvS799l1QKHO
 uYzb9MQJxVYxvC7Whd+H6kJKFMiOlzqZ/NVqdVwRNiCezV1qtTZzMLzEEilic2EbOena4uknPoa
 7M7AoeqT8fzZCJXmQAeCTjEnntUqk0v3g360SxeAWbxGykFJoMheOeEZntILeRHWhmWbswGsVMW
 OTZMSSEoQqy2SwFKZMaQA7jaOdVdKXUoKPM7LILvhKnn9LK0zQUnXKMZ6ZrxZIuusH0s0aE0H4W
 FkF9OBBGhoDARV8Z9BGEDFLn8AjDRdJ49fyfTBktt3sU7DqaDmimdYufgJKb3+I=
X-Google-Smtp-Source: AGHT+IHF5lCoZiah29Smw2GF3RmXeRi2Xq4gRSe6Io5dr0fMn4JvUxsTuWQ1su/j6UfiN1uo5ChDEA==
X-Received: by 2002:a05:6a00:8c02:b0:736:32d2:aa82 with SMTP id
 d2e1a72fcca58-73c267f5586mr9215516b3a.23.1744911411216; 
 Thu, 17 Apr 2025 10:36:51 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db12743afsm158530a12.16.2025.04.17.10.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:36:50 -0700 (PDT)
Message-ID: <78a52486-d86b-41b1-88b7-727371f17ecf@linaro.org>
Date: Thu, 17 Apr 2025 14:36:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 10/13] tests/qtest/bios-table-tests: Update ACPI
 table binaries for microvm
To: annie.li@oracle.com, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204402.3010-1-annie.li@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250411204402.3010-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
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

Hi Annie,

On 4/11/25 17:44, Annie Li wrote:
> Following is the diff generated by the step 5 and 6 in
> tests/qtest/bios-tables-test.c
> 
> Diff from iasl to show changes in DSDT table:
> 
> --- /tmp/asl-2F0N42.dsl 2025-04-11 12:50:02.892883467 +0000
> +++ /tmp/asl-C81N42.dsl 2025-04-11 12:50:02.890883378 +0000
> @@ -1,30 +1,30 @@
>   /*
>    * Intel ACPI Component Architecture
>    * AML/ASL+ Disassembler version 20210604 (64-bit version)
>    * Copyright (c) 2000 - 2021 Intel Corporation
>    *
>    * Disassembling to symbolic ASL+ operators
>    *
> - * Disassembly of tests/data/acpi/x86/microvm/DSDT, Fri Apr 11 12:50:02 2025
> + * Disassembly of /tmp/aml-481N42, Fri Apr 11 12:50:02 2025

Same comment from 4/13 regarding diff confusing git am and b4 and about the filename.

Otherwise:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

>    *
>    * Original Table Header:
>    *     Signature        "DSDT"
> - *     Length           0x0000016D (365)
> + *     Length           0x000001BA (442)
>    *     Revision         0x02
> - *     Checksum         0x11
> + *     Checksum         0xD5
>    *     OEM ID           "BOCHS "
>    *     OEM Table ID     "BXPC    "
>    *     OEM Revision     0x00000001 (1)
>    *     Compiler ID      "BXPC"
>    *     Compiler Version 0x00000001 (1)
>    */
>   DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
>   {
>       Scope (_SB)
>       {
>           Device (FWCF)
>           {
>               Name (_HID, "QEMU0002")  // _HID: Hardware ID
>               Name (_STA, 0x0B)  // _STA: Status
>               Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>               {
> @@ -66,56 +66,82 @@
>                       0x00000009,
>                   }
>               })
>               OperationRegion (EREG, SystemMemory, 0xFEA00000, 0x04)
>               Field (EREG, DWordAcc, NoLock, WriteAsZeros)
>               {
>                   ESEL,   32
>               }
> 
>               Method (_EVT, 1, Serialized)  // _EVT: Event
>               {
>                   Local0 = ESEL /* \_SB_.GED_.ESEL */
>                   If (((Local0 & 0x02) == 0x02))
>                   {
>                       Notify (PWRB, 0x80) // Status Change
>                   }
> +
> +                If (((Local0 & 0x10) == 0x10))
> +                {
> +                    Notify (SLPB, 0x80) // Status Change
> +                }
>               }
>           }
> 
>           Device (PWRB)
>           {
>               Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
>               Name (_UID, Zero)  // _UID: Unique ID
>           }
> 
> +        Device (SLPB)
> +        {
> +            Name (_HID, EisaId ("PNP0C0E") /* Sleep Button Device */)  // _HID: Hardware ID
> +            OperationRegion (\SLP, SystemIO, 0x0201, One)
> +            Field (\SLP, ByteAcc, NoLock, WriteAsZeros)
> +            {
> +                SBP,    1
> +            }
> +        }
> +
>           Device (VR07)
>           {
>               Name (_HID, "LNRO0005")  // _HID: Hardware ID
>               Name (_UID, 0x07)  // _UID: Unique ID
>               Name (_CCA, One)  // _CCA: Cache Coherency Attribute
>               Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>               {
>                   Memory32Fixed (ReadWrite,
>                       0xFEB00E00,         // Address Base
>                       0x00000200,         // Address Length
>                       )
>                   Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
>                   {
>                       0x00000017,
>                   }
>               })
>           }
>       }
> 
>       Scope (\)
>       {
> +        Name (_S3, Package (0x04)  // _S3_: S3 System State
> +        {
> +            0x03,
> +            Zero,
> +            Zero,
> +            Zero
> +        })
> +    }
> +
> +    Scope (\)
> +    {
>           Name (_S5, Package (0x04)  // _S5_: S5 System State
>           {
>               0x05,
>               Zero,
>               Zero,
>               Zero
>           })
>       }
>   }
> 
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   tests/data/acpi/x86/microvm/DSDT            | Bin 365 -> 442 bytes
>   tests/data/acpi/x86/microvm/DSDT.ioapic2    | Bin 365 -> 442 bytes
>   tests/data/acpi/x86/microvm/DSDT.pcie       | Bin 3023 -> 3100 bytes
>   tests/data/acpi/x86/microvm/DSDT.rtc        | Bin 404 -> 481 bytes
>   tests/data/acpi/x86/microvm/DSDT.usb        | Bin 414 -> 491 bytes
>   tests/qtest/bios-tables-test-allowed-diff.h |   5 -----
>   6 files changed, 5 deletions(-)
> 
> diff --git a/tests/data/acpi/x86/microvm/DSDT b/tests/data/acpi/x86/microvm/DSDT
> index f477668f2ee80241e47b340ad4a30f5480df2049..ee199a4fb65ab1a2d811f37d9b5bc67bccd34939 100644
> GIT binary patch
> delta 127
> zcmaFMw2PU`CD<io7b61$)76Pw(oD|c6V<breAy>X_GQ$Y_)vy#fxzVI1TFyvE`hdS
> zpMZ(K6f`w~v=c|Xho=jV;{_hR=!O`eKs+NiBNJnEBM+G480-WTnJmHREo~ex#LmLS
> V%)r1PAP~dA5g%*{7GMPm005{09v1)r
> 
> delta 54
> zcmdnR{FaH!CD<h-myv;iNpK>UG?TmVMD;8tAGV2;eHmpZK9rfv$0$2FjM0<JG+v0E
> Kg^QJefdK$+3k%2q
> 
> diff --git a/tests/data/acpi/x86/microvm/DSDT.ioapic2 b/tests/data/acpi/x86/microvm/DSDT.ioapic2
> index e5924a49962e0cff4228bcfc77ebcf48cb4a2219..7512d1527cf222d6f75a92f051f9eda402e28376 100644
> GIT binary patch
> delta 127
> zcmaFMw2PU`CD<io7b61$Q~yLRX(ng!iRxKQzU&hx`!ecHd?>@WKwxrp0+#>-mq1&v
> zPr$@q3YwZg+KD6H!_$Sw@d6KDbVCeKAfAz%k%=+7kq69i40ZyFOqO8umNt$TVrSuE
> UW?*0t5Qt&mhz~Xe3$OwO0ErwO(EtDd
> 
> delta 54
> zcmdnR{FaH!CD<h-myv;i>GVV{X(o5!iRxKQK5P>w`!dQ-d?+)Sk5P7V7^5ebX}l0S
> K3l}Q`0|Nky8w`Q~
> 
> diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
> index 8eacd21d6ecdf9a3cd3e4f03cf1b40748dcbf53e..5e3f80cbf82cab52fe310160c88d0a11ff069bf5 100644
> GIT binary patch
> delta 128
> zcmX>vK1YJfCD<iIhKGTHiDM#{G?VMziRxKQzU&hx`!ecHd?>@WKwxrp0+#>-mq1&v
> zPr$@q3YwZg+KD6H!_$Sw@d6KDbVCeKAfAz%k%=+7kq69i40ZyFY?feL%O!0bFT~Em
> W#mvCKARrLKz!4v83Kn1m3IG6dDjnGX
> 
> delta 55
> zcmbOuabBFuCD<k8JU0Ualj}q-X(rE|6V<breAp&V_GOfv_)umtAEWH%FvitfT&D3t
> L>?~ZY3=9kauQ3gZ
> 
> diff --git a/tests/data/acpi/x86/microvm/DSDT.rtc b/tests/data/acpi/x86/microvm/DSDT.rtc
> index e375473b5f033d374dd2a64a9f814fd16c3e262f..11258908703b64a835bd14307490c62c5ef7301f 100644
> GIT binary patch
> delta 129
> zcmbQj{E(T;CD<k8AtM6=)8dI-(o9~G6V)d&`La*k<;$oynS)V=Z-Kz%>I5zU1}=fN
> zV4r}=ii`@Hnm~pVN4$rp3y<Rk9=_;?7@$BrBR3-xV{{`AnBy4i1QeNU&*&{}952Mq
> X!o|$Mz#t$H!@v<AYzh`&1quKFJNg{0
> 
> delta 79
> zcmaFJJcXIdCD<io3L^sp)BTBD(oBA$6V)d&`LIpg<;y5LnS)VAI=V?RAUw#4Bi_T)
> jg*U)2z`)tSnSmod)YFAway6qjmub8ZI|~;p0|Ns9En5;N
> 
> diff --git a/tests/data/acpi/x86/microvm/DSDT.usb b/tests/data/acpi/x86/microvm/DSDT.usb
> index d63fd84620a2689120b32262f964e6a098d71632..7250d9f8ad45fca91afeda1089090eee11cd6594 100644
> GIT binary patch
> delta 127
> zcmbQo{F<4|CD<k8H6sH9)6<Du(o8N=6V<breAy>X_GQ$Y_)vy#fxzVI1TFyvE`hdS
> zpMZ(K6f`w~v=c|Xho=jV;{_hR=!O`eKs+NiBNJnEBM+G480-WTnJmFrBW)Zn#LmLS
> V%)r1PAP~dA5g%*{7GMPm006!m9&i8v
> 
> delta 54
> zcmaFOJdc^nCD<io9wP$-lj1}!X(kV`iRxKQK5P>w`!dQ-d?+)Sk5P7V7-JQeX}l0S
> K3l}Q`0|NkddJG`|
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index bb028db137..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,6 +1 @@
>   /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/x86/microvm/DSDT",
> -"tests/data/acpi/x86/microvm/DSDT.ioapic2",
> -"tests/data/acpi/x86/microvm/DSDT.pcie",
> -"tests/data/acpi/x86/microvm/DSDT.rtc",
> -"tests/data/acpi/x86/microvm/DSDT.usb",


