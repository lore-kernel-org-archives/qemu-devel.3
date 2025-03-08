Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA31C28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 18:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqyrB-0005EQ-Se; Sat, 08 Mar 2025 13:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqyr9-0005Ds-6J
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 13:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqyr7-0008FL-19
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 13:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741458298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m1ULhmvlEbjc1YFRfnF/ulG4uWSw0gVW6IT0wGx7HQ8=;
 b=Akv7lqujwrBlMPgBHcva6GXiyPWpxVg3gtnTPg7/3Wi/vxhBTjNksM2lZtOOeAwPan9L/Z
 cS1ZWdZaNsUrl8fxay1F3//OSpZLhrujO91605IY8AkGGPNDX3Qh2tRJ50Ja+v4tRTlzrY
 D7sYOVPd/qfiUCtZ8Rj0ZO2ZruIWO4k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-IqjPcH0DPTCTM7aLB1WIcQ-1; Sat, 08 Mar 2025 13:24:57 -0500
X-MC-Unique: IqjPcH0DPTCTM7aLB1WIcQ-1
X-Mimecast-MFC-AGG-ID: IqjPcH0DPTCTM7aLB1WIcQ_1741458296
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fe8c5dbdb0so5140082a91.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 10:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741458296; x=1742063096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m1ULhmvlEbjc1YFRfnF/ulG4uWSw0gVW6IT0wGx7HQ8=;
 b=IcNcB/mQITlzrZPhADThAy33EpTOyT54bwLAfwHR7kqHOOMHxAk4uhzKUSqiHmt1kq
 ydY6rlcLDXQnQUT87104Ia2/tfUQYThugFK/MpIO2Gel3o2CM8gtnjiFFAsyVdBTxK7T
 aTmxgWwASGlaskAIWivWC5QRFN+hE9aUdH7t6SnHBMU2ls9TeGrSn/puwGmdnKgW23mg
 u3MVaf8WgjpXcWg1neuXGonNilD/zvsCsQhzFr5FTzO2qVtnOzo9OTp2QZQE894H1nCB
 ab0q2vv46pqt9YOX4H0/5otJxkWUdpKW0U1Kgqn7jCJnMYricq0Gp0wUSpldT8Z1rIdP
 My7w==
X-Gm-Message-State: AOJu0YyYKraZp69yKO8OMVLr4ENzvU8vkmHfxuK16GLYJ02ud9kxVpc8
 4yKlZksfSJuOEHjDGdVolfgpptc9vCWYpEEt7N2jFzB+ilSFT4N8R1P3Zsa8yqD/OzVyHp8fSxu
 H7UbzkGXC+iSWuD4kuB6If2FGr9xU6ErI1Ty/j4I8wHeT0Ok+5K4S41rrOOOYIS88TuUo/V3bip
 DTKtnnzah10Q3Kj9+11cIXj8Quhac=
X-Gm-Gg: ASbGncsWzvFLPoUDocCaDqFgSqC8cUCDXSdPhTAP5uRIjwBAiuajAjeR94kTjkNXgRk
 gwWOsCgHUI7w7+WWkOK8YM9xRQcyNP3hdsukFcrPnLQ7EIVGEyFpkFnS6gz2Ffd6GW+M7lg==
X-Received: by 2002:a17:90a:ec87:b0:2fe:dd2c:f8e7 with SMTP id
 98e67ed59e1d1-2ff7ce8fa48mr12816179a91.10.1741458295676; 
 Sat, 08 Mar 2025 10:24:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl4cF8ZYxf6Vla+MboD4Tuvs68P4yn6IWDp0SJ9HsJpthzqqOcUM5HHFv3BEzeaIMJ3XTq1o6QphXC7xBOUqs=
X-Received: by 2002:a17:90a:ec87:b0:2fe:dd2c:f8e7 with SMTP id
 98e67ed59e1d1-2ff7ce8fa48mr12816148a91.10.1741458295364; Sat, 08 Mar 2025
 10:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-22-jsnow@redhat.com>
 <87plitm816.fsf@pond.sub.org>
In-Reply-To: <87plitm816.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 8 Mar 2025 13:24:42 -0500
X-Gm-Features: AQ5f1JohnbIKDXieZUJ3K46BbMRLILoudPGIKMsVKHk41YNjJAe6LNbMB4fYlPQ
Message-ID: <CAFn=p-bmoj0pjTufbsH0_93gLpPbgcRDX-NiDerSSyf4iPuWRg@mail.gmail.com>
Subject: Re: [PATCH 21/57] docs/qapi-domain: add :deprecated: directive option
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Harmonie Snow <harmonie@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000163e02062fd8db3d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000163e02062fd8db3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:48=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Although "deprecated" is a feature (and *will* appear in the features
> > list), add a special :deprecated: option to generate an eye-catch that
> > makes this information very hard to miss.
> >
> > (The intent is to modify qapidoc.py to add this option whenever it
> > detects that the features list attached to a definition contains the
> > "deprecated" entry.)
>
> Let me explain it in my own words to make sure I understand.
>
> 1. The transmogrifier emits a :feat: for the feature like for any other.
>    Therefore, the feature is rendered like any other.,
>
> 2. The transmogrifier additionally emits the owning directive with a
>    :deprecated: option.  This gets the eye-catch rendered.
>
> Example:
>
>     Command drive-backup (Since: 1.6)
>  -->    This command is deprecated.
>
>        Start a point-in-time copy of a block device to a new destination.
>        The status of ongoing drive-backup operations can be checked with
>        query-block-jobs where the BlockJobInfo.type field has the value
>        'backup'.  The operation can be stopped before it has completed
>        using the block-job-cancel command.
>
>        Arguments:
>           * The members of "DriveBackup".
>
>        Features:
>  -->      * **deprecated** -- This command is deprecated.  Use "blockdev-
>             backup" instead.
>
> The first arrow marks the eye-catch.  The second marks the normally
> rendered feature.
>
> The eye-catch is redundant with the feature rendering.  Readers may
> nevertheless find an eye-catch useful.
>

Yep, you've got it.


>
> For what it's worth, the Python documentation has deprecation
> information at the end of a definition documentation, together with
> "changed in" information.  Both are colored to catch the eye.  More
> restrained than your eye-catch.  Also uses less space.
>
> Hmm.
>
> Not a blocker.
>

I am extremely happy to take patches to change the layout and formatting
after we merge. I'm providing the canvas, others can paint :)


>
> > -
> >
> > RFC: Technically, this object-level option is un-needed and could be
> > replaced with a standard content-level directive that e.g. qapidoc.py
> > could insert at the beginning of the content block. I've done it here a=
s
> > an option to demonstrate how it would be possible to do.
> >
> > It's a matter of taste for "where" we feel like implementing it.
> >
> > One benefit of doing it this way is that we can create a single
> > containing box to set CSS style options controlling the flow of multipl=
e
> > infoboxes. The other way to achieve that would be to create a directive
> > that allows us to set multiple options instead, e.g.:
> >
> > .. qapi:infoboxes:: deprecated unstable
> >
> > or possibly:
> >
> > .. qapi:infoboxes::
> >    :deprecated:
> >    :unstable:
> >
> > For now, I've left these as top-level QAPI object options. "Hey, it
> works."
>
> Do you intend to drop this part in the final version?
>
> Having the commit message explain paths not taken can be useful.  But
> this is phrased as an RFC, which suggests to me you plan to drop it.
>

Yep. You just hadn't reviewed these yet so I left the commentary in :) Now
that you've seen it, it can go.


>
> > P.S., I outsourced the CSS ;)
>
> Hi, Harmonie!
>
> > Signed-off-by: Harmonie Snow <harmonie@gmail.com>
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--000000000000163e02062fd8db3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 5:48=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Although &quot;deprecated&quot; is a feature (and *will* appear in the=
 features<br>
&gt; list), add a special :deprecated: option to generate an eye-catch that=
<br>
&gt; makes this information very hard to miss.<br>
&gt;<br>
&gt; (The intent is to modify qapidoc.py to add this option whenever it<br>
&gt; detects that the features list attached to a definition contains the<b=
r>
&gt; &quot;deprecated&quot; entry.)<br>
<br>
Let me explain it in my own words to make sure I understand.<br>
<br>
1. The transmogrifier emits a :feat: for the feature like for any other.<br=
>
=C2=A0 =C2=A0Therefore, the feature is rendered like any other.,<br>
<br>
2. The transmogrifier additionally emits the owning directive with a<br>
=C2=A0 =C2=A0:deprecated: option.=C2=A0 This gets the eye-catch rendered.<b=
r>
<br>
Example:<br>
<br>
=C2=A0 =C2=A0 Command drive-backup (Since: 1.6)<br>
=C2=A0--&gt;=C2=A0 =C2=A0 This command is deprecated.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Start a point-in-time copy of a block device to =
a new destination.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0The status of ongoing drive-backup operations ca=
n be checked with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0query-block-jobs where the BlockJobInfo.type fie=
ld has the value<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;backup&#39;.=C2=A0 The operation can be sto=
pped before it has completed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0using the block-job-cancel command.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Arguments:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The members of &quot;DriveBackup&quot;=
.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Features:<br>
=C2=A0--&gt;=C2=A0 =C2=A0 =C2=A0 * **deprecated** -- This command is deprec=
ated.=C2=A0 Use &quot;blockdev-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backup&quot; instead.<br>
<br>
The first arrow marks the eye-catch.=C2=A0 The second marks the normally<br=
>
rendered feature.<br>
<br>
The eye-catch is redundant with the feature rendering.=C2=A0 Readers may<br=
>
nevertheless find an eye-catch useful.<br></blockquote><div><br></div><div>=
Yep, you&#39;ve got it.</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
For what it&#39;s worth, the Python documentation has deprecation<br>
information at the end of a definition documentation, together with<br>
&quot;changed in&quot; information.=C2=A0 Both are colored to catch the eye=
.=C2=A0 More<br>
restrained than your eye-catch.=C2=A0 Also uses less space.<br>
<br>
Hmm.<br>
<br>
Not a blocker.<br></blockquote><div><br></div><div>I am extremely happy to =
take patches to change the layout and formatting after we merge. I&#39;m pr=
oviding the canvas, others can paint :)</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
&gt; -<br>
&gt;<br>
&gt; RFC: Technically, this object-level option is un-needed and could be<b=
r>
&gt; replaced with a standard content-level directive that e.g. qapidoc.py<=
br>
&gt; could insert at the beginning of the content block. I&#39;ve done it h=
ere as<br>
&gt; an option to demonstrate how it would be possible to do.<br>
&gt;<br>
&gt; It&#39;s a matter of taste for &quot;where&quot; we feel like implemen=
ting it.<br>
&gt;<br>
&gt; One benefit of doing it this way is that we can create a single<br>
&gt; containing box to set CSS style options controlling the flow of multip=
le<br>
&gt; infoboxes. The other way to achieve that would be to create a directiv=
e<br>
&gt; that allows us to set multiple options instead, e.g.:<br>
&gt;<br>
&gt; .. qapi:infoboxes:: deprecated unstable<br>
&gt;<br>
&gt; or possibly:<br>
&gt;<br>
&gt; .. qapi:infoboxes::<br>
&gt;=C2=A0 =C2=A0 :deprecated:<br>
&gt;=C2=A0 =C2=A0 :unstable:<br>
&gt;<br>
&gt; For now, I&#39;ve left these as top-level QAPI object options. &quot;H=
ey, it works.&quot;<br>
<br>
Do you intend to drop this part in the final version?<br>
<br>
Having the commit message explain paths not taken can be useful.=C2=A0 But<=
br>
this is phrased as an RFC, which suggests to me you plan to drop it.<br></b=
lockquote><div><br></div><div>Yep. You just hadn&#39;t reviewed these yet s=
o I left the commentary in :) Now that you&#39;ve seen it, it can go.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; P.S., I outsourced the CSS ;)<br>
<br>
Hi, Harmonie!<br>
<br>
&gt; Signed-off-by: Harmonie Snow &lt;<a href=3D"mailto:harmonie@gmail.com"=
 target=3D"_blank">harmonie@gmail.com</a>&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--000000000000163e02062fd8db3d--


