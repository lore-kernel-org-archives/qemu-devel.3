Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B86E83836
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs5yR-00026U-Gu; Mon, 16 Feb 2026 16:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vs5yP-000261-LG
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vs5yL-0000K5-7h
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771276654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h1bxu+86xj+IOt0/KPKiUqdTxBahvMJ495rPtCFK2WQ=;
 b=PGVt2T1AJ0tk65llLc0I9KQRtDS1GqccvJKdhYvsRNVxrYUVXVpFP6mNV1eilw4bvorezy
 P5YXDZnZdHApT+CezKm3In8V0KcjsOvXvjwKAnV+HxsrrW4j9+A30Dfxswm5XcS52tEgM/
 +ZQqqbGYHm46aBWgcbZah8IQG8ox1wo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-aS8Sm6u2PQOXWsma-OqTEg-1; Mon, 16 Feb 2026 16:17:32 -0500
X-MC-Unique: aS8Sm6u2PQOXWsma-OqTEg-1
X-Mimecast-MFC-AGG-ID: aS8Sm6u2PQOXWsma-OqTEg_1771276651
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-437812b8bb0so2283021f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:17:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771276651; cv=none;
 d=google.com; s=arc-20240605;
 b=JgcGSGfllpA+NYPV9xIxjYkGGtn5la9YgcuBfMiFsYPwSKYOvqyKGA7A5H+wcLiekO
 jcrhrPFihyg39ukazRfRdq60UJ1KfnPlxEcM/wYq18XP2o3bS6Yr5tXfk/6/eCiLzoNU
 U7X9LMbX76fjmv1rJA/R+jmLtZ/AqIwLVpnncVDponmZCz1TUaja/W32+aQFy8RCoomy
 i+fnV76LHTo2Q5geQb4toznEX2Uz3vB5h/5xrrz4rP8fjBryoY7QBjl8sBo1dBpxbHKf
 vt0AncgzhD3px91HMSqdObTAoP0oxFaZepzNqHdfiaVMM4ku/z5nsxuLwAcKGQ7GFJGo
 N+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h1bxu+86xj+IOt0/KPKiUqdTxBahvMJ495rPtCFK2WQ=;
 fh=hbOf+wyGWDNz/eqoakqaEQWKbaYh5a4agphNdyKZTwo=;
 b=UWeYU64D815uaDGZ+p5GNM+iS+tMsji56FdVWjgWJrmBui4ZdfKlFGGep7xWYarnIj
 Zm/BkhJom/p4/BF2V4Hm+rAsD5Ki9CLEHWBPto0iPQ96nFvmHX2DLS798HUOjLaL1ecz
 IGCwm4s6TejG5HZxiSIMRCCvK5bhClUH40kDnLajh3HQhxmlwTJH1tCpjlkXWeqsY34G
 7bIgDVhn47QWVMFKEriGK5enajwnutVwxFyPPrnvZzGvIqXXLNYiAa7HD2S49wQQUl8k
 Y8d7BLXpPO6O3gPl9fasKfGmC02L7/QBDDsvsKu/KofA7MIzerorbyyo5mVZD0skOOG0
 Za9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771276651; x=1771881451; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h1bxu+86xj+IOt0/KPKiUqdTxBahvMJ495rPtCFK2WQ=;
 b=KX5oCMaF7PSLD43YPgtMjcOs+zf1dC5axcON6maNnXzAFlYNlCcME9T8l9FmmR44i+
 0rhM3GXxL0juG9uwGs4lcdD50VME4RE6YVZ8nrD0I7GJk+qRvJxcoy/Y/cF6bdhNz6ha
 Loukig25G6INiyDMXLnUsdyDxnGWSBCz7Ie64Syp8xbvF+b0rpL5LC4/jSkulEp1YCTQ
 Ckqe0DBrvIv0v16dD3kAIq5CYjmeX4KOQ5sTis5NUHYQ8xSn4KxP3G8H2EMhs1RbT+Ct
 P2dAv6fK/iY8azYIGpHjMuj597JHLwaQjjFbyricH1CLn1C0V9GnSuLv2kvPrjKPSU8d
 Oygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771276651; x=1771881451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1bxu+86xj+IOt0/KPKiUqdTxBahvMJ495rPtCFK2WQ=;
 b=TUVArVjtPbd/qwBVQ5RpxTsy+XZ+WYsTYOx183mckz7jhPmekMyKGNv+DYa3dS9y/U
 N7MvLBUEliYFa8nNTyU6sraHe0ol8jiTrP/ZeiZG7D9v0r6USnqhr4DjhMxgZhGRJM+Q
 rYHg7oQ2kyY/jUJHMEULcuckStewn4iqH7kpVIYqNO08ek997semYGRxdb+LMwuYoVXZ
 vY9QSHDkai/Btk1lvSPo1mMKkVNYRvWymW3uX9IQtB4IG0OLeq7KJTm6JN9ghjaJcRkf
 SP0CQvkaco1gSngtedSUedAV9vfxx7ODC23Gf5LKkk21r88+e2awv2pC7fN8V5zmHF5a
 qtgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg9tAbsCjG/1ae9SbY5yKD/m+ThTV53CyvL6xKSQUxEjxbe4Y7xohVQpBONNqn+2kexYAEjBi+kuqs@nongnu.org
X-Gm-Message-State: AOJu0Yy4vipIAlrWiDaMJNBeCLpLNAVyFVTy0FwqBrCOSnoVqKpnuWlQ
 0YkZR4nOAktg5VWS/OLhk+uRUuuKdvg3nAXDJdPcO3SrCnhQMg9kdMhZDpwfEUXEBrTp9C7Hy6F
 KTE+9FiM64J4lHmKE28p28J2PRR5WEb6QUyM0Wz/B+sizFH4a5o8vPOZySa+K2EYDY23KpeOo4+
 u8jfQIi18HmH9via638XJ19FqTtjetLpk=
X-Gm-Gg: AZuq6aJd17ZscQico9zyBxMf0lj4BxooLIQsKzDEloj9reY1y+WukuKkxo2cM11zPTu
 6pdAYZR+YXxDrtn3iFjqF8OkBp3+q6YwadlDt2Eh2AgzclQGspw6OG20ISqK/5qeNht9Wv3DtHb
 a2n9kIFhc5667ZvCzyGRMi+S+Kxu7fx86lNkqUvVUFmGIhzPd7NYiRnq/aQL8F9BqlzQhOYM62Y
 7G1HExwVvEYG2/hlhOT2RF7L6hGPxIaf2fFBK/XkWhqWyOYMxhFARDoOANcyQteUULFpJvBjpVw
 gO0UDiI=
X-Received: by 2002:a05:6000:1447:b0:436:1a24:df81 with SMTP id
 ffacd0b85a97d-437978c0a34mr19560912f8f.2.1771276651027; 
 Mon, 16 Feb 2026 13:17:31 -0800 (PST)
X-Received: by 2002:a05:6000:1447:b0:436:1a24:df81 with SMTP id
 ffacd0b85a97d-437978c0a34mr19560887f8f.2.1771276650595; Mon, 16 Feb 2026
 13:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-8-philmd@linaro.org>
 <252b2fa2-9251-3949-625b-7071c525c8e2@eik.bme.hu>
 <56a0f465-2055-4c82-b0c0-963b376609e9@linaro.org>
 <0492fc65-e156-1afe-ea72-520134ccca41@eik.bme.hu>
In-Reply-To: <0492fc65-e156-1afe-ea72-520134ccca41@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Feb 2026 22:17:19 +0100
X-Gm-Features: AaiRm52r8AERNtU3pb1CBJu0RI5idNo-YJXqK58U1J3izgS3UOqpEpdbdWVul3w
Message-ID: <CABgObfZpxHmdmX7La7kQLRWY0=nPZSysOYiJsU7h99JEgzio5A@mail.gmail.com>
Subject: Re: [PATCH 7/8] hw/ppc: Set graphic display dimensions generically
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Chinmay Rath <rathc@linux.ibm.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de" <qemu-ppc@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000008ee20f064af77b98"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000008ee20f064af77b98
Content-Type: text/plain; charset="UTF-8"

Il dom 15 feb 2026, 10:51 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:

> >>> +void ppc_graphic_dimensions(int *width, int *height, int *depth)
> >>> +{
> >>> +    *width = graphic_width ?: 800;
> >>> +    *height = graphic_height ?: 600;
> >>> +    *depth = graphic_depth ?: 32;
> >>> +}
> >>
> >> I think there's no reason to have this common to all ppc machines.


I agree with you here that it's better to just inline this in all the
boards that need it, because there's no reason to have 800x600x32 across
such disparate machines.

> Can you provide a patch showing how you'd prefer it to be done?
>
> Maybe turning these into properties could work. I could look at adding
> such properties but don't know how to change the -g option. But
> considering these are all machines that Mark maintains maybe he should do
> something about it


I am not sure what you'd be requesting of him?

The easiest were if he agreed to drop -g option but he
> never agrees removing anything


Not sure who's he? Is it me since I asked Philippe to keep -g, or Mark? And
if it's Mark, I am not sure what you're trying to obtain by involving (and
in a pretty rude way, too) someone who's not even part of the thread.

so then he should provide patches to clean
> this up the way he prefers. I could try to make patches but I'm afraid
> those would become wasted effort so may I only do it when there's an
> approved way that will be accepted.
>

The -g 800x600x32 option, if desired, can become simply a shortcut for -M
gfxwidth=800,gfxheight=600,gfxdepth=32 (or
gfx.width=800,gfx.height=600,gfx.depth=32), which is more similar to how
smp or boot work). This would actually be easier to implement with
Philippe's move of all graphics_* accesses to board code, so his patches
should go in either way. And then the globals can be removed altogether.

Paolo


> Regards,
> BALATON Zoltan

--0000000000008ee20f064af77b98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il dom 15 feb 2026, 10:51 BALATON Zoltan &lt;<a href=
=3D"mailto:balaton@eik.bme.hu" target=3D"_blank" rel=3D"noreferrer">balaton=
@eik.bme.hu</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
&gt;&gt;&gt; +void ppc_graphic_dimensions(int *width, int *height, int *dep=
th)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 *width =3D graphic_width ?: 800;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 *height =3D graphic_height ?: 600;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 *depth =3D graphic_depth ?: 32;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt; <br>
&gt;&gt; I think there&#39;s no reason to have this common to all ppc machi=
nes.</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
I agree with you here that it&#39;s better to just inline this in all the b=
oards that need it, because there&#39;s no reason to have 800x600x32 across=
 such disparate machines.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">&gt; Can you provide a patch showing how you&#39;d prefer it to be done=
?<br>
<br>
Maybe turning these into properties could work. I could look at adding <br>
such properties but don&#39;t know how to change the -g option. But <br>
considering these are all machines that Mark maintains maybe he should do <=
br>
something about it</blockquote></div></div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">I am not sure what you&#39;d be requesting of him?</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">The easiest were if he agreed to=
 drop -g option but he <br>
never agrees removing anything</blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Not sure who&#39;s he? Is it me since I asked Phi=
lippe to keep -g, or Mark? And if it&#39;s Mark, I am not sure what you&#39=
;re trying to obtain by involving (and in a pretty rude way, too) someone w=
ho&#39;s not even part of the thread.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"> so then he should provide patches to clean <br>
this up the way he prefers. I could try to make patches but I&#39;m afraid =
<br>
those would become wasted effort so may I only do it when there&#39;s an <b=
r>
approved way that will be accepted.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">The -g 800x600x32 option, if desired, ca=
n become simply a shortcut for -M gfxwidth=3D800,gfxheight=3D600,gfxdepth=
=3D32 (or gfx.width=3D800,gfx.height=3D600,gfx.depth=3D32), which is more s=
imilar to how smp or boot work). This would actually be easier to implement=
 with Philippe&#39;s move of all graphics_* accesses to board code, so his =
patches should go in either way. And then the globals can be removed altoge=
ther.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
BALATON Zoltan</blockquote></div></div></div>

--0000000000008ee20f064af77b98--


