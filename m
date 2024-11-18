Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584D9D4920F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 11:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD0AL-0005Kc-CG; Mon, 18 Nov 2024 06:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tD0AJ-0005KS-KA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 06:43:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tD0AH-000399-F1
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 06:43:35 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XsQgW4Rhnz6K9Jj;
 Mon, 18 Nov 2024 19:41:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id C99621409EA;
 Mon, 18 Nov 2024 19:43:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 18 Nov
 2024 12:43:22 +0100
Date: Mon, 18 Nov 2024 11:43:20 +0000
To: Gao Shiyuan via <qemu-devel@nongnu.org>
CC: Gao Shiyuan <gaoshiyuan@baidu.com>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <mst@redhat.com>, <zhao1.liu@intel.com>
Subject: Re: [PATCH 1/1] pcie-root-port: Fast PCIe root ports for new machine
Message-ID: <20241118114320.00002d12@huawei.com>
In-Reply-To: <20241117143917.41403-1-gaoshiyuan@baidu.com>
References: <20241117143917.41403-1-gaoshiyuan@baidu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Sun, 17 Nov 2024 22:39:17 +0800
Gao Shiyuan via <qemu-devel@nongnu.org> wrote:

> Some hardware devices now support PCIe 5.0, so change the default
> speed of the PCIe root port on new machine types.
> 
> For passthrough Nvidia H20, this will be able to increase the h2d/d2h
> bandwidth ~17%.

I'm curious.  Why are you seeing the perf improvement?

Maybe my mental model is wrong, but I though we just faked these
registers so there should be no actual change of the link speed
just a change in what the guest sees.   Is the driver using this
information to tune something else?

I recently added support for the equivalent to CXL port emulation
to support performance characteristic discovery but so far I think
that's only informational for userspace software rather than affecting
hardware usage directly.

Jonathan

> 
> Origin:
> [CUDA Bandwidth Test] - Starting...
> Running on...
> 
>  Device 0: NVIDIA H20
>  Quick Mode
> 
>  Host to Device Bandwidth, 1 Device(s)
>  PINNED Memory Transfers
>    Transfer Size (Bytes)    Bandwidth(MB/s)
>    33554432            45915.4
> 
>  Device to Host Bandwidth, 1 Device(s)
>  PINNED Memory Transfers
>    Transfer Size (Bytes)    Bandwidth(MB/s)
>    33554432            45980.3
> 
>  Device to Device Bandwidth, 1 Device(s)
>  PINNED Memory Transfers
>    Transfer Size (Bytes)    Bandwidth(MB/s)
>    33554432            1842886.8
> 
> Result = PASS
> 
> With this patch:
> [CUDA Bandwidth Test] - Starting...
> Running on...
> 
>  Device 0: NVIDIA H20
>  Quick Mode
> 
>  Host to Device Bandwidth, 1 Device(s)
>  PINNED Memory Transfers
>    Transfer Size (Bytes)	Bandwidth(MB/s)
>    33554432			53682.0
> 
>  Device to Host Bandwidth, 1 Device(s)
>  PINNED Memory Transfers
>    Transfer Size (Bytes)	Bandwidth(MB/s)
>    33554432			53766.0
> 
>  Device to Device Bandwidth, 1 Device(s)
>  PINNED Memory Transfers
>    Transfer Size (Bytes)	Bandwidth(MB/s)
>    33554432			1842555.1
> 
> Result = PASS
> 
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> ---
>  hw/core/machine.c                  | 1 +
>  hw/pci-bridge/gen_pcie_root_port.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a35c4a8fae..afef55626d 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,6 +38,7 @@
>  
>  GlobalProperty hw_compat_9_1[] = {
>      { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
> +    { "pcie-root-port", "x-speed", "16" },
>  };
>  const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
>  
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index 784507c826..c24ce1f2d1 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -142,7 +142,7 @@ static Property gen_rp_props[] = {
>      DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,
>                       res_reserve.mem_pref_64, -1),
>      DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
> -                                speed, PCIE_LINK_SPEED_16),
> +                                speed, PCIE_LINK_SPEED_32),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_32),
>      DEFINE_PROP_END_OF_LIST()


