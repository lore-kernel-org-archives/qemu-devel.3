Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108B5C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm4Gs-0000cW-5i; Tue, 21 Jul 2026 02:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm4Gq-0000cC-Th
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm4Go-0005md-OH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784616482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7sEib3Rfdwtze4SWl8+2bQYrmu0uVIVTSRJlmGKxsb8=;
 b=gl4o2r+qDjYjlf8CdA27tQpFhHuhng+ZGifYcrJA1BuTCHsy2R5qoiCB9w6UsBDd7rrEou
 aLn0oxV9bCM98gczYcNFiaw9F94nY4lw53YqbgPd7nMW4Cx1kvBAFNC19F2BDtUWnesCGA
 ofmoQGGWVyqAezTg4u7RI9Y0IcuEd4w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-oJfg8BTgO2SY5U7xenKH9g-1; Tue,
 21 Jul 2026 02:47:56 -0400
X-MC-Unique: oJfg8BTgO2SY5U7xenKH9g-1
X-Mimecast-MFC-AGG-ID: oJfg8BTgO2SY5U7xenKH9g_1784616475
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3F1D193E8BA; Tue, 21 Jul 2026 06:47:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F311219560AB; Tue, 21 Jul 2026 06:47:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9E70B21E6920; Tue, 21 Jul 2026 08:47:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  mark.caveayland@nutanix.com,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v19 09/15] qapi: add local migration parameter
In-Reply-To: <20260714154246.1242856-10-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 14 Jul 2026 18:42:37 +0300")
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <20260714154246.1242856-10-vsementsov@yandex-team.ru>
Date: Tue, 21 Jul 2026 08:47:51 +0200
Message-ID: <87ik68suso.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> We are going to implement local-migration feature: some devices will be
> able to transfer open file descriptors through migration stream (which
> must UNIX domain socket for that purpose).  This allows to transfer the
> whole backend state without reconnecting and restarting the backend
> service. For example, virtio-net will migrate its attached TAP netdev,
> together with its connected file descriptors.
>
> In this commit we introduce a migration parameter, which enables
> the feature for devices that support it (none at the moment).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Ben Chaney <bchaney@akamai.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 66bd900465a..813c1f76e46 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -830,7 +830,8 @@
>             'zero-page-detection',
>             'direct-io',
>             { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
> -           'cpr-exec-command'] }
> +           'cpr-exec-command',
> +           'local'] }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1012,6 +1013,15 @@
>  #     Must be set to the same value on both source and destination
>  #     before migration starts.  (Since 11.1)
>  #
> +# @local: Permit the use of optimizations for local migration.
> +#     This must only be set when both the source and destination
> +#     QEMU processes are on the same OS and directly connected

I think "on the same OS" is less than clear.  Does it mean both ends run
Linux, or both ends run Windows?  That doesn't make sense.  Recommend to
scratch it, because what matters is the UNIX domain socket.

With that, my Acked-by stands.

Ignorant question you may well have covered before: could we forgo
@local and simply use "is a UNIX domain socket"?

> +#     with a UNIX domain socket as the migration channel to enable
> +#     use of file descriptor passing.  Individual device backends
> +#     may need additional configuration flags set  to enable local
> +#     migration optimizations.  This will be documented against the
> +#     device backends where it applies.  (Since 11.2)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
> @@ -1053,7 +1063,8 @@
>              '*direct-io': 'bool',
>              '*x-rdma-chunk-size': { 'type': 'uint64',
>                                      'features': [ 'unstable' ] },
> -            '*cpr-exec-command': [ 'str' ]} }
> +            '*cpr-exec-command': [ 'str' ],
> +            '*local': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:


