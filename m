Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C437BC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 19:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txWiM-0000DY-Ix; Wed, 26 Mar 2025 15:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txWiG-0000By-HI
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txWiD-0006ev-FP
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743018410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPN6BjASvB8/TtkqY6LyqfElcrN2uxS1LZuLL+yoeR8=;
 b=hrM0VTOTmZNUdLePo/UneEAPsZ4wjItM4Eu2l94T8FreniDzA1uPVBvwNSAJN9QMBA96TY
 Nc5/N52wAP1BpPhCWATmeh6QAoYidDyjdNM/Veo42NQBtukQsJOXEcmom/AGjfX1DWD9nk
 la1SaZ/5V92ftgBAyOHG+iSSdDkn2js=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-LzqyDaqGMy2QYVhpSibqqQ-1; Wed, 26 Mar 2025 15:46:46 -0400
X-MC-Unique: LzqyDaqGMy2QYVhpSibqqQ-1
X-Mimecast-MFC-AGG-ID: LzqyDaqGMy2QYVhpSibqqQ_1743018405
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff4b130bb2so293028a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 12:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743018405; x=1743623205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UPN6BjASvB8/TtkqY6LyqfElcrN2uxS1LZuLL+yoeR8=;
 b=Vp7jcK8Ojv3AtEpx7TulBPgdAW4Vplbd8wl4QUmy1ibZmUZWrYJpxiAmJETPARNje7
 FEp0DnK3MQSvy9Xh21OLB1ViES7+6q30GVDlHK7NBEHRsg30LXLF8b8zXbG0E0VaITSa
 ymyYrWmUvqpSXdL7rqHRp7rHrsasSeO1DC+rF9puVHGI3WeiQvvm3GcotEBkRFXCoqig
 4fpWLp3hqJ8l/zt3IL7w+W4p5HQC6gy4kwkHE9HMB4ugyUJARFJj7BqeMrQLtVP8q3iw
 V4/tz+Uwe4YnT+NCjhATCC5bHmY2B4I+/b5DcZV0DC0h84mhKKWzH5nBWSPPEwnSuZqM
 cF/Q==
X-Gm-Message-State: AOJu0Yx5lqv7PD+EwKdUL/L31pEWJleWx2TdQeyGJdYwtur5ggTlKqvc
 ZoWPfXUNw8Zmv3Ox92/3bUnIbxMcmKbqgMTld5MKvrTxi7sELdXcpXiBCrSryCLInKa++3O16ev
 j1PWOJsGScATNMPnifP7zk5HFFVd6VeX7DwVgrKC294axPcXBcRpo5bqJI01NgEtMO8WNR6w558
 RSNgGVIqmxtu4yfWdhoBq5QBbGbQU=
X-Gm-Gg: ASbGncvu4EYhvbwSCSFCObPq+RtRXupx60MxUhwcXqUyXFk8S9+2721L2kMMENT0WxZ
 d9QlbagYgT9eU5u1lypYrDqRfoN3Zq4JkS4J8Sz5SDoKv7Ct3cbdiFGiPWQ1b2Fv2VnKCowOBc6
 qKsXjMW1AJpDTMUUFWraE7LnHS5ldy
X-Received: by 2002:a17:90b:5485:b0:2ff:682b:b759 with SMTP id
 98e67ed59e1d1-303a7c54a6amr1469234a91.7.1743018405495; 
 Wed, 26 Mar 2025 12:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5uFSNEavsSIlIefkTotudz6TBg8KZHIPk/F/p9ipTERvx60acmk90m3ubgFWRgqpqTGvfaHItb4t2hesswiQ=
X-Received: by 2002:a17:90b:5485:b0:2ff:682b:b759 with SMTP id
 98e67ed59e1d1-303a7c54a6amr1469183a91.7.1743018405187; Wed, 26 Mar 2025
 12:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250322010857.309490-1-jsnow@redhat.com>
 <20250322010857.309490-4-jsnow@redhat.com>
 <87bjtpmop6.fsf@pond.sub.org>
In-Reply-To: <87bjtpmop6.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Mar 2025 15:46:32 -0400
X-Gm-Features: AQ5f1JoNQBBGbMyhENwsMH68JYt3ES2KNCnWhC-Z9BujdyP7tge7AIZrXY7rmm4
Message-ID: <CAFn=p-ZJT0p7LHiBPn5deZnGSq6vtyF5b8G7pmmzUyRPtDURtQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] qapi: remove trivial "Returns:" sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Lukas Straub <lukasstraub2@web.de>, 
 Fabiano Rosas <farosas@suse.de>, Eduardo Habkost <eduardo@habkost.net>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org, 
 Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Yanan Wang <wangyanan55@huawei.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, 
 Zhenwei Pi <pizhenwei@bytedance.com>, Mads Ynddal <mads@ynddal.dk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: multipart/alternative; boundary="000000000000e0ebd9063144182c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000e0ebd9063144182c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 5:42=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > The new qapidoc transmogrifier can generate "Returns" statements with
> > type information just fine, so we can remove it from the source where i=
t
> > doesn't add anything particularly novel or helpful and just repeats the
> > type info.
> >
> > This patch does not touch Returns: lines that add some information
> > (potentially helpful, potentially not) but repeats the type information
> > to remove that type.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> This is a clear improvement for the generated docs.  For instance,
> blockdev-snapshot-delete-internal-sync goes from
>
>     Return:
>        "SnapshotInfo" -- SnapshotInfo
>
> to
>
>     Return:
>        "SnapshotInfo"
>
> However, I see that *triplicated* in my testing.  I observed similar
> issues with the previous patch, so let's discuss that there and ignore
> it here.
>
> The impact on schema file egonomics is less clear.
>
> This patch removes a bunch of "Returns:" sections that make the
> generated docs look bad.  How can we stop people from writing such
> sections?
>
> Developers tend to refer to the schema file instead of the generated
> documentation.  Information is spread across doc comment and schema
> code.  Both describe the syntactic structure.  Only the schema code has
> types, optional, and such.  The doc comment describes semantics.  In
> practice, skimming the doc comment is often enough.
>
> Except for the return value.  The doc comment's "Returns:" section is
> optional.  When it's absent, the generated docs are bad (but this patch
> fixes that).  Moreover, the doc comment doesn't fully describe the
> syntactic structure then.  Unwary readers may not be aware of that trap,
> and miss the return value.
>
> The inliner you posted before needs to know where the inlined stuff
> goes.  Obvious when there are argument descriptions or a "Returns:".
> For the cases where we have nothing useful, you proposed an explicit
> marker "Details:" (how exactly it's spelled doesn't matter here, only
> that an explicit marker can be necessary).  Could removing "Returns:"
> make the marker necessary more often?  Can our tooling reliably detect
> the need for the marker?
>

Well, tooling can at least be certain when it isn't certain.

The warning I have in my inliner branch-fork-whatever now basically just
looks at the sections and if there's non-plaintext sections between the
start and the ending, it treats the beginning as intro and the ending as
details.

In the case there is *nothing else at all*, i.e. no returns, no
arguments/members, no errors, no features - i.e. it's a single QAPIDoc
Section - the inliner will count the *paragraphs*. If it's *one* paragraph,
it deduces that it's an intro section and does not consider it ambiguous.
If there are multiple paragraphs, however, that's when it emits a warning.

A computer is never going to be able to reliably determine *intent*, but
syntactically I think that's a pretty narrow circumstance to yelp over:
"Documentation contains only a single plaintext section that consists of
two or more paragraphs". In practice, that's a reasonably rare occurrence
and is most likely to occur with query commands that take no arguments,
have no features, and do not document return value semantics.

--000000000000e0ebd9063144182c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 25,=
 2025 at 5:42=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; The new qapidoc transmogrifier can generate &quot;Returns&quot; statem=
ents with<br>
&gt; type information just fine, so we can remove it from the source where =
it<br>
&gt; doesn&#39;t add anything particularly novel or helpful and just repeat=
s the<br>
&gt; type info.<br>
&gt;<br>
&gt; This patch does not touch Returns: lines that add some information<br>
&gt; (potentially helpful, potentially not) but repeats the type informatio=
n<br>
&gt; to remove that type.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
This is a clear improvement for the generated docs.=C2=A0 For instance,<br>
blockdev-snapshot-delete-internal-sync goes from<br>
<br>
=C2=A0 =C2=A0 Return:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;SnapshotInfo&quot; -- SnapshotInfo<br>
<br>
to<br>
<br>
=C2=A0 =C2=A0 Return:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;SnapshotInfo&quot;<br>
<br>
However, I see that *triplicated* in my testing.=C2=A0 I observed similar<b=
r>
issues with the previous patch, so let&#39;s discuss that there and ignore<=
br>
it here.<br>
<br>
The impact on schema file egonomics is less clear.<br>
<br>
This patch removes a bunch of &quot;Returns:&quot; sections that make the<b=
r>
generated docs look bad.=C2=A0 How can we stop people from writing such<br>
sections?<br>
<br>
Developers tend to refer to the schema file instead of the generated<br>
documentation.=C2=A0 Information is spread across doc comment and schema<br=
>
code.=C2=A0 Both describe the syntactic structure.=C2=A0 Only the schema co=
de has<br>
types, optional, and such.=C2=A0 The doc comment describes semantics.=C2=A0=
 In<br>
practice, skimming the doc comment is often enough.<br>
<br>
Except for the return value.=C2=A0 The doc comment&#39;s &quot;Returns:&quo=
t; section is<br>
optional.=C2=A0 When it&#39;s absent, the generated docs are bad (but this =
patch<br>
fixes that).=C2=A0 Moreover, the doc comment doesn&#39;t fully describe the=
<br>
syntactic structure then.=C2=A0 Unwary readers may not be aware of that tra=
p,<br>
and miss the return value.<br>
<br>
The inliner you posted before needs to know where the inlined stuff<br>
goes.=C2=A0 Obvious when there are argument descriptions or a &quot;Returns=
:&quot;.<br>
For the cases where we have nothing useful, you proposed an explicit<br>
marker &quot;Details:&quot; (how exactly it&#39;s spelled doesn&#39;t matte=
r here, only<br>
that an explicit marker can be necessary).=C2=A0 Could removing &quot;Retur=
ns:&quot;<br>
make the marker necessary more often?=C2=A0 Can our tooling reliably detect=
<br>
the need for the marker?<br></blockquote><div><br></div><div>Well, tooling =
can at least be certain when it isn&#39;t certain.</div><div><br></div><div=
>The warning I have in my inliner branch-fork-whatever now basically just l=
ooks at the sections and if there&#39;s non-plaintext sections between the =
start and the ending, it treats the beginning as intro and the ending as de=
tails.</div><div><br></div><div>In the case there is *nothing else at all*,=
 i.e. no returns, no arguments/members, no errors, no features - i.e. it&#3=
9;s a single QAPIDoc Section - the inliner will count the *paragraphs*. If =
it&#39;s *one* paragraph, it deduces that it&#39;s an intro section and doe=
s not consider it ambiguous. If there are multiple paragraphs, however, tha=
t&#39;s when it emits a warning.</div><div><br></div><div>A computer is nev=
er going to be able to reliably determine *intent*, but syntactically I thi=
nk that&#39;s a pretty narrow circumstance to yelp over: &quot;Documentatio=
n contains only a single plaintext section that consists of two or more par=
agraphs&quot;. In practice, that&#39;s a reasonably rare occurrence and is =
most likely to occur with query commands that take no arguments, have no fe=
atures, and do not document return value semantics.</div></div></div>

--000000000000e0ebd9063144182c--


