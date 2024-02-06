Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEC6C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 08:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHDH-0006Jp-3i; Tue, 06 Feb 2024 03:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXHDG-0006JE-Ae
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:53:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXHDE-0006wf-M2
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707209631;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Kuy+442pELJQ0mjF9K99hZzSUy8PC5wpafYSdgM7i1E=;
 b=CXEmbaJRIecQ9sj30db3IcofMBK0/C3rTNPI6pJVCS+tclKNMTxQjgYLIzkh+e74txAzJt
 JSQOghsIJtdlNQIRF8GU20tbr+60K1tUpxZaroJ8c68WOBXm+XxcPZsN1UhIL071TA3tUX
 7tTbxKfLC9SUwI/v8WrHKd2xsEXtKoU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-XTSWFvCJPHKwOK-t_7oJ6A-1; Tue,
 06 Feb 2024 03:53:48 -0500
X-MC-Unique: XTSWFvCJPHKwOK-t_7oJ6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 062E328B6AB6;
 Tue,  6 Feb 2024 08:53:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D9F1111F9;
 Tue,  6 Feb 2024 08:53:47 +0000 (UTC)
Date: Tue, 6 Feb 2024 08:53:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 1/6] migration/multifd: Join the TLS thread
Message-ID: <ZcHzmb6gVJtS_flp@redhat.com>
References: <20240205194929.28963-1-farosas@suse.de>
 <20240205194929.28963-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240205194929.28963-2-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 05, 2024 at 04:49:24PM -0300, Fabiano Rosas wrote:
> We're currently leaking the resources of the TLS thread by not joining
> it and also overwriting the p->thread pointer altogether.

AFAICS, it is not ovewriting 'p->thread' because at the time when the
TLS thread is created, the main 'send thread' has not yet been
created. The TLS thread and send thread execution times are mutually
exclusive.

The 'p->running' flag is already set to true when the TLS thread is
created, so the existing cleanup should be working too, so I'm not
seeing a bug that needs fixing here.

> 
> Fixes: a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to blocking handshake")
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 8 +++++++-
>  migration/multifd.h | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index ef13e2e781..8195c1daf3 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -630,6 +630,10 @@ static void multifd_send_terminate_threads(void)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> +        if (p->tls_thread_created) {
> +            qemu_thread_join(&p->tls_thread);
> +        }
> +
>          if (p->running) {
>              qemu_thread_join(&p->thread);
>          }
> @@ -921,7 +925,9 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>      trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
>      qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
>      p->c = QIO_CHANNEL(tioc);
> -    qemu_thread_create(&p->thread, "multifd-tls-handshake-worker",
> +
> +    p->tls_thread_created = true;
> +    qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
>                         multifd_tls_handshake_thread, p,
>                         QEMU_THREAD_JOINABLE);
>      return true;
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 78a2317263..720c9d50db 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -73,6 +73,8 @@ typedef struct {
>      char *name;
>      /* channel thread id */
>      QemuThread thread;
> +    QemuThread tls_thread;
> +    bool tls_thread_created;
>      /* communication channel */
>      QIOChannel *c;
>      /* is the yank function registered */
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


