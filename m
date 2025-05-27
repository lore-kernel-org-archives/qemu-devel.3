Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A22C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJu6i-0001dr-RO; Tue, 27 May 2025 09:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJu6g-0001a6-H8
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJu6a-0006Ry-Qw
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748351551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0EGlLQOUrnPgaLzPYuuDb8X9EtxgT6a9liNWMqncXU=;
 b=Ei5LD2kTCQGrDFdBxsHPRhJ6MXsUGAJOC1haah0Be/1qZ8g/CkE5KIT6DVcy1rBFWvQtMr
 BBuuEP0n1mL+O60N0OmJiaLTKkp02oziHpNLj7v5Jrp8EYk+nBvBf7pZue7xmje/f8RMzb
 C+zH7Sji6hEYVaSNVZAj+yD08jZUarQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-jEuU5dY8M4SCUHhGuZpr_Q-1; Tue, 27 May 2025 09:12:24 -0400
X-MC-Unique: jEuU5dY8M4SCUHhGuZpr_Q-1
X-Mimecast-MFC-AGG-ID: jEuU5dY8M4SCUHhGuZpr_Q_1748351542
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so18081175e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748351542; x=1748956342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t0EGlLQOUrnPgaLzPYuuDb8X9EtxgT6a9liNWMqncXU=;
 b=dlp3SPRx0OpFzALLZ9GstA57zz+16y/xQfy1l1EWrXLnPVBsq+8XrBV9lpkxFpz5dk
 5n7ET2S+QE4+r1ODYmn0Zy3vW581uD5CfQoM9Ycf+fquJ0JLU3OOX5cWBs04ddVQ2xV6
 Dg2wjoSksXq1h61zpboZmasieOOfo0QXI4u/QeXIjv8Q7QdkK7lwkT7T+UhM+EpCGaRS
 kCSHFrLV16fs3MpmrZOtiE6O/QwIddrvCz9Sp0uCKb7O3kxdgkjBdURM9SM4Ur0I/wrU
 wHElia2Majfl/6QDfKJHLI/tqVWRMemM7Blh3qFS+Y3w66Kpbg+z9hDFdoIIJVSN80rh
 CIqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlRjPPLD7o34VyhvVLjFNyoC2TtHJZJkm4ACfYqGvhTbrEHS8m5d5lXhvmY7q9VaL1CC7CpeKswty2@nongnu.org
X-Gm-Message-State: AOJu0Yw/NcuFtbCn44bwqWn0PBDQtHaHz5FY+9eZSsV0ry77Qoao76Iw
 k89mt1rKmavneAtgTU2J9tI5nunHqzpP2IPorWBpiDprnbP9HNyIRiPXw4semoL1eIr7XM4iyVN
 MuaXui3gqJ/fRJUqabRRUV5uKo70YAOoLzlQBQzIxstfgn8/Qn+Tu/5tA
X-Gm-Gg: ASbGncvCtD+gbwU51tsPoVbNGytnWZvZQzPZk0+uIjh0V84s7V6UwjFkjs7VJv3tPJa
 +8XZV6qMu/WiBX18UbrNC0Q8+TL0jobPceZO5AUP6lTFWai8kIw9mbcaa3IozNS+a8flOKTHHMh
 znclgPaPn3ATczVAEQNS+Q/d9TEIpcraUddAerEwZJLL4JKSz2nDal6l9/Ks+1h+p65TyarkRXa
 s47WxLQuCN85CNSLteWxiC9D2fG65VESfb+2/nlO7CjqNkAIWNAuvaSp+4DCN4w0QESkWhP/X2J
 vxHvGbsP4/MdjhjoPYWCE7daWWGsrDaB
X-Received: by 2002:a05:600c:6285:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-44c91dd127bmr118895065e9.18.1748351542412; 
 Tue, 27 May 2025 06:12:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+mj/AFvGNpiJR7EJI4CFUj6gAE1r8GYIbhcrsz694kSdZoN7ZGpbwBfau7sjYhjn0N43ItA==
X-Received: by 2002:a05:600c:6285:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-44c91dd127bmr118894665e9.18.1748351541958; 
 Tue, 27 May 2025 06:12:21 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d8d945e0sm6246509f8f.94.2025.05.27.06.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 06:12:21 -0700 (PDT)
Date: Tue, 27 May 2025 15:12:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 12/25] hw/acpi/pcihp: Add an AmlRegionSpace arg to
 build_acpi_pci_hotplug
Message-ID: <20250527151219.7957b7a8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-13-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-13-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 27 May 2025 09:40:14 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> On ARM we will put the operation regions in AML_SYSTEM_MEMORY.
> So let's allow this configuration.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/pcihp.h | 3 ++-
>  hw/acpi/pcihp.c         | 8 ++++----
>  hw/i386/acpi-build.c    | 4 ++--
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index 8a46a414cc..253ac6e483 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -28,6 +28,7 @@
>  #define HW_ACPI_PCIHP_H
>  
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/aml-build.h"
>  #include "hw/hotplug.h"
>  
>  #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
> @@ -73,7 +74,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                           AcpiPciHpState *s, DeviceState *dev,
>                                           Error **errp);
>  
> -void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr);
> +void build_acpi_pci_hotplug(Aml *table, AmlRegionSpace rs, uint64_t pcihp_addr);
>  void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
>  void build_append_pcihp_resources(Aml *table,
>                                    uint64_t io_addr, uint64_t io_len);
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index fb54c31f77..310a5c54bd 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -629,7 +629,7 @@ static Aml *aml_pci_pdsm(void)
>      return method;
>  }
>  
> -void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
> +void build_acpi_pci_hotplug(Aml *table, AmlRegionSpace rs, uint64_t pcihp_addr)
>  {
>      Aml *scope;
>      Aml *field;
> @@ -638,21 +638,21 @@ void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
>      scope =  aml_scope("_SB.PCI0");
>  
>      aml_append(scope,
> -        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
> +        aml_operation_region("PCST", rs, aml_int(pcihp_addr), 0x08));
>      field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
>      aml_append(field, aml_named_field("PCIU", 32));
>      aml_append(field, aml_named_field("PCID", 32));
>      aml_append(scope, field);
>  
>      aml_append(scope,
> -        aml_operation_region("SEJ", AML_SYSTEM_IO,
> +        aml_operation_region("SEJ", rs,
>                               aml_int(pcihp_addr + ACPI_PCIHP_SEJ_BASE), 0x04));
>      field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
>      aml_append(field, aml_named_field("B0EJ", 32));
>      aml_append(scope, field);
>  
>      aml_append(scope,
> -        aml_operation_region("BNMR", AML_SYSTEM_IO,
> +        aml_operation_region("BNMR", rs,
>                               aml_int(pcihp_addr + ACPI_PCIHP_BNMR_BASE), 0x08));
>      field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
>      aml_append(field, aml_named_field("BNUM", 32));
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 52cef834ed..6ca2b34ef8 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1172,7 +1172,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dsdt, sb_scope);
>  
>          if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> -            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
> +            build_acpi_pci_hotplug(dsdt, AML_SYSTEM_IO, pm->pcihp_io_base);
>          }
>          build_piix4_pci0_int(dsdt);
>      } else if (q35) {
> @@ -1216,7 +1216,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dsdt, sb_scope);
>  
>          if (pm->pcihp_bridge_en) {
> -            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
> +            build_acpi_pci_hotplug(dsdt, AML_SYSTEM_IO, pm->pcihp_io_base);
>          }
>          build_q35_pci0_int(dsdt);
>      }


