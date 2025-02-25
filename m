Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F45C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 09:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmquj-0004cF-9o; Tue, 25 Feb 2025 04:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmquh-0004bd-Gw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:07:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmquf-0001jA-E4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740474455;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=I4FfhDXpMl0MdeuIKxaa92vCGojrGku0nUmG+DK9EpU=;
 b=XXYWZI9N9QU8qdNkYN3WtiLJSskGghljVXGi3jLRGCJ75wiuBy0Q7BzZkq5o4wlgea1MUn
 Wl8AowHiexfuBr+U6iQ+GxPnOH1ot/ww1btMdp40PcyPLgB4Q16G6hBIDvur88q3uTZYR7
 ILpQHi6nQW32AwNvP4sGcBXZQ3q84LM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226--KS1Sq9SNYWe1OVKqrFujA-1; Tue,
 25 Feb 2025 04:07:31 -0500
X-MC-Unique: -KS1Sq9SNYWe1OVKqrFujA-1
X-Mimecast-MFC-AGG-ID: -KS1Sq9SNYWe1OVKqrFujA_1740474450
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 937B71801A10; Tue, 25 Feb 2025 09:07:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC65E1955BD4; Tue, 25 Feb 2025 09:07:27 +0000 (UTC)
Date: Tue, 25 Feb 2025 09:07:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manish Mishra <manish.mishra@nutanix.com>
Cc: qemu-devel@nongnu.org, leobras@redhat.com, peterx@redhat.com
Subject: Re: [PATCH] QIOChannelSocket: Flush zerocopy socket error queue on
 ENOBUF failure for sendmsg
Message-ID: <Z72ITCJlkz9711bU@redhat.com>
References: <20250221094448.206845-1-manish.mishra@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221094448.206845-1-manish.mishra@nutanix.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
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

IIUC, you are effectively saying that the migration code is calling
qio_channel_write() too many times, before it calls qio_channel_flush(.)

Can you clarify what yu mean by the "OPTMEM limit" here ? I'm wondering
if this is potentially triggered by suboptimal tuning of the deployment
environment or we need to document tuning better. 

> To workaround this, if we encounter an ENOBUF error with a zerocopy sendmsg,
> we flush the error queue and retry once more.
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

Calling this is problematic, because qio_channel_socket_flush is
designed to block execution until all buffers are flushed. When
ioc is in non-blocking mode, this breaks the required semantics
of qio_channel_socket_writev which must return EAGAIN and not
block.

IOW, if we need to be able to flush at this point, we must be
able to do a partial flush, rather than blocking on a full
flush

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

I don't see the point in these changes adding new_zero_copy_sent_success.

IIUC, you seem to be trying to make it so that qio_channel_socket_flush
will return 0, if  qio_channel_socket_writev had called
qio_channel_socket_flush_internal behind the scenes.
That should already be working though, as the first thing we do in flush
is to check if anything was pending and, if not, then return zero:

    if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
        return 0;
    }
    ....do the real flush logic....


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


