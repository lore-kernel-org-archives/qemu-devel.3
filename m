Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EE3CA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 10:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoJj5-00050u-7e; Tue, 19 Aug 2025 06:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoJj2-00050Z-Uq
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoJj1-0000Kc-3w
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755599874;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=yO1oVmWPsy7kQn+EG1AE7nwGchFzzKFGXEDUAuvj6mo=;
 b=fLboAF1TO+OTtkZsQnKNqPnX/oFukmFAhslx7xE8qT9irdylFBtXMdg/mkpLhecfykApIr
 l8RZ8DPFvnOYku/bk3rAnfMmPbtr2EYzmG85/aQiQOue41tHaSvPsOjzekv3x9K1iCjho4
 Io566pGqbCdO5KhRU4o9yOkGDhs5OZA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-RsPgKAtcPhCQtZySN589kw-1; Tue,
 19 Aug 2025 06:37:51 -0400
X-MC-Unique: RsPgKAtcPhCQtZySN589kw-1
X-Mimecast-MFC-AGG-ID: RsPgKAtcPhCQtZySN589kw_1755599870
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B984219775A9; Tue, 19 Aug 2025 10:37:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92AEC18003FC; Tue, 19 Aug 2025 10:37:46 +0000 (UTC)
Date: Tue, 19 Aug 2025 11:37:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 1/4] qemu-thread: Introduce qemu_thread_detach()
Message-ID: <aKRT9lOS6QkRqlWA@redhat.com>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <20250807114922.1013286-2-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807114922.1013286-2-jmarcin@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 07, 2025 at 01:49:09PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Currently, QEMU threads abstraction supports both joinable and detached
> threads, but once a thread is marked as joinable it must be joined using
> qemu_thread_join() and cannot be detached later.

IMHO it is a good thing to avoid the concept of turning a joinable
thread into a detached thread at runtime. Such a change makes it
harder to reason about the correctness of the code, as you need to
fully understand the global picture of what code runs at each
phase of the thread's life, to decide if you need to join or not.
So I'd really encourage looking at whether the migration code can
be made to *always* join, rather than mixing joinable/detached for
the same thread.

> 
> For POSIX implementation, pthread_detach() is used. For Windows, marking
> the thread as detached and releasing critical section is enough as
> thread handle is released by qemu_thread_create().
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  include/qemu/thread.h    |  1 +
>  util/qemu-thread-posix.c |  8 ++++++++
>  util/qemu-thread-win32.c | 10 ++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index f0302ed01f..8a6d1ba98e 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -212,6 +212,7 @@ int qemu_thread_set_affinity(QemuThread *thread, unsigned long *host_cpus,
>  int qemu_thread_get_affinity(QemuThread *thread, unsigned long **host_cpus,
>                               unsigned long *nbits);
>  void *qemu_thread_join(QemuThread *thread);
> +void qemu_thread_detach(QemuThread *thread);
>  void qemu_thread_get_self(QemuThread *thread);
>  bool qemu_thread_is_self(QemuThread *thread);
>  G_NORETURN void qemu_thread_exit(void *retval);
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index ba725444ba..20442456b5 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -536,3 +536,11 @@ void *qemu_thread_join(QemuThread *thread)
>      }
>      return ret;
>  }
> +
> +void qemu_thread_detach(QemuThread *thread)
> +{
> +    int err = pthread_detach(thread->thread);
> +    if (err) {
> +        error_exit(err, __func__);
> +    }
> +}
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index ca2e0b512e..bdfb7b4aee 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -328,6 +328,16 @@ void *qemu_thread_join(QemuThread *thread)
>      return ret;
>  }
>  
> +void qemu_thread_detach(QemuThread *thread)
> +{
> +    QemuThreadData *data;
> +
> +    if (data->mode == QEMU_THREAD_JOINABLE) {
> +        data->mode = QEMU_THREAD_DETACHED;
> +        DeleteCriticalSection(&data->cs);
> +    }
> +}
> +
>  static bool set_thread_description(HANDLE h, const char *name)
>  {
>      HRESULT hr;
> -- 
> 2.50.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


