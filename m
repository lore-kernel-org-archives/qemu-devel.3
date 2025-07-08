Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2A7C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEXr-0000F7-KO; Tue, 08 Jul 2025 16:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZCRU-00041A-5J
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 13:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZCQQ-0005K3-O4
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 13:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751996826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4eakUl1ltj5XPn29ft+YlM5niASE2dTzYNqHfnFkes=;
 b=SHSTq9ULGHmqD88R8JtUwKlvP+RtP3E/o0CAjg0LZujV7ULkq3QkdaD6vjiHozXTg+g5XB
 VvnkTO0XekPjC94hnS0VF2Q9ulzQHoi6mqHgvOgb42NC2TnYrYBS1UoSCvPi8Khp6Z2SU6
 TkqEoGZRbLvO4l04PUFeztSl6y6/xTA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-0-iGDB3JNgeybC7iO4g0VQ-1; Tue, 08 Jul 2025 08:25:25 -0400
X-MC-Unique: 0-iGDB3JNgeybC7iO4g0VQ-1
X-Mimecast-MFC-AGG-ID: 0-iGDB3JNgeybC7iO4g0VQ_1751977524
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so2032990f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 05:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751977524; x=1752582324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b4eakUl1ltj5XPn29ft+YlM5niASE2dTzYNqHfnFkes=;
 b=uyBMd0JMsRY0neLa+q/p5JiF0fBZKW3w+Cx8W+64DCAKh7H3ghXzekzPqKBDmKgdSf
 YXZmiOOI2HcMmaRZ7clZ4eARm2CV8SAK+wXhShojl0n3j/yv59ITVRJh23X92FpOrcMH
 aZZix03V8rjwcZAs4bNFZfshvEzJJ1ryjNugB+pzHuAsBKmW/tPwuF4anarNcEi8O/d1
 6Ss7XJC1D/Jt1wvs3VLdnKvpRAiTURxo0+QfK90a/zr2uFFVazx7vH8wpdkzAaOtchxB
 1SIK88spWTlRJlO88fmeLk319PFKu5L78CBMFNK1kpyzGiEx4yzMEF8yn4kwy1x72oC0
 pSzQ==
X-Gm-Message-State: AOJu0YzAMwS5/2ikMMjeQ08IE2Z9Uh5SJ3/FUpmvh0Us9vCQUYY+mcUA
 QRDdr3ABJOetrPtX70G8GepF4ZXwdY5OBkwuj1LMV7Ga/kpJGpQqeLtbb5W0yZwNG2VFXvMFINb
 WTKnjmkDRDk7Xr6noTMRtpbM/bU9MSo1W2csP2CEjEZkKQTdatAdqF3j8h03vNN3wFK6MCkjWT+
 glj9d51nbzc6ms9GrL89IjgtegEYGJvcY=
X-Gm-Gg: ASbGncupwu5JAV7X5879eXkBGBiOnM57ylHeCEFbiBh+H2lIqDFN369si324aG9BA9j
 7co5XsiDHzMSwAW5crJgTP+0cR5+bB9qWFHqJkg3rRXZl97HhYt6ntN98Sgq4hdxBZwmP+jGieH
 kYDfut
X-Received: by 2002:a05:6000:2588:b0:3a5:1cc5:4a17 with SMTP id
 ffacd0b85a97d-3b5ddedc49cmr2213690f8f.42.1751977523991; 
 Tue, 08 Jul 2025 05:25:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF45YM4O3HZs6YCkvL0vQJ6r1LvNL6axxGo513DcN7DqQYe0gHQG76rQtGQ41n+FKYsytUr8U3YA8LJCL2ttGc=
X-Received: by 2002:a05:6000:2588:b0:3a5:1cc5:4a17 with SMTP id
 ffacd0b85a97d-3b5ddedc49cmr2213665f8f.42.1751977523560; Tue, 08 Jul 2025
 05:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
 <20250703-rust-mem-api-v1-1-cd5314bdf580@linaro.org>
 <591f8a81-2c8e-4e30-abf2-4571afed41b4@redhat.com>
 <CAAjaMXZ3JziZ6gUHF67=nqvxzUF0M46SPqftRKgHOYYLaUxjJg@mail.gmail.com>
In-Reply-To: <CAAjaMXZ3JziZ6gUHF67=nqvxzUF0M46SPqftRKgHOYYLaUxjJg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 8 Jul 2025 14:25:10 +0200
X-Gm-Features: Ac12FXxIyiVAoWAMhhYdBNcRj-Ei6pdc0UOFvXJtkQDGmCSMw6cWSyZKcC_dF2c
Message-ID: <CABgObfYY-WVcYGno3moOospz-G2vWgo=0LLVzxTZxscRFK7+wg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust/memory: replace size arg with Bits enum
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="000000000000f25e0f06396a0df8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000f25e0f06396a0df8
Content-Type: text/plain; charset="UTF-8"

Il mar 8 lug 2025, 11:11 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
ha scritto:

> > I find this both verbose and (ok, that's subjective) ugly due to the
> > extra import, the underscore.
>
> Yep, I agree on that, but I wasn't sure what name would be better.
> Whatever type-level improvement this patch brings, it's small, though
> nice-to-have. We can drop it, no problem.
>

You did identify a small but real problem, which can be fixed with
assertions.

And also another issue in the API, which is that some code likes to use bit
sizes and other likes to use byte sizes. And it's not clear whether you
have to do *8 or /8.

This is the one that is where an enum does work great, but without the "as"
(because it reintroduces the *8 or /8 problem) and with names that don't
have digits (because of the underscore, but also because it makes the
result of "as" confusing).

Byte/Word/Long/Quad would work for me, as it matches the C stb/stw/stl/stq
APIs. Also please add the enum to the prelude. Still verbose but readable.
I would also add methods like nbits() and nbytes() that can be used instead
of "as".

Of course if you go with the enum there is no need for assertions in the
memory API. Except for the >= one, so perhaps it would also make sense to
implement Cmp in addition to Eq?

> The main effect on generated code is to add an assert! to
> > memory_region_ops_read_cb() and memory_region_ops_write_cb() that's
> > similar to the above.  I'm not sure of its value, either: if the size is
> > not 1/2/4/8, memory.c/physmem.c must have screwed up big.  It's not a
> > safety concern, either, since the size is not used in any unsafe code.
>
> Yep it's more of a guard rail since we can't have refined integer types.
>

It's not a lot in the grand scheme of things, but adding a match around all
reads and writes isn't great. :(

The only way to make an enum from an integer of the same repr is via
transmute, right? So probably there could be an unsafe method
Size::from_unchecked(u32) too?

Paolo


> --
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd
>
>

--000000000000f25e0f06396a0df8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 8 lug 2025, 11:11 Manos P=
itsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org">manos.pi=
tsidianakis@linaro.org</a>&gt; ha scritto:</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
&gt; I find this both verbose and (ok, that&#39;s subjective) ugly due to t=
he<br>
&gt; extra import, the underscore.<br>
<br>
Yep, I agree on that, but I wasn&#39;t sure what name would be better.<br>
Whatever type-level improvement this patch brings, it&#39;s small, though<b=
r>
nice-to-have. We can drop it, no problem.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">You did identify a small but real =
problem, which can be fixed with assertions.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">And also another issue in the API, which is that some =
code likes to use bit sizes and other likes to use byte sizes. And it&#39;s=
 not clear whether you have to do *8 or /8.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">This is the one that is where an enum does work great, =
but without the &quot;as&quot; (because it reintroduces the *8 or /8 proble=
m) and with names that don&#39;t have digits (because of the underscore, bu=
t also because it makes the result of &quot;as&quot; confusing).</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Byte/Word/Long/Quad would work for=
 me, as it matches the C stb/stw/stl/stq APIs. Also please add the enum to =
the prelude. Still verbose but readable. I would also add methods like nbit=
s() and nbytes() that can be used instead of &quot;as&quot;.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Of course if you go with the enum the=
re is no need for assertions in the memory API. Except for the &gt;=3D one,=
 so perhaps it would also make sense to implement Cmp in addition to Eq?</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; The main effect on generated code is to add an assert! to<br>
&gt; memory_region_ops_read_cb() and memory_region_ops_write_cb() that&#39;=
s<br>
&gt; similar to the above.=C2=A0 I&#39;m not sure of its value, either: if =
the size is<br>
&gt; not 1/2/4/8, memory.c/physmem.c must have screwed up big.=C2=A0 It&#39=
;s not a<br>
&gt; safety concern, either, since the size is not used in any unsafe code.=
<br>
<br>
Yep it&#39;s more of a guard rail since we can&#39;t have refined integer t=
ypes.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">It&#39;s not a lot in the grand scheme of things, but adding a match a=
round all reads and writes isn&#39;t great. :(</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">The only way to make an enum from an integer of the =
same repr is via transmute, right? So probably there could be an unsafe met=
hod Size::from_unchecked(u32) too?</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
-- <br>
Manos Pitsidianakis<br>
Emulation and Virtualization Engineer at Linaro Ltd<br>
<br>
</blockquote></div></div></div>

--000000000000f25e0f06396a0df8--


