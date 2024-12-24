Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87532E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 07:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPz5P-0000Rc-Ld; Tue, 24 Dec 2024 02:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tPz5M-0000Qa-Nl
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 02:12:08 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tPz5J-0008DH-5W
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 02:12:08 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e3fd6cd9ef7so5062179276.1
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 23:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1735024318; x=1735629118; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7Kuax/03VShzcoQCqLvj2QsHzo1QsCDp4pb4K0tG+I=;
 b=HJeil0D9tA6eiEY+U28qs2ueE/tLS/0hDwQcaPjRoTtb+V7D0PYl+xQAoQY7OedCum
 uOfsohh/nNexf3mkCPspdh2WEdNcfcNECccgpYhIuKV46FbHfyxxg4kpccK9qGsmZMHQ
 /b0Gi5YAhA3BB+SlL/ZoXna1ukM99haaSBLO2n5z7bPafXtpMQHOP4I9OYrvUjaJU2ys
 wnRcpdot+NasEGOwuBLZjk2EelcDlkaw0lvGat5Bsy+oGGQexjFaXqt7gkHnajrR5m94
 uCcjlkcgLmcMKpcTk3KE3TbtzA3hCLFH8HNGEYZhdlNCHpcZOSMQ+AAaojsZJCSvaiNu
 JMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735024318; x=1735629118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7Kuax/03VShzcoQCqLvj2QsHzo1QsCDp4pb4K0tG+I=;
 b=hPow9DOwjAoNm8auLShm4tujV7DqO168kqd/EBhwlw464x4SD60glSnNSq45anCkhI
 aBTAUEfF6/YZNt/lF7nNhaSHKhXkYhHkyAGlcOAE+3ay+ICESjRfoxpbXdRSpVuGYfNg
 gQD9tQqP2u3cjAC2fk6r0Gks1w//Z8NxQ8MDV8N/p9at2yt0EFF+ZrOztdmRIbu5pJIR
 IqMgINY24b5d/Ru0SL/kMynBguQvk5qH9O7uT90ZPdcK3vvM3DEbfFJ3GFDez/ONJyVh
 WbRENuANoczm5h5BJL5lI52nga+QM2n4bd3wAChE4b33Ju5uj1O8LdwzA5O9UehvyUxI
 hKWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6rzPBgpi7bflK+xIbQtaJpiF2bU+MFjqYzI45933ocTFutwUtTzi7adPP7NJWUPau2yYGLRRQTyR7@nongnu.org
X-Gm-Message-State: AOJu0Yzy8a2edbx0A6GhDLOw5vQ0JUZPkuihcS7a7eMjL2p4ft4mjlNJ
 GXNlIfnjLJeLdEYIgfM/YtSlC/GwmXq8LqwCVhoAJ8NPFa91I2b5PE8m9slBEG1GaSBvyg3LqSn
 dy0OQRzxDOgVVpVBStP6npvcUocEu3+vbU/2EjA==
X-Gm-Gg: ASbGncvJ7F88PshTcf/pyLaWQcm9MRAoLvGmotA4GX+g0DSTY6uY6LoVQMImc+Rgs+u
 HyeEAiRfqhHDnsE3kyQogN0x/ew1jUS+q8JydaVcoB74H0CjU4F8SgTnNfCj1IdnX+zXIWic=
X-Google-Smtp-Source: AGHT+IGdZ6sNllYmcMBHJtPK9ug8Bbq7ig2o/EFnT/Rnklz5TlglfxydXIObgX8N7vlQ0oaAmpmxkpDqH3X/+9AxOn8=
X-Received: by 2002:a05:690c:c07:b0:6f0:697:da5f with SMTP id
 00721157ae682-6f3e2b6bb89mr137931607b3.14.1735024317450; Mon, 23 Dec 2024
 23:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20241204021142.24184-1-yichen.wang@bytedance.com>
 <20241204021142.24184-9-yichen.wang@bytedance.com>
In-Reply-To: <20241204021142.24184-9-yichen.wang@bytedance.com>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Mon, 23 Dec 2024 23:11:46 -0800
Message-ID: <CAHObMVaaLAJZcQbDYKBr0nddvKeY1L=Nf8HjqN7CNd3Z3chfaA@mail.gmail.com>
Subject: Re: [PATCH v8 08/12] migration/multifd: Add new migration option for
 multifd DSA offloading.
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 Shivam Kumar <shivam.kumar1@nutanix.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Dec 3, 2024 at 6:12=E2=80=AFPM Yichen Wang <yichen.wang@bytedance.c=
om> wrote:
>
> From: Hao Xiang <hao.xiang@linux.dev>
>
> Intel DSA offloading is an optional feature that turns on if
> proper hardware and software stack is available. To turn on
> DSA offloading in multifd live migration by setting:
>
> zero-page-detection=3Ddsa-accel
> accel-path=3D"dsa:<dsa_dev_path1> dsa:[dsa_dev_path2] ..."
>
> This feature is turned off by default.
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>  hmp-commands.hx                |  2 +-
>  include/qemu/dsa.h             | 13 +++++++++++++
>  migration/migration-hmp-cmds.c | 20 +++++++++++++++++++-
>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 32 ++++++++++++++++++++++++++++----
>  util/dsa.c                     | 31 +++++++++++++++++++++++++++++++
>  7 files changed, 123 insertions(+), 6 deletions(-)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 06746f0afc..0e04eac7c7 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1009,7 +1009,7 @@ ERST
>
>      {
>          .name       =3D "migrate_set_parameter",
> -        .args_type  =3D "parameter:s,value:s",
> +        .args_type  =3D "parameter:s,value:S",
>          .params     =3D "parameter value",
>          .help       =3D "Set the parameter for migration",
>          .cmd        =3D hmp_migrate_set_parameter,
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> index 4972332bdf..18cb1df223 100644
> --- a/include/qemu/dsa.h
> +++ b/include/qemu/dsa.h
> @@ -100,6 +100,13 @@ void qemu_dsa_stop(void);
>   */
>  void qemu_dsa_cleanup(void);
>
> +/**
> + * @brief Check if DSA is supported.
> + *
> + * @return True if DSA is supported, otherwise false.
> + */
> +bool qemu_dsa_is_supported(void);
> +
>  /**
>   * @brief Check if DSA is running.
>   *
> @@ -141,6 +148,12 @@ buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batc=
h_task,
>
>  typedef struct QemuDsaBatchTask {} QemuDsaBatchTask;
>
> +static inline bool qemu_dsa_is_supported(void)
> +{
> +    return false;
> +}
> +
> +
>  static inline bool qemu_dsa_is_running(void)
>  {
>      return false;
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmd=
s.c
> index 20d1a6e219..3bb8d97393 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -312,7 +312,16 @@ void hmp_info_migrate_parameters(Monitor *mon, const=
 QDict *qdict)
>          monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>              params->tls_authz);
> -
> +        if (params->has_accel_path) {
> +            strList *accel_path =3D params->accel_path;
> +            monitor_printf(mon, "%s:",
> +                MigrationParameter_str(MIGRATION_PARAMETER_ACCEL_PATH));
> +            while (accel_path) {
> +                monitor_printf(mon, " '%s'", accel_path->value);
> +                accel_path =3D accel_path->next;
> +            }
> +            monitor_printf(mon, "\n");
> +        }
>          if (params->has_block_bitmap_mapping) {
>              const BitmapMigrationNodeAliasList *bmnal;
>
> @@ -563,6 +572,15 @@ void hmp_migrate_set_parameter(Monitor *mon, const Q=
Dict *qdict)
>          p->has_x_checkpoint_delay =3D true;
>          visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
>          break;
> +    case MIGRATION_PARAMETER_ACCEL_PATH:
> +        p->has_accel_path =3D true;
> +        char **strv =3D g_strsplit(valuestr ? : "", " ", -1);
> +        strList **tail =3D &p->accel_path;
> +        for (int i =3D 0; strv[i]; i++) {
> +            QAPI_LIST_APPEND(tail, strv[i]);
> +        }
> +        g_strfreev(strv);
> +        break;

I am doing my final testing, and seeing a new issue for above. This
code doesn't really work, because strv is freed and all contents after
the string split are gone. So here is what I am thinking:

1. This is supposed to be an easy visit_type_strList(v, param,
&p->accel_path, &err), but it actually doesn't work. The code will
throw:
qemu-system-x86_64.dsa: ../../../qapi/string-input-visitor.c:343:
parse_type_str: Assertion `siv->lm =3D=3D LM_NONE' failed.
when you are doing "migrate_set_parameter accel-path
dsa:/dev/dsa/wq0.1" from HMP.

2. If I remove the g_strfreev(strv), things are working perfectly. But
I am worried about the memory leak here. As technically if you keep
doing migrate_set_parameter for say 1 million times, memory will be
exhausted.

David or Fabiano, can you suggest what is the best approach here?

Thanks so much. Happy Holidays!

>      case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
>          p->has_multifd_channels =3D true;
>          visit_type_uint8(v, param, &p->multifd_channels, &err);
> diff --git a/migration/options.c b/migration/options.c
> index ad8d6989a8..ca89fdc4f4 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -13,6 +13,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/dsa.h"
>  #include "exec/target_page.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> @@ -809,6 +810,13 @@ const char *migrate_tls_creds(void)
>      return s->parameters.tls_creds;
>  }
>
> +const strList *migrate_accel_path(void)
> +{
> +    MigrationState *s =3D migrate_get_current();
> +
> +    return s->parameters.accel_path;
> +}
> +
>  const char *migrate_tls_hostname(void)
>  {
>      MigrationState *s =3D migrate_get_current();
> @@ -922,6 +930,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
>      params->zero_page_detection =3D s->parameters.zero_page_detection;
>      params->has_direct_io =3D true;
>      params->direct_io =3D s->parameters.direct_io;
> +    params->has_accel_path =3D true;
> +    params->accel_path =3D QAPI_CLONE(strList, s->parameters.accel_path)=
;
>
>      return params;
>  }
> @@ -930,6 +940,7 @@ void migrate_params_init(MigrationParameters *params)
>  {
>      params->tls_hostname =3D g_strdup("");
>      params->tls_creds =3D g_strdup("");
> +    params->accel_path =3D NULL;
>
>      /* Set has_* up only for parameter checks */
>      params->has_throttle_trigger_threshold =3D true;
> @@ -1142,6 +1153,14 @@ bool migrate_params_check(MigrationParameters *par=
ams, Error **errp)
>          return false;
>      }
>
> +    if (params->has_zero_page_detection &&
> +        params->zero_page_detection =3D=3D ZERO_PAGE_DETECTION_DSA_ACCEL=
) {
> +        if (!qemu_dsa_is_supported()) {
> +            error_setg(errp, "DSA acceleration is not supported.");
> +            return false;
> +        }
> +    }
> +
>      return true;
>  }
>
> @@ -1255,6 +1274,11 @@ static void migrate_params_test_apply(MigrateSetPa=
rameters *params,
>      if (params->has_direct_io) {
>          dest->direct_io =3D params->direct_io;
>      }
> +
> +    if (params->has_accel_path) {
> +        dest->has_accel_path =3D true;
> +        dest->accel_path =3D params->accel_path;
> +    }
>  }
>
>  static void migrate_params_apply(MigrateSetParameters *params, Error **e=
rrp)
> @@ -1387,6 +1411,12 @@ static void migrate_params_apply(MigrateSetParamet=
ers *params, Error **errp)
>      if (params->has_direct_io) {
>          s->parameters.direct_io =3D params->direct_io;
>      }
> +    if (params->has_accel_path) {
> +        qapi_free_strList(s->parameters.accel_path);
> +        s->parameters.has_accel_path =3D true;
> +        s->parameters.accel_path =3D
> +            QAPI_CLONE(strList, params->accel_path);
> +    }
>  }
>
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **er=
rp)
> diff --git a/migration/options.h b/migration/options.h
> index 79084eed0d..3d1e91dc52 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -84,6 +84,7 @@ const char *migrate_tls_creds(void);
>  const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
> +const strList *migrate_accel_path(void);
>
>  /* parameters helpers */
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index a605dc26db..389776065d 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -629,10 +629,14 @@
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
> @@ -840,6 +844,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @accel-path: If enabled, specify the accelerator paths that to be
> +#     used in QEMU. For example, enable DSA accelerator for zero page
> +#     detection offloading by setting the @zero-page-detection to
> +#     dsa-accel, and defines the accel-path to "dsa:<dsa_device path>".
> +#     This parameter is default to an empty list.  (Since 9.2)
> +#
>  # @direct-io: Open migration files with O_DIRECT when possible.  This
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
> @@ -858,7 +868,7 @@
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'cpu-throttle-tailslow',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> -           'avail-switchover-bandwidth', 'downtime-limit',
> +           'avail-switchover-bandwidth', 'downtime-limit', 'accel-path',
>             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> @@ -1021,6 +1031,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @accel-path: If enabled, specify the accelerator paths that to be
> +#     used in QEMU. For example, enable DSA accelerator for zero page
> +#     detection offloading by setting the @zero-page-detection to
> +#     dsa-accel, and defines the accel-path to "dsa:<dsa_device path>".
> +#     This parameter is default to an empty list.  (Since 9.2)
> +#
>  # @direct-io: Open migration files with O_DIRECT when possible.  This
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
> @@ -1066,7 +1082,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*accel-path': [ 'str' ] } }
>
>  ##
>  # @migrate-set-parameters:
> @@ -1231,6 +1248,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @accel-path: If enabled, specify the accelerator paths that to be
> +#     used in QEMU. For example, enable DSA accelerator for zero page
> +#     detection offloading by setting the @zero-page-detection to
> +#     dsa-accel, and defines the accel-path to "dsa:<dsa_device path>".
> +#     This parameter is default to an empty list.  (Since 9.2)
> +#
>  # @direct-io: Open migration files with O_DIRECT when possible.  This
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
> @@ -1273,7 +1296,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*accel-path': [ 'str' ] } }
>
>  ##
>  # @query-migrate-parameters:
> diff --git a/util/dsa.c b/util/dsa.c
> index e6b7db2cf6..a530a607e7 100644
> --- a/util/dsa.c
> +++ b/util/dsa.c
> @@ -23,6 +23,7 @@
>  #include "qemu/bswap.h"
>  #include "qemu/error-report.h"
>  #include "qemu/rcu.h"
> +#include <cpuid.h>
>
>  #pragma GCC push_options
>  #pragma GCC target("enqcmd")
> @@ -687,6 +688,36 @@ static void dsa_completion_thread_stop(void *opaque)
>      qemu_sem_destroy(&thread_context->sem_init_done);
>  }
>
> +/**
> + * @brief Check if DSA is supported.
> + *
> + * @return True if DSA is supported, otherwise false.
> + */
> +bool qemu_dsa_is_supported(void)
> +{
> +    /*
> +     * movdir64b is indicated by bit 28 of ecx in CPUID leaf 7, subleaf =
0.
> +     * enqcmd is indicated by bit 29 of ecx in CPUID leaf 7, subleaf 0.
> +     * Doc: https://cdrdv2-public.intel.com/819680/architecture-instruct=
ion-\
> +     *      set-extensions-programming-reference.pdf
> +     */
> +    uint32_t eax, ebx, ecx, edx;
> +    bool movedirb_enabled;
> +    bool enqcmd_enabled;
> +
> +    __get_cpuid_count(7, 0, &eax, &ebx, &ecx, &edx);
> +    movedirb_enabled =3D (ecx >> 28) & 0x1;
> +    if (!movedirb_enabled) {
> +        return false;
> +    }
> +    enqcmd_enabled =3D (ecx >> 29) & 0x1;
> +    if (!enqcmd_enabled) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  /**
>   * @brief Check if DSA is running.
>   *
> --
> Yichen Wang
>

