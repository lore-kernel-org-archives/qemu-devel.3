Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B3FC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 22:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC4cy-0005P9-Lb; Mon, 05 May 2025 18:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uC4cw-0005Oj-Rs
 for qemu-devel@nongnu.org; Mon, 05 May 2025 18:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uC4ct-0000IY-HI
 for qemu-devel@nongnu.org; Mon, 05 May 2025 18:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746485369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Foe46OOz/gontKSXkuTMXb+Mtx/fpbZgsLFaeeUCZR8=;
 b=Xof9fzFlTrKmARcLwxfFkBX1Ma91Mu3FYI5hatQsUNBgw3NesQ44woIF5vV8pxwQnD+GQQ
 bR8mN7MpL7mAU8ccxOmQDVTpKuP6S90F9dpNPZquaKaCUMNt6ybaZZPoYOEzKWTQJFst4q
 8xcQShPJFOFLJYqXBiv3RtEFW2C/HEE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-rAU1AAZDMiixAczn2HVOKQ-1; Mon, 05 May 2025 18:49:26 -0400
X-MC-Unique: rAU1AAZDMiixAczn2HVOKQ-1
X-Mimecast-MFC-AGG-ID: rAU1AAZDMiixAczn2HVOKQ_1746485364
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-308677f7d8cso4050953a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 15:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746485363; x=1747090163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Foe46OOz/gontKSXkuTMXb+Mtx/fpbZgsLFaeeUCZR8=;
 b=I4QlOrQELX12Jjsi6fDrdDRMQqISl2BxnRbgfE0P2GQwXA4HzQgFbiW0/8Bmoz1Wl+
 9DRq7zLFY6A1RHbGVvUJ8hz4UZyZca0BWvmfsjD1Ew5NRWN4+kiaWpYW1pIlWg9/PTA+
 bBOl95TM2qzNDa1rI4KXAVQxnJg5nTucc4CajkrCMrhC0I5cdK3zCp+jQa3vFm6+lu1j
 Bv83V4ZEv7MeQQ1M6jjYAsv6Qg5jnVAMKI5aQVUHM1z9ztDnrJm2VrUuh/Rm/HucgyxH
 BtNtNKVFO7X/Zg7b8wzWdI/juzom1sfK1ZYevxEwzpEDxpqllsRyH1yGJkNxBR7d6LJ9
 kIcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQIXSs5VMJlc6BdmkBV6gAsZDeLB7JKNsw4KUIBCrc29CPrF9gelxTWKqiEZZOTgPMDS0gPHg6GZTx@nongnu.org
X-Gm-Message-State: AOJu0YzW4YM169ao/4OD/jP5m0kosd7MZqJhKPFg5m7FaMHYnxS3GfQm
 YMhVUE6zXOFUxMb/BEMl9z0WvvJ6mp2oupIdwgnRluYyKVldITHEWY/35ANhY4s4Z6pw+TcPxWS
 ImyAdPK+K/f+OCH6gHkTJTMMVD52Ufxx4oWY3V9Jd7TAw4z3WBfTyLZPDn3ylFV2BrBGVF9GMC8
 lTQcYV8vWsEFZDPBe8ksonUBwe22q3SiJeDD8Ufw==
X-Gm-Gg: ASbGncswPv0+awF+s+99NlrJvKmOatQM3+o+XGEEOS5ZBbjYGRq8dTzZOHdccBDDirr
 UBy5ZnEMl0ivNCrCXAAL4bnLmI8M6QECGP6dHMkqGKlffFFLeYvucaKeVSPu7Raon+k6QaFnH5x
 SZCh62VfzOUw7v9AY6+4EKuW5N
X-Received: by 2002:a17:90b:2b90:b0:2fe:b937:2a51 with SMTP id
 98e67ed59e1d1-30a61a44c51mr15842248a91.33.1746485363291; 
 Mon, 05 May 2025 15:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/YbYPUkP6ViySP4/EzUAHFfNPv95+vrvbfV/T6B13hYP6GTm10Hx3dx8CTCKj1eFaJXA11bRb0DzTaFQ7VCU=
X-Received: by 2002:a17:90b:2b90:b0:2fe:b937:2a51 with SMTP id
 98e67ed59e1d1-30a61a44c51mr15842218a91.33.1746485362841; Mon, 05 May 2025
 15:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250425120710.879518-1-thuth@redhat.com>
 <57f21448-79c1-4d46-9a8e-f9109eb67dcd@linaro.org>
 <87jz78b7fh.fsf@pond.sub.org>
 <5d0e0b69-cbbc-4fa4-a847-fdc8603a8122@redhat.com>
 <875ximdj2i.fsf@pond.sub.org>
In-Reply-To: <875ximdj2i.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 5 May 2025 18:49:06 -0400
X-Gm-Features: ATxdqUFWabOewQZkEZHOH0P1d1IoyVo5yZUt4ssVLKug2qGSU9Z-Vsfguw2Rdng
Message-ID: <CAFn=p-ZZgRg_A=nXOLGd=S8b2g9K3FNm-hqG1Rv1F=uy4PLqEQ@mail.gmail.com>
Subject: Re: [PATCH] Drop support for Python 3.8
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a87ed506346b4fa4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

--000000000000a87ed506346b4fa4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 6:45=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Thomas Huth <thuth@redhat.com> writes:
>
> >  Hi!
> >
> > On 25/04/2025 17.13, Markus Armbruster wrote:
> >> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
> >>> On 25/4/25 14:07, Thomas Huth wrote:
> >>>> From: Thomas Huth <thuth@redhat.com>
> >>>> Python 3.8 went "end of life" in October 2024 and Fedora 42 dropped
> >>>> this version already, so the "python" CI job is currently failing.
> >>>> Thus it's time to drop support for this Python version in QEMU, too.
> > ...
> >>>>    if test -z "${PYTHON}"; then
> >>>>        # A bare 'python' is traditionally python 2.x, but some distr=
os
> >>>>        # have it as python 3.x, so check in both places.
> >>>> -    for binary in python3 python python3.12 python3.11 \
> >>>> -                          python3.10 python3.9 python3.8; do
> >>>> +    for binary in python3 python python3.13 python3.12 python3.11 \
> >>>
> >>> The 3.13 test was missing in commit 45b14be9b63 ("python: enable
> testing
> >>> for 3.13"). Preferably adding in a preliminary commit, otherwise
> mention
> >>> in this patch description
> >
> > Yes, I'll add a sentence to the patch description!
> >
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >
> > Thanks!
> >
> >> Yes.  The patch looks good to me otherwise.  But John knows a lot more
> >> about this stuff than I do; would be good to get his blessing.
> >
> > Seems like John is currently away from keyboard / busy with other stuff=
?
> I think we should go ahead and include this patch to get the CI green
> again, so I'll add it to my next pull request. If there is still anything
> that needs to be done on top, it can be done in another patch later.
>
> Makes sense.  I assume you'll amend the commit message to address
> Philippe's review.


Sorry, I was chasing the tail end of Sphinx fixes and fixing up the
standalone Python library which had quite a few problems with its CI, and I
figured I would then backport all of the various problems I encountered to
our CI here; I see you've already been tackling it while I was looking
away... sorry!

(Markus tried to warn me ...)

See also:
https://gitlab.com/qemu-project/python-qemu-qmp/-/merge_requests/34
https://gitlab.com/qemu-project/python-qemu-qmp/-/merge_requests/35
https://gitlab.com/gitlab-org/gitlab/-/issues/539290

If there are no objections to moving to 3.9 as the minimum, I certainly
don't mind. Go right ahead and I'll clean up afterwards as part of my
"delint qapi" series in which I'd like to fix quite a few other things that
are currently wonky. In fact, moving to 3.9 as a minimum might make all of
that much easier for me and allow deeper cleanings.

--js

--000000000000a87ed506346b4fa4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 30, 2025 at 6:45=E2=80=AFA=
M Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_blank">th=
uth@redhat.com</a>&gt; writes:<br>
<br>
&gt;=C2=A0 Hi!<br>
&gt;<br>
&gt; On 25/04/2025 17.13, Markus Armbruster wrote:<br>
&gt;&gt; Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.or=
g" target=3D"_blank">philmd@linaro.org</a>&gt; writes:<br>
&gt;&gt;&gt; On 25/4/25 14:07, Thomas Huth wrote:<br>
&gt;&gt;&gt;&gt; From: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" =
target=3D"_blank">thuth@redhat.com</a>&gt;<br>
&gt;&gt;&gt;&gt; Python 3.8 went &quot;end of life&quot; in October 2024 an=
d Fedora 42 dropped<br>
&gt;&gt;&gt;&gt; this version already, so the &quot;python&quot; CI job is =
currently failing.<br>
&gt;&gt;&gt;&gt; Thus it&#39;s time to drop support for this Python version=
 in QEMU, too.<br>
&gt; ...<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 if test -z &quot;${PYTHON}&quot;; then<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 # A bare &#39;python&#39; is tr=
aditionally python 2.x, but some distros<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 # have it as python 3.x, so che=
ck in both places.<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 for binary in python3 python python3.12 pyt=
hon3.11 \<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3.10 python3.9 python3.8; do<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 for binary in python3 python python3.13 pyt=
hon3.12 python3.11 \<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The 3.13 test was missing in commit 45b14be9b63 (&quot;python:=
 enable testing<br>
&gt;&gt;&gt; for 3.13&quot;). Preferably adding in a preliminary commit, ot=
herwise mention<br>
&gt;&gt;&gt; in this patch description<br>
&gt;<br>
&gt; Yes, I&#39;ll add a sentence to the patch description!<br>
&gt;<br>
&gt;&gt;&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto=
:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt;<br>
&gt; Thanks!<br>
&gt;<br>
&gt;&gt; Yes.=C2=A0 The patch looks good to me otherwise.=C2=A0 But John kn=
ows a lot more<br>
&gt;&gt; about this stuff than I do; would be good to get his blessing.<br>
&gt;<br>
&gt; Seems like John is currently away from keyboard / busy with other stuf=
f? I think we should go ahead and include this patch to get the CI green ag=
ain, so I&#39;ll add it to my next pull request. If there is still anything=
 that needs to be done on top, it can be done in another patch later.<br>
<br>
Makes sense.=C2=A0 I assume you&#39;ll amend the commit message to address<=
br>
Philippe&#39;s review.</blockquote><div><br></div><div>Sorry, I was chasing=
 the tail end of Sphinx fixes and fixing up the standalone Python library w=
hich had quite a few problems with its CI, and I figured I would then backp=
ort all of the various problems I encountered to our CI here; I see you&#39=
;ve already been tackling it while I was looking away... sorry!</div><div><=
br></div><div>(Markus tried to warn me ...)</div><div><br></div><div>See al=
so:</div><div><a href=3D"https://gitlab.com/qemu-project/python-qemu-qmp/-/=
merge_requests/34">https://gitlab.com/qemu-project/python-qemu-qmp/-/merge_=
requests/34</a></div><div><a href=3D"https://gitlab.com/qemu-project/python=
-qemu-qmp/-/merge_requests/35">https://gitlab.com/qemu-project/python-qemu-=
qmp/-/merge_requests/35</a></div><div><a href=3D"https://gitlab.com/gitlab-=
org/gitlab/-/issues/539290">https://gitlab.com/gitlab-org/gitlab/-/issues/5=
39290</a></div><div><br></div><div>If there are no objections to moving to =
3.9 as the minimum, I certainly don&#39;t mind. Go right ahead and I&#39;ll=
 clean up afterwards as part of my &quot;delint qapi&quot; series in which =
I&#39;d like to fix quite a few other things that are currently wonky. In f=
act, moving to 3.9 as a minimum might make all of that much easier for me a=
nd allow deeper cleanings.</div><div><br></div><div>--js</div></div></div>

--000000000000a87ed506346b4fa4--


