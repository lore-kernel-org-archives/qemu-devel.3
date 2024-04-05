Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0536ECD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 13:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsjw3-0000Wf-0k; Fri, 05 Apr 2024 09:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsjvx-0000VS-Sj
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 09:48:45 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsjvw-0001uf-9j
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 09:48:45 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e346224bdso598729a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712324923; x=1712929723; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wdCWLNv+gNFxjtNktRqs7Z1CW9aK0oxvcU92JTLyTJg=;
 b=FBifFoiPs/CJ0dU8jmH1vmaaLGR/sKIHpeG8DiS1S74nTJ+Cv14y6EKjeMI4nJkjLm
 9Oq+F3OEVEca5pn6VwizgS8ScVfiz2RbOyNBi4quDw6PQ7uO4VRYdpEecavlzE4L+BK2
 I8Rk2ifzhmMgingGOePqA7oxCs6s9bVNQdNa5VLkZKjrSLmwi9iJtkFt5SwngXB3kK7v
 Sk6ZJKB6mPUiXuAI6h0vDj47OQQ7ezIUCUMgdUjoOyBN26D2x9fmps65yeyYLR6341zm
 bfMfWJX9DAWgmlAeVgmXdk0Wbe+NcscAqdYPvom91jmi1/lWYD3QadAMwaUNMXEe9M82
 HElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712324923; x=1712929723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wdCWLNv+gNFxjtNktRqs7Z1CW9aK0oxvcU92JTLyTJg=;
 b=C/Z9NgDLlX7ROrxBaoeXKHUkV8RyUoo7upDfGCJauDGum4tMNRwc0Khrbtk35aICQc
 VWQpUmRq/25QufNOHUUglExxJtSSuziX8LUqLDPislEJcFP5NWhhgLqXATsLLCDeypi6
 AvCZJ7H4bbcOi8JaJOLIF36xJGsuJ9s9Gu8NyBaNhcZM0TfonqwZSLUiCj7r+6xVDW3v
 TZOZ/uL1qcx1BL2Svjh/H2JZ6lh3V1V6MRJAy3KsVI27PG4ld5YXUsxMGmU0WgcwhE5A
 Tzs+IrhWvuePqaqli3oturM2h9YUxHEQwiCrSxh4agnwBme32RK9kC2s2Cm7fXiUig+n
 3HPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPydEZPH5xfPdMsvKOh3/qmI4OM5pOYgf1Zr8A9hdbIRYHf54MRzwV7S9m9IStIWvtGgYQGFF/bsDnPYoKu7IrwU2fPL0=
X-Gm-Message-State: AOJu0YzxqDAffqBVmyN/qhMsYAQVrudGX45ngVMrc6AzWUkpUJx0/chO
 ysK2Dnkyzez40Aiik6mgoCrd4g3W5niAtLjuWkDI3trla7YuIwCUt1hxjHtdZRNCoPCzUYBykbd
 mBmKTRhS+vB/32P7tkkY7fQyTW/ovo70N6Ed7JQ==
X-Google-Smtp-Source: AGHT+IGsoanTpcEJ3DDkbSmhIAhrxtMds4/t2ahvKK/E5gAVHb8BJBKQQ2eW+78USKyOqBfaKRfVterozt8fvaOkEJg=
X-Received: by 2002:a50:8ac2:0:b0:56e:64a:2a47 with SMTP id
 k2-20020a508ac2000000b0056e064a2a47mr992030edk.42.1712324922780; Fri, 05 Apr
 2024 06:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-24-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-24-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2024 14:48:31 +0100
Message-ID: <CAFEAcA87CCLyk6=XzQANoqywfnSXSMcEkezAdH8bH-pO6AXKaw@mail.gmail.com>
Subject: Re: [PATCH v12 23/23] hw/arm/virt: Add FEAT_GICv3_NMI feature support
 in virt GIC
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> A PE that implements FEAT_NMI and FEAT_GICv3 also implements
> FEAT_GICv3_NMI. A PE that does not implement FEAT_NMI, does not implement
> FEAT_GICv3_NMI

This is true but not really relevant here -- FEAT_GICv3_NMI
is not "NMI support in the GIC", it's "does the CPU interface
support NMIs". (And so I'm wondering if the code in arm_gicv3_cpuif.c
should be checking cpu_isar_feature(aa64_nmi, cpu) rather than
cs->gic->nmi_support; but I need to think through the consequences
of that first.)

The justification for "enable NMIs in the GIC device if the
CPU has FEAT_NMI" is that (a) it's only OK to have a GIC with
NMI support if the CPU also has NMI support and (b) if we
can turn on NMI support in the GIC we should, so that we can
provide the feature to the guest.

> So included support FEAT_GICv3_NMI feature as part of virt platform
> GIC initialization if FEAT_NMI and FEAT_GICv3 supported.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v4:
> - Add Reviewed-by.
> v3:
> - Adjust to be the last after add FEAT_NMI to max.
> - Check whether support FEAT_NMI and FEAT_GICv3 for FEAT_GICv3_NMI.
> ---
>  hw/arm/virt.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ef2e6c2c4d..63d9f5b553 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -729,6 +729,19 @@ static void create_v2m(VirtMachineState *vms)
>      vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
>  }
>
> +/*
> + * A PE that implements FEAT_NMI and FEAT_GICv3 also implements
> + * FEAT_GICv3_NMI. A PE that does not implement FEAT_NMI, does not implement
> + * FEAT_GICv3_NMI.
> + */
> +static bool gicv3_nmi_present(VirtMachineState *vms)
> +{
> +    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(0));
> +
> +    return cpu_isar_feature(aa64_nmi, cpu) &&
> +           (vms->gic_version != VIRT_GIC_VERSION_2);

I think we should add tcg_enabled() to this condition:
neither KVM nor hvf support FEAT_NMI yet. Defaulting QEMU to
not trying to enable NMI in the GIC device is the safe
option. As and when those accelerators get NMI support, we
can add the handling to QEMU and update this code in the virt board.

thanks
-- PMM

