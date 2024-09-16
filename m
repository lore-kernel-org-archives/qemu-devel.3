Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893BFC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 23:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqLRo-0005rd-5l; Mon, 16 Sep 2024 19:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sqLRh-0005j1-A6; Mon, 16 Sep 2024 19:47:55 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sqLRd-0001ld-Ai; Mon, 16 Sep 2024 19:47:52 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 16077A426A2;
 Mon, 16 Sep 2024 23:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F43C4CEC4;
 Mon, 16 Sep 2024 23:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726530467;
 bh=bDRJfxN59zHNn0MVplLYT1m2IcfF93b7RFm9gAS5NN4=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=PuhnKKNAfIBJl2P4TpBcw9uwEmh1ElcVRDqk9YM7l429KrapyGQWAH9YBWNER1fRA
 +11q1wmJ8lO+d28O6ReJxwgwPheCv6zp1ZHbv7W1UzCUg05gyVff/bYxGXr3XpRTym
 FOJDvPI6zqz5jck6lz7zOhk0ITNvwEnRxbicoKYwWolhC4APVlfuu7zjMZZ0Da3u6e
 snt0iey/e6diAsSS9LP2g7in5Dz7Ml7kDe1FqBOl2QjQ23RvWQgkqTtP5HFpo5AvKm
 fprIowIYfLUY4+Q31Z0vtBR54+hfJJEsdyx9BE2Lo4kf6GYG5aUUucmJ1Wrx6zztB3
 uKMxKDKitPvDg==
Date: Mon, 16 Sep 2024 16:47:43 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v1 2/4] hw/xen: xenpvh: Disable buffered IOREQs for ARM
In-Reply-To: <20240916150853.1216703-3-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2409161646360.1417852@ubuntu-linux-20-04-desktop>
References: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
 <20240916150853.1216703-3-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=sstabellini@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Add a way to enable/disable buffered IOREQs for PVH machines
> and disable them for ARM. ARM does not support buffered
> IOREQ's nor the legacy way to map IOREQ info pages.
> 
> See the following for more details:
> https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=2fbd7e609e1803ac5e5c26e22aa8e4b5a6cddbb1
> https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/arch/arm/ioreq.c;h=2e829d2e7f3760401b96fa7c930e2015fb1cf463;hb=HEAD#l138
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/arm/xen-pvh.c                | 3 +++
>  hw/i386/xen/xen-pvh.c           | 3 +++
>  hw/xen/xen-pvh-common.c         | 2 +-
>  include/hw/xen/xen-pvh-common.h | 3 +++
>  4 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
> index 04cb9855af..28af3910ea 100644
> --- a/hw/arm/xen-pvh.c
> +++ b/hw/arm/xen-pvh.c
> @@ -66,6 +66,9 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
>       */
>      mc->max_cpus = GUEST_MAX_VCPUS;
>  
> +    /* Xen/ARM does not use buffered IOREQs.  */
> +    xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
> +
>      /* List of supported features known to work on PVH ARM.  */
>      xpc->has_tpm = true;
>      xpc->has_virtio_mmio = true;
> diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
> index 45645667e9..f1f02d3311 100644
> --- a/hw/i386/xen/xen-pvh.c
> +++ b/hw/i386/xen/xen-pvh.c
> @@ -89,6 +89,9 @@ static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
>      /* We have an implementation specific init to create CPU objects.  */
>      xpc->init = xen_pvh_init;
>  
> +    /* Enable buffered IOREQs.  */
> +    xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_ATOMIC;
> +
>      /*
>       * PCI INTX routing.
>       *
> diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> index 08641fdcec..76a9b2b945 100644
> --- a/hw/xen/xen-pvh-common.c
> +++ b/hw/xen/xen-pvh-common.c
> @@ -195,7 +195,7 @@ static void xen_pvh_init(MachineState *ms)
>  
>      xen_pvh_init_ram(s, sysmem);
>      xen_register_ioreq(&s->ioreq, ms->smp.max_cpus,
> -                       HVM_IOREQSRV_BUFIOREQ_ATOMIC,
> +                       xpc->handle_bufioreq,
>                         &xen_memory_listener);
>  
>      if (s->cfg.virtio_mmio_num) {
> diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
> index bc09eea936..62c44a1ce7 100644
> --- a/include/hw/xen/xen-pvh-common.h
> +++ b/include/hw/xen/xen-pvh-common.h
> @@ -43,6 +43,9 @@ struct XenPVHMachineClass {
>       */
>      int (*set_pci_link_route)(uint8_t line, uint8_t irq);
>  
> +    /* Allow implementations to optionally enable buffered ioreqs.  */
> +    int handle_bufioreq;

Looking at the corresponding Xen interface this field is uint8_t. I
think it would be better to use the same type here and also as a
parameter to xen_register_ioreq in QEMU



>      /*
>       * Each implementation can optionally enable features that it
>       * supports and are known to work.
> -- 
> 2.43.0
> 

