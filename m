Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84112C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 20:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqIl0-0002Sg-IB; Mon, 16 Sep 2024 16:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqIkz-0002S8-8v
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 16:55:37 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqIku-0001sV-7m
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 16:55:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 329601FD85;
 Mon, 16 Sep 2024 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726520130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fChDpLm0iR48IlNvtmq9FQaPRdodlOVFEW+ki+iPnak=;
 b=e2Rq1KuAdxprdKZmDHCNoI+Kg02lbAy1njjfNjWFc/ayIb2lGRekChjWXBxmDkgXqseVMd
 4aC+LlVOWgAafMimv/U17QczSZbwn16HBXUP9WgPH1q//lZWLp800G7YVOKHR+dIR4JWov
 x7m+axQs/DWLn9wcH1xuu3tYPk0Vu4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726520130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fChDpLm0iR48IlNvtmq9FQaPRdodlOVFEW+ki+iPnak=;
 b=EOP8r8gDk4WbQrqt59Xax97O3ttZ+KD7G6uje12XtO6Yy46OTDPZR0UMqH3KMUmHHLysWH
 6/WXphxy+acCxMAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726520130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fChDpLm0iR48IlNvtmq9FQaPRdodlOVFEW+ki+iPnak=;
 b=e2Rq1KuAdxprdKZmDHCNoI+Kg02lbAy1njjfNjWFc/ayIb2lGRekChjWXBxmDkgXqseVMd
 4aC+LlVOWgAafMimv/U17QczSZbwn16HBXUP9WgPH1q//lZWLp800G7YVOKHR+dIR4JWov
 x7m+axQs/DWLn9wcH1xuu3tYPk0Vu4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726520130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fChDpLm0iR48IlNvtmq9FQaPRdodlOVFEW+ki+iPnak=;
 b=EOP8r8gDk4WbQrqt59Xax97O3ttZ+KD7G6uje12XtO6Yy46OTDPZR0UMqH3KMUmHHLysWH
 6/WXphxy+acCxMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABE4C139CE;
 Mon, 16 Sep 2024 20:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JGUJHUGb6GYfIwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Sep 2024 20:55:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: Re: [PATCH v1 6/7] qapi/migration: Introduce
 cpu-responsive-throttle parameter
In-Reply-To: <81d939d716918ed5feea3850cf0644a66d9f1a7b.1726390099.git.yong.huang@smartx.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
 <81d939d716918ed5feea3850cf0644a66d9f1a7b.1726390099.git.yong.huang@smartx.com>
Date: Mon, 16 Sep 2024 17:55:27 -0300
Message-ID: <87plp3z5c0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, smartx.com:email,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Hyman Huang <yong.huang@smartx.com> writes:

> To enable the responsive throttle that will be implemented
> in the next commit, introduce the cpu-responsive-throttle
> parameter.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/migration-hmp-cmds.c |  8 ++++++++
>  migration/options.c            | 20 ++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 16 +++++++++++++++-
>  4 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 28165cfc9e..1fe6c74d66 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -264,6 +264,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),
>              params->cpu_throttle_tailslow ? "on" : "off");
> +        assert(params->has_cpu_responsive_throttle);
> +        monitor_printf(mon, "%s: %s\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE),
> +            params->cpu_responsive_throttle ? "on" : "off");
>          assert(params->has_max_cpu_throttle);
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
> @@ -512,6 +516,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_cpu_throttle_tailslow = true;
>          visit_type_bool(v, param, &p->cpu_throttle_tailslow, &err);
>          break;
> +    case MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE:
> +        p->has_cpu_responsive_throttle = true;
> +        visit_type_bool(v, param, &p->cpu_responsive_throttle, &err);
> +        break;
>      case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
>          p->has_max_cpu_throttle = true;
>          visit_type_uint8(v, param, &p->max_cpu_throttle, &err);
> diff --git a/migration/options.c b/migration/options.c
> index 147cd2b8fd..b4c269bf1d 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -111,6 +111,8 @@ Property migration_properties[] = {
>                        DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
>      DEFINE_PROP_BOOL("x-cpu-throttle-tailslow", MigrationState,
>                        parameters.cpu_throttle_tailslow, false),
> +    DEFINE_PROP_BOOL("x-cpu-responsive-throttle", MigrationState,
> +                      parameters.cpu_responsive_throttle, false),
>      DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
>                        parameters.max_bandwidth, MAX_THROTTLE),
>      DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
> @@ -705,6 +707,13 @@ uint8_t migrate_cpu_throttle_initial(void)
>      return s->parameters.cpu_throttle_initial;
>  }
>  
> +bool migrate_responsive_throttle(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.cpu_responsive_throttle;
> +}
> +
>  bool migrate_cpu_throttle_tailslow(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -891,6 +900,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
>      params->has_cpu_throttle_tailslow = true;
>      params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
> +    params->has_cpu_responsive_throttle = true;
> +    params->cpu_responsive_throttle = s->parameters.cpu_responsive_throttle;
>      params->tls_creds = g_strdup(s->parameters.tls_creds);
>      params->tls_hostname = g_strdup(s->parameters.tls_hostname);
>      params->tls_authz = g_strdup(s->parameters.tls_authz ?
> @@ -959,6 +970,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_cpu_throttle_initial = true;
>      params->has_cpu_throttle_increment = true;
>      params->has_cpu_throttle_tailslow = true;
> +    params->has_cpu_responsive_throttle = true;
>      params->has_max_bandwidth = true;
>      params->has_downtime_limit = true;
>      params->has_x_checkpoint_delay = true;
> @@ -1191,6 +1203,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>          dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
>      }
>  
> +    if (params->has_cpu_responsive_throttle) {
> +        dest->cpu_responsive_throttle = params->cpu_responsive_throttle;
> +    }
> +
>      if (params->tls_creds) {
>          assert(params->tls_creds->type == QTYPE_QSTRING);
>          dest->tls_creds = params->tls_creds->u.s;
> @@ -1302,6 +1318,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>          s->parameters.cpu_throttle_tailslow = params->cpu_throttle_tailslow;
>      }
>  
> +    if (params->has_cpu_responsive_throttle) {
> +        s->parameters.cpu_responsive_throttle = params->cpu_responsive_throttle;
> +    }
> +
>      if (params->tls_creds) {
>          g_free(s->parameters.tls_creds);
>          assert(params->tls_creds->type == QTYPE_QSTRING);
> diff --git a/migration/options.h b/migration/options.h
> index a0bd6edc06..80d0fcdaf9 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -68,6 +68,7 @@ bool migrate_has_block_bitmap_mapping(void);
>  uint32_t migrate_checkpoint_delay(void);
>  uint8_t migrate_cpu_throttle_increment(void);
>  uint8_t migrate_cpu_throttle_initial(void);
> +bool migrate_responsive_throttle(void);
>  bool migrate_cpu_throttle_tailslow(void);
>  bool migrate_direct_io(void);
>  uint64_t migrate_downtime_limit(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 95b490706c..c61d3b3a6b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -732,6 +732,10 @@
>  #     be excessive at tail stage.  The default value is false.  (Since
>  #     5.1)
>  #
> +# @cpu-responsive-throttle: Make CPU throttling more responsively by
> +#                           introduce an extra detection metric of
> +#                           migration convergence. (Since 9.1)
> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials
>  #     for establishing a TLS connection over the migration data
>  #     channel.  On the outgoing side of the migration, the credentials
> @@ -857,7 +861,7 @@
>             'announce-rounds', 'announce-step',
>             'throttle-trigger-threshold',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
> -           'cpu-throttle-tailslow',
> +           'cpu-throttle-tailslow', 'cpu-responsive-throttle',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>             'avail-switchover-bandwidth', 'downtime-limit',
>             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
> @@ -913,6 +917,10 @@
>  #     be excessive at tail stage.  The default value is false.  (Since
>  #     5.1)
>  #
> +# @cpu-responsive-throttle: Make CPU throttling more responsively by
> +#                           introduce an extra detection metric of
> +#                           migration convergence. (Since 9.1)
> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials
>  #     for establishing a TLS connection over the migration data
>  #     channel.  On the outgoing side of the migration, the credentials
> @@ -1045,6 +1053,7 @@
>              '*cpu-throttle-initial': 'uint8',
>              '*cpu-throttle-increment': 'uint8',
>              '*cpu-throttle-tailslow': 'bool',
> +            '*cpu-responsive-throttle': 'bool',

Should this instead follow the pattern of cpu-throttle-* ?

>              '*tls-creds': 'StrOrNull',
>              '*tls-hostname': 'StrOrNull',
>              '*tls-authz': 'StrOrNull',
> @@ -1127,6 +1136,10 @@
>  #     be excessive at tail stage.  The default value is false.  (Since
>  #     5.1)
>  #
> +# @cpu-responsive-throttle: Make CPU throttling more responsively by

s/responsively/responsive/ ?

> +#                           introduce an extra detection metric of
> +#                           migration convergence. (Since 9.1)

Since 9.2. And double space after period.

> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials
>  #     for establishing a TLS connection over the migration data
>  #     channel.  On the outgoing side of the migration, the credentials
> @@ -1252,6 +1265,7 @@
>              '*cpu-throttle-initial': 'uint8',
>              '*cpu-throttle-increment': 'uint8',
>              '*cpu-throttle-tailslow': 'bool',
> +            '*cpu-responsive-throttle': 'bool',
>              '*tls-creds': 'str',
>              '*tls-hostname': 'str',
>              '*tls-authz': 'str',

