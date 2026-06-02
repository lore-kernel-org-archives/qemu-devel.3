Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D1FCD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 20:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUVYf-0002OB-28; Tue, 02 Jun 2026 16:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUVYe-0002Nq-46
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 16:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUVYc-0001xo-Cy
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 16:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780431469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yCZDeTUVjexxQ+9Tvw+5WbQmA7tbbYmLsrSFhthH/mQ=;
 b=IzFD1EG5BTIhCvT2tiVcnqzWzO8Geo3QWUx5sSCzLSgPpDZapRAqztHUZ+rP7PL5LwLxR/
 dpnMqgGer/V2R+k2Dz+FESzfnPO+2Lt34GtyMOI4PoRoOxCkm0nM95tMpNH9gh8EghdULa
 t1iVWmWGwrgdJQH5gILg/TQh1h3zYJ0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-HFXUC4zOM8eP2mVmSYn9Jg-1; Tue, 02 Jun 2026 16:17:47 -0400
X-MC-Unique: HFXUC4zOM8eP2mVmSYn9Jg-1
X-Mimecast-MFC-AGG-ID: HFXUC4zOM8eP2mVmSYn9Jg_1780431466
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51766317074so32249611cf.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780431466; x=1781036266; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yCZDeTUVjexxQ+9Tvw+5WbQmA7tbbYmLsrSFhthH/mQ=;
 b=GPrGbsmidFdLqNvJemsLJn8XtOzslN3bpEPlTaOWUSicmhDH1w+n6BAAF+OgKgFwJl
 FM//AowvELFudGO6MK7069x0Sb34FXemJZwXkpH7FFaZEn+v/elDsZtKXw5RTyQgj3nl
 bwiPmUdGDAirmS9gKKqUGtBcNNJejsm2SYV5wSz5DNk3ieZJRpKQDrcA/2KFMoocMYQm
 bibIOQ9Mp32BOsuKh/pd7Gv/t59V79dPXyvkf8qBKINUXsQmqSooH/PRWTLdwPl0kowC
 rOlesD0N+iHFnQuRlxil3cYK4OfsN9SEyjCLPKNotSppdqFIoTpGcI96qf9H96BbZIll
 pMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780431466; x=1781036266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCZDeTUVjexxQ+9Tvw+5WbQmA7tbbYmLsrSFhthH/mQ=;
 b=dAFAC9KI4aAaYsNZFkFIyZVfmGY6OjzGjCXOTLMy6we6hu69GDZNEKQ/jJ7tDH6pu6
 NHCad56AySgCzti0TKub7i11lIrK/D2XNKki3MmkAPz/ksQpLCXMR8KnrRMmkNlWNB2f
 pwee0mu4sRtt2eFd4R2c69AXmCJW3Tb62doFowAgUNNLGVh7VseOYLMKdMge8a+ITCth
 Ky5sNsIXaUznrrhWWMsm8Hw0qN7FAl/svIWqK1dta0O6WtSVex2aCdo2uyWn7XU9eQpI
 HAvcnwtyPz7u6DiAZnaCuSqarB+z8m+ZJEbzaYmyc7oK40su7KfwR7iAS8izl+P/vicU
 cNGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8AOg+/wRmb+TMJsqyBXozkg9gLaR0O/iGxpeZG4CgEufkqktHbsgUIOw0kUKS2ddCb4D1vFnC5oiqP@nongnu.org
X-Gm-Message-State: AOJu0YwdTnxUkTbSAwCLx2eQZXXzUkPuJVF3RY1h05BhbPYRDEoE7cgs
 K8zeg1fkwP54nVgYzd1YqqNuLbdMuVzexWfatMVgPhU+8VkmvpWIjzcc1qgJeDiq5DINbOEiNAQ
 92hHhKv+l/F6/GJmiWYUMovFCbQjWhThNhxjnsUpk4qRmduuPfr0WVQds
X-Gm-Gg: Acq92OFqZunmTBwm6f/4/tXHtCPzPIRmqTP1191oa7Eah/+I41Hoxm9CQETVtT+apNJ
 kb2zkvA1CWoPkNY+aPzt9oWSNgUNsfQqpILC+B4F28MpcgEZvTPalH+nm8BiCjan10EtIgftufP
 Z2r8Og6vpjC+t8+d67C8IHo0D5mJhrsts5cmS03slyJjDyW4j1M+tdjzcOFWmOz9dDzmqUfC5ra
 m9Ikx+TGJwly40YU7nqFBwzvSfqWindbZvCrXquFa9ImeaUJFajdAfwumdEZbpjYjYcZcWgMGXT
 2sP3Yu0z88e7fEWOz0+iZyfplV2MHrozVgZhPKuuHTgld6XKb4yBm8okW1p9lPjV7VRR5V2VcRZ
 r0r6vDSDGUvEQlLs7sRPFuPL+kw==
X-Received: by 2002:a05:622a:aa4b:20b0:516:f4f7:3318 with SMTP id
 d75a77b69052e-5177872dddamr8147411cf.48.1780431466005; 
 Tue, 02 Jun 2026 13:17:46 -0700 (PDT)
X-Received: by 2002:a05:622a:aa4b:20b0:516:f4f7:3318 with SMTP id
 d75a77b69052e-5177872dddamr8146821cf.48.1780431465480; 
 Tue, 02 Jun 2026 13:17:45 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775dd2e53sm6946921cf.24.2026.06.02.13.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 13:17:44 -0700 (PDT)
Date: Tue, 2 Jun 2026 16:17:43 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
Message-ID: <ah86Z0r5sMnxwgo-@x1.local>
References: <cover.1779217494.git.maciej.szmigiero@oracle.com>
 <743f03758d2a30df4093db140ccdd0f91f69bd7e.1779217494.git.maciej.szmigiero@oracle.com>
 <871peqtm5t.fsf@suse.de> <ah3eheRXN1QJAGj_@x1.local>
 <ac677bf9-1372-4905-a0b8-874a74be07be@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac677bf9-1372-4905-a0b8-874a74be07be@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 02, 2026 at 12:01:32PM +0200, Maciej S. Szmigiero wrote:
> On 1.06.2026 21:33, Peter Xu wrote:
> > On Mon, Jun 01, 2026 at 10:39:26AM -0300, Fabiano Rosas wrote:
> > > A bit idiosyncratic, but I don't have any better suggestions.
> > 
> > One thing I don't think proper with the current approach: if it's a real
> > "priority" it should be invoked always with high->low order, no matter if
> > running=true or not..  but that's not what will happen if we encode it with
> > the "depth" field.
> > 
> > That is an implication that we have two demands, and they aren't the same,
> > but this solution wrongly packed them together.
> > 
> > In 2023, VFIO already introduced VMChangeStateEntry.prepare_cb().  That is
> > a real impl of prority queues with only two: prepare_cb() always has higher
> > priority than the cb() itself.
> > 
> > Can VFIO simply leverage this existing interface, instead of hijacking
> > "depth" in an unwanted way?
> > 
> > I believe the _P2P states still need to happen first for all vfio devices,
> > then it can do the next step. Logically I think it can also be done
> > internally within VFIO by proper impl of these two callbacks, to achieve
> > both:
> > 
> > - Proper transition to P2P states first for all devices, meanwhile,
> > - Proper concurrency of all VFIO devices on device state transitions
> > 
> > Would that work in a cleaner way?
> 
> In the VFIO migration save/source code we have two transitions:
> PRE_COPY -> PRE_COPY_P2P done via prepare_cb() and
> PRE_COPY_P2P -> STOP_COPY done via cb().
> On the load/target side the situation is similar, only states are
> different.
> 
> For each of these transitions we need two callbacks: one has to launch
> per-VFIO device state change thread and the other one has to "collect"
> (or join) these threads.
> 
> All handlers of the first callback have to be complete before calling
> any handler of the second callback since otherwise there would be
> VFIO device vs VFIO device serialization.
> 
> Moreover, all the prepare_cb()-related transitions have to be done
> before any of the cb()-related is started.
> 
> 
> I presume what you suggest above is to launch per-VFIO device state
> transition thread in prepare_cb() which would then be responsible for
> doing *both* state transitions for this VFIO device.
> And then collect this thread in cb().

Yes.

> 
> However, this would need some extra interlocking:
> - A lock inside VFIO code shared by all VFIO devices making sure
> no VFIO device starts the second transition (the cb() one) before
> all VFIO devices finish the first transition (the prepare_cb() one).

Yes, more below.

> 
> - Looking at the current QEMU code, there are some non-VFIO cb()
> handlers registered via qdev_add_vm_change_state_handler() and
> quite a few handlers registered via qemu_add_vm_change_state_handler().
> 
> I presume these VFIO prepare_cb()-related transitions need to finish
> before calling any of these handlers to maintain the current ordering

IIUC, we don't necessarily need to keep this ordering; or do you see any
real demand of that?

What I see is that the order is only introduced due to P2P state of VFIO,
it seems very specific to me.

> so some kind of interlocking in vm_state_notify() between calling
> prepare_cb() and cb() may be necessary since any "prio" based
> ordering will have the same problem of reverse calling order on VM
> start vs stop.
> 
> 
> To be clear, I'm not insisting on the implementation from this patch -
> any alternative one that preserves the aforementioned ordering rules
> and has similar downtime performance is probably okay too.

The problem is, IIUC patch 1 needs better justification on its own, and I
feel like it's not doing the right thing, as discussed previously. So even
if we want to introduce a new priority-based approach, we may want to
rethink patch 1.

IMHO it'll be perfect if we can simply reuse prepare_cb().  It seems
working.

Due to this demand, I got to learn we have pthread_barrier_init(), but..
personally I like a simple atomic+event approach:

vfio thread:

  # Do step 1, ->P2P
  if (qatomic_fetch_inc(&vfio_p2p_done) + 1 == vfio_total_devices) {                                                                  
      qemu_event_set(&vfio_p2p_done_event);
  }                                                                  
  qemu_event_wait(&vfio_p2p_done_event);
  # Do step 2, ->STOPCOPY

cb() only join()s.

Would this work?

Thanks,

-- 
Peter Xu


