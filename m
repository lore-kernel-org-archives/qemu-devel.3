Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2793D3E780
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 22:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTSFZ-0001KH-1M; Wed, 10 Dec 2025 17:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTSFK-0001JA-73
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 17:01:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTSFI-00082x-3o
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 17:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765404073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VC7OkS7qV1sz+wUZCpZwSpEzZiat+Z0fjtlkf2kDxDQ=;
 b=VCBlE0Rpff5Sp+39GBNCSnwMODtAJZPAqnD6KzoV8OhLSDGjE/sPflqpkUl47A3O6BdqNB
 HTlsHwBJI1UL6PSUVVuHt1QNqCYBwq/ZO5mUNi/dickORhT+BFGuOSFN8rcovbVWQ3rtWh
 /T22TSj7dG8tB3RxEtskDjmehS2OKGs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-ArDOt9rxPbGfYkB4NmFAXA-1; Wed, 10 Dec 2025 17:01:10 -0500
X-MC-Unique: ArDOt9rxPbGfYkB4NmFAXA-1
X-Mimecast-MFC-AGG-ID: ArDOt9rxPbGfYkB4NmFAXA_1765404070
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8885a6666b1so8121006d6.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 14:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765404070; x=1766008870; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VC7OkS7qV1sz+wUZCpZwSpEzZiat+Z0fjtlkf2kDxDQ=;
 b=WwFR72ne/T+HW+NtO0GK5iS1YY7Eauf2fdjfl8Ba5QDA7B1o8qS77ap0veLLMECM+x
 D2LSo/r5ZuvV8iZJwOo8UNZsc/yJgkv9hORTLewQkdA5+hZEtE5MvsByGrc34qGzp+Sn
 Ykk4qnV+hOPIwS5D1dQr7Bfd8Akjbkt77CI3OuXifswEpGyOfjH/53vYdJTMpYFPnhxg
 Au8dzkdMDJawXNOAiuhH2jPI+WMPz3LmYldNz8chKvC3BTBsZV+WNUTv5LrIreCt7RQV
 6Mun2tfP1UwIgBF5ZCSgkGKp5wOVFP69Nt+WkmT87wI1H1XWUF7JyIqSESGk+wSHRRMa
 L2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765404070; x=1766008870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VC7OkS7qV1sz+wUZCpZwSpEzZiat+Z0fjtlkf2kDxDQ=;
 b=hIoFt7NbAJZLJyuoRhdmhu9CcrrBaduQUtgXn/VJyogsPHotherM+fDa+eJNOofJUS
 5w+SRYCaaVH8xmdBtKkn1gxm62SgcX7eId8d/vlkNv5BGA1nlK2F0yriPJe6FeX3c9KJ
 m5IYQHH2ANthubuLJgCR+3hYPXCrnK3II44GQ54EKgy9UXiatqdeM3wuNKjkLoJHBSJF
 Ax4af1p/jApJ87UEa0MPiM4uzFfFbmvMaTunsVbcf9droTG6h07IIVl8eaH2dmi9IzRC
 +xlOSThZLqUbtinbVTc5pjS3HEtUXGxCzw+a4PO++2In9pkRyedo6CNdXLv0dqDm73DS
 V31A==
X-Gm-Message-State: AOJu0YzNs+Fg6+gTyDVNNuCdBZ3zFTjNTOQcRVlgnhqa8U0aGHMvLwfH
 igyYoDwniiQsX8W9dvgZypEb0E0nwP2HkIkecxtK+afjdgzhWxW7YljybqOYR5IbO/nXCscLqkM
 NijU/SWvnjutIUd0d3sTc6oolboWV+psqTgffEJef3VL/KGWdj1wyf8kL
X-Gm-Gg: AY/fxX5Q864xvgW2Vg50Yz3C5qXqquewGUGTVjlmJMtefFnS+Ai11jcxNepfPXzZXuz
 oatAdw/z8ik4tSr6Y7BY7DipwrKWFV6g263N5FVLMiOu85cjfMF/o0dDVwbUfDXKbWObOKNSxxR
 XnXf0mHfVjpK47c6jAkkAYksJeIN32cNnsGUgTEM3bn2LODb7DZo6rLiYR0Z6rbCdOUKHFZd4Rq
 uR+GZZSAiq/ZV07OjBOJFR0+EBiCS9tamix8MVVanVp9sLjqTcRDhVmLru9twqgF2HpOlEfLh7a
 pQ6AQjDJ93QlJ98XxX8fAZmfnkTuwbZBVEniIJ+zaxmpQIN7Rf7JJbNuLz27IdkQjMVw1PRWO2i
 Hk14=
X-Received: by 2002:a05:6214:212f:b0:880:4aec:c4ed with SMTP id
 6a1803df08f44-88863a2156emr70620646d6.6.1765404069510; 
 Wed, 10 Dec 2025 14:01:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsD90Sb5nwiD+zhRn/eC6ArkQ1/neUtS5wBr8DfbILSCnHRxk8WGU5ZHuJGKggNumrA5yFxw==
X-Received: by 2002:a05:6214:212f:b0:880:4aec:c4ed with SMTP id
 6a1803df08f44-88863a2156emr70619626d6.6.1765404068911; 
 Wed, 10 Dec 2025 14:01:08 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8886ef30441sm7633176d6.56.2025.12.10.14.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 14:01:08 -0800 (PST)
Date: Wed, 10 Dec 2025 17:01:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 07/13] migration: Pass in bql_held information from
 qemu_loadvm_state()
Message-ID: <aTnto4Eb3IM_V9d5@x1.local>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-8-peterx@redhat.com>
 <40c2af51-c6ec-45eb-8139-9dafc36396e6@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40c2af51-c6ec-45eb-8139-9dafc36396e6@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 05:22:51PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 22.10.25 22:26, Peter Xu wrote:
> > Teach qemu_loadvm_state() and some of the internal functions to know
> > whether we're holding BQL or not.
> 
> Actually, this commit does more: not only pass the bql_held information,
> but also by introduce some WITH_BQL_HELD() sections.
> 
> IMHO it could be split:
> 
> 1. only add bql_held parameters, which are used only to passthorough to
> called functions. That's just to simplify further commits. Make the
> information available. At this commit, we only need to check, that
> passed information is correct (is it really held, may be add some
> comments/assertions to make it obvious)
> 
> 2. one or more commits, which prepares different functions to be called
> in thread: support bql_held=false by introducing WITH_BQL_HELD() sections.
> In such commit, we should lookthorgh the whole function and check that it
> actually prepared to be called from thread.
> 
> 
> Hmm, or without [1.], there may be several commits to prepare different
> functions. Or maybe, even one commit as it is, but change commit subject
> and message somehow, to reflect all the changes..

I prefer the last one you said.

This patch is indeed not easy to review, and it'll be the core of this
whole work (it'll be even more obvious if without the complexity due to
COLO and RDMA's coroutines.. that was separate from BQL status, hence
addressed in the next patch).

So the big question is, for the loadvm process, what must run with BQL
held, what must run with BQL released, and the rest will be "it's ok to run
with BQL, but optional".

Those things, no matter when drafting as a patch, or review, should better
happen in one patch, IMHO, otherwise it's unclear how each patch can be
reviewed if something was missed, when details scattered into multiple
patches.

I updated the commit message with below:

  migration: Pass in bql_held information from qemu_loadvm_state()
  
  Teach qemu_loadvm_state() and some of the internal functions to know
  whether we're holding BQL or not.
  
  Notes for some callers that are not obvious on BQL status:
  
    - process_incoming_migration_co() always invokes qemu_loadvm_state() with
      BQL held, which is the core loadvm coroutine.  The coroutine was
      explicitly entered from migration_incoming_process() which used to run
      in the main thread.
  
    - postcopy_listen_thread() always invokes qemu_loadvm_state() without
      BQL, which receives postcopy pages while VM is already started and
      running on destination (or to be started very soon).
  
    - qemu_load_device_state() / qmp_xen_load_devices_state() /
      load_snapshot() all are invoked with BQL held.
  
  The rest takes bql_held from upper layers.
  
  To reviewers: even if this is not functional change yet, it'll be the major
  core functional change after we switch to threadified loadvm soon.  Please
  treat it as one to add explicit code to mark out which part of incoming
  live migration would need to be executed always with the BQL, or would need
  to be run always without BQL.

Would it look better?

> 
> > 
> > So far, all the callers still always pass in TRUE, hence no functional
> > change expected.  But it may change in the near future.
> > 
> > To reviewers: even if this is not functional change yet, it'll be the major
> > core functional change after we switch to threadified loadvm soon.  Please
> > Treat it as one to add explicit code to mark out which part of incoming
> > live migration would need to be executed always with the BQL, or would need
> > to be run always without BQL.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> [..]
> 
> > diff --git a/migration/colo.c b/migration/colo.c
> > index db783f6fa7..4fd586951a 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -686,7 +686,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >       bql_lock();
> >       cpu_synchronize_all_states();
> > -    ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
> > +    ret = qemu_loadvm_state_main(mis->from_src_file, mis, true, errp);
> 
> That one is obvious..
> 
> >       bql_unlock();
> >       if (ret < 0) {
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 4ed2a2e881..38a584afae 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -878,7 +878,7 @@ process_incoming_migration_co(void *opaque)
> >                         MIGRATION_STATUS_ACTIVE);
> >       mis->loadvm_co = qemu_coroutine_self();
> > -    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
> > +    ret = qemu_loadvm_state(mis->from_src_file, true, &local_err);
> 
> Here, why are we sure? Are coroutines triggered by QMP command always run under BQL?

Yes.  QMP handlers must run with BQL, except oob commands.

> 
> Maybe, worth an assertion.

Sure I can add it.  I'll then switch that to assert(!bql) in the next patch
when it becomes a thread.

> 
> >       mis->loadvm_co = NULL;
> >       trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 232cae090b..44aadc2f51 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -154,11 +154,12 @@ static void qemu_loadvm_thread_pool_destroy(MigrationIncomingState *mis)
> >   }
> >   static bool qemu_loadvm_thread_pool_wait(MigrationState *s,
> > -                                         MigrationIncomingState *mis)
> > +                                         MigrationIncomingState *mis,
> > +                                         bool bql_held)
> >   {
> > -    bql_unlock(); /* Let load threads do work requiring BQL */
> > -    thread_pool_wait(mis->load_threads);
> > -    bql_lock();
> > +    WITH_BQL_RELEASED(bql_held) {
> > +        thread_pool_wait(mis->load_threads);
> > +    }
> >       return !migrate_has_error(s);
> 
> The function is now prepared to be called from thread, as migrate_has_error() has own mutex.
> 
> >   }
> > @@ -2117,7 +2118,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >       qemu_file_set_blocking(f, true, &error_fatal);
> >       /* TODO: sanity check that only postcopiable data will be loaded here */
> > -    load_res = qemu_loadvm_state_main(f, mis, &local_err);
> > +    load_res = qemu_loadvm_state_main(f, mis, true, &local_err);
> 
> Is it correct? I see, a bit later, postcopy_ram_listen_thread() does
> 
>     bql_lock();
>     migration_incoming_state_destroy();
>     bql_unlock();
> 
> so, I assume, that before this, when we call qemu_loadvm_state_main(), BQL is not actually locked?

Thanks for the careful review, this line was wrong, and it was reverted to
the right change in the next patch.. hence after the whole patchset applied
it'll be correct.

I guess it might be a fixup I applied to the wrong patch.  I'll move that
change here.  It should be false here indeed.

> 
> >       /*
> >        * This is tricky, but, mis->from_src_file can change after it
> > @@ -2420,7 +2421,8 @@ static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> >    * Returns: Negative values on error
> >    *
> >    */
> > -static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
> > +static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis,
> > +                                      bool bql_held, Error **errp)
> >   {
> >       int ret;
> 
> [..]
> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Peter Xu


