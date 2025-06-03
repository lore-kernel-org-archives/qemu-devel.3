Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EBAC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 12:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQqr-0000Of-7I; Tue, 03 Jun 2025 08:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMQqp-0000N3-FY
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMQqk-0007wX-Pr
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748954075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eIhGCXDv7NiJbTiC9u4z6b5iPz46vlUE2j/Ou+LZnRY=;
 b=ZKQgzawJF5loHxmmKTHRzUfemHjCIeNCHDO0T/o/dFR2IMBDkXHxmcpM5rg7l/z8yQPdS6
 sItl0QioVvB3yYZ/YD7h7eKSBZ+Z4N2qY1y+3j2fwS2rG3c1TjQ+NT3UjAD2w2csdwXgLx
 bVLxaRgamVXSvj9tjXnJzyetbYpxJo4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-s_iu3v0-MNieQ6PS28PSuQ-1; Tue, 03 Jun 2025 08:34:34 -0400
X-MC-Unique: s_iu3v0-MNieQ6PS28PSuQ-1
X-Mimecast-MFC-AGG-ID: s_iu3v0-MNieQ6PS28PSuQ_1748954073
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450787c8626so31900835e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 05:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748954073; x=1749558873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIhGCXDv7NiJbTiC9u4z6b5iPz46vlUE2j/Ou+LZnRY=;
 b=Q8JcW0zbsk39lWAkiXJADRjQqYIm2SQTIeHCTd9BgdYMQICR1TokJmlfRqMC4qs3mN
 LSawRrVMdngw6jEbs9cX9RJXj2pb8+N5eK1Phazju6UP5bDq/s/sWKCG/itFsRNB/+W0
 jkT/6o2R93R8TAwfkgHjetkwHIhIsn/3RmU4aZaCrOlivAcbzf7M1H3BFdanMKoSPS6d
 3lWt/CM6Wh2nEIa/GmEvwf5mG6NYg5fFS5R6wP4iJUG4rxSKAV4WO56zOW5QjN9eOlvZ
 awAGxFyLABabwCHNjMFNeMlBC89V47JtPmfbfHC8sPmHJH+0hU/g/Kjan/1TUDgWcwae
 W9+Q==
X-Gm-Message-State: AOJu0YxHCmFuSmQgSMOsCWZ/pZgMZWUAqwhiB35ECgu6/PZogaKjnRW5
 OQcGD7MQpopuMAQ9GmCmESjRpNg1LWI7uTOuwsrakRe+vR0aVzIhUTzYZiGDfqu2E3/2+sfrVQA
 8q5G/ECtssFlHAloghGuox76XwfyRIkiX0tJb3UkaoZInBdT+7RnVyaPL
X-Gm-Gg: ASbGncuQXb8sUuGBD3SAQs16tkkrFlvNKitcFqBIqPniJ1pvAtxgKNRFWFSFGicPH26
 DxAEVgFXZrIIUaDHtICAHDo+W5057HYGxRkpxNo1729oYITH3O48+bus9yMEK40j5tFAhB7mC8U
 oL3ozloT0yjmjw1eiHc109XCpTv3czifqp3q0yJaNNjU5tjJEBF7VJEZgOsvbc7nhuxf9SubVIo
 ZZoFImI25Dh70p3HPN+PgOVd429fUJDJxPQl8iYiyOzit4Wwrx4zGPBux/7QWuCom8RnZH1/EdY
 ZrgXRrYPS5DE+XKgigRaNcYpepV/k8AX
X-Received: by 2002:a05:600c:500e:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-4511edd5e6fmr104680015e9.21.1748954073137; 
 Tue, 03 Jun 2025 05:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNzICJ7jiQchXgpE4UAnjqnEPCMfhEnyjWD5vKQwSW5Q7salTQVIyn9d4pVPgR8Xx457uV9A==
X-Received: by 2002:a05:600c:500e:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-4511edd5e6fmr104679755e9.21.1748954072762; 
 Tue, 03 Jun 2025 05:34:32 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb0654sm160321495e9.21.2025.06.03.05.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 05:34:32 -0700 (PDT)
Date: Tue, 3 Jun 2025 14:34:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
Subject: Re: [PATCH 05/13] acpi: Send the GPE event of sleep for x86
Message-ID: <20250603143431.1ba917df@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250528163953.2183-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250528163953.2183-1-annie.li@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

On Wed, 28 May 2025 12:39:52 -0400
Annie Li <annie.li@oracle.com> wrote:

> The GPE event is triggered to notify x86 guest to sleep
> itself. The function acpi_send_sleep_event will also
> trigger GED events on HW-reduced systems where ACPI GED
> sleep event is supported.
> 
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>  hw/acpi/core.c                       | 12 ++++++++++++
>  include/hw/acpi/acpi.h               |  1 +
>  include/hw/acpi/acpi_dev_interface.h |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 58f8964e13..dcabe881bf 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -359,6 +359,18 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
>      return -1;
>  }
>  
> +void acpi_send_sleep_event(void)
> +{
> +    bool ambiguous;
> +    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, &ambiguous);
> +
> +    assert(!ambiguous);
> +    if (obj) {

Can it ever be NULL?
If not drop condition.

> +        /* Send sleep event */
> +        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
> +    }
> +}
> +
>  static void acpi_notify_wakeup(Notifier *notifier, void *data)
>  {
>      ACPIREGS *ar = container_of(notifier, ACPIREGS, wakeup);
> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
> index d1a4fa2af8..64d3ff78ed 100644
> --- a/include/hw/acpi/acpi.h
> +++ b/include/hw/acpi/acpi.h
> @@ -184,6 +184,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr);
>  
>  void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>                           AcpiEventStatusBits status);
> +void acpi_send_sleep_event(void);
>  
>  void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
>  
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 68d9d15f50..1cb050cd3a 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -13,6 +13,7 @@ typedef enum {
>      ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>      ACPI_VMGENID_CHANGE_STATUS = 32,
>      ACPI_POWER_DOWN_STATUS = 64,
> +    ACPI_SLEEP_STATUS = 128,
>  } AcpiEventStatusBits;
>  
>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"


