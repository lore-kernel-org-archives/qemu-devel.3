Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D877FE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVepc-0002N9-6c; Wed, 08 Jan 2025 17:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVepa-0002Mx-Rf
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVepY-0002Nw-9C
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736376434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5v0Tlosg5bB76nsMVkbHTrSU9aKboEdTcs4unNZYj8g=;
 b=cgKQRDXkhSg02OmPbldSHnscf6X8i390qcNwxku+rwzB7mtFs+U0h/TvuWtzFXxVUAzSR+
 9I/baS6+6TXy6KKUfkAb7Znx0lLMrxN8C+m/+Y1Ktds0OEBwE1tb4JmM/RFXhygmWGvpij
 BPmTZgdudzrNX0Co3WFGNclBk2Y186I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-uQ1lqgXvNAWCQK9WLYal8w-1; Wed, 08 Jan 2025 17:47:13 -0500
X-MC-Unique: uQ1lqgXvNAWCQK9WLYal8w-1
X-Mimecast-MFC-AGG-ID: uQ1lqgXvNAWCQK9WLYal8w
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef9b9981f1so695330a91.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 14:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736376431; x=1736981231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5v0Tlosg5bB76nsMVkbHTrSU9aKboEdTcs4unNZYj8g=;
 b=djX+Nqmc+/DQiWe/nbDJ9J1ZO15c5jfzK3s3CUlTp6uaOpRQVtQemNXFqRpkBkd5O6
 2qUM7vNkZLZFwFbW498/J2Ym3Vh1irLMPrWA6Nq2TC27IPHRkL2iElFEPyU2P1A8kI39
 kk+cRbXeMk9gW8w2Kas8qXGsRpb5OUrVQjmBoXiWQllawWTI1C7pILLWVvBJLmqQfz+2
 yB0qh7XD1H8xF26GzpdcVlW2aHKgG2TKsWBGFs4qdUDZqyXQkAHy1NLHxpq9pT5h3wZ2
 ODU2Q6geAGWJ4I3ya+u3bi8e4Llb7wgVatMWuzIA96RWRbHExaCgA24Oojpa4ZYI1v+5
 EjaQ==
X-Gm-Message-State: AOJu0YyT4k032WqdWXE2Z6x8stm+QRGezCPvr+KSilnpSqRaZy1HrY2i
 mmhbVbUbs9NsnG2X6sms6SzPnDnEa/jQNM7Mqju68lmSXEjkSfHEf+5rQWlNJta5kxqKYaAxvga
 Nfu81aurpqeNMrB88CWH0WG2aLVINlgYwzlEHUQwc2eHFtgnLusybtvXcQtpQWMWoEO0ClZTBKn
 6u0hAFGPK69EwdmzO9H0AmX9T8NKN/ucQqZ0o=
X-Gm-Gg: ASbGncuQ1AiESQSTwzKPegNYjEkse0U4v3FUxUc5kEvWFUt1KzvLxwqeeULkv6yvuzi
 fQIgbrhQYIXTVeJMGo5VP8tsED8/bP4DMRJwIjco9veXHOG/rTYDMGBx2XrdO5V/De40rUg==
X-Received: by 2002:a17:90b:280a:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2f548f2ecb6mr7009973a91.9.1736376430871; 
 Wed, 08 Jan 2025 14:47:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2CNrYZhEFuDnmQvBqbkesjC1/lT8o8m12yzsPQR6hsYCnqbsUJLWVR1xnbzcoszqTQH4/prieUIkBx0LHDEA=
X-Received: by 2002:a17:90b:280a:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2f548f2ecb6mr7009948a91.9.1736376430509; Wed, 08 Jan 2025
 14:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-17-jsnow@redhat.com>
 <87cyhm306p.fsf@pond.sub.org>
In-Reply-To: <87cyhm306p.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 8 Jan 2025 17:46:58 -0500
X-Gm-Features: AbW1kvYCJLvxc96Ho9wlj5aWb1ZvNncyVsDIVQR-LYlNvBssF2BaETHqC1-VmjM
Message-ID: <CAFn=p-auvWHvnuvQ0EbkiUYY-QE5tPyrhcbQzasMDOJxdtjG3Q@mail.gmail.com>
Subject: Re: [PATCH 16/23] docs/qapidoc: add visit_feature() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000056565c062b39a472"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--00000000000056565c062b39a472
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 9:21=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > The format_type() method is adjusted here to return None for features,
> > because Features don't have documented types. This makes
> > generate_field() safe to use for features.
>
> I'm confused: the patch doesn't touch format_type().
>

Patch refactoring booboo, sorry for the confusion.


>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 7efe2d656c0..02f434c09ab 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -187,6 +187,15 @@ def visit_paragraph(self, section: QAPIDoc.Section=
)
> -> None:
> >          self.add_lines(section.text, section.info)
> >          self.ensure_blank_line()
> >
> > +    def visit_feature(self, section: QAPIDoc.ArgSection) -> None:
> > +        # FIXME - ifcond for features is not handled at all yet!
> > +        # Proposal: decorate the right-hand column with some graphical
> > +        # element to indicate conditional availability?
> > +        assert section.text  # Guaranteed by parser.py
> > +        assert section.member
> > +
> > +        self.generate_field("feat", section.member, section.text,
> section.info)
> > +
> >      def visit_errors(self, section: QAPIDoc.Section) -> None:
> >          # FIXME: the formatting for errors may be inconsistent and may
> >          # or may not require different newline placement to ensure
>
>

--00000000000056565c062b39a472
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 20, 2024=
 at 9:21=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.c=
om" target=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsno=
w@redhat.com" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; The format_type() method is adjusted here to return None for features,=
<br>
&gt; because Features don&#39;t have documented types. This makes<br>
&gt; generate_field() safe to use for features.<br>
<br>
I&#39;m confused: the patch doesn&#39;t touch format_type().<br></blockquot=
e><div><br></div><div>Patch refactoring booboo, sorry for the confusion.<br=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 9 +++++++++<br>
&gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 7efe2d656c0..02f434c09ab 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -187,6 +187,15 @@ def visit_paragraph(self, section: QAPIDoc.Sectio=
n) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_lines(section.text, <a href=
=3D"http://section.info" rel=3D"noreferrer" target=3D"_blank">section.info<=
/a>)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def visit_feature(self, section: QAPIDoc.ArgSection) -&=
gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # FIXME - ifcond for features is not hand=
led at all yet!<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Proposal: decorate the right-hand colum=
n with some graphical<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # element to indicate conditional availab=
ility?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert section.text=C2=A0 # Guaranteed by=
 parser.py<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert section.member<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.generate_field(&quot;feat&quot;, sec=
tion.member, section.text, <a href=3D"http://section.info" rel=3D"noreferre=
r" target=3D"_blank">section.info</a>)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit_errors(self, section: QAPIDoc.Section) -=
&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # FIXME: the formatting for errors m=
ay be inconsistent and may<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # or may not require different newli=
ne placement to ensure<br>
<br>
</blockquote></div></div>
</div>

--00000000000056565c062b39a472--


