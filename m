Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888F3C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNfR-0002PK-Go; Tue, 20 May 2025 10:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHNf9-0002OQ-FN
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:09:47 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHNf6-00085O-S8
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:09:46 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-877c48657f9so1211209241.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747750183; x=1748354983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wTiO3+Hfc/CdWQbhAFjllN1Tm1FIAkftjxcvMbFqISg=;
 b=cRUngxinPoymIA1v9E4osNr4h9Nd0vDmUYUvyVyhkBAAbmeEAotXOUX4hJ43pSV9RA
 zJY2EOT76Xp/SZGN+x5d3B1d6FcR/aPK3HEoss7jLQMk7TUzPdkoZoSafrHiL32Yc/P8
 qlDjUwewwvwarBVXC1iBQn7EadY+SUNYx6Q+5ITO4v2N7e+8midcoGwo1poLhaudTOxY
 7ypuALSYtfxVWbC9DkRW/JxDQJYc//nk60OFFUATqjZEIj7g0HbYTj08xeD3Cun7YMNM
 mko+NcLG4kJ7e1wU6JaC9zodlAwCo2NBtYQABtSLyvQPYUm3bxk9whjqKNw5QCMpBbVT
 UdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747750183; x=1748354983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wTiO3+Hfc/CdWQbhAFjllN1Tm1FIAkftjxcvMbFqISg=;
 b=VekcuJWlkRe9XZ2/SO37xGOjIOzn/0NYQ1s5Ze3XlDw8Me0j6bobDtlhMxpei+7bJa
 orpFdX4Wf9M7+Kq1D864JimzE+Pxp6UigXbowfZwUFVIchErkv4NQ08+i5FlzP9/6S4/
 qt4LHnjjK1fxU1hg2XPfR32Fnj60K2eB0lmdxuWNLe1ezrttmNUBariNVEvkSa4rC9m5
 dfmzCbliw11ltGCT/8XgTh9pgNIaQyJ+BzlfOCjuu+abcZ7CrO7ynORAPidjSgBrFigE
 HrV+p/++NHhpoWIYCAmiE/uGbfu4kcrw33Zy1Ockq569PItzbHQI2TnhkwNL1G7d0R9J
 w47w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRU4xi0/5RK+Q3XSrDdnzhWOHV+6juuMDIcfiz3+4WbxZ82xy8RV92Pg4XigxL2pd+WkX8HfVaKhyv@nongnu.org
X-Gm-Message-State: AOJu0YxKbwmME+Kn0ZZdlq6MiX0aqm7279+95ZRFplDHXWxL6bJblSHe
 Xbw/+RvYtjNPU3eiIoYSH2pweVf3flCAKCp461pXIlKFsbbm03nGOu2mDA3Yh+vi08Y=
X-Gm-Gg: ASbGnctIBu3oFELTYnGSFgJ8qpv1BBXY97Oa6NzrUh2ZqxMCvKuLK3OENLUyPE7oAw9
 20c85+4Dp7QOuhCUWxNlSI8NaqX1o7oEWteU14G1CwXvdWfcTDcbfztNwVhOlEaE9pqclOIWj3U
 oEvTcJgN2062Ys/xT6tTrc47HPrzuD51R+/QXude+7eS/0wyI+xEVOkyR9qdWYu1Mc4JYm4Bhhv
 og50BWz9jk5ip0QaWmEZGZAbWrkAuZatF7CPe08JZdmTm9gnQX5NdJ8z88mufUL+XZtRQgOUJ7S
 SkcE/Ksjek0UB+ZwnCh3979615bUOKT8EJhzDNVTgKFifY3Fjb9DBcVdeQx/AHnMQvl3bvfcNAM
 T6Zq8swMX5RtTZe+Wr1YqYIUxTF3lsA==
X-Google-Smtp-Source: AGHT+IH697w9dAujLJJDV6EM0isUu1eOdQZ4XyLQZyAomYna1t7EzCHS7IXzyucBum0Gb5elMJUK+g==
X-Received: by 2002:a05:6122:4883:b0:52a:792e:ce4c with SMTP id
 71dfb90a1353d-52dbcc505cfmr12884839e0c.1.1747750182672; 
 Tue, 20 May 2025 07:09:42 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:6989:b93e:2caa:f174?
 ([2804:7f0:b401:d47f:6989:b93e:2caa:f174])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52dbab6c0c2sm8416467e0c.42.2025.05.20.07.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 07:09:42 -0700 (PDT)
Message-ID: <e1ec0e15-ad26-456b-a8d7-16f683290651@linaro.org>
Date: Tue, 20 May 2025 11:09:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-9-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250514170431.2786231-9-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ua1-x92c.google.com
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

Hi Eric,

On 5/14/25 14:00, Eric Auger wrote:
> gpex build_host_bridge_osc() and x86 originated
> build_pci_host_bridge_osc_method() are mostly identical.
> 
> In GPEX, SUPP is set to CDW2 but is not further used. CTRL
> is same as Local0.
> 
> So let gpex code reuse build_pci_host_bridge_osc_method()
> and remove build_host_bridge_osc().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> The DSDT diff  is given below:
> diff --git a/dsdt.dsl_before b/dsdt.dsl_after_osc_change
> index 3224a56..fa7558e 100644
> --- a/dsdt.dsl_before
> +++ b/dsdt.dsl_after_osc_change
> @@ -5,13 +5,13 @@
>    *
>    * Disassembling to symbolic ASL+ operators
>    *
> - * Disassembly of dsdt.dat, Mon Apr  7 05:33:06 2025
> + * Disassembly of dsdt.dat, Mon Apr  7 05:37:20 2025
>    *
>    * Original Table Header:
>    *     Signature        "DSDT"
> - *     Length           0x00001A4F (6735)
> + *     Length           0x00001A35 (6709)
>    *     Revision         0x02
> - *     Checksum         0xBF
> + *     Checksum         0xDD
>    *     OEM ID           "BOCHS "
>    *     OEM Table ID     "BXPC    "
>    *     OEM Revision     0x00000001 (1)
> @@ -1849,27 +1849,26 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
>                   {
>                       CreateDWordField (Arg3, 0x04, CDW2)
>                       CreateDWordField (Arg3, 0x08, CDW3)
> -                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
> -                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
> -                    CTRL &= 0x1F
> +                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
> +                    Local0 &= 0x1F
>                       If ((Arg1 != One))
>                       {
>                           CDW1 |= 0x08
>                       }
> 
> -                    If ((CDW3 != CTRL))
> +                    If ((CDW3 != Local0))
>                       {
>                           CDW1 |= 0x10
>                       }
> 
> -                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
> -                    Return (Arg3)
> +                    CDW3 = Local0
>                   }
>                   Else
>                   {
>                       CDW1 |= 0x04
> -                    Return (Arg3)
>                   }
> +
> +                Return (Arg3)
>               }
> 
>               Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method

The problem I face with diffs in the commit body is that tools like b4, which are
based on git am, get very confused on how to handle it. I'm surprised nobody ever
complained about it. I'm wondering if there is any catch on it, because I have to
edit commits like this manually, removing the diff, to make it finally apply to
the series. Anyways, do you mind at least removing the valid diff header, like:

> diff --git a/dsdt.dsl_before b/dsdt.dsl_after_osc_change
> index 3224a56..fa7558e 100644
> --- a/dsdt.dsl_before
> +++ b/dsdt.dsl_after_osc_change

from the commit message so it doesn't confuse b4?


> ---
>   hw/pci-host/gpex-acpi.c | 60 +++--------------------------------------
>   1 file changed, 4 insertions(+), 56 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index f1ab30f3d5..98c9868c3f 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -50,60 +50,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>       }
>   }
>   
> -static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
> -{
> -    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
> -
> -    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> -    aml_append(method,
> -        aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> -
> -    /* PCI Firmware Specification 3.0
> -     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
> -     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
> -     * identified by the Universal Unique IDentifier (UUID)
> -     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
> -     */
> -    UUID = aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
> -    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
> -    aml_append(ifctx,
> -        aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> -    aml_append(ifctx,
> -        aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> -    aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
> -    aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
> -
> -    /*
> -     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
> -     * and PCIeHotplug depending on enable_native_pcie_hotplug
> -     */
> -    aml_append(ifctx, aml_and(aml_name("CTRL"),
> -               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)),
> -               aml_name("CTRL")));
> -
> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
> -                              aml_name("CDW1")));
> -    aml_append(ifctx, ifctx1);
> -
> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
> -                              aml_name("CDW1")));
> -    aml_append(ifctx, ifctx1);
> -
> -    aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
> -    aml_append(ifctx, aml_return(aml_arg(3)));
> -    aml_append(method, ifctx);
> -
> -    elsectx = aml_else();
> -    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
> -                               aml_name("CDW1")));
> -    aml_append(elsectx, aml_return(aml_arg(3)));
> -    aml_append(method, elsectx);
> -    return method;
> -}
> -
> -static Aml *build_host_bridge_dsm(void)
> +static Aml *build_pci_host_bridge_dsm_method(void)
>   {
>       Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
>       Aml *UUID, *ifctx, *ifctx1, *buf;
> @@ -134,8 +81,9 @@ static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
>       aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>       aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>       /* Declare an _OSC (OS Control Handoff) method */
> -    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
> -    aml_append(dev, build_host_bridge_dsm());
> +    aml_append(dev,
> +               build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
> +    aml_append(dev, build_pci_host_bridge_dsm_method());
>   }
>   
>   void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)

Otherwise:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

