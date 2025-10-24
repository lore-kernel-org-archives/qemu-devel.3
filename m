Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC3FCCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 12:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCGm4-0003Dd-GJ; Fri, 24 Oct 2025 08:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCGly-0003Ce-2x
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCGlu-0003fe-Fi
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761308390;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTuZ0vKm1xG1elF4eEhqNtJXw82tFrGGMRsiKTalJPw=;
 b=MBWp14iFQZDiN5gpnXTigVcrwfPe7LKjSMtYUCOUJ5QrSSNu//Ear0SNuTVMCfvuhZV7Fb
 VIWfYZUxkctZmCO/5oldqA33flsmqavK6ZBFXejaITGy8LEUIqSbHlAmgUm9h9yMbgkCQd
 GlGQoUvRM0BaBSapZpYd8TYQjfQuo+A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-nsMXskm-MdKwwcBgdaqTyQ-1; Fri,
 24 Oct 2025 08:19:43 -0400
X-MC-Unique: nsMXskm-MdKwwcBgdaqTyQ-1
X-Mimecast-MFC-AGG-ID: nsMXskm-MdKwwcBgdaqTyQ_1761308381
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B1C1180035A; Fri, 24 Oct 2025 12:19:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E285D19540EB; Fri, 24 Oct 2025 12:19:38 +0000 (UTC)
Date: Fri, 24 Oct 2025 13:19:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v6 2/2] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Message-ID: <aPtu1px7aT9fk1a1@redhat.com>
References: <20251013092126.3480671-1-tejus.gk@nutanix.com>
 <20251013092126.3480671-3-tejus.gk@nutanix.com>
 <aOzIiVdUCoNKoWb5@redhat.com>
 <2183D087-3126-4928-9DBE-750E641B519B@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2183D087-3126-4928-9DBE-750E641B519B@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 21, 2025 at 04:16:48PM +0000, Tejus GK wrote:
> 
> 
> > On 13 Oct 2025, at 3:08 PM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Mon, Oct 13, 2025 at 09:21:22AM +0000, Tejus GK wrote:
> >> From: Manish Mishra <manish.mishra@nutanix.com>
> >> 
> >> The kernel allocates extra metadata SKBs in case of a zerocopy send,
> >> eventually used for zerocopy's notification mechanism. This metadata
> >> memory is accounted for in the OPTMEM limit. The kernel queues
> >> completion notifications on the socket error queue and this error queue
> >> is freed when userspace reads it.
> >> 
> >> Usually, in the case of in-order processing, the kernel will batch the
> >> notifications and merge the metadata into a single SKB and free the
> >> rest. As a result, it never exceeds the OPTMEM limit. However, if there
> >> is any out-of-order processing or intermittent zerocopy failures, this
> >> error chain can grow significantly, exhausting the OPTMEM limit. As a
> >> result, all new sendmsg requests fail to allocate any new SKB, leading
> >> to an ENOBUF error. Depending on the amount of data queued before the
> >> flush (i.e., large live migration iterations), even large OPTMEM limits
> >> are prone to failure.
> >> 
> >> To work around this, if we encounter an ENOBUF error with a zerocopy
> >> sendmsg, flush the error queue and retry once more.
> >> 
> >> Co-authored-by: Manish Mishra <manish.mishra@nutanix.com>
> >> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
> >> ---
> >> include/io/channel-socket.h |  5 +++
> >> io/channel-socket.c         | 75 ++++++++++++++++++++++++++++++-------
> >> 2 files changed, 66 insertions(+), 14 deletions(-)
> >> 
> >> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> >> index 26319fa98b..fcfd489c6c 100644
> >> --- a/include/io/channel-socket.h
> >> +++ b/include/io/channel-socket.h
> >> @@ -50,6 +50,11 @@ struct QIOChannelSocket {
> >>     ssize_t zero_copy_queued;
> >>     ssize_t zero_copy_sent;
> >>     bool blocking;
> >> +    /**
> >> +     * This flag indicates whether any new data was successfully sent with
> >> +     * zerocopy since the last qio_channel_socket_flush() call.
> >> +     */
> >> +    bool new_zero_copy_sent_success;
> >> };
> >> 
> >> 
> >> diff --git a/io/channel-socket.c b/io/channel-socket.c
> >> index 8b30d5b7f7..7cd9f3666d 100644
> >> --- a/io/channel-socket.c
> >> +++ b/io/channel-socket.c
> >> @@ -37,6 +37,12 @@
> >> 
> >> #define SOCKET_MAX_FDS 16
> >> 
> >> +#ifdef QEMU_MSG_ZEROCOPY
> >> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> >> +                                             bool block,
> >> +                                             Error **errp);
> >> +#endif
> >> +
> >> SocketAddress *
> >> qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
> >>                                      Error **errp)
> >> @@ -66,6 +72,7 @@ qio_channel_socket_new(void)
> >>     sioc->zero_copy_queued = 0;
> >>     sioc->zero_copy_sent = 0;
> >>     sioc->blocking = false;
> >> +    sioc->new_zero_copy_sent_success = FALSE;
> >> 
> >>     ioc = QIO_CHANNEL(sioc);
> >>     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> >> @@ -618,6 +625,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
> >>     size_t fdsize = sizeof(int) * nfds;
> >>     struct cmsghdr *cmsg;
> >>     int sflags = 0;
> >> +    bool blocking = sioc->blocking;
> >> +    bool zerocopy_flushed_once = false;
> >> 
> >>     memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
> >> 
> >> @@ -664,9 +673,24 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
> >>             goto retry;
> >>         case ENOBUFS:
> >>             if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
> >> -                error_setg_errno(errp, errno,
> >> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
> >> -                return -1;
> >> +                /**
> >> +                 * Socket error queueing may exhaust the OPTMEM limit. Try
> >> +                 * flushing the error queue once.
> >> +                 */
> >> +                if (!zerocopy_flushed_once) {
> >> +                    ret = qio_channel_socket_flush_internal(ioc, blocking,
> >> +                                                            errp);
> >> +                    if (ret < 0) {
> >> +                        return -1;
> >> +                    }
> >> +                    zerocopy_flushed_once = TRUE;
> >> +                    goto retry;
> >> +                } else {
> >> +                    error_setg_errno(errp, errno,
> >> +                                     "Process can't lock enough memory for "
> >> +                                     "using MSG_ZEROCOPY");
> >> +                    return -1;
> >> +                }
> >>             }
> >>             break;
> >>         }
> >> @@ -777,8 +801,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
> >> 
> >> 
> >> #ifdef QEMU_MSG_ZEROCOPY
> >> -static int qio_channel_socket_flush(QIOChannel *ioc,
> >> -                                    Error **errp)
> >> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> >> +                                             bool block,
> >> +                                             Error **errp)
> >> {
> >>     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> >>     struct msghdr msg = {};
> >> @@ -786,7 +811,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
> >>     struct cmsghdr *cm;
> >>     char control[CMSG_SPACE(sizeof(*serr))];
> >>     int received;
> >> -    int ret;
> >> 
> >>     if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
> >>         return 0;
> >> @@ -796,16 +820,20 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
> >>     msg.msg_controllen = sizeof(control);
> >>     memset(control, 0, sizeof(control));
> >> 
> >> -    ret = 1;
> >> -
> >>     while (sioc->zero_copy_sent < sioc->zero_copy_queued) {
> >>         received = recvmsg(sioc->fd, &msg, MSG_ERRQUEUE);
> >>         if (received < 0) {
> >>             switch (errno) {
> >>             case EAGAIN:
> >> -                /* Nothing on errqueue, wait until something is available */
> >> -                qio_channel_wait(ioc, G_IO_ERR);
> >> -                continue;
> >> +                if (block) {
> >> +                    /*
> >> +                     * Nothing on errqueue, wait until something is
> >> +                     * available.
> >> +                     */
> >> +                    qio_channel_wait(ioc, G_IO_ERR);
> >> +                    continue;
> > 
> > Why G_IO_ERR ?  If we're waiting for recvmsg() to become ready, then
> > it would need to be G_IO_IN we're waiting for.
> 
> Apologies for the delayed response. Please correct me if I am wrong, 
> https://docs.kernel.org/networking/msg_zerocopy.html#notification-reception
> mentions, that in order to poll for notifications on the socket error queue, one need not set any flag in the events field, and the kernel in return would set POLLERR in the output, when there’s eventually a message in the notification queue.
> From what I understand, the glib equivalent for POLLERR, is G_IO_ERR, which means we’d be waiting on the socket error queue until a notification comes up.

Ah I see. That's rather non-obvious. Can you put a comment in the code
to the effect that use of MSG_ERRQUEUE requires to you poll on G_IO_ERR
instead of the normal G_IO_IN.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


