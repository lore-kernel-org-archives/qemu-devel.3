Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99243C5B559
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 09:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMNYg-0003Tj-HH; Tue, 03 Jun 2025 05:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMNYe-0003Ot-LK
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMNYc-0004Cr-PV
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748941421;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZjQBWa+JXY6WnSRLURraMFujxRJfUYnJBEfRnuogP9g=;
 b=RZaiQ3P+fiOq//1KXYmAZsPZPmClyVK/N50X3mA55L53Y+A+FRaH8mgz3Ugpe6DtjCOjXR
 xN6vPn1MKOTj17yQxXeoJjqlzOgschaRc7u1k91ZnKGXpoJcuRPikArWHLWxbr4VBnNZc/
 xpvFyghhrkN1Zeb9Q8zDwVsBSCVVmfM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-pXB-OH26MWKwsHmGombl6Q-1; Tue,
 03 Jun 2025 05:03:39 -0400
X-MC-Unique: pXB-OH26MWKwsHmGombl6Q-1
X-Mimecast-MFC-AGG-ID: pXB-OH26MWKwsHmGombl6Q_1748941418
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E530C195608F; Tue,  3 Jun 2025 09:03:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.28])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D915019560A3; Tue,  3 Jun 2025 09:03:35 +0000 (UTC)
Date: Tue, 3 Jun 2025 10:03:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aD66ZLwkKDGAVleC@redhat.com>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-20-farosas@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
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
> 'config' argument > -global cmdline > defaults (migration_properties)
> 
> I.e. the config takes precedence over all, values not present in the
> config assume the default values. The (debug) -global command line
> option allows the defaults to be overridden.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c |  5 +++--
>  migration/migration.c          | 29 ++++++++++++++++++++++++++---
>  migration/migration.h          |  1 +
>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>  migration/options.h            |  3 +++
>  qapi/migration.json            | 25 +++++++++++++++++++++++--
>  system/vl.c                    |  3 ++-
>  7 files changed, 88 insertions(+), 8 deletions(-)

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7282e4b9eb..64a92d8d28 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1474,9 +1474,16 @@
>  #
>  # @resume: resume one paused migration, default "off".  (since 3.0)
>  #
> +# @config: migration configuration options, previously set via
> +#     @migrate-set-parameters and @migrate-set-capabilities.  (since
> +#     10.1)
> +#
>  # Features:
>  #
>  # @deprecated: Argument @detach is deprecated.
> +# @config: Indicates this command can receive the entire migration
> +# configuration via the @config field, dispensing the use of
> +# @migrate-set-parameters.

There is no need to add this feature - mgmt apps can identify
this simply by the fact that the 'config' parameter now exists
in the QAPI schema.

>  #
>  # Since: 0.14
>  #
> @@ -1538,7 +1545,9 @@
>    'data': {'*uri': 'str',
>             '*channels': [ 'MigrationChannel' ],
>             '*detach': { 'type': 'bool', 'features': [ 'deprecated' ] },
> -           '*resume': 'bool' } }
> +           '*config': 'MigrationParameters',
> +           '*resume': 'bool' },
> +  'features': [ 'config' ] }
>  
>  ##
>  # @migrate-incoming:
> @@ -1557,6 +1566,16 @@
>  #     error details could be retrieved with query-migrate.
>  #     (since 9.1)
>  #
> +# @config: migration configuration options, previously set via
> +#     @migrate-set-parameters and @migrate-set-capabilities.  (since
> +#     10.1)
> +#
> +# Features:
> +#
> +# @config: Indicates this command can receive the entire migration
> +# configuration via the @config field, dispensing the use of
> +# @migrate-set-parameters.

Likewise redundant.

> +#
>  # Since: 2.3
>  #
>  # .. admonition:: Notes
> @@ -1610,7 +1629,9 @@
>  { 'command': 'migrate-incoming',
>               'data': {'*uri': 'str',
>                        '*channels': [ 'MigrationChannel' ],
> -                      '*exit-on-error': 'bool' } }
> +                      '*config': 'MigrationParameters',
> +                      '*exit-on-error': 'bool' },
> +             'features': [ 'config' ] }
>  
>  ##
>  # @xen-save-devices-state:

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


