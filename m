Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F31CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 06:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwEKS-0007D1-Fs; Wed, 10 Sep 2025 02:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwEKP-0007Ce-S0
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 02:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwEKM-0008L2-Pe
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 02:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757485744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaaDbe8xqNhNuMzw41h5tkVRqHjXo6eDI5H6O8wOG1U=;
 b=IUdVqnrDj6Po7LSWwfKIUUwz1ebytiRMtT1zJAcLX4JnNsrd2XowsiY/pyi5F9oqwsmzm/
 no29jBuazHkqL7Jwon0VuFW0RsvMUi6Wm7FRPheRPBwUO7lCGvxWnMzfjosv2SIhU9uGlM
 7qxc7tPUnYhE8Uabk/Ba2J3kIigRqmE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-3u_zXC9BNiObpl3MvjPjiA-1; Wed,
 10 Sep 2025 02:29:00 -0400
X-MC-Unique: 3u_zXC9BNiObpl3MvjPjiA-1
X-Mimecast-MFC-AGG-ID: 3u_zXC9BNiObpl3MvjPjiA_1757485739
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2F321800366; Wed, 10 Sep 2025 06:28:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED55230001B5; Wed, 10 Sep 2025 06:28:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7915A21E6A27; Wed, 10 Sep 2025 08:28:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  qemu-devel@nongnu.org,  leiyang@redhat.com,
 steven.sistare@oracle.com,  yc-core@yandex-team.ru,  peterx@redhat.com,
 mst@redhat.com,  farosas@suse.de,  eblake@redhat.com,  thuth@redhat.com,
 philmd@linaro.org,  berrange@redhat.com
Subject: Re: [PATCH v2 4/8] qapi: add interface for local TAP migration
In-Reply-To: <20250903133706.1177633-5-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 3 Sep 2025 16:37:01 +0300")
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
 <20250903133706.1177633-5-vsementsov@yandex-team.ru>
Date: Wed, 10 Sep 2025 08:28:55 +0200
Message-ID: <87ikhqrfbs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> To migrate TAP device (including open fds) locally, user should:
>
> 1. enable local-tap migration capability both on source and target
> 2. use additional local-incoming=true option for tap on target
>
> Why capability is not enough? We need an option to modify early
> initialization of TAP, to avoid opening new fds. The capability
> may not be set at the moment of netdev initialization.

Bummer.  No way around that?

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 2387c21e9c..992a5b1e2b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -517,6 +517,12 @@
>  #     each RAM page.  Requires a migration URI that supports seeking,
>  #     such as a file.  (since 9.0)
>  #
> +# @local-tap: Migrate TAPs locally, keeping backend alive. Open file
> +#     descriptors and TAP-related state are migrated. Only may be
> +#     used when migration channel is unix socket. For target device
> +#     also @local-incoming option must be specified (since 10.2)
> +#     (since 10.2)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.

Missing here: local-tap is also experimental.

> @@ -536,7 +542,8 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit', 'mapped-ram'] }
> +           'dirty-limit', 'mapped-ram',
> +           { 'name': 'local-tap', 'features': [ 'unstable' ] } ] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> diff --git a/qapi/net.json b/qapi/net.json
> index 78bcc9871e..8f53549d58 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -353,6 +353,15 @@
>  # @poll-us: maximum number of microseconds that could be spent on busy
>  #     polling for tap (since 2.7)
>  #
> +# @local-incoming: Do load open file descriptor for that TAP
> +#     on incoming migration. May be used only if QEMU is started
> +#     for incoming migration. Will work only together with local-tap
> +#     migration capability enabled (default: false) (Since: 10.2)

Scratch "Do".

Re "Maybe be used only": what happens when you use it without incoming
migration or when local-tap is off?

Does "local-incoming": false count as invalid use then?

Two spaces between sentences for consistency, please.

> +#
> +# Features:
> +#
> +# @unstable: Member @local-incoming is experimental

Period at the end for consistency, please.

> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevTapOptions',
> @@ -371,7 +380,8 @@
>      '*vhostfds':   'str',
>      '*vhostforce': 'bool',
>      '*queues':     'uint32',
> -    '*poll-us':    'uint32'} }
> +    '*poll-us':    'uint32',
> +    '*local-incoming': { 'type': 'bool', 'features': [ 'unstable' ] } } }
>  
>  ##
>  # @NetdevSocketOptions:


