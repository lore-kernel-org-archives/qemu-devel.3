Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDCCFCC9AA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 05:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0CWR-0000Ie-VL; Wed, 11 Mar 2026 01:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0CWG-0000G6-Ko; Wed, 11 Mar 2026 01:54:10 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0CWD-0003to-6v; Wed, 11 Mar 2026 01:54:08 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62B5qtTo062642
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 11 Mar 2026 14:53:52 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=PQFcEe0/RNX3rYFpLgcUbZvQDuEa9qtHB7KBvmS6Ouc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1773208432; v=1;
 b=S5lMkd5Zkjh9MYgczZAuAP0+FQr92c6TuBOZjCjPKQgezzCio49IaB7scy4YZZUn
 hPq6ZB+YMcvJuD7yrTkkPaymom8FvrpDyKvFC1RB9g1vy2eh7b1c7ia99GLrWRrG
 gMGYmy/EflQw+LcGHv8qZsGw3uuAHejK6+Hy2GuqS15TNhRk45txd7MHg9YRUTuF
 YU+KIOVpeA9Y7zTBS1+3ivcg+ccIpn/HsFx6G6GSH2Yt+tB5O7HWVCQZKUCuqD4+
 ppAkePXDStBMBNFv9RAV+IgVmL+fzOLkj2jqUS3XVUtkZaYPx0DPs5yMkD14wf09
 R8boVXpa7BNW03QNcSLfhg==
Message-ID: <70d2e87e-6612-459d-afef-261a419f4aab@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 11 Mar 2026 14:52:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/pci/msix: fix error handling for msix_init callers
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org
References: <20260310182801.196443-1-viking4@gmail.com>
 <20260310182801.196443-5-viking4@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260310182801.196443-5-viking4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/11 3:28, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> Check return value of msix_init() and return early on
> failure instead of continuing with invalid state.
> - Use ret < 0 to handle negative return value.
> - No functional changes.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>   hw/net/igbvf.c         |  2 +-
>   hw/net/rocker/rocker.c |  2 +-
>   hw/pci/msix.c          |  2 +-
>   hw/scsi/megasas.c      | 16 +++++++++++-----
>   hw/usb/hcd-xhci-pci.c  | 17 ++++++++++++-----
>   5 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
> index 48d56e43ac..9a165c7063 100644
> --- a/hw/net/igbvf.c
> +++ b/hw/net/igbvf.c
> @@ -260,7 +260,7 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
>   
>       ret = msix_init(dev, IGBVF_MSIX_VEC_NUM, &s->msix, IGBVF_MSIX_BAR_IDX, 0,
>           &s->msix, IGBVF_MSIX_BAR_IDX, 0x2000, 0x70, errp);
> -    if (ret) {
> +    if (ret < 0) {
>           return;
>       }
>   
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 4a7056bd45..910dce901b 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -1228,7 +1228,7 @@ static int rocker_msix_init(Rocker *r, Error **errp)
>                       &r->msix_bar,
>                       ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFSET,
>                       0, errp);
> -    if (err) {
> +    if (err < 0) {
>           return err;
>       }
>   
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index b35476d057..1b23eaf100 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -432,7 +432,7 @@ int msix_init_exclusive_bar(PCIDevice *dev, uint32_t nentries,
>                       0, &dev->msix_exclusive_bar,
>                       bar_nr, bar_pba_offset,
>                       0, errp);
> -    if (ret) {
> +    if (ret < 0) {
>           return ret;
>       }
>   
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index f62e420a91..90d397374e 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -2380,11 +2380,17 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
>       memory_region_init_io(&s->queue_io, OBJECT(s), &megasas_queue_ops, s,
>                             "megasas-queue", 0x40000);
>   
> -    if (megasas_use_msix(s) &&
> -        msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
> -                  &s->mmio_io, b->mmio_bar, 0x3800, 0x68, NULL)) {
> -        /* TODO: check msix_init's error, and should fail on msix=on */
> -        s->msix = ON_OFF_AUTO_OFF;
> +    if (megasas_use_msix(s)) {
> +        ret = msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
> +                        &s->mmio_io, b->mmio_bar, 0x3800, 0x68, NULL);
> +
> +        if (ret < 0) {
> +            if (s->msix == ON_OFF_AUTO_ON) {
> +                error_setg(errp, "MSI-X initialization failed");

msix_init() has the errp parameter so let's use it.

Regards,
Akihiko Odaki

> +                return;
> +            }
> +            s->msix = ON_OFF_AUTO_OFF;
> +        }
>       }
>   
>       if (pci_is_express(dev)) {
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index aa570506fc..7bd4425b34 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -173,11 +173,18 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
>       }
>   
>       if (s->msix != ON_OFF_AUTO_OFF) {
> -        /* TODO check for errors, and should fail when msix=on */
> -        msix_init(dev, s->xhci.numintrs,
> -                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
> -                  &s->xhci.mem, 0, OFF_MSIX_PBA,
> -                  0x90, NULL);
> +        ret = msix_init(dev, s->xhci.numintrs,
> +                        &s->xhci.mem, 0, OFF_MSIX_TABLE,
> +                        &s->xhci.mem, 0, OFF_MSIX_PBA,
> +                        0x90, NULL);
> +
> +        if (ret < 0) {
> +            if (s->msix == ON_OFF_AUTO_ON) {
> +                error_setg(errp, "MSI-X initialization failed");
> +                return;
> +            }
> +            s->msix = ON_OFF_AUTO_OFF;
> +        }
>       }
>       s->xhci.as = pci_get_address_space(dev);
>   }


