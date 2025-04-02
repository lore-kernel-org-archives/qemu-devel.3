Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7B5C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 06:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzrpT-0001uI-Gf; Wed, 02 Apr 2025 02:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tzrpN-0001pn-Rr
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 02:43:58 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tzrpL-0001EK-UC
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 02:43:57 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227b828de00so111364595ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743576234; x=1744181034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lpOEkBT50AOkXMKAy4M+CiYOtuUAnzqRKkSj7urq1aE=;
 b=NwKFqo9hM7A3Anw0K0wbr98/7EzwxXSiaj3S5g/bSPid5FKRmbxtdTW9LU+cSRUuCO
 9nreNRXBlHpQl1LBn7LqI7sAXrjoH0IL25pir+rxn5c+WO6xbwozaeiWHsMUTIWmiXwp
 YiD4wUTj2QdV457xEorsteo4RLbJp28VrwHLpLxJpRYt4C3QQNwA4nfW61a9MljetFdE
 oxhIOxzc25RU4JjAK8H7eA6qAQmqLFxfBmqNMS/edJ6aoeuCeO24gAdR41E2ZSOpUF5O
 t9e9Su8Nt55HQhl5p4zkvvhLesD9wDy8zggU8Re8s7Y+wU+2zIcAf3r2JzTgigP2ZBoj
 b79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743576234; x=1744181034;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lpOEkBT50AOkXMKAy4M+CiYOtuUAnzqRKkSj7urq1aE=;
 b=Gb710fP36stsfbn8kzrHiPBCh7ku5VHrsd1bvttrAG6tJTDZEKc/7ogFpXfR83NeMP
 JF4Woxd/fMkQsEsXwH4Mt2zNRkbqRc/T58XIIprhqIExFdvVxP3yZ2+8dbXt550UpbsA
 VEDzErFqNufsm7hTjCsBkizTPaUYD0oyT5z7Qncv3zbMUuPjzOu2SBgFt0A8JTGW4sGq
 VLLNlcrZyZef9qZRyZSqASXmHoQNSk2RGpunQ8B3oJ4rK3OFEbhr6TSKmqz22804d+G3
 IbXlTKdya+VHDJxy+yTbzyiPnEMQn+gVl4F3JRMrA0qw8/VpVeKDPjAaDRP8IZHXifCH
 +IJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaTTYHcXww3wtzMm/rxAmlFe7W309ikCG8cs/j6mue7UGcXapjb38b5XmZCb+tlGX3dJsQy3UjEmvg@nongnu.org
X-Gm-Message-State: AOJu0Yx336if1VpvRMsqvK1vFW+Rtc8V9UEAwj3rvY7z5Zxt6iM5FH4F
 siTfv4WQnYJqzDS7JjyxLVj44MVV8Jdft+7m2UWf6HovORdY1LwyPu7FyUzLRyI=
X-Gm-Gg: ASbGnctmAH2U9tuoi+dnGBsxbUVDsly7F9zHBqjvom6qmrHIGbDy7HqowjpP/KeN43D
 0c+tYkrqBYK0M3Q4Np3z5dzbXDRhlqlFWeFU2rLHJphjVtvXbAYUFS7NwZCQfDkGJA5l+wsuN7v
 sJoMWvi/bJ6EE3O+lqTDd4RBCLU0MzVnmot8onr4up+nctI6VfK6l/oDgI6UUzmYD2e8fKHEHv7
 G5YgiHtpgJ/zHjPxBWbsuNjeDbA3U6RAILuZ2BfbVc0I9eRuDBvbEik6t9MUfuip2uNsVNukvOG
 Nf1Jwl2FuZL+B6Xu07xagTQCEr9d771lUZmIOCls1c2d8kX3Fum3c8mW
X-Google-Smtp-Source: AGHT+IEieuC3lMeeZeiiLh1WRq9R0SC/80Wxl1NofROdINcgE1f08vJv306B+fJ9D6r/r9k4X0r5tg==
X-Received: by 2002:a17:903:1b6b:b0:210:fce4:11ec with SMTP id
 d9443c01a7336-2296c6053bamr18089375ad.1.1743576233907; 
 Tue, 01 Apr 2025 23:43:53 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1cf688sm100463285ad.121.2025.04.01.23.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 23:43:53 -0700 (PDT)
Message-ID: <80dd971a-2a45-44a5-9454-43257ead30a5@linaro.org>
Date: Wed, 2 Apr 2025 03:43:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 3/5] hw/arm/virt-acpi: Factor its_enabled()
 helper out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
 <20250331221239.87150-4-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250331221239.87150-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

Hi Phil,

On 3/31/25 19:12, Philippe Mathieu-Daudé wrote:
> GIC ITS is checked for the MADT and IORT tables.
> Factor the checks out to the its_enabled() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt-acpi-build.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3ac8f8e1786..fdc08b40883 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -208,6 +208,13 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
>   #define ROOT_COMPLEX_ENTRY_SIZE 36
>   #define IORT_NODE_OFFSET 48
>   
> +static bool its_enabled(VirtMachineState *vms)
> +{
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> +
> +    return its_class_name() && !vmc->no_its;
> +}
> +

Isn't its_class_name() always "true"?


Cheers,
Gustavo

>   /*
>    * Append an ID mapping entry as described by "Table 4 ID mapping format" in
>    * "IO Remapping Table System Software on ARM Platforms", Chapter 3.
> @@ -670,7 +677,6 @@ static void
>   build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   {
>       int i;
> -    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>       const MemMapEntry *memmap = vms->memmap;
>       AcpiTable table = { .sig = "APIC", .rev = 4, .oem_id = vms->oem_id,
>                           .oem_table_id = vms->oem_table_id };
> @@ -741,7 +747,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                                             memmap[VIRT_HIGH_GIC_REDIST2].size);
>           }
>   
> -        if (its_class_name() && !vmc->no_its) {
> +        if (its_enabled(vms)) {
>               /*
>                * ACPI spec, Revision 6.0 Errata A
>                * (original 6.0 definition has invalid Length)
> @@ -973,7 +979,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>                             vms->oem_table_id);
>       }
>   
> -    if (its_class_name() && !vmc->no_its) {
> +    if (its_enabled(vms)) {
>           acpi_add_table(table_offsets, tables_blob);
>           build_iort(tables_blob, tables->linker, vms);
>       }


