Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74268C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 06:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZlCk-0000VE-J4; Thu, 10 Jul 2025 02:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uZlBB-00007b-Ry
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 02:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uZlB9-0000DX-9U
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 02:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752130482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HeFcInUI5ka0CvZOXfIu+qHWVLjUClVhVKEoR5iDrsY=;
 b=PpUywatX5ZH6vDZ+LUk0IMdAP3BiOoOG/Ggjqv4C0b3MLrXpJou63RAZByGjwEjg5J+QPG
 TBVzSLcWK044471hOBrfR15mVkcribN6p2ImmUEL1XdKL9xwxmEIzXVRtaYuC1I9mYZgW5
 90A4wxOSMx7Bz9Lv7QD0wGh34wBF6Yc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-O4D-kyoqOrubHNHzZuidKg-1; Thu, 10 Jul 2025 02:53:31 -0400
X-MC-Unique: O4D-kyoqOrubHNHzZuidKg-1
X-Mimecast-MFC-AGG-ID: O4D-kyoqOrubHNHzZuidKg_1752130411
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4530ec2c87cso4181745e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 23:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752130411; x=1752735211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HeFcInUI5ka0CvZOXfIu+qHWVLjUClVhVKEoR5iDrsY=;
 b=fY4/RhgduPEFu3YFY7b9cr/lDaH6ov/d04VaU8iKtv8TFiz3MzKmfT3b9HpL7ohadF
 CfpS0nuEhp8728QmoRevvBfJGz0raqmvTtcJT4I67iCt9oYyUl7mBh0hirfP/JXaVwAI
 IBAjSt4+USD1uDSUwaNseDvkidw4hU3Ox3FwGgZkt0+jffS4LzaRBJuqRoHViTIViHvf
 2+JShwwwQ9mCzWwtErTdVtyxHtYYiwfizdFxijNS9KZ3ep2x76cXktuu50w3Xl2DIOjl
 U/cFyCSLRLrWgQ0KFHqvR9BcPkR0WsWNl0JETk50V+tRD8Vr4g6Px7q3e6RxR6SvLcKX
 4YnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDgqxzvfMiuLmVmTCnpLnW1NnY6jmet0Wzd0a32Nt33uZ5lyP6X3tVdm9N4QYDFCpWf6CRmJLlXiqm@nongnu.org
X-Gm-Message-State: AOJu0YyE3hUX5q5Ky8IVYxHtLxelY3yM19NA6mBdGaLi1oNgMjvlolp7
 YvhnXbw+tjmizyCmuoi9MSuoQX0wu1gQUQ0G6ofMWz8wMK6MCXJGFHPk4k0XKpZxmVZ7Bj2bsvT
 /Aeo8/xNOfAfrQEQGlq3kby6qNjBNZnLvFXKHYOi3EIWLVnRX8xnZKC7hVrZggnCSqj0zJvvhJ/
 kN0ZSRujwQUT8bsVZahRNZ/liVaqIUQZI=
X-Gm-Gg: ASbGncuz2TZkWWJI0YbgS37MI1R2y82TMxkfMXtPnumYdmQrOK4p3uQ07eXEdKweHCa
 GqbQcL4I7hjFARUlpj7O3DpPR33WkdOZD1Wpr26ypBh7PpLI8OP2asXaPSMPrUvAzYczrJ2vwix
 ndeG0=
X-Received: by 2002:a05:600c:c096:b0:453:2066:4a26 with SMTP id
 5b1f17b1804b1-454dbeedc20mr15666795e9.16.1752130410629; 
 Wed, 09 Jul 2025 23:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhnImP8Q70Q0w1LjnHuDlIsLT0M84Kny6zX4oKMYvef3KtL9KF1P2bBzp8VDrgsaMHxtJn7H7FeZXu1LnCYhs=
X-Received: by 2002:a05:600c:c096:b0:453:2066:4a26 with SMTP id
 5b1f17b1804b1-454dbeedc20mr15666605e9.16.1752130410201; Wed, 09 Jul 2025
 23:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250708142437.1344644-1-eric.auger@redhat.com>
 <20250708142437.1344644-30-eric.auger@redhat.com>
In-Reply-To: <20250708142437.1344644-30-eric.auger@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 10 Jul 2025 12:23:13 +0530
X-Gm-Features: Ac12FXzJXisYKS89qRYBBHCXA-7ntE-ZIX2V8SwrtZjuBps4mqRzU4huj4Qd-Ck
Message-ID: <CAE8KmOyDTMQPiRD5HoAqfd8jgRem7PuiWooNvN+9vjFm++W7oA@mail.gmail.com>
Subject: Re: [PATCH v6 29/36] hw/acpi/ged: Support migration of AcpiPciHpState
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, imammedo@redhat.com, Jonathan.Cameron@huawei.com, 
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com, 
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 9 Jul 2025 at 01:30, Eric Auger <eric.auger@redhat.com> wrote:
> Add a subsection to migrate the AcpiPciHpState state.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  hw/acpi/generic_event_device.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 7535d07737..95682b79a2 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -417,6 +417,25 @@ static const VMStateDescription vmstate_ghes_state = {
>      }
>  };
>
> +static bool pcihp_needed(void *opaque)
> +{
> +    AcpiGedState *s = opaque;
> +    return s->pcihp_state.use_acpi_hotplug_bridge;
> +}
> +
> +static const VMStateDescription vmstate_pcihp_state = {
> +    .name = "acpi-ged/pcihp",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = pcihp_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_PCI_HOTPLUG(pcihp_state,
> +                            AcpiGedState,
> +                            NULL, NULL),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_acpi_ged = {
>      .name = "acpi-ged",
>      .version_id = 1,
> @@ -429,6 +448,7 @@ static const VMStateDescription vmstate_acpi_ged = {
>          &vmstate_memhp_state,
>          &vmstate_cpuhp_state,
>          &vmstate_ghes_state,
> +        &vmstate_pcihp_state,
>          NULL
>      }
>  };
> --

Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


