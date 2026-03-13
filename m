Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB53106FD9A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0xPl-000244-98; Fri, 13 Mar 2026 03:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0xPh-00023E-OO; Fri, 13 Mar 2026 03:58:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0xPe-00029V-OZ; Fri, 13 Mar 2026 03:58:29 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62D7w7Wi033762
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 13 Mar 2026 16:58:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=clvHLri9i4/PXAR1Pz83oNxTrf3g34wTxEa9Rx8Cy0s=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1773388687; v=1;
 b=YGuzvZKlSf7w6i1O5X3naf7+mjZCkcK2RCbIzTKL6x7UzNTZLG61wXs5/i617L3+
 XPtn70Rlil6Xx2WTFiZB3wP1aFn4B9ZA3VD55JmxMQ1dfWZY7G2CitY/lGMW9n0y
 dcYaO6RaOV6hiicCeBUIykI3gkpfK7IUg7JBO/DWh8QKdi30193Gm9/4NJaRyySr
 BN7uSr4mjv+dm0w+V06qQX1g1T3XjWvf44wccJwKnJ/Pu2Zg2KMTyp+mIhDUoyUX
 UAdNnRbf78J5xs6VLYr0cQdwm2DqW4SITPNKVjLB6WVy1yL0WbbZqjtXrD33tggF
 KQm2vnR9/jYHi1XJ6yON6g==
Message-ID: <8da7fa1c-0f4d-4952-b9d9-fe8d2f36ce25@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 13 Mar 2026 16:58:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] hw/pci/msix: fix error handling for msix_init
 callers
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hannes Reinecke <hare@suse.com>,
 "open list:megasas" <qemu-block@nongnu.org>
References: <20260311183432.214960-1-viking4@gmail.com>
 <20260311183432.214960-5-viking4@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260311183432.214960-5-viking4@gmail.com>
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

On 2026/03/12 3:34, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> Check return value of msix_init() and return early on
> failure instead of continuing with invalid state.
> - Use ret < 0 to handle negative return value.
> - Use errp parameter to handle failure instead of NULL.
> - No functional changes.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> 
> ---
> v2:
> - Use errp parameter to handle failure instead of NULL.
> ---
>   hw/net/igbvf.c         |  2 +-
>   hw/net/rocker/rocker.c |  2 +-
>   hw/pci/msix.c          |  2 +-
>   hw/scsi/megasas.c      | 18 +++++++++++++-----
>   hw/usb/hcd-xhci-pci.c  | 19 ++++++++++++++-----
>   5 files changed, 30 insertions(+), 13 deletions(-)
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
> index f62e420a91..b237ba7656 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -2380,11 +2380,19 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
>       memory_region_init_io(&s->queue_io, OBJECT(s), &megasas_queue_ops, s,
>                             "megasas-queue", 0x40000);
>   
> -    if (megasas_use_msix(s) &&
> -        msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
> -                  &s->mmio_io, b->mmio_bar, 0x3800, 0x68, NULL)) {
> -        /* TODO: check msix_init's error, and should fail on msix=on */
> -        s->msix = ON_OFF_AUTO_OFF;
> +    if (megasas_use_msix(s)) {
> +        Error *local_err = NULL;
> +        ret = msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
> +                        &s->mmio_io, b->mmio_bar, 0x3800, 0x68, &local_err);
> +
> +        if (ret < 0) {
> +            if (s->msix == ON_OFF_AUTO_ON) {
> +                error_propagate(errp, local_err);

error_propagate() is discouraged in include/qapi/error.h because 
ERRP_GUARD() exists as an alternative so I thought of using it, but 
perhaps it may be a better to avoid having a local error variable 
altogether.

Instead, you can pass (s->msix == ON_OF_AUTO_ON ? errp : NULL) to 
msix_init() as the errp parameter.

Regards,
Akihiko Odaki

> +                return;
> +            }
> +            error_free(local_err);
> +            s->msix = ON_OFF_AUTO_OFF;
> +        }
>       }
>   
>       if (pci_is_express(dev)) {
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index aa570506fc..3bdde9b64a 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -173,11 +173,20 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
>       }
>   
>       if (s->msix != ON_OFF_AUTO_OFF) {
> -        /* TODO check for errors, and should fail when msix=on */
> -        msix_init(dev, s->xhci.numintrs,
> -                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
> -                  &s->xhci.mem, 0, OFF_MSIX_PBA,
> -                  0x90, NULL);
> +        Error *local_err = NULL;
> +        ret = msix_init(dev, s->xhci.numintrs,
> +                        &s->xhci.mem, 0, OFF_MSIX_TABLE,
> +                        &s->xhci.mem, 0, OFF_MSIX_PBA,
> +                        0x90, &local_err);
> +
> +        if (ret < 0) {
> +            if (s->msix == ON_OFF_AUTO_ON) {
> +                error_propagate(errp, local_err);
> +                return;
> +            }
> +            error_free(local_err);
> +            s->msix = ON_OFF_AUTO_OFF;
> +        }
>       }
>       s->xhci.as = pci_get_address_space(dev);
>   }


