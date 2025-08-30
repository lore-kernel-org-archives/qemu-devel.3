Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180DFCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO6g-0006JQ-GF; Sat, 30 Aug 2025 12:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1usGmH-0007Wy-2E
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 04:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1usGmD-0000gN-Ir
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 04:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756541850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNH0bnIDWZ4tm1P0gAI1K4Eo7Yr106+oiVDBobMqCJg=;
 b=V18OftJBxThqUHRp/rH2us0L5jj1ED10tLEBrFIEkEXtx4R+MsNSKlPxE1MxXyDhNX3plk
 dGV/FdEqkX4BF8lb4kq/3AmFxyG/gKTKYfpAF3L7rtoHS+LVv+XlNwF2XZPxeMBiSkSyBe
 LQ4ywj4gxyMzZir356ddVWyjg/QVm6w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-INbKNUC8M-mQHGMqXsozmA-1; Sat,
 30 Aug 2025 04:17:27 -0400
X-MC-Unique: INbKNUC8M-mQHGMqXsozmA-1
X-Mimecast-MFC-AGG-ID: INbKNUC8M-mQHGMqXsozmA_1756541846
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 068FB180044F; Sat, 30 Aug 2025 08:17:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6899830001B5; Sat, 30 Aug 2025 08:17:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD82321E6A27; Sat, 30 Aug 2025 10:17:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  qemu-devel@nongnu.org,  eblake@redhat.com,
 devel@lists.libvirt.org
Subject: Re: [PATCH] qapi: net/tap: deprecate vhostforce option
In-Reply-To: <20250829125429.795595-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 29 Aug 2025 15:54:29 +0300")
References: <20250829125429.795595-1-vsementsov@yandex-team.ru>
Date: Sat, 30 Aug 2025 10:17:22 +0200
Message-ID: <87wm6lcjfx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> This option simply duplicates the @vhost option since long ago
> (10 years!)
> commit 1e7398a140f7a6 ("vhost: enable vhost without without MSI-X").

This isn't obvious to me.

As far as I can see, their only use is in net_init_tap_one():

    if (tap->has_vhost ? tap->vhost :
        vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {

Can you take this apart for me?

> Let's finally deprecate it.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  docs/about/deprecated.rst | 7 +++++++
>  qapi/net.json             | 6 +++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index d50645a071..d14cb37480 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -516,6 +516,13 @@ Stream ``reconnect`` (since 9.2)
>  The ``reconnect`` option only allows specifying second granularity timeouts,
>  which is not enough for all types of use cases, use ``reconnect-ms`` instead.
>  
> +TAP ``vhostforce`` (since 10.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``vhostforce`` option just duplicates the main ``vhost`` option.
> +Use ``vhost`` alone.

Would "Use instead ``vhost`` instead" be clearer?

> +
> +
>  VFIO device options
>  '''''''''''''''''''
>  
> diff --git a/qapi/net.json b/qapi/net.json
> index 78bcc9871e..d1216bb60a 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -353,6 +353,10 @@
>  # @poll-us: maximum number of microseconds that could be spent on busy
>  #     polling for tap (since 2.7)
>  #
> +# Features:
> +#
> +# @deprecated: Member @vhostforce is deprecated.  Simply use @vhost.

@deprecated text is commonly of the form "FOO is deprecated.  Use BAR
instead."

Recommend "Use @vhost instead."

> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevTapOptions',
> @@ -369,7 +373,7 @@
>      '*vhost':      'bool',
>      '*vhostfd':    'str',
>      '*vhostfds':   'str',
> -    '*vhostforce': 'bool',
> +    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
>      '*queues':     'uint32',
>      '*poll-us':    'uint32'} }


