Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72D2C87FDA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 09:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujajQ-0007jC-LQ; Wed, 06 Aug 2025 05:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujaiT-0007D4-Py
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujaiR-0005sE-8S
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754473545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1XAmqBs/fphM8gaMz/XHiiGE8lEiQWGOyyNk09ttro=;
 b=EH8XwNS+vlckoafZgyIJE/cv35AIh5GAXvyFucI9ToUiQZpYeAPb8SLLvR8QjRdR/ONXfx
 Dx1q9HsrAjyGPJOC9dgr74lQSk23ExRDENqWBjT5qcJapixYMLKnXMPvQv5NcjAGbmpuSy
 fQpvQZZLY9SuDdOdXjz8QxIxNTaqXyM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-bwTY-nVQN9qis3QBkX_fMg-1; Wed, 06 Aug 2025 05:45:44 -0400
X-MC-Unique: bwTY-nVQN9qis3QBkX_fMg-1
X-Mimecast-MFC-AGG-ID: bwTY-nVQN9qis3QBkX_fMg_1754473543
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-242aa2e4887so2948905ad.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 02:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754473543; x=1755078343;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I1XAmqBs/fphM8gaMz/XHiiGE8lEiQWGOyyNk09ttro=;
 b=RtabrxfNMxerCq+jDjYTyKtfFPcV41/W8lFFxhf9qj0gnbkONMcUoD6LlLIEZkaH1g
 U1WUZv0enomUdOUQ4W/mLXFKm18C+5gOn+6Sp+T+pJKeNnWa04iGS+bUpl4/bCMPb/L6
 8/f3UAlPTtLvUoPbOo+hMewo+JOQTO3DMECy/aqOS2I3epEhvP8mlWQo8yq3Tk3b4g4R
 dir1DuPuTVBd1CdtDxB82wXW7oqmz/twbk6An58cdATGSh3tQ9q25ZHfq7FHipNIiph6
 bcJCxy5YAE13LOC6VLmGzQzZli+lSZ1KhabHvjozQGws6YS5487EnHoDxpXRPC0Dsx6N
 bNrg==
X-Gm-Message-State: AOJu0YyAIgxVOkXhYsyughxArRm7e8wlRI44TmETNQq8OEiGOUYBZM/+
 25zHvn/s7g8aVFpVGiZmJ1bM/Yq2Dx0zuX0jNdTYz9sUvt9OYvop4xDCdiPlMK0pe5gZZcud7A3
 A3RFRI5KOfHGrViQ+AHEmceYELYU3EI/+rdpS5bcaxOuMZ+JkH+9w45Pi
X-Gm-Gg: ASbGnctXRBblful7yOy/YI6bSRec2x6gAU3QZsysdiQ32PK1n9D9/hs2I5U43LuukSY
 Nb7rN3frWRBFg8mlj7wSWcsK94MHgPltlmOc0Hv5hflTaDnKjdX652HcAoT9qXrBCpz5zh0zcI1
 ZMTw31QFHx2oo+Y/TNXtmyMWDYCEYd48Z3nWsPcbjyH8TOhAjJexsqlIj9GP7VkK71HUGnEqz43
 3p4tK292hQtMr1yOPxI6VId/UJYLqlQ/E857M28/9QONNMSjKiz+YsDONhTcYuMaJGH6FMmWTuk
 Cfq4uhaDfqDhVlNiXpvqXHc3GzBWYXtYM/nuOOA+XBr70MYOkBBP+Q==
X-Received: by 2002:a17:902:f687:b0:240:aa0:1584 with SMTP id
 d9443c01a7336-242a0b8bc9fmr27983815ad.38.1754473542899; 
 Wed, 06 Aug 2025 02:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPzEMTFG/PPAEK1naGR0uu8hclqjC4IkX7ZM7cWmBmkjLeBunM+OFR+e23UVFH+fUV1rO9hQ==
X-Received: by 2002:a17:902:f687:b0:240:aa0:1584 with SMTP id
 d9443c01a7336-242a0b8bc9fmr27983495ad.38.1754473542499; 
 Wed, 06 Aug 2025 02:45:42 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.249])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e89a3a6fsm153560595ad.147.2025.08.06.02.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 02:45:42 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:15:30 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 23/27] migration: Refactor vmstate_save_state_v()
 function
Message-ID: <aJMkOipj4cXnrI7O@armenon-kvm.bengluru.csb>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-23-123450810db7@redhat.com>
 <CAMxuvax_9EP3T0PwAknxb3B_-3S_D3saQqZ+u3z1Sc6zAaS4OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvax_9EP3T0PwAknxb3B_-3S_D3saQqZ+u3z1Sc6zAaS4OQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Marc-André,
Thanks for the review.

On Wed, Aug 06, 2025 at 12:19:29PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Aug 5, 2025 at 10:31 PM Arun Menon <armenon@redhat.com> wrote:
> 
> > The original vmstate_save_state_v() function combined multiple
> > responsibilities like calling pre-save hooks, saving the state of
> > the device, handling subsection saves and invoking post-save hooks.
> > This led to a lengthy and less readable function.
> >
> > To address this, introduce wrapper functions for pre-save,
> > post-save and the device-state save functionalities.
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  migration/vmstate.c | 78
> > ++++++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 60 insertions(+), 18 deletions(-)
> >
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index
> > 60ff38858cf54277992fa5eddeadb6f3d70edec3..fbc59caadbbcc75fe6de27b459aa9aa25e76aa0a
> > 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -414,22 +414,43 @@ int vmstate_save_state_with_err(QEMUFile *f, const
> > VMStateDescription *vmsd,
> >      return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id,
> > vmsd->version_id, errp);
> >  }
> >
> > -int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> > -                         void *opaque, JSONWriter *vmdesc, int
> > version_id, Error **errp)
> > +static int pre_save_dispatch(const VMStateDescription *vmsd, void *opaque,
> > +                             Error **errp)
> >  {
> >      int ret = 0;
> > -    const VMStateField *field = vmsd->fields;
> > -
> > -    trace_vmstate_save_state_top(vmsd->name);
> > -
> >      if (vmsd->pre_save) {
> >          ret = vmsd->pre_save(opaque);
> >          trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> >          if (ret) {
> > -            error_setg(errp, "pre-save failed: %s", vmsd->name);
> > -            return ret;
> > +            error_setg(errp, "pre-save for %s failed, ret: %d",
> > +                       vmsd->name, ret);
> >          }
> >      }
> > +    return ret;
> > +}
> > +
> > +static int post_save_dispatch(const VMStateDescription *vmsd, void
> > *opaque,
> > +                              Error **errp)
> > +{
> > +    int ret = 0;
> > +    if (vmsd->post_save) {
> > +        ret = vmsd->post_save(opaque);
> 
> +        error_setg(errp, "post-save for %s failed, ret: %d",
> > +                   vmsd->name, ret);
> >
> 
> Only set errp if ret != 0
> 
Yes, missed this one.
> 
> > +    }
> > +    return ret;
> > +}
> > +
> > +static int vmstate_save_dispatch(QEMUFile *f,
> > +                                 const VMStateDescription *vmsd,
> > +                                 void *opaque, JSONWriter *vmdesc,
> > +                                 int version_id, Error **errp)
> > +{
> > +    ERRP_GUARD();
> > +    int ret = 0;
> > +    int ps_ret = 0;
> > +    Error *local_err = NULL;
> > +    const VMStateField *field = vmsd->fields;
> >
> >      if (vmdesc) {
> >          json_writer_str(vmdesc, "vmsd_name", vmsd->name);
> > @@ -532,9 +553,7 @@ int vmstate_save_state_v(QEMUFile *f, const
> > VMStateDescription *vmsd,
> >                  if (ret) {
> >                      error_setg(errp, "Save of field %s/%s failed",
> >                                  vmsd->name, field->name);
> > -                    if (vmsd->post_save) {
> > -                        vmsd->post_save(opaque);
> > -                    }
> > +                    ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
> >
> 
> why keep ps_ret ?
It is not required.
> 
> What do you do of local_err ?
Should be freed. We do nothing with this. In the next patch it is propagated, and
previous error is dismissed. But that will no longer be the case if the behaviour of
post_save is is kept the same (from the discussion on changeing post_save() to cleanup_save())

> 
> 
> >                      return ret;
> >                  }
> >
> > @@ -557,16 +576,39 @@ int vmstate_save_state_v(QEMUFile *f, const
> > VMStateDescription *vmsd,
> >      if (vmdesc) {
> >          json_writer_end_array(vmdesc);
> >      }
> > +    return ret;
> > +}
> >
> > -    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
> >
> > -    if (vmsd->post_save) {
> > -        int ps_ret = vmsd->post_save(opaque);
> > -        if (!ret && ps_ret) {
> > -            ret = ps_ret;
> > -            error_setg(errp, "post-save failed: %s", vmsd->name);
> > -        }
> > +int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> > +                         void *opaque, JSONWriter *vmdesc, int version_id,
> > +                         Error **errp)
> > +{
> > +    ERRP_GUARD();
> > +    int ret = 0;
> > +    Error *local_err = NULL;
> > +    int ps_ret = 0;
> > +
> > +    trace_vmstate_save_state_top(vmsd->name);
> > +
> > +    ret = pre_save_dispatch(vmsd, opaque, errp);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    ret = vmstate_save_dispatch(f, vmsd, opaque, vmdesc,
> > +                                version_id, errp);
> > +    if (ret) {
> > +        return ret
> 
> 
> post_save_dispatch() should be called on failure.
> 
> >
> >      }
> > +
> > +    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
> >
> 
> Imho this should be moved back to the vmstate_save_dispatch()
> 
> +    ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
> > +    if (!ret && ps_ret) {
> > +        ret = ps_ret;
> > +        error_setg(errp, "post-save failed: %s", vmsd->name);
> >
> 
> And then you can have a single place to call post_save_dispatch() - remove
> it from vmstate_subsection_save -> you mean vmstate_save_state_v()?
> 
> It should probably call error_propagate() instead.
Yes, we can move vmstate_subsection_save() and the subsequent call
to post_save() here.
Shall do, if we are planning to keep this behavior for post_save.
Otherwise we can just keep things as is, and just change post_save() return
value and naming.
> 
> 
> 
> > +    }
> > +
> >      return ret;
> >  }
> >
> >
> > --
> > 2.50.1
> >
> >

Regards,
Arun


