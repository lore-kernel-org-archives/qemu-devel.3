Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4DAC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 20:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfPcf-0005aO-Kz; Tue, 04 Feb 2025 15:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfPcd-0005a2-IY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:34:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfPcb-000418-TY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738701251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jWaxpprHcv5NDQlNvqzGNuwHoeylexRYsa1DdnNK9Us=;
 b=FzQKQ53esFzHmUH35fDp47TcRf3QALAZODZircV9qWioUzdkutQoN8uEiKtn8lPKw77q6f
 2L0napnZGxytBhxKefDHegX1ERxTirHT7bNgrHfvGMHumPqRsp0160eYQPoN+4+SspTrOE
 8kyMHA535jbRYD23QwRtEwssVSeFkMo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-ZvZvubQiP46aPXltdO9qIw-1; Tue, 04 Feb 2025 15:34:10 -0500
X-MC-Unique: ZvZvubQiP46aPXltdO9qIw-1
X-Mimecast-MFC-AGG-ID: ZvZvubQiP46aPXltdO9qIw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8860ab00dso100004306d6.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 12:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738701250; x=1739306050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWaxpprHcv5NDQlNvqzGNuwHoeylexRYsa1DdnNK9Us=;
 b=kJhT7t9gnZne3wBVZSKQfH2IjUAAYwrh6xcqBZwjiPWpd8MRc70nQof4fHETU8rzI0
 LzHwZPkFOk7tw1PmKeCxmfoWzpZm1N2DvfobMJYI4cRXz+LnJj5eVE2g8jz52iv0pE7M
 uxN9l3Y1szuZ71i/fMH7xeO4mMQuc5jdxUkU9bgtrLKLtbIKXI3FXGOULoEUmTJSaN3+
 2Bwg+f39g/4QCtwJrR4y22+gT9BzrJZmAUoUJqTo/wVc69EVauol+xmirwTbTNU6w0Hl
 zR9HVMu4tHpJRqLUwVQ1vHZvsMHGc5WLmDLOE3mU+Zcp+xeBGoRJEibpJiJxCuzERkGO
 G9uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnwLP6nNEU1fjKRjKDGOEtR7ZP4IQqO0HKrKHx79SgVHcoMEVsAtxVtPRmZFvf16k4glv9s4uAMT/k@nongnu.org
X-Gm-Message-State: AOJu0YwnUG6C/P/RMe3+nggVaElyZbcJdmMiuk5/ydQXE0gUb4WvF1QD
 AhMPSyK/5sfb842Xkgz8n3B85diGFdu/eLd/f4I6psf8ZTjGxlewUV9R7TmzR4IP9dx+l8zNDGt
 2huB8jR+p46IwHjma/0vnbQ4bPg548IjBS4pNWkST57ZrjE+Yze69
X-Gm-Gg: ASbGncuwdmIeCi0KhQBQxkmrKPoyf0AbjYxAbvxr+EmVLISBGWXsuKEQtoN8AM/W3ec
 4S8ylOcF8frLk3UwBfAhJl0FDINEEHbUU5zDd9KIk6r+FyzE73HP8cUnsmZJvILsYJiv/1vIysp
 Y/t3b8Gv+rASaChjUhTYZXyA8VJ60vhtt4BubflZmH5fahXvs9McrmdoF82pjxrjfP82ibyviq4
 pcmSTGZeS0y/5FOwwxhBMAVrPxu3/guuJgURhWHcrxTLEOGUe0nBIp68GYAyYu0gMFwIuEEO/P5
 Gerx7F/3sKqPqNHqDEj8jQ3zMfTcVYF5MfhUuJCFMCilo2q1
X-Received: by 2002:a05:6214:e69:b0:6e1:715f:cdd0 with SMTP id
 6a1803df08f44-6e42fb8b094mr2558056d6.16.1738701249764; 
 Tue, 04 Feb 2025 12:34:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8kMhofDR62p6vebriq1UgCTAG6RhB8yyeMhUioi/LvzX4xdMwVsSq72iqCRt0CX/P4jQD/A==
X-Received: by 2002:a05:6214:e69:b0:6e1:715f:cdd0 with SMTP id
 6a1803df08f44-6e42fb8b094mr2557806d6.16.1738701249444; 
 Tue, 04 Feb 2025 12:34:09 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2547f2cf3sm65545666d6.5.2025.02.04.12.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 12:34:09 -0800 (PST)
Date: Tue, 4 Feb 2025 15:34:07 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 19/33] migration: Add
 save_live_complete_precopy_thread handler
Message-ID: <Z6J5vyd1_gdWlYAB@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <7561a5d67e113e166c7d43246d52feec6ca06fb5.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6JUP2w9u_FQRP6u@x1.local>
 <4ad3e311-e701-4029-bb51-e69da4f69468@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ad3e311-e701-4029-bb51-e69da4f69468@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 04, 2025 at 08:32:15PM +0100, Maciej S. Szmigiero wrote:
> On 4.02.2025 18:54, Peter Xu wrote:
> > On Thu, Jan 30, 2025 at 11:08:40AM +0100, Maciej S. Szmigiero wrote:
> > > +static int multifd_device_state_save_thread(void *opaque)
> > > +{
> > > +    struct MultiFDDSSaveThreadData *data = opaque;
> > > +    int ret;
> > > +
> > > +    ret = data->hdlr(data->idstr, data->instance_id, &send_threads_abort,
> > > +                     data->handler_opaque);
> > 
> > I thought we discussed somewhere and the plan was we could use Error** here
> > to report errors.  Would that still make sense, or maybe I lost some
> > context?
> 
> That was about *load* threads, here these are *save* threads.

Ah OK.

> 
> Save handlers do not return an Error value, neither save_live_iterate, nor
> save_live_complete_precopy or save_state does so.

Let's try to make new APIs work with Error* if possible.

> 
> > Meanwhile, I still feel uneasy on having these globals (send_threads_abort,
> > send_threads_ret).  Can we make MultiFDDSSaveThreadData the only interface
> > between migration and the threads impl?  So I wonder if it can be:
> > 
> >    ret = data->hdlr(data);
> > 
> > With extended struct like this (I added thread_error and thread_quit):
> > 
> > struct MultiFDDSSaveThreadData {
> >      SaveLiveCompletePrecopyThreadHandler hdlr;
> >      char *idstr;
> >      uint32_t instance_id;
> >      void *handler_opaque;
> >      /*
> >       * Should be NULL when struct passed over to thread, the thread should
> >       * set this if the handler would return false.  It must be kept NULL if
> >       * the handler returned true / success.
> >       */
> >      Error *thread_error;
> 
> As I mentioned above, these handlers do not generally return Error type,
> so this would need to be an *int;
> 
> >      /*
> >       * Migration core would set this when it wants to notify thread to
> >       * quit, for example, when error occured in other threads, or migration is
> >       * cancelled by the user.
> >       */
> >      bool thread_quit;
> 
>             ^ I guess that was supposed to be a pointer too (*thread_quit).

It's my intention to make this bool, to make everything managed per-thread.

It's actually what we do with multifd, these are a bunch of extra threads
to differeciate from the "IO threads" / "multifd threads".

> 
> > };
> > 
> > Then if any multifd_device_state_save_thread() failed, for example, it
> > should notify all threads to quit by setting thread_quit, instead of
> > relying on yet another global variable to show migration needs to quit.
> 
> multifd_abort_device_state_save_threads() needs to access
> send_threads_abort too.

This may need to become something like:

  QLIST_FOREACH() {
      MultiFDDSSaveThreadData *data = ...;
      data->thread_quit = true;
  }

We may want to double check qmp 'migrate_cancel' will work when save
threads are running, but this can also be done for later.

> 
> And multifd_join_device_state_save_threads() needs to access
> send_threads_ret.

Then this one becomes:

  thread_pool_wait(send_threads);
  QLIST_FOREACH() {
      MultiFDDSSaveThreadData *data = ...;
      if (data->thread_error) {
         return false;
      }
  }
  return true;

> 
> These variables ultimately will have to be stored somewhere since
> there can be multiple save threads and so multiple instances of
> MultiFDDSSaveThreadData.
> 
> So these need to be stored somewhere where
> multifd_spawn_device_state_save_thread() can reach them to assign
> their addresses to MultiFDDSSaveThreadData members.

Then multifd_spawn_device_state_save_thread() will need to manage the
qlist, making sure migration core remembers what jobs it submitted.  It
sounds good to have that bookkeeping when I think about it, instead of
throw the job to the thread pool and forget it..

> 
> However, at that point multifd_device_state_save_thread() can
> access them too so it does not need to have them passed via
> MultiFDDSSaveThreadData.
> 
> However, nothing prevents putting send_threads* variables
> into a global struct (with internal linkage - "static", just as
> these separate ones are) if you like such construct more.

This should be better than the current global vars indeed, but less
favoured if the per-thread way could work above.

Thanks,

-- 
Peter Xu


