Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35476606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X8P9qlqg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU4xA-0002iH-VQ; Thu, 19 Nov 2026 11:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU4x8-0002hO-Ct
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:25:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU4x6-0004Fl-T1
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795105536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mR0PlA0DElFWveso4Odvmjd4yeNKrUqVnnfcpBXrxs4=;
 b=X8P9qlqgQ6OO2Zr3DyJ4+qQIiL8gq0D45fyB7yQUwxeTxD4MsLvc7Y9urVdQJS0337jkeF
 l0F3FYYeFnZX4x3PE0ZO1hOZJfzwI9sSvEg0lJbb6XJcG3UYCtg/JqbB0EpsGPaDjiA74Q
 4JtSGnqe+jsnHO9K7lIxvWod5pC4Tk4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-0zNjpFLcMH6_k7fw4jFeyw-1; Thu,
 19 Nov 2026 11:25:31 -0500
X-MC-Unique: 0zNjpFLcMH6_k7fw4jFeyw-1
X-Mimecast-MFC-AGG-ID: 0zNjpFLcMH6_k7fw4jFeyw_1795105530
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6FE31956060; Thu, 19 Nov 2026 16:25:29 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 122771801971; Thu, 19 Nov 2026 16:25:26 +0000 (UTC)
Date: Thu, 19 Nov 2026 10:25:24 -0600
From: Eric Blake <eblake@redhat.com>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net
Subject: Re: [PATCH 3/5] block/nbd: Refresh the connection on block_resize
Message-ID: <av8ia-EWRqZXchhR@redhat.com>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
 <20261119144632.232457-4-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119144632.232457-4-guillaume.vincke@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 03:46:30PM +0100, Guillaume Vincke wrote:
> When an NBD device is resized, two steps are needed to propagate the
> information. First, as the size is only exchanged at handshake, the
> connection needs to be reset. Then, the new size needs to be updated by
> calling bdrv_co_refresh_total_sectors().
> The QMP block_resize method, by calling bdrv_co_truncate(), takes care
> of the second step but, considering the NBD connection is lazy, nothing
> deals with reconnection when the device is idle.
> 
> This patch uses the new bdrv_co_refresh_connection() to force the
> handshake by manually starting the reconnection routine.
> It creates a clean flow to resize an NBD-backed block device on the
> server side by closing the connection and calling block_resize.
> When the node is configured with reconnect-delay=0, refreshing starts
> the reconnection but returns immediately with -EIO. The management
> application can handle this case by waiting for the connection to be
> established and re-running block_resize.
> 
> To detect disconnection, we peek the channel. This does not detect dead
> peers or disconnected TLS-secured connections. Therefore, this flow
> will not work if the server does not disconnect cleanly or if the
> communication is encrypted.

This is problematic, since unencrypted traffic is more likely to trip
over denial of service CVE attacks; is there any way we can make
client disconnect easier to detect even for TLS clients?

> 
> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
> ---

> +++ b/nbd/client-connection.c
> @@ -296,8 +296,11 @@ void nbd_client_connection_release(NBDClientConnection *conn)
>      }
>  }
>  
> -/* Only true when the peer closed the channel. Does not detect if dead. */
> -static bool nbd_channel_is_closed(QIOChannel *ioc)
> +/*
> + * Only true when the peer closed the channel. Always returns false for TLS
> + * channels. Does not detect if dead.
> + */
> +bool nbd_channel_is_closed(QIOChannel *ioc)
>  {
>      char data;
>      struct iovec iov = { .iov_base = &data, .iov_len = 1 };
> -- 
> 2.43.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


