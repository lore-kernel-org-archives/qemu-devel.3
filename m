Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC12EC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Laj-0003of-Mc; Mon, 14 Apr 2025 11:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4LaZ-0003nA-6U
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:19:11 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4LaR-0001ci-05
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:19:09 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so692239966b.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744643941; x=1745248741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=itiCAPETVe2/RGi+UYH26fChg95SVzOBCEturP2yBFQ=;
 b=s44gxOFkFShD2rQaIXaFTnwHrDttwLxew71MRLiIs0dkAhq/2kFRv1/mLHEOcMcY75
 IQvDOIfA/hU8jNH7KOZXaoZQ2BZVioQw7hVV98sXN5KNK1U8Z/2XzUhRUC7A172R/ASp
 kn8OlKCFKs0rtTXXfFJfbbIQrFEWRqCMGlMwgpx640Cnq4arstJ0LIu6+uCkhXIlH382
 8vw2vAlAGvee1xtp5c3BzxTs8Hm5ZQu2vga66MRkK2lg7COej7q0Lbmlne0MWtap5gIL
 AOmH5OL7yw8oFyB9exzgvbJPtbiO7efskpu9dbLiAuLsYNebBJsJBhHjVm3Gsacl5r3q
 oO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744643941; x=1745248741;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=itiCAPETVe2/RGi+UYH26fChg95SVzOBCEturP2yBFQ=;
 b=H+jr5/vn6GqpGYuI3UYeuhwKaKu59ZmyRSFHCdvDgrpXu87P89fg9y5ULwwIhI2l16
 H6rYwA53/p97UJbIEVapVO6kPy3cPNS38bl0PCqq8ep8eiSaGDbYzNjd0/CI4H6fJET4
 nzbtUXc+F0uMDVjPl4LGuCXFPcB4Y7C14U0/6KPoiKFlxFsT4FuQiHcavPc7Pv0Cxxyf
 E4dd7yL4CdpoKu9fEmAlQhlo7wCtE9VHohmwWD+3W46M8UANqBxmmMmHkdOnhbiUp+Sw
 bI3viMvfmdjkBwLAWSruYp3AAnl0GCUUBS7DViEACmz2IkQtYCcqWoE+EO09tI0zuh73
 Cv4A==
X-Gm-Message-State: AOJu0YyGasiTqMyFv6MQbENJmJQF8fqHCVtCCqQI1LznMU6kYZ5VazHi
 XwbhRWMAX/IeNyY3bUMlLWKiMV7hbwZ3lRkInJ+gzLEu8Wm0Y9HA5+THtlwbO7A=
X-Gm-Gg: ASbGncsBrb72UreH4LN2BqGLqls7HL+8evQ2tXwlOkLJk/S6168iOJKFgYKzPwRP6bY
 eM/+XbJZAkTzI5tVLziukJ61vT6GxHaeSoElGg+6mLimKdUq0imnXMe/A5IUckqvW8bq2s3r29d
 UKn+BSpf/AEohezMesH71l+mPOyeGfARFo+AhYJ+dBuK1GAiuupxRw9nVHolakLqe1B22lNkuU3
 9qWrmz5c7R9XiLmUcUi5djXe/KZwNq2t7DykV8hVt83PckUub9BtpbkokvICvy/3D9IONgijS4d
 H43fwOtaduBoSQRuhdFTTaFTzpHd9sSTToEWGmOhajs=
X-Google-Smtp-Source: AGHT+IECmHFLkwefFkwkMhnq3FchDQkXNvvVjBChg/iMA0jradlQa1MP+Jm9R1smPucoxTbh790jqA==
X-Received: by 2002:a17:906:6a09:b0:abf:742e:1fd7 with SMTP id
 a640c23a62f3a-acad36d0442mr1206865566b.57.1744643940794; 
 Mon, 14 Apr 2025 08:19:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1bb3df5sm917955166b.26.2025.04.14.08.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 08:19:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4B8495F8A5;
 Mon, 14 Apr 2025 16:18:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Annie Li <annie.li@oracle.com>
Cc: qemu-devel@nongnu.org,  dave@treblig.org,  mst@redhat.com,
 imammedo@redhat.com,  anisinha@redhat.com,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 zhao1.liu@intel.com,  pbonzini@redhat.com,  richard.henderson@linaro.org,
 slp@redhat.com,  eblake@redhat.com,  armbru@redhat.com,
 miguel.luis@oracle.com, Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC V3 PATCH 05/13] acpi: Send the GPE event of suspend and
 wakeup for x86
In-Reply-To: <20250411204133.2955-1-annie.li@oracle.com> (Annie Li's message
 of "Fri, 11 Apr 2025 16:41:32 -0400")
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204133.2955-1-annie.li@oracle.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 14 Apr 2025 16:18:59 +0100
Message-ID: <87cydeepp8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Annie Li <annie.li@oracle.com> writes:

> The GPE event is triggered to notify x86 guest to suppend
> itself. The function acpi_send_sleep_event will also
> trigger GED events on HW-reduced systems where ACPI GED
> sleep event is supported.
>
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>  hw/acpi/core.c                       | 10 ++++++++++
>  include/hw/acpi/acpi.h               |  1 +
>  include/hw/acpi/acpi_dev_interface.h |  1 +
>  3 files changed, 12 insertions(+)
>
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 58f8964e13..00a9d226f0 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -359,6 +359,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
>      return -1;
>  }
>=20=20
> +void acpi_send_sleep_event(void)
> +{
> +    Object *obj =3D object_resolve_path_type("", TYPE_ACPI_DEVICE_IF,
> NULL);

Is it a fair assumption there will only ever be one QOM object that
provides the TYPE_ACPI_DEVICE_IF interface on a system?

> +
> +    if (obj) {
> +        /* Send sleep event */
> +        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
> +    }
> +}
> +
>  static void acpi_notify_wakeup(Notifier *notifier, void *data)
>  {
>      ACPIREGS *ar =3D container_of(notifier, ACPIREGS, wakeup);
> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
> index d1a4fa2af8..64d3ff78ed 100644
> --- a/include/hw/acpi/acpi.h
> +++ b/include/hw/acpi/acpi.h
> @@ -184,6 +184,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t=
 addr);
>=20=20
>  void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>                           AcpiEventStatusBits status);
> +void acpi_send_sleep_event(void);
>=20=20
>  void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
>=20=20
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_=
dev_interface.h
> index 68d9d15f50..1cb050cd3a 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -13,6 +13,7 @@ typedef enum {
>      ACPI_NVDIMM_HOTPLUG_STATUS =3D 16,
>      ACPI_VMGENID_CHANGE_STATUS =3D 32,
>      ACPI_POWER_DOWN_STATUS =3D 64,
> +    ACPI_SLEEP_STATUS =3D 128,
>  } AcpiEventStatusBits;
>=20=20
>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

