Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3EFC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 11:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLln-00029Y-Mr; Mon, 28 Jul 2025 07:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugLC6-00068u-Fo
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugLC3-00053b-NB
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753698894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rgyLYpz65d0ZmPO1l0wtpPAY8KcBd4DpbKu7X7hh5UI=;
 b=Zqbf0P6UV3xoVUvXvbI+PIPASTHdi0DEL6U1sQ8xagp4u4WdeBNL4PC8cw6+rUf6Pepv9S
 oydup6lHetdD3sZ5yqZqqJC26hdxiMZJh5IC49UHv66UeJWSZXf/Uj8FBRdQDHOi1YZo8M
 cLBLaurqfDv7bHif1AX66rgQ3IfzcM8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-GiD1DlfTP2aE8Jbu2n5IjQ-1; Mon, 28 Jul 2025 06:34:53 -0400
X-MC-Unique: GiD1DlfTP2aE8Jbu2n5IjQ-1
X-Mimecast-MFC-AGG-ID: GiD1DlfTP2aE8Jbu2n5IjQ_1753698892
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3138e65efe2so4000034a91.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753698892; x=1754303692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rgyLYpz65d0ZmPO1l0wtpPAY8KcBd4DpbKu7X7hh5UI=;
 b=T9ASgDZhVFGxjLOeErKWhY8N2UilPA4pYn5pVPjGZavEoZpLL7vGrouWR595YqVhkW
 DA0aKHhQ5EKlb7MIOVHeRV0fSemKOTwfByGrMtZoMgqWymBTf0FnPqtERGKRhTOAsQGz
 NB5LM3j57SzbGcX1V1C1sV3ZMzcXxLsLVSmsvx78FxuO1CpbcS5E4iuYS4WBegNyCI+Y
 y+ReFBLSUGSQ79uETQjZy5NROU2d1Ky1dlj6+at8TPj0yCFKZdoYWVSWupT2gm8wrc5c
 j1fAVe76LrR9/ZYe1ribzjsxVb3DlTJiyINRES0kS5SwrxQc1ndwXmVGcdn7ozLOhx/r
 5yrg==
X-Gm-Message-State: AOJu0Yydsufth65UZXHJM65OujzLLeL3bugMu2F/7AyhPmmxO3Hm9+kT
 s8JVjTBBGjw+1kBSet3kcr+3Jeykw3NpTNuHRl3PGjemwRaaS05eNcD4cH/GXqclH2m1TSY8cxG
 j1tjmV7SGzF25/LIEFewCEWdjfSO1JMYU70tX+bSNwfqA9ZWX4xI/+/hGxddr/5BFt0ofGum38J
 YxGETuTeK78KT0P4LnJNyanjZfyhVk7LM=
X-Gm-Gg: ASbGnctWZ/8gSQMiV9bs7ax2oLNmwH8HqhxXYrkDZqJTG43g+mFsKetRnzFk7UQcb7+
 6IhDJk4z9xAaYy/9yp/01gSimTG0RRKTr5BArWZLFzBCavCUwvRUpJR19r5s2s+IUjj6UQ3K1QB
 K0Flyvz8t3w9qBVJprAbyTcYVb6NwKxiyacm+DdkCZTGhQmgnVPWaBdA==
X-Received: by 2002:a17:90b:538c:b0:31f:134:94ae with SMTP id
 98e67ed59e1d1-31f013495ccmr2681676a91.11.1753698891811; 
 Mon, 28 Jul 2025 03:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGh2wfTW2s/HQDJmPBgy6db/vIIh+B7h09LSyDL/QFYbXeQeLqQiXWTSlNWa0hBEXCu049c0rStWMumjiUwfc=
X-Received: by 2002:a17:90b:538c:b0:31f:134:94ae with SMTP id
 98e67ed59e1d1-31f013495ccmr2681649a91.11.1753698891311; Mon, 28 Jul 2025
 03:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-22-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-22-d52704443975@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 28 Jul 2025 14:34:38 +0400
X-Gm-Features: Ac12FXzN4iDbuwcBa0TxDHHPykOEf7L7Vf2spJDYGK7zpcpQOOJbJ0oXMykWPDY
Message-ID: <CAMxuvazqk=UdEUYsFPcOdp-oOqPhO-kZoa0LuzY-Repyp5zOnA@mail.gmail.com>
Subject: Re: [PATCH v7 22/24] migration: Capture error in
 postcopy_ram_listen_thread()
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000075cb09063afad77f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000075cb09063afad77f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:22=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
> to load the vm, and in case of a failure, it should set the error
> in the migration object.
>
> When postcopy live migration runs, the device states are loaded by
> both the qemu coroutine process_incoming_migration_co() and the
> postcopy_ram_listen_thread(). Therefore, it is important that the
> coroutine also reports the error in case of failure, with
> error_report_err(). Otherwise, the source qemu will not display
> any errors before going into the postcopy pause state.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/migration.c |  2 +-
>  migration/savevm.c    | 10 ++++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index
> 0a5a8d5948b2b0a3f85163795e84f71903870d25..4a76d7ed730589bae87115368b0bf48=
19f8b161e
> 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -925,7 +925,7 @@ fail:
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_FAILED);
>      migrate_set_error(s, local_err);
> -    error_free(local_err);
> +    error_report_err(local_err);
>
>      migration_incoming_state_destroy();
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> 810bba9799246c8d57514be0927bb474edee8e9b..202bb9f494c9185434a50967c439ce8=
4e0b3acee
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      QEMUFile *f =3D mis->from_src_file;
>      int load_res;
>      MigrationState *migr =3D migrate_get_current();
> +    Error *local_err =3D NULL;
>
>      object_ref(OBJECT(migr));
>
> @@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      qemu_file_set_blocking(f, true);
>
>      /* TODO: sanity check that only postcopiable data will be loaded her=
e
> */
> -    load_res =3D qemu_loadvm_state_main(f, mis, NULL);
> +    load_res =3D qemu_loadvm_state_main(f, mis, &local_err);
>
>      /*
>       * This is tricky, but, mis->from_src_file can change after it
> @@ -2137,7 +2138,12 @@ static void *postcopy_ram_listen_thread(void
> *opaque)
>                           __func__, load_res);
>              load_res =3D 0; /* prevent further exit() */
>          } else {
> -            error_report("%s: loadvm failed: %d", __func__, load_res);
> +            if (local_err !=3D NULL) {
> +                error_prepend(&local_err,
> +                              "loadvm failed during postcopy: %d: ",
> load_res);
> +                migrate_set_error(migr, local_err);
> +                error_report_err(local_err);
> +            }
>              migrate_set_state(&mis->state,
> MIGRATION_STATUS_POSTCOPY_ACTIVE,
>                                             MIGRATION_STATUS_FAILED);
>          }
>
> --
> 2.50.0
>
>

--00000000000075cb09063afad77f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25,=
 2025 at 4:22=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.co=
m">armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">This is an incremental step in converting vmstate load=
ing<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
postcopy_ram_listen_thread() calls qemu_loadvm_state_main()<br>
to load the vm, and in case of a failure, it should set the error<br>
in the migration object.<br>
<br>
When postcopy live migration runs, the device states are loaded by<br>
both the qemu coroutine process_incoming_migration_co() and the<br>
postcopy_ram_listen_thread(). Therefore, it is important that the<br>
coroutine also reports the error in case of failure, with<br>
error_report_err(). Otherwise, the source qemu will not display<br>
any errors before going into the postcopy pause state.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0migration/migration.c |=C2=A0 2 +-<br>
=C2=A0migration/savevm.c=C2=A0 =C2=A0 | 10 ++++++++--<br>
=C2=A02 files changed, 9 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index 0a5a8d5948b2b0a3f85163795e84f71903870d25..4a76d7ed730589bae87115368b0=
bf4819f8b161e 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -925,7 +925,7 @@ fail:<br>
=C2=A0 =C2=A0 =C2=A0migrate_set_state(&amp;mis-&gt;state, MIGRATION_STATUS_=
ACTIVE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MIGRATION_STATUS_FAILED);<br>
=C2=A0 =C2=A0 =C2=A0migrate_set_error(s, local_err);<br>
-=C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 error_report_err(local_err);<br>
<br>
=C2=A0 =C2=A0 =C2=A0migration_incoming_state_destroy();<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index 810bba9799246c8d57514be0927bb474edee8e9b..202bb9f494c9185434a50967c43=
9ce84e0b3acee 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)=
<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *f =3D mis-&gt;from_src_file;<br>
=C2=A0 =C2=A0 =C2=A0int load_res;<br>
=C2=A0 =C2=A0 =C2=A0MigrationState *migr =3D migrate_get_current();<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0object_ref(OBJECT(migr));<br>
<br>
@@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaque)=
<br>
=C2=A0 =C2=A0 =C2=A0qemu_file_set_blocking(f, true);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* TODO: sanity check that only postcopiable data will =
be loaded here */<br>
-=C2=A0 =C2=A0 load_res =3D qemu_loadvm_state_main(f, mis, NULL);<br>
+=C2=A0 =C2=A0 load_res =3D qemu_loadvm_state_main(f, mis, &amp;local_err);=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * This is tricky, but, mis-&gt;from_src_file can chang=
e after it<br>
@@ -2137,7 +2138,12 @@ static void *postcopy_ram_listen_thread(void *opaque=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __func__, load_res);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load_res =3D 0; /* prevent =
further exit() */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: loadvm fa=
iled: %d&quot;, __func__, load_res);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(&amp=
;local_err,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;loadvm failed during postcopy: %d: &q=
uot;, load_res);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_set_error(=
migr, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(l=
ocal_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0migrate_set_state(&amp;mis-=
&gt;state, MIGRATION_STATUS_POSTCOPY_ACTIVE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 MIGRATION_STATUS_FAILED);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>

--00000000000075cb09063afad77f--


