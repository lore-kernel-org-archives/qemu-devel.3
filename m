Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5380BCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 15:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzcuY-0001ll-Pw; Fri, 19 Sep 2025 11:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzcuW-0001kI-HB
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:20:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzcuT-0000LE-2h
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:20:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7BFDF1F747;
 Fri, 19 Sep 2025 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758295224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WnOocnbU2YqwdnuknIlHoL/tGQ5Uh2v0tZMjGw3NDEc=;
 b=lLKCucn7jyD+b5Y2/V8yHjvccXqw312J9mXzsUYzkNUvgFXvr+2deMOCtwntbaxjS03xDZ
 chK2CWTYSQIQh/fHDLGm9HU6pdy+g9Tg2eo1k/dkOlq0bSHSQmihXbJjQVLJOba40f4Hup
 q2rlwdUfBQDBXT8kSfYTxSieZfmul6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758295224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WnOocnbU2YqwdnuknIlHoL/tGQ5Uh2v0tZMjGw3NDEc=;
 b=O+XMn6pz+BbfTLlaCSCtw+ZCqmF5yATLiWZ/ViUWyKKKnDkf0REXuSj+0XkStrz3sMGuhB
 Sqk1ZfPoE53UdIBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758295224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WnOocnbU2YqwdnuknIlHoL/tGQ5Uh2v0tZMjGw3NDEc=;
 b=lLKCucn7jyD+b5Y2/V8yHjvccXqw312J9mXzsUYzkNUvgFXvr+2deMOCtwntbaxjS03xDZ
 chK2CWTYSQIQh/fHDLGm9HU6pdy+g9Tg2eo1k/dkOlq0bSHSQmihXbJjQVLJOba40f4Hup
 q2rlwdUfBQDBXT8kSfYTxSieZfmul6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758295224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WnOocnbU2YqwdnuknIlHoL/tGQ5Uh2v0tZMjGw3NDEc=;
 b=O+XMn6pz+BbfTLlaCSCtw+ZCqmF5yATLiWZ/ViUWyKKKnDkf0REXuSj+0XkStrz3sMGuhB
 Sqk1ZfPoE53UdIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E197213A78;
 Fri, 19 Sep 2025 15:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l643KLd0zWjzPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Sep 2025 15:20:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 peterx@redhat.com, berrange@redhat.com, jasowang@redhat.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v5 16/19] qapi: add interface for local TAP migration
In-Reply-To: <20250919095545.1912042-17-vsementsov@yandex-team.ru>
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
 <20250919095545.1912042-17-vsementsov@yandex-team.ru>
Date: Fri, 19 Sep 2025 12:20:21 -0300
Message-ID: <87y0qatqoa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

Hi Vladimir, as usual with "qapi:" patches, some comments about
language:

> To migrate virtio-net TAP device backend (including open fds) locally,
> user should simply set migration parameter
>
>    fds = [virtio-net]
>
> Why not simple boolean? To simplify migration to further versions,
> when more devices will support fds migration.
>
> Alternatively, we may add per-device option to disable fds-migration,
> but still:
>
> 1. It's more comfortable to set same capabilities/parameters on both
> source and target QEMU, than care about each device.
>
> 2. To not break the design, that machine-type + device options +
> migration capabilites and parameters are fully define the resulting
> migration stream. We'll break this if add in future more fds-passing
> support in devices under same fds=true parameter.
>

These arguments look convincing to me.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/qapi/util.h | 17 +++++++++++++++++
>  migration/options.c | 30 +++++++++++++++++++++++++++++
>  migration/options.h |  2 ++
>  qapi/migration.json | 46 ++++++++++++++++++++++++++++++++++++---------
>  4 files changed, 86 insertions(+), 9 deletions(-)
>
> diff --git a/include/qapi/util.h b/include/qapi/util.h
> index 29bc4eb865..b953402416 100644
> --- a/include/qapi/util.h
> +++ b/include/qapi/util.h
> @@ -69,4 +69,21 @@ int parse_qapi_name(const char *name, bool complete);
>          _len;                                                       \
>      })
>  
> +/*
> + * For any GenericList @list, return true if it contains specified
> + * element.
> + */
> +#define QAPI_LIST_CONTAINS(list, el)                                \
> +    ({                                                              \
> +        bool _found = false;                                        \
> +        typeof_strip_qual(list) _tail;                              \
> +        for (_tail = list; _tail != NULL; _tail = _tail->next) {    \
> +            if (_tail->value == el) {                               \
> +                _found = true;                                      \
> +                break;                                              \
> +            }                                                       \
> +        }                                                           \
> +        _found;                                                     \
> +    })
> +
>  #endif
> diff --git a/migration/options.c b/migration/options.c
> index 4e923a2e07..061a1b8eaf 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -13,6 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qapi/util.h"
>  #include "exec/target_page.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> @@ -262,6 +263,13 @@ bool migrate_mapped_ram(void)
>      return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
>  }
>  
> +bool migrate_fds_virtio_net(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return QAPI_LIST_CONTAINS(s->parameters.fds, FDS_TARGET_VIRTIO_NET);
> +}
> +
>  bool migrate_ignore_shared(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -960,6 +968,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->has_direct_io = true;
>      params->direct_io = s->parameters.direct_io;
>  
> +    if (s->parameters.has_fds) {
> +        params->has_fds = true;
> +        params->fds = QAPI_CLONE(FdsTargetList, s->parameters.fds);
> +    }
> +
>      return params;
>  }
>  
> @@ -1179,6 +1192,11 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    if (params->has_fds) {
> +        error_setg(errp, "Not implemented");
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> @@ -1297,6 +1315,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_direct_io) {
>          dest->direct_io = params->direct_io;
>      }
> +
> +    if (params->has_fds) {
> +        dest->has_fds = true;

I think what you want is to set this in
migrate_params_init(). block_bitmap_mapping is a bit of an outlier in
that it takes an empty *input* as valid.

> +        dest->fds = params->fds;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -1429,6 +1452,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_direct_io) {
>          s->parameters.direct_io = params->direct_io;
>      }
> +
> +    if (params->has_fds) {
> +        qapi_free_FdsTargetList(s->parameters.fds);
> +
> +        s->parameters.has_fds = true;
> +        s->parameters.fds = QAPI_CLONE(FdsTargetList, params->fds);

Same here, has_fds should always be true in s->parameters.

> +    }
>  }
>  
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> diff --git a/migration/options.h b/migration/options.h
> index 82d839709e..a79472a235 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -87,6 +87,8 @@ const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
>  
> +bool migrate_fds_virtio_net(void);
> +
>  /* parameters helpers */
>  
>  bool migrate_params_check(MigrationParameters *params, Error **errp);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 2387c21e9c..6ef9629c6d 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -747,6 +747,19 @@
>        '*transform': 'BitmapMigrationBitmapAliasTransform'
>    } }
>  
> +##
> +# @FdsTarget:
> +#
> +# @virtio-net: Enable live backend migration for virtio-net.

So you're assuming normal migration is "non-live backend migration"
because the backend is stopped and started again on the destination. I
think it makes sense.

> +#     The only supported backend is TAP device. When enabled, TAP fds
> +#     and all related state is passed to target QEMU through migration
> +#     channel (which should be unix socket).
> +#
> +# Since: 10.2
> +##
> +{ 'enum': 'FdsTarget',
> +  'data': [ 'virtio-net' ] }
> +
>  ##
>  # @BitmapMigrationNodeAlias:
>  #
> @@ -924,10 +937,14 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @fds: List of targets to enable live-backend migration for. This
> +#     requires migration channel to be a unix socket (to pass fds
> +#     through). (Since 10.2)

I think I prefer live-backend as written here rather than the non
hyphenated version above. This clears up the ambiguity and can be used
in variable names, as a name for the feature and ... _thinks really
hard_ ... as the parameter name! (maybe)

On that note, fds is just too broad, I'm sure you know that, but to be
specific, we already have fd migration, multifd, fdset (as argument of
file: migration), etc. Talking just about the user interface here, of
course.

Also: "@fds: List of targets..." is super confusing.

And although "to pass fds through" is helping clarify the meaning of
@fds, it exposes implementation details on the QAPI, I don't think it's
relevant in the parameter description.

> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> -#     @x-vcpu-dirty-limit-period are experimental.
> +# @unstable: Members @x-checkpoint-delay,
> +#     @x-vcpu-dirty-limit-period and @fds are experimental.
>  #
>  # Since: 2.4
>  ##
> @@ -950,7 +967,8 @@
>             'vcpu-dirty-limit',
>             'mode',
>             'zero-page-detection',
> -           'direct-io'] }
> +           'direct-io',
> +           'fds' ] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1105,10 +1123,14 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @fds: List of targets to enable live-backend migration for. This
> +#     requires migration channel to be a unix socket (to pass fds
> +#     through). (Since 10.2)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> -#     @x-vcpu-dirty-limit-period are experimental.
> +# @unstable: Members @x-checkpoint-delay,
> +#     @x-vcpu-dirty-limit-period and @fds are experimental.
>  #
>  # TODO: either fuse back into `MigrationParameters`, or make
>  #     `MigrationParameters` members mandatory
> @@ -1146,7 +1168,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*fds': { 'type': [ 'FdsTarget' ], 'features': [ 'unstable' ] } } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1315,10 +1338,14 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @fds: List of targets to enable live-backend migration for. This
> +#     requires migration channel to be a unix socket (to pass fds
> +#     through). (Since 10.2)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> -#     @x-vcpu-dirty-limit-period are experimental.
> +# @unstable: Members @x-checkpoint-delay,
> +#     @x-vcpu-dirty-limit-period and @fds are experimental.
>  #
>  # Since: 2.4
>  ##
> @@ -1353,7 +1380,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*fds': { 'type': [ 'FdsTarget' ], 'features': [ 'unstable' ] } } }
>  
>  ##
>  # @query-migrate-parameters:

