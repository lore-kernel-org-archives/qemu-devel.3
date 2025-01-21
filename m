Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFCEC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFja-0006KB-3v; Tue, 21 Jan 2025 10:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taFjY-0006K0-6w
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:00:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taFjV-000166-Vl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:00:03 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ycr176cf8z6M4ZV;
 Tue, 21 Jan 2025 22:58:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 33151140A70;
 Tue, 21 Jan 2025 22:59:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 15:59:57 +0100
Date: Tue, 21 Jan 2025 14:59:56 +0000
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] hw/mem/cxl_type3: Ensure errp is set on realization
 failure
Message-ID: <20250121145956.00007e66@huawei.com>
In-Reply-To: <20250120030947.254930-3-lizhijian@fujitsu.com>
References: <20250120030947.254930-1-lizhijian@fujitsu.com>
 <20250120030947.254930-3-lizhijian@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.086, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 20 Jan 2025 11:09:47 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> Simply pass the errp to its callee which will set errp if needed, to
> enhance error reporting for CXL Type 3 device initialization by setting
> the errp when realization functions fail.
> 
> Previously, failing to set `errp` could result in errors being overlooked,
> causing the system to mistakenly treat failure scenarios as successful and
> potentially leading to redundant cleanup operations in ct3_exit().
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Looks good to me so just that reordering issue in patch 2.

Thanks for fixing this up.

Jonathan

> ---
>  hw/mem/cxl_type3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 9eb3d0979cf5..c3b6a1d6a612 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -883,7 +883,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>                       &ct3d->cxl_dstate.device_registers);
>  
>      /* MSI(-X) Initialization */
> -    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
> +    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, errp);
>      if (rc) {
>          goto err_free_special_ops;
>      }
> @@ -904,7 +904,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  
>      pcie_cap_deverr_init(pci_dev);
>      /* Leave a bit of room for expansion */
> -    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
> +    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, errp);
>      if (rc) {
>          goto err_release_cdat;
>      }


