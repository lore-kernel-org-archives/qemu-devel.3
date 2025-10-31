Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A729CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 14:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEpfa-0000Va-ON; Fri, 31 Oct 2025 09:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEpfY-0000VN-RM
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEpfQ-0003Hy-IB
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761919185;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=stuMcp2HDAWTrsB12IWigVUpixcN3VROJ5irrSVVg4I=;
 b=RbP7f1654jE7oLGlUXW25wppE5la0mouWK3UsjeeiQmYK02Q+wNTdXTm1KfSbKJK8Wx9xi
 kS9TaujcqSn8wpSF80ad8d85CJvLEI2mP/Pe/uGm/Hq3Ua7ka41kJTKBfO+noj04uwAS7I
 fYtf7FkvbxomlFgr7Y9vGjCYIriBJHY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-SVbJLH4wMembZenRPNAtJA-1; Fri,
 31 Oct 2025 09:59:40 -0400
X-MC-Unique: SVbJLH4wMembZenRPNAtJA-1
X-Mimecast-MFC-AGG-ID: SVbJLH4wMembZenRPNAtJA_1761919179
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 458231955DA6; Fri, 31 Oct 2025 13:59:37 +0000 (UTC)
Received: from redhat.com (dhcp-17-192.lcy.redhat.com [10.42.17.192])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F52419540DA; Fri, 31 Oct 2025 13:59:35 +0000 (UTC)
Date: Fri, 31 Oct 2025 13:59:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org, Manish Mishra <manish.mishra@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v7 2/2] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Message-ID: <aQTAxDBWPxcrj82g@redhat.com>
References: <20251024131546.929499-1-tejus.gk@nutanix.com>
 <20251024131546.929499-3-tejus.gk@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024131546.929499-3-tejus.gk@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 24, 2025 at 01:15:43PM +0000, Tejus GK wrote:
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
>  io/channel-socket.c         | 80 ++++++++++++++++++++++++++++++-------
>  2 files changed, 71 insertions(+), 14 deletions(-)

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>


>  SocketAddress *
>  qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>                                       Error **errp)
> @@ -66,6 +72,7 @@ qio_channel_socket_new(void)
>      sioc->zero_copy_queued = 0;
>      sioc->zero_copy_sent = 0;
>      sioc->blocking = false;
> +    sioc->new_zero_copy_sent_success = FALSE;

Needs to be 'false'

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
> @@ -664,9 +673,24 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
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
> +                    ret = qio_channel_socket_flush_internal(ioc, blocking,
> +                                                            errp);
> +                    if (ret < 0) {
> +                        return -1;
> +                    }
> +                    zerocopy_flushed_once = TRUE;

... 'true'..


> @@ -843,13 +876,32 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>          /* No errors, count successfully finished sendmsg()*/
>          sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
>  
> -        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
> +        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
>          if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> -            ret = 0;
> +            sioc->new_zero_copy_sent_success = TRUE;

...true...

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

...false....

Since these are trivial changes, i'll make them when applying this
patch, so no need to re-send.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


