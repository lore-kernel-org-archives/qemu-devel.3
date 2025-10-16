Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCFACCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MWs-00044H-40; Thu, 16 Oct 2025 07:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9MWo-0003yl-Aq
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 07:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9MWh-00052t-ES
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 07:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760615523;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YGXJgS7s6LK1MTFk9cMQwe6C9ZB0ALHGMrAiAgTme1s=;
 b=NK+MEA0rhkMfdB3kvhDk06nwmmJFrqrRvFvqInCe8ndNUUl8hV2OLNyQC95BKSoTaLSDPk
 MIAm65Z4bJn8QFn7BKA0wU97f9GRatiJp0fo8y2mUS8U4hkuwryUc/a5qlsdhChyMSwkGf
 sCH6fulrFh5ThitY1n3/MVlFOjRuBns=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-CZ1zV6FqMZ-49l00yVDzcw-1; Thu,
 16 Oct 2025 07:52:01 -0400
X-MC-Unique: CZ1zV6FqMZ-49l00yVDzcw-1
X-Mimecast-MFC-AGG-ID: CZ1zV6FqMZ-49l00yVDzcw_1760615520
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BD11195608E; Thu, 16 Oct 2025 11:51:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 371041800451; Thu, 16 Oct 2025 11:51:52 +0000 (UTC)
Date: Thu, 16 Oct 2025 12:51:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de,
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: Re: [PATCH v2 16/25] chardev: add .chr_get_client() handler
Message-ID: <aPDcVSgydnzZV3yj@redhat.com>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-17-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016114104.1384675-17-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 16, 2025 at 02:40:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> A pair for .char_add_client(), to be used to support backend-transfer
> migration of chardev attached to vhost-user-blk in following commits.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  chardev/char-socket.c  | 7 +++++++
>  chardev/char.c         | 6 ++++++
>  include/chardev/char.h | 4 ++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 0a5738c158..51bb9d0a2d 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -929,6 +929,12 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
>      return 0;
>  }
>  
> +static int tcp_chr_get_client(Chardev *chr)
> +{
> +    SocketChardev *s = SOCKET_CHARDEV(chr);
> +
> +    return s->sioc->fd;
> +}

This will crash on a NULL s->sioc pointer when the chardev
is not connected. More generally it feels wrong to be exposing
internal impl details of the socket chardev in this way.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


