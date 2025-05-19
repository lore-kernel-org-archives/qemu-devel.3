Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2596C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 10:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGy6b-0005T6-Sj; Mon, 19 May 2025 06:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGy6Z-0005Sp-SA
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGy6Y-0001cu-0Y
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747651940;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YF2vWK9Q4r4bHptI7XUcNCW5CxVm7CrKm2zfJGYBN7w=;
 b=J+S1N+ciVlK3pjD6YMYzyzTuJvn6a5Y4UAlDcWpqSw5+eWQoFMgybhUGE/CUKBJy6Gznx4
 fb72w4a1jpY7uUPlCI2cXM+jkP+cNVnWghQXWevYDLdoB2uQXILzFUuhwbrJUD26dmZLku
 Hd2ntYUZy3uui2ylu6LohMmWc1eu4LQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-br6rnCesPkyIbL9kXw6O3w-1; Mon,
 19 May 2025 06:52:18 -0400
X-MC-Unique: br6rnCesPkyIbL9kXw6O3w-1
X-Mimecast-MFC-AGG-ID: br6rnCesPkyIbL9kXw6O3w_1747651938
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D68871955DAB; Mon, 19 May 2025 10:52:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 682671800268; Mon, 19 May 2025 10:52:16 +0000 (UTC)
Date: Mon, 19 May 2025 11:52:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 2/4] chardev: Don't attempt to unregister yank function
 more than once
Message-ID: <aCsNXIpN5CVCG70S@redhat.com>
References: <20250515222014.4161-1-farosas@suse.de>
 <20250515222014.4161-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515222014.4161-3-farosas@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Thu, May 15, 2025 at 07:20:12PM -0300, Fabiano Rosas wrote:
> tcp_chr_free_connection() can be called multiple times in succession,
> in which case the yank function will get as argument a NULL s->sioc
> that has been cleared by the previous tcp_chr_free_connection() call.
> 
> This leads to an abort() at yank_unregister_function().
> 
>  #0  __GI_raise (sig=6) at ../sysdeps/unix/sysv/linux/raise.c:51
>  #1  __GI_abort () at abort.c:79
>  #2  qtest_check_status (s=0x513000005600) at ../tests/qtest/libqtest.c:209
>  #3  qtest_wait_qemu (s=0x513000005600) at ../tests/qtest/libqtest.c:273
>  #4  qtest_kill_qemu (s=0x513000005600) at ../tests/qtest/libqtest.c:285
>  #5  kill_qemu_hook_func (s=0x513000005600) at ../tests/qtest/libqtest.c:294
>  #6  g_hook_list_invoke (hook_list=0x55ea9cc750c0 <abrt_hooks>, may_recurse=0) at ../glib/ghook.c:534
>  #7  sigabrt_handler (signo=6) at ../tests/qtest/libqtest.c:299
>  #8  <signal handler called>
>  #9  __GI_raise (sig=6) at ../sysdeps/unix/sysv/linux/raise.c:51
>  #10 __GI_abort () at abort.c:79
>  #11 yank_unregister_function (instance=0x7fb26f2ea9a0,
>      func=0x55ea9bcc0a10 <char_socket_yank_iochannel>, opaque=0x0) at
>      ../util/yank.c:151
>  #12 tcp_chr_free_connection (chr=0x51300000ffc0) at ../chardev/char-socket.c:385
>  #13 tcp_chr_disconnect_locked (chr=0x51300000ffc0) at ../chardev/char-socket.c:477
>  #14 tcp_chr_disconnect (chr=0x51300000ffc0) at ../chardev/char-socket.c:495
>  #15 tcp_chr_hup (channel=0x514000000040, cond=G_IO_HUP, opaque=0x51300000ffc0) at ../chardev/char-socket.c:536
>  #16 qio_channel_fd_source_dispatch (source=0x50c0000b5fc0, callback=0x55ea9bcd6770 <tcp_chr_hup>,
>      user_data=0x51300000ffc0) at ../io/channel-watch.c:84
>  #17 g_main_dispatch (context=0x50f000000040) at ../glib/gmain.c:3381
>  #18 g_main_context_dispatch (context=context@entry=0x50f000000040) at ../glib/gmain.c:4099
>  #19 g_main_context_iterate (context=0x50f000000040, block=block@entry=1, dispatch=dispatch@entry=1,
>      self=<optimized out>) at ../glib/gmain.c:4175
>  #20 g_main_loop_run (loop=0x502000055690) at ../glib/gmain.c:4373
> 
> Commit ebae6477dc ("chardev: check if the chardev is registered for
> yanking") seems to have encountered a similar issue, but checking
> s->registered_yank is not a complete solution because that flag
> pertains to the yank instance, not to each individual function.
> 
> Skip the yank_unregister_function() in case s->sioc is already NULL,
> which indicates the last yank function was already removed.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> Can tcp_chr_free_connection() race with itself? I'm assuming no.
> 
> Could we just make yank_unregister_instance() remove all yank
> functions at once? Those asserts/abort in the yank code are a bit
> masochistic.
> ---
>  chardev/char-socket.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


