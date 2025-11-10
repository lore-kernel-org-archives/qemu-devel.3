Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF7CCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 18:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIWzB-0006Hc-C4; Mon, 10 Nov 2025 13:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vIWg4-0004tW-An
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 13:31:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vIWg2-000077-8L
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 13:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762799501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GFc30vJWY51tgN7oEfX+cbZm0Rd6DS/ppdZyK+KRF80=;
 b=AMIJ6cqRJGwii3d/yxaoFPlYZfidTps1pGv4FsQdNSQol4cb7XpjcqcgzGW8qKYd3DXyw9
 W7kNBeELjV09CMuhXBrPmSNSSIELVoqA1LWHOaPFW90rXN9dxXz5EtnAoqZwKPaXVAr3eI
 ikaWcrhtZg6UjAb2NR8caOjQq+muFoQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-hKo5vmO1Ny-HibonFARkVQ-1; Mon,
 10 Nov 2025 13:31:37 -0500
X-MC-Unique: hKo5vmO1Ny-HibonFARkVQ-1
X-Mimecast-MFC-AGG-ID: hKo5vmO1Ny-HibonFARkVQ_1762799496
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 319AC1800350; Mon, 10 Nov 2025 18:31:36 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.44])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C207180035F; Mon, 10 Nov 2025 18:31:33 +0000 (UTC)
Date: Mon, 10 Nov 2025 12:31:30 -0600
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berrange@redhat.com, kwolf@redhat.com, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 08/12] qio: Provide accessor around QIONetListener->sioc
Message-ID: <haasbv7ril4vgvhwq6abanfggwpck3pkigagzm7uqtvc4wrqvu@axvifs4fk6px>
References: <20251108230525.3169174-14-eblake@redhat.com>
 <20251108230525.3169174-22-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108230525.3169174-22-eblake@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Nov 08, 2025 at 04:59:29PM -0600, Eric Blake wrote:
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
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---

> +++ b/io/net-listener.c
> @@ -298,6 +298,18 @@ bool qio_net_listener_is_connected(QIONetListener *listener)
>      return listener->connected;
>  }
> 
> +size_t qio_net_listener_nsioc(QIONetListener *listener)
> +{
> +    return listener->nsioc;
> +}
> +
> +QIOChannelSocket *qio_net_listener_sioc(QIONetListener *listener, size_t n)
> +{
> +    if (n > listener->nsioc) {
> +        return NULL;

Off-by-1; this should be 'n >= listener->nsioc'.

> +    }
> +    return listener->sioc[n];
> +}

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


