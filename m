Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494351099B29
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 17:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3dXF-00065f-TP; Fri, 20 Mar 2026 13:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3dXE-00065K-80
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 13:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3dXB-0005R8-4d
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 13:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774027275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vs5HItp1EZJK++4Ft6rwxoFJfkm55x9k5jA0C1EpWIQ=;
 b=bvbb8Pgm7GjTqeJ21TBUkhlpoeuTHq4tpaL/HaaHjwTGMEXqvPzksXD4ozcfyEYciojVQB
 em92KyeGHXJTy//SVVffmUHYf1jNbO40mMNIf8/hzQ3xWRkVhXc+ytHsWM3bmaqfB0sd+Q
 F2K6Kccfy260okbvZbGoUhSB2ww+/ek=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-rkz3S1RVM2iI9ElYg-yFFA-1; Fri, 20 Mar 2026 13:21:13 -0400
X-MC-Unique: rkz3S1RVM2iI9ElYg-yFFA-1
X-Mimecast-MFC-AGG-ID: rkz3S1RVM2iI9ElYg-yFFA_1774027273
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89c4d85d619so64965686d6.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 10:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774027273; cv=none;
 d=google.com; s=arc-20240605;
 b=Y/Enkj+hrUETsTl2howHEj0DsRISGbixOgEYVbe1fGwoC4vvXlrDSG3FkZBf4mEJVj
 Mtsqo8p9WdEgYiBfLqX/kJjX9GFbvzTVWrK989xkyLJLycDNjXL2kFs5BcczH6Q4Sft7
 dqi/vTJ4mX+8Tcfldz1jVsPbg0oeyzk26mBFDW1XWpCWozsZv/1/896UNLi7EZUrJLXw
 CiwRx7i0FRJK4/dQr9Vd94vGX0uBdA04zxUav6qfHHEwwl8Hj7x9NymCEgAef842+Izq
 XQCTOZ14JfeFEEo9KvpUhhxUNsVLvcfvacZ0LWtx1V0gP7GGMPLt6YhO7PTaMxZ2mqU7
 hAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vs5HItp1EZJK++4Ft6rwxoFJfkm55x9k5jA0C1EpWIQ=;
 fh=ITVUHrDuK24wfFWcPHAMT7QsL3mgm65a7A/rtIt/55A=;
 b=B2xl+bFovJNaqMVC9zvs/EeQ5NsUYhhEqvbiEVpw1FVh7oH/JSn/a5s/pWgGckyrra
 oIFmYWdQe1Zuj7XI5/Io9LZf7vnYyCabaqJC/ANgWa135sOWe9z3X9giJYG6RTfui7F5
 JptMfYzW/gWlQLwL7g5Uy9RBFxMVxED0M4IvK1QNozj0C4D0417GrJwapdxEeExVkSm0
 iiwHxaqIrsYowSaa4gQsk15ml6gYf0nH57yTfSV9P9S6f755vHKop5tFu6I2S3X9fwc6
 gzfuJ+siG4Ns8ZcqxmnL1i81fA0AXjnnzuAA1JsbsrY8kiXqVVeupZ/Gd0nIgeLDywI9
 /lmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774027273; x=1774632073; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vs5HItp1EZJK++4Ft6rwxoFJfkm55x9k5jA0C1EpWIQ=;
 b=tY/R5RejA08C1CawlPd/Du/a+8g7l+qpl6ZnrlZHh28S335MvYRY5w6PPR9cBiF2hU
 P5tOusUDiGh/9RBa9n8kCz0MhIkef1NNd3w1gG6IVsIzPkrAaw4ZaOZTn6lXeGaOBqAb
 b71AK9OCG+3iv6J+AFopTmk6xzid9XimDxGaql88bFlv17WALr5+2Yab11WuMPYNMV8Y
 Bc7Q8kXjMNTmTmvdcDMQWLvuL0PD8TAaxAdMGqAsgxlFjQHT/1ENgocmqdCn5ixAm3O6
 hiL+8mr9dMbmtw9Z++YDLVfMPZkBob4Bm5wvZfGOpEzBGUfva8DDXwxNiJrUUGVKlbeE
 GGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774027273; x=1774632073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vs5HItp1EZJK++4Ft6rwxoFJfkm55x9k5jA0C1EpWIQ=;
 b=PVUWQDA/E2bE0TDEZCLCejg7hx4oqX+W0AjGrt8MNNOUrJhVkE4Y6DSmZ4T2msb3x2
 rd8XSSQwN6QrTYfCD3s5rrHlyhxc1orRhZoTANtoUG3JqfdOU2x5n2X0Hwn9k55T6j/5
 0jHhlCAIdmpzaYE8iPmrlKBJOj2q1nApEmglRPr5wpkGI6Wf23phBUZbN9FV4UT50fwU
 wO+AuNZJk6qzDyHjFzXeYsbitGjOFQP+GRE1uhj/kA7h0BkGFAhpF5243KKIpna+/pYT
 uFlMf+0AI5VjeDqLwel5Gb0iRyS4N2VBYWQ9IdcNPsrAWTt8XOQxvGIKPn4v4JguMqf0
 ysKw==
X-Gm-Message-State: AOJu0YxHEvsU/s167ywP+TS58GQocdXAr3M1eOE9EdKrlRBchCwGGtcG
 IvP59OhU1U0VyhL1jvRRydAYnYffu56IR7r21oi41JxxkNcn0bQwP4mcGATk3rz3hlp2vTSON/H
 cVw1uxNCkbaEysZOobxe1lw5ZOMWvtu0CX9sExxAqTMfk7lMTyuR4mqRqLw5MBTHEV6PO2/66d2
 viKtYrQm3eI4r2TPAMjrCos4jR9jeQ5mk=
X-Gm-Gg: ATEYQzwg78cGL69lfnKRZApva2mHkH8waG6UncM3cTPFXT6YskbqRcQxaYKKUVRNFQ6
 DDy0v6cQ0KTXsKz3sz06tOgeE5plAA78F5T6veSchEbgXA5Su5Spj8fFsEbn5ikC/EvD5suNeWG
 c7ExInKHPOBHmrH2YGPCEwI5K16g/Zy/8WrNZ+3tjU+rubAnwVAI0mzMQuWgmCrDFmFxWKX/8sW
 o1wspnDSITqs4HXzItiMRNb9tYcPCntpbwCwQ==
X-Received: by 2002:a05:6214:4b13:b0:89c:869a:ef7d with SMTP id
 6a1803df08f44-89c869af1bfmr48546926d6.40.1774027272448; 
 Fri, 20 Mar 2026 10:21:12 -0700 (PDT)
X-Received: by 2002:a05:6214:4b13:b0:89c:869a:ef7d with SMTP id
 6a1803df08f44-89c869af1bfmr48546306d6.40.1774027271818; Fri, 20 Mar 2026
 10:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-2-jsnow@redhat.com>
 <87se9u7koi.fsf@pond.sub.org>
In-Reply-To: <87se9u7koi.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 20 Mar 2026 13:20:59 -0400
X-Gm-Features: AaiRm52p_OHpKJZKVs7MKap5ijtzwZGtp6JOviZR2HSVWrVYmHQ_4wSc-0J4h04
Message-ID: <CAFn=p-b5uJL8uW_zVg6+30xVVO8MXwD=ukFk-H3UCjT7dHia5g@mail.gmail.com>
Subject: Re: [PATCH 1/8] qapi: differentiate "intro" and "details" sections
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
Content-Type: multipart/alternative; boundary="0000000000005be495064d77e934"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--0000000000005be495064d77e934
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026, 8:24=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch begins distinguishing "Plain" sections as being either
> > "Intro" or "Details" sections for the purpose of knowing when/where/how
> > to inline those sections.
> >
> > The Intro section is always the first section of any doc block. It may
> > be empty or any number of paragraphs. It is interrupted by any other
> > non-plaintext section, i.e.; Members, Features, Errors, Returns, Since,
> > and TODO.
> >
> > The details section, when present, is either the last section or the
> > second-to-last section when a "Since:" section is present. It consists
> > of any plain text in the doc block that follows any named sections if
> > present.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> The commit message explains what kinds INTRO and DETAILS are, but not
> why they're useful.  My guess:
>

Right, my apologies. Leaning on you having some existing knowledge here,
and also going light on details because the series is still obviously in
flux.

Let me elaborate on the motivations here...


> 1. Represent the future "Details:" marker: the plain section before it
> is of kind INTRO, the one afterwards is of kind DETAILS.
>

Yes.


> 2. Future programming convenience?  With just PLAIN, code may have to
> understand the section's context to make decisions, and with INTRO and
> DETAILS is doesn't.
>
> Guess close enough?
>

Pretty much.

Originally, I thought I'd inline things like this:

Intro (child)
Intro (parent)
...other sections...
Details (parent)
Details (child)

Last time we went over this, you mused that there was likely never a
sufficient reason to actually inline the intro. I recall believing and
accepting this.

So functionally what this does for us is:

(1) Explicitly delineate what comes before the tabular section of the docs
(members, Returns, Errors, features) and what comes after.

(2) Explicitly defines what will not be inlined.


> The commit message covers PLAIN sections at the beginning and at the end
> (modulo Since:).  It doesn't cover PLAIN sections between tagged
> sections / member descriptions.  You disallow these in PATCH 2.  You can
> either cover them here, or get rid of them by swapping PATCH 1 and 2.
>

Sure. For now they're separated just to separate concerns in review, but if
you believe both should be all-at-once, that's fine too. I think there's
not a regression by separating it, though. It's just a semantic change from
details meaning "anything after the intro" to "specifically the closing
section". The intermediate meaning exists for only one patch.


> Hmm, is your description of DETAILS accurate?  Looks like it isn't; see
> my review of tests/qapi-schema/doc-good.out below.
>

Whoops, future-think. It winds up being true, but isn't true yet as of this
commit. Well, almost. See below.


> > ---
> >  docs/sphinx/qapidoc.py         |  2 +-
> >  scripts/qapi/parser.py         | 35 +++++++++++++++++++++++-----------
> >  tests/qapi-schema/doc-good.out |  8 ++++----
> >  3 files changed, 29 insertions(+), 16 deletions(-)
>
> [Skipping the Python code in my first pass...]
>
> > diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> > index 04a55072646..04e29e8d50f 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -116,7 +116,7 @@ The _one_ {and only}, description on the same line
> >  Also _one_ {and only}
> >      feature=3Denum-member-feat
> >  a member feature
> > -    section=3DPlain
> > +    section=3DDetails
> >  @two is undocumented
>
> The section containing "@two is undocumented" changes from PLAIN to
> DETAILS.  Doc source:
>
>     ##
>     # @Enum:
>     #
>     # @one: The _one_ {and only}, description on the same line
>     #
>     # Features:
>     # @enum-feat: Also _one_ {and only}
>     # @enum-member-feat: a member feature
>     #
>     # @two is undocumented
>     ##
>
> It is at the end.  Good.
>
> >  doc symbol=3DBase
> >      body=3D
> > @@ -175,7 +175,7 @@ description starts on the same line
> >  a feature
> >      feature=3Dcmd-feat2
> >  another feature
> > -    section=3DPlain
> > +    section=3DDetails
> >  .. note:: @arg3 is undocumented
>
> The section containing "@arg3 is undocumented" changes from PLAIN to
> DETAILS.  Doc source:
>
> Doc source:
>
>     ##
>     # @cmd:
>     #
>     # @arg1:
>     #     description starts on a new line,
>     #     indented
>     #
>     # @arg2: description starts on the same line
>     #     remainder indented differently
>     #
>     # Returns: @Object
>     #
>     # Errors: some
>     #
>     # Features:
>     # @cmd-feat1: a feature
>     # @cmd-feat2: another feature
>     #
>     # .. note:: @arg3 is undocumented
>     #
>     # TODO: frobnicate
>     #
>
> It is *not* at the end.  Is the commit message inaccurate?
>

Ah. I wasn't considering TODO... Since it is a comment I mentally elided it=
.

What I mean to say is that Details is (will be) essentially the last
content section that is actually rendered.

In the HTML, it will always be last if present because both TODO and Since
are actually entirely removed from the flow of the document.

Though as we both point out, what i write is not technically true here. (It
can currently be an intermediate section AND Since is not the only section
that may follow it.)


> >      section=3DReturns
> >  @Object
> > @@ -183,7 +183,7 @@ another feature
> >  some
> >      section=3DTodo
> >  frobnicate
> > -    section=3DPlain
> > +    section=3DDetails
> >  .. admonition:: Notes
> >
> >   - Lorem ipsum dolor sit amet
>     - Ut enim ad minim veniam
>
>     [some section body text elided for brevity...]
>
>    Note::
>        Ceci n'est pas une note
>        section=3DSince
>    2.10
>
> The section starting with the adminition and ending after "Ceci n'est
> pas une note" changes from PLAIN to DETAILS.  Doc source continued:
>
>     # .. admonition:: Notes
>     #
>     #  - Lorem ipsum dolor sit amet
>     #  - Ut enim ad minim veniam
>     #
>     [same text elided...]
>     #
>     # Note::
>     #     Ceci n'est pas une note
>     #
>     # Since: 2.10
>     ##
>
> It is second-to-last, and the last section is SINCE.  Good.
>
> > @@ -216,7 +216,7 @@ If you're bored enough to read this, go see a video
> of boxed cats
> >  a feature
> >      featurec=3Dmd-feat2
> >  another feature
> > -    section=3DPlain
> > +    section=3DDetails
> >  .. qmp-example::
> >
> >     -> "this example"
>
> This one is also at the end.  Good.
>
>

--0000000000005be495064d77e934
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2026, 8:24=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch begins distinguishing &quot;Plain&quot; sections as being e=
ither<br>
&gt; &quot;Intro&quot; or &quot;Details&quot; sections for the purpose of k=
nowing when/where/how<br>
&gt; to inline those sections.<br>
&gt;<br>
&gt; The Intro section is always the first section of any doc block. It may=
<br>
&gt; be empty or any number of paragraphs. It is interrupted by any other<b=
r>
&gt; non-plaintext section, i.e.; Members, Features, Errors, Returns, Since=
,<br>
&gt; and TODO.<br>
&gt;<br>
&gt; The details section, when present, is either the last section or the<b=
r>
&gt; second-to-last section when a &quot;Since:&quot; section is present. I=
t consists<br>
&gt; of any plain text in the doc block that follows any named sections if<=
br>
&gt; present.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
The commit message explains what kinds INTRO and DETAILS are, but not<br>
why they&#39;re useful.=C2=A0 My guess:<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Right, my apologies. Leaning on you =
having some existing knowledge here, and also going light on details becaus=
e the series is still obviously in flux.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Let me elaborate on the motivations here...</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<br>
1. Represent the future &quot;Details:&quot; marker: the plain section befo=
re it<br>
is of kind INTRO, the one afterwards is of kind DETAILS.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<br>
2. Future programming convenience?=C2=A0 With just PLAIN, code may have to<=
br>
understand the section&#39;s context to make decisions, and with INTRO and<=
br>
DETAILS is doesn&#39;t.<br>
<br>
Guess close enough?<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Pretty much.=C2=A0</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Originally, I thought I&#39;d inline things like this:</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Intro (child)</div><div dir=3D=
"auto">Intro (parent)</div><div dir=3D"auto">...other sections...</div><div=
 dir=3D"auto">Details (parent)</div><div dir=3D"auto">Details (child)</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Last time we went over this, =
you mused that there was likely never a sufficient reason to actually inlin=
e the intro. I recall believing and accepting this.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">So functionally what this does for us is:</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">(1) Explicitly delineate what=
 comes before the tabular section of the docs (members, Returns, Errors, fe=
atures) and what comes after.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">(2) Explicitly defines what will not be inlined.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contai=
ner"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
<br>
The commit message covers PLAIN sections at the beginning and at the end<br=
>
(modulo Since:).=C2=A0 It doesn&#39;t cover PLAIN sections between tagged<b=
r>
sections / member descriptions.=C2=A0 You disallow these in PATCH 2.=C2=A0 =
You can<br>
either cover them here, or get rid of them by swapping PATCH 1 and 2.<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sure. =
For now they&#39;re separated just to separate concerns in review, but if y=
ou believe both should be all-at-once, that&#39;s fine too. I think there&#=
39;s not a regression by separating it, though. It&#39;s just a semantic ch=
ange from details meaning &quot;anything after the intro&quot; to &quot;spe=
cifically the closing section&quot;. The intermediate meaning exists for on=
ly one patch.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Hmm, is your description of DETAILS accurate?=C2=A0 Looks like it isn&#39;t=
; see<br>
my review of tests/qapi-schema/doc-good.out below.<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Whoops, future-think. It =
winds up being true, but isn&#39;t true yet as of this commit. Well, almost=
. See below.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"></div=
><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
2 +-<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 35 +++=
++++++++++++++++++++-----------<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out |=C2=A0 8 ++++----<br>
&gt;=C2=A0 3 files changed, 29 insertions(+), 16 deletions(-)<br>
<br>
[Skipping the Python code in my first pass...]<br>
<br>
&gt; diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-go=
od.out<br>
&gt; index 04a55072646..04e29e8d50f 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.out<br>
&gt; +++ b/tests/qapi-schema/doc-good.out<br>
&gt; @@ -116,7 +116,7 @@ The _one_ {and only}, description on the same line=
<br>
&gt;=C2=A0 Also _one_ {and only}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Denum-member-feat<br>
&gt;=C2=A0 a member feature<br>
&gt; -=C2=A0 =C2=A0 section=3DPlain<br>
&gt; +=C2=A0 =C2=A0 section=3DDetails<br>
&gt;=C2=A0 @two is undocumented<br>
<br>
The section containing &quot;@two is undocumented&quot; changes from PLAIN =
to<br>
DETAILS.=C2=A0 Doc source:<br>
<br>
=C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 # @Enum:<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # @one: The _one_ {and only}, description on the same line<br=
>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Features:<br>
=C2=A0 =C2=A0 # @enum-feat: Also _one_ {and only}<br>
=C2=A0 =C2=A0 # @enum-member-feat: a member feature<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # @two is undocumented<br>
=C2=A0 =C2=A0 ##<br>
<br>
It is at the end.=C2=A0 Good.<br>
<br>
&gt;=C2=A0 doc symbol=3DBase<br>
&gt;=C2=A0 =C2=A0 =C2=A0 body=3D<br>
&gt; @@ -175,7 +175,7 @@ description starts on the same line<br>
&gt;=C2=A0 a feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Dcmd-feat2<br>
&gt;=C2=A0 another feature<br>
&gt; -=C2=A0 =C2=A0 section=3DPlain<br>
&gt; +=C2=A0 =C2=A0 section=3DDetails<br>
&gt;=C2=A0 .. note:: @arg3 is undocumented<br>
<br>
The section containing &quot;@arg3 is undocumented&quot; changes from PLAIN=
 to<br>
DETAILS.=C2=A0 Doc source:<br>
<br>
Doc source:<br>
<br>
=C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 # @cmd:<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # @arg1:<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0description starts on a new line,<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0indented<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # @arg2: description starts on the same line<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0remainder indented differently<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Returns: @Object<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Errors: some<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Features:<br>
=C2=A0 =C2=A0 # @cmd-feat1: a feature<br>
=C2=A0 =C2=A0 # @cmd-feat2: another feature<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # .. note:: @arg3 is undocumented<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # TODO: frobnicate<br>
=C2=A0 =C2=A0 #<br>
<br>
It is *not* at the end.=C2=A0 Is the commit message inaccurate?<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Ah. I wasn&#=
39;t considering TODO... Since it is a comment I mentally elided it.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">What I mean to say is that Det=
ails is (will be) essentially the last content section that is actually ren=
dered.</div><div dir=3D"auto"><br></div><div dir=3D"auto">In the HTML, it w=
ill always be last if present because both TODO and Since are actually enti=
rely removed from the flow of the document.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Though as we both point out, what i write is not techni=
cally true here. (It can currently be an intermediate section AND Since is =
not the only section that may follow it.)</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DReturns<br>
&gt;=C2=A0 @Object<br>
&gt; @@ -183,7 +183,7 @@ another feature<br>
&gt;=C2=A0 some<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DTodo<br>
&gt;=C2=A0 frobnicate<br>
&gt; -=C2=A0 =C2=A0 section=3DPlain<br>
&gt; +=C2=A0 =C2=A0 section=3DDetails<br>
&gt;=C2=A0 .. admonition:: Notes<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0- Lorem ipsum dolor sit amet<br>
=C2=A0 =C2=A0 - Ut enim ad minim veniam<br>
<br>
=C2=A0 =C2=A0 [some section body text elided for brevity...]<br>
<br>
=C2=A0 =C2=A0Note::<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Ceci n&#39;est pas une note<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0section=3DSince<br>
=C2=A0 =C2=A02.10<br>
<br>
The section starting with the adminition and ending after &quot;Ceci n&#39;=
est<br>
pas une note&quot; changes from PLAIN to DETAILS.=C2=A0 Doc source continue=
d:<br>
<br>
=C2=A0 =C2=A0 # .. admonition:: Notes<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 #=C2=A0 - Lorem ipsum dolor sit amet<br>
=C2=A0 =C2=A0 #=C2=A0 - Ut enim ad minim veniam<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 [same text elided...]<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Note::<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0Ceci n&#39;est pas une note<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Since: 2.10<br>
=C2=A0 =C2=A0 ##<br>
<br>
It is second-to-last, and the last section is SINCE.=C2=A0 Good.<br>
<br>
&gt; @@ -216,7 +216,7 @@ If you&#39;re bored enough to read this, go see a =
video of boxed cats<br>
&gt;=C2=A0 a feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 featurec=3Dmd-feat2<br>
&gt;=C2=A0 another feature<br>
&gt; -=C2=A0 =C2=A0 section=3DPlain<br>
&gt; +=C2=A0 =C2=A0 section=3DDetails<br>
&gt;=C2=A0 .. qmp-example::<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0-&gt; &quot;this example&quot;<br>
<br>
This one is also at the end.=C2=A0 Good.<br>
<br>
</blockquote></div></div></div>

--0000000000005be495064d77e934--


