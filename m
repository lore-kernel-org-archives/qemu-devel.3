Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA89FC35FEB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 06:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqS73-0005Q6-5V; Tue, 17 Sep 2024 02:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sqS71-0005In-8W
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 02:54:59 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sqS6y-0002qn-Iq
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 02:54:58 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-277dd761926so2476813fac.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726556095; x=1727160895;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i7A/igZc2ZPI3MTROPzbT1DeR2r1OYfnXc9rjXbvOX0=;
 b=wTGTuGhRk726X77XnZFYQiWlEazwgP5ADpa3H2pG7xQ8VKsIbnX56b5CjKGRfkaInK
 kwl5MJbARMLvU0Y7wiHWFe5GqZ76beiXXazUPMX4KlaWTdoWBjo0k0GzQOxyBFSmeDJr
 q7pUPipgp1sDbB73B/lU4J/kF6g+uvrXIkkZqOaSMax0dP10e/qGqSfhRKvYfRJrWzFv
 +hcm0gkzxLTgo1ynIE6n78sWZ1hQPKMxzFwVnvYIVuZeW8MYf+zMHQ2GbjI4PbvwMjII
 OkUKAv7lBkO6nNW08OPRMvlfy+VbvHtO5dVQIYbwa5/mIi6IrHd+syOEhfH1lqC9bDHJ
 SqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726556095; x=1727160895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i7A/igZc2ZPI3MTROPzbT1DeR2r1OYfnXc9rjXbvOX0=;
 b=Vv2YlSuWfe8w6xhkdQ2XJ0Md4XPba3H9+ULM845wBy1ePY8GpnBcqoONUnNFGFbcJ3
 8kXPWIrVRlM8vs8XuIPXl454r4YPykTCG99pGXxf6J+lZn87qU6uBnVdeQXmkYcWvM6w
 xfjT4YQbI0ZTPHg4nfBVbV1m6SidS1eN1j+3WZXDHTK50VAkYtYVFuAWlLZauGJoIuP1
 uyQqK+ReraXxrKHJ+Ni7t3OWpp3/mnCQSM3ho0YlWH57P6RYOA5QkLXKeAuAs5WoOuLC
 FKPBxXOi84jHawc9QBdQyOzIf/9Jx9WFVSXBvrqUd+L2twIwVnmCW6ib/vDNz9O+idoM
 kdpg==
X-Gm-Message-State: AOJu0YzpoWzkmrnhercZKV0ZaaeEUU1dsqUyM9bJzDej+zIbxMtw42Sd
 4Y7dGBx1noS/1cC7TReQN0401Yg3JkMUEsi/BKPS/qcCck6d0Eg8PMiehOcS2ZAMREdK1/DB+HS
 89XXju5g+I76b6baILVvWwT2wKvVaFaUE46i34w==
X-Google-Smtp-Source: AGHT+IHcLJROpnGi1JM/XNubG4D83LSDnKb4Zpv+NZfulvalWYwrzkK3xF0eOB2r4Li3UDNiUwXcTc4miSGTL0jjXxw=
X-Received: by 2002:a05:6871:9c19:b0:254:bd24:de83 with SMTP id
 586e51a60fabf-27c68929cdamr8481388fac.12.1726556094705; Mon, 16 Sep 2024
 23:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1726390098.git.yong.huang@smartx.com>
 <81d939d716918ed5feea3850cf0644a66d9f1a7b.1726390099.git.yong.huang@smartx.com>
 <87plp3z5c0.fsf@suse.de>
In-Reply-To: <87plp3z5c0.fsf@suse.de>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 17 Sep 2024 14:54:38 +0800
Message-ID: <CAK9dgmaGaq46tDVsbrHENH+9hLPbOjOSiNtGystdiDT0Ja6KgQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] qapi/migration: Introduce cpu-responsive-throttle
 parameter
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b5db8506224b2a1d"
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000b5db8506224b2a1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 4:55=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:

> Hyman Huang <yong.huang@smartx.com> writes:
>
> > To enable the responsive throttle that will be implemented
> > in the next commit, introduce the cpu-responsive-throttle
> > parameter.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  migration/migration-hmp-cmds.c |  8 ++++++++
> >  migration/options.c            | 20 ++++++++++++++++++++
> >  migration/options.h            |  1 +
> >  qapi/migration.json            | 16 +++++++++++++++-
> >  4 files changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/migration-hmp-cmds.c
> b/migration/migration-hmp-cmds.c
> > index 28165cfc9e..1fe6c74d66 100644
> > --- a/migration/migration-hmp-cmds.c
> > +++ b/migration/migration-hmp-cmds.c
> > @@ -264,6 +264,10 @@ void hmp_info_migrate_parameters(Monitor *mon,
> const QDict *qdict)
> >          monitor_printf(mon, "%s: %s\n",
> >
> MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),
> >              params->cpu_throttle_tailslow ? "on" : "off");
> > +        assert(params->has_cpu_responsive_throttle);
> > +        monitor_printf(mon, "%s: %s\n",
> > +
> MigrationParameter_str(MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE),
> > +            params->cpu_responsive_throttle ? "on" : "off");
> >          assert(params->has_max_cpu_throttle);
> >          monitor_printf(mon, "%s: %u\n",
> >
> MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
> > @@ -512,6 +516,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const
> QDict *qdict)
> >          p->has_cpu_throttle_tailslow =3D true;
> >          visit_type_bool(v, param, &p->cpu_throttle_tailslow, &err);
> >          break;
> > +    case MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE:
> > +        p->has_cpu_responsive_throttle =3D true;
> > +        visit_type_bool(v, param, &p->cpu_responsive_throttle, &err);
> > +        break;
> >      case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
> >          p->has_max_cpu_throttle =3D true;
> >          visit_type_uint8(v, param, &p->max_cpu_throttle, &err);
> > diff --git a/migration/options.c b/migration/options.c
> > index 147cd2b8fd..b4c269bf1d 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -111,6 +111,8 @@ Property migration_properties[] =3D {
> >                        DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
> >      DEFINE_PROP_BOOL("x-cpu-throttle-tailslow", MigrationState,
> >                        parameters.cpu_throttle_tailslow, false),
> > +    DEFINE_PROP_BOOL("x-cpu-responsive-throttle", MigrationState,
> > +                      parameters.cpu_responsive_throttle, false),
> >      DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
> >                        parameters.max_bandwidth, MAX_THROTTLE),
> >      DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
> > @@ -705,6 +707,13 @@ uint8_t migrate_cpu_throttle_initial(void)
> >      return s->parameters.cpu_throttle_initial;
> >  }
> >
> > +bool migrate_responsive_throttle(void)
> > +{
> > +    MigrationState *s =3D migrate_get_current();
> > +
> > +    return s->parameters.cpu_responsive_throttle;
> > +}
> > +
> >  bool migrate_cpu_throttle_tailslow(void)
> >  {
> >      MigrationState *s =3D migrate_get_current();
> > @@ -891,6 +900,8 @@ MigrationParameters
> *qmp_query_migrate_parameters(Error **errp)
> >      params->cpu_throttle_increment =3D
> s->parameters.cpu_throttle_increment;
> >      params->has_cpu_throttle_tailslow =3D true;
> >      params->cpu_throttle_tailslow =3D s->parameters.cpu_throttle_tails=
low;
> > +    params->has_cpu_responsive_throttle =3D true;
> > +    params->cpu_responsive_throttle =3D
> s->parameters.cpu_responsive_throttle;
> >      params->tls_creds =3D g_strdup(s->parameters.tls_creds);
> >      params->tls_hostname =3D g_strdup(s->parameters.tls_hostname);
> >      params->tls_authz =3D g_strdup(s->parameters.tls_authz ?
> > @@ -959,6 +970,7 @@ void migrate_params_init(MigrationParameters *param=
s)
> >      params->has_cpu_throttle_initial =3D true;
> >      params->has_cpu_throttle_increment =3D true;
> >      params->has_cpu_throttle_tailslow =3D true;
> > +    params->has_cpu_responsive_throttle =3D true;
> >      params->has_max_bandwidth =3D true;
> >      params->has_downtime_limit =3D true;
> >      params->has_x_checkpoint_delay =3D true;
> > @@ -1191,6 +1203,10 @@ static void
> migrate_params_test_apply(MigrateSetParameters *params,
> >          dest->cpu_throttle_tailslow =3D params->cpu_throttle_tailslow;
> >      }
> >
> > +    if (params->has_cpu_responsive_throttle) {
> > +        dest->cpu_responsive_throttle =3D params->cpu_responsive_throt=
tle;
> > +    }
> > +
> >      if (params->tls_creds) {
> >          assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
> >          dest->tls_creds =3D params->tls_creds->u.s;
> > @@ -1302,6 +1318,10 @@ static void
> migrate_params_apply(MigrateSetParameters *params, Error **errp)
> >          s->parameters.cpu_throttle_tailslow =3D
> params->cpu_throttle_tailslow;
> >      }
> >
> > +    if (params->has_cpu_responsive_throttle) {
> > +        s->parameters.cpu_responsive_throttle =3D
> params->cpu_responsive_throttle;
> > +    }
> > +
> >      if (params->tls_creds) {
> >          g_free(s->parameters.tls_creds);
> >          assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
> > diff --git a/migration/options.h b/migration/options.h
> > index a0bd6edc06..80d0fcdaf9 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -68,6 +68,7 @@ bool migrate_has_block_bitmap_mapping(void);
> >  uint32_t migrate_checkpoint_delay(void);
> >  uint8_t migrate_cpu_throttle_increment(void);
> >  uint8_t migrate_cpu_throttle_initial(void);
> > +bool migrate_responsive_throttle(void);
> >  bool migrate_cpu_throttle_tailslow(void);
> >  bool migrate_direct_io(void);
> >  uint64_t migrate_downtime_limit(void);
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 95b490706c..c61d3b3a6b 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -732,6 +732,10 @@
> >  #     be excessive at tail stage.  The default value is false.  (Since
> >  #     5.1)
> >  #
> > +# @cpu-responsive-throttle: Make CPU throttling more responsively by
> > +#                           introduce an extra detection metric of
> > +#                           migration convergence. (Since 9.1)
> > +#
> >  # @tls-creds: ID of the 'tls-creds' object that provides credentials
> >  #     for establishing a TLS connection over the migration data
> >  #     channel.  On the outgoing side of the migration, the credentials
> > @@ -857,7 +861,7 @@
> >             'announce-rounds', 'announce-step',
> >             'throttle-trigger-threshold',
> >             'cpu-throttle-initial', 'cpu-throttle-increment',
> > -           'cpu-throttle-tailslow',
> > +           'cpu-throttle-tailslow', 'cpu-responsive-throttle',
> >             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> >             'avail-switchover-bandwidth', 'downtime-limit',
> >             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] =
},
> > @@ -913,6 +917,10 @@
> >  #     be excessive at tail stage.  The default value is false.  (Since
> >  #     5.1)
> >  #
> > +# @cpu-responsive-throttle: Make CPU throttling more responsively by
> > +#                           introduce an extra detection metric of
> > +#                           migration convergence. (Since 9.1)
> > +#
> >  # @tls-creds: ID of the 'tls-creds' object that provides credentials
> >  #     for establishing a TLS connection over the migration data
> >  #     channel.  On the outgoing side of the migration, the credentials
> > @@ -1045,6 +1053,7 @@
> >              '*cpu-throttle-initial': 'uint8',
> >              '*cpu-throttle-increment': 'uint8',
> >              '*cpu-throttle-tailslow': 'bool',
> > +            '*cpu-responsive-throttle': 'bool',
>
> Should this instead follow the pattern of cpu-throttle-* ?


Ok




> >              '*tls-creds': 'StrOrNull',
> >              '*tls-hostname': 'StrOrNull',
> >              '*tls-authz': 'StrOrNull',
> > @@ -1127,6 +1136,10 @@
> >  #     be excessive at tail stage.  The default value is false.  (Since
> >  #     5.1)
> >  #
> > +# @cpu-responsive-throttle: Make CPU throttling more responsively by
>
> s/responsively/responsive/ ?
>
> > +#                           introduce an extra detection metric of
> > +#                           migration convergence. (Since 9.1)
>
> Since 9.2. And double space after period.
>
> > +#
> >  # @tls-creds: ID of the 'tls-creds' object that provides credentials
> >  #     for establishing a TLS connection over the migration data
> >  #     channel.  On the outgoing side of the migration, the credentials
> > @@ -1252,6 +1265,7 @@
> >              '*cpu-throttle-initial': 'uint8',
> >              '*cpu-throttle-increment': 'uint8',
> >              '*cpu-throttle-tailslow': 'bool',
> > +            '*cpu-responsive-throttle': 'bool',
> >              '*tls-creds': 'str',
> >              '*tls-hostname': 'str',
> >              '*tls-authz': 'str',
>


--=20
Best regards

--000000000000b5db8506224b2a1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 17, 20=
24 at 4:55=E2=80=AFAM Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de">=
farosas@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">Hyman Huang &lt;<a=
 href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.=
com</a>&gt; writes:<br>
<br>
&gt; To enable the responsive throttle that will be implemented<br>
&gt; in the next commit, introduce the cpu-responsive-throttle<br>
&gt; parameter.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 migration/migration-hmp-cmds.c |=C2=A0 8 ++++++++<br>
&gt;=C2=A0 migration/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2=
0 ++++++++++++++++++++<br>
&gt;=C2=A0 migration/options.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
&gt;=C2=A0 qapi/migration.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1=
6 +++++++++++++++-<br>
&gt;=C2=A0 4 files changed, 44 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-=
cmds.c<br>
&gt; index 28165cfc9e..1fe6c74d66 100644<br>
&gt; --- a/migration/migration-hmp-cmds.c<br>
&gt; +++ b/migration/migration-hmp-cmds.c<br>
&gt; @@ -264,6 +264,10 @@ void hmp_info_migrate_parameters(Monitor *mon, co=
nst QDict *qdict)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;%s: %s\n&q=
uot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MigrationParameter_str=
(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params-&gt;cpu_throttl=
e_tailslow ? &quot;on&quot; : &quot;off&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(params-&gt;has_cpu_responsive_thro=
ttle);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;%s: %s\n&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MigrationParameter_str(MIGR=
ATION_PARAMETER_CPU_RESPONSIVE_THROTTLE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params-&gt;cpu_responsive_t=
hrottle ? &quot;on&quot; : &quot;off&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(params-&gt;has_max_cpu_thrott=
le);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;%s: %u\n&q=
uot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MigrationParameter_str=
(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),<br>
&gt; @@ -512,6 +516,10 @@ void hmp_migrate_set_parameter(Monitor *mon, cons=
t QDict *qdict)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;has_cpu_throttle_tailslow =3D =
true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 visit_type_bool(v, param, &amp;p-&gt=
;cpu_throttle_tailslow, &amp;err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;has_cpu_responsive_throttle =3D tru=
e;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 visit_type_bool(v, param, &amp;p-&gt;cpu_=
responsive_throttle, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;has_max_cpu_throttle =3D true;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 visit_type_uint8(v, param, &amp;p-&g=
t;max_cpu_throttle, &amp;err);<br>
&gt; diff --git a/migration/options.c b/migration/options.c<br>
&gt; index 147cd2b8fd..b4c269bf1d 100644<br>
&gt; --- a/migration/options.c<br>
&gt; +++ b/migration/options.c<br>
&gt; @@ -111,6 +111,8 @@ Property migration_properties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;x-cpu-throttle-tailslow&quo=
t;, MigrationState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 parameters.cpu_throttle_tailslow, false),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;x-cpu-responsive-throttle&quot;,=
 MigrationState,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 parameters.cpu_responsive_throttle, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_SIZE(&quot;x-max-bandwidth&quot;, Migr=
ationState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 parameters.max_bandwidth, MAX_THROTTLE),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_SIZE(&quot;avail-switchover-bandwidth&=
quot;, MigrationState,<br>
&gt; @@ -705,6 +707,13 @@ uint8_t migrate_cpu_throttle_initial(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return s-&gt;parameters.cpu_throttle_initial;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +bool migrate_responsive_throttle(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MigrationState *s =3D migrate_get_current();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return s-&gt;parameters.cpu_responsive_throttle;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 bool migrate_cpu_throttle_tailslow(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MigrationState *s =3D migrate_get_current();<br>
&gt; @@ -891,6 +900,8 @@ MigrationParameters *qmp_query_migrate_parameters(=
Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;cpu_throttle_increment =3D s-&gt;parame=
ters.cpu_throttle_increment;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;has_cpu_throttle_tailslow =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;cpu_throttle_tailslow =3D s-&gt;paramet=
ers.cpu_throttle_tailslow;<br>
&gt; +=C2=A0 =C2=A0 params-&gt;has_cpu_responsive_throttle =3D true;<br>
&gt; +=C2=A0 =C2=A0 params-&gt;cpu_responsive_throttle =3D s-&gt;parameters=
.cpu_responsive_throttle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;tls_creds =3D g_strdup(s-&gt;parameters=
.tls_creds);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;tls_hostname =3D g_strdup(s-&gt;paramet=
ers.tls_hostname);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;tls_authz =3D g_strdup(s-&gt;parameters=
.tls_authz ?<br>
&gt; @@ -959,6 +970,7 @@ void migrate_params_init(MigrationParameters *para=
ms)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;has_cpu_throttle_initial =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;has_cpu_throttle_increment =3D true;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;has_cpu_throttle_tailslow =3D true;<br>
&gt; +=C2=A0 =C2=A0 params-&gt;has_cpu_responsive_throttle =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;has_max_bandwidth =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;has_downtime_limit =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 params-&gt;has_x_checkpoint_delay =3D true;<br>
&gt; @@ -1191,6 +1203,10 @@ static void migrate_params_test_apply(MigrateSe=
tParameters *params,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dest-&gt;cpu_throttle_tailslow =3D p=
arams-&gt;cpu_throttle_tailslow;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (params-&gt;has_cpu_responsive_throttle) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dest-&gt;cpu_responsive_throttle =3D para=
ms-&gt;cpu_responsive_throttle;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (params-&gt;tls_creds) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(params-&gt;tls_creds-&gt;type=
 =3D=3D QTYPE_QSTRING);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dest-&gt;tls_creds =3D params-&gt;tl=
s_creds-&gt;u.s;<br>
&gt; @@ -1302,6 +1318,10 @@ static void migrate_params_apply(MigrateSetPara=
meters *params, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;parameters.cpu_throttle_tailsl=
ow =3D params-&gt;cpu_throttle_tailslow;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (params-&gt;has_cpu_responsive_throttle) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;parameters.cpu_responsive_throttle =
=3D params-&gt;cpu_responsive_throttle;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (params-&gt;tls_creds) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(s-&gt;parameters.tls_creds);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(params-&gt;tls_creds-&gt;type=
 =3D=3D QTYPE_QSTRING);<br>
&gt; diff --git a/migration/options.h b/migration/options.h<br>
&gt; index a0bd6edc06..80d0fcdaf9 100644<br>
&gt; --- a/migration/options.h<br>
&gt; +++ b/migration/options.h<br>
&gt; @@ -68,6 +68,7 @@ bool migrate_has_block_bitmap_mapping(void);<br>
&gt;=C2=A0 uint32_t migrate_checkpoint_delay(void);<br>
&gt;=C2=A0 uint8_t migrate_cpu_throttle_increment(void);<br>
&gt;=C2=A0 uint8_t migrate_cpu_throttle_initial(void);<br>
&gt; +bool migrate_responsive_throttle(void);<br>
&gt;=C2=A0 bool migrate_cpu_throttle_tailslow(void);<br>
&gt;=C2=A0 bool migrate_direct_io(void);<br>
&gt;=C2=A0 uint64_t migrate_downtime_limit(void);<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index 95b490706c..c61d3b3a6b 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
&gt; @@ -732,6 +732,10 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0be excessive at tail stage.=C2=A0 The defau=
lt value is false.=C2=A0 (Since<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A05.1)<br>
&gt;=C2=A0 #<br>
&gt; +# @cpu-responsive-throttle: Make CPU throttling more responsively by<=
br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0introduce an extra detection metric of<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0migration convergence. (Since 9.1)<br>
&gt; +#<br>
&gt;=C2=A0 # @tls-creds: ID of the &#39;tls-creds&#39; object that provides=
 credentials<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0for establishing a TLS connection over the =
migration data<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0channel.=C2=A0 On the outgoing side of the =
migration, the credentials<br>
&gt; @@ -857,7 +861,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;announce-rounds&#3=
9;, &#39;announce-step&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;throttle-trigger-t=
hreshold&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cpu-throttle-initi=
al&#39;, &#39;cpu-throttle-increment&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cpu-throttle-tailslow&#=
39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cpu-throttle-tailslow&#=
39;, &#39;cpu-responsive-throttle&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;tls-creds&#39;, &#=
39;tls-hostname&#39;, &#39;tls-authz&#39;, &#39;max-bandwidth&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;avail-switchover-b=
andwidth&#39;, &#39;downtime-limit&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &#39;name&#39;: &#39;=
x-checkpoint-delay&#39;, &#39;features&#39;: [ &#39;unstable&#39; ] },<br>
&gt; @@ -913,6 +917,10 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0be excessive at tail stage.=C2=A0 The defau=
lt value is false.=C2=A0 (Since<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A05.1)<br>
&gt;=C2=A0 #<br>
&gt; +# @cpu-responsive-throttle: Make CPU throttling more responsively by<=
br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0introduce an extra detection metric of<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0migration convergence. (Since 9.1)<br>
&gt; +#<br>
&gt;=C2=A0 # @tls-creds: ID of the &#39;tls-creds&#39; object that provides=
 credentials<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0for establishing a TLS connection over the =
migration data<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0channel.=C2=A0 On the outgoing side of the =
migration, the credentials<br>
&gt; @@ -1045,6 +1053,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpu-throttle-ini=
tial&#39;: &#39;uint8&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpu-throttle-inc=
rement&#39;: &#39;uint8&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpu-throttle-tai=
lslow&#39;: &#39;bool&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpu-responsive-thrott=
le&#39;: &#39;bool&#39;,<br>
<br>
Should this instead follow the pattern of cpu-throttle-* ?</blockquote><div=
><br></div><div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif" class=3D"gmail_default">Ok</div></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color=
:rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*tls-creds&#39;: =
&#39;StrOrNull&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*tls-hostname&#39=
;: &#39;StrOrNull&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*tls-authz&#39;: =
&#39;StrOrNull&#39;,<br>
&gt; @@ -1127,6 +1136,10 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0be excessive at tail stage.=C2=A0 The defau=
lt value is false.=C2=A0 (Since<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A05.1)<br>
&gt;=C2=A0 #<br>
&gt; +# @cpu-responsive-throttle: Make CPU throttling more responsively by<=
br>
<br>
s/responsively/responsive/ ?<br>
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0introduce an extra detection metric of<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0migration convergence. (Since 9.1)<br>
<br>
Since 9.2. And double space after period.<br>
<br>
&gt; +#<br>
&gt;=C2=A0 # @tls-creds: ID of the &#39;tls-creds&#39; object that provides=
 credentials<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0for establishing a TLS connection over the =
migration data<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0channel.=C2=A0 On the outgoing side of the =
migration, the credentials<br>
&gt; @@ -1252,6 +1265,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpu-throttle-ini=
tial&#39;: &#39;uint8&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpu-throttle-inc=
rement&#39;: &#39;uint8&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpu-throttle-tai=
lslow&#39;: &#39;bool&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpu-responsive-thrott=
le&#39;: &#39;bool&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*tls-creds&#39;: =
&#39;str&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*tls-hostname&#39=
;: &#39;str&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*tls-authz&#39;: =
&#39;str&#39;,<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000b5db8506224b2a1d--

