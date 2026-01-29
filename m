Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CD8D6101A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 15:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTqE-0005qX-US; Thu, 29 Jan 2026 10:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTqD-0005gs-LN
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:21:53 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTqB-0005LA-MD
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:21:53 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79274e0e56bso11506587b3.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 07:21:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769700110; cv=none;
 d=google.com; s=arc-20240605;
 b=BhxXh8iPgF5khks9bNfYBtpwAsYFMlDgq+zVsYUwq+pS2YrAOoboo6YKRzCFD1xqyx
 eh3w5q2ywa3Zn7ahg3amGKd/nr7vmg6ym/rGPNkno0RBDM7AE9NMP9dC5bvajFOEQbUz
 afTmPlQJV5WDQh4EO2I1+ZLHCBtsmbnHhg0Am/I5ecB3lGTy8zIkta2jH3tCDoQP1YsX
 PgWWgIMDq+oZ3pXgbxjc/CSMhbe714fUDQau6B5NEbre7882vqevs1/t40fymyKe7vLG
 QgG+j6PXoWyNT7njJJZj9Bu1LyEVG0EZQ9pUm4RgerWRLh+5ywR7am1U/QyGwI4eqZGl
 QAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=j1eDuwiY+cHZoCJie36KvZ2wMGIKytbIGIatLMMs61A=;
 fh=us4lPT8YSvMw3WPWVr1x1zbLMIgA1kHH4DqlCTpJeag=;
 b=in2XVfgw3adYb6karOvY6pOvp2sUc5fgTpvZaJP6zzINlWJoHo/1zgQ8OP/3+ZESY6
 HQ0aHV44G4Ed9EIZHO/9UAZUVKtG8Hs9FuI8BnDXMfosGktfn79Bu0CHXfZZZ/1qHTRQ
 wQhFw0c5zNp522ubpHZ/RcsAyb8Be4k6m8d26dz6Y/4JjEn6pTkaEheItgg9GzmpMgYL
 19gRxYTdBTtHeOkfM3H8PXQeVi257iBd/lq58I2nzh5neaeQ+iS5K0y1Ez9I9WbbJJFu
 WXqQfxYr7F5aEOw2lZDMxj+5txKr20rYTFgZQRm1h1/3hGgsEtIxFvttQcW2aBXLPDza
 Y6oA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769700110; x=1770304910; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j1eDuwiY+cHZoCJie36KvZ2wMGIKytbIGIatLMMs61A=;
 b=vK7FPavIH66udpD0qfNBr8gpILjyM6SJppRrr3M0WuMSvyMNpzd3lB4qEldSLWnNZ9
 2gXYuZrzryZvWtfcbau6V5VSiAtXS4hykbDpH6sVH+mjjCj110r+Pgqj7GmwFb8jDHAm
 HgqRzV0lIH/1hftyeXrnaLtC2qO1Kx/ZqVdXHq/HntOYQQXnrXSl9HxLBIhXhenHSgrT
 y1d3doRJJyqTNAOFQOSK7QEMuUwXCEEHNEiGmdX0F7OBou8tVbyyqap82lzu60vP4AvG
 gRuAZj1M5qS19r8NasDJ8m51DXLwggTG8Hi2QbTOL/cv66MDurXWhBPgulBYiuThnMqa
 Pbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769700110; x=1770304910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1eDuwiY+cHZoCJie36KvZ2wMGIKytbIGIatLMMs61A=;
 b=CPPNOFzzFq/iGa+mFRPbcaIhfysCzRxBHaDZAShVIUEKYtl3IrRSRzh7EZBHwlNlOE
 4/Py7LaBbnR0AAZt6pTMiogGqozvC4yEQpNP9moFKMG0PH0PbGqMeON9atgXT8fC/tXl
 W82p+8xUV86SLcnw0cHL/+WnDrH+B57BDbdrDRdZ43pjdMS9BJ+urBilZfmZNa4HyWaK
 AvHdvLPFyOz4XjdpETlvIFrecrNELpZWff808KGp/GlO9XIw/zLD/0NJ8QrAbtld6NAe
 S1V2hENwO8s71BQvuIUzctwmL8gAuQFpjg+N35B+cs7k4oncgCLwAzChxEmexoJs6wNw
 Vmmw==
X-Gm-Message-State: AOJu0Yx2Ct7L+LC89L53ViS8GDglkaDOIVKCpdbxkGl7gI8CFyBNt/Rb
 ojh/aPA/7qdNbZlKGSvrfdAGmn5sB/BDjGbgv3S2cZ/vONEzLqKRydgnsZW1GXJ836Yx7b+yqT+
 D7wRXhsaz7MC1VqNRue7D2FocITPWMIZkLb2G+HFBgQ==
X-Gm-Gg: AZuq6aLgAveSHhroiQBpDKsJkmAua9N2YxCCcDAV1eG/STZzCYVxVKzKNJCrffxratR
 iHKrh/+h+th4DI2IeMDjuI5i4yBKW/m97UUQMp1QS8KX5XRzizzDjUmr1HfYtQtRXQFf69Rqr9w
 TfAZEG7AogP5aL4+wAA72sJaRLpLdP7LsOhkKJEYIdY0PxiideW6ThX8yJq8OOFX5+L9AOLRXFL
 /lJuYp6aBsYdFtuLfJj22FyNpZ5QyVCcL/5/knf8ByKFOt8CUqC/bSdUey4ggFX4i61KQ==
X-Received: by 2002:a05:690c:5a8f:b0:78f:f3c6:f303 with SMTP id
 00721157ae682-7947abfacbemr60791727b3.38.1769700109790; Thu, 29 Jan 2026
 07:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
 <20260127182805.73212-5-mohamed@unpredictable.fr>
In-Reply-To: <20260127182805.73212-5-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 15:21:38 +0000
X-Gm-Features: AZwV_QggdnzhttS9zZiOT9KoXIES71kSnnMARfxHtRAtqtvjn9paXqdGGz9cSZw
Message-ID: <CAFEAcA-BD0q2Eno+uo=pCDnnV6zEt2wWeoi8JujHZuaj0KzKCA@mail.gmail.com>
Subject: Re: [PATCH v18 04/22] hw: arm: virt: rework MSI-X configuration
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Tue, 27 Jan 2026 at 18:28, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Introduce a -M msi= argument to be able to control MSI-X support independently
> from ITS, as part of supporting GICv3 + GICv2m platforms.
>
> Remove vms->its as it's no longer needed after that change.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  hw/arm/virt-acpi-build.c |  20 ++++---
>  hw/arm/virt.c            | 112 ++++++++++++++++++++++++++++++++++++---
>  include/hw/arm/virt.h    |   5 +-
>  3 files changed, 121 insertions(+), 16 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 03b4342574..f87bf1bf2f 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c

You'll find the SMMUv3 acceleration changes produce some minor
conflicts in this file that you'll need to sort out.

The rest below here is minor stuff.

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4badc1a734..3d7f02ce0e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -737,7 +737,7 @@ static void create_its(VirtMachineState *vms)
>  {
>      DeviceState *dev;
>
> -    assert(vms->its);
> +    assert(vms->msi_controller == VIRT_MSI_CTRL_ITS);

I think we colud now simply drop this assert, given the simplicity
of the calling logic.

>      if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
>          /*
>           * Do nothing if ITS is neither supported by the host nor emulated by
> @@ -957,9 +957,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>
>      fdt_add_gic_node(vms);
>
> -    if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
> +    if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
>          create_its(vms);
> -    } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
> +    } else if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
>          create_v2m(vms);
>      }
>  }
> @@ -2132,6 +2132,36 @@ static void finalize_gic_version(VirtMachineState *vms)
>                                                 gics_supported, max_cpus);
>  }
>
> +static void finalize_msi_controller(VirtMachineState *vms)
> +{
> +    if (vms->msi_controller == VIRT_MSI_LEGACY_OPT_ITS_OFF) {
> +        if (vms->gic_version == 2) {
> +            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
> +        }
> +        else {
> +            vms->msi_controller = VIRT_MSI_CTRL_NONE;
> +        }

This needs commentary to explain why it is doing what it's
doing.

> +    }
> +    if (vms->msi_controller == VIRT_MSI_CTRL_AUTO) {
> +        if (vms->gic_version == VIRT_GIC_VERSION_2) {
> +            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
> +        }
> +        else {
> +            vms->msi_controller = VIRT_MSI_CTRL_ITS;
> +        }
> +    }

> +
> +    if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
> +        if (vms->gic_version == VIRT_GIC_VERSION_2) {
> +            /* Older Qemu releases accepted this, but better to error. */

"QEMU" is all-caps.

Also, do you mean "older QEMU releases accepted the command line,
and we now error"? Generally we shouldn't do that. If you mean
"the old legacy its= option permits this, but the new msi= one
diagnoses it as an error", the comment could be clearer.

> +            error_report("GICv2 + ITS is an invalid configuration.");
> +            exit(1);
> +        }
> +    }
> +
> +    assert(vms->msi_controller != VIRT_MSI_CTRL_AUTO);
> +}
> +

> +static char *virt_get_msi(Object *obj, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +    const char *val;
> +
> +    switch (vms->msi_controller) {
> +    case VIRT_MSI_CTRL_NONE:
> +    case VIRT_MSI_LEGACY_OPT_ITS_OFF:
> +        val = "off";
> +        break;
> +    case VIRT_MSI_CTRL_ITS:
> +        val = "its";
> +        break;
> +    case VIRT_MSI_CTRL_GICV2M:
> +        val = "gicv2m";
> +        break;
> +    case VIRT_MSI_CTRL_AUTO:
> +        val = "auto";
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return g_strdup(val);
> +}
> +
> +static void virt_set_msi(Object *obj, const char *value, Error **errp)
> +{
> +    ERRP_GUARD();
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    if (!strcmp(value, "auto")) {
> +        vms->msi_controller = VIRT_MSI_CTRL_AUTO; /* Will be overriden later */
> +    } else if (!strcmp(value, "its")) {
> +        vms->msi_controller = VIRT_MSI_CTRL_ITS;
> +    } else if (!strcmp(value, "gicv2m")) {
> +        vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
> +    } else if (!strcmp(value, "none")) {

Everywhere else seems to use "off" for the fourth value of
this option (so auto, its, gicv2m, off), but here we have "none".

> +        vms->msi_controller = VIRT_MSI_CTRL_NONE;
> +    } else {
> +        error_setg(errp, "Invalid msi value");
> +        error_append_hint(errp, "Valid values are auto, gicv2m, its, off\n");
> +    }
> +}


> +    object_class_property_add_str(oc, "msi", virt_get_msi,
> +                                  virt_set_msi);
> +    object_class_property_set_description(oc, "msi",
> +                                          "Set MSI settings. "
> +                                          "Valid values are auto/gicv2m/its/off");

We use '/' for 'on/off' but list all the values like
"Valid values are 2, 3, 4, host and max" for a set of strings.

thanks
-- PMM

