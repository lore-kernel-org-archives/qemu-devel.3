Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1737C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 20:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmfB7-0005C6-K7; Mon, 24 Feb 2025 15:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmfB2-0005B6-5X
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmfAx-000234-Qr
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740429333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OOMJDSYLEp/nsBVyH2/UJTBVyVNLStcKm5MiZVNgTUs=;
 b=ggXnKlS7ZuuHd77wSQvgeLG7n7liFkeGtP7Gzfbb+8O/dIxBmvn3SRVxagtJfDpUlVF5mF
 5gmJc2mxR8hbEQA6XNIziLXRDnOwZv+dwbi1hAuJcO1oE868LJADDU4shpxUjP2/AkFpry
 L+93KKw7k+REcL49sHH487Lc+YbKkS8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-6dOaORTeM2yW2YrzT3MqUA-1; Mon, 24 Feb 2025 15:35:31 -0500
X-MC-Unique: 6dOaORTeM2yW2YrzT3MqUA-1
X-Mimecast-MFC-AGG-ID: 6dOaORTeM2yW2YrzT3MqUA_1740429331
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6dadae92652so103728746d6.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 12:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740429331; x=1741034131;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOMJDSYLEp/nsBVyH2/UJTBVyVNLStcKm5MiZVNgTUs=;
 b=aYPynJ2JkGQzVd1og9L2rg8gFNnwryyLgufYhVUdQWhDWKXpkml2CZ/hwxlDu+BRaf
 Qgn2lR8uWCOoqGEH+FqokJuVXzZfuwCYVzPQhvwp/MT6o2VGrTRy5GKRB//CXf8hz1Qa
 QFW/dIpG/bLg1AyLpiv0glLhe2dyXCLcvNWN/a7FmhhXmZCzYSALPupGjb0DgHdPpmkj
 zdjidTrDsvcyLYLLVNt35cesh0ZM+MW/Tmjje1LkpOED2p2mXb+3R/kQqlAxndOTy+Se
 zVi0zXPoczTQxvaK2dd+wdjTS1HsmEN1YtvdbPaXHTXdSqWORzI97ED88zYLXl78I4Bt
 c9qA==
X-Gm-Message-State: AOJu0YxAwwcbRUYShwN3+59oOtNi6DYT/ussC5pCVS0va02PRhHLtcBf
 jTHUfCbXeBH4+gmmFiSTUdpRwsSpwIRkB3d2snSa+siVT/OojXCXnJjNnCN2d3uSob5szmGB2Il
 O0XkHVFY7YklMJxvdxdqjCOHQevYaRLT7BvhsMKzFlKxIsCfc5wqs
X-Gm-Gg: ASbGnct2P/wpJLgD3/hOAnsDugoXUQIV5gZI84CzfiQnev4WXwq27/vIL/E4hlPEDZT
 5NrItGFtlMpXdkGPEAOysFdpi0o7YkoaZYqD10n0n0c5JWFeCkWDUmnrp3zrl9aI8hR+JHAEjWy
 GVSlF5mNNOLNRbD7trmSDtVuOkCWUge4sz9jWv+ybMWo3Jdk8uoMr8b8I7CHnVEHIg5p64v+meR
 9nSSHZzoh+JNu5CoSahdsF5lXGEzvg1DiCp7uv9HEBLsyraIB05K9yaHXs9/dKFrczxpA==
X-Received: by 2002:a05:6214:1243:b0:6e2:4859:f062 with SMTP id
 6a1803df08f44-6e87ab46f57mr8829336d6.21.1740429330884; 
 Mon, 24 Feb 2025 12:35:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyokh+92qDIYc3PTdgixra9bG5Spm4A20I4PBhgrfkfBrb6ta8I8nrX8I23YEASCGHf2HhdQ==
X-Received: by 2002:a05:6214:1243:b0:6e2:4859:f062 with SMTP id
 6a1803df08f44-6e87ab46f57mr8828966d6.21.1740429330563; 
 Mon, 24 Feb 2025 12:35:30 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e87b176cfesm1027856d6.111.2025.02.24.12.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 12:35:30 -0800 (PST)
Date: Mon, 24 Feb 2025 15:35:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Manish Mishra <manish.mishra@nutanix.com>
Cc: qemu-devel@nongnu.org, leobras@redhat.com, berrange@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] QIOChannelSocket: Flush zerocopy socket error queue on
 ENOBUF failure for sendmsg
Message-ID: <Z7zX9fz1lFDdi-rA@x1.local>
References: <20250221094448.206845-1-manish.mishra@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221094448.206845-1-manish.mishra@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 21, 2025 at 04:44:48AM -0500, Manish Mishra wrote:
> We allocate extra metadata SKBs in case of zerocopy send. This metadata memory
> is accounted for in the OPTMEM limit. If there is any error with sending
> zerocopy data or if zerocopy was skipped, these metadata SKBs are queued in the
> socket error queue. This error queue is freed when userspace reads it.
> 
> Usually, if there are continuous failures, we merge the metadata into a single
> SKB and free another one. However, if there is any out-of-order processing or
> an intermittent zerocopy failures, this error chain can grow significantly,
> exhausting the OPTMEM limit. As a result, all new sendmsg requests fail to
> allocate any new SKB, leading to an ENOBUF error.
> 
> To workaround this, if we encounter an ENOBUF error with a zerocopy sendmsg,
> we flush the error queue and retry once more.

Could you add some more info on how this issue could be reproduced?  When
it happens, it should only report zerocopy skipped and that's the only case
below would be helpful, am I right?  (otherwise it should fail sendmsg()
anyway in other form)

Please copy Fabiano when repost.

> 
> Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
> ---
>  include/io/channel-socket.h |  1 +
>  io/channel-socket.c         | 52 ++++++++++++++++++++++++++++++++-----
>  2 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index ab15577d38..6cfc66eb5b 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -49,6 +49,7 @@ struct QIOChannelSocket {
>      socklen_t remoteAddrLen;
>      ssize_t zero_copy_queued;
>      ssize_t zero_copy_sent;
> +    bool new_zero_copy_sent_success;
>  };
>  
>  
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 608bcf066e..c7f576290f 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -37,6 +37,11 @@
>  
>  #define SOCKET_MAX_FDS 16
>  
> +#ifdef QEMU_MSG_ZEROCOPY
> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> +                                             Error **errp);
> +#endif
> +
>  SocketAddress *
>  qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>                                       Error **errp)
> @@ -65,6 +70,7 @@ qio_channel_socket_new(void)
>      sioc->fd = -1;
>      sioc->zero_copy_queued = 0;
>      sioc->zero_copy_sent = 0;
> +    sioc->new_zero_copy_sent_success = FALSE;
>  
>      ioc = QIO_CHANNEL(sioc);
>      qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> @@ -566,6 +572,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>      size_t fdsize = sizeof(int) * nfds;
>      struct cmsghdr *cmsg;
>      int sflags = 0;
> +    bool zero_copy_flush_pending = TRUE;

It'll be nice to add some comment above this variable explaining the issue.

>  
>      memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>  
> @@ -612,9 +619,21 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>              goto retry;
>          case ENOBUFS:
>              if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
> -                error_setg_errno(errp, errno,
> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
> -                return -1;
> +                if (zero_copy_flush_pending) {
> +                    ret = qio_channel_socket_flush_internal(ioc, errp);

Calling a socket specific helper in generic qiochannel path may not be a
good idea.

Maybe we could still stick with qio_channel_flush(), but insteadx add a new
parameter to qio_channel_flush(..., bool *succeeded), only pass in
"succeeded == NULL" here, not collect the cached result. Then the other
multifd use case it can pass in a valid "succeeded" pointer.

> +                    if (ret < 0) {
> +                        error_setg_errno(errp, errno,
> +                                         "Zerocopy flush failed");
> +                        return -1;
> +                    }
> +                    zero_copy_flush_pending = FALSE;
> +                    goto retry;
> +                } else {
> +                    error_setg_errno(errp, errno,
> +                                     "Process can't lock enough memory for "
> +                                     "using MSG_ZEROCOPY");
> +                    return -1;
> +                }
>              }
>              break;
>          }
> @@ -725,8 +744,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>  
>  
>  #ifdef QEMU_MSG_ZEROCOPY
> -static int qio_channel_socket_flush(QIOChannel *ioc,
> -                                    Error **errp)
> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> +                                             Error **errp)
>  {
>      QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>      struct msghdr msg = {};
> @@ -791,15 +810,34 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>          /* No errors, count successfully finished sendmsg()*/
>          sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
>  
> -        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
> +        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
>          if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> -            ret = 0;

After this change, IIUC this function will return either -1 or 1, never 0.
Not sure whether it's intended.  May worth add a comment above the function.

> +            sioc->new_zero_copy_sent_success = TRUE;
>          }
>      }
>  
>      return ret;
>  }
>  
> +static int qio_channel_socket_flush(QIOChannel *ioc,
> +                                    Error **errp)
> +{
> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> +    int ret;
> +
> +    ret = qio_channel_socket_flush_internal(ioc, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (sioc->new_zero_copy_sent_success) {
> +        sioc->new_zero_copy_sent_success = FALSE;
> +        ret = 0;
> +    }
> +
> +    return ret;
> +}
> +
>  #endif /* QEMU_MSG_ZEROCOPY */
>  
>  static int
> -- 
> 2.43.0
> 

-- 
Peter Xu


