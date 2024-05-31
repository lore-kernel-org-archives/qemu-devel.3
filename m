Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B4AC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 10:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCzHC-0006TR-9J; Fri, 31 May 2024 06:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sCzHA-0006TC-LI
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:14:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sCzH7-0008Q7-Sb
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:14:20 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VrJpf51gmz6K96b;
 Fri, 31 May 2024 18:12:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 2537E140C98;
 Fri, 31 May 2024 18:14:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 May
 2024 11:14:01 +0100
Date: Fri, 31 May 2024 11:14:00 +0100
To: Nam Cao <namcao@linutronix.de>
CC: Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 <qemu-devel@nongnu.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v2] pci-bridge/xio3130_downstream: fix invalid link
 speed and link width
Message-ID: <20240531111400.000064f7@Huawei.com>
In-Reply-To: <20240529201744.15420-1-namcao@linutronix.de>
References: <20240529201744.15420-1-namcao@linutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 29 May 2024 22:17:44 +0200
Nam Cao <namcao@linutronix.de> wrote:

> Set link width to x1 and link speed to 2.5 Gb/s as specified by the
> datasheet. Without this, these fields in the link status register read
> zero, which is incorrect.
> 
> This problem appeared since 3d67447fe7c2 ("pcie: Fill PCIESlot link fields
> to support higher speeds and widths"), which allows PCIe slot to set link
> width and link speed. However, if PCIe slot does not explicitly set these
> properties, they will be zero. Before this commit, the width and speed
> default to x1 and 2.5 Gb/s.
> 
> Fixes: 3d67447fe7c2 ("pcie: Fill PCIESlot link fields to support higher speeds and widths")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
Hi Nam,

I'm feeling a bit guilty about this one a known it was there for a while.

I was lazy when fixing the equivalent CXL case a while back on
basis no one had noticed and unlike CXL (where migration is broken for a lot
of reasons) fixing this may need to take into account migration from broken to
fixed versions.  Have you tested that?

I did the CXL fix slightly differently.  Can't remember why though - looking
at the fact it uses an instance_post_init, is there an issue with accidentally
overwriting the parameters?  Or did I just over engineer the fix?

https://gitlab.com/jic23/qemu/-/commit/314f5033c639ebe8218078a17513935747f15d9d

> ---
> v2: implement this in .realize() instead
> ---
>  hw/pci-bridge/xio3130_downstream.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 38a2361fa2..2df1ee203d 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -72,6 +72,9 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
>      pci_bridge_initfn(d, TYPE_PCIE_BUS);
>      pcie_port_init_reg(d);
>  
> +    s->speed = QEMU_PCI_EXP_LNK_2_5GT;
> +    s->width = QEMU_PCI_EXP_LNK_X1;
> +
>      rc = msi_init(d, XIO3130_MSI_OFFSET, XIO3130_MSI_NR_VECTOR,
>                    XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
>                    XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,


