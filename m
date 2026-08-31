Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1823DC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x10Cy-0006KS-Pe; Mon, 31 Aug 2026 07:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x10Cw-0006KK-L2
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x10Cu-0006GG-AZ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788175782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJXytDvKu/edgksKPG3JhKbgWSC3f5O2t2VzIBvsNRw=;
 b=Ap0b1KneGKOlHKPDvbQ41qGlXxjP0U+9LrEufHR9uBZwe3rLs2vJJQGNCU6aD8XAOR14Nd
 2YMOaUuLNe72/QqyqMbEh/NIS4xVloegQQqEU1BhKpo5kCDNGRK8OftBldOikVI5+idHAx
 Hc211JKXbnu7h4CI0Jt86Y2iPRzc7hI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-OyLMcJaIMxmDyDIQeB7DKQ-1; Mon,
 31 Aug 2026 07:29:38 -0400
X-MC-Unique: OyLMcJaIMxmDyDIQeB7DKQ-1
X-Mimecast-MFC-AGG-ID: OyLMcJaIMxmDyDIQeB7DKQ_1788175777
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A6D3195DE25; Mon, 31 Aug 2026 11:29:37 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF7FB3000223; Mon, 31 Aug 2026 11:29:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/6] io/channel-websock: fix an unauthenticated crash
 in the handshake
From: marcandre.lureau@redhat.com
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260831100151.914178-1-den@openvz.org>
References: <20260831100151.914178-1-den@openvz.org>
Date: Mon, 31 Aug 2026 15:29:28 +0400
Message-Id: <178817576852.2700790.2039576285438786814.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2406;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GrF16Y3Z1p1fW+FFfUaezQ7gpNaatjYUJ91xcUMcUZk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqlWWbmOci1jRZt7RRS2ZZkNkuGua0Pt76XNJXc
 M7JKLpkHmyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapVlmwAKCRDa6OEJdZac
 5cv1EACTiPalcWC96f63mzuksQH2kY4Qa2r3srcnyjoQOSxQ1QyUnDusyOOP7q58P6tKjXB0X2Q
 LU6Lj0O0dzaHhk1i/fxsTT3Wc+eYgv4UOy37ntxdePah28nE1n0MejyiI9fnHQybPAAFnPymv+c
 2RpxEa1DJX3xQoBgFGTcxym/MSV149kQEFTNn8MmF2riIt1TVeHgam1G8E2ZhZ5GikY+pW05zlD
 r5PbD1lKcijQFmOyv8U6cixLsZRifCdR6qGCWjFmGkxJ7JF59hnautkX5mWiNo+A+LK74YDUZ3b
 T8onrhLfbZLberR4nxCWRMmxfsKYxe/QZ/l6N2Rk0piKG3/c6WbNCW8GTbvEQfVZzbX6+BEpRWj
 eeOMIvDoRwI7vxwp+4IXcq76x1RXDaeJMno+uFjMZs/JdxJoP1n1KFvoQaWjM7mgWN62gf82N/B
 TNQzSj5qHHEHpAWJfJk83ufc3JjPCVQZozw6nRmjFIUNElC2rbVqXH0IDmA9ykTXcA6mEydqfdN
 dUaK1LmcspFPalmwtAKBcFtz79MQDchai2WpiWhFVv4aTF2Yzg1ofNGX+N3bm2/rk1flsrFubq3
 O1ebUeA2QGg4yg0nFgqLrZF5pYM0alqlOQKkn8mUr6DdhzG8XsEdIb/Ps+jlTxshn5w5BlMDryF
 a6u3Sgl8X8l4qKg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> A client which can reach a VNC websocket port crashes QEMU before it has
> authenticated, by sending an HTTP greeting whose request line holds no
> space:
> 
>   printf 'stats\r\nx\r\n\r\n' | nc $host $port
> 
> Three defects line up to produce it. The greeting is rejected without
> queueing a response, so the handshake goes on to flush an empty buffer.
> A zero length sendmsg() succeeds and returns 0, which
> qio_channel_socket_writev() mistakes for failure and reports as
> QIO_CHANNEL_ERR_BLOCK with errp left unset. The handshake treats every
> negative return as fatal and hands that NULL Error to
> error_get_pretty(). Patches 1 to 3 close the three links.
> 
> Patch 5 is the same NULL Error on the read side of the handshake, where
> ERR_BLOCK is folded into -1. It is reachable for a wss:// client, whose
> master channel is then a TLS channel: a wakeup carrying only part of a
> record makes gnutls report EAGAIN.
> 
> The tests drive the handshake through a channel which reports ERR_BLOCK
> on demand, covering both directions. No test reproduces the original
> crash itself, which turns on a stale errno and is not reliably
> reproducible in a unit test. What they pin is that a 400 is emitted and
> that ERR_BLOCK no longer reaches error_get_pretty().
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Daniel P. Berrangé <berrange@redhat.com>
> CC: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Denis V. Lunev (6):
>   io/channel-socket: do not treat a zero length write as an error
>   io/channel-websock: send an HTTP 400 when the greeting has no space
>   io/channel-websock: handle a blocked write during the handshake
>   tests/unit: add websock handshake test
>   io/channel-websock: do not lose QIO_CHANNEL_ERR_BLOCK while reading
>   tests/unit: cover blocked IO during the websock handshake
> 
>  io/channel-socket.c                  |   2 +-
>  io/channel-websock.c                 |  10 +-
>  tests/unit/meson.build               |   1 +
>  tests/unit/test-io-channel-websock.c | 249 +++++++++++++++++++++++++++
>  4 files changed, 260 insertions(+), 2 deletions(-)
>  create mode 100644 tests/unit/test-io-channel-websock.c
> 

Patch series lgtm. You cc stable, why didn't you file a CVE?

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


