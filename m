Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E305C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 05:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Dxs-00066P-7k; Fri, 26 Apr 2024 01:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0Dxo-00063V-7J
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 01:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0Dxm-0003fr-OD
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 01:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714108653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qy+4yete2XICrArU1m/0MHLjZGbPu8E3hHFPP3ut/ZU=;
 b=YyEKPNu7VMPjF6aZZmmHglPkc/4L2AGvd/dgCNMZ3DyOeeX0BYsJm8ISJdSuj09xfesl+9
 yiL4KAUxBYsAOLjdqUXx++1ESMWWqntfVshV3SjsWqHjXoQpGISABKYOdfD66EczETOhnI
 PkN39p/Qu0xAtF5jFBTDJX5ByJS5O/M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-hW4U3tcBOmmzdxsbnRAwzQ-1; Fri, 26 Apr 2024 01:17:29 -0400
X-MC-Unique: hW4U3tcBOmmzdxsbnRAwzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D2A9811029;
 Fri, 26 Apr 2024 05:17:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1938540C6CB2;
 Fri, 26 Apr 2024 05:17:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 387E721E66E5; Fri, 26 Apr 2024 07:17:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 pbonzini@redhat.com,  qemu-devel@nongnu.org,  yc-core@yandex-team.ru
Subject: Re: [PATCH v3 4/4] qapi: introduce exit-on-error parameter for
 migrate-incoming
In-Reply-To: <20240425181551.1465739-5-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 25 Apr 2024 21:15:51 +0300")
References: <20240425181551.1465739-1-vsementsov@yandex-team.ru>
 <20240425181551.1465739-5-vsementsov@yandex-team.ru>
Date: Fri, 26 Apr 2024 07:17:28 +0200
Message-ID: <87frv81z4n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Now we do set MIGRATION_FAILED state, but don't give a chance to
> orchestrator to query migration state and get the error.
>
> Let's provide a possibility for QMP-based orchestrators to get an error
> like with outgoing migration.
>
> For hmp_migrate_incoming(), let's enable the new behavior: HMP is not
> and ABI, it's mostly intended to use by developer and it makes sense
> not to stop the process.
>
> For x-exit-preconfig, let's keep the old behavior:
>  - it's called from init(), so here we want to keep current behavior by
>    default
>  - it does exit on error by itself as well
> So, if we want to change the behavior of x-exit-preconfig, it should be
> another patch.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8c65b90328..9de8b98d0b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1837,6 +1837,10 @@
>  # @channels: list of migration stream channels with each stream in the
>  #     list connected to a destination interface endpoint.
>  #
> +# @exit-on-error: Do exit on incoming migration failure.  Default true.

Scratch "Do"?

> +#     When set to false, the error is reported by MIGRATION event and

Comma before "and", please.

Suggest "the failure triggers a MIGRATION event".

> +#     error could be retrieved by query-migrate command.  (since 9.1)

"error details could be retrieved with query-migrate", perhaps?

> +#
>  # Since: 2.3
>  #
>  # Notes:
> @@ -1889,7 +1893,8 @@
>  ##
>  { 'command': 'migrate-incoming',
>               'data': {'*uri': 'str',
> -                      '*channels': [ 'MigrationChannel' ] } }
> +                      '*channels': [ 'MigrationChannel' ],
> +                      '*exit-on-error': 'bool' } }
>  
>  ##
>  # @xen-save-devices-state:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


