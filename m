Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08259606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RVyQjEBj;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QNEoFXQK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVb9y-0007u6-HZ; Mon, 23 Nov 2026 16:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVb9W-0007rn-Sm
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 16:00:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVb9T-00012p-9d
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 16:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795467636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3/gKHhjIqWQncfrB8193rdip+U7GW+gWCLuV80FhM8=;
 b=RVyQjEBj2KzK/MN2Mqn+N1mfYp14VfqbnE0oCVfOkPn2yCmNnQBxOIMuEdP6EPiI5ks5SV
 wpIzFdi40hVM+es1aobd92Yic8lGDH+GW//gIhpOU91yKnGoXFTJ04IOE6stcBFYjNUMSH
 sT0lp9OXxJK/KM73eCyBSnA9KDfG1DM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-JrfQ84GuOiu5FbC9sM1d1A-1; Mon, 23 Nov 2026 21:00:32 +0000
X-MC-Unique: JrfQ84GuOiu5FbC9sM1d1A-1
X-Mimecast-MFC-AGG-ID: JrfQ84GuOiu5FbC9sM1d1A_1795467631
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b41f4ca1bfso2876684a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:00:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795467631; cv=none;
 d=google.com; s=arc-20260327;
 b=sjAd5lpJKi0iAInY76nfPMN2tJ4TxOsC3h8pK7DLhQBMEAl+fPgbbARW67GFv9eDUB
 88iQfXJw6auPydgnptwexkBujq5xEUrWunSgADEHnqKz/mbR49rmEd3p8HVkTG7YCNbh
 /Ic/CCnIfru17nheQYOrSZwF3fm7WNi9wnop7xSuQIStXbreFhJDko+D2NkJdlgbddFm
 uTxv5Dph6wUQX70qag6Te2apTxr7g1GSQ0ZZPh/AYXp7wByv8i7Y4kHYugUniEzPm5B8
 AU4Y6pf3b3XIdwt5N4rMjHUXF/Kn59EPgFkYXsMgS9Pyvg+4DEAv6YB+10SnN0I6mWwC
 2OkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v3/gKHhjIqWQncfrB8193rdip+U7GW+gWCLuV80FhM8=;
 fh=4AscduIS2U4s83XIiAurb9xqUN1CshjIHynfnbSP3QE=;
 b=gwfNxYWtYxrJJEQjMpgEcibIHCTGXe6e+XsrHcoo8NfP/dmkJxXszQepA06My9lt3A
 /1OeXtjXe19tQijTHqxMhrJ6KZvoqLUG6Mbd9R08s8osKUoD4yjVFOoldT2IGpZyk+RM
 Quv3+RwT7xJwGKD/lqPDoA7E0zjvbX/ZH9gdcGjzkrx5ddBNypydPK7yOEv2NANlh6s1
 a4Nkv36NmEF7KxX7/6rvX0/PA1EL+JsX47myW4Zu8MuJWXyq9iS4M92TRBWfjkrJ6+fV
 IbiBaOfVqrlTpwLYLc9+zLRw18O8KjxiT+JyjD+lALmGA+Pi9qtpIBigw4+LUi0Lthq4
 U0Mw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795467631; x=1796072431; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v3/gKHhjIqWQncfrB8193rdip+U7GW+gWCLuV80FhM8=;
 b=QNEoFXQK4M0kvCw4x1ApSfuImJnYlz+y9EvUa3YjsvYcp6Zgr4bh+PWWW1znBB+W/D
 r1b4b7BJa2gUyODIfwdk5r4jLauorzVcBHjviUJ4+JOUKp9Ous66134sq980Vp7FN7lE
 qJgJaKnJ7lCtI7iEznbNO0GRvHKo/tyC/G29i+LbeYlorkCZW+Hq0Xj2AmkxyDdTGiYm
 /1fMdy/hP9yd/B6rEPnXBAqV4ERnknZAONMi9doYrLr/UQtz0q0kjYEFWc18GS+8H9FN
 tzQvfa0JEOuyLCvP4SP9PD2Lxf8yJZ3iPqy8/33yw8jLLoTwqx/IFgjBOgaSvD7PbCeW
 dbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795467631; x=1796072431;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v3/gKHhjIqWQncfrB8193rdip+U7GW+gWCLuV80FhM8=;
 b=2vHZIbI2yhp7nkiYXlQi31SP2nyOscGKec7hY+BxQJaba8nJ868l1qfLa0wb9ECB/2
 BWMsDZBvjafSbQu2kD6EsPrwlY2fMNwfdWGYHmwfggDY9KmmTWOWe7M94jsgaRZcgiNG
 3MGBfmYLc8a5cqWben5xmkxCxVP57m9yuXl08u1ORCtULrTGHIvQElqB4Co3+NM3oe86
 XKigwRU2ycfSTn+UwJsmbrpoap2ESZ5r3UcKbexB/sW+jLkxZJtvKo1s146zudxo3qRX
 3Zaw5cV9ODj8XAVDCgkR2bOiBVzk1B1hwJ0AqfiedqLD8fdR4nR5ucHbbQvCt0W1KZfI
 UecQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHUDhEr+q/7Hf4x7jX0pTbWLviuN19z8S1lH6Ibjoxi7wmLO4ARN1diVSWD9UtU2IL+NioqrLyENMm1@nongnu.org
X-Gm-Message-State: APuU4Z+fIrE+0XdIl2+6XW2nSavuDC2KUnH44iUYLCK9ceLaetoGenOh
 3VBNJJ2yeX+ZS1nk0VlLKWM61JUoZX04T+nbF8S2F22nW1xQ57MGv+qW6J4WJft3o1HPq+ye6Ei
 RoilWIuggDBOLs2Mn2BfNvxfj9NdHXV9Go2xBIk2AkjFZq563rj2eZ4KbrBuahhEGFz9csWiy2Q
 blltDPo96aos7xSF5h2Vg3eylLTzZ/IJw=
X-Gm-Gg: AZFdTZf4licoCmQDP/YsJdHv+cY3LdTR9HNEZH/1nUMX9JAHKi+ZDdX90SzsjjllRPy
 UhsDh0GnZtABnREtQ0xuF0BauqxXU6+HcxF71oDjtlc6DDacGtbwcK4Jgjw36wVZ/tXjcReFih8
 YXVvtgoyL84cQKtcdz0mLtYn1o8vhhfxPhyojUaJAwAj21O2Dlta1726rbrE/2rOszMvODI3amy
 Gy2kBi0tQeN1XxDy2WEyjge1p+2NBt1kdHWQy48YOMvvf+fPTqZmjZi2Ne+HyHUiRxmHBX7eSpi
 6jBOH/PJiokPuR9pPlqY
X-Received: by 2002:a17:90b:2ecb:b0:3ac:8446:c1a5 with SMTP id
 98e67ed59e1d1-3b41c988620mr10508715a91.48.1795467628961; 
 Mon, 23 Nov 2026 13:00:28 -0800 (PST)
X-Received: by 2002:a17:90b:2ecb:b0:3ac:8446:c1a5 with SMTP id
 98e67ed59e1d1-3b41c988620mr10508681a91.48.1795467628390; Mon, 23 Nov 2026
 13:00:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com> <87ik21vy11.fsf@pond.sub.org>
 <CABgObfagz=EvmYtNFBo2xyDdXNkFPK8k0-YGDs7aVS6xRKEJTw@mail.gmail.com>
 <awQisiKRYpQSTmVy@redhat.com> <87a4mzwuqp.fsf@pond.sub.org>
 <CABgObfaELn80BU_b9CjaTqiHx_tCj+8hSh+59FpUk33+osBvDQ@mail.gmail.com>
 <87y0ajuw9j.fsf@draig.linaro.org>
In-Reply-To: <87y0ajuw9j.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 23 Nov 2026 22:00:16 +0100
X-Gm-Features: Aa3M54qXGj3Iv_-hQpAquxBDGO-fHGPP8AfzXup4AEAbLbGYuyWLuPTP3RTmpdQ
Message-ID: <CABgObfbb-+zmxeV5rjLM=7cXAZUqpGr84kBPTfnysiLc+crL-w@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000324e850660f7e202"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000324e850660f7e202
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 23 nov 2026, 21:29 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scri=
tto:

> > On the other hand: people are already reviewing *clearly* LLM-produced
> > patch series (example
> >
> https://lore.kernel.org/qemu-devel/CABgObfbKKSoO1NsyygXUT4O1b+aPZ0SRNUGU5=
5pcQphR5s81aQ@mail.gmail.com/T/
> ).
>
> clearly? My reading is the cover letter is thorough but its not giving
> off LLM vibes to me. I've only eyeballed the patches themselves but they
> seem thought out and split into nicely re-viewable chunks. If it is AI
> it certainly seems to be in the hands of someone who knows what they are
> doing.
>

Sure, no doubt Denis knows what he's doing. But the commit messages are
certainly AI (I have just checked the cover letter and three patches with
pangram, including one that didn't give me immediate pause), and there are
certain aspects of overengineering that give me serious doubts about the
code.

In that respect a clear policy would remove all of the pressure to wait and
possibly ask later for forgiveness, and would let us provide clear agent
instructions without being hypocritical.

Paolo

> Doesn't that produce the same kind of peer pressure on core
> > maintainers, in fact even more so because they are not warned in
> > advance?
>
> I certainly prefer up-front declaration of usage because it would inform
> my approach to review alongside the experience of the author.
>
> >
> > Paolo
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--000000000000324e850660f7e202
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 23 nov 2026, 21:29 Alex B=
enn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro=
.org</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
&gt; On the other hand: people are already reviewing *clearly* LLM-produced=
<br>
&gt; patch series (example<br>
&gt; <a href=3D"https://lore.kernel.org/qemu-devel/CABgObfbKKSoO1NsyygXUT4O=
1b+aPZ0SRNUGU55pcQphR5s81aQ@mail.gmail.com/T/" rel=3D"noreferrer noreferrer=
" target=3D"_blank">https://lore.kernel.org/qemu-devel/CABgObfbKKSoO1NsyygX=
UT4O1b+aPZ0SRNUGU55pcQphR5s81aQ@mail.gmail.com/T/</a>).<br>
<br>
clearly? My reading is the cover letter is thorough but its not giving<br>
off LLM vibes to me. I&#39;ve only eyeballed the patches themselves but the=
y<br>
seem thought out and split into nicely re-viewable chunks. If it is AI<br>
it certainly seems to be in the hands of someone who knows what they are<br=
>
doing.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Sure, no doubt Denis knows what he&#39;s doing. But the commit messag=
es are certainly AI (I have just checked the cover letter and three patches=
 with pangram, including one that didn&#39;t give me immediate pause), and =
there are certain aspects of overengineering that give me serious doubts ab=
out the code.</div><div dir=3D"auto"><br></div><div dir=3D"auto">In that re=
spect a clear policy would remove all of the pressure to wait and possibly =
ask later for forgiveness, and would let us provide clear agent instruction=
s without being hypocritical.=C2=A0</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">&gt; Doesn&#39;t that produce the same kind of peer=
 pressure on core<br>
&gt; maintainers, in fact even more so because they are not warned in<br>
&gt; advance?<br>
<br>
I certainly prefer up-front declaration of usage because it would inform<br=
>
my approach to review alongside the experience of the author.<br>
<br>
&gt;<br>
&gt; Paolo<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div></div>

--000000000000324e850660f7e202--


