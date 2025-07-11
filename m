Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C95C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 15:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaFSb-0004uM-NX; Fri, 11 Jul 2025 11:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uaFRo-0003gj-QP
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uaFRm-0002aF-BN
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752246836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u489aaZ8ymOfKoYXj/dQmXGb/kZ2Xd7p09wAuYgp0UE=;
 b=cQoQocLu6hL1h+Ql94lFmP2JrOdasPTRye7DvSodcKST3OkEx4ZvPAwrevYGJ2Xjd4u3bQ
 1Li68nSFRKtrkPBRhNnUF7tTa76zAirDmZzrFGnP0DtCR/CmH8tW/R1/RVVmOC6bdInUQ/
 KAh2EWzCQZozXJ+mdp0SlAhuKvRUzOI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-MIg5ytUrM_2kIUMohs6mUg-1; Fri, 11 Jul 2025 11:13:55 -0400
X-MC-Unique: MIg5ytUrM_2kIUMohs6mUg-1
X-Mimecast-MFC-AGG-ID: MIg5ytUrM_2kIUMohs6mUg_1752246834
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235196dfc50so22518825ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 08:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752246834; x=1752851634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u489aaZ8ymOfKoYXj/dQmXGb/kZ2Xd7p09wAuYgp0UE=;
 b=fs62bKN3iR0L2Icp4oEq0GAKWfivmBPSUh+JtWqsQRvu21IdRlit4vM3amv3hveLl5
 M5/NkRRA5tdpbNpxgIhTt3Xs1y5JQRqOCbSdDAltEDoqLzdjgZEjZGAV+XQFjzamtLje
 Xuz+MD44pXlZb+YoZZQiTwcJhQfEbyB0wnHkz/M4mUiAroVdDscnQz9KzbUlkQqxN2jL
 3vnrSZu9ShpzNVi6eGnqQdwmg7NL3yZ83XIIRacpOAMSNLDfsiFtctuHxvQZlhAAa84G
 omy0OmCT7t9/duiK9j+E7d9uHvk5yEvMPT1iWOv2Keph7nZI76ehBbAS/vdWNi+yvRiR
 gZZQ==
X-Gm-Message-State: AOJu0YwyeSUobCf5PYhied5Q53ZGe2VC02rOfEd4OfdXmaClNK5dGu+r
 yVyQ+fVC90YfJ6g4lHdoMgdwTMzGQZ+bnbk6jqPuZD4Ww1x2iAlr4puSjJ//k7Ct07A/ALIlFBM
 rOzkcVE/M+pv92kTKUItEDRWRBl83kbafPRaDQ5uKlK6Q/2HR+JuQwzIxQesYAOt9vDib/InLVa
 ompHkZ1eGCO/E/6TabfPBTwv1Fiv/nat8=
X-Gm-Gg: ASbGncsZlpmlHzZ9WSWMDo7KgcCTuhZYIAomPeEK7uPBfSBxEtxvCnPf5LHec+uBAcI
 kUbnSEso1MaTIw+9yLuZbGo9wpJAQS4UN6iNVv5rmKtFRc93CErLeCPbPH2egL5+38GjGfwb3HD
 xm4MoA5UuN4wnxgS/J9nZVFoa3QDjHNlY8bGW4YfrDGuyUvzDOO7nb
X-Received: by 2002:a17:902:f707:b0:23c:7b55:d051 with SMTP id
 d9443c01a7336-23dede48998mr59678975ad.14.1752246834109; 
 Fri, 11 Jul 2025 08:13:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuDGr3jN/AHa+AA1BWb1Pa4kCVGFaekOJC1dbcjIHkZDtb3k1JRm4Laj0r37vOa/Ivz7SUU0kuI1xi2rzK5n8=
X-Received: by 2002:a17:902:f707:b0:23c:7b55:d051 with SMTP id
 d9443c01a7336-23dede48998mr59678565ad.14.1752246833728; Fri, 11 Jul 2025
 08:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250711054005.60969-1-jsnow@redhat.com>
 <87ple76quz.fsf@pond.sub.org>
In-Reply-To: <87ple76quz.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 Jul 2025 11:13:40 -0400
X-Gm-Features: Ac12FXzgPuEsDgIjgx7GnXwJnX_Up2--ehGfrjl3qj208IE4GSY4HwulB1BZm0U
Message-ID: <CAFn=p-ZYYd-0WAxhYTYCDdvcxLp5MUme5XkcJ7_z7kxnpLt8HA@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] QAPI: add cross-references to qapi docs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eric Blake <eblake@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Lukas Straub <lukasstraub2@web.de>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="0000000000001574ec0639a8c2c4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--0000000000001574ec0639a8c2c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025, 5:04=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Based-on: 20250711051045.51110-1-jsnow@redhat.com
> >     [PATCH v6 0/4] qapi: add auto-generated return docs
> >
> > v2:
> >  - Applied a few new transformations I had missed.
> >  - Manually excluded those Markus pointed out as being unhelpful.
>
> You missed a few.  Can drop them in my tree.  I also suggested a commit
> message amendment.  Can do that in my tree, too.  With that, series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Please do feel free. I read your reviews and I'm happy with all the
changes, including the commit message changes to highlist the
cross-reference lookup ambiguity problems where they arise.

(Sorry I missed some...)


> > Hi, this patch series is a *mostly* mechanical application of QAPI
> > cross-references to the QAPI/QMP documentation. I exported all
> > cross-referenceable symbols from the QMP QAPI schema and ran them
> > through a script that converted any matching words to a cross-reference=
.
> >
> > I then used `git add -p` and only added changes that looked reasonable,
> > omitting many cases of converting common words like "stop",
> > "transaction", "eject", "String" etc when it wasn't immediately clear
> > that it was appropriate. I probably missed a few ... in either
> > direction.
> >
> > I'd like to ask maintainers for each subsystem to review the changes an=
d
> > confirm that they make sense. To make it easy for you, here's a link to
> > each module that was changed, in order:
>
> [...]
>
> > A few benefits of doing this:
> >
> > (1) It makes the docs easier to navigate for users, being able to just
> >     click to the referred data type / enum / event / command / etc.
>
> A *huge* usability win!
>
> > (2) It helps prevent bitrot: if the name of a command / event / data
> >     type / etc changes, the cross-reference will cause the build to
> >     fail, giving a needed hint that documentation elsewhere needs to be
> >     updated.
>
> Can also catch typos.
>
> > (3) Prompting the maintainers to review the generated HTML documentatio=
n
> >     O:-)
>
> WAT?!?  We're supposed to actually look at the doc we expect our users
> to read?
>
> [...]
>
>

--0000000000001574ec0639a8c2c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 11, 2025, 5:04=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Based-on: <a href=3D"mailto:20250711051045.51110-1-jsnow@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">20250711051045.51110-1-jsnow@redhat.com=
</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0[PATCH v6 0/4] qapi: add auto-generated return docs=
<br>
&gt;<br>
&gt; v2:<br>
&gt;=C2=A0 - Applied a few new transformations I had missed.<br>
&gt;=C2=A0 - Manually excluded those Markus pointed out as being unhelpful.=
<br>
<br>
You missed a few.=C2=A0 Can drop them in my tree.=C2=A0 I also suggested a =
commit<br>
message amendment.=C2=A0 Can do that in my tree, too.=C2=A0 With that, seri=
es<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Please do feel f=
ree. I read your reviews and I&#39;m happy with all the changes, including =
the commit message changes to highlist the cross-reference lookup ambiguity=
 problems where they arise.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">(Sorry I missed some...)</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
<br>
&gt; Hi, this patch series is a *mostly* mechanical application of QAPI<br>
&gt; cross-references to the QAPI/QMP documentation. I exported all<br>
&gt; cross-referenceable symbols from the QMP QAPI schema and ran them<br>
&gt; through a script that converted any matching words to a cross-referenc=
e.<br>
&gt;<br>
&gt; I then used `git add -p` and only added changes that looked reasonable=
,<br>
&gt; omitting many cases of converting common words like &quot;stop&quot;,<=
br>
&gt; &quot;transaction&quot;, &quot;eject&quot;, &quot;String&quot; etc whe=
n it wasn&#39;t immediately clear<br>
&gt; that it was appropriate. I probably missed a few ... in either<br>
&gt; direction.<br>
&gt;<br>
&gt; I&#39;d like to ask maintainers for each subsystem to review the chang=
es and<br>
&gt; confirm that they make sense. To make it easy for you, here&#39;s a li=
nk to<br>
&gt; each module that was changed, in order:<br>
<br>
[...]<br>
<br>
&gt; A few benefits of doing this:<br>
&gt;<br>
&gt; (1) It makes the docs easier to navigate for users, being able to just=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0click to the referred data type / enum / event / co=
mmand / etc.<br>
<br>
A *huge* usability win!<br>
<br>
&gt; (2) It helps prevent bitrot: if the name of a command / event / data<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0type / etc changes, the cross-reference will cause =
the build to<br>
&gt;=C2=A0 =C2=A0 =C2=A0fail, giving a needed hint that documentation elsew=
here needs to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0updated.<br>
<br>
Can also catch typos.<br>
<br>
&gt; (3) Prompting the maintainers to review the generated HTML documentati=
on<br>
&gt;=C2=A0 =C2=A0 =C2=A0O:-)<br>
<br>
WAT?!?=C2=A0 We&#39;re supposed to actually look at the doc we expect our u=
sers<br>
to read?<br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--0000000000001574ec0639a8c2c4--


