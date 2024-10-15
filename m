Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FFCD20681
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 22:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0pjl-0006Fv-3i; Tue, 15 Oct 2024 18:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1t0pjj-0006FG-4k
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 18:09:51 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1t0pjg-0006d1-N2
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 18:09:50 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6e35bf59cf6so3572407b3.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1729030187; x=1729634987; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLwmT3xBx6rCg1lN6zp0aBSJ7OPnxy6ZU1h5UKXR2Sg=;
 b=fUyXBmBU+Nv4lB2GsD3BNeA8EMaEwGsqFvFO3UObpc8WlaakqSbcSTFMf4Q12ImgLX
 7exyg5CSP/bRpAqkCTB62rW7bFrELxYZiHjIdmCHmcgPk+uGUWhbTWrwc1x+8ani7RGx
 +PXYk0b0mIYFdWPV+/2c1JufhwpJWmp3UwyezbnIARvQFTDlEfXdgYF8MNYmxYnQzKCS
 BPIilxpggwdeoJGV2UY2tWkklMP+DmsqL5Ttnpz/Q8ua2q+YUBKQV6JDzlnXLROtbrp+
 LhiPbvq1gfgzMhKLkbxG6JUOd1DlFaQjZXb1Z8HcUJrdTyE/JrtJzFfgf59b+iY2WyTT
 Tecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729030187; x=1729634987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLwmT3xBx6rCg1lN6zp0aBSJ7OPnxy6ZU1h5UKXR2Sg=;
 b=IKKMeNDX71x+22QWNb/U9pgpfjja3BgB/tUi3idMiAPh/4g37lpfn55FRHWZZci967
 9WeqeB3Q4+t9SJb2SVaf8NX4qovR3ywprSx9muZDtIrfb/B9bj9FW0zl2Eq1NFY0h7xO
 KV46btnc+OVumf7advoqxD0K1GKheqc7gacsb0eGyAJ0LhSmP/nPQNUXZc+00ZiYpZji
 t3YP/8uHFxM5mGRnWtOFzIeAUOVVoSYXxK4ck1JHsLHfuyfbvKRLAAxQPNKJ0RufWW3n
 1S2tR6ummbUZM0L5A94ZlbLbe54mfBuwyP/Kl6tO7yjgIEHaYpAVoVa8ntMXEnxheEKq
 EWjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb6gB8p8j/MTQ4kXCRghC5MQMbC7gaEqVi6sL4++YgCQAIyKJhNar3Ov3t8ADlmZCVXiuJFAWlyD+P@nongnu.org
X-Gm-Message-State: AOJu0YxkpOW0utJgQUiixVI4++8uQBVn6dAKpYesdM+jBBaat+ZUqYgJ
 wKBTM22E9gDdG/ez8Qh+AJHsN9IJfNC5fkrBfNXLa71aHIL4hFHcRLRyakSOgiVakfC6od/6YH+
 niAQVXyksWsKF1WO+4+1JSBkO1DWuh1vxme1eqA==
X-Google-Smtp-Source: AGHT+IG4w1x8cmXCVRemu4e6GvTKkb5zDL27sAaw2Fl8mjkMfbxZaeQ1PJ6anY5/ul+l55sNtQMUO+6IJNNckSfrDnk=
X-Received: by 2002:a05:690c:6504:b0:6e2:3e9:d892 with SMTP id
 00721157ae682-6e3d3823031mr21664157b3.19.1729030187490; Tue, 15 Oct 2024
 15:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
 <20241009234610.27039-9-yichen.wang@bytedance.com>
 <Zwlc-CmBC2Q-Q1A8@gallifrey>
In-Reply-To: <Zwlc-CmBC2Q-Q1A8@gallifrey>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Tue, 15 Oct 2024 15:09:36 -0700
Message-ID: <CAHObMVZ-CcrYnUpP5OHbkSO7-WVKKzGfAD4NVMg_szJP7si5Dw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 08/12] migration/multifd: Add new
 migration option for multifd DSA offloading.
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 qemu-devel@nongnu.org, Hao Xiang <hao.xiang@linux.dev>, 
 "Liu, Yuan1" <yuan1.liu@intel.com>, Shivam Kumar <shivam.kumar1@nutanix.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yw1-x1134.google.com
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

On Fri, Oct 11, 2024 at 10:14=E2=80=AFAM Dr. David Alan Gilbert
<dave@treblig.org> wrote:
>
> * Yichen Wang (yichen.wang@bytedance.com) wrote:
> > From: Hao Xiang <hao.xiang@linux.dev>
>
> Please split the cpuid stuff out into a separate patch; it feels like
> it should be in some x86 specific place.

DSA is an Intel feature/device, and it only makes sense on x86. I
mean, dsa.c already implies that it is a x86 specific feature. So I
guess keeping it in the dsa.c is a better option?

>
> > Intel DSA offloading is an optional feature that turns on if
> > proper hardware and software stack is available. To turn on
> > DSA offloading in multifd live migration by setting:
> >
> > zero-page-detection=3Ddsa-accel
> > dsa-accel-path=3D[dsa_dev_path1] [dsa_dev_path2] ... [dsa_dev_pathX]
>
> I'd like to suggest changing that to:
>
> accel-path=3Ddsa:dev_path1 dsa:dev_path2 somethingelse:dev_path2 etc
>
> that means we don't need a new option when someone adds a different
> accelerator.

It all depends on the implementation of "other accelerators". I am OK
with this change if you believe that is better.

>
> Dave
> > This feature is turned off by default.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> > Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> > ---
> >  hmp-commands.hx                |  2 +-
> >  include/qemu/dsa.h             | 13 +++++++++++++
> >  migration/migration-hmp-cmds.c | 19 ++++++++++++++++++-
> >  migration/options.c            | 30 ++++++++++++++++++++++++++++++
> >  migration/options.h            |  1 +
> >  qapi/migration.json            | 32 ++++++++++++++++++++++++++++----
> >  util/dsa.c                     | 31 +++++++++++++++++++++++++++++++
> >  7 files changed, 122 insertions(+), 6 deletions(-)
> >
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index 06746f0afc..0e04eac7c7 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -1009,7 +1009,7 @@ ERST
> >
> >      {
> >          .name       =3D "migrate_set_parameter",
> > -        .args_type  =3D "parameter:s,value:s",
> > +        .args_type  =3D "parameter:s,value:S",
>
> Can you show the case you need this for?
>

That is used for pass a strList in the QEMU CLI. Without this change,
I cannot do:
migrate_set_parameter dsa-accel-path /dev/dsa/wq0.1 /dev/dsa/wq0.1
and it will complain.

> Dave
>
> >          .params     =3D "parameter value",
> >          .help       =3D "Set the parameter for migration",
> >          .cmd        =3D hmp_migrate_set_parameter,
> > diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> > index a3b502ee41..b1bb6daad2 100644
> > --- a/include/qemu/dsa.h
> > +++ b/include/qemu/dsa.h
> > @@ -100,6 +100,13 @@ void qemu_dsa_stop(void);
> >   */
> >  void qemu_dsa_cleanup(void);
> >
> > +/**
> > + * @brief Check if DSA is supported.
> > + *
> > + * @return True if DSA is supported, otherwise false.
> > + */
> > +bool qemu_dsa_is_supported(void);
> > +
> >  /**
> >   * @brief Check if DSA is running.
> >   *
> > @@ -141,6 +148,12 @@ buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *ba=
tch_task,
> >
> >  typedef struct QemuDsaBatchTask {} QemuDsaBatchTask;
> >
> > +static inline bool qemu_dsa_is_supported(void)
> > +{
> > +    return false;
> > +}
> > +
> > +
> >  static inline bool qemu_dsa_is_running(void)
> >  {
> >      return false;
> > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-c=
mds.c
> > index 20d1a6e219..983f13b73c 100644
> > --- a/migration/migration-hmp-cmds.c
> > +++ b/migration/migration-hmp-cmds.c
> > @@ -312,7 +312,16 @@ void hmp_info_migrate_parameters(Monitor *mon, con=
st QDict *qdict)
> >          monitor_printf(mon, "%s: '%s'\n",
> >              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> >              params->tls_authz);
> > -
> > +        if (params->has_dsa_accel_path) {
> > +            strList *dsa_accel_path =3D params->dsa_accel_path;
> > +            monitor_printf(mon, "%s:",
> > +                MigrationParameter_str(MIGRATION_PARAMETER_DSA_ACCEL_P=
ATH));
> > +            while (dsa_accel_path) {
> > +                monitor_printf(mon, " '%s'", dsa_accel_path->value);
> > +                dsa_accel_path =3D dsa_accel_path->next;
> > +            }
> > +            monitor_printf(mon, "\n");
> > +        }
> >          if (params->has_block_bitmap_mapping) {
> >              const BitmapMigrationNodeAliasList *bmnal;
> >
> > @@ -563,6 +572,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
> >          p->has_x_checkpoint_delay =3D true;
> >          visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
> >          break;
> > +    case MIGRATION_PARAMETER_DSA_ACCEL_PATH:
> > +        p->has_dsa_accel_path =3D true;
> > +        g_autofree char **strv =3D g_strsplit(valuestr ? : "", " ", -1=
);
> > +        strList **tail =3D &p->dsa_accel_path;
> > +        for (int i =3D 0; strv[i]; i++) {
> > +            QAPI_LIST_APPEND(tail, strv[i]);
> > +        }
> > +        break;
> >      case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
> >          p->has_multifd_channels =3D true;
> >          visit_type_uint8(v, param, &p->multifd_channels, &err);
> > diff --git a/migration/options.c b/migration/options.c
> > index 147cd2b8fd..a0b3a7d291 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -13,6 +13,7 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "qemu/error-report.h"
> > +#include "qemu/dsa.h"
> >  #include "exec/target_page.h"
> >  #include "qapi/clone-visitor.h"
> >  #include "qapi/error.h"
> > @@ -832,6 +833,13 @@ const char *migrate_tls_creds(void)
> >      return s->parameters.tls_creds;
> >  }
> >
> > +const strList *migrate_dsa_accel_path(void)
> > +{
> > +    MigrationState *s =3D migrate_get_current();
> > +
> > +    return s->parameters.dsa_accel_path;
> > +}
> > +
> >  const char *migrate_tls_hostname(void)
> >  {
> >      MigrationState *s =3D migrate_get_current();
> > @@ -945,6 +953,8 @@ MigrationParameters *qmp_query_migrate_parameters(E=
rror **errp)
> >      params->zero_page_detection =3D s->parameters.zero_page_detection;
> >      params->has_direct_io =3D true;
> >      params->direct_io =3D s->parameters.direct_io;
> > +    params->has_dsa_accel_path =3D true;
> > +    params->dsa_accel_path =3D QAPI_CLONE(strList, s->parameters.dsa_a=
ccel_path);
> >
> >      return params;
> >  }
> > @@ -953,6 +963,7 @@ void migrate_params_init(MigrationParameters *param=
s)
> >  {
> >      params->tls_hostname =3D g_strdup("");
> >      params->tls_creds =3D g_strdup("");
> > +    params->dsa_accel_path =3D NULL;
> >
> >      /* Set has_* up only for parameter checks */
> >      params->has_throttle_trigger_threshold =3D true;
> > @@ -1165,6 +1176,14 @@ bool migrate_params_check(MigrationParameters *p=
arams, Error **errp)
> >          return false;
> >      }
> >
> > +    if (params->has_zero_page_detection &&
> > +        params->zero_page_detection =3D=3D ZERO_PAGE_DETECTION_DSA_ACC=
EL) {
> > +        if (!qemu_dsa_is_supported()) {
> > +            error_setg(errp, "DSA acceleration is not supported.");
> > +            return false;
> > +        }
> > +    }
> > +
> >      return true;
> >  }
> >
> > @@ -1278,6 +1297,11 @@ static void migrate_params_test_apply(MigrateSet=
Parameters *params,
> >      if (params->has_direct_io) {
> >          dest->direct_io =3D params->direct_io;
> >      }
> > +
> > +    if (params->has_dsa_accel_path) {
> > +        dest->has_dsa_accel_path =3D true;
> > +        dest->dsa_accel_path =3D params->dsa_accel_path;
> > +    }
> >  }
> >
> >  static void migrate_params_apply(MigrateSetParameters *params, Error *=
*errp)
> > @@ -1410,6 +1434,12 @@ static void migrate_params_apply(MigrateSetParam=
eters *params, Error **errp)
> >      if (params->has_direct_io) {
> >          s->parameters.direct_io =3D params->direct_io;
> >      }
> > +    if (params->has_dsa_accel_path) {
> > +        qapi_free_strList(s->parameters.dsa_accel_path);
> > +        s->parameters.has_dsa_accel_path =3D true;
> > +        s->parameters.dsa_accel_path =3D
> > +            QAPI_CLONE(strList, params->dsa_accel_path);
> > +    }
> >  }
> >
> >  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **=
errp)
> > diff --git a/migration/options.h b/migration/options.h
> > index a0bd6edc06..8198b220bd 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -86,6 +86,7 @@ const char *migrate_tls_creds(void);
> >  const char *migrate_tls_hostname(void);
> >  uint64_t migrate_xbzrle_cache_size(void);
> >  ZeroPageDetection migrate_zero_page_detection(void);
> > +const strList *migrate_dsa_accel_path(void);
> >
> >  /* parameters helpers */
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index b66cccf107..d8b42ceae6 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -626,10 +626,14 @@
> >  #     multifd migration is enabled, else in the main migration thread
> >  #     as for @legacy.
> >  #
> > +# @dsa-accel: Perform zero page checking with the DSA accelerator
> > +#     offloading in multifd sender thread if multifd migration is
> > +#     enabled, else in the main migration thread as for @legacy.
> > +#
> >  # Since: 9.0
> >  ##
> >  { 'enum': 'ZeroPageDetection',
> > -  'data': [ 'none', 'legacy', 'multifd' ] }
> > +  'data': [ 'none', 'legacy', 'multifd', 'dsa-accel' ] }
> >
> >  ##
> >  # @BitmapMigrationBitmapAliasTransform:
> > @@ -837,6 +841,12 @@
> >  #     See description in @ZeroPageDetection.  Default is 'multifd'.
> >  #     (since 9.0)
> >  #
> > +# @dsa-accel-path: If enabled, use DSA accelerator offloading for
> > +#     certain memory operations. Enable DSA accelerator for zero
> > +#     page detection offloading by setting the @zero-page-detection
> > +#     to dsa-accel. This parameter defines the dsa device path, and
> > +#     defaults to an empty list.  (Since 9.2)
> > +#
> >  # @direct-io: Open migration files with O_DIRECT when possible.  This
> >  #     only has effect if the @mapped-ram capability is enabled.
> >  #     (Since 9.1)
> > @@ -855,7 +865,7 @@
> >             'cpu-throttle-initial', 'cpu-throttle-increment',
> >             'cpu-throttle-tailslow',
> >             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> > -           'avail-switchover-bandwidth', 'downtime-limit',
> > +           'avail-switchover-bandwidth', 'downtime-limit', 'dsa-accel-=
path',
> >             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] =
},
> >             'multifd-channels',
> >             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> > @@ -1018,6 +1028,12 @@
> >  #     See description in @ZeroPageDetection.  Default is 'multifd'.
> >  #     (since 9.0)
> >  #
> > +# @dsa-accel-path: If enabled, use DSA accelerator offloading for
> > +#     certain memory operations. Enable DSA accelerator for zero
> > +#     page detection offloading by setting the @zero-page-detection
> > +#     to dsa-accel. This parameter defines the dsa device path, and
> > +#     defaults to an empty list.  (Since 9.2)
> > +#
> >  # @direct-io: Open migration files with O_DIRECT when possible.  This
> >  #     only has effect if the @mapped-ram capability is enabled.
> >  #     (Since 9.1)
> > @@ -1063,7 +1079,8 @@
> >              '*vcpu-dirty-limit': 'uint64',
> >              '*mode': 'MigMode',
> >              '*zero-page-detection': 'ZeroPageDetection',
> > -            '*direct-io': 'bool' } }
> > +            '*direct-io': 'bool',
> > +            '*dsa-accel-path': [ 'str' ] } }
> >
> >  ##
> >  # @migrate-set-parameters:
> > @@ -1228,6 +1245,12 @@
> >  #     See description in @ZeroPageDetection.  Default is 'multifd'.
> >  #     (since 9.0)
> >  #
> > +# @dsa-accel-path: If enabled, use DSA accelerator offloading for
> > +#     certain memory operations. Enable DSA accelerator for zero
> > +#     page detection offloading by setting the @zero-page-detection
> > +#     to dsa-accel. This parameter defines the dsa device path, and
> > +#     defaults to an empty list.  (Since 9.2)
> > +#
> >  # @direct-io: Open migration files with O_DIRECT when possible.  This
> >  #     only has effect if the @mapped-ram capability is enabled.
> >  #     (Since 9.1)
> > @@ -1270,7 +1293,8 @@
> >              '*vcpu-dirty-limit': 'uint64',
> >              '*mode': 'MigMode',
> >              '*zero-page-detection': 'ZeroPageDetection',
> > -            '*direct-io': 'bool' } }
> > +            '*direct-io': 'bool',
> > +            '*dsa-accel-path': [ 'str' ] } }
> >
> >  ##
> >  # @query-migrate-parameters:
> > diff --git a/util/dsa.c b/util/dsa.c
> > index cbaa47c360..eeede3c0c7 100644
> > --- a/util/dsa.c
> > +++ b/util/dsa.c
> > @@ -23,6 +23,7 @@
> >  #include "qemu/bswap.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/rcu.h"
> > +#include <cpuid.h>
> >
> >  #pragma GCC push_options
> >  #pragma GCC target("enqcmd")
> > @@ -691,6 +692,36 @@ static void dsa_completion_thread_stop(void *opaqu=
e)
> >      qemu_sem_destroy(&thread_context->sem_init_done);
> >  }
> >
> > +/**
> > + * @brief Check if DSA is supported.
> > + *
> > + * @return True if DSA is supported, otherwise false.
> > + */
> > +bool qemu_dsa_is_supported(void)
> > +{
> > +    /*
> > +     * movdir64b is indicated by bit 28 of ecx in CPUID leaf 7, sublea=
f 0.
> > +     * enqcmd is indicated by bit 29 of ecx in CPUID leaf 7, subleaf 0=
.
> > +     * Doc: https://cdrdv2-public.intel.com/819680/architecture-instru=
ction-\
> > +     *      set-extensions-programming-reference.pdf
> > +     */
> > +    uint32_t eax, ebx, ecx, edx;
> > +    bool movedirb_enabled;
> > +    bool enqcmd_enabled;
> > +
> > +    __get_cpuid_count(7, 0, &eax, &ebx, &ecx, &edx);
> > +    movedirb_enabled =3D (ecx >> 28) & 0x1;
> > +    if (!movedirb_enabled) {
> > +        return false;
> > +    }
> > +    enqcmd_enabled =3D (ecx >> 29) & 0x1;
> > +    if (!enqcmd_enabled) {
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> >  /**
> >   * @brief Check if DSA is running.
> >   *
> > --
> > Yichen Wang
> >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

