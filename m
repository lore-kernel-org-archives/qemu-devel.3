Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E10C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 03:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV1Rf-0002vg-5g; Tue, 30 Jan 2024 22:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV1Rd-0002vY-1F
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:39:25 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV1Ra-0004uA-LQ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706672363; x=1738208363;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jFt7W29WlZr+tWeECXsjc2n5qhxVmEUKjJ6VOVNjujU=;
 b=CmsrcrEgW7Hu4DzwhRJPCzMQG2KNUoCvlcCF1kPoS5gImLDcDlSHpApI
 2vBK633dzrDhEasKOyhsFW+LIlLD4qyHg1yi7E6trHeWkIzE+oj46CWw7
 5uz9YSn/F6Yg0CBXDZ08egq8Pwecb8yWs5JKwzArSjMigcE0F6MPZdKva
 mWBgbmZvUg6CIKNC67CnPSWZgogTHsATXu4WXoO+R8QMUyADIzMh7Xp6r
 oRZK6QQ+3A+gEQ+yTB7hD5tt11zqHUEQPfRl5Yw7zJkIkQ/YoY/r6VzRO
 toKS27RA/e9QYiUt0Xu6HGhZWhjit3BCzN14zUo957pmmNmn1tYenQ4PV g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17010397"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="17010397"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 19:39:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119483627"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="1119483627"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2024 19:39:14 -0800
Date: Wed, 31 Jan 2024 11:52:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/5] pci: Switch bus reset to 3-phase-reset
Message-ID: <ZbnEDTH2IP4xKNFx@intel.com>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
 <20240119163512.3810301-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119163512.3810301-2-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jan 19, 2024 at 04:35:08PM +0000, Peter Maydell wrote:
> Date: Fri, 19 Jan 2024 16:35:08 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 1/5] pci: Switch bus reset to 3-phase-reset
> X-Mailer: git-send-email 2.34.1
> 
> Switch the PCI bus from using BusClass::reset to the Resettable
> interface.
> 
> This has no behavioural change, because the BusClass code to support
> subclasses that use the legacy BusClass::reset will call that method
> in the hold phase of 3-phase reset.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/pci/pci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 76080af580d..05c2e46bda5 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -64,7 +64,7 @@ bool pci_available = true;
>  
>  static char *pcibus_get_dev_path(DeviceState *dev);
>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
> -static void pcibus_reset(BusState *qbus);
> +static void pcibus_reset_hold(Object *obj);
>  static bool pcie_has_upstream_port(PCIDevice *dev);
>  
>  static Property pci_props[] = {
> @@ -202,13 +202,15 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
>  {
>      BusClass *k = BUS_CLASS(klass);
>      PCIBusClass *pbc = PCI_BUS_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
>      k->print_dev = pcibus_dev_print;
>      k->get_dev_path = pcibus_get_dev_path;
>      k->get_fw_dev_path = pcibus_get_fw_dev_path;
>      k->realize = pci_bus_realize;
>      k->unrealize = pci_bus_unrealize;
> -    k->reset = pcibus_reset;
> +
> +    rc->phases.hold = pcibus_reset_hold;
>  
>      pbc->bus_num = pcibus_num;
>      pbc->numa_node = pcibus_numa_node;
> @@ -424,9 +426,9 @@ void pci_device_reset(PCIDevice *dev)
>   * Called via bus_cold_reset on RST# assert, after the devices
>   * have been reset device_cold_reset-ed already.
>   */
> -static void pcibus_reset(BusState *qbus)
> +static void pcibus_reset_hold(Object *obj)
>  {
> -    PCIBus *bus = DO_UPCAST(PCIBus, qbus, qbus);
> +    PCIBus *bus = PCI_BUS(obj);
>      int i;
>  
>      for (i = 0; i < ARRAY_SIZE(bus->devices); ++i) {
> -- 
> 2.34.1
> 
> 

