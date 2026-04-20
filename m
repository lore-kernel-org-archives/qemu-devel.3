Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2179AF588E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEq9j-0003vP-S4; Mon, 20 Apr 2026 11:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wEq9g-0003uG-9K
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 11:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wEq9e-0000lJ-2L
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 11:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776697396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pthMTNMqlXrlhPSp0jk3XCcHWOVSS3of+jZOr0KsTkI=;
 b=gUApSDi43ZXj7ori9lpTybVHSCcZTsDuRUs9Hz5AEuu0kY1SgZFA8cn7urXv7HPyXLHGYi
 062RQFwnaiUh5PZMQAvQT4vXkbRNPYohCIddqCr+hrwOfwhSOtnHX8+mCi4GfkaKuUGpSW
 Lt3VekRZcEieQbuICw6eXznkKZ6Ycpk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-UWynm5IaPNSI3oDTpaGe7w-1; Mon, 20 Apr 2026 11:03:14 -0400
X-MC-Unique: UWynm5IaPNSI3oDTpaGe7w-1
X-Mimecast-MFC-AGG-ID: UWynm5IaPNSI3oDTpaGe7w_1776697393
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35da4795b3cso6057252a91.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 08:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776697393; cv=none;
 d=google.com; s=arc-20240605;
 b=KMvWZ7Q1gcGqsYddAcd+wtjDBTiuMgPRf2XsIAtAzcB7QuRcMYbxXigBZwKROxYaKq
 gzBF2cynRGFRr75hAMF2yw6LItMWS6Vvc6DitwZE4QR8awZTbzbCNrUhsqRG2chzsT+2
 SUOlkaqfmpV8ybzW+2AlqBBk5EdbZItv2zi88VdlE9nKQqwexGs/ArXxReVWjoqoq/QL
 Kn+heLBu59S+2TUqLLOQdnxGoOsOGFL96FMUkpCGI8GmYZJ4Q+/+rOXdPfgcfYohhw98
 ufOUF9TAh1CWEXYPat97smB/3+EZQMz/9jWjTGDeoMxHnOOfuhMdpPpkKJWGkqKweew9
 5rOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pthMTNMqlXrlhPSp0jk3XCcHWOVSS3of+jZOr0KsTkI=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=Vf9WdSgN/kiMIViIyY+z6kDnM7Y9tQS1BcFwTHyM7fQgxkNoznTdYgMbmSwIrcDY4z
 OD9+6/v6gUSGNsWU3Jg1AEY14ifURqHMWUJ6+I7/eDup2m1hWULBQt9JXBogSoo0Bkix
 PIzL/ihWAIDIy3qTprpj6ZtXVfaEjSdbZWShgPcM75GhFFafSVDXyQ9nTzmgrkGQlZ4j
 SdQq5o6jGx83tbR1wn3uPx47/b+NoKSNvbznsviy7TsSzdgF9orcRuZG9qhiGqfyT881
 TjVXlb0kYk6wRxgpZLiHBukPxF+jk9kmxZExKUYF+zTSs9trbnZS9m0QE8F8k+LQT2nA
 5whA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776697393; x=1777302193; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pthMTNMqlXrlhPSp0jk3XCcHWOVSS3of+jZOr0KsTkI=;
 b=LRrUsOKwrc1HFSSXijbWdzi7w9Kafl5wrm1qoPyaSk6xIC72NisBpgUZVFxtCOhlsS
 M2ZiIdYKd0Fh1pTKnLpuw2Ymx8drjI+pTqkEoDeqVHvfsakmqlM9FYR/4NTipE01OUPR
 FTq6UrU8rlP9VIdPt+JXvUW9VLIgAo2Osve71os6vqGu3M8dOPgfrUmcDN0Iae8ysgew
 5i4BmFi9xQ3oKYD8+dn2J6i8L3tDiCKa2kJjIjJ73dxbmGYH9VFGS/JUgfAt27myughy
 122OkKSI/j4c+yI3agn6Zgg2X6pyPfqCYpPQlNHe7V2YQbh2NNOiK/T4lBXiLbGKv5Nn
 +buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776697393; x=1777302193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pthMTNMqlXrlhPSp0jk3XCcHWOVSS3of+jZOr0KsTkI=;
 b=J1wImi53BHtO2nbulzecHEQXgWxW9vz+xc+BimcLU9k883YgOisBmQoq8PBGu44K+U
 qnCBFOcLgJ93IrvXC7XtMCKf2tpIT3H0FldXkc47w1mqmkHKLQcJV9w6RlW5ZOPER1A5
 S2DfhUaJogAEE3/OpsJMX8EH+hT2ZQDWRIwM2xqL2Wr2Mkc/XXxvY6lMLuWRGXUD9Aa5
 Ybkwh0NHijOqo7OjKwn/ztf0xAGJJg2pdYTtEgo6TXzVKlDXWGMLo8COfX9NO0V/xNUf
 g/NzjoihRplMjlZicJ9/kqwR88h0CYeO7+DG7xsBzb+2xEfGMnzpSGy/3RkqfHlr2l24
 2x2g==
X-Gm-Message-State: AOJu0YzxPPHLVO8/uXDu5bavz+vYukMLobzOlqdr3QaLInUCt9J1KXiZ
 M43iS4+hQe1WD9+6ZDi0gkEI+2NTjOMVWeu8kLpY4w1B0yNcH/eKHtvnrp6Q2BeCqf+o96SD5aQ
 VYZIdcyhbfk1pzcbMiycRc5qZQfc4tC1hfb7X16l09PvpxB9yy6Ytggv2H6VGsvFDLfmgOAzk3B
 q6H5IVwn7qA3gE03wDdY+GetI9TNWx7mI=
X-Gm-Gg: AeBDiesoxdGK5lLFJpUjlBnlnYF9WbX0jjsqmAb70QlEAWpEHz7oZLc8Swa2oxY5W3+
 4v4w8JSWVs7zApnuIrPtsy08q+EF9kfgNSc60m0c+FYZ7YGxXU3rjAyx68+PXvS8W8+GeWlliqe
 y6H+pt+j3o0OG90VvKvQCl8C2WMoUa3300Bpc6DLAx8u2PB3RPGaALpIQNpw+6pHPRiX+CSMq7i
 FmDhE62ngYZ3IRZfAyL9/rrkwW5LBVv/QMNCjYP7yPqITAewqZiHC1z5kXcehOpiPzrRKS9LIgY
 DgOsuy0bT+Dd0eq7U0Xj//Vze1E+pW+d4lw=
X-Received: by 2002:a17:90b:35c6:b0:35e:5aa5:ae38 with SMTP id
 98e67ed59e1d1-361403ebe7cmr12973093a91.9.1776697393283; 
 Mon, 20 Apr 2026 08:03:13 -0700 (PDT)
X-Received: by 2002:a17:90b:35c6:b0:35e:5aa5:ae38 with SMTP id
 98e67ed59e1d1-361403ebe7cmr12972997a91.9.1776697392444; Mon, 20 Apr 2026
 08:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-46-231416f76dc3@redhat.com>
 <ad-2zbZKrCWBrlbb@redhat.com>
In-Reply-To: <ad-2zbZKrCWBrlbb@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Apr 2026 19:03:00 +0400
X-Gm-Features: AQROBzCiS0948qe2a6auPAJzlQi15iJJNWw9kG0HyP84r7F9xWwVnTBU9OSrzhE
Message-ID: <CAMxuvaz-BTW40bJwChY8VT_m1Z75Z8FL=UFm1rLnc3YD0YZTfg@mail.gmail.com>
Subject: Re: [PATCH v2 46/67] ui/vnc: make the worker thread per-VncDisplay
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Wed, Apr 15, 2026 at 8:03=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Apr 10, 2026 at 11:19:08PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > The VNC encoding worker thread was using a single global queue shared
> > across all VNC displays, with no way to stop it. This made it impossibl=
e
> > to properly clean up resources when a VncDisplay is freed.
> >
> > Move the VncJobQueue from a file-scoped global to a per-VncDisplay
> > member, so each display owns its worker thread and queue. Add
> > vnc_stop_worker_thread() to perform an orderly shutdown: signal the
> > thread to exit, join it, and destroy the queue. The thread is now
> > created as QEMU_THREAD_JOINABLE instead of QEMU_THREAD_DETACHED.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  ui/vnc-jobs.h |  3 ++-
> >  ui/vnc.h      |  2 ++
> >  ui/vnc-jobs.c | 76 +++++++++++++++++++++++++++++++++------------------=
--------
> >  ui/vnc.c      |  3 ++-
> >  4 files changed, 49 insertions(+), 35 deletions(-)
> >
>
> > diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> > index 5b17ef54091..c809287dd3a 100644
> > --- a/ui/vnc-jobs.c
> > +++ b/ui/vnc-jobs.c
> > @@ -29,8 +29,6 @@
> >  #include "qemu/osdep.h"
> >  #include "vnc.h"
> >  #include "vnc-jobs.h"
> > -#include "qemu/sockets.h"
> > -#include "qemu/main-loop.h"
> >  #include "trace.h"
> >
> >  /*
> > @@ -56,17 +54,10 @@ struct VncJobQueue {
> >      QemuCond cond;
> >      QemuMutex mutex;
> >      QemuThread thread;
> > +    bool exit;
> >      QTAILQ_HEAD(, VncJob) jobs;
> >  };
> >
> > -typedef struct VncJobQueue VncJobQueue;
> > -
> > -/*
> > - * We use a single global queue, but most of the functions are
> > - * already reentrant, so we can easily add more than one encoding thre=
ad
> > - */
> > -static VncJobQueue *queue;
> > -
> >  static void vnc_lock_queue(VncJobQueue *queue)
> >  {
> >      qemu_mutex_lock(&queue->mutex);
> > @@ -125,19 +116,22 @@ static void vnc_job_free(VncJob *job)
> >   */
> >  void vnc_job_push(VncJob *job)
> >  {
> > +    VncJobQueue *queue =3D job->vs->vd->queue;
> > +
> >      assert(!QTAILQ_IN_USE(job, next));
> >
> >      if (QLIST_EMPTY(&job->rectangles)) {
> >          vnc_job_free(job);
> >      } else {
> >          vnc_lock_queue(queue);
> > +        assert(!queue->exit);
> >          QTAILQ_INSERT_TAIL(&queue->jobs, job, next);
> >          qemu_cond_broadcast(&queue->cond);
> >          vnc_unlock_queue(queue);
> >      }
> >  }
> >
> > -static bool vnc_has_job_locked(VncState *vs)
> > +static bool vnc_has_job_locked(VncJobQueue *queue, VncState *vs)
> >  {
>
> Instead of passing this I think you could add
>
>    VncJobQueue *queue =3D vs->vd->queue;
>
> which guarantees the queue object matches the state object
> instead of leaving that precondition to the caller.

ok

>
> >      VncJob *job;
> >
> > @@ -151,8 +145,10 @@ static bool vnc_has_job_locked(VncState *vs)
> >
> >  void vnc_jobs_join(VncState *vs)
> >  {
> > +    VncJobQueue *queue =3D vs->vd->queue;
> > +
> >      vnc_lock_queue(queue);
> > -    while (vnc_has_job_locked(vs)) {
> > +    while (vnc_has_job_locked(queue, vs)) {
> >          qemu_cond_wait(&queue->cond, &queue->mutex);
> >      }
> >      vnc_unlock_queue(queue);
> > @@ -252,9 +248,13 @@ static int vnc_worker_thread_loop(VncJobQueue *que=
ue)
> >      int saved_offset;
> >
> >      vnc_lock_queue(queue);
> > -    while (QTAILQ_EMPTY(&queue->jobs)) {
> > +    while (QTAILQ_EMPTY(&queue->jobs) && !queue->exit) {
> >          qemu_cond_wait(&queue->cond, &queue->mutex);
> >      }
> > +    if (queue->exit) {
> > +        vnc_unlock_queue(queue);
> > +        return 1;
> > +    }
> >      job =3D QTAILQ_FIRST(&queue->jobs);
> >      vnc_unlock_queue(queue);
> >
> > @@ -340,39 +340,49 @@ disconnected:
> >      return 0;
> >  }
> >
> > -static VncJobQueue *vnc_queue_init(void)
> > -{
> > -    VncJobQueue *queue =3D g_new0(VncJobQueue, 1);
> > -
> > -    qemu_cond_init(&queue->cond);
> > -    qemu_mutex_init(&queue->mutex);
> > -    QTAILQ_INIT(&queue->jobs);
> > -    return queue;
> > -}
>
> IMHO it makes sense to keep this object allocator
> method and call it from...
>
> > -
> >  static void *vnc_worker_thread(void *arg)
> >  {
> >      VncJobQueue *queue =3D arg;
> >
> >      while (!vnc_worker_thread_loop(queue)) ;
> > -    g_assert_not_reached();
> > +
> >      return NULL;
> >  }
> >
> > -static bool vnc_worker_thread_running(void)
> > +void vnc_start_worker_thread(VncDisplay *vd)
> >  {
> > -    return queue; /* Check global queue */
> > +    VncJobQueue *queue;
> > +
> > +    assert(vd->queue =3D=3D NULL);
> > +
> > +    queue =3D g_new0(VncJobQueue, 1);
> > +    qemu_cond_init(&queue->cond);
> > +    qemu_mutex_init(&queue->mutex);
> > +    QTAILQ_INIT(&queue->jobs);
> > +    vd->queue =3D queue;
>
> ....here
>
>   vd->queue =3D vnc_queue_init();
>
> though renaming it to vnc_queue_new() would be more
> in keeping with the naming patterns.

ok

>
> > +
> > +    qemu_thread_create(&queue->thread, "vnc_worker", vnc_worker_thread=
, queue,
> > +                       QEMU_THREAD_JOINABLE);
> >  }
> >
> > -void vnc_start_worker_thread(void)
> > +void vnc_stop_worker_thread(VncDisplay *vd)
> >  {
> > -    VncJobQueue *q;
> > +    VncJobQueue *queue =3D vd->queue;
> >
> > -    if (vnc_worker_thread_running())
> > +    if (!queue) {
> >          return;
> > +    }
> > +
> > +    /* all VNC clients must have finished before we can stop the worke=
r thread */
> > +    vnc_lock_queue(queue);
> > +    assert(QTAILQ_EMPTY(&queue->jobs));
> > +    queue->exit =3D true;
> > +    qemu_cond_broadcast(&queue->cond);
> > +    vnc_unlock_queue(queue);
> >
> > -    q =3D vnc_queue_init();
> > -    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread, q,
> > -                       QEMU_THREAD_DETACHED);
> > -    queue =3D q; /* Set global queue */
> > +    qemu_thread_join(&queue->thread);
> > +    qemu_cond_destroy(&queue->cond);
> > +    qemu_mutex_destroy(&queue->mutex);
> > +    g_free(queue);
>
>
> I'd suggest  a vnc_queue_free(queue) method here too
>
> > +    vd->queue =3D NULL;
> >  }
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index ba7376360e6..4e5a9ee0341 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -3457,7 +3457,7 @@ void vnc_display_init(const char *id, Error **err=
p)
> >      vd->share_policy =3D VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
> >      vd->connections_limit =3D 32;
> >
> > -    vnc_start_worker_thread();
> > +    vnc_start_worker_thread(vd);
> >
> >      register_displaychangelistener(&vd->dcl);
> >      vd->kbd =3D qkbd_state_init(vd->dcl.con);
> > @@ -3517,6 +3517,7 @@ static void vnc_display_free(VncDisplay *vd)
> >
> >      assert(QTAILQ_EMPTY(&vd->clients));
> >
> > +    vnc_stop_worker_thread(vd);
> >      vnc_display_close(vd);
> >      unregister_displaychangelistener(&vd->dcl);
> >      qkbd_state_free(vd->kbd);
> >
> > --
> > 2.53.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


