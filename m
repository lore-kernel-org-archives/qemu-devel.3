Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550E2C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 11:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgjxI-0004HW-0g; Wed, 21 Aug 2024 07:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sgjxD-0004FO-Nt
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sgjxA-0003g8-Gq
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724241396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FTk8NqyEH/ClGTImGEZhfmhQdhqhqGIIJFGatRNRaAo=;
 b=Ip7KIW2CpmSX05bhvtekYdPW9FsKXBYxsHbknMncI0A9DqVzjtg/HDaWKnQkA5x2xhPDoO
 RZLbxKQZuavx648YkJQtcNs4uYHCf3XZUMXX2jWBMOdYD7mi+oT435xnencLNZSjTC6mSs
 qN+8889U/geplDW4YEflS9NJ/1ieS2c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-CBnDwyXvOzGwWl5zed_mfw-1; Wed, 21 Aug 2024 07:56:35 -0400
X-MC-Unique: CBnDwyXvOzGwWl5zed_mfw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-371ab0c02e0so3131171f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 04:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724241394; x=1724846194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FTk8NqyEH/ClGTImGEZhfmhQdhqhqGIIJFGatRNRaAo=;
 b=QDIMtT+6j0nQlVKnr7H9Vch9JCJuu6ZrN4Clw2qmsh1KK/NQQ1OO5x41Tj5LnDCjQF
 pdhbKqpaMiUtVFCAAqiQGuq3UDNkQmDPNGOQkjGGSISP5HwhE5dZk0bJgZM1gNV76ZLV
 CJZZwpES/6hAVwt6kQKEZ6W2V3aFFoLGVYPM5wpF9pGri2Vc9jnZa9Ti1WqR0/a5ROxj
 ZAGkcksecVfEJVGXOjZJD3CFVxRf+hihrSsS3DoCufq2cOehT/klfBvFSPr3Pqj3iJj9
 6EIG/WCuzuD1Ik/lgIh5MANdcvOh5Xsb9/bEO3l3CbrpZgaxLdePS0A3VJWjKhXyXlX4
 BX8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8RqILuM8+59k9Cfx5mZTM9RABGFDsgwRJirDvzcm7pYZ03ATZ1PWRFIHun1vK5Ok33yD59Jv9zeJ0@nongnu.org
X-Gm-Message-State: AOJu0YyzjE6+x9DhxEqsHH4am57WU9qPSx2K7e0jP8TacysHcQAehvh1
 xzGBxxZoZhagz5Sa7bPf48+LLZv0RgjjCSw4XB/1G7sV2TOZ0Gwj262Wv5xEW2jODAVU/4lM8dU
 /PvDQGdBgjayQChvK9j7YVq2eIA67qEovad6TlVMKwniPrKFXpuwppAkI+MS0jbJzf9J3MgtoTf
 v29ppGMqkylHp1cTxVLaWLWlGXl3s=
X-Received: by 2002:a5d:5905:0:b0:371:8e85:c58e with SMTP id
 ffacd0b85a97d-372fd5b9191mr1601346f8f.33.1724241394111; 
 Wed, 21 Aug 2024 04:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI43RXtF50+ldSepP/Ckx9pYGuDR7XB/tqb1AW6TggI58xvDnxuDRNdFC0ON8rmmH2L7qr591zgigYM6uOEjs=
X-Received: by 2002:a5d:5905:0:b0:371:8e85:c58e with SMTP id
 ffacd0b85a97d-372fd5b9191mr1601322f8f.33.1724241393559; Wed, 21 Aug 2024
 04:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240820170907.6788-1-yichen.wang@bytedance.com>
 <20240820170907.6788-4-yichen.wang@bytedance.com>
In-Reply-To: <20240820170907.6788-4-yichen.wang@bytedance.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 21 Aug 2024 17:26:16 +0530
Message-ID: <CAE8KmOypgmrWR6dxAz7iQ=3k+fTXSMKs6kUTUdRisGcq22p8Pw@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] migration: Add migration parameters for QATzip
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, 
 Xiaoning Ding <xiaoning.ding@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 20 Aug 2024 at 22:40, Yichen Wang <yichen.wang@bytedance.com> wrote:
> Adds support for migration parameters to control QATzip compression
> level and to enable/disable software fallback when QAT hardware is
> unavailable. This is a preparatory commit for a subsequent commit that
> will actually use QATzip compression.

* Is the check whether "QAT hardware is available" happening in this
patch? (I couldn't spot it).
* The informatory notice "This is a preparatory commit for..." could
be moved to the cover-letter, instead of commit message. (Not sure how
it helps to log it in git history)

> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
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
> index 7324571e92..f4c27426c8 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -792,6 +792,11 @@
>  #     speed, and 9 means best compression ratio which will consume
>  #     more CPU.  Defaults to 1.  (Since 5.0)
>  #
> +# @multifd-qatzip-level: Set the compression level to be used in live
> +#     migration. The level is an integer between 1 and 9, where 1 means
> +#     the best compression speed, and 9 means the best compression
> +#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
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
> +#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
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
> +#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
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
> --
> Yichen Wang

'multifd-qatzip-level' related changes look okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


