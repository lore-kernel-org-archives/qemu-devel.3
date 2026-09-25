Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEBAC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAD2u-0001JD-Fs; Fri, 25 Sep 2026 17:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xAD2r-0001J1-GK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xAD2p-0003Mx-3U
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790370081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KNKvk9neUFUjldqAP4KN3NwRY7XmTXLkqg8BuEaVLpA=;
 b=ePQ7h/oeDpaudvMmX1wTI3EOqpQMziOvFNDZLFmIqlSOiQ5q2j1eS9zcQQEbJw2IYeJ9qF
 CF9SNQUnrzTYcPHuho3FX+j+98BgGj30dJUVQuM2oH3Wb0uNC2fUU8P9dy6psGzTHcfZ3A
 D5WRLrMReJ3YT51ZO/WskN2d7Ia6Psc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-xBHG9eNyNROjoZ31oQ7LMw-1; Fri,
 25 Sep 2026 17:00:14 -0400
X-MC-Unique: xBHG9eNyNROjoZ31oQ7LMw-1
X-Mimecast-MFC-AGG-ID: xBHG9eNyNROjoZ31oQ7LMw_1790370013
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C35918BA35A; Fri, 25 Sep 2026 21:00:12 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E3E2195604D; Fri, 25 Sep 2026 21:00:09 +0000 (UTC)
Date: Fri, 25 Sep 2026 16:00:06 -0500
From: Eric Blake <eblake@redhat.com>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/2] nbd/client-connection: Fix client returning a closed
 channel
Message-ID: <arbf-WK4eJCeNX35@redhat.com>
References: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
 <20260925155346.357703-2-guillaume.vincke@ovhcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925155346.357703-2-guillaume.vincke@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 25, 2026 at 05:53:45PM +0200, Guillaume Vincke wrote:
> When a server closes the connection after a successful handshake but
> before running any operations, the channel returned by
> nbd_co_establish_connection() is the closed one and the connect thread
> is not started.
> 
> When configured with reconnect-delay=0 (the default), this situation
> generates at least two IO errors. The first one happens when trying to
> issue an operation to the closed socket. The connect thread will be
> started on the next request, which may happen long after, and will
> create the second error as nbd_co_establish_connection() returns a NULL
> channel.
> 
> Peeking the channel to detect FIN or RST avoids the first IO error and
> does not delay the starting of the connect thread.
> 
> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
> ---
>  nbd/client-connection.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/nbd/client-connection.c b/nbd/client-connection.c
> index 6a4f080717..878219fede 100644
> --- a/nbd/client-connection.c
> +++ b/nbd/client-connection.c
> @@ -274,6 +274,26 @@ void nbd_client_connection_release(NBDClientConnection *conn)
>      }
>  }
>  
> +/* only true when the peer closed the channel. Does not detect if dead */

For consistent style, I would use

/* Only true when the peer closed the channel. Does not detect if dead. */

> +static bool nbd_channel_is_closed(QIOChannel *ioc)
> +{
> +    char data;
> +    struct iovec iov = { .iov_base = &data, .iov_len = 1 };
> +    ssize_t len = -1;
> +
> +    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> +        return false;
> +    }
> +
> +    len = qio_channel_readv_full(
> +        ioc, &iov, 1, NULL, NULL, QIO_CHANNEL_READ_FLAG_MSG_PEEK, NULL);
> +
> +    if (len == 0 || (len < 0 && len != QIO_CHANNEL_ERR_BLOCK)) {
> +        return true;
> +    }
> +    return false;

The last group could be shortened to:

   return len == 0 || (len < 0 && len != QIO_CHANNEL_ERR_BLOCK);

but that is not mandatory.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


