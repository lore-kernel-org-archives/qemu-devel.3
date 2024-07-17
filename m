Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5B5C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4kE-00064v-25; Wed, 17 Jul 2024 09:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU4kB-00064P-Jq
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:30:55 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU4k9-0005ic-49
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:30:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BD7821AE5;
 Wed, 17 Jul 2024 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721223051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W92Uu5rpEr94fOjM7QD/w0fV1vy9xPZGCUVSJ7dCN+M=;
 b=Ozmrojxak+FVhd4VMWfS/BvUpg8rayZC9S3CtQKdGKBy5bSBEK9H5gcPUVkm/cVenZlN/2
 jZvSLC36zntmWb/Zyz5jkPj3ndULHITk2nY0HYg4oTIJnO8uOH1z0UuijJlt0qBw+TOp/D
 UzqzxwwzKqBnN9qShb73ZaYJ0HZ9ciw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721223051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W92Uu5rpEr94fOjM7QD/w0fV1vy9xPZGCUVSJ7dCN+M=;
 b=1fkdSpjg8XMa9Ahk26H+7sa9pmMjuHP/CYTZSkyRplFz8WNrkVmwlkVPjwiO2uiyGbSi4e
 8Yx5V4Y3CEY/9SCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721223051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W92Uu5rpEr94fOjM7QD/w0fV1vy9xPZGCUVSJ7dCN+M=;
 b=Ozmrojxak+FVhd4VMWfS/BvUpg8rayZC9S3CtQKdGKBy5bSBEK9H5gcPUVkm/cVenZlN/2
 jZvSLC36zntmWb/Zyz5jkPj3ndULHITk2nY0HYg4oTIJnO8uOH1z0UuijJlt0qBw+TOp/D
 UzqzxwwzKqBnN9qShb73ZaYJ0HZ9ciw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721223051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W92Uu5rpEr94fOjM7QD/w0fV1vy9xPZGCUVSJ7dCN+M=;
 b=1fkdSpjg8XMa9Ahk26H+7sa9pmMjuHP/CYTZSkyRplFz8WNrkVmwlkVPjwiO2uiyGbSi4e
 8Yx5V4Y3CEY/9SCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB2D5136E5;
 Wed, 17 Jul 2024 13:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CfPhK4rHl2a8cgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jul 2024 13:30:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: Re: [PATCH v5 08/13] migration/multifd: Add new migration option
 for multifd DSA offloading.
In-Reply-To: <20240711215244.19237-9-yichen.wang@bytedance.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711215244.19237-9-yichen.wang@bytedance.com>
Date: Wed, 17 Jul 2024 10:30:48 -0300
Message-ID: <87v8142liv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> From: Hao Xiang <hao.xiang@linux.dev>
>
> Intel DSA offloading is an optional feature that turns on if
> proper hardware and software stack is available. To turn on
> DSA offloading in multifd live migration:
>
> dsa-accel-path="[dsa_dev_path1] [dsa_dev_path2] ... [dsa_dev_pathX]"
>
> This feature is turned off by default.
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  migration/migration-hmp-cmds.c | 15 ++++++++++-
>  migration/options.c            | 47 ++++++++++++++++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 32 ++++++++++++++++++++---
>  4 files changed, 90 insertions(+), 5 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7d608d26e1..c422db4ecd 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -312,7 +312,16 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>              params->tls_authz);
> -
> +        if (params->has_dsa_accel_path) {
> +            strList *dsa_accel_path = params->dsa_accel_path;
> +            monitor_printf(mon, "%s:",
> +                MigrationParameter_str(MIGRATION_PARAMETER_DSA_ACCEL_PATH));
> +            while (dsa_accel_path) {
> +                monitor_printf(mon, " %s", dsa_accel_path->value);
> +                dsa_accel_path = dsa_accel_path->next;
> +            }
> +            monitor_printf(mon, "\n");
> +        }
>          if (params->has_block_bitmap_mapping) {
>              const BitmapMigrationNodeAliasList *bmnal;
>  
> @@ -563,6 +572,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_x_checkpoint_delay = true;
>          visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
>          break;
> +    case MIGRATION_PARAMETER_DSA_ACCEL_PATH:
> +        p->has_dsa_accel_path = true;
> +        visit_type_strList(v, param, &p->dsa_accel_path, &err);
> +        break;
>      case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
>          p->has_multifd_channels = true;
>          visit_type_uint8(v, param, &p->multifd_channels, &err);
> diff --git a/migration/options.c b/migration/options.c
> index 645f55003d..f839493016 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -29,6 +29,7 @@
>  #include "ram.h"
>  #include "options.h"
>  #include "sysemu/kvm.h"
> +#include <cpuid.h>
>  
>  /* Maximum migrate downtime set to 2000 seconds */
>  #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
> @@ -162,6 +163,10 @@ Property migration_properties[] = {
>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
>                         parameters.zero_page_detection,
>                         ZERO_PAGE_DETECTION_MULTIFD),
> +    /* DEFINE_PROP_ARRAY("dsa-accel-path", MigrationState, x, */
> +    /*                    parameters.dsa_accel_path, qdev_prop_string, char *), */
> +    /* DEFINE_PROP_STRING("dsa-accel-path", MigrationState, */
> +    /*                    parameters.dsa_accel_path), */
>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -815,6 +820,13 @@ const char *migrate_tls_creds(void)
>      return s->parameters.tls_creds;
>  }
>  
> +const strList *migrate_dsa_accel_path(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.dsa_accel_path;
> +}
> +
>  const char *migrate_tls_hostname(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -926,6 +938,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->zero_page_detection = s->parameters.zero_page_detection;
>      params->has_direct_io = true;
>      params->direct_io = s->parameters.direct_io;
> +    params->dsa_accel_path = QAPI_CLONE(strList, s->parameters.dsa_accel_path);
>  
>      return params;
>  }
> @@ -934,6 +947,7 @@ void migrate_params_init(MigrationParameters *params)
>  {
>      params->tls_hostname = g_strdup("");
>      params->tls_creds = g_strdup("");
> +    params->dsa_accel_path = NULL;
>  
>      /* Set has_* up only for parameter checks */
>      params->has_throttle_trigger_threshold = true;
> @@ -1137,6 +1151,22 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    if (params->has_zero_page_detection &&
> +        params->zero_page_detection == ZERO_PAGE_DETECTION_DSA_ACCEL) {
> +#ifdef CONFIG_DSA_OPT
> +        unsigned int eax, ebx, ecx, edx;
> +        /* ENQCMD is indicated by bit 29 of ecx in CPUID leaf 7, subleaf 0. */
> +        if (!__get_cpuid_count(7, 0, &eax, &ebx, &ecx, &edx) ||
> +            !(ecx & (1 << 29))) {
> +            error_setg(errp, "DSA acceleration is not supported by CPU");
> +            return false;
> +        }

This should be a function along with the others in dsa.h, then you
wouldn't need the ifdef here.

> +#else
> +        error_setg(errp, "DSA acceleration is not enabled");
> +        return false;
> +#endif
> +    }
> +
>      return true;
>  }
>  
> @@ -1247,6 +1277,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_direct_io) {
>          dest->direct_io = params->direct_io;
>      }
> +
> +    if (params->has_dsa_accel_path) {
> +        dest->has_dsa_accel_path = true;
> +        dest->dsa_accel_path = params->dsa_accel_path;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -1376,6 +1411,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_direct_io) {
>          s->parameters.direct_io = params->direct_io;
>      }
> +    if (params->has_dsa_accel_path) {
> +        qapi_free_strList(s->parameters.dsa_accel_path);
> +        s->parameters.has_dsa_accel_path = true;
> +        s->parameters.dsa_accel_path =
> +            QAPI_CLONE(strList, params->dsa_accel_path);
> +    }
>  }
>  
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> @@ -1401,6 +1442,12 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>          params->tls_authz->type = QTYPE_QSTRING;
>          params->tls_authz->u.s = strdup("");
>      }
> +    /* if (params->dsa_accel_path */
> +    /*     && params->dsa_accel_path->type == QTYPE_QNULL) { */
> +    /*     qobject_unref(params->dsa_accel_path->u.n); */
> +    /*     params->dsa_accel_path->type = QTYPE_QLIST; */
> +    /*     params->dsa_accel_path->u.s = strdup(""); */
> +    /* } */
>  
>      migrate_params_test_apply(params, &tmp);
>  
> diff --git a/migration/options.h b/migration/options.h
> index a2397026db..78b9e4080b 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -85,6 +85,7 @@ const char *migrate_tls_creds(void);
>  const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
> +const strList *migrate_dsa_accel_path(void);
>  
>  /* parameters helpers */
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 1234bef888..ff41780347 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -619,10 +619,14 @@
>  #     multifd migration is enabled, else in the main migration thread
>  #     as for @legacy.
>  #
> +# @dsa-accel: Perform zero page checking with the DSA accelerator
> +#     offloading in multifd sender thread if multifd migration is
> +#     enabled, else in the main migration thread as for @legacy.
> +#
>  # Since: 9.0
>  ##
>  { 'enum': 'ZeroPageDetection',
> -  'data': [ 'none', 'legacy', 'multifd' ] }
> +  'data': [ 'none', 'legacy', 'multifd', 'dsa-accel' ] }
>  
>  ##
>  # @BitmapMigrationBitmapAliasTransform:
> @@ -825,6 +829,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @dsa-accel-path: If enabled, use DSA accelerator offloading for
> +#     certain memory operations. Enable DSA accelerator for zero
> +#     page detection offloading by setting the @zero-page-detection
> +#     to dsa-accel. This parameter defines the dsa device path, and
> +#     defaults to an empty list. (since 9.2)
> +#
>  # @direct-io: Open migration files with O_DIRECT when possible.  This
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
> @@ -843,7 +853,7 @@
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'cpu-throttle-tailslow',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> -           'avail-switchover-bandwidth', 'downtime-limit',
> +           'avail-switchover-bandwidth', 'downtime-limit', 'dsa-accel-path',
>             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> @@ -1000,6 +1010,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @dsa-accel-path: If enabled, use DSA accelerator offloading for
> +#     certain memory operations. Enable DSA accelerator for zero
> +#     page detection offloading by setting the @zero-page-detection
> +#     to dsa-accel. This parameter defines the dsa device path, and
> +#     defaults to an empty list. (since 9.2)
> +#
>  # @direct-io: Open migration files with O_DIRECT when possible.  This
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
> @@ -1044,7 +1060,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*dsa-accel-path': ['str'] } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1204,6 +1221,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @dsa-accel-path: If enabled, use DSA accelerator offloading for
> +#     certain memory operations. Enable DSA accelerator for zero
> +#     page detection offloading by setting the @zero-page-detection
> +#     to dsa-accel. This parameter defines the dsa device path, and
> +#     defaults to an empty list. (since 9.2)
> +#
>  # @direct-io: Open migration files with O_DIRECT when possible.  This
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
> @@ -1245,7 +1268,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*dsa-accel-path': ['str'] } }
>  
>  ##
>  # @query-migrate-parameters:

