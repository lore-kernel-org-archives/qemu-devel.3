Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC53C35FE7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 05:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqncp-0001b3-P3; Wed, 18 Sep 2024 01:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sqncj-0001aJ-F0
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 01:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sqnch-0007RX-KF
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 01:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726638785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLVcFukP+8C7+eH6+pYs8KIsjxL0ER+1dAge8Ca5G+c=;
 b=DZpPRI1pd5xCDieL6wcm0zFXhpEQ9PwgxCd1IAv/V3V8o99giH5zB8d7u+61CTqmHMze84
 RoMQtUiSTqESgccYMpJsoIljCVmOBsOg6xBu8rzDAw2rnAS5n9KQhUcLheMOSKFEMVX2da
 hCunNhyTvKDvW95vXV9gJ74mqHcFwcA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-6muknBUjO_iGNn1zY45Isg-1; Wed,
 18 Sep 2024 01:53:01 -0400
X-MC-Unique: 6muknBUjO_iGNn1zY45Isg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2359D195608B; Wed, 18 Sep 2024 05:53:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F4783001FEF; Wed, 18 Sep 2024 05:52:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C9C2F21E6A28; Wed, 18 Sep 2024 07:52:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: dave@treblig.org
Cc: peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 armbru@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] migration: Remove unused zero-blocks capability
In-Reply-To: <20240918000207.182683-3-dave@treblig.org> (dave@treblig.org's
 message of "Wed, 18 Sep 2024 01:02:06 +0100")
References: <20240918000207.182683-1-dave@treblig.org>
 <20240918000207.182683-3-dave@treblig.org>
Date: Wed, 18 Sep 2024 07:52:56 +0200
Message-ID: <87msk54ifb.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

dave@treblig.org writes:

> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> migrate_zero_blocks is unused since
>   eef0bae3a7 ("migration: Remove block migration")
>
> Remove it.
> That whole zero-blocks capability was just for old-school
> block migration anyway.
>
> Remove the capability as well.
>
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>  migration/options.c |  8 --------
>  migration/options.h |  1 -
>  qapi/migration.json | 10 +---------
>  3 files changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 9460c5dee9..997e060612 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -177,7 +177,6 @@ Property migration_properties[] = {
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
>      DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
>      DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
> -    DEFINE_PROP_MIG_CAP("x-zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCKS),
>      DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
>      DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
>      DEFINE_PROP_MIG_CAP("x-postcopy-preempt",

Property of (pseudo-)device "migration".  The "x-" prefix suggests we
expect management software not to rely on it.  Okay.

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index b66cccf107..82d0fc962e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -389,13 +389,6 @@
>  #     footprint is mlock()'d on demand or all at once.  Refer to
>  #     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
>  #
> -# @zero-blocks: During storage migration encode blocks of zeroes
> -#     efficiently.  This essentially saves 1MB of zeroes per block on
> -#     the wire.  Enabling requires source and target VM to support
> -#     this feature.  To enable it is sufficient to enable the
> -#     capability on the source VM.  The feature is disabled by
> -#     default.  (since 1.6)
> -#
>  # @events: generate events for each migration state change (since 2.4)
>  #
>  # @auto-converge: If enabled, QEMU will automatically throttle down
> @@ -483,7 +476,7 @@
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
> -  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> +  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
>             'events', 'postcopy-ram',
>             { 'name': 'x-colo', 'features': [ 'unstable' ] },
>             'release-ram',

This is used by migrate-set-capabilities and query-migrate-capabilities,
via ['MigrationCapabilityStatus'].

query-migrate-capabilities is unaffected: it couldn't return zero-blocks
anymore even before the patch.

migrate-set-capabilities changes incompatibly, I'm afraid.  Before the
patch:

    {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"capability": "zero-blocks", "state": true}]}}
    {"return": {}}

Afterwards:

    {"error": {"class": "GenericError", "desc": "Parameter 'capability' does not accept value 'zero-blocks'"}}

If we had somehow rejected the capability when it made no sense,
removing it now it never makes sense would be obviously fine.

The straight & narrow path is to deprecate now, remove later.

If we believe nothing relies on it, we can bend the rules and remove
right away.  Missing then: update to docs/about/removed-features.rst.

> @@ -542,7 +535,6 @@
>  #           {"state": false, "capability": "xbzrle"},
>  #           {"state": false, "capability": "rdma-pin-all"},
>  #           {"state": false, "capability": "auto-converge"},
> -#           {"state": false, "capability": "zero-blocks"},
>  #           {"state": true, "capability": "events"},
>  #           {"state": false, "capability": "postcopy-ram"},
>  #           {"state": false, "capability": "x-colo"}

Example for query-migrate-capabilities.  Good.


