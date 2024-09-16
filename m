Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29657C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 23:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqLPe-00019u-CG; Mon, 16 Sep 2024 19:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sqLPc-00019O-Po
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 19:45:44 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sqLPa-0001aP-JB
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 19:45:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 512CDA4269D;
 Mon, 16 Sep 2024 23:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC4DC4CEC4;
 Mon, 16 Sep 2024 23:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726530337;
 bh=qVWWWq9UIXHy8aSd5DJScwNnAvgoj5FmkSawrRlvnjo=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=PtAK+WxVe9uecqhXbn3BtinaInXrkrK8NMLnCY77P28hG4eoYUXZ7xEnINrp59BuU
 xPlXYoJrNhU67/Qd64DAQeRZrllG0zYcKTJZS1NDIRo1RF9rn39H5MGSmrDwg/AgHi
 jBNql/71MR7e+P21rubM8YpGNEGhJkDoLQXjfTJpm5fkyRDNNYrkN3FtGE2DR2UTvd
 eZwRvj7rKB8uJUBAbk4n7LU0kGgLReOwfJZ9OTx1Cmyxhih0vMoYdd3FzD4qdepIHO
 FdSZkWLXq5qgimCidflkYT6Fk/bOKi9dUzaiF+GxOSr/fw9cbg8Wiwmarp1DEjsPxU
 JHvRaaYAN+tIw==
Date: Mon, 16 Sep 2024 16:45:34 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v1 1/4] xen: Expose handle_bufioreq in xen_register_ioreq
In-Reply-To: <20240916150853.1216703-2-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2409161643090.1417852@ubuntu-linux-20-04-desktop>
References: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
 <20240916150853.1216703-2-edgar.iglesias@gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
> Expose handle_bufioreq in xen_register_ioreq().
> This is to allow machines to enable or disable buffered ioreqs.
> 
> No functional change since all callers still set it to
> HVM_IOREQSRV_BUFIOREQ_ATOMIC.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/i386/xen/xen-hvm.c           |   4 +-
>  hw/xen/xen-hvm-common.c         | 100 +++++++++++++++++++-------------
>  hw/xen/xen-pvh-common.c         |   4 +-
>  include/hw/xen/xen-hvm-common.h |   3 +
>  include/hw/xen/xen_native.h     |   3 +-
>  5 files changed, 70 insertions(+), 44 deletions(-)
> 
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 4f6446600c..d3df488c48 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -614,7 +614,9 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
>  
>      state = g_new0(XenIOState, 1);
>  
> -    xen_register_ioreq(state, max_cpus, &xen_memory_listener);
> +    xen_register_ioreq(state, max_cpus,
> +                       HVM_IOREQSRV_BUFIOREQ_ATOMIC,
> +                       &xen_memory_listener);
>  
>      xen_is_stubdomain = xen_check_stubdomain(state->xenstore);
>  
> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> index 3a9d6f981b..d8824cccf1 100644
> --- a/hw/xen/xen-hvm-common.c
> +++ b/hw/xen/xen-hvm-common.c
> @@ -667,6 +667,8 @@ static int xen_map_ioreq_server(XenIOState *state)
>      xen_pfn_t ioreq_pfn;
>      xen_pfn_t bufioreq_pfn;
>      evtchn_port_t bufioreq_evtchn;
> +    unsigned long num_frames = 1;
> +    unsigned long frame = 1;
>      int rc;
>  
>      /*
> @@ -675,59 +677,72 @@ static int xen_map_ioreq_server(XenIOState *state)
>       */
>      QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_bufioreq != 0);
>      QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_ioreq(0) != 1);
> +
> +    if (state->has_bufioreq) {
> +        frame = 0;
> +        num_frames = 2;
> +    }
>      state->fres = xenforeignmemory_map_resource(xen_fmem, xen_domid,
>                                           XENMEM_resource_ioreq_server,
> -                                         state->ioservid, 0, 2,
> +                                         state->ioservid,
> +                                         frame, num_frames,
>                                           &addr,
>                                           PROT_READ | PROT_WRITE, 0);
>      if (state->fres != NULL) {
>          trace_xen_map_resource_ioreq(state->ioservid, addr);
> -        state->buffered_io_page = addr;
> -        state->shared_page = addr + XC_PAGE_SIZE;
> +        state->shared_page = addr;
> +        if (state->has_bufioreq) {
> +            state->buffered_io_page = addr;
> +            state->shared_page = addr + XC_PAGE_SIZE;
> +        }
>      } else if (errno != EOPNOTSUPP) {
>          error_report("failed to map ioreq server resources: error %d handle=%p",
>                       errno, xen_xc);
>          return -1;
>      }
>  
> -    rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
> -                                   (state->shared_page == NULL) ?
> -                                   &ioreq_pfn : NULL,
> -                                   (state->buffered_io_page == NULL) ?
> -                                   &bufioreq_pfn : NULL,
> -                                   &bufioreq_evtchn);
> -    if (rc < 0) {
> -        error_report("failed to get ioreq server info: error %d handle=%p",
> -                     errno, xen_xc);
> -        return rc;
> -    }
> -
> -    if (state->shared_page == NULL) {
> -        trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
> +    if (state->has_bufioreq) {
> +        rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
> +                                       (state->shared_page == NULL) ?
> +                                       &ioreq_pfn : NULL,
> +                                       (state->buffered_io_page == NULL) ?
> +                                       &bufioreq_pfn : NULL,
> +                                       &bufioreq_evtchn);
> +        if (rc < 0) {
> +            error_report("failed to get ioreq server info: error %d handle=%p",
> +                    errno, xen_xc);
> +            return rc;
> +        }
>  
> -        state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
> -                                                  PROT_READ | PROT_WRITE,
> -                                                  1, &ioreq_pfn, NULL);
>          if (state->shared_page == NULL) {
> -            error_report("map shared IO page returned error %d handle=%p",
> -                         errno, xen_xc);
> +            trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
> +
> +            state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
> +                                                      PROT_READ | PROT_WRITE,
> +                                                      1, &ioreq_pfn, NULL);
> +            if (state->shared_page == NULL) {
> +                error_report("map shared IO page returned error %d handle=%p",
> +                        errno, xen_xc);
> +            }
>          }
> -    }


If I am reading the code right the calls to xen_get_ioreq_server_info
and xenforeignmemory_map were not done to setup bufioreq. They were done
for legacy compatibility to support systems where
xenforeignmemory_map_resource returns EOPNOTSUPP.

I think we should either get rid of this legacy path completely, or
keep it for both bufioreq and non-bufioreq.



> -    if (state->buffered_io_page == NULL) {
> -        trace_xen_map_ioreq_server_buffered_io_page(bufioreq_pfn);
> -
> -        state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
> -                                                       PROT_READ | PROT_WRITE,
> -                                                       1, &bufioreq_pfn,
> -                                                       NULL);
>          if (state->buffered_io_page == NULL) {
> -            error_report("map buffered IO page returned error %d", errno);
> -            return -1;
> +            trace_xen_map_ioreq_server_buffered_io_page(bufioreq_pfn);
> +
> +            state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
> +                    PROT_READ | PROT_WRITE,
> +                    1, &bufioreq_pfn,
> +                    NULL);
> +            if (state->buffered_io_page == NULL) {
> +                error_report("map buffered IO page returned error %d", errno);
> +                return -1;
> +            }
>          }
>      }
>  
> -    if (state->shared_page == NULL || state->buffered_io_page == NULL) {
> +
> +    if (state->shared_page == NULL ||
> +        (state->has_bufioreq && state->buffered_io_page == NULL)) {
>          return -1;
>      }
>  
> @@ -830,14 +845,15 @@ static void xen_do_ioreq_register(XenIOState *state,
>          state->ioreq_local_port[i] = rc;
>      }
>  
> -    rc = qemu_xen_evtchn_bind_interdomain(state->xce_handle, xen_domid,
> -                                          state->bufioreq_remote_port);
> -    if (rc == -1) {
> -        error_report("buffered evtchn bind error %d", errno);
> -        goto err;
> +    if (state->has_bufioreq) {
> +        rc = qemu_xen_evtchn_bind_interdomain(state->xce_handle, xen_domid,
> +                                              state->bufioreq_remote_port);
> +        if (rc == -1) {
> +            error_report("buffered evtchn bind error %d", errno);
> +            goto err;
> +        }
> +        state->bufioreq_local_port = rc;
>      }
> -    state->bufioreq_local_port = rc;
> -
>      /* Init RAM management */
>  #ifdef XEN_COMPAT_PHYSMAP
>      xen_map_cache_init(xen_phys_offset_to_gaddr, state);
> @@ -865,6 +881,7 @@ err:
>  }
>  
>  void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
> +                        int handle_bufioreq,
>                          const MemoryListener *xen_memory_listener)
>  {
>      int rc;
> @@ -883,7 +900,8 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
>          goto err;
>      }
>  
> -    rc = xen_create_ioreq_server(xen_domid, &state->ioservid);
> +    state->has_bufioreq = handle_bufioreq != HVM_IOREQSRV_BUFIOREQ_OFF;
> +    rc = xen_create_ioreq_server(xen_domid, handle_bufioreq, &state->ioservid);
>      if (!rc) {
>          xen_do_ioreq_register(state, max_cpus, xen_memory_listener);
>      } else {
> diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> index 28d7168446..08641fdcec 100644
> --- a/hw/xen/xen-pvh-common.c
> +++ b/hw/xen/xen-pvh-common.c
> @@ -194,7 +194,9 @@ static void xen_pvh_init(MachineState *ms)
>      }
>  
>      xen_pvh_init_ram(s, sysmem);
> -    xen_register_ioreq(&s->ioreq, ms->smp.max_cpus, &xen_memory_listener);
> +    xen_register_ioreq(&s->ioreq, ms->smp.max_cpus,
> +                       HVM_IOREQSRV_BUFIOREQ_ATOMIC,
> +                       &xen_memory_listener);
>  
>      if (s->cfg.virtio_mmio_num) {
>          xen_create_virtio_mmio_devices(s);
> diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
> index 3d796235dc..7246941fe5 100644
> --- a/include/hw/xen/xen-hvm-common.h
> +++ b/include/hw/xen/xen-hvm-common.h
> @@ -81,6 +81,8 @@ typedef struct XenIOState {
>      QLIST_HEAD(, XenPciDevice) dev_list;
>      DeviceListener device_listener;
>  
> +    bool has_bufioreq;
> +
>      Notifier exit;
>  } XenIOState;
>  
> @@ -95,6 +97,7 @@ void xen_device_unrealize(DeviceListener *listener, DeviceState *dev);
>  
>  void xen_hvm_change_state_handler(void *opaque, bool running, RunState rstate);
>  void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
> +                        int handle_bufioreq,
>                          const MemoryListener *xen_memory_listener);
>  
>  void cpu_ioreq_pio(ioreq_t *req);
> diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> index 1a5ad693a4..5caf91a616 100644
> --- a/include/hw/xen/xen_native.h
> +++ b/include/hw/xen/xen_native.h
> @@ -464,10 +464,11 @@ static inline void xen_unmap_pcidev(domid_t dom,
>  }
>  
>  static inline int xen_create_ioreq_server(domid_t dom,
> +                                          int handle_bufioreq,
>                                            ioservid_t *ioservid)
>  {
>      int rc = xendevicemodel_create_ioreq_server(xen_dmod, dom,
> -                                                HVM_IOREQSRV_BUFIOREQ_ATOMIC,
> +                                                handle_bufioreq,
>                                                  ioservid);
>  
>      if (rc == 0) {
> -- 
> 2.43.0
> 

