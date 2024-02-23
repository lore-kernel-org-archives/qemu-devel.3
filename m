Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EAAC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdNJd-0007xL-Rh; Thu, 22 Feb 2024 23:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdNJc-0007wz-4v
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:37:40 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdNJT-0001VS-AN
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:37:39 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-512e39226efso747816e87.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 20:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708663049; x=1709267849; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6MIISw5Jx6sDM22EcrE9/PW7JWU+nFF2xyzM1pSB9o=;
 b=TNKWlvd1HFoPzi8wJWEN1YlQ1PHp8DWDDPbgwpLp5Csyi21MrWCaynJ5sC/jYL3/zA
 4ZFJnZvOGGwzOGLTaXdbCuHfOj4x6KQXvUJCA9XouPm3K/0ZSRekcsWWPQKVodjD0Nms
 8mg7pAqwxkliCTVRAWCoBVnbNvspTDLd7JtqFlM6BmjiL661NHMHOs4cuP4lpGuGkKIF
 BQpjuvGBkA20PrJZe2CrHtMU/OiFSAE/eD+yi8Me2toMnYC20RjiDzVqfSNz8QfzwFrF
 1HiLjqnqvliKdBnBMK9mhc7fZ8bPl1329zMs7R0POho7jp7FabyHphJkES9KQRaecepb
 yI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708663049; x=1709267849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6MIISw5Jx6sDM22EcrE9/PW7JWU+nFF2xyzM1pSB9o=;
 b=TFx44E8BMI+UjM/owZ9y0fjNiB+GtbatyrhnW5EghP4LtMBdusHR5bhWdejKfWRYyi
 b0JyOqkWuysp/smuZxkd59X1QKEWmoH4gDQExbcgky6WrVuLgB+qjXT2s7aYfr5kdSpJ
 UxmXBkuxTZsK2PJrQCXmGjouCEfHotJcsFXmNqT2Vs6u7a4nsTZa07P0hZNBoQPp74Yc
 q5eoK0WVKoZ/knB90FdpKJLcaH2yIMIZVtDFpF7Z4uz/Q91Sv91/HayqZTSBOMDZV7F+
 h+bl5jjOov4T5G+ObL02S4VtFiEJexpzqjoCwFVB08q/Q4PbqXXjPSb8R3tB06jttGxa
 /bbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNA9PuErdTr4jVQ1+eJms+XYwOUOYkwTDiZ8jt/SVvdjbXzjF0USDR0QonqQJ3/NZU70//hE9SzKqfcirGvALjGV45pUc=
X-Gm-Message-State: AOJu0Yz7uYFHxmgEUmq6hQ8OUooYyeagh+HKkSKhN5hZj3eLU/ZYL/Su
 nbPrutSLrx6H8LZ1c3/Jv/39ZeFaQ+X+DC1jKLfPltRVQsrIlZG9Z+FiUGai0BSrGgfGF5mIBpW
 q+duYa5Zbb7XnrOWZFXLOCQLU56kYRXr97UnpmQ==
X-Google-Smtp-Source: AGHT+IEHen9w3vtuNcqHDS1kkQOLYail8f0LFOCABQO1H5R7J8fg7uLEjnwDNWwYTUhGJ7CCSMemK1D92GZ+b2zPIBU=
X-Received: by 2002:ac2:48a4:0:b0:512:b71d:3283 with SMTP id
 u4-20020ac248a4000000b00512b71d3283mr475635lfg.67.1708663048990; Thu, 22 Feb
 2024 20:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-2-hao.xiang@bytedance.com>
 <CAEr7rXjdbTzPByJkysvkKrWXzwjhMpDBW4Po0MuifGr5YV3woQ@mail.gmail.com>
In-Reply-To: <CAEr7rXjdbTzPByJkysvkKrWXzwjhMpDBW4Po0MuifGr5YV3woQ@mail.gmail.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 22 Feb 2024 20:37:17 -0800
Message-ID: <CAAYibXg71-T=56eNgdinrxsBPgOmHZkm_BiDByJRMpmELNkWGg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/7] migration/multifd: Add new
 migration option zero-page-detection.
To: Elena Ufimtseva <ufimtseva@gmail.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, 
 jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 21, 2024 at 5:58=E2=80=AFAM Elena Ufimtseva <ufimtseva@gmail.co=
m> wrote:
>
>
>
> On Fri, Feb 16, 2024 at 2:41=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.co=
m> wrote:
>>
>> This new parameter controls where the zero page checking is running.
>> 1. If this parameter is set to 'legacy', zero page checking is
>> done in the migration main thread.
>> 2. If this parameter is set to 'none', zero page checking is disabled.
>>
>
> Hello Hao
>
> Few questions and comments.
>
> First the commit message states that the parameter control where the chec=
king is done, but it also controls
> if sending of zero pages is done by multifd threads or not.
>
>
>>
>> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>> ---
>>  hw/core/qdev-properties-system.c    | 10 ++++++++++
>>  include/hw/qdev-properties-system.h |  4 ++++
>>  migration/migration-hmp-cmds.c      |  9 +++++++++
>>  migration/options.c                 | 21 ++++++++++++++++++++
>>  migration/options.h                 |  1 +
>>  migration/ram.c                     |  4 ++++
>>  qapi/migration.json                 | 30 ++++++++++++++++++++++++++---
>>  7 files changed, 76 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-=
system.c
>> index 1a396521d5..63843f18b5 100644
>> --- a/hw/core/qdev-properties-system.c
>> +++ b/hw/core/qdev-properties-system.c
>> @@ -679,6 +679,16 @@ const PropertyInfo qdev_prop_mig_mode =3D {
>>      .set_default_value =3D qdev_propinfo_set_default_value_enum,
>>  };
>>
>> +const PropertyInfo qdev_prop_zero_page_detection =3D {
>> +    .name =3D "ZeroPageDetection",
>> +    .description =3D "zero_page_detection values, "
>> +                   "multifd,legacy,none",
>> +    .enum_table =3D &ZeroPageDetection_lookup,
>> +    .get =3D qdev_propinfo_get_enum,
>> +    .set =3D qdev_propinfo_set_enum,
>> +    .set_default_value =3D qdev_propinfo_set_default_value_enum,
>> +};
>> +
>>  /* --- Reserved Region --- */
>>
>>  /*
>> diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-prope=
rties-system.h
>> index 06c359c190..839b170235 100644
>> --- a/include/hw/qdev-properties-system.h
>> +++ b/include/hw/qdev-properties-system.h
>> @@ -8,6 +8,7 @@ extern const PropertyInfo qdev_prop_macaddr;
>>  extern const PropertyInfo qdev_prop_reserved_region;
>>  extern const PropertyInfo qdev_prop_multifd_compression;
>>  extern const PropertyInfo qdev_prop_mig_mode;
>> +extern const PropertyInfo qdev_prop_zero_page_detection;
>>  extern const PropertyInfo qdev_prop_losttickpolicy;
>>  extern const PropertyInfo qdev_prop_blockdev_on_error;
>>  extern const PropertyInfo qdev_prop_bios_chs_trans;
>> @@ -47,6 +48,9 @@ extern const PropertyInfo qdev_prop_iothread_vq_mappin=
g_list;
>>  #define DEFINE_PROP_MIG_MODE(_n, _s, _f, _d) \
>>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_mig_mode, \
>>                         MigMode)
>> +#define DEFINE_PROP_ZERO_PAGE_DETECTION(_n, _s, _f, _d) \
>> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_zero_page_detection, \
>> +                       ZeroPageDetection)
>>  #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
>>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
>>                          LostTickPolicy)
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cm=
ds.c
>> index 99b49df5dd..7e96ae6ffd 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -344,6 +344,11 @@ void hmp_info_migrate_parameters(Monitor *mon, cons=
t QDict *qdict)
>>          monitor_printf(mon, "%s: %s\n",
>>              MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESS=
ION),
>>              MultiFDCompression_str(params->multifd_compression));
>> +        assert(params->has_zero_page_detection);
>
>
> What is the reason to have assert here?

It's just to verify that the option is initialized properly before we
reach here. Same things are done for other options.

>
>>
>> +        monitor_printf(mon, "%s: %s\n",
>> +            MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECT=
ION),
>> +            qapi_enum_lookup(&ZeroPageDetection_lookup,
>> +                params->zero_page_detection));
>>          monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
>>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZ=
E),
>>              params->xbzrle_cache_size);
>> @@ -634,6 +639,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
>>          p->has_multifd_zstd_level =3D true;
>>          visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
>>          break;
>> +    case MIGRATION_PARAMETER_ZERO_PAGE_DETECTION:
>> +        p->has_zero_page_detection =3D true;
>> +        visit_type_ZeroPageDetection(v, param, &p->zero_page_detection,=
 &err);
>> +        break;
>>      case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
>>          p->has_xbzrle_cache_size =3D true;
>>          if (!visit_type_size(v, param, &cache_size, &err)) {
>> diff --git a/migration/options.c b/migration/options.c
>> index 3e3e0b93b4..3c603391b0 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -179,6 +179,9 @@ Property migration_properties[] =3D {
>>      DEFINE_PROP_MIG_MODE("mode", MigrationState,
>>                        parameters.mode,
>>                        MIG_MODE_NORMAL),
>> +    DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationSta=
te,
>> +                       parameters.zero_page_detection,
>> +                       ZERO_PAGE_DETECTION_LEGACY),
>>
>>      /* Migration capabilities */
>>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
>> @@ -903,6 +906,13 @@ uint64_t migrate_xbzrle_cache_size(void)
>>      return s->parameters.xbzrle_cache_size;
>>  }
>>
>> +ZeroPageDetection migrate_zero_page_detection(void)
>> +{
>> +    MigrationState *s =3D migrate_get_current();
>> +
>> +    return s->parameters.zero_page_detection;
>> +}
>> +
>>  /* parameter setters */
>>
>>  void migrate_set_block_incremental(bool value)
>> @@ -1013,6 +1023,8 @@ MigrationParameters *qmp_query_migrate_parameters(=
Error **errp)
>>      params->vcpu_dirty_limit =3D s->parameters.vcpu_dirty_limit;
>>      params->has_mode =3D true;
>>      params->mode =3D s->parameters.mode;
>> +    params->has_zero_page_detection =3D true;
>> +    params->zero_page_detection =3D s->parameters.zero_page_detection;
>>
>>      return params;
>>  }
>> @@ -1049,6 +1061,7 @@ void migrate_params_init(MigrationParameters *para=
ms)
>>      params->has_x_vcpu_dirty_limit_period =3D true;
>>      params->has_vcpu_dirty_limit =3D true;
>>      params->has_mode =3D true;
>> +    params->has_zero_page_detection =3D true;
>>  }
>>
>>  /*
>> @@ -1350,6 +1363,10 @@ static void migrate_params_test_apply(MigrateSetP=
arameters *params,
>>      if (params->has_mode) {
>>          dest->mode =3D params->mode;
>>      }
>> +
>> +    if (params->has_zero_page_detection) {
>> +        dest->zero_page_detection =3D params->zero_page_detection;
>> +    }
>>  }
>>
>>  static void migrate_params_apply(MigrateSetParameters *params, Error **=
errp)
>> @@ -1494,6 +1511,10 @@ static void migrate_params_apply(MigrateSetParame=
ters *params, Error **errp)
>>      if (params->has_mode) {
>>          s->parameters.mode =3D params->mode;
>>      }
>> +
>> +    if (params->has_zero_page_detection) {
>> +        s->parameters.zero_page_detection =3D params->zero_page_detecti=
on;
>> +    }
>>  }
>>
>>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **e=
rrp)
>> diff --git a/migration/options.h b/migration/options.h
>> index 246c160aee..b7c4fb3861 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -93,6 +93,7 @@ const char *migrate_tls_authz(void);
>>  const char *migrate_tls_creds(void);
>>  const char *migrate_tls_hostname(void);
>>  uint64_t migrate_xbzrle_cache_size(void);
>> +ZeroPageDetection migrate_zero_page_detection(void);
>>
>>  /* parameters setters */
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 4649a81204..556725c30f 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1123,6 +1123,10 @@ static int save_zero_page(RAMState *rs, PageSearc=
hStatus *pss,
>>      QEMUFile *file =3D pss->pss_channel;
>>      int len =3D 0;
>>
>> +    if (migrate_zero_page_detection() !=3D ZERO_PAGE_DETECTION_LEGACY) =
{
>> +        return 0;
>> +    }
>> +
>>      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>>          return 0;
>>      }
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 5a565d9b8d..99843a8e95 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -653,6 +653,17 @@
>>  { 'enum': 'MigMode',
>>    'data': [ 'normal', 'cpr-reboot' ] }
>>
>> +##
>> +# @ZeroPageDetection:
>> +#
>> +# @legacy: Perform zero page checking from main migration thread. (sinc=
e 9.0)
>> +#
>> +# @none: Do not perform zero page checking.
>> +#
>> +##
>> +{ 'enum': 'ZeroPageDetection',
>> +  'data': [ 'legacy', 'none' ] }
>> +
>
>
> Above you have introduced the qdev property qdev_prop_zero_page_detection=
 with multifd, but it is not present in the scheme.
> Perhaps 'mulitfd' in qdev_prop_zero_page_detection belongs to another pat=
ch?

You are right. I will fix that.

>
>
>>
>>  ##
>>  # @BitmapMigrationBitmapAliasTransform:
>>  #
>> @@ -874,6 +885,9 @@
>>  # @mode: Migration mode. See description in @MigMode. Default is 'norma=
l'.
>>  #        (Since 8.2)
>>  #
>> +# @zero-page-detection: See description in @ZeroPageDetection.
>> +#     Default is 'legacy'. (Since 9.0)
>> +#
>>  # Features:
>>  #
>>  # @deprecated: Member @block-incremental is deprecated.  Use
>> @@ -907,7 +921,8 @@
>>             'block-bitmap-mapping',
>>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstabl=
e'] },
>>             'vcpu-dirty-limit',
>> -           'mode'] }
>> +           'mode',
>> +           'zero-page-detection'] }
>>
>>  ##
>>  # @MigrateSetParameters:
>> @@ -1066,6 +1081,10 @@
>>  # @mode: Migration mode. See description in @MigMode. Default is 'norma=
l'.
>>  #        (Since 8.2)
>>  #
>> +# @zero-page-detection: See description in @ZeroPageDetection.
>> +#     Default is 'legacy'. (Since 9.0)
>> +#
>> +#
>>  # Features:
>>  #
>>  # @deprecated: Member @block-incremental is deprecated.  Use
>> @@ -1119,7 +1138,8 @@
>>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>>                                              'features': [ 'unstable' ] =
},
>>              '*vcpu-dirty-limit': 'uint64',
>> -            '*mode': 'MigMode'} }
>> +            '*mode': 'MigMode',
>> +            '*zero-page-detection': 'ZeroPageDetection'} }
>>
>>  ##
>>  # @migrate-set-parameters:
>> @@ -1294,6 +1314,9 @@
>>  # @mode: Migration mode. See description in @MigMode. Default is 'norma=
l'.
>>  #        (Since 8.2)
>>  #
>> +# @zero-page-detection: See description in @ZeroPageDetection.
>> +#     Default is 'legacy'. (Since 9.0)
>> +#
>>  # Features:
>>  #
>>  # @deprecated: Member @block-incremental is deprecated.  Use
>> @@ -1344,7 +1367,8 @@
>>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>>                                              'features': [ 'unstable' ] =
},
>>              '*vcpu-dirty-limit': 'uint64',
>> -            '*mode': 'MigMode'} }
>> +            '*mode': 'MigMode',
>> +            '*zero-page-detection': 'ZeroPageDetection'} }
>>
>>  ##
>>  # @query-migrate-parameters:
>> --
>> 2.30.2
>>
>>
>
>
> --
> Elena

