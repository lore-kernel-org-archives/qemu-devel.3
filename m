Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB29CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Opr-0003EC-TC; Thu, 16 Oct 2025 10:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9Opp-0003AT-VC
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9Opd-0001cy-Re
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760624385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2QH6bxarJSosxIZHyyqYk/vswgK8GtKX7ZUbv9jTCJ0=;
 b=dax68tqW2mMPzX476vDCer31n688oX5Er8uHviFkRO+ojz7ki1T4JFaD2xy4viiG3Z+uLw
 15pX80RTLtvZdv+PlYmEeWN1SXRxThlLKyV+wCot8BzhZz/GwIcS4LRd1K6ObMdhbGL478
 wslq4ota3yfeSeh24RerpCxan0LuXfM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-TIw2Wxh2O6iBzCFcgOiIXg-1; Thu,
 16 Oct 2025 10:19:43 -0400
X-MC-Unique: TIw2Wxh2O6iBzCFcgOiIXg-1
X-Mimecast-MFC-AGG-ID: TIw2Wxh2O6iBzCFcgOiIXg_1760624382
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BB701808985; Thu, 16 Oct 2025 14:19:42 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C4D81800577; Thu, 16 Oct 2025 14:19:40 +0000 (UTC)
Date: Thu, 16 Oct 2025 09:19:37 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Grant Millar | Cylo <rid@cylo.io>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v2 3/3] io: fix use after free in websocket handshake code
Message-ID: <6cimskrbakrzqi63vwup45m4riyrbrlmcsws34llmhv2jqokeh@w5tzqlnuuf73>
References: <20251003150245.3510069-1-berrange@redhat.com>
 <20251003150245.3510069-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003150245.3510069-4-berrange@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Oct 03, 2025 at 04:02:45PM +0100, Daniel P. Berrangé wrote:
> If the QIOChannelWebsock object is freed while it is waiting to
> complete a handshake, a GSource is leaked. This can lead to the
> callback firing later on and triggering a use-after-free in the
> use of the channel. This was observed in the VNC server with the
> following trace from valgrind:
> 
> ==2523108== Invalid read of size 4
> ==2523108==    at 0x4054A24: vnc_disconnect_start (vnc.c:1296)

> 
> The above can be reproduced by launching QEMU with
> 
>   $ qemu-system-x86_64 -vnc localhost:0,websocket=5700
> 
> and then repeatedly running:
> 
>   for i in {1..100}; do
>      (echo -n "GET / HTTP/1.1" && sleep 0.05) | nc -w 1 localhost 5700 &
>   done
> 
> CVE-2025-11234
> Reported-by: Grant Millar | Cylo <rid@cylo.io>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/io/channel-websock.h |  3 ++-
>  io/channel-websock.c         | 22 ++++++++++++++++------
>  2 files changed, 18 insertions(+), 7 deletions(-)

> 
> diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
> index e180827c57..6700cf8946 100644
> --- a/include/io/channel-websock.h
> +++ b/include/io/channel-websock.h
> @@ -61,7 +61,8 @@ struct QIOChannelWebsock {
>      size_t payload_remain;
>      size_t pong_remain;
>      QIOChannelWebsockMask mask;
> -    guint io_tag;
> +    guint hs_io_tag; /* tracking handshake task */
> +    guint io_tag; /* tracking watch task */

The comment helps.  It might be possible to use a longer name like
watch_io_tag as the counterpart to hs_io_tag for symmetry, but that's
more code churn, so I'm happy to keep the names you have here.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


