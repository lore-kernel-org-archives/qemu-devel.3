Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0BAC30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 00:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMdRs-0008H9-0E; Wed, 26 Jun 2024 20:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sMcov-0001YC-S6
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 20:17:04 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sMcos-00048K-Js
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 20:17:01 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3cabac56b38so4284834b6e.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 17:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1719447412; x=1720052212; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MY2U6Bz5FL5g8pl58N9ZJYcMRxZ6ko20orsOzybusN4=;
 b=K6LJZZnW8IdOETZG0QWT3NI/SpiUKo+U5xuVbZD5CAj2Y6QQ5YPo38beWSVVPt96Sd
 9JSkWHjiNsFm9gk67cNgAlyvsm3tlnrx7oq/jJdzxkP0/dNyUFc8vKVOX7zpvwctZthh
 Sg4DYTEv3zkOLSgAXT075flqa+BjDvnQHeXC243ZHNzA+GlIiH0Hg8dhVVTthtgC+7sD
 bwk/7BwFPPlDa8PcSVfj2veu76obH5esI6TxMXGH2VRXU6wyo2EIZ+APEx1v8AoYdZn6
 Tr1R7nN6p8msGTm8asoG1QQ9LW1r6e8J14+h9hfY1cRLmRwAwXCyLhsSycr3dQfg1uU0
 rfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719447412; x=1720052212;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MY2U6Bz5FL5g8pl58N9ZJYcMRxZ6ko20orsOzybusN4=;
 b=XL6vLYmq/Abj2U4T+NaNJTtmea7Ajr7R8l8Adq42Bxlx+Kv6wlywulUsZ+hy9KOT/Q
 6AsRk3EZuhGsXHZWM8t0R7gQcQBX2qdMFrY+8l4RLkQIbS5Drhi5NgBeufXmqCrTy6PW
 8QFe/vq+hT9Mn8ympWNXJTmqa1kxiv73W0zfw0in4ZIE/A1RtpLIinp2qei1+H0kZul7
 9EXV8MB89F5b2wwtCKDIi0gEU9OvrgPybiTylLd4fUV7KSVRGbLk6TvJ1mvPCLxuQ3qd
 BhFBHZvWSdowX9qCM9wNPRaUUjCC9LZqQ3yMPxUKK9U6zW/MjEAIKjGFBMLLwaK+/yTi
 kLMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxnB/sOqAD07KW16FojpzU11LBPoc8a+9D1wS7AARE/oExrn4ZWEyJXnXQ+vrRsiTU/hR9ckeMwwnSiZHKqyDneQ6jl7s=
X-Gm-Message-State: AOJu0YwNZTDkuqOzInHJPOSIJ+vnzeCWmrXvE24xKxOcwy9SkZrHNVZC
 Cvu5fCG6n+GsXRVHJnetColPs82q2ENu1IqyNF/kl7JpZbGMBQWy9mugZmBPVjQ=
X-Google-Smtp-Source: AGHT+IHsJ/LSspIKfpswaHaTZp/AZtlZ+F0B2gwEWxMV9/JVhAam/k19YoKJG/BVvgWQtPSbOrCyow==
X-Received: by 2002:a05:6808:138f:b0:3d2:22ac:fc48 with SMTP id
 5614622812f47-3d543b7c69dmr15258914b6e.38.1719447412224; 
 Wed, 26 Jun 2024 17:16:52 -0700 (PDT)
Received: from smtpclient.apple ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d56771ea8asm65355b6e.6.2024.06.26.17.16.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2024 17:16:51 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2 2/5] migration: Add migration parameters for QATzip
From: Yichen Wang <yichen.wang@bytedance.com>
In-Reply-To: <PH7PR11MB5941DB7AE63F9114667CFEE1A33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
Date: Wed, 26 Jun 2024 17:16:40 -0700
Cc: Bryan Zhang <bryan.zhang@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "hao.xiang@linux.dev" <hao.xiang@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B24B57D-EE7F-413D-9AD5-7519FEBA423F@bytedance.com>
References: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
 <20240326224221.3623014-3-bryan.zhang@bytedance.com>
 <PH7PR11MB5941DB7AE63F9114667CFEE1A33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
X-Mailer: Apple Mail (2.3774.600.62)
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Jun 2024 20:57:10 -0400
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



> On Mar 28, 2024, at 12:23=E2=80=AFAM, Liu, Yuan1 <yuan1.liu@intel.com> =
wrote:
>=20
>> -----Original Message-----
>> From: Bryan Zhang <bryan.zhang@bytedance.com>
>> Sent: Wednesday, March 27, 2024 6:42 AM
>> To: qemu-devel@nongnu.org
>> Cc: peterx@redhat.com; farosas@suse.de; Liu, Yuan1 =
<yuan1.liu@intel.com>;
>> berrange@redhat.com; Zou, Nanhai <nanhai.zou@intel.com>;
>> hao.xiang@linux.dev; Bryan Zhang <bryan.zhang@bytedance.com>
>> Subject: [PATCH v2 2/5] migration: Add migration parameters for =
QATzip
>>=20
>> Adds support for migration parameters to control QATzip compression
>> level and to enable/disable software fallback when QAT hardware is
>> unavailable. This is a preparatory commit for a subsequent commit =
that
>> will actually use QATzip compression.
>>=20
>> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
>> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
>> ---
>> Revision: This commit now includes a parameter for controlling =
software
>> fallback. Fallback is generally intended to be disabled, but having =
this
>> option available enables using software fallback for testing.
>>=20
>> This commit also now has some glue code to properly set parameters.
>>=20
>> migration/migration-hmp-cmds.c |  8 +++++
>> migration/options.c            | 57 =
++++++++++++++++++++++++++++++++++
>> migration/options.h            |  2 ++
>> qapi/migration.json            | 35 +++++++++++++++++++++
>> 4 files changed, 102 insertions(+)
>>=20
>> diff --git a/migration/migration-hmp-cmds.c =
b/migration/migration-hmp-
>> cmds.c
>> index 99b49df5dd..4bd23ba14d 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -630,6 +630,14 @@ void hmp_migrate_set_parameter(Monitor *mon, =
const
>> QDict *qdict)
>>         p->has_multifd_zlib_level =3D true;
>>         visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
>>         break;
>> +    case MIGRATION_PARAMETER_MULTIFD_QATZIP_LEVEL:
>> +        p->has_multifd_qatzip_level =3D true;
>> +        visit_type_uint8(v, param, &p->multifd_qatzip_level, &err);
>> +        break;
>> +    case MIGRATION_PARAMETER_MULTIFD_QATZIP_SW_FALLBACK:
>> +        p->has_multifd_qatzip_sw_fallback =3D true;
>> +        visit_type_bool(v, param, &p->multifd_qatzip_sw_fallback, =
&err);
>> +        break;
>>     case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
>>         p->has_multifd_zstd_level =3D true;
>>         visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
>> diff --git a/migration/options.c b/migration/options.c
>> index 3e3e0b93b4..1316ea605a 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -62,6 +62,15 @@
>> #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
>> /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
>> #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
>> +/*
>> + * 1: best speed, ... 9: best compress ratio
>> + * There is some nuance here. Refer to QATzip documentation to =
understand
>> + * the mapping of QATzip levels to standard deflate levels.
>> + */
>> +#define DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL 1
>> +/* QATzip's SW fallback implementation is extremely slow, so avoid
>> fallback */
>> +#define DEFAULT_MIGRATE_MULTIFD_QATZIP_SW_FALLBACK false
>> +
>> /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
>> #define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
>=20
> Hi Bryan
>=20
> The default compression level may be set higher, such as 6. I checked =
QAT throughput
> If the data size is less than or equal to 64K, level 1 has much better =
throughput=20
> performance than level 6 and level 9. But if the data size is greater =
than 128K, little=20
> change in throughput, and the default MULTIFD_PACKET_SIZE is 512K, you =
can have a try=20
> to use a high compression level, to get better compression performance =
without affecting=20
> throughput.
>=20
> In addition, if you change MULTIFD_PACKET_SIZE to 64K, you may have =
better throughput=20
> with more multifd threads
Hi Yuan,

Thanks for your comment. I did a quick experiments on our CPU. With =
chunk size at 512K, for silesia dataset, the throughput degrades at =
level 6:
# for f in `seq 1 1 9`; do echo "Level $f:"; qzip -C 524288 -L $f -k =
silesia.8G | grep ":"; done
Level 1:
Time taken:     2230.772 ms
Throughput:    30402.186 Mbit/s
Space Savings:    65.712 %
Compression ratio: 2.916 : 1
Level 2:
Time taken:     2245.205 ms
Throughput:    30206.750 Mbit/s
Space Savings:    65.712 %
Compression ratio: 2.916 : 1
Level 3:
Time taken:     2217.789 ms
Throughput:    30580.161 Mbit/s
Space Savings:    65.712 %
Compression ratio: 2.916 : 1
Level 4:
Time taken:     2251.014 ms
Throughput:    30128.798 Mbit/s
Space Savings:    65.712 %
Compression ratio: 2.916 : 1
Level 5:
Time taken:     2200.991 ms
Throughput:    30813.550 Mbit/s
Space Savings:    65.712 %
Compression ratio: 2.916 : 1
Level 6:
Time taken:     2508.218 ms
Throughput:    27039.255 Mbit/s
Space Savings:    67.396 %
Compression ratio: 3.067 : 1
Level 7:
Time taken:     2510.847 ms
Throughput:    27010.943 Mbit/s
Space Savings:    67.396 %
Compression ratio: 3.067 : 1
Level 8:
Time taken:     2521.428 ms
Throughput:    26897.594 Mbit/s
Space Savings:    67.396 %
Compression ratio: 3.067 : 1
Level 9:
Time taken:     3071.055 ms
Throughput:    22083.729 Mbit/s
Space Savings:    67.664 %
Compression ratio: 3.092 : 1

For random text data, throughput actually improves at level 6.
# for f in `seq 1 1 9`; do echo "Level $f:"; qzip -C 524288 -L $f -k =
text.txt | grep ":"; done
Level 1:
Time taken:     1788.683 ms
Throughput:     8945.129 Mbit/s
Space Savings:    24.959 %
Compression ratio: 1.333 : 1
Level 2:
Time taken:     1786.135 ms
Throughput:     8957.890 Mbit/s
Space Savings:    24.959 %
Compression ratio: 1.333 : 1
Level 3:
Time taken:     1785.564 ms
Throughput:     8960.754 Mbit/s
Space Savings:    24.959 %
Compression ratio: 1.333 : 1
Level 4:
Time taken:     1787.351 ms
Throughput:     8951.795 Mbit/s
Space Savings:    24.959 %
Compression ratio: 1.333 : 1
Level 5:
Time taken:     1785.171 ms
Throughput:     8962.727 Mbit/s
Space Savings:    24.959 %
Compression ratio: 1.333 : 1
Level 6:
Time taken:     1752.000 ms
Throughput:     9132.420 Mbit/s
Space Savings:    24.873 %
Compression ratio: 1.331 : 1
Level 7:
Time taken:     1752.297 ms
Throughput:     9130.872 Mbit/s
Space Savings:    24.873 %
Compression ratio: 1.331 : 1
Level 8:
Time taken:     1752.538 ms
Throughput:     9129.617 Mbit/s
Space Savings:    24.873 %
Compression ratio: 1.331 : 1
Level 9:
Time taken:     1762.593 ms
Throughput:     9077.535 Mbit/s
Space Savings:    24.870 %
Compression ratio: 1.331 : 1

For random binary data, throughput remains the same from 0-9.=20

Given our live migration is mostly memory pages, and I am not very sure =
what scenario would better fit to above tests. I am OK with either =
default level (1 or 6). I can change to 6 in my next patchiest if you =
believe that is better.

Thanks very much!

Regards,
Yichen=20
>=20
>> @@ -143,6 +152,12 @@ Property migration_properties[] =3D {
>>     DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
>>                       parameters.multifd_zlib_level,
>>                       DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
>> +    DEFINE_PROP_UINT8("multifd-qatzip-level", MigrationState,
>> +                      parameters.multifd_qatzip_level,
>> +                      DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
>> +    DEFINE_PROP_BOOL("multifd-qatzip-sw-fallback", MigrationState,
>> +                      parameters.multifd_qatzip_sw_fallback,
>> +                      DEFAULT_MIGRATE_MULTIFD_QATZIP_SW_FALLBACK),
>>     DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
>>                       parameters.multifd_zstd_level,
>>                       DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
>> @@ -861,6 +876,20 @@ int migrate_multifd_zlib_level(void)
>>     return s->parameters.multifd_zlib_level;
>> }
>>=20
>> +int migrate_multifd_qatzip_level(void)
>> +{
>> +    MigrationState *s =3D migrate_get_current();
>> +
>> +    return s->parameters.multifd_qatzip_level;
>> +}
>> +
>> +bool migrate_multifd_qatzip_sw_fallback(void)
>> +{
>> +    MigrationState *s =3D migrate_get_current();
>> +
>> +    return s->parameters.multifd_qatzip_sw_fallback;
>> +}
>> +
>> int migrate_multifd_zstd_level(void)
>> {
>>     MigrationState *s =3D migrate_get_current();
>> @@ -983,6 +1012,11 @@ MigrationParameters
>> *qmp_query_migrate_parameters(Error **errp)
>>     params->multifd_compression =3D =
s->parameters.multifd_compression;
>>     params->has_multifd_zlib_level =3D true;
>>     params->multifd_zlib_level =3D s->parameters.multifd_zlib_level;
>> +    params->has_multifd_qatzip_level =3D true;
>> +    params->multifd_qatzip_level =3D =
s->parameters.multifd_qatzip_level;
>> +    params->has_multifd_qatzip_sw_fallback =3D true;
>> +    params->multifd_qatzip_sw_fallback =3D
>> +        s->parameters.multifd_qatzip_sw_fallback;
>>     params->has_multifd_zstd_level =3D true;
>>     params->multifd_zstd_level =3D s->parameters.multifd_zstd_level;
>>     params->has_xbzrle_cache_size =3D true;
>> @@ -1038,6 +1072,8 @@ void migrate_params_init(MigrationParameters
>> *params)
>>     params->has_multifd_channels =3D true;
>>     params->has_multifd_compression =3D true;
>>     params->has_multifd_zlib_level =3D true;
>> +    params->has_multifd_qatzip_level =3D true;
>> +    params->has_multifd_qatzip_sw_fallback =3D true;
>>     params->has_multifd_zstd_level =3D true;
>>     params->has_xbzrle_cache_size =3D true;
>>     params->has_max_postcopy_bandwidth =3D true;
>> @@ -1147,6 +1183,14 @@ bool migrate_params_check(MigrationParameters
>> *params, Error **errp)
>>         return false;
>>     }
>>=20
>> +    if (params->has_multifd_qatzip_level &&
>> +        ((params->multifd_qatzip_level > 9) ||
>> +        (params->multifd_qatzip_level < 1))) {
>> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>> "multifd_qatzip_level",
>> +                   "a value between 1 and 9");
>> +        return false;
>> +    }
>> +
>>     if (params->has_multifd_zstd_level &&
>>         (params->multifd_zstd_level > 20)) {
>>         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>> "multifd_zstd_level",
>> @@ -1312,6 +1356,12 @@ static void
>> migrate_params_test_apply(MigrateSetParameters *params,
>>     if (params->has_multifd_compression) {
>>         dest->multifd_compression =3D params->multifd_compression;
>>     }
>> +    if (params->has_multifd_qatzip_level) {
>> +        dest->multifd_qatzip_level =3D params->multifd_qatzip_level;
>> +    }
>> +    if (params->has_multifd_qatzip_sw_fallback) {
>> +        dest->multifd_qatzip_sw_fallback =3D params-
>>> multifd_qatzip_sw_fallback;
>> +    }
>>     if (params->has_xbzrle_cache_size) {
>>         dest->xbzrle_cache_size =3D params->xbzrle_cache_size;
>>     }
>> @@ -1447,6 +1497,13 @@ static void
>> migrate_params_apply(MigrateSetParameters *params, Error **errp)
>>     if (params->has_multifd_compression) {
>>         s->parameters.multifd_compression =3D =
params->multifd_compression;
>>     }
>> +    if (params->has_multifd_qatzip_level) {
>> +        s->parameters.multifd_qatzip_level =3D params-
>>> multifd_qatzip_level;
>> +    }
>> +    if (params->has_multifd_qatzip_sw_fallback) {
>> +        s->parameters.multifd_qatzip_sw_fallback =3D
>> +            params->multifd_qatzip_sw_fallback;
>> +    }
>>     if (params->has_xbzrle_cache_size) {
>>         s->parameters.xbzrle_cache_size =3D =
params->xbzrle_cache_size;
>>         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
>> diff --git a/migration/options.h b/migration/options.h
>> index 246c160aee..94aee24d97 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -87,6 +87,8 @@ MigMode migrate_mode(void);
>> int migrate_multifd_channels(void);
>> MultiFDCompression migrate_multifd_compression(void);
>> int migrate_multifd_zlib_level(void);
>> +int migrate_multifd_qatzip_level(void);
>> +bool migrate_multifd_qatzip_sw_fallback(void);
>> int migrate_multifd_zstd_level(void);
>> uint8_t migrate_throttle_trigger_threshold(void);
>> const char *migrate_tls_authz(void);
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 0b33a71ab4..66ea6d32fc 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -853,6 +853,16 @@
>> #     speed, and 9 means best compression ratio which will consume
>> #     more CPU. Defaults to 1. (Since 5.0)
>> #
>> +# @multifd-qatzip-level: Set the compression level to be used in =
live
>> +#     migration. The level is an integer between 1 and 9, where 1 =
means
>> +#     the best compression speed, and 9 means the best compression
>> +#     ratio which will consume more CPU. Defaults to 1.
>> +#
>> +# @multifd-qatzip-sw-fallback: Enable software fallback if QAT =
hardware
>> +#     is unavailable. Defaults to false. Software fallback =
performance
>> +#     is very poor compared to regular zlib, so be cautious about
>> +#     enabling this option.
>> +#
>> # @multifd-zstd-level: Set the compression level to be used in live
>> #     migration, the compression level is an integer between 0 and =
20,
>> #     where 0 means no compression, 1 means the best compression
>> @@ -915,6 +925,7 @@
>>            'xbzrle-cache-size', 'max-postcopy-bandwidth',
>>            'max-cpu-throttle', 'multifd-compression',
>>            'multifd-zlib-level', 'multifd-zstd-level',
>> +           'multifd-qatzip-level', 'multifd-qatzip-sw-fallback',
>>            'block-bitmap-mapping',
>>            { 'name': 'x-vcpu-dirty-limit-period', 'features':
>> ['unstable'] },
>>            'vcpu-dirty-limit',
>> @@ -1045,6 +1056,16 @@
>> #     speed, and 9 means best compression ratio which will consume
>> #     more CPU. Defaults to 1. (Since 5.0)
>> #
>> +# @multifd-qatzip-level: Set the compression level to be used in =
live
>> +#     migration. The level is an integer between 1 and 9, where 1 =
means
>> +#     the best compression speed, and 9 means the best compression
>> +#     ratio which will consume more CPU. Defaults to 1.
>> +#
>> +# @multifd-qatzip-sw-fallback: Enable software fallback if QAT =
hardware
>> +#     is unavailable. Defaults to false. Software fallback =
performance
>> +#     is very poor compared to regular zlib, so be cautious about
>> +#     enabling this option.
>> +#
>> # @multifd-zstd-level: Set the compression level to be used in live
>> #     migration, the compression level is an integer between 0 and =
20,
>> #     where 0 means no compression, 1 means the best compression
>> @@ -1125,6 +1146,8 @@
>>             '*max-cpu-throttle': 'uint8',
>>             '*multifd-compression': 'MultiFDCompression',
>>             '*multifd-zlib-level': 'uint8',
>> +            '*multifd-qatzip-level': 'uint8',
>> +            '*multifd-qatzip-sw-fallback': 'bool',
>>             '*multifd-zstd-level': 'uint8',
>>             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>>             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>> @@ -1273,6 +1296,16 @@
>> #     speed, and 9 means best compression ratio which will consume
>> #     more CPU. Defaults to 1. (Since 5.0)
>> #
>> +# @multifd-qatzip-level: Set the compression level to be used in =
live
>> +#     migration. The level is an integer between 1 and 9, where 1 =
means
>> +#     the best compression speed, and 9 means the best compression
>> +#     ratio which will consume more CPU. Defaults to 1.
>> +#
>> +# @multifd-qatzip-sw-fallback: Enable software fallback if QAT =
hardware
>> +#     is unavailable. Defaults to false. Software fallback =
performance
>> +#     is very poor compared to regular zlib, so be cautious about
>> +#     enabling this option.
>> +#
>> # @multifd-zstd-level: Set the compression level to be used in live
>> #     migration, the compression level is an integer between 0 and =
20,
>> #     where 0 means no compression, 1 means the best compression
>> @@ -1350,6 +1383,8 @@
>>             '*max-cpu-throttle': 'uint8',
>>             '*multifd-compression': 'MultiFDCompression',
>>             '*multifd-zlib-level': 'uint8',
>> +            '*multifd-qatzip-level': 'uint8',
>> +            '*multifd-qatzip-sw-fallback': 'bool',
>>             '*multifd-zstd-level': 'uint8',
>>             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>>             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>> --
>> 2.30.2



