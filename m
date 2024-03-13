Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DE4C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkThI-0002dR-5G; Wed, 13 Mar 2024 14:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rkTh6-0002MA-6C
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:51:17 -0400
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rkTh2-0004Kk-BP
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1710355869; bh=nRJf/N6o8fgUC/Zd5i/fkKonSZ0sW0Nl3K1SCe8whvg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vx+KoI9rfmlA/v1yqjiBz22iCoGOO/gziMPLUVqyoCuNsCLaqZICi/oGJF4qQvF2c
 9PFAuGxlOTHjpe6oGiIRSSY34SEoFNPFxRtC8PW1xyPmDJA9G5pt3go8vgflAhUAEy
 viDp4qJkG6PqyKe5TnDBoa1k00D1KycGmmzw0Z34=
Date: Wed, 13 Mar 2024 19:51:08 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Hao Chen <chenh@yusur.tech>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com, 
 cohuck@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH] hw/virtio: Add support for VDPA network simulation devices
Message-ID: <d9e4f3b4-9c2e-466c-b5f4-3387ce88c6b9@t-8ch.de>
References: <20240221073802.2888022-1-chenh@yusur.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221073802.2888022-1-chenh@yusur.tech>
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024-02-21 15:38:02+0800, Hao Chen wrote:
> This patch adds support for VDPA network simulation devices.
> The device is developed based on virtio-net and tap backend,
> and supports hardware live migration function.
> 
> For more details, please refer to "docs/system/devices/vdpa-net.rst"
> 
> Signed-off-by: Hao Chen <chenh@yusur.tech>
> ---
>  MAINTAINERS                                 |   5 +
>  docs/system/device-emulation.rst            |   1 +
>  docs/system/devices/vdpa-net.rst            | 121 +++++++++++++
>  hw/net/virtio-net.c                         |  16 ++
>  hw/virtio/virtio-pci.c                      | 189 +++++++++++++++++++-
>  hw/virtio/virtio.c                          |  39 ++++
>  include/hw/virtio/virtio-pci.h              |   5 +
>  include/hw/virtio/virtio.h                  |  19 ++
>  include/standard-headers/linux/virtio_pci.h |   7 +
>  9 files changed, 399 insertions(+), 3 deletions(-)
>  create mode 100644 docs/system/devices/vdpa-net.rst

[..]

> diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
> index b7fdfd0668..fb5391cef6 100644
> --- a/include/standard-headers/linux/virtio_pci.h
> +++ b/include/standard-headers/linux/virtio_pci.h
> @@ -216,6 +216,13 @@ struct virtio_pci_cfg_cap {
>  #define VIRTIO_PCI_COMMON_Q_NDATA	56
>  #define VIRTIO_PCI_COMMON_Q_RESET	58
>  
> +#define LM_LOGGING_CTRL                 0
> +#define LM_BASE_ADDR_LOW                4
> +#define LM_BASE_ADDR_HIGH               8
> +#define LM_END_ADDR_LOW                 12
> +#define LM_END_ADDR_HIGH                16
> +#define LM_VRING_STATE_OFFSET           0x20

These changes are not in upstream Linux and will be undone by
./scripts/update-linux-headers.sh.

Are they intentionally in this header?

> +
>  #endif /* VIRTIO_PCI_NO_MODERN */
>  
>  #endif

