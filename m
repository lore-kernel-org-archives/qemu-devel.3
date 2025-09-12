Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBECCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux5Ck-0004hd-DK; Fri, 12 Sep 2025 10:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux5Ci-0004h7-Nd
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux5Cf-0000VI-Eh
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757689003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GfPRBt3T7f76dO09EiMxEfCXHZlIzdu/X1ZCVRk/5Ic=;
 b=MB0kNkIf5+WC1LvNqGJlbgmKSHr2qBNzDsnNCZq6HcYEBVe5qm5h0G1dcTeyLaGyh6wnO3
 PqRjbAPItqX/X8AeRcBIoTC6H/0SjWU1lcidqgsrUQ9Y4jBuDr4DPlrDGlMGZa5RXA1And
 kwz0iNUQZOY0Ttvdaswi1PvG+XHzm2c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207--ihtulM0NKuoFaZWNZHz3A-1; Fri,
 12 Sep 2025 10:56:42 -0400
X-MC-Unique: -ihtulM0NKuoFaZWNZHz3A-1
X-Mimecast-MFC-AGG-ID: -ihtulM0NKuoFaZWNZHz3A_1757689000
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C7AB1800293; Fri, 12 Sep 2025 14:56:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E16119560BE; Fri, 12 Sep 2025 14:56:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 853CC21E6A27; Fri, 12 Sep 2025 16:56:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  peterx@redhat.com,  farosas@suse.de,
 raphael@enfabrica.net,  sgarzare@redhat.com,
 marcandre.lureau@redhat.com,  pbonzini@redhat.com,  kwolf@redhat.com,
 hreitz@redhat.com,  berrange@redhat.com,  eblake@redhat.com,
 qemu-devel@nongnu.org,  qemu-block@nongnu.org,
 steven.sistare@oracle.com,  den-plotnikov@yandex-team.ru,  Laurent Vivier
 <lvivier@redhat.com>
Subject: Re: [PATCH 24/33] chardev-add: support local migration
In-Reply-To: <20250813164856.950363-25-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 13 Aug 2025 19:48:45 +0300")
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-25-vsementsov@yandex-team.ru>
Date: Fri, 12 Sep 2025 16:56:36 +0200
Message-ID: <87wm634t3v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> This commit introduces a possibility to migrate open chardev
> socket fd through migration channel without reconnecting.
>
> For this, user should:
>  - enable new migration capability local-char-socket
>  - mark the socket by an option support-local-migration=true
>  - on target add local-incoming=true option to the socket
>
> Motivation for the API:
>
> 1. We don't want to migrate all sockets. For example, QMP-connection is
>    bad candidate, as it is separate on source and target. So, we need
>    @support-local-migration option to mark sockets, which we want to
>    migrate (after this series, we'll want to migrate chardev used to
>    connect with vhost-user-server).
>
> 2. Still, for remote migration, we can't migrate any sockets, so, we
>    need a capability, to enable/disable the whole feature.
>
> 3. And finally, we need a sign for the socket to not open a connection
>    on initialization, but wait for incoming migration. We can't use
>    @support-local-migration option for it, as it may be enabled, but we
>    are in incoming-remote migration. Also, we can't rely on the
>    migration capability, as user is free to setup capabilities before or
>    after chardev creation, and it would be a bad precedent to create
>    relations here.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

> diff --git a/qapi/char.json b/qapi/char.json
> index f0a53f742c..5b535c196a 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -280,11 +280,23 @@
>  #     mutually exclusive with @reconnect.
>  #     (default: 0) (Since: 9.2)
>  #
> +# @support-local-migration: The socket open file descriptor will
> +#     migrate if this field is true and local-char-socket migration
> +#     capability enabled (default: false) (Since: 10.2)
> +#
> +# @local-incoming: Do load open file descriptor for the socket
> +#     on incoming migration. May be used only if QEMU is started
> +#     for incoming migration and only together with local-char-socket
> +#     migration capability (default: false) (Since: 10.2)
> +#
>  # Features:
>  #
>  # @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
>  #     instead.
>  #
> +# @unstable: Members @support-local-migration and @local-incoming
> +#            are experimental
> +#
>  # Since: 1.4
>  ##
>  { 'struct': 'ChardevSocket',
> @@ -298,7 +310,9 @@
>              '*tn3270': 'bool',
>              '*websocket': 'bool',
>              '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
> -            '*reconnect-ms': 'int' },
> +            '*reconnect-ms': 'int',
> +            '*support-local-migration': { 'type': 'bool', 'features': [ 'unstable' ] },
> +            '*local-incoming': { 'type': 'bool', 'features': [ 'unstable' ] } },
>    'base': 'ChardevCommon' }
>  
>  ##
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 2387c21e9c..4f282d168e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -517,6 +517,11 @@
>  #     each RAM page.  Requires a migration URI that supports seeking,
>  #     such as a file.  (since 9.0)
>  #
> +# @local-char-socket: Migrate socket chardevs open file descriptors.
> +#     Only may be used when migration channel is unix socket. Only
> +#     involves socket chardevs with "support-local-migration" option
> +#     enabled.  (since 10.2)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -536,7 +541,8 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit', 'mapped-ram'] }
> +           'dirty-limit', 'mapped-ram',
> +           { 'name': 'local-char-socket', 'features': [ 'unstable' ] } ] }
>  
>  ##
>  # @MigrationCapabilityStatus:

I understand why we need a knob to enable the feature.  A
MigrationCapability looks fine to me.  We could perhaps come up with a
better name, but let's leave that for later.

I'm unsure about making users mark the sockets (really: the sockets
wrapped in a character device backend) to be migrated that way.

Which sockets are users supposed to mark, and how would they know?

What happens when a user marks the QMP socket?  You called that a "bad
candidate".

Doesn't feel like good user interface design.

Could QEMU decide (in principle) which sockets are suitable for
sending down the migration channel?

If yes, could we make it do the right thing automatically?  Or at least
a check that stops the user from doing the wrong thing?

[...]


