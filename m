Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83899CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraEF-0004ui-Vn; Tue, 02 Apr 2024 05:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rraEE-0004u6-JR
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:14:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rraE4-0002xw-Ce
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:14:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V82C85wgGz6K6wd;
 Tue,  2 Apr 2024 17:09:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id CFB12140518;
 Tue,  2 Apr 2024 17:14:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Apr
 2024 10:14:32 +0100
Date: Tue, 2 Apr 2024 10:14:31 +0100
To: Li Zhijian <lizhijian@fujitsu.com>
CC: Fan Ni <fan.ni@samsung.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] CXL/cxl_type3: add first_dvsec_offset() helper
Message-ID: <20240402101431.00002494@Huawei.com>
In-Reply-To: <20240402014647.3733839-1-lizhijian@fujitsu.com>
References: <20240402014647.3733839-1-lizhijian@fujitsu.com>
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue,  2 Apr 2024 09:46:46 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> It helps to figure out where the first dvsec register is located. In
> addition, replace offset and size hardcore with existing macros.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

I agree we should be using the macros.

The offset calc is a bit specific to the the chosen memory layout,
so not sure it makes sense to break it out to a separate function.

I'll suggest alternative possible approaches in review of next patch.

Jonathan

> ---
>  hw/mem/cxl_type3.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b0a7e9f11b64..ad2fe7d463fb 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -643,6 +643,16 @@ static DOEProtocol doe_cdat_prot[] = {
>      { }
>  };
>  
> +static uint16_t first_dvsec_offset(CXLType3Dev *ct3d)
> +{
> +    uint16_t offset = PCI_CONFIG_SPACE_SIZE;
> +
> +    if (ct3d->sn != UI64_NULL)
> +        offset += PCI_EXT_CAP_DSN_SIZEOF;
> +
> +    return offset;
> +}
> +
>  static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -663,13 +673,10 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      pci_config_set_prog_interface(pci_conf, 0x10);
>  
>      pcie_endpoint_cap_init(pci_dev, 0x80);
> -    if (ct3d->sn != UI64_NULL) {
> -        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> -        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> -    } else {
> -        cxl_cstate->dvsec_offset = 0x100;
> -    }
> +    if (ct3d->sn != UI64_NULL)
> +        pcie_dev_ser_num_init(pci_dev, PCI_CONFIG_SPACE_SIZE, ct3d->sn);
>  
> +    cxl_cstate->dvsec_offset = first_dvsec_offset(ct3d);
>      ct3d->cxl_cstate.pdev = pci_dev;
>      build_dvsecs(ct3d);
>  


