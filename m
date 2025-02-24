Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2102BC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdMa-0001te-Gx; Mon, 24 Feb 2025 13:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmdKR-00085G-Cj
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:37:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmdKO-0005i7-Is
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740422230;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bus5ZjkZ0Q1fqVEcvqpc0Gzr+5y9nonsf/lTcfPLqzc=;
 b=Ci67Vd+/v4zzt7noNobLqDFEF7ViLkI9T8NJlCBHmW6qSR1uHCc5g5aNrkFjdxzlMpCBT4
 VWlceryusl0RA+C1gwb02g9cdVqD32m2uYSHRwiqwKJXv7oTohRNrDp1w22CK4K2r0ClxU
 nPqi5d4PHMJfjASKZwM7PbUUsGTl8M4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-RJLrU0oAPviI4MQCHJrP4g-1; Mon, 24 Feb 2025 13:37:08 -0500
X-MC-Unique: RJLrU0oAPviI4MQCHJrP4g-1
X-Mimecast-MFC-AGG-ID: RJLrU0oAPviI4MQCHJrP4g_1740422227
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43aafafe6b7so3850105e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740422227; x=1741027027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bus5ZjkZ0Q1fqVEcvqpc0Gzr+5y9nonsf/lTcfPLqzc=;
 b=PMiP2n35R/MU7+JpJbZ++HVdicQ86tsxj4/Duza9n+MQdEVgjyroPWZ0hgqKE8SaMd
 0XM/9T46Kh70tzg2gmJq3O3NgBekphwuuCu7O8sV5Njl8o7mgmGZ4Vk9gi9U077PAWDt
 5l21H6RCUgGx6UroltCpKY4kJSgfJnCgx+HGhtFxxMJX6ZrrhncN+iaCIIralF6cQMtb
 ZmGNMawH3RNbyjIoBlP5fCH3Ow95gN4nKEb6IPt9mhuyQr1Tm/PXq415Ve/0uJjuO+Le
 SIg33xU/rvzM+1R0RbSU0YWRrNtKP4wdcxDfQqQP0N0nynhC7SV2v+lMzv6FuhWSuDUn
 A7Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhB0IsSk793Tu7jLqtDzJcq2s9DAyNLelFBuZZRt5HQWD/Ukb/sI27VAjfFjGXKQ1oFvcpTGXgARGJ@nongnu.org
X-Gm-Message-State: AOJu0YzT3E6w4VC3SZxfYfBtOfLRi5HHDyRKDB8BlCbN0YXD9APdQ5kx
 +a1ClJqsVQxHsTN9aVsHIBY3210Hf53S3Ia7I4x2XIq2pf40bXa5r4IrGahPOoSfmv7Hc0ixmw0
 Xztsj7wwLxI0kYREbbeE8Xs+yOJTY8+trbuHXe6ihEprYhPynu6ss
X-Gm-Gg: ASbGncuB+upAK0FUb3zY4NJdIm6OTo6FvmtYSkLeKYhu/DeCJyF7cWMAS7A8wAC23Eu
 55vKo79cdmWeJ6vGH+e1/o2ZYy4xv0P03462gI+OtenJQvheWqcHJ5oXavKLYP2JT9UFrrKk4O6
 l9Zb7aEOuMU5qcG72l/j95KZykdTw+rdBJAssMbpdebSumTgpr2XOuNC8yilOGslS5/w4sjBRW6
 86jMNOtzWHL54nw//N0vRiih67gcOpPXKAMKTCJP0zHi6uHJ06McBEQ1DnKRxYPXeYLNl4Am7QV
 cA6gfPzVeQPh4uveJtbGwi7v56oC5Po7nb0EiXqksZQjy6h9jbaGQxqn63OlXVw=
X-Received: by 2002:a5d:6daa:0:b0:38a:87cc:fb42 with SMTP id
 ffacd0b85a97d-38f6e95d5famr12386782f8f.21.1740422227477; 
 Mon, 24 Feb 2025 10:37:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpujlNRfU4TY3mhPF0XkK8PyGOsh/x2KKK/1KevjqqJl/cT2P5ENG6Y+G+/FUHG4XiByvSxg==
X-Received: by 2002:a5d:6daa:0:b0:38a:87cc:fb42 with SMTP id
 ffacd0b85a97d-38f6e95d5famr12386754f8f.21.1740422227114; 
 Mon, 24 Feb 2025 10:37:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02e486csm113012195e9.18.2025.02.24.10.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 10:37:06 -0800 (PST)
Message-ID: <5604e46b-da22-46df-9d6e-2a163df62881@redhat.com>
Date: Mon, 24 Feb 2025 19:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pci: Use PCI PM capability initializer
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
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220224918.2520417-3-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250220224918.2520417-3-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Alex,

On 2/20/25 11:48 PM, Alex Williamson wrote:
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
> ---
>  hw/net/e1000e.c                 | 3 +--
>  hw/net/eepro100.c               | 4 +---
>  hw/net/igb.c                    | 3 +--
>  hw/nvme/ctrl.c                  | 3 +--
>  hw/pci-bridge/pcie_pci_bridge.c | 2 +-
>  hw/vfio/pci.c                   | 2 +-
>  hw/virtio/virtio-pci.c          | 3 +--
>  7 files changed, 7 insertions(+), 13 deletions(-)
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
nit: below there is a redundant
    pci_set_word(pci_dev->wmask + offset + PCI_PM_CTRL,
                 PCI_PM_CTRL_STATE_MASK);

Thanks

Eric
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
> index 89d900e9cf0c..6903f831e45f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2216,7 +2216,7 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>      case PCI_CAP_ID_PM:
>          vfio_check_pm_reset(vdev, pos);
>          vdev->pm_cap = pos;
> -        ret = pci_add_capability(pdev, cap_id, pos, size, errp) >= 0;
> +        ret = pci_pm_init(pdev, pos, errp) >= 0;
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


