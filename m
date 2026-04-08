Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2385D10F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVl-0004Sb-88; Wed, 08 Apr 2026 15:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAY52-0006g7-04
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wARaA-0008D7-36
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 08:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775649629;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QzRZy/UiZMCPm6IVlmWgawDD3tp2+VYGrqFAiLFQBHo=;
 b=efmWXeBgk7A4h0/RGQFssd+1j45xF08q1OqKgs+viaf990sKdPfkEzSpeKzxGjig8bODsf
 quw229kRkC/yVM85+kYDUhn8pIm2kjOBiuTbiuiphJeve4kRq4r6y+GiceXuIZuijA6mCR
 tehOTk43gebiU5x7B7WrOPJv+ybkRA4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-mEDxfqJlP_azAihopj8kOQ-1; Wed,
 08 Apr 2026 08:00:27 -0400
X-MC-Unique: mEDxfqJlP_azAihopj8kOQ-1
X-Mimecast-MFC-AGG-ID: mEDxfqJlP_azAihopj8kOQ_1775649626
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4784C180056E; Wed,  8 Apr 2026 12:00:26 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 573B019560A6; Wed,  8 Apr 2026 12:00:24 +0000 (UTC)
Date: Wed, 8 Apr 2026 13:00:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: Re: [RFC v4 3/5] io/channel-socket: tolerate AF_PACKET getpeername
Message-ID: <adZDVfElLkzTaBM_@redhat.com>
References: <20260407050818.2249570-1-lulu@redhat.com>
 <20260407050818.2249570-4-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407050818.2249570-4-lulu@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 07, 2026 at 01:05:50PM +0800, Cindy Lu wrote:
> When -chardev socket,fd=... is handed an AF_PACKET socket,
> getpeername() can fail with EOPNOTSUPP instead of ENOTCONN because
> packet sockets are not connection-oriented. qio_channel_socket_set_fd()
> currently treats that as fatal and refuses to wrap the fd, even though
> getsockname() and the local address are still valid.
> 
> Treat EOPNOTSUPP the same way as ENOTCONN and leave remoteAddr empty.
> That keeps existing stream-socket behavior unchanged while allowing
> AF_PACKET fds to be adopted by QIOChannelSocket.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  io/channel-socket.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 3053b35ad8..2ed26aefa3 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -115,7 +115,11 @@ qio_channel_socket_set_fd(QIOChannelSocket *sioc,
>  
>      if (getpeername(fd, (struct sockaddr *)&sioc->remoteAddr,
>                      &sioc->remoteAddrLen) < 0) {
> -        if (errno == ENOTCONN) {
> +        if (errno == ENOTCONN
> +#ifdef EOPNOTSUPP
> +            || errno == EOPNOTSUPP
> +#endif

Why conditionalize it ?  We use this unconditionally throughout
QEMU code AFAICS, even on Windows.

> +            ) {
>              memset(&sioc->remoteAddr, 0, sizeof(sioc->remoteAddr));
>              sioc->remoteAddrLen = sizeof(sioc->remoteAddr);
>          } else {
> -- 
> 2.52.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


