Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26557C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 19:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCOIj-00033l-Qs; Tue, 06 May 2025 15:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uCOIf-0002y4-Ox
 for qemu-devel@nongnu.org; Tue, 06 May 2025 15:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uCOIe-0001J3-0h
 for qemu-devel@nongnu.org; Tue, 06 May 2025 15:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746560994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yE8tgYPHbuVa4hQeIDxuKsnUXs5cXRwbkdxbMnP7dlI=;
 b=WNITCL0BCemEuKKqNdM17q6LmnO659yqNJwu3zjjwmjASW7+5RUagxlrf+ZrUk2mW2mV/Z
 GKtk1Q6f6KbFlQLnRqAel+kdSOJluQttdg9rD5X5CaeN/7AabHLpzv/oWQgETtvsXMtP8b
 aeVT9kx5QNASMFBYUsfi71vaEIO3cqE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-N81bry-7OKaGpjMjj6dyow-1; Tue, 06 May 2025 15:49:53 -0400
X-MC-Unique: N81bry-7OKaGpjMjj6dyow-1
X-Mimecast-MFC-AGG-ID: N81bry-7OKaGpjMjj6dyow_1746560992
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22e3abea7e8so11486485ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 12:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746560991; x=1747165791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yE8tgYPHbuVa4hQeIDxuKsnUXs5cXRwbkdxbMnP7dlI=;
 b=KI+p8Bv4v5bHb5EtOxqet3C2vY+2yqiBYJN9DYJct1bcy+w1lVuNI0Uf/d1QmwXUm+
 +LWtCKxzZNv9O0dkvtGj3WZ+pBIT5SafjX8bgau+wsgD2Jhzjfulg2YvgZWqtSlm9C8D
 xK/TzQ9/azvUiy9T1Ze5mupGp81gQGMM4DX3QRTHUgllT3Jkfp7QRLy2Kz8jqPlJy5c/
 V21Vx2E21jHL71OkKVFC/Osu7ntL2MYN9T3zNTk2//UhJdvsKl0r0RRle5ED0wxgfCH7
 6EnIPzftlShcuiGc53lH0Bgwie3gm+SzqpIoR7AVX4xp6fTZgCYQSzCAW+XfEvPdIROG
 lkxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC2CP6ziqufPSxmYchzFaNTx9GvkV01MEh4rBZ22IJdusj3TJjZ/SgP3UVr/QiEIPxjxDP/tAoZh2I@nongnu.org
X-Gm-Message-State: AOJu0YxdvOeck2PKGCxYzXrOLVsVFvnQtRzhXvNAigVr6mbDYUtLKONy
 iJIUU2E+2MvPdU9Az+50ecJwXETT3t0zB40zinGE7XH8tcxcRDTd3qUEx5yMjVAFYjmz7Qz02ou
 CcaLFwrwYNP25GygIuhbh9rZmeQHJ9R9P3fx0OuOftcW9tdUToC5RSwoVtxjH/rGosvh7lmxzuD
 o7xRjeE1nSWb8wsE6axcx7YyiHzManyGxbeoQ=
X-Gm-Gg: ASbGncso6P7cDHFApWI7HsbFaI7L6yoTDLl7k2E88zR/7QBV+KPriK3vsI5eoVcRSpZ
 QpvAk4iqESD1f5VtdoSKNOBDrru9GyddZPPhy8XYO9Dtv6l5xCRrydeT3Z7bDXrjuzhi7yKlneQ
 9UNa1NdSIq+WFcCfLRQZdCbC+x
X-Received: by 2002:a17:90b:4a51:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-30aac15309fmr955617a91.1.1746560991434; 
 Tue, 06 May 2025 12:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKPcHdj3HsPqgYYxFzwhWUvdvh564Q+dJ4OiiLO1Ipusowbi/yo4HWk7uN0ed5Otm1MhIZqC7RXISSF+piN6g=
X-Received: by 2002:a17:90b:4a51:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-30aac15309fmr955586a91.1.1746560990909; Tue, 06 May 2025
 12:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250425120710.879518-1-thuth@redhat.com>
 <57f21448-79c1-4d46-9a8e-f9109eb67dcd@linaro.org>
 <87jz78b7fh.fsf@pond.sub.org>
 <5d0e0b69-cbbc-4fa4-a847-fdc8603a8122@redhat.com>
 <875ximdj2i.fsf@pond.sub.org>
 <CAFn=p-ZZgRg_A=nXOLGd=S8b2g9K3FNm-hqG1Rv1F=uy4PLqEQ@mail.gmail.com>
 <67ceeed9-75e1-489d-a750-dcf1beac703f@redhat.com>
In-Reply-To: <67ceeed9-75e1-489d-a750-dcf1beac703f@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 6 May 2025 15:49:38 -0400
X-Gm-Features: ATxdqUErq7hFThEvKwco5Ze4c7U-eIMx41W_q3-nOJZ2_NziAxHgKcz-50-t5GY
Message-ID: <CAFn=p-Y3xOo95XMRNC-pSrcoD6858bkzu0cpCUqXn1MZs1vAmA@mail.gmail.com>
Subject: Re: [PATCH] Drop support for Python 3.8
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000713d7006347ceb56"
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

--000000000000713d7006347ceb56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 10:17=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 06/05/2025 00.49, John Snow wrote:
> ...
> > If there are no objections to moving to 3.9 as the minimum, I certainly
> > don't mind. Go right ahead and I'll clean up afterwards as part of my
> > "delint qapi" series in which I'd like to fix quite a few other things
> that
> > are currently wonky. In fact, moving to 3.9 as a minimum might make all
> of
> > that much easier for me and allow deeper cleanings.
>
>   Hi John!
>
> It has just been merged:
>

Yay! Thanks a lot for doing this. I lost my appetite for arguing for Python
version bumps, but when other people do it, I am always cheering :) Sorry
to have been MIA while you were submitting this.


>
>
> https://gitlab.com/qemu-project/qemu/-/commit/d64db833d6e3cbe9ea5f3634248=
0f9
>
> Do you want me to provide a patch for python-qemu-qmp, too, or will you
> handle it?
>

I'll handle it - the CI over there was hosed as well and needed some other
adjustments that aren't applicable to mainline CI, I got it green again
just this morning.

Technically, the standalone QMP package still supports 3.7, because I have
a bit tighter control over the dependencies and environments there, which
has allowed me to support older versions for longer. It's probably due for
a bump now that 3.9 is our minimum, though.

Related: Akihiko is trying to bump the Sphinx version, I want to integrate
linting for the QAPI subpackage, Peter Maydell is encountering Sphinx build
errors dependent on the version installed, and Daniel wants to integrate
python linting into make check - I have to line everything up and make sure
it all works at the same time. Hopefully good progress on that by week's
end now that I've knocked out the standalone CI issues.


>
>   Thomas

--000000000000713d7006347ceb56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 6, =
2025 at 10:17=E2=80=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com=
">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 06/05/2025 00.49, John Snow wrote:<br>
...<br>
&gt; If there are no objections to moving to 3.9 as the minimum, I certainl=
y <br>
&gt; don&#39;t mind. Go right ahead and I&#39;ll clean up afterwards as par=
t of my <br>
&gt; &quot;delint qapi&quot; series in which I&#39;d like to fix quite a fe=
w other things that <br>
&gt; are currently wonky. In fact, moving to 3.9 as a minimum might make al=
l of <br>
&gt; that much easier for me and allow deeper cleanings.<br>
<br>
=C2=A0 Hi John!<br>
<br>
It has just been merged:<br></blockquote><div><br></div><div>Yay! Thanks a =
lot for doing this. I lost my appetite for arguing for Python version bumps=
, but when other people do it, I am always cheering :) Sorry to have been M=
IA while you were submitting this.</div><div>=C2=A0<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/commit/d64db833d6e3cbe9ea=
5f36342480f9" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-=
project/qemu/-/commit/d64db833d6e3cbe9ea5f36342480f9</a><br>
<br>
Do you want me to provide a patch for python-qemu-qmp, too, or will you <br=
>
handle it?<br></blockquote><div><br></div><div>I&#39;ll handle it - the CI =
over there was hosed as well and needed some other adjustments that aren&#3=
9;t applicable to mainline CI, I got it green again just this morning.</div=
><div><br></div><div>Technically, the standalone QMP package still supports=
 3.7, because I have a bit tighter control over the dependencies and enviro=
nments there, which has allowed me to support older versions for longer. It=
&#39;s probably due for a bump now that 3.9 is our minimum, though.</div><d=
iv><br></div><div>Related: Akihiko is trying to bump the Sphinx version, I =
want to integrate linting for the QAPI subpackage, Peter Maydell is encount=
ering Sphinx build errors dependent on the version installed, and Daniel wa=
nts to integrate python linting into make check - I have to line everything=
 up and make sure it all works at the same time. Hopefully good progress on=
 that by week&#39;s end now that I&#39;ve knocked out the standalone CI iss=
ues.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
=C2=A0 Thomas
</blockquote></div></div>

--000000000000713d7006347ceb56--


