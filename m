Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A19C1125864
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0NsL-0000DU-Ez; Wed, 11 Mar 2026 14:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0NsI-0000CN-2D; Wed, 11 Mar 2026 14:01:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0NsF-0008DE-Ms; Wed, 11 Mar 2026 14:01:37 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWJTc0kp8zHnGkY;
 Thu, 12 Mar 2026 02:01:24 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 39FE64056A;
 Thu, 12 Mar 2026 02:01:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 18:01:31 +0000
Date: Wed, 11 Mar 2026 18:01:30 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 58/65] hw/arm/virt: Pull "wire CPU interrupts" out of
 create_gic()
Message-ID: <20260311180130.00000add@huawei.com>
In-Reply-To: <20260223170212.441276-59-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-59-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
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

On Mon, 23 Feb 2026 17:02:05 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> create_gic() is quite long and mixes GICv2 and GICv3 even though
> they're mostly different in their creation.  As a preliminary to
> splitting it up, pull out the "wire the CPU interrupts to the GIC PPI
> inputs" code out into its own function.  This is a long and
> self-contained piece of code that is the main thing that we need to
> do basically the same way for GICv2 and GICv3.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
One trivial, "whilst you are here" inline.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/arm/virt.c | 127 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 69 insertions(+), 58 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3c318680f8..ec6e49099a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -795,13 +795,80 @@ static bool gicv3_nmi_present(VirtMachineState *vms)
>             (vms->gic_version != VIRT_GIC_VERSION_2);
>  }
>  
> +static void gic_connect_ppis(VirtMachineState *vms)
> +{
> +    /*
> +     * Wire the outputs from each CPU's generic timer and the GICv3
> +     * maintenance interrupt signal to the appropriate GIC PPI inputs,
> +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ/NMI/VINMI interrupt outputs to the
> +     * CPU's inputs.
> +     */
> +    MachineState *ms = MACHINE(vms);
> +    int i;
> +    unsigned int smp_cpus = ms->smp.cpus;
> +    SysBusDevice *gicbusdev = SYS_BUS_DEVICE(vms->gic);
> +
> +    for (i = 0; i < smp_cpus; i++) {

If this doesn't get changed later in a way that prevents it, maybe sneak in
moving the  int i into the loop init?  It looks messy above.

> +        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
> +        int intidbase = NUM_IRQS + i * GIC_INTERNAL;

