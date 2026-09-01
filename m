Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8663C624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SKb-0004ZO-Rw; Tue, 01 Sep 2026 13:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1SKa-0004ZF-WB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1SKY-0007h6-TW
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788283890;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCqsEIBbgABjttWbC115Pwf2p3f/61FQ5TxkxIcMJgg=;
 b=OYBVAi+eeChc0+BVqgSHJ6M3tNZOastwtk7nXvqGrMMA5+xk6m4No7bAtAZSzOMPwah7Et
 wRyRrO0b/tCa3Mqrv6NiSynXLpCFydDO+V35vTN5oU+TfrYCYwanHOWP6wK4G199wVeGQZ
 xMoacfosoe30XpIuw4oiSfI21cJB4qk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-VqsX9HXXOVmoPVAM_SGYcA-1; Tue,
 01 Sept 2026 13:31:27 -0400
X-MC-Unique: VqsX9HXXOVmoPVAM_SGYcA-1
X-Mimecast-MFC-AGG-ID: VqsX9HXXOVmoPVAM_SGYcA_1788283886
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D28D7195609F; Tue,  1 Sep 2026 17:31:25 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1EB330001A2; Tue,  1 Sep 2026 17:31:23 +0000 (UTC)
Date: Tue, 1 Sep 2026 18:31:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 1/6] io/channel-socket: do not treat a zero length write
 as an error
Message-ID: <apcL6GC9c_bGYodp@redhat.com>
References: <20260831100151.914178-1-den@openvz.org>
 <20260831100151.914178-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831100151.914178-2-den@openvz.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Aug 31, 2026 at 12:01:46PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> qio_channel_socket_writev() checks "ret <= 0" after sendmsg(). A zero
> length iovec is written successfully and returns 0, so the success
> falls into the errno switch, which acts on whatever the last failing
> syscall left in errno. A stale EAGAIN turns it into
> QIO_CHANNEL_ERR_BLOCK with errp untouched, and a caller which treats
> every negative return as fatal then passes a NULL Error to
> error_get_pretty(). The websocket handshake does exactly that, so an
> unauthenticated client crashes QEMU during the greeting.
> 
> Returning 0 is safe for callers which loop until everything is
> written. qio_channel_writev_full_all() has no zero progress guard, but
> iov_copy() yields no entries for a zero length write, so that loop is
> never entered. A connected stream socket returns 0 only when there is
> nothing to send.
> 
> The WIN32 implementation in the same file uses "ret < 0".
> 
> Fixes: 559607ea173a ("io: add QIOChannelSocket class")
> Cc: qemu-stable@nongnu.org
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  io/channel-socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Though IMHO it is also a bug in the caller to request writing
of zero bytes.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


