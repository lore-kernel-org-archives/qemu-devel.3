Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85295C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWn1-00015S-GF; Fri, 06 Jun 2025 09:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNWmz-00014k-53
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNWmw-0000yU-SP
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749215231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0B6K9hNU2Icp10I9fr0xrv+zJyN++7GTrQqa+iV8hK8=;
 b=gBi8tvcUgHk/DwTMdwjAllCqkJgarH7BWFYeEjcuM9Lw4sbQzoWZvYQ4A2Q+k87D9syFFD
 ovljssDlQw2/cryWhL+APRRg5Wz4uUHhOxlhAcwq0mQPDhVKi7KlEDDeGKGhAsSp82cYiP
 hgmFRSuaxyB955p1JmMrMso5AOVNLa4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-f2ukzJTANg206Pr08uXvCw-1; Fri, 06 Jun 2025 09:07:10 -0400
X-MC-Unique: f2ukzJTANg206Pr08uXvCw-1
X-Mimecast-MFC-AGG-ID: f2ukzJTANg206Pr08uXvCw_1749215229
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so10564055e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749215229; x=1749820029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0B6K9hNU2Icp10I9fr0xrv+zJyN++7GTrQqa+iV8hK8=;
 b=oGmu08b+LyW0mf4HXBouNnzPwQjpXhzLaHYKml5hO9LhukBBcK3kjMlBVNpTPnL8Qv
 XkmXwsUmGNENRZRQcUAKoJn+zYJsYVJFnlrnnSuLlS5k47RlkwToOjP9kmT8zqxrm2jE
 FzRUCC9cWmwG5d2ySGaC0bbxDJkYKZrjNNjUonIMaTPXk7usdxv0+K8svs5Tjl4u1nFO
 H3ykvZa5fJYNXOGuUJhnFGeT+myOKaj8Bm38nfa6aGLD2uOOIRRpi8oOgUE1N23x3yt4
 LgIg9R6MD8E1jq5TBiZyxnIFfWUKh+n7nnMGJ7FUVXoUM0Utzyscq/BK0adx/IYOGSDB
 0g1g==
X-Gm-Message-State: AOJu0YxaOoa0GF6voNgJFG8vqJO3G+gJO94mwqVmYDQP3z/PHoyw70wl
 EXIeOQjm3uYK2WHWW1PBzcWpikJzlbp3Fm7pSCKLeLc6FZvanHR2e6nzrG/uyECig9XV939uF/g
 gZ2Vbt+UAhsRhJjPb+xQKZPVXVXIQ1LXwmJG6AmNMEUsWoEuSdc+FzzCo
X-Gm-Gg: ASbGnctEQiQQ1P/iVI52ODRc1xSIkCeznFzt64YWJhGWhSfRbpvBO+q9+Ka/s+I+zA/
 vBoG4GRjyQED5wGl7PefZjwkgsZ+CLWow65vr62uOjdh3N9KxJW3hY6Y3DAQWaxsEHZh5XEEqkx
 uBMENnwvTbn5FemAPmCisEcHzXxQrFvMLOU74mIBa3FdUf87PatquVZE79fZDpQfpIxjUHG++7u
 pHHI1Di6WkT2JRtQnDVntkgMOYlh8uYHme3eVFYSdsRFXomjrrD+VEJ+4eQh4MCSiHSygHJL4n4
 bJ9jozcReITZT7OVRh9sqqqaRofll+mq
X-Received: by 2002:a05:600c:1c8b:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4520128d3e8mr39266985e9.0.1749215228850; 
 Fri, 06 Jun 2025 06:07:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgPYkq6KthUDhm1Qj3oH/VHGxkKMjEb8V0lYVCA9C3ZiBmnJxMwiCDXTJTlB0G5ww67wRxjQ==
X-Received: by 2002:a05:600c:1c8b:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4520128d3e8mr39266345e9.0.1749215228292; 
 Fri, 06 Jun 2025 06:07:08 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532435fbfsm1857330f8f.64.2025.06.06.06.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:07:07 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:07:05 +0200
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
Subject: Re: [PATCH 08/18] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_INIT_DEVERR definition
Message-ID: <20250606150705.47f5c153@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-9-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-9-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Thu,  1 May 2025 23:04:46 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> VIRTIO_PCI_FLAG_INIT_DEVERR was only used by the hw_compat_2_8[]
> array, via the 'x-pcie-deverr-init=3Doff' property. We removed all
> machines using that array, lets remove all the code around
> VIRTIO_PCI_FLAG_INIT_DEVERR (see commit 9a4c0e220d8 for similar
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
> index 8abc5f8f20d..ed142932f7b 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -34,7 +34,6 @@ enum {
>      VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
>      VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
>      VIRTIO_PCI_FLAG_ATS_BIT,
> -    VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
>      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
>      VIRTIO_PCI_FLAG_INIT_PM_BIT,
>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> @@ -62,9 +61,6 @@ enum {
>  /* address space translation service */
>  #define VIRTIO_PCI_FLAG_ATS (1 << VIRTIO_PCI_FLAG_ATS_BIT)
> =20
> -/* Init error enabling flags */
> -#define VIRTIO_PCI_FLAG_INIT_DEVERR (1 << VIRTIO_PCI_FLAG_INIT_DEVERR_BI=
T)
> -
>  /* Init Link Control register */
>  #define VIRTIO_PCI_FLAG_INIT_LNKCTL (1 << VIRTIO_PCI_FLAG_INIT_LNKCTL_BI=
T)
> =20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 4e0d4bda6ed..0075ae590db 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2215,10 +2215,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev,=
 Error **errp)
>              last_pcie_cap_offset +=3D PCI_ERR_SIZEOF;
>          }
> =20
> -        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
> -            /* Init error enabling flags */
> -            pcie_cap_deverr_init(pci_dev);
> -        }
> +        /* Init error enabling flags */
> +        pcie_cap_deverr_init(pci_dev);
> =20
>          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_LNKCTL) {
>              /* Init Link Control Register */
> @@ -2349,8 +2347,6 @@ static const Property virtio_pci_properties[] =3D {
>                      VIRTIO_PCI_FLAG_ATS_BIT, false),
>      DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT, true),
> -    DEFINE_PROP_BIT("x-pcie-deverr-init", VirtIOPCIProxy, flags,
> -                    VIRTIO_PCI_FLAG_INIT_DEVERR_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-lnkctl-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,


