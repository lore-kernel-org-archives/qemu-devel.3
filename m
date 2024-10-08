Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24691CEFC21
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 16:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syCrm-00060x-K7; Tue, 08 Oct 2024 12:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1syCrj-00060O-W6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:15:16 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1syCrg-0007V5-U4
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:15:15 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fac63abf63so57321011fa.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728404111; x=1729008911; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMIvpHcd45lnY83/T5RuSlqtxEHFtUU4rXlFswYQzkM=;
 b=eeJB2rgZt2YqgfnPyPxvh2ceuax640O+ywTg2QstJxROj+fP1s4rqGAljSpjKf7KT4
 haH+w0N3ZysR6Ws6zFDuhmvktuQKYtqiD00P28m/zeKa4Fx0rGc58nUJ+wZdbfIMzkDz
 3gF1c0uYEGEg0M5s4TKjJOFG84aRAAXobZ4nThNNy86Gj1+okXyAgbjTfkS9GEH4Bqg7
 GHu7c92Pg3p3ga15F3KoTQaPeWJgiX3TvcHmquGBcYj64sDGysuYYTJUsnelCYof+yHi
 71t07OgDmeFjzQy5bXjqCRqjiCFqJFx2igcmVfWL+o5eliJPkL17uLRsqhr0fEujzyMu
 na1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728404111; x=1729008911;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMIvpHcd45lnY83/T5RuSlqtxEHFtUU4rXlFswYQzkM=;
 b=IsnNawqgzqu7C4gblahyJ7HYyQy/G55ZUnAXv5xpSVPSzk2r7h+L+hb6PMff90zxQR
 YlXKdCIAqXUqP1TBbvu+fe5EI/cqJY4YmAUU3obQMTN1zLcptlZoR63XWZ6RFoeoIQfO
 UmqnHgT4t52ULMZrGKC7ia24fbW/VeywBiFZ0I3gR30cuKaTLUV6fc33Di6rt0VWV8OY
 ncfa7RuPIg78g4dxSvpgjwfGujNV6PyfDrfrnOU5PMg8i27zOUA/ApvLDAbX4mhbclTW
 VVkAXuGaQGiD5i2s27o8mi5jIIDfR6/afzezfvJ2Q1j0V5WU9XcMuWUQehdiwBWt2hyd
 oa5w==
X-Gm-Message-State: AOJu0YyhWO3oR8zRWyDkksH1J3P9HTHdx0r5CYVRQj4E6sg/ApBileg7
 326XdDg6xy7+Q/7j7vCmm9oCExxez+3dlLIc4zfLRYFna82RNQBk
X-Google-Smtp-Source: AGHT+IGDWMbqRpqybixokuuP3QnOFg281QMvVsPNrT/ERnJ4OB4eKlTCgCDG90riRqCH5QN2YB4N+Q==
X-Received: by 2002:a2e:bea7:0:b0:2fb:c20:dbc5 with SMTP id
 38308e7fff4ca-2fb0c20dc90mr31779931fa.29.1728404110528; 
 Tue, 08 Oct 2024 09:15:10 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9ab16d6sm12134871fa.9.2024.10.08.09.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 09:15:09 -0700 (PDT)
Date: Tue, 8 Oct 2024 18:15:09 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org,
 paul@xen.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PULL v2 2/5] hw/xen: Expose handle_bufioreq in xen_register_ioreq
Message-ID: <ZwVaje_9lg9lwavh@zapote>
References: <20241003185655.1480819-1-edgar.iglesias@gmail.com>
 <20241003185655.1480819-3-edgar.iglesias@gmail.com>
 <CAFEAcA9SgThjVW=VY_ZeKZh0bAe+rbTReK00DAQEXgMwD8cNqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9SgThjVW=VY_ZeKZh0bAe+rbTReK00DAQEXgMwD8cNqQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Oct 07, 2024 at 04:42:49PM +0100, Peter Maydell wrote:
> On Thu, 3 Oct 2024 at 19:57, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> >
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >
> > Expose handle_bufioreq in xen_register_ioreq().
> > This is to allow machines to enable or disable buffered ioreqs.
> >
> > No functional change since all callers still set it to
> > HVM_IOREQSRV_BUFIOREQ_ATOMIC.
> >
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> 
> Hi; Coverity has noticed a problem (CID 1563383) with this change:
> 
> > diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> > index 3a9d6f981b..7d2b72853b 100644
> > --- a/hw/xen/xen-hvm-common.c
> > +++ b/hw/xen/xen-hvm-common.c
> > @@ -667,6 +667,8 @@ static int xen_map_ioreq_server(XenIOState *state)
> >      xen_pfn_t ioreq_pfn;
> >      xen_pfn_t bufioreq_pfn;
> >      evtchn_port_t bufioreq_evtchn;
> 
> In this function bufioreq_evtchn is declared uninitialized...
> 
> > +    unsigned long num_frames = 1;
> > +    unsigned long frame = 1;
> >      int rc;
> >
> >      /*
> > @@ -675,59 +677,78 @@ static int xen_map_ioreq_server(XenIOState *state)
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
> 
> ...which was OK prior to this change, because (ignoring the
> early-exit case) we would always pass through this function
> call, which initializes bufioreq_evtchn...
> 
> > -    if (rc < 0) {
> > -        error_report("failed to get ioreq server info: error %d handle=%p",
> > -                     errno, xen_xc);
> > -        return rc;
> > -    }
> > +    /*
> > +     * If we fail to map the shared page with xenforeignmemory_map_resource()
> > +     * or if we're using buffered ioreqs, we need xen_get_ioreq_server_info()
> > +     * to provide the the addresses to map the shared page and/or to get the
> > +     * event-channel port for buffered ioreqs.
> > +     */
> > +    if (state->shared_page == NULL || state->has_bufioreq) {
> > +        rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
> > +                                       (state->shared_page == NULL) ?
> > +                                       &ioreq_pfn : NULL,
> > +                                       (state->has_bufioreq &&
> > +                                        state->buffered_io_page == NULL) ?
> > +                                       &bufioreq_pfn : NULL,
> > +                                       &bufioreq_evtchn);
> 
> ...but now the initialization has moved inside an if() so it only
> happens under certain conditions...
> 
> > +        if (rc < 0) {
> > +            error_report("failed to get ioreq server info: error %d handle=%p",
> > +                         errno, xen_xc);
> > +            return rc;
> > +        }
> >
> > -    if (state->shared_page == NULL) {
> > -        trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
> > +        if (state->shared_page == NULL) {
> > +            trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
> >
> > -        state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
> > -                                                  PROT_READ | PROT_WRITE,
> > -                                                  1, &ioreq_pfn, NULL);
> > +            state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
> > +                                                      PROT_READ | PROT_WRITE,
> > +                                                      1, &ioreq_pfn, NULL);
> > +        }
> >          if (state->shared_page == NULL) {
> >              error_report("map shared IO page returned error %d handle=%p",
> >                           errno, xen_xc);
> >          }
> > -    }
> >
> > -    if (state->buffered_io_page == NULL) {
> > -        trace_xen_map_ioreq_server_buffered_io_page(bufioreq_pfn);
> > +        if (state->has_bufioreq && state->buffered_io_page == NULL) {
> > +            trace_xen_map_ioreq_server_buffered_io_page(bufioreq_pfn);
> >
> > -        state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
> > -                                                       PROT_READ | PROT_WRITE,
> > -                                                       1, &bufioreq_pfn,
> > -                                                       NULL);
> > -        if (state->buffered_io_page == NULL) {
> > -            error_report("map buffered IO page returned error %d", errno);
> > -            return -1;
> > +            state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
> > +                                                        PROT_READ | PROT_WRITE,
> > +                                                        1, &bufioreq_pfn,
> > +                                                        NULL);
> > +            if (state->buffered_io_page == NULL) {
> > +                error_report("map buffered IO page returned error %d", errno);
> > +                return -1;
> > +            }
> >          }
> >      }
> >
> > -    if (state->shared_page == NULL || state->buffered_io_page == NULL) {
> > +    if (state->shared_page == NULL ||
> > +        (state->has_bufioreq && state->buffered_io_page == NULL)) {
> >          return -1;
> >      }
> 
> ...and the tail end of the function has not been modified, so
> (not visible in this diff context) when we do:
> 
>     trace_xen_map_ioreq_server_buffered_io_evtchn(bufioreq_evtchn);
> 
>     state->bufioreq_remote_port = bufioreq_evtchn;
> 
>     return 0;
> 
> we may be using it uninitialized (in the trace statement
> and when assigning it to state->bufioreq_remote_port).
> 
> Could you have a look at this and send a fix, please?
>

Thanks Peter,

I sent a fix for this yesterday.

Best regards,
Edgar

