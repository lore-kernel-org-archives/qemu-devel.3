Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF66C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeNq-0004uP-E5; Mon, 11 Mar 2024 08:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjeNn-0004sf-Rt
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjeNl-0005HR-SG
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710158630;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dCa70XiU7NBWIRy7Prh481jt0xh2wAhsXUxJWoSN0DQ=;
 b=H7EjtapJr6eT197UPq/uAZFxQlb6haYqPw5CrU23zTCkU+iL8VxvMqbNul6Uu9xt3f2duo
 3XKHma/+Lj3s6yLTYzs/ALUeKpmRw9oFDcRjNP+IZYGQBkR0Z/lL1NZpxYGwG90PTkGrcQ
 +4NGlWTsmVLZcxzEsqhNJV3RFfsarzk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-hqS_GTgDMuWH3H5nJyFiEQ-1; Mon,
 11 Mar 2024 08:03:45 -0400
X-MC-Unique: hqS_GTgDMuWH3H5nJyFiEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2E022801583;
 Mon, 11 Mar 2024 12:03:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1BE8C4F9A0;
 Mon, 11 Mar 2024 12:03:43 +0000 (UTC)
Date: Mon, 11 Mar 2024 12:03:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 25/27] migration/multifd: Add mapped-ram support to fd: URI
Message-ID: <Ze7zHaHBaCRO8qKu@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
 <20240304012634.95520-26-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240304012634.95520-26-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 04, 2024 at 09:26:32AM +0800, peterx@redhat.com wrote:
> From: Fabiano Rosas <farosas@suse.de>
> 
> If we receive a file descriptor that points to a regular file, there's
> nothing stopping us from doing multifd migration with mapped-ram to
> that file.
> 
> Enable the fd: URI to work with multifd + mapped-ram.
> 
> Note that the fds passed into multifd are duplicated because we want
> to avoid cross-thread effects when doing cleanup (i.e. close(fd)). The
> original fd doesn't need to be duplicated because monitor_get_fd()
> transfers ownership to the caller.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Link: https://lore.kernel.org/r/20240229153017.2221-23-farosas@suse.de
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/fd.h        |  2 ++
>  migration/fd.c        | 44 +++++++++++++++++++++++++++++++++++++++++++
>  migration/file.c      | 18 ++++++++++++------
>  migration/migration.c |  4 ++++
>  migration/multifd.c   |  2 ++
>  5 files changed, 64 insertions(+), 6 deletions(-)
> 

> @@ -73,4 +98,23 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
>                                 fd_accept_incoming_migration,
>                                 NULL, NULL,
>                                 g_main_context_get_thread_default());
> +
> +    if (migrate_multifd()) {
> +        int channels = migrate_multifd_channels();
> +
> +        while (channels--) {
> +            ioc = QIO_CHANNEL(qio_channel_file_new_fd(dup(fd)));
> +
> +            if (QIO_CHANNEL_FILE(ioc)->fd == -1) {
> +                error_setg(errp, "Failed to duplicate fd %d", fd);
> +                return;
> +            }

I'd suggest that Peter's comment about failure checks be fixed
by introducing a new constructor that handles the dup + error
reporting.

   QIOChannel *qio_channel_file_new_dupfd(int fd, Error **errp;)

so we're not repeating the error reporting multiple places.

> +
> +            qio_channel_set_name(ioc, "migration-fd-incoming");
> +            qio_channel_add_watch_full(ioc, G_IO_IN,
> +                                       fd_accept_incoming_migration,
> +                                       NULL, NULL,
> +                                       g_main_context_get_thread_default());
> +        }
> +    }
>  }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


