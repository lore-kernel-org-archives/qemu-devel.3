Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0024E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIDa-0001Os-EE; Mon, 29 Dec 2025 13:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaIDY-0001Nq-LZ
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:43:44 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaIDW-0007hF-6Z
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:43:44 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a1022dda33so75876975ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767033820; x=1767638620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uwn1Ia6i5f2r6o+NnwihSUzXHLhls41F5p1+a1eMrFQ=;
 b=PBeGHGNX6DQxOq5c+0kHWPPaH0gRCW31+aNp/Facd3Ttc6QXfmcLbemOQfZQNEtfns
 20kYGW5z087nRa6/Y1b6BUlz0d2uyIGrLHuSuqSuXwZjDHFwS9AjEv4FcVh9O7KRcIvN
 JWC6ReNCQOitcnaA+ogZbosQq2DMqca73L6spq1TPd0vd6W9ph88jwUTSNp+f+iaO0Jq
 ac/K76lgGMnbDFi5l7K36Ij4dI9rGoDdnNAfTLKII52CqlRi7Gdkc/T5p1Vlsim3a8Dh
 IwOCKL038Xno5yaE8tnBxUTJ0KNui/Gn/+mOorRsH88DOn3O9MExmAELKap56ajrRqJ8
 Knlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767033820; x=1767638620;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uwn1Ia6i5f2r6o+NnwihSUzXHLhls41F5p1+a1eMrFQ=;
 b=mJlF3x7vRIZ69YRuS9cl4kauMkAQcxXX475qr0fyw9CEKA+edDNs47TaC3o8UpTdIh
 A9nInwXctItKxrUesQF95OIHWXnVNMxHvuAe4xsAOXsb6t2O2/M7WoO0l48v3AwnTNHy
 B3sGG65WrP4ndJ55h/NTZtEDG9ZhTpIy+biIrrSmlNcIopVEjspGXNSZnF2jpq6ywO0g
 jDzhUOSMZ2mdVncA9ytlTC7X2RjTYWqnjbNeLqnqvoNLwcRbtrYBwilaLA8R+E+SfiE0
 I3V63OH4cwyDtLZ/AS3mUgGBFn6OD9RWlqnR7VUCxlATRhtdAK7zabpu7hwhFFy8q66Q
 hCng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeZKm4P16dx+BoNaVZtfczj/2cE/LGvTjvaXmXcDnAHU3KQpNSIU229PC4wumQubOtqJI/nxC3meWs@nongnu.org
X-Gm-Message-State: AOJu0YwZlQD0Ub6HQlhZCMVsySjWfkIH4ESBtKpkpLB+aywuvKFEXf0I
 pvQAzHPZQG/WZlqiFFQWptuR+y0MhZJW70djvN6tRk9jlQkhKPK9U5Wdmd6RB7S9kvk=
X-Gm-Gg: AY/fxX4RvlrRIlivlIexnvIGUdfj5KmtwHPcckbeqh957+ww1iECHubaiiNquDF74v6
 fqfkyS8GQvC/EAB01RAWtWVlN10FQCb2g40wi6u3qbtlIUbIojiqNFRE59Ki8gfmBv71yERepWR
 Wp7Om4ptgIwdrWsVlosZvP1IXQnC8QJzb57RTm3CfcCm0Gutmuq/poPokwLVWwD0LAaJHmXbMKp
 g3nEuo5D1ptVUUTN36vakcS2Vh7JNI+Bv6C7XnpEgZ8QUjpmOq8J/IH2dEXz7zmPlVbQdJIu+P2
 HyQHZ4CLE7KoV8Zj0NalP0g1Io+ZIIkp/SyTBW+u45d5V/s3uxB0Hd4nuDY/omKDadnJRsUCS1Z
 VHf/byB1zlU6vmj+Cl/PhTIgzOf4LYi/8aGtd1G4r4L0X9v9dxr8qULefRNnsKXzk6CG36nmb87
 409MDZ6UJrJwA9rH5RTdzs5JawHTFctG9wi6/wnVP7KA+RoH98TaztyOzA
X-Google-Smtp-Source: AGHT+IH38YtqoTF7wx7s38i2m+/OSaoP7yEHgGhDuk2Zgmj+fK7stjLK8Nlx5s43A/87PIrNe3VV5A==
X-Received: by 2002:a17:903:1a2e:b0:297:d764:9874 with SMTP id
 d9443c01a7336-2a2f222bfebmr313442345ad.21.1767033820186; 
 Mon, 29 Dec 2025 10:43:40 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c83325sm281846545ad.34.2025.12.29.10.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 10:43:39 -0800 (PST)
Message-ID: <f9a6ac85-f3d5-4e14-a717-bd2183cda1d6@linaro.org>
Date: Mon, 29 Dec 2025 10:43:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/28] hw/arm: virt: add GICv2m for the case when ITS
 is not available
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
 <20251228235422.30383-5-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251228235422.30383-5-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/28/25 3:53 PM, Mohamed Mediouni wrote:
> On Hypervisor.framework for macOS and WHPX for Windows, the provided environment is a GICv3 without ITS.
> 
> As such, support a GICv3 w/ GICv2m for that scenario.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/arm/virt-acpi-build.c |  4 +++-
>   hw/arm/virt.c            | 16 +++++++++++++++-
>   include/hw/arm/virt.h    |  2 ++
>   3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 03b4342574..b6f722657a 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -960,7 +960,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>               build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
>               build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
>           }
> -    } else {
> +    }
> +
> +    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) && !vms->no_gicv3_with_gicv2m) {

check patch reports:
ERROR: line over 90 characters
#31: FILE: hw/arm/virt-acpi-build.c:965:
+    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) && 
!vms->no_gicv3_with_gicv2m) {

>           const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
>   
>           /* 5.2.12.16 GIC MSI Frame Structure */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index fd0e28f030..0fb8dcb07d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -959,6 +959,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>   
>       if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
>           create_its(vms);
> +    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
> +        create_v2m(vms);
>       } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
>           create_v2m(vms);
>       }
> @@ -2444,6 +2446,8 @@ static void machvirt_init(MachineState *machine)
>       vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
>           !vmc->no_ns_el2_virt_timer_irq;
>   
> +    vms->no_gicv3_with_gicv2m = vmc->no_gicv3_with_gicv2m;
> +
>       fdt_add_timer_nodes(vms);
>       fdt_add_cpu_nodes(vms);
>   
> @@ -3488,6 +3492,7 @@ static void virt_instance_init(Object *obj)
>       vms->its = true;
>       /* Allow ITS emulation if the machine version supports it */
>       vms->tcg_its = !vmc->no_tcg_its;
> +    vms->no_gicv3_with_gicv2m = false;
>   
>       /* Default disallows iommu instantiation */
>       vms->iommu = VIRT_IOMMU_NONE;
> @@ -3533,10 +3538,19 @@ static void machvirt_machine_init(void)
>   }
>   type_init(machvirt_machine_init);
>   
> +static void virt_machine_11_0_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
> +
>   static void virt_machine_10_2_options(MachineClass *mc)
>   {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
> +    vmc->no_gicv3_with_gicv2m = true;
> +    virt_machine_11_0_options(mc);
>   }
> -DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
> +DEFINE_VIRT_MACHINE(10, 2)
>   
>   static void virt_machine_10_1_options(MachineClass *mc)
>   {
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 8694aaa4e2..c5bc47ee88 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -130,6 +130,7 @@ struct VirtMachineClass {
>       bool no_cpu_topology;
>       bool no_tcg_lpa2;
>       bool no_ns_el2_virt_timer_irq;
> +    bool no_gicv3_with_gicv2m;
>       bool no_nested_smmu;
>   };
>   
> @@ -178,6 +179,7 @@ struct VirtMachineState {
>       char *oem_id;
>       char *oem_table_id;
>       bool ns_el2_virt_timer_irq;
> +    bool no_gicv3_with_gicv2m;
>       CXLState cxl_devices_state;
>       bool legacy_smmuv3_present;
>   };


