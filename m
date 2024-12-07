Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7835AE7717D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 19:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tK0jw-0002uu-FU; Sat, 07 Dec 2024 14:45:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tK0jv-0002ua-Fh
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 14:45:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tK0jt-0001Fv-LH
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 14:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733600716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rfviz3+RJEQHLnq1F5+iSVV04mCXVnj5nH43drfDTXU=;
 b=c6goDcNnDYvvcK9/gUkYIKiKr6Y6ldL/NGFV9ErGcFgwfe1kFtA0qdvLZQk/3tTEEC/UdU
 U6AjDnarc2FFcBx+8IORdF9zAK7iaHnOew4mY7jKoVY5NYFb9aS23J619P990OR7HiFtzJ
 yNT67IlnCC5lrTjJ8MpHTjdtaj+EkPw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-FbdyV0SCOAWc6rYXKvlEcw-1; Sat, 07 Dec 2024 14:45:10 -0500
X-MC-Unique: FbdyV0SCOAWc6rYXKvlEcw-1
X-Mimecast-MFC-AGG-ID: FbdyV0SCOAWc6rYXKvlEcw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e3cbf308so402601f8f.2
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2024 11:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733600709; x=1734205509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rfviz3+RJEQHLnq1F5+iSVV04mCXVnj5nH43drfDTXU=;
 b=OvDJREWeFLkIXI+XiP3uQL1sJcRqZ2IjKMP9+w6d3BlLLlNiPpqaHREhqCAq+e0HEA
 ZX+M6j48+7elLTUqZfiZ779drI0/Eiq24yAUreqo+Y3TwUBRUnOLoZqoT+rPBpbaxpgL
 csTVSYBwShku3fwSrhJq5rHhfkQqTyZhuvFq9iv1fQsGqt2Qen8yYBkHwLbgdggAyrfH
 Q7QOOoZ8humZng8CDSWLRT3vmLKEZ10P2B+L1qAlRY4Uzlwwr3FanwJmauOAfkBbw4S5
 +7bc9CIR42iYJeFHmEYjca6y9GrLaY6zPQQHPBg7Q+D+o4n2hnNJTRAjIyV3GBvkeqKA
 42UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/+x6k8MkQ6QYyCzWIoqhNRsGGAwsZigutODAwhxXihv7Er9DppThtgn6lmv5X7FEBt9Vq2OatPxhB@nongnu.org
X-Gm-Message-State: AOJu0YxKj+tDhj6BxAkUGU3XjMixe6pyM2jqw10+sFGPveRiNgh++wPX
 /IZ05wam7auYDSULIlE89I4YxxY9WVulD4hQZctBE/tWfSB7L16LltVKebLaSo6hwYizaI9wUti
 fqz9YdkFiT0HEFAi8OKFBf+tZSHy4DS/g/XC6FuvTTP2xxIkdsl6dMqeLIIQoNU/4xcMSPyMqrh
 61rMub0TYwldyCuZw2lsYWp1zBNzk=
X-Gm-Gg: ASbGncuu3BMOCWhiks369k9aE/JV2lnbiDersOe5voipSXGUAdFhQai2NmA5aowOQrb
 zVWcWYu2dkNNGQCHJ0DVTE/IBypEsBg==
X-Received: by 2002:adf:e18a:0:b0:385:e2c4:1f8d with SMTP id
 ffacd0b85a97d-3862b351423mr5746193f8f.19.1733600709415; 
 Sat, 07 Dec 2024 11:45:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLSoa7HdOTdDeZ7TEqhhzoulQMze8aNsJmQnv3X/qUJNM69D+7IluIXSjemAOV0v0Fbx0JVjpt6YBcItvXb5k=
X-Received: by 2002:adf:e18a:0:b0:385:e2c4:1f8d with SMTP id
 ffacd0b85a97d-3862b351423mr5746182f8f.19.1733600709112; Sat, 07 Dec 2024
 11:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-6-zhao1.liu@intel.com>
 <adb80a8c-ee40-4d8e-898b-a62d12746aa9@redhat.com> <Z1RxQU7sgxi2WJxQ@intel.com>
In-Reply-To: <Z1RxQU7sgxi2WJxQ@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 7 Dec 2024 20:44:58 +0100
Message-ID: <CABgObfZpn4R2dpEJQr2-60QXEyBfLnY6ztdWG1Bd5NW0VN3TNQ@mail.gmail.com>
Subject: Re: [RFC 05/13] rust: add a bit operation binding for deposit64
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007314540628b35e63"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000007314540628b35e63
Content-Type: text/plain; charset="UTF-8"

Il sab 7 dic 2024, 16:43 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> > impl IntegerExt for u64
> > {
> >     fn deposit(self, start: usize, length: usize, fieldval: u64) -> u64 {
> >         /* FIXME: Implement a more elegant check with error handling
> support? */
> >         assert!(length > 0 && length <= 64 - start);
> >
> >         let mask = (u64::MAX >> (64 - length)) << start;
> >         (value & !mask) | ((fieldval << start) & mask)
> >     }
> > }
>
> Then C and Rust would be using completely different bitops library, is
> it necessary to implement the C interface directly in Rust instead of
> keeping the C implementation (when Rust is enabled)?
>

If it's domain specific (related to emulation) then it's better to avoid
duplication but In some cases it's unavoidable: for example very very
simple inlines (e.g. clock_get_hz for an example) or simple forwarding APIs
like the various timer_init variants. It's simpler to redo the forwarding
in Rust and only write the callback translation once, than to repeat many
times the code to translate the callbacks and forward each init variant to
the corresponding C function.

Paolo

> And we can add a "prelude" module so that you can do
> >
> > use qemu_api::prelude::*;
> >
> > and get all these useful traits at once.  I will send a patch after
> > fleshing the idea out a bit more.
>
> Thanks! Cross fingers.
>
> Regards,
> Zhao
>
>
>

--0000000000007314540628b35e63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 7 dic 2024, 16:43 Zhao Liu &lt;<a href=3D"mailt=
o:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; ha scritto:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">&gt; impl IntegerExt for u64=
<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0fn deposit(self, start: usize, length: usize, field=
val: u64) -&gt; u64 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* FIXME: Implement a more elegant ch=
eck with error handling support? */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert!(length &gt; 0 &amp;&amp; leng=
th &lt;=3D 64 - start);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0let mask =3D (u64::MAX &gt;&gt; (64 -=
 length)) &lt;&lt; start;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(value &amp; !mask) | ((fieldval &lt;=
&lt; start) &amp; mask)<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; }<br>
<br>
Then C and Rust would be using completely different bitops library, is<br>
it necessary to implement the C interface directly in Rust instead of<br>
keeping the C implementation (when Rust is enabled)?<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">If it&#39;s domain spec=
ific (related to emulation) then it&#39;s better to avoid duplication but I=
n some cases it&#39;s unavoidable: for example very very simple inlines (e.=
g. clock_get_hz for an example) or simple forwarding APIs like the various =
timer_init variants. It&#39;s simpler to redo the forwarding in Rust and on=
ly write the callback translation once, than to repeat many times the code =
to translate the callbacks and forward each init variant to the correspondi=
ng C function.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; And we can add a &quot;prelude&quot; module so that you can do<br>
&gt; <br>
&gt; use qemu_api::prelude::*;<br>
&gt; <br>
&gt; and get all these useful traits at once.=C2=A0 I will send a patch aft=
er<br>
&gt; fleshing the idea out a bit more.<br>
<br>
Thanks! Cross fingers.<br>
<br>
Regards,<br>
Zhao<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000007314540628b35e63--


