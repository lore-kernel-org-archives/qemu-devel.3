Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504C2CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzUT-00081V-Lj; Mon, 20 Oct 2025 19:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzUG-0007yg-NZ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:40:24 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzUB-0001lw-D1
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:40:24 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b6a73db16efso2806993a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761003617; x=1761608417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MFSzp+5J2LrVZGlRDL/SOjklbQV/5g0TpauuYWG+0hI=;
 b=KmlBjsyPyVdGHKoMpWujQHGbZ5wYDm/TJVbaM5jM2rfpnls52+5CaId4G9qAzyuArx
 9KACrIwoa+Bi3+AdVBUKg10+nXjj2G1QQ7znQ/ZwtCSCsGRptpLjmnGCpPNknTasi0WB
 NQlDgF+N0gecWuKGYBfShxmm0fnqDmJzhUeNgp2CFv31bwQkowJBxh8FqNYrs8Q4gOf/
 WiS/wXsGVx7idryditYS9jh6hlZf/NnDWnKt5b5dnKx+qZzOSl5z+OXLpXvgyEkpKEBp
 i8rP2fAcZBmyPHSyKeNshBqGHxzqL1wSYBOuXC/SAxom+U2UMkh5TrX5TLw+PwyCKkUZ
 CquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761003617; x=1761608417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MFSzp+5J2LrVZGlRDL/SOjklbQV/5g0TpauuYWG+0hI=;
 b=p2bmaLmNOsY6FdnHtONwS9n5BXIX/5T6gIEiAfCp6f+EjSILEAax8Ltf2Y9Eurg00w
 sf/9fpok1ytYtAsBpL2O/GsI19kDfHNXgpsq0WeEVC64sV8D/da41uyfkgzK7o6LGKQK
 zno+Q3UrGyQcya9jnRJDEjIa7oUiZ1rvUHI71IqHaIcwdIaRgu9i6MixyxpdxUzLxTAE
 AzitsapKeNSXCRfYr51crQpBgMkliFWILpjPwvx2lpRtfSNogD+wXe4UkvUqh86zqmBS
 LZkeauNmMxccW0vjVIxGf2JY1WoMRMTOpHHHIngMr3DvkHY1AlNnD19LTHFCdmDOlEPf
 YWOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvy5emklHbDuGGG81Cbr4eLejmrnC8kZe9i4oEAvqV6DjKSuoclQpxmj2DFllSCrCGkkVnHw9vgx+G@nongnu.org
X-Gm-Message-State: AOJu0YxpVCjux/LWYhD8luixQGEUh6Uws2cEgaMmg4Tog5H8/gVNPWFZ
 K9Pg1KDmZ5FKjWtpYCxJPYiW1dyEb+a5OeZia738JYYnLrZCvo8cXIgXv9jn9L0DJqA=
X-Gm-Gg: ASbGncvtBYLSKbkxdEVIGxF0XLNqysVLs2k4L7AE7fOjtCQp+EvKgAs6QScEinHty7G
 z6oTyWdXI379DA4kaekANq30871k+Xac1UsgIFBsvO45JByc4e79mLpq0PSooumZPFaBCfu9+YY
 k7Fcit+IoYYbkSFGytlkjrO/L3G/nM+HopDe+4iJYKS5Wg8EjyKCNnxxGPPVNPMqc5/k2XApnFh
 wVoxOzJ/xgc5YcTiMbYnDEbghntnSM5eEqu1+hM1Dw0gjBKwGi5DCdCp3UTisFO5kSCNDESWQEh
 1+VVHYOGS0xf0JTUfVR8B4tG0+/NEB/pBNfnotRng7v8zS3ev/KTAtdin88H4IoC0zeHp5zcc66
 tbvakgvSpwLrPZcsWqNtU3i14ztn8uYYLKd2fis9LC4gXJ+tIVkOgG2BSnSujxhWgsW2JGcr2Ls
 NEg66IMNuAkz1kll+9GqVOWrXR
X-Google-Smtp-Source: AGHT+IHPy2QmJvXcffWfWRAaTfx/yuhaDLAYB0GCq3xI8Fm3aCTjVU5+FAUOHnzqWhxpQz04z+ppVw==
X-Received: by 2002:a17:902:fc8f:b0:26b:3aab:f6b8 with SMTP id
 d9443c01a7336-290ccab5a83mr179303375ad.58.1761003617331; 
 Mon, 20 Oct 2025 16:40:17 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472197d3sm90724235ad.102.2025.10.20.16.40.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:40:16 -0700 (PDT)
Message-ID: <051b731d-7d02-4c13-8cf2-9cec67ca8f8f@linaro.org>
Date: Mon, 20 Oct 2025 16:40:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 26/30] hw/arm/virt-acpi-build: Include missing 'cpu.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020222010.68708-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020222010.68708-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 2025-10-20 15:20, Philippe Mathieu-Daudé wrote:
> "cpu.h" is indirectly pulled in by another header. Include
> it explicitly in order to avoid when changing default CPPFLAGS path:
> 
>    hw/arm/virt-acpi-build.c:903:34: error: call to undeclared function 'arm_feature';
>      903 |         uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
>          |                                  ^
>    hw/arm/virt-acpi-build.c:903:53: error: incomplete definition of type 'ARMCPU' (aka 'struct ArchCPU')
>      903 |         uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
>          |                                               ~~~~~~^
>    include/qemu/typedefs.h:30:16: note: forward declaration of 'struct ArchCPU'
>       30 | typedef struct ArchCPU ArchCPU;
>          |                ^
>    hw/arm/virt-acpi-build.c:903:60: error: use of undeclared identifier 'ARM_FEATURE_PMU'
>      903 |         uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
>          |                                                            ^
>    hw/arm/virt-acpi-build.c:993:10: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_DISABLED'
>      993 |     case QEMU_PSCI_CONDUIT_DISABLED:
>          |          ^
>    hw/arm/virt-acpi-build.c:996:10: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_HVC'
>      996 |     case QEMU_PSCI_CONDUIT_HVC:
>          |          ^
>    hw/arm/virt-acpi-build.c:1000:10: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_SMC'
>     1000 |     case QEMU_PSCI_CONDUIT_SMC:
>          |          ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt-acpi-build.c | 1 +
>   1 file changed, 1 insertion(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


