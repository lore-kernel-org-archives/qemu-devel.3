Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36883C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 15:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tveZt-0005Vq-BG; Fri, 21 Mar 2025 11:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tveZR-0005St-Uw
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tveZM-0008M1-RM
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742571959;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=923fBdFpF7srfDlQezpPiv/YV/Ew1UvKsMi6Eia5/Ig=;
 b=E7SVklV5T7CZ/tFxa4fV6Bxwk3IPi6ZESJENirfHOvLMbPsH/j/faLdX6CQI7+CxuZHmwB
 DasInH6wh5Wv0BlSKdQwpewrwOWUthEdKsMrb5llevGFB6JqMtxNPOsCqZZVhUpYfJxxOU
 z4FsCO+VX45XKsbh4QboVjaXl0+OX3s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-hxwevHI8PQWfWnThkMgiKg-1; Fri,
 21 Mar 2025 11:45:55 -0400
X-MC-Unique: hxwevHI8PQWfWnThkMgiKg-1
X-Mimecast-MFC-AGG-ID: hxwevHI8PQWfWnThkMgiKg_1742571954
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3C5A1933B41; Fri, 21 Mar 2025 15:45:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8016C19373C4; Fri, 21 Mar 2025 15:45:51 +0000 (UTC)
Date: Fri, 21 Mar 2025 15:45:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manish Mishra <manish.mishra@nutanix.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de
Subject: Re: [PATCH v3] QIOChannelSocket: Flush zerocopy socket error queue
 on sendmsg failure due to ENOBUF
Message-ID: <Z92JrM6pF-dhyCGd@redhat.com>
References: <20250317015231.241141-1-manish.mishra@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317015231.241141-1-manish.mishra@nutanix.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Sun, Mar 16, 2025 at 09:52:31PM -0400, Manish Mishra wrote:
> We allocate extra metadata SKBs in case of a zerocopy send. This metadata
> memory is accounted for in the OPTMEM limit. If there is any error while
> sending zerocopy packets or if zerocopy is skipped, these metadata SKBs are
> queued in the socket error queue. This error queue is freed when userspace
> reads it.
> 
> Usually, if there are continuous failures, we merge the metadata into a single
> SKB and free another one. As a result, it never exceeds the OPTMEM limit.
> However, if there is any out-of-order processing or intermittent zerocopy
> failures, this error chain can grow significantly, exhausting the OPTMEM limit.
> As a result, all new sendmsg requests fail to allocate any new SKB, leading to
> an ENOBUF error. Depending on the amount of data queued before the flush
> (i.e., large live migration iterations), even large OPTMEM limits are prone to
> failure.
> 
> To work around this, if we encounter an ENOBUF error with a zerocopy sendmsg,
> we flush the error queue and retry once more.
> 
> V2:
>   1. Removed the dirty_sync_missed_zero_copy migration stat.
>   2. Made the call to qio_channel_socket_flush_internal() from
>      qio_channel_socket_writev() non-blocking.
> 
> V3:
>   1. Add the dirty_sync_missed_zero_copy migration stat again.

These notes about changes each version should always be below
the '---' line, because they shouldn't remain in the commit message
when merged.

> 
> Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
> ---
>  include/io/channel-socket.h |  5 +++
>  io/channel-socket.c         | 74 ++++++++++++++++++++++++++++++-------
>  2 files changed, 65 insertions(+), 14 deletions(-)
> 

> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 608bcf066e..604ca9890d 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -37,6 +37,12 @@
>  
>  #define SOCKET_MAX_FDS 16
>  
> +#ifdef QEMU_MSG_ZEROCOPY
> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> +                                             bool block,
> +                                             Error **errp);
> +#endif
> +
>  SocketAddress *
>  qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>                                       Error **errp)
> @@ -65,6 +71,7 @@ qio_channel_socket_new(void)
>      sioc->fd = -1;
>      sioc->zero_copy_queued = 0;
>      sioc->zero_copy_sent = 0;
> +    sioc->new_zero_copy_sent_success = FALSE;
>  
>      ioc = QIO_CHANNEL(sioc);
>      qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> @@ -566,6 +573,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>      size_t fdsize = sizeof(int) * nfds;
>      struct cmsghdr *cmsg;
>      int sflags = 0;
> +    bool zero_copy_flush_pending = TRUE;
>  
>      memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>  
> @@ -612,9 +620,25 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>              goto retry;
>          case ENOBUFS:
>              if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
> -                error_setg_errno(errp, errno,
> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
> -                return -1;
> +                /**
> +                 * Socket error queueing may exhaust the OPTMEM limit. Try
> +                 * flushing the error queue once.
> +                 */
> +                if (zero_copy_flush_pending) {
> +                    ret = qio_channel_socket_flush_internal(ioc, false, errp);

Hardcoding block==false isn't right.  The socket may be in either
blocking or non-blocking mode, and that needs to be taken into
account, otherwise we'll get spurious failures in blocking mode
if "flush" would otherwise want to block.

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
> @@ -725,8 +749,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>  
>  
>  #ifdef QEMU_MSG_ZEROCOPY
> -static int qio_channel_socket_flush(QIOChannel *ioc,
> -                                    Error **errp)
> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> +                                             bool block,
> +                                             Error **errp)
>  {
>      QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>      struct msghdr msg = {};
> @@ -734,7 +759,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>      struct cmsghdr *cm;
>      char control[CMSG_SPACE(sizeof(*serr))];
>      int received;
> -    int ret;
>  
>      if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
>          return 0;
> @@ -744,16 +768,19 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>      msg.msg_controllen = sizeof(control);
>      memset(control, 0, sizeof(control));
>  
> -    ret = 1;
> -
>      while (sioc->zero_copy_sent < sioc->zero_copy_queued) {
>          received = recvmsg(sioc->fd, &msg, MSG_ERRQUEUE);
>          if (received < 0) {
>              switch (errno) {
>              case EAGAIN:
> -                /* Nothing on errqueue, wait until something is available */
> -                qio_channel_wait(ioc, G_IO_ERR);
> -                continue;
> +                if (block) {
> +                    /* Nothing on errqueue, wait until something is
> +                     * available.
> +                     */
> +                    qio_channel_wait(ioc, G_IO_ERR);
> +                    continue;
> +                }
> +                return 0;
>              case EINTR:
>                  continue;
>              default:
> @@ -791,13 +818,32 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
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
> -    return ret;
> +    return 0;
> +}



> +
> +static int qio_channel_socket_flush(QIOChannel *ioc,
> +                                    Error **errp)
> +{
> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> +    int ret;
> +
> +    ret = qio_channel_socket_flush_internal(ioc, true, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (sioc->new_zero_copy_sent_success) {
> +        sioc->new_zero_copy_sent_success = FALSE;
> +        return 0;
> +    }
> +
> +    return 1;
>  }
>  
>  #endif /* QEMU_MSG_ZEROCOPY */
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


