Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE56D33981
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXpZ-0007lF-9u; Fri, 05 Dec 2025 10:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXpQ-0007ks-2o
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXpO-0007MZ-G0
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764948877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDAyk/5FIaliAHwtFaO6sNa6LArhSOx4AFASumModzE=;
 b=APZlURFnxqfTfjC3uV5UHe5iF9oI2YlcQKCYdJ34lxgoeZMKDEXSSxRpuRimNKgiKJO1ON
 FdNjSpRpcJJytvP1N12yv0Jd++0rMsU7Wc4oXooc065BEBimvawSfupskw2ZR5j8+UdSSM
 4+18zWDEZgW16HhOyYC5npdvOeojUu4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-RCz_T5sJP5OTAgfxZJ_KfQ-1; Fri, 05 Dec 2025 10:34:33 -0500
X-MC-Unique: RCz_T5sJP5OTAgfxZJ_KfQ-1
X-Mimecast-MFC-AGG-ID: RCz_T5sJP5OTAgfxZJ_KfQ_1764948873
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3437863d0easo3490902a91.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764948872; x=1765553672; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lDAyk/5FIaliAHwtFaO6sNa6LArhSOx4AFASumModzE=;
 b=K6gjoxMGAz9tmSxNpyUziMZXHfR+NLwX4OnYGtobH3ORugbVQ60LelAQrpAxqJKQz3
 VFm5jqNaK90BUJ87Dg19K+TwUlZucKDt0MGBsIuhwzNJwnPkk4sJihGeVpqVTOIp98wq
 FDw2A1w31XFkVOApT2EzW2TTDGQ/Ri/Her+quFpXdW0BIY3pewPSzBdrEyRe5W3PO+s8
 miyWKEO3zhGF3QuYqzZKbzFwx4xkAmuebkJI1dshWMUbIoKohlnnkVVz5UKZN5di4hrp
 cvi9onpypFXIrM96mqj+wIAdAl+0L2f+cmjX4Fw5ubRTyr3f8mMCaJym9wyjn3etRF91
 LfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764948872; x=1765553672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDAyk/5FIaliAHwtFaO6sNa6LArhSOx4AFASumModzE=;
 b=n8/bfFMCvk42mGFvuXQoGQwpqKRjT3jA0bMwT0sMVZ48+9c/8EXOnHrV4YZ9Ql2biO
 CQR+UVVQSkhk0iRi2U1rqfBZChlW3wwO9FPt2JfNnlw+9wdkz2FIcqgYhyttJCX33T9j
 X0JZorEBnzDVYRByRBFADZOy258XLhDNDNLFxwJdH1sd6uQSVPr9wkSBuYHOf/DBdkQQ
 SmVBgQ+SjB0mUZbPLgBioPgG3yP4O6+xdyT77zdwT5gjMyGNW1kca7p6/TSO6Ji1NjlA
 m9OSxAGrnyWaHnlfIYMv+84ZCYbPBCt2P5iH+nA778nPafhlM5AZeVtSJJNqJEk6yCQZ
 79bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb3qcSjmUqALknMU2ghZ7v0rbaPI1OdoaqmbgAiXlaWyG8apQixcubGL5rM8dhIY1vq2Rvow3s4YZc@nongnu.org
X-Gm-Message-State: AOJu0YyjEuFXjzNF3im8JDblb6//dLb6gto+qiLdzTfT6+AqLw/YxWbU
 +FbJAqd1TeNL1GXs3vHukkOaMQxo4p9Cx5ecEq85WmKtDNAzZOnmYuHky/33oggSJbVcdiPD0a1
 5hQseWCYYYkVYN8p+Dj29z6p7bmM09fOc7Dlt1HAjmgcsJt6i008yQkvkD1JWC8bsSErMO2X/5c
 uczZ2glOvI1TcMa3OVgqNr32vJAzNLvNk=
X-Gm-Gg: ASbGncsBEgPDbZGGw4Fpv8LI9pykxABMLyQoCo+6vDdJgIPkl9q8xWHZei+PyKRJibi
 DZV6KnxSoEytQxueAydJNr3wON8xEN8g7EfYK7JsDvMshG8eWvxeb8yc70uDLl7n400LxfNyGV9
 Xed1lbUEupSWl+vF82IJGcxL2BoJ/Utt0q8p6ngNH/UMsREuiAzxEhuL0kmhEyBq6nisOG3y9dv
 ciBdpprcZ3SqKSjPTBVJfMtkQ==
X-Received: by 2002:a17:90b:1fc6:b0:341:8ca8:ae64 with SMTP id
 98e67ed59e1d1-3491270ced5mr10615277a91.35.1764948872629; 
 Fri, 05 Dec 2025 07:34:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbri5jQlxWTWGwhuQliI2Y2sHfD+WIJblfS0RkdW8BP+myGVu6Hc765vDavNigg7Zn/3u6rN8i7iy5clgtFa0=
X-Received: by 2002:a17:90b:1fc6:b0:341:8ca8:ae64 with SMTP id
 98e67ed59e1d1-3491270ced5mr10615253a91.35.1764948871828; Fri, 05 Dec 2025
 07:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
 <20251204154235.149575-11-vsementsov@yandex-team.ru>
In-Reply-To: <20251204154235.149575-11-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Dec 2025 19:34:20 +0400
X-Gm-Features: AWmQ_blP17t0oHD-vi6TmUcYX21nhlkao7JK6rY4OpwduHKxnXVBPMzLSVkgk8Q
Message-ID: <CAMxuvaxRsQiskJYRBB_m3rG3PbBiD2QQLqi8FX-BA_4utep02g@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] chardev/char: qemu_char_open(): add return value
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008d6cd90645362ea5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000008d6cd90645362ea5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Dec 4, 2025 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> Accordingly with recommendations in include/qapi/error.h accompany
> errp by boolean return value and get rid of error propagation.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/char.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index bdd907f015..e2ec4e15cc 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -246,7 +246,7 @@ int qemu_chr_add_client(Chardev *s, int fd)
>          CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
>  }
>
> -static void qemu_char_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool qemu_char_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
>      /* Any ChardevCommon member would work */
> @@ -262,13 +262,15 @@ static void qemu_char_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>          }
>          chr->logfd =3D qemu_create(common->logfile, flags, 0666, errp);
>          if (chr->logfd < 0) {
> -            return;
> +            return false;
>          }
>      }
>
> -    if (cc->chr_open) {
> -        cc->chr_open(chr, backend, errp);
> +    if (!cc->chr_open) {
> +        return true;
>      }
> +
> +    return cc->chr_open(chr, backend, errp);
>  }
>
>  static void char_init(Object *obj)
> @@ -1007,7 +1009,6 @@ static Chardev *chardev_new(const char *id, const
> char *typename,
>  {
>      Object *obj;
>      Chardev *chr =3D NULL;
> -    Error *local_err =3D NULL;
>
>      assert(g_str_has_prefix(typename, "chardev-"));
>      assert(id);
> @@ -1018,9 +1019,7 @@ static Chardev *chardev_new(const char *id, const
> char *typename,
>      chr->label =3D g_strdup(id);
>      chr->gcontext =3D gcontext;
>
> -    qemu_char_open(chr, backend, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (!qemu_char_open(chr, backend, errp)) {
>          object_unref(obj);
>          return NULL;
>      }
> --
> 2.48.1
>
>

--0000000000008d6cd90645362ea5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 4, 2025 at 7:42=
=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementsov@y=
andex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Accordingly with recommendations in=
 include/qapi/error.h accompany<br>
errp by boolean return value and get rid of error propagation.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br></blockquote><div><br=
></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marca=
ndre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0chardev/char.c | 15 +++++++--------<br>
=C2=A01 file changed, 7 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index bdd907f015..e2ec4e15cc 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -246,7 +246,7 @@ int qemu_chr_add_client(Chardev *s, int fd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CHARDEV_GET_CLASS(s)-&gt;chr_add_client(s=
, fd) : -1;<br>
=C2=A0}<br>
<br>
-static void qemu_char_open(Chardev *chr, ChardevBackend *backend, Error **=
errp)<br>
+static bool qemu_char_open(Chardev *chr, ChardevBackend *backend, Error **=
errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);<br>
=C2=A0 =C2=A0 =C2=A0/* Any ChardevCommon member would work */<br>
@@ -262,13 +262,15 @@ static void qemu_char_open(Chardev *chr, ChardevBacke=
nd *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chr-&gt;logfd =3D qemu_create(common-&gt;=
logfile, flags, 0666, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (chr-&gt;logfd &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (cc-&gt;chr_open) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cc-&gt;chr_open(chr, backend, errp);<br>
+=C2=A0 =C2=A0 if (!cc-&gt;chr_open) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 return cc-&gt;chr_open(chr, backend, errp);<br>
=C2=A0}<br>
<br>
=C2=A0static void char_init(Object *obj)<br>
@@ -1007,7 +1009,6 @@ static Chardev *chardev_new(const char *id, const cha=
r *typename,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Object *obj;<br>
=C2=A0 =C2=A0 =C2=A0Chardev *chr =3D NULL;<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(g_str_has_prefix(typename, &quot;chardev-&quot;)=
);<br>
=C2=A0 =C2=A0 =C2=A0assert(id);<br>
@@ -1018,9 +1019,7 @@ static Chardev *chardev_new(const char *id, const cha=
r *typename,<br>
=C2=A0 =C2=A0 =C2=A0chr-&gt;label =3D g_strdup(id);<br>
=C2=A0 =C2=A0 =C2=A0chr-&gt;gcontext =3D gcontext;<br>
<br>
-=C2=A0 =C2=A0 qemu_char_open(chr, backend, &amp;local_err);<br>
-=C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 if (!qemu_char_open(chr, backend, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_unref(obj);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--0000000000008d6cd90645362ea5--


