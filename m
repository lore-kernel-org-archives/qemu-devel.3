Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC5DC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 17:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tduVn-00071W-FV; Fri, 31 Jan 2025 12:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tduVl-000717-MB
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:08:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tduVj-0006J3-R3
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738343333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IWQCLl3kdLGmw4xtmFhOHgTFSx9pNJOpThTOnPW9iMY=;
 b=P/OMHevCl95fanZfrK63zQCnkg8Gk7SaHSTniAoTofwDuxEMWOgzYSue/RjiHB1GjVGLoi
 ynXrwugSDvD3xx+y4Piu1C03WxkcUJdOQCIjxnScc4gK9qbff5pAtiGN0QJ98iMnI9nl0B
 6K31auUyB4r5KEOTQanH/ztPbae8sOI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-76-eB2uiOLmVZ4QpoEX-SA-1; Fri, 31 Jan 2025 12:08:46 -0500
X-MC-Unique: 76-eB2uiOLmVZ4QpoEX-SA-1
X-Mimecast-MFC-AGG-ID: 76-eB2uiOLmVZ4QpoEX-SA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385ded5e92aso960771f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 09:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738343324; x=1738948124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IWQCLl3kdLGmw4xtmFhOHgTFSx9pNJOpThTOnPW9iMY=;
 b=gPy0O+PuYefinJxAr6kVHEIhtk981+UJUaYDQ3zBiyv2PBhVN5oLga/iwkc2jqnEaE
 Lx/J/xoyVFW1Y/wwhRdr+d3LiqzjL3fhzQEJe5DO3PxXFnG0INUvfC0Hbia6dXy/tMTI
 8Cb0coJUV1yEiHU2zCcNF0LyzLCJibLrfj1saeA2dVx0BaYXtYvIMowwDS3BKs3zygRA
 F8aos70J7k2CrJtERgOJV5sk393VCdIwMxucy9vIJMBX4h1rmbCpUGOSP94grMZmWi37
 KR0b1E+p3vYEhj/5RBP2Kcm70NUEcWVtmQWY9KT5kEEBSLhoz5uXcMNv0HTQZ1AdppsT
 dFJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUbCUZKZlasv0f8xPKCnZOP1OdqJ7mnEK+2QPkRqX7gZI5ChVg7vrCdwi2+OL75zZRTRCZz5dM+xDN@nongnu.org
X-Gm-Message-State: AOJu0Yw332b0YJQZ6GYR7njqzf7k0JgcYyH4KyhJZnUx8qgBe8PaL8ih
 9J7m7M1jn4YDIWVKilGlUa+NLHaddHYpuJ7CjP1mffqogkVIhxMgdnWA6XgAdSZQg8Qfr8f8UW9
 BAO7cyTs1+q2eJj47zc4b/6kXnLlBFqhypyKvRMML/Z3SMrf8if7sPLcSANYjSCiH0pE2RKSErN
 ENdFF3qByRMds/GGBJJ+1r3JqcKqk=
X-Gm-Gg: ASbGncv8rzEf0n9g0ArXd1CxscB3PTJwKGgczxLKzZvupxmML6BBCEhi5U+hC5Cab+K
 pXBjRbUSyEW+b4sUByRAMA3tXGXBIFHUwHhci7aStOYOqlqFj1QbrrTcdW01x
X-Received: by 2002:a05:6000:1fa4:b0:382:51ae:7569 with SMTP id
 ffacd0b85a97d-38c5195df76mr10909600f8f.18.1738343324297; 
 Fri, 31 Jan 2025 09:08:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8wOoYvDOez9UxpXmoMLD/m/WI5HVgHlwYfEgstcpOrYRsJ8xGHi6lI2dz/y8Y4RYblE0CTeJb9S9nkPjjHr0=
X-Received: by 2002:a05:6000:1fa4:b0:382:51ae:7569 with SMTP id
 ffacd0b85a97d-38c5195df76mr10909558f8f.18.1738343323898; Fri, 31 Jan 2025
 09:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
 <Z5ii-ueFt5-5Brxz@redhat.com>
 <8c0eea44-d0bf-4b86-9b1b-1c2082ab2df9@linaro.org>
 <9bf6d4b0-7a89-4110-a1e1-46bbdb2fc793@linaro.org>
 <c13e207e-06a5-4f40-b319-f4f2e59d919a@redhat.com>
 <CAFEAcA_CfVfypS5yUtT3V34CDxmAqx7wYnDoKPfHq-o=54GgAg@mail.gmail.com>
 <8a54600c-ff3f-42dd-b164-62a57de867df@redhat.com>
 <62449bfd-eb65-41d6-ae53-0333bcb603b3@linaro.org>
In-Reply-To: <62449bfd-eb65-41d6-ae53-0333bcb603b3@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 Jan 2025 18:08:32 +0100
X-Gm-Features: AWEUYZlnrBBTgL2xGyPuulkfcAjO_1-axyVCW62fI5fgMA99HEown4Chg-0TqSg
Message-ID: <CABgObfYvYWxua7_TwYzWH99N5pR92Vsmv8Q=57FU_g5wSwmacw@mail.gmail.com>
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, "Hajnoczi, Stefan" <stefanha@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liviu Ionescu <ilg@livius.net>
Content-Type: multipart/alternative; boundary="00000000000051aa1a062d0398b2"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--00000000000051aa1a062d0398b2
Content-Type: text/plain; charset="UTF-8"

Il ven 31 gen 2025, 17:46 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 1/29/25 04:47, Paolo Bonzini wrote:
> > The difference with TCG of course is that TCG is in active development,
> and therefore its
> > 32-bit host support is not surviving passively in the same way that a
> random device is.
> > Still, I think we can identify at least three different parts that
> should be treated
> > differently: 64-on-32, 32-on-32 system-mode emulation and 32-on-32
> user-mode emulation.
>
> Why the user/system split for 32-on-32?
>

Various reasons which overall point at 32-on-32 system emulation being not
used very much.

1) 32-bit has the address space size limitation, which makes it harder to
test even moderately sized (2G) guests.

2) I might be wrong but user mode emulation has no equivalent of the
forced-64bit hwaddr or ram_addr_t types; 32 bit is not very 32 bit anyway
in the case of system emulation

3) 32-bit virtualization support only exists on x86 and possibly MIPS

4) system emulation is used mostly on development systems, whereas user
mode emulation might be used on small systems to run short-lived
proprietary programs

5) for those 32-bit hosts that have a completely separate TCG backend
(well, that's Arm), getting rid TLB accesses does eliminate a bit of code.

None of them may be compelling, or maybe deprecating only one of the two
don't really make a difference in terms of maintainability, but this at
least makes the case for 32-on-32 system emulation a lot weaker.

More specifically, I don't believe anything other than 32-bit Arm hosts are
in user and for anything but user mode emulation, but those have a nonzero
chance of being in use.

> We could and should remove 64-on-32, maybe even without a deprecation
> period, but the rest
> > I'm not so sure.  I don't know enough to understand their maintenance
> cost (other than the
> > mere existence of the 32-bit TCG backends), but it's certainly not
> comparable to 64-on-32.
>
> Ok, lemme see how easy it is to prohibit configuring 64-on-32.
>

Probably very easy, and I would really want to do that without even a
deprecation period.

But I also think we should still deprecate 32-bit hosts, sooner rather than
> later.  Even
> if we have no immediate plans to remove them.  I think we want interested
> parties to speak
> up.  At some point this decade I want to be able to say: we've given you
> fair warning and
> time is up.
>

Fair enough. We have several deprecations that are in limbo and probably
won't go away soon, and it makes sense for 32-bit hosts to be another.

Also, I don't want this to look like stonewalling, so I will point out that
we can always decide to remove only *some* 32-bit hosts (or some 32-bit TCG
backends), once the deprecation countdown has ticked for some time.

Paolo

--00000000000051aa1a062d0398b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 31 gen 2025, 17:46 Richar=
d Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hen=
derson@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 1/29/25 04:47, Paolo Bonzini wrote:<br>
&gt; The difference with TCG of course is that TCG is in active development=
, and therefore its <br>
&gt; 32-bit host support is not surviving passively in the same way that a =
random device is.=C2=A0 <br>
&gt; Still, I think we can identify at least three different parts that sho=
uld be treated <br>
&gt; differently: 64-on-32, 32-on-32 system-mode emulation and 32-on-32 use=
r-mode emulation.<br>
<br>
Why the user/system split for 32-on-32?<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Various reasons which overall point =
at 32-on-32 system emulation being not used very much.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">1) 32-bit has the address space size limitat=
ion, which makes it harder to test even moderately sized (2G) guests.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">2) I might be wrong but user =
mode emulation has no equivalent of the forced-64bit hwaddr or ram_addr_t t=
ypes; 32 bit is not very 32 bit anyway in the case of system emulation=C2=
=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">3) 32-bit virtualiza=
tion support only exists on x86 and possibly MIPS</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">4) system emulation is used mostly on development=
 systems, whereas user mode emulation might be used on small systems to run=
 short-lived proprietary programs</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">5) for those 32-bit hosts that have a completely separate TCG bac=
kend (well, that&#39;s Arm), getting rid TLB accesses does eliminate a bit =
of code.</div><div dir=3D"auto"><br></div><div dir=3D"auto">None of them ma=
y be compelling, or maybe deprecating only one of the two don&#39;t really =
make a difference in terms of maintainability, but this at least makes the =
case for 32-on-32 system emulation a lot weaker.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">More specifically, I don&#39;t believe anything ot=
her than 32-bit Arm hosts are in user and for anything but user mode emulat=
ion, but those have a nonzero chance of being in use.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; We could and should remove 64-on-32, maybe even without a deprecation =
period, but the rest <br>
&gt; I&#39;m not so sure.=C2=A0 I don&#39;t know enough to understand their=
 maintenance cost (other than the <br>
&gt; mere existence of the 32-bit TCG backends), but it&#39;s certainly not=
 comparable to 64-on-32.<br>
<br>
Ok, lemme see how easy it is to prohibit configuring 64-on-32.<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Probably very=
 easy, and I would really want to do that without even a deprecation period=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">But I also think we should still deprecate 32-bit hosts, sooner rather th=
an later.=C2=A0 Even <br>
if we have no immediate plans to remove them.=C2=A0 I think we want interes=
ted parties to speak <br>
up.=C2=A0 At some point this decade I want to be able to say: we&#39;ve giv=
en you fair warning and <br>
time is up.<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Fair enough. We have several deprecations that are in limbo and =
probably won&#39;t go away soon, and it makes sense for 32-bit hosts to be =
another.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Also, I don&#39=
;t want this to look like stonewalling, so I will point out that we can alw=
ays decide to remove only *some* 32-bit hosts (or some 32-bit TCG backends)=
, once the deprecation countdown has ticked for some time.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--00000000000051aa1a062d0398b2--


