Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE2DC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SW4-0005RI-82; Tue, 01 Sep 2026 13:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1SW2-0005Mz-Em
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1SW0-0001SC-Fv
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788284599;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RfdWQhPY4KIXAcmOnEzm9vM/rdBeJ/CCr79174S+EnI=;
 b=Huu+nUfZQGKdYFAT59KVuzxdDvXGpua55fhtqwUgQEdgxMmzlNS/uAOy2NoN7V+ft5rJ5w
 mlPJb86tJCy4Uz88NjzS0xhhp1Zr0nEqMNli08eNO4HIcacn7UNa9ZxF5Xvp67AMaPVBRi
 eNkgolM44YotaKt536qtIZ1/D305AnA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-RyFvgwumNIyhd-EJONm_-Q-1; Tue,
 01 Sept 2026 13:43:18 -0400
X-MC-Unique: RyFvgwumNIyhd-EJONm_-Q-1
X-Mimecast-MFC-AGG-ID: RyFvgwumNIyhd-EJONm_-Q_1788284597
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7C4D184A098; Tue,  1 Sep 2026 17:43:16 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B7B01803A7A; Tue,  1 Sep 2026 17:43:15 +0000 (UTC)
Date: Tue, 1 Sep 2026 18:43:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/6] io/channel-websock: fix an unauthenticated crash in
 the handshake
Message-ID: <apcOsFJFVVekcWAi@redhat.com>
References: <20260831100151.914178-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831100151.914178-1-den@openvz.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 31, 2026 at 12:01:45PM +0200, Denis V. Lunev wrote:
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


Thanks for the various fixes.

While we're on this topic though, way back when Websocket support was
first introduced to QEMU, I was pretty sceptical that it was a good
idea for QEMU to be implementing the HTTP protocol directly. Some of
these bugs (possibly even all) were likely a direct result of me
porting the websockets code into QIOChannel, so not neccessarily the
original impl.

None the less, I still feel pretty uncomfortable about the idea of
QEMU implementing websockets/HTTP support directly. The lack of
TLS support is a big flag that makes the whole thing questionable.
Although you could put TLS in at the VNC level with VeNCrypt,
IMHO doing it at the HTTP level is the right approach so the VNC
protocol handshake is fully covered.

Having it inside QEMU also means it missed the biggest benefit of
using websockets, which is that you can have a single TCP port
hosting all VMs and select them dynamically from the HTTP request,
instead of one TCP port per VM.

So I've thought about proposing its deprecation & deletion several
times, on the basis that it is better to put an external websockets
proxy in front of QEMU's VNC server instead of inside QEMU.


None the less, I'll queue all these patches.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


