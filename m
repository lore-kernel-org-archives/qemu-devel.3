Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28100C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 22:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2ZG-0007OR-3p; Tue, 27 May 2025 18:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uK2ZD-0007OE-PP
 for qemu-devel@nongnu.org; Tue, 27 May 2025 18:14:39 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uK2ZB-0001yV-Ei
 for qemu-devel@nongnu.org; Tue, 27 May 2025 18:14:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52FD721DF7;
 Tue, 27 May 2025 22:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748384072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBKTUkQOpo1MP1GyN1dWQ65JxpVwy2Z+X8y7O2iypfo=;
 b=lDa30phFKUTp4wyHvcsQM6dsXj7LZfDzi0ktLtFe8IATS+xMnJ0gWkgNEcSP1HZlfKICsb
 sL/Qrun63BJDQnoPzBBZlkw23LSM0rO2kVk9BSgPqhcfjHFD5P1opOr3Oa0PNuscBFQBt+
 ZKEN2IYAYg90fVxxxp/RCq4l6TCiVCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748384072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBKTUkQOpo1MP1GyN1dWQ65JxpVwy2Z+X8y7O2iypfo=;
 b=WT4WePHxNIXekXvRbh0w/atHzjGZQiyzqJTZ3b+lhrk252J2VDgFslh9hUifRsaGitfD/L
 tjSfxTgG4ZmGh5Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lDa30phF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WT4WePHx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748384072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBKTUkQOpo1MP1GyN1dWQ65JxpVwy2Z+X8y7O2iypfo=;
 b=lDa30phFKUTp4wyHvcsQM6dsXj7LZfDzi0ktLtFe8IATS+xMnJ0gWkgNEcSP1HZlfKICsb
 sL/Qrun63BJDQnoPzBBZlkw23LSM0rO2kVk9BSgPqhcfjHFD5P1opOr3Oa0PNuscBFQBt+
 ZKEN2IYAYg90fVxxxp/RCq4l6TCiVCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748384072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBKTUkQOpo1MP1GyN1dWQ65JxpVwy2Z+X8y7O2iypfo=;
 b=WT4WePHxNIXekXvRbh0w/atHzjGZQiyzqJTZ3b+lhrk252J2VDgFslh9hUifRsaGitfD/L
 tjSfxTgG4ZmGh5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD467136E0;
 Tue, 27 May 2025 22:14:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rvqYHkc5Nmj1OgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 May 2025 22:14:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 12/13] [PoC] migration: Add query/set commands for
 MigrationConfig
In-Reply-To: <874ix7byin.fsf@pond.sub.org>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-13-farosas@suse.de> <874ix7byin.fsf@pond.sub.org>
Date: Tue, 27 May 2025 19:14:28 -0300
Message-ID: <87zfex8zwb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 52FD721DF7
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Add the QMP commands query-migrate-config and migrate-set-config to
>> read and write the migration configuration options.
>
> These supersede query-migrate-capabilities, query-migrate-parameters,
> migrate-set-capabilities, and migrate-set-parameters, right?
>

They could. We haven't made a decision at this moment.

>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 24 ++++++++++++++++++++++++
>>  migration/options.h |  2 +-
>>  qapi/migration.json | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 67 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/options.c b/migration/options.c
>> index 4e3792dec3..c85ee2e506 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -1441,3 +1441,27 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>>      migrate_config_apply(&tmp);
>>      migrate_post_update_config(&tmp, errp);
>>  }
>> +
>> +void qmp_migrate_set_config(MigrationConfig *config, Error **errp)
>> +{
>> +    if (!migrate_config_check(config, errp)) {
>> +        /* Invalid parameter */
>> +        return;
>> +    }
>> +
>> +    migrate_config_apply(config);
>> +    migrate_post_update_config(config, errp);
>> +}
>> +
>> +MigrationConfig *qmp_query_migrate_config(Error **errp)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +    MigrationConfig *config = g_new0(MigrationConfig, 1);
>> +
>> +    QAPI_CLONE_MEMBERS(MigrationConfig, config, &s->config);
>> +
>> +    /* set the has_* fields for every option */
>> +    migrate_config_init(config);
>> +
>> +    return config;
>> +}
>> diff --git a/migration/options.h b/migration/options.h
>> index 61ee854bb0..0e36dafe80 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -72,7 +72,7 @@ uint64_t migrate_xbzrle_cache_size(void);
>>  ZeroPageDetection migrate_zero_page_detection(void);
>>  
>>  bool migrate_config_check(MigrationConfig *params, Error **errp);
>> -void migrate_config_init(MigrationConfig *params);
>> +void migrate_config_init(MigrationConfig *config);
>
> Have you considered renaming the declaration's parameter when you change
> its type in PATCH 08, or when you rename the definition's parameter in
> PATCH 11?
>

Yes, that looks like a mistake during rebase.

>>  bool migrate_config_get_cap_compat(MigrationConfig *config, int i);
>>  bool migrate_caps_check(MigrationConfig *new, Error **errp);
>>  #endif
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 5e39f21adc..bb2487dbc6 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -2552,3 +2552,45 @@
>>    'data': { '*tls-creds': 'str',
>>              '*tls-hostname': 'str',
>>              '*tls-authz': 'str' } }
>> +
>> +##
>> +# @query-migrate-config:
>> +#
>> +# Returns information about the current migration configuration
>> +# options
>> +#
>> +# Returns: @MigrationConfig
>> +#
>> +# Since: 10.1
>> +#
>> +# .. qmp-example::
>> +#
>> +#     -> { "execute": "query-migrate-config" }
>> +#     <- { "return": {
>> +#              "multifd-channels": 2,
>> +#              "cpu-throttle-increment": 10,
>> +#              "cpu-throttle-initial": 20,
>> +#              "max-bandwidth": 33554432,
>> +#              "downtime-limit": 300
>> +#           }
>> +#        }
>> +##
>> +{ 'command': 'query-migrate-config',
>> +  'returns': 'MigrationConfig' }
>> +
>> +##
>> +# @migrate-set-config:
>> +#
>> +# Set various migration configuration options.
>> +#
>> +# Since: 10.1
>> +#
>> +# .. qmp-example::
>> +#
>> +#     -> { "execute": "migrate-set-config" ,
>> +#          "arguments": { "max-bandwidth": 33554432,
>> +#                         "downtime-limit": 300 } }
>> +#     <- { "return": {} }
>> +##
>> +{ 'command': 'migrate-set-config', 'boxed': true,
>> +  'data': 'MigrationConfig' }
>
> This patch exposes MigrationConfig externally.  We should double-check
> its documentation to make sure it's what we want there.  Known issue:
> how to reset @tls-creds & friends.  Touched in my review of PATCH 07.

I'll take a closer look at tls options after Daniel suggested changing
MigrationParameters' TLS options type from str to StrOrNull. That allows
us to drop MigrateSetParameters entirely.

