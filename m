Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E451FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHBs-0001zM-QM; Fri, 10 Jan 2025 10:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tWHBg-0001gS-F9
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:44:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tWHBe-00082B-0w
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:44:40 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV5X019Pjz6D9JL;
 Fri, 10 Jan 2025 23:42:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 13674140CF4;
 Fri, 10 Jan 2025 23:44:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 16:44:33 +0100
Date: Fri, 10 Jan 2025 15:44:32 +0000
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Message-ID: <20250110154432.000031b0@huawei.com>
In-Reply-To: <20241213093602.3248246-1-lizhijian@fujitsu.com>
References: <20241213093602.3248246-1-lizhijian@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Fri, 13 Dec 2024 17:36:02 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> This assertion always happens when we sanitize the CXL memory device.
> $ echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> 
> It is incorrect to register an MSIX number beyond the device's capability.
> 
> Expand the device's MSIX number and use the enum to maintain the *USED*
> and MAX MSIX number
> 
> Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2: just increase msix number and add enum to maintainer their values #
> Jonathan

Ah. Sorry I was unclear. Two patches please

1. Make the number bigger to fix the bug. Only this one gets a fixes tag and
   is suitable for backporting.

2. Add an enum including all numbers currently used and use that throughout the
   type3 related code. That will prevent use accidentally introducing the
   bug in future but doesn't need to be backported. 
 
A few other comments inline.

Thanks

Jonathan

> ---
>  hw/cxl/cxl-device-utils.c   |  6 ++----
>  hw/mem/cxl_type3.c          | 10 +++++-----
>  include/hw/cxl/cxl_device.h |  7 +++++++
>  3 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 035d034f6d..bc2171e3d4 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -354,8 +354,6 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
>  
>  static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
>  {
> -    const uint8_t msi_n = 9;
> -
>      /* 2048 payload size */
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
>                       PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
> @@ -364,8 +362,8 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
>                       BG_INT_CAP, 1);
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> -                     MSI_N, msi_n);
> -    cxl_dstate->mbox_msi_n = msi_n;
> +                     MSI_N, CXL_MSIX_MBOX);

Should be passed in from the type 3 specific call so add a parameter to this
function and pass this from cxl_device_register_init_t3.
Even better pass it into there from ct3d_reset()

Will potentially be a different number for the switch CCI passed in from
the call of cxl_device_register_init_swcci() in switch-mailbox-cci.c


> +    cxl_dstate->mbox_msi_n = CXL_MSIX_MBOX;
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
>                       MBOX_READY_TIME, 0); /* Not reported */
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5cf754b38f..f2f060ed9e 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -843,7 +843,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      ComponentRegisters *regs = &cxl_cstate->crb;
>      MemoryRegion *mr = &regs->component_registers;
>      uint8_t *pci_conf = pci_dev->config;
> -    unsigned short msix_num = 6;
>      int i, rc;
>      uint16_t count;
>  
> @@ -884,16 +883,17 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>                       &ct3d->cxl_dstate.device_registers);
>  
>      /* MSI(-X) Initialization */
> -    rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
> +    rc = msix_init_exclusive_bar(pci_dev, CXL_MSIX_MAX, 4, NULL);
>      if (rc) {
>          goto err_address_space_free;
>      }
> -    for (i = 0; i < msix_num; i++) {
> +    for (i = 0; i < CXL_MSIX_MAX; i++) {
>          msix_vector_use(pci_dev, i);
>      }
>  
>      /* DOE Initialization */
> -    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
> +    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
> +                  CXL_MSIX_PCIE_DOE);
>  
>      cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
>      cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
> @@ -908,7 +908,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      if (rc) {
>          goto err_release_cdat;
>      }
> -    cxl_event_init(&ct3d->cxl_dstate, 2);
> +    cxl_event_init(&ct3d->cxl_dstate, CXL_MSIX_EVENT_START);
>  
>      /* Set default value for patrol scrub attributes */
>      ct3d->patrol_scrub_attrs.scrub_cycle_cap =
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 561b375dc8..3f89b041ce 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -133,6 +133,13 @@ typedef enum {
>      CXL_MBOX_MAX = 0x20
>  } CXLRetCode;
>  
> +enum {

Maybe worth naming these to be type3 specific.

> +    CXL_MSIX_PCIE_DOE = 0,
Name it to include that this is specifically the DOE for the table access protocol.

   CXL_MSIX_PCIE_DOE_TABLE_ACCESS


This should be private to cxl_type3.c which should be possible by passing
it to a few more calls from there. 

> +    CXL_MSIX_EVENT_START = 2,
> +    CXL_MSIX_MBOX = CXL_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
> +    CXL_MSIX_MAX
> +};
> +
>  typedef struct CXLCCI CXLCCI;
>  typedef struct cxl_device_state CXLDeviceState;
>  struct cxl_cmd;


