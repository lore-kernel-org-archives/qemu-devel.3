Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23335C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWrd-0002dT-Hl; Fri, 06 Jun 2025 09:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNWrb-0002cq-PB
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNWrZ-0001jx-Oc
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749215520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ipZKrYvg61hbI+PbEz/iG6UuFlyxZocCPB968tsHvLk=;
 b=hVCswU9Shno+GDWandi7q+3DCgqcT5H3HJlBPt13m7mZjiEoKya8zlSemIzwuKVJV1KBcX
 cRE/NDEwKJzWgUv5E6oEBQEhHzFnqXIvp1kZ8f+6UVk10RvaeVy0ijcj9CDDsvwsH3rqzn
 0W3gKr+LE1zHA7lsW3qg1IPqkCILvdk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-miLbfRtvNnmgM3ZEiBnMDA-1; Fri, 06 Jun 2025 09:11:58 -0400
X-MC-Unique: miLbfRtvNnmgM3ZEiBnMDA-1
X-Mimecast-MFC-AGG-ID: miLbfRtvNnmgM3ZEiBnMDA_1749215518
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eee2398bso1054706f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749215518; x=1749820318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ipZKrYvg61hbI+PbEz/iG6UuFlyxZocCPB968tsHvLk=;
 b=g6XeBDs/ERXgtXjXt5f+wyAXf6nwuTWpyYkU3E0Cfg9ntbAT8NIS+QRuNWf9yOoRVc
 kC/sIEHMjiQmOGLN/yWwLY+PUmsFDNQWDTqdJHx/TA+7NUjufteFHLejBStCRNW1wmLC
 Dc38ZYNsJ1sNq/4ImXFCh3g3+MLeuU0EZUQmYjasA/ZSbNWyM4nMPsaT/tLhr6R25p9y
 a6t5dOjjgROjlIrj1EOMdX9w28FX2x2WTJCjDuA0cXt5+yIqaiy2+EoApP7iU4LTta9+
 +uR+nbat93x8TdcoFSh15jqXB5MM1OyRzx0DUw3KRZK37oLFY/co/6witPg/deZWn9/I
 GaAw==
X-Gm-Message-State: AOJu0YwU2570JxEmrUJUSY97PxA2rkO7Tk8cFw+nVbUrTLeI7vstUldI
 LNDQxWZm0NCLX15ioRHMKujGW6BWqJ+JbNyWIGoK4Tv7qIrh9bPO07G15H+U9F40x8ffpAKBExH
 9wZY5eWGo41Adkj4FIlR3K4klORsKacQE+P3ItTBHcZsBUJRjrDSkHU4J
X-Gm-Gg: ASbGncsUAUw42baBZld1btmMvCqszSbkUXnYx25+S0ZUY1u0pithL+fT2im/BSU3Wn6
 GzbOQAWct2xeMQIsmJtqub8qQIL6lxzAkso4jwEayAdZD4Q1W4Zw+EjYQDqOk/HyQqlnsMs2Drl
 BNFe4jTFgRn5EMV0MXFIAYtuR+DtMrwo0frIGzifvL92/HfJ9zN28rfUK27jynYcMlnRu8QBAcu
 +O3l0xgqR3WZO2LqMeypztf6pj9reEMMshKEqphUYAlxnuS/I37J+z2KX2vK2OdxtqRoP2QKDDS
 Egqg60qoY7+Al+bc4okSpvCQsR/EqGQhwqjy07pF4i8=
X-Received: by 2002:a05:6000:288c:b0:3a4:d0dc:184d with SMTP id
 ffacd0b85a97d-3a5318a7872mr2924008f8f.27.1749215517642; 
 Fri, 06 Jun 2025 06:11:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVacDBkQOMlfhxnG7tlSk4TN7bBVpTucuqUgsn21Hn2v18k/Tk29sM5ZtX8yZNINL/AJSyQw==
X-Received: by 2002:a05:6000:288c:b0:3a4:d0dc:184d with SMTP id
 ffacd0b85a97d-3a5318a7872mr2923966f8f.27.1749215517179; 
 Fri, 06 Jun 2025 06:11:57 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532464e7fsm1837098f8f.96.2025.06.06.06.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:11:56 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:11:54 +0200
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
Subject: Re: [PATCH 10/18] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_INIT_PM definition
Message-ID: <20250606151154.57d0f4ab@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-11-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-11-philmd@linaro.org>
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

On Thu,  1 May 2025 23:04:48 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> VIRTIO_PCI_FLAG_INIT_PM was only used by the hw_compat_2_8[]
> array, via the 'x-pcie-pm-init=3Doff' property. We removed all
> machines using that array, lets remove all the code around
> VIRTIO_PCI_FLAG_INIT_PM (see commit 9a4c0e220d8 for similar
> VIRTIO_PCI_FLAG_* enum removal).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/virtio/virtio-pci.h |  4 ----
>  hw/virtio/virtio-pci.c         | 19 +++++--------------
>  2 files changed, 5 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pc=
i.h
> index a8dd613ffbc..d1f7403cbdf 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -34,7 +34,6 @@ enum {
>      VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
>      VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
>      VIRTIO_PCI_FLAG_ATS_BIT,
> -    VIRTIO_PCI_FLAG_INIT_PM_BIT,
>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
>      VIRTIO_PCI_FLAG_AER_BIT,
>      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> @@ -60,9 +59,6 @@ enum {
>  /* address space translation service */
>  #define VIRTIO_PCI_FLAG_ATS (1 << VIRTIO_PCI_FLAG_ATS_BIT)
> =20
> -/* Init Power Management */
> -#define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
> -
>  /* Init The No_Soft_Reset bit of Power Management */
>  #define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
>    (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 5b86a9a447c..9ec92d5a736 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2226,11 +2226,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev,=
 Error **errp)
>                           PCI_PM_CTRL_NO_SOFT_RESET);
>          }
> =20
> -        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
> -            /* Init Power Management Control Register */
> -            pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
> -                         PCI_PM_CTRL_STATE_MASK);
> -        }
> +        /* Init Power Management Control Register */
> +        pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
> +                     PCI_PM_CTRL_STATE_MASK);
> =20
>          if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
>              pcie_ats_init(pci_dev, last_pcie_cap_offset,
> @@ -2323,16 +2321,11 @@ static void virtio_pci_bus_reset_hold(Object *obj=
, ResetType type)
>      virtio_pci_reset(qdev);
> =20
>      if (pci_is_express(dev)) {
> -        VirtIOPCIProxy *proxy =3D VIRTIO_PCI(dev);
> -
>          pcie_cap_deverr_reset(dev);
>          pcie_cap_lnkctl_reset(dev);
> =20
> -        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
> -            pci_word_test_and_clear_mask(
> -                dev->config + dev->pm_cap + PCI_PM_CTRL,
> -                PCI_PM_CTRL_STATE_MASK);
> -        }
> +        pci_word_test_and_clear_mask(dev->config + dev->pm_cap + PCI_PM_=
CTRL,
> +                                     PCI_PM_CTRL_STATE_MASK);
>      }
>  }
> =20
> @@ -2345,8 +2338,6 @@ static const Property virtio_pci_properties[] =3D {
>                      VIRTIO_PCI_FLAG_ATS_BIT, false),
>      DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT, true),
> -    DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> -                    VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,


