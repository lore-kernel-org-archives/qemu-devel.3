Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B6ACCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUKp-0008TR-Th; Thu, 30 Oct 2025 11:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vEUKU-0008QP-T7
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vEUKP-00058j-Gq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761837156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6G3KeI0h89ZTRwaL5AVRWAIvBSSC3/QKm/TnduamAsE=;
 b=Sbrr/OLr7Au0RPCw8skmuvlJwqnjeNLsHoiTA0K4tO88xmzRA7QqLKKIlBxeKTvu2ot7DP
 w4NcSV56LV7fzrBMJa7Jyk1w2yLMR90hSkZRwueNy4epwr1CnZP74nTxnINHONpqTLOR2j
 3PMy/qTRyZW68L+WmNzwqobdw+A7Ehc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Ce__2bivPpmaCB0nOylX3w-1; Thu, 30 Oct 2025 11:12:34 -0400
X-MC-Unique: Ce__2bivPpmaCB0nOylX3w-1
X-Mimecast-MFC-AGG-ID: Ce__2bivPpmaCB0nOylX3w_1761837154
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-785c67bec06so15233287b3.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761837154; x=1762441954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6G3KeI0h89ZTRwaL5AVRWAIvBSSC3/QKm/TnduamAsE=;
 b=M57ceNQGf7srv0llSA6sDHmeMDMLekhqR3LgKyiRt0qNhQS1wpGw+tY8lBa56Wfc+K
 dIidUYjlVHdY5C38zGnl0kn0HtWSaZKmrUB6ST5GMlk9+sbChJSykSOwnxKO+ym9Y8uR
 77WL8mvUfRKiGUwJ89xjITlR4QB67YflPfy0EzVbEhJTxgGxh20qa4gGXH32uAmzT9Iw
 ocvjsKyPn3i1TOnLGxgTakp+V3TeFThpaXzx2qg6OkryApAT5tIIcImIZy5Atn1JaxlI
 HPHg72bCLH+XjK5lYXrlrrqosQs4aPvwVckBFEOlW9nqQkZClrYTnrWEVikW0/GmjZlj
 dH5A==
X-Gm-Message-State: AOJu0YwFdcMTo1iCBp85tmuyiIw1NT9DYA95YZ6xak4DCo9WEjyChRME
 0yd6rYlUhVKwP+T3PGxVilv5OfxwAdkBmK1M0GqXzzZDETnvynDBhdq9OYtxDg18iLQFweW4fxZ
 8uw4dlE2qQPx6EVu1czbBcLk3TqJjhecPl4X0pgg4dNsCFXiyjv2uvTsYnWzDEk1SBinC9T+DmA
 5Eenw6vf6k4hiAL5Bpd+58Juh/dr7sJOs=
X-Gm-Gg: ASbGncv3OgEXaPmpVTSmLNscI9OTy+lOz7SlHt0TQK1slTNJ+VTPZ9k0YJ8nSmAVRio
 D82QK9KgKizZ4zCsZlXbTMm8oKtRNLkI2jPj9a5sBAKSe/MgjaiGx2eK8Y18owNmsPtCiAq9zvw
 3qep4tRCe0lbZtDY0+hkWkkXWK6kzFNLd3hdIiQu+l5hu1rt+oxnIEU0RRClk1pgHgL+D+4Fh29
 3Rpfb08qHvw+mU=
X-Received: by 2002:a05:690c:3612:b0:785:c4d1:da0e with SMTP id
 00721157ae682-7863911e91fmr34953467b3.66.1761837153809; 
 Thu, 30 Oct 2025 08:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiQWmyDl9rNcitjK3b20esqYVzEbJh1eNOMx2gKOCh2dkukleL1Ebbh+/T6Y7UIWrCsxzV1mKHzx/QHuk2T3U=
X-Received: by 2002:a05:690c:3612:b0:785:c4d1:da0e with SMTP id
 00721157ae682-7863911e91fmr34953187b3.66.1761837153320; Thu, 30 Oct 2025
 08:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-4-jsnow@redhat.com>
 <de0c1bf7-7ae9-4087-9a33-ea96d1fa6db7@redhat.com>
In-Reply-To: <de0c1bf7-7ae9-4087-9a33-ea96d1fa6db7@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 30 Oct 2025 11:12:22 -0400
X-Gm-Features: AWmQ_bku-P3jTxALP9uHk07aGIDXqSj8qu9EiL8MsU4hDVrlYeZy4_zNql1Ob8A
Message-ID: <CAFn=p-a9QCwhA=QLXOLJVMBqxBk_3PVMhFSedVB=iBsoDsDEDw@mail.gmail.com>
Subject: Re: [PATCH RFC 03/10] python/mkvenv: create timestamp file for each
 group "ensured"
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ad1f4d064261adbd"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000ad1f4d064261adbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025, 4:28=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote:

>
> Missing patch description - what is this good for?
>

At the moment, truthfully, nothing!

The intent was a timestamp file for each group so scripts don't need to
reinstall groups post-config time.

Basically a replacement for check-venv's timestamp file.



>   Thomas
>
> On 28/10/2025 23.03, John Snow wrote:
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   python/scripts/mkvenv.py | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
> > index a064709e6ce..a22e3ee3394 100644
> > --- a/python/scripts/mkvenv.py
> > +++ b/python/scripts/mkvenv.py
> > @@ -838,6 +838,12 @@ def ensure_group(
> >               raise Ouch(result[0])
> >           raise SystemExit(f"\n{result[0]}\n\n")
> >
> > +    if inside_a_venv():
> > +        for group in groups:
> > +            path =3D Path(sys.prefix).joinpath(f"{group}.group")
> > +            with open(path, "w", encoding=3D"UTF8"):
> > +                pass
> > +
> >
> >   def post_venv_setup() -> None:
> >       """
>
>

--000000000000ad1f4d064261adbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025, 4:28=E2=80=
=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
Missing patch description - what is this good for?<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">At the moment, truthfully=
, nothing!</div><div dir=3D"auto"><br></div><div dir=3D"auto">The intent wa=
s a timestamp file for each group so scripts don&#39;t need to reinstall gr=
oups post-config time.</div><div dir=3D"auto"><br></div><div dir=3D"auto">B=
asically a replacement for check-venv&#39;s timestamp file.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=C2=A0 Thomas<br>
<br>
On 28/10/2025 23.03, John Snow wrote:<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0python/scripts/mkvenv.py | 6 ++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 6 insertions(+)<br>
&gt; <br>
&gt; diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py<br>
&gt; index a064709e6ce..a22e3ee3394 100644<br>
&gt; --- a/python/scripts/mkvenv.py<br>
&gt; +++ b/python/scripts/mkvenv.py<br>
&gt; @@ -838,6 +838,12 @@ def ensure_group(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Ouch(resul=
t[0])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise SystemExit(f&quot;\n{res=
ult[0]}\n\n&quot;)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 if inside_a_venv():<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for group in groups:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D Path(sys.prefix).j=
oinpath(f&quot;{group}.group&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(path, &quot;w&quo=
t;, encoding=3D&quot;UTF8&quot;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0def post_venv_setup() -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
</blockquote></div></div></div>

--000000000000ad1f4d064261adbd--


