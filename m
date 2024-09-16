Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10221C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 23:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqLU5-0006Pn-OZ; Mon, 16 Sep 2024 19:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sqLU3-0006H4-I2; Mon, 16 Sep 2024 19:50:19 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sqLU1-00024P-TX; Mon, 16 Sep 2024 19:50:19 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B23245C3114;
 Mon, 16 Sep 2024 23:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154FDC4CEC4;
 Mon, 16 Sep 2024 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726530616;
 bh=EcihBU2MW+o0k8STiYL5wfgfRi+z+e3ydSW7l+a5gAw=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=RGB2J96z0XM6/2N1YgdJL1hrET9dwWbaDhoLTvF8NJVBBzsOIyCxVhID0f9Mm7/FI
 MDo1dFqc2ihsQb+75KauXTS95u5y7oB7kHJmJ8qMOv8nogC7ApweXU5PWRTKrTJmKE
 azIVOi20Ms9eLdjkPk9P9apALizLi5pnnfCeq5+PgYXW9V2UT0yYWQdaRsX13sOmq1
 KXrKpowqs+eUrVw1K5icr9oY6KsCKXROLDykw+7TaV3Aa9ntu0FHeOvv5ND1S1MtDZ
 FgW1X7STNq2ASK9rVzamI1jlbQulGfwtsbf0dJ7EJZzgndGWQg8LL4YmVGQ9Zaewpx
 BQmMWPto4BNxA==
Date: Mon, 16 Sep 2024 16:50:12 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org, 
 qemu-arm@nongnu.org
Subject: Re: [PATCH v1 4/4] hw/arm: xenpvh: Enable PCI for ARM PVH
In-Reply-To: <20240916150853.1216703-5-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2409161649590.1417852@ubuntu-linux-20-04-desktop>
References: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
 <20240916150853.1216703-5-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Sep 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Enable PCI support for the ARM Xen PVH machine.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/arm/xen-pvh.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
> index 28af3910ea..33f0dd5982 100644
> --- a/hw/arm/xen-pvh.c
> +++ b/hw/arm/xen-pvh.c
> @@ -39,6 +39,16 @@ static void xen_arm_instance_init(Object *obj)
>                                           VIRTIO_MMIO_DEV_SIZE };
>  }
>  
> +static void xen_pvh_set_pci_intx_irq(void *opaque, int intx_irq, int level)
> +{
> +    XenPVHMachineState *s = XEN_PVH_MACHINE(opaque);
> +    int irq = s->cfg.pci_intx_irq_base + intx_irq;
> +
> +    if (xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level)) {
> +        error_report("xendevicemodel_set_pci_intx_level failed");
> +    }
> +}
> +
>  static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
>  {
>      XenPVHMachineClass *xpc = XEN_PVH_MACHINE_CLASS(oc);
> @@ -69,7 +79,11 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
>      /* Xen/ARM does not use buffered IOREQs.  */
>      xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
>  
> +    /* PCI INTX delivery.  */
> +    xpc->set_pci_intx_irq = xen_pvh_set_pci_intx_irq;
> +
>      /* List of supported features known to work on PVH ARM.  */
> +    xpc->has_pci = true;
>      xpc->has_tpm = true;
>      xpc->has_virtio_mmio = true;
>  
> -- 
> 2.43.0
> 

