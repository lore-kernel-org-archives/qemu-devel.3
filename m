Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309F5C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDW3-0004h1-02; Wed, 26 Feb 2025 04:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnDW0-0004ey-Lm
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:15:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnDVv-0002EU-3x
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740561334;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jMgZMNeMEKpCXq0pSjKk/bXi7IDGfFfSfGQVVYPdZg8=;
 b=MA+gHJAkpuz9Iq0N+vFevt13IZk5Ijgt6u+KrVR6HzuyrYfZRqyV/n3udKOakGNUvIAV9f
 lwxCBhsTe7xbcohx3uGRDGx8GdPbWNPJ+Sjhmy/t92JjfEJfmEvyKI0lfhgKlZJvxBzws/
 aVFT2mJvCHUC6Br2T/hTvvT/ZJd7UN0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-k3s-yZczNzSPuonEn8i2Yg-1; Wed,
 26 Feb 2025 04:15:30 -0500
X-MC-Unique: k3s-yZczNzSPuonEn8i2Yg-1
X-Mimecast-MFC-AGG-ID: k3s-yZczNzSPuonEn8i2Yg_1740561330
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF3381955F28; Wed, 26 Feb 2025 09:15:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.113])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5667719560A3; Wed, 26 Feb 2025 09:15:26 +0000 (UTC)
Date: Wed, 26 Feb 2025 09:15:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH] trace/simple: Fix hang when using simpletrace with fork()
Message-ID: <Z77bqqKiV7etJNCf@redhat.com>
References: <20250226085015.1143991-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226085015.1143991-1-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 26, 2025 at 09:50:15AM +0100, Thomas Huth wrote:
> When compiling QEMU with --enable-trace-backends=simple , the
> iotest 233 is currently hanging. This happens because qemu-nbd
> calls trace_init_backends() first - which causes simpletrace to
> install its writer thread and the atexit() handler - before
> calling fork(). But the simpletrace writer thread is then only
> available in the parent process, not in the child process anymore.
> Thus when the child process exits, its atexit handler waits forever
> on the trace_empty_cond condition to be set by the non-existing
> writer thread, so the process never finishes.
> 
> Fix it by installing a pthread_atfork() handler, too, which
> makes sure that the trace_writeout_enabled variable gets set
> to false again in the child process, so we can use it in the
> atexit() handler to check whether we still need to wait on the
> writer thread or not.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  trace/simple.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/trace/simple.c b/trace/simple.c
> index c0aba00cb7f..269bbda69f1 100644
> --- a/trace/simple.c
> +++ b/trace/simple.c
> @@ -380,8 +380,22 @@ void st_print_trace_file_status(void)
>  
>  void st_flush_trace_buffer(void)
>  {
> -    flush_trace_file(true);
> +    flush_trace_file(trace_writeout_enabled);
> +}
> +
> +#ifndef _WIN32
> +static void trace_thread_atfork(void)
> +{
> +    /*
> +     * If we fork, the writer thread does not exist in the child, so
> +     * make sure to allow st_flush_trace_buffer() to clean up correctly.
> +     */
> +    g_mutex_lock(&trace_lock);
> +    trace_writeout_enabled = false;
> +    g_cond_signal(&trace_empty_cond);
> +    g_mutex_unlock(&trace_lock);
>  }
> +#endif

This doesn't seem right to me. This is being run in the child and while
it may avoid the hang when the child exits, surely it still leaves tracing
non-functional in the child as we're lacking the thread to write out the
trace data.

>  
>  /* Helper function to create a thread with signals blocked.  Use glib's
>   * portable threads since QEMU abstractions cannot be used due to reentrancy in
> @@ -396,6 +410,7 @@ static GThread *trace_thread_create(GThreadFunc fn)
>  
>      sigfillset(&set);
>      pthread_sigmask(SIG_SETMASK, &set, &oldset);
> +    pthread_atfork(NULL, NULL, trace_thread_atfork);
>  #endif
>  
>      thread = g_thread_new("trace-thread", fn, NULL);
> -- 
> 2.48.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


