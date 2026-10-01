Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88BECA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 04:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC8fN-00028g-7S; Thu, 01 Oct 2026 00:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1xC8fE-00026c-8M
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 00:45:01 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1xC8f9-00060x-CB
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 00:44:58 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2e2bfc2540cso13533525ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 21:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790829891; cv=none;
 d=google.com; s=arc-20260327;
 b=XpG5gMOOuPxM2c74nIYJz3EKyqQruw7sCc1faCZuiJyPuzrn1inY59K0j/nFRRZiTS
 iQZb8I93DWHFr9uzUrsPYO4FcpGzINd3F7YWxKzdMaWtKDaxV9ut15oslkAQH25njSDt
 lMeXcHoA4Jv7d+x4KNv/CpCORnNLoxJFari+ZMZq030zgUFcx5z6GtGiXbNCcO5Cn/7e
 u3LIVc06gkL9Q0P6sz+2lROINTMT6Uge+FLKsTgnEfc881Jiw9r8bOzy/qm+xkLKVJzx
 2ObpmxvJ2DArEMxFfscIP+1AXOs+B5KkGo44DqTjBiNCliJBUjimjw+HYs69T4CcITHL
 D3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZR2p6bf1vUmU8MxigYX1Va4TRyRlVO0ZJEbdhB87Pl8=;
 fh=/otbiuYty4h6tt/8CD1ctSZ+A8a9H3FjEskjxoewZE0=;
 b=YPiML7AUFH64FBDyM8TFwgJGHel4iQnJhso7gb2qoRiFA2tlwGsv0ZpCGidQMiyioR
 KvNID1pXk6j8Jfxt63Gdzk+SVcHwzhceIg8M0wRKy1fregI9GBhzBL7y3MceOR8xVJOj
 cYOgf0r8ONsSWjF83HP+UnCg5+XJWQMnvX1SO6nNab258VLRZVUgarBRyOhOBZYCpj9B
 mg6zph8u5Vpx4GnXquMfTdJmYaWP0lMQ/1Z/vYrZKNSitcF0LsEpqVUNToyqqSCRm+F4
 fW1/NWlpTHGRW/guqBDKD2+EWINX3j2AtIXIWnT/sp/qsKlXShhN21EaNcLR5GoXH/5P
 iq1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790829891; x=1791434691;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZR2p6bf1vUmU8MxigYX1Va4TRyRlVO0ZJEbdhB87Pl8=;
 b=SOZdNNmcR/bGulWC69oizB44D0GRM0pTuAIuy1Zai6J0TRSMA84HZxSv/6vYLSlzsC
 IOoz7LfV0RYcunYjQEqMGxgFGzEqTK1s5iKUWRA6sY5YdmUdRhlLeXrie3gXpBeJ6NqM
 zsEbQEh1jUMMQ54ad3/BB6awwzYLVGZR3qao5jbMFJZ8/nZlavtJe1c4MuPdcDSQ4BTZ
 9ruX3wYd4DNGRdcN2FFlzYkHA4pxI9a2obxp3YfrNhW9AF+Bkuf856qGTAQ/64wbNxBL
 xZLeAgJiYCJqnP+36ZiDckf4HaU6AOTqJuqZPYUXqbuqLYUjMikSitBZr8FNBIDVWltj
 NqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790829891; x=1791434691;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZR2p6bf1vUmU8MxigYX1Va4TRyRlVO0ZJEbdhB87Pl8=;
 b=2wUY9I6r2uNJttQln0oceLdjH3krctRgzZU8S06Uh0KEUv+fPftapIVdC24RhUF1Ae
 aw00n3c+7IibIzHKYTXz2jA84p0WYiDqceWGqK/l1g9rcPOe/vV3IuYEiGc3XN/G3xnT
 k58CPpDRVu+nbMpNTQWFikYcsLXIHlHzLua2MKQ+TS6GxvqTMEtWBZtgvg/7BRSBB9K/
 cdQoA8qYNWLkQuANR6tCh/qdxxgqlorJOQvrb3c97CSuJD4a9wRf560Pp2OhmRy0mv+e
 VY8dX48u2+5tPjgxSF3OJlHImcadYcdrHkZXOnc8GjaMLu/QsUZ9T/HBqqBac0WOuIEK
 o4kg==
X-Gm-Message-State: AFq9FYIf7bOzPaC9xh66uSMfZgkafdXEeSvULRJyClDfeMse4o6nZ6wA
 cZnw1AgnHeKctg6xPIiRNJxO0nSm/4WiRp0+xODAAoXrBMlVdfnxpk2LMgxF6UxC6vmm1d8ghK+
 v55Q0JVT90kkX/HKZYlh8R1kra0DMYN39VTWdeSvMjw==
X-Gm-Gg: AYBFou3uBZdlIU/abCFIfIgp2vYrPCkgcjTLV8h17EA7MgZPtJL4XwtTdLwCJ9sj33g
 H+KGOXDqP4NS/JMFEVPgDJVUnO89p+TqQzArguBUgZIaSXU4cXcgCZgyN03ApiKF50DzvzCw3dP
 tQQ3LUF0B8T5MQy5K7as/O4l7nxesbkzVASv5gc9RZgr4HMPGI2eXmKxd13191dS7e1PEa/hC5x
 cB1+0y7A3uH7jsO7V2TBlCQQhsKIWs9LzqA8w1yV4P9BbjNTA9qpVyJzZFlrgeH2NfJwDFfBoQ4
 j3eWvc8feD3opLTITorqio56gqo4oPR40ymKF1oXONtzvJhupuoegk2dZDPO2HrhExm/p0tMydK
 uHQtkW3VoEQ==
X-Received: by 2002:a17:902:ce8d:b0:2df:a803:efaf with SMTP id
 d9443c01a7336-2e2e4b84831mr31213175ad.23.1790829890648; Wed, 30 Sep 2026
 21:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
In-Reply-To: <20260930085433.830743-1-pbonzini@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 30 Sep 2026 22:44:38 -0600
X-Gm-Features: AclHuK-IWTuszzLADoTSGuvJNc1iqROMh8L245zTZIZbuQNW4Tlbmk7yYTvyCYA
Message-ID: <CANCZdfqTQ1JJJwrZj5e9NptWfs2P9MooMpLNgnHCCHsv9BCSDw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] docs/devel, AGENTS.md: a completely new policy on
 AI-generated contributions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007c4ed6065cc013c7"
Received-SPF: none client-ip=2607:f8b0:4864:39::f;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000007c4ed6065cc013c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:54=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:

> Based on the previous discussions, I am finally attempting a non-RFC
> version of the new AI policy.  Discussion on v3 introduced interesting
> points on attestation and I think a consensus is forming.
>
> Why review the policy?  The blanket ban no longer reflects reality, since
> contributors have been posting AI-generated patches or even larger series=
.
> This was done most likely in good faith, as these submissions predated
> the introduction of an AGENTS.md file, and it shows that AI can be used
> for useful and creative work on QEMU.
>
> Rather than expecting maintainers to police these contributors, the new
> policy seeks to ensure that AI usage helps us produce better code rather
> than simply move faster and flood us with dubious work.  In the words
> of Warner Losh, we want to avoid "free as in puppy" contributions[1]
> that increase the load of present and future maintainers by adding
> technical debt.
>
> This is not a free-for-all.  To avoid maintainer burnout, AI
> contributions must be grounded in respect for maintainers and in the
> existing contribution process.  Large, heavily AI-assisted contributions
> require pre-arrangement with the relevant subsystem maintainers, and
> will be held to a higher standard.
>
> One of the reasons for the old policy was the issue of code provenance
> and the impossibility to certify the originality of code created by
> AI/LLM tools.  The new policy tries to adopt a "Swiss cheese"
> approach to mitigating the risks implicit in accepting AI-generated code
> in three ways:
>
> 1) by requiring pre-arrangement for larger contributions, and making
> maintainers free to apply their own considerations (see [2] for a good
> list).  Maintainers' preferences bring experience and creative thought
> into the process, and contributors must take them into account.
>
> 2) by introducing agent instructions that help the contributor drive
> the design and understand the code produced by the LLM;
>
> 3) by introducing an "AI-used-for" trailer that scopes areas where
> Signed-off-by cannot guarantee full control of provenance.
>
> This series reflects feedback from earlier requests for comments, and
> even earlier discussions with members of the QEMU community.  Thanks to
> everyone who provided feedback on earlier drafts.
>
> Paolo
>
> v3->v4:
> - rework opening text [Daniel]
> - exempt "official project agents" from not being able to post to
>   GitLab [Alex]
> - explicitly forbid clean room reimplementation [Kevin/Daniel]
> - remove "The DCO still certifies that the contributor has the legal
>   right to submit code in general" paragraph, replace with a note
>   that "AI-used-for" attests respecting the policies and is considered
>   enough for DCO [Daniel, Kevin]
> - make the requirement to "understand and explain your changes"
>   more prominent
> - small edits for grammar and clarity
>
> v2->v3:
> - remove parser example, replace with "adaptations of existing code"
> - when LLMs are used for boilerplate, "highly recommend" disclosure
>   for "non-trivial, functional code".  The idea here is to avoid
>   having to disclose using AI to apply e.g. changes related to
>   automatic code review, and leaving people some leeway.
> - clarify split between DCO (legal right to submit code in general)
>   and AI-used-for acknowledging that the submitter cannot audit LLM
>   output against e.g. the training data.
> - clarify the defense-in-depth/swiss-cheese approach to limit the
>   risk of copyright violations from LLM output
> - mention that pre-arrangement is not an entirely new concept
> - mention that maintainers can demand larger changes than for
> human-written code
> - do not mention inclusion of the prompt
> - add checkpatch.pl hunk, changing the phrasing of "no AI" lint
> - rebase AGENTS.md on top of existing file, split
> - drop CLAUDE.md/GEMINI.md symlinks, already done via .claude/.gemini
>
> [1]
> https://lore.kernel.org/qemu-devel/CANCZdfrTwfrK0wnuL2cPVF_9W2-8PXtJeHkgk=
TP+Uv2sT8s0Ng@mail.gmail.com/
> [2]
> https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=3DcXiYyFoQo0wCSUJ6b=
=3D7nVLLCwKhP6Nwxw@mail.gmail.com/
>
> Paolo Bonzini (4):
>   docs/devel: relax policy on AI-generated contributions
>   AGENTS.md: add final instructions
>   AGENTS.md: let agents know what the participation rules are
>   AGENTS.md: make the human part of the design process
>
>  docs/devel/code-provenance.rst |  71 +----------
>  docs/devel/index-process.rst   |   1 +
>  docs/devel/llm-usage.rst       | 213 +++++++++++++++++++++++++++++++++
>  AGENTS.md                      | 137 +++++++++++++++++++--
>  scripts/checkpatch.pl          |   5 +-
>  5 files changed, 347 insertions(+), 80 deletions(-)
>  create mode 100644 docs/devel/llm-usage.rst
>

Acked-by: Warner Losh <imp@bsdimp.com>

How can I not ack this series with a cover letter like this :)

But it looks good to my eye as well, and the minor tire kicking I did
showed it was useful.


> --
> 2.55.0
>
>

--0000000000007c4ed6065cc013c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 30,=
 2026 at 2:54=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redha=
t.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Based on the previous discussions, I am finally a=
ttempting a non-RFC<br>
version of the new AI policy.=C2=A0 Discussion on v3 introduced interesting=
<br>
points on attestation and I think a consensus is forming.<br>
<br>
Why review the policy?=C2=A0 The blanket ban no longer reflects reality, si=
nce<br>
contributors have been posting AI-generated patches or even larger series.<=
br>
This was done most likely in good faith, as these submissions predated<br>
the introduction of an AGENTS.md file, and it shows that AI can be used<br>
for useful and creative work on QEMU.<br>
<br>
Rather than expecting maintainers to police these contributors, the new<br>
policy seeks to ensure that AI usage helps us produce better code rather<br=
>
than simply move faster and flood us with dubious work.=C2=A0 In the words<=
br>
of Warner Losh, we want to avoid &quot;free as in puppy&quot; contributions=
[1]<br>
that increase the load of present and future maintainers by adding<br>
technical debt.<br>
<br>
This is not a free-for-all.=C2=A0 To avoid maintainer burnout, AI<br>
contributions must be grounded in respect for maintainers and in the<br>
existing contribution process.=C2=A0 Large, heavily AI-assisted contributio=
ns<br>
require pre-arrangement with the relevant subsystem maintainers, and<br>
will be held to a higher standard.<br>
<br>
One of the reasons for the old policy was the issue of code provenance<br>
and the impossibility to certify the originality of code created by<br>
AI/LLM tools.=C2=A0 The new policy tries to adopt a &quot;Swiss cheese&quot=
;<br>
approach to mitigating the risks implicit in accepting AI-generated code<br=
>
in three ways:<br>
<br>
1) by requiring pre-arrangement for larger contributions, and making<br>
maintainers free to apply their own considerations (see [2] for a good<br>
list).=C2=A0 Maintainers&#39; preferences bring experience and creative tho=
ught<br>
into the process, and contributors must take them into account.<br>
<br>
2) by introducing agent instructions that help the contributor drive<br>
the design and understand the code produced by the LLM;<br>
<br>
3) by introducing an &quot;AI-used-for&quot; trailer that scopes areas wher=
e<br>
Signed-off-by cannot guarantee full control of provenance.<br>
<br>
This series reflects feedback from earlier requests for comments, and<br>
even earlier discussions with members of the QEMU community.=C2=A0 Thanks t=
o<br>
everyone who provided feedback on earlier drafts.<br>
<br>
Paolo<br>
<br>
v3-&gt;v4:<br>
- rework opening text [Daniel]<br>
- exempt &quot;official project agents&quot; from not being able to post to=
<br>
=C2=A0 GitLab [Alex]<br>
- explicitly forbid clean room reimplementation [Kevin/Daniel]<br>
- remove &quot;The DCO still certifies that the contributor has the legal<b=
r>
=C2=A0 right to submit code in general&quot; paragraph, replace with a note=
<br>
=C2=A0 that &quot;AI-used-for&quot; attests respecting the policies and is =
considered<br>
=C2=A0 enough for DCO [Daniel, Kevin]<br>
- make the requirement to &quot;understand and explain your changes&quot;<b=
r>
=C2=A0 more prominent<br>
- small edits for grammar and clarity<br>
<br>
v2-&gt;v3:<br>
- remove parser example, replace with &quot;adaptations of existing code&qu=
ot;<br>
- when LLMs are used for boilerplate, &quot;highly recommend&quot; disclosu=
re<br>
=C2=A0 for &quot;non-trivial, functional code&quot;.=C2=A0 The idea here is=
 to avoid<br>
=C2=A0 having to disclose using AI to apply e.g. changes related to<br>
=C2=A0 automatic code review, and leaving people some leeway.<br>
- clarify split between DCO (legal right to submit code in general)<br>
=C2=A0 and AI-used-for acknowledging that the submitter cannot audit LLM<br=
>
=C2=A0 output against e.g. the training data.<br>
- clarify the defense-in-depth/swiss-cheese approach to limit the<br>
=C2=A0 risk of copyright violations from LLM output<br>
- mention that pre-arrangement is not an entirely new concept<br>
- mention that maintainers can demand larger changes than for human-written=
 code<br>
- do not mention inclusion of the prompt<br>
- add <a href=3D"http://checkpatch.pl" rel=3D"noreferrer" target=3D"_blank"=
>checkpatch.pl</a> hunk, changing the phrasing of &quot;no AI&quot; lint<br=
>
- rebase AGENTS.md on top of existing file, split<br>
- drop CLAUDE.md/GEMINI.md symlinks, already done via .claude/.gemini<br>
<br>
[1] <a href=3D"https://lore.kernel.org/qemu-devel/CANCZdfrTwfrK0wnuL2cPVF_9=
W2-8PXtJeHkgkTP+Uv2sT8s0Ng@mail.gmail.com/" rel=3D"noreferrer" target=3D"_b=
lank">https://lore.kernel.org/qemu-devel/CANCZdfrTwfrK0wnuL2cPVF_9W2-8PXtJe=
HkgkTP+Uv2sT8s0Ng@mail.gmail.com/</a><br>
[2] <a href=3D"https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=3DcXiYy=
FoQo0wCSUJ6b=3D7nVLLCwKhP6Nwxw@mail.gmail.com/" rel=3D"noreferrer" target=
=3D"_blank">https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=3DcXiYyFoQ=
o0wCSUJ6b=3D7nVLLCwKhP6Nwxw@mail.gmail.com/</a><br>
<br>
Paolo Bonzini (4):<br>
=C2=A0 docs/devel: relax policy on AI-generated contributions<br>
=C2=A0 AGENTS.md: add final instructions<br>
=C2=A0 AGENTS.md: let agents know what the participation rules are<br>
=C2=A0 AGENTS.md: make the human part of the design process<br>
<br>
=C2=A0docs/devel/code-provenance.rst |=C2=A0 71 +----------<br>
=C2=A0docs/devel/index-process.rst=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0docs/devel/llm-usage.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0| 213 ++++++++++++=
+++++++++++++++++++++<br>
=C2=A0AGENTS.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 137 +++++++++++++++++++--<br>
=C2=A0scripts/<a href=3D"http://checkpatch.pl" rel=3D"noreferrer" target=3D=
"_blank">checkpatch.pl</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
5 +-<br>
=C2=A05 files changed, 347 insertions(+), 80 deletions(-)<br>
=C2=A0create mode 100644 docs/devel/llm-usage.rst<br></blockquote><div><br>=
</div><div>Acked-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@=
bsdimp.com</a>&gt;</div><div><br></div><div>How can I not ack this series w=
ith a cover letter like this :)</div><div><br></div><div>But it looks good =
to my eye as well, and the minor tire kicking I did showed it was useful.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
2.55.0<br>
<br>
</blockquote></div></div>

--0000000000007c4ed6065cc013c7--

