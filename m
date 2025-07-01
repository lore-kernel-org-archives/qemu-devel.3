Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E06C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 08:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWWTP-0007Q6-OJ; Tue, 01 Jul 2025 04:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWWTL-0007Pg-Re
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWWTG-0004GL-7u
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751358963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAbQ3nl6C/DNCrbMQH2fXecxzabiBsPun2flvWWZbcE=;
 b=Lash3ckajH+W1d+OrhRNFLeFUE4McN3QRCDyC07SbHQmdlJFG/PKqvasYmGZYsxgyImwU9
 3ggbFdGrQVGXi2kSVxa07opiGzLaORFNQ8gONvU20DSTI77A/kgfhicl+dZDbE3eIf1bPD
 KjLgxVufJnynVbtn3bQRl5RxA6/Q4h0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-uMO2vraAMyWaEAwBGvIFOQ-1; Tue,
 01 Jul 2025 04:36:02 -0400
X-MC-Unique: uMO2vraAMyWaEAwBGvIFOQ-1
X-Mimecast-MFC-AGG-ID: uMO2vraAMyWaEAwBGvIFOQ_1751358961
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D9DA180120D; Tue,  1 Jul 2025 08:36:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E70219560AB; Tue,  1 Jul 2025 08:36:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7499E21E6A27; Tue, 01 Jul 2025 10:35:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  armbru@redhat.com,  Peter
 Xu <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 20/24] migration: Allow migrate commands to provide
 the migration config
In-Reply-To: <20250630195913.28033-21-farosas@suse.de> (Fabiano Rosas's
 message of "Mon, 30 Jun 2025 16:59:09 -0300")
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-21-farosas@suse.de>
Date: Tue, 01 Jul 2025 10:35:58 +0200
Message-ID: <87zfdoxq8h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> Allow the migrate and migrate_incoming commands to pass the migration
> configuration options all at once, dispensing the use of
> migrate-set-parameters and migrate-set-capabilities.
>
> The motivation of this is to simplify the interface with the
> management layer and avoid the usage of several command invocations to
> configure a migration. It also avoids stale parameters from a previous
> migration to influence the current migration.
>
> The options that are changed during the migration can still be set
> with the existing commands.
>
> The order of precedence is:
>
> 'config' argument > -global migration cmdline > migrate-set-parameters
> > defaults (migration_properties)
>
> I.e. the config takes precedence over all, values not present in the
> config assume the default values. The -global migration command line
> option allows the defaults to be overridden for debug.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index c5e6ea1a2d..11b7d7ebec 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1456,6 +1456,13 @@
>  #
>  # @resume: resume one paused migration, default "off".  (since 3.0)
>  #
> +# @config: migration configuration options, previously set via
> +#     @migrate-set-parameters and @migrate-set-capabilities.  Setting
> +#     this argument causes all migration configuration options
> +#     previously set via @migrate-set-parameters to be ignored.
> +#     Configuration options not set will assume their default
> +#     values. (since 10.1)
> +#

Recommend

  # @config: migration configuration options.  When present, any
  #     migration configuration previously set with
  #     @migrate-set-parameters is ignored.  (since 10.1)

I could be persuaded to keep the sentence on defaults.

>  # Features:
>  #
>  # @deprecated: Argument @detach is deprecated.
> @@ -1520,6 +1527,7 @@
>    'data': {'*uri': 'str',
>             '*channels': [ 'MigrationChannel' ],
>             '*detach': { 'type': 'bool', 'features': [ 'deprecated' ] },
> +           '*config': 'MigrationParameters',
>             '*resume': 'bool' } }
>  
>  ##
> @@ -1539,6 +1547,13 @@
>  #     error details could be retrieved with query-migrate.
>  #     (since 9.1)
>  #
> +# @config: migration configuration options, previously set via
> +#     @migrate-set-parameters and @migrate-set-capabilities.  Setting
> +#     this argument causes all migration configuration options
> +#     previously set via @migrate-set-parameters to be ignored.
> +#     Configuration options not set will assume their default
> +#     values. (since 10.1)

Likewise.

> +#
>  # Since: 2.3
>  #
>  # .. admonition:: Notes
> @@ -1592,6 +1607,7 @@
>  { 'command': 'migrate-incoming',
>               'data': {'*uri': 'str',
>                        '*channels': [ 'MigrationChannel' ],
> +                      '*config': 'MigrationParameters',
>                        '*exit-on-error': 'bool' } }
>  
>  ##

[...]


