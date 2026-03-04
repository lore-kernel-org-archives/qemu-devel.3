Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20825EF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpOs-000383-0l; Wed, 04 Mar 2026 11:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vxpOr-00037q-83
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:48:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vxpOp-0001aS-Dy
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772642918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7CtjJHW7LZJMrUlhau3xdW279bozoWtGgCwLrVBsD5Y=;
 b=Uo4Xrv8T9b2Fbl/t1Zxfe0sm3cMAWPcitCx0J9pTm8LIhI0x0ugvZNeO1i7xItRGTUXriJ
 8MEdAea0AVQ3hl98CFeeiOeIUxoiyZ/uzYlt6bhpaSpmFYwPSkCAhOdJM7/McxrF+7Phw1
 7YF5ctNFhTlolE1Sszmi786B1qU/rAQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-R0KiCB_mM82pEIY9sIT_pA-1; Wed, 04 Mar 2026 11:48:36 -0500
X-MC-Unique: R0KiCB_mM82pEIY9sIT_pA-1
X-Mimecast-MFC-AGG-ID: R0KiCB_mM82pEIY9sIT_pA_1772642916
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-79881805767so75030467b3.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:48:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772642916; cv=none;
 d=google.com; s=arc-20240605;
 b=AcxH+j/ByV2ztkPsZgqKRlZPOJmTwQSZd99sMzpQBTPSW/fNUCZxdGnOpFtFzATFJx
 b6Dz1oMTP2YoniwJ3+znx8d6mndCvlqfoeAUkRgg241FWUGxSVKLYWux9wiNMD47l0q/
 Os9vTUhJoeSkNDmCgqwUCm/s472yTjgkRYJoodrFVZh/zTGLlW1GpbUblA3qfhF3ida1
 WuANZ2kSrYl7QxL5oAuJM8z5cZi/ps07X5+ukXDRBCJff9YV+l6CgXNTlppLuFb489KM
 Go/APZQH7+J+chU8pzdAQY26TjBk9emt/Z6en3mMQqGT2I4908A+8IpEr1SCPr5uqzdC
 7K/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7CtjJHW7LZJMrUlhau3xdW279bozoWtGgCwLrVBsD5Y=;
 fh=Xm1ao//qklFdOPp89/6xUzCVv6E/EI6O1lKNAzhngcE=;
 b=NiqKRAfKE2Hl2OrfBo/VOxdRSSffGWDqrVTk/T717vF83/Dlx71EG9dhGIBgO7EJTO
 1sxBkdP8WgpqjXBAdJh6knsxBg+kpI5et17iPHaL1EOwQP0SfS7y5t/WWss876+8U1LS
 4J/oX1nrU8cIQmv8f7defAedOBRqv7jxehyUQCm7ryP85tLJaCT4Oey98HM6xGVjqXnc
 Itoj8M6ymspFECf4ijiQUnf4iHTELR2OhfM7nYL+kEJ+vgOox4xuy3Nfyl1BmfKR5yL0
 6jtL1nTTMqwFQcd74IVbv4at/cqdpQW1EIUdv7SQ0fTlkU/inGlv4WzNUtCBfIpjbkkG
 rZvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772642916; x=1773247716; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7CtjJHW7LZJMrUlhau3xdW279bozoWtGgCwLrVBsD5Y=;
 b=cUf8UoOG9tYNitVxRHvbKwcBkiYqkoaLYifB1nXH1sKcfAqVd3dwnZEjLcbpyGE+s9
 lxE5iDEYTZcWo0c6QA6lyjXb4CcwVExR6HJZFzCb04/8dv2SUXF6jsPCh1PQD5nPPz0N
 7XCLhiSQFqllDENBDiynZoZHB8AyJPXtObrYhjtSgSp7b33PPkl6bFPZg6BD2MoGxO9m
 brJ00B5CqOOyxxD6Vq3NUjNEmuwIZKi/KQp8H3SmeALVZtftTT7/WndoDc60Ersatpx/
 eNx1eBcteIlNeEnIixqu6UET1+53LtE90Q8PmGvID4JKBB/q9XvsI6pLRZQB0rtZEj1J
 N5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772642916; x=1773247716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CtjJHW7LZJMrUlhau3xdW279bozoWtGgCwLrVBsD5Y=;
 b=sN+Cbvh4ZR2yr52z4hYd1Pym6OjNALw3A3c4oacnVT68pCVSxL7903qdwXvLGDYdy3
 sJEnWyUA65v0PzaFpMw9HLqirdA8p9vxc+5Kt658c5DoBwbB569ksnD9XBV4NvImtuXy
 KiG39/Ok9P3i/L7LYIupiSF4dcQRtON4pPagtTTZZUgG4mIt/75g41+VSwL+Px4A9D6J
 pQEiTyZnXbTXFEZSAYtHbG3TxakD1RBzg/POkjXqv/jVypW3JDXc0VC7g5RyGcAqZy8m
 M9MHCK3n+ri4GmY1CRMGJK8P7s9OXp58vqPD6hYTe2TpH1z9u5Kr9XEH9Mm/6JtGYp0t
 f5wQ==
X-Gm-Message-State: AOJu0YyNN+gOmXGhv8u9/mZpcefyKUtpSHcCHU4zQFdMs6H5DHndv8UR
 9kIkTVXkyyAAYOOnzsUi7xGWX4DYvYJ57DIg075vaW02J5NCCH/duZczbJDZLVV6hP4Ae3SaEen
 BoA7WPAd83YW6A8qhTXS/kSJUFKo0yd7GnfmQ7hr1/oXp+cRx8VKeSygIIOzXd6ROW0l5WESIdR
 thVbYxuy9lhPFyfXIold+1wvBmEdA4FbY=
X-Gm-Gg: ATEYQzw7mvlrEnSuBO6yvKLxQ4jh2J1x+sH38ccKccTArFVpjNHI8Ygs7b96cAMaxM5
 O1ykq5XegujKcE9QqaoeHMXaiAW4LcXZqkO+BDH2EJs3QkWF+f2t22y7lfTTd8QszoFeXYAu7kG
 6QBrJf8pih8ycgCTh+j7l5MNUfPOyIWlJrG98cEeHt9qPNj8sPISDbwqJ7mkHKH3TkDc6Op500Z
 y1dHsYwVzCcv9jg0JNVYw1rh+CgLshIyjayJbNT
X-Received: by 2002:a05:690c:660c:b0:798:6561:2a7c with SMTP id
 00721157ae682-798c6ca2ea1mr19742047b3.41.1772642915947; 
 Wed, 04 Mar 2026 08:48:35 -0800 (PST)
X-Received: by 2002:a05:690c:660c:b0:798:6561:2a7c with SMTP id
 00721157ae682-798c6ca2ea1mr19741867b3.41.1772642915525; Wed, 04 Mar 2026
 08:48:35 -0800 (PST)
MIME-Version: 1.0
References: <CAFn=p-bNbEwV+1ijfs=+_bCVfexjvN9WRNZwL13Qas+i_HmUBQ@mail.gmail.com>
 <87ldg7kh38.fsf@pond.sub.org>
In-Reply-To: <87ldg7kh38.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 4 Mar 2026 11:48:24 -0500
X-Gm-Features: AaiRm51lXyXaehkZQ1ZYram2npnLH2eoy8KE9zAN_Q4RYjRHv-5MPYqLH-unUCQ
Message-ID: <CAFn=p-Yfo2Hn9DCBGvOnpnOzqKhaZBiqWxSS5AmPi6nO_A=RYg@mail.gmail.com>
Subject: Re: QAPIDoc Total Section Ordering
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000004b8001064c359788"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

--0000000000004b8001064c359788
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026, 5:46=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Hi, let's recap...
> >
> > In general, it would be nice to have a strict inter-section ordering
> > for a few reasons:
> >
> > (1) It makes it easier to add generated sections such as return
> > values, undocumented members, or undocumented features/flags (such as
> > Out-of-band execution), because there is a clear and obvious place
> > where we should insert the generated doc. We have a few spots in the
> > code now where we have a bespoke algorithm to find the correct
> > insertion point, and it would be nice to consolidate this logic.
> >
> > (2) It makes the inliner easier, because merging two doc sections is
> > more obvious when there is a normal order that must be adhered to;
> > fields that are absent in one or the other docs list do not cause
> > problems or complex edge cases.
> >
> > (3) It allows us to design around a unified look and layout in the
> > HTML generator, which increases visual cohesion and yadda yadda yadda.
> > In particular, each "group" of doc types is laid out in a block where
> > having multiple fields of the same type be non-contiguous greatly
> > increases visual clutter. i.e. all arguments should be contiguous, all
> > features should be contiguous, etc. I have in the past referred to
> > these groupings of doc section types as "doc regions".
> >
> > For these reasons, I'd like to nail down the order once and for all,
> > and clarify a few things.
> >
> > The order I think you prefer is something like this:
> >
> > (1) Introduction ("Plain text", currently) - Always the first section,
> > always precisely one section. (But may be multiple paragraphs housed
> > within that single section.)
> > (2) Arguments/members/values/alternatives
> > (3) Return(s)
> > (4) Error(s)
> > (5) Feature(s)
> > (6) Details ("Plain text", currently - generally used for clarifying
> > detail, examples, and other information.)
>
>   (7) Since
>

Ah, right. Because I remove "since" from the flow of the document, I wind
up caring about it less, but yes. It can be last in the source.


> > Before I go any further, is this order "roughly correct" to you?
>
> Yes!
>
> > ...
> >
> > We previously discussed prohibiting "plain text" from appearing
> > anywhere except in (1) or (6). From memory, the summary of that
> > discussion is:
> >
> > Me: Prohibiting plaintext from appearing between 2-5 makes inlining
> > easier, and improves HTML output by preventing plaintext paragraphs
> > from interrupting the "tabular" output used to render metadata fields.
> >
> > You: Although it is not often utilized, we may want the freedom/power
> > to use plaintext paragraphs to add addendums/notes attached to
> > specific sections, i.e. adding a "Note:" to the tail of the arguments
> > section specifically.
> >
> > I recall we debated this particular restriction quite a few times and
> > at length; does this summary sound roughly accurate as far as you
> > remember?
>
> It does.
>
> What breaks right now if you prohibit untagged sections between (2) to
> (5)?
>

Not much. I think we have an interloping plaintext section maybe once or
twice in the docs currently. In my previous patches, I just removed those
sections but there was some concern about the ability to annotate e.g.
arguments sections with a note.

I haven't actually worked on this feature, but I suggested once we could
add an "addendum" or "section-note" tag to include these. I don't currently
have a strong sense of how hard that would or wouldn't be.

>

--0000000000004b8001064c359788
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 4, 2026, 5:46=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Hi, let&#39;s recap...<br>
&gt;<br>
&gt; In general, it would be nice to have a strict inter-section ordering<b=
r>
&gt; for a few reasons:<br>
&gt;<br>
&gt; (1) It makes it easier to add generated sections such as return<br>
&gt; values, undocumented members, or undocumented features/flags (such as<=
br>
&gt; Out-of-band execution), because there is a clear and obvious place<br>
&gt; where we should insert the generated doc. We have a few spots in the<b=
r>
&gt; code now where we have a bespoke algorithm to find the correct<br>
&gt; insertion point, and it would be nice to consolidate this logic.<br>
&gt;<br>
&gt; (2) It makes the inliner easier, because merging two doc sections is<b=
r>
&gt; more obvious when there is a normal order that must be adhered to;<br>
&gt; fields that are absent in one or the other docs list do not cause<br>
&gt; problems or complex edge cases.<br>
&gt;<br>
&gt; (3) It allows us to design around a unified look and layout in the<br>
&gt; HTML generator, which increases visual cohesion and yadda yadda yadda.=
<br>
&gt; In particular, each &quot;group&quot; of doc types is laid out in a bl=
ock where<br>
&gt; having multiple fields of the same type be non-contiguous greatly<br>
&gt; increases visual clutter. i.e. all arguments should be contiguous, all=
<br>
&gt; features should be contiguous, etc. I have in the past referred to<br>
&gt; these groupings of doc section types as &quot;doc regions&quot;.<br>
&gt;<br>
&gt; For these reasons, I&#39;d like to nail down the order once and for al=
l,<br>
&gt; and clarify a few things.<br>
&gt;<br>
&gt; The order I think you prefer is something like this:<br>
&gt;<br>
&gt; (1) Introduction (&quot;Plain text&quot;, currently) - Always the firs=
t section,<br>
&gt; always precisely one section. (But may be multiple paragraphs housed<b=
r>
&gt; within that single section.)<br>
&gt; (2) Arguments/members/values/alternatives<br>
&gt; (3) Return(s)<br>
&gt; (4) Error(s)<br>
&gt; (5) Feature(s)<br>
&gt; (6) Details (&quot;Plain text&quot;, currently - generally used for cl=
arifying<br>
&gt; detail, examples, and other information.)<br>
<br>
=C2=A0 (7) Since<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Ah, right. Because I remove &quot;since&quot; from the flow=
 of the document, I wind up caring about it less, but yes. It can be last i=
n the source.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<br>
&gt; Before I go any further, is this order &quot;roughly correct&quot; to =
you?<br>
<br>
Yes!<br>
<br>
&gt; ...<br>
&gt;<br>
&gt; We previously discussed prohibiting &quot;plain text&quot; from appear=
ing<br>
&gt; anywhere except in (1) or (6). From memory, the summary of that<br>
&gt; discussion is:<br>
&gt;<br>
&gt; Me: Prohibiting plaintext from appearing between 2-5 makes inlining<br=
>
&gt; easier, and improves HTML output by preventing plaintext paragraphs<br=
>
&gt; from interrupting the &quot;tabular&quot; output used to render metada=
ta fields.<br>
&gt;<br>
&gt; You: Although it is not often utilized, we may want the freedom/power<=
br>
&gt; to use plaintext paragraphs to add addendums/notes attached to<br>
&gt; specific sections, i.e. adding a &quot;Note:&quot; to the tail of the =
arguments<br>
&gt; section specifically.<br>
&gt;<br>
&gt; I recall we debated this particular restriction quite a few times and<=
br>
&gt; at length; does this summary sound roughly accurate as far as you<br>
&gt; remember?<br>
<br>
It does.<br>
<br>
What breaks right now if you prohibit untagged sections between (2) to<br>
(5)?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Not much. I think we have an interloping plaintext section maybe once o=
r twice in the docs currently. In my previous patches, I just removed those=
 sections but there was some concern about the ability to annotate e.g. arg=
uments sections with a note.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">I haven&#39;t actually worked on this feature, but I suggested once we=
 could add an &quot;addendum&quot; or &quot;section-note&quot; tag to inclu=
de these. I don&#39;t currently have a strong sense of how hard that would =
or wouldn&#39;t be.</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_=
quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000004b8001064c359788--


