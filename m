Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466FBC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueuAd-0006P3-8g; Thu, 24 Jul 2025 07:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ueuAW-0006DM-C1
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:31:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ueuAU-0003iE-EO
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:31:24 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so736829b3a.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1753356680; x=1753961480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ck9T/jF+PL5A+Qgew1lYRC5089aRjomI5oJ+XOm2M0=;
 b=E/vNMjrEcgGqTeceWgN36g8SLAjKiVwLlgT8ZHut4vVKJjrdwmR+4XgIGRz36QYUWt
 m2Nx7QB6GnglMToh2GN1W43KTDTLg/1t0FAZlDaQ9Nndg4FvYEdSj0dETxYjKUI8/skE
 Y/mv+69TLRWvvwaWCPlbRGlj65Af9ZJY1q9XpjMRJgZWXLjWDiUpWyQwDE312NNVVDKZ
 C4XhmzCZu/zHJsCPJRBeZmixskrp/UekVwltny1U0+X+LbgZi39CvEqkYwYlBl2O2DfF
 80EvfEZD0TxpnUDI0kCWGEkhvN1PaOejZ2NQLurKi8ag1m90gKmAuq1qCJdoNMUSSoXf
 DnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753356680; x=1753961480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ck9T/jF+PL5A+Qgew1lYRC5089aRjomI5oJ+XOm2M0=;
 b=S9uwSysPsk3Drg8ftBel6QyfBWVjSAF2ABHb20vkWa+aiWNhFNW41Ni/sFOwS3NNQ6
 jD34EmYWMC9iyAqd0tkAR3Yd3AAjJmnSHehTPh1gSmKw+hBDaPUvgxBwaYHbc9Cr7aFw
 UYNj5RZCQ2we2zEyZEl0eMjCK96J/nFO+JbYOXMuUS2mQRUWpyOsjzf3oshW7orCJSc1
 iv7wJMM7TPm8SxQGmmx1UXhg8xYzMq/0yE18AS7yhgINfYW/MvVMspxbCeriAPIb7kND
 M/0RlVXo1vnuwI84VvevWNUL1/Jm0VlgV6Q60mZLzLIp/Qg47N3H+hV0doGLA/SpfKoo
 SSbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+qe74iRtWdA7hzlkw3NJWe4RdvpHzkw7p1k1EP93k/D8Y5FPZmlXqRSclS/Q3VpeAs6COcUzdk++e@nongnu.org
X-Gm-Message-State: AOJu0YxsOqE9L4USl21UUISnHswKBmdGCBFBOm7k/oM0q9g4cILTJ6Ud
 TFd/qoMBXtNmcYZNymzbdT9PfVZCCjsSMeK8Y+gBZuW9z/3jiEkW6y36vTDMF/n/PJo=
X-Gm-Gg: ASbGncuDYInTS79DnQ1pYOiDE3kyQFusBjNf/+KXzNGLMxdvN2Elaj4wTjYADew5pfV
 c5Cllrf2IpDFe2vM3A9qYtZRS52wsbarL+AWm/N8ePGnkKvzZ5EYf4/aIxwfwYs33zT7i6A4LDD
 U7sZfPYwB3HB18VSARZtuWtDGZ4pOhNZ253R8Ke90vNandyuujdbrjLA/Gt0YUoaL6fmMzP43Sp
 IuVUj4W9Ts5boaa4F8dVPeTwPSc8mHpcPrbglcfgtyZYJLB2O3eqAq2IFU53jMJ59WR1JJRGlwd
 +ILOYfI9n3YhH79+PqQVUySjXaH1ZusTpMiJIAf+p9bIAyo705IcOm9cwJeSuVjvNyRGCDsJEYQ
 eMvyEXqdrDG4UGo0sWNFxQcfqUK0yrAPL348Ie7xiXaWFiXPofqcC2mMewVIBBLVzTS/JLKR0Ln
 Pc
X-Google-Smtp-Source: AGHT+IGlR2PemdOvM4ky41A/u3NeTmCzpzbt0Aijr588oRsmEJrssvz7j/eiuCoiIB1DjvM56fwBMg==
X-Received: by 2002:a05:6a20:914b:b0:238:e380:a282 with SMTP id
 adf61e73a8af0-23d49121b97mr10220429637.26.1753356679776; 
 Thu, 24 Jul 2025 04:31:19 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:8924:370b:6e58:6804:59a0?
 ([2804:7f0:bcc0:8924:370b:6e58:6804:59a0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761ae158ab9sm1494182b3a.45.2025.07.24.04.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 04:31:19 -0700 (PDT)
Message-ID: <ffc50826-a21d-4b26-b25f-0432a2a57faf@ventanamicro.com>
Date: Thu, 24 Jul 2025 08:31:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/data/acpi/riscv64: Update expected FADT and
 MADT
To: Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <anup@brainfault.org>, Atish Kumar Patra <atishp@rivosinc.com>
References: <20250724110350.452828-1-sunilvl@ventanamicro.com>
 <20250724110350.452828-4-sunilvl@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250724110350.452828-4-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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



On 7/24/25 8:03 AM, Sunil V L wrote:
> Update the expected tables for the version change.
>   /*
>    *
>    * ACPI Data Table [FACP]
>    *
>    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>    */
> 
>   [000h 0000 004h]                   Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
>   [004h 0004 004h]                Table Length : 00000114
>   [008h 0008 001h]                    Revision : 06
> -[009h 0009 001h]                    Checksum : 13
> +[009h 0009 001h]                    Checksum : 12
>   [00Ah 0010 006h]                      Oem ID : "BOCHS "
>   [010h 0016 008h]                Oem Table ID : "BXPC    "
>   [018h 0024 004h]                Oem Revision : 00000001
>   [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>   [020h 0032 004h]       Asl Compiler Revision : 00000001
> 
>   [024h 0036 004h]                FACS Address : 00000000
>   [028h 0040 004h]                DSDT Address : 00000000
>   [02Ch 0044 001h]                       Model : 00
>   [02Dh 0045 001h]                  PM Profile : 00 [Unspecified]
>   [02Eh 0046 002h]               SCI Interrupt : 0000
>   [030h 0048 004h]            SMI Command Port : 00000000
>   [034h 0052 001h]           ACPI Enable Value : 00
>   [035h 0053 001h]          ACPI Disable Value : 00
>   [036h 0054 001h]              S4BIOS Command : 00
>   [037h 0055 001h]             P-State Control : 00
> @@ -86,33 +86,33 @@
>        Use APIC Physical Destination Mode (V4) : 0
>                          Hardware Reduced (V5) : 1
>                         Low Power S0 Idle (V5) : 0
> 
>   [074h 0116 00Ch]              Reset Register : [Generic Address Structure]
>   [074h 0116 001h]                    Space ID : 00 [SystemMemory]
>   [075h 0117 001h]                   Bit Width : 00
>   [076h 0118 001h]                  Bit Offset : 00
>   [077h 0119 001h]        Encoded Access Width : 00 [Undefined/Legacy]
>   [078h 0120 008h]                     Address : 0000000000000000
> 
>   [080h 0128 001h]        Value to cause reset : 00
>   [081h 0129 002h]   ARM Flags (decoded below) : 0000
>                                 PSCI Compliant : 0
>                          Must use HVC for PSCI : 0
> 
> -[083h 0131 001h]         FADT Minor Revision : 05
> +[083h 0131 001h]         FADT Minor Revision : 06
>   [084h 0132 008h]                FACS Address : 0000000000000000
> [...]
> 
>   /*
>    *
>    * ACPI Data Table [APIC]
>    *
>    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>    */
> 
>   [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
>   [004h 0004 004h]                Table Length : 00000074
> -[008h 0008 001h]                    Revision : 06
> -[009h 0009 001h]                    Checksum : B4
> +[008h 0008 001h]                    Revision : 07
> +[009h 0009 001h]                    Checksum : B3
>   [00Ah 0010 006h]                      Oem ID : "BOCHS "
>   [010h 0016 008h]                Oem Table ID : "BXPC    "
> [...]
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   tests/data/acpi/riscv64/virt/APIC           | Bin 116 -> 116 bytes
>   tests/data/acpi/riscv64/virt/FACP           | Bin 276 -> 276 bytes
>   tests/qtest/bios-tables-test-allowed-diff.h |   2 --
>   3 files changed, 2 deletions(-)
> 
> diff --git a/tests/data/acpi/riscv64/virt/APIC b/tests/data/acpi/riscv64/virt/APIC
> index 66a25dfd2d6ea2b607c024722b2eab95873a01e9..3fb5b753596fc7c2618b3d5210be8b00b0c177f6 100644
> GIT binary patch
> delta 16
> XcmXRZ;c^V{bS`0FU|`=okt+)TB&q~M
> 
> delta 16
> XcmXRZ;c^V{bS`0FU|`!akt+)TB&h^L
> 
> diff --git a/tests/data/acpi/riscv64/virt/FACP b/tests/data/acpi/riscv64/virt/FACP
> index a5276b65ea8ce46cc9b40d96d98f0669c9089ed4..78e1b14b1d4ff0533a6a4c041f195a69b4ef114d 100644
> GIT binary patch
> delta 30
> mcmbQjG=+)F&CxkPgpq-PO=u!lB_rF!iPaMgcqj8PasU8k76z;U
> 
> delta 30
> mcmbQjG=+)F&CxkPgpq-PO?V<#B_r#^iPaMgcqj8PasU8k8wRWZ
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 0c3f7a6cac..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,3 +1 @@
>   /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/riscv64/virt/APIC",
> -"tests/data/acpi/riscv64/virt/FACP",


