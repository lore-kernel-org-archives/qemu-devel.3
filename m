Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929DFC83033
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 08:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWWOC-0005sO-2l; Tue, 01 Jul 2025 04:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWWO5-0005rw-5w
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWWNx-0007mK-MT
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751358635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SJm1g+ozJ4DDYxFxHDA1HTYs3w7iLHtWg1xD7MZnffo=;
 b=BZ+tae+aFg1UwgVVcRvwqRwMyFrvEkgobZiHt9M0FABCfnfyCgxNSGx3APp8NhGwuoUD3W
 FNlMjos78ffYN9pMgyIf2CVqG/ICgk7LACIh4MTBtRM86HXvGF3JJb40p8841+OThgqlNU
 5dB0ezT8EiwXNgKlHs/MekTaVESgNiU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-oLSum4sgNQC-2VgSN9tGbw-1; Tue,
 01 Jul 2025 04:30:31 -0400
X-MC-Unique: oLSum4sgNQC-2VgSN9tGbw-1
X-Mimecast-MFC-AGG-ID: oLSum4sgNQC-2VgSN9tGbw_1751358631
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2E9A1944AAD; Tue,  1 Jul 2025 08:30:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AF82180045B; Tue,  1 Jul 2025 08:30:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BEE3A21E6A27; Tue, 01 Jul 2025 10:30:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Peter Xu
 <peterx@redhat.com>,  devel@lists.libvirt.org,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 18/24] qapi/migration: Deprecate capabilities commands
In-Reply-To: <20250630195913.28033-19-farosas@suse.de> (Fabiano Rosas's
 message of "Mon, 30 Jun 2025 16:59:07 -0300")
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-19-farosas@suse.de>
Date: Tue, 01 Jul 2025 10:30:27 +0200
Message-ID: <87bjq4z524.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> The concept of capabilities is being merged into the concept of
> parameters. From now on, the commands that handle capabilities are
> deprecated in favor of the commands that handle parameters.
>
> Affected commands:
>
> - migrate-set-capabilities
> - query-migrate-capabilities
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/about/deprecated.rst      | 12 ++++++++++++
>  migration/migration-hmp-cmds.c |  6 ++++++
>  qapi/migration.json            | 16 ++++++++++++++--
>  3 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 42037131de..15474833ea 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -605,3 +605,15 @@ command documentation for details on the ``fdset`` usage.
>  
>  The ``zero-blocks`` capability was part of the block migration which
>  doesn't exist anymore since it was removed in QEMU v9.1.
> +
> +``migrate-set-capabilities`` command (since 10.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +This command was deprecated. Use ``migrate-set-parameters`` instead
> +which now supports setting capabilities.
> +
> +``query-migrate-capabilities`` command (since 10.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +This command was deprecated. Use ``query-migrate-parameters`` instead
> +which now supports querying capabilities.

Scratch "This command was deprecated."

Could also scratch "which now supports..."  Up to you.

> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 8615340a6b..7f234d5aa8 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -229,6 +229,9 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
>  {
>      MigrationCapabilityStatusList *caps, *cap;
>  
> +    warn_report("info migrate_capabilities is deprecated;"
> +                " use info migrate_parameters instead");
> +
>      caps = qmp_query_migrate_capabilities(NULL);
>  
>      if (caps) {
> @@ -616,6 +619,9 @@ void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict)
>      MigrationCapabilityStatus *value;
>      int val;
>  
> +    warn_report("migrate_set_capability is deprecated;"
> +                " use migrate_set_parameter instead");
> +
>      val = qapi_enum_parse(&MigrationCapability_lookup, cap, -1, &err);
>      if (val < 0) {
>          goto end;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 3d3f5624c5..c5e6ea1a2d 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -521,6 +521,11 @@
>  #
>  # @capabilities: json array of capability modifications to make
>  #
> +# Features:
> +#
> +# @deprecated: This command is deprecated in favor of
> +# migrate-set-parameters.

For consistency with existing deprecation notes:

   # @deprecated: This command is deprecated.  Use migrate-set-parameters
   # instead.

> +#
>  # Since: 1.2
>  #
>  # .. qmp-example::
> @@ -530,7 +535,8 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'migrate-set-capabilities',
> -  'data': { 'capabilities': ['MigrationCapabilityStatus'] } }
> +  'data': { 'capabilities': ['MigrationCapabilityStatus'] },
> +  'features': ['deprecated'] }
>  
>  ##
>  # @query-migrate-capabilities:
> @@ -539,6 +545,11 @@
>  #
>  # Returns: @MigrationCapabilityStatus
>  #
> +# Features:
> +#
> +# @deprecated: This command is deprecated in favor of
> +# query-migrate-parameters.

Likewise.

> +#
>  # Since: 1.2
>  #
>  # .. qmp-example::
> @@ -554,7 +565,8 @@
>  #           {"state": false, "capability": "x-colo"}
>  #        ]}
>  ##
> -{ 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
> +{ 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus'],
> +  'features': ['deprecated'] }
>  
>  ##
>  # @MultiFDCompression:

With that:

Reviewed-by: Markus Armbruster <armbru@redhat.com>


