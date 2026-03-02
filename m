Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8354DD58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwfy-00089c-St; Mon, 02 Mar 2026 01:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vwwfw-00087u-70
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:22:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vwwft-0005jg-So
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772432555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8xHnXP2+i2Sqi2ibG1CO68US9CyRL0aXIdbKa8Ya7Q=;
 b=FdfV5ZdKCIiXmLFnnwp52asww/RMED7StQZQvp2gGyATdcDSNsjrqSGe1X2QvVEmK0JmvE
 oPP/2TS6NMybXQzS0QrgQQDpTs0QPsiaj0vVZd7Lp/9jgqAprtiI+KVbK7VjTlGfHaFIjh
 1oZ37Q9g4PyajDLaYp11a70CeCCixvA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-T3kiyv4BOrec4LrTUH4QNA-1; Mon, 02 Mar 2026 01:22:34 -0500
X-MC-Unique: T3kiyv4BOrec4LrTUH4QNA-1
X-Mimecast-MFC-AGG-ID: T3kiyv4BOrec4LrTUH4QNA_1772432553
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837246211bso53556305e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 22:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772432553; x=1773037353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8xHnXP2+i2Sqi2ibG1CO68US9CyRL0aXIdbKa8Ya7Q=;
 b=rqOPdAnn6xVcqdBo96oW5YgF8GuPQft7wyGu0QBHCTNxqZWYoIVVeANEgl1+I2+PGT
 DDzEH232HlyAK55FMjB44I3WPgRiynv/+Lcz5N2Tb8dd0CwAa+qCqNXiGhthUNJckmtv
 ibXqhwiFM4xkMi/L+N1HabnGIWgPDJBb7f4lCHsPzvyRqq2LPqLJ3d3up/Ev+kLDh04e
 4p/HlwgHX8UyZgkU+QZDCJamOxFXnGjjLpcULy1MExJit1B0ZbJmQrtuYBtFRcOEZzkw
 sm/RocAzc4Rfks+TIJegkCiepRMjmiutlBdVAbG1AiSUrT3d81TXCw6TD2F2xZjYQmBt
 EWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772432553; x=1773037353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i8xHnXP2+i2Sqi2ibG1CO68US9CyRL0aXIdbKa8Ya7Q=;
 b=MDUNRsr+82U9V83n7td5XamKFMIeigp8C9jVqKdzdwmpXFITmbUQNTiV2M3WD3fAQd
 GUi6vehqVJ5UDfqvUfi1rVuh+yzhhEc7O+35bfBwu8B/N0DlebeALAQ2/yvQFRTR1tup
 FzY0q82mK7hT09j+aM7zlpCQm9Vjj1r2MX/ipFsmvDg0nSXL26eOx5Jfb3T406KP2W7r
 yFFO0oUDUl9bEC3++6EHbpR7bTut96+tX2krmsweSQlcZzRGRqB71zyh3w9yMe4qEdwr
 BoxBt4zT/Ch/LsLXkqL+eoUBZNAFMxUxVFOCOR00KP1AGjkimhPIltWekhwkIHZ037Aw
 uiMg==
X-Gm-Message-State: AOJu0Yw2gHsny7MjbHkBGZQ6HPNtzjnlFy2AWyAcMKsVZLAVCNxcXq7M
 tF0Q/kut2Am7FOpc+s7xPhZf3eMsYSkOcwvc0vcdxuBfhUfJVM0qN8PxmV9BxiujnHb+aqCLdWJ
 BAA6ER66moolja83A25b+4c+s8dfqc748RTGllHE11o1HA0EyPuyZnMSn
X-Gm-Gg: ATEYQzwZwikMfJEvdzwNFPyfRC1Nj1BwbglNx/s+O3XWialcyaJ6xxp73RakD/pZJFK
 OYZh8z6p9/lp0WNlzzlpitUxP+kTqtB37IFtA+iEIlZPLt/Clllz/uBd8YZfeVT1C318JW676ta
 9tg7BUpHQe0rXh6E79gpNaPK7HB6J7upb/CrzPFdOz83fGVvS1/209xHENWEcsA/HL8zTZkhKac
 L0ncGQqXaYXeiBXajb2cIPWnvS9oZNRL1STOWd++d65QveXpBd2KDbOcWaJdnAilLf0BTF30YRi
 Acy3B18CGX6LfQpjp6YcPBY+7wzQ79EnKGZKMEnJP9DXEalw0DZ8dZACqBF+cW5VjJXvqlFg6l9
 GV4/nrg==
X-Received: by 2002:a05:600c:46d5:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-483c9bb7c16mr183709605e9.3.1772432552949; 
 Sun, 01 Mar 2026 22:22:32 -0800 (PST)
X-Received: by 2002:a05:600c:46d5:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-483c9bb7c16mr183709335e9.3.1772432552538; 
 Sun, 01 Mar 2026 22:22:32 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfbb465bsm277437775e9.3.2026.03.01.22.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 22:22:31 -0800 (PST)
Date: Mon, 2 Mar 2026 07:22:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 02/11] hw/acpi: Move acpi_send_event() function out
 of acpi_interface.c
Message-ID: <20260302072230.668f5906@imammedo>
In-Reply-To: <20260225035739.42848-3-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
 <20260225035739.42848-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 25 Feb 2026 04:57:30 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> acpi_interface.c should only register QOM interfaces. Move
> the acpi_send_event() function to core.c with the other
> event handlers, and its declaration in 'hw/acpi/acpi.h'.
>=20
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/acpi.h               |  1 +
>  include/hw/acpi/acpi_dev_interface.h |  2 --
>  hw/acpi/acpi_interface.c             |  9 ---------
>  hw/acpi/core.c                       | 10 ++++++++++
>  4 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
> index b036116dfb8..dc3672db521 100644
> --- a/include/hw/acpi/acpi.h
> +++ b/include/hw/acpi/acpi.h
> @@ -182,6 +182,7 @@ void acpi_gpe_reset(ACPIREGS *ar);
>  void acpi_gpe_ioport_writeb(ACPIREGS *ar, uint32_t addr, uint32_t val);
>  uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr);
> =20
> +void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
>  void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>                           AcpiEventStatusBits status);
> =20
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_=
dev_interface.h
> index 5927e40eaff..65debb90a8d 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -27,8 +27,6 @@ DECLARE_CLASS_CHECKERS(AcpiDeviceIfClass, ACPI_DEVICE_I=
F,
> =20
>  typedef struct AcpiDeviceIf AcpiDeviceIf;
> =20
> -void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
> -
>  /**
>   * AcpiDeviceIfClass:
>   *
> diff --git a/hw/acpi/acpi_interface.c b/hw/acpi/acpi_interface.c
> index 8637ff18fca..e58e8aaee23 100644
> --- a/hw/acpi/acpi_interface.c
> +++ b/hw/acpi/acpi_interface.c
> @@ -4,15 +4,6 @@
>  #include "qemu/module.h"
>  #include "qemu/queue.h"
> =20
> -void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event)
> -{
> -    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(dev);
> -    if (adevc->send_event) {
> -        AcpiDeviceIf *adev =3D ACPI_DEVICE_IF(dev);
> -        adevc->send_event(adev, event);
> -    }
> -}
> -
>  void qbus_build_aml(BusState *bus, Aml *scope)
>  {
>      BusChild *kid;
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 6b65e587f2a..a6a62a742d1 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -22,6 +22,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/core/irq.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/acpi_dev_interface.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "qemu/config-file.h"
>  #include "qapi/error.h"
> @@ -753,3 +754,12 @@ void acpi_update_sci(ACPIREGS *regs, qemu_irq irq)
>                         (regs->pm1.evt.en & ACPI_BITMASK_TIMER_ENABLE) &&
>                         !(pm1a_sts & ACPI_BITMASK_TIMER_STATUS));
>  }
> +
> +void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event)
> +{
> +    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(dev);
> +    if (adevc->send_event) {
> +        AcpiDeviceIf *adev =3D ACPI_DEVICE_IF(dev);
> +        adevc->send_event(adev, event);
> +    }
> +}


