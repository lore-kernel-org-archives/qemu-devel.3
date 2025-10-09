Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD78CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nxK-00084j-1d; Thu, 09 Oct 2025 06:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6nxG-00082b-C9
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6nxA-0001i3-N3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760005971;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=x7hVhywp3p7uy9l6sveQLxhYLzKMH74UuOwuuh4Y26k=;
 b=Fhx3ZyCD1yK2O4Bu2w2zLEhL3WIDFnNZTEY+C+1g9v382Df7EOQD3MKHUOe34xnB4X/hxA
 hRzjszmXOuqTYbWW0OnnihWEUoeUHf6zP9qF8ACVHi+NP1Wx31cZG6f+4NocR4m6qON6De
 PHuSL68R9jtV6VJiKW9QtLNaBaxgsPk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-XsqufI_bO_q71W-xXWe8xg-1; Thu,
 09 Oct 2025 06:32:48 -0400
X-MC-Unique: XsqufI_bO_q71W-xXWe8xg-1
X-Mimecast-MFC-AGG-ID: XsqufI_bO_q71W-xXWe8xg_1760005967
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58D191800366; Thu,  9 Oct 2025 10:32:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.196])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE9F818001C6; Thu,  9 Oct 2025 10:32:43 +0000 (UTC)
Date: Thu, 9 Oct 2025 11:32:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Manish Mishra <manish.mishra@nutanix.com>
Subject: Re: [PATCH v5 3/3] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Message-ID: <aOePR-Jd5UX5DXAA@redhat.com>
References: <20251009101420.3048487-1-tejus.gk@nutanix.com>
 <20251009101420.3048487-4-tejus.gk@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251009101420.3048487-4-tejus.gk@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 09, 2025 at 10:14:18AM +0000, Tejus GK wrote:
> From: Manish Mishra <manish.mishra@nutanix.com>
> 
> The kernel allocates extra metadata SKBs in case of a zerocopy send,
> eventually used for zerocopy's notification mechanism. This metadata
> memory is accounted for in the OPTMEM limit. The kernel queues
> completion notifications on the socket error queue and this error queue
> is freed when userspace reads it.
> 
> Usually, in the case of in-order processing, the kernel will batch the
> notifications and merge the metadata into a single SKB and free the
> rest. As a result, it never exceeds the OPTMEM limit. However, if there
> is any out-of-order processing or intermittent zerocopy failures, this
> error chain can grow significantly, exhausting the OPTMEM limit. As a
> result, all new sendmsg requests fail to allocate any new SKB, leading
> to an ENOBUF error. Depending on the amount of data queued before the
> flush (i.e., large live migration iterations), even large OPTMEM limits
> are prone to failure.
> 
> To work around this, if we encounter an ENOBUF error with a zerocopy
> sendmsg, flush the error queue and retry once more.
> 
> Co-authored-by: Manish Mishra <manish.mishra@nutanix.com>
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
> ---
>  include/io/channel-socket.h |  5 +++
>  io/channel-socket.c         | 78 ++++++++++++++++++++++++++++++-------
>  migration/multifd-nocomp.c  |  3 +-
>  migration/multifd.c         |  3 +-
>  4 files changed, 72 insertions(+), 17 deletions(-)
> 
> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index 26319fa98b..fcfd489c6c 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -50,6 +50,11 @@ struct QIOChannelSocket {
>      ssize_t zero_copy_queued;
>      ssize_t zero_copy_sent;
>      bool blocking;
> +    /**
> +     * This flag indicates whether any new data was successfully sent with
> +     * zerocopy since the last qio_channel_socket_flush() call.
> +     */
> +    bool new_zero_copy_sent_success;
>  };
>  
>  
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 8b30d5b7f7..22d59cd3cf 100644
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
> @@ -66,6 +72,7 @@ qio_channel_socket_new(void)
>      sioc->zero_copy_queued = 0;
>      sioc->zero_copy_sent = 0;
>      sioc->blocking = false;
> +    sioc->new_zero_copy_sent_success = FALSE;
>  
>      ioc = QIO_CHANNEL(sioc);
>      qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> @@ -618,6 +625,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>      size_t fdsize = sizeof(int) * nfds;
>      struct cmsghdr *cmsg;
>      int sflags = 0;
> +    bool blocking = sioc->blocking;
> +    bool zerocopy_flushed_once = false;
>  
>      memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>  
> @@ -663,10 +672,26 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>          case EINTR:
>              goto retry;
>          case ENOBUFS:
> -            if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
> -                error_setg_errno(errp, errno,
> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
> -                return -1;
> +            if (flags & (QIO_CHANNEL_WRITE_FLAG_ZERO_COPY |
> +                QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE)) {


There are only two callers where this patch has added use of
QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE.

Both of them already sett QIO_CHANNEL_WRITE_FLAG_ZERO_COPY, so
this code branch was already being taken

IOW, this new QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE looks
pointless.



> +                /**
> +                 * Socket error queueing may exhaust the OPTMEM limit. Try
> +                 * flushing the error queue once.
> +                 */
> +                if (!zerocopy_flushed_once) {
> +                    ret = qio_channel_socket_flush_internal(ioc, blocking,
> +                                                            errp);
> +                    if (ret < 0) {
> +                        return -1;
> +                    }
> +                    zerocopy_flushed_once = TRUE;
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
> @@ -777,8 +802,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
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
> @@ -786,7 +812,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>      struct cmsghdr *cm;
>      char control[CMSG_SPACE(sizeof(*serr))];
>      int received;
> -    int ret;
>  
>      if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
>          return 0;
> @@ -796,16 +821,20 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
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
> +                    /*
> +                     * Nothing on errqueue, wait until something is
> +                     * available.
> +                     */
> +                    qio_channel_wait(ioc, G_IO_ERR);
> +                    continue;
> +                }
> +                return 0;
>              case EINTR:
>                  continue;
>              default:
> @@ -843,13 +872,32 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
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
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index b48eae3d86..9a28ccafd6 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -66,7 +66,8 @@ static int multifd_nocomp_send_setup(MultiFDSendParams *p, Error **errp)
>      uint32_t page_count = multifd_ram_page_count();
>  
>      if (migrate_zero_copy_send()) {
> -        p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
> +        p->write_flags |= (QIO_CHANNEL_WRITE_FLAG_ZERO_COPY |
> +                           QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE);
>      }
>  
>      if (!migrate_mapped_ram()) {
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 98873cee74..ccfafa6505 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -703,7 +703,8 @@ static void *multifd_send_thread(void *opaque)
>                  multifd_device_state_send_prepare(p);
>  
>                  /* Device state packets cannot be sent via zerocopy */
> -                write_flags_masked |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
> +                write_flags_masked |= (QIO_CHANNEL_WRITE_FLAG_ZERO_COPY |
> +                    QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE);
>              } else {
>                  ret = multifd_send_state->ops->send_prepare(p, &local_err);
>                  if (ret != 0) {
> -- 
> 2.43.7
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


