Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFEBC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJiC-00029c-Ld; Wed, 26 Feb 2025 10:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJi5-0001zW-Fq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:52:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJi3-0004Ft-N3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740585151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KGq5La7yk+czEiF+6Xo77Jf5JrsRdt59tbf6s0nbt8=;
 b=VsaM3y6WBu5f0YE7YKG6F0hAKDzLg05LiMbidf+uZQLCFRW47rRnnsKnaB+nC5uCMF8GvR
 XZbMsZtN6931X3d1TKQmDXXdSLrGBgdnP8JvnBgpOyw3iejJZeZAEKg0FisTIxuqxbIc0t
 jsgIV7cl51e1WHlVZj8tnvRc9RoaNLA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-KSyCBbMhPbSev25-uZ0Jdg-1; Wed, 26 Feb 2025 10:52:29 -0500
X-MC-Unique: KSyCBbMhPbSev25-uZ0Jdg-1
X-Mimecast-MFC-AGG-ID: KSyCBbMhPbSev25-uZ0Jdg_1740585149
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43998ec3733so35526125e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740585148; x=1741189948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KGq5La7yk+czEiF+6Xo77Jf5JrsRdt59tbf6s0nbt8=;
 b=o53hxyTqPS7GOQkDMcLkgY3/IT4C0s7LcJCvjR6EKCV8B1Hy4FW/fgwuoHDvhJoVBJ
 NVXy/tCGUmxHPdCwKyTnUEDJlJ9jhAD84F35mv2CC40rPEijZABiv9OLM2aMUBvP3E5U
 KWQWNRpf3JUyWANKP18EC0z8f+RFhhTBVzeITs7ApECTzrRKPk7akgf6aAk60EA/qPY8
 FQPT0AQ1CHE+IpxzxZrt22qyRWmGsIwcvsC7/2eQElkPb7Y12hk1gK9RNn1JCmDAzXDj
 aYID39ydy/ik0RWPnd8ShDTV+qKk4Mmo2wp8kApQI/9JJd1ErZUB5bAAWwzFJwxk712v
 LQMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5HbwlOMlmOSA3BsHRO7zFcEil5SIAQOfi1142CP5QjFuxaXWWsZ/QUfhSKF/wSE6tNXiR1w3mP3L2@nongnu.org
X-Gm-Message-State: AOJu0YxDp83dJH7Bk0pAHBgUMLeswmens3YkAo8OyfQK8KYH3M107cnP
 QS//9tqBMZaM45OQFE9ykch4SJg2NzIS9HWxf1dtmwfciLrs8bBIErYWkC67yQn9R4q8lVQzOv+
 CMLxKNIjwy526MQkq2VFWlbFp3vQO6I8KYWk9XbCb9nKqJ7/47C1j
X-Gm-Gg: ASbGncuwprsy3LYz4LxWv6EvzViToMB74OR95tRnLRamLUvXaYe7Jt365+VAo4tcz0B
 Rc9b+JqD5EgP+SaQQ4+In7shK98tpAPYy5Qb39zLdfEDhP1L5E8XUqPxttrxx0d7hy72Fz8UtGC
 8UIXSwD9r0GpsteKi1FlTAY40/xu0BqP1J+6AP1Acqj1pOy09l509UTKmj/RBDhqgO8T4btsgmv
 1s49hUtKb9BEwFQfR5VX0tql086mjR0gN7bQN6ar8tmZK739OPPO56Sdn4mPsLoq+t9hyJN3BCK
 k6Yy6APks6TqFJTyJ7iOP+nS/m1jBHoVoaGKYLX3Cg8t47RIvy3o5jpFws7DoS8=
X-Received: by 2002:a05:600c:5493:b0:439:9a40:a9ff with SMTP id
 5b1f17b1804b1-43ab0f27170mr57873565e9.1.1740585148401; 
 Wed, 26 Feb 2025 07:52:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFhPBq1dHswsswtne5Hy7yfVLOgg9RZzruRywauu4DAenatyPVYw3EqKeA58NQ2oZQlV7VJQ==
X-Received: by 2002:a05:600c:5493:b0:439:9a40:a9ff with SMTP id
 5b1f17b1804b1-43ab0f27170mr57873335e9.1.1740585147976; 
 Wed, 26 Feb 2025 07:52:27 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba571274sm26036365e9.31.2025.02.26.07.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:52:27 -0800 (PST)
Date: Wed, 26 Feb 2025 16:52:26 +0100
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
Subject: Re: [PATCH v4 08/14] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250226165226.49b88429@imammedo.users.ipa.redhat.com>
In-Reply-To: <e9e0aafd7cc8613709171ec5d8a6d9d9be62d7c1.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <e9e0aafd7cc8613709171ec5d8a6d9d9be62d7c1.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, 21 Feb 2025 15:35:17 +0100
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

you below set it for 9.2 to false, so
shouldn't it be set to true by default here?

>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 4439252e1a75..9de51105a513 100644
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
> @@ -950,7 +954,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> +        static const AcpiNotificationSourceId *notify;
>          AcpiGedState *acpi_ged_state;
> +        unsigned int notify_sz;
>          AcpiGhesState *ags;
>  
>          acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> @@ -959,9 +965,17 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>              ags = &acpi_ged_state->ghes_state;
>  
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


