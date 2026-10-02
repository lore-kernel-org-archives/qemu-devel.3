Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83F7CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCea8-0000bq-Db; Fri, 02 Oct 2026 10:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCeZy-0000Yh-FL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:49:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCeZu-0003zq-Qe
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790952577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4KHM/RuCJxu9UrIlExAHIQ+Sfp0WosKpaiyk+2mSfGE=;
 b=PMwHRr2Jki00m47YzIKq1uElKuZKWnWhYJO0l7UlO9pw93ZHEkuk94/RDPSPiNR3Z5C/2C
 8je/A7l1FFM0kpFv7vO2VWvk5aAItRy/6+Q1uZMNXxUCgO3iycd9pgSYa5z+gcXSFGmzAI
 C3XOrmqP2Ve6bH3Sk4/0nsTvNvBDhpA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-50txgIsIPCu2QYmNQpOWcw-1; Fri, 02 Oct 2026 10:49:32 -0400
X-MC-Unique: 50txgIsIPCu2QYmNQpOWcw-1
X-Mimecast-MFC-AGG-ID: 50txgIsIPCu2QYmNQpOWcw_1790952571
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4887f71b1baso6444862f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 07:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790952571; cv=none;
 d=google.com; s=arc-20260327;
 b=l+OJxtDXe2erBqUFSwydPfHOvIziuJd7Wyqb14JlKk5llZV3qFfrw2kx5fUP2PU+0e
 O0Bn00q8KYYH9IGLg6Axoi6tObGRxFb/njCCWxXc05zdeMoxi2JEe78LsUpnhn9Mng6f
 Z5XJcX3EPfA5YHSq9s7/pkQbgBmgpnwYuUkhbvBfwi9cFCQlDQV46hiG3fCoBR9Yirml
 vsk2yOIzp4N6z4MKUKAbY43j3nEwTsGo1U5O5eRVEM/Lpj25FBRckOR6xrkSkrll47c4
 yfESKiam6T5UgUZ9a/lYEHBIMFyK3K7+MbkVl1NzHykwvbprAA8/zD9OTPm7ZIV9jbjE
 QYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4KHM/RuCJxu9UrIlExAHIQ+Sfp0WosKpaiyk+2mSfGE=;
 fh=7ZnccY8InAwc+MILNNrPYXm7f5gO4HGpH9rE296jmSE=;
 b=aJ7R1EWpw5aGhTLOcueeI6BxHm5LYofFJoezOn9stqDaDMX+g3HB2PFWSHGe8MPniI
 YRSbRUuBPz3dkWztXToDTLEuXnum7lTBQLJ2CgcgfFF65g/Eke8+1yWs8tg4vAzpyKUx
 N9XQgJ23ODyvQb2BGFkxgnX7OzsH6Rp/ts3N3WidiBmuqRZacQsC6NWbQEluCJIuN69J
 OxArlcKBjgIFEynAJvix/psRh9TD17T5EbHHu9K2IaGcRbxWhYfJtyWF3gy/4c4yw9qt
 2aa7BZSnJjljm+pp2dH+eCp7tQEZtfl7VAJwtz+rGq9fhGx51s/penEHCNw+0oB+w5Aj
 wnVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790952571; x=1791557371; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4KHM/RuCJxu9UrIlExAHIQ+Sfp0WosKpaiyk+2mSfGE=;
 b=A9C1J+tpFclkNwAKYqIHK7Vt+PHv99A1j5tmr64GPa39oDzu9N4zqBnmyu0R4wK0x5
 vXNSDVGW+V3dBNAzG4K+86hQgj83KnW4YNOXHxpDEJsiDKSrFwiEdfUILJSSzwMRtCSP
 gp6IO9K00VrySLthyjlqIfaAgbhKfmEU3IEJkl1DAxl6DMW5it5YeZMVC+jp0To14L30
 wpkcym9UEBFCV7mn4C7ysKP0kuvPhCe4Yrrt0eZSyF8BQ0nhepwDrpjduPhKJYqyq09V
 83vEzj1Kp6vtdNYlyy9UPXZHCkNSzylT+HBEJguwsol6q7/q3iKoWzgMnlD71fJNL7wv
 3tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790952571; x=1791557371;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4KHM/RuCJxu9UrIlExAHIQ+Sfp0WosKpaiyk+2mSfGE=;
 b=y3GRnk1WNM60bRoii+NwKfBSfoELp2Dke1Jk4/NykW62qy3xKO/v0eQhVwT2CEhFZi
 zFpPDliG0mvUKrZJyO4MMtdBWrmgvZziYI76qYKkT2ztdf3HovuNA0giWbqbyb+8A/ad
 1kJbDSnpP6fCFJ26nkuSjDcaiqOJO6VskLvc0xv/RgiF35jK22rCDVbLyE8MkGX5LPBy
 RyvvjXjgIZK9UwW7qRZyILKV2tKfXgXeA6LkFTRh1p6hupEts/PjOjdzSUvnIunokt5u
 aPBUheM+Ak9wIxT9rQMzrle4JmGO+briTvPJPIwktkTGXrZAV8f+WVxOSSfj7d61LCp5
 lkYw==
X-Gm-Message-State: AFq9FYKWzRpVF3O+jdUCSj2NWvKhXRVJnGALgawaXhJhDOoLQ0LsBP8j
 q7nLMqyQOFvc55bO/8xTaQtmfB8srcf+JM+HgK1abbQCk3QlYCETHU4JNlr73bSoXisymPhjpf/
 I8ss6enrla+kIc5bdBqdpa8c66dumbF+yXGOmX63agnBFhdnfbgXPqk2wXMKdpSH5cvkiqKK6px
 652Y/q0a3ChoK/EYDOvfgi2lZJ+VWfkgA=
X-Gm-Gg: AYBFou3qNXY/6moKK812tFC3SX4v+kTGSxmjE/obnY9wE55y52TnCvGUOfGFdGQxJwX
 XS1r57OwxnBsY+XBMdBxavnw5fIQj5qhUkK26UVHIW2fjdjeWjZWCR+XQ/+zwbZHnNsw3c5gSjP
 caPrv908z9u9aTPzSbOEJqf9bcLzQOT/sDOPqVyCbXVRo9O37IPizP0EcpQHkPd8M2S3NFyqpLr
 Ivnjk4DE03fv/0b2dJ8D68yHIkOix5Wi8lSPdtTqVts7ugHdRc8MIOfWL9TIw==
X-Received: by 2002:a05:6000:d8d:b0:488:8a5d:ffbe with SMTP id
 ffacd0b85a97d-48b1275c46emr4538982f8f.33.1790952571371; 
 Fri, 02 Oct 2026 07:49:31 -0700 (PDT)
X-Received: by 2002:a05:6000:d8d:b0:488:8a5d:ffbe with SMTP id
 ffacd0b85a97d-48b1275c46emr4538945f8f.33.1790952570765; Fri, 02 Oct 2026
 07:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261001151228.3373747-1-berrange@redhat.com>
 <20261001151228.3373747-17-berrange@redhat.com>
 <75ae2444-0ac9-4aee-8881-fb3431c639e8@redhat.com>
 <ar-Pm3jf4q4gyj0W@redhat.com>
In-Reply-To: <ar-Pm3jf4q4gyj0W@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 2 Oct 2026 16:49:19 +0200
X-Gm-Features: AclHuK-Ae7sHGgqA_XuvD7AtXsg0aRXfUsxnRUOg2Kzbnxw0VoFc7tKBE_DlnyU
Message-ID: <CABgObfbXqUA1JHikLqCqrvbaxtVAq7QsP7+f987dS+tc_OrQsQ@mail.gmail.com>
Subject: Re: [PATCH 16/20] trace: include qemu_loglevel_mask(LOG_TRACE) in
 guard
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ca5a95065cdca3f4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000ca5a95065cdca3f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 2 ott 2026, 13:04 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> On Fri, Oct 02, 2026 at 12:45:49PM +0200, Paolo Bonzini wrote:
> > On 10/1/26 17:12, Daniel P. Berrang=C3=A9 wrote:
> > > If emitting a trace event requires computation for the parameters
> > > passed to the probe, the callers should guard that computation
> > > with trace_event_by_state_backends(), which is a macro expanding
> > > to the a check of the "TRACE_...._DSTATE()" expression. For the
> > > log backend this should include a check for LOG_TRACE being
> > > present in the configured log level.
> > This also needs something for Rust (apologies for the mailer damage):
>
> Ok, I'll test that and include it in a future v3, since I already
> sent out v2 before seeing this.
>

No hurry, it's just an optimization.

Paolo

> --- a/scripts/tracetool/backend/log.py
> > +++ b/scripts/tracetool/backend/log.py
> > @@ -16,7 +16,6 @@
> >
> >
> >  PUBLIC =3D True
> > -CHECK_TRACE_EVENT_GET_STATE =3D True
> >
> >
> >  def generate_h_begin(events, group):
> > @@ -52,3 +51,9 @@ def generate_rs(event, group):
> >          '        }',
> >          fmt=3Dexpand_format_string(event.fmt, event.name + " "),
> >          args=3Devent.args.rust_call_varargs())
> > +
> > +def generate_rs_backend_dstate(event, group):
> > +    out('    unsafe { (bindings::qemu_loglevel & bindings::LOG_TRACE)
> !=3D 0
> > && '
> > +        + 'trace_event_state_is_enabled(_%(event_id)s_DSTATE) } ||',
> > +        event_id =3D 'TRACE_' + e.name.upper())
> > +
> >
> > Paolo
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000ca5a95065cdca3f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 2 ott 2026, 13:04 Daniel =
P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat=
.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Fri, Oct 02, 2026 at 12:45:49PM +0200, Paolo Bonzini wrote:<b=
r>
&gt; On 10/1/26 17:12, Daniel P. Berrang=C3=A9 wrote:<br>
&gt; &gt; If emitting a trace event requires computation for the parameters=
<br>
&gt; &gt; passed to the probe, the callers should guard that computation<br=
>
&gt; &gt; with trace_event_by_state_backends(), which is a macro expanding<=
br>
&gt; &gt; to the a check of the &quot;TRACE_...._DSTATE()&quot; expression.=
 For the<br>
&gt; &gt; log backend this should include a check for LOG_TRACE being<br>
&gt; &gt; present in the configured log level.<br>
&gt; This also needs something for Rust (apologies for the mailer damage):<=
br>
<br>
Ok, I&#39;ll test that and include it in a future v3, since I already<br>
sent out v2 before seeing this.<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">No hurry, it&#39;s just an optimization.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; --- a/scripts/tracetool/backend/log.py<br>
&gt; +++ b/scripts/tracetool/backend/log.py<br>
&gt; @@ -16,7 +16,6 @@<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 PUBLIC =3D True<br>
&gt; -CHECK_TRACE_EVENT_GET_STATE =3D True<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 def generate_h_begin(events, group):<br>
&gt; @@ -52,3 +51,9 @@ def generate_rs(event, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 }&#=
39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fmt=3Dexpand_format_string(event.fmt=
, <a href=3D"http://event.name" rel=3D"noreferrer noreferrer" target=3D"_bl=
ank">event.name</a> + &quot; &quot;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args=3Devent.args.rust_call_varargs(=
))<br>
&gt; +<br>
&gt; +def generate_rs_backend_dstate(event, group):<br>
&gt; +=C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 unsafe { (bindings::qemu_logleve=
l &amp; bindings::LOG_TRACE) !=3D 0<br>
&gt; &amp;&amp; &#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 + &#39;trace_event_state_is_enabled(_%(ev=
ent_id)s_DSTATE) } ||&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 event_id =3D &#39;TRACE_&#39; + e.name.up=
per())<br>
&gt; +<br>
&gt; <br>
&gt; Paolo<br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://entangle-photo.org</a> :|<b=
r>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =
=C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000ca5a95065cdca3f4--


