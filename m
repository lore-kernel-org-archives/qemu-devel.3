Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F032C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZ5P-00085H-7a; Thu, 27 Feb 2025 03:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tnZ4w-0007ut-Cs
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:17:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tnZ4t-0003Ff-HG
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740644226;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSduAAHRvh95X3lj1R7wHtURajRg+ao5CH/HcZhmkOo=;
 b=J7fjqOzAtRQwLgN5XUMUyuelKLLSlaC/7su7EoSdDv0FfRxst0bGIBrq+/rCbS/+CgFr3p
 mPw5+lr8HkNXXif5mS7X3MfKFvCjyVNBHuJ+iAXNRngd/MDtoTo0htKNz1AIQ4ZjsXsMzC
 6IQftLPg5PmDExBT5B92XoN09iUVp3Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-YHgbXLi3O4CW8Wc4jZwYbw-1; Thu, 27 Feb 2025 03:17:04 -0500
X-MC-Unique: YHgbXLi3O4CW8Wc4jZwYbw-1
X-Mimecast-MFC-AGG-ID: YHgbXLi3O4CW8Wc4jZwYbw_1740644224
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f338525e1so204610f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 00:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740644224; x=1741249024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSduAAHRvh95X3lj1R7wHtURajRg+ao5CH/HcZhmkOo=;
 b=IVBMxDSCNmvRI6bphMa4eYNcXSXhHnAsX5wXEh0Z8Qo8qG9b2rFk2WYPEcxl3OgJ6V
 any9sr7CRcV7+SEdXC3g8NiAeK9vkVAV1RcwrXhGfVY/WhsOTkys3k/dgh8alLRemxYM
 gt0cpjkqAZbzThuHji7ClJOIj0z139NGA7W+JPKnbFgnby/fTPNs8DlZ+xfUB66iCIxe
 bJW3uM9ZESyHksU4I8gCdCHiznPSjlirts4Mnz+OQ9TufvtNNCqwuGyIpZKYazN9clQZ
 venPeA4WiXcu8DMOy7LC9Bg+hMybcItlEKrHhdcX0Qkumxj7RNJ5qEveJstVaD/Mxwac
 ouZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPkvq3yQhDCrb9rxMhyI8Mkd529jxovwLFPEe5LDyNoqm3cibZWYQIKRIhiCEkOsSGFZ0UVUSntjEm@nongnu.org
X-Gm-Message-State: AOJu0YywJiN6c17RYMmsWDWuf1UKVzhL2zrGs3Z3lHQWd+7i/wf29SGv
 85p8bIEX/xM/TVn8f1/o6DmXTXWoDxKS4h+s1zvVEl9GR+vtrU+4wVROkDDXeYfLijeO4a1IpR8
 F9AiL8p8cUpyIMuf86i2iS2HfOBFxSjQbkvZrKquEFeB/N12UAblB
X-Gm-Gg: ASbGncvZZ7eT5ARRlcBNM2T0K2Xqr5RPmyYdZbX99PZJHH01DHtLl22WzumjGjP52HX
 C3XrwTb9s/4bSdU6hmKN880Ue8/6UYLQGNuPa2Ru2IV+DfF5tU6FrhyNhfDwnfRgbfVTRlOjJqV
 Pc288APedzvBc8YpYyjdnTGMA9c1Q8GccqVIfF3t/4YavSTsik+D+4iygen1WofvTqq90A7t5iF
 URNK0a553d56H5hYFKiTakEPyEu7Nn+HjcgRSrc71epBSQFnWfWtZTQBJaWetCC6+yR9jeDpN6c
 1qiJx4xfwsW7qVK/wvNaIvUWblxcv5sC9XAZFLp2wKJfAMyM3pBKkbmB7Jpzg9s=
X-Received: by 2002:a5d:64aa:0:b0:390:e889:d1cf with SMTP id
 ffacd0b85a97d-390e889d44amr322230f8f.37.1740644223664; 
 Thu, 27 Feb 2025 00:17:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7aTUM/NNSxj09oKi958dGsf8bEBCOOWHOqKSpUu5GyBifE26ACOLSEFo0XpXXTfh+b6w0UQ==
X-Received: by 2002:a5d:64aa:0:b0:390:e889:d1cf with SMTP id
 ffacd0b85a97d-390e889d44amr322197f8f.37.1740644223315; 
 Thu, 27 Feb 2025 00:17:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm1199639f8f.88.2025.02.27.00.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 00:17:02 -0800 (PST)
Message-ID: <9dde61e3-7f29-493f-ad2b-bb504d46ee67@redhat.com>
Date: Thu, 27 Feb 2025 09:17:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] pci: Use PCI PM capability initializer
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger.pro@gmail.com, clg@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
References: <20250225215237.3314011-1-alex.williamson@redhat.com>
 <20250225215237.3314011-3-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250225215237.3314011-3-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/25/25 10:52 PM, Alex Williamson wrote:
> Switch callers directly initializing the PCI PM capability with
> pci_add_capability() to use pci_pm_init().
>
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Stefan Weil <sw@weilnetz.de>
> Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Klaus Jensen <its@irrelevant.dk>
> Cc: Jesper Devantier <foss@defmacro.it>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/net/e1000e.c                 | 3 +--
>  hw/net/eepro100.c               | 4 +---
>  hw/net/igb.c                    | 3 +--
>  hw/nvme/ctrl.c                  | 3 +--
>  hw/pci-bridge/pcie_pci_bridge.c | 2 +-
>  hw/vfio/pci.c                   | 7 ++++++-
>  hw/virtio/virtio-pci.c          | 3 +--
>  7 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index f637853073e2..b72cbab7e889 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -372,8 +372,7 @@ static int
>  e1000e_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
>  {
>      Error *local_err = NULL;
> -    int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
> -                                 PCI_PM_SIZEOF, &local_err);
> +    int ret = pci_pm_init(pdev, offset, &local_err);
>  
>      if (local_err) {
>          error_report_err(local_err);
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index 6d853229aec2..29a39865a608 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -551,9 +551,7 @@ static void e100_pci_reset(EEPRO100State *s, Error **errp)
>      if (info->power_management) {
>          /* Power Management Capabilities */
>          int cfg_offset = 0xdc;
> -        int r = pci_add_capability(&s->dev, PCI_CAP_ID_PM,
> -                                   cfg_offset, PCI_PM_SIZEOF,
> -                                   errp);
> +        int r = pci_pm_init(&s->dev, cfg_offset, errp);
>          if (r < 0) {
>              return;
>          }
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index 4d93ce629f95..700dbc746d3d 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -356,8 +356,7 @@ static int
>  igb_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
>  {
>      Error *local_err = NULL;
> -    int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
> -                                 PCI_PM_SIZEOF, &local_err);
> +    int ret = pci_pm_init(pdev, offset, &local_err);
>  
>      if (local_err) {
>          error_report_err(local_err);
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 68903d1d7067..1faea3d2b85b 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8503,8 +8503,7 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
>      Error *err = NULL;
>      int ret;
>  
> -    ret = pci_add_capability(pci_dev, PCI_CAP_ID_PM, offset,
> -                             PCI_PM_SIZEOF, &err);
> +    ret = pci_pm_init(pci_dev, offset, &err);
>      if (err) {
>          error_report_err(err);
>          return ret;
> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
> index fd4514a595ce..9fa656b43b42 100644
> --- a/hw/pci-bridge/pcie_pci_bridge.c
> +++ b/hw/pci-bridge/pcie_pci_bridge.c
> @@ -52,7 +52,7 @@ static void pcie_pci_bridge_realize(PCIDevice *d, Error **errp)
>          goto cap_error;
>      }
>  
> -    pos = pci_add_capability(d, PCI_CAP_ID_PM, 0, PCI_PM_SIZEOF, errp);
> +    pos = pci_pm_init(d, 0, errp);
>      if (pos < 0) {
>          goto pm_error;
>      }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 89d900e9cf0c..1a4a0b4b15b4 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2216,7 +2216,12 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>      case PCI_CAP_ID_PM:
>          vfio_check_pm_reset(vdev, pos);
>          vdev->pm_cap = pos;
> -        ret = pci_add_capability(pdev, cap_id, pos, size, errp) >= 0;
> +        ret = pci_pm_init(pdev, pos, errp) >= 0;
> +        /*
> +         * PCI-core config space emulation needs write access to the power
> +         * state enabled for tracking BAR mapping relative to PM state.
> +         */
> +        pci_set_word(pdev->wmask + pos + PCI_PM_CTRL, PCI_PM_CTRL_STATE_MASK);
>          break;
>      case PCI_CAP_ID_AF:
>          vfio_check_af_flr(vdev, pos);
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c773a9130c7e..afe8b5551c5c 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2204,8 +2204,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>          pos = pcie_endpoint_cap_init(pci_dev, 0);
>          assert(pos > 0);
>  
> -        pos = pci_add_capability(pci_dev, PCI_CAP_ID_PM, 0,
> -                                 PCI_PM_SIZEOF, errp);
> +        pos = pci_pm_init(pci_dev, 0, errp);
>          if (pos < 0) {
>              return;
>          }


