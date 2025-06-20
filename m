Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF704C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSakN-00050k-91; Fri, 20 Jun 2025 08:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSajt-0004wr-GO
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:21:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSajr-0007Mm-EW
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750422057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCDuPbcz51+r9EY5thnNhRDzl+s2DLdA7Mhax7aDjbM=;
 b=i8IbxwVa3/DkxSYjrqcP23XGedoWUHD1yOcL1Z2wgwok08BYzT4/OoKBcNJjrVP7pFxNR6
 osDWjw9dMeZzxJTVcx7FI9YI4poKEtO4ga9JS5E8Kmyz0axIxnJdGUY2dK+A6pEiGM/+/7
 6k9CjcvryUPbwJK/OdHQptWZWyIL+3Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-2giSYj9NMKCDMUuvYp36RA-1; Fri, 20 Jun 2025 08:20:56 -0400
X-MC-Unique: 2giSYj9NMKCDMUuvYp36RA-1
X-Mimecast-MFC-AGG-ID: 2giSYj9NMKCDMUuvYp36RA_1750422055
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso1012433f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750422055; x=1751026855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gCDuPbcz51+r9EY5thnNhRDzl+s2DLdA7Mhax7aDjbM=;
 b=TvJ6hQMq7fHxN9au4i3ZYSPSsTePUnytFeodAspTu9MfLGvQ39XU/opxAmN7dNtAb6
 OwtbWJm3S5lcB/UZ+jliPSu25aq1GB7wtpiuFgrsrKEFG0Gk1XjI6G4MTOsOTcB6X4C6
 ZFXiXrE3ntzyInSWRytcsAOOq4l9tTrB1i3fWKkiytXm+3iUgv13XUIevHW9F9sqled+
 CUB8W5CybPA0Y8d13lNSiAaJcf+ictS+ugMtVN7fLiSJvCn2eMIzSYy8MCF2aUxlGc/e
 mJJIFC2jDKWzqN4bG+9pqiFA9SdOcOdfhBwnLL1f+oNmL/q5O2iqCl55jhKQdI3Px2se
 Znhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURoedTUoCN5fY9yN2lRxe1kxnyNgHl3JkuY/IVOO3GyknlNjqHnmn+AEtsde0jLskYv/bU7sZQtRdL@nongnu.org
X-Gm-Message-State: AOJu0YzwvC1Wu8QkJAQE4Xv6VPR410wDqkqRUBNW18KmA3MXF+HuPc3E
 hXvJ0zXs7NxWv6nAOBy9rYZYDMZ/YSidVfcqbDeNSpuSmYfD1s53+6GNlp6Ni6aDnNNbc+aTnCz
 FgPfOEuRICQF0HTQU1lzKza/07nHwDb76qI4g1ETOWKXkFDl9LlEru8wd
X-Gm-Gg: ASbGncugJP/IFry5xPRJgHplzBNr1XoGUfIF5K5hrNX5Ja//pwKk5lrQ97nz6wZe7mf
 vc7lk5CWClkbYARGpVxLWd85BkRxX+sy7e0HbUXql/elRd9vUokZZK3fvF0XSayr2YiCdh00a75
 i1FD1f303NxjrN7kOW/DqwV50r2d89eYv8DG0pKPPCIKakigkYKHuhrTPcFfYdml6+YbwFtgZ8J
 8YZP5ixtJBXorxPJrbna7rTndmn7SEOtHpL1srM4qZPOcdnSdmlqw6OraIHOknJqNELhHWCVYH8
 qLLFW5pGZCr4
X-Received: by 2002:a05:6000:65c:b0:3a4:e667:922e with SMTP id
 ffacd0b85a97d-3a6d12dbe56mr2141497f8f.4.1750422055283; 
 Fri, 20 Jun 2025 05:20:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGOPPnwZQZDCN7GBhEHlQZ1eWYxrDYOQZAErz4+cZ6o9lSpDkRSgIVe461zPDNDp/xyfyk6A==
X-Received: by 2002:a05:6000:65c:b0:3a4:e667:922e with SMTP id
 ffacd0b85a97d-3a6d12dbe56mr2141466f8f.4.1750422054881; 
 Fri, 20 Jun 2025 05:20:54 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45366181aebsm7966475e9.3.2025.06.20.05.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 05:20:54 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:20:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 15/29] hw/i386/acpi-build: Use AcpiPciHpState::root
 in acpi_set_pci_info
Message-ID: <20250620142053.3a32333e@fedora>
In-Reply-To: <20250616094903.885753-16-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-16-eric.auger@redhat.com>
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

On Mon, 16 Jun 2025 11:46:44 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> pcihp acpi_set_pci_info() generic code currently uses
> acpi_get_i386_pci_host() to retrieve the pci host bridge.
> 
> To make it work also on ARM we get rid of that call and
> directly use AcpiPciHpState::root.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> v2 -> v3:
> - Use AcpiPciHpState::root
> 
> v1 -> v2
> - described the fact we changed the implementation of
>   acpi_get_pci_host() in the commit msg.
> ---
>  hw/acpi/pcihp.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 236e175b69..e79a24b821 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -99,10 +99,10 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
>      return info;
>  }
>  
> -static void acpi_set_pci_info(bool has_bridge_hotplug)
> +static void acpi_set_pci_info(AcpiPciHpState *s)
>  {
>      static bool bsel_is_set;
> -    Object *host = acpi_get_i386_pci_host();
> +    bool has_bridge_hotplug = s->use_acpi_hotplug_bridge;
>      PCIBus *bus;
>      BSELInfo info = { .bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT,
>                        .has_bridge_hotplug = has_bridge_hotplug };
> @@ -112,11 +112,8 @@ static void acpi_set_pci_info(bool has_bridge_hotplug)
>      }
>      bsel_is_set = true;
>  
> -    if (!host) {
> -        return;
> -    }
>  
> -    bus = PCI_HOST_BRIDGE(host)->bus;
> +    bus = s->root;
>      if (bus) {
>          /* Scan all PCI buses. Set property to enable acpi based hotplug. */
>          pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &info);
> @@ -266,7 +263,7 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
>  
>  void acpi_pcihp_reset(AcpiPciHpState *s)
>  {
> -    acpi_set_pci_info(s->use_acpi_hotplug_bridge);
> +    acpi_set_pci_info(s);
>      acpi_pcihp_update(s);
>  }
>  


