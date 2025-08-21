Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673F0CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 16:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up8FL-0004Yn-7A; Thu, 21 Aug 2025 12:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1up8FJ-0004YV-2j
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 12:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1up8FG-0004Li-0v
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 12:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755794069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1qMTKi1BEICBy23HpsTjNz5ae+MM589RI9/Omcyjq5U=;
 b=StsXRCsLOI4doaNFASSFuS42fui80iTSNYG0kiaDSuu7lCyTU7MmT0TunRA4jnASMqaE1B
 bv10aO3e7djbe8Mq0vjm+ogmVdGcEwbNzp/WXsCOIpMCSHZgWVRaPJO2fI3hYIeoQ0NaSW
 Pw9weRpcFX7LL30D7S7ZT+J0p48DtPs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-yjPtxCq5MKqthuwYLtlAbw-1; Thu, 21 Aug 2025 12:34:27 -0400
X-MC-Unique: yjPtxCq5MKqthuwYLtlAbw-1
X-Mimecast-MFC-AGG-ID: yjPtxCq5MKqthuwYLtlAbw_1755794067
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-244581ce388so26783275ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 09:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755794067; x=1756398867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1qMTKi1BEICBy23HpsTjNz5ae+MM589RI9/Omcyjq5U=;
 b=skyYMSGd9RLQfBe7Ukt9/Kw+N8zM+K6RSmNDWV8HEEK2MBSK6y2zgZ/gv5nU4MIVXw
 Yo+lebD+H2FxLqotvT/a5jZwAQDPKmdKD5vCU62o68KL7QxqXVkLyJoaKGbCD3On+at2
 ZmZ34Xb2KFs3/n1XgPqbTa9lgYANQGSwReYfKML0+M1QeH/XdWEwsKvNM8ULW9yYen2H
 uZ2Hxdu5cu+0iY4sUX0hTEaLPtawT4eh937Wp3ShRLn0jiEBy1Jto6LoSkfVtUxcG+MQ
 0kYTrztXok4fIjFOwMeoXk+CoDHflz0RcEessG29INY4Nqs00Jvo4IXjCbCT/U7RVqni
 jS3w==
X-Gm-Message-State: AOJu0YziWEBm9UVynv4kT6eQD/077RBBjeusO/RcVAn1Lgi6+4zMyUD6
 HMcHaZWiZPGtuioKPaPcgOpiD+uKScAZuxpHpVEfWkfEJsfLisQUrYBnqObhEgiAA2ALYFpz9Zd
 9tlxrknPsjPnjMzAKqcZIvRkV+YAznLn+x4K90Sf8sYY+NBPhcTLIRJ1aLmN8WHYhgY7oK7mEZm
 T+exPQ+3Qw2I3zn0gvC+Iy3ANTfP8wvTU=
X-Gm-Gg: ASbGnctw4uyA64+i/Ou4Cxk+5YmkJYQxNetwIMR2+nWmIMR4PfRR8/Jzn8xIKOFwIRa
 3r+ZAnDNMyhS7PTowYDnlJCBzSAD/iuw5WyKbvIDGHL1dvkX5xFT220ZDm+4iPc6lMXaN6caKqt
 TIfDY5XA6hLYS1cVHp3LXMvQ==
X-Received: by 2002:a17:902:db0c:b0:240:a430:91d with SMTP id
 d9443c01a7336-2462edee7b2mr298265ad.10.1755794066676; 
 Thu, 21 Aug 2025 09:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE85k4Sakqw6T0Ykwgf7iqCLEd+4dxVOJePCNy1559tN/gnw5kFA1EXsxGV+tsU8VKrmO3tP8UT9+f08po0NoY=
X-Received: by 2002:a17:902:db0c:b0:240:a430:91d with SMTP id
 d9443c01a7336-2462edee7b2mr297815ad.10.1755794066218; Thu, 21 Aug 2025
 09:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250821145130.845104-1-thuth@redhat.com>
In-Reply-To: <20250821145130.845104-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Aug 2025 20:34:14 +0400
X-Gm-Features: Ac12FXxd77BzHRDtU79CyCIQOSoGZsKVlfy1cLXKy98M4-njdNeVuAJAa3dNYxs
Message-ID: <CAMxuvaxvMPqsN3iRQ-NDGtAQoZRD=LSFXjiJL7VTZuwyr-m_7g@mail.gmail.com>
Subject: Re: [PATCH] ui/vnc: Fix crash when specifying [vnc] without id in the
 config file
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009dbb0f063ce2a952"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000009dbb0f063ce2a952
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Aug 21, 2025 at 6:51=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> From: Thomas Huth <thuth@redhat.com>
>
> QEMU currently crashes when there is a [vnc] section in the config
> file that does not have an "id =3D ..." line:
>
>  $ echo "[vnc]" > /tmp/qemu.conf
>  $ ./qemu-system-x86_64 -readconfig /tmp/qemu.conf
>  qemu-system-x86_64: ../../devel/qemu/ui/vnc.c:4347: vnc_init_func:
>   Assertion `id' failed.
>  Aborted (core dumped)
>
> The required "id" is only set up automatically while parsing the command
> line, but not when reading the options from the config file.
> Thus let's move code that automatically adds the id (if it does not
> exist yet) to the init function that needs the id for the first time,
> replacing the assert() statement there.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2836
> Signed-off-by: Thomas Huth <thuth@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/vnc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 68ca4a68e7a..9054fc81253 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -4309,8 +4309,9 @@ void vnc_display_add_client(const char *id, int
> csock, bool skipauth)
>      }
>  }
>
> -static void vnc_auto_assign_id(QemuOptsList *olist, QemuOpts *opts)
> +static char *vnc_auto_assign_id(QemuOpts *opts)
>  {
> +    QemuOptsList *olist =3D qemu_find_opts("vnc");
>      int i =3D 2;
>      char *id;
>
> @@ -4320,23 +4321,18 @@ static void vnc_auto_assign_id(QemuOptsList
> *olist, QemuOpts *opts)
>          id =3D g_strdup_printf("vnc%d", i++);
>      }
>      qemu_opts_set_id(opts, id);
> +
> +    return id;
>  }
>
>  void vnc_parse(const char *str)
>  {
>      QemuOptsList *olist =3D qemu_find_opts("vnc");
>      QemuOpts *opts =3D qemu_opts_parse_noisily(olist, str,
> !is_help_option(str));
> -    const char *id;
>
>      if (!opts) {
>          exit(1);
>      }
> -
> -    id =3D qemu_opts_id(opts);
> -    if (!id) {
> -        /* auto-assign id if not present */
> -        vnc_auto_assign_id(olist, opts);
> -    }
>  }
>
>  int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
> @@ -4344,7 +4340,11 @@ int vnc_init_func(void *opaque, QemuOpts *opts,
> Error **errp)
>      Error *local_err =3D NULL;
>      char *id =3D (char *)qemu_opts_id(opts);
>
> -    assert(id);
> +    if (!id) {
> +        /* auto-assign id if not present */
> +        id =3D vnc_auto_assign_id(opts);
> +    }
> +
>      vnc_display_init(id, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> --
> 2.50.1
>
>

--0000000000009dbb0f063ce2a952
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 21, 2025 at 6:51=
=E2=80=AFPM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">From: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_b=
lank">thuth@redhat.com</a>&gt;<br>
<br>
QEMU currently crashes when there is a [vnc] section in the config<br>
file that does not have an &quot;id =3D ...&quot; line:<br>
<br>
=C2=A0$ echo &quot;[vnc]&quot; &gt; /tmp/qemu.conf<br>
=C2=A0$ ./qemu-system-x86_64 -readconfig /tmp/qemu.conf<br>
=C2=A0qemu-system-x86_64: ../../devel/qemu/ui/vnc.c:4347: vnc_init_func:<br=
>
=C2=A0 Assertion `id&#39; failed.<br>
=C2=A0Aborted (core dumped)<br>
<br>
The required &quot;id&quot; is only set up automatically while parsing the =
command<br>
line, but not when reading the options from the config file.<br>
Thus let&#39;s move code that automatically adds the id (if it does not<br>
exist yet) to the init function that needs the id for the first time,<br>
replacing the assert() statement there.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2836" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2836</a><br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br></blockquote><div><br></div><div>Re=
viewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/vnc.c | 18 +++++++++---------<br>
=C2=A01 file changed, 9 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/ui/vnc.c b/ui/vnc.c<br>
index 68ca4a68e7a..9054fc81253 100644<br>
--- a/ui/vnc.c<br>
+++ b/ui/vnc.c<br>
@@ -4309,8 +4309,9 @@ void vnc_display_add_client(const char *id, int csock=
, bool skipauth)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void vnc_auto_assign_id(QemuOptsList *olist, QemuOpts *opts)<br>
+static char *vnc_auto_assign_id(QemuOpts *opts)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 QemuOptsList *olist =3D qemu_find_opts(&quot;vnc&quot;);<br>
=C2=A0 =C2=A0 =C2=A0int i =3D 2;<br>
=C2=A0 =C2=A0 =C2=A0char *id;<br>
<br>
@@ -4320,23 +4321,18 @@ static void vnc_auto_assign_id(QemuOptsList *olist,=
 QemuOpts *opts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id =3D g_strdup_printf(&quot;vnc%d&quot;,=
 i++);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0qemu_opts_set_id(opts, id);<br>
+<br>
+=C2=A0 =C2=A0 return id;<br>
=C2=A0}<br>
<br>
=C2=A0void vnc_parse(const char *str)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QemuOptsList *olist =3D qemu_find_opts(&quot;vnc&quot;)=
;<br>
=C2=A0 =C2=A0 =C2=A0QemuOpts *opts =3D qemu_opts_parse_noisily(olist, str, =
!is_help_option(str));<br>
-=C2=A0 =C2=A0 const char *id;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!opts) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 id =3D qemu_opts_id(opts);<br>
-=C2=A0 =C2=A0 if (!id) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* auto-assign id if not present */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vnc_auto_assign_id(olist, opts);<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)<br>
@@ -4344,7 +4340,11 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Erro=
r **errp)<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0char *id =3D (char *)qemu_opts_id(opts);<br>
<br>
-=C2=A0 =C2=A0 assert(id);<br>
+=C2=A0 =C2=A0 if (!id) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* auto-assign id if not present */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 id =3D vnc_auto_assign_id(opts);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0vnc_display_init(id, &amp;local_err);<br>
=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div></div>

--0000000000009dbb0f063ce2a952--


