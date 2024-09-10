Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23931ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 06:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sntvy-0006AH-PD; Tue, 10 Sep 2024 02:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sntvo-00069J-4a
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:00:56 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sntvi-0001lx-BG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:00:50 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-277c861d9f6so2942301fac.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725948044; x=1726552844;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p0Q9bWyjvRXqcr4iD+iPDPvO9ruYSsjQ6f1X128SPLA=;
 b=sQg7QgUkFgTWNjGJEsLMoUZrWLUw3b0OWtL259oWJd7JKNgybZXEa0IFa/uCTp6+/V
 ob/8LJnZkA4O9qHU576kaGaWP/SwigGO1bDxNHx3Gw8jpumGF/iGdRJsmIfNxZI75b9F
 emjhe0Szkgs9NLF8+BVuPOzYhHt3pNm8Lk2vId5+F5YgkY4s4/HxrBAv8TeRWVci0CmN
 SDnT+HXhbtZXCwZ4s52718urMMINykTTVhyp4knxqFPZWnB2qhTZdqRcQVGY1WebfD9W
 Mai0SyNtxgMZM9EKy5YYoqhN9xzXVDgYNCNC5UsWLgVN736k3/31lKROppcCGmDqfKEs
 FEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725948044; x=1726552844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p0Q9bWyjvRXqcr4iD+iPDPvO9ruYSsjQ6f1X128SPLA=;
 b=t7UL2uTIbXnENL80okCDFTLUijXLP7w/AqixWAVWFw2v8QLnOvqp40UiaNPoEEbdPt
 fkSoRauZmDmrMnJ8IpjzioF3a7ZqOgGp6iyTQ8eGoIfBDyOeRSBNJA+Rw8OrPZMYJwYr
 6e/AfCnyxf+hitg06eA4rp2ud8JuSE3b1j+uBXx3RLVBjNJbs4XBYk61fDtmBOgwLJex
 lhbQEi7KZ15PaOTRevVy0eOKc5GbVN0vBPcQZ1Ippj38QII+VZxG9pWH8slMTiK93sUt
 4hfdZlwivCPLH1qGbU7xqKkjQBIomf6dtQqcwxMjxWAZUJQrZTFzCp36quocRkVXZI24
 kp/w==
X-Gm-Message-State: AOJu0YzHDOWvW6AcZ9p9BzLTlP6q1xA9KWXQnFp40sVt1cV8scAniE98
 6IZfluY4e30I0bXZsgxItqTjz0/+5BZ1IUqwra1uuS432GqTPfAzSd2NHizU/G3hVcOrKiMrXRC
 CkMiTm4LtL274DoRFxSVSqOaKhwOBk229Lv7Ku8S2ywfhggxMu/3gF8s9
X-Google-Smtp-Source: AGHT+IEuuZtXugZ8dpgTWKow9XN7/TTHemaoksHCBB8c8oJkj88rzwYe66d3ByZrE4LMWfjnYdi4oIZNI7Yac/7/g64=
X-Received: by 2002:a05:6870:af47:b0:278:8b:57b1 with SMTP id
 586e51a60fabf-27b82fab4a7mr13352727fac.35.1725948043166; Mon, 09 Sep 2024
 23:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725891841.git.yong.huang@smartx.com>
 <08d77dbc95b8836189bae049e82e790ead6c8535.1725891841.git.yong.huang@smartx.com>
In-Reply-To: <08d77dbc95b8836189bae049e82e790ead6c8535.1725891841.git.yong.huang@smartx.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 10 Sep 2024 14:00:26 +0800
Message-ID: <CAK9dgma3ruS0KgkP-Cz-4BtF6foQD3i5iPKHS9g5jEF4eEHTtg@mail.gmail.com>
Subject: Re: [PATCH RESEND RFC 08/10] migration: Introduce
 cpu-responsive-throttle parameter
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000003a3420621bd986d"
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000003a3420621bd986d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In order to reduce the maintenance work of QMP.

Given that the focus of this patchset is huge VM migration, is
it possible to enable or disable these two features with a single
parameter, such as "cpu-aggressive-throttle"?

Yong

On Mon, Sep 9, 2024 at 10:26=E2=80=AFPM Hyman Huang <yong.huang@smartx.com>=
 wrote:

> To enable the responsive throttle that will be implemented
> in the next commit, introduce the cpu-responsive-throttle
> parameter.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/migration-hmp-cmds.c |  8 ++++++++
>  migration/options.c            | 20 ++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 16 +++++++++++++++-
>  4 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration-hmp-cmds.c
> b/migration/migration-hmp-cmds.c
> index f7b8e06bb4..a3d4d3f62f 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -273,6 +273,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const
> QDict *qdict)
>              MigrationParameter_str(
>                  MIGRATION_PARAMETER_CPU_PERIODIC_THROTTLE_INTERVAL),
>              params->cpu_periodic_throttle_interval);
> +        assert(params->has_cpu_responsive_throttle);
> +        monitor_printf(mon, "%s: %s\n",
> +
> MigrationParameter_str(MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE),
> +            params->cpu_responsive_throttle ? "on" : "off");
>          assert(params->has_max_cpu_throttle);
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE)=
,
> @@ -529,6 +533,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const
> QDict *qdict)
>          p->has_cpu_periodic_throttle_interval =3D true;
>          visit_type_uint8(v, param, &p->cpu_periodic_throttle_interval,
> &err);
>          break;
> +    case MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE:
> +        p->has_cpu_responsive_throttle =3D true;
> +        visit_type_bool(v, param, &p->cpu_responsive_throttle, &err);
> +        break;
>      case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
>          p->has_max_cpu_throttle =3D true;
>          visit_type_uint8(v, param, &p->max_cpu_throttle, &err);
> diff --git a/migration/options.c b/migration/options.c
> index 2dbe275ba0..aa233684ee 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -110,6 +110,8 @@ Property migration_properties[] =3D {
>      DEFINE_PROP_UINT8("x-cpu-periodic-throttle-interval", MigrationState=
,
>                        parameters.cpu_periodic_throttle_interval,
>                        DEFAULT_MIGRATE_CPU_PERIODIC_THROTTLE_INTERVAL),
> +    DEFINE_PROP_BOOL("x-cpu-responsive-throttle", MigrationState,
> +                      parameters.cpu_responsive_throttle, false),
>      DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
>                        parameters.max_bandwidth, MAX_THROTTLE),
>      DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
> @@ -715,6 +717,13 @@ bool migrate_periodic_throttle(void)
>      return s->parameters.cpu_periodic_throttle;
>  }
>
> +bool migrate_responsive_throttle(void)
> +{
> +    MigrationState *s =3D migrate_get_current();
> +
> +    return s->parameters.cpu_responsive_throttle;
> +}
> +
>  bool migrate_cpu_throttle_tailslow(void)
>  {
>      MigrationState *s =3D migrate_get_current();
> @@ -899,6 +908,8 @@ MigrationParameters
> *qmp_query_migrate_parameters(Error **errp)
>      params->has_cpu_periodic_throttle_interval =3D true;
>      params->cpu_periodic_throttle_interval =3D
>          s->parameters.cpu_periodic_throttle_interval;
> +    params->has_cpu_responsive_throttle =3D true;
> +    params->cpu_responsive_throttle =3D
> s->parameters.cpu_responsive_throttle;
>      params->tls_creds =3D g_strdup(s->parameters.tls_creds);
>      params->tls_hostname =3D g_strdup(s->parameters.tls_hostname);
>      params->tls_authz =3D g_strdup(s->parameters.tls_authz ?
> @@ -967,6 +978,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_cpu_throttle_tailslow =3D true;
>      params->has_cpu_periodic_throttle =3D true;
>      params->has_cpu_periodic_throttle_interval =3D true;
> +    params->has_cpu_responsive_throttle =3D true;
>      params->has_max_bandwidth =3D true;
>      params->has_downtime_limit =3D true;
>      params->has_x_checkpoint_delay =3D true;
> @@ -1208,6 +1220,10 @@ static void
> migrate_params_test_apply(MigrateSetParameters *params,
>              params->cpu_periodic_throttle_interval;
>      }
>
> +    if (params->has_cpu_responsive_throttle) {
> +        dest->cpu_responsive_throttle =3D params->cpu_responsive_throttl=
e;
> +    }
> +
>      if (params->tls_creds) {
>          assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
>          dest->tls_creds =3D params->tls_creds->u.s;
> @@ -1325,6 +1341,10 @@ static void
> migrate_params_apply(MigrateSetParameters *params, Error **errp)
>              params->cpu_periodic_throttle_interval;
>      }
>
> +    if (params->has_cpu_responsive_throttle) {
> +        s->parameters.cpu_responsive_throttle =3D
> params->cpu_responsive_throttle;
> +    }
> +
>      if (params->tls_creds) {
>          g_free(s->parameters.tls_creds);
>          assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
> diff --git a/migration/options.h b/migration/options.h
> index efeac01470..613d675003 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -70,6 +70,7 @@ uint8_t migrate_cpu_throttle_increment(void);
>  uint8_t migrate_cpu_throttle_initial(void);
>  uint8_t migrate_periodic_throttle_interval(void);
>  bool migrate_periodic_throttle(void);
> +bool migrate_responsive_throttle(void);
>  bool migrate_cpu_throttle_tailslow(void);
>  bool migrate_direct_io(void);
>  uint64_t migrate_downtime_limit(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 6d8358c202..9f52ed1899 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -734,6 +734,10 @@
>  # @cpu-periodic-throttle-interval: Interval of the periodic CPU
> throttling.
>  #     (Since 9.1)
>  #
> +# @cpu-responsive-throttle: Make CPU throttling more responsively by
> +#                           introduce an extra detection metric of
> +#                           migration convergence. (Since 9.1)
> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials
>  #     for establishing a TLS connection over the migration data
>  #     channel.  On the outgoing side of the migration, the credentials
> @@ -855,7 +859,7 @@
>             'throttle-trigger-threshold',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'cpu-throttle-tailslow', 'cpu-periodic-throttle',
> -           'cpu-periodic-throttle-interval',
> +           'cpu-periodic-throttle-interval', 'cpu-responsive-throttle',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>             'avail-switchover-bandwidth', 'downtime-limit',
>             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
> @@ -916,6 +920,10 @@
>  # @cpu-periodic-throttle-interval: Interval of the periodic CPU
> throttling.
>  #     (Since 9.1)
>  #
> +# @cpu-responsive-throttle: Make CPU throttling more responsively by
> +#                           introduce an extra detection metric of
> +#                           migration convergence. (Since 9.1)
> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials
>  #     for establishing a TLS connection over the migration data
>  #     channel.  On the outgoing side of the migration, the credentials
> @@ -1045,6 +1053,7 @@
>              '*cpu-throttle-tailslow': 'bool',
>              '*cpu-periodic-throttle': 'bool',
>              '*cpu-periodic-throttle-interval': 'uint8',
> +            '*cpu-responsive-throttle': 'bool',
>              '*tls-creds': 'StrOrNull',
>              '*tls-hostname': 'StrOrNull',
>              '*tls-authz': 'StrOrNull',
> @@ -1132,6 +1141,10 @@
>  # @cpu-periodic-throttle-interval: Interval of the periodic CPU
> throttling.
>  #     (Since 9.1)
>  #
> +# @cpu-responsive-throttle: Make CPU throttling more responsively by
> +#                           introduce an extra detection metric of
> +#                           migration convergence. (Since 9.1)
> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials
>  #     for establishing a TLS connection over the migration data
>  #     channel.  On the outgoing side of the migration, the credentials
> @@ -1254,6 +1267,7 @@
>              '*cpu-throttle-tailslow': 'bool',
>              '*cpu-periodic-throttle': 'bool',
>              '*cpu-periodic-throttle-interval': 'uint8',
> +            '*cpu-responsive-throttle': 'bool',
>              '*tls-creds': 'str',
>              '*tls-hostname': 'str',
>              '*tls-authz': 'str',
> --
> 2.39.1
>
>

--=20
Best regards

--00000000000003a3420621bd986d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif" class=3D"gmail_default">In order to reduce the maintenance work of QM=
P.<br></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"=
 class=3D"gmail_default"><br></div><div style=3D"font-family:&quot;comic sa=
ns ms&quot;,sans-serif" class=3D"gmail_default">Given that the focus of thi=
s patchset is huge VM migration, is</div><div style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif" class=3D"gmail_default">it possible to enable=
 or disable these two features with a single</div><div style=3D"font-family=
:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">parameter, s=
uch as &quot;cpu-aggressive-throttle&quot;?<br></div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div=
><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"g=
mail_default">Yong</div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 9, 2024 at 10:26=E2=80=AFPM Hyman Huang=
 &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@=
smartx.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">To enable the responsi=
ve throttle that will be implemented<br>
in the next commit, introduce the cpu-responsive-throttle<br>
parameter.<br>
<br>
Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" tar=
get=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
---<br>
=C2=A0migration/migration-hmp-cmds.c |=C2=A0 8 ++++++++<br>
=C2=A0migration/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 20 +++=
+++++++++++++++++<br>
=C2=A0migration/options.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
1 +<br>
=C2=A0qapi/migration.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 16 +++=
++++++++++++-<br>
=C2=A04 files changed, 44 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.=
c<br>
index f7b8e06bb4..a3d4d3f62f 100644<br>
--- a/migration/migration-hmp-cmds.c<br>
+++ b/migration/migration-hmp-cmds.c<br>
@@ -273,6 +273,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const Q=
Dict *qdict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MigrationParameter_str(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIGRATION_PAR=
AMETER_CPU_PERIODIC_THROTTLE_INTERVAL),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0params-&gt;cpu_periodic_thr=
ottle_interval);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(params-&gt;has_cpu_responsive_throttle)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;%s: %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MigrationParameter_str(MIGRATION=
_PARAMETER_CPU_RESPONSIVE_THROTTLE),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params-&gt;cpu_responsive_thrott=
le ? &quot;on&quot; : &quot;off&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(params-&gt;has_max_cpu_throttle);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;%s: %u\n&quot;,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MigrationParameter_str(MIGR=
ATION_PARAMETER_MAX_CPU_THROTTLE),<br>
@@ -529,6 +533,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDi=
ct *qdict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;has_cpu_periodic_throttle_interval =
=3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0visit_type_uint8(v, param, &amp;p-&gt;cpu=
_periodic_throttle_interval, &amp;err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;has_cpu_responsive_throttle =3D true;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 visit_type_bool(v, param, &amp;p-&gt;cpu_respo=
nsive_throttle, &amp;err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;has_max_cpu_throttle =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0visit_type_uint8(v, param, &amp;p-&gt;max=
_cpu_throttle, &amp;err);<br>
diff --git a/migration/options.c b/migration/options.c<br>
index 2dbe275ba0..aa233684ee 100644<br>
--- a/migration/options.c<br>
+++ b/migration/options.c<br>
@@ -110,6 +110,8 @@ Property migration_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT8(&quot;x-cpu-periodic-throttle-interva=
l&quot;, MigrationState,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0parameters.cpu_periodic_throttle_interval,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0DEFAULT_MIGRATE_CPU_PERIODIC_THROTTLE_INTERVAL),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;x-cpu-responsive-throttle&quot;, Migr=
ationState,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 parameters.cpu_responsive_throttle, false),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_SIZE(&quot;x-max-bandwidth&quot;, Migration=
State,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0parameters.max_bandwidth, MAX_THROTTLE),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_SIZE(&quot;avail-switchover-bandwidth&quot;=
, MigrationState,<br>
@@ -715,6 +717,13 @@ bool migrate_periodic_throttle(void)<br>
=C2=A0 =C2=A0 =C2=A0return s-&gt;parameters.cpu_periodic_throttle;<br>
=C2=A0}<br>
<br>
+bool migrate_responsive_throttle(void)<br>
+{<br>
+=C2=A0 =C2=A0 MigrationState *s =3D migrate_get_current();<br>
+<br>
+=C2=A0 =C2=A0 return s-&gt;parameters.cpu_responsive_throttle;<br>
+}<br>
+<br>
=C2=A0bool migrate_cpu_throttle_tailslow(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MigrationState *s =3D migrate_get_current();<br>
@@ -899,6 +908,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;has_cpu_periodic_throttle_interval =3D true;=
<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;cpu_periodic_throttle_interval =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;parameters.cpu_periodic_throttle_in=
terval;<br>
+=C2=A0 =C2=A0 params-&gt;has_cpu_responsive_throttle =3D true;<br>
+=C2=A0 =C2=A0 params-&gt;cpu_responsive_throttle =3D s-&gt;parameters.cpu_=
responsive_throttle;<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;tls_creds =3D g_strdup(s-&gt;parameters.tls_=
creds);<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;tls_hostname =3D g_strdup(s-&gt;parameters.t=
ls_hostname);<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;tls_authz =3D g_strdup(s-&gt;parameters.tls_=
authz ?<br>
@@ -967,6 +978,7 @@ void migrate_params_init(MigrationParameters *params)<b=
r>
=C2=A0 =C2=A0 =C2=A0params-&gt;has_cpu_throttle_tailslow =3D true;<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;has_cpu_periodic_throttle =3D true;<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;has_cpu_periodic_throttle_interval =3D true;=
<br>
+=C2=A0 =C2=A0 params-&gt;has_cpu_responsive_throttle =3D true;<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;has_max_bandwidth =3D true;<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;has_downtime_limit =3D true;<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;has_x_checkpoint_delay =3D true;<br>
@@ -1208,6 +1220,10 @@ static void migrate_params_test_apply(MigrateSetPara=
meters *params,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0params-&gt;cpu_periodic_thr=
ottle_interval;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (params-&gt;has_cpu_responsive_throttle) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dest-&gt;cpu_responsive_throttle =3D params-&g=
t;cpu_responsive_throttle;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (params-&gt;tls_creds) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(params-&gt;tls_creds-&gt;type =3D=
=3D QTYPE_QSTRING);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest-&gt;tls_creds =3D params-&gt;tls_cre=
ds-&gt;u.s;<br>
@@ -1325,6 +1341,10 @@ static void migrate_params_apply(MigrateSetParameter=
s *params, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0params-&gt;cpu_periodic_thr=
ottle_interval;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (params-&gt;has_cpu_responsive_throttle) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;parameters.cpu_responsive_throttle =3D p=
arams-&gt;cpu_responsive_throttle;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (params-&gt;tls_creds) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(s-&gt;parameters.tls_creds);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(params-&gt;tls_creds-&gt;type =3D=
=3D QTYPE_QSTRING);<br>
diff --git a/migration/options.h b/migration/options.h<br>
index efeac01470..613d675003 100644<br>
--- a/migration/options.h<br>
+++ b/migration/options.h<br>
@@ -70,6 +70,7 @@ uint8_t migrate_cpu_throttle_increment(void);<br>
=C2=A0uint8_t migrate_cpu_throttle_initial(void);<br>
=C2=A0uint8_t migrate_periodic_throttle_interval(void);<br>
=C2=A0bool migrate_periodic_throttle(void);<br>
+bool migrate_responsive_throttle(void);<br>
=C2=A0bool migrate_cpu_throttle_tailslow(void);<br>
=C2=A0bool migrate_direct_io(void);<br>
=C2=A0uint64_t migrate_downtime_limit(void);<br>
diff --git a/qapi/migration.json b/qapi/migration.json<br>
index 6d8358c202..9f52ed1899 100644<br>
--- a/qapi/migration.json<br>
+++ b/qapi/migration.json<br>
@@ -734,6 +734,10 @@<br>
=C2=A0# @cpu-periodic-throttle-interval: Interval of the periodic CPU throt=
tling.<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0(Since 9.1)<br>
=C2=A0#<br>
+# @cpu-responsive-throttle: Make CPU throttling more responsively by<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0introduce an extra detection metric of<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0migration convergence. (Since 9.1)<br>
+#<br>
=C2=A0# @tls-creds: ID of the &#39;tls-creds&#39; object that provides cred=
entials<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0for establishing a TLS connection over the migra=
tion data<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0channel.=C2=A0 On the outgoing side of the migra=
tion, the credentials<br>
@@ -855,7 +859,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;throttle-trigger-threshold&#=
39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;cpu-throttle-initial&#39;, &=
#39;cpu-throttle-increment&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;cpu-throttle-tailslow&#39;, =
&#39;cpu-periodic-throttle&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cpu-periodic-throttle-interv=
al&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cpu-periodic-throttle-interv=
al&#39;, &#39;cpu-responsive-throttle&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;tls-creds&#39;, &#39;tls-hos=
tname&#39;, &#39;tls-authz&#39;, &#39;max-bandwidth&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;avail-switchover-bandwidth&#=
39;, &#39;downtime-limit&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { &#39;name&#39;: &#39;x-checkpoi=
nt-delay&#39;, &#39;features&#39;: [ &#39;unstable&#39; ] },<br>
@@ -916,6 +920,10 @@<br>
=C2=A0# @cpu-periodic-throttle-interval: Interval of the periodic CPU throt=
tling.<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0(Since 9.1)<br>
=C2=A0#<br>
+# @cpu-responsive-throttle: Make CPU throttling more responsively by<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0introduce an extra detection metric of<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0migration convergence. (Since 9.1)<br>
+#<br>
=C2=A0# @tls-creds: ID of the &#39;tls-creds&#39; object that provides cred=
entials<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0for establishing a TLS connection over the migra=
tion data<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0channel.=C2=A0 On the outgoing side of the migra=
tion, the credentials<br>
@@ -1045,6 +1053,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*cpu-throttle-tailslow=
&#39;: &#39;bool&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*cpu-periodic-throttle=
&#39;: &#39;bool&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*cpu-periodic-throttle=
-interval&#39;: &#39;uint8&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpu-responsive-throttle&#3=
9;: &#39;bool&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*tls-creds&#39;: &#39;=
StrOrNull&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*tls-hostname&#39;: &#=
39;StrOrNull&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*tls-authz&#39;: &#39;=
StrOrNull&#39;,<br>
@@ -1132,6 +1141,10 @@<br>
=C2=A0# @cpu-periodic-throttle-interval: Interval of the periodic CPU throt=
tling.<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0(Since 9.1)<br>
=C2=A0#<br>
+# @cpu-responsive-throttle: Make CPU throttling more responsively by<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0introduce an extra detection metric of<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0migration convergence. (Since 9.1)<br>
+#<br>
=C2=A0# @tls-creds: ID of the &#39;tls-creds&#39; object that provides cred=
entials<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0for establishing a TLS connection over the migra=
tion data<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0channel.=C2=A0 On the outgoing side of the migra=
tion, the credentials<br>
@@ -1254,6 +1267,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*cpu-throttle-tailslow=
&#39;: &#39;bool&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*cpu-periodic-throttle=
&#39;: &#39;bool&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*cpu-periodic-throttle=
-interval&#39;: &#39;uint8&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpu-responsive-throttle&#3=
9;: &#39;bool&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*tls-creds&#39;: &#39;=
str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*tls-hostname&#39;: &#=
39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*tls-authz&#39;: &#39;=
str&#39;,<br>
-- <br>
2.39.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div>

--00000000000003a3420621bd986d--

