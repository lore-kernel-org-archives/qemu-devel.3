Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29C8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAtX-0004uT-Iq; Mon, 29 Jun 2026 08:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weAtW-0004sJ-A1
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weAtT-0006JM-T3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782735318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NpQPJOYlbKsGqmZzUDVtJ1mJHqH+cuJnb9/K+tTKSsM=;
 b=ftUz132ihq1x5YihMkpnuCX2gQbsysPtTBMdMMPvDLgPpCrW+suBmgxHdL/EexknYWq96Q
 LFnKs/OS1MuhAGYFRrPQvVoAumLrITWkHuGoJ49vOPdumvFaCDT1oqBLmuqOTjEolzKxWz
 VouPjeosH3BFptr8PRFCs6SD3aI6Uec=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-TFSghh2jPpqJ5D59oKCUfA-1; Mon, 29 Jun 2026 08:15:16 -0400
X-MC-Unique: TFSghh2jPpqJ5D59oKCUfA-1
X-Mimecast-MFC-AGG-ID: TFSghh2jPpqJ5D59oKCUfA_1782735315
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47407691804so343277f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782735315; x=1783340115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NpQPJOYlbKsGqmZzUDVtJ1mJHqH+cuJnb9/K+tTKSsM=;
 b=VYyRI/hidFDWMO5nQgg3dHC1X8Sw7nODFnqxRke2kMCjhFum5mUmsHaCYmA6B7h5/p
 OEWrEbiJp27z41gWtJjEq9m9qiw9aa2u0xqq7BIVdp9SsE9Vznc6li3tOTc+qwea+B1R
 4jJRgm/dLOfbarhg9Roa2CT2fmlds7q2pRty/4njT7Yat2LgX24QLA+dg20VG59xdwmI
 sSY1fhv2C3lj2fMTbdQbUDiLW9bDuEHms0styVC3aw6hDSmO0r2BL2mVRsjversQsdTw
 haAHX2nBC4iUVgpSuSq0uEMFibXziI+czi7Q9qGDcX5TvtI+4ItSRwEafKNImJLA1Pdk
 Kgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782735315; x=1783340115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NpQPJOYlbKsGqmZzUDVtJ1mJHqH+cuJnb9/K+tTKSsM=;
 b=GcXUbH5FK07Xz+WZ2y8AYtomr8ZQRQnOt0QwhCIC7nelu27Rk+4qRPBE8AMHW5PXQC
 alyQWmrlA9dVNrngsqq/mZaL0MaYNSxpshdVZqrAWwPoniYcE/QAoYCXNAWd0iF4sg13
 ljfsRIX/7UCHGQi0XXWKfmue0QJcKc+NVDcbej1IbCufUZHoUSKSlDwuaHMMvqZoM86Y
 XjpOJTbJqVhlUx0JFZ78Txi1tQNPqBR+EapnWw/yiL3dB0A4nlRV0pe0+V1V8l5dF+iq
 fmAH8gnffEZkcAz40PZyqPD2ykuykzUVQWDPlaV3K2QHoU1XxPTBYB5a5m3PEN3zJn2S
 cG5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHeXM2mfvfwo2GFKGR12zo+nGL3GpDkAj2mQPb6lJIBPsvwA7Bb3TpkBOFv/iYqyEwwUFtA5DZfRcM@nongnu.org
X-Gm-Message-State: AOJu0Ywr1MwG17PiggUHWYHYa/d4MRnVTb0QI0QVR5hG7lL6eIQsMALZ
 uoGh4WmkZgZmIDQmQDb75u4pvPOC81upsKK0SLGkHWIUB6JTp8pnbVo/9hWacLLNgLO4SBD1X8Y
 ERJ35ZoJ2Y2ikXXaLVybhqioDame3KX5l9hy2FxWb3E1sEsu7UGr2smTF
X-Gm-Gg: AfdE7ck/H96+QIgB0BiJTUe/VB74AL6CcNmLjOOIsl9PydqRw0hqbIIycEOCn1Q251y
 mJ6qvChl36zEiEhUeZiRzBIMDRc8NzAwu/YIwFrau7oEAS62pWCeJDt1xIy+iqQqouw7Xzv3Lce
 OGxhjswODzmGBNf4plQ0GVep5Cy/AmmWtmkwJcASaQ0iCZxiZIvkXZSReFjtNE5VguIqTMVITr3
 NAYmVY5TTiZ5hiFF5EIfJVSUCF/jZun1h5PUE7A1QKpF838/64PaSijxm+Id60fS8KPo5gcVERE
 ZySHiYOLmHUP1hlTIbBQWgJAAIa3m3ilUjrDoLJeteWervh92UbN5RoGdG49nTeXzG/KLJ4B+3g
 ez6dPqNd/0P4H5rI7jLtfpCIzuO9NvKBCAp7/BrcdP+EmU1tAGub04A==
X-Received: by 2002:a05:6000:29db:b0:45d:3aa3:7f76 with SMTP id
 ffacd0b85a97d-46dc14cbf6emr19408254f8f.33.1782735315438; 
 Mon, 29 Jun 2026 05:15:15 -0700 (PDT)
X-Received: by 2002:a05:6000:29db:b0:45d:3aa3:7f76 with SMTP id
 ffacd0b85a97d-46dc14cbf6emr19408204f8f.33.1782735314996; 
 Mon, 29 Jun 2026 05:15:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f9db29a94sm28598349f8f.22.2026.06.29.05.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 05:15:14 -0700 (PDT)
Message-ID: <50466e87-36f6-4462-ac01-dbdcb2745891@redhat.com>
Date: Mon, 29 Jun 2026 14:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/17] arm: virt: add support for WDAT based watchdog
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
References: <20260624102830.1355552-1-imammedo@redhat.com>
 <20260624102830.1355552-8-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260624102830.1355552-8-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/24/26 12:28 PM, Igor Mammedov wrote:
> Add WDAT handling for sbsa-gwdt on arm/virt machine.
> 
> WDAT mode is enabled by 'wdat' option: ex: "-device sbsa-gwdt,wdat=on"
> 
> When WDAT is enabled:
>  - Build the WDAT ACPI table instead of the GTDT watchdog entry,
>    since they are mutually exclusive due to different timer
>    resolution (WDAT uses 1 kHz vs GTDT's system counter frequency).
>  - Skip FDT watchdog node creation, as the DT-based Linux driver
>    would use the system counter frequency which doesn't match the
>    WDAT-mode 1 kHz clock.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v3:
>    - Skip FDT watchdog node creation in wdat mode
>    (Eric)
>      - wiring part of larger '[PATCH v2 11/21] arm: virt: add support for WDAT based watchdog'
> ---
>  hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++--------
>  hw/arm/virt.c            | 10 ++++++----
>  2 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f5b3b4ce48..71706b98e6 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -65,6 +65,7 @@
>  #include "target/arm/cpu.h"
>  #include "target/arm/multiprocessing.h"
>  #include "hw/watchdog/sbsa_gwdt.h"
> +#include "hw/acpi/wdat-gwdt.h"
>  
>  #include "smmuv3-accel.h"
>  #include "tegra241-cmdqv.h"
> @@ -859,7 +860,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   * 5.2.25 Generic Timer Description Table (GTDT)
>   */
>  static void
> -build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> +build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms,
> +           Object *wdt, bool add_watchdog)
wdt is not used anymore

With that fixed
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


>  {
>      /*
>       * Table 5-117 Flag Definitions
> @@ -870,7 +872,6 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
>                          .oem_table_id = vms->oem_table_id };
>      uint32_t gtdt_start = table_data->len;
> -    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
>  
>      acpi_table_begin(&table, table_data);
>  
> @@ -903,12 +904,12 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, 0xFFFFFFFFFFFFFFFF, 8);
>  
>      /* Platform Timer Count */
> -    build_append_int_noprefix(table_data,  wdt ? 1 : 0, 4);
> +    build_append_int_noprefix(table_data,  add_watchdog ? 1 : 0, 4);
>      /* Platform Timer Offset */
>      build_append_int_noprefix(table_data,
> -        wdt ? (table_data->len - gtdt_start) +
> -              4 + 4 + 4 /* len of this & following 2 fields to skip */
> -            : 0, 4);
> +        add_watchdog ? (table_data->len - gtdt_start) +
> +                       4 + 4 + 4 /* len of this & following 2 fields to skip */
> +                     : 0, 4);
>  
>      if (vms->ns_el2_virt_timer_irq) {
>          /* Virtual EL2 Timer GSIV */
> @@ -921,7 +922,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
> -    if (wdt) {
> +    if (add_watchdog) {
>          hwaddr rbase = vms->memmap[VIRT_GWDT_REFRESH].base;
>          hwaddr cbase = vms->memmap[VIRT_GWDT_CONTROL].base;
>          int irq = ARM_SPI_BASE + vms->irqmap[VIRT_GWDT_WS0];
> @@ -1332,13 +1333,19 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      GArray *table_offsets;
>      unsigned dsdt, xsdt;
> +    bool has_wdat = false;
>      GArray *tables_blob = tables->table_data;
>      MachineState *ms = MACHINE(vms);
>      CPUCoreCaches caches[CPU_MAX_CACHES];
>      unsigned int num_caches;
> +    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
>  
>      num_caches = virt_get_caches(vms, caches);
>  
> +    if (wdt) {
> +        has_wdat = object_property_get_bool(wdt, "wdat", &error_abort);
> +    }
> +
>      table_offsets = g_array_new(false, true /* clear */,
>                                          sizeof(uint32_t));
>  
> @@ -1357,6 +1364,17 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      acpi_add_table(table_offsets, tables_blob);
>      build_madt(tables_blob, tables->linker, vms);
>  
> +    acpi_add_table(table_offsets, tables_blob);
> +    if (wdt && has_wdat) {
> +        uint64_t freq = object_property_get_uint(wdt, "clock-frequency",
> +                                                 &error_abort);
> +        build_gwdt_wdat(tables_blob, tables->linker,
> +                        vms->oem_id, vms->oem_table_id,
> +                        vms->memmap[VIRT_GWDT_REFRESH].base,
> +                        vms->memmap[VIRT_GWDT_CONTROL].base,
> +                        freq);
> +    }
> +
>      if (!vmc->no_cpu_topology) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_pptt(tables_blob, tables->linker, ms, vms->oem_id,
> @@ -1364,7 +1382,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      }
>  
>      acpi_add_table(table_offsets, tables_blob);
> -    build_gtdt(tables_blob, tables->linker, vms);
> +    build_gtdt(tables_blob, tables->linker, vms, wdt, wdt && !has_wdat);
>  
>      acpi_add_table(table_offsets, tables_blob);
>      {
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index aacf9b7251..35ded6d1d4 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3825,9 +3825,11 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>          qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>          g_free(resv_prop_str);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_WDT_SBSA)) {
> -        uint64_t cntfrq = object_property_get_int(OBJECT(qemu_get_cpu(0)),
> -                                                  "cntfrq", &error_abort);
> -        qdev_prop_set_uint64(dev, "clock-frequency", cntfrq);
> +        if (!object_property_get_bool(OBJECT(dev), "wdat", &error_abort)) {
> +            uint64_t cntfrq = object_property_get_int(OBJECT(qemu_get_cpu(0)),
> +                                                      "cntfrq", &error_abort);
> +            qdev_prop_set_uint64(dev, "clock-frequency", cntfrq);
> +        }
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
>          if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
>              error_setg(errp, "virt machine already has %s set. "
> @@ -3890,7 +3892,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>          sysbus_mmio_map(s, 1, cbase);
>          sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
>  
> -        {
> +        if (!object_property_get_bool(OBJECT(dev), "wdat", &error_abort)) {
>              char *nodename = g_strdup_printf("/watchdog@%" PRIx64, cbase);
>  
>              qemu_fdt_add_subnode(ms->fdt, nodename);


