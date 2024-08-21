Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEA4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 00:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgZe5-0004VI-PD; Tue, 20 Aug 2024 20:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sgZe1-0004Rt-2m; Tue, 20 Aug 2024 20:56:13 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sgZdz-00033u-BW; Tue, 20 Aug 2024 20:56:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 28EFAA40BDC;
 Wed, 21 Aug 2024 00:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAACC4AF0B;
 Wed, 21 Aug 2024 00:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724201760;
 bh=zt+bRCw1JFD/aYFu4ktsx31ttxki0L5FzmNifjsxUGo=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=iI83DkJv6j8k3NwYp3USCf0B3ZclwH5Y1YWOB1Tna4gSgKqk2zmAd9N/mD4VDBvvv
 +A/jNt2WgABrEJ6EE4SmE64oNTLlJGfTs5oPUgirlfbd/Hv21IJkKvnlDuxHBJKute
 ki2g/3OvEer63dOW0xuoNak1WYxdb1mtUTu+nNKKY8lMCxHe2PHkHvjgSiPnvWlVJd
 ukCOwkU1Wu7xfKiF+GlqYB0GMs5ZcBSEFaCSH5IcbzLAuka3BmMMc+Kh7mcznbcVFi
 CNB+f8ZQFX+qGhDUXztlAUrsKzsfMGlSw8VqKXqUvFt7l6UV7+uFPZWqdn26jRSQmp
 gBmwgbn77MXbA==
Date: Tue, 20 Aug 2024 17:55:57 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 04/12] hw/arm: xenpvh: Add support for SMP guests
In-Reply-To: <20240820142949.533381-5-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2408201755430.298534@ubuntu-linux-20-04-desktop>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
 <20240820142949.533381-5-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=sstabellini@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 20 Aug 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Add SMP support for Xen PVH ARM guests.
> Create ms->smp.max_cpus ioreq servers to handle hotplug.
> 
> Note that ms->smp.max_cpus will be passed to us by the
> user (Xen tools) set to the guests maxvcpus.
> 
> The value in mc->max_cpus is an absolute maximum for the
> -smp option and won't be used to setup ioreq servers unless
> the user explicitly specifies it with -smp.
> 
> If the user doesn't pass -smp on the command-line, smp.cpus
> and smp.max_cpus will default to 1.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/arm/xen_arm.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index 5f75cc3779..fda65d0d8d 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> @@ -173,7 +173,7 @@ static void xen_arm_init(MachineState *machine)
>  
>      xen_init_ram(machine);
>  
> -    xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
> +    xen_register_ioreq(xam->state, machine->smp.max_cpus, &xen_memory_listener);
>  
>      xen_create_virtio_mmio_devices(xam);
>  
> @@ -218,7 +218,26 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
>      MachineClass *mc = MACHINE_CLASS(oc);
>      mc->desc = "Xen PVH ARM machine";
>      mc->init = xen_arm_init;
> -    mc->max_cpus = 1;
> +
> +    /*
> +     * mc->max_cpus holds the MAX value allowed in the -smp command-line opts.
> +     *
> +     * 1. If users don't pass any -smp option:
> +     *   ms->smp.cpus will default to 1.
> +     *   ms->smp.max_cpus will default to 1.
> +     *
> +     * 2. If users pass -smp X:
> +     *   ms->smp.cpus will be set to X.
> +     *   ms->smp.max_cpus will also be set to X.
> +     *
> +     * 3. If users pass -smp X,maxcpus=Y:
> +     *   ms->smp.cpus will be set to X.
> +     *   ms->smp.max_cpus will be set to Y.
> +     *
> +     * In scenarios 2 and 3, if X or Y are set to something larger than
> +     * mc->max_cpus, QEMU will bail out with an error message.
> +     */
> +    mc->max_cpus = GUEST_MAX_VCPUS;
>      mc->default_machine_opts = "accel=xen";
>      /* Set explicitly here to make sure that real ram_size is passed */
>      mc->default_ram_size = 0;
> -- 
> 2.43.0
> 

