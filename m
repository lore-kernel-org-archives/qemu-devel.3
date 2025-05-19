Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DB2C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 11:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGyEP-0007a0-4c; Mon, 19 May 2025 07:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGyEM-0007ZB-Kb
 for qemu-devel@nongnu.org; Mon, 19 May 2025 07:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGyEK-0002pH-Hk
 for qemu-devel@nongnu.org; Mon, 19 May 2025 07:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747652421;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gh0mgaXiQqeXOhNqJ4UyIqsY3wkXYtnyPKkSGupA+JQ=;
 b=HZvZwt04VObpjYZDkr29WFfkfv4ZiaqZOLMSdK8Pv5JPhv1pzr2MtBkojdbK8Id5vTVpRr
 toMU124VyW1L131AKu/uXWTz1HJ8VO7fA36zWl985HZsQ5a203EzS32Ksqsuc31jm7GVZO
 2OVpuEgXeQQmV+gHaaOXbjG74JJsLvA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-egLJRtbnP5G7tImKzn1c-A-1; Mon,
 19 May 2025 07:00:17 -0400
X-MC-Unique: egLJRtbnP5G7tImKzn1c-A-1
X-Mimecast-MFC-AGG-ID: egLJRtbnP5G7tImKzn1c-A_1747652417
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2E0F19560AF; Mon, 19 May 2025 11:00:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A646180049D; Mon, 19 May 2025 11:00:14 +0000 (UTC)
Date: Mon, 19 May 2025 12:00:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 4/4] chardev: Introduce a lock for hup_source
Message-ID: <aCsPOyZCu-AcZOI3@redhat.com>
References: <20250515222014.4161-1-farosas@suse.de>
 <20250515222014.4161-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250515222014.4161-5-farosas@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 15, 2025 at 07:20:14PM -0300, Fabiano Rosas wrote:
> It's possible for the hup_source to have its reference decremented by
> remove_hup_source() while it's still being added to the context,
> leading to asserts in glib:

IIUC this must mean that

  tcp_chr_free_connection

is being called concurrently with

  update_ioc_handlers

I'm wondering if that is really intended, or a sign of a deeper
bug that we'll just paper over if we add the mutex proposed here.

Are you able to provide stack traces showing the 2 concurrent
operations that are triggering this problem ?

> 
> g_source_set_callback_indirect: assertion 'g_atomic_int_get
> (&source->ref_count) > 0'
> 
> g_source_attach: assertion 'g_atomic_int_get (&source->ref_count) > 0'
> failed
> 
> Add a lock to serialize removal and creation.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  chardev/char-socket.c  | 4 ++++
>  chardev/char.c         | 2 ++
>  include/chardev/char.h | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index d16608f1ed..88db9acd0d 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -374,7 +374,9 @@ static void tcp_chr_free_connection(Chardev *chr)
>          s->read_msgfds_num = 0;
>      }
>  
> +    qemu_mutex_lock(&chr->hup_source_lock);
>      remove_hup_source(s);
> +    qemu_mutex_unlock(&chr->hup_source_lock);
>  
>      tcp_set_msgfds(chr, NULL, 0);
>      remove_fd_in_watch(chr);
> @@ -613,6 +615,7 @@ static void update_ioc_handlers(SocketChardev *s)
>                                       tcp_chr_read, chr,
>                                       chr->gcontext);
>  
> +    qemu_mutex_lock(&chr->hup_source_lock);
>      remove_hup_source(s);
>      s->hup_source = qio_channel_create_watch(s->ioc, G_IO_HUP);
>      /*
> @@ -634,6 +637,7 @@ static void update_ioc_handlers(SocketChardev *s)
>      g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
>                            chr, NULL);
>      g_source_attach(s->hup_source, chr->gcontext);
> +    qemu_mutex_unlock(&chr->hup_source_lock);
>  }
>  
>  static void tcp_chr_connect(void *opaque)
> diff --git a/chardev/char.c b/chardev/char.c
> index bbebd246c3..d03f698b38 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -279,6 +279,7 @@ static void char_init(Object *obj)
>      chr->handover_yank_instance = false;
>      chr->logfd = -1;
>      qemu_mutex_init(&chr->chr_write_lock);
> +    qemu_mutex_init(&chr->hup_source_lock);
>  
>      /*
>       * Assume if chr_update_read_handler is implemented it will
> @@ -316,6 +317,7 @@ static void char_finalize(Object *obj)
>          close(chr->logfd);
>      }
>      qemu_mutex_destroy(&chr->chr_write_lock);
> +    qemu_mutex_destroy(&chr->hup_source_lock);
>  }
>  
>  static const TypeInfo char_type_info = {
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 429852f8d9..064184153d 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -60,6 +60,7 @@ struct Chardev {
>      Object parent_obj;
>  
>      QemuMutex chr_write_lock;
> +    QemuMutex hup_source_lock;
>      CharBackend *be;
>      char *label;
>      char *filename;
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


