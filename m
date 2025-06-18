Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887C4C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 17:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRwhy-0003IQ-AJ; Wed, 18 Jun 2025 13:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRwhw-0003Hy-9t
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 13:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRwhs-0004Tn-Qa
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 13:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750268174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wWUGyBXKompQ/HwYyPMue2Kas0U5DfPSg3fkCWCqxmQ=;
 b=EuLV3gZ9hG/8m3E1A90dZiNKMU2q3K72LDk2qsnytXQ5iQtdE1Cwj5gu+82tVBWOSRysDe
 xNJpHRPu1UjtXW/VxRwQ0VonuHONbJy/+rRyxLDqqS5Lo4/gnfKNPBtg+ly7yQxYcHo3ib
 EDNbcwDnxYMizhCfJj35dGZ4eBhvNDM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-ZSOIUqhSOY6FQ-TC8G8Qeg-1; Wed, 18 Jun 2025 13:36:13 -0400
X-MC-Unique: ZSOIUqhSOY6FQ-TC8G8Qeg-1
X-Mimecast-MFC-AGG-ID: ZSOIUqhSOY6FQ-TC8G8Qeg_1750268172
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a579058758so1751739f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 10:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750268172; x=1750872972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wWUGyBXKompQ/HwYyPMue2Kas0U5DfPSg3fkCWCqxmQ=;
 b=TnWRuDq6AD6FpkcJGJniHVHCUVhn6aZPuVGy8K1UFqwKRV9N95hzTiybajZUZ7EWUj
 E7Tre0ODx6lDQJ6HRfXXQiJrp3RBO2+XpYJ8Ro3M1g/Enziyp5duQBEadIsODOfxMoMX
 UbFPfLHUTm3YFt0eLlf8lY4L1Yx/DKsW6rTqitPbXF5L06i/HZ5qHiDAaBfMJbGxLie6
 K9h20OjMJROSE+IKFtV7TlqOcg6bVqdCZn5Fgz7qB2pW0iBher9SO1oA57sxyEjmnSsG
 VNCa/evyRLHHc0yKOAn/oEpGdIrRnQG+L7/GvbsFQH1IQiEyzhXzH8TKSlZ652/yIWNZ
 xMLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4CYDph5bogfkrkRKWpmpFJr5ozhpwAyol/o97/3bmMmYNO/Ldpbp72mC7hZkn5W+eOWXKLqWcaVwP@nongnu.org
X-Gm-Message-State: AOJu0YxldbkcxwmW1sASwhKn3hVMvT5GNeveHEey41DBvWslQQnr1Dux
 V+QmBNvF2EnodsKojYGPaXTk80bgwDMoDfQJCClaZgxbAXHMWNOH7qozaOuXmqcFIfJNeDb/bCF
 X2mbSkAgmKNrTl0kXw3v7XcWWu2NVzvOm5qt90Apa5qv9OVy0kwpC4Zw6poGq/5NlM1+QR6h4QN
 fYEYN07u6h34sOFdfjkQ6zHEzIGq2HGrk=
X-Gm-Gg: ASbGncuPX//OzKZ8x7C4kf0PhUglerO02ZGtBXzylmmRWAb394f9FpBsNCGG2OIR/Yo
 zbVYDs7EA6JybGdMQjrHOaPS/57fWwslQhZ6CmRrQphIJDcpVmjdtO1HQo6/v9qvp3LCotfIYHO
 olp3o=
X-Received: by 2002:a05:6000:2486:b0:3a4:ef30:a4c8 with SMTP id
 ffacd0b85a97d-3a572399103mr16955488f8f.10.1750268172004; 
 Wed, 18 Jun 2025 10:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+A1tQWbHLL0pXpwgJaduA/7Ydj40rzuzGUJi+sLiRcaAXGk630Mvo4Fvajgp83Y/fnSDknZgRGnc4nOHau/s=
X-Received: by 2002:a05:6000:2486:b0:3a4:ef30:a4c8 with SMTP id
 ffacd0b85a97d-3a572399103mr16955470f8f.10.1750268171592; Wed, 18 Jun 2025
 10:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <aEk6vdosWZgyQGXD@intel.com>
 <CABgObfaK8h3GE4GWbPrn22JshYcCFdXsxWHWuAPVC4pRb7GZ0A@mail.gmail.com>
 <CABgObfa+w3pcYhFnO6ETxSfoNiNU=+_8WcW6dE8dkUrbt6darw@mail.gmail.com>
 <877c19nn3p.fsf@pond.sub.org>
In-Reply-To: <877c19nn3p.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Jun 2025 19:36:00 +0200
X-Gm-Features: Ac12FXxoz7JmlW0nRWAm6o60zGqGCNGxpbrbAultRxPXx1hLPhjBStJd8ceemvk
Message-ID: <CABgObfY7==Q8z9xPS6oO-qv9U4LJ19Y+mCYENqSYnGFwkhoBYw@mail.gmail.com>
Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-rust@nongnu.org, Martin Kletzander <mkletzan@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a139850637dc1090"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000a139850637dc1090
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 18 giu 2025, 16:25 Markus Armbruster <armbru@redhat.com> ha scritto:

> I don't know enough about Rust/serde to give advice.  I do know how to
> make a fool of myself by asking dumb questions.
>

No dumb questions, only dumb answers.

> For commands this is not a problem because the real underlying
> > transformation is QObject->QObject and the intermediate steps (to and
> > from QObject) can use serde.
>
> Are you talking about commands implemented in Rust?
>

Yes. I will intersperse your text with the corresponding Rust/serde
implementation.

The existing data flow is roughly like this (I'm simplifying):
>
> 1. Parse JSON text into request QObject, pass to QMP core
> 2. Extract command name string and argument QDict
> 3. Look up generated command marshaller / unmarshaller, pass argument
>    QDict to it
>

Same so far since this is C code.

4. Unmarshall argument QDict with the QObject input visitor and
>    generated visit_type_ARG()
>

Unmarshall with QObject Deserializer, which talks to a serde-generated
Deserialize implementation.

5. Pass the C arguments to the handwritten command handler, receive the
>    C return value
>

Same.

6. Marshall the return value into a QObject with the QObject output
>    visitor and generated visit_type_RET(), return it to QMP core
>

Marshall with the QObject Serializer, which talks to a serde-generated
Serialize implementation.

7. Insert it into a response QObject
> 8. Unparse response QObject into JSON text
>

Same.

How would a Serde flow look like?
>

As described above, visitors are bypassed and the marshalling/unmarshalling
works directly at the QObject level.

Implementation-wise the main difference is that 1) the type code
(Serialize/Deserialize) is not the same for serialization and
desetialization, unlike visit_type_*() 2) the code generation is done by
serde instead of qapi-gen and we'd be mostly oblivious to how it works.

The Serializer and Deserializer should be about 1500 lines of Rust + tests,
and they would do the functionality of the QObject input and output
visitors.

> However, QOM property getters/setters (especially, but not
> > exclusively, for properties with compound types) remain a problem
> > since these use callbacks with a Visitor* argument.
>
> object_property_set() takes the new property value wrapped in an input
> visitor.  The property setter extracts it using visit_type_FOOs() with
> this input visitor as it sees fit.  Ideally, it uses exactly
> visit_type_PROPTYPE().
>
> object_property_get() takes an output visitor to be wrapped it around
> the property value.  The property getter inserts it using
> visit_type_FOOs() with this output visitor as it sees fit.  Ideally, it
> uses exactly visit_type_PROPTYPE().
>
> We sometimes use a QObject input / output visitor, and sometimes a
> string input / output visitor.  The latter come with restrictions, and
> are evolutionary dead ends.
>
> The QObject visitors wrap a QObject, the string visitors wrap a string
> (d'oh).
>

Yep. The string visitor is why we cannot just change getters and setters to
use QObject.

In this case, without writing a visit_type_*() implementation that can
write to a Rust struct, an intermediate QObject would be the only way to
turn a Visitor into a Rust data type. So I can imagine three ways to
operate:

* Keep using serde like for commands: in the callback that is invoked by
object_property_set() do Visitor->QObject->setter (yes that means double
conversion when the source visitor is and QObject visitor) or for the
getter case, getter->QObject->Visitor. This has the minimum amount of code
added to qapi-gen.

* Generate a visit_type_*() implementation that emits a Rust struct (i.e.
one that maps for example 'str' to a String and not a *mut c_char) and
forgo serde completely. Use this generated implementation everywhere: QOM
getters and setters, as well as QMP commands. This is how C code works.

* Generate rust->C (e.g. String->*mut c_char) and C->rust converters from
qapi-gen; use the existing C visit_type_*() to extract data from visitors
and then apply said converters to turn the data into a Rust struct, and
likewise in the other direction. This was the way Marc-Andr=C3=A9's prototy=
pe
worked.

I'm afraid this is too terse for ignorant me.
>

I tried to translate that. :)

Paolo


> > I am leaning towards option 1, i.e. keep using serde but only cover
> > conversions to and from QObject. The reason is that one future usecase
> > for Rust in QEMU is the UEFI variable store; that one also has some
> > Rust<->JSON conversions and could be served by either QObject or
> > serde_json. Either way, it'd be nice for the UEFI variable store to
> > remain within the Rust serde ecosystem and allow sharing code between
> > QEMU and Coconut SVSM. But I'm not so sure...
> >
> > Paolo
>
>

--000000000000a139850637dc1090
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 18 giu 2025, 16:25 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
I don&#39;t know enough about Rust/serde to give advice.=C2=A0 I do know ho=
w to<br>
make a fool of myself by asking dumb questions.<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">No dumb questions, only dumb=
 answers.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"=
gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; For commands this is not a problem because the real underlying<br>
&gt; transformation is QObject-&gt;QObject and the intermediate steps (to a=
nd<br>
&gt; from QObject) can use serde.<br>
<br>
Are you talking about commands implemented in Rust?<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes. I will intersperse =
your text with the corresponding Rust/serde implementation.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
The existing data flow is roughly like this (I&#39;m simplifying):<br>
<br>
1. Parse JSON text into request QObject, pass to QMP core<br>2. Extract com=
mand name string and argument QDict<br>3. Look up generated command marshal=
ler / unmarshaller, pass argument<br>
=C2=A0 =C2=A0QDict to it<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Same so far since this is C code.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_con=
tainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
4. Unmarshall argument QDict with the QObject input visitor and<br>
=C2=A0 =C2=A0generated visit_type_ARG()<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Unmarshall with QObject Deserializer=
, which talks to a serde-generated Deserialize implementation.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">5. Pass the =
C arguments to the handwritten command handler, receive the<br>
=C2=A0 =C2=A0C return value<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Same.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
6. Marshall the return value into a QObject with the QObject output<br>
=C2=A0 =C2=A0visitor and generated visit_type_RET(), return it to QMP core<=
br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">M=
arshall with the QObject Serializer, which talks to a serde-generated Seria=
lize implementation.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
7. Insert it into a response QObject<br>8. Unparse response QObject into JS=
ON text<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Same.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
How would a Serde flow look like?<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">As described above, visitors are bypassed =
and the marshalling/unmarshalling works directly at the QObject level.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Implementation-wise the main=
 difference is that 1) the type code (Serialize/Deserialize) is not the sam=
e for serialization and desetialization, unlike visit_type_*() 2) the code =
generation is done by serde instead of qapi-gen and we&#39;d be mostly obli=
vious to how it works.</div><div dir=3D"auto"><br></div><div dir=3D"auto">T=
he Serializer and Deserializer should be about 1500 lines of Rust + tests, =
and they would do the functionality of the QObject input and output visitor=
s.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_q=
uote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
&gt; However, QOM property getters/setters (especially, but not<br>
&gt; exclusively, for properties with compound types) remain a problem<br>
&gt; since these use callbacks with a Visitor* argument.<br>
<br>
object_property_set() takes the new property value wrapped in an input<br>
visitor.=C2=A0 The property setter extracts it using visit_type_FOOs() with=
<br>
this input visitor as it sees fit.=C2=A0 Ideally, it uses exactly<br>
visit_type_PROPTYPE().<br>
<br>
object_property_get() takes an output visitor to be wrapped it around<br>
the property value.=C2=A0 The property getter inserts it using<br>
visit_type_FOOs() with this output visitor as it sees fit.=C2=A0 Ideally, i=
t<br>
uses exactly visit_type_PROPTYPE().<br>
<br>
We sometimes use a QObject input / output visitor, and sometimes a<br>
string input / output visitor.=C2=A0 The latter come with restrictions, and=
<br>
are evolutionary dead ends.<br>
<br>
The QObject visitors wrap a QObject, the string visitors wrap a string<br>
(d&#39;oh).<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Yep. The string visitor is why we cannot just change getters and=
 setters to use QObject.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>In this case, without writing a visit_type_*() implementation that can wri=
te to a Rust struct, an intermediate QObject would be the only way to turn =
a Visitor into a Rust data type. So I can imagine three ways to operate:</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">* Keep using serde like fo=
r commands: in the callback that is invoked by object_property_set() do Vis=
itor-&gt;QObject-&gt;setter (yes that means double conversion when the sour=
ce visitor is and QObject visitor) or for the getter case, getter-&gt;QObje=
ct-&gt;Visitor. This has the minimum amount of code added to qapi-gen.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">* Generate a visit_type_*() =
implementation that emits a Rust struct (i.e. one that maps for example &#3=
9;str&#39; to a String and not a *mut c_char) and forgo serde completely. U=
se this generated implementation everywhere: QOM getters and setters, as we=
ll as QMP commands. This is how C code works.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">* Generate rust-&gt;C (e.g. String-&gt;*mut c_char) a=
nd C-&gt;rust converters from qapi-gen; use the existing C visit_type_*() t=
o extract data from visitors and then apply said converters to turn the dat=
a into a Rust struct, and likewise in the other direction. This was the way=
 Marc-Andr=C3=A9&#39;s prototype worked.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">I&#39;m afraid this is too terse f=
or ignorant me.<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">I tried to translate that. :)</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
&gt; I am leaning towards option 1, i.e. keep using serde but only cover<br=
>
&gt; conversions to and from QObject. The reason is that one future usecase=
<br>
&gt; for Rust in QEMU is the UEFI variable store; that one also has some<br=
>
&gt; Rust&lt;-&gt;JSON conversions and could be served by either QObject or=
<br>
&gt; serde_json. Either way, it&#39;d be nice for the UEFI variable store t=
o<br>
&gt; remain within the Rust serde ecosystem and allow sharing code between<=
br>
&gt; QEMU and Coconut SVSM. But I&#39;m not so sure...<br>
&gt;<br>
&gt; Paolo<br>
<br>
</blockquote></div></div></div>

--000000000000a139850637dc1090--


