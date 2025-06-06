Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933C1C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWqH-000238-E9; Fri, 06 Jun 2025 09:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNWqF-00022d-V4
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNWqD-0001aZ-Lh
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749215433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7qYu20UH1C1ja8g+S+Vm9h283DG5lvy0PhG3JEOW0Y=;
 b=ezZ/Y71fZDfYTYCjtSeQbNtqZysiRwRzciduukvXlVmBy0iRpfb1013tsjWuXtAE7HtQhC
 5te4JvocPyM4jUoJgG1pYucuvcLDYCqPPmsX24xaCXaPZiX+tlvZ1tJvayry1Oj91FxeLN
 7gzOarW1i2N85HatSfnWLgLydHbS9os=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-j5YYF_V1NhKHqm26anXsvw-1; Fri, 06 Jun 2025 09:10:32 -0400
X-MC-Unique: j5YYF_V1NhKHqm26anXsvw-1
X-Mimecast-MFC-AGG-ID: j5YYF_V1NhKHqm26anXsvw_1749215431
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-addcea380fcso165075766b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749215431; x=1749820231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7qYu20UH1C1ja8g+S+Vm9h283DG5lvy0PhG3JEOW0Y=;
 b=w/OEQ9VIPWxWXEtCaDgDGbFBq+laHnSQfuDmpSFOcZIVhnTlZ10FPV3WuPhJPABxt3
 AKxfSzcA8UfroHRIpn8XjSmG1wFaE7cZBAMYNvJWyc7gfmgkJdh96FnWJGVBHvIsbdXe
 vwRKEVINB5STFhDxs666xttcGUGg8+GUmfkInUhJxxi8I68jckAA6pBnQbg6KN/whYCY
 4efGP9gfzEWlsuvPrsBIZlNF5O3TjtkinD7Q6b+MoPImoeGt3hT+1VoWWIZKwB/dGeB6
 DP13k8+WTMSS/+3v/wqkeKRzSAVA/CvGcGvBowVF7gxeOSx13bgAqMOrpWxV+PwHvtIB
 g8pA==
X-Gm-Message-State: AOJu0Yy1VirwhoHZdO3NUKrfgqq11cvGsWthX9OenKN1ItmEf3mqNJMj
 FLfRNybo3lBk2qPXrHj19YbA2KVqOP1G9228cLUNKnSjbue5EbDCSBavR5xMWqJIt8EZHp6KGBA
 xwftla5MnAoxP/ENYpk43YcrB+VlvdyvmP2ZSzADBtX7DzmN0xajVQpWw
X-Gm-Gg: ASbGncspXMIBuSb837wTZ+TddvP9i0x5cC6npcHrszgiWDPPPKt6dIsNR/6DU5qCDzb
 jz6oWsSXa0TIfj9FSDM3mtpjAgpeDAzI6FJfyJd6eWZQfsr2zuP0EtNeoxQ+kddls06K+IE4yp/
 z/bEXjdUO9l7VQjWdnOR7OoFnvkruKuwTHbL0lhKCzL1M58B3CHgE0zm+KoBUiEhi+g7uG1tEtM
 LwlmFFU2DNPAJDYoZC1CETtiDG+TXmLoxbSJUo7AtxuCD8Z+RE3q9lllB9617Tto0+dOPf3evQZ
 0EOun9DZaNFD4H/oEGisYsDeWZufZ2bfLG1Y+/T0xqg=
X-Received: by 2002:a17:907:9487:b0:adb:449c:7621 with SMTP id
 a640c23a62f3a-ade1a9229aamr323663666b.29.1749215430756; 
 Fri, 06 Jun 2025 06:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFYwgEPiyQz1YL2KluMI6HD89vautkmUz1mTtkd5NFbmPeUPSXGlZIMvQkfvgtWbtaAs1dVA==
X-Received: by 2002:a17:907:9487:b0:adb:449c:7621 with SMTP id
 a640c23a62f3a-ade1a9229aamr323658766b.29.1749215430237; 
 Fri, 06 Jun 2025 06:10:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc1c788sm114939266b.101.2025.06.06.06.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:10:29 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:10:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/18] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_INIT_LNKCTL definition
Message-ID: <20250606151027.068b5106@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-10-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-10-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Thu,  1 May 2025 23:04:47 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> VIRTIO_PCI_FLAG_INIT_LNKCTL was only used by the hw_compat_2_8[]
> array, via the 'x-pcie-lnkctl-init=3Doff' property. We removed all
> machines using that array, lets remove all the code around
> VIRTIO_PCI_FLAG_INIT_LNKCTL (see commit 9a4c0e220d8 for similar
> VIRTIO_PCI_FLAG_* enum removal).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/virtio/virtio-pci.h | 4 ----
>  hw/virtio/virtio-pci.c         | 8 ++------
>  2 files changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pc=
i.h
> index ed142932f7b..a8dd613ffbc 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -34,7 +34,6 @@ enum {
>      VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
>      VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
>      VIRTIO_PCI_FLAG_ATS_BIT,
> -    VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
>      VIRTIO_PCI_FLAG_INIT_PM_BIT,
>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
>      VIRTIO_PCI_FLAG_AER_BIT,
> @@ -61,9 +60,6 @@ enum {
>  /* address space translation service */
>  #define VIRTIO_PCI_FLAG_ATS (1 << VIRTIO_PCI_FLAG_ATS_BIT)
> =20
> -/* Init Link Control register */
> -#define VIRTIO_PCI_FLAG_INIT_LNKCTL (1 << VIRTIO_PCI_FLAG_INIT_LNKCTL_BI=
T)
> -
>  /* Init Power Management */
>  #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
> =20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 0075ae590db..5b86a9a447c 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2218,10 +2218,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev,=
 Error **errp)
>          /* Init error enabling flags */
>          pcie_cap_deverr_init(pci_dev);
> =20
> -        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_LNKCTL) {
> -            /* Init Link Control Register */
> -            pcie_cap_lnkctl_init(pci_dev);
> -        }
> +        /* Init Link Control Register */
> +        pcie_cap_lnkctl_init(pci_dev);
> =20
>          if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
>              pci_set_word(pci_dev->config + pos + PCI_PM_CTRL,
> @@ -2347,8 +2345,6 @@ static const Property virtio_pci_properties[] =3D {
>                      VIRTIO_PCI_FLAG_ATS_BIT, false),
>      DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT, true),
> -    DEFINE_PROP_BIT("x-pcie-lnkctl-init", VirtIOPCIProxy, flags,
> -                    VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,


