Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EC4C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufItO-00014Z-MA; Fri, 25 Jul 2025 09:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ufIpa-0000tO-Sg
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ufIpY-0005kE-6s
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753451483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ueieLiV1CXveVeB/MLUaICSjIjI4DgoYTN/JLntUNS0=;
 b=ClI81xhL1SMxnflwauvcJmhm9Uyb6pehD4grI6m8tWlIKF8aLl10jlTlEfs+CP5KY47XNj
 gCJtGWIP2JV1LLm6e9Jnx0ICHo6Inv4+QAYnh3otYPNgLlW9ndTxFta5d6ehAFOTekAWlm
 YyVSAEieGO/IdZaPVyPHkmZq6wgPCBg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-sxeuh2bzMBa2aKHkmIy9VA-1; Fri, 25 Jul 2025 09:51:19 -0400
X-MC-Unique: sxeuh2bzMBa2aKHkmIy9VA-1
X-Mimecast-MFC-AGG-ID: sxeuh2bzMBa2aKHkmIy9VA_1753451479
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2356ce66d7cso34233435ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 06:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753451478; x=1754056278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ueieLiV1CXveVeB/MLUaICSjIjI4DgoYTN/JLntUNS0=;
 b=hoIZCtl52YgH7HjKkpzE5ESFDVJtWM8RmdQRXUPxl/tnPhiA7Ea+jdpltBj5IWW9Ta
 Lq3V/9IxJ+LpOWlU2LnHL3O6O9kKqb7CehQqUcaFuN9JSaEP3E1PE3mTQNwpXxN9iDiB
 9FQUSEd3eXPDkeUV6xYZCRxtY9YvJkylT8WekspcmygleHMh0yiXJqkgvMHvdeaeCeAj
 CcFS61nU8WRJ+Sv3ylXY9EOiiRreqevwf9J12QV7wGHQnGuan/TYRaUJAYEyPhJRLR9b
 DEIJE384noyVc0kXlzx22PXNhAT1wLbsENp9yt17C0HJ487zOTaCszv2gVTI487JIvZq
 us2Q==
X-Gm-Message-State: AOJu0YyNWrJcRtFupGYFoRkjL6J9Vq+XOgvW4Qna4ek+INknkU7ui1vP
 1yTsLkGvlhKyRdxtSU8Ub0SlR7cWGpQHoCW+iHqx3VFcv2XVcfXB2EuqLzpPhX/C4gowq+qG1hk
 otS3e1aLjzVx4fSZLAIW3UenoWAR31NwH2ultpiggcwFnjDFaVbnpASIZw0r5/wcpobubZAvD+y
 sLsM8GyH53miYoR6mCFO0teMM3PTUSlgg=
X-Gm-Gg: ASbGncsFNiYlBNZilxWK1kimG+bz0yqcnoybhLRKruYs47rIg8bCzcVWl7HfpcWN8a8
 6jJSqBjB3RZnY8KGpu+IArkEV1zqyx5tYur8BMzaRDI/d+DF12CD6Q4QJk3bs02Cg+e7vm+0p9+
 K+W55okrF5Vr+i/4mAmZuCwUncB9XtWC8zoaIMDCRCfD+vrZnuFiyVEA==
X-Received: by 2002:a17:903:32d1:b0:234:b44c:d3c8 with SMTP id
 d9443c01a7336-23fb31b3056mr26517825ad.37.1753451478620; 
 Fri, 25 Jul 2025 06:51:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJdZbEqYdfz6HgVgAueSYXdy/+NhAHlUNyosxO7T6hd2MW0UKRUJuv7yqGswJg/4kNdUB7aptSZ0FmkKIyebM=
X-Received: by 2002:a17:903:32d1:b0:234:b44c:d3c8 with SMTP id
 d9443c01a7336-23fb31b3056mr26517515ad.37.1753451478203; Fri, 25 Jul 2025
 06:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-3-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-3-d52704443975@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 25 Jul 2025 17:51:06 +0400
X-Gm-Features: Ac12FXx1on4sHfzfC89_264kmBCJjZW5buWuJ-_scZPOGKqRR2h0weW91pa1moI
Message-ID: <CAMxuvaz3GhwFqBSA6VsKNAOhxiS-XcCcbkTjVX4upJiN1bmucA@mail.gmail.com>
Subject: Re: [PATCH v7 03/24] migration: push Error **errp into
 qemu_loadvm_state_header()
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
Content-Type: multipart/alternative; boundary="0000000000007d52f3063ac13cf1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000007d52f3063ac13cf1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:19=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_state_header() must report an error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/savevm.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> ab947620f724874f325fb9fb59bef50b7c16fb51..842ff3dc6d5ccb05f7d33cef9f7319b=
141419501
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2814,35 +2814,44 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t
> type)
>      return 0;
>  }
>
> -static int qemu_loadvm_state_header(QEMUFile *f)
> +static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
>  {
>      unsigned int v;
>      int ret;
>
>      v =3D qemu_get_be32(f);
>      if (v !=3D QEMU_VM_FILE_MAGIC) {
> -        error_report("Not a migration stream");
> +        error_setg(errp, "Not a migration stream, magic: %x !=3D %x",
> +                   v, QEMU_VM_FILE_MAGIC);
>          return -EINVAL;
>      }
>
>      v =3D qemu_get_be32(f);
>      if (v =3D=3D QEMU_VM_FILE_VERSION_COMPAT) {
> -        error_report("SaveVM v2 format is obsolete and don't work
> anymore");
> +        error_setg(errp,
> +                   "SaveVM v2 format is obsolete and no longer supported=
,
> "
> +                   "file version %x !=3D %x",
> +                   v, QEMU_VM_FILE_VERSION_COMPAT);
> +
>          return -ENOTSUP;
>      }
>      if (v !=3D QEMU_VM_FILE_VERSION) {
> -        error_report("Unsupported migration stream version");
> +        error_setg(errp, "Unsupported migration stream version, "
> +                   "file version %x !=3D %x",
> +                   v, QEMU_VM_FILE_VERSION);
>          return -ENOTSUP;
>      }
>
>      if (migrate_get_current()->send_configuration) {
> -        if (qemu_get_byte(f) !=3D QEMU_VM_CONFIGURATION) {
> -            error_report("Configuration section missing");
> +        v =3D qemu_get_byte(f);
> +        if (v !=3D QEMU_VM_CONFIGURATION) {
> +            error_setg(errp, "Configuration section missing, %x !=3D %x"=
,
> +                       v, QEMU_VM_CONFIGURATION);
>              return -EINVAL;
>          }
> -        ret =3D vmstate_load_state(f, &vmstate_configuration,
> &savevm_state, 0,
> -                                 NULL);
>
> +        ret =3D vmstate_load_state(f, &vmstate_configuration,
> &savevm_state, 0,
> +                                 errp);
>          if (ret) {
>              return ret;
>          }
> @@ -3119,7 +3128,7 @@ int qemu_loadvm_state(QEMUFile *f)
>
>      qemu_loadvm_thread_pool_create(mis);
>
> -    ret =3D qemu_loadvm_state_header(f);
> +    ret =3D qemu_loadvm_state_header(f, NULL);
>      if (ret) {
>          return ret;
>      }
>
> --
> 2.50.0
>
>

--0000000000007d52f3063ac13cf1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25,=
 2025 at 4:19=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.co=
m">armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">This is an incremental step in converting vmstate load=
ing<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that qemu_loadvm_state_header() must report an error<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0migration/savevm.c | 27 ++++++++++++++++++---------<br>
=C2=A01 file changed, 18 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index ab947620f724874f325fb9fb59bef50b7c16fb51..842ff3dc6d5ccb05f7d33cef9f7=
319b141419501 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2814,35 +2814,44 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t t=
ype)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int qemu_loadvm_state_header(QEMUFile *f)<br>
+static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0unsigned int v;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0v =3D qemu_get_be32(f);<br>
=C2=A0 =C2=A0 =C2=A0if (v !=3D QEMU_VM_FILE_MAGIC) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Not a migration stream&quot=
;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Not a migration stream,=
 magic: %x !=3D %x&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v, QE=
MU_VM_FILE_MAGIC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0v =3D qemu_get_be32(f);<br>
=C2=A0 =C2=A0 =C2=A0if (v =3D=3D QEMU_VM_FILE_VERSION_COMPAT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;SaveVM v2 format is obsolet=
e and don&#39;t work anymore&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;SaveVM v2 format is obsolete and no longer supported, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;file version %x !=3D %x&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v, QE=
MU_VM_FILE_VERSION_COMPAT);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUP;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (v !=3D QEMU_VM_FILE_VERSION) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Unsupported migration strea=
m version&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Unsupported migration s=
tream version, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;file version %x !=3D %x&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v, QE=
MU_VM_FILE_VERSION);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUP;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (migrate_get_current()-&gt;send_configuration) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_get_byte(f) !=3D QEMU_VM_CONFIGURATIO=
N) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Configuration=
 section missing&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D qemu_get_byte(f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v !=3D QEMU_VM_CONFIGURATION) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Configura=
tion section missing, %x !=3D %x&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0v, QEMU_VM_CONFIGURATION);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_con=
figuration, &amp;savevm_state, 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_con=
figuration, &amp;savevm_state, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -3119,7 +3128,7 @@ int qemu_loadvm_state(QEMUFile *f)<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_loadvm_thread_pool_create(mis);<br>
<br>
-=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_header(f);<br>
+=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_header(f, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>

--0000000000007d52f3063ac13cf1--


