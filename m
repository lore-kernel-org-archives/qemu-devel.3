Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF3EC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJSob-0003O6-CX; Mon, 26 May 2025 04:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJSoZ-0003Ni-Ht
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJSoW-0001wf-TG
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748246642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kV/rAWErUWU4xF7lU2bWCWhPZLn88TaMNTLjHROPZg0=;
 b=SvFTJj2/kF2Jkocb3RAUSUKn6sNb9L9QdsF5J3fRvmjx90ecHiJFqCjYANyIlXoqwM1ZIq
 I89EQ4UaCk7wTS5egLrajXiJ+ylQESc6Kvy6Uyc9wCqDE5M7mgoB6xmqz4cplG9BxKBWnA
 BepyTNX1idj9h2iA0+OgoeswIUdCDFg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-BNRq_qakNem4EKumMmTVyQ-1; Mon,
 26 May 2025 04:04:00 -0400
X-MC-Unique: BNRq_qakNem4EKumMmTVyQ-1
X-Mimecast-MFC-AGG-ID: BNRq_qakNem4EKumMmTVyQ_1748246639
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AFEE180087F; Mon, 26 May 2025 08:03:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA6761800359; Mon, 26 May 2025 08:03:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F177021E675E; Mon, 26 May 2025 10:03:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 13/13] [PoC] migration: Allow migrate commands to
 provide the migration config
In-Reply-To: <20250411191443.22565-14-farosas@suse.de> (Fabiano Rosas's
 message of "Fri, 11 Apr 2025 16:14:43 -0300")
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-14-farosas@suse.de>
Date: Mon, 26 May 2025 10:03:55 +0200
Message-ID: <87tt57ajdg.fsf@pond.sub.org>
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
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c |  5 +++--
>  migration/migration.c          |  8 ++++----
>  qapi/migration.json            | 10 ++++++++++
>  system/vl.c                    |  3 ++-
>  4 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 49c26daed3..44d2265002 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -429,7 +429,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> -    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
> +    qmp_migrate_incoming(NULL, true, caps, NULL, true, false, &err);
>      qapi_free_MigrationChannelList(caps);
>  
>  end:
> @@ -715,7 +715,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> -    qmp_migrate(NULL, true, caps, false, false, true, resume, &err);
> +    qmp_migrate(NULL, true, caps, NULL, false, false, true, resume,
> +                &err);
>      if (hmp_handle_error(mon, err)) {
>          return;
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index 55d839abd0..a1f04cef32 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1894,8 +1894,8 @@ void migrate_del_blocker(Error **reasonp)
>  
>  void qmp_migrate_incoming(const char *uri, bool has_channels,
>                            MigrationChannelList *channels,
> -                          bool has_exit_on_error, bool exit_on_error,
> -                          Error **errp)
> +                          MigrationConfig *config, bool has_exit_on_error,
> +                          bool exit_on_error, Error **errp)
>  {
>      Error *local_err = NULL;
>      static bool once = true;
> @@ -2159,8 +2159,8 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
>      return G_SOURCE_REMOVE;
>  }
>  
> -void qmp_migrate(const char *uri, bool has_channels,
> -                 MigrationChannelList *channels, bool has_detach, bool detach,
> +void qmp_migrate(const char *uri, bool has_channels, MigrationChannelList *channels,
> +                 MigrationConfig *config, bool has_detach, bool detach,
>                   bool has_resume, bool resume, Error **errp)
>  {
>      bool resume_requested;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index bb2487dbc6..5bd8f0f1b2 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1638,6 +1638,10 @@
   ##
   # @migrate:
   #
   # Migrates the current running guest to another Virtual Machine.
   #
   # @uri: the Uniform Resource Identifier of the destination VM
   #
   # @channels: list of migration stream channels with each stream in the
   #     list connected to a destination interface endpoint.
   #
   # @detach: this argument exists only for compatibility reasons and is
   #     ignored by QEMU
>  #
>  # @resume: resume one paused migration, default "off".  (since 3.0)

Unrelated to this patch, but here goes anyway.  What happens if I pass
@uri and @channels with I "resume": true, and they differ from the ones
passed originally?

>  #
> +# @config: migration configuration options, previously set via
> +#     @migrate-set-parameters and @migrate-set-capabilities.  (since
> +#     10.1)
> +#
>  # Since: 0.14
>  #
>  # .. admonition:: Notes
> @@ -1702,6 +1706,7 @@
>  { 'command': 'migrate',
>    'data': {'*uri': 'str',
>             '*channels': [ 'MigrationChannel' ],
> +           '*config': 'MigrationConfig',
>             '*detach': 'bool', '*resume': 'bool' } }
>  

Some configuration is passed in individual arguments, the remainder
wrapped in a struct.

Here's how we could avoid this.  'data': 'MigrateArguments' where
MigrateArguments is a struct with base MigrationConfig that adds the
other arguments.  Add 'boxed': true if you like.

Not sure it's wortwhile, but I wanted to show you for your
consideration.

>  ##
> @@ -1721,6 +1726,10 @@
>  #     error details could be retrieved with query-migrate.
>  #     (since 9.1)
>  #
> +# @config: migration configuration options, previously set via
> +#     @migrate-set-parameters and @migrate-set-capabilities.  (since
> +#     10.1)
> +#
>  # Since: 2.3
>  #
>  # .. admonition:: Notes
> @@ -1774,6 +1783,7 @@
>  { 'command': 'migrate-incoming',
>               'data': {'*uri': 'str',
>                        '*channels': [ 'MigrationChannel' ],
> +                      '*config': 'MigrationConfig',
>                        '*exit-on-error': 'bool' } }
>  
>  ##

Likewise.

> diff --git a/system/vl.c b/system/vl.c
> index ec93988a03..ea7040ef8d 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2826,7 +2826,8 @@ void qmp_x_exit_preconfig(Error **errp)
>                  g_new0(MigrationChannelList, 1);
>  
>              channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
> -            qmp_migrate_incoming(NULL, true, channels, true, true, &local_err);
> +            qmp_migrate_incoming(NULL, true, channels, NULL, true, true,
> +                                 &local_err);
>              if (local_err) {
>                  error_reportf_err(local_err, "-incoming %s: ", incoming);
>                  exit(1);


