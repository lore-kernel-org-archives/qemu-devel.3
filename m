Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E87C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 05:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0E8I-0000hv-PH; Fri, 26 Apr 2024 01:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0E8B-0000hd-BM
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 01:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0E89-0007pi-48
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 01:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714109296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xCsyPeTUAm9Kzmea7hrUM3dFCubvF3oTah39TvsloEc=;
 b=V/3cTHTegHCnpusp4kYukxS4K7UTyz1K+rR5RpjPthVhcnMiqpWWSXvDLVBONSI1s6fCdA
 Ur1wyt6enuzZ/bnkDUJcQp+WSRM241/dWxNKxcbSTUb0n8PK8OQzdwlKluAReRSlfI4z6L
 gu+RDDqNcuOW49VmUDP7PGrDnqNTjqE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-qpnrnhDtNv-wn43u4dF9rQ-1; Fri, 26 Apr 2024 01:26:12 -0400
X-MC-Unique: qpnrnhDtNv-wn43u4dF9rQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8434C1005D5C;
 Fri, 26 Apr 2024 05:26:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B15040C6DAE;
 Fri, 26 Apr 2024 05:26:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6DFEF21E6680; Fri, 26 Apr 2024 07:26:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,  devel@lists.libvirt.org,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 1/6] migration: Remove 'skipped' field from MigrationStats
In-Reply-To: <20240425150939.19268-2-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 25 Apr 2024 12:09:34 -0300")
References: <20240425150939.19268-1-farosas@suse.de>
 <20240425150939.19268-2-farosas@suse.de>
Date: Fri, 26 Apr 2024 07:26:11 +0200
Message-ID: <87a5lg1yq4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> The 'skipped' field of the MigrationStats struct has been deprecated
> in 8.1. Time to remove it.
>
> Deprecation commit 7b24d32634 ("migration: skipped field is really
> obsolete.").
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/about/deprecated.rst       | 6 ------
>  docs/about/removed-features.rst | 6 ++++++
>  migration/migration-hmp-cmds.c  | 2 --
>  migration/migration.c           | 2 --
>  qapi/migration.json             | 8 --------
>  5 files changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b548519b5..4d9d6bf2da 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -488,12 +488,6 @@ option).
>  Migration
>  ---------
>  
> -``skipped`` MigrationStats field (since 8.1)
> -''''''''''''''''''''''''''''''''''''''''''''
> -
> -``skipped`` field in Migration stats has been deprecated.  It hasn't
> -been used for more than 10 years.
> -
>  ``inc`` migrate command option (since 8.2)
>  ''''''''''''''''''''''''''''''''''''''''''
>  
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index f9cf874f7b..9873f59bee 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -614,6 +614,12 @@ was superseded by ``sections``.
>  Member ``section-size`` in the return value of ``query-sgx-capabilities``
>  was superseded by ``sections``.
>  
> +``query-migrate`` return value member ``skipped`` (removed in 9.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Member ``skipped`` of the ``MigrationStats`` struct hasn't been used
> +for more than 10 years. Removed with no replacement.
> +
>  Human Monitor Protocol (HMP) commands
>  -------------------------------------
>  
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7e96ae6ffd..28f776d06d 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -105,8 +105,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>                         info->ram->total >> 10);
>          monitor_printf(mon, "duplicate: %" PRIu64 " pages\n",
>                         info->ram->duplicate);
> -        monitor_printf(mon, "skipped: %" PRIu64 " pages\n",
> -                       info->ram->skipped);
>          monitor_printf(mon, "normal: %" PRIu64 " pages\n",
>                         info->ram->normal);
>          monitor_printf(mon, "normal bytes: %" PRIu64 " kbytes\n",
> diff --git a/migration/migration.c b/migration/migration.c
> index 696762bc64..3b433fdb31 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1149,8 +1149,6 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      info->ram->transferred = migration_transferred_bytes();
>      info->ram->total = ram_bytes_total();
>      info->ram->duplicate = stat64_get(&mig_stats.zero_pages);
> -    /* legacy value.  It is not used anymore */
> -    info->ram->skipped = 0;
>      info->ram->normal = stat64_get(&mig_stats.normal_pages);
>      info->ram->normal_bytes = info->ram->normal * page_size;
>      info->ram->mbps = s->mbps;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8c65b90328..401b8e24ac 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -23,9 +23,6 @@
>  #
>  # @duplicate: number of duplicate (zero) pages (since 1.2)
>  #
> -# @skipped: number of skipped zero pages.  Always zero, only provided
> -#     for compatibility (since 1.5)
> -#
>  # @normal: number of normal pages (since 1.2)
>  #
>  # @normal-bytes: number of normal bytes sent (since 1.2)
> @@ -63,16 +60,11 @@
>  #     between 0 and @dirty-sync-count * @multifd-channels.  (since
>  #     7.1)
>  #
> -# Features:
> -#
> -# @deprecated: Member @skipped is always zero since 1.5.3
> -#
>  # Since: 0.14
>  ##
>  { 'struct': 'MigrationStats',
>    'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
>             'duplicate': 'int',
> -           'skipped': { 'type': 'int', 'features': [ 'deprecated' ] },
>             'normal': 'int',
>             'normal-bytes': 'int', 'dirty-pages-rate': 'int',
>             'mbps': 'number', 'dirty-sync-count': 'int',

Reviewed-by: Markus Armbruster <armbru@redhat.com>


