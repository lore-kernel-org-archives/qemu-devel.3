Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F93AC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texsJ-0005B9-OK; Mon, 03 Feb 2025 09:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1texsE-0005AY-G3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1texsB-0004AP-IQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738594585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hpVWyB1VjMpTnWgMvsuey9cqmooTRXL8lylghjWh4bA=;
 b=SaIVrE2KV8PuwZ2XX/2NvBlgAFpLMZV2jw/UWEcY8IqU9ORv0+f5q+uNHFzh9vaGf2bzQA
 NcvvZ3AnhC8UJMy4bZaZflBaxpFKDzBd0NWz0UI2rgfU0B2vWYcTsRgjnLh3IOBxn2p0L1
 rjRg0QJQMlwphJBCXxTueVslaSmdLnk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-K2JHq3BiPDi4eVhwFiWhmg-1; Mon, 03 Feb 2025 09:56:23 -0500
X-MC-Unique: K2JHq3BiPDi4eVhwFiWhmg-1
X-Mimecast-MFC-AGG-ID: K2JHq3BiPDi4eVhwFiWhmg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so31399405e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738594582; x=1739199382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpVWyB1VjMpTnWgMvsuey9cqmooTRXL8lylghjWh4bA=;
 b=Duopi7qN10W/myCsa6LtCx5MR7AZLqOZJzjKNKUDgvLNmKwGOfCO2eXiJvsLj5bmcs
 RQ0n7fHLqF2GnMu93IRDIr5TUPuddr5WgSD1Oq9as94EiaTBb3tL2/OFVlk+7WAu58Ze
 NhNnYtWBtU1UmpGKgxmCIEhtfAx39FpuY0uXkZLG0BOiZyFjCHXgV3Ncc8MnjmSZTPZh
 tVlRGX82QqZ31MpPRe+hcAck1dBgIOr6jkBGJjCFeWCPSNk2CtdW8KEt3W29C2twdN4m
 trSDjWKZ5iXKApFxMWAbwiqMh7ICu0PoBOqddOh3699tE/IKQ4UoaHSzdR8Tets2TZzL
 0aHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL7tUnI0vpCtW3vZQ3lpewkaX+RFF87/YqftSyDkE8Fn0OnIn/KsNc3QC7K6IPQobApwewlsfQtPk0@nongnu.org
X-Gm-Message-State: AOJu0YzRdXGc+zP/AsORzzHfIClgVPe+DJGZpAFgJmAF4e91ZXOwZC1i
 RHDhX9hXX+guEaqW+J19IZUTDZJilPer8EAp/YiURXDs5gvAR9/xxetUUHMQkAME9bF6KkSxrKd
 4xzEzW+P+5q6ZXkXjh2C2TYKMBYIJHjY7cC+lee5wJU22/9lS2d60
X-Gm-Gg: ASbGncsC6WLVM4peso8lLwxnVm0Mpv9v526ZRISkxYjS9qwiEmtqW6JTJQSHUzdxyuI
 8W4olqPed+2uFTz/QQ3SdJh8qIJpo2+NScoa+XJHAL4I7b6+a8EO1IAhlg1jg5ZgplWzyQueJRG
 M75LBw2ZM/T5aVATNNpoG3JoIoOicTZlRiNJ9TpKbb9y+xlVuNwknxNOY5CPAeyIjNrdgGjeJIb
 TtBo+TZl7RN7TSZUpMUBrbbYuDpESEMPthj7W20xcioUPxTT8O93S42dBlR8V4YAxOLNawKbUWN
 5tXRg6vVv8lj9MPwMdKV0reZ7qjyH+FxtlIuKULfuv110wEhcfwZ
X-Received: by 2002:a5d:5f51:0:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-38c520af7eemr19926045f8f.51.1738594581205; 
 Mon, 03 Feb 2025 06:56:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKsfDmXecYcYAqx65QASumXBo2Ly7hd6gI8lbOCu3S2I5c/7iYMyLCugWP7aHHOPbyZATluQ==
X-Received: by 2002:a5d:5f51:0:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-38c520af7eemr19925956f8f.51.1738594579237; 
 Mon, 03 Feb 2025 06:56:19 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102bdbsm12847484f8f.28.2025.02.03.06.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:56:18 -0800 (PST)
Date: Mon, 3 Feb 2025 15:56:17 +0100
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
Subject: Re: [PATCH v3 05/14] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250203155617.50d25320@imammedo.users.ipa.redhat.com>
In-Reply-To: <0fb474d83bcb4464cf8b23822044688bdc3fd945.1738345063.git.mchehab+huawei@kernel.org>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <0fb474d83bcb4464cf8b23822044688bdc3fd945.1738345063.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 31 Jan 2025 18:42:46 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Create a new property (x-has-hest-addr) and use it to detect if
> the GHES table offsets can be calculated from the HEST address
> (qemu 10.0 and upper) or via the legacy way via an offset obtained
> from the hardware_errors firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/generic_event_device.c |  1 +
>  hw/acpi/ghes.c                 | 17 ++++++-----------
>  hw/arm/virt-acpi-build.c       | 32 ++++++++++++++++++++++++++++----
>  hw/core/machine.c              |  2 ++
>  include/hw/acpi/ghes.h         |  3 ++-
>  5 files changed, 39 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 5346cae573b7..14d8513a5440 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static const Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, false),
>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 8f284fd191a6..a91dcd777433 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -359,7 +359,8 @@ static void build_ghes_v2_entry(GArray *table_data,
>  }
>  
>  /* Build Hardware Error Source Table */
> -void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +                     GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const AcpiNotificationSourceId *notif_source,
>                       int num_sources,
> @@ -369,14 +370,6 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>      uint32_t hest_offset;
>      int i;
> -    AcpiGedState *acpi_ged_state;
> -    AcpiGhesState *ags = NULL;
> -
> -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> -                                                       NULL));
> -    if (acpi_ged_state) {
> -        ags = &acpi_ged_state->ghes_state;
> -    }

hmh, can we move this once within series to the place where it should end up at,
instead of rewriting just added code over again,
somewhere at the being of series (maybe as separate patch)?


>      hest_offset = table_data->len;
>  
> @@ -415,8 +408,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
>  
> -    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> -        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    if (ags->use_hest_addr) {
> +        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    }

the same as comment in 3/14, please no flipping back and forth which might
break bisection. Also this hunk looks misplaced and should be a part of 3/14

and do not forget about ACPI_HW_ERROR_ADDR_FW_CFG_FILE, that should be excluded
when use_hest_addr == TRUE

I see that 6/14 does that, but order makes it 
 
>  
>      ags->present = true;
>  }
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3d411787fc37..9de51105a513 100644
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
> @@ -950,10 +954,30 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> -                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
> -                        vms->oem_id, vms->oem_table_id);
> +        static const AcpiNotificationSourceId *notify;
> +        AcpiGedState *acpi_ged_state;
> +        unsigned int notify_sz;
> +        AcpiGhesState *ags;
> +
> +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +        if (acpi_ged_state) {
> +            ags = &acpi_ged_state->ghes_state;
> +
> +            acpi_add_table(table_offsets, tables_blob);
> +
> +            if (!ags->use_hest_addr) {
> +                notify = hest_ghes_notify_9_2;
> +                notify_sz = ARRAY_SIZE(hest_ghes_notify_9_2);

all 9.2 compat hunks look misplaced,
they have no relation to using HEST addr at all,
they belong to the patches that introduce new error type
i.e. where hest_ghes_notify mutates to 2 entry array.

> +            } else {
> +                notify = hest_ghes_notify;
> +                notify_sz = ARRAY_SIZE(hest_ghes_notify);
> +            }
> +
> +            acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> +                            tables->linker, notify, notify_sz,
> +                            vms->oem_id, vms->oem_table_id);
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
> index 6c2e57af0456..bfc8fd851648 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -76,7 +76,8 @@ typedef struct AcpiNotificationSourceId {
>      enum AcpiGhesNotifyType notify;
>  } AcpiNotificationSourceId;
>  
> -void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +                     GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const AcpiNotificationSourceId * const notif_source,
>                       int num_sources,


