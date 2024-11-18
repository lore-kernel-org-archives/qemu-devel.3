Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424D0D10F5B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 16:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD4Fw-0003oO-2P; Mon, 18 Nov 2024 11:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tD4Fq-0003o6-Dp
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:05:34 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tD4Fn-0000fw-EW
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date;
 bh=hOPsZNwuk5Of7mPpSe/MIV1efYXeimkHvzOur3w1rP4=; b=OQiXcgEPsvbrw034DEWEss4y7z
 PawOfKRjrWzYq6BaK+BXlU+cGyDwlKKR1CVR9AtldNz1qsLTncbQCyiZX/De9bEQlExXt9YXDW33V
 bOh386Z1BUnzZvOH6aEKLY1T4V9dhWVuF7NMfclqt3MZNvD+5hbN8DNyuwdjrZSUgS8s=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tD4Fe-00BId7-02;
 Mon, 18 Nov 2024 16:05:22 +0000
Received: from lfbn-gre-1-248-145.w90-112.abo.wanadoo.fr ([90.112.205.145]
 helo=l14) by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tD4Fd-00FG94-2H;
 Mon, 18 Nov 2024 16:05:21 +0000
Date: Mon, 18 Nov 2024 17:05:18 +0100
From: Anthony PERARD <anthony@xenproject.org>
To: Jiqian Chen <Jiqian.Chen@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 Stewart Hildebrand <stewart.hildebrand@amd.com>,
 Huang Rui <ray.huang@amd.com>
Subject: Re: [QEMU PATCH v10] xen/passthrough: use gsi to map pirq when dom0
 is PVH
Message-ID: <Zztlvl0m-Oi2XGXq@l14>
References: <20241106061418.3655304-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106061418.3655304-1-Jiqian.Chen@amd.com>
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 06, 2024 at 02:14:18PM +0800, Jiqian Chen wrote:
> In PVH dom0, when passthrough a device to domU, QEMU code
> xen_pt_realize->xc_physdev_map_pirq wants to use gsi, but in current codes
> the gsi number is got from file /sys/bus/pci/devices/<sbdf>/irq, that is
> wrong, because irq is not equal with gsi, they are in different spaces, so
> pirq mapping fails.
> 
> To solve above problem, use new interface of Xen, xc_pcidev_get_gsi to get
> gsi and use xc_physdev_map_pirq_gsi to map pirq when dom0 is PVH.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

Acked-by: Anthony PERARD <anthony@xenproject.org>

But, this following change probably needs an ack from PCI maintaners,
CCed.

> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index eb26cac81098..07805aa8a5f3 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -23,6 +23,10 @@ extern bool pci_available;
>  #define PCI_SLOT_MAX            32
>  #define PCI_FUNC_MAX            8
>  
> +#define PCI_SBDF(seg, bus, dev, func) \
> +            ((((uint32_t)(seg)) << 16) | \
> +            (PCI_BUILD_BDF(bus, PCI_DEVFN(dev, func))))
> +
>  /* Class, Vendor and Device IDs from Linux's pci_ids.h */
>  #include "hw/pci/pci_ids.h"

Thanks,

-- 
Anthony PERARD

