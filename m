Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01382CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 13:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoiql-0005su-It; Wed, 20 Aug 2025 09:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uoiqi-0005rk-MP
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:27:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uoiqe-0004HQ-5g
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755696445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yVY1UyzCvi2E1JH3d2fiAsFw7OWxxUq6lfrhKRwY1+U=;
 b=Gjrpl8ToqxxHuHGCTd2gFHt7NJBo/HlMjRUh/Xdi8RHsSAy7a4WAYxsHkjnY3BHpdDdwzp
 Q1zUDyRC7+Fh6iEUwdvR0B4PoQgTcOazYD1KxsQpxyXkU8GbOWomY7XWKARpnL+5yr7AI4
 Kzj3faYMroayzeOeK6jMXLTWZwsW3dQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-wqUMROeINOaKB3s529Us7w-1; Wed, 20 Aug 2025 09:27:24 -0400
X-MC-Unique: wqUMROeINOaKB3s529Us7w-1
X-Mimecast-MFC-AGG-ID: wqUMROeINOaKB3s529Us7w_1755696444
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e8704ea619so1884825685a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 06:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755696444; x=1756301244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVY1UyzCvi2E1JH3d2fiAsFw7OWxxUq6lfrhKRwY1+U=;
 b=KSvq30Bs5sdfXPjQYVHniNl0wUqnTndJs2h8ibHhq7D4S9Ta855cdO5GycgjrtjxRf
 T62B3Y03nXohyqbSca8DnF3oA3WXalgXfIt+KB3riTCib6S8A1ilATEqed85Z4OHYDKR
 47Z/XYkQDZ6/JG2oFtB3xcw+niSTbHA7P0uQEnZvx5XNwsRkN/WhanYtfUN7po7tSfYd
 Yj3DvyIWvRNECEt87glK8YTdXQw4jBPtIoWegiyrYHuaeA63q2eadXy8bHoEbxJ0SrHK
 zGOpdzFJZlUdYl8gzlvJCNE7jIdCPyrxznhJ8NFTzZdCdWUICEIvwlJj1P+7aoBsVJ2L
 DHBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXhGQjfAMtoouCuuzIg4WxHJJewc230D1XMVtV9198inUgzzHser9bUkY54MqYUNN5d9w0XCiL7pQQ@nongnu.org
X-Gm-Message-State: AOJu0Yz+u6KBhuaX3yjNpqc3EMprJIDg9wRzAPbh5wqMRR+fHfeICHnJ
 EgAhhjfLeo+YVTbGkYuTVjTKN3oCi2ifaov/t94+TuBtSyGajjyk3grWE6jGazzwMShIOiMXeaI
 Ehkwu62GOH5XS0efKtLHy4oMs7BZdBwTqSNJR9y2rdLG4APpqUGBPfY86
X-Gm-Gg: ASbGncsFdt40dcHt5xlEKA3bVUN93It/4JmwxYdBYCO16AroDB1a0f0bsJgwHp5pyzZ
 6y+RauHhkd5H/hLRxkRObzETYPzENIn3AK3ZHRCLBrjBXg1QHNyepvTtXwR0lkYl7mmHgaKnR0q
 BCykO7taRw+KDXGxRumaPn+kbtZru5Yh9dfprf4w3DGIRX4MGo7A1SZOsYrLrBzpYJZ2rPLqgbH
 piPbuStkoGyCtUPg7dtV6V+EzkKkEUnSPpM/4yo/eJOEflovNp2er8pC7CVpZGKK3ctxSzRqz+t
 mcosU32R5bMSThHsgmovDozaagBGTJS9
X-Received: by 2002:a05:620a:4727:b0:7e9:fbd4:d77c with SMTP id
 af79cd13be357-7e9fcb4df14mr320596985a.63.1755696443617; 
 Wed, 20 Aug 2025 06:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjFtf3V9bsKOa/5RgFpAMnmvXA9w9o7cZw26sFFAb+dSQxPaaw7BCgxqYje0niLh8uJmFTKA==
X-Received: by 2002:a05:620a:4727:b0:7e9:fbd4:d77c with SMTP id
 af79cd13be357-7e9fcb4df14mr320592385a.63.1755696443012; 
 Wed, 20 Aug 2025 06:27:23 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba92fa157sm88638976d6.47.2025.08.20.06.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 06:27:22 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:27:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, farosas@suse.de, raphael@enfabrica.net,
 sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Subject: Re: [PATCH 26/33] io/channel-socket: introduce
 qio_channel_socket_keep_nonblock()
Message-ID: <aKXNLfKWzHKUhGaz@x1.local>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-27-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813164856.950363-27-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 13, 2025 at 07:48:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add a possibility to keep socket non-block status when passing
> through qio channel. We need this to support migration of open
> fds through migration channel.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/io/channel-socket.h |  3 +++
>  io/channel-socket.c         | 16 ++++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index a88cf8b3a9..0a4327d745 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -49,6 +49,7 @@ struct QIOChannelSocket {
>      socklen_t remoteAddrLen;
>      ssize_t zero_copy_queued;
>      ssize_t zero_copy_sent;
> +    bool keep_nonblock;
>  };
>  
>  
> @@ -275,4 +276,6 @@ int qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc,
>                                         size_t size,
>                                         Error **errp);
>  
> +void qio_channel_socket_keep_nonblock(QIOChannel *ioc);
> +
>  #endif /* QIO_CHANNEL_SOCKET_H */
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 3b7ca924ff..cd93d7f180 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -462,9 +462,16 @@ static void qio_channel_socket_finalize(Object *obj)
>  }
>  
>  
> +void qio_channel_socket_keep_nonblock(QIOChannel *ioc)
> +{
> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> +    sioc->keep_nonblock = true;
> +}
> +
> +
>  #ifndef WIN32
>  static void qio_channel_socket_copy_fds(struct msghdr *msg,
> -                                        int **fds, size_t *nfds)
> +                                        int **fds, size_t *nfds, bool set_block)
>  {
>      struct cmsghdr *cmsg;
>  
> @@ -497,8 +504,9 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
>                  continue;
>              }
>  
> -            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> -            qemu_socket_set_block(fd);
> +            if (set_block) {
> +                qemu_socket_set_block(fd);
> +            }

"keep_nonblock" as a feature in iochannel is slightly hard to digest.  It
can also be read as "keep the fd to be always nonblocking".

Is this feature required, or can this also be done in a get() or
post_load() on the other side to set nonblock to whatever it should be
(that dest QEMU should be aware of)?

>  
>  #ifndef MSG_CMSG_CLOEXEC
>              qemu_set_cloexec(fd);
> @@ -556,7 +564,7 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
>      }
>  
>      if (fds && nfds) {
> -        qio_channel_socket_copy_fds(&msg, fds, nfds);
> +        qio_channel_socket_copy_fds(&msg, fds, nfds, !sioc->keep_nonblock);
>      }
>  
>      return ret;
> -- 
> 2.48.1
> 
> 

-- 
Peter Xu


