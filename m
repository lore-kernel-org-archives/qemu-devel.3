Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984D9C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4cZF-00019J-R8; Tue, 15 Apr 2025 05:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4cZD-00017O-FE
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4cZB-0002S9-7W
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744709211;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8/W0NGjVftI0IqDImAV4o9XXQkf+j2n4BSMfZG0wJm8=;
 b=UOzHKUxjk7b/HJRnp53Htr1po/EwqfcifiKbaMdhqsdbrYEpFp8atmauN6ScQ+XFV/fgrf
 qEvXKk3wNY71vsDAwrdyJIrpUzwzOWEH5xhUx3CkbWj+w0YTVyMpKF5KTe4cPQlVTYrzfa
 PEYxqQ491aI20TYIv+6vF9J2xatOm98=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-5O2qJIPsPF6lU4MPfaHEPQ-1; Tue,
 15 Apr 2025 05:26:50 -0400
X-MC-Unique: 5O2qJIPsPF6lU4MPfaHEPQ-1
X-Mimecast-MFC-AGG-ID: 5O2qJIPsPF6lU4MPfaHEPQ_1744709209
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C277195608A; Tue, 15 Apr 2025 09:26:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FF4D1955BC4; Tue, 15 Apr 2025 09:26:45 +0000 (UTC)
Date: Tue, 15 Apr 2025 10:26:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manish <manish.mishra@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 peterx@redhat.com, leobras@redhat.com
Subject: Re: [PATCH v4] QIOChannelSocket: Flush zerocopy socket error queue
 on sendmsg failure due to ENOBUF
Message-ID: <Z_4mUkuAXcTXyx5B@redhat.com>
References: <20250403082121.366851-1-manish.mishra@nutanix.com>
 <871ptuhla6.fsf@suse.de>
 <14f644e9-aa8a-45b0-9d0a-972d72345409@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14f644e9-aa8a-45b0-9d0a-972d72345409@nutanix.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 15, 2025 at 02:50:39PM +0530, Manish wrote:
> 
> On 14/04/25 7:56 pm, Fabiano Rosas wrote:
> > !-------------------------------------------------------------------|
> >    CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > Manish Mishra <manish.mishra@nutanix.com> writes:
> > 
> > > We allocate extra metadata SKBs in case of a zerocopy send. This metadata
> > > memory is accounted for in the OPTMEM limit. If there is any error while
> > > sending zerocopy packets or if zerocopy is skipped, these metadata SKBs are
> > > queued in the socket error queue. This error queue is freed when userspace
> > > reads it.
> > > 
> > > Usually, if there are continuous failures, we merge the metadata into a single
> > > SKB and free another one. As a result, it never exceeds the OPTMEM limit.
> > > However, if there is any out-of-order processing or intermittent zerocopy
> > > failures, this error chain can grow significantly, exhausting the OPTMEM limit.
> > > As a result, all new sendmsg requests fail to allocate any new SKB, leading to
> > > an ENOBUF error. Depending on the amount of data queued before the flush
> > > (i.e., large live migration iterations), even large OPTMEM limits are prone to
> > > failure.
> > > 
> > > To work around this, if we encounter an ENOBUF error with a zerocopy sendmsg,
> > > we flush the error queue and retry once more.
> > > 
> > > Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
> > > ---
> > >   include/io/channel-socket.h |  5 +++
> > >   io/channel-socket.c         | 74 ++++++++++++++++++++++++++++++-------
> > >   2 files changed, 65 insertions(+), 14 deletions(-)
> > > 
> > > V2:
> > >    1. Removed the dirty_sync_missed_zero_copy migration stat.
> > >    2. Made the call to qio_channel_socket_flush_internal() from
> > >       qio_channel_socket_writev() non-blocking.
> > > 
> > > V3:
> > >    1. Add the dirty_sync_missed_zero_copy migration stat again.
> > > 
> > > V4:
> > >    1. Minor nit to rename s/zero_copy_flush_pending/zerocopy_flushed_once.
> > > 
> > > diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> > > index ab15577d38..2c48b972e8 100644
> > > --- a/include/io/channel-socket.h
> > > +++ b/include/io/channel-socket.h
> > > @@ -49,6 +49,11 @@ struct QIOChannelSocket {
> > >       socklen_t remoteAddrLen;
> > >       ssize_t zero_copy_queued;
> > >       ssize_t zero_copy_sent;
> > > +    /**
> > > +     * This flag indicates whether any new data was successfully sent with
> > > +     * zerocopy since the last qio_channel_socket_flush() call.
> > > +     */
> > > +    bool new_zero_copy_sent_success;
> > >   };
> > > diff --git a/io/channel-socket.c b/io/channel-socket.c
> > > index 608bcf066e..d5882c16fe 100644
> > > --- a/io/channel-socket.c
> > > +++ b/io/channel-socket.c
> > > @@ -37,6 +37,12 @@
> > >   #define SOCKET_MAX_FDS 16
> > > +#ifdef QEMU_MSG_ZEROCOPY
> > > +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> > > +                                             bool block,
> > > +                                             Error **errp);
> > > +#endif
> > > +
> > >   SocketAddress *
> > >   qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
> > >                                        Error **errp)
> > > @@ -65,6 +71,7 @@ qio_channel_socket_new(void)
> > >       sioc->fd = -1;
> > >       sioc->zero_copy_queued = 0;
> > >       sioc->zero_copy_sent = 0;
> > > +    sioc->new_zero_copy_sent_success = FALSE;
> > >       ioc = QIO_CHANNEL(sioc);
> > >       qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> > > @@ -566,6 +573,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
> > >       size_t fdsize = sizeof(int) * nfds;
> > >       struct cmsghdr *cmsg;
> > >       int sflags = 0;
> > > +    bool zerocopy_flushed_once = FALSE;
> > >       memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
> > > @@ -612,9 +620,25 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
> > >               goto retry;
> > >           case ENOBUFS:
> > >               if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
> > > -                error_setg_errno(errp, errno,
> > > -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
> > > -                return -1;
> > > +                /**
> > > +                 * Socket error queueing may exhaust the OPTMEM limit. Try
> > > +                 * flushing the error queue once.
> > > +                 */
> > > +                if (!zerocopy_flushed_once) {
> > > +                    ret = qio_channel_socket_flush_internal(ioc, false, errp);
> > I'm not following this closely so I might have missed some disussion,
> > but let me point out that the previous version had a comment regarding
> > hardcoding 'false' here that I don't see addressed nor any comments
> > explaining why it wasn't addressed.
> 
> Hi Fabiano, I did reply to that in last comment for v3. Please let me know
> if that does not make sense. https://lore.kernel.org/all/c7a86623-db04-459f-afd5-6a318475bb92@nutanix.com/T/

That comment doesn't really address the problem.

If the socket is in blocking mode, we *MUST* block to send
all data. Returning early with a partial send when zerocopy
buffers are full isn't matching the requested semantics
for blocking mode.

> 
> 
> > 
> > > +                    if (ret < 0) {
> > > +                        error_setg_errno(errp, errno,
> > > +                                         "Zerocopy flush failed");
> > > +                        return -1;
> > > +                    }
> > > +                    zerocopy_flushed_once = TRUE;
> > > +                    goto retry;
> > > +                } else {
> > > +                    error_setg_errno(errp, errno,
> > > +                                     "Process can't lock enough memory for "
> > > +                                     "using MSG_ZEROCOPY");
> > > +                    return -1;
> > > +                }
> > >               }
> > >               break;

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


