Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB088C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBYsH-0006El-Ex; Tue, 29 Sep 2026 10:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYsG-0006Ea-CH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYsB-00020w-II
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790692318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8aHOYMw06vFqIyQ1lq70Z2xZ30dZKMzPuV/jSQIEo4=;
 b=ISyCPsv4NVc5b0LxmHzllWm0Wwj+hoO+X7U5F8oAtEy6UDTjvHk0er0diM+6EwohNwxNae
 1EvI2Q/67WffcfV+zXNuIuYOWQdRh6+GWcxhWb769IS78XHoKK97g2/ZqRjm4woJzKDaeD
 xh/d1K/GBQ8vq8BPjacMsp+suThi5gw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-5Na_TWHvN3e6X25cClxAkw-1; Tue, 29 Sep 2026 10:31:56 -0400
X-MC-Unique: 5Na_TWHvN3e6X25cClxAkw-1
X-Mimecast-MFC-AGG-ID: 5Na_TWHvN3e6X25cClxAkw_1790692315
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8200c815489so62320247b3.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790692315; cv=none;
 d=google.com; s=arc-20260327;
 b=PFjDPcIKBGLC1ZV6hA8tpfNPLENaXoEgI3j4J5bPv2iN3hm51JeYNWEyqVX/RzE2qz
 jZF9FhRhp+axYq4VxFrY2Z7aL/rvzMgi7jeFaUXIlBPeC8kJDfeNW2t7XQ8WjE4JCVL6
 ItGuCf+btHy75g94rchZjfCySQ/CRSpTIh4b1IYHsy0g3a+Qy7v9xIi8RuXrBXXO8Kwh
 18lDZ0XLG+7+jqXJj7KnKTMtGY71sbCfEv8ujtjDE9suX5ZTMEZlfkwrmJ+tetLBxdWA
 3007vzVHennuVN0wYh6v0KjpnN8QC0g2UkzGgVunaTQZKPQd7OnvQrEGU+sD2fZPww7M
 EbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B8aHOYMw06vFqIyQ1lq70Z2xZ30dZKMzPuV/jSQIEo4=;
 fh=be+vfmX/XCacP4IeQ/q9Cx8cwWw6V3GT9VXAd+fPJLc=;
 b=h5dujBsbtL1rK3LpT7PGTg7nNtopQxfSfd022de+TkrAUTF/dIcQI10uW2kSLc613s
 qEgI1D3LV7FL0F5l+RwfacukO8UxmviiuEQHIKh9SsJrjw7qHlCz4/dkjbFsqzgrFXoB
 cmqmQECs2eGcIxaHy8kqxfVvGdtEJvb/ldzfnHde8+pah69MIJaKMXugoTu5Z1BIMwrx
 nenefhZhILrHxefJLyhesFkfxp7HxUK840QDgGufVdM9zuXzt/l0T/1H2Bsb+OIVEVa+
 Au4ce5t32nNugFvWhdLQk9jPuc0VkkRpV8Yq/ShI92xFSGvt5RniHOpZjA6an/VM4yHf
 ZaFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790692315; x=1791297115; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B8aHOYMw06vFqIyQ1lq70Z2xZ30dZKMzPuV/jSQIEo4=;
 b=atBd4WFkzsQ70u8C4xeaLn1/PyTPnB+9KT8TCEpVHEdtmMWbMACfxxRrb0yJzJt+Yj
 kbOyY0JbYT5uCANm430g4nuj8rehXDALwYdTOaK44NXnf5pfr3LwER10wZTWBlWwjS8i
 5VtHTs8aeSEfh9kTqH6L1rz2g0R4F2mmRtosryereraDbKKnqePIP0+FftNDs1xiQ27P
 wTZxvAp2qh3jkqu0paYfhVfWlxhbMg1w/MdnDKoHDOw0B3g5Z5TpEzKjt9pTJE5Ct3oW
 NJol8FlwFUJ0Y0vWtgwO8DPdUD9+sxeLZXFujGLRCnQkzUktwPektm5G42di8NEt69nV
 Vtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790692315; x=1791297115;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B8aHOYMw06vFqIyQ1lq70Z2xZ30dZKMzPuV/jSQIEo4=;
 b=JuZdo7hEjbi98LZszMce9/uPOPVV/3w3RAhr71WjFRjmJ1T85mwvWeQgl0EtNC8Bs9
 ZDyv4eo6cnPq/RaECOZ96byf1Jjs7d6EvKrC/xUod12vGHELpBM9+bDFifJQYJtNSo7l
 Wx/7yVLm6eMUAl9TcIQEeqMXdbIut8G8lxjaym7Tc6MuYjGUzvqgzzV1phbJNszI6Vev
 DjJ0BcA7mnNODdFRkGdk4w3zD4K/3XlXnnjZlzQIqf3I94dJJ/VJZpLDWQL67LopYB51
 l4EnfFsZIOfO5SmfaEI5sWyCy8W0rRh+hiPQIjRoj/EUTlsFsV1MRl9dJ97MOQa/Z7wa
 0kcg==
X-Gm-Message-State: AFuF++mKszL/QO8/n84MOuV6jAPLwuerx82gajAlKpCitsajMAYG3z/H
 qpYgR/t6IXpkBpFYS84fuchsRcDGaYLIobjvelCwV2NAtxths+hFtEjP41ooKLt/30RNniR4R5E
 kw/Yn75paLyq6x3jdx2OfSUPL82Ku45yBzoWCmOTeVRKfXv4XOBQ1toUuTWhPFBFcfQPm3OPs4y
 dHEUs9BRscQn2Pi2xeIWUqksZayHNzcXQbwNz+2j8=
X-Gm-Gg: AYBFou2MEdSDIR83S2BFzXseBOxcXtAFlPXFTCZIq5KOi253d1tdOzzuN0aF7Wd4SBV
 U92L0p9RSuDJgBoa4HPIsnl8N+BfS+VRn03OmPKOGPRkpcFgnEb0Q91GX9jC8YJpMD0ssjy3huI
 Lx2F6oRb66e6EXPPWUQYAsPxt1Uu0OwG+xVPxRXDGl/Whokm0INk0kELo0dhTL1nIx1S8VGQv+Z
 ewGF6r0CZvIDYM=
X-Received: by 2002:a53:a44c:0:b0:672:99e1:11ce with SMTP id
 956f58d0204a3-672ed48ecf5mr4742337d50.107.1790692315051; 
 Tue, 29 Sep 2026 07:31:55 -0700 (PDT)
X-Received: by 2002:a53:a44c:0:b0:672:99e1:11ce with SMTP id
 956f58d0204a3-672ed48ecf5mr4742297d50.107.1790692314344; Tue, 29 Sep 2026
 07:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-5-jsnow@redhat.com>
 <87bj9gxmiw.fsf@pond.sub.org>
In-Reply-To: <87bj9gxmiw.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Sep 2026 10:31:42 -0400
X-Gm-Features: AclHuK8VT7pOP9Ev7qcKKRAdfby7S_vJcyRKahKO9PBwkchjsAj75Rlpv2FMiw4
Message-ID: <CAFn=p-ZCq09nrc=O7jCay9JJ9c9eopMzQmDqHcdS8j=kWtVa_w@mail.gmail.com>
Subject: Re: [PATCH 04/14] qapi/parser: enforce doc block section ordering
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex@shazbot.org>, Kashyap Chamarthy <kchamart@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004ca787065ca00bc0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000004ca787065ca00bc0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, 8:36=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Enforce the relative ordering of "Intro", "Members", "Features",
> > "Errors" and "Returns" sections.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.rst | 19 +++++++++++------
> >  scripts/qapi/parser.py       | 41 ++++++++++++++++++++++++++++++------
> >  2 files changed, 48 insertions(+), 12 deletions(-)
> >
> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rs=
t
> > index 3ac1c2dae18..29e9c5a3da6 100644
> > --- a/docs/devel/qapi-code-gen.rst
> > +++ b/docs/devel/qapi-code-gen.rst
> > @@ -985,12 +985,19 @@ When documentation is required (see pragma_
> 'doc-required'), every
> >  definition must have documentation.
> >
> >  Definition documentation starts with a description naming the
> > -definition with an optional indented overview (the "intro"),
> > -:ref:`descriptions <doc-descrip>` of each argument (for commands and
> > -events), member (for structs and unions), branch (for alternates), or
> > -value (for enums), :ref:`feature descriptions <doc-feat>` of each
> > -feature (if any), and finally optional :ref:`tagged sections
> > -<doc-tagged>`.
> > +definition with an optional indented overview (the "intro").
> > +
> > +The introduction is followed by :ref:`descriptions <doc-descrip>` of
> > +each argument (for commands and events), member (for structs and
> > +unions), branch (for alternates), or value (for enums).
> > +
> > +:ref:`Tagged sections <doc-tagged>` follow in order: Returns (for
> > +commands), Errors (for commands), and lastly :ref:`feature
> > +descriptions <doc-feat>` if applicable.
>
> *Some* of the tagged sections do.
>
> Does this document still need the concept "tagged section"?
>

I doubt it does, beyond an explanation of common syntax. Happy to hear
suggestions...

We could also stand to change some of the method names like "ensure
untagged section" could become "ensure details", and the like.

tagged vs untagged has become increasingly non-meaningful.


> > +
> > +Definition documentation concludes with rST-formatted detail
> > +paragraphs (including examples, notes, &c), and finally an optional
> > +"Since" tagged section at the very end.
> >
> >  .. _doc-descrip:
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index fe284a3f866..94a60a23482 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -545,6 +545,28 @@ def get_doc(self) -> 'QAPIDoc':
> >              doc.all_sections.append(QAPIDoc.Section(info,
> QAPIDoc.Kind.INTRO))
> >              line =3D self.get_doc_indented(doc)
> >              no_more_args =3D False
> > +            last_ordered_section =3D QAPIDoc.Kind.INTRO
> > +
> > +            def _tag_check(this: Union['QAPIDoc.Kind', str]) -> None:
> > +                nonlocal last_ordered_section
> > +                if isinstance(this, str):
> > +                    this =3D QAPIDoc.Kind.from_string(this)
>
> Simpler, I think: require a .Kind argument, and do the conversion from
> string in the one caller that needs it.
>

You're right.


> > +
> > +                if this in (QAPIDoc.Kind.TODO, QAPIDoc.Kind.SINCE,
> > +                            QAPIDoc.Kind.DETAILS):
> > +                    return
> > +
> > +                if this.value < last_ordered_section.value:
> > +                    raise QAPIParseError(
> > +                        self,
> > +                        f"'{this}' section cannot appear after "
> > +                        f"'{last_ordered_section}' section, please
> re-order "
> > +                        "the sections and adjust phrasing as necessary
> to "
> > +                        "ensure consistent documentation flow between
> the "
> > +                        "source code and the rendered HTML manual"
> > +                    )
>
> That's a loooong error message.  It actually consists of the error
> proper and advice on how to correct it.  Please use
>
>     "<error>\n<advice>"
>
> like we do in expr.py's check_keys(), parser.py's
> ._validate_doc_line_format(), and schema.py's ._def_definition().  Yes,
> the embedded newline is a bit of a hack.
>

ACK.


> > +
> > +                last_ordered_section =3D this
> >
> >              while line is not None:
> >                  # Blank lines
> > @@ -558,6 +580,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                      if doc.has_features:
> >                          raise QAPIParseError(
> >                              self, "duplicated 'Features:' line")
> > +                    _tag_check(QAPIDoc.Kind.FEATURE)
> >                      self.accept(False)
> >                      line =3D self.get_doc_line()
> >                      while line =3D=3D '':
> > @@ -581,6 +604,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                              self,
> >                              "description of '@%s:' follows a section"
> >                              % match.group(1))
> > +                    _tag_check(QAPIDoc.Kind.MEMBER)
> >                      while (line is not None
> >                             and (match :=3D
> self._match_at_name_colon(line))):
> >                          doc.new_argument(self.info, match.group(1))
> > @@ -621,6 +645,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                          )
> >                          raise QAPIParseError(self, emsg)
> >
> > +                    _tag_check(match.group(1))
>
> This is the caller that needs it.
>

Yep.


> >                      doc.new_tagged_section(
> >                          self.info,
> >                          QAPIDoc.Kind.from_string(match.group(1))
> > @@ -632,6 +657,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                      no_more_args =3D True
> >                  else:
> >                      # plain paragraph(s)
> > +                    _tag_check(QAPIDoc.Kind.DETAILS)
> >                      doc.ensure_untagged_section(self.info)
> >                      doc.append_line(line)
> >                      line =3D self.get_doc_paragraph(doc)
> > @@ -674,14 +700,17 @@ class QAPIDoc:
> >      """
> >
> >      class Kind(enum.Enum):
> > -        DETAILS =3D 0
> > +        # The order here is the order in which sections must appear in
> > +        # source code; with the exception of 'TODO' which may appear
> > +        # anywhere but is treated as a comment.
> > +        INTRO =3D 0
> >          MEMBER =3D 1
> > -        FEATURE =3D 2
> > -        RETURNS =3D 3
> > -        ERRORS =3D 4
> > -        SINCE =3D 5
> > +        RETURNS =3D 2
> > +        ERRORS =3D 3
> > +        FEATURE =3D 4
> > +        DETAILS =3D 5
> >          TODO =3D 6
> > -        INTRO =3D 7
> > +        SINCE =3D 7
> >
> >          @staticmethod
> >          def from_string(kind: str) -> 'QAPIDoc.Kind':
>
> Missing: negative test for the new error.
>

Yep. If you are overall pleased with this change enough (pending nits),
I'll add the tests now.

>

--0000000000004ca787065ca00bc0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2026, 8:36=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Enforce the relative ordering of &quot;Intro&quot;, &quot;Members&quot=
;, &quot;Features&quot;,<br>
&gt; &quot;Errors&quot; and &quot;Returns&quot; sections.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/devel/qapi-code-gen.rst | 19 +++++++++++------<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 41 ++++++++++=
++++++++++++++++++++------<br>
&gt;=C2=A0 2 files changed, 48 insertions(+), 12 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.r=
st<br>
&gt; index 3ac1c2dae18..29e9c5a3da6 100644<br>
&gt; --- a/docs/devel/qapi-code-gen.rst<br>
&gt; +++ b/docs/devel/qapi-code-gen.rst<br>
&gt; @@ -985,12 +985,19 @@ When documentation is required (see pragma_ &#39=
;doc-required&#39;), every<br>
&gt;=C2=A0 definition must have documentation.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Definition documentation starts with a description naming the<br=
>
&gt; -definition with an optional indented overview (the &quot;intro&quot;)=
,<br>
&gt; -:ref:`descriptions &lt;doc-descrip&gt;` of each argument (for command=
s and<br>
&gt; -events), member (for structs and unions), branch (for alternates), or=
<br>
&gt; -value (for enums), :ref:`feature descriptions &lt;doc-feat&gt;` of ea=
ch<br>
&gt; -feature (if any), and finally optional :ref:`tagged sections<br>
&gt; -&lt;doc-tagged&gt;`.<br>
&gt; +definition with an optional indented overview (the &quot;intro&quot;)=
.<br>
&gt; +<br>
&gt; +The introduction is followed by :ref:`descriptions &lt;doc-descrip&gt=
;` of<br>
&gt; +each argument (for commands and events), member (for structs and<br>
&gt; +unions), branch (for alternates), or value (for enums).<br>
&gt; +<br>
&gt; +:ref:`Tagged sections &lt;doc-tagged&gt;` follow in order: Returns (f=
or<br>
&gt; +commands), Errors (for commands), and lastly :ref:`feature<br>
&gt; +descriptions &lt;doc-feat&gt;` if applicable.<br>
<br>
*Some* of the tagged sections do.<br>
<br>
Does this document still need the concept &quot;tagged section&quot;?<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I doub=
t it does, beyond an explanation of common syntax. Happy to hear suggestion=
s...</div><div dir=3D"auto"><br></div><div dir=3D"auto">We could also stand=
 to change some of the method names like &quot;ensure untagged section&quot=
; could become &quot;ensure details&quot;, and the like.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">tagged vs untagged has become increasingly=
 non-meaningful.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +<br>
&gt; +Definition documentation concludes with rST-formatted detail<br>
&gt; +paragraphs (including examples, notes, &amp;c), and finally an option=
al<br>
&gt; +&quot;Since&quot; tagged section at the very end.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 .. _doc-descrip:<br>
&gt;=C2=A0 <br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index fe284a3f866..94a60a23482 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -545,6 +545,28 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.all_sections.appen=
d(QAPIDoc.Section(info, QAPIDoc.Kind.INTRO))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D self.get_doc_=
indented(doc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_more_args =3D False=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_ordered_section =3D QA=
PIDoc.Kind.INTRO<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def _tag_check(this: Union[=
&#39;QAPIDoc.Kind&#39;, str]) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nonlocal last=
_ordered_section<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance=
(this, str):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 this =3D QAPIDoc.Kind.from_string(this)<br>
<br>
Simpler, I think: require a .Kind argument, and do the conversion from<br>
string in the one caller that needs it.<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">You&#39;re right.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_cont=
ainer"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if this in (Q=
APIDoc.Kind.TODO, QAPIDoc.Kind.SINCE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPIDoc.Kind.DETAILS):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if this.value=
 &lt; last_ordered_section.value:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 raise QAPIParseError(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 self,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 f&quot;&#39;{this}&#39; section cannot appear after &quot;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 f&quot;&#39;{last_ordered_section}&#39; section, please re-o=
rder &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;the sections and adjust phrasing as necessary to &quot=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;ensure consistent documentation flow between the &quot=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;source code and the rendered HTML manual&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 )<br>
<br>
That&#39;s a loooong error message.=C2=A0 It actually consists of the error=
<br>
proper and advice on how to correct it.=C2=A0 Please use<br>
<br>
=C2=A0 =C2=A0 &quot;&lt;error&gt;\n&lt;advice&gt;&quot;<br>
<br>
like we do in expr.py&#39;s check_keys(), parser.py&#39;s<br>
._validate_doc_line_format(), and schema.py&#39;s ._def_definition().=C2=A0=
 Yes,<br>
the embedded newline is a bit of a hack.<br></blockquote></div></div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">ACK.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_ordered_=
section =3D this<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while line is not None=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Blank =
lines<br>
&gt; @@ -558,6 +580,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if doc.has_features:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self, &quot;duplicated &#39;Features:&#3=
9; line&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 _tag_check(QAPIDoc.Kind.FEATURE)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 self.accept(False)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 line =3D self.get_doc_line()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 while line =3D=3D &#39;&#39;:<br>
&gt; @@ -581,6 +604,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;description of &#39;@%s:&#39; foll=
ows a section&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 % match.group(1))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 _tag_check(QAPIDoc.Kind.MEMBER)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 while (line is not None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and (match :=3D self._match_at_name_colon=
(line))):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 doc.new_argument(<a href=3D"http://self.info" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">self.info</a>, match.group(1))<br>
&gt; @@ -621,6 +645,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(self, emsg)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 _tag_check(match.group(1))<br>
<br>
This is the caller that needs it.<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Yep.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 doc.new_tagged_section(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer norefer=
rer" target=3D"_blank">self.info</a>,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 QAPIDoc.Kind.from_string(match.group(1))<br>
&gt; @@ -632,6 +657,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 no_more_args =3D True<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # plain paragraph(s)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 _tag_check(QAPIDoc.Kind.DETAILS)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 doc.ensure_untagged_section(<a href=3D"http://self.info" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">self.info</a>)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 doc.append_line(line)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 line =3D self.get_doc_paragraph(doc)<br>
&gt; @@ -674,14 +700,17 @@ class QAPIDoc:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 class Kind(enum.Enum):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 DETAILS =3D 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # The order here is the order in which se=
ctions must appear in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # source code; with the exception of &#39=
;TODO&#39; which may appear<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # anywhere but is treated as a comment.<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 INTRO =3D 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MEMBER =3D 1<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 FEATURE =3D 2<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 RETURNS =3D 3<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ERRORS =3D 4<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 SINCE =3D 5<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 RETURNS =3D 2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ERRORS =3D 3<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 FEATURE =3D 4<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DETAILS =3D 5<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TODO =3D 6<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 INTRO =3D 7<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 SINCE =3D 7<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @staticmethod<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def from_string(kind: str) -&gt; &#3=
9;QAPIDoc.Kind&#39;:<br>
<br>
Missing: negative test for the new error.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Yep. If you are overall pleased wi=
th this change enough (pending nits), I&#39;ll add the tests now.</div><div=
 dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"></blockquote></div></div></div>

--0000000000004ca787065ca00bc0--


