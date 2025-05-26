Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB23C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 07:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJScY-0000hY-SX; Mon, 26 May 2025 03:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJScV-0000hO-T5
 for qemu-devel@nongnu.org; Mon, 26 May 2025 03:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJScU-0000av-8Q
 for qemu-devel@nongnu.org; Mon, 26 May 2025 03:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748245894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pK5ZsDwQQXpiW+o7H6rm2+5BPo4V87ycDVp2gU9bTeY=;
 b=AWu8RcUpPFU9vnCOOjXEUGYipviv+n2fNI1Br6qQpk4cFcF2yWeEL/AxHvv9A2XcxQuoda
 /Ssw2peXK0utCZrwOcyREbjsh28aZi52KMrlowpAWT5OchTnLEwyXoHZBQMmpIM7ZvnA0w
 iqJynzykPbCHOrTfGC1foHCDBCzs4qQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-Q1z8bDDYNbKU7EByfe8x-Q-1; Mon,
 26 May 2025 03:51:32 -0400
X-MC-Unique: Q1z8bDDYNbKU7EByfe8x-Q-1
X-Mimecast-MFC-AGG-ID: Q1z8bDDYNbKU7EByfe8x-Q_1748245892
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08C9A19560A7; Mon, 26 May 2025 07:51:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAF891800371; Mon, 26 May 2025 07:51:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F2D9821E6768; Mon, 26 May 2025 09:51:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 12/13] [PoC] migration: Add query/set commands for
 MigrationConfig
In-Reply-To: <20250411191443.22565-13-farosas@suse.de> (Fabiano Rosas's
 message of "Fri, 11 Apr 2025 16:14:42 -0300")
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-13-farosas@suse.de>
Date: Mon, 26 May 2025 09:51:28 +0200
Message-ID: <874ix7byin.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> Add the QMP commands query-migrate-config and migrate-set-config to
> read and write the migration configuration options.

These supersede query-migrate-capabilities, query-migrate-parameters,
migrate-set-capabilities, and migrate-set-parameters, right?

> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 24 ++++++++++++++++++++++++
>  migration/options.h |  2 +-
>  qapi/migration.json | 42 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 4e3792dec3..c85ee2e506 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1441,3 +1441,27 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>      migrate_config_apply(&tmp);
>      migrate_post_update_config(&tmp, errp);
>  }
> +
> +void qmp_migrate_set_config(MigrationConfig *config, Error **errp)
> +{
> +    if (!migrate_config_check(config, errp)) {
> +        /* Invalid parameter */
> +        return;
> +    }
> +
> +    migrate_config_apply(config);
> +    migrate_post_update_config(config, errp);
> +}
> +
> +MigrationConfig *qmp_query_migrate_config(Error **errp)
> +{
> +    MigrationState *s = migrate_get_current();
> +    MigrationConfig *config = g_new0(MigrationConfig, 1);
> +
> +    QAPI_CLONE_MEMBERS(MigrationConfig, config, &s->config);
> +
> +    /* set the has_* fields for every option */
> +    migrate_config_init(config);
> +
> +    return config;
> +}
> diff --git a/migration/options.h b/migration/options.h
> index 61ee854bb0..0e36dafe80 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -72,7 +72,7 @@ uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
>  
>  bool migrate_config_check(MigrationConfig *params, Error **errp);
> -void migrate_config_init(MigrationConfig *params);
> +void migrate_config_init(MigrationConfig *config);

Have you considered renaming the declaration's parameter when you change
its type in PATCH 08, or when you rename the definition's parameter in
PATCH 11?

>  bool migrate_config_get_cap_compat(MigrationConfig *config, int i);
>  bool migrate_caps_check(MigrationConfig *new, Error **errp);
>  #endif
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5e39f21adc..bb2487dbc6 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -2552,3 +2552,45 @@
>    'data': { '*tls-creds': 'str',
>              '*tls-hostname': 'str',
>              '*tls-authz': 'str' } }
> +
> +##
> +# @query-migrate-config:
> +#
> +# Returns information about the current migration configuration
> +# options
> +#
> +# Returns: @MigrationConfig
> +#
> +# Since: 10.1
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "query-migrate-config" }
> +#     <- { "return": {
> +#              "multifd-channels": 2,
> +#              "cpu-throttle-increment": 10,
> +#              "cpu-throttle-initial": 20,
> +#              "max-bandwidth": 33554432,
> +#              "downtime-limit": 300
> +#           }
> +#        }
> +##
> +{ 'command': 'query-migrate-config',
> +  'returns': 'MigrationConfig' }
> +
> +##
> +# @migrate-set-config:
> +#
> +# Set various migration configuration options.
> +#
> +# Since: 10.1
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "migrate-set-config" ,
> +#          "arguments": { "max-bandwidth": 33554432,
> +#                         "downtime-limit": 300 } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'migrate-set-config', 'boxed': true,
> +  'data': 'MigrationConfig' }

This patch exposes MigrationConfig externally.  We should double-check
its documentation to make sure it's what we want there.  Known issue:
how to reset @tls-creds & friends.  Touched in my review of PATCH 07.


