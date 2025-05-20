Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9476C54754
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHM83-0003CV-VP; Tue, 20 May 2025 08:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHM81-0003CC-Qd
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:31:29 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHM7v-0004iD-I8
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:31:29 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-52eec54acf4so505599e0c.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747744279; x=1748349079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fL7WhFP6w6L2PiRs6zkB+Kk9hcklC639f32eQyJNiNU=;
 b=pF2lDv8vZremWzgTsUYhCSzgsty9uUhsk1YoB2abg8jOyPLFcfQVZxqWX28nffgOvn
 nQ+lDSy84ynSxfgp3jE6PwWAvJoVssu4rt3BFOL+gJ//d51W/gkq+AbS9hNpnaMmcU6L
 98/SDzjRdRWgx5mRzEVVd4iNL0YyLfSi20ua+F9wM0mNAcAYxQKo0MaVS7S6KEUuD03k
 50Q/MSOynM3pv7dIZcbT9NZgsHJzW9sKh8Z9FZrrpA4Rh9iYgRGcJgAs31zTiuwu1wrx
 a32kfugZBYLQqHejRoRhrLGbLC21N2uXaAgwMVR1WcPlgYTnb0ZaTmNbHDlh0Ytteovx
 cxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747744279; x=1748349079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fL7WhFP6w6L2PiRs6zkB+Kk9hcklC639f32eQyJNiNU=;
 b=RlwWYQWlVbleo6FnkwvZYFuUIOJLnS7xv+Ny/OfjxZc+66PciA39JcQiz7vouFt9Zy
 yPQuCxdzgx/1SbxWdW2OQybmT6E1ouJ9NVGFhtoxQqRlumXxV0RGUrBRWudygruYVtYZ
 rer9AMMAiU1Uy7VaP2D2igdTxo9YMN18CKnSFB3O6FgmuQceIt+LoyvhhxhvxUWERP3g
 2M0vPByVS77XX5MAopOGhfhcgablCDSEkkOlIu6+fms69S38+6SqrdQAIFo0clXVsPO4
 4lHE8HgQhnaP241lhR1Y6NeKg51Cqh0tIyXWgNkb+zhKNZEvOv/TLPSPyQfht537km+j
 Bubw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMfDdhIanj0V5ZvU9c1fLajxEtg+eJAOOg7KF+5TdeRqU62uFJE1lrLVFkq24lBQbuIGgg5zTaRAKy@nongnu.org
X-Gm-Message-State: AOJu0YyTIgf7bIeGQC1hiGOHTNJAI+hr1bljHD0szCbj5st6LjhAJoqa
 KT+0iJNR2L34p5EDoRz6VNzAQrlyT3Ca72Xl0qm2ViDje73mIND8KEwASvEf0HxwaQA=
X-Gm-Gg: ASbGnctTHS7Vq9NA8gPy1vzU8SycJYH1DoG2rbytgd/1JYRTDLM8/JJC6ntzcAOAN9v
 PGUssqMhKO+6312VwWra2ull/j+ky6Y7VCjJjMBGMZ8jsz6C799A7ha+WnaO0DKgeY4zK/8yEhV
 MCMFROEIF08qPjyjUybCZx4HYCYSt9o/creCYKdwPkc9o3jf/o7BhiCBk9XGnRb72bEPUjn91s6
 iENJvrEuPgMlkr46fgG00jGXT4rwI8RcC5sw/jOKWtUnUpLsRq/tVk4L6K/sXg1QreOJowoc8HB
 swHTHRkHN1iCOtZuavWKmaVCRWCHsoqgNalcZFgT0h3Gfth7b2lWYeAgSmhm8ZrXzd2Wv8rO07w
 QL5+Hz4NqzOsRNUTb+t9i6/WYrX6mAQ==
X-Google-Smtp-Source: AGHT+IGvtr6Z/XhaYErjsBdslFFVvdq1bufOlgwXcP0+TEuZaWmcnuqBA+MAea9S0wC43vh9vSUdxA==
X-Received: by 2002:a05:6122:1998:b0:50d:a31c:678c with SMTP id
 71dfb90a1353d-52dba7d091bmr13121602e0c.2.1747744278878; 
 Tue, 20 May 2025 05:31:18 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:6989:b93e:2caa:f174?
 ([2804:7f0:b401:d47f:6989:b93e:2caa:f174])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52dba9405a2sm8341560e0c.13.2025.05.20.05.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 05:31:18 -0700 (PDT)
Message-ID: <31b7402d-4d7d-4d38-9d2d-27143520e581@linaro.org>
Date: Tue, 20 May 2025 09:31:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] hw/acpi: Rename and move build_x86_acpi_pci_hotplug
 to pcihp
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-4-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250514170431.2786231-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa2d.google.com
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
> We plan to reuse build_x86_acpi_pci_hotplug() implementation
> for ARM so let's move the code to generic pcihp.
> 
> Associated static aml_pci_pdsm() helper is also moved along.
> build_x86_acpi_pci_hotplug is renamed into build_acpi_pci_hotplug().
> 
> No code change intended.
> 
> Also fix the reference to  acpi_pci_hotplug.rst documentation

nit: double space       ----^

There is still one place where the ref is wrong, see below.


> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> rfc -> v1:
> - make build_append_pci_dsm_func0_common non static and move it to
>    pcihp
> ---
>   hw/i386/acpi-build.h    |   4 -
>   include/hw/acpi/pcihp.h |   9 +-
>   hw/acpi/pcihp.c         | 174 ++++++++++++++++++++++++++++++++++++++-
>   hw/i386/acpi-build.c    | 176 +---------------------------------------
>   4 files changed, 183 insertions(+), 180 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> index 275ec058a1..8ba3c33e48 100644
> --- a/hw/i386/acpi-build.h
> +++ b/hw/i386/acpi-build.h
> @@ -5,10 +5,6 @@
>   
>   extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
>   
> -/* PCI Hot-plug registers' base. See docs/specs/acpi_pci_hotplug.rst */
> -#define ACPI_PCIHP_SEJ_BASE 0x8
> -#define ACPI_PCIHP_BNMR_BASE 0x10
> -
>   void acpi_setup(void);
>   Object *acpi_get_i386_pci_host(void);
>   
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index a97904bada..95efe9a804 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -3,7 +3,7 @@
>    *
>    * QEMU supports PCI hotplug via ACPI. This module
>    * implements the interface between QEMU and the ACPI BIOS.
> - * Interface specification - see docs/specs/acpi_pci_hotplug.txt
> + * Interface specification - see docs/specs/acpi_pci_hotplug.rst
>    *
>    * Copyright (c) 2013, Red Hat Inc, Michael S. Tsirkin (mst@redhat.com)
>    * Copyright (c) 2006 Fabrice Bellard
> @@ -33,6 +33,10 @@
>   #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
>   #define ACPI_PCIHP_IO_LEN_PROP "acpi-pcihp-io-len"
>   
> +/* PCI Hot-plug registers bases. See docs/spec/acpi_pci_hotplug.rst */

nit:                               specs   ---^


Otherwise:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

> +#define ACPI_PCIHP_SEJ_BASE 0x8
> +#define ACPI_PCIHP_BNMR_BASE 0x10
> +
>   typedef struct AcpiPciHpPciStatus {
>       uint32_t up;
>       uint32_t down;
> @@ -69,6 +73,9 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                            AcpiPciHpState *s, DeviceState *dev,
>                                            Error **errp);
>   
> +void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr);
> +void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
> +
>   /* Called on reset */
>   void acpi_pcihp_reset(AcpiPciHpState *s);
>   
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index aac90013d4..e0260f67e6 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -26,7 +26,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "hw/acpi/pcihp.h"
> -
> +#include "hw/acpi/aml-build.h"
>   #include "hw/pci-host/i440fx.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_bridge.h"
> @@ -513,6 +513,178 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
>                                      OBJ_PROP_FLAG_READ);
>   }
>   
> +void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
> +{
> +    Aml *UUID, *ifctx1;
> +    uint8_t byte_list[1] = { 0 }; /* nothing supported yet */
> +
> +    aml_append(ctx, aml_store(aml_buffer(1, byte_list), retvar));
> +    /*
> +     * PCI Firmware Specification 3.1
> +     * 4.6.  _DSM Definitions for PCI
> +     */
> +    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
> +    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(0), UUID)));
> +    {
> +        /* call is for unsupported UUID, bail out */
> +        aml_append(ifctx1, aml_return(retvar));
> +    }
> +    aml_append(ctx, ifctx1);
> +
> +    ifctx1 = aml_if(aml_lless(aml_arg(1), aml_int(2)));
> +    {
> +        /* call is for unsupported REV, bail out */
> +        aml_append(ifctx1, aml_return(retvar));
> +    }
> +    aml_append(ctx, ifctx1);
> +}
> +
> +static Aml *aml_pci_pdsm(void)
> +{
> +    Aml *method, *ifctx, *ifctx1;
> +    Aml *ret = aml_local(0);
> +    Aml *caps = aml_local(1);
> +    Aml *acpi_index = aml_local(2);
> +    Aml *zero = aml_int(0);
> +    Aml *one = aml_int(1);
> +    Aml *not_supp = aml_int(0xFFFFFFFF);
> +    Aml *func = aml_arg(2);
> +    Aml *params = aml_arg(4);
> +    Aml *bnum = aml_derefof(aml_index(params, aml_int(0)));
> +    Aml *sunum = aml_derefof(aml_index(params, aml_int(1)));
> +
> +    method = aml_method("PDSM", 5, AML_SERIALIZED);
> +
> +    /* get supported functions */
> +    ifctx = aml_if(aml_equal(func, zero));
> +    {
> +        build_append_pci_dsm_func0_common(ifctx, ret);
> +
> +        aml_append(ifctx, aml_store(zero, caps));
> +        aml_append(ifctx,
> +            aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
> +        /*
> +         * advertise function 7 if device has acpi-index
> +         * acpi_index values:
> +         *            0: not present (default value)
> +         *     FFFFFFFF: not supported (old QEMU without PIDX reg)
> +         *        other: device's acpi-index
> +         */
> +        ifctx1 = aml_if(aml_lnot(
> +                     aml_or(aml_equal(acpi_index, zero),
> +                            aml_equal(acpi_index, not_supp), NULL)
> +                 ));
> +        {
> +            /* have supported functions */
> +            aml_append(ifctx1, aml_or(caps, one, caps));
> +            /* support for function 7 */
> +            aml_append(ifctx1,
> +                aml_or(caps, aml_shiftleft(one, aml_int(7)), caps));
> +        }
> +        aml_append(ifctx, ifctx1);
> +
> +        aml_append(ifctx, aml_store(caps, aml_index(ret, zero)));
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
> +
> +       aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
> +       aml_append(ifctx, aml_store(pkg, ret));
> +       /*
> +        * Windows calls func=7 without checking if it's available,
> +        * as workaround Microsoft has suggested to return invalid for func7
> +        * Package, so return 2 elements package but only initialize elements
> +        * when acpi_index is supported and leave them uninitialized, which
> +        * leads elements to being Uninitialized ObjectType and should trip
> +        * Windows into discarding result as an unexpected and prevent setting
> +        * bogus 'PCI Label' on the device.
> +        */
> +       ifctx1 = aml_if(aml_lnot(aml_lor(
> +                    aml_equal(acpi_index, zero), aml_equal(acpi_index, not_supp)
> +                )));
> +       {
> +           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret, zero)));
> +           /*
> +            * optional, if not impl. should return null string
> +            */
> +           aml_append(ifctx1, aml_store(aml_string("%s", ""),
> +                                        aml_index(ret, one)));
> +       }
> +       aml_append(ifctx, ifctx1);
> +
> +       aml_append(ifctx, aml_return(ret));
> +    }
> +
> +    aml_append(method, ifctx);
> +    return method;
> +}
> +
> +void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
> +{
> +    Aml *scope;
> +    Aml *field;
> +    Aml *method;
> +
> +    scope =  aml_scope("_SB.PCI0");
> +
> +    aml_append(scope,
> +        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
> +    field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> +    aml_append(field, aml_named_field("PCIU", 32));
> +    aml_append(field, aml_named_field("PCID", 32));
> +    aml_append(scope, field);
> +
> +    aml_append(scope,
> +        aml_operation_region("SEJ", AML_SYSTEM_IO,
> +                             aml_int(pcihp_addr + ACPI_PCIHP_SEJ_BASE), 0x04));
> +    field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> +    aml_append(field, aml_named_field("B0EJ", 32));
> +    aml_append(scope, field);
> +
> +    aml_append(scope,
> +        aml_operation_region("BNMR", AML_SYSTEM_IO,
> +                             aml_int(pcihp_addr + ACPI_PCIHP_BNMR_BASE), 0x08));
> +    field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> +    aml_append(field, aml_named_field("BNUM", 32));
> +    aml_append(field, aml_named_field("PIDX", 32));
> +    aml_append(scope, field);
> +
> +    aml_append(scope, aml_mutex("BLCK", 0));
> +
> +        method = aml_method("PCEJ", 2, AML_NOTSERIALIZED);
> +    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
> +    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
> +    aml_append(method,
> +        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("B0EJ")));
> +    aml_append(method, aml_release(aml_name("BLCK")));
> +    aml_append(method, aml_return(aml_int(0)));
> +    aml_append(scope, method);
> +
> +    method = aml_method("AIDX", 2, AML_NOTSERIALIZED);
> +    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
> +    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
> +    aml_append(method,
> +        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("PIDX")));
> +    aml_append(method, aml_store(aml_name("PIDX"), aml_local(0)));
> +    aml_append(method, aml_release(aml_name("BLCK")));
> +    aml_append(method, aml_return(aml_local(0)));
> +    aml_append(scope, method);
> +
> +    aml_append(scope, aml_pci_pdsm());
> +
> +    aml_append(table, scope);
> +}
> +
>   const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>       .name = "acpi_pcihp_pci_status",
>       .version_id = 1,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9e584e69fd..b92765fbd9 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -361,32 +361,6 @@ static Aml *aml_pci_device_dsm(void)
>       return method;
>   }
>   
> -static void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
> -{
> -    Aml *UUID, *ifctx1;
> -    uint8_t byte_list[1] = { 0 }; /* nothing supported yet */
> -
> -    aml_append(ctx, aml_store(aml_buffer(1, byte_list), retvar));
> -    /*
> -     * PCI Firmware Specification 3.1
> -     * 4.6.  _DSM Definitions for PCI
> -     */
> -    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(0), UUID)));
> -    {
> -        /* call is for unsupported UUID, bail out */
> -        aml_append(ifctx1, aml_return(retvar));
> -    }
> -    aml_append(ctx, ifctx1);
> -
> -    ifctx1 = aml_if(aml_lless(aml_arg(1), aml_int(2)));
> -    {
> -        /* call is for unsupported REV, bail out */
> -        aml_append(ifctx1, aml_return(retvar));
> -    }
> -    aml_append(ctx, ifctx1);
> -}
> -
>   static Aml *aml_pci_edsm(void)
>   {
>       Aml *method, *ifctx;
> @@ -647,96 +621,6 @@ static bool build_append_notification_callback(Aml *parent_scope,
>       return !!nr_notifiers;
>   }
>   
> -static Aml *aml_pci_pdsm(void)
> -{
> -    Aml *method, *ifctx, *ifctx1;
> -    Aml *ret = aml_local(0);
> -    Aml *caps = aml_local(1);
> -    Aml *acpi_index = aml_local(2);
> -    Aml *zero = aml_int(0);
> -    Aml *one = aml_int(1);
> -    Aml *not_supp = aml_int(0xFFFFFFFF);
> -    Aml *func = aml_arg(2);
> -    Aml *params = aml_arg(4);
> -    Aml *bnum = aml_derefof(aml_index(params, aml_int(0)));
> -    Aml *sunum = aml_derefof(aml_index(params, aml_int(1)));
> -
> -    method = aml_method("PDSM", 5, AML_SERIALIZED);
> -
> -    /* get supported functions */
> -    ifctx = aml_if(aml_equal(func, zero));
> -    {
> -        build_append_pci_dsm_func0_common(ifctx, ret);
> -
> -        aml_append(ifctx, aml_store(zero, caps));
> -        aml_append(ifctx,
> -            aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
> -        /*
> -         * advertise function 7 if device has acpi-index
> -         * acpi_index values:
> -         *            0: not present (default value)
> -         *     FFFFFFFF: not supported (old QEMU without PIDX reg)
> -         *        other: device's acpi-index
> -         */
> -        ifctx1 = aml_if(aml_lnot(
> -                     aml_or(aml_equal(acpi_index, zero),
> -                            aml_equal(acpi_index, not_supp), NULL)
> -                 ));
> -        {
> -            /* have supported functions */
> -            aml_append(ifctx1, aml_or(caps, one, caps));
> -            /* support for function 7 */
> -            aml_append(ifctx1,
> -                aml_or(caps, aml_shiftleft(one, aml_int(7)), caps));
> -        }
> -        aml_append(ifctx, ifctx1);
> -
> -        aml_append(ifctx, aml_store(caps, aml_index(ret, zero)));
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
> -
> -       aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
> -       aml_append(ifctx, aml_store(pkg, ret));
> -       /*
> -        * Windows calls func=7 without checking if it's available,
> -        * as workaround Microsoft has suggested to return invalid for func7
> -        * Package, so return 2 elements package but only initialize elements
> -        * when acpi_index is supported and leave them uninitialized, which
> -        * leads elements to being Uninitialized ObjectType and should trip
> -        * Windows into discarding result as an unexpected and prevent setting
> -        * bogus 'PCI Label' on the device.
> -        */
> -       ifctx1 = aml_if(aml_lnot(aml_lor(
> -                    aml_equal(acpi_index, zero), aml_equal(acpi_index, not_supp)
> -                )));
> -       {
> -           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret, zero)));
> -           /*
> -            * optional, if not impl. should return null string
> -            */
> -           aml_append(ifctx1, aml_store(aml_string("%s", ""),
> -                                        aml_index(ret, one)));
> -       }
> -       aml_append(ifctx, ifctx1);
> -
> -       aml_append(ifctx, aml_return(ret));
> -    }
> -
> -    aml_append(method, ifctx);
> -    return method;
> -}
> -
>   /*
>    * build_prt - Define interrupt routing rules
>    *
> @@ -1227,62 +1111,6 @@ static Aml *build_q35_dram_controller(const AcpiMcfgInfo *mcfg)
>       return dev;
>   }
>   
> -static void build_x86_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
> -{
> -    Aml *scope;
> -    Aml *field;
> -    Aml *method;
> -
> -    scope =  aml_scope("_SB.PCI0");
> -
> -    aml_append(scope,
> -        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
> -    field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> -    aml_append(field, aml_named_field("PCIU", 32));
> -    aml_append(field, aml_named_field("PCID", 32));
> -    aml_append(scope, field);
> -
> -    aml_append(scope,
> -        aml_operation_region("SEJ", AML_SYSTEM_IO,
> -                             aml_int(pcihp_addr + ACPI_PCIHP_SEJ_BASE), 0x04));
> -    field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> -    aml_append(field, aml_named_field("B0EJ", 32));
> -    aml_append(scope, field);
> -
> -    aml_append(scope,
> -        aml_operation_region("BNMR", AML_SYSTEM_IO,
> -                             aml_int(pcihp_addr + ACPI_PCIHP_BNMR_BASE), 0x08));
> -    field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> -    aml_append(field, aml_named_field("BNUM", 32));
> -    aml_append(field, aml_named_field("PIDX", 32));
> -    aml_append(scope, field);
> -
> -    aml_append(scope, aml_mutex("BLCK", 0));
> -
> -    method = aml_method("PCEJ", 2, AML_NOTSERIALIZED);
> -    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
> -    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
> -    aml_append(method,
> -        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("B0EJ")));
> -    aml_append(method, aml_release(aml_name("BLCK")));
> -    aml_append(method, aml_return(aml_int(0)));
> -    aml_append(scope, method);
> -
> -    method = aml_method("AIDX", 2, AML_NOTSERIALIZED);
> -    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
> -    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
> -    aml_append(method,
> -        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("PIDX")));
> -    aml_append(method, aml_store(aml_name("PIDX"), aml_local(0)));
> -    aml_append(method, aml_release(aml_name("BLCK")));
> -    aml_append(method, aml_return(aml_local(0)));
> -    aml_append(scope, method);
> -
> -    aml_append(scope, aml_pci_pdsm());
> -
> -    aml_append(table, scope);
> -}
> -
>   static Aml *build_q35_osc_method(bool enable_native_pcie_hotplug)
>   {
>       Aml *if_ctx;
> @@ -1394,7 +1222,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           aml_append(dsdt, sb_scope);
>   
>           if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> -            build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
> +            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
>           }
>           build_piix4_pci0_int(dsdt);
>       } else if (q35) {
> @@ -1438,7 +1266,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           aml_append(dsdt, sb_scope);
>   
>           if (pm->pcihp_bridge_en) {
> -            build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
> +            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
>           }
>           build_q35_pci0_int(dsdt);
>       }


