Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF45C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ccY-0007dk-49; Wed, 08 May 2024 04:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4ccS-0007bu-Pr
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4ccP-00075e-Sc
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715156740;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SNe3oV7NDkld0hswjNaY/8AC2AQnoTIvnBFvKit2IC8=;
 b=AzY8gNl0fObtbVWgY/duYkfehy3EO7CcvDF+aZOwTYKANMITajNteQpXJdvD2NDnX3dEis
 idjVoxEhezVIORXcLZqnd9TR31na8eDPEQC8+pldLsskPDUt8UMfnlhNJf2UzjY4n6ozGE
 0gYjtLsEXslGjtqgapue+s0oxRWMaxQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-EQX1rWnLOMa__P0uFZ591w-1; Wed, 08 May 2024 04:25:37 -0400
X-MC-Unique: EQX1rWnLOMa__P0uFZ591w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D82B68025FC;
 Wed,  8 May 2024 08:25:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF3B749104B;
 Wed,  8 May 2024 08:25:34 +0000 (UTC)
Date: Wed, 8 May 2024 09:25:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 4/9] migration: Add direct-io parameter
Message-ID: <Zjs2_bGtmgmJ9iZ8@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-5-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 26, 2024 at 11:20:37AM -0300, Fabiano Rosas wrote:
> Add the direct-io migration parameter that tells the migration code to
> use O_DIRECT when opening the migration stream file whenever possible.
> 
> This is currently only used with the mapped-ram migration that has a
> clear window guaranteed to perform aligned writes.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/qemu/osdep.h           |  2 ++
>  migration/migration-hmp-cmds.c | 11 +++++++++++
>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 18 +++++++++++++++---
>  util/osdep.c                   |  9 +++++++++
>  6 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index c7053cdc2b..645c14a65d 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -612,6 +612,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
>  bool qemu_has_ofd_lock(void);
>  #endif
>  
> +bool qemu_has_direct_io(void);
> +
>  #if defined(__HAIKU__) && defined(__i386__)
>  #define FMT_pid "%ld"
>  #elif defined(WIN64)
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7e96ae6ffd..8496a2b34e 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -397,6 +397,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MODE),
>              qapi_enum_lookup(&MigMode_lookup, params->mode));
> +
> +        if (params->has_direct_io) {
> +            monitor_printf(mon, "%s: %s\n",
> +                           MigrationParameter_str(
> +                               MIGRATION_PARAMETER_DIRECT_IO),
> +                           params->direct_io ? "on" : "off");
> +        }
>      }
>  
>      qapi_free_MigrationParameters(params);
> @@ -690,6 +697,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_mode = true;
>          visit_type_MigMode(v, param, &p->mode, &err);
>          break;
> +    case MIGRATION_PARAMETER_DIRECT_IO:
> +        p->has_direct_io = true;
> +        visit_type_bool(v, param, &p->direct_io, &err);
> +        break;
>      default:
>          assert(0);
>      }
> diff --git a/migration/options.c b/migration/options.c
> index 239f5ecfb4..ae464aa4f2 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -826,6 +826,22 @@ int migrate_decompress_threads(void)
>      return s->parameters.decompress_threads;
>  }
>  
> +bool migrate_direct_io(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    /* For now O_DIRECT is only supported with mapped-ram */
> +    if (!s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM]) {
> +        return false;
> +    }
> +
> +    if (s->parameters.has_direct_io) {
> +        return s->parameters.direct_io;
> +    }
> +
> +    return false;
> +}
> +
>  uint64_t migrate_downtime_limit(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -1061,6 +1077,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->has_zero_page_detection = true;
>      params->zero_page_detection = s->parameters.zero_page_detection;
>  
> +    if (s->parameters.has_direct_io) {
> +        params->has_direct_io = true;
> +        params->direct_io = s->parameters.direct_io;
> +    }
> +
>      return params;
>  }
>  
> @@ -1097,6 +1118,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_vcpu_dirty_limit = true;
>      params->has_mode = true;
>      params->has_zero_page_detection = true;
> +    params->has_direct_io = qemu_has_direct_io();
>  }
>  
>  /*
> @@ -1416,6 +1438,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_zero_page_detection) {
>          dest->zero_page_detection = params->zero_page_detection;
>      }
> +
> +    if (params->has_direct_io) {
> +        dest->direct_io = params->direct_io;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -1570,6 +1596,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_zero_page_detection) {
>          s->parameters.zero_page_detection = params->zero_page_detection;
>      }
> +
> +    if (params->has_direct_io) {
> +        s->parameters.direct_io = params->direct_io;
> +    }
>  }

I would expect to see something added to migrat_params_check() that
calls qemu_has_direct_io() and reports an error if the platform
lacks O_DIRECT, so mgmt apps see when they're trying to use O_DIRECT
on a bad platform straightaway, rather than only when migration
starts later.

Alternatively, and perhaps better would be for use to have a meson.build
check for O_DIRECT, and then make all the QAPI features have a condition
on CONFIG_O_DIRECT, so QAPI rejects any use of 'direct-io' feature at
input time.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


