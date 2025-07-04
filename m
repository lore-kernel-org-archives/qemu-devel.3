Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66452C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfRB-0004am-7U; Fri, 04 Jul 2025 08:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXfR3-0004YF-EH
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:22:33 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXfQx-00074v-49
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:22:31 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e7b4ba530feso726488276.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 05:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751631745; x=1752236545; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iMBIiHQc0yjE/REZp+XDiEkuacvEtho3L9zfi80FAbQ=;
 b=aes5+PyUq/aCCT2lB61lGGjU+ai19OfVKVQYyXixM6crjUaxWU5SAZpVm2Y+auJkop
 yRbomX+z1MlOTDFSKt5A4H5YR459H5ccU/qTfB6qaGWILaRDeaiZu+g3I7FWCUN86BOr
 hpeCYRPvpIr9iQV65SlP1ei/LkpcFZtGh3rxHU5rt32LD+R+uFEWtgBmaVTFJVhNlJ7M
 sMNo2gQy6r3VXpsqjfgt50jLbHPysp22/HJrZrBIN/DW8ukbagJu7by/2Hk/HngzqeoW
 Wp3wpDapd77/tptD33jzPTFTEZvu9bUvne/vBtwQjM6A2zbbLdjYFQIbVwoSB42Omobu
 nZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751631745; x=1752236545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iMBIiHQc0yjE/REZp+XDiEkuacvEtho3L9zfi80FAbQ=;
 b=wPKaQdFRuP8KDnFTMK+hyJhIO17CpjmLKtMGBTLLuVnuIMPnCjMNJ/65Kb5klVHuDD
 mVM8mdi4fqPTlEGVYAAUnQQKfk096VkXj3OAOGWCY93kvtyZQp4TOYLvjalgpbJMjCGC
 iuPU8S9nRoSh095tilifDtkw84yd3DS+WOFwFhVTweCs/AQu6z1k6cZa//qSBg+d3EJk
 aj71b9rssTrOl7Y/Wk5UWHa0xA+L1IJJ9Zwazark09TFNM9sDDMkAmy8sHoYAwr21/oT
 wo1n/+Dw94dS/fK1lgItUrpEmOwb29vTKIBthdYT+JBTsqUzuR3VQtacnK7FdhERviVD
 XZXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0oqxLKoB1NW02zM3jCyxyc577NAOJjLNSLdoGPLnnQpJ67jENLjfFal0ZCf9LcNIgY+/SVP5qfQ4v@nongnu.org
X-Gm-Message-State: AOJu0YzbXJHaxlcvw4BdLFP3CK+HQOaEK5fAzrRKplk3YrwIT8Pd3MVP
 ZJGvHDpYuK8hnVSGLJbTLT4iU5HjvdMdcA+tu74H3yLkB1N7Y+FhPUHGzm0eL9ChVDY2w7HBU1B
 nqpv2jJlIxuX/tPcHEtRi0D/xGz24rf9TWWUiSCk4Cw==
X-Gm-Gg: ASbGncs+j6Pye4eBrgwz3M1TfEG1XuONitkEfPPqFSCJ+cMG/6Nnjz95FKIQxCn1Ip1
 xY1AZOQ2B9by47ghb9u8lgAITLe/p0y0tfUqTMIDRqxgbS3uZdSO64Yp/kLftEeh9Srp2aAG8oh
 TDylDbirAsaS7LE0nzcw6abu1RVH7gsAfF/lpx3YoZk03lZ4ZNHLgQhr4=
X-Google-Smtp-Source: AGHT+IGfWdp77I+9zhcSBR8KxW+kTvMaR6HnFCzmr6OWbowL4Jm1njk3vLbEhhoPdUJI9ceeuC/WnLUiKJ+2KHvM4DQ=
X-Received: by 2002:a05:690c:387:b0:712:d70b:45cc with SMTP id
 00721157ae682-71668cf2015mr28891327b3.8.1751631745068; Fri, 04 Jul 2025
 05:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250702163115.251445-1-eric.auger@redhat.com>
 <20250702163115.251445-5-eric.auger@redhat.com>
In-Reply-To: <20250702163115.251445-5-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 13:22:13 +0100
X-Gm-Features: Ac12FXzT3OfEfz5CdBbVNt4SvHHsZqLdVbTfeyDedc84_69uDnEINS86BXYsLM4
Message-ID: <CAFEAcA9hhdwHNrBfEqO4GD6kSb3Efcw-Rztq=CqvcOGMG3+z6A@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] hw/arm/virt: Allow virt extensions with KVM
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 miguel.luis@oracle.com, richard.henderson@linaro.org, maz@kernel.org, 
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 hi@alyssa.is
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 2 Jul 2025 at 17:31, Eric Auger <eric.auger@redhat.com> wrote:
>
> From: Haibo Xu <haibo.xu@linaro.org>
>
> Up to now virt support on guest has been only supported with TCG.
> Now it becomes feasible to use it with KVM acceleration.
>
> Also check only in-kernel GICv3 is used along with KVM EL2.
>
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v6 -> v7:
> - rebase on top of "hw/arm/virt: Make EL2 accelerator check an
>   accept-list". I dared to keep Richard's R-b though.
>
> v2 -> v3:
> - check gic version/in-kernel implementation when kvm el2 is set (Peter)
>
> v1 -> v2:
> - fixed test ordering: virt && ((kvm && !kvm_el2) || hvf) [Richard]
> - tweeked the commit title & message
> ---
>  hw/arm/virt.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 550a272fbb..1c0a2c43c4 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -792,6 +792,13 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>      default:
>          g_assert_not_reached();
>      }
> +
> +    if (kvm_enabled() && vms->virt &&
> +        (revision != 3 || !kvm_irqchip_in_kernel())) {
> +        error_report("KVM EL2 only is supported with in-kernel GICv3");

"is only supported"

> +        exit(1);
> +    }
> +
>      vms->gic = qdev_new(gictype);
>      qdev_prop_set_uint32(vms->gic, "revision", revision);
>      qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
> @@ -2211,7 +2218,8 @@ static void machvirt_init(MachineState *machine)
>          exit(1);
>      }
>
> -    if (vms->virt && !tcg_enabled() && !qtest_enabled()) {
> +    if (vms->virt && !(kvm_enabled() && kvm_arm_el2_supported()) &&
> +                     !tcg_enabled() && !qtest_enabled()) {
>          error_report("mach-virt: %s does not support providing "
>                       "Virtualization extensions to the guest CPU",
>                       current_accel_name());

Have you tested doing a VM migration of a KVM with EL2 setup?
I suppose the system registers probably generally Just Work
via the sysreg GET/SET_ONE_REG API, but won't the in-kernel
GICv3 have extra state that we need to migrate in
hw/intc/arm_gicv3_kvm.c ?

thanks
-- PMM

