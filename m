Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA41C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 10:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSYkQ-00023q-Sv; Fri, 20 Jun 2025 06:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSYkP-00023R-4Y; Fri, 20 Jun 2025 06:13:25 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSYkN-00058q-CF; Fri, 20 Jun 2025 06:13:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNtZW59Jlz6M5Wt;
 Fri, 20 Jun 2025 18:12:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id AB2661400D7;
 Fri, 20 Jun 2025 18:13:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 12:13:13 +0200
Date: Fri, 20 Jun 2025 11:13:11 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 23/29] hw/core/sysbus: Introduce
 sysbus_mmio_map_name() helper
Message-ID: <20250620111311.00005da2@huawei.com>
In-Reply-To: <20250616094903.885753-24-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-24-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Jun 2025 11:46:52 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Some sysbus devices have conditionnal mmio regions. This

Spell check. conditional

> happens for instance with the hw/acpi/ged device. In that case
> it becomes difficult to predict which index a specific MMIO
> region corresponds to when one needs to mmio map the region.
> Introduce a new helper that takes the name of the region instead
> of its index. If the region is not found this returns -1.
> Otherwise it maps the corresponding index and returns this latter.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Nice helper.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  include/hw/sysbus.h |  1 +
>  hw/core/sysbus.c    | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
> index 7dc88aaa27..18fde8a7b4 100644
> --- a/include/hw/sysbus.h
> +++ b/include/hw/sysbus.h
> @@ -82,6 +82,7 @@ void sysbus_connect_irq(SysBusDevice *dev, int n, qemu_irq irq);
>  bool sysbus_is_irq_connected(SysBusDevice *dev, int n);
>  qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, int n);
>  void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
> +int sysbus_mmio_map_name(SysBusDevice *dev, const char*name, hwaddr addr);
>  void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
>                               int priority);
>  
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index e71367adfb..ec69e877a2 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -151,6 +151,17 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
>      sysbus_mmio_map_common(dev, n, addr, false, 0);
>  }
>  
> +int sysbus_mmio_map_name(SysBusDevice *dev, const char *name, hwaddr addr)
> +{
> +    for (int i = 0; i < dev->num_mmio; i++) {
> +        if (!strcmp(dev->mmio[i].memory->name, name)) {
> +            sysbus_mmio_map(dev, i, addr);
> +            return i;
> +        }
> +    }
> +    return -1;
> +}
> +
>  void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
>                               int priority)
>  {


