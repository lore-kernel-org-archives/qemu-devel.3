Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8C5CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 20:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGjm8-0006aX-1U; Wed, 05 Nov 2025 15:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGjlu-0006Zp-3M
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 15:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGjlp-0007sB-Mj
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 15:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762373175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsYWFQ7M98c3CCWI0HedSJycDt764Q0g/uIoYQ6Su98=;
 b=SaPbutWWLRJfQOBIRIvd5q6FF81J7Ga/xoDwHdOM+LMeOAmBlZ+nhwisf1NxDfX6vEsU4C
 L4pfYbeGXByNu44OXALsQTDO8ASUC3DnpevziwrMurXeTOfKLA44Xz3filt5x5rGrlcZVA
 jnd/Y2+NCnPZY2nBDkqNdwkyXuizZ04=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-WrTFEcVyN6aRJSwx2RaTtw-1; Wed,
 05 Nov 2025 15:06:12 -0500
X-MC-Unique: WrTFEcVyN6aRJSwx2RaTtw-1
X-Mimecast-MFC-AGG-ID: WrTFEcVyN6aRJSwx2RaTtw_1762373171
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0DB219560A1; Wed,  5 Nov 2025 20:06:10 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.131])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 344821800872; Wed,  5 Nov 2025 20:06:08 +0000 (UTC)
Date: Wed, 5 Nov 2025 14:06:06 -0600
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berrange@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 5/8] qio: Let listening sockets remember their owning
 QIONetListener
Message-ID: <3nyd5oqiiy5egwfuup4ibnw5kgb555ijshpiafax3xdjgvcy6b@a7qwjdlkpuwi>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103202849.3687643-15-eblake@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

On Mon, Nov 03, 2025 at 02:10:56PM -0600, Eric Blake wrote:
> Make it easier to get from the sioc listening to a single address on
> behalf of a NetListener back to its owning object, which will be
> beneficial in an upcoming patch that teaches NetListener how to
> interact with AioContext.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/io/channel-socket.h | 1 +
>  io/channel-socket.c         | 1 +
>  io/net-listener.c           | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index a88cf8b3a9f..eee686f3b4d 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -49,6 +49,7 @@ struct QIOChannelSocket {
>      socklen_t remoteAddrLen;
>      ssize_t zero_copy_queued;
>      ssize_t zero_copy_sent;
> +    struct QIONetListener *listener;

Commenting on my own patch:

After re-reading docs/devel/style.rst, I can see that this particular
forward declaration of QIONetListener is not consistent with the
guidelines.  I have to have a forward reference, since the style guide
also forbids circular inclusion (net-listener.h already includes
channel-socket.h, so channel-socket.h cannot include net-listener.h);
but it may be better for me to move the forward reference into
include/qemu/typedefs.h rather than inlining it how I did here.

(It is a red herring that struct QIOChannelSocket{} already contains
two other uses of 'struct' in its declaration body - both of those are
for 'struct sockaddr_storage' which is the POSIX type always spelled
with struct, with no typical QEMU CamelCase wrapper)

> +++ b/io/channel-socket.c
> @@ -65,6 +65,7 @@ qio_channel_socket_new(void)
>      sioc->fd = -1;
>      sioc->zero_copy_queued = 0;
>      sioc->zero_copy_sent = 0;
> +    sioc->listener = NULL;

Also, I added an explicit zero initialization to the new member to
match existing explicit initializers.  But checking qom/object.c, I
see that object_new() first uses g_malloc() instead of g_new0(), but
then calls object_initialize_with_type() does a forced memset(,0,) -
so all object constructors that do explicit field initialization to
zero are doing redundant work.

Dropping the sioc->listener = NULL assignment from this patch thus
makes sense from the less work perspective, but now that I've pointed
it out, dropping the sioc->zero_copy_* = 0 lines makes sense too.  But
cleanups like that should probably be a separate patch, and maybe
touch as many clients of object_new() as possible (perhaps via
Coccinelle?), rather than shoehorning in a deletion of just those two
lines into a v2 of this particular patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


