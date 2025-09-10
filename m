Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E06DCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 17:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwODC-0008CS-33; Wed, 10 Sep 2025 13:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwODA-0008Bn-PQ
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 13:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwOD6-0003jC-St
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 13:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757523737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5ReGiGY6uadiKJ+QzUjrPbDSpgbi9ZwcLfupHAT/So=;
 b=XCmwMOidlDASkw9agBRM3x668DbWRcUgRGaQjJastWt3At11/CjIgGOLR5eZeBDOnk460k
 js6Q2cAs24cpKldAO1ubBu+RFgjCSUsesxqUk6yKG8tEoloZbu5HK0vVkgbTons1PaFbx2
 W3kHnbM7HtoGdD9IH2GFEL1naxxta/Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-bO4A4E2hPLiu-aOrr2ULUQ-1; Wed, 10 Sep 2025 12:47:30 -0400
X-MC-Unique: bO4A4E2hPLiu-aOrr2ULUQ-1
X-Mimecast-MFC-AGG-ID: bO4A4E2hPLiu-aOrr2ULUQ_1757522850
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-721094e78e5so75671626d6.1
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 09:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757522850; x=1758127650;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5ReGiGY6uadiKJ+QzUjrPbDSpgbi9ZwcLfupHAT/So=;
 b=nJynXcfNrP8RNNFtxZE/Jhye19krzjIYD5bgOlA0XmwAvVLWagTkvLXJF5+qSMDpC8
 kU1TYdKegBFcOMult7gRHg1Vl9wH5Q/mFUUsT+BhYNBruPU25gO6OARqOg6g2co3tzM5
 4+nrhbSmQcaHgcMU6d2JOyz96RPoogUZyueK+cYWsmUMUL++FL3pCjgbhKbLFOsqeD06
 ueLqzS5ahHLP8tMdGTuHkJeUcyUyGSzWnaeDwhF1Am8mVscodI8XKoZ3kAEBZjHO5vlT
 RDtGu4+UEjbyVSGehOwvrmndFj3THH3/jCvFJg5BdzGr2lu8w81gPxMWAZKBy3ihAeyx
 9I6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV9N4mK2ga0/IBkKb0U0gvb4e3YXXC4K202upKSVT+6DsDSG0V0Ea+YAraVFMppDIUqdAUUpMtK+uv@nongnu.org
X-Gm-Message-State: AOJu0YxmAdD+yE4MLQY0Sx0fbJ8jI30M9sWeG97JPHQ78T+IT3WN2DOO
 /S6OohvYirj8HijTWlT5+bufP4az1fSbNiYoOwj1Yt3N1sAPXwiu04cNiaqfW62ZHqJ4u2txLlz
 F1FyCNm6GvuctCJd0bPsh0AzJ2Eq+bjPtDG18UgtUpvAVstzH3cP+JAxs
X-Gm-Gg: ASbGncvzEirQMgtcJeGsmZQVQXlXWWCql8Ym420VDmWTdmGQo9zp1W1HO1T2pxCFiIt
 QOLdvGOcoZvmHvsLhSYhkf2E6g/PtioKhPpluY6po8DfmDzfuovNVDOi0/Nh2aQQthAfbOehZ46
 xQ8X+TA9vuYEABGJIGr2jFa+PnReVXFqkZiOrS7uo6OPwcRcIBt3xSVtWKKjgG89RKXDviHkHIy
 P6aCAF8lgCH9rwHKhqWybUiv3OxC4m06hcs3xah6OUiBOFHNCRfwH4SoP7HNSVSsaBRpfZhmzFD
 XyZC/W4jSbUCw2RVgL2ef+6GoW/T/7T4H1Ehzb6HwHrdV4DQE36YJqDOu/25uQSJvjy4o9LjWvn
 2VJiqejyUNw6/PdHYQULdPQ==
X-Received: by 2002:a0c:f092:0:20b0:73b:d22e:14c5 with SMTP id
 6a1803df08f44-73bd22e1629mr142923676d6.3.1757522849734; 
 Wed, 10 Sep 2025 09:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzREP4taqWZIQoMGNLRYw2eALmGxP7o151JaOGGRFZmkuAxbM33pCfbvI1NdbTRFQ4BetYtA==
X-Received: by 2002:a0c:f092:0:20b0:73b:d22e:14c5 with SMTP id
 6a1803df08f44-73bd22e1629mr142923186d6.3.1757522849145; 
 Wed, 10 Sep 2025 09:47:29 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-72925b87571sm124927506d6.6.2025.09.10.09.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:47:28 -0700 (PDT)
Date: Wed, 10 Sep 2025 12:47:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, farosas@suse.de,
 steven.sistare@oracle.com
Subject: Re: [PATCH v3] migration/qemu-file: don't make incoming fds blocking
 again
Message-ID: <aMGrnua2KHDerfMi@x1.local>
References: <20250910143156.1053779-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910143156.1053779-1-vsementsov@yandex-team.ru>
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

On Wed, Sep 10, 2025 at 05:31:56PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> In migration we want to pass fd "as is", not changing its
> blocking status.
> 
> The only current user of these fds is CPR state (through VMSTATE_FD),
> which of-course doesn't want to modify fds on target when source is
> still running and use these fds.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> v3: RESEND, add qemu-devel to CC, sorry for the noise
> v2: rework, following Daniel's suggestion to use flag.
> 
>  include/io/channel.h  |  1 +
>  io/channel-socket.c   | 12 ++++++++----
>  io/channel.c          |  2 +-
>  migration/qemu-file.c |  3 ++-
>  4 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 234e5db70d..5394f50768 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -36,6 +36,7 @@ OBJECT_DECLARE_TYPE(QIOChannel, QIOChannelClass,
>  
>  #define QIO_CHANNEL_READ_FLAG_MSG_PEEK 0x1
>  #define QIO_CHANNEL_READ_FLAG_RELAXED_EOF 0x2
> +#define QIO_CHANNEL_READ_FLAG_PRESERVE_BLOCKING 0x4

Shouldn't the name reflect FD somehow?  Or it can imply preservation
blocking for the channel itself.

  QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING 
  QIO_CHANNEL_READ_FLAG_PRESERVE_FD_BLOCKING 
  ...

>  
>  typedef enum QIOChannelFeature QIOChannelFeature;
>  
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 3b7ca924ff..2f6e2d84a3 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -464,7 +464,8 @@ static void qio_channel_socket_finalize(Object *obj)
>  
>  #ifndef WIN32
>  static void qio_channel_socket_copy_fds(struct msghdr *msg,
> -                                        int **fds, size_t *nfds)
> +                                        int **fds, size_t *nfds,
> +                                        bool preserve_blocking)
>  {
>      struct cmsghdr *cmsg;
>  
> @@ -497,8 +498,10 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
>                  continue;
>              }
>  
> -            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> -            qemu_socket_set_block(fd);
> +            if (!preserve_blocking) {
> +                /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> +                qemu_socket_set_block(fd);
> +            }
>  
>  #ifndef MSG_CMSG_CLOEXEC
>              qemu_set_cloexec(fd);
> @@ -556,7 +559,8 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
>      }
>  
>      if (fds && nfds) {
> -        qio_channel_socket_copy_fds(&msg, fds, nfds);
> +        qio_channel_socket_copy_fds(
> +            &msg, fds, nfds, flags & QIO_CHANNEL_READ_FLAG_PRESERVE_BLOCKING);
>      }
>  
>      return ret;
> diff --git a/io/channel.c b/io/channel.c
> index ebd9322765..50d5f7b10b 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -58,7 +58,7 @@ ssize_t qio_channel_readv_full(QIOChannel *ioc,
>  {
>      QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
>  
> -    if ((fds || nfds) &&
> +    if ((fds || nfds || (flags & QIO_CHANNEL_READ_FLAG_PRESERVE_BLOCKING)) &&

Not a huge deal, but.. IMHO we can simply ignore this flag when fds==NULL.

It can also make callers' lives slightly easier too by always passing in
this flag when necessary, like in below.

>          !qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
>          error_setg_errno(errp, EINVAL,
>                           "Channel does not support file descriptor passing");
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index b6ac190034..92c7b5678b 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -324,6 +324,7 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>      size_t nfd = 0;
>      int **pfds = f->can_pass_fd ? &fds : NULL;
>      size_t *pnfd = f->can_pass_fd ? &nfd : NULL;
> +    int flags = f->can_pass_fd ? QIO_CHANNEL_READ_FLAG_PRESERVE_BLOCKING : 0;
>  
>      assert(!qemu_file_is_writable(f));
>  
> @@ -340,7 +341,7 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>  
>      do {
>          struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
> -        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
> +        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, flags,
>                                       &local_error);
>          if (len == QIO_CHANNEL_ERR_BLOCK) {
>              if (qemu_in_coroutine()) {
> -- 
> 2.48.1
> 

-- 
Peter Xu


