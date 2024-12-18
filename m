Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A84E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvl8-00064l-6Y; Wed, 18 Dec 2024 10:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tNvl6-00064M-Jp
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:14:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tNvl4-0002bM-Lg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734534879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nNL/6RcFBI/95J8DuGB4nLAyv599WNtDMCiE/94jUbE=;
 b=N6vSztOZoDcTxc1l89UhUr+LPIHmbm5QWjYF/xUe0qJxr+VK+5RFWwsuiFIIexBdNQ5+2Q
 ytCs6BvOGhTXgu4ypf9EEo+xVvq7pIdmcs7XIh3ESSSNx6fxwXkfm45CSustdBBOkvVbZd
 sI/EyLr4X32K8E+UcJ13HOzGoplThos=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-_F6tS67UPq-yiRdK6jw3tQ-1; Wed, 18 Dec 2024 10:14:38 -0500
X-MC-Unique: _F6tS67UPq-yiRdK6jw3tQ-1
X-Mimecast-MFC-AGG-ID: _F6tS67UPq-yiRdK6jw3tQ
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ef9da03117so8895274a91.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734534876; x=1735139676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nNL/6RcFBI/95J8DuGB4nLAyv599WNtDMCiE/94jUbE=;
 b=oqphAqpa6yR8A3urEMqrv2EuDP43WRezsDVOOFLio1HzdihSHcrkfugB7zSHvy1xhH
 9ED6WWsPmozbo3aY6Q8pC3BRryvKJQwNSrY9r0HUtkT8v0GVx27JEBiGU0dLrWCgRzdS
 nI+jqu8CQcyRoQ9QqSCxZ318JeQk/U1I3sXavIYcNO7Wf+vEY9G6Z8TQrABUQYdDfQTC
 ViKwqcLGQUWl7Wo0GEelgkT2ktCuO6K2yJau6r00nDGTh98bQSPOjfqA7dtCVnUKgWb3
 +BO0OFXdx2SNeA46nYUrXEXHvv6BQqWBmj7kLfqMEJbiew+rRd6wzZgCwE/qBW19yiVP
 zgbQ==
X-Gm-Message-State: AOJu0Yzh9cS6RIpShobwyTetTnlgCeo0DPjlcN7Sf0dJ53nvPXpAPZJ5
 0am5fMN6jmF8satKILz+ugacMRC1FFwJZ4gfkOMJgi44kHqR1Znp7X5eQrfvtintQi7fOJiUgja
 BGdaN96k6vy+sjAxmzGDdD+xBI9jW8qbu8k//JICkU99sgNNEZJsTsKtuKWX/x5iFwhmdy1BuWr
 i0ZjSmukczCo2WMaI8eYvEk9TpiCZEadhXIaU=
X-Gm-Gg: ASbGncs7azPan/Vvg0R/8C7sw5DndDKheTJOcRGu/je2fC+7MYgZ4tdOKEN3nu6iUQg
 2iapU9RQZvgJeZz5VHpYM+ab7lvl/PZ9foF2HXsXuBhL+o+I8eAgb78Dx9GoMN9J3mvr7RA==
X-Received: by 2002:a17:90b:3d45:b0:2ee:5edc:489 with SMTP id
 98e67ed59e1d1-2f2e93742ecmr4403833a91.26.1734534875913; 
 Wed, 18 Dec 2024 07:14:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUYCLgQ69bXr69+JLcL6ayRQneJTr/vAvhLZ8WN8wfSw3j9yX14zkCFz9UoPkdhXR3eO4F9aUVdRpdSxy0nbo=
X-Received: by 2002:a17:90b:3d45:b0:2ee:5edc:489 with SMTP id
 98e67ed59e1d1-2f2e93742ecmr4403810a91.26.1734534875576; Wed, 18 Dec 2024
 07:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-5-jsnow@redhat.com>
 <87y10dtg06.fsf@pond.sub.org>
In-Reply-To: <87y10dtg06.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 18 Dec 2024 10:14:22 -0500
Message-ID: <CAFn=p-Y3YVCLCtLWH4hfUW=GkuZ1JjrMu9yuCD_WsmeF3x0Gwg@mail.gmail.com>
Subject: Re: [PATCH 04/23] qapi: expand tags to all doc sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000001c268206298cdf01"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

--0000000000001c268206298cdf01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024, 5:58=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
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
> Doesn't pass 'make check' for me.  Diff appended.  It shows the error
> messages get worse.
>

Whoops! My per-patch tester wasn't running make check, only linters and
build testing. I'll fix this, but please keep reviewing in the meantime.

Apologies for the oversight.


>
> diff --git a/tests/qapi-schema/doc-duplicated-return.err
> b/tests/qapi-schema/doc-duplicated-return.err
> index 503b916b25..c0036fe8aa 100644
> --- a/tests/qapi-schema/doc-duplicated-return.err
> +++ b/tests/qapi-schema/doc-duplicated-return.err
> @@ -1 +1 @@
> -doc-duplicated-return.json:8: duplicated 'Returns' section
> +doc-duplicated-return.json:8: duplicated 'Tag.RETURNS' section
> diff --git a/tests/qapi-schema/doc-duplicated-since.err
> b/tests/qapi-schema/doc-duplicated-since.err
> index a9b60c0c3d..1066040560 100644
> --- a/tests/qapi-schema/doc-duplicated-since.err
> +++ b/tests/qapi-schema/doc-duplicated-since.err
> @@ -1 +1 @@
> -doc-duplicated-since.json:8: duplicated 'Since' section
> +doc-duplicated-since.json:8: duplicated 'Tag.SINCE' section
> diff --git a/tests/qapi-schema/doc-empty-section.err
> b/tests/qapi-schema/doc-empty-section.err
> index 711a0d629c..3eae1b93c9 100644
> --- a/tests/qapi-schema/doc-empty-section.err
> +++ b/tests/qapi-schema/doc-empty-section.err
> @@ -1 +1 @@
> -doc-empty-section.json:6: text required after 'Errors:'
> +doc-empty-section.json:6: text required after 'Tag.ERRORS:'
> diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> index ec277be91e..87d2f074cf 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -110,7 +110,7 @@ The _one_ {and only}, description on the same line
>  Also _one_ {and only}
>      feature=3Denum-member-feat
>  a member feature
> -    section=3DNone
> +    section=3DTag.UNTAGGED
>  @two is undocumented
>  doc symbol=3DBase
>      body=3D
> @@ -168,15 +168,15 @@ description starts on the same line
>  a feature
>      feature=3Dcmd-feat2
>  another feature
> -    section=3DNone
> +    section=3DTag.UNTAGGED
>  .. note:: @arg3 is undocumented
> -    section=3DReturns
> +    section=3DTag.RETURNS
>  @Object
> -    section=3DErrors
> +    section=3DTag.ERRORS
>  some
> -    section=3DTODO
> +    section=3DTag.TODO
>  frobnicate
> -    section=3DNone
> +    section=3DTag.UNTAGGED
>  .. admonition:: Notes
>
>   - Lorem ipsum dolor sit amet
> @@ -200,7 +200,7 @@ Examples::
>
>  Note::
>      Ceci n'est pas une note
> -    section=3DSince
> +    section=3DTag.SINCE
>  2.10
>  doc symbol=3Dcmd-boxed
>      body=3D
> @@ -209,7 +209,7 @@ If you're bored enough to read this, go see a video o=
f
> boxed cats
>  a feature
>      feature=3Dcmd-feat2
>  another feature
> -    section=3DNone
> +    section=3DTag.UNTAGGED
>  .. qmp-example::
>
>     -> "this example"
>
>

--0000000000001c268206298cdf01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 18, 2024, 5:58=E2=80=
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
Doesn&#39;t pass &#39;make check&#39; for me.=C2=A0 Diff appended.=C2=A0 It=
 shows the error<br>
messages get worse.<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Whoops! My per-patch tester wasn&#39;t running make chec=
k, only linters and build testing. I&#39;ll fix this, but please keep revie=
wing in the meantime.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Ap=
ologies for the oversight.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<br>
<br>
diff --git a/tests/qapi-schema/doc-duplicated-return.err b/tests/qapi-schem=
a/doc-duplicated-return.err<br>
index 503b916b25..c0036fe8aa 100644<br>
--- a/tests/qapi-schema/doc-duplicated-return.err<br>
+++ b/tests/qapi-schema/doc-duplicated-return.err<br>
@@ -1 +1 @@<br>
-doc-duplicated-return.json:8: duplicated &#39;Returns&#39; section<br>
+doc-duplicated-return.json:8: duplicated &#39;Tag.RETURNS&#39; section<br>
diff --git a/tests/qapi-schema/doc-duplicated-since.err b/tests/qapi-schema=
/doc-duplicated-since.err<br>
index a9b60c0c3d..1066040560 100644<br>
--- a/tests/qapi-schema/doc-duplicated-since.err<br>
+++ b/tests/qapi-schema/doc-duplicated-since.err<br>
@@ -1 +1 @@<br>
-doc-duplicated-since.json:8: duplicated &#39;Since&#39; section<br>
+doc-duplicated-since.json:8: duplicated &#39;Tag.SINCE&#39; section<br>
diff --git a/tests/qapi-schema/doc-empty-section.err b/tests/qapi-schema/do=
c-empty-section.err<br>
index 711a0d629c..3eae1b93c9 100644<br>
--- a/tests/qapi-schema/doc-empty-section.err<br>
+++ b/tests/qapi-schema/doc-empty-section.err<br>
@@ -1 +1 @@<br>
-doc-empty-section.json:6: text required after &#39;Errors:&#39;<br>
+doc-empty-section.json:6: text required after &#39;Tag.ERRORS:&#39;<br>
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t<br>
index ec277be91e..87d2f074cf 100644<br>
--- a/tests/qapi-schema/doc-good.out<br>
+++ b/tests/qapi-schema/doc-good.out<br>
@@ -110,7 +110,7 @@ The _one_ {and only}, description on the same line<br>
=C2=A0Also _one_ {and only}<br>
=C2=A0 =C2=A0 =C2=A0feature=3Denum-member-feat<br>
=C2=A0a member feature<br>
-=C2=A0 =C2=A0 section=3DNone<br>
+=C2=A0 =C2=A0 section=3DTag.UNTAGGED<br>
=C2=A0@two is undocumented<br>
=C2=A0doc symbol=3DBase<br>
=C2=A0 =C2=A0 =C2=A0body=3D<br>
@@ -168,15 +168,15 @@ description starts on the same line<br>
=C2=A0a feature<br>
=C2=A0 =C2=A0 =C2=A0feature=3Dcmd-feat2<br>
=C2=A0another feature<br>
-=C2=A0 =C2=A0 section=3DNone<br>
+=C2=A0 =C2=A0 section=3DTag.UNTAGGED<br>
=C2=A0.. note:: @arg3 is undocumented<br>
-=C2=A0 =C2=A0 section=3DReturns<br>
+=C2=A0 =C2=A0 section=3DTag.RETURNS<br>
=C2=A0@Object<br>
-=C2=A0 =C2=A0 section=3DErrors<br>
+=C2=A0 =C2=A0 section=3DTag.ERRORS<br>
=C2=A0some<br>
-=C2=A0 =C2=A0 section=3DTODO<br>
+=C2=A0 =C2=A0 section=3DTag.TODO<br>
=C2=A0frobnicate<br>
-=C2=A0 =C2=A0 section=3DNone<br>
+=C2=A0 =C2=A0 section=3DTag.UNTAGGED<br>
=C2=A0.. admonition:: Notes<br>
<br>
=C2=A0 - Lorem ipsum dolor sit amet<br>
@@ -200,7 +200,7 @@ Examples::<br>
<br>
=C2=A0Note::<br>
=C2=A0 =C2=A0 =C2=A0Ceci n&#39;est pas une note<br>
-=C2=A0 =C2=A0 section=3DSince<br>
+=C2=A0 =C2=A0 section=3DTag.SINCE<br>
=C2=A02.10<br>
=C2=A0doc symbol=3Dcmd-boxed<br>
=C2=A0 =C2=A0 =C2=A0body=3D<br>
@@ -209,7 +209,7 @@ If you&#39;re bored enough to read this, go see a video=
 of boxed cats<br>
=C2=A0a feature<br>
=C2=A0 =C2=A0 =C2=A0feature=3Dcmd-feat2<br>
=C2=A0another feature<br>
-=C2=A0 =C2=A0 section=3DNone<br>
+=C2=A0 =C2=A0 section=3DTag.UNTAGGED<br>
=C2=A0.. qmp-example::<br>
<br>
=C2=A0 =C2=A0 -&gt; &quot;this example&quot;<br>
<br>
</blockquote></div></div></div>

--0000000000001c268206298cdf01--


