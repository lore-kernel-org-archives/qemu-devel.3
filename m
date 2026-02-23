Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC95EC1122
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 19:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vubDx-0001cx-Nw; Mon, 23 Feb 2026 14:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vubDb-0001b3-2t
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 14:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vubDZ-0002KZ-Ca
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 14:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771873420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMX441P8bJLBwKEWs+mbAHs0IPb96AAA7l7/0evWMaw=;
 b=AIr4d2FU+h+J/ZEgX/p4KmLBWDAraiqOtR+YXhUiN1KJBaz+gr4v+k2e35gqi5sKjag/QC
 VjQKJy2y7RR1F2z0EnVOdKM1/l2eeQErEztXANdukFsZxw7EliQj/xB3/dje58cdOluYDb
 65Qj37WThKW25cTp+xL8rnj03CsWr3o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-_6_KCItONfK1zOZCnvNFag-1; Mon, 23 Feb 2026 14:03:36 -0500
X-MC-Unique: _6_KCItONfK1zOZCnvNFag-1
X-Mimecast-MFC-AGG-ID: _6_KCItONfK1zOZCnvNFag_1771873415
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4376761037bso3580589f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 11:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771873415; cv=none;
 d=google.com; s=arc-20240605;
 b=JC5YMNMvxpI3vLNekCVxziHYuZ1TlteIrEk/wrOsvTekd5tm2SQtQFGhoiGVReIZAp
 BVa2IgRsxgMP/kkpsCXPPMEhPWyh5owHN4yRWqpPFZJYinrLR6GoAJZdbji3ehzl5kvT
 Nbg7PCMoEUKQC3kBtsNkD0mhsZVO3CYMuyoZ+s9ClCpQEW/byo/m4ll6jdXD8EILsH8C
 tyuqY8FJdjLUv2n9TpJRNtrvGobri4n/L3Vusq5WTjYJZ9AEYeMYvGdsL33Bb0K929w1
 IOXxPPr85jjL+F8AyWhp0cn92lLr+qGwiMgUT1FMKvZEYjXXf0xOdyvoGF+pCFtFkIjE
 vPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zMX441P8bJLBwKEWs+mbAHs0IPb96AAA7l7/0evWMaw=;
 fh=iwikotSpFFwzaSLMrKIFwxwdNWCdgVrd4Hn+N4HsbHM=;
 b=JolJtQoM5663dmOM/vzmSOnWhW1tqIFPONjC60DaUAZO/vPtGcC1bQ6iuFltfuTgdE
 t/gKRlpyWZSEHqBRuPYhn/Dlje9SoK3jR55lb3LdQL725ulQppFNLWTR8Ey0BlQSHMq0
 KxmAJoX48wrvv10X1jLQrT0aVE+ZaBFPzasR1wDvdxfsBdJyBXENhN8nTalikn3nwSOr
 3lt0Ikq+gSou+NiBUwzs1aDB/JOsehID+BThBf63hhbc9R5vBvLUhb1Z9Jaz++HKwhBn
 7lGWyUdh7aTPRnw6lKCfre0U3X1ZHfI8ohrrn9lgjJacXnZL5sCyHO79cDNGZNbdRAoE
 hCqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771873415; x=1772478215; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zMX441P8bJLBwKEWs+mbAHs0IPb96AAA7l7/0evWMaw=;
 b=JP/+rKeBlCMbiKby6TCGX35wCU8S7fk95GWIUepc+rPqN2XBp/gvdjpRQfTxSSherY
 TRff9dfhpf41A8dqqn9UnZWWccsiaMTYGCG6xiAb+uavf+MTIzE60vCxEdvf/WxrLZ4g
 O6JbV/i/3Di8d6pRcLnDA1eCv3QhLqxYf4c86iwi734WGuDyqcRKL5l2lG0gBwyzj8SD
 FBm5iTQAlMEuo+WhXomht1q302gilH6D13HScJnHUzq7wKwiQHq3IRiQYedzqQSJDAjW
 6Kxq83ygU0SKiCyqCFpnmGEjzpVSAZx6OFt2Z8hVUz5TYqoGN4ZdlLmGSeWYhCZjzTt9
 roNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771873415; x=1772478215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMX441P8bJLBwKEWs+mbAHs0IPb96AAA7l7/0evWMaw=;
 b=XYJdRO43tdPbgVciFzaAE5GzMvVxsMZSH2WVFFfSzaHUkv+zZMxi8e92+SdKhOf1fo
 1Rw217lIqnQLWSD4STZVaRe0qxEa75t05muIKQ+6QYFkAFO4cMWd9iDdQNLpgh0Bc8Fn
 zFf1fpyU3jlcyasAHsQd6DuZqkEUzwnSQwwyxrVrmyKYlfq1sW+QYc6wHdyiHk9WSK5D
 0l073G8QAQ3Y/WuxCibpy/O7t5otyCWoAPFPLAk2VnGwBhNModjcRuiID4ZQpv/KB1iQ
 Ub8q04z4P5gEhhlrIat8cogEgfgiHWCTtlRLO+gV1Bc2sKkUYAkr9AC0VfhOZ8SpBigf
 Q+IA==
X-Gm-Message-State: AOJu0YzouIlqD9q/q0hVxTw1iJCZwE1qK5qCCe1pWokBJdou2FV00cy0
 YVOsttmswWMu4QHqRZiVRTjAVSOYZLsrkwieZW/jhvXJyFNcKQXSygxSsIhiI4nSEjBLArmZB24
 bmWLz7uBvHjYpSv2B2jpDb91OpNR0G1fVyYMguF342ISEYVDZXIFi4Zc978RAzv34CkTVb3TV8T
 yzk4BNXxtXy2DD9lz6tRjOAcflAIs1cKM=
X-Gm-Gg: ATEYQzyfTEEjQMA2I6rEkUuPEO3N8u8+NWZfFWVq0Ce94htftMR9ecbqNs8Wh1ucUO5
 9F1pskDYkALP83GTbZb3NafK+yTpqY2VP+otZFCTgTjySTlR/CtaqXU9OufYxcrpR6JdWJEmYwh
 7qo8YPQy4kU/tCXjqYj4ODqMFoOocUeJbloVimZNlfrtEfsvpa6G4XfOR1RVHXSFVp2CkqIah+B
 pq4TljxbJFCoqDaS6I9NprAVyN94O9a+UvDoDbOfHhbRYHfpvn67Jcu4Uc4Q04ezTvsP5DfrNFC
 gcak4V8=
X-Received: by 2002:a05:6000:290e:b0:432:5a4e:c023 with SMTP id
 ffacd0b85a97d-4396ffc46camr16991619f8f.13.1771873415224; 
 Mon, 23 Feb 2026 11:03:35 -0800 (PST)
X-Received: by 2002:a05:6000:290e:b0:432:5a4e:c023 with SMTP id
 ffacd0b85a97d-4396ffc46camr16991567f8f.13.1771873414776; Mon, 23 Feb 2026
 11:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <aZwjpfu-qCCSoHdx@redhat.com>
 <bedbf511-c46a-4468-bf65-cc452c621765@redhat.com>
 <aZx_Wy1-eBsTEB1s@redhat.com>
In-Reply-To: <aZx_Wy1-eBsTEB1s@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 23 Feb 2026 20:03:21 +0100
X-Gm-Features: AaiRm526srvpqunoMtw2m9ysXVzlAHRI_ao03hwkMOeuomM6mFKrXVnmY1rc75Y
Message-ID: <CABgObfa7ur+jjQjjm8hacNJZ92YJ3G7vzugxzw0oQ1FsSM-Uaw@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] rust: QObject and QAPI bindings
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Armbruster,
 Markus" <armbru@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000799a61064b826d43"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000799a61064b826d43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 23 feb 2026, 17:25 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> I guess the thing I'm wondering about when I ask about the big picture
> is to understand tne interoperability implications of this impl approach,
> given the starting point that the Rust & C structs are *not* ABI
> compatible.
>
> If we're anticipating that the Rust usage flows up from a Rust QMP comman=
d
> handler, then the data is in the Rust struct right from the entry point
> and perhaps the interoperability needs are reduced in scope.
>
> If we're anticipating a calls back & forth between C & Rust code, that
> directly handle the deserialized structs, then we have an open interop
> question. Is the implication that we round-trip via JSON every time we
> need to swap between a Rust struct and C struct for a given type ?


Right now yes.

Or
> will we have a direct struct<->struct conversion mechanism ? Or is there
> something else entirely ?
>

Marc-Andr=C3=A9 had such a conversion mechanism in his patches. However I w=
ould
not include it unless there's a need. Generally speaking I don't expect
anything involving QAPI to be performance critical.

I feel a bit lost in how to evaluate this series without seeing some
> real world usage, in a way that exposes the possible implications of
> the lack of C/Rust ABI compat in the structs.
>

Yes, I understand and it's a recurrent problem with all the Rust
infrastructure, it's hard to evaluate it beyond test cases. Right now my
best hope for a first user would be either QMP commands, or the block layer=
.

Paolo


> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000799a61064b826d43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 23 feb 2026, 17:25 Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">I guess the thing I&#39;m wondering about when I ask about the b=
ig picture<br>
is to understand tne interoperability implications of this impl approach,<b=
r>
given the starting point that the Rust &amp; C structs are *not* ABI compat=
ible.<br>
<br>
If we&#39;re anticipating that the Rust usage flows up from a Rust QMP comm=
and<br>
handler, then the data is in the Rust struct right from the entry point<br>
and perhaps the interoperability needs are reduced in scope.<br>
<br>
If we&#39;re anticipating a calls back &amp; forth between C &amp; Rust cod=
e, that<br>
directly handle the deserialized structs, then we have an open interop<br>
question. Is the implication that we round-trip via JSON every time we<br>
need to swap between a Rust struct and C struct for a given type ?</blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Right now yes=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"> Or<br>
will we have a direct struct&lt;-&gt;struct conversion mechanism ? Or is th=
ere<br>
something else entirely ?<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Marc-Andr=C3=A9 had such a conversion mechanism in=
 his patches. However I would not include it unless there&#39;s a need. Gen=
erally speaking I don&#39;t expect anything involving QAPI to be performanc=
e critical.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">I feel a bit lost in how to evaluate this series without seei=
ng some<br>
real world usage, in a way that exposes the possible implications of<br>
the lack of C/Rust ABI compat in the structs.<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Yes, I understand and it&#39;s=
 a recurrent problem with all the Rust infrastructure, it&#39;s hard to eva=
luate it beyond test cases. Right now my best hope for a first user would b=
e either QMP commands, or the block layer.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://entangle-photo.org</a> :|<b=
r>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =
=C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000799a61064b826d43--


