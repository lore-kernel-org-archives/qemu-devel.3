Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F1BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbyqo-0003fn-JF; Thu, 08 Aug 2024 04:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbyqn-0003fF-74
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbyql-0007fv-Em
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723107022;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=v6J6+UE9yoZgVAxKMzhrpg6GLnnB0hBvKEnUQ2lmG68=;
 b=hO60IvN5rO2TGVmi9sOyg8AmMOoqEdR0UUl/KnhHKOH/FMuUfWhwT52IVc5gZkl0EpAZFk
 p2EVsIZ7Z/YUbsGzLqHC7RiY85s2hDxH/LiJblgkR27SRD9LRsEc7aEndtjHgkZRwkSZL0
 3KpIjTCtAvlnbLm529dY+R1jGJ/lHVA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-ZV18ngK2O1Kma1FLlgQt7Q-1; Thu,
 08 Aug 2024 04:50:18 -0400
X-MC-Unique: ZV18ngK2O1Kma1FLlgQt7Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7E1E19560A2; Thu,  8 Aug 2024 08:50:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15A5D19560A3; Thu,  8 Aug 2024 08:50:14 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:50:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: yaozhenguo <yaozhenguo1@gmail.com>
Cc: qemu-devel@nongnu.org, yaozhenguo@jd.com
Subject: Re: [PATCH] qio: fix qemu crash when live migration
Message-ID: <ZrSGwy0H7nhIwMZz@redhat.com>
References: <20240808030411.76990-1-yaozhenguo@jd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240808030411.76990-1-yaozhenguo@jd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 08, 2024 at 11:04:11AM +0800, yaozhenguo wrote:
> qemu will crash in live migration cleanup process at source host.
> BT is as below:
> 
> 0  0x00007f740fc9e165 in g_source_destroy () at /usr/lib64/libglib-2.0.so.0
> 1  0x000055a2982a0f6e in qio_net_listener_set_client_func_full
> 2  0x000055a298345130 in tcp_chr_update_read_handler
> 3  0x000055a298341598 in qemu_chr_fe_set_handlers_full
> 4  0x000055a298341655 in qemu_chr_fe_set_handlers
> 5  0x000055a298191e75 in vhost_user_blk_event
> 6  0x000055a298292b79 in object_deinit
> 7  object_finalize
> 8  object_unref
> 9  0x000055a298292b3c in object_property_del_all
> 10 object_finalize
> 11 object_unref
> 12 0x000055a298291d7d in object_property_del_child
> 13 object_unparent
> 14 0x000055a29834a3c4 in qemu_chr_cleanup
> 15 0x000055a298160d87 in qemu_cleanup
> 16 0x000055a297e6bff1 in main
> 
> Crash reason is that qio_net_listener_finalize is called before
> qio_net_listener_set_client_func_full. so, listener->io_source
> is used after free. fix this by adding more checks.

If finalize() has been called, then not only has listener->io_source
been freed, but 'listener' itself has also been freed, thus....

> 
> Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
> ---
>  io/net-listener.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/io/net-listener.c b/io/net-listener.c
> index 47405965a6..c02965f919 100644
> --- a/io/net-listener.c
> +++ b/io/net-listener.c
> @@ -143,6 +143,11 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
>  {
>      size_t i;
>  
> +
> +    if (!listener->nsioc || !listener->io_source || !listener->name) {
> +        return;
> +    }

....this is still accessing freed memory for 'listener'.


What is the call path of the stack triggering qio_net_listener_finalize ?

Whatever callpath has done that needs to be setting SocketChardev->listener
field to NULL, because tcp_chr_update_read_handler will check for NULL
before calling qio_net_listener_set_client_func_full.

> +
>      if (listener->io_notify) {
>          listener->io_notify(listener->io_data);
>      }
> @@ -264,6 +269,10 @@ void qio_net_listener_disconnect(QIONetListener *listener)
>  {
>      size_t i;
>  
> +    if (!listener->nsioc || !listener->io_source || !listener->name) {
> +        return;
> +    }
> +
>      if (!listener->connected) {
>          return;
>      }
> @@ -301,6 +310,10 @@ static void qio_net_listener_finalize(Object *obj)
>      g_free(listener->io_source);
>      g_free(listener->sioc);
>      g_free(listener->name);
> +
> +    listener->io_source = NULL;
> +    listener->sioc = NULL;
> +    listener->name = NULL;
>  }
>  
>  static const TypeInfo qio_net_listener_info = {
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


