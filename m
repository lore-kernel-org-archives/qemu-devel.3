Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92107C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 22:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0Nb-00043u-Ry; Tue, 13 Aug 2024 18:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1se0Na-00042I-Kh; Tue, 13 Aug 2024 18:52:38 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1se0NZ-0001id-1e; Tue, 13 Aug 2024 18:52:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C4AFB61903;
 Tue, 13 Aug 2024 22:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19E9C32782;
 Tue, 13 Aug 2024 22:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723589555;
 bh=/9E0bV+7de54mixbbQS3JvL8Qj9PklPehoTxAy+Sxcs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=B8dh8xal5x36LJnouHDGBoZOprSPE9UDE4eH0Q/ZwWwldb5GrwYDoTu3tOERwkW+Z
 zald+nejF3aLYlmCP16dQnesfsPyW4n7lDlpBSNRwEK0QAoltX1DZKJUJGeM+/EfDQ
 1yR9keeLxcHP6j+DHnJpN3JxuuT9o0tx4qgEnrGZ9ywn7X+w7SvT6dT3CcQYqGni/a
 a69w5E7GxY600EBu0uRdpwZMungKU3eOAfu9iIqnSj9A5cMM+XCDeQZ+i6875UpKkZ
 UkNPVmVjO5hAlOjmqnco2uKDtyYYxwdVBGbHhL2Ur2kwM+JP83XC0JC2jWkmncBK5H
 hTgdDZva1rHfg==
Date: Tue, 13 Aug 2024 15:52:32 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, 
 anthony@xenproject.org, paul@xen.org, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, xenia.ragiadakou@amd.com, jason.andryuk@amd.com, 
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org, 
 qemu-arm@nongnu.org
Subject: Re: [PATCH v1 04/10] hw/arm: xenpvh: Add support for SMP guests
In-Reply-To: <ZruRm34zIMtUm7oH@zapote>
Message-ID: <alpine.DEB.2.22.394.2408131550080.298534@ubuntu-linux-20-04-desktop>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-5-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2408121650590.298534@ubuntu-linux-20-04-desktop>
 <ZruRm34zIMtUm7oH@zapote>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 13 Aug 2024, Edgar E. Iglesias wrote:
> On Mon, Aug 12, 2024 at 06:47:17PM -0700, Stefano Stabellini wrote:
> > On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> > > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > > 
> > > Add SMP support for Xen PVH ARM guests. Create max_cpus ioreq
> > > servers to handle hotplug.
> > > 
> > > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > > ---
> > >  hw/arm/xen_arm.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> > > index 5f75cc3779..ef8315969c 100644
> > > --- a/hw/arm/xen_arm.c
> > > +++ b/hw/arm/xen_arm.c
> > > @@ -173,7 +173,7 @@ static void xen_arm_init(MachineState *machine)
> > >  
> > >      xen_init_ram(machine);
> > >  
> > > -    xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
> > > +    xen_register_ioreq(xam->state, machine->smp.max_cpus, &xen_memory_listener);
> > >  
> > >      xen_create_virtio_mmio_devices(xam);
> > >  
> > > @@ -218,7 +218,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
> > >      MachineClass *mc = MACHINE_CLASS(oc);
> > >      mc->desc = "Xen PVH ARM machine";
> > >      mc->init = xen_arm_init;
> > > -    mc->max_cpus = 1;
> > > +    /* MAX number of vcpus supported by Xen.  */
> > > +    mc->max_cpus = GUEST_MAX_VCPUS;
> > 
> > Will this cause allocations of data structures with 128 elements?
> > Looking at hw/xen/xen-hvm-common.c:xen_do_ioreq_register it seems
> > possible? Or hw/xen/xen-hvm-common.c:xen_do_ioreq_register is called
> 
> Yes, in theory there's probably overhead with this but as you correctly
> noted below, a PVH aware xl will set the max_cpus option to a lower value.
> 
> With a non-pvh aware xl, I was a little worried about the overhead
> but I couldn't see any visible slow-down on ARM neither in boot or in network
> performance (I didn't run very sophisticated benchmarks).
 
What do you mean by "non-pvh aware xl"? All useful versions of xl
support pvh?

> > later on with the precise vCPU value which should be provided to QEMU
> > via the -smp command line option
> > (tools/libs/light/libxl_dm.c:libxl__build_device_model_args_new)?
> 
> Yes, a pvh aware xl will for example pass -smp 2,maxcpus=4 based on
> values from the xl.cfg. If the user doesn't set maxvcpus in xl.cfg, xl
> will set maxvcpus to the same value as vcpus.

OK good. In that case if this is just an initial value meant to be
overwritten, I think it is best to keep it as 1.

