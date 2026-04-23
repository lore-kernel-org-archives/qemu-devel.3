Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4257DF589CF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFtor-0007sm-Kk; Thu, 23 Apr 2026 09:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFtok-0007lZ-NV
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFtoh-0000sx-U3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776949801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yrt2d1UQo/uEdzcrW8OrSRjEvCxJaOzjH26WIm+POgg=;
 b=gTPX0VfYwaEDWJDHQ6mWwSofVL72s82NNIcpBhbgwVsNeOsZSoABSwZv2C/d9R0YrfZj5S
 efXRFjd0hqmKZzZv0OOgOb5B+ENPeah5z4ZWwUg94FMAWNW+/9gpg465mggaYStKl8G0Hi
 iOJt40nyIlvLI8+SjV7/PBFeqauUT7Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-1J4vL3i2PR-OU2ExcLP58g-1; Thu,
 23 Apr 2026 09:09:57 -0400
X-MC-Unique: 1J4vL3i2PR-OU2ExcLP58g-1
X-Mimecast-MFC-AGG-ID: 1J4vL3i2PR-OU2ExcLP58g_1776949796
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18CAD19560AA; Thu, 23 Apr 2026 13:09:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85008180045E; Thu, 23 Apr 2026 13:09:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34D0D21E6A28; Thu, 23 Apr 2026 15:09:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V6 13/14] qapi: examine IOThread attachment status via
 query-iothreads
In-Reply-To: <20260410150457.85190-14-zhangckid@gmail.com> (Zhang Chen's
 message of "Fri, 10 Apr 2026 23:04:56 +0800")
References: <20260410150457.85190-1-zhangckid@gmail.com>
 <20260410150457.85190-14-zhangckid@gmail.com>
Date: Thu, 23 Apr 2026 15:09:53 +0200
Message-ID: <87340lomam.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> Extend the 'IOThreadInfo' structure to include attachment metrics.
> This allows users to monitor the associated devices by identify them
> by their QOM paths.
>
> New fields added to IOThreadInfo:
> - @holders: IoThreadHolder(QOM path or block node name) of the devices
>             currently associated with this iothread.

See "I'm confused" below.

>
> These fields are also exposed via the Human Monitor Interface (HMP)
> command 'info iothreads' to assist with manual debugging and
> performance tuning.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

[...]

> diff --git a/qapi/misc.json b/qapi/misc.json
> index d65d8012b2..e173d54a5e 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -94,7 +94,8 @@
>  # @IoThreadHolderKind:
>  #
>  # @block-node: Block node name.
> -# @qom-object: Standard QOM path.
> +#
> +# @qom-object: QOM path.
>  #
>  # Since: 11.0
>  ##

Squash this into PATCH 02, please.

> @@ -104,7 +105,7 @@
>  ##
>  # @IoThreadHolder:
>  #
> -# @type: Current IoThread holder type support QOM path and Block node.
> +# @type: Current IoThread holder type support QOM path and block node.

This, too.

>  #
>  # Since: 11.0
>  ##
> @@ -124,6 +125,13 @@
>  #
>  # @thread-id: ID of the underlying host thread
>  #
> +# @holders: IoThreadHolder(QOM path or block node name) of the devices

Space before (

> +#     currently associated with this iothread.  Users can pre-allocate

I'm confused.  What is holding what?

A QOM object / block node / monitor holding an I/O thread?

> +#     multiple iothread objects to serve as a persistent thread pool.
> +#     When a device is hot-unplugged, it is detached from its
> +#     iothread, but the iothread remains available, allowing future
> +#     hot-plugged devices to attach to it.
> +#
>  # @poll-max-ns: maximum polling time in ns, 0 means polling is
>  #     disabled (since 2.9)
>  #
> @@ -141,6 +149,7 @@
>  { 'struct': 'IOThreadInfo',
>    'data': {'id': 'str',
>             'thread-id': 'int',
> +           'holders': ['IoThreadHolder'],
>             'poll-max-ns': 'int',
>             'poll-grow': 'int',
>             'poll-shrink': 'int',
> @@ -166,6 +175,8 @@
>  #              {
>  #                 "id":"iothread0",
>  #                 "thread-id":3134,
> +#                 "holders":["/machine/peripheral/blk1/virtio-backend",
> +#                            "/machine/peripheral/blk0/virtio-backend"],
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,
> @@ -174,6 +185,7 @@
>  #              {
>  #                 "id":"iothread1",
>  #                 "thread-id":3135,
> +#                 "holders":["/machine/peripheral/blk2/virtio-backend"],
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,


