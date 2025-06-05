Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6FDC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDa1-00037m-DN; Thu, 05 Jun 2025 12:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNDZq-00034x-Ob
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNDZn-0002AG-Ra
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749141382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=11CLacksM1BhpU+Hs16yXDObr01e/HZjlyOVUKUkByg=;
 b=fResaSu1ybWTKpW9LXGY2fmVWfNvWJVyLe1f2994OAESFYM0Lm6q6Xwgkl3MW1RTh5egxk
 FQ3Y2/mKVTdcdeeHNe16d+tyD/KGPjuGBHf3k66J36Hn7HzKgKV88WvE1we4htJJRWhlXg
 f5+sOvH41zR4zxq1xc/yJ7Z8gBEqbps=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500--u1asB4qOaejURoU76j0mA-1; Thu, 05 Jun 2025 12:36:20 -0400
X-MC-Unique: -u1asB4qOaejURoU76j0mA-1
X-Mimecast-MFC-AGG-ID: -u1asB4qOaejURoU76j0mA_1749141380
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-311d067b3faso2034516a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749141379; x=1749746179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=11CLacksM1BhpU+Hs16yXDObr01e/HZjlyOVUKUkByg=;
 b=DhtYovRa3Mncge5ZZXfafd3H+yH/RWpYWNw83/Eo0hUfqdsQsGmbIKpZFp/ngClR+h
 TT3jwNhfDGDgajKLT4aJnny5giAGgS832DOR1KBrBu14L/5hw5T/c/E3ysNj2xvUCQsp
 uoOVGMtv2wvCWhnM4VuNTO+MHNnUmTa6nV40yXGVUvaKQOGCtSPuigU+AzxkADsHIgN9
 9toLqWloawxTiZZqLSbdHHKCa0S4nrirQX31iwTBtZ/itUf4Oxs0QKQSw/7UbBJ/lkSq
 zNN6MM6fKhtd5mJkBciuhShqsmR4kqntkx3hmmTfTdn5n/Da9CpA4fnHWtNLXDo26Oor
 xzGg==
X-Gm-Message-State: AOJu0YyKDUMedQ9XSp+pxhynvK5j0KiJNInrcSrHPyR0a/CH2ZYHcIHf
 QWz0+3OVWIljNVzHBL7wbZ1h8NQ9be4GJgDmvk0//ZvoQ++317kPC28EVY4NYmzELH18rEgH6L9
 Z3m0uLp4oUgi/NU9MCw2EkdL5cnAJCiuSZeZxB9pHONzLvZJ1ZhjwdZSahO240AQ4eN0WNy24fM
 YTfS9YwkQhWKt6E+KEz50W4OsVDVXQ8ZaZI6eXQM96AQ==
X-Gm-Gg: ASbGncsQUy+H43pDq1yJZdJN/3aeK+sMP2VnpwObLvWYvJlP7H3rrZ2EjWtG/GwudfH
 FXA3iTcDTDWwPHAPpodF8qv4eIoappmpq05lVyMNmdiLxNWAMU1HWHppcgXyyDWrV3RSLVr7j1j
 PRcjMORbwNUnqLUPth4mHoabsf
X-Received: by 2002:a17:90b:2252:b0:312:1c83:58ec with SMTP id
 98e67ed59e1d1-31346b2a382mr679933a91.12.1749141378969; 
 Thu, 05 Jun 2025 09:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeALc0uVQAKHf0Uij+KTSujEMzHJ53YjlES/2Dw7b4vyww0tc6PH/UQXR/ckUqYEjJpVBf4RNEmungmyg6qdw=
X-Received: by 2002:a17:90b:2252:b0:312:1c83:58ec with SMTP id
 98e67ed59e1d1-31346b2a382mr679882a91.12.1749141378369; Thu, 05 Jun 2025
 09:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250523180809.41211-1-jsnow@redhat.com>
 <20250523180809.41211-2-jsnow@redhat.com>
 <aD2IBR5FTFCSrV8x@redhat.com>
In-Reply-To: <aD2IBR5FTFCSrV8x@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 5 Jun 2025 12:36:06 -0400
X-Gm-Features: AX0GCFsCDxOJX2AXKvxWs7EMADxceXAmC6wlg87YupbYVAE0y79U59jjzviR5YI
Message-ID: <CAFn=p-bNR3vTkqc9n9xqdyT7b1uE4V2mdP6UkXbjjAn1hbXZtw@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs/qapi-domain: Improve QAPI indices
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008538380636d5b6f9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

--0000000000008538380636d5b6f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 7:16=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Fri, May 23, 2025 at 02:08:09PM -0400, John Snow wrote:
> > This patch changes the "by type" categorization in favor of using
> > sub-categories of a literal "By type" category instead. A new "By
> > module" categorization is also added that follows a similar pattern.
>
> I'm not much of a fan of this. IMHO unless you are looking at the
> module(s) for the subsystem you are the maintainer of, the split
> of definitions across modules comes across as somewhat arbitrary
> and unpredictable.
>

I'm assuming here that you are opposing the "by module" categorization
specifically.

Fair enough. Markus has said similar things; that the split by module is
more of a sin of necessity than a genuine categorization. I suppose in my
mind's eye it is my hope that they WOULD be useful for grouping like
commands, structures, and events by topic. I admit they are not necessarily
strictly adherent to that idea at the moment.

However, I think it's *conceptually* useful to group together, say, "block
related things" into a block topic. Modules may not fit this 1:1 at
current, but it's the best we have.

If there's opposition to doing it in this manner, I cede, but still
maintain that grouping things by topic would be superior to a flat list of
just absolutely everything.


>
> Looking at this from the POV of a consumer of QMP, our entrypoint
> to research is either a command name or an event name.
>
> The data type names of enums/alternates/objects are an internal
> QEMU detail that's not part of the public API.
>

Keep in mind that once the "inliner" is merged, the great majority of
"internal" structures will be omitted from this index. The exact definition
of what is elided is hard for me to describe formally, but: Any object that
is currently referenced only via "...The members of ..." will be omitted,
as the information relating to that definition will be inlined into the
appropriate command/event instead.

This will also by definition exclude entities that aren't referenced at
all, such as internal definitions we use for QOM/QDEV and similar purposes.

Due to a limitation in how I present alternates (i.e. via reference to the
type and not by inlining the choices/types), alternates are one of the few
types whose internal details remain even after the inliner is merged. This
isn't a fundamental barrier, just where the cutting room knife made the
excision, and can be remedied in the future.

The algorithm for what is visible is something like the following:

1. All entities are hidden by default.
2. All commands and events are marked visible.
3. All member types belonging to a visible entity (commands, events) are
marked as visible; i.e. if an event uses an enum or a command takes a
compound object as an argument, those entities become visible in the
documentation, even though the name of that type is an "internal detail".
This is because I do not have a system in place for presenting recursive
structures, and it is currently easiest to link to these types by
reference, necessitating their visibility. This marking is carried out
recursively.
4. All return types, currently, are marked visible. In the future we may
inline return structures in a manner similar to members, but we do not do
so, yet.

This isn't enough to remove *all* internal types, but it does get a lion's
share of them and thins the documentation considerably. I don't have
numbers on hand at present, but when I get these prerequisite series out of
the way, I can enumerate them.


>
> If we consider the index currently:
>
>   Alternates | Commands | Enums | Events | Modules | Objects | A | .... |=
 Z
>
> The A ... Z bits link to a mix of all type names, which is a bit
> overwhealming.
>
> At the same time the page is twice as big as it needs to be
> as the same info is repeated under the A-Z index and the
> other per-type indexes.
>

Yes; but that's how indices are at times: multiple things are listed in
multiple places to facilitate lookup. It is not really meant to be space
efficient.

In my case, the things I really truly care about are:

(1) A true alphabetical list of all symbols we have documented, and
(2) A list of all events and commands, specifically.

Everything else more or less just comes along for the ride by parallel;
making an index for events/commands inherently creates an index for
objects, enums, etc. I didn't see a need to specifically exclude them.


>
> I think what would help would be to make the index dynamic
>
> eg
>
>   A | B | C | D | E | ... | X | Y | Z
>
>   [ ] Show internal types
>

> The A-Z index would default to showing commands and events.
> Selecting the "Types" checkbox would toggle display of the
> alternate/enum/object names, which could be done via having
> a CSS class on each index entry, and javascript which just
> toggles 'display: none' / 'display: block' CSS property on
> the elements with the given class. I'm not convinced we need
> the modules in the index.
>

That'd be cool! Unfortunately I'm going to reply here with the dreaded
"patches welcome". I'm worried I don't have the mandate to spend much more
time on this project than I already have... :(

If you'd like to take a crack at it, I would be happy to advise.


>
>
> > Alphabetical sorting has been improved and will sort in a case
> > insensitive manner for all categories, now.
>
> This is trivial and nice and could be a standalone fix ?
>

Maybe! This patchset is one of those cases where I went to fix one thing
and got carried away... If I can extract just this fix by its lonesome I
will do so. I admit that I forget right now how easy that is to do, or if
it relies on my restructuring of other elements.

... It's probably easy enough to rewrite, anyway.


>
> > Lastly, the "main" QAPI Index (qapi-index.html) is altered to index
> > *everything* from all namespaces, adding disambiguation where necessary
> > to do so.
>
> This looks a bit wierd having the same types and modules repeated
> multiple times.
>

I suppose so. If we do not find the master index useful, we could go the
other route and eliminate it entirely, leaving only the domain-specific
indices. I recall Markus at one point assumed the master index to work as
this patch makes it work, so I just closed the loop here. The way it
currently actually works is that the master index only indexes items that
have no associated domain, which turns out to be essentially nothing.


>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--0000000000008538380636d5b6f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 2, =
2025 at 7:16=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berra=
nge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Fri, May 23, 2025 at 02:08:09PM -0400=
, John Snow wrote:<br>
&gt; This patch changes the &quot;by type&quot; categorization in favor of =
using<br>
&gt; sub-categories of a literal &quot;By type&quot; category instead. A ne=
w &quot;By<br>
&gt; module&quot; categorization is also added that follows a similar patte=
rn.<br>
<br>
I&#39;m not much of a fan of this. IMHO unless you are looking at the<br>
module(s) for the subsystem you are the maintainer of, the split<br>
of definitions across modules comes across as somewhat arbitrary<br>
and unpredictable.<br></blockquote><div><br></div><div>I&#39;m assuming her=
e that you are opposing the &quot;by module&quot; categorization specifical=
ly. <br></div><div><br></div><div>Fair enough. Markus has said similar thin=
gs; that the split by module is more of a sin of necessity than a genuine c=
ategorization. I suppose in my mind&#39;s eye it is my hope that they WOULD=
 be useful for grouping like commands, structures, and events by topic. I a=
dmit they are not necessarily strictly adherent to that idea at the moment.=
</div><div><br></div><div>However, I think it&#39;s *conceptually* useful t=
o group together, say, &quot;block related things&quot; into a block topic.=
 Modules may not fit this 1:1 at current, but it&#39;s the best we have.</d=
iv><div><br></div><div>If there&#39;s opposition to doing it in this manner=
, I cede, but still maintain that grouping things by topic would be superio=
r to a flat list of just absolutely everything.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
Looking at this from the POV of a consumer of QMP, our entrypoint<br>
to research is either a command name or an event name.<br>
<br>
The data type names of enums/alternates/objects are an internal<br>
QEMU detail that&#39;s not part of the public API.<br></blockquote><div><br=
></div><div>Keep in mind that once the &quot;inliner&quot; is merged, the g=
reat majority
 of &quot;internal&quot; structures will be omitted from this index. The ex=
act definition of what is elided is hard for me to describe formally, but: =
Any object that is currently referenced only via &quot;...The members of ..=
.&quot; will be omitted, as the information relating to that definition wil=
l be inlined into the appropriate command/event instead.</div><div><br></di=
v><div>This will also by definition exclude entities that aren&#39;t refere=
nced at all, such as internal definitions we use for QOM/QDEV and similar p=
urposes.</div><div><br></div><div>Due to a limitation in how I present alte=
rnates (i.e. via reference to the type and not by inlining the choices/type=
s), alternates are one of the few types whose internal details remain even =
after the inliner is merged. This isn&#39;t a fundamental barrier, just whe=
re the cutting room knife made the excision, and can be remedied in the fut=
ure.</div><div><br></div><div>The algorithm for what is visible is somethin=
g like the following:</div><div><br></div><div>1. All entities are hidden b=
y default.</div><div>2. All commands and events are marked visible.</div><d=
iv>3. All member types belonging to a visible entity (commands, events) are=
 marked as visible; i.e. if an event uses an enum or a command takes a comp=
ound object as an argument, those entities become visible in the documentat=
ion, even though the name of that type is an &quot;internal detail&quot;. T=
his is because I do not have a system in place for presenting recursive str=
uctures, and it is currently easiest to link to these types by reference, n=
ecessitating their visibility. This marking is carried out recursively.</di=
v><div>4. All return types, currently, are marked visible. In the future we=
 may inline return structures in a manner similar to members, but we do not=
 do so, yet.</div><div><br></div><div>This isn&#39;t enough to remove *all*=
 internal types, but it does get a lion&#39;s share of them and thins the d=
ocumentation considerably. I don&#39;t have numbers on hand at present, but=
 when I get these prerequisite series out of the way, I can enumerate them.=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
If we consider the index currently:<br>
<br>
=C2=A0 Alternates | Commands | Enums | Events | Modules | Objects | A | ...=
. | Z<br>
<br>
The A ... Z bits link to a mix of all type names, which is a bit<br>
overwhealming.<br>
<br>
At the same time the page is twice as big as it needs to be<br>
as the same info is repeated under the A-Z index and the<br>
other per-type indexes.<br></blockquote><div><br></div><div>Yes; but that&#=
39;s how indices are at times: multiple things are listed in multiple place=
s to facilitate lookup. It is not really meant to be space efficient.</div>=
<div><br></div><div>In my case, the things I really truly care about are:</=
div><div><br></div><div>(1) A true alphabetical list of all symbols we have=
 documented, and</div><div>(2) A list of all events and commands, specifica=
lly.</div><div><br></div><div>Everything else more or less just comes along=
 for the ride by parallel; making an index for events/commands inherently c=
reates an index for objects, enums, etc. I didn&#39;t see a need to specifi=
cally exclude them.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
I think what would help would be to make the index dynamic<br>
<br>
eg<br>
<br>
=C2=A0 A | B | C | D | E | ... | X | Y | Z<br>
<br>
=C2=A0 [ ] Show internal types <br></blockquote><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
The A-Z index would default to showing commands and events.<br>
Selecting the &quot;Types&quot; checkbox would toggle display of the<br>
alternate/enum/object names, which could be done via having<br>
a CSS class on each index entry, and javascript which just<br>
toggles &#39;display: none&#39; / &#39;display: block&#39; CSS property on<=
br>
the elements with the given class. I&#39;m not convinced we need<br>
the modules in the index.<br></blockquote><div><br></div><div>That&#39;d be=
 cool! Unfortunately I&#39;m going to reply here with the dreaded &quot;pat=
ches welcome&quot;. I&#39;m worried I don&#39;t have the mandate to spend m=
uch more time on this project than I already have... :(</div><div><br></div=
><div>If you&#39;d like to take a crack at it, I would be happy to advise.<=
/div><div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
<br>
&gt; Alphabetical sorting has been improved and will sort in a case<br>
&gt; insensitive manner for all categories, now.<br>
<br>
This is trivial and nice and could be a standalone fix ?<br></blockquote><d=
iv><br></div><div>Maybe! This patchset is one of those cases where I went t=
o fix one thing and got carried away... If I can extract just this fix by i=
ts lonesome I will do so. I admit that I forget right now how easy that is =
to do, or if it relies on my restructuring of other elements.</div><div><br=
></div><div>... It&#39;s probably easy enough to rewrite, anyway.</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Lastly, the &quot;main&quot; QAPI Index (qapi-index.html) is altered t=
o index<br>
&gt; *everything* from all namespaces, adding disambiguation where necessar=
y<br>
&gt; to do so.<br>
<br>
This looks a bit wierd having the same types and modules repeated<br>
multiple times.<br></blockquote><div><br></div><div>I suppose so. If we do =
not find the master index useful, we could go the other route and eliminate=
 it entirely, leaving only the domain-specific indices. I recall Markus at =
one point assumed the master index to work as this patch makes it work, so =
I just closed the loop here. The way it currently actually works is that th=
e master index only indexes items that have no associated domain, which tur=
ns out to be essentially nothing.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>

--0000000000008538380636d5b6f9--


