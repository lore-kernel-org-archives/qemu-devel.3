Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A7FC02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9Ku-0006aV-SS; Wed, 29 Jan 2025 09:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td9Ko-00063j-2K
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td9Kl-0001jA-1E
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738161986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zps/3j71AxRB3VSHFiDs10+H/k3K8T/PTeJbzfow478=;
 b=EmzAfwthjOSGxt0ypBI2c8chg+/yQlSQqJH/hr/RTJBoZ7m+F6vBA6QnNbccL28komvW4m
 N3q1dAlkzSfyZFmDA+1DuntbONlxe2FuJviFCkbOpXUERNM0NpL0TqPPi3pYbmZXY5Du+B
 tNfPBjhGhrc6upkzupo+GNgnC+GIVg8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-0ubYVrTwM-q0XR2mGRXpFw-1; Wed, 29 Jan 2025 09:46:23 -0500
X-MC-Unique: 0ubYVrTwM-q0XR2mGRXpFw-1
X-Mimecast-MFC-AGG-ID: 0ubYVrTwM-q0XR2mGRXpFw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e03f54d0so2796655f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 06:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738161982; x=1738766782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zps/3j71AxRB3VSHFiDs10+H/k3K8T/PTeJbzfow478=;
 b=iWnUrjr9oHJLzvOgR/ZWUTQyKQQz1kdT+X2ywSRYsGHhDFZ3dYXRtLuyZXYaoYYHEl
 23Nbb37HhKsZBvLptCxpHml7s11khspABZ8TxSBZ9J0nBN2a3XOx2qsBs700+OT26idd
 dS8yGZq8L9K9p7jDUP2Jg7mZBOVSx1zHm+lgpcPl6rIECL4Yx2sDYhLfp7z6+zoB+2bP
 7wmJM6cbN9+7JpWVUYNbqeFtINPrR1+vX+niCM3PruZk4a0fGKmwFvgX0tkjaNe3ovO3
 QKJboZZwLsTvdJDxf3BDIUoQH+nAHGSwpiTZupQxSBvUE3vD+W1DQ2G56ixf3Fk6vGZw
 EFJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuH8CiwW4gvCV2dr2QPbN95hdukRHlQnj3j1qjQetzM+B56XxG03ETxj8X6I7dAaC8JZcnIb4NuVuk@nongnu.org
X-Gm-Message-State: AOJu0Ywg/4Wzpa6zP0d4pw+xUrszf9LBY55uZw7IUlBjQvm1JU8BZrCc
 e+EDao4g7snxNH8cuo3xuKgw1vTzRLixHZNKlkzw50gwmEMYO4LCiDpi/dbEkWv/TjYOQfIqyM4
 XIviK7mY1euVUpDjWAY2tgFLFv6FDGiL16B1dd87HgAZpsFBqlGzO
X-Gm-Gg: ASbGncsNQH8OlY4dRReVieTSLCaiDcNiD4aiMOOh19TlzeHPqqacsJ3sG3RDOxCWclb
 AK/wX38Hlr8Xp5sm1hrwDPUNKaDbGoyvX92m++63MzLmYb9Tgb0DQVElMijOpYItY+ICuQTzig4
 jaeEiOmGMgxFGkFYpl7H9uZtYuIPjm+nHY7SFWAFaFupwY6UeMViidgNvUJUoPkUOD82dGwtBlJ
 EcpTohEHNIJyyvgbvpZd1wuCJYhIwhtriwphneebdlgPY/yssVZIsahfIYwm6Vk4btTIYkzMk1c
 /k2nTySb6kKl5zwlZNb3mLJixsWl7CZaWdATz9ueV/Ij37hrsKTH
X-Received: by 2002:a5d:4528:0:b0:386:3803:bbd5 with SMTP id
 ffacd0b85a97d-38c520aef99mr2090036f8f.45.1738161982385; 
 Wed, 29 Jan 2025 06:46:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTWMdkLt0nZB0pu9uyexYYwVelUXqEYDlVLdT4jETusdaU3xjREvgMs4Ww71m1F5P8mClsBA==
X-Received: by 2002:a5d:4528:0:b0:386:3803:bbd5 with SMTP id
 ffacd0b85a97d-38c520aef99mr2090015f8f.45.1738161981922; 
 Wed, 29 Jan 2025 06:46:21 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81a39sm24823285e9.35.2025.01.29.06.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 06:46:21 -0800 (PST)
Date: Wed, 29 Jan 2025 15:46:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/13] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250129154620.4f7ac01c@imammedo.users.ipa.redhat.com>
In-Reply-To: <2c18343e6f8dd84f734329396a789a3a314519ff.1738137123.git.mchehab+huawei@kernel.org>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <2c18343e6f8dd84f734329396a789a3a314519ff.1738137123.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 29 Jan 2025 09:04:12 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Create a new property (x-has-hest-addr) and use it to detect if
> the GHES table offsets can be calculated from the HEST address
> (qemu 10.0 and upper) or via the legacy way via an offset obtained
                                              ^^^
s/via/where/

> from the hardware_errors firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/generic_event_device.c |  1 +
>  hw/acpi/ghes.c                 | 20 +++++++++++++-------
>  hw/arm/virt-acpi-build.c       | 30 ++++++++++++++++++++++++++----
>  hw/core/machine.c              |  2 ++
>  include/hw/acpi/ghes.h         |  4 +++-
>  5 files changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 5346cae573b7..70729b6238a5 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static const Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, true),
>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index adf80945c6db..736287766989 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -353,7 +353,8 @@ static void build_ghes_v2_entry(GArray *table_data,
>  }
>  
>  /* Build Hardware Error Source Table */
> -void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +                     GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const AcpiNotificationSourceId *notif_source,
>                       int num_sources,
> @@ -382,10 +383,13 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>       * Tell firmware to write into GPA the address of HEST via fw_cfg,
>       * once initialized.
>       */
> -    bios_linker_loader_write_pointer(linker,
> -                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> -                                     sizeof(uint64_t),
> -                                     ACPI_BUILD_TABLE_FILE, hest_offset);
> +
> +    if (ags->use_hest_addr) {
> +        bios_linker_loader_write_pointer(linker,
> +                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                         sizeof(uint64_t),
> +                                         ACPI_BUILD_TABLE_FILE, hest_offset);
> +    }

if ags->use_hest_addr is true, then we can safely exclude
 hardware_errors_addr fw_cfg
it shouldn't be used when use_hest_addr == true,
something along lines:

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 7362877669..a30f65f9f5 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -272,6 +272,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
                                        i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
     }
 
+if (!ags->use_hest_addr) {
     /*
      * Tell firmware to write hardware_errors GPA into
      * hardware_errors_addr fw_cfg, once the former has been initialized.
@@ -280,6 +281,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
                                      sizeof(uint64_t),
                                      ACPI_HW_ERROR_FW_CFG_FILE, 0);
 }
+}
 
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
 static void build_ghes_v2_entry(GArray *table_data,
@@ -399,13 +401,13 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
                     hardware_error->len);
 
-    /* Create a read-write fw_cfg file for Address */
-    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
-        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
-
     if (ags->use_hest_addr) {
         fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
             NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+    } else {
+        /* Create a read-write fw_cfg file for Address */
+        fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
+           NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
     }
 
     ags->present = true;


>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> @@ -399,8 +403,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
>  
> -    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> -        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    if (ags->use_hest_addr) {
> +        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    }
>  
>      ags->present = true;
>  }
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3d411787fc37..be1e51e0bb29 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -897,6 +897,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
>      { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
>  };
>  
> +static const AcpiNotificationSourceId hest_ghes_notify_9_2[] = {
> +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> +};
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -950,10 +954,28 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> -                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
> -                        vms->oem_id, vms->oem_table_id);
> +        AcpiGhesState *ags;
> +        AcpiGedState *acpi_ged_state;

I'd do something like this, instead of calling acpi_build_hest() twice

           notify = hest_ghes_notify_9_2
           notify_sz = ...

> +
> +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +        if (acpi_ged_state) {
> +            ags = &acpi_ged_state->ghes_state;
> +
> +            acpi_add_table(table_offsets, tables_blob);
> +
> +            if (!ags->use_hest_addr) {

                   notify = hest_ghes_notify
                   notify_sz = 

> +            }
               acpi_build_hest(ags, tables_blob, tables->hardware_errors,
                               tables->linker, notify,
                               notify_sz,
                               vms->oem_id, vms->oem_table_id);
> +        }
>      }
>  
>      if (ms->numa_state->num_nodes > 0) {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c23b39949649..0d0cde481954 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,10 +34,12 @@
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "audio/audio.h"
>  
>  GlobalProperty hw_compat_9_2[] = {
>      {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
> +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
>  };
>  const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 237721fec0a2..bfc8fd851648 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -61,6 +61,7 @@ typedef struct AcpiGhesState {
>      uint64_t hest_addr_le;
>      uint64_t hw_error_le;
>      bool present; /* True if GHES is present at all on this board */
> +    bool use_hest_addr; /* True if HEST address is present */
>  } AcpiGhesState;
>  
>  /*
> @@ -75,7 +76,8 @@ typedef struct AcpiNotificationSourceId {
>      enum AcpiGhesNotifyType notify;
>  } AcpiNotificationSourceId;
>  
> -void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +                     GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const AcpiNotificationSourceId * const notif_source,
>                       int num_sources,


