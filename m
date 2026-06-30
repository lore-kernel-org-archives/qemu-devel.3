Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32FCC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVGJ-0003PF-Jo; Tue, 30 Jun 2026 06:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weVGI-0003P4-8D
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weVGG-0003DP-7B
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782813610;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRrngd/3Yub5FCeNAUgkotsCDLLaZPJwkgWvYp12aws=;
 b=Mlx3QdJ4gt4Jec2KsdjBdlKD2EWccqZzjTR9eHY4PQP9er03XuivIrNpMkWndad2bXx653
 pmKTXI7F97Q9zORG2WEo71SCTqME0123AzcneLL7x0nCpY0xr/y29fD9pWItDH245LRIzk
 lr1fMLZHGIecpJCHa3IZSZJOw6HCbn0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-FfVNHuqhMy-8VkiTwbuA2w-1; Tue,
 30 Jun 2026 06:00:06 -0400
X-MC-Unique: FfVNHuqhMy-8VkiTwbuA2w-1
X-Mimecast-MFC-AGG-ID: FfVNHuqhMy-8VkiTwbuA2w_1782813605
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0388A1956058; Tue, 30 Jun 2026 10:00:05 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.20])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 947F019560B2; Tue, 30 Jun 2026 10:00:03 +0000 (UTC)
Date: Tue, 30 Jun 2026 10:59:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] io/channel-socket: Document why we can ignore
 socket_set_cork() errors
Message-ID: <akOTn-JUKbYLJPA5@redhat.com>
References: <20260630093518.2325304-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630093518.2325304-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 30, 2026 at 10:35:18AM +0100, Peter Maydell wrote:
> In qio_channel_socket_set_cork(), we call socket_set_cork() but
> ignore its success/failure return value.  This is OK because we are
> implementing qio_channel_set_cork() here, and that function's API
> documentation states that the setting is merely a hint.  So even if
> setting TCP_CORK on the underlying socket fails for some reason, this
> isn't going to be a problem for the caller; correspondingly the
> qio_channel_set_cork() function has no error return.
> 
> Add a comment in qio_channel_socket_set_cork() explaining why we
> don't check for errors.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2254
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Spotted by a static analyzer; it seemed to me worth adding the comment.
> ---
>  io/channel-socket.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

and queued.

> 
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index ea2ec84108..12773b832c 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -946,6 +946,12 @@ qio_channel_socket_set_cork(QIOChannel *ioc,
>      QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>      int v = enabled ? 1 : 0;
>  
> +    /*
> +     * We can ignore the error return from socket_set_cork() because
> +     * at the QIO API level set_cork is only a hint, and so
> +     * qio_channel_set_cork() can never fail even if it didn't
> +     * actually do anything.
> +     */
>      socket_set_cork(sioc->fd, v);
>  }
>  
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


