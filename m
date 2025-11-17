Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB834CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 12:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKyl0-00056l-3j; Mon, 17 Nov 2025 07:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vKykl-00052r-75
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 07:54:44 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vKykh-0003l8-VJ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 07:54:41 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-65749fe614bso140472eaf.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 04:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763384078; x=1763988878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TXjUCoq59/tgAn18CqRFTHUMU4WH97ot5mBq06MA6g4=;
 b=lN48cuRN+1ZQRhBadXKy7UNj2SGbUImErG7p/ILD/EeKxOnzOx8ZA2fbJJdS1YrccD
 QpXI8761kcxGV/XmC33RCnbHRv0538i6KWX0/d3w0qSXnZNIinwM0JKw62+UquSH7Z7r
 uz0/1Mdy62VgLMbiPBEq7JN9ABoHwwVo0/3zQLh2de6SKFj5z3krQVhss45n2wgl+eD1
 /VlkrWydGm3tQQN98uC0j4ad5MkIHfJtjGkvLmsAasNlBdLsCKWGz91w/uqWQAQxOp87
 YnHNZaiDQADia2BjW5SlulTFW91vXFatCx67ZaE0E/D6vfbU3ilTiojFvgJWbibTuH2O
 KIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763384078; x=1763988878;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TXjUCoq59/tgAn18CqRFTHUMU4WH97ot5mBq06MA6g4=;
 b=IxBdJhaW+gidI7xp07paK5W1Pr5EFLB6tDezmwv6Bo1P2EYuTgiddFr9EPtGUFPt9q
 XuiCflupChOzx5fFwB/3908K+lNGP1mNBC2i/iVQY+GxNvKMKPWE6DFKfmnBPtLf6OyC
 2adsunYRsMkm+UFT8nOM+xhfBv/d/UWHxtTN2NmyuA2HCR3g+pl1p+Xge/9SZDadnXSC
 sWh6beZvVEIE/kzmiA8XiCT1KyG2tGhoannxriKw5b1btxvK7bjyhgERsVIK2GpXp51U
 IJ3fIszbGG0SHo/nPTzFq3WLlCl/+0wUe/vs+DD8pJzU7ihmjHM66qVOFWgI+13VQvwm
 oKNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIt979zf6jMhnwtky6ml8Bc+DvB/+2PbIszH9d6FS1AzGbYhdBxTn7gzadLOagXwydUCk1EUoM/oz4@nongnu.org
X-Gm-Message-State: AOJu0YzI9Em02l198H47Ps0b/JDiq77Th2aAA41CfnhJw7TPhST7w/se
 iP6sRZ4xitovEmpiASGX674UZy3E9bgDzVi7JraOtVKuL8y7mj8Uw4mVdh8NH0GibX0=
X-Gm-Gg: ASbGncu3XYpwRQtP0vfMpPrqzrVExnGP0pX81PlXLbqAv2S4soEzH52ws30QOzxpXyx
 8L0TzSRusNAi/y/aWd77hw6HpWiN+ECy0L1oqurY1XUDDSh3jX8K5mdOHVMPPFG8V2bVDs/DIQG
 P/RKOWmP5AtPSv/d8aLnTS9PwyAss91rY8ZYtT09GEdcJv4aG7q12PPLvT5SOPjxTLiLCJmg6aH
 asHLLI3RRG5rjc2h09RPtq8+GKTti8yIaflP0rMncIgJkUagUsZH4QXSEKj5rkdltPbAsnJ4Hd6
 NXMCeEn0Ah4TLizRlQAemKGTiGZezu7rd/N3gpNlnoke1J+yRsREoShzMmMJyWux9PYXvsjJjTD
 C8MhwPwdQZxTsq+k1uMxogP0l1vIoaHWm0ZdWhUaRGcwEim5BBDAixa87ozNuW3/UKtKsU5Nqf6
 PfwLcMkPb40z5NADI=
X-Google-Smtp-Source: AGHT+IHiED4lbApq1BvAdQ22VrSj60UmUMS6gZAkaaQVsJKH8wx+w8d6sTKtRoTwYLbGXlu2atlAQg==
X-Received: by 2002:a05:6870:440d:b0:3ec:3fe0:4e36 with SMTP id
 586e51a60fabf-3ec3fe066c9mr1398876fac.6.1763384078149; 
 Mon, 17 Nov 2025 04:54:38 -0800 (PST)
Received: from [192.168.68.110] ([191.202.237.26])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a3bce15sm5355576a34.23.2025.11.17.04.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 04:54:37 -0800 (PST)
Message-ID: <8d83aafe-5c20-4c90-bc7b-1b3b4a397f7c@ventanamicro.com>
Date: Mon, 17 Nov 2025 09:54:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 2/2] tests/acpi: Add acpi ged and power button
 in DSDT for RISC-V
To: liu.xuemei1@zte.com.cn, imammedo@redhat.com, alistair.francis@wdc.com,
 sunilvl@ventanamicro.com, anisinha@redhat.com
Cc: pbonzini@redhat.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, mst@redhat.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20251113094415092DtFmNd_mcxtATexVfYz7E@zte.com.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251113094415092DtFmNd_mcxtATexVfYz7E@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2d.google.com
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



On 11/12/25 10:44 PM, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Update the reference DSDT blob to include acpi ged and power button
> for RISC-V.
> 
> DSDT diff:
>                   })
>               }
>           }
> +
> +        Device (\_SB.GED)
> +        {
> +            Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
> +            Name (_UID, "GED")  // _UID: Unique ID
> +            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> +            {
> +                Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
> +                {
> +                    0x00000009,
> +                }
> +            })
> +            OperationRegion (EREG, SystemMemory, 0x10101000, 0x04)
> +            Field (EREG, DWordAcc, NoLock, WriteAsZeros)
> +            {
> +                ESEL,   32
> +            }
> +
> +            Method (_EVT, 1, Serialized)  // _EVT: Event
> +            {
> +                Local0 = ESEL /* \_SB_.GED_.ESEL */
> +                If (((Local0 & 0x02) == 0x02))
> +                {
> +                    Notify (PWRB, 0x80) // Status Change
> +                }
> +            }
> +        }
> +
> +        Device (PWRB)
> +        {
> +            Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
> +            Name (_UID, Zero)  // _UID: Unique ID
> +        }
>       }
>   }
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   tests/data/acpi/riscv64/virt/DSDT           | Bin 3538 -> 3681 bytes
>   tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>   2 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
> index 968e1a15c87bb5753b3a84ddb357e26312767220..90de02e889f0057cbaeadb932ae135e2ca8943c9 100644
> GIT binary patch
> delta 170
> zcmca4{ZNL>CD<h-k&l6a>CZ$iX(pe?8`W3y)<-uvvB&7e2Rp^PySl`4#Cv$U@H#pN
> zcp4ZO8Z&UjhXT1k2_VZkC|Hn>i@TGJftit$fq|itA-cge$km;Jhe1F<fQu!%ksHKy
> zb`5s*Q4o=hcMS{SEC6v576?qPPT*o<;9_bE2oG}NYKU%<1TjFC3ApeE_yrg^8#qHO
> GV*mhK>?tS!
> 
> delta 25
> hcmaDTb4i-ZCD<k85-$S-lj=k+X(r!W8`W3y0sv*P2bll>
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 8e85fcdee9..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>   /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/riscv64/virt/DSDT",


