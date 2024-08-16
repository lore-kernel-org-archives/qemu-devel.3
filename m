Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B09EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0g7-00017D-SH; Fri, 16 Aug 2024 13:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sf0g6-00010m-Lx
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:23:54 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sf0g4-0000nO-EX
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:23:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FD972236A;
 Fri, 16 Aug 2024 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723829030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=20qlFlTkBshADSj75CYRAC0CfCbEaY5rEVddDoMDiRA=;
 b=C3xxB4xb38GnRfGJT59jsRCXmEAKWKtftC4Ixgu/tJyYyEKbVNiZDfDIuMRCPhzkDN74sQ
 xInoasT426Glq1qqqXKdYi3L2PQz9a5Aee2vSJkF3bH4cRirvZuXBpjpdpIz5QwKTkXBnx
 5cS02Bp/dv5yM6luEu3iELepAW/j0Kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723829030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=20qlFlTkBshADSj75CYRAC0CfCbEaY5rEVddDoMDiRA=;
 b=YAAsrmE0EPkilJUhiUjEIb9/hv8Vvl244f/0n6eEpevX2Um+PJM+UN6HuO9R8shZvkSAhm
 wxE1JQXk7+o2zOAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723829029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=20qlFlTkBshADSj75CYRAC0CfCbEaY5rEVddDoMDiRA=;
 b=ComzcGX8J6qAznui1zByVVZ82WCk9Y4DirNJTbizHowsyM+TmFppge/t2BhD+xYNc3v2Eb
 KplEnUs52AcnNGQzg4IcMM6vLXX5W9EdnZl/BZYeg6k7AS1j4ZojSQhxkWAUic4UiL/au6
 AQsAV2N2ZUd1ttlwgq5w7dVyCkZbQjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723829029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=20qlFlTkBshADSj75CYRAC0CfCbEaY5rEVddDoMDiRA=;
 b=ig70KSbKzQgGlSzRKo3LIcruguNE1aItvMV1XYZe40pnme5ytU7y52IQMs6HiAWMnCJUHb
 WW/RlpZY/RVu5BDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 101231379A;
 Fri, 16 Aug 2024 17:23:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3IovMiSLv2ZoOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 16 Aug 2024 17:23:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v7 3/5] migration: Add migration parameters for QATzip
In-Reply-To: <20240815002124.65384-4-yichen.wang@bytedance.com>
References: <20240815002124.65384-1-yichen.wang@bytedance.com>
 <20240815002124.65384-4-yichen.wang@bytedance.com>
Date: Fri, 16 Aug 2024 14:23:46 -0300
Message-ID: <87o75s5ql9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, linux.dev:email,
 imap1.dmz-prg2.suse.org:helo, bytedance.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> From: Bryan Zhang <bryan.zhang@bytedance.com>
>
> Adds support for migration parameters to control QATzip compression
> level and to enable/disable software fallback when QAT hardware is
> unavailable. This is a preparatory commit for a subsequent commit that
> will actually use QATzip compression.
>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/migration-hmp-cmds.c |  4 ++++
>  migration/options.c            | 34 ++++++++++++++++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 18 ++++++++++++++++++
>  4 files changed, 57 insertions(+)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7d608d26e1..28165cfc9e 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -576,6 +576,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_multifd_zlib_level = true;
>          visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
>          break;
> +    case MIGRATION_PARAMETER_MULTIFD_QATZIP_LEVEL:
> +        p->has_multifd_qatzip_level = true;
> +        visit_type_uint8(v, param, &p->multifd_qatzip_level, &err);
> +        break;
>      case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
>          p->has_multifd_zstd_level = true;
>          visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
> diff --git a/migration/options.c b/migration/options.c
> index 645f55003d..147cd2b8fd 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -55,6 +55,13 @@
>  #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
>  /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
>  #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
> +/*
> + * 1: best speed, ... 9: best compress ratio
> + * There is some nuance here. Refer to QATzip documentation to understand
> + * the mapping of QATzip levels to standard deflate levels.
> + */
> +#define DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL 1
> +
>  /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
>  #define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
>  
> @@ -123,6 +130,9 @@ Property migration_properties[] = {
>      DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
>                        parameters.multifd_zlib_level,
>                        DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
> +    DEFINE_PROP_UINT8("multifd-qatzip-level", MigrationState,
> +                      parameters.multifd_qatzip_level,
> +                      DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
>      DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
>                        parameters.multifd_zstd_level,
>                        DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
> @@ -787,6 +797,13 @@ int migrate_multifd_zlib_level(void)
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
>  int migrate_multifd_zstd_level(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -892,6 +909,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->multifd_compression = s->parameters.multifd_compression;
>      params->has_multifd_zlib_level = true;
>      params->multifd_zlib_level = s->parameters.multifd_zlib_level;
> +    params->has_multifd_qatzip_level = true;
> +    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
>      params->has_multifd_zstd_level = true;
>      params->multifd_zstd_level = s->parameters.multifd_zstd_level;
>      params->has_xbzrle_cache_size = true;
> @@ -946,6 +965,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_multifd_channels = true;
>      params->has_multifd_compression = true;
>      params->has_multifd_zlib_level = true;
> +    params->has_multifd_qatzip_level = true;
>      params->has_multifd_zstd_level = true;
>      params->has_xbzrle_cache_size = true;
>      params->has_max_postcopy_bandwidth = true;
> @@ -1038,6 +1058,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
> @@ -1195,6 +1223,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_multifd_compression) {
>          dest->multifd_compression = params->multifd_compression;
>      }
> +    if (params->has_multifd_qatzip_level) {
> +        dest->multifd_qatzip_level = params->multifd_qatzip_level;
> +    }
>      if (params->has_multifd_zlib_level) {
>          dest->multifd_zlib_level = params->multifd_zlib_level;
>      }
> @@ -1315,6 +1346,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_multifd_compression) {
>          s->parameters.multifd_compression = params->multifd_compression;
>      }
> +    if (params->has_multifd_qatzip_level) {
> +        s->parameters.multifd_qatzip_level = params->multifd_qatzip_level;
> +    }
>      if (params->has_multifd_zlib_level) {
>          s->parameters.multifd_zlib_level = params->multifd_zlib_level;
>      }
> diff --git a/migration/options.h b/migration/options.h
> index a2397026db..a0bd6edc06 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -78,6 +78,7 @@ uint64_t migrate_max_postcopy_bandwidth(void);
>  int migrate_multifd_channels(void);
>  MultiFDCompression migrate_multifd_compression(void);
>  int migrate_multifd_zlib_level(void);
> +int migrate_multifd_qatzip_level(void);
>  int migrate_multifd_zstd_level(void);
>  uint8_t migrate_throttle_trigger_threshold(void);
>  const char *migrate_tls_authz(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7324571e92..279a705cae 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -792,6 +792,11 @@
>  #     speed, and 9 means best compression ratio which will consume
>  #     more CPU.  Defaults to 1.  (Since 5.0)
>  #
> +# @multifd-qatzip-level: Set the compression level to be used in live
> +#     migration. The level is an integer between 1 and 9, where 1 means
> +#     the best compression speed, and 9 means the best compression
> +#     ratio which will consume more CPU. Defaults to 1. (Since 9.1)

Double space after periods please.

Since 9.2

> +#
>  # @multifd-zstd-level: Set the compression level to be used in live
>  #     migration, the compression level is an integer between 0 and 20,
>  #     where 0 means no compression, 1 means the best compression
> @@ -852,6 +857,7 @@
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
>             'max-cpu-throttle', 'multifd-compression',
>             'multifd-zlib-level', 'multifd-zstd-level',
> +           'multifd-qatzip-level',
>             'block-bitmap-mapping',
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>             'vcpu-dirty-limit',
> @@ -967,6 +973,11 @@
>  #     speed, and 9 means best compression ratio which will consume
>  #     more CPU.  Defaults to 1.  (Since 5.0)
>  #
> +# @multifd-qatzip-level: Set the compression level to be used in live
> +#     migration. The level is an integer between 1 and 9, where 1 means
> +#     the best compression speed, and 9 means the best compression
> +#     ratio which will consume more CPU. Defaults to 1. (Since 9.1)

same here

> +#
>  # @multifd-zstd-level: Set the compression level to be used in live
>  #     migration, the compression level is an integer between 0 and 20,
>  #     where 0 means no compression, 1 means the best compression
> @@ -1040,6 +1051,7 @@
>              '*max-cpu-throttle': 'uint8',
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
> +            '*multifd-qatzip-level': 'uint8',
>              '*multifd-zstd-level': 'uint8',
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> @@ -1171,6 +1183,11 @@
>  #     speed, and 9 means best compression ratio which will consume
>  #     more CPU.  Defaults to 1.  (Since 5.0)
>  #
> +# @multifd-qatzip-level: Set the compression level to be used in live
> +#     migration. The level is an integer between 1 and 9, where 1 means
> +#     the best compression speed, and 9 means the best compression
> +#     ratio which will consume more CPU. Defaults to 1. (Since 9.1)

same here

> +#
>  # @multifd-zstd-level: Set the compression level to be used in live
>  #     migration, the compression level is an integer between 0 and 20,
>  #     where 0 means no compression, 1 means the best compression
> @@ -1241,6 +1258,7 @@
>              '*max-cpu-throttle': 'uint8',
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
> +            '*multifd-qatzip-level': 'uint8',
>              '*multifd-zstd-level': 'uint8',
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',

