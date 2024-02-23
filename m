Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24893C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 00:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdJOM-00029j-Bk; Thu, 22 Feb 2024 19:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rdJOJ-00028V-Qt
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 19:26:15 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rdJOI-0006FW-0c
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 19:26:15 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DFF2A6339A;
 Fri, 23 Feb 2024 00:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8412AC433C7;
 Fri, 23 Feb 2024 00:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708647964;
 bh=S6XLWwOlyw5kVkrghNQ9x3mICtxXeoGmEqulSxH1LPs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=L4qne9PBS9NG8ikgBrkpnxHesLLuFCKpMU/uxjIadOUGu1nxweNwNTc/UJb45QVoa
 0BEJoxj4wDUrYkMj+Qx1Q59exNDVRQjRdqz3GRn1TRAoTYoNG+Pfhkrl2e3DXNQiDr
 vVQQ79mADinRLkS9KcUGwcYC+pGU9pHnVekOAxi0J0AKo48CkovTiRq9wJFD54Ql5j
 UXkqENTUd5tazjvBpKSJNIWG67Ajs9+YCUl4o5CSNAUE2XQ4AwVO1SOYAZV97VT7zn
 VHfSefBNL1TzL+j9BXg/uWEYMu9pQ305dJlAmtkOiAwp3QngODZ/Aj76PXWWavhxWe
 AM8AfJk4jggeA==
Date: Thu, 22 Feb 2024 16:26:01 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jiqian Chen <Jiqian.Chen@amd.com>
cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org, Huang Rui <Ray.Huang@amd.com>, 
 Huang Rui <ray.huang@amd.com>
Subject: Re: [RFC QEMU PATCH v4 1/1] xen: Use gsi instead of irq for mapping
 pirq
In-Reply-To: <20240105071919.350397-2-Jiqian.Chen@amd.com>
Message-ID: <alpine.DEB.2.22.394.2402221625040.754277@ubuntu-linux-20-04-desktop>
References: <20240105071919.350397-1-Jiqian.Chen@amd.com>
 <20240105071919.350397-2-Jiqian.Chen@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 5 Jan 2024, Jiqian Chen wrote:
> In PVH dom0, it uses the linux local interrupt mechanism,
> when it allocs irq for a gsi, it is dynamic, and follow
> the principle of applying first, distributing first. And
> the irq number is alloced from small to large, but the
> applying gsi number is not, may gsi 38 comes before gsi
> 28, that causes the irq number is not equal with the gsi
> number. And when passthrough a device, qemu wants to use
> gsi to map pirq, xen_pt_realize->xc_physdev_map_pirq, but
> the gsi number is got from file
> /sys/bus/pci/devices/<sbdf>/irq in current code, so it
> will fail when mapping.
> 
> Add gsi into XenHostPCIDevice and use gsi number that
> read from gsi sysfs if it exists.
> 
> Co-developed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-host-pci-device.c | 7 +++++++
>  hw/xen/xen-host-pci-device.h | 1 +
>  hw/xen/xen_pt.c              | 6 +++++-
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
> index 8c6e9a1716a2..5be3279aa25b 100644
> --- a/hw/xen/xen-host-pci-device.c
> +++ b/hw/xen/xen-host-pci-device.c
> @@ -370,6 +370,13 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
>      }
>      d->irq = v;
>  
> +    xen_host_pci_get_dec_value(d, "gsi", &v, errp);
> +    if (*errp) {
> +        d->gsi = -1;
> +    } else {
> +        d->gsi = v;
> +    }
> +
>      xen_host_pci_get_hex_value(d, "class", &v, errp);
>      if (*errp) {
>          goto error;
> diff --git a/hw/xen/xen-host-pci-device.h b/hw/xen/xen-host-pci-device.h
> index 4d8d34ecb024..74c552bb5548 100644
> --- a/hw/xen/xen-host-pci-device.h
> +++ b/hw/xen/xen-host-pci-device.h
> @@ -27,6 +27,7 @@ typedef struct XenHostPCIDevice {
>      uint16_t device_id;
>      uint32_t class_code;
>      int irq;
> +    int gsi;
>  
>      XenHostPCIIORegion io_regions[PCI_NUM_REGIONS - 1];
>      XenHostPCIIORegion rom;
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index 36e6f93c372f..d448f3a17306 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -839,7 +839,11 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
>          goto out;
>      }
>  
> -    machine_irq = s->real_device.irq;
> +    if (s->real_device.gsi < 0) {
> +        machine_irq = s->real_device.irq;
> +    } else {
> +        machine_irq = s->real_device.gsi;
> +    }
>      if (machine_irq == 0) {
>          XEN_PT_LOG(d, "machine irq is 0\n");
>          cmd |= PCI_COMMAND_INTX_DISABLE;
> -- 
> 2.34.1
> 

