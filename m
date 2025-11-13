Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAD4CD5BA0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 09:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJTF4-0001FE-8A; Thu, 13 Nov 2025 04:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJTEc-00015a-EL
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 04:03:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJTEa-0004eF-Ij
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 04:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763024595;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EbtA6md38hy+Bq5OXcQUkIVjf6yBtEH8Ns6gp83/sA4=;
 b=ZlxJkxXmap3Mo+xiIPUIdN0ATOiLaiW85J6fKY4NSB9J9W9MvQba0wbqN6/d8rfilNL2Hf
 jmML3IEZmdrfZrzvpPXJ8bcIW4PYTWQsxQqEhMfK0oBzt68J7cNH/ePUdeyJaGSF7SgR5k
 mWydQgixEqMDoABZWHi74eRqaXcxsSk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-WzqFJor6MAerabtdXgjupA-1; Thu,
 13 Nov 2025 04:03:13 -0500
X-MC-Unique: WzqFJor6MAerabtdXgjupA-1
X-Mimecast-MFC-AGG-ID: WzqFJor6MAerabtdXgjupA_1763024593
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED54B180049F; Thu, 13 Nov 2025 09:03:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD0083000198; Thu, 13 Nov 2025 09:03:09 +0000 (UTC)
Date: Thu, 13 Nov 2025 09:03:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 09/13] qio: Provide accessor around QIONetListener->sioc
Message-ID: <aRWeyr7xMovosK0X@redhat.com>
References: <20251112224032.864420-15-eblake@redhat.com>
 <20251112224032.864420-24-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112224032.864420-24-eblake@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Nov 12, 2025 at 04:31:09PM -0600, Eric Blake wrote:
> An upcoming patch needs to pass more than just sioc as the opaque
> pointer to an AioContext; but since our AioContext code in general
> (and its QIO Channel wrapper code) lacks a notify callback present
> with GSource, we do not have the trivial option of just g_malloc'ing a
> small struct to hold all that data coupled with a notify of g_free.
> Instead, the data pointer must outlive the registered handler; in
> fact, having the data pointer have the same lifetime as QIONetListener
> is adequate.
> 
> But the cleanest way to stick such a helper struct in QIONetListener
> will be to rearrange internal struct members.  And that in turn means
> that all existing code that currently directly accesses
> listener->nsioc and listener->sioc[] should instead go through
> accessor functions, to be immune to the upcoming struct layout
> changes.  So this patch adds accessor methods qio_net_listener_nsioc()
> and qio_net_listener_sioc(), and puts them to use.
> 
> While at it, notice that the pattern of grabbing an sioc from the
> listener only to turn around can call
> qio_channel_socket_get_local_address is common enough to also warrant
> the helper of qio_net_listener_get_local_address, and fix a copy-paste
> error in the corresponding documentation.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: new patch
> v3: fix off-by-one, also add qio_net_listener_get_local_address
> ---
>  include/io/channel-socket.h |  2 +-
>  include/io/net-listener.h   | 42 +++++++++++++++++++++++++++++++++++++
>  chardev/char-socket.c       |  2 +-
>  io/net-listener.c           | 27 ++++++++++++++++++++++++
>  migration/socket.c          |  4 ++--
>  ui/vnc.c                    | 34 ++++++++++++++++++------------
>  6 files changed, 94 insertions(+), 17 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


