Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD27BE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLlGf-0001cL-K3; Thu, 12 Dec 2024 10:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tLlGd-0001br-Rd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:38:19 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tLlGb-0002ZB-1E
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date;
 bh=d7loXoRdZ1igJ2wSUNEYwLh4PTsFsCd6B3/p+qYULSc=; b=bkByxIa/CoW+nko918KJQjFIPz
 DpLSy+OCroVMzwDEVBu3hhE3XRRmlqksMueSpOAONgq9QCP1dN/R5BayQr7DgqzvTKC83fBkPa1L8
 xkw9e5lqCPwHGPI/tCJ0q/YebUPfnkr/B+wUaal4L2XSq9JM47YCUEbwa4gAuC+m+Ogo=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tLlGS-00HDGM-0o;
 Thu, 12 Dec 2024 15:38:08 +0000
Received: from lfbn-gre-1-248-145.w90-112.abo.wanadoo.fr ([90.112.205.145]
 helo=l14) by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tLlGS-00HDu8-0f;
 Thu, 12 Dec 2024 15:38:08 +0000
Date: Thu, 12 Dec 2024 16:38:05 +0100
From: Anthony PERARD <anthony@xenproject.org>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [QEMU PATCH v10] xen/passthrough: use gsi to map pirq when dom0
 is PVH
Message-ID: <Z1sDXYATWad0Rbyf@l14>
References: <20241106061418.3655304-1-Jiqian.Chen@amd.com>
 <Zztlvl0m-Oi2XGXq@l14>
 <BL1PR12MB58491C9D1CCC1880C442AF73E73D2@BL1PR12MB5849.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB58491C9D1CCC1880C442AF73E73D2@BL1PR12MB5849.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Dec 10, 2024 at 07:17:30AM +0000, Chen, Jiqian wrote:
> On 2024/11/19 00:05, Anthony PERARD wrote:
> > On Wed, Nov 06, 2024 at 02:14:18PM +0800, Jiqian Chen wrote:
> >> In PVH dom0, when passthrough a device to domU, QEMU code
> >> xen_pt_realize->xc_physdev_map_pirq wants to use gsi, but in current codes
> >> the gsi number is got from file /sys/bus/pci/devices/<sbdf>/irq, that is
> >> wrong, because irq is not equal with gsi, they are in different spaces, so
> >> pirq mapping fails.
> >>
> >> To solve above problem, use new interface of Xen, xc_pcidev_get_gsi to get
> >> gsi and use xc_physdev_map_pirq_gsi to map pirq when dom0 is PVH.
> >>
> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >> Signed-off-by: Huang Rui <ray.huang@amd.com>
> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> > 
> > Acked-by: Anthony PERARD <anthony@xenproject.org>
> > 
> > But, this following change probably needs an ack from PCI maintaners,
> > CCed.
> As PCI maintainers didn't response for weeks,
> can I just move the definition of the macro back to xen_pt.c file ?

No, that's fine. I should be able to send a pull-request with this
change without too much trouble.

Cheers,

> >> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> >> index eb26cac81098..07805aa8a5f3 100644
> >> --- a/include/hw/pci/pci.h
> >> +++ b/include/hw/pci/pci.h
> >> @@ -23,6 +23,10 @@ extern bool pci_available;
> >>  #define PCI_SLOT_MAX            32
> >>  #define PCI_FUNC_MAX            8
> >>  
> >> +#define PCI_SBDF(seg, bus, dev, func) \
> >> +            ((((uint32_t)(seg)) << 16) | \
> >> +            (PCI_BUILD_BDF(bus, PCI_DEVFN(dev, func))))
> >> +
> >>  /* Class, Vendor and Device IDs from Linux's pci_ids.h */
> >>  #include "hw/pci/pci_ids.h"

-- 
Anthony PERARD

