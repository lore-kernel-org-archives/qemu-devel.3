Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45BDC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5T8e-0005BQ-KX; Thu, 17 Apr 2025 13:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T8c-0005Ar-Gk
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:34:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T8a-0001rk-3R
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:34:57 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so983555b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744911294; x=1745516094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T1fDvpTylWdirzN7nHsilveuWE9fad1LOo8gfH1QjAw=;
 b=iEMiqn+ZTg7OCKKCF0d1Y91JpYdwr9rOO+d6ld0vAB9YsKiyQxUvxjUpYlN3VpWhEK
 l8ljBow2+3X2/FRtsjbkuoIOA1xSIL1h5Gf3Er+AR2bNf/qjL35T/JmqiklzmQ73h9pQ
 LnC2TEtoaRiT05R1hurtuwQU7y2nPSB2arXtC553JyupN3DQRbGi+vUH4meyBPaF3x70
 SN1h7RN/XNPK+DnETst0Jp3H3IYixQJTeWgf08pxkX4V3anvWTgZnA8DZWB19oz/VkKa
 J7j9uS7hzYWvV1wiP7tS6fV4CLgW6z0Hr3MAk3cMgZ2IPXNSJcX0iWAxh0ZINvpaEUAc
 0YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744911294; x=1745516094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T1fDvpTylWdirzN7nHsilveuWE9fad1LOo8gfH1QjAw=;
 b=JKtkcljnjPmScY5lLNUyc6t54QzGjo7ueJS5tqMMi0aqG+IQyNvo5eloi1cqB49hFI
 TprdTDRjJoWcetuJY5jq2HkWu7guW/MuWWTA6KZkfXNuHrtmizikejuOsl4iaEwoBD7A
 cEgO4KZNF3uzwtDQed1D19ToGjiHDUVXoqyd93r+b13g+uSSVs/xkUgBmAxTLePM0FyC
 SXfnAy1n2ZyDOd2s1vRIufMrM74Gb/fZN2xMb6mPQZEfILG/SpQyDQ0q1rt+ANIX1ktk
 rJPSMj0iIlMDAJCfY+Z1tWET/ZNk3DONencaMDC/ae0v65afCECn/s0as2MKMngtnX0H
 G3Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF2XSvPYGAKb5ZLG/m7SZ6YIw3JKFbswaee7BhrpI1m8PllF5Xwh/EDxLA7ZMffy1TYXRhEEqagmTQ@nongnu.org
X-Gm-Message-State: AOJu0YwBmAh0Bami4nB8uoKIbp8WmeBVu91Wt+GQERtrTWb0og27q3OA
 QY9B5eEXRwM1qRu5vfpudeyud8V7l/VlqvRlun8aXXMi7Gsnfo/8YM4rHktcXYE=
X-Gm-Gg: ASbGncuz3J+kSl1Qjj2zw9pPy+dF+KnqjZwg7lVecXGoQ+vKZs8zMcCthxwH3hdbigD
 eWtKpvactTvlW/1o4QesOGgIl83n/A8++yaDVPA5nr3ZbPgrwH9lx6EwGc9fRiK9+38BiNQB3b9
 64eDoHQ2SrK+woBvAWQ9i/jOZZVhyrHsRyKkbwZXYg+9zER0fTiVQJbGfZrcXoxKtq9FXQAVjux
 KY6yNJ9mIoLgfZ22uDV0kdCMywqd5pvskNB9K/UjFOPQ5qJJuwM9toS4SE6V8kLA2EA2fi1IBN9
 a4m12zhPOp06MGXn88MTQi3y+NG8Y0sIVT79D0DxXKO5uV9/ToLj
X-Google-Smtp-Source: AGHT+IFBSZ6UvDSLA2d8auhSjHg506FswL8CFLozKdLN/XNPe0UKr0Kum811W3eDDlqH3KPIZ7FRUA==
X-Received: by 2002:a05:6a00:4399:b0:736:33fd:f57d with SMTP id
 d2e1a72fcca58-73dbfbc7aabmr353309b3a.17.1744911294317; 
 Thu, 17 Apr 2025 10:34:54 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfaeb59dsm110709b3a.177.2025.04.17.10.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:34:53 -0700 (PDT)
Message-ID: <986226f4-e6ce-491c-a9bb-d1c2bcfd1e43@linaro.org>
Date: Thu, 17 Apr 2025 14:34:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 07/13] microvm: support control method sleep button
To: annie.li@oracle.com, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204236.2977-1-annie.li@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250411204236.2977-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/11/25 17:42, Annie Li wrote:
> Add the support of control method sleep button and System
> S3 Sleeping State for microvm.

I would say "... of ACPI Control Method Sleeping Button ...¨,
the important part being "ACPI" to make clear what's the
context of the support. Because such a device requires
also some plumbing in QEMU code to really be "supported".

For the title, maybe smth like: "microvm: Add ACPI sleeping button device"


> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   hw/i386/acpi-microvm.c                 | 11 +++++++++++
>   include/hw/acpi/generic_event_device.h |  1 +
>   2 files changed, 12 insertions(+)
> 
> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> index 279da6b4aa..57c45ea327 100644
> --- a/hw/i386/acpi-microvm.c
> +++ b/hw/i386/acpi-microvm.c
> @@ -32,6 +32,7 @@
>   #include "hw/acpi/generic_event_device.h"
>   #include "hw/acpi/utils.h"
>   #include "hw/acpi/erst.h"
> +#include "hw/acpi/control_method_device.h"
>   #include "hw/i386/fw_cfg.h"
>   #include "hw/i386/microvm.h"
>   #include "hw/pci/pci.h"
> @@ -123,12 +124,22 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
>       build_ged_aml(sb_scope, GED_DEVICE, x86ms->acpi_dev,
>                     GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
>       acpi_dsdt_add_power_button(sb_scope);
> +    acpi_dsdt_add_sleep_button(sb_scope);
>       acpi_dsdt_add_virtio(sb_scope, mms);
>       acpi_dsdt_add_xhci(sb_scope, mms);
>       acpi_dsdt_add_pci(sb_scope, mms);
>       aml_append(dsdt, sb_scope);
>   
>       /* ACPI 5.0: Table 7-209 System State Package */

Should this be "Table 7-205"? Or even, why not:

"ACPI 6.5, Table 7.11: System State Package" ?


Cheers,
Gustavo

> +    scope = aml_scope("\\");
> +    pkg = aml_package(4);
> +    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S3));
> +    aml_append(pkg, aml_int(0)); /* ignored */
> +    aml_append(pkg, aml_int(0)); /* reserved */
> +    aml_append(pkg, aml_int(0)); /* reserved */
> +    aml_append(scope, aml_name_decl("_S3", pkg));
> +    aml_append(dsdt, scope);
> +
>       scope = aml_scope("\\");
>       pkg = aml_package(4);
>       aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index d2dac87b4a..28c5785863 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -85,6 +85,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>   #define ACPI_GED_SLP_TYP_POS       0x2   /* SLP_TYPx Bit Offset */
>   #define ACPI_GED_SLP_TYP_MASK      0x07  /* SLP_TYPx 3-bit mask */
>   #define ACPI_GED_SLP_TYP_S5        0x05  /* System _S5 State (Soft Off) */
> +#define ACPI_GED_SLP_TYP_S3        0x03  /* System _S3 State (Sleeping State) */
>   #define ACPI_GED_SLP_EN            0x20  /* SLP_EN write-only bit */
>   
>   #define GED_DEVICE      "GED"


