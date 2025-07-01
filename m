Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBC1C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 07:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWVi4-0003I2-BX; Tue, 01 Jul 2025 03:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWVhs-0003H2-K4
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 03:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWVhp-0001pb-T2
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 03:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751356020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NDYvF+NNHFRB+AMLaC7FrAFiBgZgxHPaOPADytRba80=;
 b=X9UEXjOvUNjqyQmOxGcb13oPMpROOeE9+upg0CKXVgMGVBpyDOvsQngRncqPLjc+wOhwgM
 IA+GPI6P83q6xUt+DIh4lXKulTGaYJ8O/FgKlQlOZjCEty6erpF/deqtOBq6vsZ7Y6pfPp
 paIVMsJPFkuHFNbnSEEaiw1kL8afwPI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-CQoSnwwzMOaEZo-mUb-2tA-1; Tue,
 01 Jul 2025 03:46:59 -0400
X-MC-Unique: CQoSnwwzMOaEZo-mUb-2tA-1
X-Mimecast-MFC-AGG-ID: CQoSnwwzMOaEZo-mUb-2tA_1751356018
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 376941954215; Tue,  1 Jul 2025 07:46:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76D60180045C; Tue,  1 Jul 2025 07:46:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8D7321E6A27; Tue, 01 Jul 2025 09:46:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Peter Xu
 <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 03/24] migration: Normalize tls arguments
In-Reply-To: <20250630195913.28033-4-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 30 Jun 2025 16:58:52 -0300")
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-4-farosas@suse.de>
Date: Tue, 01 Jul 2025 09:46:54 +0200
Message-ID: <87y0t81hg1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> The migration parameters tls_creds, tls_authz and tls_hostname
> currently have a non-uniform handling. When used as arguments to
> migrate-set-parameters, their type is StrOrNull and when used as
> return value from query-migrate-parameters their type is a plain
> string.
>
> Not only having to convert between the types is cumbersome, but it
> also creates the issue of requiring two different QAPI types to be
> used, one for each command. MigrateSetParameters is used for
> migrate-set-parameters with the TLS arguments as StrOrNull while
> MigrationParameters is used for query-migrate-parameters with the TLS
> arguments as str.
>
> Since StrOrNull could be considered a superset of str, change the type
> of the TLS arguments in MigrationParameters to StrOrNull. Also ensure
> that QTYPE_QNULL is never used.
>
> 1) migrate-set-parameters will always write QTYPE_QSTRING to
>   s->parameters, either an empty or non-empty string.
>
> 2) query-migrate-parameters will always return a QTYPE_QSTRING, either
>   empty or non-empty.
>
> 3) the migrate_tls_* helpers will always return a non-empty string or
>   NULL, for the internal migration code's consumption.
>
> Points (1) and (2) above help simplify the parameters validation and
> the query command handling because s->parameters is already kept in
> the format that query-migrate-parameters (and info migrate_paramters)
> expect. Point (3) is so people don't need to care about StrOrNull in
> migration code.
>
> This will allow the type duplication to be removed in the next
> patches.
>
> Note that the type of @tls_creds, @tls-hostname, @tls-authz changes
> from str to StrOrNull in introspection of the query-migrate-parameters
> command. We accept this imprecision to enable de-duplication.
>
> There's no need to free the TLS options in
> migration_instance_finalize() because they're freed by the qdev
> properties .release method.
>
> Temporary in this patch:
> migrate_params_test_apply() copies s->parameters into a temporary
> structure, so it's necessary to drop the references to the TLS options
> if they were not set by the user to avoid double-free. This is fixed
> in the next patches.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/migration/options.c b/migration/options.c
> index 384ef9e421..f7bbdba5fc 100644
> --- a/migration/options.c
> +++ b/migration/options.c

[...]

> @@ -935,6 +951,37 @@ AnnounceParameters *migrate_announce_params(void)
>      return &ap;
>  }
>  
> +void migrate_tls_opts_free(MigrationParameters *params)
> +{
> +    qapi_free_StrOrNull(params->tls_creds);
> +    qapi_free_StrOrNull(params->tls_hostname);
> +    qapi_free_StrOrNull(params->tls_authz);
> +}
> +
> +/* either non-empty or empty string */

This isn't true, because ...

> +static void tls_opt_to_str(StrOrNull **tls_opt)
> +{
> +    StrOrNull *opt = *tls_opt;
> +
> +    if (!opt) {
> +        return;

... it can also be null.

Maybe

   /* Normalize QTYPE_QNULL to QTYPE_QSTRING "" */

> +    }
> +
> +    switch (opt->type) {
> +    case QTYPE_QSTRING:
> +        return;
> +    case QTYPE_QNULL:
> +        qobject_unref(opt->u.n);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    opt->type = QTYPE_QSTRING;
> +    opt->u.s = g_strdup("");
> +    *tls_opt = opt;
> +}

I'd prefer something like

       if (!opt || opt->type == QTYPE_QSTRING) {
           return;
       }
       qobject_unref(opt->u.n);
       opt->type = QTYPE_QSTRING;
       opt->u.s = g_strdup("");
       *tls_opt = opt;

But this is clearly a matter of taste.

> +
>  MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>  {
>      MigrationParameters *params;

[...]

> @@ -1251,18 +1294,24 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      }
>  
>      if (params->tls_creds) {
> -        assert(params->tls_creds->type == QTYPE_QSTRING);
> -        dest->tls_creds = params->tls_creds->u.s;
> +        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
> +    } else {
> +        /* drop the reference, it's owned by s->parameters */
> +        dest->tls_creds = NULL;

Suggest "clear the reference" to avoid associations with reference
counting.

>      }
>  
>      if (params->tls_hostname) {
> -        assert(params->tls_hostname->type == QTYPE_QSTRING);
> -        dest->tls_hostname = params->tls_hostname->u.s;
> +        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
> +    } else {
> +        /* drop the reference, it's owned by s->parameters */
> +        dest->tls_hostname = NULL;
>      }
>  
>      if (params->tls_authz) {
> -        assert(params->tls_authz->type == QTYPE_QSTRING);
> -        dest->tls_authz = params->tls_authz->u.s;
> +        dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
> +    } else {
> +        /* drop the reference, it's owned by s->parameters */
> +        dest->tls_authz = NULL;
>      }
>  
>      if (params->has_max_bandwidth) {

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 4963f6ca12..97bb022c45 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1293,9 +1293,9 @@
>              '*cpu-throttle-initial': 'uint8',
>              '*cpu-throttle-increment': 'uint8',
>              '*cpu-throttle-tailslow': 'bool',
> -            '*tls-creds': 'str',
> -            '*tls-hostname': 'str',
> -            '*tls-authz': 'str',
> +            '*tls-creds': 'StrOrNull',
> +            '*tls-hostname': 'StrOrNull',
> +            '*tls-authz': 'StrOrNull',
>              '*max-bandwidth': 'size',
>              '*avail-switchover-bandwidth': 'size',
>              '*downtime-limit': 'uint64',

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


