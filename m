Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FC5D6E2AF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 16:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWGuo-0006yJ-4Y; Thu, 18 Dec 2025 11:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vWGum-0006xx-6Z
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 11:31:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vWGuj-0007m9-FL
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 11:31:43 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXGPj6zGqzJ46CX;
 Fri, 19 Dec 2025 00:31:05 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 35A0A40086;
 Fri, 19 Dec 2025 00:31:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Dec
 2025 16:31:36 +0000
Date: Thu, 18 Dec 2025 16:31:34 +0000
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ira.weiny@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
 <dongjoo.seo1@samsung.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <armbru@redhat.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/5] hw/pcie: Support enabling flit mode
Message-ID: <20251218163134.000002e4@huawei.com>
In-Reply-To: <20251103195209.1319917-2-dave@stgolabs.net>
References: <20251103195209.1319917-1-dave@stgolabs.net>
 <20251103195209.1319917-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon,  3 Nov 2025 11:52:05 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> PCIe Flit Mode, introduced with the PCIe 6.0 specification, is a
> fundamental change in how data is transmitted over the bus to
> improve transfer rates. It shifts from variable-sized Transaction
> Layer Packets (TLPs) to fixed 256-byte Flow Control Units (FLITs).
> 
> As with the link speed and width training, have ad-hoc property for
> setting the flit mode and allow CXL components to make use of it.
> 
> For the CXL root port and dsp cases, always report flit mode but
> the actual value after 'training' will depend on the downstream
> device configuration.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

One small question inline.


> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index d9078e783bf0..6b97da0b4cbb 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -145,6 +145,7 @@ static const Property gen_rp_props[] = {
>                                  speed, PCIE_LINK_SPEED_16),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_32),
> +    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, false),
Do we need this given we only care about this mode for CXL devices?

Will default to false anyway and seems unwise to add infrastructure
when nothing that can be connected below this uses it yet.

>  };
>  
>  static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)



