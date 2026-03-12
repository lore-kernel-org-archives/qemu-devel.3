Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABF61067029
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 14:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0gfz-0001tl-B1; Thu, 12 Mar 2026 10:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0gfv-0001tC-Jv; Thu, 12 Mar 2026 10:06:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0gft-0001hp-Hc; Thu, 12 Mar 2026 10:06:07 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWqBg2Js6zJ46fM;
 Thu, 12 Mar 2026 22:05:15 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 485184056A;
 Thu, 12 Mar 2026 22:06:03 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 14:06:02 +0000
Date: Thu, 12 Mar 2026 14:06:01 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 60/65] hw/arm/virt: Create and connect GICv5
Message-ID: <20260312140601.00005cfa@huawei.com>
In-Reply-To: <20260223170212.441276-61-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-61-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 23 Feb 2026 17:02:07 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> In this commit we create and connect up the GICv5.  We do not
> advertise it in the ACPI tables or DTB; that will be done in a
> following commit.
> 
> The user-facing gic-version property still only documents and permits
> in its setter function the existing set of possible values; we won't
> permit the user to select a GICv5 until all the code to handle it is
> in place.
> 
> Although we currently implement only the IRS, and only for EL1,
> we reserve space in the virt board's memory map now for all the
> register frames that the GICv5 may use. Each interrupt domain has:
>  * one IRS config register frame
>  * one ITS config register frame
>  * one ITS translate register frame
> and each of these frames is 64K in size and 64K aligned and must be
> at a unique address (that is, it is not permitted to have all the IRS
> config register frames at the same physical address in the different
> S/NS/etc physical address spaces).
> 
> The addresses and layout of these frames are entirely up to the
> implementation: software will be passed their addresses via firmware
> data structures (ACPI or DTB).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/arm/virt.c         | 101 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h |  14 ++++++
>  2 files changed, 115 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3d19eb0fee..a9addf5ac0 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c

> @@ -781,6 +795,49 @@ static void create_v2m(VirtMachineState *vms)
>      vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
>  }
>  
> +static void create_gicv5(VirtMachineState *vms, MemoryRegion *mem)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    SysBusDevice *gicbusdev;
> +    const char *gictype = gicv5_class_name();
> +    QList *cpulist = qlist_new(), *iaffidlist = qlist_new();
> +
> +    vms->gic = qdev_new(gictype);
> +    qdev_prop_set_uint32(vms->gic, "spi-range", NUM_IRQS);
> +
> +    object_property_set_link(OBJECT(vms->gic), "sysmem",
> +                             OBJECT(mem), &error_fatal);
Trivial: I'd move OBJECT(mem) up a line.
> +


