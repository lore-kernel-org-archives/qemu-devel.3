Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C1CCD128D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 15:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrJcn-0001zs-06; Mon, 01 Apr 2024 11:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rrJcg-0001yj-OS
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 11:30:59 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rrJce-0003a1-9z
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 11:30:58 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B03BA33B8A;
 Mon,  1 Apr 2024 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711985453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UXKBe9dWAPxBzmYFE92qAyyfP4RvD54YTepsQYRn/K0=;
 b=vPX5+NjfLFXPcCgRRTyUOuTRRZ7ocQ6J//iXvz7OaOHjHZ+IolO/7RC52iFGFrG1Ra7FqR
 MnuuDnyGJypxyk56gXPX72ki51+SIK0FPiIU3U0q5zfjBhys6TnCyBLkhCY0Zk09KnOevg
 xLKQkYTbg8jcoz4tlpbzqDbKJwTWC80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711985453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UXKBe9dWAPxBzmYFE92qAyyfP4RvD54YTepsQYRn/K0=;
 b=1Ywnqk/0qE/WDUCctphPo6gr74Gt+nvZAIBcbcJ6DkAOwTbsdhcFlexVqfRXqt53AAmsv5
 jBjjCKuEwMzDi+Cg==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B2041348C;
 Mon,  1 Apr 2024 15:30:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id CW4ZAS3TCma8SwAAn2gu4w
 (envelope-from <farosas@suse.de>); Mon, 01 Apr 2024 15:30:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bryan Zhang <bryan.zhang@bytedance.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, yuan1.liu@intel.com, berrange@redhat.com,
 nanhai.zou@intel.com, hao.xiang@linux.dev, Bryan Zhang
 <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v2 2/5] migration: Add migration parameters for QATzip
In-Reply-To: <20240326224221.3623014-3-bryan.zhang@bytedance.com>
References: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
 <20240326224221.3623014-3-bryan.zhang@bytedance.com>
Date: Mon, 01 Apr 2024 12:30:50 -0300
Message-ID: <87o7atrtg5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

Bryan Zhang <bryan.zhang@bytedance.com> writes:

> Adds support for migration parameters to control QATzip compression
> level and to enable/disable software fallback when QAT hardware is
> unavailable. This is a preparatory commit for a subsequent commit that
> will actually use QATzip compression.
>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> ---
> Revision: This commit now includes a parameter for controlling software
> fallback. Fallback is generally intended to be disabled, but having this
> option available enables using software fallback for testing.
>
> This commit also now has some glue code to properly set parameters.
>
>  migration/migration-hmp-cmds.c |  8 +++++
>  migration/options.c            | 57 ++++++++++++++++++++++++++++++++++
>  migration/options.h            |  2 ++
>  qapi/migration.json            | 35 +++++++++++++++++++++
>  4 files changed, 102 insertions(+)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 99b49df5dd..4bd23ba14d 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -630,6 +630,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_multifd_zlib_level = true;
>          visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
>          break;
> +    case MIGRATION_PARAMETER_MULTIFD_QATZIP_LEVEL:
> +        p->has_multifd_qatzip_level = true;
> +        visit_type_uint8(v, param, &p->multifd_qatzip_level, &err);
> +        break;
> +    case MIGRATION_PARAMETER_MULTIFD_QATZIP_SW_FALLBACK:
> +        p->has_multifd_qatzip_sw_fallback = true;
> +        visit_type_bool(v, param, &p->multifd_qatzip_sw_fallback, &err);
> +        break;
>      case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
>          p->has_multifd_zstd_level = true;
>          visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
> diff --git a/migration/options.c b/migration/options.c
> index 3e3e0b93b4..1316ea605a 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -62,6 +62,15 @@
>  #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
>  /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
>  #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
> +/*
> + * 1: best speed, ... 9: best compress ratio
> + * There is some nuance here. Refer to QATzip documentation to understand
> + * the mapping of QATzip levels to standard deflate levels.
> + */
> +#define DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL 1
> +/* QATzip's SW fallback implementation is extremely slow, so avoid fallback */
> +#define DEFAULT_MIGRATE_MULTIFD_QATZIP_SW_FALLBACK false
> +
>  /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
>  #define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
>  
> @@ -143,6 +152,12 @@ Property migration_properties[] = {
>      DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
>                        parameters.multifd_zlib_level,
>                        DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
> +    DEFINE_PROP_UINT8("multifd-qatzip-level", MigrationState,
> +                      parameters.multifd_qatzip_level,
> +                      DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
> +    DEFINE_PROP_BOOL("multifd-qatzip-sw-fallback", MigrationState,
> +                      parameters.multifd_qatzip_sw_fallback,
> +                      DEFAULT_MIGRATE_MULTIFD_QATZIP_SW_FALLBACK),
>      DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
>                        parameters.multifd_zstd_level,
>                        DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
> @@ -861,6 +876,20 @@ int migrate_multifd_zlib_level(void)
>      return s->parameters.multifd_zlib_level;
>  }
>  
> +int migrate_multifd_qatzip_level(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.multifd_qatzip_level;
> +}
> +
> +bool migrate_multifd_qatzip_sw_fallback(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.multifd_qatzip_sw_fallback;
> +}
> +
>  int migrate_multifd_zstd_level(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -983,6 +1012,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->multifd_compression = s->parameters.multifd_compression;
>      params->has_multifd_zlib_level = true;
>      params->multifd_zlib_level = s->parameters.multifd_zlib_level;
> +    params->has_multifd_qatzip_level = true;
> +    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
> +    params->has_multifd_qatzip_sw_fallback = true;
> +    params->multifd_qatzip_sw_fallback =
> +        s->parameters.multifd_qatzip_sw_fallback;
>      params->has_multifd_zstd_level = true;
>      params->multifd_zstd_level = s->parameters.multifd_zstd_level;
>      params->has_xbzrle_cache_size = true;
> @@ -1038,6 +1072,8 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_multifd_channels = true;
>      params->has_multifd_compression = true;
>      params->has_multifd_zlib_level = true;
> +    params->has_multifd_qatzip_level = true;
> +    params->has_multifd_qatzip_sw_fallback = true;
>      params->has_multifd_zstd_level = true;
>      params->has_xbzrle_cache_size = true;
>      params->has_max_postcopy_bandwidth = true;
> @@ -1147,6 +1183,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    if (params->has_multifd_qatzip_level &&
> +        ((params->multifd_qatzip_level > 9) ||
> +        (params->multifd_qatzip_level < 1))) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_qatzip_level",
> +                   "a value between 1 and 9");
> +        return false;
> +    }
> +
>      if (params->has_multifd_zstd_level &&
>          (params->multifd_zstd_level > 20)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_level",
> @@ -1312,6 +1356,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_multifd_compression) {
>          dest->multifd_compression = params->multifd_compression;
>      }
> +    if (params->has_multifd_qatzip_level) {
> +        dest->multifd_qatzip_level = params->multifd_qatzip_level;
> +    }
> +    if (params->has_multifd_qatzip_sw_fallback) {
> +        dest->multifd_qatzip_sw_fallback = params->multifd_qatzip_sw_fallback;
> +    }
>      if (params->has_xbzrle_cache_size) {
>          dest->xbzrle_cache_size = params->xbzrle_cache_size;
>      }
> @@ -1447,6 +1497,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_multifd_compression) {
>          s->parameters.multifd_compression = params->multifd_compression;
>      }
> +    if (params->has_multifd_qatzip_level) {
> +        s->parameters.multifd_qatzip_level = params->multifd_qatzip_level;
> +    }
> +    if (params->has_multifd_qatzip_sw_fallback) {
> +        s->parameters.multifd_qatzip_sw_fallback =
> +            params->multifd_qatzip_sw_fallback;
> +    }
>      if (params->has_xbzrle_cache_size) {
>          s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
>          xbzrle_cache_resize(params->xbzrle_cache_size, errp);
> diff --git a/migration/options.h b/migration/options.h
> index 246c160aee..94aee24d97 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -87,6 +87,8 @@ MigMode migrate_mode(void);
>  int migrate_multifd_channels(void);
>  MultiFDCompression migrate_multifd_compression(void);
>  int migrate_multifd_zlib_level(void);
> +int migrate_multifd_qatzip_level(void);
> +bool migrate_multifd_qatzip_sw_fallback(void);
>  int migrate_multifd_zstd_level(void);
>  uint8_t migrate_throttle_trigger_threshold(void);
>  const char *migrate_tls_authz(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 0b33a71ab4..66ea6d32fc 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -853,6 +853,16 @@
>  #     speed, and 9 means best compression ratio which will consume
>  #     more CPU. Defaults to 1. (Since 5.0)
>  #
> +# @multifd-qatzip-level: Set the compression level to be used in live
> +#     migration. The level is an integer between 1 and 9, where 1 means
> +#     the best compression speed, and 9 means the best compression
> +#     ratio which will consume more CPU. Defaults to 1.
> +#
> +# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
> +#     is unavailable. Defaults to false. Software fallback performance
> +#     is very poor compared to regular zlib, so be cautious about
> +#     enabling this option.
> +#
>  # @multifd-zstd-level: Set the compression level to be used in live
>  #     migration, the compression level is an integer between 0 and 20,
>  #     where 0 means no compression, 1 means the best compression
> @@ -915,6 +925,7 @@
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
>             'max-cpu-throttle', 'multifd-compression',
>             'multifd-zlib-level', 'multifd-zstd-level',
> +           'multifd-qatzip-level', 'multifd-qatzip-sw-fallback',
>             'block-bitmap-mapping',
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>             'vcpu-dirty-limit',
> @@ -1045,6 +1056,16 @@
>  #     speed, and 9 means best compression ratio which will consume
>  #     more CPU. Defaults to 1. (Since 5.0)
>  #
> +# @multifd-qatzip-level: Set the compression level to be used in live
> +#     migration. The level is an integer between 1 and 9, where 1 means
> +#     the best compression speed, and 9 means the best compression
> +#     ratio which will consume more CPU. Defaults to 1.

(Since 9.1)

> +#
> +# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
> +#     is unavailable. Defaults to false. Software fallback performance
> +#     is very poor compared to regular zlib, so be cautious about
> +#     enabling this option.

(Since 9.1)

> +#
>  # @multifd-zstd-level: Set the compression level to be used in live
>  #     migration, the compression level is an integer between 0 and 20,
>  #     where 0 means no compression, 1 means the best compression
> @@ -1125,6 +1146,8 @@
>              '*max-cpu-throttle': 'uint8',
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
> +            '*multifd-qatzip-level': 'uint8',
> +            '*multifd-qatzip-sw-fallback': 'bool',
>              '*multifd-zstd-level': 'uint8',
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> @@ -1273,6 +1296,16 @@
>  #     speed, and 9 means best compression ratio which will consume
>  #     more CPU. Defaults to 1. (Since 5.0)
>  #
> +# @multifd-qatzip-level: Set the compression level to be used in live
> +#     migration. The level is an integer between 1 and 9, where 1 means
> +#     the best compression speed, and 9 means the best compression
> +#     ratio which will consume more CPU. Defaults to 1.

(Since 9.1)

> +#
> +# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
> +#     is unavailable. Defaults to false. Software fallback performance
> +#     is very poor compared to regular zlib, so be cautious about
> +#     enabling this option.

(Since 9.1)

> +#
>  # @multifd-zstd-level: Set the compression level to be used in live
>  #     migration, the compression level is an integer between 0 and 20,
>  #     where 0 means no compression, 1 means the best compression
> @@ -1350,6 +1383,8 @@
>              '*max-cpu-throttle': 'uint8',
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
> +            '*multifd-qatzip-level': 'uint8',
> +            '*multifd-qatzip-sw-fallback': 'bool',
>              '*multifd-zstd-level': 'uint8',
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',

