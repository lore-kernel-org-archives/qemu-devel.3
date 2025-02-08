Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F64C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 11:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgjDt-0004jo-DP; Sat, 08 Feb 2025 06:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgjDm-0004jE-Il
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 06:42:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgjDk-00009M-Qw
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 06:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739014920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=maZD1J7qe8nz1qcfpE3E3EO+M+U+/67hJTDDAF24NTA=;
 b=XAp0A2lG3hQcj3wxHZ3UYvCCBdoxwaXaO7d9GGOyzLq90gOFGvGK1pUTGSBkevbcXbXh9R
 vYJfeEv2e836SyZ8fA6HR48LNy++mqXnkALKbtgJk59e5IC/RE94oyoD7v9QXdSn5zSK8Y
 +9wwVEQrRlsI22AUj9m1pIn3lWlqEBY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-qbZdztJEPdKDXCeeUq0y6A-1; Sat, 08 Feb 2025 06:41:58 -0500
X-MC-Unique: qbZdztJEPdKDXCeeUq0y6A-1
X-Mimecast-MFC-AGG-ID: qbZdztJEPdKDXCeeUq0y6A
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361d4e8359so22214445e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 03:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739014917; x=1739619717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=maZD1J7qe8nz1qcfpE3E3EO+M+U+/67hJTDDAF24NTA=;
 b=vAvd1WJL9nxsKoqlhRFLMOeM8PVUUnu6Udir8g7pqM6g49PkIL4jQgg3AZWQ3onHwX
 j0R8w34mwGCKDodHn4M3pQm+swuJ/aG3S/e4t3hQNAW6k7Qa5YIv78Gg+HIgkTGI0XE3
 B00qZiTRzojP+tnv0tcZX+f4ljNDXbmXYsCe2cIt4R7W2b4mUHq9ZHsYAAY083AO33fg
 1amJoRdCM4EqtO0jOU7G9R8BirO2bzPzGrVutdWNswD7vs9styta/OA3zUhsv//z/rZY
 nzr0nRxLnUep6+hVoxsG3b/0fmQw6zT3c8kpPDxYvmDsnYtc/fedGVBLa+kK6SM5+OgM
 DP4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvdbfk96Bmw6RBH7EkonkZ9S5L+a7vV62jMK2FpSza9nVOWi7iBX2TYAPMCeoWwejsLuScv59PaqmQ@nongnu.org
X-Gm-Message-State: AOJu0YxfgflmkZ5rRIhsL79Ytk26dQ2nXUQMXWgW6feteXsVsFzeRW6j
 hxmPvySC7q4W52e8teudNGFper1MSV5svHnzxy5HNJ+BUZlGXvWgNWPnJssEdn/SU9Et23N8hAp
 W11uMSCGzezFoDLXfB/r6mA03WsIfbXdigRtZN3M6D6KwESqBGQm/zwtn8MQtGQlARYa/ifm0P/
 RvEdpOQiy3St4qGiMeR4avHVXSgpU=
X-Gm-Gg: ASbGnctEGTFKYd/3k/c8HeVGOh8kJBgCfGy6qIPGk+nlAM0SsmUIjswjsHl05rOPskx
 VZD7WI4iO7JhIqz+4+HxqtkJosfxqkFUM0Qh0jDprAnAXrVUMnexxlLldCAn6
X-Received: by 2002:a05:600c:5114:b0:434:ff25:199f with SMTP id
 5b1f17b1804b1-439249bd37amr44187155e9.26.1739014916898; 
 Sat, 08 Feb 2025 03:41:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/z/wQmFR+hBCckctW3ra7mTId9fgNj32ARS6AWKCjEgQDugBDwEd+r2+y7LLUJhjfIW8F1mqlySodlfE9knc=
X-Received: by 2002:a05:600c:5114:b0:434:ff25:199f with SMTP id
 5b1f17b1804b1-439249bd37amr44187015e9.26.1739014916511; Sat, 08 Feb 2025
 03:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-10-zhao1.liu@intel.com>
 <750f06f3-6326-473f-9d08-ad6bb1f2a54a@redhat.com> <Z6c4NVX4wteIEIOA@intel.com>
In-Reply-To: <Z6c4NVX4wteIEIOA@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 8 Feb 2025 12:41:46 +0100
X-Gm-Features: AWEUYZnqdVIEI_vtj_tEa75yeqkNsx3cSDBhwhqh5nevaZZ40emRmJxKla14knc
Message-ID: <CABgObfaBLdQOf0RGbnmxYJ5qYM0Q95z-8Nx6Amwzvu-88e56zQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] rust/timer/hpet: add qom and qdev APIs support
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005bbf20062d9ff6ca"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--0000000000005bbf20062d9ff6ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 8 feb 2025, 11:36 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> On Wed, Jan 29, 2025 at 11:58:14AM +0100, Paolo Bonzini wrote:
> > Date: Wed, 29 Jan 2025 11:58:14 +0100
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: Re: [PATCH 09/10] rust/timer/hpet: add qom and qdev APIs suppo=
rt
> >
> >
> >
> > On Sat, Jan 25, 2025 at 1:32=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> =
wrote:
> > >      fn read(&mut self, addr: hwaddr, _size: u32) -> u64 {
> >
> > This can be &self.
>
> Done.
>
> > >          let shift: u64 =3D (addr & 4) * 8;
> > >
> > > +        match addr {
> > > +            HPET_TN_CFG_REG =3D> self.config >> shift, // including
> interrupt capabilities
> >
> > This needs to be "match addr & !4".
>
> I understand it's not necessary:
>
> In timer_and_addr(), I've masked the address with 0x18.
>
>     fn timer_and_addr(&self, addr: hwaddr) ->
> Option<(&BqlRefCell<HPETTimer>, hwaddr)> {
>         let timer_id: usize =3D ((addr - 0x100) / 0x20) as usize;
>
>         if timer_id > self.num_timers.get() {
>             None
>         } else {
>             Some((&self.timers[timer_id], addr & 0x18))
>

Ah, this should be 0x1C (or perhaps 0x1F). Otherwise there is a bug in
accessing the high 32 bits of a 64-bit register; shift will always be 0 in
HPETTimer::read and write.

// No need for HPETClass. Just like OBJECT_DECLARE_SIMPLE_TYPE in C.
>
> Then this can be "grep", as a reference.
>

Sure.

Thanks,

Paolo


> >     type Class =3D <SysBusDevice as ObjectType>::Class;
> >      const TYPE_NAME: &'static CStr =3D crate::TYPE_HPET;
> > }
> >
> > which is indeed more similar to OBJECT_DECLARE_SIMPLE_TYPE().
>
> Awesome! Thanks.
>
> Regards,
> Zhao
>
>

--0000000000005bbf20062d9ff6ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 8 feb 2025, 11:36 Zhao Li=
u &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; ha=
 scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed=
, Jan 29, 2025 at 11:58:14AM +0100, Paolo Bonzini wrote:<br>
&gt; Date: Wed, 29 Jan 2025 11:58:14 +0100<br>
&gt; From: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; Subject: Re: [PATCH 09/10] rust/timer/hpet: add qom and qdev APIs supp=
ort<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On Sat, Jan 25, 2025 at 1:32=E2=80=AFPM Zhao Liu &lt;<a href=3D"mailto=
:zhao1.liu@intel.com" target=3D"_blank" rel=3D"noreferrer">zhao1.liu@intel.=
com</a>&gt; wrote:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 fn read(&amp;mut self, addr: hwaddr, _size: u=
32) -&gt; u64 {<br>
&gt; <br>
&gt; This can be &amp;self.<br>
<br>
Done.<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 let shift: u64 =3D (addr &amp; =
4) * 8;<br>
&gt; &gt; <br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 match addr {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HPET_TN_CFG_REG =3D&gt=
; self.config &gt;&gt; shift, // including interrupt capabilities<br>
&gt; <br>
&gt; This needs to be &quot;match addr &amp; !4&quot;.<br>
<br>
I understand it&#39;s not necessary:<br>
<br>
In timer_and_addr(), I&#39;ve masked the address with 0x18. <br>
<br>
=C2=A0 =C2=A0 fn timer_and_addr(&amp;self, addr: hwaddr) -&gt; Option&lt;(&=
amp;BqlRefCell&lt;HPETTimer&gt;, hwaddr)&gt; {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 let timer_id: usize =3D ((addr - 0x100) / 0x20)=
 as usize;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if timer_id &gt; self.num_timers.get() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Some((&amp;self.timers[timer_id],=
 addr &amp; 0x18))<br></blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Ah, this should be 0x1C (or perhaps 0x1F). Otherwise ther=
e is a bug in accessing the high 32 bits of a 64-bit register; shift will a=
lways be 0 in HPETTimer::read and write.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">// No need for HPETClass. Just lik=
e OBJECT_DECLARE_SIMPLE_TYPE in C.<br>
<br>
Then this can be &quot;grep&quot;, as a reference.<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Sure.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0type Class =3D &lt;SysBusDevice as ObjectType&gt;::=
Class;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 const TYPE_NAME: &amp;&#39;static CStr =3D crate::=
TYPE_HPET;<br>
&gt; }<br>
&gt; <br>
&gt; which is indeed more similar to OBJECT_DECLARE_SIMPLE_TYPE().<br>
<br>
Awesome! Thanks.<br>
<br>
Regards,<br>
Zhao<br>
<br>
</blockquote></div></div></div>

--0000000000005bbf20062d9ff6ca--


