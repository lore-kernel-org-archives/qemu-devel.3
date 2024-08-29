Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CF1C83F09
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 11:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjdlw-0006Q7-4e; Thu, 29 Aug 2024 07:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjdlv-0006PP-9f
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 07:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjdls-0005hF-KW
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 07:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724932610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pyj91Hz512ih9OptKu+6POOEbwTKtXD5wjZ9JYuko9Q=;
 b=jB4CWeFMxsuDj/ys0UiLyDWhYarGs6hqnlJxOfGDAXqirmawROV57tvvT9tBq4WChg0wrK
 FT0XZ2pG/dmv6bHLUH7jVobipTyJniuRnTes/zwHfad/lR+vTwv8FWPiwOeE4fM+6IYf0N
 uIEeeS56hx5SqSpDQ4T48bd/Ihc6j5E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-NhKLudl4OqWF7huUSJpV3A-1; Thu,
 29 Aug 2024 07:56:47 -0400
X-MC-Unique: NhKLudl4OqWF7huUSJpV3A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49CBE1954B02; Thu, 29 Aug 2024 11:56:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B043019560A3; Thu, 29 Aug 2024 11:56:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7EE0421E6A28; Thu, 29 Aug 2024 13:56:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Peter Krempa <pkrempa@redhat.com>, Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH] chardev: allow specifying finer-grained reconnect timeouts
In-Reply-To: <20240816100723.2815-1-d-tatianin@yandex-team.ru> (Daniil
 Tatianin's message of "Fri, 16 Aug 2024 13:07:23 +0300")
References: <20240816100723.2815-1-d-tatianin@yandex-team.ru>
Date: Thu, 29 Aug 2024 13:56:43 +0200
Message-ID: <87v7zjleys.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Daniil Tatianin <d-tatianin@yandex-team.ru> writes:

> The "reconnect" option only allows to specify the time in seconds,
> which is way too long for certain workflows.
>
> We have a lightweight disk backend server, which takes about 20ms to
> live update, but due to this limitation in QEMU, previously the guest
> disk controller would hang for one second because it would take this
> long for QEMU to reinitialize the socket connection.
>
> Make it possible to specify a smaller timeout by treating the value in
> "reconnect" as milliseconds via the new "reconnect-is-ms" option.
>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

Your use case demonstrates that a granularity of seconds was the wrong
choice for the reconnection delay.

[...]

> diff --git a/qapi/char.json b/qapi/char.json
> index ef58445cee..61aeccf09d 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -272,8 +272,13 @@
>  #     (default: false) (Since: 3.1)
>  #
>  # @reconnect: For a client socket, if a socket is disconnected, then
> -#     attempt a reconnect after the given number of seconds.  Setting
> -#     this to zero disables this function.  (default: 0) (Since: 2.2)
> +#     attempt a reconnect after the given number of seconds (unless
> +#     @reconnect-is-ms is set to true, in that case the number is
> +#     treated as milliseconds).  Setting this to zero disables
> +#     this function.  (default: 0) (Since: 2.2)
> +#
> +# @reconnect-is-ms: The value specified in @reconnect should be treated
> +#     as milliseconds.  (default: false) (Since: 9.2)
>  #
>  # Since: 1.4
>  ##
> @@ -287,7 +292,8 @@
>              '*telnet': 'bool',
>              '*tn3270': 'bool',
>              '*websocket': 'bool',
> -            '*reconnect': 'int' },
> +            '*reconnect': 'int',
> +            '*reconnect-is-ms': 'bool' },
>    'base': 'ChardevCommon' }
>  
>  ##

I don't like this interface.

   PRO: compatible extension; no management application updates needed
   unless they want to support sub-second delays.

   CON: specifying a sub-second delay takes two parameters, which is
   awkward.

   CON: trap in combination with -set.  Before the patch, something like
   -set chardev.ID.reconnect=N means N seconds no matter what.
   Afterwards, it depends on the value of reconnect-is-ms, which may be
   set far away.  Mitigating factor: -set is obscure.

Alternatives:

1. Change @reconnect to 'number', specify sub-second delays as
   fractions.

   PRO: compatible extension; no management application updates needed
   unless they want to support sub-second delays.

   CON: first use of floating-point for time in seconds in QAPI, as far
   as I can see.

   CON: QemuOpts can't do floating-point.

2. Deprecate @reconnect in favour of a new member with a more suitable
   unit.  Error if both are present.

   PRO: after @reconnect is gone, the interface is what it arguably
   should've been from the start.

   CON: incompatible change.  Management application updates needed
   within the deprecation grace period.

Let's get additional input from management application developers.  I
cc'ed some.

Related: NetdevSocketOptions member @reconnect.


