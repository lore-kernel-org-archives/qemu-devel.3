Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8E9C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 12:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYllt-0000tM-Ah; Fri, 17 Jan 2025 07:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYllk-0000su-37
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYlli-0000q4-7k
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737118088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mmkPZyvqlnHW2+0reQ+L1NkQ1IaWqwGv+wpX1YNVsl4=;
 b=J6r1rHIiGy1SzDAZ/JPx1b1k3oWQsWKLxKsEP9GD64rWolIq8/SU6TiTFCl20aOu5DbwXG
 1FXq0DU8ROUNFKgo31LjARzRcMkuT21/uH/8H9vepTlPzYkUKQSdzB02hlE8LUjaZv2Y8d
 j4uqnbZWNxrC7TZNWXoHXA9lUsSlweI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-7N9IZIfwPQSoF0_CvmXojg-1; Fri, 17 Jan 2025 07:48:07 -0500
X-MC-Unique: 7N9IZIfwPQSoF0_CvmXojg-1
X-Mimecast-MFC-AGG-ID: 7N9IZIfwPQSoF0_CvmXojg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3860bc1d4f1so1278922f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 04:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737118086; x=1737722886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mmkPZyvqlnHW2+0reQ+L1NkQ1IaWqwGv+wpX1YNVsl4=;
 b=G4j3K5mSc4GqAIoniKx2leqAx/BCHhMOmCxsgg2mnALhr0RMgurCVzS2el5Lh2wKzE
 aumx+hwHBbAjarFd1KijuBdmVu5/QmNaZGROBAJE+kz7Q6jtYHB9hplYIpeGrC8OTOp+
 LB8fRUF53ia8SRvJkwGtj/EE6Q557o41r9XAA8xX7pY7iaBLAjJ9VT1EHd5rqFIOY14U
 2pc01j/7sSXm2IRObFu5uLWypecVzbMVA3E4Q+7moXzkVU4kmbBBPZm/dcqi2AGpmvUz
 LOI8mwIkErl46TfOxhpeJnzVD9Us/DM7XwM9iHhZgrhrwvQUDOhg69uAC2r1aCHB02qG
 Bgrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYU5BoOIBPn+OA2VjlNqSZZw9KxUqOdu30zgwEQ855/IIjCf9JF25JdI0u/lBm41N/XXnRQpgay7sF@nongnu.org
X-Gm-Message-State: AOJu0Yydx/Yz84tAKrAFRXF9fwGrHrO2iDlN33eZxWXFb1Dbg5OjlA/g
 T8UIcZ8VJwUVVAlLNQGhiATc5lTbtJqdMPEf1LSe0D7rSd5ICup+yE3lCaleh9KKFcWVrLSNYLQ
 ESRFapQvjtz61L7d7gDoh1T6V1Fo0f+1X9GfN2HPnxzaY3MQAGxb6tt9z6hsDsi9xoyRwklGqmq
 BZhcUHxv2Lg3RD4M8LoCLenhKPwnw=
X-Gm-Gg: ASbGncua9ilp4gH5Ra35O5B/RJgfvVH5F2C7kSv6hjS3d5UX0G/RjWpBCGq8SsC3J2f
 Tupnkyx9QD7uXDURE/+EpgcHjP692xHBHLoDa/WY=
X-Received: by 2002:a05:6000:156c:b0:385:eb85:f111 with SMTP id
 ffacd0b85a97d-38bf577f703mr2988632f8f.14.1737118085806; 
 Fri, 17 Jan 2025 04:48:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjijlmkAex1lTQbuAdJ2jHBqPhfL9DhXWLVFBk/XqfD3Vlsibpfl15G2LvanU3GtskTWSwdxiRTVeC+WW5M9k=
X-Received: by 2002:a05:6000:156c:b0:385:eb85:f111 with SMTP id
 ffacd0b85a97d-38bf577f703mr2988606f8f.14.1737118085495; Fri, 17 Jan 2025
 04:48:05 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-5-zhao1.liu@intel.com>
 <6108dfe6-f629-431c-be91-51abff338e85@redhat.com> <Z1XJBJp+l92+OrY9@intel.com>
 <CABgObfaeoLociD5rzptg4Uj4anMonc0M8iP_TK3qa-17FecR2A@mail.gmail.com>
 <Z4h3Q/JBxtWxi+bK@intel.com>
 <CABgObfYeRASh3oao6fpKBcijnhGaMKdAWsAQbrya7rwwOJfE1g@mail.gmail.com>
 <Z4o7nbonhTHftVXq@intel.com>
In-Reply-To: <Z4o7nbonhTHftVXq@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Jan 2025 13:47:53 +0100
X-Gm-Features: AbW1kvY3wTqvYJy5sNXP7wJHPrFhuIb9YpcIC29pcfx69wLBheAfdjsTMcruJSo
Message-ID: <CABgObfaDdSitQxnLvOnXqFiLFR+wR1+cLK1E8kHbTb47F_08tw@mail.gmail.com>
Subject: Re: [RFC 04/13] rust: add bindings for gpio_{in|out} initialization
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006b5e76062be6529e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
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

--0000000000006b5e76062be6529e
Content-Type: text/plain; charset="UTF-8"

Il ven 17 gen 2025, 11:55 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> > >         assert!(pins.len() > 0);
> >
> > !pins.is_empty().
>
> Yes.
>
> > But I am not sure it's needed...
> > >
> > >         unsafe {
> > >             qdev_init_gpio_out(
> > >                 self.upcast::<DeviceState>() as *const DeviceState as
> *mut DeviceState,
> > >                 pins[0].as_ptr(),
> > >                 pins.len() as c_int,
> >
> > ... if you use instead pins.as_ptr() without the initial dereference.
>
> Emm, pins.as_ptr() returns `*const InterruptSource`, which can't be
> converted to `*mut *mut IRQState` with InterruptSource::as_ptr().
>

It can be cast, since an InterruptSource is essentially a *mut IRQState,
but I agree it's not pretty.

Maybe add a "pub(crate) fn as_slice_of_qemu_irq(slice: [Self]) -> [*mut
IRQState)" to InterruptSource? It would just do a transmute and build the
new slice with from_raw_parts. And then "let pins =
InterruptSource::as_slice_of_qemu_irq(pins)" lets you use pins.as_ptr().

Paolo

So I haven't thought of a better way yet...
>
> > > impl HPETState {
> > >     ...
> > >
> > >     fn handle_legacy_irq(&self, irq: u32, level: u32) {
> > >         if irq == HPET_LEGACY_PIT_INT {
> > >             if !self.is_legacy_mode() {
> > >                 self.irqs[0].set(level != 0);
> > >             }
> > >         } else {
> > >             self.rtc_irq_level.set(level as u8);
> >
> > Any reason why you defined rtc_irq_level as InterruptSource<u8>
> > instead of InterruptSource<u32>?
>
> Thanks! I missed to clean up this, having previously used u8.
>
> Regards,
> Zhao
>
>

--0000000000006b5e76062be6529e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 17 gen 2025, 11:55 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert!(pins.len() &gt; 0);<br>
&gt; <br>
&gt; !pins.is_empty().<br>
<br>
Yes.<br>
<br>
&gt; But I am not sure it&#39;s needed...<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsafe {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init_gpio_out=
(<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self=
.upcast::&lt;DeviceState&gt;() as *const DeviceState as *mut DeviceState,<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pins=
[0].as_ptr(),<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pins=
.len() as c_int,<br>
&gt; <br>
&gt; ... if you use instead pins.as_ptr() without the initial dereference.<=
br>
<br>
Emm, pins.as_ptr() returns `*const InterruptSource`, which can&#39;t be<br>
converted to `*mut *mut IRQState` with InterruptSource::as_ptr().<br></bloc=
kquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It can be =
cast, since an InterruptSource is essentially a *mut IRQState, but I agree =
it&#39;s not pretty.</div><div dir=3D"auto"><br></div><div dir=3D"auto">May=
be add a &quot;pub(crate) fn as_slice_of_qemu_irq(slice: [Self]) -&gt; [*mu=
t IRQState)&quot; to InterruptSource? It would just do a transmute and buil=
d the new slice with from_raw_parts. And then &quot;let pins =3D InterruptS=
ource::as_slice_of_qemu_irq(pins)&quot; lets you use pins.as_ptr().</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
So I haven&#39;t thought of a better way yet...<br>
<br>
&gt; &gt; impl HPETState {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0fn handle_legacy_irq(&amp;self, irq: u32, leve=
l: u32) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if irq =3D=3D HPET_LEGACY_PIT_IN=
T {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if !self.is_legacy=
_mode() {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self=
.irqs[0].set(level !=3D 0);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rtc_irq_level=
.set(level as u8);<br>
&gt; <br>
&gt; Any reason why you defined rtc_irq_level as InterruptSource&lt;u8&gt;<=
br>
&gt; instead of InterruptSource&lt;u32&gt;?<br>
<br>
Thanks! I missed to clean up this, having previously used u8.<br>
<br>
Regards,<br>
Zhao<br>
<br>
</blockquote></div></div></div>

--0000000000006b5e76062be6529e--


