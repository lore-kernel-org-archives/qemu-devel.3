Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7EACA5FB8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viG4b-0006L5-Lq; Tue, 20 Jan 2026 13:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG4P-0006FH-Qx
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:21 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG4O-0000R1-2T
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:13 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-793ae293fadso48865997b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:03:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768932191; cv=none;
 d=google.com; s=arc-20240605;
 b=PLMTDGxiWOXeUR/XX9296kteUHbZEoUPr63IY0BzMki6dEdv8BOr+P0EecBCyB4ILR
 CHKEGWtclx51hTAJSxVB47e3O9Lyayv2XoK+SlpU5LNxCtzy9Hrjr+MvGQZ1iIFhLcDc
 dNlG/IPxDtEhPp64C+qrpYNNeXmxr6Ibw1ACfD8D3YJGnijZLrwEjWbcKxNkggBC9ysM
 268g0L75+MH/8sjHwE+SqEvgrWiIhsvNUKAyuMBQDX89QzRCz3nOHHz6u4UenGuz04It
 KWtC/ch9iSkKs5lXazvGH/fEF6ZiqCQgCmy8m10lQG5sYdl0bCuiVoH2QmdNL0+OfYEH
 PyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NDi/W0I+/+kW+XukCQLUwooPVxYe/yxhyjh9j/z90ig=;
 fh=h5XwtwbFZRZ1FUOtZRgdKZteGKilXmRo+GqhpTRH7tM=;
 b=kNfnZpMbPqePAYtEqr5ZoYaQTKQuZE+fQuD6bAxSA+0tWhvBAsxuOK6Uu7hb3HaMk6
 o1bIffk1zpEIK48DKj0ffinhOm83Ut/d2l158gEMARQ0pr5UVfOx8CFGW8gT3DgT4uYx
 DZWW4tXPys3gYlRiwuy2+3NOhfK3bbg5WdmxFxsgmDcRaYnRMPGCfWGcfhiWhOlYKY6U
 EEaLgWUAKfLdsNAqps9ZZPvWCnSdyIaoHKOUwP7NPLJQTz9VuBSgWSoYhBCSUHqGc5NG
 GpbbrxUM20aqoC0dh1QV3JYjRo1Xvpz8x+vMhj5jY/o6heVTtSh/QJdmqWQKKYYNcGQP
 J3Lw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768932191; x=1769536991; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NDi/W0I+/+kW+XukCQLUwooPVxYe/yxhyjh9j/z90ig=;
 b=yTMz9qq1t5fi8wud8fYcwfNd5izhGIMo1HrBSBF69v7o7M1Eg5SomI+FittlOQn5/d
 oMLsau/nDhunAd3ZlxfmOA7w+ycRt4BtAm5gFTkLbZkwr9LzZRPGlq9vbJiAQnsYFNFB
 ktIhIcakKkazO5UgiIo2bAjlj8fq+i4tu9foW/u39wtLkW/OV9dvChM1ixTn/6vWRuSf
 NBU/uLX7Ia0H9PIx162TLr7W7lvckqRMAk6dD3VGSxHoaeUH5/RiS6wYNAAMGSoSwQZU
 sZj6+kQCVr7lzRoEfjtEvdas1j/A6dwZ6NrBZIrpRtKTXNXSYq/HhwPlo9q70dOj/Om0
 IFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768932191; x=1769536991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDi/W0I+/+kW+XukCQLUwooPVxYe/yxhyjh9j/z90ig=;
 b=o/i5psmFLQ6HYy4xD5CT5+aep9xdtE3nMGaZHZBIf1YN7wNYlPT1uxNIIoI28Zdg+K
 CdeZ/8M6aXFhctw+r8dmwe9OKyq4nLZk6HjzSGbAm49DM8gbpPtF5UtJbJ7wCp26viPx
 DHJMFKcLdmjwTmFl7Oc1fgYSVshVUmwy0yZDk58wODtovw22fPEeONYDWHiEV6apkxzx
 ycr2uhZOfSHOM+jB6X51r0QeBwJF/noRZv2JO1KwZXsIszUS++tuB2KNGt21O5UN87E6
 SnCwk8SxLemQwR2mTpbW7giz7MkIYViCiIMFfao5w5I2YKX1cc02LjbIAp8PRZdpADWN
 AtbA==
X-Gm-Message-State: AOJu0YxdB+Ot7B0BtVjzKbGxkodvVwRUenWljMXJBuvQ6HaTkyfuuumv
 JZVMz1iiDRwDnym9UTiMj8y6Ig5oo/TugAm2bsiQ9qfDBT+E5Gp63T4QjehDFwRPxCw4nGa84Eg
 b4AWPORY5+FaJeTlKUEeBTxMNATrS4QlmJJ55HEH8jg==
X-Gm-Gg: AZuq6aK6w/uDDkkc4GnXnL3t3+74MGCWN0g86JUEHwQxbPwKo/YJVdZzWItO8WzLdxg
 HwIA1qcwYkIMko05NuFq0wgzKRg5d1BQXkl5lAaX/wgdYdPBz5ZO+LS9YHjX7Hok/7n2JBI/9p2
 tJnJYsyMpD8P/X4pP6UV1l/OBf/8AApZF3FnNqmNUfs5txG3kSNWN1wbUCb9g4y7g9XVWv4+PhM
 E0lZ/LK/MC6zQodCRY90KxWmCu/mvWZWhvjJhFPnpONRHysleAcQVFujZhvaSxwmrRI9Q==
X-Received: by 2002:a05:690c:5:b0:78f:a6e7:76fc with SMTP id
 00721157ae682-793c671d131mr116039317b3.24.1768932189149; Tue, 20 Jan 2026
 10:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-5-mohamed@unpredictable.fr>
In-Reply-To: <20260116135235.38092-5-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jan 2026 18:02:56 +0000
X-Gm-Features: AZwV_QgsQqZLoqCe6lU68ohPxKsx5IohRR9xjA1qQRHSrALtyUvwTyacYdORsXY
Message-ID: <CAFEAcA-3P6i_w3b7SaFTn4Zmwnot5vpDs89y+zpjcJ=-mEnP5w@mail.gmail.com>
Subject: Re: [PATCH v16 04/26] hw/arm: virt: add GICv2m for the case when ITS
 is not available
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 16 Jan 2026 at 13:52, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> On Hypervisor.framework for macOS and WHPX for Windows, the provided environment is a GICv3 without ITS.
>
> As such, support a GICv3 w/ GICv2m for that scenario.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c | 5 ++++-
>  hw/arm/virt.c            | 8 ++++++++
>  include/hw/arm/virt.h    | 2 ++
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 03b4342574..40ea6b6dd5 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -960,7 +960,10 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
>              build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
>          }
> -    } else {
> +    }
> +
> +    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its)
> +     && !vms->no_gicv3_with_gicv2m) {
>          const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
>
>          /* 5.2.12.16 GIC MSI Frame Structure */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4badc1a734..275f26d439 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -959,6 +959,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>
>      if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
>          create_its(vms);
> +    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
> +        create_v2m(vms);
>      } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
>          create_v2m(vms);
>      }
> @@ -2449,6 +2451,8 @@ static void machvirt_init(MachineState *machine)
>      vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
>          !vmc->no_ns_el2_virt_timer_irq;
>
> +    vms->no_gicv3_with_gicv2m = vmc->no_gicv3_with_gicv2m;
> +
>      fdt_add_timer_nodes(vms);
>      fdt_add_cpu_nodes(vms);
>
> @@ -3497,6 +3501,7 @@ static void virt_instance_init(Object *obj)
>      vms->its = true;
>      /* Allow ITS emulation if the machine version supports it */
>      vms->tcg_its = !vmc->no_tcg_its;
> +    vms->no_gicv3_with_gicv2m = false;
>
>      /* Default disallows iommu instantiation */
>      vms->iommu = VIRT_IOMMU_NONE;
> @@ -3549,7 +3554,10 @@ DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
>
>  static void virt_machine_10_2_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_11_0_options(mc);
> +    vmc->no_gicv3_with_gicv2m = true;
>      compat_props_add(mc->compat_props, hw_compat_10_2, hw_compat_10_2_len);
>  }

The MSI controller selection logic is already pretty confusing,
and this is making it more complicated. I don't think we should
need this machine back compatibility, because currently there
is no setup where you can have a GICv3 that doesn't also have
either an ITS or no MSI controller.

I think also that we can make the code cleaner if we:
(1) clean the existing "pick an MSI controller" logic up
so that we do it up front, the same way we do "pick a GIC
version"
(2) add the new "msi" property and deprecate the old "its" one
(3) then add the gicv3-with-gicv2m-on-hvf logic to that

I see this series adds an "msi" property, but it also
makes the old "its" property an OnOffAuto -- do we really
need both ?

I wrote some code for this this afternoon before I realised
that you'd done the "msi" property in that series (so the
duplication with your work is my fault). I'll send them
out as an RFC to give an idea of what I have in mind.

thanks
-- PMM

