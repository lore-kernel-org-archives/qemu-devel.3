Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC01E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 12:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhu9-0004EU-6o; Thu, 12 Dec 2024 07:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tLhu6-0004E1-Qi
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:02:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tLhu4-0003PG-5C
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:02:50 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y89vj75nvz6K6ll;
 Thu, 12 Dec 2024 19:57:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 5431E140AB8;
 Thu, 12 Dec 2024 20:02:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Dec
 2024 13:02:34 +0100
Date: Thu, 12 Dec 2024 12:02:32 +0000
To: Li Zhijian via <qemu-devel@nongnu.org>
CC: Li Zhijian <lizhijian@fujitsu.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Message-ID: <20241212120232.000056a9@huawei.com>
In-Reply-To: <20241212085534.2669377-1-lizhijian@fujitsu.com>
References: <20241212085534.2669377-1-lizhijian@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 12 Dec 2024 16:55:33 +0800
Li Zhijian via <qemu-devel@nongnu.org> wrote:

> This assertion always happens when we sanitize the CXL memory device.
> $ echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> 
> It is incorrect to register an MSIX number beyond the device's capability.
> 
> Expand the device's MSIX to 10 and introduce the `request_msix_number()`
> helper function to dynamically request an available MSIX number.
> 
> Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Hi.

Thanks for testing + the fix.

This looks like a  mess up by me due to reordering patches. 
In the first instance, the fix should just be to increase msi_n (keep it minimal)

The refactor to use an allocator may makes sense as a follow up, but needs
to be used universally for allocation of each msix, not just for the later
ones.  However, it may be simpler to just use an enum with a _MAX final
entry to ensure we allocate the right overall number.  These are fixed
numbers and a restricted resource, so dynamic allocator is probably unnecessary.

Longer term we need to spend some time on automated tests so this sort of silly
bug doesn't happen in future :(

Thanks,

Jonathan


> ---
>  hw/cxl/cxl-device-utils.c   |  3 ++-
>  hw/mem/cxl_type3.c          | 15 ++++++++++++++-
>  include/hw/cxl/cxl_device.h |  2 ++
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 035d034f6d..8e52af6813 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -354,8 +354,9 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
>  
>  static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
>  {
> -    const uint8_t msi_n = 9;
> +    uint8_t msi_n = cxl_request_msi_number();
>  
> +    assert(msi_n > 0);
>      /* 2048 payload size */
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
>                       PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5cf754b38f..dbb1368736 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -835,6 +835,19 @@ static DOEProtocol doe_cdat_prot[] = {
>      { }
>  };
>  
> +#define CT3_MSIX_NUM 10
> +unsigned short cxl_request_msi_number(void)
> +{
> +    const unsigned short start = 6;
> +    static unsigned short next = start;
> +
> +    if (next + 1 >= CT3_MSIX_NUM) {
> +        return -1;
> +    }
> +
> +    return ++next;
> +}
> +
>  static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -843,7 +856,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      ComponentRegisters *regs = &cxl_cstate->crb;
>      MemoryRegion *mr = &regs->component_registers;
>      uint8_t *pci_conf = pci_dev->config;
> -    unsigned short msix_num = 6;
> +    unsigned short msix_num = CT3_MSIX_NUM;
>      int i, rc;
>      uint16_t count;
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 561b375dc8..622265f50e 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -680,4 +680,6 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                     uint64_t len);
>  bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                    uint64_t len);
> +unsigned short cxl_request_msi_number(void);
> +
>  #endif


