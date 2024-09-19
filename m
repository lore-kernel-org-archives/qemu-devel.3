Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D86FCF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 17:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srLHc-0006vW-QA; Thu, 19 Sep 2024 13:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1srLHb-0006oz-66
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:49:35 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1srLHZ-0001k7-5u
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:49:34 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-49bcd11fc37so352637137.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726768172; x=1727372972; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mfx9nDEwWLIpKCVHRneBH4hvuTBkLiiktuVJaawU2nY=;
 b=EuESq0TTxQZNiGoYWrkADpNFGBzIxIW/aWWIuLpwo7A0Od2By2toGjZx9fzIsz8QYI
 N8vru28BnC1MDTH5yiLxMhI+/NmNAfGCW2zBb9wPAm2PKfKD+4ZDEzNlTgZMSYgP+1vl
 SXIPHudxReJgDQ4SiXkDvtaaAEARXw9b6/bbVCvmKy3LKaHFHA1FP2bs5jEHnFeiILbH
 uoBc5Bh27kPRdy9hHoa0N6gHQzgn+nyHxHecZ3lO8kf8IkhhP4nZvqbTF/FwaKdpNvIj
 53J9eJZCOACF5Jq3hXMvcXfnOEsp9lTgpSMQJ05Avez4WUpStp336JIisYxjQ6siyG1d
 0enA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726768172; x=1727372972;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mfx9nDEwWLIpKCVHRneBH4hvuTBkLiiktuVJaawU2nY=;
 b=WUoKyrG0VOt8set8AQkUR/S4atVQlaBJmMYE357886Sv2c8S/felf0ZOV60tHZTuow
 AuvDecR9j6+l9hiF3mJF/o+L1JP2J2RzEG+IsFnkuyFxp94+kjBfWU0I91+Tr9IRA3xI
 4eF2w6QUJnHQiAq4znMstHVCcG+8BbPoU6nCv8DupQQhoU+jMEBvncuQT9+0IkLOfxqt
 UJkWd9bSBDiE+YpiUAz9CZUiXRTCE28KvUGyxLgZUN6VF29wIWH9Pe5q3K1MZNYlv0Hs
 d29bKtMvA2TrgOqebY7gTCmUpx9XlQyeP6cOFHZrPipNOTilFvDQabiNxSl0qhiKfkyx
 09Ow==
X-Gm-Message-State: AOJu0YxVaL37E0bztVstkxiX1E88JiqfX6CccO75dyb8SCKyG0yL0kMX
 NpMg5lzNGveZwa1OFoULyVd/v+d+tfDa+l2+cgLMmo0F2yxdAhGW
X-Google-Smtp-Source: AGHT+IHTkyX02sK/cO/7bvsYYZGFbcED+nb78Jl8L86g6nddDbJklOYonskHWI5JM7i6dGduHNz0WA==
X-Received: by 2002:a05:6102:5493:b0:49b:dd30:d168 with SMTP id
 ada2fe7eead31-49fc7540d7emr465523137.2.1726768171832; 
 Thu, 19 Sep 2024 10:49:31 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-8493985d1bfsm1459263241.20.2024.09.19.10.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 10:49:30 -0700 (PDT)
Date: Thu, 19 Sep 2024 19:28:32 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v1 1/4] xen: Expose handle_bufioreq in xen_register_ioreq
Message-ID: <ZuxfQAAAdP1JqT0k@zapote>
References: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
 <20240916150853.1216703-2-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2409161643090.1417852@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2409161643090.1417852@ubuntu-linux-20-04-desktop>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vs1-xe2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Sep 16, 2024 at 04:45:34PM -0700, Stefano Stabellini wrote:
> On Mon, 16 Sep 2024, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > 
> > Expose handle_bufioreq in xen_register_ioreq().
> > This is to allow machines to enable or disable buffered ioreqs.
> > 
> > No functional change since all callers still set it to
> > HVM_IOREQSRV_BUFIOREQ_ATOMIC.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  hw/i386/xen/xen-hvm.c           |   4 +-
> >  hw/xen/xen-hvm-common.c         | 100 +++++++++++++++++++-------------
> >  hw/xen/xen-pvh-common.c         |   4 +-
> >  include/hw/xen/xen-hvm-common.h |   3 +
> >  include/hw/xen/xen_native.h     |   3 +-
> >  5 files changed, 70 insertions(+), 44 deletions(-)
> > 
> > diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> > index 4f6446600c..d3df488c48 100644
> > --- a/hw/i386/xen/xen-hvm.c
> > +++ b/hw/i386/xen/xen-hvm.c
> > @@ -614,7 +614,9 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
> >  
> >      state = g_new0(XenIOState, 1);
> >  
> > -    xen_register_ioreq(state, max_cpus, &xen_memory_listener);
> > +    xen_register_ioreq(state, max_cpus,
> > +                       HVM_IOREQSRV_BUFIOREQ_ATOMIC,
> > +                       &xen_memory_listener);
> >  
> >      xen_is_stubdomain = xen_check_stubdomain(state->xenstore);
> >  
> > diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> > index 3a9d6f981b..d8824cccf1 100644
> > --- a/hw/xen/xen-hvm-common.c
> > +++ b/hw/xen/xen-hvm-common.c
> > @@ -667,6 +667,8 @@ static int xen_map_ioreq_server(XenIOState *state)
> >      xen_pfn_t ioreq_pfn;
> >      xen_pfn_t bufioreq_pfn;
> >      evtchn_port_t bufioreq_evtchn;
> > +    unsigned long num_frames = 1;
> > +    unsigned long frame = 1;
> >      int rc;
> >  
> >      /*
> > @@ -675,59 +677,72 @@ static int xen_map_ioreq_server(XenIOState *state)
> >       */
> >      QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_bufioreq != 0);
> >      QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_ioreq(0) != 1);
> > +
> > +    if (state->has_bufioreq) {
> > +        frame = 0;
> > +        num_frames = 2;
> > +    }
> >      state->fres = xenforeignmemory_map_resource(xen_fmem, xen_domid,
> >                                           XENMEM_resource_ioreq_server,
> > -                                         state->ioservid, 0, 2,
> > +                                         state->ioservid,
> > +                                         frame, num_frames,
> >                                           &addr,
> >                                           PROT_READ | PROT_WRITE, 0);
> >      if (state->fres != NULL) {
> >          trace_xen_map_resource_ioreq(state->ioservid, addr);
> > -        state->buffered_io_page = addr;
> > -        state->shared_page = addr + XC_PAGE_SIZE;
> > +        state->shared_page = addr;
> > +        if (state->has_bufioreq) {
> > +            state->buffered_io_page = addr;
> > +            state->shared_page = addr + XC_PAGE_SIZE;
> > +        }
> >      } else if (errno != EOPNOTSUPP) {
> >          error_report("failed to map ioreq server resources: error %d handle=%p",
> >                       errno, xen_xc);
> >          return -1;
> >      }
> >  
> > -    rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
> > -                                   (state->shared_page == NULL) ?
> > -                                   &ioreq_pfn : NULL,
> > -                                   (state->buffered_io_page == NULL) ?
> > -                                   &bufioreq_pfn : NULL,
> > -                                   &bufioreq_evtchn);
> > -    if (rc < 0) {
> > -        error_report("failed to get ioreq server info: error %d handle=%p",
> > -                     errno, xen_xc);
> > -        return rc;
> > -    }
> > -
> > -    if (state->shared_page == NULL) {
> > -        trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
> > +    if (state->has_bufioreq) {
> > +        rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
> > +                                       (state->shared_page == NULL) ?
> > +                                       &ioreq_pfn : NULL,
> > +                                       (state->buffered_io_page == NULL) ?
> > +                                       &bufioreq_pfn : NULL,
> > +                                       &bufioreq_evtchn);
> > +        if (rc < 0) {
> > +            error_report("failed to get ioreq server info: error %d handle=%p",
> > +                    errno, xen_xc);
> > +            return rc;
> > +        }
> >  
> > -        state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
> > -                                                  PROT_READ | PROT_WRITE,
> > -                                                  1, &ioreq_pfn, NULL);
> >          if (state->shared_page == NULL) {
> > -            error_report("map shared IO page returned error %d handle=%p",
> > -                         errno, xen_xc);
> > +            trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
> > +
> > +            state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
> > +                                                      PROT_READ | PROT_WRITE,
> > +                                                      1, &ioreq_pfn, NULL);
> > +            if (state->shared_page == NULL) {
> > +                error_report("map shared IO page returned error %d handle=%p",
> > +                        errno, xen_xc);
> > +            }
> >          }
> > -    }
> 
> 
> If I am reading the code right the calls to xen_get_ioreq_server_info
> and xenforeignmemory_map were not done to setup bufioreq. They were done
> for legacy compatibility to support systems where
> xenforeignmemory_map_resource returns EOPNOTSUPP.
> 
> I think we should either get rid of this legacy path completely, or
> keep it for both bufioreq and non-bufioreq.


Yes, I'll fix the conditions and keep the legacy code for now!

Cheers,
Edgar


> 
> 
> 
> > -    if (state->buffered_io_page == NULL) {
> > -        trace_xen_map_ioreq_server_buffered_io_page(bufioreq_pfn);
> > -
> > -        state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
> > -                                                       PROT_READ | PROT_WRITE,
> > -                                                       1, &bufioreq_pfn,
> > -                                                       NULL);
> >          if (state->buffered_io_page == NULL) {
> > -            error_report("map buffered IO page returned error %d", errno);
> > -            return -1;
> > +            trace_xen_map_ioreq_server_buffered_io_page(bufioreq_pfn);
> > +
> > +            state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
> > +                    PROT_READ | PROT_WRITE,
> > +                    1, &bufioreq_pfn,
> > +                    NULL);
> > +            if (state->buffered_io_page == NULL) {
> > +                error_report("map buffered IO page returned error %d", errno);
> > +                return -1;
> > +            }
> >          }
> >      }
> >  
> > -    if (state->shared_page == NULL || state->buffered_io_page == NULL) {
> > +
> > +    if (state->shared_page == NULL ||
> > +        (state->has_bufioreq && state->buffered_io_page == NULL)) {
> >          return -1;
> >      }
> >  
> > @@ -830,14 +845,15 @@ static void xen_do_ioreq_register(XenIOState *state,
> >          state->ioreq_local_port[i] = rc;
> >      }
> >  
> > -    rc = qemu_xen_evtchn_bind_interdomain(state->xce_handle, xen_domid,
> > -                                          state->bufioreq_remote_port);
> > -    if (rc == -1) {
> > -        error_report("buffered evtchn bind error %d", errno);
> > -        goto err;
> > +    if (state->has_bufioreq) {
> > +        rc = qemu_xen_evtchn_bind_interdomain(state->xce_handle, xen_domid,
> > +                                              state->bufioreq_remote_port);
> > +        if (rc == -1) {
> > +            error_report("buffered evtchn bind error %d", errno);
> > +            goto err;
> > +        }
> > +        state->bufioreq_local_port = rc;
> >      }
> > -    state->bufioreq_local_port = rc;
> > -
> >      /* Init RAM management */
> >  #ifdef XEN_COMPAT_PHYSMAP
> >      xen_map_cache_init(xen_phys_offset_to_gaddr, state);
> > @@ -865,6 +881,7 @@ err:
> >  }
> >  
> >  void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
> > +                        int handle_bufioreq,
> >                          const MemoryListener *xen_memory_listener)
> >  {
> >      int rc;
> > @@ -883,7 +900,8 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
> >          goto err;
> >      }
> >  
> > -    rc = xen_create_ioreq_server(xen_domid, &state->ioservid);
> > +    state->has_bufioreq = handle_bufioreq != HVM_IOREQSRV_BUFIOREQ_OFF;
> > +    rc = xen_create_ioreq_server(xen_domid, handle_bufioreq, &state->ioservid);
> >      if (!rc) {
> >          xen_do_ioreq_register(state, max_cpus, xen_memory_listener);
> >      } else {
> > diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> > index 28d7168446..08641fdcec 100644
> > --- a/hw/xen/xen-pvh-common.c
> > +++ b/hw/xen/xen-pvh-common.c
> > @@ -194,7 +194,9 @@ static void xen_pvh_init(MachineState *ms)
> >      }
> >  
> >      xen_pvh_init_ram(s, sysmem);
> > -    xen_register_ioreq(&s->ioreq, ms->smp.max_cpus, &xen_memory_listener);
> > +    xen_register_ioreq(&s->ioreq, ms->smp.max_cpus,
> > +                       HVM_IOREQSRV_BUFIOREQ_ATOMIC,
> > +                       &xen_memory_listener);
> >  
> >      if (s->cfg.virtio_mmio_num) {
> >          xen_create_virtio_mmio_devices(s);
> > diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
> > index 3d796235dc..7246941fe5 100644
> > --- a/include/hw/xen/xen-hvm-common.h
> > +++ b/include/hw/xen/xen-hvm-common.h
> > @@ -81,6 +81,8 @@ typedef struct XenIOState {
> >      QLIST_HEAD(, XenPciDevice) dev_list;
> >      DeviceListener device_listener;
> >  
> > +    bool has_bufioreq;
> > +
> >      Notifier exit;
> >  } XenIOState;
> >  
> > @@ -95,6 +97,7 @@ void xen_device_unrealize(DeviceListener *listener, DeviceState *dev);
> >  
> >  void xen_hvm_change_state_handler(void *opaque, bool running, RunState rstate);
> >  void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
> > +                        int handle_bufioreq,
> >                          const MemoryListener *xen_memory_listener);
> >  
> >  void cpu_ioreq_pio(ioreq_t *req);
> > diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> > index 1a5ad693a4..5caf91a616 100644
> > --- a/include/hw/xen/xen_native.h
> > +++ b/include/hw/xen/xen_native.h
> > @@ -464,10 +464,11 @@ static inline void xen_unmap_pcidev(domid_t dom,
> >  }
> >  
> >  static inline int xen_create_ioreq_server(domid_t dom,
> > +                                          int handle_bufioreq,
> >                                            ioservid_t *ioservid)
> >  {
> >      int rc = xendevicemodel_create_ioreq_server(xen_dmod, dom,
> > -                                                HVM_IOREQSRV_BUFIOREQ_ATOMIC,
> > +                                                handle_bufioreq,
> >                                                  ioservid);
> >  
> >      if (rc == 0) {
> > -- 
> > 2.43.0
> > 

