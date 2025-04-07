Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B4CC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 12:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1lHU-0003Kt-0O; Mon, 07 Apr 2025 08:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1lHG-00036p-92
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 08:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1lHB-0006So-5t
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 08:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744027706;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mj/dzqXQb6D6L5bKjxFn8KcdxD9+qRjWUBiBrM5ZAXs=;
 b=NCjmVQ1bX1Cb10+Hrs0btx216gUfhJeFqZlX9TJNJiyMRv+2hu0ag3EOsmWwQpTlUEQukw
 20WkzZBch/6a9/Kx3rPeB4GXxA+dNqm8uRj5mpy8pRjFU7y7tVlWkg1IZF1HcRxxqWQNLD
 GGN0dsmLhnUtCZ43iJMYp7hET8wJ4Ek=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-zV3LXR04PHKEI0CH90YseA-1; Mon, 07 Apr 2025 08:08:25 -0400
X-MC-Unique: zV3LXR04PHKEI0CH90YseA-1
X-Mimecast-MFC-AGG-ID: zV3LXR04PHKEI0CH90YseA_1744027704
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913f97d115so2130541f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 05:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744027704; x=1744632504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mj/dzqXQb6D6L5bKjxFn8KcdxD9+qRjWUBiBrM5ZAXs=;
 b=DbqILpddWsH1SuGxfYQDKs/P0955J2I7HYGqQEshBxW4PquQkufSOPO+STb9AyKY4X
 JwuOCT0Io7j/0RP7wavkNxGx7jKIo3XEgarVVyI+5rgyHU738HcIgkP//kNBO9IaDoy+
 8Jvvt8KCM1bJdcTv7Q4my5ykdg0qiIvbtXZXnbRsv2enHIs6XQqiJ6L52okAOTsOnV+m
 AHnu3J8ggtWY4bviIadGA1uW0GEcVfJi1Wd/PoxDK1KaaEvXwQ+USe5ZHozNgdbBJaYl
 ZiM45r2HBtoA8EbISdr3vvVTdyuj1apEG2irJ4jlEYbWQuR5mSTB+aGUuBw+1wXtrp8Z
 mfWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFHXI2ep9CODDbtPgXy/bLDkbhblZXe2+CWsDfZLfyKXuc2yG1nPByT2vUzV3CqYf5iCmQYnzlvQ3I@nongnu.org
X-Gm-Message-State: AOJu0Yw6zHEFLkZMaCngZEEjyFlSro2xI673QFhPRsuuzCmjOcMiT4Dn
 v8ch7hmKPVY4f5D5ARLhD9I5d4J/wHfC73MMa6stSg4TckT/VHm+bDS5mjDnS6APOqNcwC2JUVB
 dmxfqSvvcNsgGuIgejV0FKQ/lpcQfcoeWsMqaccYiRe40PXY3HjkX
X-Gm-Gg: ASbGncvPvIWopwZcrqukq6i6xRj2UgFeKqx3JkLzaVavQbhHugxA/pBr22Zq+10ZDss
 xNDYn54tGLTh0M6n0nfhkFi0aCMbUMagmZtw0LxnN1bL1PzqP+FxeLK6hZJdKydopq1Xr2q+sb/
 8s/wuPCsQ/22Vo9Dh3jJ8AIAPl/p9wQ9dfSsc2HyjYLFscvI9KiQpwKcclyPSWyOM3Oz/oVtWYD
 SiUsoQzdY5YtFPs8NrcMLOlxLaRn/N4++/H7VcZlZ82X20X5LO++E3UMsIGO/lDtRWbq0kI6oJk
 5K6tZhj7kHtYCPBVBISijVH5ctMEi91hVSlCB4kKrqMwFGoRXsI1eLqdaEtG320=
X-Received: by 2002:a05:6000:4212:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-39c2e6219b2mr14459477f8f.15.1744027704011; 
 Mon, 07 Apr 2025 05:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXXmd57rymqmPJnQki/kvAEsesBDSIPuC0AnzymGBFiKSv/YKd5FFvxajVbUxJ/AgQqzUTQQ==
X-Received: by 2002:a05:6000:4212:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-39c2e6219b2mr14459454f8f.15.1744027703663; 
 Mon, 07 Apr 2025 05:08:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec3428298sm129662595e9.8.2025.04.07.05.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 05:08:22 -0700 (PDT)
Message-ID: <d5b9e64f-6fe3-4de9-ba4b-4cf3b61a5800@redhat.com>
Date: Mon, 7 Apr 2025 14:08:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 4/9] hw/arm/virt-acpi: Factor its_enabled()
 helper out
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-5-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250403204029.47958-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/3/25 10:40 PM, Philippe Mathieu-Daudé wrote:
> GIC ITS is checked for the MADT and IORT tables.
> Factor the checks out to the its_enabled() helper.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/virt-acpi-build.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9b7fc99f170..1c389ef5cdb 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -208,6 +208,13 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
>  #define ROOT_COMPLEX_ENTRY_SIZE 36
>  #define IORT_NODE_OFFSET 48
>  
> +static bool its_enabled(VirtMachineState *vms)
> +{
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> +
> +    return !vmc->no_its;
> +}
> +
>  /*
>   * Append an ID mapping entry as described by "Table 4 ID mapping format" in
>   * "IO Remapping Table System Software on ARM Platforms", Chapter 3.
> @@ -670,7 +677,6 @@ static void
>  build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
>      int i;
> -    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      const MemMapEntry *memmap = vms->memmap;
>      AcpiTable table = { .sig = "APIC", .rev = 4, .oem_id = vms->oem_id,
>                          .oem_table_id = vms->oem_table_id };
> @@ -741,7 +747,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                                            memmap[VIRT_HIGH_GIC_REDIST2].size);
>          }
>  
> -        if (!vmc->no_its) {
> +        if (its_enabled(vms)) {
>              /*
>               * ACPI spec, Revision 6.0 Errata A
>               * (original 6.0 definition has invalid Length)
> @@ -973,7 +979,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>                            vms->oem_table_id);
>      }
>  
> -    if (!vmc->no_its) {
> +    if (its_enabled(vms)) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_iort(tables_blob, tables->linker, vms);
>      }


