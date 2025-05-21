Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D40BC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlLg-0001Mz-2o; Wed, 21 May 2025 11:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHlLa-0001M2-3y
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:27:10 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHlLS-000454-LO
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:27:09 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-231fd67a9aeso37961775ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747841218; x=1748446018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vYTckfD81agmH5Xmoc7T8HX6TcSOrbDNI8bR8zby13g=;
 b=eInr1Y/GWsiqzvqie5z61PItyCwoqWpeuJgv1w3O41EmJsX/727Dicgyk2Lb9gOlqO
 fBcPLuQd5m7OuG+NbX4DMlbcCQcLv3fmUlFrcSSHOglkT7B28KafC7oZOhwv5Zz7dn5H
 sEc6AZKT52tW+Kf31WRBUKiPpr8GMGTcka8LwgAz+f1o/jzqKrVOh4SjfTn7RITtR69V
 5hETu1/hyiNPQhCpzYSMt4YXyRjXVV5hbIplBdTXBg3THbtBMJLfJJ5FxNgOtjQQKGkM
 iu6aR/QTgz64W+inQHdkNaWGchsdasaqv1n9Wzp3w+sS90aZTxIK6+OORjpO6/DuDJY0
 KTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747841218; x=1748446018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vYTckfD81agmH5Xmoc7T8HX6TcSOrbDNI8bR8zby13g=;
 b=fwUC2wsxWv6l2X9SrcKAkjBugoXFwmtUsXnbJ7E578T1ogguI2S+PRxfTHUvv4I1qw
 p+yMkLfW1UsNLt0ARoBdqx1P6/7RW0wUOWNUNvv3eng3KpYOSRxzqVpuJU/f1t+mgd6K
 GqeIcnp/H3tEC6Xu5YURh5uqGCGIISyqbSceGJovIaaJJ05WIoRXyDBnOIL5wUmRO6gP
 d6SSjeOIxn5olCwPWQ8XHgupXAZPN7LmkzIR+cAs2Vi+clzaftJga4ycpNenxIoGNikJ
 ZQ9yOQAE73nAqQXn7zkqba2wNpdMym4UN7fwhYO8MMPZlHj4gvMa0PNWuXtmr+Q+x7Pq
 AV8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnYWx63eJ9wur9onpAJkEtRGqd8QyjkjcL/FDXtgtNivnePwSRg37Wb9IQlvTVeJCoAfsueY3Dtdr6@nongnu.org
X-Gm-Message-State: AOJu0Yy1CQJYrgvXugz63XyLuArRZFkatY2xCDfVET3tdoA0WZ1OdTbz
 oYRoyVE+vQCUcLZHPXLSosQxZHf2i9bCPrw3Yu1Zka3Qa5tX6WwutFC0eSaalJs3a1A=
X-Gm-Gg: ASbGncv8XxseL0EljYXTOfe6A/V04N6qEEESYtLot/n5Y+xiZiugPNmpV4EK20tMzK6
 aVD6Z0JQmGCaV5wcBvIaFkJ+Q9oZrMfMOw/ODr/r8Tt8qtZrfyVFxDqi7uWNLCfwRINFM1SP7OK
 mu1pc2e1ug48mZuclrLjmqq/KVYTR9PFzR/MWWtTQIGUHqYMIyJTcMfzbDBtNnkcRgNA2d0Nz6+
 v6u4yt1lWs0TR8xFH4M0tsCbYajIAnz21AWxFLjNkbLgxDHI+Ew63Uv43LF9C2iE6c2fCtZ2TpL
 G9bn5Kqq3L8doTcNaEdZO/lEr5REe+p0+OR1vrscIIbGluw+7eWekRXJ6oZ/XD7NL0Jeq2f3Jqi
 B96eAF82l/4IMEk1/NbQj6tT2J990fg==
X-Google-Smtp-Source: AGHT+IFDBrggbgTAFRW74tnvRHyJSTcmC988dNI+BSGU6lOxz0XGx2zI02pWGHfzgXjAOaKZugKQuA==
X-Received: by 2002:a17:902:d2cf:b0:221:89e6:ccb6 with SMTP id
 d9443c01a7336-231d4ea09cfmr313156025ad.25.1747841218545; 
 Wed, 21 May 2025 08:26:58 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:532e:8fb1:3c49:40da?
 ([2804:7f0:b401:d47f:532e:8fb1:3c49:40da])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4aca2d6sm94160185ad.3.2025.05.21.08.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 08:26:58 -0700 (PDT)
Message-ID: <ad7c7b84-9f12-4767-a349-df47c489c726@linaro.org>
Date: Wed, 21 May 2025 12:26:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] hw/i386/acpi-build: Move aml_pci_edsm to a generic
 place
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-15-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250514170431.2786231-15-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/14/25 14:01, Eric Auger wrote:
> Move aml_pci_edsm to pcihp since we want to reuse that for
> ARM and acpi-index support.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/acpi/pcihp.h |  2 ++
>   hw/acpi/pcihp.c         | 53 +++++++++++++++++++++++++++++++++++++++++
>   hw/i386/acpi-build.c    | 53 -----------------------------------------
>   3 files changed, 55 insertions(+), 53 deletions(-)
> 
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index 4d820b4baf..bc31dbff39 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -82,6 +82,8 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus);
>   
>   void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>   
> +Aml *aml_pci_edsm(void);
> +
>   /* Called on reset */
>   void acpi_pcihp_reset(AcpiPciHpState *s);
>   
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index d800371ddc..57fe8938b1 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -937,6 +937,59 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
>       }
>   }
>   
> +Aml *aml_pci_edsm(void)
> +{
> +    Aml *method, *ifctx;
> +    Aml *zero = aml_int(0);
> +    Aml *func = aml_arg(2);
> +    Aml *ret = aml_local(0);
> +    Aml *aidx = aml_local(1);
> +    Aml *params = aml_arg(4);
> +
> +    method = aml_method("EDSM", 5, AML_SERIALIZED);
> +
> +    /* get supported functions */
> +    ifctx = aml_if(aml_equal(func, zero));
> +    {
> +        /* 1: have supported functions */
> +        /* 7: support for function 7 */
> +        const uint8_t caps = 1 | BIT(7);
> +        build_append_pci_dsm_func0_common(ifctx, ret);
> +        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
> +        aml_append(ifctx, aml_return(ret));
> +    }
> +    aml_append(method, ifctx);
> +
> +    /* handle specific functions requests */
> +    /*
> +     * PCI Firmware Specification 3.1
> +     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
> +     *        Operating Systems
> +     */
> +    ifctx = aml_if(aml_equal(func, aml_int(7)));
> +    {
> +       Aml *pkg = aml_package(2);
> +       aml_append(pkg, zero);
> +       /* optional, if not impl. should return null string */
> +       aml_append(pkg, aml_string("%s", ""));
> +       aml_append(ifctx, aml_store(pkg, ret));
> +
> +       /*
> +        * IASL is fine when initializing Package with computational data,
> +        * however it makes guest unhappy /it fails to process such AML/.
> +        * So use runtime assignment to set acpi-index after initializer
> +        * to make OSPM happy.
> +        */
> +       aml_append(ifctx,
> +           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
> +       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
> +       aml_append(ifctx, aml_return(ret));
> +    }
> +    aml_append(method, ifctx);
> +
> +    return method;
> +}
> +
>   const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>       .name = "acpi_pcihp_pci_status",
>       .version_id = 1,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index bcfba2ccb3..385e75d061 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -322,59 +322,6 @@ build_facs(GArray *table_data)
>       g_array_append_vals(table_data, reserved, 40); /* Reserved */
>   }
>   
> -static Aml *aml_pci_edsm(void)
> -{
> -    Aml *method, *ifctx;
> -    Aml *zero = aml_int(0);
> -    Aml *func = aml_arg(2);
> -    Aml *ret = aml_local(0);
> -    Aml *aidx = aml_local(1);
> -    Aml *params = aml_arg(4);
> -
> -    method = aml_method("EDSM", 5, AML_SERIALIZED);
> -
> -    /* get supported functions */
> -    ifctx = aml_if(aml_equal(func, zero));
> -    {
> -        /* 1: have supported functions */
> -        /* 7: support for function 7 */
> -        const uint8_t caps = 1 | BIT(7);
> -        build_append_pci_dsm_func0_common(ifctx, ret);
> -        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
> -        aml_append(ifctx, aml_return(ret));
> -    }
> -    aml_append(method, ifctx);
> -
> -    /* handle specific functions requests */
> -    /*
> -     * PCI Firmware Specification 3.1
> -     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
> -     *        Operating Systems
> -     */
> -    ifctx = aml_if(aml_equal(func, aml_int(7)));
> -    {
> -       Aml *pkg = aml_package(2);
> -       aml_append(pkg, zero);
> -       /* optional, if not impl. should return null string */
> -       aml_append(pkg, aml_string("%s", ""));
> -       aml_append(ifctx, aml_store(pkg, ret));
> -
> -       /*
> -        * IASL is fine when initializing Package with computational data,
> -        * however it makes guest unhappy /it fails to process such AML/.
> -        * So use runtime assignment to set acpi-index after initializer
> -        * to make OSPM happy.
> -        */
> -       aml_append(ifctx,
> -           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
> -       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
> -       aml_append(ifctx, aml_return(ret));
> -    }
> -    aml_append(method, ifctx);
> -
> -    return method;
> -}
> -
>   /*
>    * build_prt - Define interrupt routing rules
>    *

EDSM is not called from anywhere. _DSM method actually calls the PDSM, already defined
in pcihp.c and generated by aml_pci_pdsm(). build_acpi_pci_hotplug(), which calls
aml_pci_pdsm(), properly creates the PDSM method. Then in build_append_pcihp_slots()
the a _DSM is defined per slot and inside it there is a call to PDSM, so I understand
we should actually stick to the PDSM in pcihp.c instead of EDSM.

EDSM, being used in i386 code, feels a outdated PDSM, so maybe PDSM should be used there,
although a different story or a clean up for later. I'm not sure what "static endpoint"
means in the context of EDSM.

Hence this patch can be dropped in my understanding and:

aml_append(pci0_scope, aml_pci_edsm()) in 15/22 too, without any prejudice to the
hotplugging and unplugging in this series.


Cheers,
Gustavo

