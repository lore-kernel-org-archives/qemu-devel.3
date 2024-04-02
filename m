Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B80CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraHM-0007Cj-7x; Tue, 02 Apr 2024 05:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rraH9-00079f-Ba
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:17:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rraH1-0005lO-2l
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:17:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V82L61TJdz6GB07;
 Tue,  2 Apr 2024 17:15:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E5F84140CB9;
 Tue,  2 Apr 2024 17:17:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Apr
 2024 10:17:10 +0100
Date: Tue, 2 Apr 2024 10:17:06 +0100
To: Li Zhijian <lizhijian@fujitsu.com>
CC: Fan Ni <fan.ni@samsung.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] CXL/cxl_type3: reset DVSEC CXL Control in ct3d_reset
Message-ID: <20240402101706.000045b2@Huawei.com>
In-Reply-To: <20240402014647.3733839-2-lizhijian@fujitsu.com>
References: <20240402014647.3733839-1-lizhijian@fujitsu.com>
 <20240402014647.3733839-2-lizhijian@fujitsu.com>
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

On Tue,  2 Apr 2024 09:46:47 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> After the kernel commit
> 0cab68720598 ("cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window")

Fixes tag seems appropriate.

> CXL type3 devices cannot be enabled again after the reboot because this
> flag was not reset.
> 
> This flag could be changed by the firmware or OS, let it have a
> reset(default) value in reboot so that the OS can read its clean status.

Good find.  I think we should aim for a fix that is less fragile to future
code rearrangement etc.

> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  hw/mem/cxl_type3.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ad2fe7d463fb..3fe136053390 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -305,7 +305,8 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>  
>      dvsec = (uint8_t *)&(CXLDVSECDevice){
>          .cap = 0x1e,
> -        .ctrl = 0x2,
> +#define CT3D_DEVSEC_CXL_CTRL 0x2
> +        .ctrl = CT3D_DEVSEC_CXL_CTRL,
Naming doesn't make it clear the define is a reset value / default value.
>          .status2 = 0x2,
>          .range1_size_hi = range1_size_hi,
>          .range1_size_lo = range1_size_lo,
> @@ -906,6 +907,16 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>      return address_space_write(as, dpa_offset, attrs, &data, size);
>  }
>  
> +/* Reset DVSEC CXL Control */
> +static void ct3d_dvsec_cxl_ctrl_reset(CXLType3Dev *ct3d)
> +{
> +    uint16_t offset = first_dvsec_offset(ct3d);

This relies to much on the current memory layout.  We should doing a search
of config space to find the right entry, or we should cache a pointer to
the relevant structure when we fill it in the first time.

> +    CXLDVSECDevice *dvsec;
> +
> +    dvsec = (CXLDVSECDevice *)(ct3d->cxl_cstate.pdev->config + offset);
> +    dvsec->ctrl = CT3D_DEVSEC_CXL_CTRL;
> +}
> +
>  static void ct3d_reset(DeviceState *dev)
>  {
>      CXLType3Dev *ct3d = CXL_TYPE3(dev);
> @@ -914,6 +925,7 @@ static void ct3d_reset(DeviceState *dev)
>  
>      cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
>      cxl_device_register_init_t3(ct3d);
> +    ct3d_dvsec_cxl_ctrl_reset(ct3d);
>  
>      /*
>       * Bring up an endpoint to target with MCTP over VDM.


