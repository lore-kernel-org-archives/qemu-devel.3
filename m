Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B91FC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 20:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgsAf-0000xB-Sk; Wed, 21 Aug 2024 16:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgsAe-0000uP-Ac
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 16:43:08 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgsAb-0007Ir-Rf
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 16:43:08 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e116ec43a4aso188128276.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724272982; x=1724877782; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvlKJdxHwZ5vLjeXpNMwKiglICZBm6xxi7lMuayGeZ0=;
 b=jo7pBcgC6PzS1yfwGKu7qXaZ0AYZG3tMNkUo6n8T+y2EKPJp/Jg3Mv7IQL8UwgZ2x2
 uX17d2RK0IBwnoQHxuQIraBvoUTladpsha8+igbrtt/6xA8QShHKpqT/r3XA/S7ZqD6D
 UZcdHcZYy1ZCkw0f1oQ6VcsGR/txI1NUs5Mspfiy/9qOv76x4z2OKKvflV3mV+cQOjbT
 FUQfnRT1STp6wdxSdH3H69yr9GnKCufDylWby6uMQnXdp5JE3FXfkHQA9dI+7gekJgFK
 3hZ7PTeXPMjezXEU2XmJKs6GOkmR9tOQrzGcOzNDzv/s5c6PzaUNiIhs1fk++ANkA1QC
 HR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724272982; x=1724877782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvlKJdxHwZ5vLjeXpNMwKiglICZBm6xxi7lMuayGeZ0=;
 b=KcdQlc7LiPha98Siou7E/ZZ3LlA+imUJYzq/8keJGBlItBPtKTDmeIDUvnP/4kP0RT
 YiaeqqPpkjWwOvyBZHCbk1YjnDRnj4W1RD6c+CR5V68nYm1s+c8QOA0we0iUyTAjvEhL
 Wyknpj1GXsYMgyS2aDP5vdsI8rvVHvNvwAERq5may8uaaGd/MsknFnaoH3mfoS6ucl76
 3b3qW9JEOVKi0FC6IKKkuLN2c3GAc6vGicd7LEjJtVxRMKVj3Q/LI5s3dYQI3DxeajFz
 jA7CRxPRfSiduLZHbkwU5Axl9qWz28Os3Qh5Ane5qEDbKflgl+DWtGW7o98crmv9iOSP
 iUfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW8XrZxwpfF1vIWhtT+/Bc/U32RHDBCaj0cAR20K2mghe/Qmsybx7xMVtO7tFYU2H8ECKBDk570znW@nongnu.org
X-Gm-Message-State: AOJu0YyrovzxpgSWs/F25Vbmsa8QX/4Zs77v0uK/vGlPLQMEBaSmX7AE
 +dsntUHq6WLznef3z2VUAOK+RUyjlSWs6qIlRIqpl1pDaSkG07+2xN0nn3+Ly1A5dhle2MGuRLh
 sMaZALKLN4chrtcVlbRtEZP7icU5hYKOBPe1d7w==
X-Google-Smtp-Source: AGHT+IHkwXmWM9uDpduuRxZ3okk9+pGW4UKjUlP7yv9AIMebptpyfRY6GQ11PpU+ZrLj1LWbfMeyjGfHH6C08+/h7xI=
X-Received: by 2002:a05:6902:138d:b0:e11:7096:5478 with SMTP id
 3f1490d57ef6-e1666400f28mr4033042276.20.1724272982166; Wed, 21 Aug 2024
 13:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240820170907.6788-1-yichen.wang@bytedance.com>
 <20240820170907.6788-4-yichen.wang@bytedance.com>
 <CAE8KmOypgmrWR6dxAz7iQ=3k+fTXSMKs6kUTUdRisGcq22p8Pw@mail.gmail.com>
In-Reply-To: <CAE8KmOypgmrWR6dxAz7iQ=3k+fTXSMKs6kUTUdRisGcq22p8Pw@mail.gmail.com>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Wed, 21 Aug 2024 13:42:51 -0700
Message-ID: <CAHObMVZh_Y5g8LZbt1r__RX_BXzg3jqm+HFmC3_s3JAj-3YWDg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 3/5] migration: Add migration parameters
 for QATzip
To: Prasad Pandit <ppandit@redhat.com>
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
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Aug 21, 2024 at 4:56=E2=80=AFAM Prasad Pandit <ppandit@redhat.com> =
wrote:
>
> On Tue, 20 Aug 2024 at 22:40, Yichen Wang <yichen.wang@bytedance.com> wro=
te:
> > Adds support for migration parameters to control QATzip compression
> > level and to enable/disable software fallback when QAT hardware is
> > unavailable. This is a preparatory commit for a subsequent commit that
> > will actually use QATzip compression.
>
> * Is the check whether "QAT hardware is available" happening in this
> patch? (I couldn't spot it).

After discussing with Intel folks, I decided to align to the existing
QPL behavior. In QPL, the code path of compression will always go
through regardless. When acceleration hardware is initialized
properly, use it. If failed, fallback to software path automatically.
So in this QAT case, I do the same. The line of "ret =3D
qzInit(&q->sess, true);" will do the auto software fallback.

> * The informatory notice "This is a preparatory commit for..." could
> be moved to the cover-letter, instead of commit message. (Not sure how
> it helps to log it in git history)
>

Oh, this line is purely for breaking the big patch into two commits.
This one plus the following commit [4/5] together implements the full
feature. I can remove this from the commit message if you prefer.

> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> > Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> > Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> > ---
> >  migration/migration-hmp-cmds.c |  4 ++++
> >  migration/options.c            | 34 ++++++++++++++++++++++++++++++++++
> >  migration/options.h            |  1 +
> >  qapi/migration.json            | 18 ++++++++++++++++++
> >  4 files changed, 57 insertions(+)
> >
> > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-c=
mds.c
> > index 7d608d26e1..28165cfc9e 100644
> > --- a/migration/migration-hmp-cmds.c
> > +++ b/migration/migration-hmp-cmds.c
> > @@ -576,6 +576,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
> >          p->has_multifd_zlib_level =3D true;
> >          visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
> >          break;
> > +    case MIGRATION_PARAMETER_MULTIFD_QATZIP_LEVEL:
> > +        p->has_multifd_qatzip_level =3D true;
> > +        visit_type_uint8(v, param, &p->multifd_qatzip_level, &err);
> > +        break;
> >      case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
> >          p->has_multifd_zstd_level =3D true;
> >          visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
> > diff --git a/migration/options.c b/migration/options.c
> > index 645f55003d..147cd2b8fd 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -55,6 +55,13 @@
> >  #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
> >  /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
> >  #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
> > +/*
> > + * 1: best speed, ... 9: best compress ratio
> > + * There is some nuance here. Refer to QATzip documentation to underst=
and
> > + * the mapping of QATzip levels to standard deflate levels.
> > + */
> > +#define DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL 1
> > +
> >  /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
> >  #define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
> >
> > @@ -123,6 +130,9 @@ Property migration_properties[] =3D {
> >      DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
> >                        parameters.multifd_zlib_level,
> >                        DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
> > +    DEFINE_PROP_UINT8("multifd-qatzip-level", MigrationState,
> > +                      parameters.multifd_qatzip_level,
> > +                      DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
> >      DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
> >                        parameters.multifd_zstd_level,
> >                        DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
> > @@ -787,6 +797,13 @@ int migrate_multifd_zlib_level(void)
> >      return s->parameters.multifd_zlib_level;
> >  }
> >
> > +int migrate_multifd_qatzip_level(void)
> > +{
> > +    MigrationState *s =3D migrate_get_current();
> > +
> > +    return s->parameters.multifd_qatzip_level;
> > +}
> > +
> >  int migrate_multifd_zstd_level(void)
> >  {
> >      MigrationState *s =3D migrate_get_current();
> > @@ -892,6 +909,8 @@ MigrationParameters *qmp_query_migrate_parameters(E=
rror **errp)
> >      params->multifd_compression =3D s->parameters.multifd_compression;
> >      params->has_multifd_zlib_level =3D true;
> >      params->multifd_zlib_level =3D s->parameters.multifd_zlib_level;
> > +    params->has_multifd_qatzip_level =3D true;
> > +    params->multifd_qatzip_level =3D s->parameters.multifd_qatzip_leve=
l;
> >      params->has_multifd_zstd_level =3D true;
> >      params->multifd_zstd_level =3D s->parameters.multifd_zstd_level;
> >      params->has_xbzrle_cache_size =3D true;
> > @@ -946,6 +965,7 @@ void migrate_params_init(MigrationParameters *param=
s)
> >      params->has_multifd_channels =3D true;
> >      params->has_multifd_compression =3D true;
> >      params->has_multifd_zlib_level =3D true;
> > +    params->has_multifd_qatzip_level =3D true;
> >      params->has_multifd_zstd_level =3D true;
> >      params->has_xbzrle_cache_size =3D true;
> >      params->has_max_postcopy_bandwidth =3D true;
> > @@ -1038,6 +1058,14 @@ bool migrate_params_check(MigrationParameters *p=
arams, Error **errp)
> >          return false;
> >      }
> >
> > +    if (params->has_multifd_qatzip_level &&
> > +        ((params->multifd_qatzip_level > 9) ||
> > +        (params->multifd_qatzip_level < 1))) {
> > +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_qatzip=
_level",
> > +                   "a value between 1 and 9");
> > +        return false;
> > +    }
> > +
> >      if (params->has_multifd_zstd_level &&
> >          (params->multifd_zstd_level > 20)) {
> >          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_l=
evel",
> > @@ -1195,6 +1223,9 @@ static void migrate_params_test_apply(MigrateSetP=
arameters *params,
> >      if (params->has_multifd_compression) {
> >          dest->multifd_compression =3D params->multifd_compression;
> >      }
> > +    if (params->has_multifd_qatzip_level) {
> > +        dest->multifd_qatzip_level =3D params->multifd_qatzip_level;
> > +    }
> >      if (params->has_multifd_zlib_level) {
> >          dest->multifd_zlib_level =3D params->multifd_zlib_level;
> >      }
> > @@ -1315,6 +1346,9 @@ static void migrate_params_apply(MigrateSetParame=
ters *params, Error **errp)
> >      if (params->has_multifd_compression) {
> >          s->parameters.multifd_compression =3D params->multifd_compress=
ion;
> >      }
> > +    if (params->has_multifd_qatzip_level) {
> > +        s->parameters.multifd_qatzip_level =3D params->multifd_qatzip_=
level;
> > +    }
> >      if (params->has_multifd_zlib_level) {
> >          s->parameters.multifd_zlib_level =3D params->multifd_zlib_leve=
l;
> >      }
> > diff --git a/migration/options.h b/migration/options.h
> > index a2397026db..a0bd6edc06 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -78,6 +78,7 @@ uint64_t migrate_max_postcopy_bandwidth(void);
> >  int migrate_multifd_channels(void);
> >  MultiFDCompression migrate_multifd_compression(void);
> >  int migrate_multifd_zlib_level(void);
> > +int migrate_multifd_qatzip_level(void);
> >  int migrate_multifd_zstd_level(void);
> >  uint8_t migrate_throttle_trigger_threshold(void);
> >  const char *migrate_tls_authz(void);
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 7324571e92..f4c27426c8 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -792,6 +792,11 @@
> >  #     speed, and 9 means best compression ratio which will consume
> >  #     more CPU.  Defaults to 1.  (Since 5.0)
> >  #
> > +# @multifd-qatzip-level: Set the compression level to be used in live
> > +#     migration. The level is an integer between 1 and 9, where 1 mean=
s
> > +#     the best compression speed, and 9 means the best compression
> > +#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
> > +#
> >  # @multifd-zstd-level: Set the compression level to be used in live
> >  #     migration, the compression level is an integer between 0 and 20,
> >  #     where 0 means no compression, 1 means the best compression
> > @@ -852,6 +857,7 @@
> >             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> >             'max-cpu-throttle', 'multifd-compression',
> >             'multifd-zlib-level', 'multifd-zstd-level',
> > +           'multifd-qatzip-level',
> >             'block-bitmap-mapping',
> >             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstab=
le'] },
> >             'vcpu-dirty-limit',
> > @@ -967,6 +973,11 @@
> >  #     speed, and 9 means best compression ratio which will consume
> >  #     more CPU.  Defaults to 1.  (Since 5.0)
> >  #
> > +# @multifd-qatzip-level: Set the compression level to be used in live
> > +#     migration. The level is an integer between 1 and 9, where 1 mean=
s
> > +#     the best compression speed, and 9 means the best compression
> > +#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
> > +#
> >  # @multifd-zstd-level: Set the compression level to be used in live
> >  #     migration, the compression level is an integer between 0 and 20,
> >  #     where 0 means no compression, 1 means the best compression
> > @@ -1040,6 +1051,7 @@
> >              '*max-cpu-throttle': 'uint8',
> >              '*multifd-compression': 'MultiFDCompression',
> >              '*multifd-zlib-level': 'uint8',
> > +            '*multifd-qatzip-level': 'uint8',
> >              '*multifd-zstd-level': 'uint8',
> >              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> >              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> > @@ -1171,6 +1183,11 @@
> >  #     speed, and 9 means best compression ratio which will consume
> >  #     more CPU.  Defaults to 1.  (Since 5.0)
> >  #
> > +# @multifd-qatzip-level: Set the compression level to be used in live
> > +#     migration. The level is an integer between 1 and 9, where 1 mean=
s
> > +#     the best compression speed, and 9 means the best compression
> > +#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
> > +#
> >  # @multifd-zstd-level: Set the compression level to be used in live
> >  #     migration, the compression level is an integer between 0 and 20,
> >  #     where 0 means no compression, 1 means the best compression
> > @@ -1241,6 +1258,7 @@
> >              '*max-cpu-throttle': 'uint8',
> >              '*multifd-compression': 'MultiFDCompression',
> >              '*multifd-zlib-level': 'uint8',
> > +            '*multifd-qatzip-level': 'uint8',
> >              '*multifd-zstd-level': 'uint8',
> >              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> >              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> > --
> > Yichen Wang
>
> 'multifd-qatzip-level' related changes look okay.
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
>
> Thank you.
> ---
>   - Prasad
>

