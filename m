Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146E7CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 10:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3XtH-0001iz-6K; Tue, 30 Sep 2025 06:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3XtE-0001iG-4l
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3Xt5-0000iP-4I
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759229226;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=P/csI+2buzQQ1UIQqqZYPwG5NXUjlx0nMYbrq1bg3UI=;
 b=M2P0BIPt+4/TnarvgcGSwhLi569SwVXoHyxJfoO4MPtp/CpIGhHyg2K87dpw0NrmTN5FeP
 fZ3czk0a1zdOAq51iR09y/kSu1oLu2E8h6x+1qbscHjN5MvDx7Win5ZhAPTO+onmpHspYJ
 l5NAgTiq3wyHhLO8st08nu5PdUktDqc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-hjsrK475NTKHv0TkGCZtxg-1; Tue,
 30 Sep 2025 06:46:57 -0400
X-MC-Unique: hjsrK475NTKHv0TkGCZtxg-1
X-Mimecast-MFC-AGG-ID: hjsrK475NTKHv0TkGCZtxg_1759229216
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8632E19560BB; Tue, 30 Sep 2025 10:46:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5C5C1956095; Tue, 30 Sep 2025 10:46:53 +0000 (UTC)
Date: Tue, 30 Sep 2025 11:46:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Grant Millar | Cylo <rid@cylo.io>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] ui/vnc: Fix NULL pointer dereference in
 vnc_disconnect_start
Message-ID: <aNu1GnwmAOi0SOAm@redhat.com>
References: <CANdvy3dH9bBdopj_KUqaLD0Viq7uKn0jPObjqz6H7XvMgRnPrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANdvy3dH9bBdopj_KUqaLD0Viq7uKn0jPObjqz6H7XvMgRnPrw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 30, 2025 at 10:35:01AM +0100, Grant Millar | Cylo wrote:
> From 0d1c4ac000a66ef22b4a0cd0c4bedd840192096a Mon Sep 17 00:00:00 2001
> From: Rid <rid@cylo.io>
> Date: Tue, 30 Sep 2025 10:23:58 +0100
> Subject: [PATCH] ui/vnc: Fix NULL pointer dereference in vnc_disconnect_start
> 
> When a WebSocket connection fails during the handshake, vs->ioc can be
> NULL when vnc_disconnect_start() is called, leading to a segmentation
> fault when qio_channel_close() tries to dereference it.
> 
> This can be reproduced by sending incomplete HTTP requests to the
> WebSocket port:
> 
>   for i in {1..100}; do
>     (echo -n "GET / HTTP/1.1" && sleep 0.05) | nc -w 1 <IP> <PORT> &
>   done
> 
> Add a NULL check before calling qio_channel_close() to prevent the crash.
> 
> Signed-off-by: Rid <rid@cylo.io>
> ---
>  ui/vnc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 77c823bf2e..1669ed1b80 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1301,7 +1301,9 @@ static void vnc_disconnect_start(VncState *vs)
>          g_source_remove(vs->ioc_tag);
>          vs->ioc_tag = 0;
>      }
> -    qio_channel_close(vs->ioc, NULL);
> +    if (vs->ioc) {
> +        qio_channel_close(vs->ioc, NULL);
> +    }
>      vs->disconnecting = TRUE;

The NULL here is  just a symptom of a bigger problem earlier on and
thus the wrong thing to fix.

The QIOChannelWebsock is not unregistering the GSource callback when
it is closed. So we have closed the QIOChannel client connection,
freed the VncState struct, but still have a (now closed) FD registered
with the event loop for poll(). This eventually triggers the callback
which does a use-after-free on VncState which happens to not crash,
but returns a NULL QIOChannel which is passed to vnc_disconnect_start

We need to fix QIOChannelWebsock to remove the GSource.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


