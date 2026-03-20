Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58251099B28
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 17:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3dql-0000H6-HK; Fri, 20 Mar 2026 13:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3dqg-0000AB-CK
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 13:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3dqd-0000Sk-OX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 13:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774028479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azue2QjovRAK6mOomccjm9Z+pXESCV5HnSjsGQTqbtY=;
 b=GLeVKTml9AqMGf+8UChQyic5SC8HGEAK+TxJoTW7bjKiFjdWAjGVk/IFaGy9a0vyFy4NOy
 cOmukh9fvtXsdByhNKI2HJIseJifWazjhzT6pZySfSBsDBXGwnRtIjsvOVHrnwdUUYvloR
 /5mctvctkdWMkAKpgNt/pH1wnFf+8cc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-jnYTInRbOPqMj7m7JS7kPQ-1; Fri, 20 Mar 2026 13:41:07 -0400
X-MC-Unique: jnYTInRbOPqMj7m7JS7kPQ-1
X-Mimecast-MFC-AGG-ID: jnYTInRbOPqMj7m7JS7kPQ_1774028462
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5091782ab06so105889931cf.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 10:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028461; cv=none;
 d=google.com; s=arc-20240605;
 b=XmcP7ERNpVDonYm6zis0eo2k2GbeBa+ULTBCaJC0bm8UMfP3AWQW+kXfkNJWBNIl/R
 ZfHMu63Z5V7tCArQ0LmvpdfToxgolDZuJ1PA6s1+s2YZ5ZIuLsY+CJR2N1eqICcH0Csa
 m88im+xZZQMeaMFKl3JpqbL7K5tXuSMdiG1FrJMHeOaY32C+h6PrIGkXsVuF++plRZLU
 uGgOUIYSggUVvvsx8WtF3FagnOM+JOFk/Qkq9YSl2/DdUmVEV7aB6WShkjsvrqKAmidW
 8JNZSoibRXa1r8WwGnxFwEJf4R7yBv2mCqNYqYJtAahS41vbgQKZZ2JtFA1ieDzUvTgp
 VtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=azue2QjovRAK6mOomccjm9Z+pXESCV5HnSjsGQTqbtY=;
 fh=ITVUHrDuK24wfFWcPHAMT7QsL3mgm65a7A/rtIt/55A=;
 b=QIF7W21/k6NbYDHNJqv1uZvIUSkwxd3tPetobKPosuoldFcfCCulVCvv9yZ0Vg2+XA
 D2kdF6RbQu1w9NSQHSC7S+uDbaG6PEk1T1F+dlMduKEk+dO2VrAhiajLqFrBza+XINqL
 mRX09rGNKEmthZZB2veJb5sc7MDqqrhbWRrbXsy6zidBDROps/2+O5Y9U7xKXYrQhiwO
 5cjnj9V/j8oN8Bi+0hK5sgcWDq7W2H1OlVmif6Hy11kK/KH5OP8Q6/1jStfcHcIHbocr
 MRavIKvMR1Pb7s5IH1fUfgzEKNK13vlPDFXEy2pp2iXNnwaSw7ZoPAVxH94h/NeXBwgX
 ZpMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774028461; x=1774633261; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=azue2QjovRAK6mOomccjm9Z+pXESCV5HnSjsGQTqbtY=;
 b=EtOm1wxtllkqAZoUL6d0qtkMJbJ9maUL24ZmdqIS+dNYfjVD+hAUrqCz7qcmNo7igh
 B6Hf1nm6AK4hns9xxh6nSgD1fKjP87xb+Kc3MU5BJAmvy6twxKh5m6+ifww2ywHOaXsa
 DRfkK5Iu+FSoqe42NJ0rIe3DiMLvLsXesGRu981ujMy23EqYOFdtt16VgHjMzENg0G2V
 RsFkqWH4XMnEm/YlYq6JdiDxhds0hkWdYEQe6wNcxBPQfDWC6hmmx170BUjpVvd+7SKR
 xIhBhWqw+zR7QrK+Vmoo6D9hXxVMB8Kal9nKWZTDjaVWIJGSGsKhjsldtNgoKJ5bM8bj
 m4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774028461; x=1774633261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azue2QjovRAK6mOomccjm9Z+pXESCV5HnSjsGQTqbtY=;
 b=c971aA1YEeYfuOxsf/FKN/nSWn/0t01Qcu9lzpcqSkeRm5qGVpaOwhcr/QRu7A80nD
 lj+i9OKQfSwNQH485nhZcy5byIpG7LRp+rWbat2vC5qqKtXWtp9KikbOwtCvIIBBEgiq
 AAbfVssF0f05nrKIbH5p3pTNSxP+GcfjddojwRCZUCpebhsdbIvLwJQj5jYXdYqvaue8
 U6gBRqFoxPsfQYapZfxlvbJXIgf8rMkOIZG4keQo4Q/V4mwqhStoRTmYxxi4dovpf7ha
 TRcyI9vnBpZ89f0Nkhgf720Dn1ZDjlQq0Sr+BPtArzaNVyqdwhedyVGY0MPBCsOyXZ4s
 +Tpg==
X-Gm-Message-State: AOJu0YxiAPIp2SkkizSKEL0Jh5vEb4XFOkYeYosR3J4/dECNFnSLcGIp
 ISVen/JvNOTCXWN+TthFIhSA+uM0UE8asflX+JUl4a9SOzpqqN7SbZyAFgskA8u8hQqRIwJt/IV
 NF76Jivzi9o5LJ451JgGSIz29wn8trUjNFDe630/CtO9NscSMMbT8WqRYzL2hE7XevMR+1ya/Pw
 u3JvQDcZpLBZYUlVuOslmbrtqR/6LuQBA=
X-Gm-Gg: ATEYQzzEOxqS33Z48yEkUKo2PYBNQElbVuwvTwRfddgjC+TGDH2LyLHtjyX1a5a5GJR
 xHJw5BOAmObxW/71zH2tLxjmU2z8G5NwlQAaH9t65kmgRcEILo3k8IVkWItmpWC6MIGRxkSR3Lw
 IWH4SLCjlkeevsFZv+0McAzRm2+ig+H3zdyLm1E7faFVAGQhmywyUWJpub43EKfjgJrNfm9Y6RD
 zTc5+YONmneTs3ZZHrwKkrs4oRgoXs+2QVufQ==
X-Received: by 2002:ac8:7dc5:0:b0:4ee:1b0e:861a with SMTP id
 d75a77b69052e-50b373bfb1amr58740361cf.13.1774028460835; 
 Fri, 20 Mar 2026 10:41:00 -0700 (PDT)
X-Received: by 2002:ac8:7dc5:0:b0:4ee:1b0e:861a with SMTP id
 d75a77b69052e-50b373bfb1amr58739661cf.13.1774028460199; Fri, 20 Mar 2026
 10:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-3-jsnow@redhat.com>
 <87h5qa7joo.fsf@pond.sub.org>
In-Reply-To: <87h5qa7joo.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 20 Mar 2026 13:40:48 -0400
X-Gm-Features: AaiRm50-YajQg5mX9dQkxCAtVa6KUF58Obs4cUy6u365JjF87L-rMxl38GD6JDM
Message-ID: <CAFn=p-bU08juAbYaXPheforOU+4se-MZY9PK4Hr7NSVLdAYt2A@mail.gmail.com>
Subject: Re: [PATCH 2/8] qapi: prohibit 'details' sections between tagged
 sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003121c5064d7830d9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000003121c5064d7830d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026, 8:46=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch prohibits plain documentation sections from appearing betwee=
n
> > "tagged" sections. The two existing uses of this pattern are patched
> > out.
>
> One real use, and one just for test coverage.
>
> > This is being done primarily to ensure consistency between the source
> > documents and the final, rendered HTML output. Because
> > member/feature/returns/error sections will always appear in a visually
> > grouped element in the HTML output, prohibiting plain paragraphs betwee=
n
> > those sections ensures ordering consistency between source and the fina=
l
> > render.
>
> Is consistency an actual problem being fixed, or a future problem being
> avoided?  I'm guessing the latter, based on my review of qom.json below.
>

With just one actual use, it's *mostly* avoiding future problems. It does
correct one instance in the rendered HTML of a plain text paragraph
interrupting the tabular fields, which is not a "bug" per se but a visual
inconsistency I wish to eliminate.

The problem is minimal now, but intensifies when considering inlining.
Prohibiting the insertion of any section into the "tabular region" helps
ensure consistent, good looking HTML manual output.

A goal is for source order to match rendered order. Rendered order looks
best with all tabular elements grouped together without root-level
paragraphs interrupting them.

Thus, the desire to restrict source order.

(i.e. we allow only one intro section and only one details section.)



> > Additionally, prohibiting such "middle" text paragraphs allows us to
> > classify all plain text sections as either "intro" or "details" section=
s,
> > because these sections must either appear before structured/tagged
> > sections ("intro") or afterwards ("details").
>
> Huh?
>
> The previous patch already classified all plain text sections as either
> INTRO or DETAILS.
>
> I think the paragraph would make sense if this patch came before the
> previous one.
>

Mmm.

The previous patch is confusingly worded and I didn't do better here.

Previous patch categorizes all plaintext sections as intro or details, but
technically allows multiple details sections.

This patch enforces that we only have one.

(...I think. Currently not clear on how TODO and Since behave with this
logic. Maybe we end up with multiple details sections interrupted only by
non-rendered sections... Edit: yes, you find such a case below.)


> > This keeps the inlining algorithm simpler with fewer "splice" points
> > when merging multiple documentation blocks.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/qom.json                   |  4 ++--
> >  scripts/qapi/parser.py          | 17 +++++++++++++++++
> >  tests/qapi-schema/doc-good.json |  4 ++--
> >  tests/qapi-schema/doc-good.out  |  4 ++--
> >  tests/qapi-schema/doc-good.txt  |  8 ++++----
> >  5 files changed, 27 insertions(+), 10 deletions(-)
> >
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index c653248f85d..1b47abd44e9 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -243,12 +243,12 @@
> >  #
> >  # @typename: the type name of an object
> >  #
> > +# Returns: a list describing object properties
> > +#
> >  # .. note:: Objects can create properties at runtime, for example to
> >  #    describe links between different devices and/or objects.  These
> >  #    properties are not included in the output of this command.
> >  #
> > -# Returns: a list describing object properties
> > -#
> >  # Since: 2.12
> >  ##
> >  { 'command': 'qom-list-properties',
>
> Rendered documentation before the patch:
>
>     Command qom-list-properties (Since: 2.12)
>
>        List properties associated with a QOM object.
>
>        Arguments:
>           * typename (string) -- the type name of an object
>
>        Note:
>
>          Objects can create properties at runtime, for example to describ=
e
>          links between different devices and/or objects.  These propertie=
s
>          are not included in the output of this command.
>
>        Return:
>           [ObjectPropertyInfo] -- a list describing object properties
>
> Afterwards:
>
>     Command qom-list-properties (Since: 2.12)
>
>        List properties associated with a QOM object.
>
>        Arguments:
>           * typename (string) -- the type name of an object
>
>        Return:
>           [ObjectPropertyInfo] -- a list describing object properties
>
>        Note:
>
>          Objects can create properties at runtime, for example to describ=
e
>          links between different devices and/or objects.  These propertie=
s
>          are not included in the output of this command.
>
> Fine.
>
> [Skipping the Python code in my first pass...]
>
> > diff --git a/tests/qapi-schema/doc-good.json
> b/tests/qapi-schema/doc-good.json
> > index fac13425b72..9103fed472e 100644
> > --- a/tests/qapi-schema/doc-good.json
> > +++ b/tests/qapi-schema/doc-good.json
> > @@ -165,12 +165,12 @@
> >  # @cmd-feat1: a feature
> >  # @cmd-feat2: another feature
> >  #
> > -# .. note:: @arg3 is undocumented
> > -#
> >  # Returns: @Object
> >  #
> >  # Errors: some
> >  #
> > +# .. note:: @arg3 is undocumented
> > +#
> >  # TODO: frobnicate
> >  #
> >  # .. admonition:: Notes
> > diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> > index 04e29e8d50f..6a0167ad580 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -175,12 +175,12 @@ description starts on the same line
> >  a feature
> >      feature=3Dcmd-feat2
> >  another feature
> > -    section=3DDetails
> > -.. note:: @arg3 is undocumented
> >      section=3DReturns
> >  @Object
> >      section=3DErrors
> >  some
> > +    section=3DDetails
> > +.. note:: @arg3 is undocumented
> >      section=3DTodo
> >  frobnicate
> >      section=3DDetails
>
> The Details section is still between tagged sections.  The code
> prohibiting it must have a hole :)
>

Well, there's the answer to my above self-musing on Since/TODO...
After reading my replies, is it clear what I am concerned with
accomplishing?

If not, the goal for *rendered output* is this:

1. Intro (literally and truly only ever one section, both in the QAPIDoc
sense and in the rendered HTML output sense)

2. All tabular sections (members, returns, Errors, features)

3. Details

You'll notice I didn't bother specifying Since and TODO here. TODO is
removed from rendered output, so I don't actually care where it goes in the
QAPIDoc source list.

Since is also removed from the flow in the HTML output, so I also don't
care about it. (However, you requested that it specifically go last, so I
do address that in this series and later prohibit any details sections from
appearing after a Since marker.)

The true "semantic" goals here are two things:

(1) Prohibiting free text from appearing within the tabular section region

(2) Delineating free text that appears before the tabular region from free
text that appears after it.

I apologize for conflating "section order" with "rendered section order".

You are right to point out that these sections i do not care about may, in
the source, impact the classification of other sections and the total
number thereof.

(i.e. TODO is enough to terminate the intro without an explicit details
marker, and Since/TODO can create multiple details sections after the
tabular region. They are merged visually but not in the QAPIDoc sections
list. I don't consider this a bug per se, but it is the source of a lot of
confusion here in this series when I am eliding that technicality.)


> > diff --git a/tests/qapi-schema/doc-good.txt
> b/tests/qapi-schema/doc-good.txt
> > index 74b73681d32..ded699dd596 100644
> > --- a/tests/qapi-schema/doc-good.txt
> > +++ b/tests/qapi-schema/doc-good.txt
> > @@ -120,16 +120,16 @@ Command cmd (Since: 2.10)
> >
> >        * **cmd-feat2** -- another feature
> >
> > -   Note:
> > -
> > -     "arg3" is undocumented
> > -
> >     Return:
> >        "Object" -- "Object"
> >
> >     Errors:
> >        some
> >
> > +   Note:
> > +
> > +     "arg3" is undocumented
> > +
> >     Notes:
> >
> >     * Lorem ipsum dolor sit amet
>
>

--0000000000003121c5064d7830d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2026, 8:46=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch prohibits plain documentation sections from appearing betwe=
en<br>
&gt; &quot;tagged&quot; sections. The two existing uses of this pattern are=
 patched<br>
&gt; out.<br>
<br>
One real use, and one just for test coverage.<br>
<br>
&gt; This is being done primarily to ensure consistency between the source<=
br>
&gt; documents and the final, rendered HTML output. Because<br>
&gt; member/feature/returns/error sections will always appear in a visually=
<br>
&gt; grouped element in the HTML output, prohibiting plain paragraphs betwe=
en<br>
&gt; those sections ensures ordering consistency between source and the fin=
al<br>
&gt; render.<br>
<br>
Is consistency an actual problem being fixed, or a future problem being<br>
avoided?=C2=A0 I&#39;m guessing the latter, based on my review of qom.json =
below.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">With just one actual use, it&#39;s *mostly* avoiding future problems.=
 It does correct one instance in the rendered HTML of a plain text paragrap=
h interrupting the tabular fields, which is not a &quot;bug&quot; per se bu=
t a visual inconsistency I wish to eliminate.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">The problem is minimal now, but intensifies when cons=
idering inlining. Prohibiting the insertion of any section into the &quot;t=
abular region&quot; helps ensure consistent, good looking HTML manual outpu=
t.</div><div dir=3D"auto"><br></div><div dir=3D"auto">A goal is for source =
order to match rendered order. Rendered order looks best with all tabular e=
lements grouped together without root-level paragraphs interrupting them.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Thus, the desire to restr=
ict source order.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
(i.e. we allow only one intro section and only one details section.)</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
&gt; Additionally, prohibiting such &quot;middle&quot; text paragraphs allo=
ws us to<br>
&gt; classify all plain text sections as either &quot;intro&quot; or &quot;=
details&quot; sections,<br>
&gt; because these sections must either appear before structured/tagged<br>
&gt; sections (&quot;intro&quot;) or afterwards (&quot;details&quot;).<br>
<br>
Huh?<br>
<br>
The previous patch already classified all plain text sections as either<br>
INTRO or DETAILS.<br>
<br>
I think the paragraph would make sense if this patch came before the<br>
previous one.<br></blockquote></div></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Mmm.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The pr=
evious patch is confusingly worded and I didn&#39;t do better here.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Previous patch categorizes all =
plaintext sections as intro or details, but technically allows multiple det=
ails sections.</div><div dir=3D"auto"><br></div><div dir=3D"auto">This patc=
h enforces that we only have one.=C2=A0</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">(...I think. Currently not clear on how TODO and Since beha=
ve with this logic. Maybe we end up with multiple details sections interrup=
ted only by non-rendered sections... Edit: yes, you find such a case below.=
)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; This keeps the inlining algorithm simpler with fewer &quot;splice&quot=
; points<br>
&gt; when merging multiple documentation blocks.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/qom.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 17 ++=
+++++++++++++++<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.json |=C2=A0 4 ++--<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out=C2=A0 |=C2=A0 4 ++--<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.txt=C2=A0 |=C2=A0 8 ++++----<br>
&gt;=C2=A0 5 files changed, 27 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/qom.json b/qapi/qom.json<br>
&gt; index c653248f85d..1b47abd44e9 100644<br>
&gt; --- a/qapi/qom.json<br>
&gt; +++ b/qapi/qom.json<br>
&gt; @@ -243,12 +243,12 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @typename: the type name of an object<br>
&gt;=C2=A0 #<br>
&gt; +# Returns: a list describing object properties<br>
&gt; +#<br>
&gt;=C2=A0 # .. note:: Objects can create properties at runtime, for exampl=
e to<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 describe links between different devices and/or o=
bjects.=C2=A0 These<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 properties are not included in the output of this=
 command.<br>
&gt;=C2=A0 #<br>
&gt; -# Returns: a list describing object properties<br>
&gt; -#<br>
&gt;=C2=A0 # Since: 2.12<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;qom-list-properties&#39;,<br>
<br>
Rendered documentation before the patch:<br>
<br>
=C2=A0 =C2=A0 Command qom-list-properties (Since: 2.12)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0List properties associated with a QOM object.<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Arguments:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * typename (string) -- the type name of =
an object<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Note:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Objects can create properties at runtime,=
 for example to describe<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0links between different devices and/or ob=
jects.=C2=A0 These properties<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0are not included in the output of this co=
mmand.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ObjectPropertyInfo] -- a list describin=
g object properties<br>
<br>
Afterwards:<br>
<br>
=C2=A0 =C2=A0 Command qom-list-properties (Since: 2.12)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0List properties associated with a QOM object.<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Arguments:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * typename (string) -- the type name of =
an object<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ObjectPropertyInfo] -- a list describin=
g object properties<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Note:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Objects can create properties at runtime,=
 for example to describe<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0links between different devices and/or ob=
jects.=C2=A0 These properties<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0are not included in the output of this co=
mmand.<br>
<br>
Fine.<br>
<br>
[Skipping the Python code in my first pass...]<br>
<br>
&gt; diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-g=
ood.json<br>
&gt; index fac13425b72..9103fed472e 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.json<br>
&gt; +++ b/tests/qapi-schema/doc-good.json<br>
&gt; @@ -165,12 +165,12 @@<br>
&gt;=C2=A0 # @cmd-feat1: a feature<br>
&gt;=C2=A0 # @cmd-feat2: another feature<br>
&gt;=C2=A0 #<br>
&gt; -# .. note:: @arg3 is undocumented<br>
&gt; -#<br>
&gt;=C2=A0 # Returns: @Object<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Errors: some<br>
&gt;=C2=A0 #<br>
&gt; +# .. note:: @arg3 is undocumented<br>
&gt; +#<br>
&gt;=C2=A0 # TODO: frobnicate<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # .. admonition:: Notes<br>
&gt; diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-go=
od.out<br>
&gt; index 04e29e8d50f..6a0167ad580 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.out<br>
&gt; +++ b/tests/qapi-schema/doc-good.out<br>
&gt; @@ -175,12 +175,12 @@ description starts on the same line<br>
&gt;=C2=A0 a feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Dcmd-feat2<br>
&gt;=C2=A0 another feature<br>
&gt; -=C2=A0 =C2=A0 section=3DDetails<br>
&gt; -.. note:: @arg3 is undocumented<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DReturns<br>
&gt;=C2=A0 @Object<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DErrors<br>
&gt;=C2=A0 some<br>
&gt; +=C2=A0 =C2=A0 section=3DDetails<br>
&gt; +.. note:: @arg3 is undocumented<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DTodo<br>
&gt;=C2=A0 frobnicate<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DDetails<br>
<br>
The Details section is still between tagged sections.=C2=A0 The code<br>
prohibiting it must have a hole :)<br></blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Well, there&#39;s the answer to my above =
self-musing on Since/TODO...</div><div dir=3D"auto"></div><div dir=3D"auto"=
>After reading my replies, is it clear what I am concerned with accomplishi=
ng?</div><div dir=3D"auto"><br></div><div dir=3D"auto">If not, the goal for=
 *rendered output* is this:</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">1. Intro (literally and truly only ever one section, both in the QAPIDo=
c sense and in the rendered HTML output sense)</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">2. All tabular sections (members, returns, Errors, f=
eatures)</div><div dir=3D"auto"><br></div><div dir=3D"auto">3. Details</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">You&#39;ll notice I didn&#39=
;t bother specifying Since and TODO here. TODO is removed from rendered out=
put, so I don&#39;t actually care where it goes in the QAPIDoc source list.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Since is also removed f=
rom the flow in the HTML output, so I also don&#39;t care about it. (Howeve=
r, you requested that it specifically go last, so I do address that in this=
 series and later prohibit any details sections from appearing after a Sinc=
e marker.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">The true &quo=
t;semantic&quot; goals here are two things:</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">(1) Prohibiting free text from appearing within the tab=
ular section region</div><div dir=3D"auto"><br></div><div dir=3D"auto">(2) =
Delineating free text that appears before the tabular region from free text=
 that appears after it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
I apologize for conflating &quot;section order&quot; with &quot;rendered se=
ction order&quot;.</div><div dir=3D"auto"><br></div><div dir=3D"auto">You a=
re right to point out that these sections i do not care about may, in the s=
ource, impact the classification of other sections and the total number the=
reof.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(i.e. TODO is enou=
gh to terminate the intro without an explicit details marker, and Since/TOD=
O can create multiple details sections after the tabular region. They are m=
erged visually but not in the QAPIDoc sections list. I don&#39;t consider t=
his a bug per se, but it is the source of a lot of confusion here in this s=
eries when I am eliding that technicality.)</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
&gt; diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-go=
od.txt<br>
&gt; index 74b73681d32..ded699dd596 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.txt<br>
&gt; +++ b/tests/qapi-schema/doc-good.txt<br>
&gt; @@ -120,16 +120,16 @@ Command cmd (Since: 2.10)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * **cmd-feat2** -- another feature<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0Note:<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0&quot;arg3&quot; is undocumented<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0Return:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Object&quot; -- &quot;Object&quot;<br=
>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0Errors:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 some<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0Note:<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;arg3&quot; is undocumented<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0Notes:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0* Lorem ipsum dolor sit amet<br>
<br>
</blockquote></div></div></div>

--0000000000003121c5064d7830d9--


