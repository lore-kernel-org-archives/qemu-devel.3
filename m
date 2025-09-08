Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8269CAC582
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 22:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvjwU-0004Wy-7Z; Mon, 08 Sep 2025 18:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvjwS-0004Wl-Li
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 18:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvjwN-00021M-8p
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 18:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757368941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0MT/qOLggLvm3Xq0cmbGLwUuTk31mWCajRwdOSs8Z4=;
 b=ahFjcQdYa1hBEkolwee7aZu35YaWADxm8iNMMxZqz35fh/ojdrwtHaENh2pQ6z939M5/Dn
 NkhJPmOxrw2zZMoZQk4Xagg++N3QZMtcSTMzifXmxciTza1xcOLrwOX19+PAm6HOX42mNw
 AnDZzMGv5RLzxLwJaD534quuh4SYerc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-j8hMu544Pl2tVPlzpFcm8w-1; Mon, 08 Sep 2025 18:02:20 -0400
X-MC-Unique: j8hMu544Pl2tVPlzpFcm8w-1
X-Mimecast-MFC-AGG-ID: j8hMu544Pl2tVPlzpFcm8w_1757368939
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-819781ca2d4so209027485a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 15:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757368939; x=1757973739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0MT/qOLggLvm3Xq0cmbGLwUuTk31mWCajRwdOSs8Z4=;
 b=vgUsoKeZtH0LzSIWs+6Uz7RyWsVEEj0087XCCIfPa8QUzoJzQEuDEOO55rAcvRQSw/
 Vpx9aiChC844GD3KXiMhlfR9KtuBuT05lPeW3a17BC5cTdZEj/vwVAGkKmeY9beQ4ELh
 tyNjbEi2uY52XDwuXLqvvKTEXDE9i5l2xhhIc8Y3ME6FyDzoAec0kYq+CTN0yFouJozj
 He1uMAI11ZxFxf/stPJG0Z2MB0wbCpFOr/7npUSR3021dDkEHhXa6jMAKbR1FYzUh5rV
 jxkGVYOUN0mcLRp1rCErSQ+KFjMNIB4/vqnLWt4sPznviKWiMGgEECTu8RqUOk/p8pse
 euEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaA+l0WczqXLY4o2e2kSgs7dcBL3q0u1awWfF8/5puSOQgtVeFF7Iyl0Ub293PePvMEOdRfDFiIrDc@nongnu.org
X-Gm-Message-State: AOJu0Ywf1rDXBmQiOs9AL4jnacDcNBwoLJy63UXTm9++GJgQ6NB+AP80
 A55pUL8CWFku34LXPeLRa5UhoWcgl1wAfyCM8kbrJrbUqqF8oymroOm2KBAs64Uh3XleOecu0cL
 zFIMJHaitUMRBEXOL0JsI7sln/JHhj6chvxVieLkr8Sj8yOYDdclIAzNq
X-Gm-Gg: ASbGncvwP7IAtI7W6VX5CLLdIVdMffF3BJ2oxTKOCVWoe7wM5opr1qfgwnJHY7qbt6W
 ZAa2aV1iVXGZWdWm8CEeOn/jnlyN1QbcUMW2kT7X5JY5NFzfC8/MTgEtGPFpEoAZw7Cr8N6N0e3
 /bdUgANV6vL2B7jQvN4L4cqCzoGcBau61nxEplVErLDApK/GGXdr3MktwEwJxmssP6M1pmqDPDn
 xorUhf39AQ3FCluuGcIP4KreRPjeRG9wQbKym9+f/HmeANJx69Ktz7poagcoXjlNoaZWA0WQSCR
 D9KhMj/1rjnFukKzh3vHtlhgPoYZDuQcqXpyam9KmDeUDW1LYmWMOXeUW/9Yh6gRv+vsH21+xDm
 XWwqhvD4YuqhSP3xT37dqNQ==
X-Received: by 2002:a05:620a:701a:b0:802:18ca:7032 with SMTP id
 af79cd13be357-813c443d002mr946952585a.83.1757368937774; 
 Mon, 08 Sep 2025 15:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG50RoBvlRGOATaHlU92CMu4rQv/XCFD+iUxJGz7WIlqAQL8Uu1ysaVnUgoM0G+2/Fyx7ih0w==
X-Received: by 2002:a05:620a:701a:b0:802:18ca:7032 with SMTP id
 af79cd13be357-813c443d002mr946944385a.83.1757368937162; 
 Mon, 08 Sep 2025 15:02:17 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-81b5e4cb839sm12338585a.35.2025.09.08.15.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 15:02:16 -0700 (PDT)
Date: Mon, 8 Sep 2025 18:02:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH 03/10] util: add qemu_set_blocking() function
Message-ID: <aL9SZr8uU4lp0o41@x1.local>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-4-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903094411.1029449-4-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 03, 2025 at 12:44:03PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> In generic code we have qio_channel_set_blocking(), which takes
> bool parameter, and qemu_file_set_blocking(), which as well takes
> bool parameter.
> 
> At lower fd-layer we have a mess of functions:
> 
> - enough direct calls to g_unix_set_fd_nonblocking()
> and several wrappers without bool parameter:
> 
> - qemu_scoket_set_nonblock(), which asserts success for posix (still,
>   in most cases we can handle the error in better way) and ignores
>   error for win32 realization
> 
> - qemu_socket_try_set_nonblock(), the best one
> 
> - qemu_socket_set_block(), which simply ignores an error, the worst
>   case
> 
> And all three lack errp argument, so we have to handle it after the
> call.
> 
> So let's introduce a new socket-layer wrapper, and use it consistently
> in following commits.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/qemu/osdep.h |  1 +
>  util/oslib-posix.c   | 12 ++++++++++++
>  util/oslib-win32.c   | 18 ++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index be3460b32f..1b38cb7e45 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -687,6 +687,7 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
>      G_GNUC_WARN_UNUSED_RESULT;
>  
>  void qemu_set_cloexec(int fd);
> +bool qemu_set_blocking(int fd, bool block, Error **errp);
>  
>  /* Return a dynamically allocated directory path that is appropriate for storing
>   * local state.
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 4ff577e5de..e473938195 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -250,6 +250,18 @@ void qemu_anon_ram_free(void *ptr, size_t size)
>  #endif
>  }
>  
> +bool qemu_set_blocking(int fd, bool block, Error **errp)
> +{
> +    if (!g_unix_set_fd_nonblocking(fd, !block, NULL)) {

If we want to do the best, we could also pass in GError** here, and convert
GError(.message) to errp?

> +        error_setg_errno(errp, errno,
> +                         "Can't set file descriptor %d %s", fd,
> +                         block ? "blocking" : "non-blocking");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  void qemu_socket_set_block(int fd)
>  {
>      g_unix_set_fd_nonblocking(fd, false, NULL);
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index b7351634ec..03044f5b59 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -177,6 +177,24 @@ static int socket_error(void)
>      }
>  }
>  
> +bool qemu_set_blocking(int fd, bool block, Error **errp)
> +{
> +    unsigned long opt = block ? 0 : 1;
> +
> +    if (block) {
> +        qemu_socket_unselect(fd, NULL);
> +    }
> +
> +    if (ioctlsocket(fd, FIONBIO, &opt) != NO_ERROR) {
> +        error_setg_errno(errp, socket_error(),
> +                         "Can't set file descriptor %d %s", fd,
> +                         block ? "blocking" : "non-blocking");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  void qemu_socket_set_block(int fd)
>  {
>      unsigned long opt = 0;
> -- 
> 2.48.1
> 

-- 
Peter Xu


