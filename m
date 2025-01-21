Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD7DC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFi4-0005HK-IH; Tue, 21 Jan 2025 09:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taFi2-0005H6-9l
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:58:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taFi0-0000oZ-8A
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:58:30 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ycr1441kcz6K9JV;
 Tue, 21 Jan 2025 22:58:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id CE4D9140B33;
 Tue, 21 Jan 2025 22:58:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 15:58:13 +0100
Date: Tue, 21 Jan 2025 14:58:12 +0000
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Fix special_ops memory leak on
 msix_init_exclusive_bar() failure
Message-ID: <20250121145812.00004c63@huawei.com>
In-Reply-To: <20250120030947.254930-2-lizhijian@fujitsu.com>
References: <20250120030947.254930-1-lizhijian@fujitsu.com>
 <20250120030947.254930-2-lizhijian@fujitsu.com>
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

On Mon, 20 Jan 2025 11:09:46 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> Address a memory leak issue by ensuring `regs->special_ops` is freed when
> `msix_init_exclusive_bar()` encounters an error during CXL Type3 device
> initialization.
> 
> Additionally, this patch renames err_address_space_free to err_msix_uninit
> for better clarity and logical flow
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Hi.

The need to reorder the cleanup calls made me look more
closely at this patch. Either the order was wrong here or in the previous
patch. I think the issue is here.

Jonathan

> ---
>  hw/mem/cxl_type3.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 9dad250f56d5..9eb3d0979cf5 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -885,7 +885,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      /* MSI(-X) Initialization */
>      rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
>      if (rc) {
> -        goto err_address_space_free;
> +        goto err_free_special_ops;
>      }
>      for (i = 0; i < CXL_T3_MSIX_VECTOR_NR; i++) {
>          msix_vector_use(pci_dev, i);
> @@ -899,7 +899,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
>      cxl_cstate->cdat.private = ct3d;
>      if (!cxl_doe_cdat_init(cxl_cstate, errp)) {
> -        goto err_free_special_ops;
> +        goto err_msix_uninit;
>      }
>  
>      pcie_cap_deverr_init(pci_dev);
> @@ -936,9 +936,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  err_release_cdat:
>      cxl_doe_cdat_release(cxl_cstate);
>  err_free_special_ops:
> -    msix_uninit_exclusive_bar(pci_dev);
>      g_free(regs->special_ops);
> -err_address_space_free:
> +err_msix_uninit:
> +    msix_uninit_exclusive_bar(pci_dev);

This reorder doesn't look correct.

Should end up I think as
err_release_cdata:
    cxl_doe_cdata_release(cxl_cstate);
err_msix_uninit:
    msix_uninit_eclusive_bar(pci_dev);
err_free_special_ops:
    g_free(regs->special_ops)
err_address_space_free:
etc.

>      if (ct3d->dc.host_dc) {
>          cxl_destroy_dc_regions(ct3d);
>          address_space_destroy(&ct3d->dc.host_dc_as);


