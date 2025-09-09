Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B2BCAC589
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 08:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvtsO-0001yf-G2; Tue, 09 Sep 2025 04:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvtsM-0001y2-Gm
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 04:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvtsF-0002ta-U0
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 04:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757407126;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fl7pOOphCcRVFi5KnNaNyHtIUAcphYtyW1XCVxzc7Ew=;
 b=SGn6xHZ7QXbvpIv6vgIPYEpcsKX6iLS4dQ56cDFl+xt2CCW7d6QKSC5nFoBefUw1PIUD9n
 BpRx6FXjfz+SDNg7PyKV7Wat72XchKcz8bzWgB+wNmTS/jAJKshStI7P2m8+JeMLof4Z0D
 8phhn/1BNuo5QLye1zRYrLBjgx8+FSw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-N2nNdOroOS2auUSjXihqSg-1; Tue,
 09 Sep 2025 04:38:43 -0400
X-MC-Unique: N2nNdOroOS2auUSjXihqSg-1
X-Mimecast-MFC-AGG-ID: N2nNdOroOS2auUSjXihqSg_1757407122
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76ADB1800447; Tue,  9 Sep 2025 08:38:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C6381800452; Tue,  9 Sep 2025 08:38:39 +0000 (UTC)
Date: Tue, 9 Sep 2025 09:38:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 02/10] char-socket: rework tcp_chr_recv()
Message-ID: <aL_njFMhsCazHxUf@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-3-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903094411.1029449-3-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Wed, Sep 03, 2025 at 12:44:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> First, qio_channel_readv_full() already guarantees BLOCKING and
> CLOEXEC states for incoming descriptors, no reason call extra
> ioctls.
> 
> Second, current implementation calls _set_block() and _set_cloexec()
> again on old descriptors on failure path - we fix this too.
> 
> Finally, handling errors exactly after qio_channel_readv_full() call
> looks more readable.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  chardev/char-socket.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 1e8313915b..5b9b19ba8b 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -293,6 +293,18 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
>                                       0, &err);
>      }
>  
> +    if (ret == QIO_CHANNEL_ERR_BLOCK) {
> +        errno = EAGAIN;
> +        return -1;
> +    } else if (ret == -1) {
> +        trace_chr_socket_recv_err(chr, chr->label, error_get_pretty(err));
> +        error_free(err);
> +        errno = EIO;
> +        return -1;
> +    }
> +
> +    assert(ret >= 0);

Moving this logic to here means that in the blocking I/O, and/or error
paths, we are not clearing out the previously read s->read_msgfds_num
These should be considered obsolete at the point we start a new read
call, regardless of its success, hence why we had the code ordered in
this way.


> +
>      if (msgfds_num) {
>          /* close and clean read_msgfds */
>          for (i = 0; i < s->read_msgfds_num; i++) {
> @@ -307,30 +319,7 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
>          s->read_msgfds_num = msgfds_num;
>      }
>  
> -    for (i = 0; i < s->read_msgfds_num; i++) {
> -        int fd = s->read_msgfds[i];
> -        if (fd < 0) {
> -            continue;
> -        }
> -
> -        /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> -        qemu_socket_set_block(fd);
> -
> -#ifndef MSG_CMSG_CLOEXEC
> -        qemu_set_cloexec(fd);
> -#endif
> -    }

This for(){} removal is fnie.

> -
> -    if (ret == QIO_CHANNEL_ERR_BLOCK) {
> -        errno = EAGAIN;
> -        ret = -1;
> -    } else if (ret == -1) {
> -        trace_chr_socket_recv_err(chr, chr->label, error_get_pretty(err));
> -        error_free(err);
> -        errno = EIO;
> -    } else if (ret == 0) {
> -        trace_chr_socket_recv_eof(chr, chr->label);
> -    }
> +    trace_chr_socket_recv_eof(chr, chr->label);
>  
>      return ret;
>  }
> -- 
> 2.48.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


