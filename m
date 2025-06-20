Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCA5C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbFv-00072T-3o; Fri, 20 Jun 2025 08:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbFs-000726-R2
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbFo-0002ka-9q
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750424038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpJ9He9GeILtZKTHNA5OGPxDe6Vm4FWISqx7nV9RGjw=;
 b=JrbH3PbRpH8Iqfu+F37GkaJu4JBqHWMlc8KU4XOJ6au9ZmvL3bbkz8ECqYerFNMeqh62KZ
 yXt63bVacTfhWIbElGmhtc6cPQMS6Z2cTW1xFw5jiSIBbu0nQX+x2km77rDzfHYOvZ+1YW
 AZdakXoMgm+G/iisZmvEB32ADPnJ7PI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-5EelRYQwOdW6FaexOwLq1g-1; Fri, 20 Jun 2025 08:53:57 -0400
X-MC-Unique: 5EelRYQwOdW6FaexOwLq1g-1
X-Mimecast-MFC-AGG-ID: 5EelRYQwOdW6FaexOwLq1g_1750424036
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45311704d22so11227085e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424036; x=1751028836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gpJ9He9GeILtZKTHNA5OGPxDe6Vm4FWISqx7nV9RGjw=;
 b=kbojlSiJuD79PqyVVgKMHOtFf0+mV44mpfeRuwL79wvWMYBSlnGm67BrCh6WPycehc
 PjFC0bFav+NCZm6YoBK98inBPhWXV85n5NmxJZa4Rq9K54SeR+6Dq4SOO8ZTy1KysgWE
 uVOgir21iCmhNwqJ5/rLnH2QzJxOybOv/HMXlJ7C/vcGeGbIlnAzqrS+4RNnVQdWJXdb
 9BrXUlmFZXTjkkFwAxVKM9DpU4DgzuO2+GUVsnTYmRCtHTT87hN7VZv5yu0M6aQaJc5P
 e4XWGx35BskrUqgnebnVR195FIIzim1GYhytGhQLo6Mhq79ir4I39zSQ+yoowp/Gh8KL
 GJmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2IV9IVmrc2TDJOfyv3KrvBn2dVuhqvzCv7EHYNmDxC7ussMzmwDjq5j96qTcy+6Z0LGPwAaD8Aif2@nongnu.org
X-Gm-Message-State: AOJu0Ywr9WLAWOanDZq7auJx111G6gs66iIYxPfZAs66i68tyKWu1IsT
 xcJjxxkDZNp8QoGr15h8pNu4/OwI3O3LXAWPAvQzPUX02KAg1Tpk3FS7cKAaWQN9indR7/+B8vn
 h4oqU3w6cWRvQzLzlpfWpkU6AH9ndfRUYFKyi2/mUmVfyXO8Am/W3yGojzHo5de6W
X-Gm-Gg: ASbGncuICIGVW92XpobYSTb8zcZDvLKIi38gW7eTcQsQA8fUDcwnVG9JAtoBT9IkuBZ
 v+nTXVjNdcq3crFsZj8mYHK+QgNEkA1c0U/Tucv6Kx0TKk0ChSw9rm7vhLJ3GRaceKYkr5RDEl5
 +wpTvXsTcHBOB/7Vtt/ERpfb4siDNEHFH7sxZQ2XGsGzFa5Fw5L7HGbnTnfquucbk0I77C5inpx
 5Qlny9ZE3k0NPwVJxSgACFjs/wsF5ZWXxZAlXNj4j4H+tlZu04I6d1lZoy3d03SqzNDGzQA5xCh
 5/VCZYRpnKWD
X-Received: by 2002:a05:6000:645:b0:3a4:fefb:c8d3 with SMTP id
 ffacd0b85a97d-3a6d130e802mr2393219f8f.40.1750424035990; 
 Fri, 20 Jun 2025 05:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSTXYIKlv4J6+TbOtFuhkQimBlBaUdFESUJ5G5cT5G35l43BNfkHUiEEvNvS/VCE204i/Ewg==
X-Received: by 2002:a05:6000:645:b0:3a4:fefb:c8d3 with SMTP id
 ffacd0b85a97d-3a6d130e802mr2393192f8f.40.1750424035556; 
 Fri, 20 Jun 2025 05:53:55 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646dc66fsm24404625e9.18.2025.06.20.05.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 05:53:55 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:53:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 21/29] hw/acpi/ged: Call pcihp plug callbacks in
 hotplug handler implementation
Message-ID: <20250620145354.31f709ad@fedora>
In-Reply-To: <20250616094903.885753-22-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-22-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

On Mon, 16 Jun 2025 11:46:50 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Add PCI device related code in the TYPE_HOTPLUG_HANDLER
> implementation.
> 
> For a PCI device hotplug/hotunplug event, the code routes to
> acpi_pcihp_device callbacks (pre_plug_cb, plug_cb, unplug_request_cb,
> unplug_cb).
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

I'd put that before 20/29

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


> ---
> 
> v2 -> v3:
> - remove else block in acpi_ged_device_pre_plug_cb
> ---
>  hw/acpi/generic_event_device.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index b4eefb0106..2ae9ad082a 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -18,6 +18,7 @@
>  #include "hw/irq.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/mem/nvdimm.h"
> +#include "hw/pci/pci_device.h"
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "qemu/error-report.h"
> @@ -236,6 +237,14 @@ static const MemoryRegionOps ged_regs_ops = {
>      },
>  };
>  
> +static void acpi_ged_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> +                                        DeviceState *dev, Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_pre_plug_cb(hotplug_dev, dev, errp);
> +    }
> +}
> +
>  static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>                                      DeviceState *dev, Error **errp)
>  {
> @@ -249,6 +258,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>          }
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_plug_cb(hotplug_dev, &s->pcihp_state, dev, errp);
>      } else {
>          error_setg(errp, "virt: device plug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -265,6 +276,9 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
>          acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_unplug_request_cb(hotplug_dev, &s->pcihp_state,
> +                                            dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -280,6 +294,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
>          acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->pcihp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -510,6 +526,7 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
>      dc->vmsd = &vmstate_acpi_ged;
>      dc->realize = acpi_ged_realize;
>  
> +    hc->pre_plug = acpi_ged_device_pre_plug_cb;
>      hc->plug = acpi_ged_device_plug_cb;
>      hc->unplug_request = acpi_ged_unplug_request_cb;
>      hc->unplug = acpi_ged_unplug_cb;


