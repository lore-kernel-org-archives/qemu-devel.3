Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E668C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9k3x-000680-TL; Tue, 29 Apr 2025 08:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9k3p-000668-UC
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9k3n-0001fk-DA
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745929657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4nOSrRHsvMuZWPqENTr2gYNzqPf00XnU3g0ZgF5qf9o=;
 b=C5mO8J1vkni9YWXCcirle3ZBxcmrH/MzG+1kZnEWZDLj334wSrMqYrgofOpkTgnrbtrYHM
 utsrc2fmdwf8OpDH6pPD2tMxgCQFMfuzrvYGwbhnG1ypSxBbCFVzzOXO29+5ghcWMgBvsT
 k/O+JNdT8lbPaDwf4CF7OO6hoGaT2IE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-RQVfty6bOuuj4DQBko7yvw-1; Tue, 29 Apr 2025 08:27:35 -0400
X-MC-Unique: RQVfty6bOuuj4DQBko7yvw-1
X-Mimecast-MFC-AGG-ID: RQVfty6bOuuj4DQBko7yvw_1745929654
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d00017e9dso33117745e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745929654; x=1746534454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4nOSrRHsvMuZWPqENTr2gYNzqPf00XnU3g0ZgF5qf9o=;
 b=Lp361P58TCXJBlkTo5cUiG4mXaCCYUFrMfehwl9IbAlJPCNfu6rjd4Ei0yu/HYwCkj
 RkPtVExxB4w4SrR+Rdbwj3egLsyToh0+snQLCXK842+pkER0Cc+Q+KiUXzsBjd1Hw7fP
 KN28uTZMmsAiIbP0D12P96DdpLIpHDPMsEXKJ62CLUIGKKnrZNSb5WMBnPijm/mhIs6d
 8G/UZorUChLm/AyFqOMB39iE8YozZIM3R6jfdCxstsnraWvfkSU1rjcslACQ8BUNLzCg
 kX8Ww5Ns7KdFa3ZjI2HBFY3JrWrfQ5Y82FSO7kvnR25uwAb2R760lCFm9DgvJduAV1UQ
 r/tA==
X-Gm-Message-State: AOJu0YxWcbKWCvhaZYOANIPEr4BLoowhzSa1+APlQ91xGnileD/UnyVM
 4GHs6kvePx/3kUe623Zb7LEDrBZVOpgXDyuVwY5KVA7dhM8euYzK7ncHvYSDlbudaOiG/W6hurg
 BrRvvXGSqGpr0scyuvbJksIJfWZ12HziNuz3k1tlOBpGWsXX6gef2LSfPTC5hgx86KEjjsLr6h2
 TFWWj+efUf1nQGk1VaVncJLm3s2vc=
X-Gm-Gg: ASbGnctudSa89EbRl2GisPjOr5tXrl+TBdokVW51+ksrg2y9nh2E2bh6ptmhJ9CRGrF
 0CKKeGLUYf4VWeRXDAqbi3mGveooPYpd+11mOeoe4LA/pn2cIpXGqSkoYy4QD1y3kwq8=
X-Received: by 2002:a05:6000:22c5:b0:399:7f2b:8531 with SMTP id
 ffacd0b85a97d-3a08ad77608mr1952168f8f.38.1745929654283; 
 Tue, 29 Apr 2025 05:27:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEawHUKY3VMiFl92RSOKJCTivJJR0QRF3NoQmGhcxIZ/1tAn+2yBpHfGleK21KgOWxTifgkKqnVnyUx0gR0CLY=
X-Received: by 2002:a05:6000:22c5:b0:399:7f2b:8531 with SMTP id
 ffacd0b85a97d-3a08ad77608mr1952154f8f.38.1745929653993; Tue, 29 Apr 2025
 05:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250429093319.5010-1-magnuskulke@linux.microsoft.com>
 <CABgObfaxzxdBf3f-JwKA8osOwZZQf-dqpsambpAFhPvkvjDo8w@mail.gmail.com>
 <aBDBExDzR57PcRre@example.com>
In-Reply-To: <aBDBExDzR57PcRre@example.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Apr 2025 14:27:21 +0200
X-Gm-Features: ATxdqUFxAGLeffdhZOZ5U69ViNn-5tBscSKO_iM6ZFK5hwqamIs_eLKOejp0WHs
Message-ID: <CABgObfbCSnQxdFzexobKr9HtoGcB_5R_6eioCzAvMyc6ZzGypw@mail.gmail.com>
Subject: Re: [PATCH v3] target/i386/emulate: remove rflags leftovers
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: multipart/alternative; boundary="000000000000d45bde0633e9ecef"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

--000000000000d45bde0633e9ecef
Content-Type: text/plain; charset="UTF-8"

Il mar 29 apr 2025, 14:17 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
scritto:

> Yes, I'm using the generalized emulator in the context of adding the MSHV
> accelerator. (I'll probably get around sending an RFC patchset this week
> for
> it). There were minor compilation issues w/ the emulator code, that I had
> to
> fix to make it compile on Linux. However I don't have access to an x86_64
> Mac for development either, so I can't test a HVF build.
>

No problem, using MSHV to test if I am breaking anything in the emulator is
enough!

Paolo

Best,
>
> Magnus
>
> > ---
> > >  target/i386/emulate/x86_decode.c | 17 ++++++-----------
> > >  1 file changed, 6 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/target/i386/emulate/x86_decode.c
> > > b/target/i386/emulate/x86_decode.c
> > > index 7fee219687..7efa2f570e 100644
> > > --- a/target/i386/emulate/x86_decode.c
> > > +++ b/target/i386/emulate/x86_decode.c
> > > @@ -1408,7 +1408,7 @@ struct decode_tbl _2op_inst[] = {
> > >  };
> > >
> > >  struct decode_x87_tbl invl_inst_x87 = {0x0, 0, 0, 0, 0, false, false,
> > > NULL,
> > > -                                       NULL, decode_invalid, 0};
> > > +                                       NULL, decode_invalid};
> > >
> > >  struct decode_x87_tbl _x87_inst[] = {
> > >      {0xd8, 0, 3, X86_DECODE_CMD_FADD, 10, false, false,
> > > @@ -1456,8 +1456,7 @@ struct decode_x87_tbl _x87_inst[] = {
> > >       decode_x87_modrm_st0, NULL, decode_d9_4},
> > >      {0xd9, 4, 0, X86_DECODE_CMD_INVL, 4, false, false,
> > >       decode_x87_modrm_bytep, NULL, NULL},
> > > -    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL,
> NULL,
> > > -     RFLAGS_MASK_NONE},
> > > +    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL,
> > > NULL},
> > >      {0xd9, 5, 0, X86_DECODE_CMD_FLDCW, 2, false, false,
> > >       decode_x87_modrm_bytep, NULL, NULL},
> > >
> > > @@ -1478,20 +1477,17 @@ struct decode_x87_tbl _x87_inst[] = {
> > >       decode_x87_modrm_st0, NULL},
> > >      {0xda, 3, 3, X86_DECODE_CMD_FCMOV, 10, false, false,
> > > decode_x87_modrm_st0,
> > >       decode_x87_modrm_st0, NULL},
> > > -    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> NULL,
> > > -     RFLAGS_MASK_NONE},
> > > +    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> NULL},
> > >      {0xda, 4, 0, X86_DECODE_CMD_FSUB, 4, false, false,
> > > decode_x87_modrm_st0,
> > >       decode_x87_modrm_intp, NULL},
> > >      {0xda, 5, 3, X86_DECODE_CMD_FUCOM, 10, false, true,
> > > decode_x87_modrm_st0,
> > >       decode_decode_x87_modrm_st0, NULL},
> > >      {0xda, 5, 0, X86_DECODE_CMD_FSUB, 4, true, false,
> > > decode_x87_modrm_st0,
> > >       decode_x87_modrm_intp, NULL},
> > > -    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> NULL,
> > > -     RFLAGS_MASK_NONE},
> > > +    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> NULL},
> > >      {0xda, 6, 0, X86_DECODE_CMD_FDIV, 4, false, false,
> > > decode_x87_modrm_st0,
> > >       decode_x87_modrm_intp, NULL},
> > > -    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> NULL,
> > > -     RFLAGS_MASK_NONE},
> > > +    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> NULL},
> > >      {0xda, 7, 0, X86_DECODE_CMD_FDIV, 4, true, false,
> > > decode_x87_modrm_st0,
> > >       decode_x87_modrm_intp, NULL},
> > >
> > > @@ -1511,8 +1507,7 @@ struct decode_x87_tbl _x87_inst[] = {
> > >       decode_x87_modrm_intp, NULL, NULL},
> > >      {0xdb, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> > >       decode_db_4},
> > > -    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> NULL,
> > > -     RFLAGS_MASK_NONE},
> > > +    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> NULL},
> > >      {0xdb, 5, 3, X86_DECODE_CMD_FUCOMI, 10, false, false,
> > >       decode_x87_modrm_st0, decode_x87_modrm_st0, NULL},
> > >      {0xdb, 5, 0, X86_DECODE_CMD_FLD, 10, false, false,
> > > --
> > > 2.34.1
> > >
> > >
>
>

--000000000000d45bde0633e9ecef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 29 apr 2025, 14:17 Magnus Kulke &lt;<a href=3D"=
mailto:magnuskulke@linux.microsoft.com" target=3D"_blank" rel=3D"noreferrer=
">magnuskulke@linux.microsoft.com</a>&gt; ha scritto:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Yes, I&#39;m using the generalized em=
ulator in the context of adding the MSHV<br>
accelerator. (I&#39;ll probably get around sending an RFC patchset this wee=
k for<br>
it). There were minor compilation issues w/ the emulator code, that I had t=
o<br>
fix to make it compile on Linux. However I don&#39;t have access to an x86_=
64<br>
Mac for development either, so I can&#39;t test a HVF build.<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">No problem, usi=
ng MSHV to test if I am breaking anything in the emulator is enough!</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
Best,<br>
<br>
Magnus<br>
<br>
&gt; ---<br>
&gt; &gt;=C2=A0 target/i386/emulate/x86_decode.c | 17 ++++++-----------<br>
&gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 11 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/target/i386/emulate/x86_decode.c<br>
&gt; &gt; b/target/i386/emulate/x86_decode.c<br>
&gt; &gt; index 7fee219687..7efa2f570e 100644<br>
&gt; &gt; --- a/target/i386/emulate/x86_decode.c<br>
&gt; &gt; +++ b/target/i386/emulate/x86_decode.c<br>
&gt; &gt; @@ -1408,7 +1408,7 @@ struct decode_tbl _2op_inst[] =3D {<br>
&gt; &gt;=C2=A0 };<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 struct decode_x87_tbl invl_inst_x87 =3D {0x0, 0, 0, 0, 0, f=
alse, false,<br>
&gt; &gt; NULL,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0NULL, decode_invalid, 0};<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0NULL, decode_invalid};<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 struct decode_x87_tbl _x87_inst[] =3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xd8, 0, 3, X86_DECODE_CMD_FADD, 10, false, =
false,<br>
&gt; &gt; @@ -1456,8 +1456,7 @@ struct decode_x87_tbl _x87_inst[] =3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_x87_modrm_st0, NULL, decode_d9_4=
},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xd9, 4, 0, X86_DECODE_CMD_INVL, 4, false, f=
alse,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_x87_modrm_bytep, NULL, NULL},<br=
>
&gt; &gt; -=C2=A0 =C2=A0 {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, fals=
e, NULL, NULL, NULL,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0RFLAGS_MASK_NONE},<br>
&gt; &gt; +=C2=A0 =C2=A0 {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, fals=
e, NULL, NULL,<br>
&gt; &gt; NULL},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xd9, 5, 0, X86_DECODE_CMD_FLDCW, 2, false, =
false,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_x87_modrm_bytep, NULL, NULL},<br=
>
&gt; &gt;<br>
&gt; &gt; @@ -1478,20 +1477,17 @@ struct decode_x87_tbl _x87_inst[] =3D {<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_x87_modrm_st0, NULL},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xda, 3, 3, X86_DECODE_CMD_FCMOV, 10, false,=
 false,<br>
&gt; &gt; decode_x87_modrm_st0,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_x87_modrm_st0, NULL},<br>
&gt; &gt; -=C2=A0 =C2=A0 {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false=
, NULL, NULL, NULL,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0RFLAGS_MASK_NONE},<br>
&gt; &gt; +=C2=A0 =C2=A0 {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false=
, NULL, NULL, NULL},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xda, 4, 0, X86_DECODE_CMD_FSUB, 4, false, f=
alse,<br>
&gt; &gt; decode_x87_modrm_st0,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_x87_modrm_intp, NULL},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xda, 5, 3, X86_DECODE_CMD_FUCOM, 10, false,=
 true,<br>
&gt; &gt; decode_x87_modrm_st0,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_decode_x87_modrm_st0, NULL},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xda, 5, 0, X86_DECODE_CMD_FSUB, 4, true, fa=
lse,<br>
&gt; &gt; decode_x87_modrm_st0,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_x87_modrm_intp, NULL},<br>
&gt; &gt; -=C2=A0 =C2=A0 {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false=
, NULL, NULL, NULL,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0RFLAGS_MASK_NONE},<br>
&gt; &gt; +=C2=A0 =C2=A0 {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false=
, NULL, NULL, NULL},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xda, 6, 0, X86_DECODE_CMD_FDIV, 4, false, f=
alse,<br>
&gt; &gt; decode_x87_modrm_st0,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_x87_modrm_intp, NULL},<br>
&gt; &gt; -=C2=A0 =C2=A0 {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false=
, NULL, NULL, NULL,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0RFLAGS_MASK_NONE},<br>
&gt; &gt; +=C2=A0 =C2=A0 {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false=
, NULL, NULL, NULL},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xda, 7, 0, X86_DECODE_CMD_FDIV, 4, true, fa=
lse,<br>
&gt; &gt; decode_x87_modrm_st0,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_x87_modrm_intp, NULL},<br>
&gt; &gt;<br>
&gt; &gt; @@ -1511,8 +1507,7 @@ struct decode_x87_tbl _x87_inst[] =3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_x87_modrm_intp, NULL, NULL},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xdb, 4, 3, X86_DECODE_CMD_INVL, 10, false, =
false, NULL, NULL,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_db_4},<br>
&gt; &gt; -=C2=A0 =C2=A0 {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false=
, NULL, NULL, NULL,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0RFLAGS_MASK_NONE},<br>
&gt; &gt; +=C2=A0 =C2=A0 {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false=
, NULL, NULL, NULL},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xdb, 5, 3, X86_DECODE_CMD_FUCOMI, 10, false=
, false,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decode_x87_modrm_st0, decode_x87_modrm_=
st0, NULL},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 {0xdb, 5, 0, X86_DECODE_CMD_FLD, 10, false, f=
alse,<br>
&gt; &gt; --<br>
&gt; &gt; 2.34.1<br>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
</blockquote></div></div></div>

--000000000000d45bde0633e9ecef--


