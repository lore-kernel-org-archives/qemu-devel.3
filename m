Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716A4C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 13:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tne0v-0004OW-Ui; Thu, 27 Feb 2025 08:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tne0s-0004O7-Sv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:33:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tne0q-0003Ay-RF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740663195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuW0BIbjNJWghJa21XE54H5m1b+Yluf4uBw+NY/1p34=;
 b=S0MKc0GMHmat4pszZAw83BLkTnSEPd0xWvLoqrpObLEeta0+8MZMsIZuPr2C+GSLTIVbFK
 yR/PWIwn3QYmPwEaMxKysflqWzIU9y/TDWucJ+jmXSYUjjTM9IapLcgRpQSg9jTKFqm4r+
 A9Bm8C2jkffOlo6xZUhKBheoqkwBGZs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Jp-Yp3CjOZ-faS4hArfchg-1; Thu, 27 Feb 2025 08:33:13 -0500
X-MC-Unique: Jp-Yp3CjOZ-faS4hArfchg-1
X-Mimecast-MFC-AGG-ID: Jp-Yp3CjOZ-faS4hArfchg_1740663193
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abb61c30566so88337666b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 05:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740663192; x=1741267992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HuW0BIbjNJWghJa21XE54H5m1b+Yluf4uBw+NY/1p34=;
 b=Aal/DJ9r6JArOFyNPJuYX6/G/uXBpMXZl5f0v11gOiiyu0wF5wjgSRKF6DNqy3kTmi
 4ec//vtopVTpX+QWUD2dRM4lcky+CPTM88BVRV1/fmeqoHiQVOT5e0YgeiMGw7CCpgPA
 8/H+G8Vk5h4g1Tjqi0kRBRuo2b/JJc7Y1rUxG359Bm1HXmD/xMxnLbgPFki9IHPCS/uX
 rtXB7AX3E8n1y1Qw8c27LHNY9jzokJHjU2NxJiU7HFf9ruPSZO45Daq35M9fVg182LAD
 yYmbCWsHisKO92pEVPxSSsPxAFxXWisbMrx+EdBA/TB3Qtb3uNQpDmWKY2jOsTZaalaj
 UCfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm5XdR59rwqhAH3ZqfpOnBf5XwWTjBi0je2NJ4tr6dddxEi1Q1ArCxEMASVhsEMuzGQuglDq6p8nXU@nongnu.org
X-Gm-Message-State: AOJu0YxAs2BMMUrQCJGfEU0y8zsj8oW0KvU/FyT03s9vNb8U2M1BOQNq
 5L0EyZc15YFiv7zj1E+FSjPkJpAFUbzJhhvcRGyftPId6hYylzvaH7U/FEqS0uZfuN30NJ4Rm4L
 VCL6YELUkJGBMYLA/TsqhlDfhEMJ1AwhbYDOoQ0LS6tnyH69y89jv
X-Gm-Gg: ASbGncuP+CPqbRVcRQ3S+tjzUU7N3b9QJs+nmfw0vN6SU5eYBkRqFmr9Sn9bj8cfRoQ
 m26QzE/+J/As4JHO1ky9z5Ig5jv/E5kb7Ovv04uo2XLGgRNqsnwOLZEHKCbphI4igheKeRXhR77
 uezKWcquxl49YI4x1CVhP0yDDTXH3ljcpTdI0H37L+ZfQsEZUdh3+MDkFA4kOogHQXiDLShq+2N
 twl1m0J/ioTE1YJqeJ8k6I3x8MPpXERGgX6t0t5J03M60Zaqm6yeupApurZ1NV6lI9BFcO1jZ6B
 jILqQzUelhtdFyztdhGwixvWG3NYZOa5JT1+Us9vLjUz++6PqzlYmr8sdVv1yEI=
X-Received: by 2002:a17:906:c102:b0:abf:692:40bd with SMTP id
 a640c23a62f3a-abf069269e7mr507684066b.43.1740663192428; 
 Thu, 27 Feb 2025 05:33:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/90eOgmTyscXKI0cIupAmIcBT4EO6X1+/bdOFr1HCGTM4DVJjj7JL05WdQvhP1cwBDPTntw==
X-Received: by 2002:a17:906:c102:b0:abf:692:40bd with SMTP id
 a640c23a62f3a-abf069269e7mr507680666b.43.1740663191987; 
 Thu, 27 Feb 2025 05:33:11 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf1bef130esm57685066b.40.2025.02.27.05.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 05:33:11 -0800 (PST)
Date: Thu, 27 Feb 2025 14:33:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/21] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250227143310.3df0687f@imammedo.users.ipa.redhat.com>
In-Reply-To: <73e0b70ed4125dc07a85fb43281a7731f452750e.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <73e0b70ed4125dc07a85fb43281a7731f452750e.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 27 Feb 2025 12:03:42 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Create a new property (x-has-hest-addr) and use it to detect if
> the GHES table offsets can be calculated from the HEST address
> (qemu 10.0 and upper) or via the legacy way via an offset obtained
> from the hardware_errors firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

with checkpatch issues fixed
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/generic_event_device.c |  1 +
>  hw/arm/virt-acpi-build.c       | 18 ++++++++++++++++--
>  hw/core/machine.c              |  2 ++
>  3 files changed, 19 insertions(+), 2 deletions(-)
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
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index af5056201c22..03ee30b3b3f0 100644
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
> @@ -951,6 +955,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  
>      if (vms->ras) {
>          AcpiGedState *acpi_ged_state;
> +        static const AcpiNotificationSourceId *notify;
> +        unsigned int notify_sz;
>          AcpiGhesState *ags;
>  
>          acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> @@ -958,9 +964,17 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>          ags = &acpi_ged_state->ghes_state;
>          if (ags) {
>              acpi_add_table(table_offsets, tables_blob);
> +
> +            if (!ags->use_hest_addr) {
> +                notify = hest_ghes_notify_9_2;
> +                notify_sz = ARRAY_SIZE(hest_ghes_notify_9_2);
> +            } else {
> +                notify = hest_ghes_notify;
> +                notify_sz = ARRAY_SIZE(hest_ghes_notify);
> +            }
> +
>              acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> -                            tables->linker, hest_ghes_notify,
> -                            ARRAY_SIZE(hest_ghes_notify),
> +                            tables->linker, notify, notify_sz,
>                              vms->oem_id, vms->oem_table_id);
>          }
>      }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 02cff735b3fb..7a11e0f87b11 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,6 +34,7 @@
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "audio/audio.h"
>  
>  GlobalProperty hw_compat_9_2[] = {
> @@ -43,6 +44,7 @@ GlobalProperty hw_compat_9_2[] = {
>      { "virtio-balloon-pci-non-transitional", "vectors", "0" },
>      { "virtio-mem-pci", "vectors", "0" },
>      { "migration", "multifd-clean-tls-termination", "false" },
> +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
>  };
>  const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>  


