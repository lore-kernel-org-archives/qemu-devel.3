Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02725E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 18:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxbH-0000ls-0A; Thu, 09 Jan 2025 13:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVxbA-0000lR-F9
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVxb5-0005Ke-2Q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736448573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qr6D18aPxUc8js6lj5VFD7K85noJbrnVw6AzFQlZU1Y=;
 b=XOFJyy3kRw1Hr11PJtFMgm1mXqMLXxjOMvbWD4cnCG6AmKu0Fp+csiz08+eMEWCKHbT4uS
 bTXsd0H33ovGlnmSprFxi4Dr1wudEOF3r6GuhSYdDFW/7j51dan/ZiYFH2ctygF1U8qVzg
 Zk0uWgqW4Plv2VxwO2WjyudhHaVZ6pQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-MBQDfJrcOZqci-VtswFXmQ-1; Thu, 09 Jan 2025 13:49:27 -0500
X-MC-Unique: MBQDfJrcOZqci-VtswFXmQ-1
X-Mimecast-MFC-AGG-ID: MBQDfJrcOZqci-VtswFXmQ
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2efa0eb9cfeso2231091a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 10:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736448566; x=1737053366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qr6D18aPxUc8js6lj5VFD7K85noJbrnVw6AzFQlZU1Y=;
 b=Xyn9nnEQKdGfQBZZ5XnZq9fGkRtLXwJFSTHc0cLVzxH4+EcF+m1jFNb/b6fQhNAczs
 GDrZvQR5rx5yxpfNPE5W5jkvJmxms7lZJ7s2ZM9WS0WdIoAjAkjDqI4u+UTwLC891iRe
 PYe/Gtls4iZ46lAqgCRfGtF4KnjHApXZutHjerG6JirsUHf3tThi/wX3oyutEgVQjIrC
 az4OMv/UhTnm7IfJtIKqeyK4RVfwl0r8gOiXyujWR5pSGyTYSUxS2C7fHdQ17qFj3rRD
 NQPAEn6jDV6iuPwjZoaoqF0umVcJNaWIgqOWUosPPIXvA06QgZCiwapGu7A+XEyaeXL4
 eH5Q==
X-Gm-Message-State: AOJu0YzO5BGHBx+N6M7Md/vBosiA1pDCrH2/Mi7tJGi/Kl0fhiXRA+il
 5CAMuOh6bj62vZJAYqkqwWKzkzpMyC4rz3jKQL6cXJQhjfAdJljZDmO8xTY3OY1MCyOKJFUuc92
 u51d1ep0sYRDaFg0qDs+yqF58+afmnjfyuvlRj8RwqJrrMf60PRRb2nfQ7k6PReDd09FVtwSdyd
 VcWkrx4k7K28qYswj5EJb7PwV97X4=
X-Gm-Gg: ASbGncsaCht4WHREZ9XbooWuvlITtvuxt1x/bTKFxF0okRmD3WA7JREYKUVKDkcY+G5
 R/senvB4hkUT1iF+/O92GYDe3yf9xZQTSh9HCCpXyU4F3MoI+BCQKFuvur7KHCCrqx5IgIQ==
X-Received: by 2002:a17:90b:3e82:b0:2ee:8253:9a9f with SMTP id
 98e67ed59e1d1-2f5545de647mr6262362a91.11.1736448566462; 
 Thu, 09 Jan 2025 10:49:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXWm4UakDaK+b+ETg1iNhZ5zlcL6bsDOU5oq4S3T0R7nve0/ID81667pYgvQIleGJzQEjhdC6nylpfiPW/vp4=
X-Received: by 2002:a17:90b:3e82:b0:2ee:8253:9a9f with SMTP id
 98e67ed59e1d1-2f5545de647mr6262330a91.11.1736448566113; Thu, 09 Jan 2025
 10:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-5-jsnow@redhat.com>
 <87ldwa4hwj.fsf@pond.sub.org>
In-Reply-To: <87ldwa4hwj.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 9 Jan 2025 13:49:13 -0500
X-Gm-Features: AbW1kvY9-BE8vHlmm5eJFeN3pdJx7u-4SA28q8WwmDlELRP31wQptxiTGYZa3ig
Message-ID: <CAFn=p-b51afQQDo7qd_T5EPyunuxGY-N8hjzbim5894JGwTEjA@mail.gmail.com>
Subject: Re: [PATCH 04/23] qapi: expand tags to all doc sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000f45bf5062b4a6f10"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000f45bf5062b4a6f10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024, 8:13=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch adds an explicit section tag to all QAPIDoc
> > sections. Members/Features are now explicitly tagged as such, with the
> > name now being stored in a dedicated "name" field (which qapidoc.py was
> > not actually using anyway.)
> >
> > WIP: Yeah, the difference between "tagged" and "untagged" sections is
> > now pretty poorly named, and explicitly giving "untagged" sections an
> > "UNTAGGED" tag is ... well, worse. but mechanically, this accomplishes
> > what I need for the series.
> >
> > Please suggest better naming conventions, keeping in mind that I
> > currently have plans for a future patch that splits the "UNTAGGED" tag
> > into "INTRO" and "DETAILS" tags. But, we still need a meta-name for the
> > category of sections that are "formerly known as untagged" but cannot b=
e
> > called "freeform" because that name is used for the category of
> > docblocks that are not attached to an entity (but happens to be
> > comprised entirely of "formerly known as untagged" sections.)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> A free-form doc comment consists of just one untagged section, actually.
> I don't remember whether anything relies on "just one".
>

Sure, yes. Sorry, I keep thinking of documentation as containing "any
number of sections" but keep eliding the fact that our parser
implementation currently will never actually create multiple adjacent
"untagged" sections.

I don't even change this anywhere even in my offline WIP, so it's just me
being over-general.

(I don't think it winds up being relevant or mattering to anything in this
series or my larger project beyond some word choices.)


> The term "tagged" is rooted in doc comment syntax.
> docs/devel/qapi-code-gen.rst section "Definition documentation":
>
>     Definition documentation starts with a line naming the definition,
>     followed by an optional overview, a description of each argument (for
>     commands and events), member (for structs and unions), branch (for
>     alternates), or value (for enums), a description of each feature (if
>     any), and finally optional tagged sections.
>
> Sadly, this isn't fully accurate anymore.
>
>     Descriptions start with '\@name:'.  The description text must be
>     indented [...]
>
>     A tagged section begins with a paragraph that starts with one of the
>     following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends
> with
>     the start of a new section.
>
>     The second and subsequent lines of tagged sections must be indented
>     [...]
>
> Nothing about untagged sections.  These are sections that aren't
> descriptions or tagged.  Example:
>
>     # @Returns: Lorem ipsum dolor sit amet, consectetur adipiscing elit,
>     #     sed do eiusmod tempor incididunt ut labore et dolore magna
>     #     aliqua.
>     #
>     # Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
>     # nisi ut aliquip ex ea commodo consequat.
>     #
>     # Duis aute irure dolor in reprehenderit in voluptate velit esse
>     # cillum dolore eu fugiat nulla pariatur.
>     ##
>
> Here, the tagged "Returns" section ends after "aliqua."  Why?  Because
> "Ut enim" isn't indented.  The untagged section ends after "pariatur."
>
> We parse a definition doc comment as a sequence of sections.
>
> The first one is the overview.
>
> Member / argument descriptions, if any, are next.
>
> Then we may have any number of tagged or untagged sections.  If I
> remember correctly, you'd like to banish them.  Let's pretend they can't
> exist here.
>

I think you're referring to my desire to banish "untagged" sections from
appearing *between* "tagged" sections. Yes, that's still a desire; though I
make no movement on it in this series as sent to list, and this change is
entirely unrelated to that desire.

(It's more related to being able to distinguish features from members, and
later, distinguishing intro/details. This patch still serves a purpose even
without the inliner or the complexities it brings, but serves both needs.)

((Reminder: the reason for this desire is because "tagged sections" are
rendered in html as a two-column list, and free paragraphs appearing
between list entries looks bad in the rendered documentation, because it
means ending the table, starting paragraph(s), then starting a new table.
If free text is meant to be associated with a specific
member/feature/section-group, it should be marked up (in SOME way) so that
the renderer can achieve that grouping visually.

(There will be a standalone patch that implements this restriction and we
can debate this there, I'm only giving you context here.)))


> Then we may have a "Features:" line followed by feature descriptions.
>
> Finally, we may have any number of tagged or untagged sections.
>
> Each of these sections is represented as an instance of type Section,
> and the entire definition doc as an instance of type QAPIDoc.
>
> Section has a member @tag of type str.
>
> For tagged sections, it's the tag, i.e "Since", "Returns", ...  Obvious
> enough.
>
> For overview and other untagged sections, it's None.  Still obvious.
>
> For descriptions, it's the name of the thing being described.  Less than
> obvious.  Note that descriptions are actually instances of ArgSection, a
> subtype of Section, which prevents confusion with tagged sections.
>

Note that this patch changes this as well; it becomes "member" or "feature"
as appropriate and the name is moved into a dedicated name field that
belongs to the ArgSection class.

(Turns out legacy qapidoc doesn't use this stored name at all anyway, it
fetches the name via the linked feature/member instead.)


> QAPIDoc has the overview in member @body, member / argument descriptions
> in @args, feature descriptions in @features, and the remaining sections
> in @sections.
>
> I'm in favor of cleaning this up some.
>
> I think we can keep the Section name.
>
> Moving the name of the thing being described from @tag to @name is good.
> What value to put into @tag then?  Whatever suits you.
>

What suits me is "member" and "feature". :)


> Perhaps we should rename @tag to avoid undue ties to tagged sections.
> @kind would work for me.
>

Sold!


> Value None for untagged sections is fine with me.  If a string suits you
> better, that's fine, too.  "untagged", "plain", I don't know, propose
> something.
>

For static typing reasons, an explicit tag is preferred to distinguish from
it being "optional".

I could cope with any of:

"plain",
"text",
"plaintext",
"paragraphs",
"unstructured",
"free"

... keeping in mind that I do intend to "split" this tag/kind into "intro"
and "details" later. i.e. this is a temporary tag/kind label.

I think I like "text" the most because it says the least. What about you?


> @body, @args, and so forth aren't exactly great names.  If they truly
> annoy or confuse you, feel free to propose better ones.
>

I believe they can be removed entirely once the old qapidoc is sunset,
leaving only .sections[] behind.

This removes the temptation to pick out sections "out of order".

We only need the list of sections in their source order to generate the
appropriate rST.

(Note: the inliner actually does need to filter sections somewhat to do its
inlining magic, but we'll talk about that later. All you need to know right
now is that my WIP does not utilize any field except .sections[], so the
others can in fact be dropped as redundant once we make the switch. This
patch helps enable the paradigm of "everything you need to render a section
is contained within the Section object itself" which lends itself well to
the new transmogrifier, the goal of always processing/rendering in source
order, and facilitating the mechanics of the inliner.)

...

In case I got too rambly, my action items for this patch are:

- fix the test (already done)
- rename tag to kind
- rename "untagged" to "text", possibly changing it again pending your
feedback.

--js

>

--000000000000f45bf5062b4a6f10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 20, 2024, 8:13=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch adds an explicit section tag to all QAPIDoc<br>
&gt; sections. Members/Features are now explicitly tagged as such, with the=
<br>
&gt; name now being stored in a dedicated &quot;name&quot; field (which qap=
idoc.py was<br>
&gt; not actually using anyway.)<br>
&gt;<br>
&gt; WIP: Yeah, the difference between &quot;tagged&quot; and &quot;untagge=
d&quot; sections is<br>
&gt; now pretty poorly named, and explicitly giving &quot;untagged&quot; se=
ctions an<br>
&gt; &quot;UNTAGGED&quot; tag is ... well, worse. but mechanically, this ac=
complishes<br>
&gt; what I need for the series.<br>
&gt;<br>
&gt; Please suggest better naming conventions, keeping in mind that I<br>
&gt; currently have plans for a future patch that splits the &quot;UNTAGGED=
&quot; tag<br>
&gt; into &quot;INTRO&quot; and &quot;DETAILS&quot; tags. But, we still nee=
d a meta-name for the<br>
&gt; category of sections that are &quot;formerly known as untagged&quot; b=
ut cannot be<br>
&gt; called &quot;freeform&quot; because that name is used for the category=
 of<br>
&gt; docblocks that are not attached to an entity (but happens to be<br>
&gt; comprised entirely of &quot;formerly known as untagged&quot; sections.=
)<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
A free-form doc comment consists of just one untagged section, actually.<br=
>
I don&#39;t remember whether anything relies on &quot;just one&quot;.<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sure, =
yes. Sorry, I keep thinking of documentation as containing &quot;any number=
 of sections&quot; but keep eliding the fact that our parser implementation=
 currently will never actually create multiple adjacent &quot;untagged&quot=
; sections.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I don&#39;t =
even change this anywhere even in my offline WIP, so it&#39;s just me being=
 over-general.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(I don&#3=
9;t think it winds up being relevant or mattering to anything in this serie=
s or my larger project beyond some word choices.)</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
The term &quot;tagged&quot; is rooted in doc comment syntax.<br>
docs/devel/qapi-code-gen.rst section &quot;Definition documentation&quot;:<=
br>
<br>
=C2=A0 =C2=A0 Definition documentation starts with a line naming the defini=
tion,<br>
=C2=A0 =C2=A0 followed by an optional overview, a description of each argum=
ent (for<br>
=C2=A0 =C2=A0 commands and events), member (for structs and unions), branch=
 (for<br>
=C2=A0 =C2=A0 alternates), or value (for enums), a description of each feat=
ure (if<br>
=C2=A0 =C2=A0 any), and finally optional tagged sections.<br>
<br>
Sadly, this isn&#39;t fully accurate anymore.<br>
<br>
=C2=A0 =C2=A0 Descriptions start with &#39;\@name:&#39;.=C2=A0 The descript=
ion text must be<br>
=C2=A0 =C2=A0 indented [...]<br>
<br>
=C2=A0 =C2=A0 A tagged section begins with a paragraph that starts with one=
 of the<br>
=C2=A0 =C2=A0 following words: &quot;Since:&quot;, &quot;Returns:&quot;, &q=
uot;Errors:&quot;, &quot;TODO:&quot;.=C2=A0 It ends with<br>
=C2=A0 =C2=A0 the start of a new section.<br>
<br>
=C2=A0 =C2=A0 The second and subsequent lines of tagged sections must be in=
dented<br>
=C2=A0 =C2=A0 [...]<br>
<br>
Nothing about untagged sections.=C2=A0 These are sections that aren&#39;t<b=
r>
descriptions or tagged.=C2=A0 Example:<br>
<br>
=C2=A0 =C2=A0 # @Returns: Lorem ipsum dolor sit amet, consectetur adipiscin=
g elit,<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0sed do eiusmod tempor incididunt ut labo=
re et dolore magna<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0aliqua.<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Ut enim ad minim veniam, quis nostrud exercitation ullamco =
laboris<br>
=C2=A0 =C2=A0 # nisi ut aliquip ex ea commodo consequat.<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Duis aute irure dolor in reprehenderit in voluptate velit e=
sse<br>
=C2=A0 =C2=A0 # cillum dolore eu fugiat nulla pariatur.<br>
=C2=A0 =C2=A0 ##<br>
<br>
Here, the tagged &quot;Returns&quot; section ends after &quot;aliqua.&quot;=
=C2=A0 Why?=C2=A0 Because<br>
&quot;Ut enim&quot; isn&#39;t indented.=C2=A0 The untagged section ends aft=
er &quot;pariatur.&quot;<br>
<br>
We parse a definition doc comment as a sequence of sections.<br>
<br>
The first one is the overview.<br>
<br>
Member / argument descriptions, if any, are next.<br>
<br>
Then we may have any number of tagged or untagged sections.=C2=A0 If I<br>
remember correctly, you&#39;d like to banish them.=C2=A0 Let&#39;s pretend =
they can&#39;t<br>
exist here.<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">I think you&#39;re referring to my desire to banish &quot;untagg=
ed&quot; sections from appearing *between* &quot;tagged&quot; sections. Yes=
, that&#39;s still a desire; though I make no movement on it in this series=
 as sent to list, and this change is entirely unrelated to that desire.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">(It&#39;s more related to b=
eing able to distinguish features from members, and later, distinguishing i=
ntro/details. This patch still serves a purpose even without the inliner or=
 the complexities it brings, but serves both needs.)</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">((Reminder: the reason for this desire is beca=
use &quot;tagged sections&quot; are rendered in html as a two-column list, =
and free paragraphs appearing between list entries looks bad in the rendere=
d documentation, because it means ending the table, starting paragraph(s), =
then starting a new table. If free text is meant to be associated with a sp=
ecific member/feature/section-group, it should be marked up (in SOME way) s=
o that the renderer can achieve that grouping visually.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">(There will be a standalone patch that impl=
ements this restriction and we can debate this there, I&#39;m only giving y=
ou context here.)))</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<br>
Then we may have a &quot;Features:&quot; line followed by feature descripti=
ons.<br>
<br>
Finally, we may have any number of tagged or untagged sections.<br>
<br>
Each of these sections is represented as an instance of type Section,<br>
and the entire definition doc as an instance of type QAPIDoc.<br>
<br>
Section has a member @tag of type str.<br>
<br>
For tagged sections, it&#39;s the tag, i.e &quot;Since&quot;, &quot;Returns=
&quot;, ...=C2=A0 Obvious<br>
enough.<br>
<br>
For overview and other untagged sections, it&#39;s None.=C2=A0 Still obviou=
s.<br>
<br>
For descriptions, it&#39;s the name of the thing being described.=C2=A0 Les=
s than<br>
obvious.=C2=A0 Note that descriptions are actually instances of ArgSection,=
 a<br>
subtype of Section, which prevents confusion with tagged sections.<br></blo=
ckquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Note that=
 this patch changes this as well; it becomes &quot;member&quot; or &quot;fe=
ature&quot; as appropriate and the name is moved into a dedicated name fiel=
d that belongs to the ArgSection class.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">(Turns out legacy qapidoc doesn&#39;t use this stored name =
at all anyway, it fetches the name via the linked feature/member instead.)<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quot=
e gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
QAPIDoc has the overview in member @body, member / argument descriptions<br=
>
in @args, feature descriptions in @features, and the remaining sections<br>
in @sections.<br>
<br>
I&#39;m in favor of cleaning this up some.<br>
<br>
I think we can keep the Section name.<br>
<br>
Moving the name of the thing being described from @tag to @name is good.<br=
>
What value to put into @tag then?=C2=A0 Whatever suits you.<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">What suits me is=
 &quot;member&quot; and &quot;feature&quot;. :)</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
Perhaps we should rename @tag to avoid undue ties to tagged sections.<br>
@kind would work for me.<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Sold!</div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<br>
Value None for untagged sections is fine with me.=C2=A0 If a string suits y=
ou<br>
better, that&#39;s fine, too.=C2=A0 &quot;untagged&quot;, &quot;plain&quot;=
, I don&#39;t know, propose<br>
something.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">For static typing reasons, an explicit tag is preferred to distin=
guish from it being &quot;optional&quot;.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">I could cope with any of:</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">&quot;plain&quot;,</div><div dir=3D"auto">&quot;text&qu=
ot;,</div><div dir=3D"auto">&quot;plaintext&quot;,</div><div dir=3D"auto">&=
quot;paragraphs&quot;,</div><div dir=3D"auto">&quot;unstructured&quot;,</di=
v><div dir=3D"auto">&quot;free&quot;</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">... keeping in mind that I do intend to &quot;split&quot; this=
 tag/kind into &quot;intro&quot; and &quot;details&quot; later. i.e. this i=
s a temporary tag/kind label.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">I think I like &quot;text&quot; the most because it says the least. W=
hat about you?</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
@body, @args, and so forth aren&#39;t exactly great names.=C2=A0 If they tr=
uly<br>
annoy or confuse you, feel free to propose better ones.<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">I believe they can b=
e removed entirely once the old qapidoc is sunset, leaving only .sections[]=
 behind.</div><div dir=3D"auto"><br></div><div dir=3D"auto">This removes th=
e temptation to pick out sections &quot;out of order&quot;.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">We only need the list of sections in =
their source order to generate the appropriate rST.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">(Note: the inliner actually does need to filter=
 sections somewhat to do its inlining magic, but we&#39;ll talk about that =
later. All you need to know right now is that my WIP does not utilize any f=
ield except .sections[], so the others can in fact be dropped as redundant =
once we make the switch. This patch helps enable the paradigm of &quot;ever=
ything you need to render a section is contained within the Section object =
itself&quot; which lends itself well to the new transmogrifier, the goal of=
 always processing/rendering in source order, and facilitating the mechanic=
s of the inliner.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">...</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">In case I got too rambly,=
 my action items for this patch are:</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">- fix the test (already done)</div><div dir=3D"auto">- rename =
tag to kind</div><div dir=3D"auto">- rename &quot;untagged&quot; to &quot;t=
ext&quot;, possibly changing it again pending your feedback.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">--js</div><div dir=3D"auto"><div clas=
s=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000f45bf5062b4a6f10--


