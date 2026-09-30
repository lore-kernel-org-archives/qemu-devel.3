Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABFBCA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBzZH-0001wa-5Y; Wed, 30 Sep 2026 15:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBzZD-0001vm-Kn
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 15:02:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBzZB-0000p9-50
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 15:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790794927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srmT/TltqtmhC4xk6QwvuvbLJHjuUGlXHWGJn50u2Lo=;
 b=NJrBWFPRfDzOkFq/itb3/9NXfO6bm0z2gh3HVQdyCsUq37wdqRODvgMYgUG8x5Dq+j9XPh
 J+Sgdf0bfWtfkaRHpG7EK1wEjju9VvzIYglhEW/DxfAjg7nCL89LKYYW1bIW3ThjBg8qTX
 /DjrxaFuT/UiZoNIQL8eKxl2+uV7300=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-hwxFmjY9PEiDuXBW6tuNZA-1; Wed, 30 Sep 2026 15:02:01 -0400
X-MC-Unique: hwxFmjY9PEiDuXBW6tuNZA-1
X-Mimecast-MFC-AGG-ID: hwxFmjY9PEiDuXBW6tuNZA_1790794920
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48589603501so3943801f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 12:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790794920; cv=none;
 d=google.com; s=arc-20260327;
 b=nGD5fDs6+8jMvciS+G/RAXGaBWKNhCjH2DgIfx68IFHFkayuA7REp4K0d66/EbJESu
 BAxjb6+BZ+y4ohBKHXnVJreCL15LjNxv1tOokV3Leb0Dht4N38DbzndateyZeiMYBay2
 gdJGKD5b3kaEGa6vywWS/ZJgScm5vnkVWyhngviXyxU+/3u+ynbeygqtMu/Q0hT89k8m
 GLp1MdS6bnQMaB3eRuJEv4+nGSrRPTTtiH+T7AN3ZENi8zbRiqD/mTfh/S2DO7m87FTr
 HDnIdmvUmRPN0pJKt1azme9PjR4jdAdoVDVm42u5MCPUeIiNmshCdWwxCfasTivUDeRM
 wrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=srmT/TltqtmhC4xk6QwvuvbLJHjuUGlXHWGJn50u2Lo=;
 fh=ky+sQDerw8rIVSD/AQNaMoWpHx8PBP1L1z2SxHR/Pyg=;
 b=a4aPCoM27ImzvEC4biA9ntRRSLB/Csm45FrLqW5xgUjiDXmFd5FF94iZIlIjlo9Cue
 nxuJPsIgIx3hDiEFpTb1w3w4l/f1l6SC57FeCp9GFCAKEci2SWwjJiYVk+cKoZQ7QJOU
 LztvyxiHH2NXRkQpvk6xhvBAryW7MSma01jhAN3FPgJw5Porru1/Qv4MJoOUmsBQ1460
 RjHKmVAg1tHdb8L9vdPWIgEDvkD0srGWGH7GEu8g97Gn32eKbcGADKFvxHPWX6Hmu/FX
 pFRg+/U5H3rPU2AZFHPnCOc6U/nSQa7esAGViKJsROGwGIoZfmc54nqPZ1jlcLaFAuT+
 ed0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790794920; x=1791399720; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=srmT/TltqtmhC4xk6QwvuvbLJHjuUGlXHWGJn50u2Lo=;
 b=c1utEOr5isCa2sJkCJKEhnNTu0vF2isfyPgzahwMGktymJfxk1CQE5P88W2rjqK5X0
 5Dw/Z+cQa6mtS2M42FGgI5JXshftJ8YWwYehgyUzXqXKYCquttYCDK5G8zRbuJhebtxT
 c5tkRTPGLq6lzHFZ3CF4uoEQ7+i2PFaPbMBCqfMp51x+Nglezl1Ck9mrbGs7YW2Csrie
 unUCw7vMSFg31dsmZNxqCWZvNO5tV8DFerDu661PaNvsJdUiAzvlkZydfupxdpjuN5Pi
 WB5ncsCzUxWUaXNntsUD7SkH3txp1mP4ySTzHSxJgeGeno0Bl3wht3tKLFM3y1Ye3cyz
 IuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790794920; x=1791399720;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=srmT/TltqtmhC4xk6QwvuvbLJHjuUGlXHWGJn50u2Lo=;
 b=SAzv0msfjjaE2yHGNMOOiJTNZ5QjaUa4J0qQLmRY45Msfmrf6dNlRX4r7N1LXW6f+m
 Sxa6Z1h8say3VrkjPry+uBNRJKPHb9io9bC8f86odrspnGZ0zcbdw47QBchRaPqxpFhF
 zFepwWb0dL1AAsFGv/o+vJVJWjXJNCIlghTBCf8SlcYdt3n7OJMTF2OD7JBSyIrzrx9j
 A/1CjRohc5JQFLL1bwXx3jQpGV3YCZhTx2RNe8A4dupU6BaDPFrjuvRamX1AjFCQGTsG
 oGcVnfXyyVBjltEtwXaOyHSUj9EWCxU0A+IRGfWQGXTHMFHqvuH2srX2fIze5jXbUbCv
 Rh3A==
X-Forwarded-Encrypted: i=1;
 AKwUvByG/SqrFH/4rqkID9BstkgiEd0hkuM74EURsJdBG35MwckwMIeAUrQYVoL+uXKpGwb9uVqIoDGMVKXw@nongnu.org
X-Gm-Message-State: AFq9FYKRc0aM/sV48nMs7AfHgzGYRDQOMZvrD+N8wmB5EAD+MRhgv5V9
 Wj+uQuDyZeqhzxxiRhA6QTYlCcNQAjeDolewEVRy/N9nuICP5UR6uDMwZHXdwFsJsT8IbzBofr6
 hWJI/nUfJyT5F05FoI05wJ7KHIGkACgaV1VDB2pGvmhBPVDzZ0AUVqflXBd9GnC4VcoGdnQHc5G
 O6aYp891/d+Ef8B5w5eo4jtcYi12Y3Bpc=
X-Gm-Gg: AYBFou2X6lXK8WmcQW6u31IFKoxY3M3ChD0mozdjV8Fjx6zDNZcSuh1WNdQxpj/Re/h
 1wnmbNRXI0u0+hawZ0tji0XqwCi5rdS4g1OW2Pc2/qqaTeRIx488SgujGZ25DwX/VUaN8H4DTOX
 SxW8yOiJGHF0lwI0DUM3KwOio2gDHyxe/JAlp0asnFTs9/u20QjrDSAjQTPLpfKqHEP9mT1rmC2
 Wc27zcnhhNszza99lcoC/jOh+vZPE1bwWGiLyp1wZF7KxzPcXtdFEv+kF1Kdg==
X-Received: by 2002:a05:6000:3c7:b0:48a:f073:336b with SMTP id
 ffacd0b85a97d-48b025023bemr4801564f8f.23.1790794920192; 
 Wed, 30 Sep 2026 12:02:00 -0700 (PDT)
X-Received: by 2002:a05:6000:3c7:b0:48a:f073:336b with SMTP id
 ffacd0b85a97d-48b025023bemr4801529f8f.23.1790794919815; Wed, 30 Sep 2026
 12:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <05ace2dc-5e44-4f4a-8254-4f9459bdef1c@oss.qualcomm.com>
 <ar0KHoufSW4glOzO@redhat.com>
In-Reply-To: <ar0KHoufSW4glOzO@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 30 Sep 2026 21:01:47 +0200
X-Gm-Features: AclHuK-ly38L9usr4IIqjGVarXSS-kg-skNh6tsAw2PBrQN5QNsdud_isxKlJoA
Message-ID: <CABgObfa5+53aQcLLFK_n8CvHNiCBTik8wjGErcjXFKX3hm0XBQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>
Content-Type: multipart/alternative; boundary="0000000000000fca4e065cb7efde"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000000fca4e065cb7efde
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 30 set 2026, 15:09 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> > > +     AI-used-for: tests, docs
> > > +     AI-used-for: code
> > > +     AI-used-for: code (refactoring)
> > > +     AI-used-for: code (prototype)
> > > +     AI-used-for: research
>
> Do we really want to include that last one "research" ? In that scenario
> the AI agent is not directly authoring code, so nothing in the commit can
> be directly attributed to the AI.
>

I don't recall specifically where it was brought up... Perhaps something
separate from "code" makes sense for extremely small fixes but I agree that
"research" is not interesting anymore, given the meaning that is attached
to the trailer since this version.

I'm not convinced "AI-used-for: research" has any real value other than
> to demonstrate how much you personally  rely on AI, and I don't think
> the projects needs to care/ask about that.
>

Maybe it was intended for patches attached to security reports or something
like that. It can go though.

> > +``AI-used-for`` should not be included for "background" usage such as
> > > +autocomplete or obtaining a pre-review of the patch.
>
> I'd be stronger and say  "AI-used-for" only be used where some part of
> the patch *content* was authored by the AI.
>

Yep.

Paolo

--0000000000000fca4e065cb7efde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 30 set 2026, 15:09 Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0AI-used-for: tests, docs<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0AI-used-for: code<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0AI-used-for: code (refactoring)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0AI-used-for: code (prototype)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0AI-used-for: research<br>
<br>
Do we really want to include that last one &quot;research&quot; ? In that s=
cenario<br>
the AI agent is not directly authoring code, so nothing in the commit can<b=
r>
be directly attributed to the AI.<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">I don&#39;t recall specifically where it w=
as brought up... Perhaps something separate from &quot;code&quot; makes sen=
se for extremely small fixes but I agree that &quot;research&quot; is not i=
nteresting anymore, given the meaning that is attached to the trailer since=
 this version.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">I&#39;m not convinced &quot;AI-used-for: research&quot; has =
any real value other than<br>
to demonstrate how much you personally=C2=A0 rely on AI, and I don&#39;t th=
ink<br>
the projects needs to care/ask about that.<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Maybe it was intended for patches=
 attached to security reports or something like that. It can go though.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; &gt; +``AI-used-for`` should not be included for &quot;background&quot=
; usage such as<br>
&gt; &gt; +autocomplete or obtaining a pre-review of the patch.<br>
<br>
I&#39;d be stronger and say=C2=A0 &quot;AI-used-for&quot; only be used wher=
e some part of<br>
the patch *content* was authored by the AI.<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Yep.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Paolo</div></div>

--0000000000000fca4e065cb7efde--


