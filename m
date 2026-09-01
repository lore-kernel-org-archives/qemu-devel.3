Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78445C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SGD-0003QQ-Nt; Tue, 01 Sep 2026 13:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1SGD-0003QF-25
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1SG7-0006Xw-6x
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788283614;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfcDS2D5SbPqPSf7/h/hYBznhRyHdoYSNvKEouFPRZk=;
 b=BMHUYXy6K8Bx4Rtn5OJYXO5qQljZkNCMz1QH3ck05ThvF7/U6jsJ/AjrtRSWpTgHzbgpe9
 ZzWJ001QHhKhcj3s4GbvBy23gMLkdyhVykMzMIuUD/a1STR7HPRMjpxVXRMU2aMH8TvbQ4
 Y9TvujaWSsyY+RkjMmKtpo3i1SG2O3Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-OczMYwJTMpuiXB0yazPwpQ-1; Tue,
 01 Sept 2026 13:26:51 -0400
X-MC-Unique: OczMYwJTMpuiXB0yazPwpQ-1
X-Mimecast-MFC-AGG-ID: OczMYwJTMpuiXB0yazPwpQ_1788283610
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C43518009DF; Tue,  1 Sep 2026 17:26:50 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8AE41803A60; Tue,  1 Sep 2026 17:26:48 +0000 (UTC)
Date: Tue, 1 Sep 2026 18:26:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 5/6] io/channel-websock: do not lose
 QIO_CHANNEL_ERR_BLOCK while reading
Message-ID: <apcK1YPQTL3QEvuM@redhat.com>
References: <20260831100151.914178-1-den@openvz.org>
 <20260831100151.914178-6-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831100151.914178-6-den@openvz.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 31, 2026 at 12:01:50PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> qio_channel_websock_handshake_read() folds every negative return from
> qio_channel_read() into -1. QIO_CHANNEL_ERR_BLOCK leaves errp unset, so
> qio_channel_websock_handshake_io() then hands a NULL Error to
> error_get_pretty() and QEMU dies.
> 
> The master channel is non-blocking and, for a wss:// client, is a TLS
> channel. A G_IO_IN wakeup carrying only part of a TLS record makes
> gnutls report EAGAIN, which is all it takes to reach this before the
> client has authenticated.
> 
> ERR_BLOCK here means the headers are not complete yet, which is what a
> 0 return already tells the caller. Report it that way and keep waiting.
> The watch is level triggered, so an incomplete record sitting in the
> socket spins the main loop until the rest of it arrives. That is
> bounded by the round trip and is what every reader layered over TLS
> already does.
> 
> Fixes: 2d1d0e70cf3e ("io: add QIOChannelWebsock class")
> Cc: qemu-stable@nongnu.org
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  io/channel-websock.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


