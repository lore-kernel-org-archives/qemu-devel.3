Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C5DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuYN-0007TM-7j; Mon, 03 Nov 2025 08:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vFuYD-0007O0-MU; Mon, 03 Nov 2025 08:24:54 -0500
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vFuY8-0002WJ-3L; Mon, 03 Nov 2025 08:24:48 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d0XP06jNgzHnHF1;
 Mon,  3 Nov 2025 21:24:20 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 6223914033F;
 Mon,  3 Nov 2025 21:24:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Nov
 2025 13:24:21 +0000
Date: Mon, 3 Nov 2025 13:24:19 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 07/32] hw/pci/pci: Move pci_init_bus_master() after
 adding device to bus
Message-ID: <20251103132419.00004abc@huawei.com>
In-Reply-To: <20251031105005.24618-8-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-8-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 31 Oct 2025 10:49:40 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> During PCI hotplug, in do_pci_register_device(), pci_init_bus_master()
> is called before storing the pci_dev pointer in bus->devices[devfn].
> 
> This causes a problem if pci_init_bus_master() (via its
> get_address_space() callback) attempts to retrieve the device using
> pci_find_device(), since the PCI device is not yet visible on the bus.
> 
> Fix this by moving the pci_init_bus_master() call to after the device
> has been added to bus->devices[devfn].
> 
> This prepares for a subsequent patch where the accel SMMUv3
> get_address_space() callback retrieves the pci_dev to identify the
> attached device type.
> 
> No functional change intended.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Seems harmless.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/pci/pci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c9932c87e3..9693d7f10c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1370,9 +1370,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>      pci_dev->bus_master_as.max_bounce_buffer_size =
>          pci_dev->max_bounce_buffer_size;
>  
> -    if (phase_check(PHASE_MACHINE_READY)) {
> -        pci_init_bus_master(pci_dev);
> -    }
>      pci_dev->irq_state = 0;
>      pci_config_alloc(pci_dev);
>  
> @@ -1416,6 +1413,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>      pci_dev->config_write = config_write;
>      bus->devices[devfn] = pci_dev;
>      pci_dev->version_id = 2; /* Current pci device vmstate version */
> +    if (phase_check(PHASE_MACHINE_READY)) {
> +        pci_init_bus_master(pci_dev);
> +    }
>      return pci_dev;
>  }
>  


