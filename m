Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DDCC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KlR-0001JH-EN; Mon, 14 Apr 2025 10:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4KlP-0001Ip-JB
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:26:19 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4KlN-0005fr-L9
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:26:19 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 292941F7BA;
 Mon, 14 Apr 2025 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744640773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4n6TExYb6nr1oIQh1rjmXfz6rcu8QDUd2lwE+0ubK0=;
 b=Oq9QXuGTxX8V7oa5ky6ue5898Gk0LRUuISZbartV26dK/F0S0MRkawmhk8wH9WCXPgqb/I
 NW5xKTqmw7RzXMXVKwkduyLpqRugRWI577C81jKr1WJlaYz2glDYI7SEO1EsVSTfrdLYLW
 hDdetPH59zTA2Wr3d5tIUPzVGycJil0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744640773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4n6TExYb6nr1oIQh1rjmXfz6rcu8QDUd2lwE+0ubK0=;
 b=cbo3qbClpTe/3Iqyrs207phkCCM7IZ65uBAex6kgVwoXREcSjNXecljuIcgYtkws0w8dfR
 gQY3bA0a956HyeAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744640773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4n6TExYb6nr1oIQh1rjmXfz6rcu8QDUd2lwE+0ubK0=;
 b=Oq9QXuGTxX8V7oa5ky6ue5898Gk0LRUuISZbartV26dK/F0S0MRkawmhk8wH9WCXPgqb/I
 NW5xKTqmw7RzXMXVKwkduyLpqRugRWI577C81jKr1WJlaYz2glDYI7SEO1EsVSTfrdLYLW
 hDdetPH59zTA2Wr3d5tIUPzVGycJil0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744640773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4n6TExYb6nr1oIQh1rjmXfz6rcu8QDUd2lwE+0ubK0=;
 b=cbo3qbClpTe/3Iqyrs207phkCCM7IZ65uBAex6kgVwoXREcSjNXecljuIcgYtkws0w8dfR
 gQY3bA0a956HyeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99FD41336F;
 Mon, 14 Apr 2025 14:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pVasFgQb/WfhEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 14 Apr 2025 14:26:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Manish Mishra <manish.mishra@nutanix.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, leobras@redhat.com, Manish
 Mishra <manish.mishra@nutanix.com>
Subject: Re: [PATCH v4] QIOChannelSocket: Flush zerocopy socket error queue
 on sendmsg failure due to ENOBUF
In-Reply-To: <20250403082121.366851-1-manish.mishra@nutanix.com>
References: <20250403082121.366851-1-manish.mishra@nutanix.com>
Date: Mon, 14 Apr 2025 11:26:09 -0300
Message-ID: <871ptuhla6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Manish Mishra <manish.mishra@nutanix.com> writes:

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
> Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
> ---
>  include/io/channel-socket.h |  5 +++
>  io/channel-socket.c         | 74 ++++++++++++++++++++++++++++++-------
>  2 files changed, 65 insertions(+), 14 deletions(-)
>
> V2:
>   1. Removed the dirty_sync_missed_zero_copy migration stat.
>   2. Made the call to qio_channel_socket_flush_internal() from
>      qio_channel_socket_writev() non-blocking.
>
> V3:
>   1. Add the dirty_sync_missed_zero_copy migration stat again.
>
> V4:
>   1. Minor nit to rename s/zero_copy_flush_pending/zerocopy_flushed_once.
>
> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index ab15577d38..2c48b972e8 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -49,6 +49,11 @@ struct QIOChannelSocket {
>      socklen_t remoteAddrLen;
>      ssize_t zero_copy_queued;
>      ssize_t zero_copy_sent;
> +    /**
> +     * This flag indicates whether any new data was successfully sent with
> +     * zerocopy since the last qio_channel_socket_flush() call.
> +     */
> +    bool new_zero_copy_sent_success;
>  };
>  
>  
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 608bcf066e..d5882c16fe 100644
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
> +    bool zerocopy_flushed_once = FALSE;
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
> +                if (!zerocopy_flushed_once) {
> +                    ret = qio_channel_socket_flush_internal(ioc, false, errp);

I'm not following this closely so I might have missed some disussion,
but let me point out that the previous version had a comment regarding
hardcoding 'false' here that I don't see addressed nor any comments
explaining why it wasn't addressed.

> +                    if (ret < 0) {
> +                        error_setg_errno(errp, errno,
> +                                         "Zerocopy flush failed");
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

