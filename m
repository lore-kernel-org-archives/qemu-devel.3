Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8139ACA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 21:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvjnn-0000zJ-JU; Mon, 08 Sep 2025 17:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvjnl-0000yQ-Pm
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvjni-0000l7-Ui
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757368404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHP1XjKaA3r6d8jPu0T7HqmzsW4slgna+aqru/2LixQ=;
 b=KED5xqs/7mZDoYpNksUx/c56Lb+m1bStWM9Tt0KnDfdDU/Q9Jfe4+m2MDtFCr4M+M411g1
 Ug5S8D/UYu73N8hXSzqyS+yRol8Laiz8vmud+tjCQp4BcRv8HU05nOk+LwriuuZIkft9Q1
 XnM4tQ2j8br7mqGBBTPoG6mqeAvyFCY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-I7veO6VhPim56LXjthdVOg-1; Mon, 08 Sep 2025 17:53:23 -0400
X-MC-Unique: I7veO6VhPim56LXjthdVOg-1
X-Mimecast-MFC-AGG-ID: I7veO6VhPim56LXjthdVOg_1757368403
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8153161a93eso745923585a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 14:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757368403; x=1757973203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHP1XjKaA3r6d8jPu0T7HqmzsW4slgna+aqru/2LixQ=;
 b=qhtLJ6c3G3sFNjkad/8lzCX53cnW2yc2CSqbqYILJL0ozidShaIEp0dXhnXuB+/KWU
 +QbCORFE7fOn8J1jz7rUpxVLonOM/myHED1BNqpLKJEzTxPzLI5IogOIUA6f7/AhRevv
 3lIcAK0Px9RRy2lVlHgEUFy4E7bAsNIBbaYxNPFkcOYOPhIdw1iZ4NToCC5iFIK9fjSS
 OpupvmnnKmYcWiaaNaZ3sW7O+SzfrwEyYYnWjpjnZRIy8MsOTmT8bNPKePDeYs+HBJKP
 iIbL0LBNh3S3iz7No8HerORdy/thtxVbvXZc0/x4nSI6DvHSgTAE+Bg9cKQdYYZQaSY7
 /oVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpWfqFp2JCSH2+ZdcwyAGGshhh9HiqDBPvIHe0oU5eYRIu3BdQNqLP5MUbLfBD66fVoIZJvmoo9kr+@nongnu.org
X-Gm-Message-State: AOJu0YyUjg+InpyZIdOhDl0qQ+TUS8nCkGc7DBqucUAVHw02KiWtYlZL
 bc12p0PSx8Enip5boyXsyINzZ3wZYly79SmBJBpALv2uwu9CRuMsE8JrQDoI2Ffx9OGNjeNy9Un
 6tqPAUU2aqwl+owXlHbobpKABVzI5nfc9kPArTa1Oxe8o1U1tcqOKYSLO
X-Gm-Gg: ASbGncuxtqed8kviXGYdq3a2m2XkD3Bp0UDQJokeuRmFAltdIiIpIPl2kJ67Ku4WmJP
 ksyryT796tIpAqozO3QnL+JL2knHMAQiNtg25oSfqv5N5yzqbnIEF7OfwEIEH7RiOWHOTVtvbPD
 eJnE/iI2j+Lwb3e6O1S3LZ5BkSAAqMR1rIuk3HnIOSbdrWdW0UDo4cFRhFQMivh3W7qT2OmpfNp
 ulv3NG5A2Fjyw7LOgLkv20od4R+SfQfAPPW20V7Hh275k+18YUHTn+45JYEoH5rQ6gS7AF2YQZM
 oasiZie33EJGa1L3cY15qyMXo9jbayJt460LUYiRM4W2TXrV9ROs/5gsF+MJtX0Z3/xDX8cKttj
 TyJcQZ+ngFJToISXWC+Ic6g==
X-Received: by 2002:a05:620a:178e:b0:815:abea:dc94 with SMTP id
 af79cd13be357-815abeadeaemr741061685a.19.1757368402688; 
 Mon, 08 Sep 2025 14:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Y3PSAAQUQ3utu5Q108VDbXPdQHpERPdmvxJx4Y5Yl2Rylakm+wQ+dZmWpdbDpxYmuXQuzg==
X-Received: by 2002:a05:620a:178e:b0:815:abea:dc94 with SMTP id
 af79cd13be357-815abeadeaemr741059885a.19.1757368402242; 
 Mon, 08 Sep 2025 14:53:22 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61bbbc28csm869971cf.28.2025.09.08.14.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 14:53:21 -0700 (PDT)
Date: Mon, 8 Sep 2025 17:53:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 02/10] char-socket: rework tcp_chr_recv()
Message-ID: <aL9QT9T2QTCA_tks@x1.local>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-3-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903094411.1029449-3-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

This tracepoint may still need to be put into a ret==0 check.

Looks reasonable other than that..

>  
>      return ret;
>  }
> -- 
> 2.48.1
> 

-- 
Peter Xu


