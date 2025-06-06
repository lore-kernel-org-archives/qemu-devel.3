Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86033C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 20:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNdbA-0001t8-Ms; Fri, 06 Jun 2025 16:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uNdb8-0001rm-HR
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:23:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uNdb4-0003jt-JX
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:23:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6AB0C1F74A;
 Fri,  6 Jun 2025 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749241402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHrjID2615U59FjIzVY58QjfhhglPirPKhYUnszAesI=;
 b=kWmgj/hzdMCLrz9oFUVeIk3qAd525mzboyCGI5ISzMWSj2knEYUKMxhAz4ZtL/ww1j6Zf6
 V0OcBWF/Cw4Cz7O28SRhsK0E8W05OVoMqewkViLtRBAaeswaLXaiiivP/vkI9ZqvfqjDHK
 MNBuCvfjIUb391NV88dpcvKxCj3kuyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749241402;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHrjID2615U59FjIzVY58QjfhhglPirPKhYUnszAesI=;
 b=gGN90Tw09c4gI6JJqDc/ByPY9JxCjcqXlEOLK5SwILXv2uxxUlQZ7Xn49sT8rSTSuB0d4q
 7Fn4xhc6MzVxPsBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="kWmgj/hz";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gGN90Tw0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749241402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHrjID2615U59FjIzVY58QjfhhglPirPKhYUnszAesI=;
 b=kWmgj/hzdMCLrz9oFUVeIk3qAd525mzboyCGI5ISzMWSj2knEYUKMxhAz4ZtL/ww1j6Zf6
 V0OcBWF/Cw4Cz7O28SRhsK0E8W05OVoMqewkViLtRBAaeswaLXaiiivP/vkI9ZqvfqjDHK
 MNBuCvfjIUb391NV88dpcvKxCj3kuyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749241402;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHrjID2615U59FjIzVY58QjfhhglPirPKhYUnszAesI=;
 b=gGN90Tw09c4gI6JJqDc/ByPY9JxCjcqXlEOLK5SwILXv2uxxUlQZ7Xn49sT8rSTSuB0d4q
 7Fn4xhc6MzVxPsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF1A91369F;
 Fri,  6 Jun 2025 20:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sDCTIjlOQ2gtfwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Jun 2025 20:23:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
In-Reply-To: <aENBda_y3v3y4ptS@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de> <aENBda_y3v3y4ptS@x1.local>
Date: Fri, 06 Jun 2025 17:23:18 -0300
Message-ID: <874iwswrex.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 6AB0C1F74A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
>> Allow the migrate and migrate_incoming commands to pass the migration
>> configuration options all at once, dispensing the use of
>> migrate-set-parameters and migrate-set-capabilities.
>> 
>> The motivation of this is to simplify the interface with the
>> management layer and avoid the usage of several command invocations to
>> configure a migration. It also avoids stale parameters from a previous
>> migration to influence the current migration.
>> 
>> The options that are changed during the migration can still be set
>> with the existing commands.
>> 
>> The order of precedence is:
>> 
>> 'config' argument > -global cmdline > defaults (migration_properties)
>
> Could we still keep the QMP migrate-set-parameters values?
>
>   'config' argument > QMP setups using migrate-set-parameters >
>     -global cmdline > defaults (migration_properties)
>

That's the case. I failed to mention it in the commit message. IOW it
behaves just like today, but the new 'config' way takes precedence over
all.

> I asked this before, maybe I forgot the answer..
>
>> 
>> I.e. the config takes precedence over all, values not present in the
>> config assume the default values. The (debug) -global command line
>> option allows the defaults to be overridden.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration-hmp-cmds.c |  5 +++--
>>  migration/migration.c          | 29 ++++++++++++++++++++++++++---
>>  migration/migration.h          |  1 +
>>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>>  migration/options.h            |  3 +++
>>  qapi/migration.json            | 25 +++++++++++++++++++++++--
>>  system/vl.c                    |  3 ++-
>>  7 files changed, 88 insertions(+), 8 deletions(-)
>> 
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index a8c3515e9d..38b289e8d8 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -575,7 +575,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>>      }
>>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>>  
>> -    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
>> +    qmp_migrate_incoming(NULL, true, caps, NULL, true, false, &err);
>>      qapi_free_MigrationChannelList(caps);
>>  
>>  end:
>> @@ -952,7 +952,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>      }
>>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>>  
>> -    qmp_migrate(NULL, true, caps, false, false, true, resume, &err);
>> +    qmp_migrate(NULL, true, caps, NULL, false, false, true, resume,
>> +                &err);
>>      if (hmp_handle_error(mon, err)) {
>>          return;
>>      }
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 75c4ec9a95..7b450b8836 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -335,6 +335,7 @@ void migration_object_init(void)
>>      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
>>  
>>      migration_object_check(current_migration, &error_fatal);
>> +    migrate_params_store_defaults(current_migration);
>>  
>>      ram_mig_init();
>>      dirty_bitmap_mig_init();
>> @@ -1916,13 +1917,24 @@ void migrate_del_blocker(Error **reasonp)
>>  
>>  void qmp_migrate_incoming(const char *uri, bool has_channels,
>>                            MigrationChannelList *channels,
>> -                          bool has_exit_on_error, bool exit_on_error,
>> -                          Error **errp)
>> +                          MigrationParameters *config, bool has_exit_on_error,
>> +                          bool exit_on_error, Error **errp)
>>  {
>>      Error *local_err = NULL;
>>      static bool once = true;
>> +    MigrationState *s = migrate_get_current();
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>>  
>> +    if (config) {
>> +        /*
>> +         * If a config was provided, all options set previously get
>> +         * ignored.
>> +         */
>> +        if (!migrate_params_override(s, config, errp)) {
>> +            return;
>> +        }
>> +    }
>> +
>>      if (!once) {
>>          error_setg(errp, "The incoming migration has already been started");
>>          return;
>> @@ -2182,7 +2194,8 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
>>  }
>>  
>>  void qmp_migrate(const char *uri, bool has_channels,
>> -                 MigrationChannelList *channels, bool has_detach, bool detach,
>> +                 MigrationChannelList *channels,
>> +                 bool has_detach, bool detach, MigrationParameters *config,
>>                   bool has_resume, bool resume, Error **errp)
>>  {
>>      bool resume_requested;
>> @@ -2193,6 +2206,16 @@ void qmp_migrate(const char *uri, bool has_channels,
>>      MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
>>      MigrationChannel *cpr_channel = NULL;
>>  
>> +    if (config) {
>> +        /*
>> +         * If a config was provided, all options set previously get
>> +         * ignored.
>> +         */
>> +        if (!migrate_params_override(s, config, errp)) {
>> +            return;
>> +        }
>> +    }
>> +
>>      /*
>>       * Having preliminary checks for uri and channel
>>       */
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 993d51aedd..49761f4699 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -319,6 +319,7 @@ struct MigrationState {
>>  
>>      /* params from 'migrate-set-parameters' */
>>      MigrationParameters parameters;
>> +    MigrationParameters defaults;
>
> This is also prone to be a pointer; I still think embeded qapi objects are
> too error prone.  Since it's new, make it a pointer from start?
>

Ok.

>>  
>>      MigrationStatus state;
>>  
>> diff --git a/migration/options.c b/migration/options.c
>> index fa3f7035c8..dd2288187d 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -1333,6 +1333,36 @@ static void migrate_params_apply(MigrationParameters *params)
>>                                             params->block_bitmap_mapping);
>>  }
>>  
>> +void migrate_params_store_defaults(MigrationState *s)
>> +{
>> +    /*
>> +     * The defaults set for each qdev property in migration_properties
>> +     * will be stored as the default values for each migration
>> +     * parameter. For debugging, using -global can override the
>> +     * defaults.
>> +     */
>> +    QAPI_CLONE_MEMBERS(MigrationParameters, &s->defaults, &s->parameters);
>> +}
>> +
>> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
>> +                             Error **errp)
>> +{
>> +    ERRP_GUARD();
>> +
>> +    assert(bql_locked());
>> +
>> +    /* reset to default parameters */
>> +    migrate_params_apply(&s->defaults);
>> +
>> +    /* overwrite with the new ones */
>> +    qmp_migrate_set_parameters(new, errp);
>> +    if (*errp) {
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>>  {
>>      MigrationParameters *tmp = g_new0(MigrationParameters, 1);
>> diff --git a/migration/options.h b/migration/options.h
>> index fcfd120cd7..3630c2a0dd 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -83,4 +83,7 @@ void migrate_capability_set_compat(MigrationParameters *params, int i,
>>  void migrate_capabilities_set_compat(MigrationParameters *params,
>>                                       MigrationCapabilityStatusList *caps);
>>  bool migrate_caps_check(MigrationParameters *new, Error **errp);
>> +void migrate_params_store_defaults(MigrationState *s);
>> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
>> +                             Error **errp);
>>  #endif
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 7282e4b9eb..64a92d8d28 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1474,9 +1474,16 @@
>>  #
>>  # @resume: resume one paused migration, default "off".  (since 3.0)
>>  #
>> +# @config: migration configuration options, previously set via
>> +#     @migrate-set-parameters and @migrate-set-capabilities.  (since
>> +#     10.1)
>> +#
>>  # Features:
>>  #
>>  # @deprecated: Argument @detach is deprecated.
>> +# @config: Indicates this command can receive the entire migration
>> +# configuration via the @config field, dispensing the use of
>> +# @migrate-set-parameters.
>>  #
>>  # Since: 0.14
>>  #
>> @@ -1538,7 +1545,9 @@
>>    'data': {'*uri': 'str',
>>             '*channels': [ 'MigrationChannel' ],
>>             '*detach': { 'type': 'bool', 'features': [ 'deprecated' ] },
>> -           '*resume': 'bool' } }
>> +           '*config': 'MigrationParameters',
>> +           '*resume': 'bool' },
>> +  'features': [ 'config' ] }
>>  
>>  ##
>>  # @migrate-incoming:
>> @@ -1557,6 +1566,16 @@
>>  #     error details could be retrieved with query-migrate.
>>  #     (since 9.1)
>>  #
>> +# @config: migration configuration options, previously set via
>> +#     @migrate-set-parameters and @migrate-set-capabilities.  (since
>> +#     10.1)
>> +#
>> +# Features:
>> +#
>> +# @config: Indicates this command can receive the entire migration
>> +# configuration via the @config field, dispensing the use of
>> +# @migrate-set-parameters.
>> +#
>>  # Since: 2.3
>>  #
>>  # .. admonition:: Notes
>> @@ -1610,7 +1629,9 @@
>>  { 'command': 'migrate-incoming',
>>               'data': {'*uri': 'str',
>>                        '*channels': [ 'MigrationChannel' ],
>> -                      '*exit-on-error': 'bool' } }
>> +                      '*config': 'MigrationParameters',
>> +                      '*exit-on-error': 'bool' },
>> +             'features': [ 'config' ] }
>>  
>>  ##
>>  # @xen-save-devices-state:
>> diff --git a/system/vl.c b/system/vl.c
>> index 3b7057e6c6..b29fd24d08 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2823,7 +2823,8 @@ void qmp_x_exit_preconfig(Error **errp)
>>                  g_new0(MigrationChannelList, 1);
>>  
>>              channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
>> -            qmp_migrate_incoming(NULL, true, channels, true, true, &local_err);
>> +            qmp_migrate_incoming(NULL, true, channels, NULL, true, true,
>> +                                 &local_err);
>>              if (local_err) {
>>                  error_reportf_err(local_err, "-incoming %s: ", incoming);
>>                  exit(1);
>> -- 
>> 2.35.3
>> 

