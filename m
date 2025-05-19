Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66FCC54756
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 10:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGy4O-0004ex-RF; Mon, 19 May 2025 06:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGy4M-0004el-3Q
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGy4I-0001G9-NS
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747651797;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTn6bni0o1Yo/KduYnhokf80jbZXIW+ZD1FyX+562fc=;
 b=TwTcnNA98D1iYzmPgQJUAzTVdJYv01o+rpbg+mPd5Gy/IgmzF/zivmZAk9R/ZJGKXU+H8I
 5goB0pXkmWmivFdk1p87gpvF1N3F90/Aehjn3xNwRbXQG6Z4SLNhF/1TqxFEHMVhHNY0aS
 VqS6sDwEiqWUj/LuZlk7EEymdQWQneY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-PGopqNDnPnuk0YL2SYeKPg-1; Mon,
 19 May 2025 06:49:54 -0400
X-MC-Unique: PGopqNDnPnuk0YL2SYeKPg-1
X-Mimecast-MFC-AGG-ID: PGopqNDnPnuk0YL2SYeKPg_1747651793
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 642171956086; Mon, 19 May 2025 10:49:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CBC018001D8; Mon, 19 May 2025 10:49:50 +0000 (UTC)
Date: Mon, 19 May 2025 11:49:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 1/4] chardev: Fix QIOChannel refcount
Message-ID: <aCsMy-OnmUPC-sB7@redhat.com>
References: <20250515222014.4161-1-farosas@suse.de>
 <20250515222014.4161-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515222014.4161-2-farosas@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Thu, May 15, 2025 at 07:20:11PM -0300, Fabiano Rosas wrote:
> The IOWatchPoll holds a reference to the iochannel while the "child"
> source (iwp->src) is removed from the context and freed. Freeing the
> source leads to the iochannel being also freed at
> qio_channel_fd_source_finalize().
> 
> Later, io_watch_poll_prepare() tries to create another source with the
> same iochannel and hits an use after free:
> 
> ==8241==ERROR: AddressSanitizer: heap-use-after-free on address 0x514000000040
> READ of size 8 at 0x514000000040 thread T2
>     #0 0x561c2d272fcd in object_get_class  ../qom/object.c:1043:17
>     #1 0x561c2d338f84 in QIO_CHANNEL_GET_CLASS  include/io/channel.h:29:1
>     #2 0x561c2d33b26f in qio_channel_create_watch  ../io/channel.c:388:30
>     #3 0x561c2d2f0993 in io_watch_poll_prepare  ../chardev/char-io.c:65:20
>     ...
> 
> 0x514000000040 is located 0 bytes inside of 392-byte region [0x514000000040,0x5140000001c8)
> freed by thread T2 here:
>     #0 0x561c2d2319a5 in free
>     #1 0x7fb2c0926638 in g_free
>     #2 0x561c2d276507 in object_finalize  ../qom/object.c:734:9
>     #3 0x561c2d271d0d in object_unref  ../qom/object.c:1231:9
>     #4 0x561c2d32ef1d in qio_channel_fd_source_finalize  ../io/channel-watch.c:95:5
>     #5 0x7fb2c091d124 in g_source_unref_internal ../glib/gmain.c:2298
>     #6 0x561c2d2f0b6c in io_watch_poll_prepare  ../chardev/char-io.c:71:9
>     ...
> 
> previously allocated by thread T3 (connect) here:
>     #0 0x561c2d231c69 in malloc
>     #1 0x7fb2c0926518 in g_malloc
>     #2 0x561c2d27246e in object_new_with_type  ../qom/object.c:767:15
>     #3 0x561c2d272530 in object_new  ../qom/object.c:789:12
>     #4 0x561c2d320193 in qio_channel_socket_new  ../io/channel-socket.c:64:31
>     #5 0x561c2d308013 in tcp_chr_connect_client_async  ../chardev/char-socket.c:1181:12
>     #6 0x561c2d3002e7 in qmp_chardev_open_socket_client  ../chardev/char-socket.c:1281:9
>     ...
> 
> Fix the issue by incrementing the iochannel reference count when the
> IOWatchPoll takes a reference and decrementing when it is finalized.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  chardev/char-io.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


