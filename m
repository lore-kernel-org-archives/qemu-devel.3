Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FF7C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 20:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNHZG-00065c-Lu; Thu, 05 Jun 2025 16:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNHZC-00065A-T3
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 16:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNHZ8-0000h0-UX
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 16:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749156716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtS4M20Y3exLxGd5ILSxDqyzf0b39YV0H2jB74eMxIY=;
 b=WIYOhMt+nAvMTuCnLcCz5Ck3TENeO1JETl/TWwjOSboO3RfCzjXrsIiEmtPrBN03s20eRo
 5+ouByZQ+t6LxHQNw22ommrr2H1XPcyyStTu7ISdoU2FkPm835bb+tnBNpQ2vwMscxikWE
 oBFd+sPtHPfJE9oqEqJeIT0yh69farU=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-KPdiLK9qNquqEBQc0IkwQQ-1; Thu, 05 Jun 2025 16:51:55 -0400
X-MC-Unique: KPdiLK9qNquqEBQc0IkwQQ-1
X-Mimecast-MFC-AGG-ID: KPdiLK9qNquqEBQc0IkwQQ_1749156714
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-87e8668f1ffso976915241.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 13:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749156713; x=1749761513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtS4M20Y3exLxGd5ILSxDqyzf0b39YV0H2jB74eMxIY=;
 b=tHaFfNorf6QbRxq6HFfWi6XOMfeNc3kXj1aCB8xs0ExqzjOSIyZBeXBKV15sUkhjNE
 /nuLsKiNuOZ8PRLeuK73GMZCwwmcL8bRF9BToaLUNPI3dmrX9Gxke/kRDnSz6bcRXtTv
 VlRhFgr/s/9FbtwGYw/oC/E3ykg0yVwdkTcKp68JR95IO6oYDtFzJ0QNCaBSkECQ1BVF
 n+IEo5Oyj4KvTv/LE5t2v/DCondV9LDihkRUi4sfgw4OS3AbFrlf339LO8DIHAOYaGeQ
 oICY1wsrIX/Zust7GLwMptjsgEl0YDs7egq5OG+eEuh0TPiExzLfjlqB+iyLntPBBHAz
 PYLw==
X-Gm-Message-State: AOJu0Ywql9WbmRJ/pQcO73k8RfuyF3QEd4+3UkrDfQ7Vz6iLSPTaKcnz
 EQuDL0RaMXXmwky16ZMzvOMzckd5kwi9PgR6GyuAg0YU3xn6j3OT0NvNEKC6sbP1nixUJKj3ZcR
 42koYZIzo8YeRi9GXzI0ZwF8YBXWZ4wdgcfT8eEFmm4AIfG2VOIP/Xoxy1tsi+PZO
X-Gm-Gg: ASbGnctnAUWetDXpJfd7GVy1Mett3fkIqvgaITEVRKRZ+/4+g5/+Ef+xHuOU5wcjw6V
 tzA3UOq6N9ZdNWIptTYicZpcPLZCWxfeIIx4cuE639yHqqHEPw4uHwyzR/vaSuJtXOKsv/gdaCg
 0ZPY+EyF6en/9bheJA25C0s7JDBJ7Tt8ahnMBIsmuSCKYNZi7RyNaeTS17slAjICEwoJA4ktD2G
 7AptuOKGs/DOWsI+G8BSocFwO9HVgC3imAeMbYaLai9Yzhf+OXZQa1u1aQ9cpdEKsjE/J16mEEW
 f7Q=
X-Received: by 2002:a05:6102:1591:b0:4e4:f503:6675 with SMTP id
 ada2fe7eead31-4e772a6ba32mr1024864137.18.1749156713332; 
 Thu, 05 Jun 2025 13:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGsht4eIvT6RNAbpZMcgl0T1Kr1RU4cReK0Pz6Sq8BM7uzLgsw/UhgANw9f6lpj8Gqn7LpEw==
X-Received: by 2002:a05:622a:410d:b0:494:b3eb:a4b9 with SMTP id
 d75a77b69052e-4a5b9db8c40mr17702071cf.51.1749156702545; 
 Thu, 05 Jun 2025 13:51:42 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a61117d0a7sm1081651cf.33.2025.06.05.13.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 13:51:41 -0700 (PDT)
Date: Thu, 5 Jun 2025 16:51:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 01/21] migration: Normalize tls arguments
Message-ID: <aEIDW3gVi9LF4FTQ@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 02, 2025 at 10:37:50PM -0300, Fabiano Rosas wrote:
> The migration parameters tls_creds, tls_authz and tls_hostname
> currently have a non-uniform handling. When used as arguments to
> migrate-set-parameters, their type is StrOrNull and when used as
> return value from query-migrate-parameters, their type is a plain
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
> of the TLS arguments in MigrationParameters to StrOrNull and add a
> helper to ensure they're never actually used as QTYPE_QNULL.
> 
> This will allow the type duplication to be removed in the next
> patches.

Definitely a progress if we can finally merge the two!

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c |   8 +-
>  migration/migration.c          |   2 +
>  migration/options.c            | 149 ++++++++++++++++++++-------------
>  migration/options.h            |   1 +
>  migration/tls.c                |   2 +-
>  qapi/migration.json            |   6 +-
>  6 files changed, 99 insertions(+), 69 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index e8a563c7d8..bc8179c582 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -276,14 +276,12 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
>              params->max_cpu_throttle);
> -        assert(params->tls_creds);
>          monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
> -            params->tls_creds);
> -        assert(params->tls_hostname);
> +                       params->tls_creds ? params->tls_creds->u.s : "");
>          monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
> -            params->tls_hostname);
> +                       params->tls_hostname ? params->tls_hostname->u.s : "");
>          assert(params->has_max_bandwidth);
>          monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
> @@ -319,7 +317,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>              params->max_postcopy_bandwidth);
>          monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> -            params->tls_authz);
> +                       params->tls_authz ? params->tls_authz->u.s : "");
>  
>          if (params->has_block_bitmap_mapping) {
>              const BitmapMigrationNodeAliasList *bmnal;
> diff --git a/migration/migration.c b/migration/migration.c
> index 4697732bef..f65cb81b6d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -4053,6 +4053,8 @@ static void migration_instance_finalize(Object *obj)
>  {
>      MigrationState *ms = MIGRATION_OBJ(obj);
>  
> +    migrate_tls_opts_free(&ms->parameters);

Does this line imply that maybe it's time we make MigrationState.parameters
a pointer instead of embeded struct anymore?

We already used to have tls_* strings hence that idea should be already
applicable even before.. but this work just made me think about it more.

So instead of freeing sub-fields if we add more to MigrationParameters, we
could then do:

  g_clear_pointer(&ms->parameters, qapi_free_MigrationParameters);

> +
>      qemu_mutex_destroy(&ms->error_mutex);
>      qemu_mutex_destroy(&ms->qemu_file_lock);
>      qemu_sem_destroy(&ms->wait_unplug_sem);
> diff --git a/migration/options.c b/migration/options.c
> index 162c72cda4..45a95dc6da 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -162,9 +162,11 @@ const Property migration_properties[] = {
>      DEFINE_PROP_SIZE("announce-step", MigrationState,
>                        parameters.announce_step,
>                        DEFAULT_MIGRATE_ANNOUNCE_STEP),
> -    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
> -    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
> -    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
> +    /*
> +     * tls-creds, tls-hostname and tls-authz are of type StrOrNull,
> +     * which can't be easily handled (if at all) by qdev. So these
> +     * will not be exposed as global migration options (-global).
> +     */
>      DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
>                         parameters.x_vcpu_dirty_limit_period,
>                         DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
> @@ -379,13 +381,6 @@ bool migrate_rdma(void)
>      return s->rdma_migration;
>  }
>  
> -bool migrate_tls(void)
> -{
> -    MigrationState *s = migrate_get_current();
> -
> -    return s->parameters.tls_creds && *s->parameters.tls_creds;
> -}
> -
>  typedef enum WriteTrackingSupport {
>      WT_SUPPORT_UNKNOWN = 0,
>      WT_SUPPORT_ABSENT,
> @@ -834,21 +829,44 @@ const char *migrate_tls_authz(void)
>  {
>      MigrationState *s = migrate_get_current();
>  
> -    return s->parameters.tls_authz;
> +    if (s->parameters.tls_authz &&
> +        s->parameters.tls_authz->type == QTYPE_QSTRING &&
> +        *s->parameters.tls_authz->u.s) {
> +        return s->parameters.tls_authz->u.s;
> +    }

Nitpick: some deduplication would be nice?  E.g.

  bool StrOrNull_str_valid(StrOrNull *obj)
  {
      return obj && obj->type == QTYPE_QSTRING && *obj->u.s;
  }

  const char *StrOrNull_str_get(StrOrNull *obj)
  {
      assert(obj && obj->type == QTYPE_QSTRING);
      return obj->u.s;
  }

  const char *StrOrNull_to_str(StrOrNull *obj)
  {
      return StrOrNull_str_valid(obj) ? StrOrNull_str_get(obj) : NULL;
  }

Then:

const char *migrate_tls_authz(void)
{
    return StrOrNull_to_str(s->parameters.tls_authz);
}

Then apply below.

> +
> +    return NULL;
>  }
>  
>  const char *migrate_tls_creds(void)
>  {
>      MigrationState *s = migrate_get_current();
>  
> -    return s->parameters.tls_creds;
> +    if (s->parameters.tls_creds &&
> +        s->parameters.tls_creds->type == QTYPE_QSTRING &&
> +        *s->parameters.tls_creds->u.s) {
> +        return s->parameters.tls_creds->u.s;
> +    }
> +
> +    return NULL;
>  }
>  
>  const char *migrate_tls_hostname(void)
>  {
>      MigrationState *s = migrate_get_current();
>  
> -    return s->parameters.tls_hostname;
> +    if (s->parameters.tls_hostname &&
> +        s->parameters.tls_hostname->type == QTYPE_QSTRING &&
> +        *s->parameters.tls_hostname->u.s) {
> +        return s->parameters.tls_hostname->u.s;
> +    }
> +
> +    return NULL;
> +}
> +
> +bool migrate_tls(void)
> +{
> +    return !!migrate_tls_creds();
>  }
>  
>  uint64_t migrate_vcpu_dirty_limit_period(void)
> @@ -888,6 +906,36 @@ AnnounceParameters *migrate_announce_params(void)
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
> +/* needs BQL if dst is part of s->parameters */
> +static void tls_option_set_str(StrOrNull **dstp, StrOrNull *src)

Nitpick: set_str made me think that the internal objects will be stolen.
Maybe tls_option_copy()?

> +{
> +    StrOrNull *dst = *dstp;
> +
> +    assert(!dst);
> +
> +    dst = *dstp = g_new0(StrOrNull, 1);
> +    dst->type = QTYPE_QSTRING;
> +
> +    if (!src) {
> +        dst->u.s = g_strdup("");
> +        return;
> +    }
> +
> +    if (src->type == QTYPE_QSTRING) {
> +        dst->u.s = g_strdup(src->u.s);
> +    } else {
> +        assert(src->type == QTYPE_QNULL);
> +        dst->u.s = g_strdup("");
> +    }
> +}
> +
>  MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>  {
>      MigrationParameters *params;
> @@ -903,10 +951,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
>      params->has_cpu_throttle_tailslow = true;
>      params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
> -    params->tls_creds = g_strdup(s->parameters.tls_creds);
> -    params->tls_hostname = g_strdup(s->parameters.tls_hostname);
> -    params->tls_authz = g_strdup(s->parameters.tls_authz ?
> -                                 s->parameters.tls_authz : "");
> +
> +    tls_option_set_str(&params->tls_creds, s->parameters.tls_creds);
> +    tls_option_set_str(&params->tls_hostname, s->parameters.tls_hostname);
> +    tls_option_set_str(&params->tls_authz, s->parameters.tls_authz);
> +
>      params->has_max_bandwidth = true;
>      params->max_bandwidth = s->parameters.max_bandwidth;
>      params->has_avail_switchover_bandwidth = true;
> @@ -963,9 +1012,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>  
>  void migrate_params_init(MigrationParameters *params)
>  {
> -    params->tls_hostname = g_strdup("");
> -    params->tls_creds = g_strdup("");
> -
>      /* Set has_* up only for parameter checks */
>      params->has_throttle_trigger_threshold = true;
>      params->has_cpu_throttle_initial = true;
> @@ -1142,7 +1188,8 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>  #ifdef CONFIG_LINUX
>      if (migrate_zero_copy_send() &&
>          ((params->has_multifd_compression && params->multifd_compression) ||
> -         (params->tls_creds && *params->tls_creds))) {
> +         (params->tls_creds && params->tls_creds->type == QTYPE_QSTRING &&
> +          *params->tls_creds->u.s))) {

Nitpick: StrOrNull_str_valid() candidate.

>          error_setg(errp,
>                     "Zero copy only available for non-compressed non-TLS multifd migration");
>          return false;
> @@ -1204,18 +1251,24 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      }
>  
>      if (params->tls_creds) {
> -        assert(params->tls_creds->type == QTYPE_QSTRING);
> -        dest->tls_creds = params->tls_creds->u.s;
> +        tls_option_set_str(&dest->tls_creds, params->tls_creds);
> +    } else {
> +        /* drop the reference, it's owned by s->parameters */
> +        dest->tls_creds = NULL;
>      }

This looks ok, but smells tricky, because before this line, "params" can
contain something that it doesn't own..

If above idea of "making MigrationState->parameters a real QAPI object"
works out, here IIUC we can also make "params" a real QAPI object by
QAPI_CLONE(MigrationState->parameters), then when reaching here:

       if (params->tls_creds) {
          qapi_free_StrOrNull(params->tls_creds);
          params->tls_creds = QAPI_CLONE(params->tls_creds);
       }

It avoids the tricky "else" where we need to remember to clear something it
doesn't ever own.  Same to the rest.

>  
>      if (params->tls_hostname) {
> -        assert(params->tls_hostname->type == QTYPE_QSTRING);
> -        dest->tls_hostname = params->tls_hostname->u.s;
> +        tls_option_set_str(&dest->tls_hostname, params->tls_hostname);
> +    } else {
> +        /* drop the reference, it's owned by s->parameters */
> +        dest->tls_hostname = NULL;
>      }
>  
>      if (params->tls_authz) {
> -        assert(params->tls_authz->type == QTYPE_QSTRING);
> -        dest->tls_authz = params->tls_authz->u.s;
> +        tls_option_set_str(&dest->tls_authz, params->tls_authz);
> +    } else {
> +        /* drop the reference, it's owned by s->parameters */
> +        dest->tls_authz = NULL;
>      }
>  
>      if (params->has_max_bandwidth) {
> @@ -1320,21 +1373,18 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      }
>  
>      if (params->tls_creds) {
> -        g_free(s->parameters.tls_creds);
> -        assert(params->tls_creds->type == QTYPE_QSTRING);
> -        s->parameters.tls_creds = g_strdup(params->tls_creds->u.s);
> +        qapi_free_StrOrNull(s->parameters.tls_creds);
> +        tls_option_set_str(&s->parameters.tls_creds, params->tls_creds);

Yeah, exactly like this one..

>      }
>  
>      if (params->tls_hostname) {
> -        g_free(s->parameters.tls_hostname);
> -        assert(params->tls_hostname->type == QTYPE_QSTRING);
> -        s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
> +        qapi_free_StrOrNull(s->parameters.tls_hostname);
> +        tls_option_set_str(&s->parameters.tls_hostname, params->tls_hostname);
>      }
>  
>      if (params->tls_authz) {
> -        g_free(s->parameters.tls_authz);
> -        assert(params->tls_authz->type == QTYPE_QSTRING);
> -        s->parameters.tls_authz = g_strdup(params->tls_authz->u.s);
> +        qapi_free_StrOrNull(s->parameters.tls_authz);
> +        tls_option_set_str(&s->parameters.tls_authz, params->tls_authz);
>      }
>  
>      if (params->has_max_bandwidth) {
> @@ -1433,32 +1483,11 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>  {
>      MigrationParameters tmp;
>  
> -    /* TODO Rewrite "" to null instead for all three tls_* parameters */
> -    if (params->tls_creds
> -        && params->tls_creds->type == QTYPE_QNULL) {
> -        qobject_unref(params->tls_creds->u.n);
> -        params->tls_creds->type = QTYPE_QSTRING;
> -        params->tls_creds->u.s = strdup("");
> -    }
> -    if (params->tls_hostname
> -        && params->tls_hostname->type == QTYPE_QNULL) {
> -        qobject_unref(params->tls_hostname->u.n);
> -        params->tls_hostname->type = QTYPE_QSTRING;
> -        params->tls_hostname->u.s = strdup("");
> -    }
> -    if (params->tls_authz
> -        && params->tls_authz->type == QTYPE_QNULL) {
> -        qobject_unref(params->tls_authz->u.n);
> -        params->tls_authz->type = QTYPE_QSTRING;
> -        params->tls_authz->u.s = strdup("");
> -    }
> -
>      migrate_params_test_apply(params, &tmp);
>  
> -    if (!migrate_params_check(&tmp, errp)) {
> -        /* Invalid parameter */
> -        return;
> +    if (migrate_params_check(&tmp, errp)) {
> +        migrate_params_apply(params, errp);
>      }
>  
> -    migrate_params_apply(params, errp);
> +    migrate_tls_opts_free(&tmp);
>  }
> diff --git a/migration/options.h b/migration/options.h
> index 82d839709e..999eee6f3b 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -91,4 +91,5 @@ ZeroPageDetection migrate_zero_page_detection(void);
>  
>  bool migrate_params_check(MigrationParameters *params, Error **errp);
>  void migrate_params_init(MigrationParameters *params);
> +void migrate_tls_opts_free(MigrationParameters *params);
>  #endif
> diff --git a/migration/tls.c b/migration/tls.c
> index 5cbf952383..8a89d3f767 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -126,7 +126,7 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
>      }
>  
>      const char *tls_hostname = migrate_tls_hostname();
> -    if (tls_hostname && *tls_hostname) {
> +    if (tls_hostname) {
>          hostname = tls_hostname;
>      }
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 41826bde45..fa42d94810 100644
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
> -- 
> 2.35.3
> 

-- 
Peter Xu


