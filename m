Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEABAC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 18:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sblOz-0001o0-MZ; Wed, 07 Aug 2024 14:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sblOy-0001nG-2Q
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sblOs-00060a-4g
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723055320;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GdmMMXM1AukQrXC5Ya5uEZtl6/P9TuVcgoU/QAKY7Q=;
 b=OnM9iKTqEV57ISpYmLXJUUnvYzo5/nvB6rOanFt1YsZwomK8Yw0v22VieMcj453/lhCGRm
 3Of4bdWMAb+ffyyahcarWQanKMwlvyWq8zRSyDtGrQj/1N59XDTJ/rD4+tJy1SJ9JOZ380
 r35qK3K1iBluyYkpfb1T6lzwSOuNy1M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-2NmEC7kCMVOD5oH6BVh8Gg-1; Wed,
 07 Aug 2024 14:28:36 -0400
X-MC-Unique: 2NmEC7kCMVOD5oH6BVh8Gg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87B9E1955F69; Wed,  7 Aug 2024 18:28:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31C44300019D; Wed,  7 Aug 2024 18:28:29 +0000 (UTC)
Date: Wed, 7 Aug 2024 19:28:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH v4 4/7] nbd/server: CVE-2024-7409: Drop non-negotiating
 clients
Message-ID: <ZrO8yjx0PYWGYv_X@redhat.com>
References: <20240807174943.771624-9-eblake@redhat.com>
 <20240807174943.771624-13-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807174943.771624-13-eblake@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 07, 2024 at 12:43:30PM -0500, Eric Blake wrote:
> A client that opens a socket but does not negotiate is merely hogging
> qemu's resources (an open fd and a small amount of memory); and a
> malicious client that can access the port where NBD is listening can
> attempt a denial of service attack by intentionally opening and
> abandoning lots of unfinished connections.  The previous patch put a
> default bound on the number of such ongoing connections, but once that
> limit is hit, no more clients can connect (including legitimate ones).
> The solution is to insist that clients complete handshake within a
> reasonable time limit, defaulting to 10 seconds.  A client that has
> not successfully completed NBD_OPT_GO by then (including the case of
> where the client didn't know TLS credentials to even reach the point
> of NBD_OPT_GO) is wasting our time and does not deserve to stay
> connected.  Later patches will allow fine-tuning the limit away from
> the default value (including disabling it for doing integration
> testing of the handshake process itself).
> 
> Note that this patch in isolation actually makes it more likely to see
> qemu SEGV after nbd-server-stop, as any client socket still connected
> when the server shuts down will now be closed after 10 seconds rather
> than at the client's whims.  That will be addressed in the next patch.
> 
> For a demo of this patch in action:
> $ qemu-nbd -f raw -r -t -e 10 file &
> $ nbdsh --opt-mode -c '
> H = list()
> for i in range(20):
>   print(i)
>   H.insert(i, nbd.NBD())
>   H[i].set_opt_mode(True)
>   H[i].connect_uri("nbd://localhost")
> '
> 
> where later connections get to start progressing once earlier ones are
> forcefully dropped for taking too long, rather than hanging.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/server.c     | 31 ++++++++++++++++++++++++++++++-
>  nbd/trace-events |  1 +
>  2 files changed, 31 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


