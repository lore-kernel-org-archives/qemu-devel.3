Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2BBCCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9OlG-0001Xl-7q; Thu, 16 Oct 2025 10:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9OlE-0001Xb-4O
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9Ol7-0000wg-Vj
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760624109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCsJ7o/H8gr+Tihp2nikFFKht1lBBDM9bDcL78KhuJU=;
 b=D9CIqvhMRjEyL/94ai+kjMki/Trk1KMTJDCzdAJwLwbi7kiTnyyTyL8/fWGL3jprnny1zI
 LrguZM1pJvfaWUuODLbMHgxGFgkwePEGB19OY7uM+smvwcILmZPpa/eqNIuJSHGx+8RGl/
 W2GHyTuBP6pB67EJgfGd28qz08f5bRY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-U-pVJPeiNRiclYhgOzM9MA-1; Thu,
 16 Oct 2025 10:15:06 -0400
X-MC-Unique: U-pVJPeiNRiclYhgOzM9MA-1
X-Mimecast-MFC-AGG-ID: U-pVJPeiNRiclYhgOzM9MA_1760624105
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2650919560B2; Thu, 16 Oct 2025 14:15:05 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84D201956056; Thu, 16 Oct 2025 14:15:03 +0000 (UTC)
Date: Thu, 16 Oct 2025 09:15:00 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Grant Millar | Cylo <rid@cylo.io>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v2 2/3] io: move websock resource release to close method
Message-ID: <7ulwaczdiyrnpgqijnzuwfqz3v2qamvczmbk7gyqu7hbss677x@u5xtigb6wvrk>
References: <20251003150245.3510069-1-berrange@redhat.com>
 <20251003150245.3510069-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003150245.3510069-3-berrange@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 03, 2025 at 04:02:44PM +0100, Daniel P. Berrangé wrote:
> The QIOChannelWebsock object releases all its resources in the
> finalize callback. This is later than desired, as callers expect
> to be able to call qio_channel_close() to fully close a channel
> and release resources related to I/O.
> 
> The logic in the finalize method is at most a failsafe to handle
> cases where a consumer forgets to call qio_channel_close.
> 
> This adds equivalent logic to the close method to release the
> resources, using g_clear_handle_id/g_clear_pointer to be robust
> against repeated invokations. The finalize method is tweaked

invocations

> so that the GSource is removed before releasing the underlying
> channel.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  io/channel-websock.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index 0a8c5c4712..a50a160e18 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -922,13 +922,13 @@ static void qio_channel_websock_finalize(Object *obj)
>      buffer_free(&ioc->encinput);
>      buffer_free(&ioc->encoutput);
>      buffer_free(&ioc->rawinput);
> -    object_unref(OBJECT(ioc->master));
>      if (ioc->io_tag) {
>          g_source_remove(ioc->io_tag);
>      }
>      if (ioc->io_err) {
>          error_free(ioc->io_err);
>      }
> +    object_unref(OBJECT(ioc->master));
>  }
>  
>  
> @@ -1218,6 +1218,15 @@ static int qio_channel_websock_close(QIOChannel *ioc,
>      QIOChannelWebsock *wioc = QIO_CHANNEL_WEBSOCK(ioc);
>  
>      trace_qio_channel_websock_close(ioc);
> +    buffer_free(&wioc->encinput);
> +    buffer_free(&wioc->encoutput);
> +    buffer_free(&wioc->rawinput);
> +    if (wioc->io_tag) {
> +        g_clear_handle_id(&wioc->io_tag, g_source_remove);
> +    }
> +    if (wioc->io_err) {
> +        g_clear_pointer(&wioc->io_err, error_free);
> +    }
>      return qio_channel_close(wioc->master, errp);
>  }
>  
> -- 
> 2.50.1
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


